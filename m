Return-Path: <SRS0=Sm7F=2K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46182C2D0D3
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 11:51:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 158D024680
	for <iommu@archiver.kernel.org>; Fri, 20 Dec 2019 11:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158D024680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E22CC8726A;
	Fri, 20 Dec 2019 11:50:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id agQGU_v4aNkb; Fri, 20 Dec 2019 11:50:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D433586FF6;
	Fri, 20 Dec 2019 11:50:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBBC3C1796;
	Fri, 20 Dec 2019 11:50:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D41DC077D
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 11:50:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EB189251AE
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 11:50:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pSFZRYVJ4x-O for <iommu@lists.linux-foundation.org>;
 Fri, 20 Dec 2019 11:50:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by silver.osuosl.org (Postfix) with ESMTPS id EDE51250BF
 for <iommu@lists.linux-foundation.org>; Fri, 20 Dec 2019 11:50:55 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Dec 2019 03:50:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,335,1571727600"; d="scan'208";a="228584602"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
 by orsmga002.jf.intel.com with ESMTP; 20 Dec 2019 03:50:54 -0800
Received: from fmsmsx115.amr.corp.intel.com (10.18.116.19) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 20 Dec 2019 03:50:54 -0800
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 fmsmsx115.amr.corp.intel.com (10.18.116.19) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 20 Dec 2019 03:50:54 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.90]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.29]) with mapi id 14.03.0439.000;
 Fri, 20 Dec 2019 19:50:52 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, David
 Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v4 0/7] Use 1st-level for IOVA translation
Thread-Topic: [PATCH v4 0/7] Use 1st-level for IOVA translation
Thread-Index: AQHVthray/3ZZTiwzUq7igUsBwcT3qfC6XAw
Date: Fri, 20 Dec 2019 11:50:52 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A13A364@SHSMSX104.ccr.corp.intel.com>
References: <20191219031634.15168-1-baolu.lu@linux.intel.com>
In-Reply-To: <20191219031634.15168-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzVmNGY2YTUtM2IzMC00NWJjLTg0ZjYtYzk2NGM2YjlhNGZiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiK0NqSTRiTk9FY0ltVksrZ1cxWWtXUlhRZlI1MG1Zb0RNdnZJZ3FsUnMrNlZWN3diOUl3QlNvMVhaSHlzYVwvQUsifQ==
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun, 
 Yi Y" <yi.y.sun@intel.com>
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

Hi Baolu,

In a brief, this version is pretty good to me. However, I still want
to have the following checks to see if anything missed. Wish it
helps.

1) would using IOVA over FLPT default on?
My opinion is that before we have got gIOVA nested translation
done for passthru devices, we should make this feature as off.

2) the domain->agaw is somehow calculated according to the
capabilities related to second level page table. As we are moving
IOVA to FLPT, I'd suggest to calculate domain->agaw with the
translation modes FLPT supports (e.g. 4 level and 5 level)

3) Per VT-d spec, FLPT has canonical requirement to the input
addresses. So I'd suggest to add some enhance regards to it.
Please refer to chapter 3.6 :-).

3.6 First-Level Translation
First-level translation restricts the input-address to a canonical address (i.e., address bits 63:N have
the same value as address bit [N-1], where N is 48-bits with 4-level paging and 57-bits with 5-level
paging). Requests subject to first-level translation by remapping hardware are subject to canonical
address checking as a pre-condition for first-level translation, and a violation is treated as a
translation-fault.

