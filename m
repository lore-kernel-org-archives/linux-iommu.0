Return-Path: <SRS0=qbNH=NK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC536C432BE
	for <iommu@archiver.kernel.org>; Thu, 19 Aug 2021 18:11:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C1E610A5
	for <iommu@archiver.kernel.org>; Thu, 19 Aug 2021 18:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 42C1E610A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DC4F818D4;
	Thu, 19 Aug 2021 18:11:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mxXESjz59A_Y; Thu, 19 Aug 2021 18:11:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D6C9081846;
	Thu, 19 Aug 2021 18:11:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0CA6C001A;
	Thu, 19 Aug 2021 18:11:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07326C000E
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 18:11:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D688242506
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 18:11:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=microsoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OSaHr0OvMVRx for <iommu@lists.linux-foundation.org>;
 Thu, 19 Aug 2021 18:11:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from outbound.mail.eo.outlook.com
 (mail-oln040093003004.outbound.protection.outlook.com [40.93.3.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0647742501
 for <iommu@lists.linux-foundation.org>; Thu, 19 Aug 2021 18:11:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQx5RicZXCQVwO21zoJEl63zLjOPV98nW7kJOO50pf07D3DZuHZzDM7P04kFHCvnYdmdc5z0k1IL73/tT9q0Wwzxcf2Nu6Mf9NkvFJjcGLyWf+W9HC6DVTUxWkCaqJsIRLVds2RVoVFWpGVOBtGRgrIgfNuVzXOh2O0D3aL7DU+Ywy8CKosw0uF6fn2cbNc47l5L5AiXfUKYRp8k09H1I/060xbu8EvwlA/UQfCgibSrX3uo4pGpxqJ4NTZdD5Ie+rRvZuyElPUeQZRiRfxqc1WVdcl/eVbpDcFtPhG+TCNqcKOtSV7kf9oet+LPtkMoPFA3fNzq+Txdj9qkJsRVpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrY7M72rF1Zr0I5j/dlAudxwgz6bxl1zXCiMr7diBYQ=;
 b=Isrmb0PG4kuJDNvN7MtzhFnxRmSsZe13SWdgqzaH+huqpsw+HZj09I78htq+zbjSRp0H4RM283VMbqaluorYPui0Ytp+CXufgLgFmsTYCxA0QeCMIo7E0pNHfg+DTcsvWW9pFrzsywa+h67Bcj9B0Z2wG88/q1oc763lNYZq85iFNbLGeid5CoIkxdmuXdg9jVtDtCfqvVIN7pRSLy+QS3TCPnnSWRI6/xjSlAPlaHtQ4TgKuckCqcSRGWyt99U39HmLMIgA8llnl3Wlzgm+0pyNlJdwUdO1OnY/CPUebkbtoaPSzqDvZLSi1ZOsfyJjFlIUBJMbAEllGCcdKbxOQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrY7M72rF1Zr0I5j/dlAudxwgz6bxl1zXCiMr7diBYQ=;
 b=hfNdtZK8RSKoA3hwSF992+kvPvqlclLcx+yqaiu78PJDZ5ZjNo4FW+09UIZ2u3A0XHyn58K/s5N1rG1FmriLRx1P7jDLGdoziV//mMgICpMsWc65CjGXU5HynWDTErFsZe47Dm0E3MBGroRemZbar1qrWg/5pjFEKJbDn+bEA7Y=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0157.namprd21.prod.outlook.com (2603:10b6:300:78::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.0; Thu, 19 Aug
 2021 18:11:31 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e8f7:b582:9e2d:ba55]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::e8f7:b582:9e2d:ba55%2]) with mapi id 15.20.4436.012; Thu, 19 Aug 2021
 18:11:31 +0000
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
Subject: RE: [PATCH V3 11/13] HV/IOMMU: Enable swiotlb bounce buffer for
 Isolation VM
Thread-Topic: [PATCH V3 11/13] HV/IOMMU: Enable swiotlb bounce buffer for
 Isolation VM
Thread-Index: AQHXjUfwueIoKygi8UWT9Nsp+4fozKt7FrWA
Date: Thu, 19 Aug 2021 18:11:30 +0000
Message-ID: <MWHPR21MB159315B335EB0B064B0B0F23D7C09@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210809175620.720923-1-ltykernel@gmail.com>
 <20210809175620.720923-12-ltykernel@gmail.com>
