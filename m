Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEACC433E0
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 12:08:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0E864E6F
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 12:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0E864E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9134A6F185
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 12:08:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K4soVi9dcgKD for <iommu@archiver.kernel.org>;
	Tue,  9 Feb 2021 12:08:10 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 8C3796F484; Tue,  9 Feb 2021 12:08:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82D326EEFD;
	Tue,  9 Feb 2021 12:08:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 579E9C0174;
	Tue,  9 Feb 2021 12:08:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94C43C013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 12:08:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7CB70872E0
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 12:08:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Df6vsKT4G5f for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 12:08:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BD76C86BA5
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 12:08:05 +0000 (UTC)
IronPort-SDR: z347gOit52ZyGhlKsowbhuKWyH7EB/758LtlP+q1gDGll7DgXuE3e5SfS2XN2YyJUo6ga+jRav
 hU5/buDhBA8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="266703259"
X-IronPort-AV: E=Sophos;i="5.81,164,1610438400"; d="scan'208";a="266703259"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2021 04:08:05 -0800
IronPort-SDR: EkElaaO7PCIBA7u/r7+YS4trpQvRbTAKGLXQ9dXFuJaQMYuagqKw+/nG+EKN+fuOkgJwNMxnEj
 bFzIa3t3AiOA==
X-IronPort-AV: E=Sophos;i="5.81,164,1610438400"; d="scan'208";a="396095446"
Received: from yisun1-ubuntu.bj.intel.com (HELO yi.y.sun) ([10.238.156.116])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA256;
 09 Feb 2021 04:07:59 -0800
Date: Tue, 9 Feb 2021 20:02:31 +0800
From: Yi Sun <yi.y.sun@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [RFC PATCH 10/11] vfio/iommu_type1: Optimize dirty bitmap
 population based on iommu HWDBM
Message-ID: <20210209120231.GC28580@yi.y.sun>
References: <20210128151742.18840-1-zhukeqian1@huawei.com>
 <20210128151742.18840-11-zhukeqian1@huawei.com>
 <20210207095630.GA28580@yi.y.sun>
 <8150bd3a-dbb9-2e2b-386b-04e66f4b68dc@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8150bd3a-dbb9-2e2b-386b-04e66f4b68dc@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: Mark Rutland <mark.rutland@arm.com>, kevin.tian@intel.com,
 Cornelia Huck <cohuck@redhat.com>, yan.y.zhao@intel.com, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, jiangkunkun@huawei.com,
 Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, lushenming@huawei.com,
 Kirti Wankhede <kwankhede@nvidia.com>, James Morse <james.morse@arm.com>,
 Marc Zyngier <maz@kernel.org>, wanghaibin.wang@huawei.com,
 kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
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

On 21-02-09 11:16:08, Robin Murphy wrote:
> On 2021-02-07 09:56, Yi Sun wrote:
> >Hi,
> >
> >On 21-01-28 23:17:41, Keqian Zhu wrote:
> >
> >[...]
> >
> >>+static void vfio_dma_dirty_log_start(struct vfio_iommu *iommu,
> >>+				     struct vfio_dma *dma)
> >>+{
> >>+	struct vfio_domain *d;
> >>+
> >>+	list_for_each_entry(d, &iommu->domain_list, next) {
> >>+		/* Go through all domain anyway even if we fail */
> >>+		iommu_split_block(d->domain, dma->iova, dma->size);
> >>+	}
> >>+}
> >
> >This should be a switch to prepare for dirty log start. Per Intel
> >Vtd spec, there is SLADE defined in Scalable-Mode PASID Table Entry.
> >It enables Accessed/Dirty Flags in second-level paging entries.
> >So, a generic iommu interface here is better. For Intel iommu, it
> >enables SLADE. For ARM, it splits block.
> 
> From a quick look, VT-D's SLADE and SMMU's HTTU appear to be the
> exact same thing. This step isn't about enabling or disabling that
> feature itself (the proposal for SMMU is to simply leave HTTU
> enabled all the time), it's about controlling the granularity at
> which the dirty status can be detected/reported at all, since that's
> tied to the pagetable structure.
> 
> However, if an IOMMU were to come along with some other way of
> reporting dirty status that didn't depend on the granularity of
> individual mappings, then indeed it wouldn't need this operation.
> 
Per my thought, we can use these two start/stop interfaces to make
user space decide when to start/stop the dirty tracking. For Intel
SLADE, I think we can enable this bit when this start interface is
called by user space. I don't think leave SLADE enabled all the time
is necessary for Intel Vt-d. So I suggest a generic interface here.
Thanks!

> Robin.
> 
> >>+
> >>+static void vfio_dma_dirty_log_stop(struct vfio_iommu *iommu,
> >>+				    struct vfio_dma *dma)
> >>+{
> >>+	struct vfio_domain *d;
> >>+
> >>+	list_for_each_entry(d, &iommu->domain_list, next) {
> >>+		/* Go through all domain anyway even if we fail */
> >>+		iommu_merge_page(d->domain, dma->iova, dma->size,
> >>+				 d->prot | dma->prot);
> >>+	}
> >>+}
> >
> >Same as above comment, a generic interface is required here.
> >
> >>+
> >>+static void vfio_iommu_dirty_log_switch(struct vfio_iommu *iommu, bool start)
> >>+{
> >>+	struct rb_node *n;
> >>+
> >>+	/* Split and merge even if all iommu don't support HWDBM now */
> >>+	for (n = rb_first(&iommu->dma_list); n; n = rb_next(n)) {
> >>+		struct vfio_dma *dma = rb_entry(n, struct vfio_dma, node);
> >>+
> >>+		if (!dma->iommu_mapped)
> >>+			continue;
> >>+
> >>+		/* Go through all dma range anyway even if we fail */
> >>+		if (start)
> >>+			vfio_dma_dirty_log_start(iommu, dma);
> >>+		else
> >>+			vfio_dma_dirty_log_stop(iommu, dma);
> >>+	}
> >>+}
> >>+
> >>  static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
> >>  					unsigned long arg)
> >>  {
> >>@@ -2812,8 +2900,10 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
> >>  		pgsize = 1 << __ffs(iommu->pgsize_bitmap);
> >>  		if (!iommu->dirty_page_tracking) {
> >>  			ret = vfio_dma_bitmap_alloc_all(iommu, pgsize);
> >>-			if (!ret)
> >>+			if (!ret) {
> >>  				iommu->dirty_page_tracking = true;
> >>+				vfio_iommu_dirty_log_switch(iommu, true);
> >>+			}
> >>  		}
> >>  		mutex_unlock(&iommu->lock);
> >>  		return ret;
> >>@@ -2822,6 +2912,7 @@ static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
> >>  		if (iommu->dirty_page_tracking) {
> >>  			iommu->dirty_page_tracking = false;
> >>  			vfio_dma_bitmap_free_all(iommu);
> >>+			vfio_iommu_dirty_log_switch(iommu, false);
> >>  		}
> >>  		mutex_unlock(&iommu->lock);
> >>  		return 0;
> >>-- 
> >>2.19.1
> >_______________________________________________
> >iommu mailing list
> >iommu@lists.linux-foundation.org
> >https://lists.linuxfoundation.org/mailman/listinfo/iommu
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
