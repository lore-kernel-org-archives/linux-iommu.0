Return-Path: <SRS0=TrXs=EJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80055C4742C
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 09:57:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41502240C
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 09:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emerson.onmicrosoft.com header.i=@emerson.onmicrosoft.com header.b="e/oHYWm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41502240C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emerson.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7A26F86C98;
	Tue,  3 Nov 2020 09:57:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KT20tl+nwD5S; Tue,  3 Nov 2020 09:57:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7ECE486C80;
	Tue,  3 Nov 2020 09:57:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63362C08A1;
	Tue,  3 Nov 2020 09:57:37 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24B8EC0889
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 09:57:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 05B948578B
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 09:57:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ToIQpoOnpBrm for <iommu@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 09:57:34 +0000 (UTC)
X-Greylist: delayed 00:35:35 by SQLgrey-1.7.6
Received: from mx0b-00300601.pphosted.com (mx0b-00300601.pphosted.com
 [148.163.142.35])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 52B0F85785
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 09:57:34 +0000 (UTC)
Received: from pps.filterd (m0144092.ppops.net [127.0.0.1])
 by mx0b-00300601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A39HKT4014054; Tue, 3 Nov 2020 09:21:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
 by mx0b-00300601.pphosted.com with ESMTP id 34jnh938gb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Nov 2020 09:21:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFxPXeyw47W/cwcSqVGAoGl6YU2Wyp+GI0P1AW/7RkmN7iYvH66iIrLS99GAHfYsCYC2kO60BkfFQ4+lzyixaHexMJegSYxBoybq4hLN60tRQ+SDUcaP7m9EW+zBS1mJwKRxFFvSjbx243zdkhGGpnWUmW2p41b/a3ZMfaTmcJDJfVa8mxLL0AtrXJtrYhOI8w7T3AJa4d4JR6zmjiL9DA0w1LNjrBksF7/29sBoRKbAit7ArSHiDG+/1jIARv5Cv0NYOtBq2X+uEcuBixzO9bK8eoQvxJQH7+BDW7nRH/nDSWRojHhThtVTX9zLuxFzD/WKdg3TW42A1WrnyaYa9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMFVhoZvK+KFUJdmGIEVaLOi2S8GCCnHlfTdRU0+1JA=;
 b=mhTWVFNttYp99hxakKo6OFZzgONuTXlpEkSj5kwoSSDmJl9D5GVY3MZXZw+jmr2nDX4wv2OlnyAMjQ9EPr4e4ZfqbEbXHsg9UyVlwtW0K+kP0R/XIPni5iTJQFn9esHuVzaK9BGUPH7JcDzc67FuGd1JOxHrfZ/RUK+1OOpgpcLmcrZy8vDGOh2JfpwewdBrRoZ3gEO+oFgUKvITNXEjnpHNsxqzbxrWQLKzLZPYMHjj6dCVr6GcLyGKbyZ821KN0aDCY72vuH1ixEmoSJ0iM45ebwoTFJWvpTh0C5W5GT4Kg328gnvfSN870JXRTkHbclzcMW1cFVQo921giSo44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emerson.com; dmarc=pass action=none header.from=emerson.com;
 dkim=pass header.d=emerson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=emerson.onmicrosoft.com; s=selector2-emerson-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMFVhoZvK+KFUJdmGIEVaLOi2S8GCCnHlfTdRU0+1JA=;
 b=e/oHYWm23IVc2w0S7LYx5jvHxInLH+bVxO/BjWOom+EEYg7NvRSP8bEANISezpsJfzM1GWnMA8m5hiigaSCZS//LlFMYH/A9A2uoXcQZjTH2LkDqq6TrCRgz9wEAWfCrEWwuw6GlYUYamOfEGD9qHyFMVQhoWyWAeHsER1qVeuo=
