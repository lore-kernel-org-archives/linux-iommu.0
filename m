Return-Path: <SRS0=KP5g=OF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92163C433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 15:43:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C61961155
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 15:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C61961155
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B81CE400EA;
	Wed, 15 Sep 2021 15:43:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6kMn4DzfV-Eb; Wed, 15 Sep 2021 15:43:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 67D4340152;
	Wed, 15 Sep 2021 15:43:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3CDD3C000F;
	Wed, 15 Sep 2021 15:43:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25D71C000D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 15:43:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 07FA782BF4
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 15:43:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=microsoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zszxEoCeBMzi for <iommu@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 15:43:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from na01-obe.outbound.protection.outlook.com
 (mail-oln040093003015.outbound.protection.outlook.com [40.93.3.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 13B6A80C30
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 15:43:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pa7/lJ0isyv1RsJkef3bXdrVB2sNPu/Zywzz7J/m101ACUDYMwE95b0ueLrM5xmaWMVnnvIlFPmrm0yY/eni1t+j7kC+/EhXbnPzlV0hyMQTjjlpEpi/tvB2eP7tKewm53Nh0/laZV9kcgnZD2n4MVQD7/l++wfoasYOv6awx7VKQQ/NB+GzAAgIT3xzrW0KQBr3Jv3OT9ugE90H+McJWrglGTbZnb55y5efE0N/OyU/RhfB6BvaxveCNMiTWKJsLC0ANVgRBT/tb0FpFAXYlzNto5c/5USSCDR6doNSB/Y7g4vjBxWdQHyQr6MQWlKfNz8c6Y1Grc8HFbwEh+Y5TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=ZTCgiElrCg7vhUsB24F98StewJFC6DipKoz7OVeqwGM=;
 b=n9AZkHSvTGdBV1Z+PEq/dZ7Oou/TcBnRr3gnBdQ4a8AevXhYxRo+NFLn81ZJlmLXCh8SMplObvYseDxVpqXXQ3DDLu7jmivZcUUUWXi3wR6uL1zuLvNwZxcgjsoLiT+f8MeEDlzS7whFaffkEI52r06Rfe0yHLFrTYJvOLFFirIzW0rlysiWv8CSYA1hPpVvJaxQfeUm80ZY7Rgbji9yY+oIZGoZYSIM0IghjFW9DqvssibwKjXv/ngsoqdiIVG0D+Qzhi01S6P6yc+T2thNMSlW1fa2b8YUSSyMk7Q6S/+oJw/yF/CTQQCVzxOCNR5fHa6IZZJ7W8o/jChfSTk5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTCgiElrCg7vhUsB24F98StewJFC6DipKoz7OVeqwGM=;
 b=grVySTjNQGhIpHC4lbE6hSF7KJpTDTxLtbUHLF271YKz2i4FhEPPqFWNpiOe2ZuiUDvyH4HFqTw9p6jtaS0pCBhGoO1421ozmacRXF7OmYYur+YgbVLvy3rjPJLLWGfBrNEs788RGKOEm4JtH4gI+i1zx48p2eEDESo0xTapt+8=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW2PR2101MB1819.namprd21.prod.outlook.com (2603:10b6:302:8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.2; Wed, 15 Sep
 2021 15:43:19 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9cb:4254:eba4:a4c3]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9cb:4254:eba4:a4c3%7]) with mapi id 15.20.4544.005; Wed, 15 Sep 2021
 15:43:19 +0000
To: Tianyu Lan <ltykernel@gmail.com>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan
 Cui <decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>, "jgross@suse.com"
 <jgross@suse.com>, "sstabellini@kernel.org" <sstabellini@kernel.org>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
 <kuba@kernel.org>, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de"
 <arnd@arndb.de>, "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "brijesh.singh@amd.com" <brijesh.singh@amd.com>, Tianyu Lan
 <Tianyu.Lan@microsoft.com>, "thomas.lendacky@amd.com"
 <thomas.lendacky@amd.com>, "pgonda@google.com" <pgonda@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "rppt@kernel.org" <rppt@kernel.org>, "sfr@canb.auug.org.au"
 <sfr@canb.auug.org.au>, "aneesh.kumar@linux.ibm.com"
 <aneesh.kumar@linux.ibm.com>, "saravanand@fb.com" <saravanand@fb.com>,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "tj@kernel.org" <tj@kernel.org>, "rientjes@google.com" <rientjes@google.com>
Subject: RE: [PATCH V5 11/12] scsi: storvsc: Add Isolation VM support for
 storvsc driver
Thread-Topic: [PATCH V5 11/12] scsi: storvsc: Add Isolation VM support for
 storvsc driver
