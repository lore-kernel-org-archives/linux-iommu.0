Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071F3C433F5
	for <iommu@archiver.kernel.org>; Thu,  3 Feb 2022 06:54:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99BCA605EA;
	Thu,  3 Feb 2022 06:54:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mLTtBb1tVTgx; Thu,  3 Feb 2022 06:54:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6EFCC60D61;
	Thu,  3 Feb 2022 06:54:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F894C0011;
	Thu,  3 Feb 2022 06:54:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44433C000B
 for <iommu@lists.linux-foundation.org>; Thu,  3 Feb 2022 06:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C1AB41648
 for <iommu@lists.linux-foundation.org>; Thu,  3 Feb 2022 06:54:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=renesas.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h80I01pOW2Xl for <iommu@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 06:54:06 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (mail-os0jpn01on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:700c::701])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B386D41646
 for <iommu@lists.linux-foundation.org>; Thu,  3 Feb 2022 06:54:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOV0JqpQdSWqob4GKVzUcBpLo3E4mAbs4ndxZvh3arX/cgcOc44fdoRhf5PdPPrz0nn6XO/KRxGdHlPYnjJ9iN+6TKjnnZCL/BNc/U5LgYX6w36GtqWWk/gotuzQ7h31voNDNCT84AYSJ6+sxHi3bvQSDhOFPfWDgq5+8R1HE/i4hVFjwxvylURbqTPhbXwu7VYhluHOL3ZHAqMKvTWqK3hJEL+NceTqYVy5QHqCYkvtS7RiFUCRzrYGRTrm9EcsQzYkqRg93sSqP0S4zI82STGUKP16WAW+WdwAbfW7WPgrAT7Lc3M8YGOACpDoN0EispxLr/6MC08BbODfTNItlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6R4aLA1XPnusvV5w9ewQlNmdFGEZi1DfK/W8ASMYXnQ=;
 b=LJc684Kz4ePvQMOP0yT6aqrfjR9cBfgrRVNNZuTmFNnHDkV5ljdLZOVSQmXjZhvppX8stw8R2uLyh4qe/fnuXtrFJ9cIGQZV32YSD98wus0y/aiF14NIH+ECKZe4tPgfdAlAWBGdoTmC59JW1e4YQuNJn3lzENuW9o76QRe9XX0z6zzAXuBjBoRDv9JK/9erdxV6vOg3mXtlfRL9wtSbTwuB5uTre6iG9GEh/F1bKFvJDXMyYq+u3qa4phpjI5PP6zwB2SSJQ0lIOLP9DYWwjnq73DUXZVvwVgVVvKXRFx9coSVhmOBFTtvmYYQh91vDQbMhlbQrRUJqZw7+bDxX5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6R4aLA1XPnusvV5w9ewQlNmdFGEZi1DfK/W8ASMYXnQ=;
 b=Jqne+PXyApq/PXccCd6ybjoMuuNXBM9xSR5eLlMKTg8SeIqK5Ecp0O4cBA6zJoYA/zRnKt19IIhLLCDe1TDu+d4a4H2/LXJ3qaw8DnHUC4B7oCRt8L5MmSQ4s5sQDQAGgkj28cnWUfrIZHnMpmAalCI6lx73+NzulSo6vh+xrX4=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYWPR01MB8854.jpnprd01.prod.outlook.com
 (2603:1096:400:16a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Thu, 3 Feb
 2022 06:54:01 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b8a7:7600:2af0:eea7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::b8a7:7600:2af0:eea7%5]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 06:54:01 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: [PATCH 2/2] iommu/ipmmu-vmsa: Add support for R-Car Gen4
Thread-Topic: [PATCH 2/2] iommu/ipmmu-vmsa: Add support for R-Car Gen4
Thread-Index: AQHYEerv765yfwyF10SBICWVWsSd2KyACUgAgAAXFSCAAAXpAIABSz1w
Date: Thu, 3 Feb 2022 06:54:01 +0000
Message-ID: <TYBPR01MB53411DE58B8567604CABE9EFD8289@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20220125125602.4144793-1-yoshihiro.shimoda.uh@renesas.com>
 <20220125125602.4144793-3-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXmievc1U0PXfv01wsibUs+B+5U6kPbcE8=v2GKTvFbTA@mail.gmail.com>
 <TYBPR01MB5341422A4238B937BFEBD0D6D8279@TYBPR01MB5341.jpnprd01.prod.outlook.com>
 <CAMuHMdUkB6+kYWewxHHSkgapioiu2s+A=32me72H4+tQU0+bDA@mail.gmail.com>
