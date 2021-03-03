Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EADC433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 19:01:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29AB1601FB
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 19:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29AB1601FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBD5C4AE77;
	Wed,  3 Mar 2021 19:01:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ky-c85MNRbk7; Wed,  3 Mar 2021 19:01:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1953E4ADED;
	Wed,  3 Mar 2021 19:01:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF59BC000B;
	Wed,  3 Mar 2021 19:01:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C229C0001
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 19:01:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 104F34AE76
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 19:01:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 65KvrJjpA4KC for <iommu@lists.linux-foundation.org>;
 Wed,  3 Mar 2021 19:01:33 +0000 (UTC)
X-Greylist: delayed 01:42:49 by SQLgrey-1.8.0
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6C9854ADED
 for <iommu@lists.linux-foundation.org>; Wed,  3 Mar 2021 19:01:33 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id k66so7339975wmf.1
 for <iommu@lists.linux-foundation.org>; Wed, 03 Mar 2021 11:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=6SXDPW7Ja1F1ZDUtT3b1kT4xu9LP1HVvj8vwXrpadEE=;
 b=lyUyI0g9Zj/FgoYlRVDMQE99MdUq7AFFW9qlq/OeCWjHW4WT1G0gQTSvzdsz1MMKUM
 8JzFnP+jH/he/dc1ISMzHA7ZIipiFJSuMNJIjG9Y4MUt2ijCXcF5TiNZi7HaL6EfAWBt
 yTjPs2ryh1U1UDjou1XEFlsyJRWvfieUZhO0SkPOY4WfKg4Jp6lvJ5LEJzCNUmWknraN
 VRSngARsafF/ayj9xm0vjrvzBZpI3BErdZ+l4B1JBURaDEpPbpVHkAphD+D9BAycA/i1
 D9j+VJybxTslsKQJRMRxIQuRNXKYFjJ4s6yDl5U9xeql47mqIdJlOocvDqogEcH9uDP/
 xQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6SXDPW7Ja1F1ZDUtT3b1kT4xu9LP1HVvj8vwXrpadEE=;
 b=eOF+tgu0aPjNyQPg2U0wmPybfKMninLxBItpSG08R7q3Pm/qVnNyb8wa7Ki27gp+QF
 ni5rsE9qOPBEOVbPL34GKTbozBM3I08n6GrHuNplszDTG/jNO1YBLcWeVJrf8FKtqtZM
 /92+g3F8sCvBKVSyxv86dFxz52HggUJNA12rmgqTa8TcREowHGS+I3JFXmv7tgYZ8/oV
 aPMi6LcUAfTXejsnM+nxnidIEkvzsqoodeu3/vQs2TAc+i3IhvrmS/fjNMdFCWXIpnuS
 rUFjyoB1PEBwTZZHzcYbyWaIgMPmCzxC02Gp4Bu2F+OUsp9JvHX+CrdJwhn+xRBazBYL
 rwmw==
X-Gm-Message-State: AOAM532Fg3BrXYgYA8s5VbhvNMKBSTel3ReWnC1Tfyz8Yolgc/tNkCvK
 vMDEt33x415GKSVMQUinumIKe07auT9I4Q==
X-Google-Smtp-Source: ABdhPJxitgbClhWHxPB/Q8czpTna+HwUgtDapft1ST8WuHw0OzA3X/LBjFtvYzMSzsV07jswzlvEYw==
X-Received: by 2002:a1c:c904:: with SMTP id f4mr72966wmb.14.1614791529643;
 Wed, 03 Mar 2021 09:12:09 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id m11sm20217474wrz.40.2021.03.03.09.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Mar 2021 09:12:09 -0800 (PST)
Date: Wed, 3 Mar 2021 18:11:47 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Vivek Gautam <vivek.gautam@arm.com>
Subject: Re: [PATCH RFC v1 02/15] iommu: Add a simple PASID table library
Message-ID: <YD/DU8XNYHlTzTay@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-3-vivek.gautam@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210115121342.15093-3-vivek.gautam@arm.com>
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

Hi Vivek,

Thanks again for working on this. I have a few comments but it looks
sensible overall.

Regarding the overall design, I was initially assigning page directories
instead of whole PASID tables, which would simplify the driver and host
implementation. A major complication, however, is SMMUv3 accesses PASID
tables using a guest-physical address, so there is a messy negotiation
needed between host and guest when the host needs to allocate PASID
tables. Plus vSMMU needs PASID table assignment, so that's what the host
driver will implement.

On Fri, Jan 15, 2021 at 05:43:29PM +0530, Vivek Gautam wrote:
> Add a small API in iommu subsystem to handle PASID table allocation
> requests from different consumer drivers, such as a paravirtualized
> iommu driver. The API provides ops for allocating and freeing PASID
> table, writing to it and managing the table caches.
> 
> This library also provides for registering a vendor API that attaches
> to these ops. The vendor APIs would eventually perform arch level
> implementations for these PASID tables.

Although Arm might be the only vendor to ever use this, I think the
abstraction makes sense and isn't too invasive. Even if we called directly
into the SMMU driver from the virtio one, we'd still need patch 3 and
separate TLB invalidations ops.

> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will.deacon@arm.com>
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
>  drivers/iommu/iommu-pasid-table.h | 134 ++++++++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 drivers/iommu/iommu-pasid-table.h
> 
> diff --git a/drivers/iommu/iommu-pasid-table.h b/drivers/iommu/iommu-pasid-table.h
> new file mode 100644
> index 000000000000..bd4f57656f67
> --- /dev/null
> +++ b/drivers/iommu/iommu-pasid-table.h
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PASID table management for the IOMMU
> + *
> + * Copyright (C) 2021 Arm Ltd.
> + */
> +#ifndef __IOMMU_PASID_TABLE_H
> +#define __IOMMU_PASID_TABLE_H
> +
> +#include <linux/io-pgtable.h>
> +
> +#include "arm/arm-smmu-v3/arm-smmu-v3.h"
> +
> +enum pasid_table_fmt {
> +	PASID_TABLE_ARM_SMMU_V3,
> +	PASID_TABLE_NUM_FMTS,
> +};
> +
> +/**
> + * struct arm_smmu_cfg_info - arm-smmu-v3 specific configuration data
> + *
> + * @s1_cfg: arm-smmu-v3 stage1 config data
> + * @feat_flag: features supported by arm-smmu-v3 implementation
> + */
> +struct arm_smmu_cfg_info {
> +	struct arm_smmu_s1_cfg	*s1_cfg;
> +	u32			feat_flag;
> +};
> +
> +/**
> + * struct iommu_vendor_psdtable_cfg - Configuration data for PASID tables
> + *
> + * @iommu_dev: device performing the DMA table walks
> + * @fmt: The PASID table format
> + * @base: DMA address of the allocated table, set by the vendor driver
> + * @cfg: arm-smmu-v3 specific config data
> + */
> +struct iommu_vendor_psdtable_cfg {
> +	struct device		*iommu_dev;
> +	enum pasid_table_fmt	fmt;
> +	dma_addr_t		base;
> +	union {
> +		struct arm_smmu_cfg_info	cfg;

For the union to be extensible, that field should be called "arm" or
something like that.

Thanks,
Jean

> +	} vendor;
> +};
> +
> +struct iommu_vendor_psdtable_ops;
> +
> +/**
> + * struct iommu_pasid_table - describes a set of PASID tables
> + *
> + * @cookie: An opaque token provided by the IOMMU driver and passed back to any
> + * callback routine.
> + * @cfg: A copy of the PASID table configuration
> + * @ops: The PASID table operations in use for this set of page tables
> + */
> +struct iommu_pasid_table {
> +	void					*cookie;
> +	struct iommu_vendor_psdtable_cfg	cfg;
> +	struct iommu_vendor_psdtable_ops	*ops;
> +};
> +
> +#define pasid_table_cfg_to_table(pst_cfg) \
> +	container_of((pst_cfg), struct iommu_pasid_table, cfg)
> +
> +struct iommu_vendor_psdtable_ops {
> +	int (*alloc)(struct iommu_vendor_psdtable_cfg *cfg);
> +	void (*free)(struct iommu_vendor_psdtable_cfg *cfg);
> +	void (*prepare)(struct iommu_vendor_psdtable_cfg *cfg,
> +			struct io_pgtable_cfg *pgtbl_cfg, u32 asid);
> +	int (*write)(struct iommu_vendor_psdtable_cfg *cfg, int ssid,
> +		     void *cookie);
> +	void (*sync)(void *cookie, int ssid, bool leaf);
> +};
> +
> +static inline int iommu_psdtable_alloc(struct iommu_pasid_table *tbl,
> +				       struct iommu_vendor_psdtable_cfg *cfg)
> +{
> +	if (!tbl->ops->alloc)
> +		return -ENOSYS;
> +
> +	return tbl->ops->alloc(cfg);
> +}
> +
> +static inline void iommu_psdtable_free(struct iommu_pasid_table *tbl,
> +				       struct iommu_vendor_psdtable_cfg *cfg)
> +{
> +	if (!tbl->ops->free)
> +		return;
> +
> +	tbl->ops->free(cfg);
> +}
> +
> +static inline int iommu_psdtable_prepare(struct iommu_pasid_table *tbl,
> +					 struct iommu_vendor_psdtable_cfg *cfg,
> +					 struct io_pgtable_cfg *pgtbl_cfg,
> +					 u32 asid)
> +{
> +	if (!tbl->ops->prepare)
> +		return -ENOSYS;
> +
> +	tbl->ops->prepare(cfg, pgtbl_cfg, asid);
> +	return 0;
> +}
> +
> +static inline int iommu_psdtable_write(struct iommu_pasid_table *tbl,
> +				       struct iommu_vendor_psdtable_cfg *cfg,
> +				       int ssid, void *cookie)
> +{
> +	if (!tbl->ops->write)
> +		return -ENOSYS;
> +
> +	return tbl->ops->write(cfg, ssid, cookie);
> +}
> +
> +static inline int iommu_psdtable_sync(struct iommu_pasid_table *tbl,
> +				      void *cookie, int ssid, bool leaf)
> +{
> +	if (!tbl->ops->sync)
> +		return -ENOSYS;
> +
> +	tbl->ops->sync(cookie, ssid, leaf);
> +	return 0;
> +}
> +
> +/* A placeholder to register vendor specific pasid layer */
> +static inline struct iommu_pasid_table *
> +iommu_register_pasid_table(enum pasid_table_fmt fmt,
> +			   struct device *dev, void *cookie)
> +{
> +	return NULL;
> +}
> +
> +#endif /* __IOMMU_PASID_TABLE_H */
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
