Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B48C433EF
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 11:27:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E70D2409FA;
	Tue, 15 Mar 2022 11:27:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wz0Jh5wuulYn; Tue, 15 Mar 2022 11:27:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 452E640260;
	Tue, 15 Mar 2022 11:27:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21B1DC0012;
	Tue, 15 Mar 2022 11:27:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF1F2C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 11:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 93BF360F9D
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 11:27:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Os8iLCdd-2R for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 11:27:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 52E7660F94
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 11:27:27 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id j17so28557710wrc.0
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 04:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Xsy+hdBDmUEEW9oGx4D4eHqInkltCSE2p0AuseWmMgg=;
 b=NN5nqsh5i2xYRMZXD4nVNF44ylsoZUN1zOSa8Vzd4saL/27OcGoHbKQSfiEqQbnx7+
 Eft7dWXkDfTrx7LuODBh7+p3+qJQDwsy5n5Jp8eoWvlZWGulbQqK27lYw4cgD2fxDdGK
 jlgVl5VVl0GV/w8Mw7cV7mLIU8CG4phu5pwPOm0orA8CQFVFWTDgZC8MoGspUSQ46AKx
 lkGZ/fpYCyerOUjUbrFm5lyOmIoRNE2Aqa5mU92mx3ZjtED1k8eFhJaIldK6mkV34T30
 afZlNazQE9o5zyTKePlKUNCHT73/Fm3P+amBqUwUPPUjeSkCHyCfbDz2fHFIqQEgW+/p
 NYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Xsy+hdBDmUEEW9oGx4D4eHqInkltCSE2p0AuseWmMgg=;
 b=N95Yyt8V4bm1smj4KlFeI4e4ANOpQtSngn8oBZuYTW2lLqDjrdI4YBEK6shTGCwijQ
 O79nIkLsyU6LvT31+NdOu2FZpEdBtECZs6PScHkp2zU+w4Ga1/F5t8xDu9ViCkLJM9yP
 8Qj0EuI9tFW+9ec9UC9+ffEe7WJLXlmG6Q5yCzW7FQZXWVJwdj1rhSLtAlA56FoCkUJr
 Lj3h5pH22SGcN+sCHRXVc7ecL2jR/lBxisAKMMrDDG/QdwDrAgVy3LBhfZm0/FMW48hc
 XOr+mNolN1TSS40KWpwtiv4F4cDVJzMeFe0Pecnfdxg8EMpRXCHTLPRNIhkt3AiMaMtG
 pHEw==
X-Gm-Message-State: AOAM531gu/xm8YbZeMxyQ48su2/cjpGTE+fwVtK7GUFVJL2ahy3/d/zp
 ZICnNPRxNLBD/WZ1D35EPIndNQ==
X-Google-Smtp-Source: ABdhPJxjD95iUAyVMeq2yyB+8Hz8TYrdwXdaaEoOsEgDVOLullCXgK01LaViQhsTRhCAEfA2ljtKjw==
X-Received: by 2002:adf:cd8f:0:b0:1ed:af02:2295 with SMTP id
 q15-20020adfcd8f000000b001edaf022295mr19238184wrj.226.1647343645473; 
 Tue, 15 Mar 2022 04:27:25 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 n8-20020a5d5988000000b00203d5f1f3e4sm1348294wri.105.2022.03.15.04.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Mar 2022 04:27:25 -0700 (PDT)
Date: Tue, 15 Mar 2022 11:26:59 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 2/8] iommu: Add attach/detach_dev_pasid domain ops
Message-ID: <YjB4AyrgsnbUrlLe@myrica>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-3-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220315050713.2000518-3-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Zanussi,
 Tom" <tom.zanussi@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, Jacob Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On Mon, Mar 14, 2022 at 10:07:06PM -0700, Jacob Pan wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> An IOMMU domain represents an address space which can be attached by
> devices that perform DMA within a domain. However, for platforms with
> PASID capability the domain attachment needs be handled at device+PASID
> level. There can be multiple PASIDs within a device and multiple devices
> attached to a given domain.
> This patch introduces a new IOMMU op which support device, PASID, and
> IOMMU domain attachment. The immediate use case is for PASID capable
> devices to perform DMA under DMA APIs.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  include/linux/iommu.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 369f05c2a4e2..fde5b933dbe3 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -227,6 +227,8 @@ struct iommu_iotlb_gather {
>   * @aux_get_pasid: get the pasid given an aux-domain
>   * @sva_bind: Bind process address space to device
>   * @sva_unbind: Unbind process address space from device
> + * @attach_dev_pasid: attach an iommu domain to a pasid of device
> + * @detach_dev_pasid: detach an iommu domain from a pasid of device

Isn't that operation "assign a PASID to a domain" instead?  In patch 5,
the domain is already attached to the device, so set_domain_pasid() might
be clearer and to the point. If the IOMMU driver did the allocation we
could also avoid patch 1.

If I understand correctly this series is not about a generic PASID API
that allows drivers to manage multiple DMA address spaces, because there
still doesn't seem to be any interest in that. It's about the specific
IDXD use-case, so let's focus on that. We can introduce a specialized call
such as (iommu|dma)_set_device_pasid(), which will be easy to consolidate
later into a more generic "dma_enable_pasid()" API if that ever seems
useful.

Thanks,
Jean

>   * @sva_get_pasid: Get PASID associated to a SVA handle
>   * @page_response: handle page request response
>   * @cache_invalidate: invalidate translation caches
> @@ -296,6 +298,10 @@ struct iommu_ops {
>  	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
>  				      void *drvdata);
>  	void (*sva_unbind)(struct iommu_sva *handle);
> +	int (*attach_dev_pasid)(struct iommu_domain *domain,
> +				struct device *dev, ioasid_t id);
> +	void (*detach_dev_pasid)(struct iommu_domain *domain,
> +				 struct device *dev, ioasid_t id);
>  	u32 (*sva_get_pasid)(struct iommu_sva *handle);
>  
>  	int (*page_response)(struct device *dev,
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
