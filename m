Return-Path: <SRS0=IUlV=GR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13101C433E6
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 03:04:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765CB2220F
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 03:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765CB2220F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E917586A35;
	Thu, 14 Jan 2021 03:04:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lJ1ABqBNdycd; Thu, 14 Jan 2021 03:04:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EB1F486985;
	Thu, 14 Jan 2021 03:04:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA665C088B;
	Thu, 14 Jan 2021 03:04:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D237C013A
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 03:04:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 52BB885727
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 03:04:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9WyCzmNFirdH for <iommu@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 03:04:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1522D86B2D
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 03:04:46 +0000 (UTC)
IronPort-SDR: 88JePXzkwSZp0AJL88JwDUTJkuX1NhjqSc4tqanbA33U8NrIyKAXMWSRI4vzfXxRvxn08NOcWo
 EU5ZiRPyUncQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="242374975"
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; d="scan'208";a="242374975"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2021 19:04:43 -0800
IronPort-SDR: q38mOx/V7oAM31QAhnw8sofaSSSTjTJs5FCa/H5GQ2odqGBTy//SrjBn3tWjRKohhejtHyd7hr
 wg437tMLZqyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; d="scan'208";a="424801658"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga001.jf.intel.com with ESMTP; 13 Jan 2021 19:04:29 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Jan 2021 19:04:29 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Jan 2021 19:04:29 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 13 Jan 2021 19:04:29 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 13 Jan 2021 19:04:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gC5nqBzLFHTJzsSX/hHhVdbxxva0xdnt2q1767u/pdNI+WWUvBDfATr+HbwZ2LPLURzCaBOY5gb9L/R9ievl9/bR19U2NWxBaoYdOuMIX/48TWWiou4oO0g4DpL6BxwTR3tNjo8VabbbQTDWzoE+zAraBO4uGLTmH9P96acJoZcufRT4M0+O/LrJV6ZUAMfu+vDBnF6HVVnrpHlibb2g7Rfg1XSkjviSPZjsF7XzeGTiIcEi8NintlK8EmSJvtJWnCe/ijBjciFOr6A49eWYQgtbqsb+9g72ZyzhGEjsVnixCgA1QwvkzhnDRr2hHo2zUbzO+w9+42Lr3zwstSfnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/2mFpspHv3qAuBseo794ptS1HfQT0w1OU1YwTAnv0w=;
 b=f40hDA8BEJdVwgYQpRdOw8quFb38+c+zAC8HgPjSZxvPu60DPVmxICEfPwdT6XKWaRBEm9DV5F8CDD/p6uLnBcwku+eczbFC9F06oUZPSMUoOE5u7Bps/VmZIyB0gQbPWEYg42bFt8TpQ99GmpBw9M3bMlFIEt7STVghWr+k4JqxhNUqgkYrhMKrN+WAjicqpcDl1jZRn0q8oP3QfPa7Fl1WLkSkC0emNorbvPvSjSRS81SC7dXU1fXziryl6w2rRxjQ9PrG0pglwXJZdmY6KnHkAnSbof4XTOMf/AStKAOW9FAtaj1j4qp+vTL/avDaZ+p4VhHjWppdeYLd/J4X/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/2mFpspHv3qAuBseo794ptS1HfQT0w1OU1YwTAnv0w=;
 b=nf1GL4srdJ0b2Lg+jdtjm71yk/WlhWR6xQNwKG9nOdECxh3iIJfQt/5P7IX8jDjtMAr5E34ign1k1Ge4RpQwjHVKIHfGsJ9vZ4hmcDmWRGo8l4tdzL/9l4CgH42aytAUOkMlEo5Cfs3CFNLls1GiDFm86J2N8UX0epkWUiLDyOk=