Received: from MWHPR10MB1310.namprd10.prod.outlook.com (2603:10b6:300:21::18)
 by CO1PR10MB4753.namprd10.prod.outlook.com (2603:10b6:303:6f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 09:21:56 +0000
Received: from MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e]) by MWHPR10MB1310.namprd10.prod.outlook.com
 ([fe80::d85:aa30:739f:496e%12]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 09:21:56 +0000
From: "Merger, Edgar [AUTOSOL/MAS/AUGS]" <Edgar.Merger@emerson.com>
To: "jroedel@suse.de" <jroedel@suse.de>
Subject: RE: amdgpu error whenever IOMMU is enabled
Thread-Topic: amdgpu error whenever IOMMU is enabled
Thread-Index: Adaux7yL4OYKNrMETgKrPGK8SdhnWAC+sr5Q
Date: Tue, 3 Nov 2020 09:21:56 +0000
Message-ID: <MWHPR10MB131017A874BB6FE5FF72F7BD89110@MWHPR10MB1310.namprd10.prod.outlook.com>
References: <MWHPR10MB1310CDB6829DDCF5EA84A14689150@MWHPR10MB1310.namprd10.prod.outlook.com>
In-Reply-To: <MWHPR10MB1310CDB6829DDCF5EA84A14689150@MWHPR10MB1310.namprd10.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=emerson.com;
x-originating-ip: [194.140.115.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a3ee812-9eb7-4451-824a-08d87fd9e90c
x-ms-traffictypediagnostic: CO1PR10MB4753:
x-microsoft-antispam-prvs: <CO1PR10MB4753672D95185CFA5DF2E08089110@CO1PR10MB4753.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tw0wISWhCkPuWTWG0zXuhRu6YmJtOQ12zlo46HkF40YHZy9bpWzodNBFdRz8JCx8zwjNTAP8/GGNejn5mra443pR+WqA8FXkgy2gZ+1gBxQWI3grsKzXNISDDLQNEpOMi63D4xgObbNODH2Ms09rANhOms9AYyrCXz3+KZ6Rq4qq7HrB8hVHXWqc22wlF4ql29GHsz0m+uWHhTi5yQvd91JNeAznFGbvfJKgJOti9JxetuIhGvTATjQkUeIOAPk5fJgNb7MCSqogAPBt6W+LLO2ouqiuI4CCMt3KIsUWgxZZvWxzaQ71XSCX9vD/2INdiFa292Vw7532gyIuYY8V3OK5v963Gwapjm6QM6A2V/A8O2wOpDxElpYTTm4uPl/PNdEMAh9geO5eqRCN5kaeJQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR10MB1310.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(396003)(39860400002)(366004)(376002)(136003)(66476007)(316002)(53546011)(76116006)(66946007)(478600001)(66446008)(86362001)(6916009)(26005)(6506007)(2906002)(66556008)(66616009)(8676002)(8936002)(64756008)(71200400001)(33656002)(66574015)(83380400001)(4326008)(9686003)(966005)(99936003)(52536014)(55016002)(7696005)(5660300002)(186003)(166002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ZTVbSR4Pab+4NUfRsovEX2hK12xB0wSl3Laf5QNPfc1+hJL1BFbIraiBXRdZunqAphuJ46LEqQaKhgMmZMD3vhahx4umXu63XTNLOt4HKExFxnAqYYIG3yLOhcxF9pw3jcQEfgACiJiRxIvv7X0ZE7cJhgAq8w3ey+8dbEcoT7AtmEjCpEOYzbLx+WGUTeAK2YI7shcPBklS5QWzB0Ak7C7+m+d3sfAQV8YTgbM7v07wPFQY4nY6IAUVZeBblLCwVr/oWvYnB5rfxeYl4u35fP52YvS20F0DqNtYHPN2DltJEblAof3paJYKzwRVn7zkB+SODFJXRyU7e2kSqA/nBwkkuzleFjW1svcmqFMJdXfLFxxaBnM2jRiVu41/uBs7yukxOqa7zBKwh1zzHoupPQtpXODxjfIgPmnRYwDqjoTDk+Optei6B9FMWd4Boqj3SAEhFwIqiFnGt/rtKqAPsUtuV4p8QraN6pcCP54YsekIr91uI+3uJvYLLpDZWZT978KTxkXD7891mAem43C2DRxT7oQ47tBZBsn8K1nvdnzH8RyAHeXEfobaPittfISnV8dEOiJPrxg0huzgrJcYexoLAs6OL1+sKES0n8g9EgTmzjpeP0zgzoV9U7LLmUXSj80cvVCsvZimSzkbMjeAoA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Emerson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1310.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3ee812-9eb7-4451-824a-08d87fd9e90c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 09:21:56.6107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eb06985d-06ca-4a17-81da-629ab99f6505
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wsyAmLa5TGSynoJVoRryAmahUoUenv6SPYcrKY8K5JrjAe79TUQ4PFY9uaTz0TD+kCPMqKSKLOOo/ejUgRecN1ODG2EbQIqBdtor/cqER3o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4753
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-03_07:2020-11-02,
 2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030064
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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
Content-Type: multipart/mixed; boundary="===============4527307510572694184=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

--===============4527307510572694184==
Content-Language: en-US
Content-Type: multipart/related;
	boundary="_004_MWHPR10MB131017A874BB6FE5FF72F7BD89110MWHPR10MB1310namp_";
	type="multipart/alternative"

--_004_MWHPR10MB131017A874BB6FE5FF72F7BD89110MWHPR10MB1310namp_
Content-Type: multipart/alternative;
	boundary="_000_MWHPR10MB131017A874BB6FE5FF72F7BD89110MWHPR10MB1310namp_"

--_000_MWHPR10MB131017A874BB6FE5FF72F7BD89110MWHPR10MB1310namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi J=F6rg,

I am seeing that amdgpu uses amd_iommu_v2 kernel-module.
To me this is the last puzzle piece that was missing to explain the depende=
ncy of that bug in amdgpu to the iommu.

[cid:image001.png@01D6B1CB.26F9C970]

Best regards
Edgar

From: Merger, Edgar [AUTOSOL/MAS/AUGS]
Sent: Freitag, 30. Oktober 2020 15:26
To: jroedel@suse.de
Cc: iommu@lists.linux-foundation.org
Subject: amdgpu error whenever IOMMU is enabled

Hello J=F6rg,

We have developed a Board "mCOM10L1900" that can be populated with an AMD R=
1305G Ryzen CPU but also with other CPUs from AMD=B4s R1000 and V1000 Serie=
s. Please see attached datasheet.

With one board we have a boot-problem that is reproducible at every ~50 boo=
t. The system is accessible via ssh and works fine except for the Graphics.=
 The graphics is off. We don=B4t see a screen. Please see attached "dmesg.l=
og". From [52.772273] onwards the kernel reports drm/amdgpu errors. It even=
 tries to reset the GPU but that fails too. I tried to reset amdgpu also by=
 command "sudo cat /sys/kernel/debug/dri/N/amdgpu_gpu_recover". That did no=
t help either.
There is a similar error reported here https://bugzilla.kernel.org/show_bug=
.cgi?id=3D204241. However the applied patch should have already been in the=
 Linux-kernel we use, which is "5.4.0-47-generic".

Also found that "amdgpu_info" shows different versions at "SMC firmware ver=
sion". Please see attachment. It is still unclear what role the IOMMU plays=
 here. Whenever we turn it off, the error does not show up anymore on the f=
ailing board.

Best regards
Edgar


--_000_MWHPR10MB131017A874BB6FE5FF72F7BD89110MWHPR10MB1310namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi J=F6rg,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am seeing that amdgpu uses amd_iommu_v2 kernel-mod=
ule.<o:p></o:p></p>
<p class=3D"MsoNormal">To me this is the last puzzle piece that was missing=
 to explain the dependency of that bug in amdgpu to the iommu.<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><img width=3D"476" height=3D"68" style=3D"width:4.95=
83in;height:.7083in" id=3D"Picture_x0020_1" src=3D"cid:image001.png@01D6B1C=
B.26F9C970"><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best regards<o:p></o:p></p>
<p class=3D"MsoNormal">Edgar<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b>From:</b> Merger, Edgar [AUTOSOL/MAS/AUGS] <br>
<b>Sent:</b> Freitag, 30. Oktober 2020 15:26<br>
<b>To:</b> jroedel@suse.de<br>
<b>Cc:</b> iommu@lists.linux-foundation.org<br>
<b>Subject:</b> amdgpu error whenever IOMMU is enabled<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hello J=F6rg,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We have developed a Board &#8220;mCOM10L1900&#8221; =
that can be populated with an AMD R1305G Ryzen CPU but also with other CPUs=
 from AMD=B4s R1000 and V1000 Series. Please see attached datasheet.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">With one board we have a boot-problem that is reprod=
ucible at every ~50 boot. The system is accessible via ssh and works fine e=
xcept for the Graphics. The graphics is off. We don=B4t see a screen. Pleas=
e see attached &#8220;dmesg.log&#8221;. From [52.772273]
 onwards the kernel reports drm/amdgpu errors. It even tries to reset the G=
PU but that fails too. I tried to reset amdgpu also by command &#8220;<span=
 style=3D"font-size:9.0pt;font-family:&quot;Arial&quot;,sans-serif;color:bl=
ack;background:white">sudo cat /sys/kernel/debug/dri/N/amdgpu_gpu_recover&#=
8221;.
 That did not help either. </span><o:p></o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Ari=
al&quot;,sans-serif;color:black;background:white">There is a similar error =
reported here
</span><a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D204241" tit=
le=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D204241"><span style=3D"=
font-size:9.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#336699;bord=
er:none windowtext 1.0pt;padding:0cm;background:white;text-decoration:none"=
>https://bugzilla.kernel.org/show_bug.cgi?id=3D204241</span></a>.
 However the applied patch should have already been in the Linux-kernel we =
use, which is &#8220;5.4.0-47-generic&#8221;.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Also found that &#8220;amdgpu_info&#8221; shows diff=
erent versions at &#8220;SMC firmware version&#8221;. Please see attachment=
. It is still unclear what role the IOMMU plays here. Whenever we turn it o=
ff, the error does not show up anymore on the failing board.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best regards<o:p></o:p></p>
<p class=3D"MsoNormal">Edgar<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MWHPR10MB131017A874BB6FE5FF72F7BD89110MWHPR10MB1310namp_--

--_004_MWHPR10MB131017A874BB6FE5FF72F7BD89110MWHPR10MB1310namp_
Content-Type: image/png; name="image001.png"
Content-Description: image001.png
Content-Disposition: inline; filename="image001.png"; size=50502;
	creation-date="Tue, 03 Nov 2020 09:21:55 GMT";
	modification-date="Tue, 03 Nov 2020 09:21:55 GMT"
Content-ID: <image001.png@01D6B1CB.26F9C970>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAAdwAAABECAIAAACkgxM4AAAAAXNSR0IArs4c6QAAAARnQU1BAACx
jwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAASdEVYdFNvZnR3YXJlAEdyZWVuc2hvdF5VCAUA
AMS9SURBVHhe7P0F3CPnebcNn2JpRswsDfOMmG6GZWZmZl4v2mvazZoZYortJKaYEzNzHDPHjl3H
cRjaBtrmLdzfqZW7de/0eds+b7+0L/x+h2Wt7pE0I13Xcf3PmdE1IFrFlD/qt5GJBGSzICaBjQIH
4YqXSWTBE4RoGBIxSAVsMY8pRlj5RCjjd6Z9jnTCiXjDEIhBkAJvBmTSzzvcFFmMm8Vw0JbPBiJx
CMcg63PzsTDnlfMuLhmzx8IWbxpiHCQjkIqCBlLNVYoHg2GvN8VBIAVlG4UohKCSoi0MOT2wYeX4
VYsH9TEmdQgCdQg1cX18dDzKOVmRFNxJQMJRiCVMKpmXXdlUyJkOu8JZGxGGSATCYWBjdiZqi9ki
UkyI+v2ZWMwdBW8cWBViOSBspnQsxFkC1RAVipLhmDtEOb1pCx12pL0mJRRg3UQ06g2FyCTrzor+
aAiSMaCdrqzVxgQoypdLJyCXhhQR5MJpxcKVSU03ByRwG7a6YipnbS4lGI37M0jRXizYCpKZMpxC
Mg++CLhp8LIQ90A2BKwzyrliUjqKH7U/EiD97kwGWBbYoDfvJRhvBgkTLiGTTqXBRUA2BywHMWuS
8rIyKecg58tCjIeIAuADNkAwflfBYVTIcspLR12ZaJKMpz3JOGRS5jxEigE+mLJ7Y+ZSxMY5wZ+G
BAfBaCKezmUhw5josAReBji/J0c4HH5Ic34+kMwRIS2ZZfxhsx9CFATz7Vs2HEm7PTm/hwr6XPh1
cJAPABMGDwMkBYIzJpPJcNoRStl9YYil7YaXYsyRnOx2xyBnjgtE3h7G13FEcR1y4PdAPuONRDzB
IJHGf4YgmwQ6a/G5HQGvK8JCiAbRF8zanBRH+EKgOrqK7v5Eoocg9BJUKlBLpyGfB83rFl2OsKM7
RvT5khCjIechM6RLTgeEhNeVAS8NHlx/HoSgL+2wGr5GMdDyWfVcuFexuDWbV3clJWuEhoTu5gx/
ibZwgktj7TLvkDRvoeTTJDvLQJy3pGKQ/sYFt9//1TvHav3FINVKyZw5XvSyRZdi4MJWFcE7Baes
EbTqogw7i+iOf0F1tlFc/4L8JVQH/9+CYuf+P/6cgGqt8aSat/F5j0OM+NRggCVcspkrulSBTCAS
kUQUZxbRHHkErYfwZBLJ+yJIJhBAyu6s7kjw0C1Aj0jmJHee9wNFQmd5xVJHBCKNMH43Inj8SNFU
RGg3heSCLkSHjAZp1W7ozmLI4/G5XGreP6nPWLm0uW3T2G0H5q/cMmludXo5qJVNlW6ih4qnUsEI
5Q2ygUjdIpSBwbfQ/DTjTiMSGUIK9iSi2WSEJTgkH/AiX6zJibWqmDMNO5V1szFbBvWbibBlX0J1
Biu2GNJ5Vs5LITj8IIoriQgu7KUc7/UikotCdKuMFGx5RLcUEcWZR9gQMEGoQroCqTLkKie00ybK
p8KsZCvz5oIB1SLUJVtVtFbSnjzCuX1on5K9XrTVdBujWijDx8sElTezWaAFwmsEo2WXoVkkHbiy
Tc6F4+lAJOGLpQKJsq1SsVcLYBShQBFpmsxkfOmsP6Paq5qjVnTGC44YR5R5sqKDJoFIeR1qIphz
UJSLMWxawa7nw/Zs0CqZi6KpQPlSSNlSLZkrZWggrI9G+EA+TyaLoNfM5YalXoEyvhHnzfPWsOJK
sJE0HUrqUFOhwhKa7C+nzRnRKzXJUsmq5Ek/6wuX7YJuopVYnvbGOCchkh7VlZPsafwwDZ9QCMUk
t1+1JUtkvkzqul0SPF7ZH6gQ+YI9TbnJPElo5gzCemJiIFUHvReqFSJbdKSqZqphY2Vvkieiab8f
we0qOQtlolZyVROhWNQfToUCcb9XAhoxQC5bdT6YRTR7HFHtKUS259vgS9lQjiJi2HmkaKcLNsqw
ZBEvhL5+/m33f/Xu8caw6snU46JG4PeeLThRyrJh13WbhlJGdJJBNDsjW/IVv1pwi4IlpzgYRLbT
HSQHLTsZpGNnleA67/4fZ1RXPwkDmUaoVCBlXEa00Hiru0T8J/5JsjIIPoIu1pwCgg/iP/EOPo4L
G4SEdJ5y8gX/h4CrV/ZquHW4hhWfzkK282BnhXH9cZ2Rzjbig19+7v8ovpCy4NaEsJcPeUSvR/Bg
QBCxGf1npSxbIihl1Toom/tZR4pzppUIFFOW/6yUK3YGvSyYZM1RSEejGKLzYauQItk8CAzQGskX
fY1YSfeIVUut6WhlI3GUMhpZjCRadhmlTKNDHYn/rJQLkCib0rRf5EJKPi6glNHIotX7XyVlyt+W
ctOa77LTPQ4J4aIZdJbflQi502hk0Voqm5s1W3fR04PkA2zOz/AeP0N4JNBlMNpGxlxmSXK2tEio
mq+o+kKMneCBloFHKavApPxhKprMR7PoZQlkpMfZ3bI1eR+FrkyQ8TiBVYrOgyGCT7OGKbuRs2pF
c6HmqNI+Z8wKrJtnSE6zKKpZTvvNmYBFsZY1ezXvTeY8CR0KSBFqKGXOzyBo5IwzZoBaAqMERQN0
HADEAFP05VQimXKHEJRywdSgHHLOJgoekXLQIlAISpnxhgoWVgMq5fBnXEHJ7dX8QZ2kUMqstQ3n
dLMOUrbEdUcajaxYeJYgEcUU0ywJzu+TI+EayZedDEqZJiPjrX0ISlmzxAo4BJrynCtC2QIpny/h
8YjAC8CJoChmPYkDWDSZDgeRgkMqOuWKzShZtLw7nnFFtP+FlBU7qkr4spQL1hzC+xTGLUp+Tg7w
MplS3GmUMoZl7E1tTiRlzSbodhFjMoblmk+lIZ7GosKUMUgB1Sxhgehg8LYj5VFe7rz7f5xRXf0k
NKTxr+gsAcs1QkJP4T95Ux7/hHe+LOVOTMbF8H5HbRzk8IkI3jn5gv9DQP8W3QpuSGejcCU7A09n
tXGr0dd4BxfD7eoMQv8zAcVeYk2K7Ciq7pjoDAmOqOpOGc46dsKCVUSKljYl87/QeUTH5mUTZAeH
SM42iiWr26mita9g6VWtOdmcUZ2EQXp0i97GXG1jz7c58VzdkUQ0awERnGIbdwgpO2jMHRoUCuYy
RirswxmfPeYCMeZgguZY0JcIBzBkFcxSDTSMRTkilXUlOVdc9mZ6zWIXcIpZVS2aYsfBXCxaOaRq
EpCSSUcUWxsJB3/MAnYKKVkYpAlMDfK0S+A9CuWVU05Wh3TZRnVBHukIXbLrSMUsIooDuxDV6aL/
6v6J9/3iI7apSKdbsnaVc2hdMA5pQRfCkBqS83UjBqEidcJTcRCSyys43DQpsh5ZJfMKkStCTwl6
606xy62WcUm7aNjGlV2TKi5BNeVKIHe7KsN+oWFNUYRf8EdRDSyZr4LespULkCyaUnk/0EEzE/ax
EX/dXm04alV3suRCcbeQEoyp2yYWPYLmYlQnjRQdBiZKza2oJG54HQdvwUsgLVB6LcagvXvA1qW4
s4Izydr9givUa5KH7Ea/xejCkcCZUMm0akWBYjAxdFel7pqA6PYuyVQrEyWMjSWrWLHLhiuv2NIl
G990a2VQ6laj5GbwQc1KY1nQMpeRpklvmY2ijddMtAps0Sb1Wit9tmrVKSAaoaguWbcVEc3OqTa2
AQWk2K4PjLKp1HI2ywG54BV4ghLd+Jp9XZb+hmm4BoN5UkaSdirjYitQrZnqDZNUB5HzuHgvodpz
bWz5L0G3sVCd1cMBEqX8hZdtVBDieRefs6fTloToSlHmMGtKdMUL+Dm0G49VR3BQQfBDRrIQr4T0
WqSgEBwGYd0t4G3bxSek3HkvTNMIvhfS8ct/nJOdfBRoWPwraqujWnQu0vEvPv6nUu4IDnXWcVk9
WET+T17/vwtcc1xDvMUVRvOinTEv4z/xT7iZGKJLHhXpmBq3CG//Tb78mv8ttKWsusooZTQyIhMJ
hUyqtgqGo/+slA0HjS5WoWWYe8okXyI4xeFiwfyflbKCErHlS9aqDkWMVBzJMxE3kvMCHTCloqFk
JKiDoALXAKPXXOUDNOPN8UQCaQGLUi44iiVX+X9Dyi0Ty5ISejnt4pCiJfdfKGXeqaOUGzBch6Ea
1OvQoAmVdetxZzVsLTKQFy1c1UkiMuFDL6esVMbOiI401hloZPRywUQZkMdMp5hZBrpY6NYtqAOm
YlLRaC17pmZO5JzerMOTs6doVxalXG/vEkmglNtGDlmooCfrI1SQZRBPGNnLQU239RVhmIcmb07X
Q5pkywmWjAQChkrWQnNYt0IJkfxu3uOqAl8DoQllhHckaEtEIiMiEW4BjzRBbIDA26IIB7Rk4mVb
Ab2sQI8M3bK5rtlwDBAVs1y0CGWbpDtzmiNrmBlMykWQcEPQ0RxEeUih++pQqIBWAqGBt3YBpawA
Y1jw3Y06aIaZKlhowYr1OMWDJJs0BXuglamAWgO9AiUEk3sRCrw1w5iSeWuKdebq0N2AnioM4Eea
dvBIFgsgDNpQKUEZtw6lLAU8WiTQqQs7LeSfaSsSV6zj5ZNS7qCEi4VELWtLpczxrrReDvNZCPGW
VKfl6DbDsBcKTgXpSJm35athg7VkUxDhrTnMwoZHbO+mOLH74k+lfLLT/l8ElYqZEf2FnkXzor/w
wY6CUUmjpIz3cQFcEkMoei0HiTgE0Wj4p/8VX36vPzO4qrjCuOZoZLyD64xrjmvbcXQekhSkcDHc
kKrfwAX+Tb78gv8tgEzQXeGy4RQUm79IRgverOSI0aBzpiKWWu1q6wQFKzeKzuMdAcl2GeFcNOPI
cyZORJsTkZI7VnAnNVdMtlYRyckgmiuEFEx1BM2LSA75JJoziSimRMGerZiaBajKoGuWIhfysUFv
igQqYE3Hsgj2B+wVDVO2ac51dgIIgTDrDdRMmbo5q9gqsrXcGSp0W5uSpU1nzTtrK9kLSEeXFUse
0SBRtzJMhM76Myl/NhemMZ1JkG2YKERxppHOzooK1JEvtggbNKaJEwNP59UEF4PwLg7p3O+omSJY
muTqUG+am01XDMnF3G1SpWhQYuxxyZ1tBH31gFfxSLJbzAfVrF/mglY+ZCu5uSLJYiGC9QeLgdEl
K2SJt2sK6S4FQ1WHLqOtoLtpHmsEyiKhCoSk+vSquUuDcsFeKzrqnc8te4Kys1pyVBhHCFGcfNmv
64ECPoV3RGUyWQzHVV+Isks5q8Caq6K9KYS9YsQnJ5NsOKxDSW3vwegvwTDrK3D+ohQT2CBtgKKC
aKBGzVXWrzA+WY8yaphSSV6wU5Q1T2MAdHA6KWlEFhFcAdbuLZL5VlgyPFweog0ooejzgTBCRcNs
ItZqW1UuQ6EFdTYeZ2IxOhbBP9WhhralgRLtguThEdYviWGtQPYp9pZkQ+sZdQ+HSAGK92ZpT4Xz
10U3J5CYiI0SCh3YkkVgoyExGaPDYaRqMypWHUcFhPGGWF9YdojIPw+07d7SUaSCAsVC0J4/UVJ8
cXQOyTpYHESLcV0NSTEgGGu0FTPax/ROJGWUctvLDrm9B8aBWTiftWZYgsHbUrxYiRZSEGPNGbnd
otrgWIsUrW06oeFkp/2/CDorCeEafuNmCpMjGgrl1dE0/rUjppN6xfsYM1FtKDVMoLgkJs3ObWeZ
P+XkG/2Zwe3C9ewMKp1NwPuoY3wcNxMtjFuK24KP47agnTuL/SmjXvbPT1vKGC5EHFisPsMV1sgU
Spk3lyRb9T8rZWzxPMFINgm9zAMpmNyKI4Je/s9KueyiUMpGO7nUi46qYStn3c6YzYRGzvstEX8M
KTi4MiHWIWNAJOb0pdwh2u2jSC9KuWHJoZEFU+E/K+UK1jumfIKMRxzhCBFPB3KYznQz818l5ZyT
Rik3TA2Uct0RKZn9YbfJ74R4WPG7GcoaFYh0kXSqdgtlybF2OunmYy4mQ0DODYota7jooostOBne
whY8uu6tMhaZMpkFh7NsU9HLDdOYLut4idQoC0fhd0rKKGUDqpqlrJiKIW8k4A6F3KEYfnq2EnpZ
dMdlb1Kw0jlMEFj0BQq6L0uZA6yD5JxuxqmInoLh6VeJnrzHkXSYonZ7wuUqQKVibVTN41DKGaeU
tPERSyjhiOkgF0FDI1cttYyLjZjSlCuac4QxCcouVvOrqk/B98pCgrfEUMq6P45e5iEiWeKKi9JI
pt/aQimn3L6MN5AJ+pEmFLvNlQF7bxNqcbcbSXjdSZ+nAfVuU5fkwFypYBRIQyJiSqadWIbXGCgJ
Fok3i5olpVvTeWc8a49mnAbjrWL7RGpQbJjLNYdSsUlpLxknHHGCSJCkjqWDWa1ZdIRyBzJOj+KU
kM5hvY5uOudIoJFVWx7FelLKnWN0WrScttFxiAhethBg8qYQDbFaSFEsYtvLJ3ZfYPNQLDwWIliU
MC5a9ktpcwrVzNhynIPqyzQ4S9bAotPJlRxtynauZGPL1jaddfiPM6qrnwTTbm+ice7as5c253dF
q/gI2gqXR3nh/Y6YTr4Ceg2DPC6AXusE5IpPx8dpSOPy/yb41/8WcN1wmMEVxlscP3ArcCVxA3GV
cMjBrUYXo5RxRMFH/ifI938FiJ6wYA51x8TxFNsMRhRHqOCO656W5KwKLqoNkUckVxaRXVhKt6vp
Nk4K6YivsyuACrEZX54mYlIgW0+HmtmIEaJ4Is44qwjtCyGCz4Jopm6kI2WWEJCOlAv2NFIlc7o1
jlLGsIzgHdrrEcMhJuliU0Q0mfGHY6IjrrkzdXeoSgQEJo6IaX8u5DBsgbIrIrirrKv0xYE+F648
1qFpRCYSCPaBNk4d6aShki2B1Ly8ZEqE/C6WSgoik87EsZYs+uSOsjuH8hhPEilAC+kI+otcYy4j
HSnzBG41hf5FWDKPyDYdSfmEpJdXTJwMrOaFUghyImBB7gpb3TEHH/doubAettBOSFpl3l8LB8Vk
XBcE4LE4DwPjBdqWYOzJvIOLQTpis1GBgJIGLgqijVOcYtnawEE2ZIac1yqlABeS7XYE5ciQ8UDO
GaKIGAsRGsQQ8AHI+5NZb1zwO5WwOxu1RDyQIUGIuJSkkwubYy416lQoexdH9OWodqOO05BgQA56
BR/JOGO0IxpOmBNZRyQLKRbUpJ0NQo4E2muJZSGeg2wc8kkQIwEu6E0GbYmAlcciIBrifY6sA9IB
kHOeQpimbKG4PUz7s1VQiiC4k6YoSwZosEZAhnzVpqDlRZAg0j67LqwAiXVcO+2WU1ad9dQ5CvJp
iEmQ1oGLOzN+oIJCyk2xbkIJBSgB0jT4k+CJAeVOZZwxBeIFa6YS8DSjQYaBXA44BrJpkK0ppDNc
UT4uQ2Lz1hDFoSBfqPkLBZ/YVeWiERxvcGDmnSzigdDtl97z0A3fGasNFYPsMFcveoQshA2HWnBq
BUcZ0e0KClqw5DhTZsHQwgdvfGjk9yMjfxi59sjVjXR1kOo2vFKREJCqU6g4+Lr9BFYO6YjyP86o
rn4SlOy6wRUfPfDueeuO9qdamC7rwSIGSVQVPuvLUsY76Dhc4Lp9Vz582f34LAzInezZE6/j7b/J
qLf7s4Grire42rjCuJ44hGAzXFyf+9NnfnjjoWtmG1PRyJ1l8K+4yZ1t/FNOvuB/F20p96fUDcNz
9kydMYWXNFekGsgU/T0UaP8bUo444hlbsEUbqyf0b54xfkqxT/Vn/7NSRiMjqOOapUuBAg+KlohP
btTXLZ2yedXMeYuWNrr7SgEavVwjgz3BxIolM+fNGj+2pav5cNERKjnDoqeG/GelXCJoDiI8k54/
Z+rSZQurtWLnqPd/lZSpiIZeFoCSgKnHYXoxPHNRctVmZfmmRWt3rDi8bfWuNQsX9hu1NMn5qoVk
/6QJyxbO37plS3HdOmXBsNGvREsRSQ9weqSMUkYjzx8/fv/GvqXT2J5kS3VJDVcPflZC1D1vbPem
Ja1pA9nueLwaCKQsfjVMlfqlKYuGV20fs2HvpMPrJ+1fPU5JcXKSndtXP33jymXzhvNxG+WzTOky
Dm6cvxT/Rw2jl2lHdw89b96C+JZt+rb93YvXSlNrpWIiInrSzaw2YWp99YaZW/ZOWrV5YP7YUpXx
CSFnl5CePq+2aeeM7Runb1k3Zdnk8S2BaRs/4pzZ0zq0bvXyCQN6zJf0weQBY9/ijavGzakyRTaY
RyP322uNsdqcVRMnLKyx1UDNrna7S0UoYQCX+lKzNoxZsnt8z2xxwDeIUs7YC13s1EXzkts26VuP
+Def6l01d+zkPoMJS2xE7uXZ5ePHbtlV37W/Z+323iXrqsNGbyWnl+y5siM/hs6u7Otav76yZ8/A
rBnKQF+iJ6YXCKojZS4k0X7+fyXlzoHQL0uZc7S55qwb333io5Ffjfz9Z3/32HV3L+6ZVvZJ49ne
irtY9ZSq7gZSJgvoaNlOo5eNRIEi6ZUTV77z2Du3nveNrlyjK1kt+OSyWyqRYs0lopcbDgGl3LC1
GeWOf5dRXf0kKOW1A8tRymctO3Ug3YXJF9WMtsJ0ic8aJWVUcBT8t5/99Se/+vCCyiyMzH3JJt5i
6hzl4pOMers/G50g3NEx3mI0zkDslJk7Rn7w93cc/cacwjQceNDFuL24abi9o1b7JKNe9s8PsKlg
vAcG17ETD/ozUyElteGsCd1DJ3IRwm+PxtspScgDk4aMC4QQYSRSWSeRj4KQseJfkUjG5sLgE3RS
LggmQDS8Q5u947YHqUFItICKRRDaEWddSZZxcKyTzIMzAyYCMGRlyRzjZ6O5rDsS9rDgZkDPQs4H
caeLj8YsYSuZds9c5liyMTg8l61PiM0+aF1wxFWUWSGfDEWA4Tx950L1dIhPASiDlozKsZDg9Oi+
sM0PMToYUMGWh2AKYnlQXTkdE5A3nbMEAlT7cJIrDp40tCtrgi9GgozD6tJg4tbYtHOikekQxAwo
AOvycoRPzAbzUQIXxqLUh9GMbWfAmBWSkUA6FvLnIcK1Hw/lIeCDSAjzWvunE4JXkfwa40umHMF0
UI6QTB9Ig6C2YMZEYoUxbXBgxezeY9B/HFatbixcZNTywymbRE+Boa3pJZunzVg+tGxHddPhgWWz
uqpSoOQu1gO1bCJqA1AWwZLz5a3nNvsWE4P5ouHJRjPQ6ANqO/Se71l2y0BiBQjxiJZNCV5Xzm4q
r7GOP5CQNjlq+8KzF00aN7V3TH6yYNb15bDs4vyy3mo96oEcaPN8yy+olJbbJXdW89PC6tjQkfLG
9cra1cLiU+TNx1q90/qIFJkYA+N3C+OOJYbPis7eqS7cV9o4b3q/xhOEs1otT7syUDsVNi+ZePrO
ZUuvKnbt8TYzSdXvUReal51fNRZZXVXQvb451dqii4uFtfZSKoRpnSnDrFXcrOsFRFgC4YlQDURU
p7vmSOkQKkw2Ld6nrTtfnrTD28p4ylF7JJGWtMLk0xPjD0d2rTJ2rNDGXuKeeIV/yeA40RN0zoLq
Edf6XV1L1hd6dvtWX1ObeDwbnwcJv6OucxvXLNu6YVX99OD4S5j511O9ZzkmtBgpaamFKiVfAYKh
iKx0+bwFq6Xg9Ne8UUwhkjMj+wqKvxg3S3K4i480vUDRYT1gycQJ6s4bHnjrgWcOLN24tG/qgUUb
D8zfMEXpLhC5rohccnOIQQo6waukiChuBeF9ShRSvULz3SfeuPn4FQNCRfHmjSCreCSR4HmXqPkN
OShGIFTJq4wvVckVkrYoH6BZXx5v5QifdSXzZFqNiTkixfmpYlrLOBNKVMB/0p5sxp4XA4rodsYA
RHpmxNeXcQDvBwB99rSzP3nsnou2ruzOTSqE+qquZJ1Ml11ahdBrrnzFkc0EqrlQXfVEWJvHbKKO
nHbDm3c8tLAyUEt1q4FSv19uEWzVItVtSsWVLNpjqkMyCFUJhEVvQCBajL0mBnNZZyRro7ELUB4f
FwjhOlPuDEOILCkJ/mje5WOsGqJGE3GzTfRXkmZez/EJIhAwxwpUrUjSojlRCvCsJR6HYCEm49M7
RE3BQkjgXZl6QBRMcRUSFSclkhLn5BmnxLpk1iUyTkHwMlpY6hUrapQWAlkplM852YydVoLdLFlV
yKjoDCn+HOuKyzElbkvk/XLWKzIhLY7jbkILmyJZS1DyZpoJljK5E+iAsOb35BWxKws+rKuKnBGw
+Vr2jALezgms7YTnKyScctQmNLCBAjQjubIvodjSuHzFrWMmUy1KG6uEdA5Ntw9RWP7l2ClM6K+P
3yIvOaNv8fn0hAO+7acO7D1r3Pz65GpYCiV8RlWZNkNavrK1bX33+hXVWX21YiacsjnyhLtViC2c
Xl+zbnDfgTmbdi0aN63OkKYuJjFhurF41eDKc7Xlx5WZu5JrjmpHDx1YOH2q4qdSEFBk78QJ2uwN
4zecumT5hokTZ1WkqJwhsihlRlXGLI4u3qXtXMlfdGT40OYt3aoW5iLj5o9fsTWqd0GIgzAP+hxY
eDrRWy/qAjV2fGHDplko5QmXw4yj6oILKl/Zs2PppHHlcEIifHyRGpzSM3+XuuZIc+22Vv+EcD0s
VwICbQ/3s6XJizPLthU2Hxzeftr4FcPLJTcmXMfy4YF5B9klp8so5anHI/vOmnn4+LyN02ZXk7mo
G9DLY+fIa3ZPWL5lYOmmvuk9zWI2SaXjTDap9cDkxan5a+prd4059/j2ndvnzRxS9ZwzZ2doFy+E
slIkj1LOhJQxYCBNmF6BSZALOsUUSlnbC7U6qRsWxlNMWAR1nm3p8frYOY2M6iPSEBFAzTv5pFm1
K7JVCvvcgz2t3q3kxAOxjceq/UvIsWw1B161DCs38GMvj/Rd4J11TZXZZGvKgppJ8h5nygyl1Zbp
Z1DZ5WAZA6Ek4Y850Mh5EGrrYcWl9KJWsRHzAtuW8ppLm/pis+qjxoit/sOFvkPGuDHOSglCOmSb
YI85wAPSHOf8s+rlXTboB0IEvw7lfEKK+hwOW6lUGHehq7APcn7Qc+7mLvecC8X53U2UMjsTVl/S
aq31gQIZgBnF0pJLy8oKEwZn9PLs1fzMlezAeZG5N8rKCvAMQSMcH8hQRXO0x0sPLg1N3ZibfSA2
91Bikp5tpt12wqMVKwsu4OubrWoaonZIrIGF38wvHzORJ/3RFTD9GnbBajUttEfr2hbn1PNpfg0I
2YiYi5Y0QWQy0AW4/t1n2LpOt84YVJS0jTMzCRzK643r7rv/Rw8+cM7SJf3xfN0Xq0cV7BGiR6fs
ghRqMZ4KHaimSUNIlEO2XFXo/fj1n9x09JI+xtC8mZ6sJtiiGpnuTxqKLVkk2QLBaC4OU7bs4hEJ
62hCyjqYEMS7ufqbj7xy7RkXtvKa7MlVYpLuV0MQMILFa0+7/rOXP/39D3478ncjd19zy6DWGwb/
zJ6prz388m8//s0L9z5z//V3j/x+5INn3zljy6nVfBFthWo+uPaUNx97deRvR37w/F8cXH3qRF2e
UtTsUPA6G1efuel3Hz//wtN/++lHIyN/+PlVezf2UlN68pMHo0JPgEYjV0mjTlBVZy4brFGRpuaN
8g7fn0q5zyd1pNywq1UiVXYmdJdSIDXZH+JIb85cSoJ2yoqt33/2jX/8fGTktyPff/7FA2vX90qt
ELosYJy+/ugr33n09x//aOSXI1hY3HjuBeNLVS3SFHzlZdPnvfXsy/iUj1/70U2HLl1UnZwEr+am
jm458vYjr/7VR7/C7frlez89uuOMVqbYlS1VfXwjKE2lu4q2LGNnC6FiKdbI2/gYpMYqE+++4g58
KXzKi/c+PqU+3GQKTbq3nG5EgE9btL1zV/z0xbf+6Ue//eTZt3av2DNoDCUJtikNPXTrMz95769e
+s5377vhfnz6Hz/59eEl68uhbNMY/9BdL/78J3985sm3Xvnm4//w3q8/fO2Dq8+/ctgvTE0Wn77v
+bu/dv/s4kz0co0b9+nrf33NvkOTRLU3yVb8SVzPsoftDtdq3kKFLLdxF7FsKrsVpETyCFYqHWBM
qza4jFt4Ss+8I/nedY4la43VW2rj+V7ZmU813FM39c3dLszeyq3aqW3cX1m7brwkk5EwVCv5BWvK
yze3Jq+h5m1X5+3t6llM8eFghc7Xh7QJc/oWnqUvOtsY3uCetD20ZPmkeoujEu66Qc9fK63eWZ2y
U5u+p7D2NHX2lqTOGnFvIq55e2aWl5yeW3RaZsvy3tN3z9y+dmtRMDJN/5wd44fnBLC47V2UGruK
mXgQdn9DnDxugMnGxw0XlywcN/Ui96TzXYNbc8Pbqc2LZo2talI40OLoeTv7pm9q9G8mJ+wJrzut
umCHMFwq4EqWpdzqhdMXHxLGrQtO3ZpafkRbNGO8xiQFDz+tOnV4S2D+6dyUC/xdh2D++qGlWyf0
F8pcJG40YMZCavae5Lx9mXk7KuvPGLNpzaRGKR5N2dIU2bfAt+70+qq94xdvG9h1ytKVa6dMGSuX
FJ8UlYSwwMYC+ZDHn/ZHqEjR4tWBrNp7KrZum0jEuzIzLnb1HIaKauMyIDsMCvjyOOeW0wdnbK7X
ZqQjVbBxEMPqob1nOZN1BYVCZMXGaeIq0NbDxsv02nJoidk0AX3p0limmR6EykLPsrN1bRY0A2nD
ERwgKjWQ+qdqC9ePK8/2ZPugwICWh7jdjJQ2wtwLqGnV/lKcAQboqb4VXxWYxaDkYd5kdcYltcKO
CMtDIgWCBwpRh2TXRZs20Mfv2DZ3+YFmz7yoIJlTGVCIgEoG4+7ouK4x8y5Jd+0FQ/UkY8CsgjmX
C3PGVJmQhZ0Ha69u1daRzibWGY5Z/aVFlxvyanwvosD5evuKkpwWVzkWXNYwFqe8XaC5JSRvdg/z
hQn7ZG2xV17rnnZuccxEihGxKPEVe7XFl3HDhzyNIsQD4FsAYy4Mr581n/YEg4th+leFKcsoHMjt
fVDf7tp4bLg609cMiQjmL0y+VgncRZh3gJ+yPb2k2DsUYwcswxLWMYVZrz3303/88NMrdx8YZsu1
KKeHDd4tsL6akRzI+lokCAlPlUsMZEJVC6R0rv97z3z82kPP7Vu5tZzgZX+mFhMqEa7k4woeBqXc
PnOG4NHLipNvQwiI4Ffjpkyv0PXmI69dd/YlfUIFY3I1LnMOJm/OPnDNI8/c8sK2eVtWTVqxe/nm
7YvXiwGG91HXHb3q8W8+tGHm6ufveuqtR19dO23FJy9+H+8Xk6oS5u/96rd+9e5Pv3rm5fMHZv3g
uU8+f+UnO+bMxrwmUFPuv/P7P3zp25eiHVdc9vXr3hj54Qc3n7pnoj6vn53SF+QbZA6NXHMXGiSN
YRljMh1tGd6Y6PBbzPQoKff4pAbBlm1yzamVPemSO6WTquHWeE8gZycCwN13xQs/eOmdg+t2jS9O
+eqZN3z4wkvXHDtep8uY67fO2fXqt9+668rrdi5asWHirh0zD04o1yjSmzLxl+y77i9e++CsXYer
fNctV935N2///MZTL2MdqV6q+tRtj+I27lm1a1rPlFcefOnHb/zw0Irdk4vDzajaFdfHpMo1N2v4
Dd2n676iTGqMneOcQjGuD4i9rz747P3X3dYr17DgoAgeqxOKqJy354ZfvPz+uZv2bZi89Kmbv4PD
w+mbjmBA3rZs/0sPvXXslIsfvvmh1x569dytR5795kMfPfrS9ELPaTvOfeeFTzes2Xv9V+/4xTMf
fnXnOa8+/b3XnnllQqwwNqy98uSb93/zoUnqZMpMc7HGx6//1aNXXT/TqDYjVFeMGcpU0Mt1X7Hq
MVDHJ4yst2kbWe5IuUDKHYCOheJVGLNSnLQ7nBpuH7HJCkBDnLOkehcZyw5Nr0y1hTSgCjBubmDX
7jljxgrRiKm3R1q7s3/ZpqY6xpStQ6wGFhq0VCLvdbsikJFCQ1tiU06h6HHgq0CWcnsD7V2KU8Y0
0Mjj5ya8ZTDxMHdbevVheWL/pEwoi1KesXbcsjMpaQpURbuUxrGMjXkiua7gxLU9XA1akxyzthem
bVZnnGHbegM9fqiHSkd5xo+MO27rOx3S48GkgRT3p0kL63PP6e+ZtbVraKkSHwZ/N0xenVx/pDat
p8sH0FuRd6xbsmA/y4+FQBHCFXyvEBXzKgE5Z8s6CjB2W2jSed7QbPDlICaYw1ZHzhdEI2/Y2Wws
gFgD4iWoTA2ce/amicNyKG6OZxzjV8ZRyn0zWay0M5QzxxB8zkKngPEzXJBjon6UsjfpTXCJktWn
AdHlHipbuzAueouhoTNh+CzorfnEPOhkOQX5AAf1Se4Jq43lB8cuO03tX+4p1K0oZc6fYLyxxWsm
Tl/Qa+kFegnsuq6OUq7Q8TIVG8hWGMAmB4W5rm2X9zaXOYfTQn+cUSHXbTPGzams3T1r2ZHm6rN7
t63sm9Cd0NPxrNuprIKZ52RmNoYaWQnwLWYEl17J5hdAgbOtmt+YdlElt9yayYGkWMoJAjHc+C5i
JATNenbmZmXpvvqGTcMzZ2vjeE33hIN2P0p5zkVJY2Nbym4XhGfDtAupxZO7q1xEWgwTD2fnHlMm
HcrvWj7zwLoFq69vFDZadcbDxM3+gKU9m8cCmH9pXVuYCA9A0a+lICa7o7OqfeP2isEB8E6ECWcr
02Yroma1h8xsMT/xjFBxA1T19h42ejNMvSqzauoslLJ9OvSfE1u4WZ+1Rph6LD/jHGb54ZY4xlwP
8N1RRbCnchCKdUNjSWz5mUZzsXNMgm96kkO2sQaUEr7SuiVHjq3euLDeU4/xhi/LuFjZr/QrM+cP
bVwydb+WnSBnx/aWFvaU56QCZZ+dGtsz//vPvj7yq7/7wTOvf2XrwenFAZlMyY5Mf6Zc8QpI0SO1
92CQUvukwBODDeMWAxAtpwsv3fv8tWddPKQ09ACDBQplyTE26s0H3n321hfn9MyqpEuUJ6EluLgp
lHUkzt/7lWvOuqKWK9507nW3XnwzBm3U9LPfeqKeL+1esu3jFz44tv0MNSLgwpV0DaX8yPXXFSPh
pfPPevXF36GRu2gvgLJg5tk/e/aRq3Zt7M5PMELdLQ81HFNGSRmTMkpZsPtQyqcf+dooKdddDEq5
6lBPShmhXZ6kyTYszv/oyb/82nlX1RkDR51Vk9e/9cRTl552ejlrBMGLUn7v8Y+Obd9bzbKKu1oO
90ihaABg1YStbzzw0aFNewYKrYyXSZL57936xHcuuRXjcB9de+7OJ2+/9BvjqmNSrgTWBN9/7t1H
brhvQe+M7oTRLn8JuuHlK5GK5tUkQhVdChoZvUw5s5ybfur2B75zwx0TqgO4Pjkni5/55OqyD57+
5ZWnnDVRbv/GmHMmH7rpwZvPv6lIdR3afPTxO19U07VT1x9+9cFXhvjGsY2HPnvm9clq88jO8779
zad6W5P27T77g3teGp9vbFmx6fuvvr9UHbNEGX70rqfuvunbM0ozWRvXkCc9/+AHNx85OkwJjXC+
LyUMpsuaI1twymVSK7p0pHPGesElGk7BcDLIv0g56/VlDdvMVc0lB2RxDKRzkGdAcOSKAUld6Ft2
/uCc03MzT00vPY1fc1Tbfubc0pi4JwsZnRhcnlxysDrjcHbCnqi+zIrZR4jmM+6oN+KlJXrCNn7u
oTI/BQKoMMZCRNqzzEyeqa4/W1l+mJl6ML3iAmP5Wc6tl0RnTZmSjka9Mkzb1Fh5XpaeDFwsnPV7
0lHWT8TT/eZZpzTZmnXMPG78LiY+BMIymHHcPWFsn6FySY+VT/j7NjtmnJqozowHdCjkQ1zEyaT8
Myf2Td1NLTyiTTjNM7jPvu7cyq4r+xfOG2YpLyuRM+Y2Zh7JTDkYH7fboy8CVm4fo6ftdcbR8OEQ
tSk++ZgvvwjSciAl+aMeLzK42LT2CDfzTBuy7LTaxnMGzjq2cOoMNsZZ47xt4vrsyiO1ygQ6gKEy
TSYz7nQEoj6g/ek+rbl07tDuzQvWHCsuPSLPHnCV81COhQXSiVKO1mwDu6wTD3kGi7KcCPa4FxVg
aswbSofi8SaUZ/um7I0vOoufuZZi6sBliOFuae3ecaXBkKUfUvNhwTmZ+npQRAdHm3DcFKDXQ0Fj
cmzV6ZnabOjLhEp+e8vWUze3wvEUEipCa35w557slu2JmpFOR8zGKlh8kTp9sE/JJIEFfVF85ZUa
uwBU2bRsSWXWRWVqqSmWB0Y1dQeSRTsOso26Cbu2TYq4pZqzOhhetqp349YJWxZO7lOzbq+lt786
/fK4sBmkgsPugchMmH4+N3dGxZA98iKYdIgavz/buy28av7g1lVTVl3dLG9waTLJUuZcOJ30xUrL
rGsuqRszsrGm3YhXaVLUBWLO1GJrX8QzCVxzoO/c4pQ9GWYSBBlTYSA3/7z85CPhjesqO7Z2zb+8
NvfSylC5N+2OBWbAhOPS0u0VZOXljbnH1cZkX64MjRhdDecYa6gUogeW5FeeOjBtPcv3QU+YrnlS
DVNX09yddBtcrKV5MxKRYByZrDmeJ9UBdcqC8TuR+ZMPzBiza8X8M9csPjZ17KaCOCXqKwRJNe9P
rZ274sXvPD3yh5HXHnhhxYQFA1StHlPLPglBKRfcInr5pJqzBBeGVI/Y9fojr15/9LIhpVmIiEUs
rQg+AP7p1dmv3f/W7z/5w51X3nVk64FSXpUDmPKCV5122QPX3Tcg9txywc13XnbboNT7rUtvveOS
WyQ/h9X6z9/48fppqyeVxmVtSTmo3n/Nd+668LJWKn/pud9++3u/3z138jAGEHdj/Yrzf/bM05dt
3dKdH1+O9XX52f6IVCH0k/uU88EaHW4YZES0eh0m5qxTv/bOHQ8vLrelrPiL3V4RpWzYlKJD091p
jUyphIZknWQI4PxdN7/+nR+vn7u6X+/2QrhJ9332+psXHDw8qPSEwLt20uY3H3j/0MpNPYzaiA1W
w31ye+Iyy5zmsl+98Tefv/3xT9/79Gfv/aa92+GvRj554t0eql6MKO89/c6Ttz8+pTUlAAHak//6
hTe9eNezS4YXNGNGI6p3Rw2sRTrHHmuhSivWKPnLgk3MmVKUJfPITffcfO7Vw4VuHNjEsJFy0FsX
HPnohV8fXbtnotykrFHWkbjlwm+8+/jbXEA+Y+uxD577eHxlyuE1B19/8NU5jYlnrt331n1PT9G6
T9t09KVvv95fn7h706mfP/bObHV498Y9P3z/s8X6+MnZxl23PHjv7Y9MLk5H1dW0ie++8vM7jl08
Q6v3paRGmK4HZM2Rx6SMtPdatNFLhHYiJsud823+ZfcFG47QZde89b1LDyrsAEQTkMoCZ8sYPmFg
Gzv7jHptJSTHQrILuLHQnJyLKxAVLK4kBAugTLDUVlqmHUzPPFPs3hIs5CQ+kgunwpzKTdwuzDlY
oieA04BIHsho+wfzKOUFe9M9CyE2DLnJgKFYnQ4iTceDwZAB41YVFp0d46dDgc6JyVguIaCXs4NW
lLLYck5aoqw8v8ddh/j0tpRnThuPUvZbsBJPDm0nFxylytOjljxuDqZacz7umTNlcPpeZnhjjJ6P
IyMIk4AZBwIboLJkJAkZ2hoZgspKWHA0t+QcZsY8qdJyS55e0d0TbsGEbelp5wRzCyFEOd1JUzYS
TQVDY5fbVh6imhuBnwe5Pog3oKc/JGvgz0JSdKCUlxwslsdT2bI7RwcQJm1GL4tRerjUu2bJxMN7
Vm67uGv5GeqCsd46ui/oQynbeXwp79QjgXH7iaZIsSF3F7Gg6ZxHxTPoZTMDEASLChN2hrec3l0e
Z1bZwPL5Y7YfmbFkS++MC2Ljz/Zuvq6ArFre16xF+jxzVRgKizBuEb/5HL4xF/qz4YLX2u3oQ0Kx
ZCSRtjEQKcPSFcT+QxxKORuzVtZbV15RmtLXjQMhxECaG1p9tSEsBpGHObPkOZdUS9uCGR4CSTCs
noLN2zB39xPDhXSICzhdUSBiEI7DjDmF07cuXzC2EY6SPX2V2VenS6e0pRxOAbsC5l6qTJuoZeLA
zYV1V/VoS/Fra58SN6FXXHRxUV1plngHxup0IBF2BfhZsPTcgj49Q2qQc3KMW0Ipr17SP/YsCr1c
P1Oa+tX+FceL0gzARig0otPOjI094N2ysb55Q03dQJh6cWBWUMqJBTDj4uLExXm+Ad3bgosvLBlD
droGKhnlbf5+qrBj5oqlB3rGrxboLnBzUHUnK2SiZekZJMdkfKWUp8DawqIrLrpp2p5mfYU+edJQ
abGeGZfy9TS1RfOnHZg2dofCjE+Hm+lILREs81GKBHvU6r/m+OU/fvXj4ztO78tVVDdV8opFT3tq
i84ejJM7MWhv28sTKuPefuLNK049r57TRE9eD/G0jerKtnhSTkFuxaSVD9308G8//dUjt367RdVS
5tiD19//yI0PoIK/cd6NT3zjEbxz1+W3v3zvC9V08bKDF7350Ksrxi8ZkvtC4ItD8qV7Xn7ihq9L
hO+KCx58//W/2zl74iCbBODmTD3wyUMPXrF92xhpRis7tumla2Tuywf6coEqFaqjlAWLB6V89mk3
dqRcTXZ1pFxz0gW7ilI+YeTkSSkHAQ6uuPj9x3+9fOpiMcrGTdlFwyt+89HHp27aooR5lPIpiw//
+OVfHl61uZtWSoFu3dNAI+cd5Obpe3/04q+vPHrR6llLJjam96rD0wvj5tWn4offlaviuHXDOdd1
S91SVAqC//bLb337kdenVid2J0tI2cNXfWJPvG4QEgOUYOUMTwG9rPkk2c2/ePfjD1z/rRk9E+Qo
zfoVH0S3Lzrj/Wd+vmPG8p6MSttiCfCilN9+9M0uof8ru89/6OuPo5SPbj3r2TuenlocOmvd/h8+
/cZYvnrqxrM/evGzqtq3d8uRj7/z6gxp4PCuU5/8zlMrylPGxksvPPn63bc+NMCPoeycQve99d2f
3HXOZbMLrZ6EUPKmmyEVvdwKVnS7eFLKbS+fkHKJFFHKJ0//AIaMJ9OOmbP7Vm6pFrutfM6ssA7O
SrGW/OBKasaOwvBKd74X4ipgUmO1oDsC4RQZShJRAXx5cHKgTYSpO6gp2/NDYl0P0UGnPx1MTlgg
LtvWWxhjjqmQzLncAUhmYNrM6ubTK9PXxFPYDVSIqhCWIel2ZXzurO6aurS5ZF+R6YVSjOeIRMSS
YAJCtmadtq6qV11TZouzT9eT4yA9B2aeG58ycQxHZ/JOZzGRmLVBXLmvXu3P+5JQyPopn8kftI4d
39p4tDl+dSzYAxYdooU2uagnH/Nmc554wgEcmBWQpsHsA8zK1dVGi2xGBhhQXBmYtExdenpRmgyZ
NJHPeZJuMmi1jF0U33JGX99qa2YQUgZkS+3zW9NJ8AQglXPOWKms2NlVach5NprxJ6hwRgq6WY+D
tqVYR4bxm2gf2D0hItCewVL3ZVVC4a0cmTIFaee8A+lxG93dFY8hgB6I0jaCY8HQIV8CexxMFPQt
i246NLY2LsDEHGNb8uBYbvxkpbHa07sxtPp4c84BedaUMpezyYFGEPImGmrzgkvOiRiLoWCYMmnI
ebNqSiEonzPnwSwMOP6thzVHI02plvWmqrO9q87onjNJaBqkX4ehFamNZ8+sTEvTkXRPoT5rX3XG
3vLgOI9eBjoDJc2PpXHSEkmmgeHApYJTAUhDY25y4/b+sZPT1jgIXdGxFwflPRCNAMfahzfmlh/t
mjxs5OMWbaJzyznjp25SsKZJemBSr7753PH1uSE6aeMyzrjPmY14jdmw/Ozw0CJK7Ldz/lzaEW02
YO+e0rhTAkO7PD071bEHq9sukRuLIBiF3kFh6/HWuJWhmkjSYfCpgK+shyqUXWCGyRVnTJg6XfEF
QBp0Lj2lZ/oeUZ1hDfgBmTixsGPHvN4NSV8LvNU2dMKZDAAfoFP2mCcWn75w0cGFm2aXhysxTQ8I
sk/XgkXeX0taZS01xAZbaaKQIYspQk66JNqnpF1c0p9SKNUJrhlDM9985JWbz7t+Wml8IdSOyejl
Tsfr/DCkc5A9S/A+iBWSxtN3PHXVkQvGGT31tFGOK6VIOQqxSqLFEUrSmhIC4valm9944pV9i3cq
Pu7Kgxc/cv2357amo6ry1iQG+asOXfLY1x6QveyeBdv+9qO/vua0yzFacq7c3Oacv3jmkxsOHpPt
wYPbLn3x0b+4YtvO6ZLqs6rrl5z9sydfvGzTrmZ2wAjXG162P6qiIyruLw70UYEaE2oUyahk8brM
7NHTbnz3joeX/LOUuzwCSrlEGFiGq+6UQiZlt654jBzhC4N15fh9Hz/7u4tPO7+U15OW/JzeRc/e
df+VZxzr5Vph8K8as+6dBz7Yv3TdsFSqBnp0oqb5YpSFXDW85cNHPz//lLMatCGE1GKmZoQkycME
wIMlwgv3PnfbZbeglCPmiBZX3n3q7WduewLHnt5stZkocJZUPaIZdrZMiA1/GdEc6onz1+N5SD/6
tXsfu/G+FlOmyZQWLUQgvmjMpnef/PHdF9w4hq1HgMBq5o1vv3r14Ssq6dr+FQfff/L7a6euryXL
ql+KgXvHjLWv3fnU7PLY49vO+fCpj9Yv2JpyU2Uno0Bq8YxlH7z60aRcq07yD9377MP3PTe5NC1j
yRfFoVee/eSmU8+bwJWbYb4WYHpjpbpfqfsN2UIXXWqHE3swZOTEHowvSTnnCIejpslTmxv39CxY
rW5ZO2HnpqmT5HGig6UHTWPXcmvO1ObsyszbxK7eV5w2v8doZCJpd71XX7CxMnddcXiFb/F+YcN5
3bNPEQb4Kvo06g6nAolx8/jNhyYt3KbO3yLvO7yuZ1ANRUHRA/O35Nce1GfvlubskTeclly4newr
6ijlEANz1vRv+cqAMha0IEYCOeumMyQVkGDetp6uwWi9NzhhLzN2V37ggGPlNeLkCcMCm6uk05TL
NTg/tuKU2qK1Y5dtnPiVvetnDZQDIZteoGdsyS86RZ5+MDfjUH71qX1ztxdbRTHitgwNl5Ytnzr/
9NLAxtTAOv/a86o7d48pV+0Vf7fiKPsYGJzLLD7NmLaT3rB+7uFDG2cOD4XtNqYBuDlzDiRnnhJb
tquyZn8Lq/uBvmgkYY4mLbNWa5sOjenuL9F8XEgyXJxCKfM+l+xhjKAox5xswBzLsr5oGqWMoVBx
yV2JVvfk0pQlQwsOZWfuia1eXF21qDJG1HiXt7/PsXaNNnmpOmdddcoWdsnhys4zp4ydR0kZzG9h
RrCn820VSnNgwwW9+ixL1YjQabPoq43VZg+tzk3YyC0+Hp51hFy/rtnfF0g449N6p05YPnXmhnnj
T+GnHFI2n5+ev9/ZpTSidqzhYc5ufcOyrh3rhiZtYDafM7zswDiUctoXZWPZruWZ+YdbG7ZWVm8w
Nq4Zf8rOOTO7pkhBtn8wuWHT0Mw91THrxdk7a2vPGr9r/wSUMpEFfTAz+cp46TCsWjm875QFGy4c
HruZ0jg/Srk607/+7KHqzCDak47YJvZo648N9yxOyLSHSdl7KtqsiUMz9tpWfSU2e3Np7tbK5PpY
JcrNmR04+6wBZhY4G+0RJTAWUMpTtjtjKWh0U+vOKE/dkByuJaQUuKU2jFPKmJlUt2XlmRPXrBvM
URAvQmlSYOmZtdI8IpUEXQusWTMJpTy0NYde7l4VnH4KP2N8XefCekJGCxRaXR/9+CcjP/ztJTvO
qCUMxcsWo9WOlIVAnfY3cp5qzlMWIl0o5aiNG1+dcXD9WSvmrWwVuopM6b6v3/+b939+cPXeVqbc
TKN6lIpfrnqVzgnIbTWfmABTjVdILMbI/Av3PP/ctx45f8+Z+5fuWDNxSRoy45UJR9YcPXP98amN
aU2mdcvlN//svc+3zlyfsyTuuuTWV+99EaXczJRPOIu89sgVz97yeB/T1ALC3Zfe9sFjbx3fcua6
SSvefeidv3zrN2cs3SjZAmGn+vWrHhv59EfX7d0/rnv1xUfv+qd3P75h76mDwsR6uq/l57uDIhq5
6vlinzIdrLPhZskdk62+f1PKVQfVOX9A86TRy6q3oPmKtCcYMztytupdlz330Xff/8res+b2Lf7O
9Y/+3Y9+hlLuJP3tM3d//sLPDq/c1EMraOR6qK8rw0UBopC/9fh9P33zk/uvu33Xsn1bF+46tHzv
wt7ZakhMmqJP3PbYJ9/9wbn7zp0/Zv4zdz7183d+emzrmZNK4+oxvRpRW/FCNaQ0fFrJJRgOuZ1A
3UXdqQl2BvPlJad85Sff+8HxnWdcuO8ru5ecEjelMC1ce/RbP3j0tRuPXLpqaP6Ltzz2+w/++uCy
fZxHOLbt+MfP/8Xy8SuriZIWkPMQ2Tt304cPvzJV6z919WnvPPLu4ikr62JPyydzENmwdPOrz7yx
fXiZANEta/d9+v1f3nPF/TMbc3asP/PXn4/ccezy6WqrP6V1x6RmUFOsuZpP74lWOxm5vZKEViLQ
zkqRkJB/2X0hufNZr69EMzMnqFvXjD+4YdHG+ROn6FMrkWrEBwIVmDCc3rC6+9Ttc3atmTi3d3I3
W8rZsrV0deZAfdPC6Xu2Tdq5efyi+c3hAboeyJY9SdGZkYlcTQ7PmVBev7J/24Zxu1ZtnTU0Vc/R
WV8QC9Vxw9zyZZO2blmwe8v0pfNafTmWMtkVmls6Z/7KZfPHDfd0+3gcq7Edi9ZsOOKYMrV/47JS
gQNu0Dx2FbP4K8UFZ+szx03RaFEhQm0ML4bHNUsW7tmycf+KeYuGmrxA+fyEKJp7e+MzVzTW7pm8
afPSGTOH++iGQOS7hNKU5vCs1YNr9s7GP81YXp9SlVp0tEpkDGssFfYaIj1hUnX12umnb1hyxsal
cxqtAZZPp2IMne0eKi5YPnXP5in7tk1fP3O4X06nyYCeYebPbGxcPXF671QxyuuEjuCrIRVHATF8
QUT2DCne4Yq1ZkCxSXbP5uctmDVn3YpVq3YNrtjRv3vP3F2758wa2yMkA4oGs+dym5fN27V26YZt
c+YvHe7vNSQhXgxkES0cz9pcUcoyPK24ctP0qfO6u2iRdvkquezCMcPLt3Yhaw62Tjl/8v49ixfO
7ZGSuYFSffr8Cas3L1l1YOrCHWPGzGO0PhJTL9++7IC1qKdWTGwcWDVj5/YJmzcOddcrhiyoPp11
8Jm8pdZMr5jR2LNm8pZDM+at7RqsNcR0VpRMY8ZmZ28aWLl/2ob9c+asGRjfk9NoK5uI1VV5aHl+
yYHWvjUrtiycO2lqUSuE2rOP+kPjxxp7di2eN7M3m7BhOFrcO3bHtvkzpjXqaUoLxmZPGbd22YJ1
h6j1h+ndB+bv2j9vzYSV3fnmvrWNbUuM4XFxioVoNFwo6MsWSHu29RmZzOzBwU3rhpcvbk5WjXIo
mg9nuQRTI/tlqNSLzJZ1C7Ytml3OxaMea0HIrj1l4rj5SqWUqVfzs2d2bd08Z83+4cXbu1bvHT71
oqVLZ0/U2aSaFH1Aqkrhnru//dmDL527fEdPVCq7c93xtlsxqcguXvWoeVNeIYRGrMKasYe7x7Gt
K3Yd/+TNz3796V+P/N3Iz97/+fl7z5lYHteXq9djRmefcsUjI+jljpqRQryRtfNYjPcJPfddeevI
b0b+8q2fXX/6lRIhV6O1czZf8OFjn/zl+3898lcjf/nhL684/ZLubI21Z7/5la898/XH5tSn1eIF
IyCFwXvnhbd864Jvbp+5MQtx2po+vunMX7zy+civR9554I0z15w2iap3BYScTxVilWOLNn/+0Hf/
4S9H/vGvRn7+yGuXrt43VpnYyvUOJMpVj4BSRlOglJtuhgs1mUC9QkQL9qADcheeecs7tz64UO9B
Kcu+wnC8WLRlS+5ykSzpnqzhzanuIsL5I4w3FAKFdXWfuflUHJl+/Mqvfvfh/zHy2//jssNn99KN
JIT3Lzj1rfvev3DboQFK74oMlz3dpWBG88RzIMmuytqpi5+69YF/+HH7V45/8eyHW2asr6SKoo+7
+8o7P33pkx9974cjvxz5zbu/vPrIFePVoUJY6clUe7O1ekQvB9DF/Il50Nqa0xy6YlNFGydYWc3P
XrH//JHP/zDyq3+867K7p5SnUpijHeq+uVs/feK9kV+NfP7Mh5fsOK8SwrAvHVp64EfP/3Bec84g
1d2VrEbBfWzN4de+9dzMwvgr9lz0zv2vrZm5Vk8Z3V5ZhOiO1Xveev69LX2Luzxyws+sWrjlvQff
G/nFyN//euQXP/ibr6w8ZUl9cndU64qoffFyzdfeU9EMFnENR3NiJ8a/knLeH0AvZ8JAxUGOE0qC
lEmFdwjZuDMZtiYjkIm3r0gip02iP8uQCd7NKQFZSfqluJfJAJKKQ8gPBSKmOyOsNYHDS8oHTMxE
p9u/tWXDuZwvmSS9KbcvnYB8BjJpZzJho1OASC4vbXYk/CEunculIyG/qy8oaRDrTPji85tlJbN8
johe1ieRVC+QdbCXgE9RQpou+hOyKxiOt2elzccjVCIqB52i3x6J+qOxQCIByWT7qihhBlJpbyLp
FkmKd+Vob4L1pwI0hFgz/imQB95rZt3Q9GJVkor5iajPFY5CNG7mPCaaACMY5l0kSdi9HlckTWTY
oEyZ+QyIQSvnM2XcwbwvQqVMTMbChRjan+/MrVG0J5CCRUUU0oukoJIzN7T2RMayALJhKuUSKSqV
wSrBj1VWBnJ5UzbgDNoAK+50FhJuay5IJHI2JBl3xSJ2mYhpniTvCSRNNnsAwjlTknEG8WN0+QRv
OAyQI1zBPPgy7Yt9+HmIh8HjggThy/rC7VmNU26/ACG5fbq3JwfFcEEkBfziwljgB0GNWJL4PQYg
GQkmwgHOKaCUI/H2YQYuAny0/TGGaEj7gwmPL5HEtQV8NYKCAAVBGtgEUFFIeN1xD+lg24lViYfF
SCCRbu+54j1+yknGIpBN22JBiIdAdoeNQCKTsuKDjNPTPrPY50pHfF4G7CnwhiGeBc5FxyDMhcDI
QNvICfB4yFAogO2KSkHS6eRCofYU21mQCY/oJOPuaIyMCFAUoZSKOKiUhwsQKQdgeZSNuPEbJ9Pt
n/YE/RCPttckLALipyGpQi5CZsMESjnlilktzmyGrriSmjkkmSMFVxqbImdKYfIqBfT27z4cPEYw
3kZrJFv0iYabluxpB5A3XvaNh255eGJzEu9j1IgkE7TqZnWiTWfHBdKZQAPxQASlLPr5vDNL2WOK
n9L8PIfvDFlsuRKpFYIVmmB5r6hEhZQ9JhJ0HIKaTyiF1UpUL4aUNERlN4u3vDOPdxhbhrKkcDHd
L+JinIOirVnNkjBsqaid8UFaAm/FmQhY6Vyw0O2hSpZY2pSnHSgytuCk2zPxO+SKI9vefeFrlwKG
LaCavSQwZ+279tUb71nXNbErP5Czcl0+sScgFwhMo4ZKpjU35jADQSNT7gDj7DLC4zq7ubwQWTVx
4wt3P3j21r1DQg9P5A1fpScziC2ZNvsKRLNItlQ3tuo4bVIT6BJbSAlRYkBLWnLVRCEAbh82JT//
2NcfueXCb+DopUWUjqZ5gpK9HH7ClCnBWdIlv1QiOASN3L62i0NX7ZqEH6+Ny1tivCsj+/KiJ0s5
6LydYly65KuI9mwtrMrOvOTIoX9lFxuDiBHQiiGDtuY1t6AQXAZC5YDUm64k2vvog72ZRtgUybnz
vX6VwkfIdNSV7AvoGqRJcyTqyXfaRpxgUx6hO6qI5lgO/KI5UXC1p0wRIKdYGd0ujqY9rcoXvxxp
/3gE/6sEZY1kOJeNtptpp4sj3YJTRsr+gkbIvN3FWOyCxaE4yKJZLVv1E5OElWRzkocoY3GKTo/s
Sirtc8iDNTJSc4llO6eTPo3w4mvmrZAFnrEpkltRvJroizCEP2/O5kzYgHJI1ZLtcrG8W0ibM3Fr
Pu8We4CtQaZqZnpJNeuJxR2BHsq9cmxx2aL+3dvn7Dw6Z9muwUnViXJYwjGg6kvnI75syENha7Ym
RZNZsdoSgXw2yinuoOjyJVyhmCOQtmYpF1O1GU1Xub39NjbiD4e8wZg7mPCGy5ZM1ZYzwFmykAxJ
IRSRzrtShs1RdLg0S8CwhbLuWt7byPkqaXdRtJAsOGRLVHckFRd+rwrnIVk3ITsljVQxCCNlyCEF
qCIKdjl7TLL4cdzqIhMtIl51xcuOKOMKZq2epD+eDiZjXilM8llPS4gO8aH+tKvWmQo1TiSQNJnK
uNMFE6MDVbfJCBsQaB+XIDIRe0KxcDVvYUwg0+OK6ES05E0qHo5z5DSbiAVpxSaUrbxmzkiQYMwZ
wU5xDgy1smD3IbSFYaysauWxcSieWBuSRgpkGpH8pOB1SVZeMLNhjy3md2oWwbBJVXcQoVy5E9KO
58zZLlOs15rshXoLyiIkEdYWoczBvD0gehNlP4/m4h0xfIS2hIpBuuaVuPZg6pWcqbKH151UxidS
IZVO2zM4nHvyfIAtkf1l9wAFTtUeatf7Dl6GQdU8rJnzPCQKXkklOM5OUmaHao5XiHzJWTNsZR2q
dXuv4ckwpgALXp2I6x5Vcgo0JBRXe2p5pOiiFEtKcIQlV1RxpllTRANWAZprzx5XrJFNDkQG24M9
1vTSVSKr27MGfp6OvGRJq/ZcxYtlcg4HKdUUafmYki2RAWvalbvlsttvPH5jk2qWI0YzVRUsufbx
vRMTbyKale7QmZZTD1UkryG7edUrqm6Kt6dY7FPWdC1UKXh0ziIyJp5rzx+US1uiaog3vFIjVkIF
YzrWPaLkZFAT1bCB9zns8HaqFFAR1pLFZdrz79jy+M9un1q2M3k3J4a1PkKsm/NUQEmRXMWc63Lx
sl9hXKxkzmh2qj2zmE0oWlMlWzpPlnJEsWjx6+AJmPjzD9/06vV3LSv0l8I12a33BhUBwp1rqXQu
9SA7DIQlQrQzIBL904rrphTHTa9MPLLizLfuf/f7jz6/fHByJax2pyuqo5AFWncn6xFGs1dFU0Gw
BwxvouRtlX1oc04PsYJboewcDsmim8uYklpAfv6Wp791wa29+VYrXaNNadGBgUzBbcc2wFtzjCmN
t4aLRnQXRs4vpNyZRKEVL+g4YpljrCWOqi0HNd1d5K0SjpSai2HNGc6S1d2CaKfwRaohPQfxcgA7
dftP+Pp4m4NIV6xYJDjVls85MmpYbji4Gn6nuVLKjd2cQllRQYkOyYadVy2M4JEL0bIAKR6S6OIS
yVe9CtZGnX3H2Nf+TTo/cEfaUsaxoj1NV8BTjASKsbgejqCRaQvHmXH85wv+EBaGtWC07Auhkdte
ttQr1gY264Izr3tDCA6VKGXN7C7YfJ3JBlHKRW/QCPnwNWV3CRFJ+cSZg16UMpYJOBwhvJMtQKKG
Tcoj0k4mRwpCyKhAasAiNmx8xURz4Sx6Gc0ukO2rtMk8ybdcbMOhxzXOx6LjKt5UJuhGLytBUQ1J
NZ+/SJARTzrgivMOj0wGmFCGj+bloCr4pKJJ0UFEI6OXM/F0PpVjEzkmnm046Zo9XzQTNYcPkwvC
+yjWk6sQ7prbi1Iu2MM5T70jZaToDpc8kaqXQimzZo63CkoooEfDiktmzUzRVEaqZvyqqBLUEc2Z
QGRrAOVSs4eRijOGXpZ8cdEbi7rDuUgmEzZQyhFrMU02smQjZi1W3ELByaS9GYQOUGyIqTvlql0s
Alu1iGhkhApydKjtU8nEVE0eHewYUjVXRCIZzE2KBQs6vWThUMplJ9b1fMEnIyJRYO3oqQDWGaJL
wnrZcEjtS8kFUsVQRnLlBUdWskZES5gl7aKPKLr1iq/I52J0KqRbRcXEFRwelLIcFJWQpHhl2SN1
m+MNCKORe6BWJrlmQNF9Oc2blXxJjoxy5jhvSaieTCXCoZFFV0LAeGrNFXx0KcBiXxLNqbA9F3PR
bSOn7ayPzjhTDBQ5KONXjGBD5QCzRp9hG9fwKHW3jB3J8IiGP6K4cdTEETSlWYq6tVQELEcqkiNW
8GbLvozmivE2VnTwvDWDSOacbMlrtgyCUuZsQdGWQC/3B+st7KvAGaC3fD2audAbZLp8eR1zFvjQ
4A2/WPWJuJ6oZlxhbP/4Ckp7iqRw1ZnuC/LJ9hFdXg7Kol9E1bZnB3Qw7dPgTlyL78t0kjJHKGkT
nUF7OjFQU+25ZZx5w8OxJpqGPBoZ3VGJVAy/QbvSeUcSPauSbTWjj9BKKF+8g5bB+51/4gJ4i47G
rxhTHoL/xJFYg0yWYNJOqgrZlo3hIkbcSSsQLUKaJTjsd2hkLK41p6w6JDRy2Z6h3GWkbAuilwnI
Hd17zSvX3bm+OQGNTFv5MYnScLyIRtasKC8c6v6VlClL84p9d/3k5U//6bO/+6s3f/fMzc+fvW5H
K81rHq6ZKBbIimTVamG65M+ikcvurnIwU/AlZXtJsBg5ayRjDuXx+8Jx1MMLJBuFkBFSn/n6Ew9e
ff84aQjjf3eqVgnpGGxxq1GatbBR8ivtKU8deRzaVYeoYTZy6O09GCfm+UOlYhYuBfhyUMBnYS5p
j3YWEWtx3pzGJ3ZGd8GW7yA5aAqSeUi0X5PkUdaCJYOlkoGahjjKgfMwNPhkiDFhAUFT1Sxsys0k
CEqzsgWHQDnYJGR0HDkwuRNce8Czdibjbl+E4V8C8r9GOnGdKgQw9RTMkmESdWsQkV1hhLdrnE1V
LA3N1tLIdHswtHslq1sGXjEJFWfTsFQUSxY7FbZm1ZVRbKpsVQxXFKOrYVZ0k6yYIlgliw6/gt+T
SWfMBmOTWLssueIykTDMGsJbOc7CdqYkFz1YXOQpIpm2RbqgMtE+VG1Psp4UwnE9lZOtGewMgzG5
hiWmxxZyW3kHqkTFACuCO0tEER4kwSTXTIE6pjOigJSseYRz4PuKglnhTXIFGETHfmVKxokU0rke
XQukblAqTqrsyDMkh4/QtvYUwDrENIiWbGzBQqfsWtKmpu1q1qlXcWwEygAZhyjV2lAsdZbwMC63
YKVlB1ew6EjJmkU0cx3hyTSiW5oK1OT2JZok1ZRBsKu31UDwKDU+JCCyj5a8VJUQm161CEwJ2LyL
owg+56bzHqZmoZF6eyJ2ngIlA0LWqnBkqeCQZBNTh1zTTDUtlZa1WrX1Vay9hqWmmSolEAxgy0BX
27dqBTQVyojmjSrusApdCrQEK8dbWKF9PduICJoM2McyqitXdIUNR1AAgwMtT2azrnSlPRN8pQsy
LUiLUBEwF5uLsrXcY0p1Q7IPupAyFBDanJRcVHtnmYNnzSkMqhJGJJuAWVsASrTQJY9aJ4pqexa8
PCYFLVAXyKLsEFSXZNhLilmXLYWCqyabWSwFOpehKkB/2Txk2KqKqUiByJqUjiLxFhsJFiVlaFTJ
Mg8smrRoT2LrZc0hFgqGo6vlGKyaewomo2guVB1Kg9C7HcWWzSi2p2xWdVBLpkLNWi1BUQNFwebU
zvspTJEYdjoTz2MvbU9FTwq8OYuPVzxiw8vr1rQGMRQZVr4RCAl2phLCMBilIFEmRBpixfZc+F/w
hZdP/FhAcemGp4ShDKWg4ShoOTFKOZmSU1fNYtVdKToLKYizJqockkVnexZ8GtfHgTpT8A6uTFei
kmmH4jiOTx0xIZWgVvRhOMhglM5D0gC6P1AuZ0qsl8E20DSJbIDjgnzLLjdtEvoF60IcqDhI6S4F
vYwbgjCeCtJOD9Zg0qnT/lrDGVfBXY7U0csiRLPgNqxGe7paR1p3ZjD/IhIZEVyhFOhFcpizpXFo
74p0F4iiaA2qzqhGsoItK1s1zVGQbVHBHFLNlYK9gX/CBXgwFFt79g/JncWSuhSppCGONQSOOlgQ
4EahHzlTphUt4arisIqlRmd8Lbj49vlkdkZ0Yp7IKk4RUfEzROwKgnLEhCtbU/gJY5lScgl1T7nl
rxXdCgtZ/CpVJyvZKJ3gsYTCV0PQobWg3hUray6u/XigoDkF3Z5X0M6h9hW/Bkhl2KunnNksSWmQ
QBugN/JOugxM3SIUCamdiG0sWlgyUwykcJ1xhTsPdnZW/Gsjt69H8y9JuWCXW+5y3VUou2KYB9HI
KhmViaLmqZSIPsTwZLFl666AQQSxuVSIggKF9vXiMJYTXMFDoZQli4x09ikXrVrVWaySuRL6mgxr
7ojkrIqOikjoqrdUClLFQL5oNVRoh8qC1xhydbWgxDhTgjsnBijel0MpD0JXBXhUkhxL8aEY9rea
X2KALNjiQj4uUgnNWxBdSs2d7AlRQijH+tOSRRXNChq5yx7tHCVv4KfZnlNRRimLFlWxG91Wpdeu
FayZoi2b9VO5AM15BKQHVAQfRF9n7Xn8cCW3qPnVHpLvJrjODhms5rCmY70VpGFm8WsoWbSKzSg4
u7HDt+dh8fhVV/t3AZ0hp2jJIKqphnBECik5egxrC5tyyVGqEnzJwXSKYpRyGlJBCKXxk/RSHIH5
K6tbqLpFamGeDeqCX0UjZ4h8ETIlyKKReyyq7mnIrgrtNJDO9eVQyj12DqVcBFWBasncjVKWoNDA
9QQJBx7cxi5LpYHSMVV0c1V0BQSnX8JcaerWSRVL5jLJYPVTsteRgodBKu5YiYgo1rJsKaGUkRY0
ey09Q3au15SXTFUEjazaqwO23JCDGguDQ9CHRi6CLjhyMtFuiAWXWPCiNdoriYMHSrnsak+sjuG3
YEELaBjSsWmK7hJtV7E+E6xs5/JOqq2k2ctYBKCUS+ZK1Vav2cZWrWN0a0VGz7pros3A0Vq15zqT
/lRMzRNzcBtIxZUpO9O6GyvQHH5Bmq2pQqUADTQyellpz9WXa091D0Kvvd5jw8FSRNrXjjKVCqAP
eQY6lQrWns2gVvGr2G/bpnO07YwRGLs6JqAiRjAntucUerkzV5zk5GQXj+Kuh4yuYAG9bFjpk3yx
H+PEdUwwrAk2uR3EbBjxcmUPW3SxkildsKs80IZdR9KAKV5sxA3GkkR3Y2WAasYqGw2F/8QnYund
vliJk8EV6xTy6Gt8HB9EnWEw1IHC5pRxpGk3he2/x6b6wJ90pCrAFgETSQ7Lnfb+HELAmKy0r9ST
QiiyhFRtIZRy2CymiQJKuWaPql6ssUTc6u6gXLAVsDF3pKw5i4jsjopEWLKgiIdQyrjORbKEiY0F
L9YrKGXOkjZcpSJZUR3xRoht+gbyIFb82YI72bmYLxqZscezpnwGcoWgijUExmG+szkkj598BiLo
3xIpVjzt31xgwYH/RIeKpmxHyjiot73s0NrYZASLAPyyRDOWqqmik0cpY7ikIIP6U+xcyStjNYMj
KI6jArQLKXw1fHHBkjtxQCqB1uZN+QKJ1SRVIticPRWFYNPCdNv5hD0tRpReq9yP/TSgoEmqJg4/
WNlC89iFO3uKbSxiODl8zU5A6czA3pmt/p9pzy75L7PEYZeoQqFuKjWdWaRIpA1nknNoSA6alLmL
J5OSN6MGA0rAj0VxezJPp4xCxDENYV3prCVK2w0t0JKINGuLCaBplnKZ5LGFaZ607s1I7gbvqtIu
nnJyossnEf6CmUd4IqH6cy3zANabSZs1R7iYqF1IEnUY6obxNSi1rDUxGcj47DQ0VPPgOEupH5S0
NZw0B1mQRQyk1pBuDrBuGkd7A7ucqdprSfSY47SploNyAXJFyIs2DQsr1a4hDUjUcfg1kYbVmwum
6UhO8uu8R2mCXAMBmwX6JePOIgyRQ8rteXt1CRQZ1IQnlfZn6RM0AV9KxXIBBycKRxSosD6vEAyg
T/O2eGe4w/Ef4ewlJO1LILRDzJjbV5pgCUb3xTClFmwJTHNNbxPbd3sfiEttupU6IQ1AqQ9w8MPC
M5V25XA0znoyeV+u7kw3iWwRUlXIKY6yTtQ4spC1YqZrBzpswRLJiU7swHLOgU2kSIf4fIBlXUna
ES/Y8nW3UPNzhguHd1+G8GINgajQo5l6eZ+D9dgkh1Ow2YumKTpMpKGZA3R6SLPgqqYNfz4bziX9
qUI7UepVW6RkDuZcGustZQJCysfxbuBIwKaM8sq60zlPhvcwLEmJwPHAsBj0fHzBqUkmXrMohk3j
rBRW7lg0VB1VjZApyAqmuIK1s0Wr2oy6i29g/HFHsNgSXXHBiQNzO+nwmLDsMcqTYHwp3dvDWEo0
pLHP8K4U60go7cvLYruNYq6sEPGiIyKRMcWTkMxdFJQFe1kh6nJYkkIiH0gy3pjsxN7enuNftDFi
gFPCohyl8+44a01oHlrBUt3CZYDCgl1wG6Kn0L6+sFvDf2JaNLwab2MZ7MZWpuqWGz6tfOLCFhxk
RFO+4W5fv0qAhApZw0whOMqilDX0LxazJ2Zk5kyCQRabwWLFo8rmJNYouiVXd4uGWdJNompSsVWU
OucSkEx7r6gJU38G9YSVNUZjjNiYkZuxEmoazY6PY1jGjIyCxn+iwjrubtiVEmCxlRb8dI9Zr4No
JBU9IffYseDj864M62lfF7VtKKck2YUC2t+SzBNFlHLdGqpZgmmHzgcaKGUNPIxNMALlKslIWAFY
DawIdQcaI6M7i4hCxiVXVLX1iqaW4sxL9qxu0yrt+XdSZSKJq4criRVtDmgavEV3pk72YsXGm/0S
lrzmomAqCERW87OFUAmTMmvJctYcDjbt3Qsn9sLXPAoOcihW2YTRPilBtnOxCwRV27n8sUjwCHZ5
ya7LVgn54vRwW6Z93QNTHgvfhrPQ7a7gFyeYKWw8GA4aAb0Vwk+bw9pIsWRxPMa3Q913x2oYk3EZ
LOx4COMALLpppGGmS5CmCFbwyw2gsUsm26e+5AdsyhiX0STUGo5wFq5d5Flx/G7bGe+0Rw5T9gsp
/ys1/2spVxw6GrlhLrdcOaTszpbIjOIpa76qRAyJrkE0suzLopRlv4935hkst50y75CwD1DWKDqo
HFcW9q47bdV546WuVkorORsFew03Dxuf5IorZJJzVlDKvEfm3JLiDspkoHPRTNGd4lzxCnShl9VY
VAqHckFzxg+9MHEApqCUDazQfXYu5i06xqGUB0DtA5kmkpwnYxDVortedcWLtjBKGQd8rb18BaXc
b0uJjm7e1qpaWaSzt6tz7Q+UMlJxhcrOYMobT7ijOTtLOflu0HpAx2aBBRQdYBDeQ3Nuqmoq1swl
3YKJoJgN5lHKWXcSQSl3WwqaqdTejWPvRji/D70sevKyr33FM6QdDVwx3lFGMv4kogZKrEvO23Mc
yaKUVU+k5EhViSyKCROHSmgiVjGmPHZglDLS7ZJbjva+Y4zJaGSkbI2XLLFBl1qDfA4EzqTx7qLg
KRVcLAY6kWA5B8XbNclVYN0FyqWl3LmMl5J9ecaZkCGpW7LtUONIs4GIFE2iXFDKBesAIvidnNeu
kW7d7TFgEiLa+pCiI4W0p3EgU+lgJu5NoJQrlgKGpqIpkHEojKeY9vMoZdFrQrASxIqP8uUQhshL
fr59KqtNpu0ZztW+zmH7MhxmWbeqnUksDRPWTKpk53USK81MkaTRyO39/pAqWSnDG0Mvy2QSMVz5
AkEpREpyJmhvkg9m0cgI9igM3ZgPOGeyBNWGvUv3cpIrb9hCWPkJrghrD6KUS+Sw7KqxlkLSmkjb
U2hkIZhSMGHYMkWvKlhpmswhCVsAjV8M8JwtiUbG8IH+xU8pbxMpe3tOSI5QJLLtZQ4724kLcbaP
yphyqqW9Q6YdqbCuwvWBvApUg5RbHrVgoRE0csHGGA66ffzWSWsupuStMICGjWOwwhqlfZDGRhXt
tAh0l7eKTYKHdpErANWbrpy5Yv/y3gXVkN6TqqF2MSB3DkmhkRGUbydBdzIygnc6dq6YBfQy583n
nElMHt0mjXJn0o54EeiGSZKCfHs0OjFDvEYo6OXOgT40MuOpNO2Rhi2MBSJ6Gcfg7va14TGuSWg3
9DIaGStCzZ5CL2uOQnunBBETnRH8qLNYTDtyhpuVQEQvF1Ho1jBGeFwxdHfZU2tFeMUeY0AuO1qc
yWeQiSLZwt7H2JOsI8XYubylnZEx7OM4hFuHYsUAix8yWliztq9da5z4qQj+E9WsmPN4v21kMjNK
ypJFxPCLei27KKSzK7JklitWtTMXPo6jqGZ0JcZkHDJbQQ3LIwai+JS6vz1tNI76uAwuWSHogj1L
29NaQMBUhFJWI0bSkkER95pF2S2qXrkLuDJkVMhVTtgWpYzmxYCMrQK/ZXxNzMsdR3/Bv7n7AnMH
jsMYGco+JQUhfE77aTYGByUtI+b9qbg5pkYVHMFSEOxL98gOsT2xrKt9ckkhWow5wgQ4br/hzsfu
fXJu1+RiVFADLIqpauebhNwNRr+5LIKCpSjnzLKOzBSAdYHkg/7k1QCJfMkd4vogOw4bX1BUfFwu
kM0Hc0lPjInmaXciaQ2MgfQkE+1J5sl4FusCA3K9TrnLJpQgVYMcfvE4IGMleGInHX5tDOVgWUKo
WVQEa0zRmud9VPvq+vYIBvMuF1+30YGQ6A8KMa8U98mdvXs5fyzri1Y9JcOhppxszi3mnbTgk/CN
Wla+aReqZiZDMrRfjPmEuF/UgmXGKYmWsGSNFEjMSlHDRZc9PNYs+Ol3PuJ/zYmP/stfxn8A7O3/
Jh3p/89HtuQxfWBwRu8UMSWRfBKjsU+kCVoJKQzJ5J15JdAepQSSZZ1Ue/8Axl60uTudyjLpHFuC
RK+N47xyAKJ6oFCN173uhJuIYezC8JWxM4garCeA1UL5QpSJgVckcwjvwtoulzJ5ZX81ZeJZj5y2
YScPZsBR8jHty3qZqfalM60KDtWqHQspHLbbpW57tbFjONpNCwt/7FpVr4bhN40Byiu3T3exp4MQ
MdKlBIQx/uNwWPGIRUvOMLWPBaFq0Tvt6Org22BXJGWFkFTslm6RM2VKbq7qE3kINrws9gg90L7k
LmfCsZkvO1kVMg2XJEO626fjaqAIIu3pyhPbFu198f7Xzl+5aShOKTFaT35xaeCwV4wFlC5LAWE9
OTRv0cziOuOoj7CQ6AmXJKdAQa4WUkRbJm7KSkEDywjVzWAWwURiePhaGCM/jYULNq3OL8pGcVIW
o/jyd/3n5Mt94cuMWuzfZdTTTzJqsT8/0JVUqviF2bNdsXIjXOiNVTC3o5Rx8PEDmXbHlIiM5R7W
FEaQL3h01YWVZqQvW2YJLgDBhCvKhPK3XnfHd25/aF73lFJM7Ei5YuOwebVA64VimaiVMCm7cgKR
nw6WNb74tz2xqwCfrHgjAhp5Miiqn+dcuQQZT3tTKOVsIMX50lIoP8MhTjYzrmga6XIoBcjXTUxb
lGa61yEUPBxKWbZklfZl09p70AWPzLslNHILh24Xh17unEfBOKICmWw5uaolHwxL6OVRUs54IzlI
Y3HN+FUhXNCjBZrAMSBVgXzFRGOxlvNwmxfufOiel37zk3/64ycj91/18IruKf0pteqnNWd7ztya
vz1ldfuXOaONjPy/Ucps+3yg9tXyK361HNTC4I1CZFZz5r1X3/v5K5//w+f/8NStT22dvWWMMkzZ
sihlgxSuP3DFxy+898fPfnvHXfc3uvrnpLvHuNV6vhu9TNvYAIR2bDv0f/zdyB1nXDKcUkqpRspK
6eHmHRc/8NHTr4389T/98rXPTl2xp5bQxojdtDOSsfjP2X75Hz4aGfnlyGPfeGbH9EVDtNYVV2sh
oeLTG6GS5tCrvlqn9NYcapsTl0RSXRTScCkcxHGcGJfvK4SMVPuwsxy1JE7bfMaz97xw8Z7zJupj
RFNad9BdHqnXrxok1z7LiuTbXiYkBKWM8DY2C2k0MuYe7cQVsntCkghh2oaiZ5sRQ7LlSg6mL1ww
II9gmhuKVjGgtaO3W0AvLx6/6u0nPzy+dN2ErCCEsiEgKmS16q7lkxWUcgmEfmfViMtyiEMjF0wM
7aREr1B1yxgk85DFIUEnmWpQRiPj+IRSbuPT2pPN4ydvTqGRezOtk1/clxsbcvLxUYxa7CSjFvsv
Z9TbnWTUYv8uo55+klGL/fkBLEtFkpLcNHYbzprDEgNrop5EteSVtZyK0TXjCqccwc61OcJgq0Q4
w6NLDpH1pnh/Jklm/abw5Rdc/sj9jyzrndZKyIUQpweYiouru8U6yF3W9gmDgknMW2KKl54HjtVE
+E6L/2KAOYD/ZMVQm25zsgmxNRDdAtktEF0PgYngnQrBLluobvJtBf9uiK6B4BIgZoF7PgQGwdkH
tjlAInOBmAfk7Pbj/hWQmAe+Arga1sAaSK2E+AD4+sCzAnzrIDINUuMg1LQIDTNfNYk1szQGmGGs
4yBRgxidLPHZGlYZoglrz3Zm4b1sIa5n7WkvuPdP3fzU5fdfuv2C1QPLTj1w8d/8duTmUy+cXx5u
hsSqrx2X6v72RHztffl/quP/V0q5FTCw0kxDmIIEY8ux9vySocVPfuOJa49eN39wwfmnXPB3n/3x
+q/cMK05XfSLaWv6kavufeX2Z8/cdvD4ntM/+dFPbrvr3v2Dy4bcEutXKI+IgXHP/L0vvvjmH/84
8sjFN0wXqkHgtfjAE3fd+/id96yfsm+MPOeTF1996d4HT123xdeeyol++Prvvv/iy3vXbtiz/Pjf
fjbyxHXf3DhhZk9KqUe4Rliv+DEXi/VgpUAUT2AYLh0LVaTzc4/+QBnDcrl9mfpM1pShbRRKee+q
/T987fN/+uUISnmsPDCcaYzJNlvudlguu4X2+U8k3z5Xz6vpHlUgRMaOiZivJxsi+tonYUmah2gj
IulkTktqUUs0bU3SRHuvYPsURhfblahgSSE5mQQkRa/ERlQCgrMnrnz9+Y+PzFs0Q1RLuVLcFu9L
1fFT9RN61F9ptk/Az0Xav8iJdvn4lpfjPILol9tH+TxiI6IMZCseCNGkqLlzFISkaCXnloteWrQl
CqEirhsOn1Fwfzkdf5lRze8koxY7yZfbwP8/GLUaJxm12L/LqKefZNRif34gAcSFO7/y7kOvjfxs
ZOTTv3/jru8u7Z5X9Ei8Obtv4yl/+Onvf/7up/ded+tHT3w48ruRF299aFn/9EqwHIbQknGzX/72
05+8/tkbT78z8g8jLz390prhOX1Zo5ZQylGx6ZW7/GrLovU6ikWyHUkwaw+wjR0xan9OeiyYuxGs
i0BEOheJ6TIlxpDMfpt8hrd8YahxjCws97IzINIw+8cH8xe5Spd76/tJ/rBP3psx9udLM31oW8da
Mr0rLu1LqgfS+s6IvDumHk5UN9rplj007M+cHqgfIApTnKmJtvgBh3hWoLTSo8+CXJdNQi+jkb8s
5SpEXabE49959fErvjO/OL0/UGQhUs2Uf/HWzy47dEkP1zUm2SjYmFqomIMkQOiFZ77/+FW3LWlM
QCl3ReSqV0LQyNiHO7+M+mekk4xy7r/LqLZyklFf4f9Y2meDOfnO0W3ZzacgFoGw4OGz7YmRvMi9
19z31O1Pz+2fF4PYkjFL/vLVnxxbc2qLL3nAdsaxc97+4KMzJ2+YkazTXilhyx9advjyfVccPnzs
449/etW2w3O1rhAI2xaeido9und/HzstAdKGmfM/fPa7G2ctYNzBXfPP/PT5vzp2ygE9S/mBPbLp
sp88/9rZq7f0ZbRygKoF1aJH0F1K2VvA9omglNtePiFlzLxI2cpX7SJWP41AATN+OVq6/Iyrrj1+
ww3n3fSjN35y+ppDrWy1J1psf+/WfI9Pae/HOLE/F6Vc8LWPBKKOc+Z8PzPw8p3fG/nJyMgP//7X
3/vR8XWnaURWdqQWjlv41pNv/fLtn7/+4Kuv3PXCHz/63T98+Ied0zc1YiXRQTeyzfN2nv/Z27/4
wauff/LOr0b+OHLx+s1z1ELCnqC81Ff3XvKz5z79/W9G/vFvR37zxAdXrD0ihzQ9Vrzt8GV/cf/L
f/393438YeSd+187b9NR2ZHhLYl5/UveevSDO8+7YXZ5LAGR7UsOfvTQK5fvPNpH9ytetStWnMj3
lzxq0a2cpPDP0/ue/Pnvf5BRzfW/nVHN8iSjFjvJqMX+/ADrjM1oTJnZnDosDx1Ze9qv3vrljce+
1khXZa/wo7c+O7Bh/6Et63/x0Xtnrb/48v03jfz00x3zZ/D2+lmrL//o5WeeuPMba+fuQH7781+8
8eJLmwfnjssU6ym5HGufp10NSxWH2CDVgtdQXLLmofvz1a3h/L6s/ERUuAX8Mxz0FEs2HA4GAr6d
EDvLIR1IyKdEhaMR4byUdqdFuBjIfoBlmezd0cqNTv6bjsTtZObiROoahtsYJWcB3Ai+uzzpr3sT
34pSVwdSyLNu+W6IjnGbpkXJW4PGdQ52rMs+ZLfcZmIf8BYXxfix5sCwiR0CpmyTkLpFQDpHZn3u
3MUX3PijZz5eO2Z5M6CwED286eDbT7+5dPLi4dJgX9iQIDGYbYnWfMRDf/fp975+2sVTpa6an+uJ
qSeMzBtO4d+W8olf8oxy7r/LqLZyklFf4f9YVAuFFbTmQjsneSddCutaRBN8AubNiDlO+bhHbn3i
jmvvHVObRID3qqPXPnTVnUt6Zr7x5HfP2X/m2m2b3/3ko1t3njM1XsC/Tu+d/extz22ZtbVUar3/
/l/cdPjsWXot4kyW+cbP3xv56rHvFOkcCXDzed987cE35w8soknu4jNOu+fG6zfOO/vZez655Owr
D207/bdvvX/9qWdO1RqNGF0Pi0gzXD5hHw0xCBXp/B5MJ3ikbBdaHr0vXk9AgLLmm+kGDiRxcwKj
/Q9e+PiSvefXkkXNTqGLu3xyw41fvdD+Na2jfeUnzaupHpV2cmlzblAaO70+u5fvnVia+OZDr/7i
zZ/MaU0KgOPSc7/6ra/fv3XFrsfveeaRWx49tOHwu0++d8fl3yqmSmpUe+HB1375g99tW3do+fwt
b7z6GXLz4UMcAO2X77/x0Y+fev6CHXt76xsvO/+pP77+xleWLkvZpH556lt33ffUtV/bvnjP4vEr
Pn3lx5+/8fPTFq5U7N6B/pUvPP/Tm/ecMgWzMtArVhz7w3Mvf2P3gT5lqpbobvlZ3Rove9snkKCa
v2xnlPIXA9WfMMrFJxnVXP/bGdUsTzJqsZOMWuzPDzCOaN6RlgO8D7xJSDx72zOP3fTokNBvhNSP
X/nBqpkrawL94/fe3DXvyCA/7bPvPnPWptUJkL9724evP/HAwgkDcSeT8Yj33Xb7A3fetaFv1nBS
r8SFYoQt+jn0csnG11DHpCrY+DxEeHtqGphWOsP3EamvgWuqNTcRUsGgH718GOiLQtW9EX6lKbgc
TPudyXvs8lUQHDgh5ZsJ8VSw3GyNfhU8OwHOCYZRyrMBvgZe9PIxgK9afUfBeRbYH4TsHRDsd8B4
n/Vmj/xVK9VrgjrAN4H6ttuY7c/1ggulPAh0ySqilBtWESnYs7o1DeCfP2f9Hz/43e5ZWweTFQYi
377pvqfvfnLBuHlyXDSsOfRyFLw5iF172W0vP/P+zinLumNSxcu0cPjppCQb2z7S2rmmwBe0p+Zr
n6iL7fVPtPt/zqi2cpJRX+H/WLTOT4pPnI8huBjOQeWd+ay9fb49Cd4zth/98KVPVsxcp2ZKqN07
rr77rgtuXj9+yetPvPS1C69euWn9R5//8ImvfK3HkatzXXdec++Nx24qxkrFYvOxx5675YxzJrAq
ExXRy6tnnPaL90e+eeVlf/HGq7985zdb5m6v5ZpYyN906UW3XHX5grG7P3zxD7dec+ea+Rv/8vV3
bjt+wYLGUE9aQCM3IlJvooGf5z/rWDmB3P492IlZjwsWVoW8ZKbG5nr1gMa7uFq+jl6eP7gA7YlJ
uZmp9MZK/YlKX0iXIYENwHC2f8XXvhYfKSMo5ayVKsbb54OKfjEEoW1zN71w5zNbZ63WQ+xtN95z
7WU3szHpzq/dd9c1d2tJ/f7rvv3wzY/wfuGsrWe//tT7h7acxWVKFvCvXLb7vbd/tmvK5ALhOrTx
rM/e+MU1p545pVA1g75+xWV/99rrKOWcS5vaWPyLF16+57yLGmxPxJSc2pr13e+8dttZ51X98enT
drz5xm9v2r13Os16POUZM0756QOPXbtpB0pZjja7gzx6+U9F3JHsSQuP4qSFRzFqb8Z/OV/uC19m
1GInGdUsTzLq6ScZtdifHyjHhTm9M5+89bHff/KHNx55c+RvR15/7K0+qb/JtH7w8ofbl25tiKlf
fvTaxslHGsmpP3rz4b2rJ4/hV/70pZHbrzk6UMqoqZ6sx7jz5huf+PZ9m7pmjIkopShrhCgpkFPD
7bPr29eeCurFkCETOcGRHgeWpUTynqB0LUTqvliZDKk2Z8HlvhkyDzqLy7JptPAwwFIf+S4IL0Fy
jcV6MJE8nswvB7g+mLnI6tsGcGE4diAdXmmFZyD2JIQPA1ztCp7iIraZzN8D6gVIj/XbJ0fdDxB5
ZCgEDSc8DdnXXeq0LNXnDQxDdggynZ9jKp42vIdmyXwC4jGIPvXEK9ddc1vUm6ob3b9/9bOrdx6b
znZ1+Xg9oxVyRi7InnP4wr/67k8Ozt4xgWmgkTuXRMSUhF6WLfQJKX+JEzru/ExolHP/XUa1lZOM
+gr/x1K0szJkZDtdbF+emWXtecbDonFQwUd3n/PSw6+dc/AinaoKSd0B3lu+etfj1923btziSa3h
hDPI6cqTLz1/zZrD3fbs/nWHH/zGo6evO4K5od7oef6F791w4IxxtBwjeA+k927c+9g9jx3afOzm
S+/C1vvwLd+ZUB9DguOKoze+98IPF09f3Fvqjbq4hjLupy++/I2zvzKz2OpKMtUQW/Tlu+Ml2Z43
CKXDFzG542WnVHXJhoXF2MhBjm7/NJQJQhCT/qKhRa898Nrpqw5OVIdb0QJvxggtNr1S0dX+9UdH
6NKJo3wsKTKEUE43jm0/75Pv/fCD5z/660/+euQ3I2dvPy1hDd12/V2333A3Di3fvPqOu667R4or
37r67m/f+GCD67rlstvfe+4Hq2dubKiDUSI/d/LqV5/96IJNG3IAx/Zd/dqTn26fN71FJQFKs2ec
86sXv31s5bS0o9TFz/jhUw/ffvyMBt+bdObTXu7p+1/+7s03ocor/esfeeE39xzYulLNW/w9fZP3
//q+u65dsaQuTBZi3UNhvs9PnzRyR8on9fpl4X6Zk9b7MzOqO5xk1GInGdUsTzLq6ScZtdifH1g7
aeFv3v/lpYcumtqY1s33fPeBV1DK/fIA1lA/fvtHO5dvL+RDn7/z4pZpZw7zC3/67uP71k7tyy/+
9Ol/vOPaY1P75Jy34ILkg3fe8fSD30Epj42q5RhXCNNKiNLRzk4GVYWt2Qhoho9FL48H6zIydZdf
uAJ8rWCy6okoVgd6+UZIPeQqraLzQ2aYADDPaX0Fss9CZCnAdq/v7Gh6HcBV7hhKGZPyRZH4rohn
DsBjEHgKIijl672x/aR7IwAa+TlIDrrNQx7LbRC6x5rs90PJDA9C+FnIj43Ee9y+f1PKnJuinVQQ
Agf3H3v6yVcbhZ6LvnL5Z4++sW38kt6gNBBR0QgkENdffPOnb/9434ytE5n+mp+r+th6QNQcWRx7
6n4FU9X/J+WTlJ28cSIpY3hkbDkMyxRJByF0zr4L3n76/f0bT+s1hqmwGCdzKS99YMvpnzzx9srB
eS2pHLX5lErxvb/4wUULd5YgfOnpV/7tj//+R9/97G9+8Iff/f6Pn/3oZyO/+/u37vxOPmQcP3TV
Oy+9s23VtirXH7bmlk1Z9MPXP96/bk8hqx7Zfu6rj3+wa90ujdIC1vxAZfrnz7143eEj44VCK0HX
wpzuzvQkygU3XyBV5E/VXHaIKGXcEFSVSPCqV5aDshe88/rmvffEe0fXH+nNN3SCLfuk8ZmGDEk0
cgnDMinoRPtkuPZ5Fx5Z9KmvPvDWGw+/u33JLi1ZuOS0Sz5++ePTNu6PmQPf+Ortt1z7LSGpfv3K
2+6/6TuFXOnrF9/y4NcfqTHNq49e+9F3f7h29mYuYfgsidULd7710qfH12KRCrdf89jrT/1w3dRx
gxLtIYamTjrrx0/decGGuYy3Waen/OiZR++/5Nw+bUzCkYu58g/c+uQbt99W9rhbY7c+9crvHziy
e3rSCyZ9/JwzRl556eb1q6vcRDU9MC4uV2yxik//8u6LUXn5Txnlvj8bo7rDSUYtdpIvt8kvM+rp
Jxm12J8fuP+qWx79+kOrp6yIQiwE4Zsv+uZTdz6LZVqDbn78woeXn3pJk0tzAWchOD4Gxk/efOzg
2hm0eeDZmz97+5l7ZvTrUghLRea2a6556ZFHNjRnTMvV5WBOCeX1JCdF8qorpziz7WtEmnOSm9YD
whgIzHbnLw9IyHKIroLEePD2g/0I+K9yiOe6qb3gXg1wvjN1f0i7AvwLAHYEoxeHqANAjAf3RLN3
IsDuhLw3Kc0E262Qvx+UGeBYZAnodkeJIL8Bxo2gdBORPk/8GQd/L0Sme81jrfAcxD4wKXPC6SEz
MQNyMyHfNEsnfmlKVy181cGUbVQWku2LemXU559+Y8+WA7/80V/ddeza6VJvV0CokhQBrq8ev/qt
Z9/buGhrX7iEtMKK4cp3fuZbJIT2LFAOSbMJ//pci87sMzTS2bP8p5y08ChGfVX/t0O1UJ3dF1mI
lsI6bc2i0bbN2/b9F35wcP2phWxFjutaqph101xIGi6N/9FT7125+xw5nPeBbd+ppz738ssXL9g9
7BZ6hF6kO9dVDBe6u4ZefeWdxy67blXXsAsil5x1/UO3P7h+4bpxpRkkRAbUnu8/9+55p3ylRpVm
dC966f637vv6vWyUcUN815rTfvPqe2es2NiTkuoRpuxnq0G+GdUVZ/6fLfOFi08im6i6t+0p3tSO
ye35s9wcjs1zu+e8eOcLF+08pztbw6yNWi+6GNWaFSHVHTY6Z1tXIpUTs7vlF/Qvee/Jj87c/JVy
vkaCd/2c9c/e8+yupVsyztgtl93y9F1PjyuObTIN3sOEIXDj2dc/eM23C2Ftx5ytP335J1fsv7ye
a4YhunnW9g+f/uSctes5k2X36uMfvPTrKw7vFbwOu6U1f855f/XKA5dtX+gHdlCb++6373z4qouL
uXrMhgPFwPcef+c7559fcbul0qJHnv3Va5efs5TDfK1OXXBs5NmnblqzsilNLVJjq/b42JjUMfLJ
vHxSxx01/ymjXHaSUU7832bUy55kVDP7fx6wfc7qv/zgV9cfuwaT8qTq5Gfufv6Vh18f0oZZL/ez
N398dNuZPVJeS/gjoCWhhFI+vH5WAhoLW/s/evkhZPvCI1PqS/7izTeff/DB9Y3pk1JlKZDVo0wx
I6KUdZKqBIR6tGx4lWJYVn1cFzjQy8dtmQtJ5vRk/bR4dXGYnmwNngHBy63cJSHxPA99mY++Lq7c
5mIuAOdiMO1LZC4J03vBjkae5gihgvcklf0Zdak5cB/ID1uLS+1hlDIHoNnst1nKd9iq/d5E3ea/
HbzfhvgmKbMsE3gNqO+b1fmx3ASnfwqk0MvdNrXLqjQdcpdLrbs4lHI9UUYpW8F3yq4zfv7D3yBn
LdnZF9dUc1yG6JTuyW8/89bt19w1Z+yCdd0Ll1dnLShPHJuvd0Xa122s+zXFSqGRu0LVP83IBReL
jHLxSUa5+CSjvqr/21F08iJkiliLOBjWng+Ct5KuvP7g6zde8PV1szcOFsZObk2f2JgqRBQ/hCOW
xG1Hr/308be/svPU/au2/eCzzx58/PHFbN/UaLGQLDaZFho5BlFJLDz7zMt3nn3BQIKOuZhZY5a9
/Nh3H7vr0QXDq4b0KXddffsPX/n47O2nx8whzm/ce+2j33v85R2rtp+249w//nLkqRtu3TZ13kBO
603LaORKgGtENJTyP1vmi6R8kp5wRWzPGp1su8mvMjYqZ8uqQeW0NaeilG85fuO6CSv62vNzZvpi
RQSTcm+02N53YaPK4TJtoeOQ7uUGX3/once/+cy2xTvVhHF87/Efv/Xj47vPjIDv6xd//bHbHpvT
N7uLa+Xs6RD4rz58xZM3P9bP9hQj+rcuvOOHz31660W3z+qac2zrub/9/t9ctHkrSnmgOPfh2177
5PknLju4e97sc79x0/f/6cPnrty1JOsqjSks+PTJhz5/9rHTtx1bMG7Z8w++9vOPfnvb6adLJhNY
1HMve/y3D9/13YvO7hq7++DRb4888+Q3N6wdKs+vsBMarlS3J1f1GxiWT+blk3b+X/HPg9loRrn1
f5tRLj7JqGb2/zygFOW2ztl439V3/frtX7XPivvlyMM3PDSlOLGVrf/6DRyrL5xaqVdT2SSIzfi4
D5589KbjZ0/VVgaAG6urd195+Y9e+uXffPRPI7/9+29d+bX1XfOn0X1GUkLkBJPzxlVruublMXEo
ZloJqLJfMSBcs6U2kNzOsL4/1bM72pgekfptiTHgn2KP73RQ+73ikbixzy/M9Cf7wdmwuWdkuU1J
ba4tniWzQlioQXpqrLI0VJliZk63V89w1Loics3P2Vxh0pfc6e3fExhqYDVqZrZD4Ew7u6BWmiLz
XyWUG3yF4SjT5UkWzLmKnZE9qkjKGskbHlHy5jgiFbSmSAjnIDxDHDvy/l/ff+43hmtjylxFScpu
IFfWZvzkkXd/+/zn//jGX4787cgffzoy8tnf33jwsv5ERbXl++L1oXRX1WOo1v9fe+8BJUl2Fuj+
6SNNZKQ3keG9T+8qqyrLV3X5qu6u6u5q77va+5keP6PxssMKdhGwwL5l33mwwHnAPmBxj8O+h5HQ
roRA8BBCAgl5b5FEv5tTo9JsSqNGYqTZGfqc71TVqRM340bEje/+f+SNe5X/Wco9HZdCIqLPxdv0
uXibvkv1qqMeNXnIoly+EjW0kJSHdItp/tJbf/ELf/2FT/35p77xoW/c/uLtr77/K//pDT+3u72q
40ojqv/I2Sfe/wfvuf3xr//SL/7K8tKuw+LYdEjneq/tFZ2IzQNXNtu/8p//639+5M37S105yYch
sGvgzC//6H/7+Hv+4vanPvOZd33hLVffOmPMV1KNBIAaT77h6s9+4a9uf/4Dn/6//uOvnJ05OM41
6one0N1iRCrhciPh9AZavGCTF4fJvS/9NBdnesVGvIRAlUeJ1M2Nax/6ow9+/J0fuf2Z27c/d/ur
f/nZn3v0JzaaK3PysAL5BmG0E3YxrCIvF2NFFVMLLkYKqcjLP//cL33sXR/7yt9+BR3yh97+gfOr
xyhX4jd/6ld/66f/y8GxvS2qKvkZJ6b91MM//qe//Mer5fkCpIcL7Tede+a9v/bu3li6T97+4O++
/5E9J+fFcgxYMzvwaz/277/x/n945x998e/ed/v2Rz/wk9fPKwmnWGj+9r9729/+1u984r2fvf2l
21/523988OTDU4w6J1pRzBKokR8/c+5Tv/17X/n87S+i+v/xu547cGJAmDKTzeG4MpY2kIu36DPy
dmjcx7aF++hz6/dNn4u36Wtmrz16Q+KKGbPJVAWMz0FWDAp8gON9jBqWBF8BxbaU26dF43akI7hK
VTKTAZA8LYQQwqRIqFEYruY6fCStJSkLqLKXVxO8lhTEBMXHyHKQr+NyLwcMGVpUl8NKCdJlyOyG
+BokNoDdA1TXmxt0pUcgPAzBDQgdh+QBiOyH8KQHR1Iug28wGNuLFVZdKTJASnGpBmQXk+ddwhjk
LoK4CYwdoKq4EEuxRJI5CNYG6CWPVMf0TQifgVCFCJuY9z6IPNibAjVYchNVn1APSGpIF/2y8vyM
J0qYkoKkSdfEtIUybg7SI7mKBJmkLyVnFTWjpDxJFTIDUb2bKLcjJhUS1LSNPNubnyysDKZLNdxC
SavuEgdTjRcmGXlhzpHefGBb73H1OfeO9F2qVx1FTFaBLkU0FCmrQdGIKKiNdfgBJaqwAZbxM+gP
ndA4P0tCNg+ZreV8UO9YzelUgQuHiCFg21Co5OpGzDYwXXKLARdRMlplX4oGYPEC8jLtqZBQrFCM
kyMlv6aHbQUzivGqmc4yWCgLFuevGznFLuglXJTdOd1PoQRO9VIoRt6K4r/53rDyIlREJWyowApA
oWOxI7riExh3gfPSRlQV/KzgJstxXezNLpbq5ivtpLU1+mLrmbIe0s2IKYc15GUuIOkxm/bRHMbJ
ET4JBDIyOkbOS1YyFuct6LiEjMxADnVdvIeuxC3Vz9OQE4FhIG8F1SFywMQ0HaLtGCPHa2mXpAbj
KQA8UL3v+s98+Hf+y4Wp4RjkJssLH/79P/hPjz0+oHQLAU6LGbSPbcfJoTQTcMlpojqVzpXA7QIp
HWuNRzNDWEwlqlqs1omKjivTZ9XvW4LbBX9A9O3utQeU4nwWYsWEVk3YzUx5a95SFEH02quPQbk5
asRWkC1FSvV43QwLtRSKMmrlaKOSUFFQmYNUibDUACV586g1o6SPirIJb5oOZ42cVPexLASrXs0G
lMrRrF8qpcxq1hn0UVVIGhiv+pjevRFVkLuLAVYIFySc5sIkG8qjW6hCyCiCELyUGBb5IM/ispKy
tr7drnn4MjBDbqEJFO0lFVykU3o+JpdAsoG3QGkESyOEXQQqEckk8WzLna8CupNTg2w1SkiJpJZJ
GemkLkcFLS5TGTKfzHIBOQOFpk9bKAzzkGgEVJt0ChiV8+W1tD6AImsgmyHTcQkRSNn5OroJdTeN
bsvnJ0uVyiEdBci9eYFfkLL4PFtSRj3HC1P5/fPpu1SvOhQ3gwzVSBUlN01BpjfnOsZTkJf8XG9C
O0xE9ILKsLq1cp0I2VpA0zA2C9FCmiVTjAmRhaCjBHQKWA3UFtHMRziKEKuQnk7qvYl9Q5aBxy0i
qbpquqeh+fKyO4OunR1iSqGh3n/ChBNPq0GTAs70awgUCFsBTXWLuldGLVYGHv3xHVHdfC9UxE3F
w3NASR5ua5UQ1MHoYRlJ2YpI1bih+VnUi2cg3Ju018Og2wche0UL5WExh/cKFmFLARnZ1sRVOyxW
YtpA1hQgaaY0BOnO0Sj6SRkmOqKYrkRkEXXhcUPBpFqm0srWeKAZKDhhs9mbziKup6r7Jo9fXjiz
bM3s3X3p//n9973j3//C1cnVBERaYuXvfv1P/vcH3jyqjw9KwyNUC+UotYjUjuvFVFUIKEWMbidU
I162klUVkpY7J7sFRG/aDRf94mu3PcHFd+HF27+YPoe+7PTt7rUHVFMSMrIdUwQXJT4/XawVkpGR
VU9vzZvet1hBtpHUC1Cwg3aRUPQgp3hMFiQ9yCBQ+NBIV4qEJLizSNCPHnjwfe/822+g/P5Dn/3q
P3z+9sdv3/5UL/n6h1//64dPPd5VJpCUnYQ+EuRm4r05ds2gYAX5XiIZVVDrUQhWjjJWVkFeNgJ0
b+mzsGjish7XkZR5QhXjOgpDLEyqe4WGT0RSHgBWjghiiMsREqICStWlljwGYjCsV90cX5BFWu0G
uRqk1RCzuzX/7j/76F+/73Mf+fDXP4mq95GvIz7zsU999O/+4eLatWlnvouXplLNInBDUQdJWSDE
MlNBPztRu+QRWmFrAHe0VIkJoSYuooy1GbN7i2A+/4I1crEEzDdfGOmFir3QCRHkEN+Mnfvpc/E2
fZfq1UdA7F2srTUdUM8UUXVcUUIiigeR3V5YAwIKqKWZ3t486+OZJgOJVq5YSehhH6Fwxg6fUYeM
HrKQlw2XXgoUC1EhF2aLEG968sjIrEtkXD49EhOhVIl0a3G5GOEqhKj0lgupov+UUzkZi/Aeubfc
MtZ7LoGMjISLdGz6UTisoL/RH98RdP/3VoLwS8WIUYk7xaiJqo10zLmpYtzUME70FHpLw8X0IhJf
xkG9b28OlucnJJJ6k5wpZtSSMYVGAa+LLSdtJ2agsFp0oYCDR91GpvfqM8oYKA5jZFxkAzRKGlCq
irouLYLCESEDKTOk6piseEQ7ZDRCIg0hNVF+4PSTH/ydv0K31Yc/+I1f/eU/uTy+vFut5TyJQbXx
F7/wu7/69E9MWFO9xf3cTDNZREbWXflavmXGiqY3r7uzPKZJYRNJuRWVkOtLuN2MaC38O3xxt3Ud
+/65zfZzhj6+1QD+ZfTtbpu+zV57QDHKlqKKE5FQp4pcXHt+wV2UwldDz18nF10L20OpBgoGewMM
InXT52g+sRpzqkTVCTmoRQooVHTRKOQxwmY906ioraY1NFMdW+7MHjJmVunO6fLew/pKMdvmg6aa
r8jZkh5g0R7bbgOhY6rqlxugtFyaGFE4lOfGHcYnVEFqgmZ5irVwc8rXGYJKCRMtL2s8v9Bhb4mB
MMdHChLBlMOC4S2U3GzVJ6ioGhGthpmOW5ZAVUA3wrbkUzUXJwNdA3pnYrAqjXesuXlneam884yx
45w9v78yvGa15mKDY4Gq1LuX7HK2YiedMnB1r9QK6hrk9bQjRNUUUARkx1Kdmt/eWpMChcPPz7Td
e3MESRnp+JujL54fd4Hxz8MiXiziF9Pn4m36LtWrjq2YUYCC5ufrqWIxqssBXvSxire3iAZqTqWg
Uu81s94U0qjDq7m1MvTeb3ZCEhXnmaQ4CtIYoI8qliP1rYkixZTJxbW2h24AKbqzHbJYiZRr0Wpv
St8AJQDZipQaIafs0w1PTkXdsEvpTaobZLQApYBpeIqa20Q4mG0HLANdr5CFNP0dqUZtpADVKyAv
IzPKXp6HAgek5GFQj2LjsuzrrS+FkN0k8jKqthng0cGiyMYIakjKsl9WMbWZqSNHI0VKQFUiMmoP
CiT2OBPve/vffPnDX/nqR752+9O3EV/4uy99A0UJn7v99t9459r43iG5W85Xx7RxJ1VEsXY1UxvE
bQdYCVfLZK3or9jeEk9b2SS6U+iRkCERqYI/PJ6u1AMShVpm3Kr55HbIqIQsBnL1kFz0ssVYqZau
V8NyBSk7oJbiZd1FFQMC6hpRVIEOtk+v351tS/bR1wy+b/o+dpu+zV57gIMzSMqq73mr+oV61GwQ
KE+nG7iJTDRAmJZHNt3SVjzIg1QnWk4YZZqM7JJ1n17EUVlmMFfrTQsbNmW/QhIcm5KVOCfgVNsr
jEaMMghDfgcZmfFrUqbIxg0JNWJcroCIpGxHTNR86yC33TpqcCwmbA25H/YUB122Cobhsoeh2gan
FlFND2MGeeRlZGQEG8rLMdb0UbqHRG2xGVREH49CjGrAKPu0KtaoBZt2tMSCgNzXipcGQR4FgyEc
NlZUMAMFUAO9FYzYRiRXD2dLwI/0phhV1ZBecFFaVC8BW/OIjYCKbgYmJLJhycrVcl6ug9dU4LYe
XxgebitSVnsryPHoHthaBnFrWm7Lzz4PjXixiF9Mn4u36btUrzpEF9VMlwxMRF7WMVHxcUjKKIV3
IiiL750fFB0XUfePKRWf1JtIGsSW3xIgV4lqbEqKuOLTYMx6bBFQ8FV0XFbZW5TSVibAICN3g6IV
5opRUQKxHC4hBTdjsu2Six615NUQSNOIrQWBzBCLNja9pSJWswOlYrBSxSumz5BRw8CM5x8ifwcU
VKUQioIN5GWUEZYIq7e8YUBwcI2GbG9RFULV0MUNiU5Y7E0fHEbJAY+OGnm5jMLSkC6geDmINi44
uNVIOCxkB1KoM+AKEDhYm33PH/z5p9736Y++9+Nf/Psvf+1j3/j8B794+/O3b3/59rt/78+HjJFR
fbyUq1RyVaTXVqGtRwwUHFS9ErpHzJSDjKyDRee1XEocRdEukFw4ZmWpoosxUXf1/ErEdb+CbuFG
tIQYTjoSpFRM00OG5WUQ6G6tpmqGm24SBuotmqjCL+HBF1/TF9P3NGObvs2+b/qqsU3fZq89oOXv
LUfkxG06kcmECTGWkBMp1NWjWGYYlpuwowxSw6tXolQpQm6tcs25DCNcQ41S8lKlkFjFlaqn3sMX
qHj9pntRhhkhYSmZEh1IykTB9kYsT7gBQ4Mw3sKEmpdRvZbud4b8hZEg42BFBYW0rroTHELNWvMy
9TTJgKcR1mtBVQCm5LfURJaPxMsEzUGES3G5SM6EEQ7qQ9HKIF6mUmIhKZAuXo5Yw/5kDYJlGCj2
Fv5pNQJDKBlk3IUiJlYjagfsJugVENo+nY3HqCguJThEHYabMCK49SLRQE7Xw6qdFmSclPECh2VQ
4qyDVoNmA9o1KCG2VhpERzQAo3V/qeYrGgFV9ytbK3TYPq4SkisupwRWKdAbriu6eXSLFgNsCXUn
flXzSEZAK+GOHXZUn0YFFBpTyQSbi9FMkNSSKDYfMqEkeRuip06i4DwDatyvJQJNoOtQsGDIgA6P
zYqheSkZEeKhGoSHAqlRr9iEvOApit6SGnWMeLkKYQf8UwFlCGgNhm0YN0KDGjZQjIRKeNj25Cu9
Be35kr/Ghia58BTlsqRgzYwmtDAh+ww1YDnupaJnWSRILpI14hEu4G66G4OBjuPLljFST4lMMLeV
sI+DPdBbhnysC3NqGCXggpjzyySmwA4JpnVsSPENoD02IoIDdslVNHwtzdMwvLblL6q4hrpA0TOm
+CfLcXCigDrI3iSWsN6E/UUgK0BXoTDgEeowY8OI5TFLgSKyEkqksgRDJvhYMpfKUu3QsA6O7eZK
PrGSZZRwopCMqSyleGwWFD3gt0LBAdjRgMk6jA/ADEqzUP2VuJTzZFCuNuS3q8DWga8Gphz3qIJJ
VtTovTPtF8p+3nbTDpADEQX9rPm53oKkbrqIau7vxQFyQESJFOlnWX9BjvBGmEbYKGpGQatLRege
w/RZWgh9ppaAwHJr8r1/8q6P/82HPvGxT/f47Bc/9fkvf+5zX//Hf7z9jt9653xncZhutbKVTqZZ
I0oVoliNlbbGQmwPh9j+Xq7PWdv0BbZ3pK/4y06feu7yUsAooVmEKWNSKogjL5doVktnVR+HYpkW
zDZgpggCwgyknVBOC5pIynqoakebVkRCXq5FVZSR2VA0wGpgoXYYr4XXVZjNB8VCWCa9MSsjdBJk
PZJqQRcprB0UB0K91UAUj9nx5muQQEZGXkZGVt2NrVVjOfDpwSi6r3SgLLdWC5XEaBJhBrPVOKtR
GpJyJ7JswagNgg5MIpRHtyXtlZCJxkLZjifWDow1fSM6lCqeNpIy72O2nu0iKXehPOA3OgETGZmM
hJWUICd5JGWEGnBqqQ6KtRmg2ECK8Se1GKPH2Vq4anutOrQGkIX9jaanauNUOY5UPohwQC+5TCRl
hIrlZH9GBRJ5uQgmoowptldAUtYxFOYXesvUYzqKwnS/amK65tdFl6SnqnKsyGYlOi1wYUrAmaq3
5UAVCRSBjJwmgAuBnsSG/Ei7dA0mh7BFPbaag9FcAMREuONLDPqTyMhjPqkUH0JSRl2UGDJG8fxC
Xh4GBmUDRfckkrLgriHR2yHMCPgcL9mJqxpSm7uU93bVxIKGtxBKENcjMQ2zkZcVmFZhBklZS7FI
ykLQW4Fy29uqBAtIyigfQpkKCzkO8iNgIC8Pw+wQ7OB9BdaTz0ehEAMeJlAnbYVHkJdNV9Zy52q+
atVbUVw1Ecqa20ReFjARBXccdAswoPihSEAnaCGQlA1Y6uLGYEhtu/khP8psFhqwoxIso4vSjg2i
LB51yQpjZ/IMHkvXfO0mNlgPab3Xu4kMknImGqZScSNQHsiOIiOXongXFgdhrgmTbZgWo71vlQUc
ZXVcDaSWS5vEyqNe20QdmGuEQiGnj9e8nO7jKwGhhK6pq4B0jH4ORlEeJjoelGX21s0zIpqJ6xl3
oUw3nLRBe/MWzhZjvWkGarhme3QEkrLhNbeW7CLAO1cd+RdKedvLfe7bps+5d6Sv+MtOn3ru8lJA
MVQoEHGD4SQNL7BeJoVlcZcAtBVUTW/Z9lcdPGWFE0Y0bMVwPSwqGCf5VIQcTCuhjBaOyRgu+2g9
yBcxl+EB1q8gP6KbzDBiZApjchE1FEWg0A9FMaIfU0MROipSuFCMF9RgUoGW5Rvm8E4BaxSIgpgV
FXdvxn3DV1bdjpGt0iGF9OaNlJ7ygJEnkgWAAJixoh61jVC6kqALskctE3w+y2RS9TBuub2qX5Q8
HEot7bDExxNSKl1O8yZRqIM84DJQflf0MLmYDyGkkkyMsEGtgq34C2qAigVBpCKGEc3lgMejUiy+
tcyP6Be0sCpGKNqfYbGEQuQbIbvi742UQqBwVU7hSjIrxdMOwZcTko2Rmie9JWspmDNjrBCSpAi6
VXr/l7wBPRjhKBBZwJIQTPVmtEVaUuIkjcU5LG0k2KQb44g0zUOOAipcYHC67FMcd2+NHxScxog0
guWA48HxM7orryTCIoH5MxChIKn4wwykfX4EF8ARGRLytDvKQUICkvJGY4B+G34O7VdD6Wsc6ATg
OOTzLjYLEuWrxB0HN8h4Jkek6AKwNCSeH6UlJFguRhfSgTTh8qQhwnhJyZXlwcqBnoZ8IE2H83Hd
l0AfTQFPA02mmUIG5ToSkWJJkFAOHwYyCmI4rMfjPAsZdOz+gJpM8aKQzmZiAqQUSBUgkQc2rFKY
RAcTGXc4muhN9U0rwQzrjuFePORS/XUGrBAJBAvRQg8qDWQS0EUR0enMEgUqlS24c5QnnYRcBhiR
yFIYG6JprFCIA5MCXAFCg4SQDmRDBS/PBCQRi8uhJJmO55JELakVo+hsM6qvtzJebzy7XxKBEVxc
iXC0oMa7+d4y5EE5CzkSCgWM+ZGHf/Tn3vDTS40dDoGkzJm9xZvpCmaVA6YdsCy/qQZ5LSQQ4N5R
GXyxlD/5uS99u5TbuepgtvXtUu7zcp/7tulz7h3pK/6y06eeu7wUwEFEzhcOru46enKu0kCN1cem
g7V4sZ4oISMbnpIWiOoYoYQCYsAreCkk5WKsYoRtO04XkyySshSI2LhcS1kj+YTtB8YnV8mB3bs7
R4/OtKsqm8dFf8iJp4eiY53IiB1LGDjBxRUxpcuBuB5OG55BFdrIyEy4jaScCWVElKGjWxEkzVOU
E07Wy9lZa64+u7l36eLBXbsPtNqjVJPqCAFF8hI2nls7PLzn6MhApSRRKPRLIi+XYzZyihkUkJez
ASyHBbVIDvUiVRCHvMik/GDMlOkEm40gKbPxWMNdGieGnKiIvMyTob2rY6dPzzcapIyEHoujdl8j
nEq6bMcsCaf5EClGMhKeRTd/2afpmIzgY0E2GqBDUSqIc66kipGqOyVDwsQ0O2RsLT5L+1gOE0x/
Dnm5lsrOGvbaqnXmRPfGI4OI++/ZefXi7L7JRTvH88FMtaDtnVk8tbb/3KW5U2endo3vrInVRshE
bI1nSKfIyYnZ02emp2eUTtKs47KajPC4P8rA2Kpz9Pru7mqlyHJKJmvEsxqRRhd3997hjfPjJ24u
XL1+4MzZnVPC4GCusmOSu3Zpbn1+oKKmSdI9NmZcO7d7ZUelliyJbpbP0Z1Kc21X4fhR/fTVzqkr
AzvaUzROUhmsURJGd7b3X9h17PzswdOT+2fsQQ1nImRNKM0cHpw71r15derUscbS/HTZ0WkM58Kx
HRPMjctzu2YGimJaikSWms1LF2b2rpdrHG9mc16/L5PLDi+ndp8yR6Zl2QoZmYqScIwMK8Xy9XZq
faNxZHNhYa1dtERFJGVvdVLauef0+KGLsyevDl19ePb0kenJYWki16lhZr3hLK/sOHpy4erNgxfP
Tx0/2ik3BJINUwHSzOjjbW7vUmPXef3gzeriwRWxqpTJZo0e0PCMFSdFhsQxr+jOIvQAa4VQQ+IN
FBqHdRNTFJ9kBDUVQ6GJhLJMxoW6s2SDar7p/ufe8/vvvf3F27c/cfv//tn/c//QQiOmL+ljTbxc
DxfL4VIpVDRx2YoqMfDM17t/+fZ3f+L9H/7kxz/T43Nf+vQXvrIt5YXBpW0p12NlJOVavNz3it22
l/vc+n3T59CXnT713OWlACtL8XZgz/Hh/VfN4hSoqq9YxGuJei/syAYTKT9F95YjdiSQCyDiMSka
5/3pNARzGEgpH5sHDgUJeW80AkrYzXigkPHUitTKZmTf1XRxOJlTweBJIZ/gQjyDsdkc5EmI0eE4
E0F5fkIELVgwwnSSD6WEcMQGRJmIVmKEkckiJwIJuYp7z0Lz0K7hHbv0iSVp1630xiNUraJk00GD
Ddf09NKV1Mq1jD0Uy+vQYnN2CqeSEUQ+DQLjIuVefMdTWD4FeiDXSMkkYGokjWKxeA4orhf5WMGY
5kPxpcsIEVQT5k8JKzcleQ5sOuowhBVj1HDemwSIgg8FoQY6FYk84adxYAkoxPNMisqj2AzFm2QY
wRIJNUvqKZccQxF9FcHGgnQ0kIx1EGWfXvJqlaA5Tg4OLrPLx6uL9wPi2CFu31p2rlp0MgmzDQfO
UucuDR05Udl3vnH0+vDa6vmiOWXGjVKmmI6Cxnu5Lhx8oPnQTy3PnMpXuIaaNhNhT91RSuuw8ah6
8s3DpX2YxDkcZaQCuYQv48zCxk1x4R5i9Jxn+cjQ0uFBI67yGFM/CKferOyaE2QKIAvOXPLRHzs4
voc1IlEnlnB2heev6KcuW4iT5w+cvXJ0pjtAxiNmCzZO59fuLy7f0HdfnD18a/e+PXOVkohnPJWO
tvZcZvaJ0KXzYxfPjR56emj+hlFSQ2Qcyns959/a7RxkomUgcdg1LZ94k9g+BgIR1zO5aoscnzH2
Pztw4SfnR85SqS6YNK2RZBpLpAJxeRWW7lf3PseP3gpKJSwvQ8oLww6z8pgxc4tf2Vc8eXFi/4Nl
xHq5ZAf82XmYvBU9eLW0/7Kz92Z586mx1UuaNgUMmS3bxvKu9pETs7vuV/Y8bJx5an7pQmWoITpq
qiFxajqeiqmmOtxOsxaWsHC6khT5kMIFZTHZRLCxZiFS5eN1lqgKhJkEqkrXfvqZn3n37737wsaF
pebkPYcv3H9wc6HYKYdRsEzWI1YtjHxqIyxCtGNSAlxLreEXSxmFyUjKn//8N772tdt/+tv/HUm5
y7S3pYzC5G0pf7uX+9z6fdPn0JedPvXc5aWA5c7IvpMjZ2+uHLtV2bhiXLu2evXqykZ7fylazubD
dpGfXxAPHW6cOzp8eK0yU6nbWdKKc2qkMGjR++eHTh0ZvX5xafP0zpmpcikd6UqFpdnmoX3Tpx8R
Lz5lHDw/duzK9KP3XlmcHFbjGmKgQ+zare89uevoxQO7TvC1SVcpLlo4S2pxrcE29yQXLuj379v7
0IH9t06eGrUdTIDuXv30genpQYVANk1CGUnnEQqFxbpaWJtrnjuysH6LOvvG0uFL40evTD5+7sSB
iSFLpFA3ULKIpTln42Tn4JnhA3smxoeNZlqxwxSKhqat+sySvefQ0NWba9fuWT82Mt3JsZVE9sDQ
2PJZ5fB9jYOvK+++T3vwwqHHrh7f2Zwc5Jy0FFDquYmN8saVmQvHN07u3znVUKtiiozl6GTBacGO
ndmD+xeOHVm9tXn+8pHju0fs3qo7RAUhpnApHc1nRnPpkRpmFT2qCpwMTISDnAU7H4GZGzAx4rJ1
0OM4h3mro3Dvk63puZyoQoCEtAaKMERmynyA06JqCoeprtDYTazfKJ17dmhwA3eoCokxjaJ64dSh
tQeEI0/ZR55tV/aHbL3JkBqbEMWMOnkEP/KAbu8BfxkIlB/RKKcpsH5q+BQcfpqdHk7bEvhFqCxl
Tz8wYY4E9DC+XKntebC+ek9xaNrNm5DIB0UD9a8pJOXuPJy/ZY6dLoRK4KGBbiYMrVDIRzwRcJrS
yhvipXNA5cHSYfaaduJN4/PjCpMGaR72PWpVdqeRlOkY7JySjr6eqx0EOZEaMqzNiyv7Do2uP1E/
8PqOvScYrIFeKKj5fCGak3NC8zgxc51beCI9+1iiNJhiTY+c9nWL7PKjev1UNMcDKUJ5p//qW2du
7drZiBHSXjj8Vn31lJS1IFGCiaPUhddPtNcJkaU0iUd5g2bFg2UIFGH6ZM/LYx0NndgSQ6bcwNO1
X/r533/3L/3G/XuOdigLSdlIFp1sVckMpLwaQzTSfpuJVsiQk/cLEUjP1ec//Zefee6h5yYrk0aC
s9OiHEiWk+wkW0NergT1MtZ7aQVh4DzychxgsTn0V+/4s+8u5YF8bSjXbsQrW1Lefvv5xV5GbD1Z
/nZeLNx/Dn0OfdnpU89dXgoYadWnjol7rtd33UruuIgdOV0/dLK6ZK9aoSI5Cd1NYc997NKVzLGr
xrXXdU4enmqUMnnCZ4v53Xv0zfPD6+elIzedA/c3Rg7ltXi+UhA7o4W5FXPtITjyjH/5QmnXldqp
C/vLLSWZDOo6O33Us34luXi9svNW8+hbmbkHA1NFXcIDeBUGDmfnXx9feUvmmTP7nt3ceOyeo50S
GZmCqYfJxblM0YLpU9r4MWnxjXDsP8QHZmVjID06Kazta07fB/vfHF++4Oy+Wr22eWS8XcpyPloJ
z53OrV+Tlm7xOx+Uzzw6c+DGYLdupsMukcNXlwbXblR3XSsffaBx/KHW7jnNEqASpXaXu/WT4dn7
uMWnCxMPxa+cXLx2enmiaNm5NDEM7dO56cfYwXtSh48OXL+5dO7qUHcqFs/FskxmeD+ceEy89MCh
E1d2PfbgPTevnNu9wDoKyERdjTcFyi8xmK9AIGqhVJvIt/yTTd9ExBQzdXv1WWnsvtRwUUPiNkNt
1V+Xp+DY6/SDF/nRVW9hEBJVyApSgmZR+F9IhOujsP+0Yh2G7tXAgTcxzTPglLVMPmbGndnSAtuA
0T3+Yw8rnT1Q45tSXEVulFzNmSXx6JmhgZ297+PKzUCeBS7KZH1p8yLMvSk3XmmVWBkkr7RgX3nb
krU72KDh0JS24w1c8apfcfJZNqQnNSOlW5igeZluDS6fdI5db4+sZnJ8lJITTDQqpVKZVKDTtg4+
l2yeBYmJJnFIb8D408rshCGzPvFk8NDPTtqbEjYJyRB0G9ndb8s2HwApZtFBeVgRKmSmfSJ64OnK
8BGW6kI30ypjhuHNz0rtmWu0tcdlHoPFJ/Lzk3lH7c1q2K771n9SH3sqJenheAa8U7DjWXZzoi0D
YIdh4T+65s9l42XABqC1Gd+8t9aZ9RkZwc7LJk1RUTzMAVWGlcP6mXtGF2uqEfMMJgwW8Cnl8kf+
8Pbtj3z8316+1uWKtbSkZGtGoaUKc3RuVBCXYvGhfGowl+xIZD3qZa2C81s//zvv/O13XDt6pcXZ
ZpIzIhknRraSshMsVIJqGXthhg09wphRLgaw0BxAUv7k3/7Dpz7x2R6f//JnvvjVL3zhn77+9dvv
/J3/sTi03CfleqKCpPwdvbxt4T76nHtH+hz6stOnnru8FJCPR7M1WDxrIikr80ChTF8DJ1JmgG8d
K6w+UB89jvl1IA3Yt8lf2lye7Mp0Mjg1WLl2c+bE6TZdhbgK+RbgFpTyPBMgYhlQLP/URdj1AGhT
GGFDksTcQSDJ2OrqzLEH2cnDrngLXBp0r8CuJ2MHpkb4kDdchsVr5tyzMfoAVOJuB4eaniS8kFyA
2dcxrToMd/xTJ9W1G82Vt8C+H8eGF3WpRmQLICiepce88w+72CHATTD5XDIIKdo9Pl8+8Whl7BDh
K4HLgtF93NH7RpenBsmYf6xrnd9c3329wnYhKEHSAWRkEakLy9jBbHAAhi+mZh/PkrtByECBADOT
5CNBZgFWHi61r8ehBRQDi8va9funRmcSsSzBqezC2fCRh9iRhWKMBjJNyBypMMBmQU+2ndwwR3pz
CQjzaYxJlAPxajBZgW4RBj0CiVvS1EO59pVwSxdQQF0ihkV3GdOhvAqHL4vHr6uLF5nKTjdn2hle
5HNx5OXdR9i1oxw2CPoBOPhmFknZdOR0jlBxw4ih0w2T+0PXn2vVV0FLm2bOkd0tK9idXZHPXJo4
dA918Snr8s3pwbFEmS3GgZDPwNqPi8vdSZsSIA/cDv3EG8eUJU9H8G6uVJGUhZNASQQp4EjKSkwu
4yqSMpuCHcP+g5dqh680Nq8e3rHaNUjSRLFyNtSoqaiPHLwEjRIXDwO+E+be4uxfG7SUSHINhh4W
O/dUFp+dvHZ2/tbl1Y2foYvXwcrVWtKIFougLKG44V1/zKrvySTq0I5VHJ8qQ2qjPov+WZiGzCKs
v0k4sGaUdChke1KeewutXwRa8BrFuHAcNn6yfGV+tBTqSXn4R2HnVWb6VGLHfcLRf9M5ftVBUi4W
VIdUxHQqG8QKJRhdS157bH5wLlXJhQeF9JaU9eCuzdm3vv7E6VlRKSf4IcamcCMTkGrFPTsXb45P
XFLUnbo0XzJ3zo8dUKhmCCIH5g/91R++90t//4UP/NGfP3v14YVie4BSBtJqjeAbuFmPGFsaRUa2
CB5FyneU8gg7sC1lFCZvS3nby3el/FoFyESMH4LFTXvpepQe7xlZNEByy2WiUrxIzL/emrgnuPPJ
3Llnnc2nrVuP7ZnbpZM0Cs1Si0f40/d19jzMTV2IahsQn4BiqqpGTCIBrEDMXYG1B/zSmD9bhwTl
CaWAlcPzq60jr4sefgxffkjc/Tpt/enSmbeNHZnZoDyZWAXW752ef0rL74ZyiB4rOBl/kokWUvOu
8ftKlWJ053Jx7yMdagIy+2DhLTC06NBOlGL8ooxP3uNefCRsziTCGhgcS8aIRME/u3N458P5fU9y
S89Qc0/kjjwzePwN3ZX1DisHOSc0sersfrK08YbG7E3S2gtGsfeqVh0vWV4VQ5HmRWXHYyy9DrYQ
kUkvF3Wr6WDxhGf1KWXiifD009GrDw6cvlp88Kn5lQ02zScTTGzXtfjZZ7XqmJjg3Uw+LbEFlQEq
CSJenXB2Hd8/efPiniOPNE4/NXRoONnOwRRZb4YVyLpTdW71aWfwam5In6yynXLgvASHg5zfW3Bl
VeguxVZuZI4+qR68NKO24xQJI8O5G4+O2W2AClRPhlaeiDXOglbFCgrwfl0JOyj6G9+TPveM0l4H
KesvS0mH6OihRjpDptJ5sgTd3akTVzKnruUG9UEmzOjnYfVH6bnOcEPRQQBuVjn5phFjp3dMD11a
b829SeBPQJ6LZplISQIuBXag1Ep0FIJlsRytZesjxYPnK5cemrh2SR0egHAEhrvcoWcm28fZqk0j
KcfWYOFHSltSTu+Bsce19o1S/Yp1aK15fGNwS8oVZsDIVKxklvEFy0fgwBvY5j4u3YKB+JAEai3r
OzHTmLiSiw1DdAx2PFA5fUpqt4CMBFuGOvQwPvlU+uSF6s2HJnY+x849k91rztQDkm8VBp6kj94/
dPhWZ8/r6dUnsnPrVVJxy+mMRdEohFc4WDwT2Xxcm9lZNRuZVrbWzFRrmInQY03GZ7XiKScQEr1J
BENYA+bM/PSl5blre/Y+Pjd/z8bag8cOPrEwfrCijes5M48VpISwc3TlXb/5/97+0u23/+Kvr7fH
Z8Q6knI75jSjL8h0S8oJgMVW5//70/d86gMf+fQnP9fjC1/57Jf+8YtfvP2Nb9x++3/90y0pbw2J
25JyhShuuXhbx9tf9L0Ufc7dps+Vrzh9SroLFJLxhAMr50uHHmfUBeDUnpT1gFGN16Tj3vHHxNpp
UDdAnQJhFLoztGi5siTgMSAEsLowthk68Li8iu60c0Q119RwK5F2a2YOGfng41Fx1BcxIMMFsAQw
Umh5bXDjQWzsBLCLgAJPYhToJWixFS5Aphre6TPN0Qdoei+0EzLyMktQYpLDJ6F707KN4LHD3bmr
dmoQCofg4M/GZ/a2U7KPiIMgRRYeDu18IubMpZGUdZahEvEsF15cH1u6P10/CslFiM2BON9DteNZ
2gVRyKseahHsQ9iOG/k9j2t7DojlBjSiZRUEfw2mr1tLT8uF3aBSfjHnRlIW4z4DpcOP8dYFiK1C
fQRa49AY8SolwPNh5OWF86HDD9P1CVmqpjJxHHlZpoDPgZnuTJfXD62PnDu+sPlM98TjA/s7sVoS
kJErfh64MNM1xm+x7UtpFCqKhKnB8aLvbL6UQV5mHIjzEK3C2KnAsesLlQnK0Nx718tnbzYRM/ex
k/dQ+96UP/Hj0sbJjtOOtugR5GVIwcjuxNmnZSRlORdQyaAZaalYrUBxZIENspBzYH4vnL/FdLQO
G2Hty7D+NmF+sGsWUGwPxq7SmefGtRX3848v1KlnaOeKz6rygp6V86CQ0HvXw2XwIVKOMkkGT7FR
LAsz69Q918zleU8mCyOjwoGnxlvHGIWLZWKQOwiTz2qzE4bEeIUT2KGfneQP5mAIRBLG2uTCjxDS
JpjZam+gBR4nXT5zoyflgQMiZoLjK5exWpPEzi4O7nnCWrxfmHuodvC56atXilOTbioaHq2W5t5Y
mH0Duf+4jlBPQmonjKcrKmS8K1B/NDeyryB3AbXhjTdxA1MCawaQlNVsrl6EIxvmsQf5HccDVjNL
a5js5UU3W/HrSMoKXjPiLWTkSjhainNmpMAnig11ouqs89RkItktVw7uWro5N3XBkbp00lEzOvIy
kjIO4YIn9syVh774Fx94681HxujiOFPaipS3NPrixxcv9UXfO37rnUvDK9tSbiaqSMrVWOmulP+V
gEK5PGfie49PHb5ZljqQz4MggOBiOKCmrpYOPDPdPRElR1DqDSEODDuWzkEuH5DkpFKDrAxuHthh
mDwv7Xu0PaftaCRr+Qij5M2lE/SBq6bZSaVlkCUiHEK5fGRj58yFR+Slo/5CB3AbevO2OaAQedKD
ZxSY26gtXdAUZOGcqbvTxawthvlYCXZdG3MqsLomHXpsiJsAYgYmHwxOz46inJ3PJIRscvWyufua
Ux6SiYJHS6WZUDidIqYmR84+Mzx1Ip8cBXAgpAFhA8/gLBUWtKioE6ADcMBNw85b5omTg4NDydHs
pAEOIcLi0aG1e9vyDGaziSKf0pJRMRoc2JXcfN343LVcfgzyAuR40GR3PgNY0JXJEvP7C4cvFWst
neYTao41CoKdDQoRYDyKHLK1LK5mIsEolsonyxF/MeStx7LVaDqGOsUSrD7oWbgXpruFouqR/BYN
Mi0GGAkjmQB4AfIwsj9w7p6ZwZmcxcLcMDU7re3Z3Rg5VJ3bHD77hsaJJ0srC1q9HJE4Ph1PgAS1
DXLl0XztBFgtyAhApuN0LhWXhACZQ5+GlWDqNGy+vjBtTykRuXYADj5J75yjyjoENRjYm7nxhh3V
Wb9FhFfr5f2PNnfe6zRHIElBGEm5BhplZMN5XswUy1IQnUOUiuegeyhz9X57ZsUdJaHaLaw80aic
ynIoozJh7rp+8s0TCxMqkwZxDvY8bEyd0YMWZEO9Y7n47+yRTaiwPCKWcyULXvkQzD8R7Z52koPu
QiyXw9PdMdg8r0zdw3fOZ5qn25M3pi88bi4cDxXc2EyxvvZgc2xTrFRyphlPGBDkYSRct0HQVojD
T08vrNfSLFjDobMP7Fi4KDvL/lwhlMr6h3YUTl+bGr2Ih9vgUYCoAFuICUyyxHHZQCCTU/dubN63
fmRXacAhWMGT5IKyk62ahS4TrfCJtpAcoPFyIVyU4rZAmFyIF3EpjRotVcy7iOXW1N/9t//xK2/9
mXmlY3jzDdyuR15YccrAeTMq9B5fNAZf6vHFlpRHuc7W6ItWslZP9B4r35XyvxJAipJ4Dkbm7BP3
Nw7dKF29unDlyvxKaaEYNbMTrpHzxspNbs+D6qkHKifuKx04PG46cZqJDHT03cec/Zv15Yv8xi1r
/aHG9EVlVp2pEKU0RrIJaXIjuflw6/ClHcevLVy7erAzIFOpYM3id50KH79Z2Htvad+t8qlHxmaP
y6NGjQsmScNz9MrcuWcnS0vBwbRWjbDVQpl05/wKrN+cHJtKleueyTPi/CVjz1uoUz9tTu0Y0UyB
TkTTIX9rPb7nZvnE5b0nr+x74Mzm2tg4x5KaKiyc4/bda68/bu961Ni4d2j5QmWgqUTDMDbjrB8Y
33FVHzsnrN5rHHumc+Roq1YPD8SGNbCCNIytlTceHF65Vrt+at/DV04sDdTtXJJpwexxcfeDws77
ufM36jcf7h47PNSqJ5KpCMvl9p8zbzwxOT7dKrAxJcvoJO/kQnrSp4QdDS+JCYyOuHN0Nk2makSw
GsWQkUcpsTEXG99Dz98DSMpH9tYRO8wVI1Jpd8Wjp+f3H95x6Nj8gXulC8/UL90/P7pA6xQgmAIk
UaxVAGeBP/a4M3Yc772jkUeQzWqtfZhdvtlYfYzc9Th17GKxOe5BRh4dbC0fO7J64tjc1frhp2aR
kRcvwbA0RLkL1CTMXw9fOzd09ezgzivF86/fsfnIEJKyjHmrmUTrYHL3faVz1yunLzvHLlcvPtCd
H1lkk3ytoe8/uLJ8aXrl8szaDfv8GyYu3zK7M5BkAQWke984PPtQ8dL5sfOb3Y3H27PXtAoKEdNQ
2+8//9bu+EkFRcEUAUtj3Oa/0ZpHQEtn+Wis2pFmltsTD/pXnk0efHJh4cbgaGOYTVF7NlL33l9X
97pR5woi5GcL519nrF9IaUR678jUyTdOT55XVBVnWV/ShHwZqqCJkGOmfQeemFg/MpzhICZAc0f6
1NPd9kY8nQtwYmLP8cbVh1YW7yeHzgZnzpaXr7anxpq2zsjpdBigUht/xzv/5vaHPv1Tt143Idfr
GQUZWY4ayMhSqlWIVCm8RoacrSFxeb/Q1Ucev/jEjWM3anytRhk/98af+PJffujBw+caMXmH2GoR
ReTlCu5sDYlz4nIS3Mvt7vv++198+oMfRUEy4rNf+sfPfflrX/rS7X/6p97oi+Xuap+Uv31I3LZ8
+x4lb9Pn4m36nPiK06eku0ARE/PhXJF35pZaB47M3ji//+rm3pXSeCOtYV6PY+goLju0f+jG+eV7
Lq4eWdxVZiQWL1Q4Z2Gifmzf3IWLS/fcu/fA0blKk5vIyTUszXvqnLtWKtKrK90DG/OXLhy6f/Pg
6kjNjuiSh6sa4V1z1oEjq0dPrt+8tHNtqTKoSnwkKBRc+3d3Lp4a6TZj1Wimk+m9wCq6qHQKVpY7
O/fnW6NQmYUdR7K77tP2PeKMVkfKYqmc4C2cEoz09NLA8Y2Dl0+ffebUkWMjA2qG42OkLhCTw+ba
4aHjF+Yuntt79ND8Dq1DA1FnpF1D4/vPTZ68sXTyyvye48OrrU6DYit40QromXCgpssLC9V9+0Zu
nj5y6+zxne2JclagonhJ4Gemigf3T57fnLt8Yens6tqYbvOJrJKlVuY6Z0/snu501QKrRUQjKlci
IqJGOM1EuZpmnRiphWZoGNLAMaBkh4QFY+z0sclb19cvP1C+/kj9npvdG9eHdo0XlbSro8f3z1aO
7jpy5fjlzasTe45Uprp1R6XL8UwlkXVSbCnDpwuFcrN5/Nzk+qFWl3WqSaGhSmvTE/suLh65sXvn
xe7BW7MP3dq/tlI1yPCOtrF2aPbAyZV9l+aP31pbPVBnDfdAuiYCLTAw2EoeWmtfPLnj1JnR05tj
I51k1fEXY4IWLPC5QrtUPbBPvXlt9MTpA6fPHp5qjHMxulpx71wVVk61jt+aO33h8P6ju5Yb3XpB
YiJkQ6rMny3MnsnfvDp14khtbma8aKlMMCoRqbkp7sblufmRikZFKyS53GqdPTM+M8U1RckhCzvW
Bg5sLm5cHkFcvnXqws3j68vD7Qp3aL986+bI8JTDKNEExRi1xqlLo2uHSq14al+1cebc+urukbLS
MLmSEy/qEWMsXGmC2q5lTh2dOLpnvmFxRkJrMLUT9+lT+0Nl3hl2Oic3zlw8fmX35ZHTr9t54qGl
y89uHFzrtstkhaFTAHVn/dd+8S/+7Ff+8N495zv58lCh2qVbvdepA3IJNyWPUCKcWrpWTVVlTEpD
aljqvun6m9/1u+/pTVTbW1vk/f/b429dqYzNCJ1O2tl6eaQU6mHisk2oSfAvt8f/+p1/vi1lFCZv
S/l7jZT7XLxNn4u36XPiK06fku7Sk7Je0GiCQslyMgv5GDBpr+hOG0Eql0ryNCWwkE1BIQEyCtMy
FIcn84G0EGM0NsZmAngUMlkooFg352qGc2VfwogMIynHCMhmvJmUj2djQsxr5vHeXPh+EX2OSAIK
JzNk2JIxMglcGJNjOPpDpNyW1BuxUAwlkJcVL2uHlUwaVCW+sJbce5Qd3BVShiFcgcIYSBmRT3KC
JyH700TWTQo4lczkiEQtHnbCvjyWkJK0SAVzcYhkAMVKPBMu5HxmiC4RgoQnxUgiyvSe2KY4iNOg
ReNWIl2OONVoCYXe2QiWR4En7XHYHJ8I20lGJ0iaiCIYyidwQZqEVBzMREYI4lw8U4jE6WxAF5Nc
KsckMsjIyMt2gDF9lOYRVDcveKOsKywHJgXvWDnQRMhuEkGmIZsAfwKyyI4UcCzwMSiEQMsAiqbQ
RWFidF54/mlJPBAPgRqIICnzgYQSyQYJAk8mRdPLKCB6EggKDxUiQYwGdPEwCRCmguWSz7/jQ0CS
CmS5cIjrPYlKsRDOQAW30C3KFiAVA4XuwaMIkwRUKzoHFs6aEYaMp/KxZCEHiHgqSHNpZGQylEVV
ZRnAGCBkILlElibEYEIncoUguuyJZAUQIgvI+FQ+RZNpNZEVo0n0sTwFfDqQ8AMfDEqRiKG5C3mQ
YnE6GIrRrgTriQgQlYAUY3EykI4ClfZwNBgqRDOQIN3BZBqC4YLUe3zUe+AbjCh6iuEjTFLUaFsN
aVRv6iKxBFwhA7rk15hEnvDkXVk+yCZ1yBeBiuQz/iSbQmkW52YA13sPiLLl3svl8SAoiTiFBQCE
ZKQ+RJVVf4GDjOp7YZ7xYsQwMaUYta2wwbk4BhglKCNYH8cHhIwn/28ff9sv/9j/sVifKcY4I1wY
SNkSZLdes96ar04LCUZEioFnoTHyUm/0fa9f9L1YuP8c+pz4itOnpLtAy6sJHosFXSYFLk1z0Yie
TTtRupLgVSgbUCtHaBvLmxhRjCQdv1kOOpavooK99SaegifNRE4jJNKVqbmhhFK/4FzRP1PAKS7B
UxGciRKSz2Ph4Zq7a0GThZToyVFhk8FtGQSEgppXqurgVm/WHiCLXq7sr+pg2rCj4l7UAjXFV9Ht
0OyiuXG+cPSacODmwLEHRlaay0260QjxU2Q5E8my6d6cMlyYGYy7OjFA90M5IdRwQ3ezTDCmxHN2
hJU8mSoYg1Bth6yyW8pGfflYgIrjJBEugVIGVfPlixFO8hJ6MCUREdRbiHEiH/DJARbdSCY4IigC
8Jpf5dNZjWJkYDTgaznViNJZd5rGCkwgL0c53asgSlAqu8qVgFjFpEpErhNaKZRG2KHeIt/oDkeY
QcMKmTSma8laNsojFMLUE04nvEOFupGosAGVzIRENqnFKnzQrICFaEVrJb9ViGpc0ubSyXQIc2Bg
0DczFjYGPELBn5djIhPWs16h5a2UwKgDUYawlYQ6hYkJdPLjOkwZrmkTqLJfKAWqAsgc3km5ilJE
4jCulAmoONCQZ10F27VYD64ZaUUiOANnEXXoVKHt+OO2L8bjOTXJ0FCQ3eIQOPO+oQmYa8CQjIfZ
gC+PlBoHASZlmDGCw4pvQIOUAZm6v9abKC48LEPV9PXOqk4YYlASk0kax1VXxfDWHZdhgGKH3a0M
bvn8hsdbhErL06m6hnWoiZ6ChnHdUAudf9LvQ2Ti6BhCXV8d0YHhIRgpuasWFIVwGgUMjifTwjkK
PHYsNeQZbkKrGVTaYY1NB5kURkV0JoraW9uEZjfQmE2MVoimCNrWNLDFsGph0taccDU/Z0EOHQX6
WQkItaCELmIlZtqEiXqfQoB725M//cs/9gs7B5YaWV3yZZsxs0EY6GIVfabpsxB9ExJ97H1///GP
fgrxic9+EXn5s5/92le/evtPfvMdWy+PNNKldqq+9UZfOerclfK/EnpSVrGy6LWRlHN4msT8Zj6L
pIwiryqGcu2K6c9agVwJT5WjacOtIi87gZrmcpCRUTAlheNqNGXEFQUXuri3AuD4pk33BJKylJH5
eIIlYqU4oWJ+A+plGCzHlSIhISln/YrtM5pETcMt2s2rfhl5uR5SGmG1FmwooDUDOzWYMIKNYrQT
CEOehowG5hAIg8ANAOdnVVyxXSg2p8hYgcvwSMpMkGrhgNCCeQunewvEBRUtSfKRpOrPOzg37K63
oGgB66CbOY5RyRCbinHpeN1tVkG3gjSSshpIVBK0kU4wQb8Qi6JeSkSBUlgsIsH5qpVY2Q5beZyg
YolqyEJSMAlGDubQrs2MrhA8H6JMv2b4VGRkhONhLRdteGkH41VXxA4kNF8BgXJhdD+LLkH2SBJR
4iN21JfLx0QJ1wuoW3J1izAkhAzGr2STgUzCT3kVGS8OYo0q2Ja7N/EYm7AoQicJXMimh/w7KjDs
QGYkqClx9IECFVQLmDLgryEpD3hTg/6MnQI5AmlviI9lKsElFSZKPh7h+MoqGDY5k/VWZFwWQgIf
ADPuLiftUsIyYE6ECSqQE3BGCuRFf67pGur4RsvBVCWUVhI0F8k6YascLQ6AOQzFYZgcgoliNo28
zCRdQta3NXWn6u9InpbtybcJudh7gKMjKavu3poJW1JGkaaQSCAsf1NzV4tuc5BoISNLqKcPhirh
yBA2UgZk83Y7MGGEBDXADviQdmUjk7ZyWRTdo5wA9axtKDZhAHnZhhKSsp6gFAL5NF3y5cxoQg1F
K1CtQq3i5RGFuA8hJIpJD1eDkZHIfA1MEwTNZzvhqhOzUCytetje4g9BqeznkZTLHnqI0FHXUvSy
7aiu+jgBCiqKlzEp72PUpCVH+N4aaXFRxchqRBUgUw7YyMuW30ZsrVUYA99CfezbI+Wt0Rd//Btv
35qQaEvKWxMSlXD7rpT/lQDFEGUF+R6YhDCD32JrFbW7vDS9qYh+kPTt7o70Fb8TAe17o6/4a56+
w78jfcVfdfQdzitOX/Vecfqq97LzzR3dlfK/hBddsB8Ifbu7I33F70Rfm7gjfcVf8/Qd/h3pK/6q
o+9wXnH6qveK01e9l51v7gjlhtQL68g9v6bclpq3MDDxLt+NgPyDpW93d6Sv+J3pzfX8vdBX/DVP
3+Hfkb7irzr6DucVp696rzh91XvZeWFHd6X8L+BbV+sHQ9/u7khf8TvT1ybuSF/x1zx9h39H+oq/
6ug7nFecvuq94vRV72XnhR1BBaOKAb6HX0JsqXkLMyDe5bvxbU/oX2b6dndH+orfGfV7pK/4a56+
w78jfcVfdfQdzitOX/Vecfqq97Lzwo7uSvlfwLeu1g+Gvt3dkb7id6avTdyRvuKvefoO/470FX/V
0Xc4rzh91XvF6avey84LO+pJueznEVtSfjG2X7zLqwr5Lt+VvtN1R/qK3+UuPwzuSvm1RP/Vvcv/
TN/puiN9xe9ylx8GPSmXMKFHQEYUsW9hB18eXvzl4Yvpz76/X/o+9o70Fd+mb7Nt+ja7I33FX3b6
dvctvpVn/bPoG8O/Td9m2/Rt9kOjrxp3pK/4Nv2n64582ydv0fex2/Rttk3fZv/L0lftbfo2+6HR
987LNn3V26av+B3pK/590/ex2/Rtdke2C0I1SDt+rodPRLw4Uuhvo98vhl+4yw8Dn3SX70bf6boj
fcXv8sOlz1nb9G322gNMf25rSNwLUdiLXh55uegfufVN+jb7vun72DvSV3ybvs226dvsRQjfEQPj
Xyb6a7LFt1Xjm2DK90Tfx27T/7HfZHvIzg+Zvmrfkb7i2/Rdpn8G/Wdgi77TtU1fNbbpq8b/svQd
5jZ9h/lDo+803pG+w7kjfcXvzLedmS36qr1N32Z35IWKBeT/H8IACjRv4AL6AAAAAElFTkSuQmCC

--_004_MWHPR10MB131017A874BB6FE5FF72F7BD89110MWHPR10MB1310namp_--


--===============4527307510572694184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4527307510572694184==--

