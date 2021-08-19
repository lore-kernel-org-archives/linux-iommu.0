Return-Path: <SRS0=qbNH=NK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A1DC4338F
	for <iommu@archiver.kernel.org>; Thu, 19 Aug 2021 18:15:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2401860F5E
	for <iommu@archiver.kernel.org>; Thu, 19 Aug 2021 18:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2401860F5E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5828613AF;
	Thu, 19 Aug 2021 18:15:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yyLu5mdGDD0f; Thu, 19 Aug 2021 18:15:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BEF41613C0;
	Thu, 19 Aug 2021 18:15:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E7D1C001A;
	Thu, 19 Aug 2021 18:15:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC8F1C000E
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 18:15:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C54E818D7
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 18:15:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=microsoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GGa5FU3UO24M for <iommu@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 18:15:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from outbound.mail.eo.outlook.com
 (mail-oln040093003002.outbound.protection.outlook.com [40.93.3.2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C871980B3D
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 18:15:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSFxODerX4ZY5DtQyvl52o2xqc6E0O1er7f+HhXzGziX3zTDrOJiR418iX1Js8H224wjhyTYp0O4X322CUparF4SfnJQI/FhxzO/AMQlpai3UkYuRVA2Wz0qtENN426vTPT/H5zafnpgxug33lk0Ujajy0R2D3QH9wEHjr4KDhU9tWGKIl/mPgE2cBHyoTEmyWrRrcbwhORCNBdYdH7WCnaGKONMvuKDFXCtpuXdRJ/9vN94C/XtdpoHNAxWZyNl2PDDO27vJL67TGG9JypwR0gAQFdQDhQU0yRIiZj2NUZkH4NGntHWwWNDSSaOmYjFJBOubyRvOsFpS9bSrBHKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPje1EQkp0sgvXF7x/6+ErwISjkdzQKunUbLvGGhPpo=;
 b=B2QWlaPwC2gMmC9bPzLPqkKs56ogar/NgpDCHX92/tSDGLpDHj1/h7miVRnRgKKR0+txNC5JKWq0Dgp9IHVklU0BgfHhMARaj74eHuvUq/vyPlP5Db8RO8ivanPce3I+wELKnazgb3VHuTQyWCG32/on2wAjX8go5MwkM8e2nPCGTbUOWT5KTZhuctsAtpBlSuutl/fQPtM49oRYBiY6DaQ7yYZG1TJ20t38Vy22+/9siBykFrhxUL+f5W/ByJiU1CsAfMi04c7lHnv5JtHcpMnRw3kMzJw8Oayj6UN78Qj3huPJQsgE+V5rIS63nO4wrcfnt6Br7dPZ//e5d3Gvmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPje1EQkp0sgvXF7x/6+ErwISjkdzQKunUbLvGGhPpo=;
 b=O6EkUByemw/HGqjq/ETX0tmiNn4JWdwJjVc2AwkdkKXgWosigQK5rbH6fCasaCNSs7b1NMxaSSrTMCoBWAz5N2WTVltAuOKQLzgYOmeEsnLfFDw2CBMyP6dqYW6sEeXr0VKs+ZINs3T4cRPizDqSZCLKxqc3uk1GhjqVA4K4O5c=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0157.namprd21.prod.outlook.com (2603:10b6:300:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.0; Thu, 19 Aug
 2021 18:14:51 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e8f7:b582:9e2d:ba55]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e8f7:b582:9e2d:ba55%2]) with mapi id 15.20.4436.012; Thu, 19 Aug 2021
 18:14:51 +0000
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
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "arnd@arndb.de"
 <arnd@arndb.de>, "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "brijesh.singh@amd.com"
 <brijesh.singh@amd.com>, "ardb@kernel.org" <ardb@kernel.org>, Tianyu Lan
 <Tianyu.Lan@microsoft.com>, "pgonda@google.com" <pgonda@google.com>,
 "martin.b.radev@gmail.com" <martin.b.radev@gmail.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "rppt@kernel.org" <rppt@kernel.org>, "sfr@canb.auug.org.au"
 <sfr@canb.auug.org.au>, "saravanand@fb.com" <saravanand@fb.com>,
 "krish.sadhukhan@oracle.com" <krish.sadhukhan@oracle.com>,
 "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "rientjes@google.com" <rientjes@google.com>, "hannes@cmpxchg.org"
 <hannes@cmpxchg.org>, "tj@kernel.org" <tj@kernel.org>
