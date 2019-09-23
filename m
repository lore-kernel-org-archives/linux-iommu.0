Return-Path: <SRS0=v/Dl=XS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FC3C4CED0
	for <iommu@archiver.kernel.org>; Mon, 23 Sep 2019 20:31:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57B6920673
	for <iommu@archiver.kernel.org>; Mon, 23 Sep 2019 20:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B6920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2721F13AA;
	Mon, 23 Sep 2019 20:31:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 67B5B13A6
	for <iommu@lists.linux-foundation.org>;
	Mon, 23 Sep 2019 20:31:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8D7E5102
	for <iommu@lists.linux-foundation.org>;
	Mon, 23 Sep 2019 20:31:03 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 Sep 2019 13:31:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,541,1559545200"; d="scan'208";a="363749806"
Received: from araj-mobl1.jf.intel.com ([10.24.10.67])
	by orsmga005.jf.intel.com with ESMTP; 23 Sep 2019 13:31:02 -0700
Date: Mon, 23 Sep 2019 13:31:02 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH 2/4] iommu/vt-d: Add first level page table interfaces
Message-ID: <20190923203102.GB21816@araj-mobl1.jf.intel.com>
References: <20190923122454.9888-1-baolu.lu@linux.intel.com>
	<20190923122454.9888-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190923122454.9888-3-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Cc: kevin.tian@intel.com, Yi Sun <yi.y.sun@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
	sanjay.k.kumar@intel.com, yi.y.sun@intel.com,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Mon, Sep 23, 2019 at 08:24:52PM +0800, Lu Baolu wrote:
> This adds functions to manipulate first level page tables
> which could be used by a scalale mode capable IOMMU unit.

s/scalale/scalable

> 
> intel_mmmap_range(domain, addr, end, phys_addr, prot)

Maybe think of a different name..? mmmap seems a bit weird :-)

>  - Map an iova range of [addr, end) to the physical memory
>    started at @phys_addr with the @prot permissions.
> 
> intel_mmunmap_range(domain, addr, end)
>  - Tear down the map of an iova range [addr, end). A page
>    list will be returned which will be freed after iotlb
>    flushing.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
