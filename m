Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E05C433DF
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 03:25:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0468E207F5
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 03:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="PHwx9WNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0468E207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C7596882A2;
	Tue, 14 Jul 2020 03:25:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q4cM-k81YfDn; Tue, 14 Jul 2020 03:25:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 62D0688238;
	Tue, 14 Jul 2020 03:25:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 480E9C0888;
	Tue, 14 Jul 2020 03:25:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A00D7C0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 03:25:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8DF3B8829C
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 03:25:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wK8oCbvVEQy7 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 03:25:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C4FD288238
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 03:25:23 +0000 (UTC)
IronPort-SDR: Dikdb8tRS3+aVFCpNLlpmv2C7Ro7a5v4KXgM9XPX8uM1WNlcisMZZozd++nj8Ka81vgGaYSqQk
 ZK9ZgWnxwqSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="128881934"
X-IronPort-AV: E=Sophos;i="5.75,349,1589266800"; d="scan'208";a="128881934"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2020 20:25:22 -0700
IronPort-SDR: dan9Yj29nrQK+K67MtSO6ZxkfdredRO1joRXhEaA5D3cZitd6l6FJ6YZ6wRnvmYvc1RmV7xiMM
 p2cgGcnZQcYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,349,1589266800"; d="scan'208";a="429619689"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
 by orsmga004.jf.intel.com with ESMTP; 13 Jul 2020 20:25:22 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 13 Jul 2020 20:25:22 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 13 Jul 2020 20:25:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alquCtHulHD8Y5n9DhUayv8T/NCoBKGND7L8Qne4KGpAtVwMoxE0bplySyhg1Zm/Qe+BXQzmKOy2ZaGF4Q6oQVaLYkDXzlghed7PGGkQbjdyD0vhhFM6sT4AxLieGE+1rmRGMReF2O6ECuxi6ydO6K5XZpKeB7bB/dhVFZDTVCwG1TpsRnftSC5IM1TjgyK3wL5tzsiHb5psmUgqIgQj4CfqSgXGFzZD2ENsNO7OjKQmGknf6ULAftKBXU5RwDQUQgGeJD7XqtXT68u4/eoN/umecruLLqbqIeG4wsWE7WCSiR8TcB7ULHD8ZByU9EW136ObDtkBQJSf4cgppQPWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWWfrE/aYrE+ZYjniqkEd5Nj9Hh4yoxMf4aR27yO2gc=;
 b=lAwgj1x6JqeVIc76uIX6dI0iQXnvNKJn2AF/4y0OLJvdAFNV738diV8eCiBMc5woSAEAy4G/TmBxJ3eV/PifSetzp5KEAL6r1q3cEh6Wb3qh5vPK6+QptxtSAChKGmObNWTYn2p+re+qUBjG43D14I9n2q3zLx8pKvZRfn1XEdq7tgnYhdL0VINhUue/9nBcSpFgr5D2nGusEVkLMU9oLAeKmDiDOcFU4Mcvkhgf/HhuJcSLTtLBkbmdYEsNgXAWWwBudtFaVOHy8wbUwLs2AiKjI2xysX8gm3HBqQkRMSyvttfROwqDaLZzxiGHRMG+ndB3klqFuzq6G0vW5Os/Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWWfrE/aYrE+ZYjniqkEd5Nj9Hh4yoxMf4aR27yO2gc=;
 b=PHwx9WNJ+l4LzzEQ2nqAUX8Qvi0+0YrdmFVPIfYfHGugZUGJISsoQy+Bi2eLZxgGf2NXtZQwiL/lgaiRrOdsFeWtqY6zBIzr3/8y/giIIWcIj1TkUB3PkjJ+lst+H1kJJzCQkruKTMys17K8NdNnLSzxJdhbAx6r4l5zriO4iRY=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB4201.namprd11.prod.outlook.com (2603:10b6:5:200::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20; Tue, 14 Jul 2020 03:25:20 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3174.025; Tue, 14 Jul
 2020 03:25:20 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "Yu, Fenghua" <fenghua.yu@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Joerg Roedel <joro@8bytes.org>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra
 <peterz@infradead.org>, H Peter Anvin <hpa@zytor.com>, David Woodhouse
 <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>, "Hansen, Dave" <dave.hansen@intel.com>, "Luck,
 Tony" <tony.luck@intel.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Christoph Hellwig <hch@infradead.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, "Mehta, Sohil" <sohil.mehta@intel.com>, 
 "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: RE: [PATCH v6 03/12] docs: x86: Add documentation for SVA (Shared
 Virtual Addressing)