Subject: RE: [PATCH V3 12/13] HV/Netvsc: Add Isolation VM support for netvsc
 driver
Thread-Topic: [PATCH V3 12/13] HV/Netvsc: Add Isolation VM support for netvsc
 driver
Thread-Index: AQHXjUf5b2VC7/Te4kWdqzzCQTFBL6t7Gw2w
Date: Thu, 19 Aug 2021 18:14:51 +0000
Message-ID: <MWHPR21MB15936FE72E65A62FBA3EF4F2D7C09@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-13-ltykernel@gmail.com>
In-Reply-To: <20210809175620.720923-13-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=98e42156-2e7e-486e-98a6-5afbdfc011ce;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-19T16:53:59Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a54f92a0-e9ee-4069-03e3-08d9633d3d06
x-ms-traffictypediagnostic: MWHPR21MB0157:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB0157B1E7993A28DF222D0A43D7C09@MWHPR21MB0157.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C+2FpoeDESJgH3DxEIPmcxYCfzmxgugj2ivBBKHXhf3DNiQ7KWtXZY0ah24+/iTniM+Y8m6NyDh+if/Kzc7b8ZN9ZfFwPHVjMlbmDwmfW5NVlNmVKMVqAneHQwoI0GjuArs2Y534jFsqPyMXwfZt24KoLuI9dWoxExwg05yI3BtivGijCw+j/5jvcuspgVBZR/iSLfkVNAKBTcybFl8kbsVsTK+aTMhA459ux9AT2tfebZiMQ4XyLdozD1Pxioe+g32BCnhnNmIdA6EKcMTv7LcDJg+vZBDVr5NdjrnDt9p5W0yUTyGOzpn608+nT0Dsqwm2Cq5MmOHTxob4MKD+QB9mZmfuICLoEclbnMfyhLI5rvQr2G+peZrBs9W0wbuNlmhRGTPXaNBlOxsa6g4d+PGpBq/LGwjG2BBpFEzu7zyu/7YJbumPLqxcBAb29Qxy48TClX990JPfAYUnfAjj6gM2Ow5j0uZA//3X6sNuwMaa4Jsu2czLoBRIANX7Eg6xaa5qqDgDndHAQJVI1N7zfEVs1V1ckDoND3hk7dDcnPsPKXXaH5E1xdgi6B0MdibMfvTPYG+rf5mevlMZKudxA6DW61FSj2OTdBPrhzFm3dH0xLnUAVwzJllhHH4A2UrVgMrOU9HNwW+E0n5eFE2/ahP4kRrUzJ5oaOdsRH1fAYcBqSdPq58oqZzfLNKMQQbwS7PVtgfM2dMJNZIbEm74n3Vvf3l+un4mJ1JxhPHmeRY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR21MB1593.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016002)(86362001)(8990500004)(316002)(26005)(186003)(38100700002)(71200400001)(33656002)(83380400001)(7696005)(30864003)(8676002)(2906002)(122000001)(110136005)(4326008)(8936002)(921005)(54906003)(64756008)(6506007)(82960400001)(82950400001)(7416002)(7406005)(76116006)(9686003)(5660300002)(508600001)(38070700005)(66946007)(66446008)(66476007)(66556008)(10290500003)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IVBG6WNbMPC+3oClPbsLzewhgBQ2hZC7sSa0aCm9VVvquSlR14k+wrTL1pJS?=
 =?us-ascii?Q?DI0WnBfMdc68Olqz/hyUhdg/XkLSOvBSokR6LwlM8kcVFpp3jndZrfKTY3uy?=
 =?us-ascii?Q?vnVD+BmYSvazRdJogH9OTH3etUt8nzL/FgC3LeP/tZ/dvxwZOW2HQUJYV3Fp?=
 =?us-ascii?Q?CEB40S1TNoY5WcQa1bVs7kM2HRPCgYlIpWF+U1RGdp55kKb2QmppENExfCeq?=
 =?us-ascii?Q?yD0W+FJFLiy9dJwlPdFI3uB3XB+PMUNVz+BplUPAyShPaUCGGpIWRVImhN1E?=
 =?us-ascii?Q?UW1mBV/dGREBbml3mkodaAchYUf8c2FyFx9rtzjaiqVWVJdJS5u4hcM3Wc6y?=
 =?us-ascii?Q?dBb2aiWcFjeMQG8DKuaJN3k46CLM9xPdScY8A6T+RPxOqKHCPKsQrhF1f+uo?=
 =?us-ascii?Q?DOSRL8QlkYEvz5N1Ytwb16OonXe5somKiMXKy8GJ/9FHv+yMO1rhg+QCE55/?=
 =?us-ascii?Q?tZV4caedS4PSzyhTcLA51HUKLRJZPMZcZZ8HidpVz6pmDsKotS/s8WIKR4hI?=
 =?us-ascii?Q?Ccx8TlezD7KgceLtlYdCHPHDAerVDLmJF9+g6WB9s+KSborLDfgZNdY9UaHs?=
 =?us-ascii?Q?Cs1w6tcu+6vBQUCP1agnBNQwyX3OItmFZDuj/WBCVp9gO0zcXPIazR3tcJMY?=
 =?us-ascii?Q?PizvkPPDlrA68hHl1c4MMyuT0pJvnChcelPBEKgduwRafNQqvqMnKQsBM0qr?=
 =?us-ascii?Q?kB66htuCWgBzRcb0TAQQA/PjZBaccXwr0WjK8Ab0MIK5krpT+YdGKBG5vICl?=
 =?us-ascii?Q?EWlxrhcL3c62Y+i0uxLmeBdtjAn6pZWLLfF/qhn40WdY8Kv1t6Lif5kEzQ00?=
 =?us-ascii?Q?hcY+O14dII5MePQr77DT4FHWY8zG9zkhf0PxIxtvhwQi/h3BqcD58JCl2wU7?=
 =?us-ascii?Q?2p+7b2eNq2PF0BNXQjfSUCK6YObe5GrhmJT+wLfDGTATolV4UuKDiMHm7XNw?=
 =?us-ascii?Q?dG65E5ZTX3qwPAoC7LGuG0fARY3mnledoeJgWHqyGg6VbKbTIQCMv7vOqpfL?=
 =?us-ascii?Q?969oC9cVz1USDeRSc7TWrd9vw50FW0wFIzrJGVqF0LSlmKRM4RBfa3X1iLmQ?=
 =?us-ascii?Q?oRezeJ9IqMBHsI3NS6vkrwA4fYP5XLA7xPikbO+PhbiHlfAcAtroiegRSDNl?=
 =?us-ascii?Q?IKWrYGmbOZfCP6i2QBFSxdR7oKPjIdbCMo0XMVmhTIup6TG4z72GKFRZrBNW?=
 =?us-ascii?Q?wHk2GL/O9ZXw4LzGfNMG2DBgW4Toza1K3LWa18tkO0D3XyE73dWIeKlgCYtd?=
 =?us-ascii?Q?7ESgGEMnHHOYyYXDDdi8O5Vtx5imiutvx4vUwxoQvOrwogC5MuprY8foV4Gf?=
 =?us-ascii?Q?CHagzHyJJ1ufC0WAikgc3QEI?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54f92a0-e9ee-4069-03e3-08d9633d3d06
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 18:14:51.3167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GGzneGYRpxFMRaobKUAnYSapisXI7wJjBntGOsYDV8W94EdtN2ZBHsWPkz8B3jJ0FBK3g6ZSNbbJEVD8JpCZedfXeY1y2lOLKtKjvIYKMWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0157
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

