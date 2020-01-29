Return-Path: <SRS0=Gm0N=3S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD43C33CB2
	for <iommu@archiver.kernel.org>; Wed, 29 Jan 2020 12:18:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35C94207FD
	for <iommu@archiver.kernel.org>; Wed, 29 Jan 2020 12:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C94207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0922020364;
	Wed, 29 Jan 2020 12:18:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oPQZLIh4rKHi; Wed, 29 Jan 2020 12:18:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 83EB420395;
	Wed, 29 Jan 2020 12:18:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69C3EC0178;
	Wed, 29 Jan 2020 12:18:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23EB9C0171
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jan 2020 12:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1F3B786E26
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jan 2020 12:18:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yuOMIu4qoQUX for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jan 2020 12:18:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by whitealder.osuosl.org (Postfix) with ESMTPS id AB4B086E1A
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jan 2020 12:18:03 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 04:18:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,377,1574150400"; d="scan'208";a="429662333"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga006.fm.intel.com with ESMTP; 29 Jan 2020 04:18:03 -0800
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 29 Jan 2020 04:18:03 -0800
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 29 Jan 2020 04:18:02 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.197]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.202]) with mapi id 14.03.0439.000;
 Wed, 29 Jan 2020 20:18:01 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>, "Joerg
 Roedel" <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Subject: RE: [PATCH V9 00/10] Nested Shared Virtual Address (SVA) VT-d support
Thread-Topic: [PATCH V9 00/10] Nested Shared Virtual Address (SVA) VT-d support
Thread-Index: AQHV1mjm+L2VVYcVTkms4SxIhsuAo6gBjx2g
Date: Wed, 29 Jan 2020 12:18:00 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A196172@SHSMSX104.ccr.corp.intel.com>
References: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmZhZTY2MzItODRlMC00YjBmLWEzZjUtNWQwOTJiYzUyMGY3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoid1V5ZjlycjBxcVFSV2VhaUNqSU1PaE1hRTdvMm0ycTNYbnV4cVNrMFk3cWdWdk14aUJUblhFYVlaS0VIeU1pRSJ9
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Jonathan Cameron <jic23@kernel.org>
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

> From: Jacob Pan [mailto:jacob.jun.pan@linux.intel.com]
> Sent: Wednesday, January 29, 2020 2:02 PM
> Subject: [PATCH V9 00/10] Nested Shared Virtual Address (SVA) VT-d support
> 
> Shared virtual address (SVA), a.k.a, Shared virtual memory (SVM) on Intel platforms
> allow address space sharing between device DMA and applications.
> SVA can reduce programming complexity and enhance security.
> This series is intended to enable SVA virtualization, i.e. enable use of SVA within a
> guest user application.
> 
> This is the remaining portion of the original patchset that is based on Joerg's x86/vt-
> d branch. The preparatory and cleanup patches are merged here.
> (git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git)
> 
> Only IOMMU portion of the changes are included in this series. Additional support is
> needed in VFIO and QEMU (will be submitted separately) to complete this
> functionality.
> 
> To make incremental changes and reduce the size of each patchset. This series does
> not inlcude support for page request services.
> 
> In VT-d implementation, PASID table is per device and maintained in the host.
> Guest PASID table is shadowed in VMM where virtual IOMMU is emulated.
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
> This is the remaining VT-d only portion of V5 since the uAPIs and IOASID common
> code have been applied to Joerg's IOMMU core branch.
> (https://lkml.org/lkml/2019/10/2/833)
> 
> The complete set with VFIO patches are here:
> https://github.com/jacobpan/linux.git:siov_sva

The complete QEMU set can be found in below link:
https://github.com/luxis1999/qemu.git: sva_vtd_v9_rfcv3

Complete kernel can be found in:
https://github.com/luxis1999/linux-vsva: vsva-linux-5.5-rc3

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
