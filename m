Return-Path: <SRS0=GLpr=2W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF47C32764
	for <iommu@archiver.kernel.org>; Wed,  1 Jan 2020 23:39:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E46221D7D
	for <iommu@archiver.kernel.org>; Wed,  1 Jan 2020 23:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E46221D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1820B87360;
	Wed,  1 Jan 2020 23:39:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zb1OwGAhdSzj; Wed,  1 Jan 2020 23:39:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3911286FAE;
	Wed,  1 Jan 2020 23:39:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AD24C1D80;
	Wed,  1 Jan 2020 23:39:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42FAAC077D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jan 2020 23:39:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0B4A620366
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jan 2020 23:39:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L30uUCLWOevN for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jan 2020 23:39:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by silver.osuosl.org (Postfix) with ESMTPS id EFF6820357
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jan 2020 23:39:33 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Jan 2020 15:39:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,384,1571727600"; d="scan'208";a="244468702"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by fmsmga004.fm.intel.com with ESMTP; 01 Jan 2020 15:39:30 -0800
Subject: Re: [PATCH v5 0/9] Use 1st-level for IOVA translation
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20191224074502.5545-1-baolu.lu@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8b40dd00-3bec-1fd9-9ba7-0db9fd727e52@linux.intel.com>
Date: Thu, 2 Jan 2020 07:38:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191224074502.5545-1-baolu.lu@linux.intel.com>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, yi.y.sun@intel.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 12/24/19 3:44 PM, Lu Baolu wrote:
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
>       .-----------.
>       |  vIOMMU   |
>       |-----------|                 .--------------------.
>       |           |IOTLB flush trap |        QEMU        |
>       .-----------. (map/unmap)     |--------------------|
>       |GIOVA->GPA |---------------->|    .------------.  |
>       '-----------'                 |    | GIOVA->HPA |  |
>       |           |                 |    '------------'  |
>       '-----------'                 |                    |
>                                     |                    |
>                                     '--------------------'
>                                                  |
>              <------------------------------------
>              |
>              v VFIO/IOMMU API
>        .-----------.
>        |  pIOMMU   |
>        |-----------|
>        |           |
>        .-----------.
>        |GIOVA->HPA |
>        '-----------'
>        |           |
>        '-----------'
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
>       .-----------.
>       |  vIOMMU   |
>       |-----------|                 .-----------.
>       |           |IOTLB flush trap |   QEMU    |
>       .-----------.    (unmap)      |-----------|
>       |GIOVA->GPA |---------------->|           |
>       '-----------'                 '-----------'
>       |           |                       |
>       '-----------'                       |
>             <------------------------------
>             |      VFIO/IOMMU
>             |  cache invalidation and
>             | guest gpd bind interfaces
>             v
>       .-----------.
>       |  pIOMMU   |
>       |-----------|
>       .-----------.
>       |GIOVA->GPA |<---First level
>       '-----------'
>       | GPA->HPA  |<---Scond level
>       '-----------'
>       '-----------'
> 
> This patch applies the first level page table for IOVA translation
> unless the DOMAIN_ATTR_NESTING domain attribution has been set.
> Setting of this attribution means the second level will be used to
> map gPA (guest physical address) to hPA (host physical address), and
> the mappings between gVA (guest virtual address) and gPA will be
> maintained by the guest with the page table address binding to host's
> first level.
> 
> Based-on-idea-by: Ashok Raj<ashok.raj@intel.com>
> Based-on-idea-by: Kevin Tian<kevin.tian@intel.com>
> Based-on-idea-by: Liu Yi L<yi.l.liu@intel.com>
> Based-on-idea-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> Based-on-idea-by: Sanjay Kumar<sanjay.k.kumar@intel.com>
> Based-on-idea-by: Lu Baolu<baolu.lu@linux.intel.com>

Queued all patches for v5.6.

Thanks,
-baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
