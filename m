Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F97EC433F5
	for <iommu@archiver.kernel.org>; Wed, 16 Mar 2022 18:34:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2937740935;
	Wed, 16 Mar 2022 18:34:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c2WhiqzEyFZM; Wed, 16 Mar 2022 18:34:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AB36E4089B;
	Wed, 16 Mar 2022 18:34:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 657BCC001A;
	Wed, 16 Mar 2022 18:34:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE31DC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 18:34:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC1AC60AD0
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 18:34:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N-otuD0jpBq5 for <iommu@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 18:34:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::617])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D95B3607A1
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 18:34:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjnWi79L6zinRPgINI0lbIWS9OFRLPefgzR5UU0bb67VePakkhrrBOUjNuaNBLwkJd40F7kU8RCFzwRWhnJjv/p4SZdm5Yi5oSyreLwFPeDLbzn8otyUTXdgyNXapQ87LgRPcrV03gkdf6E/HxFzodzdf23MZAe9rSuLZIQX+oqqIeTggd35dqs/OH6PRVgwvxzbVkqsRnfaUsePtlnJx/TGlfifnUR+2768zMvrOHyRipohNT6mp36B7KBV9yOddKxTy5GuTKbLwGYN83YHtMGfgnOT6SddMuNYembBgEepIU9fRdl2+VR1XJNZc1VA6Qa0f/3aTbyX4BDqq1oAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YAAZE68DYplUVuJSFt45ONa2GpXRxNrem62vI3Ik/b4=;
 b=C9Yk0xK/NHzszK9nJypqMvdt2uMBvm+TsFr3wjUQC3mEM0aruy8J32r/FVltMEnWjsIH8vCOraku3Rak4PayD+G11EFJ5aiExbOzX04DjcMa8Rim7fOOYe58b4H7AQlkDkivv9Fv2bg5yr3XLJFG56PTGJJvLWCTJeQl87Q96nd+ItGlXPTtxV0PGuFr49HXDRq1IX5xbPawwOrWZZkgyW1K/VowcdrBdef/1VtDr9esbcdysImbuPFJCHmo2f/Bgb0uHaukPl/tqHsVMtU0FC/N8nplTxEYGVAZSN7ECfT5kdWpBOorMzIyUjxDHjW6hbD+uSB1qeQPajykkQVwsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YAAZE68DYplUVuJSFt45ONa2GpXRxNrem62vI3Ik/b4=;
 b=wJvL7B2NL3VSF3rwuDW17CpJTYJAK8yGROwGTk0ORacNmExmE2bFKRuU+m4G/QNYDreU1MEa324aydyY/s1Eipg8G04iZIeX76QXb8v0M3Vy4WkCb3J1mlRYdlPGXAAM/h68tWtJh7vYtyMNZCdhLxGduui8OO8/HStXZGuCWgQ=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by DM5PR12MB1499.namprd12.prod.outlook.com (2603:10b6:4:8::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.26; Wed, 16 Mar 2022 18:34:51 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::692d:9532:906b:2b08%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 18:34:51 +0000
To: Robin Murphy <robin.murphy@arm.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH] thunderbolt: Stop using iommu_present()
Thread-Topic: [PATCH] thunderbolt: Stop using iommu_present()
Thread-Index: AQHYOSidJZwMFUwbGEibeELZIyT74azB9QiAgAAiooCAACnRgIAAAPcAgAAEJICAAANtgIAAAECwgAAI+YCAAALbUA==
Date: Wed, 16 Mar 2022 18:34:51 +0000
Message-ID: <BL1PR12MB5157380CD6FD9EB83E76CBB0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
 <YjHb1xCx4UAmUjrR@lahna> <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com>
 <YjIb+XOGZbWKpQDa@lahna>
 <BL1PR12MB515762E68F3A48A97EB2DC89E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjIgQfmcw6fydkXd@lahna> <3bb6a2f8-005b-587a-7d7a-7a9a5391ec05@arm.com>
 <BL1PR12MB5157DA58C3BDAFB5736676F6E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <5ef1c30a-1740-00cc-ad16-4b1c1b02fca4@arm.com>