Thread-Topic: [PATCH v6 03/12] docs: x86: Add documentation for SVA (Shared
 Virtual Addressing)
Thread-Index: AQHWWXAxW73p99IEiEm8uCYi61rUYakGYpug
Date: Tue, 14 Jul 2020 03:25:20 +0000
Message-ID: <DM5PR11MB1435394EDA593222F19F3BF8C3610@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1594684087-61184-1-git-send-email-fenghua.yu@intel.com>
 <1594684087-61184-4-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1594684087-61184-4-git-send-email-fenghua.yu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [117.169.229.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6132a85a-fe1a-4ae1-5588-08d827a589a4
x-ms-traffictypediagnostic: DM6PR11MB4201:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4201E5A86CF30A7DAADE88EBC3610@DM6PR11MB4201.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tuLbX+ZG4UxPFsh6IzjvEM7u9aw40TPg1wyjNMtGJ2uN6KIAoDwrWgdZ3V4GM4NCbEIS9QPt6pLPfxLTgNmr+QDJJ6rSoLPf5uBqHuetnBJKB6Qj8O4jcOa6L3CmZSEHsO1aO2nl3zL0helfvOkItVBe+/4xQcu1CRi2KafxiHBeMiNqgvp6eT3GF3E0JJR1/EUC9ya4kVBX32ad7q1Un0Z1kkRWcVHhWgCS8smELE6fnp/VXfD4yNQCzvkp6uIiIKx5Phf/hYRw8sTLU5c51rUudd6mxVBPOIV+e86nRpFRT4K2fuKOXocoiNpqgaR/Nv8j8tebRwO4mu8PYiMYirV3zM2UOrp8SBSeggEUQSGXuaiOp0CF5lhhv5vHrbJRmUXLzJNzcXsFAWzhTyOLWhAlV/vjBvkpi54V4vulqIu40Dg2G/3eD0ofIVxh6j67
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(55016002)(478600001)(7696005)(2906002)(186003)(110136005)(76116006)(6506007)(26005)(4326008)(966005)(5660300002)(316002)(52536014)(8936002)(66446008)(7416002)(30864003)(83380400001)(71200400001)(33656002)(6636002)(66556008)(66476007)(9686003)(86362001)(8676002)(66946007)(54906003)(64756008)(921003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: R1m0CPM1BNe3rW1rdekABmKkKgqWwVa0IGKLfzcS8T6hclZOQaalRp7LkOZfRxHt8o6ENGSth0IJMew0Nq1g/jVfnvDV0702RBM3PJJaP3W2LeYqATC7rNMMUHhXie3ZvZ2LZ4UbbeeMj7UU1ovbCShb31cMRjhQW4dB4AINPt/E3g5jUjN+6Ch2f+wzg/lvL5Rf9E9uFthRGsQBFuGwIANUKCu1CNuD6xgwmiROQTIr4EyyfcPvXxlKp85M3e9cqIUVBZ7bWFEK6pNdsoCEyMbBfFl+CfiTHEQmlq6qWQi3PuNjo+9SeD/HGwVDzmM2XPVzKyHXsNS/fnY+h5FwQBL7OY4WZZU8/pb2IKXTxNwT2wRJKrNvd9BQpuPOT2K4gDeA4SeSMs8fztrWENbIkfY5l0BNMZ+McgA+9MwdAEGaXSvoxZeqgPcYQkMVKSrxrBFEJibhOKhG8id2hKzPgjHndDkmLyjiPN+9OKogvg6Ya3lSCPfmrfX7LF9NfJRE
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6132a85a-fe1a-4ae1-5588-08d827a589a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 03:25:20.3751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7xEvz208qiYmZ6FPee9zC66z0Hon8PsKCd8/gq7sT0qd+EQufplKLt7KeghCkbSuLYZbCOaGX7lDFcrtVlBAgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4201
X-OriginatorOrg: intel.com
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>
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

> From: Fenghua Yu <fenghua.yu@intel.com>
> Sent: Tuesday, July 14, 2020 7:48 AM
> 
> From: Ashok Raj <ashok.raj@intel.com>
> 
> ENQCMD and Data Streaming Accelerator (DSA) and all of their associated features
> are a complicated stack with lots of interconnected pieces.
> This documentation provides a big picture overview for all of the features.
> 
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> v3:
> - Replace deprecated intel_svm_bind_mm() by iommu_sva_bind_mm() (Baolu)
> - Fix a couple of typos (Baolu)
> 
> v2:
> - Fix the doc format and add the doc in toctree (Thomas)
> - Modify the doc for better description (Thomas, Tony, Dave)
> 
>  Documentation/x86/index.rst |   1 +
>  Documentation/x86/sva.rst   | 287 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 288 insertions(+)
>  create mode 100644 Documentation/x86/sva.rst
> 
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst index
> 265d9e9a093b..e5d5ff096685 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -30,3 +30,4 @@ x86-specific Documentation
>     usb-legacy-support
>     i386/index
>     x86_64/index
> +   sva
> diff --git a/Documentation/x86/sva.rst b/Documentation/x86/sva.rst new file mode
> 100644 index 000000000000..7242a84169ef
> --- /dev/null
> +++ b/Documentation/x86/sva.rst
> @@ -0,0 +1,287 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===========================================
> +Shared Virtual Addressing (SVA) with ENQCMD
> +===========================================
> +
> +Background
> +==========
> +
> +Shared Virtual Addressing (SVA) allows the processor and device to use
> +the same virtual addresses avoiding the need for software to translate
> +virtual addresses to physical addresses. SVA is what PCIe calls Shared
> +Virtual Memory (SVM)
> +
> +In addition to the convenience of using application virtual addresses
> +by the device, it also doesn't require pinning pages for DMA.
> +PCIe Address Translation Services (ATS) along with Page Request
> +Interface
> +(PRI) allow devices to function much the same way as the CPU handling
> +application page-faults. For more information please refer to PCIe
> +specification Chapter 10: ATS Specification.
> +

nit: may be helpful to mention Chapter 10 of PCIe spec since 4.0. before that, ATS has its
own specification.

> +Use of SVA requires IOMMU support in the platform. IOMMU also is
> +required to support PCIe features ATS and PRI. ATS allows devices to
> +cache translations for the virtual address. IOMMU driver uses the
> +mmu_notifier() support to keep the device tlb cache and the CPU cache
> +in sync. PRI allows the device to request paging the virtual address
> +before using if they are not paged in the CPU page tables.
> +
> +
> +Shared Hardware Workqueues
> +==========================
> +
> +Unlike Single Root I/O Virtualization (SRIOV), Scalable IOV (SIOV)
> +permits the use of Shared Work Queues (SWQ) by both applications and
> +Virtual Machines (VM's). This allows better hardware utilization vs.
> +hard partitioning resources that could result in under utilization. In
> +order to allow the hardware to distinguish the context for which work
> +is being executed in the hardware by SWQ interface, SIOV uses Process
> +Address Space ID (PASID), which is a 20bit number defined by the PCIe SIG.
> +
> +PASID value is encoded in all transactions from the device. This allows
> +the IOMMU to track I/O on a per-PASID granularity in addition to using
> +the PCIe Resource Identifier (RID) which is the Bus/Device/Function.
> +
> +
> +ENQCMD
> +======
> +
> +ENQCMD is a new instruction on Intel platforms that atomically submits
> +a work descriptor to a device. The descriptor includes the operation to
> +be performed, virtual addresses of all parameters, virtual address of a
> +completion record, and the PASID (process address space ID) of the current process.
> +
> +ENQCMD works with non-posted semantics and carries a status back if the
> +command was accepted by hardware. This allows the submitter to know if
> +the submission needs to be retried or other device specific mechanisms
> +to implement fairness or ensure forward progress can be made.
> +
> +ENQCMD is the glue that ensures applications can directly submit
> +commands to the hardware and also permit hardware to be aware of
> +application context to perform I/O operations via use of PASID.
> +

maybe a reader will ask about ENQCMDs after reading ENQCMD/S spec. :-)

> +Process Address Space Tagging
> +=============================
> +
> +A new thread scoped MSR (IA32_PASID) provides the connection between
> +user processes and the rest of the hardware. When an application first
> +accesses an SVA capable device this MSR is initialized with a newly
> +allocated PASID. The driver for the device calls an IOMMU specific api
> +that sets up the routing for DMA and page-requests.
> +
> +For example, the Intel Data Streaming Accelerator (DSA) uses
> +iommu_sva_bind_device(), which will do the following.
> +
> +- Allocate the PASID, and program the process page-table (cr3) in the
> +PASID
> +  context entries.

nit: s/PASID context entries/PASID table entries/

> +- Register for mmu_notifier() to track any page-table invalidations to
> +keep
> +  the device tlb in sync. For example, when a page-table entry is

not only device tlb. I guess iotlb is also included.

> +invalidated,
> +  IOMMU propagates the invalidation to device tlb. This will force any
> +  future access by the device to this virtual address to participate in
> +  ATS. If the IOMMU responds with proper response that a page is not
> +  present, the device would request the page to be paged in via the
> +PCIe PRI
> +  protocol before performing I/O.
> +
> +This MSR is managed with the XSAVE feature set as "supervisor state" to
> +ensure the MSR is updated during context switch.
> +
> +PASID Management
> +================
> +
> +The kernel must allocate a PASID on behalf of each process and program
> +it into the new MSR to communicate the process identity to platform hardware.
> +ENQCMD uses the PASID stored in this MSR to tag requests from this process.
> +When a user submits a work descriptor to a device using the ENQCMD
> +instruction, the PASID field in the descriptor is auto-filled with the
> +value from MSR_IA32_PASID. Requests for DMA from the device are also
> +tagged with the same PASID. The platform IOMMU uses the PASID in the

not quite get " Requests for DMA from the device are also tagged with the same PASID"

> +transaction to perform address translation. The IOMMU api's setup the

s/api's/apis/ ?

> +corresponding PASID entry in IOMMU with the process address used by the CPU
> (for e.g cr3 in x86).

with the process page tables used by the CPU (e.g. the page tables pointed by cr3 in x86).

> +
> +The MSR must be configured on each logical CPU before any application

s/MSR/MSR_IA32_PASID/

> +thread can interact with a device. Threads that belong to the same
> +process share the same page tables, thus the same MSR value.

s/MSR/PASID/

> +
> +PASID is cleared when a process is created. The PASID allocation and

s/PASID/MSR_IA32_PASID/

> +MSR programming may occur long after a process and its threads have been
> created.
> +One thread must call bind() to allocate the PASID for the process. If a

s/bind()/iommu_sva_bind_device()/ or say "call iommu api to bind a process with
a device." :-)

> +thread uses ENQCMD without the MSR first being populated, it will cause #GP.
> +The kernel will fix up the #GP by writing the process-wide PASID into
> +the thread that took the #GP. A single process PASID can be used
> +simultaneously with multiple devices since they all share the same address space.

simultaneously with multiple devices if they all share the process address space.

> +
> +New threads could inherit the MSR value from the parent. But this would

s/MSR/MSR_IA32_PASID/

> +involve additional state management for those threads which may never
> +use ENQCMD. Clearing the MSR at thread creation permits all threads to
> +have a consistent behavior; the PASID is only programmed when the
> +thread calls the bind() api (iommu_sva_bind_device()()), or when a
> +thread calls ENQCMD for the first time.
> +
> +PASID Lifecycle Management
> +==========================
> +
> +Only processes that access SVA capable devices need to have a PASID
> +allocated. This allocation happens when a process first opens an SVA
> +capable device (subsequent opens of the same, or other devices will
> +share the same PASID).
> +
> +Although the PASID is allocated to the process by opening a device, it
> +is not active in any of the threads of that process. Activation is done
> +lazily when a thread tries to submit a work descriptor to a device
> +using the ENQCMD.
> +
> +That first access will trigger a #GP fault because the IA32_PASID MSR
> +has not been initialized with the PASID value assigned to the process
> +when the device was opened. The Linux #GP handler notes that a PASID as
> +been allocated for the process, and so initializes the IA32_PASID MSR
> +and returns so that the ENQCMD instruction is re-executed.
> +
> +On fork(2) or exec(2) the PASID is removed from the process as it no
> +longer has the same address space that it had when the device was opened.
> +
> +On clone(2) the new task shares the same address space, so will be able
> +to use the PASID allocated to the process. The IA32_PASID is not
> +preemptively initialized as the kernel does not know whether this
> +thread is going to access the device.
> +
> +On exit(2) the PASID is freed. The device driver ensures that any
> +pending operations queued to the device are either completed or aborted
> +before allowing the PASID to be reallocated.
> +
> +Relationships
> +=============
> +
> + * Each process has many threads, but only one PASID
> + * Devices have a limited number (~10's to 1000's) of hardware
> +   workqueues and each portal maps down to a single workqueue.
> +   The device driver manages allocating hardware workqueues.
> + * A single mmap() maps a single hardware workqueue as a "portal"
> + * For each device with which a process interacts, there must be
> +   one or more mmap()'d portals.
> + * Many threads within a process can share a single portal to access
> +   a single device.
> + * Multiple processes can separately mmap() the same portal, in
> +   which case they still share one device hardware workqueue.
> + * The single process-wide PASID is used by all threads to interact
> +   with all devices.  There is not, for instance, a PASID for each

s/with all devices/with all devices manipulated by the process/

Regards,
Yi Liu

> +   thread or each thread<->device pair.
> +
> +FAQ
> +===
> +
> +* What is SVA/SVM?
> +
> +Shared Virtual Addressing (SVA) permits I/O hardware and the processor
> +to work in the same address space. In short, sharing the address space.
> +Some call it Shared Virtual Memory (SVM), but Linux community wanted to
> +avoid it with Posix Shared Memory and Secure Virtual Machines which
> +were terms already in circulation.
> +
> +* What is a PASID?
> +
> +A Process Address Space ID (PASID) is a PCIe-defined TLP Prefix. A
> +PASID is a 20 bit number allocated and managed by the OS. PASID is
> +included in all transactions between the platform and the device.
> +
> +* How are shared work queues different?
> +
> +Traditionally to allow user space applications interact with hardware,
> +there is a separate instance required per process. For example,
> +consider doorbells as a mechanism of informing hardware about work to
> +process. Each doorbell is required to be spaced 4k (or page-size) apart
> +for process isolation. This requires hardware to provision that space
> +and reserve in MMIO. This doesn't scale as the number of threads
> +becomes quite large. The hardware also manages the queue depth for
> +Shared Work Queues (SWQ), and consumers don't need to track queue
> +depth. If there is no space to accept a command, the device will return
> +an error indicating retry. Also submitting a command to an MMIO address
> +that can't accept ENQCMD will return retry in response. In the new DMWr
> +PCIe terminology, devices need to support DMWr completer capability. In
> +addition it requires all switch ports to support DMWr routing and must
> +be enabled by the PCIe subsystem, much like how PCIe Atomics() are managed for
> instance.
> +
> +SWQ allows hardware to provision just a single address in the device.
> +When used with ENQCMD to submit work, the device can distinguish the
> +process submitting the work since it will include the PASID assigned to
> +that process. This decreases the pressure of hardware requiring to
> +support hardware to scale to a large number of processes.
> +
> +* Is this the same as a user space device driver?
> +
> +Communicating with the device via the shared work queue is much simpler
> +than a full blown user space driver. The kernel driver does all the
> +initialization of the hardware. User space only needs to worry about
> +submitting work and processing completions.
> +
> +* Is this the same as SR-IOV?
> +
> +Single Root I/O Virtualization (SR-IOV) focuses on providing
> +independent hardware interfaces for virtualizing hardware. Hence its
> +required to be almost fully functional interface to software supporting
> +the traditional BAR's, space for interrupts via MSI-x, its own register layout.
> +Virtual Functions (VFs) are assisted by the Physical Function (PF)
> +driver.
> +
> +Scalable I/O Virtualization builds on the PASID concept to create
> +device instances for virtualization. SIOV requires host software to
> +assist in creating virtual devices, each virtual device is represented
> +by a PASID along with the BDF of the device.  This allows device
> +hardware to optimize device resource creation and can grow dynamically
> +on demand. SR-IOV creation and management is very static in nature.
> +Consult references below for more details.
> +
> +* Why not just create a virtual function for each app?
> +
> +Creating PCIe SRIOV type virtual functions (VF) are expensive. They
> +create duplicated hardware for PCI config space requirements,
> +Interrupts such as MSIx for instance. Resources such as interrupts have
> +to be hard partitioned between VF's at creation time, and cannot scale
> +dynamically on demand. The VF's are not completely independent from the
> +Physical function (PF). Most VF's require some communication and
> +assistance from the PF driver. SIOV creates a software defined device.
> +Where all the configuration and control aspects are mediated via the
> +slow path. The work submission and completion happen without any mediation.
> +
> +* Does this support virtualization?
> +
> +ENQCMD can be used from within a guest VM. In these cases the VMM helps
> +with setting up a translation table to translate from Guest PASID to
> +Host PASID. Please consult the ENQCMD instruction set reference for
> +more details.
> +
> +* Does memory need to be pinned?
> +
> +When devices support SVA, along with platform hardware such as IOMMU
> +supporting such devices, there is no need to pin memory for DMA purposes.
> +Devices that support SVA also support other PCIe features that remove
> +the pinning requirement for memory.
> +
> +Device TLB support - Device requests the IOMMU to lookup an address
> +before use via Address Translation Service (ATS) requests.  If the
> +mapping exists but there is no page allocated by the OS, IOMMU hardware
> +returns that no mapping exists.
> +
> +Device requests that virtual address to be mapped via Page Request
> +Interface (PRI). Once the OS has successfully completed  the mapping,
> +it returns the response back to the device. The device continues again
> +to request for a translation and continues.
> +
> +IOMMU works with the OS in managing consistency of page-tables with the
> +device. When removing pages, it interacts with the device to remove any
> +device-tlb that might have been cached before removing the mappings
> +from the OS.
> +
> +References
> +==========
> +
> +VT-D:
> +https://01.org/blogs/ashokraj/2018/recent-enhancements-intel-virtualiza
> +tion-technology-directed-i/o-intel-vt-d
> +
> +SIOV:
> +https://01.org/blogs/2019/assignable-interfaces-intel-scalable-i/o-virt
> +ualization-linux
> +
> +ENQCMD in ISE:
> +https://software.intel.com/sites/default/files/managed/c5/15/architectu
> +re-instruction-set-extensions-programming-reference.pdf
> +
> +DSA spec:
> +https://software.intel.com/sites/default/files/341204-intel-data-stream
> +ing-accelerator-spec.pdf
> --
> 2.19.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
