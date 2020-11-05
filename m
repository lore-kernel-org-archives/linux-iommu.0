Return-Path: <SRS0=eQNl=EL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA871C388F7
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 09:10:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 171992083B
	for <iommu@archiver.kernel.org>; Thu,  5 Nov 2020 09:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZUFeKFt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 171992083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9A4BA8577C;
	Thu,  5 Nov 2020 09:10:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1aZx0nfbq2_7; Thu,  5 Nov 2020 09:10:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E748985754;
	Thu,  5 Nov 2020 09:10:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7C28C088B;
	Thu,  5 Nov 2020 09:10:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98FB7C088B
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 08:47:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9308685319
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 08:47:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MMM8_q4St_1R for <iommu@lists.linux-foundation.org>;
 Thu,  5 Nov 2020 08:47:29 +0000 (UTC)
X-Greylist: delayed 07:00:57 by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2113.outbound.protection.outlook.com [40.107.237.113])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2509685277
 for <iommu@lists.linux-foundation.org>; Thu,  5 Nov 2020 08:47:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sn1c/kpWvs7Bg/Gpi5Z72vrD5rtYQ+ixx0A7VE5r1hriEY+spKNiqNxY2SC/nhc19uOCjb7Ypy9i5Lf47A/XbaZIFeh/tbQuh63jvA0zhhydHk/Qm6M9bZStr81l0nEt3JAqZBZyH9ZC1RkaCiYqvojJ1VURWPIL4dyq3/PGynQNuco+MTrk2+76awTfNArUIJyrUAPOv8bBApkRBFDfSkCYHzlIuyJ4QkY940tbL4HLxeObP7V5rw1cGoRnkepoiDb7XcOvohkmJRMEJO2T7qjSoxobnWOktUdQ1ywncuYZL1wjtgplBBXaBVHDl9fI1lsxJuCSJptgRzPZOaga7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2tejlCftgJ3B7sk5b0KQE1+ZoWbq3TEa73UrMuOTaA=;
 b=XtfNrIF2qpH0QGRKCetrzprXaQPqb7nwqBqoyKa/1TUj4pPtv1uWfU+QlYtso+UqEKptX6FgvAt8ubM9c0P7YTgyJLLW1dsolDXoD4kF/WhEtuCn5+hWIFwnCfLFbtF53dpLNCn8qf9JJYdG9QAZJCqYMF4KUIhpcV8rmJk5sJ3qPrmI0sK5ESxNeXHf9YmiLCoOV25dCVYFvzV4c+PCfDfq1X4D+zeu10qMAMEN4XMVMl0eji75T4jNr6+wpChTiv+GiNTBrhCAPGQ/ClZdo/q85//wzO2g0DCBi+UBAWt3bIGTqqd3A7MpTwycyN5+6DcABsw6nItv4yHbfvKs1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2tejlCftgJ3B7sk5b0KQE1+ZoWbq3TEa73UrMuOTaA=;
 b=ZUFeKFt8f4oRJq40JjzrENVGdah+vE9tRpAD4RjyTWizy+yqI4Jy2gSilML5XDf98bHUocdrMSa3106ucXlutrIIAQasntQEaX9wUE2v2/Xu02C2SADBcy9+CjA1+rv/QSuWkee82T9KpXHWZlP5PXJ666kVjEqmo+l1cR/9Y58=
