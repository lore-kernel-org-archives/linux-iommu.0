Return-Path: <SRS0=Ybkk=5L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2F6C43331
	for <iommu@archiver.kernel.org>; Thu, 26 Mar 2020 12:13:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B942073E
	for <iommu@archiver.kernel.org>; Thu, 26 Mar 2020 12:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B942073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A49E5890D5;
	Thu, 26 Mar 2020 12:13:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dhRCEqv-gZkC; Thu, 26 Mar 2020 12:13:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 37C1389165;
	Thu, 26 Mar 2020 12:13:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31675C1D7F;
	Thu, 26 Mar 2020 12:13:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66A1BC0177;
 Thu, 26 Mar 2020 12:13:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 41A4326150;
 Thu, 26 Mar 2020 12:13:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d6rHEBvvyoXB; Thu, 26 Mar 2020 12:13:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 41582227FF;
 Thu, 26 Mar 2020 12:13:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABA0C30E;
 Thu, 26 Mar 2020 05:13:23 -0700 (PDT)
Received: from [10.57.61.73] (unknown [10.57.61.73])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7A5A3F71F;
 Thu, 26 Mar 2020 05:13:22 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] iommu/virtio: Reject IOMMU page granule larger
 than PAGE_SIZE
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org
References: <20200326093558.2641019-1-jean-philippe@linaro.org>
 <20200326093558.2641019-4-jean-philippe@linaro.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <66e665bc-bc33-8bda-331d-270b43cbe36d@arm.com>
Date: Thu, 26 Mar 2020 12:13:21 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326093558.2641019-4-jean-philippe@linaro.org>
Content-Language: en-GB
Cc: bbhushan2@marvell.com, virtualization@lists.linux-foundation.org,
 jasowang@redhat.com, mst@redhat.com
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

On 2020-03-26 9:35 am, Jean-Philippe Brucker wrote:
> We don't currently support IOMMUs with a page granule larger than the
> system page size. The IOVA allocator has a BUG_ON() in this case, and
> VFIO has a WARN_ON().
> 
> Removing these obstacles ranges doesn't seem possible without major
> changes to the DMA API and VFIO. Some callers of iommu_map(), for
> example, want to map multiple page-aligned regions adjacent to each
> others for scatter-gather purposes. Even in simple DMA API uses, a call
> to dma_map_page() would let the endpoint access neighbouring memory. And
> VFIO users cannot ensure that their virtual address buffer is physically
> contiguous at the IOMMU granule.
> 
> Rather than triggering the IOVA BUG_ON() on mismatched page sizes, abort
> the vdomain finalise() with an error message. We could simply abort the
> viommu probe(), but an upcoming extension to virtio-iommu will allow
> setting different page masks for each endpoint.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Reported-by: Bharat Bhushan <bbhushan2@marvell.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v1->v2: Move to vdomain_finalise(), improve commit message
> ---
>   drivers/iommu/virtio-iommu.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 5eed75cd121f..750f69c49b95 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -607,12 +607,22 @@ static struct iommu_domain *viommu_domain_alloc(unsigned type)
>   	return &vdomain->domain;
>   }
>   
> -static int viommu_domain_finalise(struct viommu_dev *viommu,
> +static int viommu_domain_finalise(struct viommu_endpoint *vdev,
>   				  struct iommu_domain *domain)
>   {
>   	int ret;
> +	unsigned long viommu_page_size;
> +	struct viommu_dev *viommu = vdev->viommu;
>   	struct viommu_domain *vdomain = to_viommu_domain(domain);
>   
> +	viommu_page_size = 1UL << __ffs(viommu->pgsize_bitmap);
> +	if (viommu_page_size > PAGE_SIZE) {
> +		dev_err(vdev->dev,
> +			"granule 0x%lx larger than system page size 0x%lx\n",
> +			viommu_page_size, PAGE_SIZE);
> +		return -EINVAL;
> +	}
> +
>   	ret = ida_alloc_range(&viommu->domain_ids, viommu->first_domain,
>   			      viommu->last_domain, GFP_KERNEL);
>   	if (ret < 0)
> @@ -659,7 +669,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   		 * Properly initialize the domain now that we know which viommu
>   		 * owns it.
>   		 */
> -		ret = viommu_domain_finalise(vdev->viommu, domain);
> +		ret = viommu_domain_finalise(vdev, domain);
>   	} else if (vdomain->viommu != vdev->viommu) {
>   		dev_err(dev, "cannot attach to foreign vIOMMU\n");
>   		ret = -EXDEV;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