Regards,
Yi Liu

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Thursday, December 19, 2019 11:16 AM
> To: Joerg Roedel <joro@8bytes.org>; David Woodhouse <dwmw2@infradead.org>;
> Alex Williamson <alex.williamson@redhat.com>
> Subject: [PATCH v4 0/7] Use 1st-level for IOVA translation
> 
> Intel VT-d in scalable mode supports two types of page tables
> for DMA translation: the first level page table and the second
> level page table. The first level page table uses the same
> format as the CPU page table, while the second level page table
> keeps compatible with previous formats. The software is able
> to choose any one of them for DMA remapping according to the use
> case.
> 
> This patchset aims to move IOVA (I/O Virtual Address) translation
> to 1st-level page table in scalable mode. This will simplify vIOMMU
> (IOMMU simulated by VM hypervisor) design by using the two-stage
> translation, a.k.a. nested mode translation.
> 
> As Intel VT-d architecture offers caching mode, guest IOVA (GIOVA)
> support is currently implemented in a shadow page manner. The device
> simulation software, like QEMU, has to figure out GIOVA->GPA mappings
> and write them to a shadowed page table, which will be used by the
> physical IOMMU. Each time when mappings are created or destroyed in
> vIOMMU, the simulation software has to intervene. Hence, the changes
> on GIOVA->GPA could be shadowed to host.
> 
> 
>      .-----------.
>      |  vIOMMU   |
>      |-----------|                 .--------------------.
>      |           |IOTLB flush trap |        QEMU        |
>      .-----------. (map/unmap)     |--------------------|
>      |GIOVA->GPA |---------------->|    .------------.  |
>      '-----------'                 |    | GIOVA->HPA |  |
>      |           |                 |    '------------'  |
>      '-----------'                 |                    |
>                                    |                    |
>                                    '--------------------'
>                                                 |
>             <------------------------------------
>             |
>             v VFIO/IOMMU API
>       .-----------.
>       |  pIOMMU   |
>       |-----------|
>       |           |
>       .-----------.
>       |GIOVA->HPA |
>       '-----------'
>       |           |
>       '-----------'
> 
> In VT-d 3.0, scalable mode is introduced, which offers two-level
> translation page tables and nested translation mode. Regards to
> GIOVA support, it can be simplified by 1) moving the GIOVA support
> over 1st-level page table to store GIOVA->GPA mapping in vIOMMU,
> 2) binding vIOMMU 1st level page table to the pIOMMU, 3) using pIOMMU
> second level for GPA->HPA translation, and 4) enable nested (a.k.a.
> dual-stage) translation in host. Compared with current shadow GIOVA
> support, the new approach makes the vIOMMU design simpler and more
> efficient as we only need to flush the pIOMMU IOTLB and possible
> device-IOTLB when an IOVA mapping in vIOMMU is torn down.
> 
>      .-----------.
>      |  vIOMMU   |
>      |-----------|                 .-----------.
>      |           |IOTLB flush trap |   QEMU    |
>      .-----------.    (unmap)      |-----------|
>      |GIOVA->GPA |---------------->|           |
>      '-----------'                 '-----------'
>      |           |                       |
>      '-----------'                       |
>            <------------------------------
>            |      VFIO/IOMMU
>            |  cache invalidation and
>            | guest gpd bind interfaces
>            v
>      .-----------.
>      |  pIOMMU   |
>      |-----------|
>      .-----------.
>      |GIOVA->GPA |<---First level
>      '-----------'
>      | GPA->HPA  |<---Scond level
>      '-----------'
>      '-----------'
> 
> This patch applies the first level page table for IOVA translation
> unless the DOMAIN_ATTR_NESTING domain attribution has been set.
> Setting of this attribution means the second level will be used to
> map gPA (guest physical address) to hPA (host physical address), and
> the mappings between gVA (guest virtual address) and gPA will be
> maintained by the guest with the page table address binding to host's
> first level.
> 
> Based-on-idea-by: Ashok Raj <ashok.raj@intel.com>
> Based-on-idea-by: Kevin Tian <kevin.tian@intel.com>
> Based-on-idea-by: Liu Yi L <yi.l.liu@intel.com>
> Based-on-idea-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Based-on-idea-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Based-on-idea-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Change log:
> 
> v3->v4:
>  - The previous version was posted here
>    https://lkml.org/lkml/2019/12/10/2126
>  - Set Execute Disable (bit 63) in first level table entries.
>  - Enhance pasid-based iotlb invalidation for both default domain
>    and auxiliary domain.
>  - Add debugfs file to expose page table internals.
> 
> v2->v3:
>  - The previous version was posted here
>    https://lkml.org/lkml/2019/11/27/1831
>  - Accept Jacob's suggestion on merging two page tables.
> 
>  v1->v2
>  - The first series was posted here
>    https://lkml.org/lkml/2019/9/23/297
>  - Use per domain page table ops to handle different page tables.
>  - Use first level for DMA remapping by default on both bare metal
>    and vm guest.
>  - Code refine according to code review comments for v1.
> 
> Lu Baolu (7):
>   iommu/vt-d: Identify domains using first level page table
>   iommu/vt-d: Add set domain DOMAIN_ATTR_NESTING attr
>   iommu/vt-d: Add PASID_FLAG_FL5LP for first-level pasid setup
>   iommu/vt-d: Setup pasid entries for iova over first level
>   iommu/vt-d: Flush PASID-based iotlb for iova over first level
>   iommu/vt-d: Use iova over first level
>   iommu/vt-d: debugfs: Add support to show page table internals
> 
>  drivers/iommu/dmar.c                |  41 ++++++
>  drivers/iommu/intel-iommu-debugfs.c |  75 +++++++++++
>  drivers/iommu/intel-iommu.c         | 201 +++++++++++++++++++++++++---
>  drivers/iommu/intel-pasid.c         |   7 +-
>  drivers/iommu/intel-pasid.h         |   6 +
>  drivers/iommu/intel-svm.c           |   8 +-
>  include/linux/intel-iommu.h         |  20 ++-
>  7 files changed, 326 insertions(+), 32 deletions(-)
> 
> --
> 2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