In-Reply-To: <CAMuHMdUkB6+kYWewxHHSkgapioiu2s+A=32me72H4+tQU0+bDA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90fc4a9f-fa11-47fa-bee5-08d9e6e1f5c4
x-ms-traffictypediagnostic: TYWPR01MB8854:EE_
x-microsoft-antispam-prvs: <TYWPR01MB885462D0622CA8D91AEFCA8AD8289@TYWPR01MB8854.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IZpnSXCWQYYkraOx6+T4MdG9XBASyrg22bNRFb7pSDdAjsm4jCJ3vVjJX7vkkoRN/TLoUaSIUb9CMYohimlACrPthbjrw8zlbLcPwRPjwN5XIDyhogvyRH5XM1zbZa5qxWGdLfDgV8HGjpLt5FnrNowNUcQBGZMuZ056uimI8u7Le9CJwan4rDAPuop3hi5QnnCNrvzK9FVYGreza6CXSs7rxB+LWI/lEK+GZGutecDCcq8K5Qn55TS5qHmhUPuOmcl0r0lJGXn1HtrWayhz1hoh6H1hqlOlC8u2C04b5ExJIeJ3jI1WMhQ2fmWW78lS7oBz9V9eudJj9bS47D32O3n24Z3y78UWfQ4p8ydnDIuJXlix7vk5VLmA683fcU2o2uTfgm9y0AJwmMAgE15RKFaH3Iesy0vXOXK4DHEUU24P9Awus3sUAAf2Qzobmk4XyeeMEHqUpRtiFaIRqrWvjLtpErsFRQBqg7+OEe1NyvDJ+yPI5/p7Ai2Bt6eu7jLxDxFfNM18afldK6+1J/fa7nyhK21EfrZNUQad4BjeGuOfaVKDOm8bMyD1En+xp0Dh6JLMD9ypFOB+M8riICdJcJQEJXe1Mspfzub4tg94eE/K7RHSTQ9j6Mi9HJaV4GZpQIzVJ/utQM5sXkow/MSAy+djMzACmNywhLvKG7wEkpSWhr1Sl0+ECmHzyxul0VQHtvQ2TcfgyKAl7Ly+3T6imA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYBPR01MB5341.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(55016003)(7696005)(6506007)(38100700002)(5660300002)(6916009)(86362001)(9686003)(33656002)(71200400001)(122000001)(508600001)(54906003)(316002)(52536014)(53546011)(38070700005)(186003)(8936002)(64756008)(76116006)(4326008)(66446008)(8676002)(66556008)(83380400001)(66946007)(2906002)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVVYK25zZ0djbyt5ZFNISDd2Nk9yUEVnYlZnSEUyaWRRQzU0OTgxeDA2OWdi?=
 =?utf-8?B?aTJqRkxrQWxqRXpodmFRTXlWNGtqMUdESkVzSmgxRWxkSVdWdkw5OXJxQUJo?=
 =?utf-8?B?ZkZndVNFN3FvNStWaDJmeUgyU091Zld0enhlNkVoK0hHUDFjeFA1N3Z4OElF?=
 =?utf-8?B?bkdzdGNZc2dMUW45Z0MzQUNPNlJmbzMvQXlTeVZQUEZJb29RelplUWFENUcx?=
 =?utf-8?B?RWFmaWxJODdIdmNWU1JBM01DRHZkMVE0V3lJRnByQTJuKzhOb2tsR3BsVWlp?=
 =?utf-8?B?MG84SFVlTzdIS0dqSFlxZ2FMQ3JDZHJvRmk1YUNiRlFBYW5UdXhHYlNqYUM2?=
 =?utf-8?B?cFVlWEtWNEg2Y3FnTGQ2NVFzbEE2ODdkc3RkRjZsTkVwWW5CZUlxUXRQbHFL?=
 =?utf-8?B?VUZITlh5K2JuYmhMOU1tQnZIbER4YXU0dlhxSDUvS01oVjV0NG5XYWNESktq?=
 =?utf-8?B?NVdGR1BPUEk5dGEwUGdvQU1raWRQc1poOE9PY2ZGOWk2MWZLTUZad3BzMVhK?=
 =?utf-8?B?UFFuS2xqMFdmQ0N2Mlg5aWJlTlE2NjBXZGx4RFd4cy9mTExOeThQNmtEU29O?=
 =?utf-8?B?QVVyS0FMQ1h3anp2dGxyZ2VXeUh4ZXhwT3R6L0VNbVlqTFB5NEo1VWl4R1VH?=
 =?utf-8?B?aDYvRGZUa3hYOEZWSVFQWVQybkhZcG5OaUpjNXNuNjhuMk9HTjlwZFZ6WGt1?=
 =?utf-8?B?dHo1UTBmWGF5VTB0VzJiQmkzMjV6eTlFRDFwTnVqK1Qza0tHUlZOc1hNUERM?=
 =?utf-8?B?cmV3am56bThtTWtKdThnbENmd3c1dmJjMkpabVVtUWFna2dtV1ZoSXNhK2My?=
 =?utf-8?B?UU5mWVpNZEcvM29aSHM1WmtMeklROWovRFRnYkFsclByeVlOTXZ6Q1BXUk9n?=
 =?utf-8?B?dG55Yk0zZkNpUSs2ZUdUMUdSVGNKSlg0ZzBTL0wyYXpnY3ZzUGZHY0xENUNi?=
 =?utf-8?B?UWxLWlJIVGUrQy81OHJkRXU0dFBXdHdOLzZqV3dYOU0vZ1g1ZWkxUTFyRmJy?=
 =?utf-8?B?QWR6YURESHhFd0JaclJiWmpKdUwrbnpKZkY0R2xtUXNMWHMrWVpXNnFpRUY3?=
 =?utf-8?B?dVp2RHM4RWVWVk8yQXdpY294eUJtQjNWQ2w5SFBSc05TN2g4ZzZzMGhBbFB3?=
 =?utf-8?B?M1NReCt5TmhFTDJOZE5iYmJhL290MFV4ekZlVjJQVlpUUWkyQjBrMmp5S0Rk?=
 =?utf-8?B?TFhhekJrbGpkZllLalBKWWFsT2lCNTZ1T3lIcExsZlFlakhmdFErYkxxWnMy?=
 =?utf-8?B?SXR6bm83ekgzNjhoTFQyZUhMZHAzTTBpclJrLzFPMkJWNEs5T0hyeVRvTmx2?=
 =?utf-8?B?QmVUTHZBeDBJRnhlcDQvaC8rRSs3d3dTQW5nd1hLdDNzV2lBWEZ6U0FtbFRW?=
 =?utf-8?B?NjFWaHQ2Z0ZmTlJHYU9pZE02VUptbkh0S1pXQjVGSU00ZkttdkNKS3pjS2tz?=
 =?utf-8?B?ajE5Q3NoMlVOMUxFZDdmTHlEbW9lK1ZMRzNxMFhicmR1TEtFazM0MGVaWTdW?=
 =?utf-8?B?blUwVEhVWWNmQ2J0V0N1OTIrN3JXNUFuTytGWm1lam9sY1pnM2NpdlJPVWNC?=
 =?utf-8?B?YkRtcjBpd1RVOTlMcmk2VEU4TGEralk0cEhkYXFvWHdIcHNUTEtUWDhUTzI2?=
 =?utf-8?B?REpTNnIyMStNS0pWMDZ1Z0tUTDRiUEc0YTEyd0RZL1dxN0l0TFVuUXdTZmVn?=
 =?utf-8?B?SmcveU9TZFVHNFU3allsalRnUjdyTmFxNmEvUTNWZ0czeE05TE9RNDdMbU5V?=
 =?utf-8?B?ZlBCWWhoL3BLZ09MVlZvdE03S0NvaGpyKzlkczdqMkpRcnd4MFpqNTlaakpX?=
 =?utf-8?B?K2loUm8vdC9pdmE0SnIrTWI4aS80c1QvaWZUTHNiV0txTFRXMXBIWVhKYjZM?=
 =?utf-8?B?RGo5eGcydXZDZFREQWx6UklPT1JBTFBhQmJCUStNR1F5UU83ZEEvNm1Sa1Nt?=
 =?utf-8?B?WThkOUF5dkFSUWp6V2JHUFJsd28zbitVY3FMRThhUERTSFdlWUhqQldmQWZP?=
 =?utf-8?B?bGJJek5GdDdyRHdrZXllTFJXRHJkbFhqS1RnRW4vSDQ0WkM4ZXNCeDVWUU5P?=
 =?utf-8?B?a252RFdvVXByV2JZNUpDSDFONHlGS05pWkFzTVBBbFFreXF2dlJyUmJKWTJV?=
 =?utf-8?B?cjN6bUljSURiSEtMM3ZpcGxGcHZ5bXFxaWpCMXQ0dWg2ZHQwcjFvZ3pXbTBQ?=
 =?utf-8?B?TzlKc2tkNTNLUW15aE51eVh3aGJIMld0SFV5SkVEWUVIWEFlbmx5VThVdWZ5?=
 =?utf-8?B?aDJCNFpwRFE0djVmSHJhbHdNK3UybVhXaUZhbGpBK2YwZmt0R0ZXeG5LNzhp?=
 =?utf-8?B?Y0g5bEJBaStoUWViZzlnVkR1NXZTejBZazh3V0Z4ajJQdXVoUUw4V2FOQXNj?=
 =?utf-8?Q?2jpcYJsahJ3XDPu5U8ETTTbh7qdbyqkD1x/fG?=
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fc4a9f-fa11-47fa-bee5-08d9e6e1f5c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 06:54:01.4196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w/xdIkrl5eitAQCDjHcHd+cNVAKCpUzUieJ9ZH24c3COvBDErq0MG1FfP7bL2qefaiVmKdGOHM3Q5vDy9BP/1x6h+m9k8CO5KyHbNhCt62Ay24WZVFPVxMt9M7rjwE+L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8854
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Geert-san,

