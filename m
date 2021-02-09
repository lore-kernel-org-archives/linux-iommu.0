Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB45BC433DB
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 12:03:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E97664EBA
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 12:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E97664EBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D6F718730B;
	Tue,  9 Feb 2021 12:03:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ESI9y7BDGEct; Tue,  9 Feb 2021 12:03:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8D9AA8725F;
	Tue,  9 Feb 2021 12:03:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8285EC1825;
	Tue,  9 Feb 2021 12:03:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E1C9C0891
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 12:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 737E88730B
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 12:03:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dPUp7oXrtZzX for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 12:03:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 982F28725F
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 12:03:17 +0000 (UTC)
IronPort-SDR: B3EtW+l7t8Nq7gn/6dfi2FasfMUTDBrKwRcmOx3WXA/X5sAEwS9l24u0lE2QtxzAVnn3KyvTBP
 lhrtdFZTd6BQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="200940027"
X-IronPort-AV: E=Sophos;i="5.81,164,1610438400"; d="scan'208";a="200940027"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2021 04:03:17 -0800
IronPort-SDR: 0ieoaeAKU7d3c11pykydksMQ7vj3nDDcGmtrF0t/KBBgWNh9lq8KKHEiw0mCbglS6xKJI2v75a
 mLYjV2Vco98Q==
X-IronPort-AV: E=Sophos;i="5.81,164,1610438400"; d="scan'208";a="396093725"
Received: from yisun1-ubuntu.bj.intel.com (HELO yi.y.sun) ([10.238.156.116])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA256;
 09 Feb 2021 04:03:10 -0800
Date: Tue, 9 Feb 2021 19:57:44 +0800
From: Yi Sun <yi.y.sun@linux.intel.com>
To: Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [RFC PATCH 10/11] vfio/iommu_type1: Optimize dirty bitmap
 population based on iommu HWDBM
Message-ID: <20210209115744.GB28580@yi.y.sun>
References: <20210128151742.18840-1-zhukeqian1@huawei.com>
 <20210128151742.18840-11-zhukeqian1@huawei.com>
 <20210207095630.GA28580@yi.y.sun>
 <407d28db-1f86-8d4f-ab15-3c3ac56bbe7f@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <407d28db-1f86-8d4f-ab15-3c3ac56bbe7f@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: Mark Rutland <mark.rutland@arm.com>, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, Marc Zyngier <maz@kernel.org>,
 jiangkunkun@huawei.com, wanghaibin.wang@huawei.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, James Morse <james.morse@arm.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On 21-02-07 18:40:36, Keqian Zhu wrote:
> Hi Yi,
> 
> On 2021/2/7 17:56, Yi Sun wrote:
> > Hi,
> > 
> > On 21-01-28 23:17:41, Keqian Zhu wrote:
> > 
> > [...]
> > 
> >> +static void vfio_dma_dirty_log_start(struct vfio_iommu *iommu,
> >> +				     struct vfio_dma *dma)
> >> +{
> >> +	struct vfio_domain *d;
> >> +
> >> +	list_for_each_entry(d, &iommu->domain_list, next) {
> >> +		/* Go through all domain anyway even if we fail */
> >> +		iommu_split_block(d->domain, dma->iova, dma->size);
> >> +	}
> >> +}
> > 
> > This should be a switch to prepare for dirty log start. Per Intel
> > Vtd spec, there is SLADE defined in Scalable-Mode PASID Table Entry.
> > It enables Accessed/Dirty Flags in second-level paging entries.
> > So, a generic iommu interface here is better. For Intel iommu, it
> > enables SLADE. For ARM, it splits block.
> Indeed, a generic interface name is better.
> 
> The vendor iommu driver plays vendor's specific actions to start dirty log, and Intel iommu and ARM smmu may differ. Besides, we may add more actions in ARM smmu driver in future.
> 
> One question: Though I am not familiar with Intel iommu, I think it also should split block mapping besides enable SLADE. Right?
> 
I am not familiar with ARM smmu. :) So I want to clarify if the block
in smmu is big page, e.g. 2M page? Intel Vtd manages the memory per
page, 4KB/2MB/1GB. There are two ways to manage dirty pages.
1. Keep default granularity. Just set SLADE to enable the dirty track.
2. Split big page to 4KB to get finer granularity.

But question about the second solution is if it can benefit the user
space, e.g. live migration. If my understanding about smmu block (i.e.
the big page) is correct, have you collected some performance data to
prove that the split can improve performance? Thanks!

> Thanks,
> Keqian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
