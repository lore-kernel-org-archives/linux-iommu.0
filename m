Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12F1C433E0
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 18:01:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D1664E17
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 18:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D1664E17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A48A286A90;
	Thu, 28 Jan 2021 18:01:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LOf6y4aQVrkf; Thu, 28 Jan 2021 18:01:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0D9598654D;
	Thu, 28 Jan 2021 18:01:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2D43C08A1;
	Thu, 28 Jan 2021 18:01:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D7FAC013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 18:01:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 63F0886E97
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 18:01:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RwkpLuHawkxr for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 18:01:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id BBC628654D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 18:01:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8E9313A1;
 Thu, 28 Jan 2021 10:01:02 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B34273F719;
 Thu, 28 Jan 2021 10:00:59 -0800 (PST)
Subject: Re: [PATCH 3/3] Adding device_dma_parameters->offset_preserve_mask to
 NVMe driver.
To: Jianxiong Gao <jxgao@google.com>, erdemaktas@google.com,
 marcorr@google.com, hch@lst.de, m.szyprowski@samsung.com,
 gregkh@linuxfoundation.org, saravanak@google.com,
 heikki.krogerus@linux.intel.com, rafael.j.wysocki@intel.com,
 andriy.shevchenko@linux.intel.com, dan.j.williams@intel.com,
 bgolaszewski@baylibre.com, jroedel@suse.de,
 iommu@lists.linux-foundation.org, konrad.wilk@oracle.com, kbusch@kernel.org,
 axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20210128003829.1892018-1-jxgao@google.com>
 <20210128003829.1892018-4-jxgao@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <0550ca25-1389-ffc2-e738-8127ceb1712f@arm.com>
Date: Thu, 28 Jan 2021 18:00:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210128003829.1892018-4-jxgao@google.com>
Content-Language: en-GB
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

On 2021-01-28 00:38, Jianxiong Gao wrote:
> NVMe driver relies on the address offset to function properly.
> This patch adds the offset preserve mask to NVMe driver when mapping
> via dma_map_sg_attrs and unmapping via nvme_unmap_sg. The mask
> depends on the page size defined by CC.MPS register of NVMe
> controller.
> 
> Signed-off-by: Jianxiong Gao <jxgao@google.com>
> ---
>   drivers/nvme/host/pci.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 856aa31931c1..0b23f04068be 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -580,12 +580,15 @@ static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
>   static void nvme_unmap_sg(struct nvme_dev *dev, struct request *req)
>   {
>   	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> -
> +	if (dma_set_page_offset_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1))
> +		dev_warn(dev->dev, "dma_set_page_offset_mask failed to set offset\n");
>   	if (is_pci_p2pdma_page(sg_page(iod->sg)))
>   		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
>   				    rq_dma_dir(req));
>   	else
>   		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
> +	if (dma_set_page_offset_mask(dev->dev, 0))
> +		dev_warn(dev->dev, "dma_set_page_offset_mask failed to reset offset\n");
>   }
>   
>   static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
> @@ -842,7 +845,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>   {
>   	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>   	blk_status_t ret = BLK_STS_RESOURCE;
> -	int nr_mapped;
> +	int nr_mapped, offset_ret;
>   
>   	if (blk_rq_nr_phys_segments(req) == 1) {
>   		struct bio_vec bv = req_bvec(req);
> @@ -868,12 +871,24 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>   	if (!iod->nents)
>   		goto out_free_sg;
>   
> +	offset_ret = dma_set_page_offset_mask(dev->dev, NVME_CTRL_PAGE_SIZE - 1);
> +	if (offset_ret) {
> +		dev_warn(dev->dev, "dma_set_page_offset_mask failed to set offset\n");
> +		goto out_free_sg;
> +	}
> +
>   	if (is_pci_p2pdma_page(sg_page(iod->sg)))
>   		nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
>   				iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
>   	else
>   		nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
>   					     rq_dma_dir(req), DMA_ATTR_NO_WARN);
> +
> +	offset_ret = dma_set_page_offset_mask(dev->dev, 0);
> +	if (offset_ret) {
> +		dev_warn(dev->dev, "dma_set_page_offset_mask failed to reset offset\n");
> +		goto out_free_sg;

If it were possible for this to fail, you might leak the DMA mapping 
here. However if dev->dma_parms somehow disappeared since a dozen lines 
above then I think you've got far bigger problems anyway.

That said, do you really need to keep toggling this back and forth all 
the time? Even if the device does make other mappings elsewhere that 
don't necessarily need the same strict alignment, would it be 
significantly harmful just to set it once at probe and leave it in place 
anyway?

Robin.

> +	}
>   	if (!nr_mapped)
>   		goto out_free_sg;
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