In-Reply-To: <20210809175620.720923-12-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8f24f853-954e-4fb1-ba7f-63e5be13c4af;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-19T16:38:26Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc5d809c-5b04-466a-c429-08d9633cc55f
x-ms-traffictypediagnostic: MWHPR21MB0157:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB0157CD7828DEB9B8D9516BE2D7C09@MWHPR21MB0157.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:158;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SPUUuhJnmIoU4Cg2uH/0j1m2WmDcK82EdbcqiGt/Qpd7R93+9NSK/73ZEo7m+u3HzTEV8EH9PKu8ZR1VaicjcrAMSuCxUvYSTmNYs7z9IWhiMKozkADkRlt6GZJuk1ZFBLP7DCDsCNRgGRL8TJYoMG/Pv6HFH57jPTftFywGCAVIfq5oIQunUdWyeza2sdVOEOvvLW+IBr9rbYOU76HYHA7dewHPwIqycl+0KUi48higib82Wi+kxgVIWjpN4WhqZ37GMII1k/+FdPNe+QIrPkzngdsiYirxG9PCfINg8jyfyd4tXEJ1aI2ADD7uCn6s7yMIGxKSl9xD5ZXwlIyE6f4WKj3SXXnnd+hD1iIkd5b72YraW0AfU20ZdOlLD/CdNjcyNUo7amsEmFMVLXnU3wVRtt2EKiSJuzgb9SX3hEBb8v21kw+iuA60zOKWKDXV2M4iaLwl50Y2xs/G4tet0Vx2rzXJJUrKq0NupMXc0YFedO5qU0Ygenb+MSzjHkABFggHhENC+e6wVn+aC75NwafOYHWH+gJt6wwJII/PVvRo4RqDB9J2Ap97JLUf0+cncnmxo4UB1visL4A+eFaenJ52o0Rhpf1lXl6N6vUKOCG5icYFJ9fLfgdIM75htovp3CmbwVWfeWF0cwGu6RFDjq38/ivKRW+n7Qi9fOzFWcVGLkg+9mz8Uo/841rGgyUboCfjTrhb/PfFSwRO6cwniQK7wHZ0honSVO4xM1jCyUI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR21MB1593.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016002)(86362001)(8990500004)(316002)(26005)(186003)(38100700002)(71200400001)(33656002)(83380400001)(7696005)(8676002)(2906002)(122000001)(110136005)(4326008)(8936002)(921005)(54906003)(64756008)(6506007)(82960400001)(82950400001)(7416002)(7406005)(76116006)(9686003)(5660300002)(508600001)(38070700005)(66946007)(66446008)(66476007)(66556008)(10290500003)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DIKV3NFT4RCfv0UJLUwGs0tkglczd6DzZOKR4Nd4SWO3HLo0gpsP+ruBwJBn?=
 =?us-ascii?Q?MAs2uKtttEwKVaeyvNYa+DE1FfLWlFQtv2KGMzXfUoAMwA2E4lmHpGDBKkeq?=
 =?us-ascii?Q?igu6RayZBcu7cZ58JM8vLbwIX9KIuWec5qAQmxmYzeMNjjRqTVel9sAx8C45?=
 =?us-ascii?Q?wcQfHk0R7zcN4lEA8RkZNmzIMNXz7HQcmxTEkdHjHtXQ8biYKI+S6KdbmZ3N?=
 =?us-ascii?Q?yboAB0JzrVirv0A+u8o1ewz0PSIP5gfR+dJ3UO5H/yxIu7T8M+ecqHfPhJNR?=
 =?us-ascii?Q?25SibdIC1rVeBRnnd7kVSXA9SznT9zSFE//S1VGZpG1YIJatNbzSZN+Ysa0I?=
 =?us-ascii?Q?3OD2CqIBQtqAHAXtUd9Jta5uN+Rjk2PYm7i8Ojz61ptdXCVeazoXIOOu5ALh?=
 =?us-ascii?Q?ORq1u/+VGvgUEvCL1G/KPkf4c86CT/vm5c/W7CLjHi27Nxwj6pGSTRjpM80o?=
 =?us-ascii?Q?y4CTUGm7fpsNYM0mlPbQt6H/43nm/egNEI+g+6aAKAwYypsMEOrFKBcdMw+0?=
 =?us-ascii?Q?0pfcmCsnFyE1kYdVdG+T7gkQ6z1M7gOz8X2msN1q59YRTt2riJaq5P+OxfHH?=
 =?us-ascii?Q?ckt0BlNPi1rCqPbyFsiwJRmKjrm3teQQ5/XJo4Xp6TYDv+EWHRrbRcG1+5YJ?=
 =?us-ascii?Q?MnzvHaTxksV2beguJUlNxFwhd10Fioy74YnJh9sEH5nDgLHFny/aw3lGzrGY?=
 =?us-ascii?Q?Tk22qNMhimJZAAaY6y17RA40aNnCz9ybQcnthSL2HEBubuZqij8tBxOvFb1y?=
 =?us-ascii?Q?Sd1vADCi762MTCHNgAnKps6TdUjQnkupP+vJep/4v+cazdqR5Ltb69FAhQqv?=
 =?us-ascii?Q?uWrDGwkDiyCsTiVuy8pa0oTeUaf3jvcqRYze3hLECI1ak9JdcV8dXnWID66S?=
 =?us-ascii?Q?agQP4vECtqJl/D/xz/e6T75UbJKb7qOd+8iSwW5gVClEgFoMrY3rXIMa34yM?=
 =?us-ascii?Q?utjVtK/bQJd9oS4Ytt5C/Rg5IbJvpmN0WaixDNkqBg5jK/736t6WBqtMz0Z9?=
 =?us-ascii?Q?XEOxOIg2cSn/BJBLWpSlBe8DBFCCwyafOy/AR2gRllMoRVpKNv+b3oJfl+tZ?=
 =?us-ascii?Q?DgJt1o/B0nMWqOPlQxwtvgIAy31s9R9wpjpyr6szO0lGGBfYSVewPorYJdAi?=
 =?us-ascii?Q?1niDSx5/2d7ru1pnNe7IMKiZ33GRvRX1kS6pP69PTIgLjJ3VcbFrQ0/5g8wR?=
 =?us-ascii?Q?R8E7mdKzCVcwAVZtdZNpTqmXIHXDXltIDdQI0zJXVE1SBHaQ0sYSlTP4mjKf?=
 =?us-ascii?Q?27OFTifi8oQG5KBQgMp8dxl+Tj3M9wz8hdjdR/TZ6OYyFHWjdvRRTQPnlzp7?=
 =?us-ascii?Q?vYoUas0MUDBTnI/25TN8EN29?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5d809c-5b04-466a-c429-08d9633cc55f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 18:11:30.5573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AFKFCJFP/cZmiQz10Z4UdhOqv4fcDTJ5JGB62xVcIQeC6YNJ1lOeSov8cJhlaQy9TXja7INKtQF+2rL5l6qJjV5hA8OKlMSR9aBaWTAoKzM=
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
> Hyper-V Isolation VM requires bounce buffer support to copy
> data from/to encrypted memory and so enable swiotlb force
> mode to use swiotlb bounce buffer for DMA transaction.
> 
> In Isolation VM with AMD SEV, the bounce buffer needs to be
> accessed via extra address space which is above shared_gpa_boundary
> (E.G 39 bit address line) reported by Hyper-V CPUID ISOLATION_CONFIG.
> The access physical address will be original physical address +
> shared_gpa_boundary. The shared_gpa_boundary in the AMD SEV SNP
> spec is called virtual top of memory(vTOM). Memory addresses below
> vTOM are automatically treated as private while memory above
> vTOM is treated as shared.
> 
> Swiotlb bounce buffer code calls dma_map_decrypted()
> to mark bounce buffer visible to host and map it in extra
> address space. Populate dma memory decrypted ops with hv
> map/unmap function.
> 
> Hyper-V initalizes swiotlb bounce buffer and default swiotlb
> needs to be disabled. pci_swiotlb_detect_override() and
> pci_swiotlb_detect_4gb() enable the default one. To override
> the setting, hyperv_swiotlb_detect() needs to run before
> these detect functions which depends on the pci_xen_swiotlb_
> init(). Make pci_xen_swiotlb_init() depends on the hyperv_swiotlb
> _detect() to keep the order.
> 
> The map function vmap_pfn() can't work in the early place
> hyperv_iommu_swiotlb_init() and so initialize swiotlb bounce
> buffer in the hyperv_iommu_swiotlb_later_init().
> 
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/hyperv/ivm.c           | 28 ++++++++++++++
>  arch/x86/include/asm/mshyperv.h |  2 +
>  arch/x86/xen/pci-swiotlb-xen.c  |  3 +-
>  drivers/hv/vmbus_drv.c          |  3 ++
>  drivers/iommu/hyperv-iommu.c    | 65 +++++++++++++++++++++++++++++++++
>  include/linux/hyperv.h          |  1 +
>  6 files changed, 101 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index c13ec5560d73..0f05e4d6fc62 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -265,3 +265,31 @@ int hv_set_mem_host_visibility(unsigned long addr, int numpages, bool visible)
> 
>  	return __hv_set_mem_host_visibility((void *)addr, numpages, visibility);
>  }
> +
> +/*
> + * hv_map_memory - map memory to extra space in the AMD SEV-SNP Isolation VM.
> + */
> +void *hv_map_memory(void *addr, unsigned long size)
> +{
> +	unsigned long *pfns = kcalloc(size / HV_HYP_PAGE_SIZE,
> +				      sizeof(unsigned long), GFP_KERNEL);
> +	void *vaddr;
> +	int i;
> +
> +	if (!pfns)
> +		return NULL;
> +
> +	for (i = 0; i < size / HV_HYP_PAGE_SIZE; i++)
> +		pfns[i] = virt_to_hvpfn(addr + i * HV_HYP_PAGE_SIZE) +
> +			(ms_hyperv.shared_gpa_boundary >> HV_HYP_PAGE_SHIFT);
> +
> +	vaddr = vmap_pfn(pfns, size / HV_HYP_PAGE_SIZE,	PAGE_KERNEL_IO);
> +	kfree(pfns);
> +
> +	return vaddr;
> +}

