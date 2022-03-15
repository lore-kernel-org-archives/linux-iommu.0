Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA24C433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 11:38:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64EEC60F94;
	Tue, 15 Mar 2022 11:38:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 33lUPzDrhxv4; Tue, 15 Mar 2022 11:38:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 078AA60F9E;
	Tue, 15 Mar 2022 11:38:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDBA3C0012;
	Tue, 15 Mar 2022 11:38:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDD7DC000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 11:38:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B7D09408CD
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 11:38:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZCUYaNadShpq for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 11:37:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28F4F40260
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 11:37:58 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id b19so6166747wrh.11
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 04:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ahx7UKZv0OoL24Ag2nb4+cGfcAOKb10fU0eUtMYyFm0=;
 b=oNyYmghoO8s47essImFCeMVvf9Lwty1wLVtvs+FnbiU/CrfsQNMzuXtgpP5GDS1vVJ
 k5Q/OmwV/Ww6UvQ/bt0Zh+K8ayrXy288SL1GvFmZg+5otu5v0ZlKXW90l+4o4/DthgC6
 t+G8flZRiUhSSNKNvyVOLHFCb2kh8QQ7K9Q6iHRzNb7CS1FgKN0aasGCA0d+zfH0Xj++
 LHcVs/vZwSdCE4QPKmV7EE3afy3qeGu0btjUhuWfriqEMfgRSgTr3uzl65XTKveWH3oY
 Mhjb0CewGkyoZEV9Sx5HDO9/c+tpHd04Yx3hxv8oj8J9aTQuUjXuxzHSnenpPxmo6Nj7
 a+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ahx7UKZv0OoL24Ag2nb4+cGfcAOKb10fU0eUtMYyFm0=;
 b=leSDdnYoGaqBL7kDEGXMU9FLLa4UF5IreH1oN31vGxhw3hh+BOwedHmvMc3lKb5iEk
 wqeArSs9nBnzveWhoPaQx2U3aj0qX/XCw0cqEYtQ4f0/5sVaIUfN1bSq6KNX7RCDL+m2
 cTA8Z0tKhwUlvUEStu5dLLs/yKXpD1VXp5AaxMMUEhkqbeaf4yHcp/qToy8brnW+PvFm
 OtzEfobIGt8pKUwD+Z5VS0mUevKODTkARkDY7psclkImuinsYDvIZs8OTsUsokc1sUIn
 8Cbsae2SBT8BEvus+n/3OZfuSNeXKactLKZ5caHOa/FJj1up8KLxI6P8ebqSlPwObIRz
 oGqg==
X-Gm-Message-State: AOAM530410xqlh0lMyl6XsHkYRx8Knag9oIGvHwWfqs3uiCa+ibqkBVH
 4nk6QLbDOqEuFcguPV1mjzPhZw==
X-Google-Smtp-Source: ABdhPJzVyTk9rbag8GQe4T4tKekK4pTCAy2iYJXtULFol/QinSOn1Gmbq4I1+NoJCpN/wq6kurGSWw==
X-Received: by 2002:a5d:5342:0:b0:1ef:7f26:df46 with SMTP id
 t2-20020a5d5342000000b001ef7f26df46mr19373979wrv.600.1647344277114; 
 Tue, 15 Mar 2022 04:37:57 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 n15-20020a05600c4f8f00b003842f011bc5sm2263815wmq.2.2022.03.15.04.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Mar 2022 04:37:56 -0700 (PDT)
Date: Tue, 15 Mar 2022 11:37:30 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 8/8] iommu: Remove unused driver data in sva_bind_device
Message-ID: <YjB6ettzNkHZ7EnW@myrica>
References: <20220315050713.2000518-1-jacob.jun.pan@linux.intel.com>
 <20220315050713.2000518-9-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220315050713.2000518-9-jacob.jun.pan@linux.intel.com>
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

