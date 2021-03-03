Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424A4C433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 20:19:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13A164EEC
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 20:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13A164EEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4B43840164;
	Wed,  3 Mar 2021 20:19:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1W1SXTBB8wFq; Wed,  3 Mar 2021 20:19:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id D15EE4016C;
	Wed,  3 Mar 2021 20:19:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB62DC000B;
	Wed,  3 Mar 2021 20:19:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10FE0C0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 20:19:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 59FE96F947
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 20:19:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ApaeFVy4uIOe for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 20:19:01 +0000 (UTC)
X-Greylist: delayed 02:24:50 by SQLgrey-1.8.0
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8BB7660594
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 20:19:01 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id dx17so17183981ejb.2
 for <iommu@lists.linux-foundation.org>; Wed, 03 Mar 2021 12:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Ay1TZ8JzvNC5idapDoUcQ5GKKqzTlTrbcqRrVJCb/Yw=;
 b=ogucOC602pOZaCllj1fYmqLgqNUWI/63+tGiLOic1car6wEizLd6dyE0DwOn17rtfD
 ChxTTUFSJed6ckJrgiZlwgavmDZFn52TLfycXF21lTs5QUJdtApImI1qmUR8uyxAWEzs
 s61T6AC0yXRCUNiPCspOfsNlvgyYrOpIopJFnalk41qx/VRGObptKQLTDLTxgCacH/YM
 xllsi8m5Xp8DrqvL/yMrmrKuVUXClLODQmhD70M+O1EDxt/oRY+yxFbHrd8fKjav54ZV
 pWMLDr+WaOHde6hJx3Ae7ntqZXyLhRPTL07imfKC3sD96prMMBjxin1uxinRRaGNHvlE
 ZLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ay1TZ8JzvNC5idapDoUcQ5GKKqzTlTrbcqRrVJCb/Yw=;
 b=A2EKpsmBHbNe16BF2rc37f2LqYkn26b6xXcajAY1FS1hXubQGB5WQd2QER3pH7tS6S
 qMEcgAB/+NN7qqqLD/3iZ7ip1uheSprVtTvGOI1+IyYMigq7/v3uwHg99Sx7vvBVx/FJ
 8OIwuRzgfL/ov4ZwHcqER1+mqt2RLCmKoWaLVG/jGWLbLfz70xLAKUj7vk5s+O0WJRhM
 IGl/Z73zXWHPJd1+Z8bX/7jNjoVob4qFlJLJ0mE+yVv9BgkOn4Zj/1PiRaaM3coczdSZ
 M+wLbPn7ijcCwvoeCnvf6tdjDG0r0EaZhtKQgpYcnlYVubQ2hhQd9lGc7q4xx3iY7f9t
 rEfw==
X-Gm-Message-State: AOAM533xefOC6Zyqb4KrR0D0kp8fOpfkHKfj7cAX/p5Kghj0ngSoiJpz
 drI3zc/fe6UytTxp5eWObj68b8FXR7NFbg==
X-Google-Smtp-Source: ABdhPJxn6VUua+CHqfiidNa4MID2EBUk3oGmo4nShGIjhhlC3uCxxeQHc4QFVLOAt5IApC64SJ7GYg==
X-Received: by 2002:adf:9bcf:: with SMTP id e15mr27492402wrc.276.1614792333891; 
 Wed, 03 Mar 2021 09:25:33 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id f9sm26704790wro.77.2021.03.03.09.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 09:25:33 -0800 (PST)
Date: Wed, 3 Mar 2021 18:25:12 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 13/15] iommu/virtio: Attach Arm PASID tables when
 available
Message-ID: <YD/GeIJA/ARevO7X@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-14-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210115121342.15093-14-vivek.gautam@arm.com>
Cc: kevin.tian@intel.com, alex.williamson@redhat.com, mst@redhat.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org,
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

