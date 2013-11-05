//------------------------------------------------------------------------------
// Source code generated by wxDesigner from file: EventArea.wdr
// Do not modify this file, all changes will be lost!
//------------------------------------------------------------------------------

#if defined(__GNUG__) && !defined(NO_GCC_PRAGMA)
    #pragma implementation "EventArea_wdr.h"
#endif

// For compilers that support precompilation
#include "wx/wxprec.h"

#ifdef __BORLANDC__
    #pragma hdrstop
#endif

// Include private header
#include "EventArea_wdr.h"

#include <wx/intl.h>

// Euro sign hack of the year
#if wxUSE_UNICODE
    #define __WDR_EURO__ wxT("\u20ac")
#else
    #if defined(__WXMAC__)
        #define __WDR_EURO__ wxT("\xdb")
    #elif defined(__WXMSW__)
        #define __WDR_EURO__ wxT("\x80")
    #else
        #define __WDR_EURO__ wxT("\xa4")
    #endif
#endif

// Implement window functions

wxSizer *EventArea( wxWindow *parent, bool call_fit, bool set_sizer )
{
    wxBoxSizer *item0 = new wxBoxSizer( wxVERTICAL );

    wxBoxSizer *item1 = new wxBoxSizer( wxVERTICAL );

    wxStaticText *item2 = new wxStaticText( parent, ID_TEXT_EVENT_AREA, /*_("AREA_LIST:")*/_("�����б�:"), wxDefaultPosition, wxSize(70,20), 0 );
    item1->Add( item2, 0, wxGROW|wxALIGN_CENTER_VERTICAL, 5 );

    wxListCtrl *item3 = new wxListCtrl( parent, ID_LISTCTRL, wxDefaultPosition, wxSize(250,200), wxLC_REPORT|wxSUNKEN_BORDER );
    item1->Add( item3, 0, wxGROW|wxALIGN_CENTER_VERTICAL, 5 );

    wxBoxSizer *item4 = new wxBoxSizer( wxHORIZONTAL );

    wxStaticText *item5 = new wxStaticText( parent, ID_TEXT_1, /*_("AREA_ID:  ")*/_("����ID:  "), wxDefaultPosition, wxDefaultSize, 0 );
    item4->Add( item5, 0, wxALIGN_CENTER|wxALL, 5 );

    wxTextCtrl *item6 = new wxTextCtrl( parent, ID_TEXTCTRL_AREA_ID, wxT(""), wxDefaultPosition, wxSize(80,-1), 0 );
    item4->Add( item6, 0, wxALIGN_CENTER|wxALL, 5 );

    wxButton *item7 = new wxButton( parent, ID_BUTTON_NEW_AREA_ID, /*_("NEW_AREA_ID")*/_("������ID"), wxDefaultPosition, wxDefaultSize, 0 );
    item4->Add( item7, 0, wxALIGN_CENTER|wxALL, 5 );

    item1->Add( item4, 0, wxGROW|wxALIGN_CENTER_VERTICAL|wxALL, 5 );

    wxBoxSizer *item8 = new wxBoxSizer( wxHORIZONTAL );

    wxStaticText *item9 = new wxStaticText( parent, ID_TEXT_2, /*_("SCRIPT_ID:")*/_("�ű�ID:"), wxDefaultPosition, wxDefaultSize, 0 );
    item8->Add( item9, 0, wxALIGN_CENTER|wxALL, 5 );

    wxTextCtrl *item10 = new wxTextCtrl( parent, ID_TEXTCTRL_SCRIPT_ID, wxT(""), wxDefaultPosition, wxSize(80,-1), 0 );
    item8->Add( item10, 0, wxALIGN_CENTER|wxALL, 5 );

    wxButton *item11 = new wxButton( parent, ID_BUTTON_DEL_RECT, _("ɾ��"), wxDefaultPosition, wxDefaultSize, 0 );
    item8->Add( item11, 0, wxALIGN_CENTER|wxALL, 5 );

    item1->Add( item8, 0, wxGROW|wxALIGN_CENTER_VERTICAL|wxALL, 5 );

    wxBoxSizer *item12 = new wxBoxSizer( wxHORIZONTAL );

    wxRadioButton *item13 = new wxRadioButton( parent, ID_RADIOBUTTON_SELECT, /*_("SELECT")*/_("ѡ��"), wxDefaultPosition, wxDefaultSize, wxRB_GROUP );
    item12->Add( item13, 0, wxALIGN_CENTER|wxALL, 5 );

    wxRadioButton *item14 = new wxRadioButton( parent, ID_RADIOBUTTON_DRAW, /*_("DRAW")*/_("����"), wxDefaultPosition, wxDefaultSize, 0 );
    item12->Add( item14, 0, wxALIGN_CENTER|wxALL, 5 );

    wxButton *item15 = new wxButton( parent, ID_BUTTON_MODITY, /*_("MODIFY")*/_("�޸�"), wxDefaultPosition, wxDefaultSize, 0 );
    item12->Add( item15, 0, wxALIGN_CENTER|wxALL, 5 );
	
    item1->Add( item12, 0, wxGROW|wxALIGN_CENTER_VERTICAL|wxALL, 5 );

    item0->Add( item1, 0, wxGROW|wxALIGN_CENTER_VERTICAL|wxALL, 5 );

	wxCheckBox* item16 = new wxCheckBox(parent, ID_CHECKBOX_LOCAL, _("�����¼�����༭"), wxDefaultPosition, wxDefaultSize, 0 );
	item0->Add( item16, 0, wxGROW|wxALIGN_CENTER_VERTICAL|wxALL, 5);

	//wxBoxSizer* paramGridSizer;
	//paramGridSizer = new wxBoxSizer( wxHORIZONTAL );

	wxGrid* paramGrid = new wxGrid( parent, ID_GRID_PARAMS, wxDefaultPosition, wxDefaultSize, 0 );

	// Grid
	paramGrid->CreateGrid( 10, 2 );
	paramGrid->EnableEditing( true );
	paramGrid->EnableGridLines( false );
	paramGrid->EnableDragGridSize( false );
	paramGrid->SetMargins( 0, 0 );

	// Columns
	paramGrid->EnableDragColSize( true );
	paramGrid->SetColLabelSize( 30 );
	paramGrid->SetColLabelValue( 0, wxT("������") );
	paramGrid->SetColLabelValue( 1, wxT("����ֵ") );
	paramGrid->SetColLabelAlignment( wxALIGN_CENTRE, wxALIGN_CENTRE );

	// Rows
	paramGrid->EnableDragRowSize( true );
	paramGrid->SetRowLabelSize( 20 );
	paramGrid->SetRowLabelAlignment( wxALIGN_CENTRE, wxALIGN_CENTRE );

	paramGrid->SetDefaultCellAlignment( wxALIGN_LEFT, wxALIGN_TOP );

	paramGrid->Fit();

	//paramGridSizer->Add( paramGrid, 0, wxALL, 5 );

	item0->Add( paramGrid, 0, wxGROW|wxALIGN_CENTER_VERTICAL|wxALL, 5 );

	if (set_sizer)
    {
        parent->SetSizer( item0 );
        if (call_fit)
            item0->SetSizeHints( parent );
    }
    
    return item0;
}

// Implement menubar functions

// Implement toolbar functions

// Implement bitmap functions


// End of generated file