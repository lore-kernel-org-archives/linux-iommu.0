Return-Path: <SRS0=Ybkk=5L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C478C43331
	for <iommu@archiver.kernel.org>; Thu, 26 Mar 2020 12:56:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF882073E
	for <iommu@archiver.kernel.org>; Thu, 26 Mar 2020 12:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF882073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D803788937;
	Thu, 26 Mar 2020 12:56:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9+T+5cpGcBNq; Thu, 26 Mar 2020 12:56:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A5B3588915;
	Thu, 26 Mar 2020 12:56:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AFB3C1D7C;
	Thu, 26 Mar 2020 12:56:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 549AEC0177
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 12:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 235FA261BE
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 12:56:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cvQFcEa+bl9Q for <iommu@lists.linux-foundation.org>;
 Thu, 26 Mar 2020 12:56:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by silver.osuosl.org (Postfix) with ESMTPS id 05BA7204D4
 for <iommu@lists.linux-foundation.org>; Thu, 26 Mar 2020 12:56:19 +0000 (UTC)
IronPort-SDR: e0leqXBn2b5/LwtNfY59ELG2O8dIgUMi4vD7wL5s9QaVRmzeGmZzRE0h81p6DyGp4ZHdE4Ke+X
 8tuJlKR0kHLg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2020 05:56:19 -0700
IronPort-SDR: yiOsM0HzQtPs7uCAalT1rmEaVhDVR7PBoOr5v2NRZQDpTvBCDiL/gALwpPAPkTAp+Rfv0LXRHs
 WUCGki2QgF7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,308,1580803200"; d="scan'208";a="393970616"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga004.jf.intel.com with ESMTP; 26 Mar 2020 05:56:18 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Mar 2020 05:56:18 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.50]) with mapi id 14.03.0439.000;
 Thu, 26 Mar 2020 20:56:13 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [PATCH v1 0/8] vfio: expose virtual Shared Virtual Addressing
 to VMs
Thread-Topic: [PATCH v1 0/8] vfio: expose virtual Shared Virtual Addressing
 to VMs
Thread-Index: AQHWAEUdI4Sfhdx3H0+yWIyqzj+O7Kha2xeQ
Date: Thu, 26 Mar 2020 12:56:13 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A20440A@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
In-Reply-To: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, 
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun, Yi
 Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Sunday, March 22, 2020 8:32 PM
> To: alex.williamson@redhat.com; eric.auger@redhat.com
> Subject: [PATCH v1 0/8] vfio: expose virtual Shared Virtual Addressing to VMs
> 
> From: Liu Yi L <yi.l.liu@intel.com>
> 
> Shared Virtual Addressing (SVA), a.k.a, Shared Virtual Memory (SVM) on
> Intel platforms allows address space sharing between device DMA and
> applications. SVA can reduce programming complexity and enhance security.
> 
> This VFIO series is intended to expose SVA usage to VMs. i.e. Sharing
> guest application address space with passthru devices. This is called
> vSVA in this series. The whole vSVA enabling requires QEMU/VFIO/IOMMU
> changes. For IOMMU and QEMU changes, they are in separate series (listed
> in the "Related series").
> 
> The high-level architecture for SVA virtualization is as below, the key
> design of vSVA support is to utilize the dual-stage IOMMU translation (
> also known as IOMMU nesting translation) capability in host IOMMU.
> 
> 
>     .-------------.  .---------------------------.
>     |   vIOMMU    |  | Guest process CR3, FL only|
>     |             |  '---------------------------'
>     .----------------/
>     | PASID Entry |--- PASID cache flush -
>     '-------------'                       |
>     |             |                       V
>     |             |                CR3 in GPA
>     '-------------'
> Guest
> ------| Shadow |--------------------------|--------
>       v        v                          v
> Host
>     .-------------.  .----------------------.
>     |   pIOMMU    |  | Bind FL for GVA-GPA  |
>     |             |  '----------------------'
>     .----------------/  |
>     | PASID Entry |     V (Nested xlate)
>     '----------------\.------------------------------.
>     |             |   |SL for GPA-HPA, default domain|
>     |             |   '------------------------------'
>     '-------------'
> Where:
>  - FL = First level/stage one page tables
>  - SL = Second level/stage two page tables
> 
> There are roughly four parts in this patchset which are
> corresponding to the basic vSVA support for PCI device
> assignment
>  1. vfio support for PASID allocation and free for VMs
>  2. vfio support for guest page table binding request from VMs
>  3. vfio support for IOMMU cache invalidation from VMs
>  4. vfio support for vSVA usage on IOMMU-backed mdevs
> 
> The complete vSVA kernel upstream patches are divided into three phases:
>     1. Common APIs and PCI device direct assignment
>     2. IOMMU-backed Mediated Device assignment
>     3. Page Request Services (PRS) support
> 
> This patchset is aiming for the phase 1 and phase 2, and based on Jacob's
> below series.
> [PATCH V10 00/11] Nested Shared Virtual Address (SVA) VT-d support:
> https://lkml.org/lkml/2020/3/20/1172
> 
> Complete set for current vSVA can be found in below branch.
> https://github.com/luxis1999/linux-vsva.git: vsva-linux-5.6-rc6
> 
> The corresponding QEMU patch series is as below, complete QEMU set can be
> found in below branch.
> [PATCH v1 00/22] intel_iommu: expose Shared Virtual Addressing to VMs
> complete QEMU set can be found in below link:
> https://github.com/luxis1999/qemu.git: sva_vtd_v10_v1

The ioasid extension is in the below link.

https://lkml.org/lkml/2020/3/25/874

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