In-Reply-To: <5ef1c30a-1740-00cc-ad16-4b1c1b02fca4@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-03-16T18:32:55Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=de44ae11-ae46-4d48-9404-a55278285b98;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-03-16T18:34:49Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 73256343-769f-4a4f-a1a8-ffd6b6bc58cb
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ea0f199-b7c2-4df9-3a7a-08da077ba8a7
x-ms-traffictypediagnostic: DM5PR12MB1499:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1499E9E6A4A8602028C68F2CE2119@DM5PR12MB1499.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vH8qwzZXVFZb7IFNcHZMsFSwafjK/ZDrg9PblPArRfIrJfpcg9qGJoJDjikNuUx2K/5ApR7FRCmsM4jAL+35dQRol7IChLbg51dx6pVJUUZBx5e72wyR2+zHZnkesdKI4bhgio/lO/JAE11tyTWQ/cFJ1On7Qgf/0jZE8ByCdlIcZ9ly4Cs3juICZbECm6S8j8DXHgIGaJ0l3IGoO00VfcWxlGkDwMuGchGFL34cLQUWPcNk3mWUesDeNuloPFIytpJdPNZ6pYgEFxfrjnnBqNpVvYPomWTk64sNSGH15onzODcJb30D1s7elq1zLY9Bty9RAqTGbnmSSK3cnExe8W2DC5H+gccRdrYfDRqFf1ZhSadX/ohjEAYbhCqy7Z+5V+ULGyX8v60/1fT6vvlMbti0C8BslyghPM0XfFgrtkNoPC5eKFofpy43iNPLypRDlXLKyExbB/zuVq1df9ujzBESULsqvN0yAbNY4PYvOC+gnueI7MCZFZpwQkb2p6xVTWRa7mmmdO1lbNOzAmC0LgnBXLukCGk4JvGm7yRSvOxrua1UDtXWgMQCjjaIF8wqTM2TJZPQAA9U8SCMuiKOVRA4efQlbG8c1xc6kJIUaZmbSsaeQiIUM+33D/JI/kK66SqpEPYQsep6UV1tTmuiqXczHpmrGvQLgyLJvcu7FYvADsP7FFLsP5tQo+mcJAp33H6K3d6EvdWcqcFFfHzLtg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8936002)(45080400002)(71200400001)(76116006)(66556008)(66446008)(66476007)(52536014)(64756008)(7696005)(508600001)(38100700002)(6506007)(5660300002)(33656002)(66946007)(186003)(9686003)(122000001)(110136005)(54906003)(316002)(83380400001)(8676002)(4326008)(38070700005)(86362001)(55016003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SwEZ9ZExyW5D5g3j+WpZicXuU4QhBVuu5CZdAGN0h8ZOioTaJx+dXTGNFt1b?=
 =?us-ascii?Q?cGHWpI0w21zlpBHrD55bk+Ws8DdfZFDMbz4KUfrkOLeNAD/qmjNLuVTK62I1?=
 =?us-ascii?Q?VYytzIv5H5C01tk8e8ZsxO4XabubonZ59+gg1CgT5b1TGPrVU1uYWM/z88Hm?=
 =?us-ascii?Q?ZJnpTwr1loIgjeUiZmTi+sAEU/fjVXjYD07Qn4dkXsitAP/T89Rkej+zwCld?=
 =?us-ascii?Q?fvHPMdrKsuSJnK5jMe0t4NFlc2Wnf3waUmlyxAsZEMVsZp5XuBs2BMQrFJwI?=
 =?us-ascii?Q?ADAgmQ6MtmkWX32qErmu49ab89+0Is1Br92qSC9c4+x8Dof/b9NPwXlo+3Y6?=
 =?us-ascii?Q?FE6cTNhHGVQx0t9xtTBbE/Bemq6MCMCsB2hY6O5LfsVbI39iTppxvKBevprz?=
 =?us-ascii?Q?fH5dzGFnh/gODaGYZ7PnuQNeDaaM1z5N77vSN3ltjYNzfU7gee4iMRrO/Mde?=
 =?us-ascii?Q?t+mr/FhQ409kxALeNyGrUbqwe0b+H/HggXd010jchhuUVPKjx07uLh/OHIC8?=
 =?us-ascii?Q?wT3bAPZ378nWyg78zUyDJVZARJhVn1JdbhuNqsQJdremeHsjpDLeR11zA1QR?=
 =?us-ascii?Q?8vfUBABpE5EURQVSBd0sCSdKdPpUQ57coc5KXJO2X3nmB0xKutkZ6xUElPj7?=
 =?us-ascii?Q?kAvUqHex9vc0O7otH2MsuKn856SdU0aQ0KomlP1XTi0XNCmquqsVnR79XYQm?=
 =?us-ascii?Q?rii4OBZIu13sZzr447zw1MSC9xd2072EmZyPEz1rdXalONOOuWzFqzYfYQW1?=
 =?us-ascii?Q?qAZQhx2kOfY3ToXM+b3GIwN3my5tVaMql+t5VPDjNtl1s4/y6Sxc0DD49643?=
 =?us-ascii?Q?vb9d+OB4xevHiec/guvcjstE0Ffe4CMVi0f0peE/0T39EHeRvGPon2UCoF01?=
 =?us-ascii?Q?ru5yMXxn/r5oXPgEjbaQkhtD76Sbbo+DTEtoBsaxYXouTI8GTLPiZOBwCkx0?=
 =?us-ascii?Q?OgiEtvLy+f/aN5Dp7HgrsiIRprT8/ClyINDawG+qn1bgDPbH71NczZMjJLfr?=
 =?us-ascii?Q?LxuATVHa0QIURFDHkLp0E/n+H2K5M4sVK8yOnhrIjwYrGlL0TKbd7fDa06Lf?=
 =?us-ascii?Q?AQ4PowLG3onuNl5n5UAhO8hsHVNz4yTfsskweNkJ512R/Xu3Mj+UpdidvEMN?=
 =?us-ascii?Q?Ck6CrPHU28lDZOB6jw+6mCaOkH/J6XQa+FaeA7UHAIsARmPpTJFSrMwT9sgs?=
 =?us-ascii?Q?BFXr8b4T7kGhSBzHSJQZRfCBsYBDxj1URvd4D5B0suhskXCJL6ruUQ4PPo+r?=
 =?us-ascii?Q?9V7Qi+RwjtB0tlEftWNUGanp8aEJnyjbdOOF5+SlFrzoTOU7ldAUGt2wP9x2?=
 =?us-ascii?Q?dHG9mfCvEQF+yMl5m41j9rZsD4mdGnfgOfrTqiX4tClieuI2UGoqP+nSuFl7?=
 =?us-ascii?Q?dnXNrGTXsclJGs/gMnyvdllUW28hJiGdNUHjbF9FMU0R9ZNgxKmtSL3z4ffP?=
 =?us-ascii?Q?M76wZlrjarGP6emeRZsBdcszkP//QD4yuhqsaQaF271/ARzQrSKkBkogqN6u?=
 =?us-ascii?Q?6sv+A941aq4gl1lrrZWnn1Lkb/YKn0G7Ic51?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea0f199-b7c2-4df9-3a7a-08da077ba8a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 18:34:51.7000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 04ZNGwBjtFA1kIf1F3jqFbKMi6tYk1aCRXNYiXNHZBV6C8D/EW0kUB7GF1jpjcXaWl/AH2CBUAByAxduYdlVzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1499
Cc: "michael.jamet@intel.com" <michael.jamet@intel.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>, "hch@lst.de" <hch@lst.de>
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
From: "Limonciello, Mario via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

[Public]

> > Can the USB4 CM make the device links in the DVSEC case perhaps too?  I
> would
> > think we want that anyway to control device suspend ordering.
> >
> > If I had something discrete to try I'd dust off the DVSEC patch I wrote
> before to
> > try it, but alas all I have is integrated stuff on my hand.
> >
> >>>> Mika, you might not have seen it yet, but I sent a follow up diff in this
> >> thread
> >>>> to Robin's patch.  If that looks good Robin can submit a v2 (or I'm happy
> to
> >> do
> >>>> so as well as I confirmed it helps my original intent too).
> >>>
> >>> I saw it now and I'm thinking are we making this unnecessary complex? I
> >>> mean Microsoft solely depends on the DMAR platform opt-in flag:
> >>>
> >>>
> >>
> >
> > I think Microsoft doesn't allow you to turn off the IOMMU though or put it
> in
> > passthrough through on the kernel command line.
> >
> >>> We also do turn on full IOMMU mappings in that case for devices that
> are
> >>> marked as external facing by the same firmware that provided the
> DMAR
> >>> bit. If the user decides to disable IOMMU from command line for
> instance
> >>> then we expect she knows what she is doing.
> >>
> >> Yeah, if external_facing is set correctly then we can safely expect the
> >> the IOMMU layer to do the right thing, so in that case it probably is OK
> >> to infer that if an IOMMU is present for the NHI then it'll be managing
> >> that whole bus hierarchy. What I'm really thinking about here is whether
> >> we can defend against a case when external_facing *isn't* set, so we
> >> treat the tunnelled ports as normal PCI buses, assume it's OK since
> >> we've got an IOMMU and everything else is getting translation domains
> by
> >> default, but then a Thunderbolt device shows up masquerading the
> VID:DID
> >> of something that gets a passthrough quirk, and thus tricks its way
> >> through the perceived protection.
> >>
> >> Robin.
> >
> > Unless it happened after 5.17-rc8 looking at the code I think that's Intel
> > specific behavior though at the moment (has_external_pci).  I don't see it
> > in a generic layer.
> 
> Ah, it's not necessarily the most obvious thing -
> pci_dev->external_facing gets propagated through to pci_dev->untrusted
> by set_pcie_untrusted(), and it's that that's then checked by
> iommu_get_def_domain_type() to enforce a translation domain regardless
> of default passthrough or quirks. It's then further checked by
> iommu-dma's dev_is_untrusted() to enforce bounce-buffering to avoid data
> leakage in sub-page mappings too.
> 

Ah thanks for explaining it, that was immediately obvious to me.

> > In addition to the point Robin said about firmware not setting external
> facing
> > if the IOMMU was disabled on command line then iommu_dma_protection
> > would be showing the wrong values meaning userspace may choose to
> > authorize the device automatically in a potentially unsafe scenario.
> >
> > Even if the user "knew what they were doing", I would expect that we still
> > do our best to protect them from themselves and not advertise something
> > that will cause automatic authorization.
> 
> Might it be reasonable for the Thunderbolt core to check early on if any
> tunnelled ports are not marked as external facing, and if so just tell
> the user that iommu_dma_protection is off the table and anything they
> authorise is at their own risk?
> 
> Robin.

How about in iommu_dma_protection_show to just check that all the device
links to the NHI are marked as untrusted?

Then if there are device links missing we solve that separately (discrete USB4
DVSEC case we just need to make those device links).
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