This function is manipulating page tables in the guest VM.  It is not involved
in communicating with Hyper-V, or passing PFNs to Hyper-V.  The pfn array
contains guest PFNs, not Hyper-V PFNs.  So it should use PAGE_SIZE
instead of HV_HYP_PAGE_SIZE, and similarly PAGE_SHIFT and virt_to_pfn().
If this code were ever to run on ARM64 in the future with PAGE_SIZE other
than 4 Kbytes, the use of PAGE_SIZE is correct choice.

> +
> +void hv_unmap_memory(void *addr)
> +{
> +	vunmap(addr);
> +}
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index a30c60f189a3..b247739f57ac 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -250,6 +250,8 @@ int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
>  int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
>  			   enum hv_mem_host_visibility visibility);
>  int hv_set_mem_host_visibility(unsigned long addr, int numpages, bool visible);
> +void *hv_map_memory(void *addr, unsigned long size);
> +void hv_unmap_memory(void *addr);
>  void hv_sint_wrmsrl_ghcb(u64 msr, u64 value);
>  void hv_sint_rdmsrl_ghcb(u64 msr, u64 *value);
>  void hv_signal_eom_ghcb(void);
> diff --git a/arch/x86/xen/pci-swiotlb-xen.c b/arch/x86/xen/pci-swiotlb-xen.c
> index 54f9aa7e8457..43bd031aa332 100644
> --- a/arch/x86/xen/pci-swiotlb-xen.c
> +++ b/arch/x86/xen/pci-swiotlb-xen.c
> @@ -4,6 +4,7 @@
> 
>  #include <linux/dma-map-ops.h>
>  #include <linux/pci.h>
> +#include <linux/hyperv.h>
>  #include <xen/swiotlb-xen.h>
> 
>  #include <asm/xen/hypervisor.h>
> @@ -91,6 +92,6 @@ int pci_xen_swiotlb_init_late(void)
>  EXPORT_SYMBOL_GPL(pci_xen_swiotlb_init_late);
> 
>  IOMMU_INIT_FINISH(pci_xen_swiotlb_detect,
> -		  NULL,
> +		  hyperv_swiotlb_detect,
>  		  pci_xen_swiotlb_init,
>  		  NULL);
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 57bbbaa4e8f7..f068e22a5636 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -23,6 +23,7 @@
>  #include <linux/cpu.h>
>  #include <linux/sched/task_stack.h>
> 
> +#include <linux/dma-map-ops.h>
>  #include <linux/delay.h>
>  #include <linux/notifier.h>
>  #include <linux/panic_notifier.h>
> @@ -2081,6 +2082,7 @@ struct hv_device *vmbus_device_create(const guid_t *type,
>  	return child_device_obj;
>  }
> 
> +static u64 vmbus_dma_mask = DMA_BIT_MASK(64);
>  /*
>   * vmbus_device_register - Register the child device
>   */
> @@ -2121,6 +2123,7 @@ int vmbus_device_register(struct hv_device *child_device_obj)
>  	}
>  	hv_debug_add_dev_dir(child_device_obj);
> 
> +	child_device_obj->device.dma_mask = &vmbus_dma_mask;
>  	return 0;
> 
>  err_kset_unregister:
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index e285a220c913..01e874b3b43a 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -13,14 +13,22 @@
>  #include <linux/irq.h>
>  #include <linux/iommu.h>
>  #include <linux/module.h>
> +#include <linux/hyperv.h>
> +#include <linux/io.h>
> 
>  #include <asm/apic.h>
>  #include <asm/cpu.h>
>  #include <asm/hw_irq.h>
>  #include <asm/io_apic.h>
> +#include <asm/iommu.h>
> +#include <asm/iommu_table.h>
>  #include <asm/irq_remapping.h>
>  #include <asm/hypervisor.h>
>  #include <asm/mshyperv.h>
> +#include <asm/swiotlb.h>
> +#include <linux/dma-map-ops.h>
> +#include <linux/dma-direct.h>
> +#include <linux/set_memory.h>
> 
>  #include "irq_remapping.h"
> 
> @@ -36,6 +44,9 @@
>  static cpumask_t ioapic_max_cpumask = { CPU_BITS_NONE };
>  static struct irq_domain *ioapic_ir_domain;
> 
> +static unsigned long hyperv_io_tlb_size;
> +static void *hyperv_io_tlb_start;
> +
>  static int hyperv_ir_set_affinity(struct irq_data *data,
>  		const struct cpumask *mask, bool force)
>  {
> @@ -337,4 +348,58 @@ static const struct irq_domain_ops hyperv_root_ir_domain_ops = {
>  	.free = hyperv_root_irq_remapping_free,
>  };
> 
> +void __init hyperv_iommu_swiotlb_init(void)
> +{
> +	unsigned long bytes;
> +
> +	/*
> +	 * Allocate Hyper-V swiotlb bounce buffer at early place
> +	 * to reserve large contiguous memory.
> +	 */
> +	hyperv_io_tlb_size = 256 * 1024 * 1024;

A hard coded size here seems problematic.   The memory size of
Isolated VMs can vary by orders of magnitude.  I see that
xen_swiotlb_init() uses swiotlb_size_or_default(), which at least
pays attention to the value specified on the kernel boot line.

Another example is sev_setup_arch(), which in the native case sets
the size to 6% of main memory, with a max of 1 Gbyte.  This is
the case that's closer to Isolated VMs, so doing something
similar could be a good approach.

> +	hyperv_io_tlb_start =
> +			memblock_alloc_low(
> +				  PAGE_ALIGN(hyperv_io_tlb_size),
> +				  HV_HYP_PAGE_SIZE);
> +
> +	if (!hyperv_io_tlb_start) {
> +		pr_warn("Fail to allocate Hyper-V swiotlb buffer.\n");
> +		return;
> +	}
> +}
> +
> +int __init hyperv_swiotlb_detect(void)
> +{
> +	if (hypervisor_is_type(X86_HYPER_MS_HYPERV)
> +	    && hv_is_isolation_supported()) {
> +		/*
> +		 * Enable swiotlb force mode in Isolation VM to
> +		 * use swiotlb bounce buffer for dma transaction.
> +		 */
> +		swiotlb_force = SWIOTLB_FORCE;
> +
> +		dma_memory_generic_decrypted_ops.map = hv_map_memory;
> +		dma_memory_generic_decrypted_ops.unmap = hv_unmap_memory;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +void __init hyperv_iommu_swiotlb_later_init(void)
> +{
> +	/*
> +	 * Swiotlb bounce buffer needs to be mapped in extra address
> +	 * space. Map function doesn't work in the early place and so
> +	 * call swiotlb_late_init_with_tbl() here.
> +	 */
> +	if (swiotlb_late_init_with_tbl(hyperv_io_tlb_start,
> +				       hyperv_io_tlb_size >> IO_TLB_SHIFT))
> +		panic("Fail to initialize hyperv swiotlb.\n");
> +}
> +
> +IOMMU_INIT_FINISH(hyperv_swiotlb_detect,
> +		  NULL, hyperv_iommu_swiotlb_init,
> +		  hyperv_iommu_swiotlb_later_init);
> +
>  #endif
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 90b542597143..83fa567ad594 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1744,6 +1744,7 @@ int hyperv_write_cfg_blk(struct pci_dev *dev, void *buf, unsigned int len,
>  int hyperv_reg_block_invalidate(struct pci_dev *dev, void *context,
>  				void (*block_invalidate)(void *context,
>  							 u64 block_mask));
> +int __init hyperv_swiotlb_detect(void);
> 
>  struct hyperv_pci_block_ops {
>  	int (*read_block)(struct pci_dev *dev, void *buf, unsigned int buf_len,
> --
> 2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