Received: from BN6PR11MB1875.namprd11.prod.outlook.com (2603:10b6:404:104::11)
 by BN7PR11MB2547.namprd11.prod.outlook.com (2603:10b6:406:af::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 14 Jan
 2021 03:03:52 +0000
Received: from BN6PR11MB1875.namprd11.prod.outlook.com
 ([fe80::a473:9954:c473:9e8d]) by BN6PR11MB1875.namprd11.prod.outlook.com
 ([fe80::a473:9954:c473:9e8d%8]) with mapi id 15.20.3742.012; Thu, 14 Jan 2021
 03:03:52 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "Raj, Ashok" <ashok.raj@intel.com>, "Jiang, Dave"
 <dave.jiang@intel.com>, "Dey, Megha" <megha.dey@intel.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: RE: [RFC PATCH v3 2/2] platform-msi: Add platform check for subdevice
 irq domain
Thread-Topic: [RFC PATCH v3 2/2] platform-msi: Add platform check for
 subdevice irq domain
Thread-Index: AQHW6hYT4EqA4SOp5kyxojBYbDjQfaomaNqQ
Date: Thu, 14 Jan 2021 03:03:52 +0000
Message-ID: <BN6PR11MB18758E47B2CC114E0AE3CD578CA80@BN6PR11MB1875.namprd11.prod.outlook.com>
References: <20210114013003.297050-1-baolu.lu@linux.intel.com>
 <20210114013003.297050-3-baolu.lu@linux.intel.com>
In-Reply-To: <20210114013003.297050-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [101.88.226.48]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a0bc6c4-77f2-4c05-6638-08d8b83905e5
x-ms-traffictypediagnostic: BN7PR11MB2547:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB25478DBB2D722976B0851EFF8CA80@BN7PR11MB2547.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qwpDmM8TOyQkmbqKTvtThQlqMlpkazV8+DO/RFdxcfJTm9Q9nX36DNvLU2c51TCsYyWvkEL0TWzacICMQ/FhLfKfpyGKPNa3fGuk8rKDQ/TQ5dkxhtxRPyfrzobbdfEaBiu7aOYr3pyhyqLbbNOokAICtI4ZotSNfOfJ9VqGTqw418DA2Jz6w/Czc/tFhxzrtLkfcT7DGTq2i56ChLRgU8u6NBUkllnjzw1KzMsuevHSpgJdVK406WYDrQ4AK3SsPdSTLy9PBNecH0qsVhX1hrXD+rXByiEQdEmut57ZeBPrBbFmEpYMJAVW7fM/FDhJXwJVuXITD4Bn1qMzCc55m5SCQrm+weQvmsxf7TfhwynwsVQwlsdLWIijzGADP5IO99yihJGW9ErMfWY6aRurb2PJCK5SLSKGSRTm6DFzO1zT7TBzQCaOUqmSa3k1slHspprXMVEMF44wOMICVi+C/g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR11MB1875.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(52536014)(66556008)(83380400001)(66946007)(186003)(7416002)(316002)(26005)(86362001)(6506007)(5660300002)(33656002)(66476007)(76116006)(8676002)(66446008)(64756008)(71200400001)(2906002)(4326008)(9686003)(966005)(7696005)(55016002)(110136005)(8936002)(478600001)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GYAf7NzA2Bvkoa/onRc9w0Xp89Pu0jlg83ydUQaVRiblHajJA9KwuutbPbY/?=
 =?us-ascii?Q?dl6V7tFIXGeBM/QjEF7edEinEIyQbCdk4h/DZyejplKzEW9y+VXWAOgcQsjL?=
 =?us-ascii?Q?ca6HGPurL2kkSYvXzFmyAXsMtdSdshYEpyICkPmkdC5zgNo62MMq2fbrIXbB?=
 =?us-ascii?Q?xZWbmMKkhn5zzRo0Dzat3Bg2xuRUgbB9FD+3QZV2gV+5Ua7i7KVoKbpZ+/7g?=
 =?us-ascii?Q?0H3E3MkQd5HmAHXTa38PBniJ8jyxMowzvV97oXs8iXXR2GNsN3PPTjI30Bqe?=
 =?us-ascii?Q?8EsNk4k+FIQrZgAVV98kNR4j8JVCq2MGEVZE/kZ8Q1dLkMRlYXxUiHXyO54v?=
 =?us-ascii?Q?XBEl0N5XvBJIDBu7tCtO5C61GoiMRXZydJpv4XUKQpr7q73gWJZouZUR+wek?=
 =?us-ascii?Q?s/cyz+GRT2Cwm3gMl7jhF910sHOhSc22JnoWS/I42JWl1YbmS6HN4jrrAM+Y?=
 =?us-ascii?Q?u6ABReDTm0YAGXHsdcxYmJW9r566pw4lCEXmUadAo6KbvSXtHT94dQNNYBMv?=
 =?us-ascii?Q?29tPPVmx2rWa42LsVvjFX+HFtcuxIK41u/wULM/VqXX3v7eP4JBtJwatSgLv?=
 =?us-ascii?Q?qWn6yP7TcWV+Nsf+wpH04p09GEWGy9o/EOWcA79qSa1sdc1V3AXPyys+2P7S?=
 =?us-ascii?Q?6fGjhvdItIo5iwCusL+hn6sgaA1KFwJEuGrlSBI6wS/Mii95nfbXXc+ls//u?=
 =?us-ascii?Q?f8kKvDTa7tM2nG1LuYTrePA2GgVM1RDCUnwgGvGXDoO5Rg0Dz+CZGtMwSYI8?=
 =?us-ascii?Q?zZA5EPE2pZVrvLhqfRgl66fcDsN6nfhoQV2vUr9CV8CmBzxpfsi1olpVufXS?=
 =?us-ascii?Q?xrD/Zdkd+dF8exKNkLH/dLhNTCBmpEnUsNwHkW6/h2F2eMjD77eCwgJQ606l?=
 =?us-ascii?Q?XPnIIXeGNYo6v4k0uf3rS5CQfUqxRzRBIpwRtwVBjX8lnVlCUTdBfKYHBzRo?=
 =?us-ascii?Q?9w2uuLSTXLlpUFLpreSB17CqasxBqSB1c9AZMZ2FtfE=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1875.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0bc6c4-77f2-4c05-6638-08d8b83905e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 03:03:52.1473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZ0l26qytVXqtIMiF2oRmP3pV84CsjxZQzQUNhEBuLrFc6DlyI2ZIloUpWoIsksnxzqs6QbI3x07+oEmDNu3dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2547
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, "Hossain, Mona" <mona.hossain@intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "will@kernel.org" <will@kernel.org>, "leon@kernel.org" <leon@kernel.org>,
 "netanelg@mellanox.com" <netanelg@mellanox.com>,
 "maz@kernel.org" <maz@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "jgg@mellanox.com" <jgg@mellanox.com>,
 "yan.y.zhao@linux.intel.com" <yan.y.zhao@linux.intel.com>,
 "shahafs@mellanox.com" <shahafs@mellanox.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Ortiz,
 Samuel" <samuel.ortiz@intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
 "Luck, Tony" <tony.luck@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "vkoul@kernel.org" <vkoul@kernel.org>, "Pan, 
 Jacob jun" <jacob.jun.pan@intel.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Woodhouse,
 David" <dwmw@amazon.co.uk>
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

> From: Lu Baolu
> Sent: Thursday, January 14, 2021 9:30 AM
> 
> The pci_subdevice_msi_create_irq_domain() should fail if the underlying
> platform is not able to support IMS (Interrupt Message Storage). Otherwise,
> the isolation of interrupt is not guaranteed.
> 
> For x86, IMS is only supported on bare metal for now. We could enable it
> in the virtualization environments in the future if interrupt HYPERCALL
> domain is supported or the hardware has the capability of interrupt
> isolation for subdevices.
> 
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/linux-
> pci/87pn4nk7nn.fsf@nanos.tec.linutronix.de/
> Link: https://lore.kernel.org/linux-
> pci/877dqrnzr3.fsf@nanos.tec.linutronix.de/
> Link: https://lore.kernel.org/linux-
> pci/877dqqmc2h.fsf@nanos.tec.linutronix.de/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  arch/x86/pci/common.c       | 71
> +++++++++++++++++++++++++++++++++++++
>  drivers/base/platform-msi.c |  8 +++++
>  include/linux/msi.h         |  1 +
>  3 files changed, 80 insertions(+)
> 
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 3507f456fcd0..9deb826fb242 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -12,6 +12,7 @@
>  #include <linux/init.h>
>  #include <linux/dmi.h>
>  #include <linux/slab.h>
> +#include <linux/iommu.h>
> 
>  #include <asm/acpi.h>
>  #include <asm/segment.h>
> @@ -724,3 +725,73 @@ struct pci_dev *pci_real_dma_dev(struct pci_dev
> *dev)
>  	return dev;
>  }
>  #endif
> +
> +/*
> + * We want to figure out which context we are running in. But the hardware
> + * does not introduce a reliable way (instruction, CPUID leaf, MSR, whatever)
> + * which can be manipulated by the VMM to let the OS figure out where it
> runs.
> + * So we go with the below probably on_bare_metal() function as a
> replacement
> + * for definitely on_bare_metal() to go forward only for the very simple
> reason
> + * that this is the only option we have.
> + */
> +static const char * const vmm_vendor_name[] = {
> +	"QEMU", "Bochs", "KVM", "Xen", "VMware", "VMW", "VMware Inc.",
> +	"innotek GmbH", "Oracle Corporation", "Parallels", "BHYVE"
> +};
> +
> +static void read_type0_virtual_machine(const struct dmi_header *dm, void
> *p)
> +{
> +	u8 *data = (u8 *)dm + 0x13;
> +
> +	/* BIOS Information (Type 0) */
> +	if (dm->type != 0 || dm->length < 0x14)
> +		return;
> +
> +	/* Bit 4 of BIOS Characteristics Extension Byte 2*/
> +	if (*data & BIT(4))
> +		*((bool *)p) = true;
> +}
> +
> +static bool smbios_virtual_machine(void)
> +{
> +	bool bit_present = false;
> +
> +	dmi_walk(read_type0_virtual_machine, &bit_present);
> +
> +	return bit_present;
> +}
> +
> +static bool on_bare_metal(struct device *dev)
> +{
> +	int i;
> +
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +		return false;
> +
> +	if (smbios_virtual_machine())
> +		return false;
> +
> +	if (iommu_capable(dev->bus, IOMMU_CAP_VIOMMU))
> +		return false;
> +
> +	for (i = 0; i < ARRAY_SIZE(vmm_vendor_name); i++)
> +		if (dmi_match(DMI_SYS_VENDOR, vmm_vendor_name[i]))
> +			return false;

Thinking more I wonder whether this check is actually useful here. As Leon
and David commented, the same vendor name can be used both for VM
and bare metal instances. It implies that both bare metal and VM might be
misinterpreted with this check. This might not be what we want originally -
find heuristics to indicate a VM environment and tolerate misinterpreting 
VM as bare metal in corner cases (but not vice versa).

Thomas?

Thanks
Kevin

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