Received: from MW2PR2101MB1130.namprd21.prod.outlook.com (2603:10b6:302:4::15)
 by MW2PR2101MB0892.namprd21.prod.outlook.com (2603:10b6:302:10::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.6; Thu, 5 Nov
 2020 00:13:53 +0000
Received: from MW2PR2101MB1130.namprd21.prod.outlook.com
 ([fe80::2c5a:e38c:d8b6:3a4]) by MW2PR2101MB1130.namprd21.prod.outlook.com
 ([fe80::2c5a:e38c:d8b6:3a4%5]) with mapi id 15.20.3564.006; Thu, 5 Nov 2020
 00:13:53 +0000
To: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Question regarding VIOT proposal
Thread-Topic: Question regarding VIOT proposal
Thread-Index: AdazCIQyX41ICCm/R+W5gs79WO29YQ==
Date: Thu, 5 Nov 2020 00:13:53 +0000
Message-ID: <MW2PR2101MB1130313B4AE39B7EAC09349B80EE0@MW2PR2101MB1130.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-11-05T00:13:52Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e9da1347-66ea-4bd9-a639-a55f871f084e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2001:4898:80e8:3:6ded:def8:8dbb:de8d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 83b20a16-3145-44ac-6572-08d8811fae0d
x-ms-traffictypediagnostic: MW2PR2101MB0892:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB08925CAD2F4F651C1B0B840E80EE0@MW2PR2101MB0892.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vFEFLrkdk0ps6jeOuCjZ8Me2lWI8CDQaOZaPsSvumG/qu37kRkUieJnJ0ywgptrEoSrcPRr5WZGp08gtnhMbH6bLtK0LzDwx9vBTgpyqZgGL7D31sQO6Idl8GZMIRl99dQRx2o3Ztt/ieEVOq/ofTAtWiwJc3tbslspOxc4IpE0QhIe1AMrjcxQy+WF/GzlP41K/BP/q2yZsz8RwFBgtOrOg/mqizeZ45rapdiy6oJ2CDf2Ka7Snnrcinj4ZJztS2DzIwYY3Ve9nwzcqEyXzoch/KZVM8J69Mirr16rWOcyNHkSZhD60RIju2wdpe2o9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR2101MB1130.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(3480700007)(71200400001)(33656002)(4744005)(7696005)(6506007)(186003)(86362001)(107886003)(2906002)(8990500004)(5660300002)(9686003)(8936002)(66476007)(82960400001)(76116006)(66946007)(55016002)(4326008)(66446008)(66556008)(64756008)(478600001)(10290500003)(82950400001)(6916009)(52536014)(8676002)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ZC9kMmV6QxIhNGl0c3msHpWrQg/OB0geB/nYsmGbPzmKje00lPUqfkBPdde1?=
 =?us-ascii?Q?enPGJAOCTZ5qTeQYUV7hyGfIeJyfoiW1GMpG1EyopSL/FeYtgPlCfCacOfWq?=
 =?us-ascii?Q?ggwmQ/C09TKRY8K1oxl1JCFCc8sLyznGKfqn2nw8LobUybAzp2MP2+Syycr1?=
 =?us-ascii?Q?leifGdq2AUe0qHiWYEWUJaraQ5cIDGvV4FQQ7qCdYbi5qsSRwVsj3RvttpJ7?=
 =?us-ascii?Q?sM1/otlYKFrd43GrKs1zZoiBXqxdEQquQylT5GR/uM6Rn6UhGL0os41mEsIA?=
 =?us-ascii?Q?Icnc9/6rtmti9UHFnqIigi5jDacw8GqdQFJo2/lQD9n2Ng5jhT6DTC2GITIT?=
 =?us-ascii?Q?/n/WMbtYnZE+AOTwep96ez7lx0XxBCbaT3vEGs7Mmbf3GeRFWfFHk6QbMCEv?=
 =?us-ascii?Q?Cc4Cxgcfee+uu1F7+LFa0+jM5hTSFG65ZA/+xfGTsLgQkoVuqQ/fa8dvifLt?=
 =?us-ascii?Q?CKQHwLA0GrPBSgkShvauzsvBSdNRq0S0q5tyQNhQCVptVyBjXfZce5pxxAZU?=
 =?us-ascii?Q?1Cf+L3zIswhK+CyIq/07wU5ZlaUd7R6ctH6IOZ2Kd83gGiOwgamPvFts/ukn?=
 =?us-ascii?Q?9I1Nqvcu9ZcYtQ/vYYhgWJoxVJMFO8vnG7R+bRZTP12Jn0EimaUvOmbKq4vk?=
 =?us-ascii?Q?zoeTGFDZQjkwFD2R6Rfue3tJQUMolX7Z7ScGY0elHa5G9URznh9jTHU6lSZM?=
 =?us-ascii?Q?K5GO4msosf8hJB7mWg+oWrpLSbbB7m6hsbSb+NWG8/uDp0KFfousYup2V2tx?=
 =?us-ascii?Q?/5Ud3D/xT20JCRXuEvSyno62bxDgGZEhs/DpMLkzlNYn6hMOmqsXyfulGPi1?=
 =?us-ascii?Q?qxdGlsPoyMQ7jd/1A/vgZdutgOcHjNPppm9z58oIoxvLW5/LbOJhv+5jaN6B?=
 =?us-ascii?Q?k5jpaD9UktMTitQ/ASBM9vZfgkqR/Jw0Cp5AEywuVzY/HT/sVvlXDNT5s/B0?=
 =?us-ascii?Q?AkSjBC5oo3nkt3nzhDlpdQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1130.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b20a16-3145-44ac-6572-08d8811fae0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 00:13:53.5648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fxAjLF2GsuiSfxsKA+HDKUaF1/MMxs5G+cT0pYXWYS43DLVWkHPMzwG64mS4ADDQuVvUh4oQ9u+NmJ0chbUCjSgfpQV/lwcfr3nLIkb8s+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0892
X-Mailman-Approved-At: Thu, 05 Nov 2020 09:10:46 +0000
Cc: Alexander Grest <Alexander.Grest@microsoft.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Yinghan Yang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yinghan Yang <Yinghan.Yang@microsoft.com>
Content-Type: multipart/mixed; boundary="===============9156514777945899681=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============9156514777945899681==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MW2PR2101MB1130313B4AE39B7EAC09349B80EE0MW2PR2101MB1130_"

--_000_MW2PR2101MB1130313B4AE39B7EAC09349B80EE0MW2PR2101MB1130_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi iommu developers,

I have a question regarding the recent VIOT submission for supporting parav=
irtualized IOMMU in guests. The spec defines PCI Range Node Structure (5.2.=
30.3) that maps to a single PCI segment.

Is it possible for the new table to express that an IOMMU covers all PCI se=
gments?  This could help support scenarios where:


  1.  Devices are dynamically assigned to guests during runtime
  2.  Devices in the same guests are assigned to different segments.

Thanks,
Yinghan

--_000_MW2PR2101MB1130313B4AE39B7EAC09349B80EE0MW2PR2101MB1130_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle19
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:416830525;
	mso-list-type:hybrid;
	mso-list-template-ids:-1541495646 67698705 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi iommu developers,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have a question regarding the recent VIOT submissi=
on for supporting paravirtualized IOMMU in guests. The spec defines PCI Ran=
ge Node Structure (5.2.30.3) that maps to a single PCI segment.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Is it possible for the new table to express that an =
IOMMU covers all PCI segments?&nbsp; This could help support scenarios wher=
e:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1">Devices are dynamically assigned to guests during runtime<o:p></o:p><=
/li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 lev=
el1 lfo1">Devices in the same guests are assigned to different segments.<o:=
p></o:p></li></ol>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Yinghan<o:p></o:p></p>
</div>
</body>
</html>

--_000_MW2PR2101MB1130313B4AE39B7EAC09349B80EE0MW2PR2101MB1130_--

--===============9156514777945899681==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============9156514777945899681==--