> From: Geert Uytterhoeven, Sent: Wednesday, February 2, 2022 8:07 PM
> 
> Hi Shimoda-san,
> 
> On Wed, Feb 2, 2022 at 11:48 AM Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > From: Geert Uytterhoeven, Sent: Wednesday, February 2, 2022 6:24 PM
> > > On Tue, Jan 25, 2022 at 6:36 PM Yoshihiro Shimoda
> > > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > > Add support for R-Car Gen4 like r8a779f0 (R-Car S4-8). The IPMMU
> > > > hardware design of r8a779f0 is the same as r8a779a0. So, rename
> > > > "r8a779a0" to "rcar_gen4".
> > > >
> > > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > >
> > > Thanks for your patch!
> > >
> > > > --- a/drivers/iommu/ipmmu-vmsa.c
> > > > +++ b/drivers/iommu/ipmmu-vmsa.c
> > >
> > > > @@ -743,7 +744,7 @@ static bool ipmmu_device_is_allowed(struct device *dev)
> > > >         unsigned int i;
> > > >
> > > >         /*
> > > > -        * R-Car Gen3 and RZ/G2 use the allow list to opt-in devices.
> > > > +        * R-Car Gen3, Gen4 and RZ/G2 use the allow list to opt-in devices.
> > > >          * For Other SoCs, this returns true anyway.
> > > >          */
> > > >         if (!soc_device_match(soc_needs_opt_in))
> > >
> > > There are a few more references to "Gen3" that can be extended.
> >
> > I'm afraid, but I could not understand this mean.
> 
> I'm sorry. I mean comments that currently say "Gen3", while they are
> applicable to R-Car Gen4, too. I think it would be good to update them
> to "Gen3/4".

Thank you. I understood it. So, I'll fix it in v2.

Best regards,
Yoshihiro Shimoda

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
