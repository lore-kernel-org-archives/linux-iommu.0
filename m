Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB020C433EF
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 14:24:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6439382C75;
	Tue, 25 Jan 2022 14:24:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ydGZ9siX1KOl; Tue, 25 Jan 2022 14:24:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 40CC282C3E;
	Tue, 25 Jan 2022 14:24:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B85AC0031;
	Tue, 25 Jan 2022 14:24:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE6A4C002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 14:24:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8829B82C3E
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 14:24:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nlh4Meb8RQbA for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 14:24:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8675082C21
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 14:24:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63F22D6E;
 Tue, 25 Jan 2022 06:23:59 -0800 (PST)
Received: from [10.57.68.26] (unknown [10.57.68.26])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CBEB3F793;
 Tue, 25 Jan 2022 06:23:56 -0800 (PST)
Message-ID: <ab09f75c-08cc-1845-9aa7-81fed779d636@arm.com>
Date: Tue, 25 Jan 2022 14:23:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
Content-Language: en-GB
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Ben Skeggs <bskeggs@redhat.com>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
 <99023cd7-f037-282f-3f25-629a14a1578b@arm.com>
 <82c5db53-088f-a51f-6fbc-c977ef871d8f@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <82c5db53-088f-a51f-6fbc-c977ef871d8f@linux.intel.com>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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

On 2022-01-25 06:27, Lu Baolu wrote:
> On 1/25/22 8:57 AM, Robin Murphy wrote:
>> On 2022-01-24 07:11, Lu Baolu wrote:
>>> Add a domain specific callback set, domain_ops, for vendor iommu driver
>>> to provide domain specific operations. Move domain-specific callbacks
>>> from iommu_ops to the domain_ops and hook them when a domain is 
>>> allocated.
>>
>> I think it would make a lot of sense for iommu_domain_ops to be a 
>> substructure *within* iommu_ops. That way we can save most of the 
>> driver boilerplate here by not needing extra variables everywhere, and 
>> letting iommu_domain_alloc() still do a default initialisation like 
>> "domain->ops = bus->iommu_ops->domain_ops;"
> 
> In the new model, iommu_domain_ops and iommu_ops are not 1:1 mapped.
> For example, a PASID-capable IOMMU could support DMA domain (which
> supports map/unmap), SVA domain (which does not), and others in the
> future. Different type of domain has its own domain_ops.

Sure, it's clear that that's the direction in which this is headed, and 
as I say I'm quite excited about that. However there are a couple of 
points I think are really worth considering:

Where it's just about which operations are valid for which domains, it's 
even simpler for the core interface wrappers to validate the domain 
type, rather than forcing drivers to implement multiple ops structures 
purely for the sake of having different callbacks populated. We already 
have this in places, e.g. where iommu_map() checks for 
__IOMMU_DOMAIN_PAGING.

Paging domains are also effectively the baseline level of IOMMU API 
functionality. All drivers support them, and for the majority of drivers 
it's all they will ever support. Those drivers really don't benefit from 
any of the churn and boilerplate in this patch as-is, and it's so easy 
to compromise with a couple of lines of core code to handle the common 
case by default when the driver *isn't* one of the handful which ever 
actually cares to install their own per-domain ops. Consider how much 
cleaner this patch would look if the typical driver diff could be 
something completely minimal like this:

----->8-----
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index be22fcf988ce..6aff493e37ee 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -514,12 +514,14 @@ static int mtk_iommu_hw_init(const struct 
mtk_iommu_data *data)

  static const struct iommu_ops mtk_iommu_ops = {
  	.domain_alloc	= mtk_iommu_domain_alloc,
-	.domain_free	= mtk_iommu_domain_free,
-	.attach_dev	= mtk_iommu_attach_device,
-	.detach_dev	= mtk_iommu_detach_device,
-	.map		= mtk_iommu_map,
-	.unmap		= mtk_iommu_unmap,
-	.iova_to_phys	= mtk_iommu_iova_to_phys,
+	.domain_ops = &(const struct iommu_domain_ops){
+		.domain_free	= mtk_iommu_domain_free,
+		.attach_dev	= mtk_iommu_attach_device,
+		.detach_dev	= mtk_iommu_detach_device,
+		.map		= mtk_iommu_map,
+		.unmap		= mtk_iommu_unmap,
+		.iova_to_phys	= mtk_iommu_iova_to_phys,
+	}
  	.probe_device	= mtk_iommu_probe_device,
  	.probe_finalize = mtk_iommu_probe_finalize,
  	.release_device	= mtk_iommu_release_device,

-----8<-----

And of course I have to shy away from calling it default_domain_ops, 
since although it's logically default ops for domains, it is not 
specifically ops for default domains, sigh... :)

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