On Mon, Mar 14, 2022 at 10:07:12PM -0700, Jacob Pan wrote:
> No one is using drvdata for sva_bind_device after kernel SVA support is
> removed from VT-d driver. Remove the drvdata parameter as well.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/dma/idxd/cdev.c                         | 2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 5 ++---
>  drivers/iommu/intel/svm.c                       | 9 ++++-----
>  drivers/iommu/iommu.c                           | 4 ++--
>  drivers/misc/uacce/uacce.c                      | 2 +-
>  include/linux/intel-iommu.h                     | 3 +--
>  include/linux/iommu.h                           | 9 +++------
>  8 files changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index b9b2b4a4124e..312ec37ebf91 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -100,7 +100,7 @@ static int idxd_cdev_open(struct inode *inode, struct file *filp)
>  	filp->private_data = ctx;
>  
>  	if (device_pasid_enabled(idxd)) {
> -		sva = iommu_sva_bind_device(dev, current->mm, NULL);
> +		sva = iommu_sva_bind_device(dev, current->mm);
>  		if (IS_ERR(sva)) {
>  			rc = PTR_ERR(sva);
>  			dev_err(dev, "pasid allocation failed: %d\n", rc);
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index a737ba5f727e..eb2f5cb0701a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -354,7 +354,7 @@ __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
>  }
>  
>  struct iommu_sva *
> -arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
> +arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
>  {
>  	struct iommu_sva *handle;
>  	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index cd48590ada30..d2ba86470c42 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -754,8 +754,7 @@ bool arm_smmu_master_sva_enabled(struct arm_smmu_master *master);
>  int arm_smmu_master_enable_sva(struct arm_smmu_master *master);
>  int arm_smmu_master_disable_sva(struct arm_smmu_master *master);
>  bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master);
> -struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
> -				    void *drvdata);
> +struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm);
>  void arm_smmu_sva_unbind(struct iommu_sva *handle);
>  u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
>  void arm_smmu_sva_notifier_synchronize(void);
> @@ -791,7 +790,7 @@ static inline bool arm_smmu_master_iopf_supported(struct arm_smmu_master *master
>  }
>  
>  static inline struct iommu_sva *
> -arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
> +arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm)
>  {
>  	return ERR_PTR(-ENODEV);
>  }
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 37d6218f173b..94deb58375f5 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -500,8 +500,7 @@ int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
>  	return ret;
>  }
>  
> -static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm,
> -				 unsigned int flags)
> +static int intel_svm_alloc_pasid(struct device *dev, struct mm_struct *mm)
>  {
>  	ioasid_t max_pasid = dev_is_pci(dev) ?
>  			pci_max_pasids(to_pci_dev(dev)) : intel_pasid_max_id;
> @@ -1002,20 +1001,20 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  	return IRQ_RETVAL(handled);
>  }
>  
> -struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
> +struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm)
>  {
>  	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
>  	struct iommu_sva *sva;
>  	int ret;
>  
>  	mutex_lock(&pasid_mutex);
> -	ret = intel_svm_alloc_pasid(dev, mm, flags);
> +	ret = intel_svm_alloc_pasid(dev, mm);
>  	if (ret) {
>  		mutex_unlock(&pasid_mutex);
>  		return ERR_PTR(ret);
>  	}
>  
> -	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
> +	sva = intel_svm_bind_mm(iommu, dev, mm);
>  	if (IS_ERR_OR_NULL(sva))
>  		intel_svm_free_pasid(mm);
>  	mutex_unlock(&pasid_mutex);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 107dcf5938d6..fef34879bc0c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3049,7 +3049,7 @@ EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
>   * On error, returns an ERR_PTR value.
>   */
>  struct iommu_sva *
> -iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
>  {
>  	struct iommu_group *group;
>  	struct iommu_sva *handle = ERR_PTR(-EINVAL);
> @@ -3074,7 +3074,7 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
>  	if (iommu_group_device_count(group) != 1)
>  		goto out_unlock;
>  
> -	handle = ops->sva_bind(dev, mm, drvdata);
> +	handle = ops->sva_bind(dev, mm);
>  
>  out_unlock:
>  	mutex_unlock(&group->mutex);
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index 281c54003edc..3238a867ea51 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -99,7 +99,7 @@ static int uacce_bind_queue(struct uacce_device *uacce, struct uacce_queue *q)
>  	if (!(uacce->flags & UACCE_DEV_SVA))
>  		return 0;
>  
> -	handle = iommu_sva_bind_device(uacce->parent, current->mm, NULL);
> +	handle = iommu_sva_bind_device(uacce->parent, current->mm);
>  	if (IS_ERR(handle))
>  		return PTR_ERR(handle);
>  
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 3f4c98f170ec..9dc855d7479d 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -777,8 +777,7 @@ extern int intel_svm_finish_prq(struct intel_iommu *iommu);
>  int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>  			  struct iommu_gpasid_bind_data *data);
>  int intel_svm_unbind_gpasid(struct device *dev, u32 pasid);
> -struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm,
> -				 void *drvdata);
> +struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm);
>  void intel_svm_unbind(struct iommu_sva *handle);
>  u32 intel_svm_get_pasid(struct iommu_sva *handle);
>  int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index fb011722e4f8..b570b37181ad 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -294,9 +294,7 @@ struct iommu_ops {
>  	int (*aux_attach_dev)(struct iommu_domain *domain, struct device *dev);
>  	void (*aux_detach_dev)(struct iommu_domain *domain, struct device *dev);
>  	int (*aux_get_pasid)(struct iommu_domain *domain, struct device *dev);
> -
> -	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm,
> -				      void *drvdata);
> +	struct iommu_sva *(*sva_bind)(struct device *dev, struct mm_struct *mm);
>  	void (*sva_unbind)(struct iommu_sva *handle);
>  	int (*attach_dev_pasid)(struct iommu_domain *domain,
>  				struct device *dev, ioasid_t id);
> @@ -705,8 +703,7 @@ void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev);
>  int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev);
>  
>  struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> -					struct mm_struct *mm,
> -					void *drvdata);
> +					struct mm_struct *mm);
>  void iommu_sva_unbind_device(struct iommu_sva *handle);
>  u32 iommu_sva_get_pasid(struct iommu_sva *handle);
>  
> @@ -1065,7 +1062,7 @@ iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
>  }
>  
>  static inline struct iommu_sva *
> -iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
>  {
>  	return NULL;
>  }
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