Thread-Index: AQHXqW4MrZFcBidRP0G2YSZHLzx10Kuj1Ldw
Date: Wed, 15 Sep 2021 15:43:18 +0000
Message-ID: <MWHPR21MB1593D62DF0B70278C57B20F1D7DB9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210914133916.1440931-1-ltykernel@gmail.com>
 <20210914133916.1440931-12-ltykernel@gmail.com>
In-Reply-To: <20210914133916.1440931-12-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7367a701-4304-4332-8506-b3f032e7ce4a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-09-14T18:10:23Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e5b4933-f8ca-4200-1ce2-08d9785f8a92
x-ms-traffictypediagnostic: MW2PR2101MB1819:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1819AA6F52E2B59BAB51F514D7DB9@MW2PR2101MB1819.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:619;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q4Odije4pLqjrE+nh/8l2cew/C9G1KtuLAEd68EUdsJVMGlI1Z/Q03sbEe7iO1ctgBz59d1SiOEp6CdEkbnexF9+HNSsqo48Ux5rp9xkQxzpMPx7R4ZhukfR65xOxzVXdvwx/KEbm2XP/gksKundHqitbVhYi+gYDY6rUYId3ctYXTXUPhSPNu1DLfru9QCPeBDrIU48qkwrueZiakjRNFwaASqsFmUmLpr0T9KAsB6m28yxl3/dx95L51X6lqgoKVTXTxwILz9zoZ4rMl4QPkh4GllWBtzptGXhpHlkB59n/ySUvbR0Cth6LNGFWT965pflb1/l9O6AzAFbNJFo659DDXcu8nLbyKtVca8vWXxI5ZcDzxbkDmCoVsgRY62KbxVrPtXhQm60qhLQzZotOuWta5lnjZ2Q7wA8awS2zNYR1D4Ct6R7tBWmerGhOEzQwcb4FvhtO1T+y9w07enVMayQaMfvhbpwV1YFWuFniPCdMCOG62ecQ4QKcCtxhhuLUiKpCW6E4yTYQBkyTTo1G+FRxgCIx1NXN6o7tDo1vOhD4UDfmVTYR24D8w4meJ8xvaZds85GG/XDKlx2uVoU+cX8sJjCh2/8gj1Wg5Sb/4zAPg8j7PCbuTEigeynrSZ1V7rhTwpgHYicZOFkMtotNF8c0+XOOPJZEGQ/u8SsAIGdOd9Bg+Og0Wg0jMotMILGkcYHs2MhdZwqCgtRY8nR6uv3zc3tWczy62PjgcNCNXw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR21MB1593.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(921005)(71200400001)(110136005)(82950400001)(54906003)(5660300002)(10290500003)(7406005)(6506007)(9686003)(33656002)(8936002)(83380400001)(66946007)(38070700005)(38100700002)(316002)(122000001)(7416002)(55016002)(26005)(66556008)(66446008)(86362001)(76116006)(66476007)(64756008)(8676002)(508600001)(7696005)(2906002)(82960400001)(52536014)(4326008)(186003)(8990500004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Akx3w9h7DWQOdOqAMTijFtFz87wpWZTK5Rm8Nv8k+RsCBMvmbLyJ8IilP7BW?=
 =?us-ascii?Q?ieTOpzIzeTUIODhGUzt6la+DISoPi0C6BFLKbK322HN+iL981+pYUXlLWISF?=
 =?us-ascii?Q?/c36Qi40Fn1zYUOn8yqgdvPnN57TkimvcpaCMFaKQbOPNBNhMUdnO2bnwsgk?=
 =?us-ascii?Q?msDoUeIyeKRzEY+DfjShumrjGc9JXndvvCnPOSSDPqan804G6DuBSq2QLDuM?=
 =?us-ascii?Q?qpqBTaFZwx7inWZLGDJaSn/FhE2Tv3DefyIjuTK2aVSLNXQTmToYAmjHo6fv?=
 =?us-ascii?Q?P7MRWqqV1nk4b5Q9v9v4B9Q4MJEMzj4krJPlTa8ZwLDi7Le3QvGMyFQj7G6S?=
 =?us-ascii?Q?Dm73bm1AXFlHlHADJZ5mwgVz+FBKJ4sUmscvuL8Q23D1/EJmzEq2vWoQRrxz?=
 =?us-ascii?Q?EApmfxzlwwsz+bsJD7/Dm3vqhTLjwj6u4pLTRRfkBHhRuUAhj6fQsQYu1nGq?=
 =?us-ascii?Q?BoG8OcrOkqNJ+kiCvlLHhEdjqy5CXML6vOybgncjzHdsaorF2ep2Xkgfznxk?=
 =?us-ascii?Q?wK4hP78xcRv9XqaJocBuWd3Eh/2bvkNJsY2rx940gE21YLkdOf+GiSySX8Q3?=
 =?us-ascii?Q?qwmFkAkPGnSPsZF9gWi/HqV9U8LOljt4K+1N0HCJ77c4KU9WN6QDVrM6rpkI?=
 =?us-ascii?Q?ZMA9HYtC6eF2BuzLt82KxHT+Nyc1TMRD1hbtOPebm221Opql7cXSOaZj/JLX?=
 =?us-ascii?Q?/EQvIVkTcgqWSnlwusGcx6E66aePJErB4dvWOhj/8JMfbF/4Y02nkbb+wkvO?=
 =?us-ascii?Q?Z/wm8o0ZJe8WPKaJTCxtuI/EHFPxvywtryg4Lo9xDS8tiTJp+kS09YrxJldQ?=
 =?us-ascii?Q?otjblrrhWq/rGNbO3XkoB4BZP6410ZP9a9UFOZMh82fslrHYCGc3BIXWvH2y?=
 =?us-ascii?Q?FNZFbWyM66hg2VXJEK1mCz8J5kb+mgZ8XjrKSQxYmq8BgyriBE4FwLX1PaoN?=
 =?us-ascii?Q?2g3WihNlDjzPTrVdhLi4oE+aBcMP1Kxz24cIJVddVWHQwiEvagFegNwFe2py?=
 =?us-ascii?Q?MrXB8gXwuDTS1j3LpAp/T2ebpZaudpGgSZXpXdoScxZqPBTsWvdipPutrrMd?=
 =?us-ascii?Q?K92u4kLicqbitY60PQeGeWpl43yhUA8dfixtAYBy7oGig6bXecvfooTKWAr3?=
 =?us-ascii?Q?G68BgOYSxfn3nqdkSUoYUAS0hZ1JvNU7bkoIA+oyejDsxUJmz8nbAKzyXgbh?=
 =?us-ascii?Q?xFnzk/zBUaYszPX5aBLXYlBLed+nEJnjrqBDOlFr2FH87NGr8LXe4vYOzn09?=
 =?us-ascii?Q?7VKaWpUZvvswV0GDydsvYv9PTd2saXt+eCfZrHAWQh1TRrpmaxDxoDXP/Dnp?=
 =?us-ascii?Q?VFD6nO2VrqVTr2nrY7tG9yCT?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5b4933-f8ca-4200-1ce2-08d9785f8a92
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 15:43:18.8355 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kp0xEe0j2pR4BSITs9K5GMBsLwALC2OIrPcOEdzxPZciX4M7fP0RFZuuHYpQrngsWUsW44NT+9VJFDi1AUVO8F/nBa0IliJ7P/hTuZHlezI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1819
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dave.hansen@intel.com" <dave.hansen@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 vkuznets <vkuznets@redhat.com>
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
From: Michael Kelley via iommu <iommu@lists.linux-foundation.org>
Reply-To: Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Tianyu Lan <ltykernel@gmail.com> Sent: Tuesday, September 14, 2021 6:39 AM
> 
> In Isolation VM, all shared memory with host needs to mark visible
> to host via hvcall. vmbus_establish_gpadl() has already done it for
> storvsc rx/tx ring buffer. The page buffer used by vmbus_sendpacket_
> mpb_desc() still needs to be handled. Use DMA API(scsi_dma_map/unmap)
> to map these memory during sending/receiving packet and return swiotlb
> bounce buffer dma address. In Isolation VM, swiotlb  bounce buffer is
> marked to be visible to host and the swiotlb force mode is enabled.
> 
> Set device's dma min align mask to HV_HYP_PAGE_SIZE - 1 in order to
> keep the original data offset in the bounce buffer.
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> Change since v4:
> 	* use scsi_dma_map/unmap() instead of dma_map/unmap_sg()
> 	* Add deleted comments back.
> 	* Fix error calculation of  hvpnfs_to_add
> 
> Change since v3:
> 	* Rplace dma_map_page with dma_map_sg()
> 	* Use for_each_sg() to populate payload->range.pfn_array.
> 	* Remove storvsc_dma_map macro
> ---
>  drivers/hv/vmbus_drv.c     |  1 +
>  drivers/scsi/storvsc_drv.c | 24 +++++++++++++++---------
>  include/linux/hyperv.h     |  1 +
>  3 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index b0be287e9a32..9c53f823cde1 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2121,6 +2121,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
>  	hv_debug_add_dev_dir(child_device_obj);
> 
>  	child_device_obj->device.dma_mask = &vmbus_dma_mask;
> +	child_device_obj->device.dma_parms = &child_device_obj->dma_parms;
>  	return 0;
> 
>  err_kset_unregister:
> diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
> index ebbbc1299c62..d10b450bcf0c 100644
> --- a/drivers/scsi/storvsc_drv.c
> +++ b/drivers/scsi/storvsc_drv.c
> @@ -21,6 +21,8 @@
>  #include <linux/device.h>
>  #include <linux/hyperv.h>
>  #include <linux/blkdev.h>
> +#include <linux/dma-mapping.h>
> +
>  #include <scsi/scsi.h>
>  #include <scsi/scsi_cmnd.h>
>  #include <scsi/scsi_host.h>
> @@ -1322,6 +1324,7 @@ static void storvsc_on_channel_callback(void *context)
>  					continue;
>  				}
>  				request = (struct storvsc_cmd_request *)scsi_cmd_priv(scmnd);
> +				scsi_dma_unmap(scmnd);
>  			}
> 
>  			storvsc_on_receive(stor_device, packet, request);
> @@ -1735,7 +1738,6 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
>  	struct hv_host_device *host_dev = shost_priv(host);
>  	struct hv_device *dev = host_dev->dev;
>  	struct storvsc_cmd_request *cmd_request = scsi_cmd_priv(scmnd);
> -	int i;
>  	struct scatterlist *sgl;
>  	unsigned int sg_count;
>  	struct vmscsi_request *vm_srb;
> @@ -1817,10 +1819,11 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
>  	payload_sz = sizeof(cmd_request->mpb);
> 
>  	if (sg_count) {
> -		unsigned int hvpgoff, hvpfns_to_add;
>  		unsigned long offset_in_hvpg = offset_in_hvpage(sgl->offset);
>  		unsigned int hvpg_count = HVPFN_UP(offset_in_hvpg + length);
> -		u64 hvpfn;
> +		struct scatterlist *sg;
> +		unsigned long hvpfn, hvpfns_to_add;
> +		int j, i = 0;
> 
>  		if (hvpg_count > MAX_PAGE_BUFFER_COUNT) {
> 
> @@ -1834,8 +1837,11 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
>  		payload->range.len = length;
>  		payload->range.offset = offset_in_hvpg;
> 
> +		sg_count = scsi_dma_map(scmnd);
> +		if (sg_count < 0)
> +			return SCSI_MLQUEUE_DEVICE_BUSY;
> 
> -		for (i = 0; sgl != NULL; sgl = sg_next(sgl)) {
> +		for_each_sg(sgl, sg, sg_count, j) {
>  			/*
>  			 * Init values for the current sgl entry. hvpgoff
>  			 * and hvpfns_to_add are in units of Hyper-V size

Nit:  The above comment is now out-of-date because hvpgoff has
been removed.

> @@ -1845,10 +1851,9 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
>  			 * even on other than the first sgl entry, provided
>  			 * they are a multiple of PAGE_SIZE.
>  			 */
> -			hvpgoff = HVPFN_DOWN(sgl->offset);
> -			hvpfn = page_to_hvpfn(sg_page(sgl)) + hvpgoff;
> -			hvpfns_to_add =	HVPFN_UP(sgl->offset + sgl->length) -
> -						hvpgoff;
> +			hvpfn = HVPFN_DOWN(sg_dma_address(sg));
> +			hvpfns_to_add = HVPFN_UP(sg_dma_address(sg) +
> +						 sg_dma_len(sg)) - hvpfn;

Good.  This looks correct now.

> 
>  			/*
>  			 * Fill the next portion of the PFN array with
> @@ -1858,7 +1863,7 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
>  			 * the PFN array is filled.
>  			 */
>  			while (hvpfns_to_add--)
> -				payload->range.pfn_array[i++] =	hvpfn++;
> +				payload->range.pfn_array[i++] = hvpfn++;
>  		}
>  	}
> 
> @@ -2002,6 +2007,7 @@ static int storvsc_probe(struct hv_device *device,
>  	stor_device->vmscsi_size_delta = sizeof(struct vmscsi_win8_extension);
>  	spin_lock_init(&stor_device->lock);
>  	hv_set_drvdata(device, stor_device);
> +	dma_set_min_align_mask(&device->device, HV_HYP_PAGE_SIZE - 1);
> 
>  	stor_device->port_number = host->host_no;
>  	ret = storvsc_connect_to_vsp(device, storvsc_ringbuffer_size, is_fc);
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index bb1a1519b93a..c94c534a944e 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1274,6 +1274,7 @@ struct hv_device {
> 
>  	struct vmbus_channel *channel;
>  	struct kset	     *channels_kset;
> +	struct device_dma_parameters dma_parms;
> 
>  	/* place holder to keep track of the dir for hv device in debugfs */
>  	struct dentry *debug_dir;
> --
> 2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