On Fri, Jan 15, 2021 at 05:43:40PM +0530, Vivek Gautam wrote:
[...]
> +static int viommu_setup_pgtable(struct viommu_endpoint *vdev,
> +				struct viommu_domain *vdomain)
> +{
> +	int ret, id;
> +	u32 asid;
> +	enum io_pgtable_fmt fmt;
> +	struct io_pgtable_ops *ops = NULL;
> +	struct viommu_dev *viommu = vdev->viommu;
> +	struct virtio_iommu_probe_table_format *desc = vdev->pgtf;
> +	struct iommu_pasid_table *tbl = vdomain->pasid_tbl;
> +	struct iommu_vendor_psdtable_cfg *pst_cfg;
> +	struct arm_smmu_cfg_info *cfgi;
> +	struct io_pgtable_cfg cfg = {
> +		.iommu_dev	= viommu->dev->parent,
> +		.tlb		= &viommu_flush_ops,
> +		.pgsize_bitmap	= vdev->pgsize_mask ? vdev->pgsize_mask :
> +				  vdomain->domain.pgsize_bitmap,
> +		.ias		= (vdev->input_end ? ilog2(vdev->input_end) :
> +				   ilog2(vdomain->domain.geometry.aperture_end)) + 1,
> +		.oas		= vdev->output_bits,
> +	};
> +
> +	if (!desc)
> +		return -EINVAL;
> +
> +	if (!vdev->output_bits)
> +		return -ENODEV;
> +
> +	switch (le16_to_cpu(desc->format)) {
> +	case VIRTIO_IOMMU_FOMRAT_PGTF_ARM_LPAE:
> +		fmt = ARM_64_LPAE_S1;
> +		break;
> +	default:
> +		dev_err(vdev->dev, "unsupported page table format 0x%x\n",
> +			le16_to_cpu(desc->format));
> +		return -EINVAL;
> +	}
> +
> +	if (vdomain->mm.ops) {
> +		/*
> +		 * TODO: attach additional endpoint to the domain. Check that
> +		 * the config is sane.
> +		 */
> +		return -EEXIST;
> +	}
> +
> +	vdomain->mm.domain = vdomain;
> +	ops = alloc_io_pgtable_ops(fmt, &cfg, &vdomain->mm);
> +	if (!ops)
> +		return -ENOMEM;
> +
> +	pst_cfg = &tbl->cfg;
> +	cfgi = &pst_cfg->vendor.cfg;
> +	id = ida_simple_get(&asid_ida, 1, 1 << desc->asid_bits, GFP_KERNEL);
> +	if (id < 0) {
> +		ret = id;
> +		goto err_free_pgtable;
> +	}
> +
> +	asid = id;
> +	ret = iommu_psdtable_prepare(tbl, pst_cfg, &cfg, asid);
> +	if (ret)
> +		goto err_free_asid;
> +
> +	/*
> +	 * Strange to setup an op here?
> +	 * cd-lib is the actual user of sync op, and therefore the platform
> +	 * drivers should assign this sync/maintenance ops as per need.
> +	 */
> +	tbl->ops->sync = viommu_flush_pasid;

But this function deals with page tables, not pasid tables. As said on an
earlier patch, the TLB flush ops should probably be passed during table
registration - those ops are global so should really be const.

> +
> +	/* Right now only PASID 0 supported ?? */
> +	ret = iommu_psdtable_write(tbl, pst_cfg, 0, &cfgi->s1_cfg->cd);
> +	if (ret)
> +		goto err_free_asid;
> +
> +	vdomain->mm.ops = ops;
> +	dev_dbg(vdev->dev, "using page table format 0x%x\n", fmt);
> +
> +	return 0;
> +
> +err_free_asid:
> +	ida_simple_remove(&asid_ida, asid);
> +err_free_pgtable:
> +	free_io_pgtable_ops(ops);
> +	return ret;
> +}
> +
> +static int viommu_config_arm_pst(struct iommu_vendor_psdtable_cfg *pst_cfg,
> +				 struct virtio_iommu_req_attach_pst_arm *req)
> +{
> +	struct arm_smmu_s1_cfg *s1_cfg = pst_cfg->vendor.cfg.s1_cfg;
> +
> +	if (!s1_cfg)
> +		return -ENODEV;
> +
> +	req->format	= cpu_to_le16(VIRTIO_IOMMU_FORMAT_PSTF_ARM_SMMU_V3);
> +	req->s1fmt	= s1_cfg->s1fmt;
> +	req->s1dss	= VIRTIO_IOMMU_PSTF_ARM_SMMU_V3_DSS_0;
> +	req->s1contextptr = cpu_to_le64(pst_cfg->base);
> +	req->s1cdmax	= cpu_to_le32(s1_cfg->s1cdmax);
> +
> +	return 0;
> +}
> +
> +static int viommu_config_pst(struct iommu_vendor_psdtable_cfg *pst_cfg,
> +			     void *req, enum pasid_table_fmt fmt)
> +{
> +	int ret;
> +
> +	switch (fmt) {
> +	case PASID_TABLE_ARM_SMMU_V3:
> +		ret = viommu_config_arm_pst(pst_cfg, req);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		WARN_ON(1);
> +	}
> +
> +	return ret;
> +}
> +
> +static int viommu_prepare_arm_pst(struct viommu_endpoint *vdev,
> +				  struct iommu_vendor_psdtable_cfg *pst_cfg)
> +{
> +	struct virtio_iommu_probe_table_format *pgtf = vdev->pgtf;
> +	struct arm_smmu_cfg_info *cfgi = &pst_cfg->vendor.cfg;
> +	struct arm_smmu_s1_cfg *cfg;
> +
> +	/* Some sanity checks */
> +	if (pgtf->asid_bits != 8 && pgtf->asid_bits != 16)
> +		return -EINVAL;

No need for this, next patch cheks asid size in viommu_config_arm_pgt()

> +
> +	cfg = devm_kzalloc(pst_cfg->iommu_dev, sizeof(cfg), GFP_KERNEL);
> +	if (!cfg)
> +		return -ENOMEM;
> +
> +	cfgi->s1_cfg = cfg;
> +	cfg->s1cdmax = vdev->pasid_bits;
> +	cfg->cd.asid = pgtf->asid_bits;

That doesn't look right, cfg->cd.asid takes the ASID value of context 0
but here we're writing a limit. viommu_setup_pgtable() probably needs to
set this field to the allocated ASID, since viommu_teardown_pgtable() uses
it.

> +
> +	pst_cfg->fmt = PASID_TABLE_ARM_SMMU_V3;

Parent function can set this

> +	/* XXX HACK: set feature bit ARM_SMMU_FEAT_2_LVL_CDTAB */
> +	pst_cfg->vendor.cfg.feat_flag |= (1 << 1);

Oh right, this flag is missing. I'll add

  #define VIRTIO_IOMMU_PST_ARM_SMMU3_F_CD2L (1ULL << 1)

to the spec.

> +
> +	return 0;
> +}
> +
> +static int viommu_prepare_pst(struct viommu_endpoint *vdev,
> +			      struct iommu_vendor_psdtable_cfg *pst_cfg,
> +			      enum pasid_table_fmt fmt)
> +{
> +	int ret;
> +
> +	switch (fmt) {
> +	case PASID_TABLE_ARM_SMMU_V3:
> +		ret = viommu_prepare_arm_pst(vdev, pst_cfg);
> +		break;
> +	default:
> +		dev_err(vdev->dev, "unsupported PASID table format 0x%x\n", fmt);
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int viommu_attach_pasid_table(struct viommu_endpoint *vdev,
> +				     struct viommu_domain *vdomain)
> +{
> +	int ret;
> +	int i, eid;
> +	enum pasid_table_fmt fmt = -1;
> +	struct virtio_iommu_probe_table_format *desc = vdev->pstf;
> +	struct virtio_iommu_req_attach_table req = {
> +		.head.type	= VIRTIO_IOMMU_T_ATTACH_TABLE,
> +		.domain		= cpu_to_le32(vdomain->id),
> +	};
> +	struct viommu_dev *viommu = vdev->viommu;
> +	struct iommu_pasid_table *tbl;
> +	struct iommu_vendor_psdtable_cfg *pst_cfg;
> +
> +	if (!viommu->has_table)
> +		return 0;
> +
> +	if (!desc)
> +		return -ENODEV;
> +
> +	/* Prepare PASID tables configuration */
> +	switch (le16_to_cpu(desc->format)) {
> +	case VIRTIO_IOMMU_FORMAT_PSTF_ARM_SMMU_V3:
> +		fmt = PASID_TABLE_ARM_SMMU_V3;
> +		break;
> +	default:
> +		dev_err(vdev->dev, "unsupported PASID table format 0x%x\n",
> +			le16_to_cpu(desc->format));
> +		return 0;
> +	}
> +
> +	if (!tbl) {
> +		tbl = iommu_register_pasid_table(fmt, viommu->dev->parent, vdomain);
> +		if (!tbl)
> +			return -ENOMEM;
> +
> +		vdomain->pasid_tbl = tbl;
> +		pst_cfg = &tbl->cfg;
> +
> +		pst_cfg->iommu_dev = viommu->dev->parent;
> +
> +		/* Prepare PASID tables info to allocate a new table */
> +		ret = viommu_prepare_pst(vdev, pst_cfg, fmt);
> +		if (ret)
> +			return ret;
> +
> +		ret = iommu_psdtable_alloc(tbl, pst_cfg);
> +		if (ret)
> +			return ret;
> +
> +		pst_cfg->iommu_dev = viommu->dev->parent;

Already set by iommu_register_pasid_table() (and needed for DMA
allocations in iommu_psdtable_alloc())

> +		pst_cfg->fmt = PASID_TABLE_ARM_SMMU_V3;

Already set above

> +
> +		ret = viommu_setup_pgtable(vdev, vdomain);
> +		if (ret) {
> +			dev_err(vdev->dev, "could not install page tables\n");
> +			goto err_free_psdtable;
> +		}
> +
> +		/* Add arch-specific configuration */
> +		ret = viommu_config_pst(pst_cfg, (void *)&req, fmt);
> +		if (ret)
> +			goto err_free_ops;
> +
> +		vdev_for_each_id(i, eid, vdev) {
> +			req.endpoint = cpu_to_le32(eid);
> +			ret = viommu_send_req_sync(viommu, &req, sizeof(req));
> +			if (ret)
> +				goto err_free_ops;
> +		}
> +	} else {
> +		/* TODO: otherwise, check for compatibility with vdev. */
> +		return -ENOSYS;
> +	}
> +
> +	dev_dbg(vdev->dev, "uses PASID table format 0x%x\n", fmt);
> +
> +	return 0;
> +
> +err_free_ops:
> +	if (vdomain->mm.ops)
> +		viommu_teardown_pgtable(vdomain);
> +err_free_psdtable:
> +	iommu_psdtable_free(tbl, &tbl->cfg);
> +
> +	return ret;
> +}
> +
>  static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  {
>  	int ret = 0;
> @@ -928,6 +1213,17 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	if (vdev->vdomain)
>  		vdev->vdomain->nr_endpoints--;
>  
> +	ret = viommu_attach_pasid_table(vdev, vdomain);
> +	if (ret) {
> +		/*
> +		 * No PASID support, too bad. Perhaps we can bind a single set
> +		 * of page tables?
> +		 */
> +		ret = viommu_setup_pgtable(vdev, vdomain);

This cannot work at the moment because viommu_setup_pgtable() writes to
the non-existing pasid table. Probably best to leave this call for next
patch.

Thanks,
Jean

> +		if (ret)
> +			dev_err(vdev->dev, "could not install tables\n");
> +	}
> +
>  	if (!vdomain->mm.ops) {
>  		/* If we couldn't bind any table, use the mapping tree */
>  		ret = viommu_simple_attach(vdomain, vdev);
> @@ -948,6 +1244,10 @@ static int viommu_map(struct iommu_domain *domain, unsigned long iova,
>  	u32 flags;
>  	struct virtio_iommu_req_map map;
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +	struct io_pgtable_ops *ops = vdomain->mm.ops;
> +
> +	if (ops)
> +		return ops->map(ops, iova, paddr, size, prot, gfp);
>  
>  	flags = (prot & IOMMU_READ ? VIRTIO_IOMMU_MAP_F_READ : 0) |
>  		(prot & IOMMU_WRITE ? VIRTIO_IOMMU_MAP_F_WRITE : 0) |
> @@ -986,6 +1286,10 @@ static size_t viommu_unmap(struct iommu_domain *domain, unsigned long iova,
>  	size_t unmapped;
>  	struct virtio_iommu_req_unmap unmap;
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +	struct io_pgtable_ops *ops = vdomain->mm.ops;
> +
> +	if (ops)
> +		return ops->unmap(ops, iova, size, gather);
>  
>  	unmapped = viommu_del_mappings(vdomain, iova, size);
>  	if (unmapped < size)
> @@ -1014,6 +1318,10 @@ static phys_addr_t viommu_iova_to_phys(struct iommu_domain *domain,
>  	struct viommu_mapping *mapping;
>  	struct interval_tree_node *node;
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +	struct io_pgtable_ops *ops = vdomain->mm.ops;
> +
> +	if (ops)
> +		return ops->iova_to_phys(ops, iova);
>  
>  	spin_lock_irqsave(&vdomain->mappings_lock, flags);
>  	node = interval_tree_iter_first(&vdomain->mappings, iova, iova);
> @@ -1264,7 +1572,12 @@ static int viommu_probe(struct virtio_device *vdev)
>  				struct virtio_iommu_config, probe_size,
>  				&viommu->probe_size);
>  
> +	viommu->has_table = virtio_has_feature(vdev, VIRTIO_IOMMU_F_ATTACH_TABLE);
>  	viommu->has_map = virtio_has_feature(vdev, VIRTIO_IOMMU_F_MAP_UNMAP);
> +	if (!viommu->has_table && !viommu->has_map) {
> +		ret = -EINVAL;
> +		goto err_free_vqs;
> +	}
>  
>  	viommu->geometry = (struct iommu_domain_geometry) {
>  		.aperture_start	= input_start,
> @@ -1356,6 +1669,7 @@ static unsigned int features[] = {
>  	VIRTIO_IOMMU_F_DOMAIN_RANGE,
>  	VIRTIO_IOMMU_F_PROBE,
>  	VIRTIO_IOMMU_F_MMIO,
> +	VIRTIO_IOMMU_F_ATTACH_TABLE,
>  };
>  
>  static struct virtio_device_id id_table[] = {
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
