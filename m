Return-Path: <SRS0=TrXs=EJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82327C2D0A3
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 12:00:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9FCC22403
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 12:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FCC22403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6C6B78739B;
	Tue,  3 Nov 2020 12:00:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mYDwTv-DxF+T; Tue,  3 Nov 2020 12:00:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CF6D787369;
	Tue,  3 Nov 2020 12:00:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BABEDC088B;
	Tue,  3 Nov 2020 12:00:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56681C0051
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 12:00:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4BC6887380
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 12:00:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N0i+FJDPvZ8O for <iommu@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 12:00:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 88E4F87369
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 12:00:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5DA4106F;
 Tue,  3 Nov 2020 04:00:40 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF3CC3F718;
 Tue,  3 Nov 2020 04:00:38 -0800 (PST)
Subject: Re: [PATCH v4 4/7] iommu: Add quirk for Intel graphic devices in
 map_sg
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Tom Murphy <murphyt7@tcd.ie>, David Woodhouse <dwmw2@infradead.org>,
 Christoph Hellwig <hch@infradead.org>
References: <20200927063437.13988-1-baolu.lu@linux.intel.com>
 <20200927063437.13988-5-baolu.lu@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <281f22ed-8b36-fc20-4b08-27ef168f941d@arm.com>
Date: Tue, 3 Nov 2020 12:00:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20200927063437.13988-5-baolu.lu@linux.intel.com>
Content-Language: en-GB
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Intel-gfx@lists.freedesktop.org, Ashok Raj <ashok.raj@intel.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On 2020-09-27 07:34, Lu Baolu wrote:
> Combining the sg segments exposes a bug in the Intel i915 driver which
> causes visual artifacts and the screen to freeze. This is most likely
> because of how the i915 handles the returned list. It probably doesn't
> respect the returned value specifying the number of elements in the list
> and instead depends on the previous behaviour of the Intel iommu driver
> which would return the same number of elements in the output list as in
> the input list.
> 
> Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/dma-iommu.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 3526db774611..e7e4d758f51a 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -879,6 +879,33 @@ static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
>   	unsigned int cur_len = 0, max_len = dma_get_max_seg_size(dev);
>   	int i, count = 0;
>   
> +	/*
> +	 * The Intel graphic driver is used to assume that the returned
> +	 * sg list is not combound. This blocks the efforts of converting
> +	 * Intel IOMMU driver to dma-iommu api's. Add this quirk to make the
> +	 * device driver work and should be removed once it's fixed in i915
> +	 * driver.
> +	 */
> +	if (IS_ENABLED(CONFIG_DRM_I915) && dev_is_pci(dev) &&
> +	    to_pci_dev(dev)->vendor == PCI_VENDOR_ID_INTEL &&
> +	    (to_pci_dev(dev)->class >> 16) == PCI_BASE_CLASS_DISPLAY) {
> +		for_each_sg(sg, s, nents, i) {
> +			unsigned int s_iova_off = sg_dma_address(s);
> +			unsigned int s_length = sg_dma_len(s);
> +			unsigned int s_iova_len = s->length;
> +
> +			s->offset += s_iova_off;
> +			s->length = s_length;
> +			sg_dma_address(s) = dma_addr + s_iova_off;
> +			sg_dma_len(s) = s_length;
> +			dma_addr += s_iova_len;
> +
> +			pr_info_once("sg combining disabled due to i915 driver\n");
> +		}
> +
> +		return nents;
> +	}

BTW, a much less invasive workaround would be to simply override 
seg_mask to 0. That's enough to make sure that no segment looks eligible 
for merging.

Robin.

> +
>   	for_each_sg(sg, s, nents, i) {
>   		/* Restore this segment's original unaligned fields first */
>   		unsigned int s_iova_off = sg_dma_address(s);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
