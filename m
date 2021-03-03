Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1E3C433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 18:26:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0964364EF1
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 18:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0964364EF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7A4B4B926;
	Wed,  3 Mar 2021 18:26:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l_QWPnDlq4mt; Wed,  3 Mar 2021 18:26:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3B7B54BEFB;
	Wed,  3 Mar 2021 18:26:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15EDAC000B;
	Wed,  3 Mar 2021 18:26:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80781C0001;
 Wed,  3 Mar 2021 18:26:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6BA704BEFB;
 Wed,  3 Mar 2021 18:26:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dP3RR499s_PM; Wed,  3 Mar 2021 18:26:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 279C14B926;
 Wed,  3 Mar 2021 18:26:38 +0000 (UTC)
IronPort-SDR: Z0oSwv7pPzAD0wztq35d4us7Sbz0vWVd938rvZ2JKJBOJjFVY9kbRgVCrM+u0aJ3uBgv2Fe1AP
 7n3sm1a3IT3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="186601469"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; d="scan'208";a="186601469"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 10:26:34 -0800
IronPort-SDR: flZ7ydHew/uLhmA0gDtrMwbn8pEMwFG07GAmfz4SHyILz2W2OCSJgnBR1uJ6kAa/Ww7OBC5TmT
 S3ny2ZIn3+Ww==
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; d="scan'208";a="428367968"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 10:26:33 -0800
Date: Wed, 3 Mar 2021 10:28:48 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Vivek Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 12/15] iommu/virtio: Add support for INVALIDATE
 request
Message-ID: <20210303102848.5d879f0e@jacob-builder>
In-Reply-To: <20210115121342.15093-13-vivek.gautam@arm.com>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-13-vivek.gautam@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, alex.williamson@redhat.com,
 mst@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

Hi Vivek,

On Fri, 15 Jan 2021 17:43:39 +0530, Vivek Gautam <vivek.gautam@arm.com>
wrote:

> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> Add support for tlb invalidation ops that can send invalidation
> requests to back-end virtio-iommu when stage-1 page tables are
> supported.
> 
Just curious if it possible to reuse the iommu uapi for invalidation and others.
When we started out designing the iommu uapi, the intention was to support
both emulated and virtio iommu.

> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> [Vivek: Refactoring the iommu_flush_ops, and adding only one pasid sync
>         op that's needed with current iommu-pasid-table infrastructure.
> 	Also updating uapi defines as required by latest changes]
> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/virtio-iommu.c | 95 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index ae5dfd3f8269..004ea94e3731 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -13,6 +13,7 @@
>  #include <linux/freezer.h>
>  #include <linux/interval_tree.h>
>  #include <linux/iommu.h>
> +#include <linux/io-pgtable.h>
>  #include <linux/module.h>
>  #include <linux/of_iommu.h>
>  #include <linux/of_platform.h>
> @@ -63,6 +64,8 @@ struct viommu_mapping {
>  };
>  
>  struct viommu_mm {
> +	int				pasid;
> +	u64				archid;
>  	struct io_pgtable_ops		*ops;
>  	struct viommu_domain		*domain;
>  };
> @@ -692,6 +695,98 @@ static void viommu_event_handler(struct virtqueue
> *vq) virtqueue_kick(vq);
>  }
>  
> +/* PASID and pgtable APIs */
> +
> +static void __viommu_flush_pasid_tlb_all(struct viommu_domain *vdomain,
> +					 int pasid, u64 arch_id, int
> type) +{
> +	struct virtio_iommu_req_invalidate req = {
> +		.head.type	= VIRTIO_IOMMU_T_INVALIDATE,
> +		.inv_gran	=
> cpu_to_le32(VIRTIO_IOMMU_INVAL_G_PASID),
> +		.flags		=
> cpu_to_le32(VIRTIO_IOMMU_INVAL_F_PASID),
> +		.inv_type	= cpu_to_le32(type),
> +
> +		.domain		= cpu_to_le32(vdomain->id),
> +		.pasid		= cpu_to_le32(pasid),
> +		.archid		= cpu_to_le64(arch_id),
> +	};
> +
> +	if (viommu_send_req_sync(vdomain->viommu, &req, sizeof(req)))
> +		pr_debug("could not send invalidate request\n");
> +}
> +
> +static void viommu_flush_tlb_add(struct iommu_iotlb_gather *gather,
> +				 unsigned long iova, size_t granule,
> +				 void *cookie)
> +{
> +	struct viommu_mm *viommu_mm = cookie;
> +	struct viommu_domain *vdomain = viommu_mm->domain;
> +	struct iommu_domain *domain = &vdomain->domain;
> +
> +	iommu_iotlb_gather_add_page(domain, gather, iova, granule);
> +}
> +
> +static void viommu_flush_tlb_walk(unsigned long iova, size_t size,
> +				  size_t granule, void *cookie)
> +{
> +	struct viommu_mm *viommu_mm = cookie;
> +	struct viommu_domain *vdomain = viommu_mm->domain;
> +	struct virtio_iommu_req_invalidate req = {
> +		.head.type	= VIRTIO_IOMMU_T_INVALIDATE,
> +		.inv_gran	= cpu_to_le32(VIRTIO_IOMMU_INVAL_G_VA),
> +		.inv_type	= cpu_to_le32(VIRTIO_IOMMU_INV_T_IOTLB),
> +		.flags		=
> cpu_to_le32(VIRTIO_IOMMU_INVAL_F_ARCHID), +
> +		.domain		= cpu_to_le32(vdomain->id),
> +		.pasid		= cpu_to_le32(viommu_mm->pasid),
> +		.archid		= cpu_to_le64(viommu_mm->archid),
> +		.virt_start	= cpu_to_le64(iova),
> +		.nr_pages	= cpu_to_le64(size / granule),
> +		.granule	= ilog2(granule),
> +	};
> +
> +	if (viommu_add_req(vdomain->viommu, &req, sizeof(req)))
> +		pr_debug("could not add invalidate request\n");
> +}
> +
> +static void viommu_flush_tlb_all(void *cookie)
> +{
> +	struct viommu_mm *viommu_mm = cookie;
> +
> +	if (!viommu_mm->archid)
> +		return;
> +
> +	__viommu_flush_pasid_tlb_all(viommu_mm->domain, viommu_mm->pasid,
> +				     viommu_mm->archid,
> +				     VIRTIO_IOMMU_INV_T_IOTLB);
> +}
> +
> +static struct iommu_flush_ops viommu_flush_ops = {
> +	.tlb_flush_all		= viommu_flush_tlb_all,
> +	.tlb_flush_walk		= viommu_flush_tlb_walk,
> +	.tlb_add_page		= viommu_flush_tlb_add,
> +};
> +
> +static void viommu_flush_pasid(void *cookie, int pasid, bool leaf)
> +{
> +	struct viommu_domain *vdomain = cookie;
> +	struct virtio_iommu_req_invalidate req = {
> +		.head.type	= VIRTIO_IOMMU_T_INVALIDATE,
> +		.inv_gran	=
> cpu_to_le32(VIRTIO_IOMMU_INVAL_G_PASID),
> +		.inv_type	= cpu_to_le32(VIRTIO_IOMMU_INV_T_PASID),
> +		.flags		=
> cpu_to_le32(VIRTIO_IOMMU_INVAL_F_PASID), +
> +		.domain		= cpu_to_le32(vdomain->id),
> +		.pasid		= cpu_to_le32(pasid),
> +	};
> +
> +	if (leaf)
> +		req.flags	|=
> cpu_to_le32(VIRTIO_IOMMU_INVAL_F_LEAF); +
> +	if (viommu_send_req_sync(vdomain->viommu, &req, sizeof(req)))
> +		pr_debug("could not send invalidate request\n");
> +}
> +
>  /* IOMMU API */
>  
>  static struct iommu_domain *viommu_domain_alloc(unsigned type)


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