From: Tianyu Lan <ltykernel@gmail.com> Sent: Monday, August 9, 2021 10:56 AM
> 

The Subject line tag should be "hv_netvsc:".

> In Isolation VM, all shared memory with host needs to mark visible
> to host via hvcall. vmbus_establish_gpadl() has already done it for
> netvsc rx/tx ring buffer. The page buffer used by vmbus_sendpacket_
> pagebuffer() still need to handle. Use DMA API to map/umap these
> memory during sending/receiving packet and Hyper-V DMA ops callback
> will use swiotlb function to allocate bounce buffer and copy data
> from/to bounce buffer.
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  drivers/net/hyperv/hyperv_net.h   |   6 ++
>  drivers/net/hyperv/netvsc.c       | 144 +++++++++++++++++++++++++++++-
>  drivers/net/hyperv/rndis_filter.c |   2 +
>  include/linux/hyperv.h            |   5 ++
>  4 files changed, 154 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
> index bc48855dff10..862419912bfb 100644
> --- a/drivers/net/hyperv/hyperv_net.h
> +++ b/drivers/net/hyperv/hyperv_net.h
> @@ -164,6 +164,7 @@ struct hv_netvsc_packet {
>  	u32 total_bytes;
>  	u32 send_buf_index;
>  	u32 total_data_buflen;
> +	struct hv_dma_range *dma_range;
>  };
> 
>  #define NETVSC_HASH_KEYLEN 40
> @@ -1074,6 +1075,7 @@ struct netvsc_device {
> 
>  	/* Receive buffer allocated by us but manages by NetVSP */
>  	void *recv_buf;
> +	void *recv_original_buf;
>  	u32 recv_buf_size; /* allocated bytes */
>  	u32 recv_buf_gpadl_handle;
>  	u32 recv_section_cnt;
> @@ -1082,6 +1084,8 @@ struct netvsc_device {
> 
>  	/* Send buffer allocated by us */
>  	void *send_buf;
> +	void *send_original_buf;
> +	u32 send_buf_size;
>  	u32 send_buf_gpadl_handle;
>  	u32 send_section_cnt;
>  	u32 send_section_size;
> @@ -1730,4 +1734,6 @@ struct rndis_message {
>  #define RETRY_US_HI	10000
>  #define RETRY_MAX	2000	/* >10 sec */
> 
> +void netvsc_dma_unmap(struct hv_device *hv_dev,
> +		      struct hv_netvsc_packet *packet);
>  #endif /* _HYPERV_NET_H */
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 7bd935412853..fc312e5db4d5 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -153,8 +153,21 @@ static void free_netvsc_device(struct rcu_head *head)
>  	int i;
> 
>  	kfree(nvdev->extension);
> -	vfree(nvdev->recv_buf);
> -	vfree(nvdev->send_buf);
> +
> +	if (nvdev->recv_original_buf) {
> +		vunmap(nvdev->recv_buf);
> +		vfree(nvdev->recv_original_buf);
> +	} else {
> +		vfree(nvdev->recv_buf);
> +	}
> +
> +	if (nvdev->send_original_buf) {
> +		vunmap(nvdev->send_buf);
> +		vfree(nvdev->send_original_buf);
> +	} else {
> +		vfree(nvdev->send_buf);
> +	}
> +
>  	kfree(nvdev->send_section_map);
> 
>  	for (i = 0; i < VRSS_CHANNEL_MAX; i++) {
> @@ -330,6 +343,27 @@ int netvsc_alloc_recv_comp_ring(struct netvsc_device *net_device, u32 q_idx)
>  	return nvchan->mrc.slots ? 0 : -ENOMEM;
>  }
> 
> +static void *netvsc_remap_buf(void *buf, unsigned long size)
> +{
> +	unsigned long *pfns;
> +	void *vaddr;
> +	int i;
> +
> +	pfns = kcalloc(size / HV_HYP_PAGE_SIZE, sizeof(unsigned long),
> +		       GFP_KERNEL);

This assumes that the "size" argument is a multiple of PAGE_SIZE.  I think
that's true in all the use cases, but it would be safer to check.

> +	if (!pfns)
> +		return NULL;
> +
> +	for (i = 0; i < size / HV_HYP_PAGE_SIZE; i++)
> +		pfns[i] = virt_to_hvpfn(buf + i * HV_HYP_PAGE_SIZE)
> +			+ (ms_hyperv.shared_gpa_boundary >> HV_HYP_PAGE_SHIFT);
> +
> +	vaddr = vmap_pfn(pfns, size / HV_HYP_PAGE_SIZE, PAGE_KERNEL_IO);
> +	kfree(pfns);
> +
> +	return vaddr;
> +}

This function appears to be a duplicate of hv_map_memory() in Patch 11 of this
series.  Is it possible to structure things so there is only one implementation?  In
any case, see the comment in hv_map_memory() about PAGE_SIZE vs
HV_HYP_PAGE_SIZE and similar.

> +
>  static int netvsc_init_buf(struct hv_device *device,
>  			   struct netvsc_device *net_device,
>  			   const struct netvsc_device_info *device_info)
> @@ -340,6 +374,7 @@ static int netvsc_init_buf(struct hv_device *device,
>  	unsigned int buf_size;
>  	size_t map_words;
>  	int i, ret = 0;
> +	void *vaddr;
> 
>  	/* Get receive buffer area. */
>  	buf_size = device_info->recv_sections * device_info->recv_section_size;
> @@ -375,6 +410,15 @@ static int netvsc_init_buf(struct hv_device *device,
>  		goto cleanup;
>  	}
> 
> +	if (hv_isolation_type_snp()) {
> +		vaddr = netvsc_remap_buf(net_device->recv_buf, buf_size);
> +		if (!vaddr)
> +			goto cleanup;
> +
> +		net_device->recv_original_buf = net_device->recv_buf;
> +		net_device->recv_buf = vaddr;
> +	}
> +
>  	/* Notify the NetVsp of the gpadl handle */
>  	init_packet = &net_device->channel_init_pkt;
>  	memset(init_packet, 0, sizeof(struct nvsp_message));
> @@ -477,6 +521,15 @@ static int netvsc_init_buf(struct hv_device *device,
>  		goto cleanup;
>  	}
> 
> +	if (hv_isolation_type_snp()) {
> +		vaddr = netvsc_remap_buf(net_device->send_buf, buf_size);
> +		if (!vaddr)
> +			goto cleanup;

I don't think this error case is handled correctly.  Doesn't the remapping
of the recv buf need to be undone?

> +
> +		net_device->send_original_buf = net_device->send_buf;
> +		net_device->send_buf = vaddr;
> +	}
> +
>  	/* Notify the NetVsp of the gpadl handle */
>  	init_packet = &net_device->channel_init_pkt;
>  	memset(init_packet, 0, sizeof(struct nvsp_message));
> @@ -767,7 +820,7 @@ static void netvsc_send_tx_complete(struct net_device *ndev,
> 
>  	/* Notify the layer above us */
>  	if (likely(skb)) {
> -		const struct hv_netvsc_packet *packet
> +		struct hv_netvsc_packet *packet
>  			= (struct hv_netvsc_packet *)skb->cb;
>  		u32 send_index = packet->send_buf_index;
>  		struct netvsc_stats *tx_stats;
> @@ -783,6 +836,7 @@ static void netvsc_send_tx_complete(struct net_device *ndev,
>  		tx_stats->bytes += packet->total_bytes;
>  		u64_stats_update_end(&tx_stats->syncp);
> 
> +		netvsc_dma_unmap(ndev_ctx->device_ctx, packet);
>  		napi_consume_skb(skb, budget);
>  	}
> 
> @@ -947,6 +1001,82 @@ static void netvsc_copy_to_send_buf(struct netvsc_device *net_device,
>  		memset(dest, 0, padding);
>  }
> 
> +void netvsc_dma_unmap(struct hv_device *hv_dev,
> +		      struct hv_netvsc_packet *packet)
> +{
> +	u32 page_count = packet->cp_partial ?
> +		packet->page_buf_cnt - packet->rmsg_pgcnt :
> +		packet->page_buf_cnt;
> +	int i;
> +
> +	if (!hv_is_isolation_supported())
> +		return;
> +
> +	if (!packet->dma_range)
> +		return;
> +
> +	for (i = 0; i < page_count; i++)
> +		dma_unmap_single(&hv_dev->device, packet->dma_range[i].dma,
> +				 packet->dma_range[i].mapping_size,
> +				 DMA_TO_DEVICE);
> +
> +	kfree(packet->dma_range);
> +}
> +
> +/* netvsc_dma_map - Map swiotlb bounce buffer with data page of
> + * packet sent by vmbus_sendpacket_pagebuffer() in the Isolation
> + * VM.
> + *
> + * In isolation VM, netvsc send buffer has been marked visible to
> + * host and so the data copied to send buffer doesn't need to use
> + * bounce buffer. The data pages handled by vmbus_sendpacket_pagebuffer()
> + * may not be copied to send buffer and so these pages need to be
> + * mapped with swiotlb bounce buffer. netvsc_dma_map() is to do
> + * that. The pfns in the struct hv_page_buffer need to be converted
> + * to bounce buffer's pfn. The loop here is necessary and so not
> + * use dma_map_sg() here.

I think I understand why the loop is necessary, but it would be
nice to add a bit more comment text to explain.  The reason is
that the entries in the page buffer array are not necessarily full
pages of data.  Each entry in the array has a separate offset and
len that may be non-zero, even for entries in the middle of the
array.   And the entries are not physically contiguous.  So each
entry must be individually mapped rather than as a contiguous unit.

> + */
> +int netvsc_dma_map(struct hv_device *hv_dev,
> +		   struct hv_netvsc_packet *packet,
> +		   struct hv_page_buffer *pb)
> +{
> +	u32 page_count =  packet->cp_partial ?
> +		packet->page_buf_cnt - packet->rmsg_pgcnt :
> +		packet->page_buf_cnt;
> +	dma_addr_t dma;
> +	int i;
> +
> +	if (!hv_is_isolation_supported())
> +		return 0;
> +
> +	packet->dma_range = kcalloc(page_count,
> +				    sizeof(*packet->dma_range),
> +				    GFP_KERNEL);
> +	if (!packet->dma_range)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < page_count; i++) {
> +		char *src = phys_to_virt((pb[i].pfn << HV_HYP_PAGE_SHIFT)
> +					 + pb[i].offset);
> +		u32 len = pb[i].len;
> +
> +		dma = dma_map_single(&hv_dev->device, src, len,
> +				     DMA_TO_DEVICE);
> +		if (dma_mapping_error(&hv_dev->device, dma)) {
> +			kfree(packet->dma_range);
> +			return -ENOMEM;
> +		}
> +
> +		packet->dma_range[i].dma = dma;
> +		packet->dma_range[i].mapping_size = len;
> +		pb[i].pfn = dma >> HV_HYP_PAGE_SHIFT;
> +		pb[i].offset = offset_in_hvpage(dma);
> +		pb[i].len = len;
> +	}
> +
> +	return 0;
> +}
> +
>  static inline int netvsc_send_pkt(
>  	struct hv_device *device,
>  	struct hv_netvsc_packet *packet,
> @@ -987,14 +1117,22 @@ static inline int netvsc_send_pkt(
> 
>  	trace_nvsp_send_pkt(ndev, out_channel, rpkt);
> 
> +	packet->dma_range = NULL;
>  	if (packet->page_buf_cnt) {
>  		if (packet->cp_partial)
>  			pb += packet->rmsg_pgcnt;
> 
> +		ret = netvsc_dma_map(ndev_ctx->device_ctx, packet, pb);
> +		if (ret)
> +			return ret;

I think this error case needs to set things up so sending the packet
can be retried at the higher levels.  The typical error is that
swiotlb is out of bounce buffer memory.  That's a transient
condition.  There's already code in this function to retry when
the vmbus_sendpacket functions fails because the ring buffer
is full, and running out of bounce buffer memory should probably
take the same path.

> +
>  		ret = vmbus_sendpacket_pagebuffer(out_channel,
>  						  pb, packet->page_buf_cnt,
>  						  &nvmsg, sizeof(nvmsg),
>  						  req_id);
> +
> +		if (ret)
> +			netvsc_dma_unmap(ndev_ctx->device_ctx, packet);
>  	} else {
>  		ret = vmbus_sendpacket(out_channel,
>  				       &nvmsg, sizeof(nvmsg),
> diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
> index f6c9c2a670f9..448fcc325ed7 100644
> --- a/drivers/net/hyperv/rndis_filter.c
> +++ b/drivers/net/hyperv/rndis_filter.c
> @@ -361,6 +361,8 @@ static void rndis_filter_receive_response(struct net_device *ndev,
>  			}
>  		}
> 
> +		netvsc_dma_unmap(((struct net_device_context *)
> +			netdev_priv(ndev))->device_ctx, &request->pkt);
>  		complete(&request->wait_event);
>  	} else {
>  		netdev_err(ndev,
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 83fa567ad594..2ea638101645 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1601,6 +1601,11 @@ struct hyperv_service_callback {
>  	void (*callback)(void *context);
>  };
> 
> +struct hv_dma_range {
> +	dma_addr_t dma;
> +	u32 mapping_size;
> +};
> +
>  #define MAX_SRV_VER	0x7ffffff
>  extern bool vmbus_prep_negotiate_resp(struct icmsg_hdr *icmsghdrp, u8 *buf, u32 buflen,
>  				const int *fw_version, int fw_vercnt,
> --
> 2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
