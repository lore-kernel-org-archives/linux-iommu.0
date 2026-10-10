Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09939380FCC
	for <iommu@lists.linux.dev>; Sat, 10 Oct 2026 02:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791598168; cv=none; b=c+C9OSWO68Ta1NRc3Y5QNyRJdXtpoOejwbH/JZihTjnkreG8eY6iE7gZfTnLSdKymSgkQVHSeux+XsP3LiXM1viyoLDtd+tXmXOhEvq7OYV7xvIJR2LkdIoTpLfNnd24wuntJQouxtDJA7g9NN8tmV7iZBibWdd/ypVWXbyesjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791598168; c=relaxed/simple;
	bh=d0EDoYHxfrUlr02R+Iw2ZmY9MamAcQ0Y6aKU5ptZvBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7OO87a2dFsxD8YW1kVEEgfHzeYi9uIoEIv9J5Bej5m8jR1mTLzQOyoyEK2kIxSd+M7GCtSOL7k2CWowF5PnzHLHLoFnVMedFQ7/yjgOeU5VZhYU+BJ8RIssw2IAKbrE2GNOrroerRsTpb+s3tGI0SPEfXBMNIAJA0Y1CneupSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aLe4E0hE; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aLe4E0hE"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2db33db4de9so9965ad.0
        for <iommu@lists.linux.dev>; Fri, 09 Oct 2026 19:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791598166; x=1792202966; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZckNohU8rxASyti8f1rup11rFGJuPHV9Cw9uToI+h6I=;
        b=aLe4E0hEVYRpadv+sWwQ+TIlVN3o99yA+0ssUSyCjd+MDtREJN2ocmNRbUcZEFxKs4
         xfQqDZ6r9EeSnulrpGDymz6Ho/FMQefgXmGYWXIpklAEo+ocZVwlX/VbtoEVvqbpKjBB
         V9K4s8UN4wHhbbZ8KY97Quy/ewqsBverN0Ju5P6p3or18hztcjc3jDxg+xmLwQjeUDfv
         GGQE7kPDjTixOHmpit03sTsRd91C7I97aLUTwXgbZPm14dHObAYkfpwlUYZMbVb4TknI
         4Q6PchRn2XxaFrmZZPG7XT9ziDorA/5eORtWFoMM/YhmzBt6mm/dxcBn4U4+8jIZA+HG
         x9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791598166; x=1792202966;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZckNohU8rxASyti8f1rup11rFGJuPHV9Cw9uToI+h6I=;
        b=h1fEo8Px/spCADlb7bFiOC511T+S98lbAjKKfYWAMKlF3CT5f1x8MjXCup82B3UxTP
         HpZpE8ywnvOf0eUcBk2riGt1KZMP0LZFBGnN7/C3/ZBtrhpvT90KpAR2O2mEkYA8+EjQ
         kcpiX69JFBXrzOVEAyUmusHZGI1f0UxH43SH/2R7PLRG6bdHsEcOtOdt+VYQcZoCtWik
         JznH5fSfU6yq3fJ0fOkiibVNOzaiEKXbxGZjrzjWcd/IEADKccwpoIP+6ke5I/dTd+0i
         F4Bqupud10DxbHCh6C689glXvyJJAIXCOSyNNDi5iSWeVsOZatwsJJHjj0nY218ly4CD
         cr2Q==
X-Forwarded-Encrypted: i=1; AKwUvBx4L4V0wiePFQPcebuV/VcEAJx9VS+PDw/UGagUta5Zo4l1zrwdR31iV296qv6dYAcPVlme1g==@lists.linux.dev
X-Gm-Message-State: AFq9FYJBBzJmUSUQcYmVDq0IPNtfWS36j5YSK4HWhC25AOggPusWyQw3
	NrdZ4D3tTBKjCg4WRYbF//J03tkk9R3SYqwndrQGEB07x7z8sIsA3gUszWXl1QYArw==
X-Gm-Gg: AYBFou1fHqKnvSMuIUZPGMK9wRHzobyYAwcJAx8MtGZGWTqebQmeEtuzbyE2QT9zlK/
	dXROCMlxGouYRjpEAO/cULUT+g6FYFRV4VlSwp51wzNfWYoAaiJVAQ1HiYzbcaMykLGMVSXz2XL
	Ek32rAum+Vw7SAwsrhUXEG6IahMPShMGE7aJblP/mggNooziCKyaAhKb7uh3coPouQS/8F3h7/2
	6u819+XBZDq+iJgMzX/wqBgbTvilSprAdbDusvo+C/uzfSE7FJB8ytsMQ+7m4OMaIJuhPdHFvKs
	ScLoFd7PJHefjR0UtBP1MayHCCe4phWvtDAL0A0ft06SKwECCGvJau1XSn+04kzjqM3qXoGVXxB
	I41k54wN5SNXojUtc1Qdnm4f4wVoYI6BjK9H3vpS9c+LQG9xuLU6BLxIw4HFdXLojW21dSnMtpX
	yil3X3drB9vZN30kKxCd8KyXCAAyMWcWCeWVRV5zxEm5MUmkKiG7VZsfJZqPlBGThUygoFIDA8b
	oXbHefbz7KyNVWHmFdMHk/04dvrml4SRueDFdDHjX9cEQquisCAah1tJXrBpawjwZg=
X-Received: by 2002:a17:903:324c:b0:2e7:e742:8bb5 with SMTP id d9443c01a7336-2e87e2d3f9fmr549055ad.14.1791598165462;
        Fri, 09 Oct 2026 19:09:25 -0700 (PDT)
Received: from google.com (163.1.145.34.bc.googleusercontent.com. [34.145.1.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422c99b6sm17931255ad.65.2026.10.09.19.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 19:09:24 -0700 (PDT)
Date: Sat, 10 Oct 2026 02:09:21 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v5 12/18] iommu/vt-d: Handle reattach of the restored
 domain
Message-ID: <asmb0qNsVLfUkIRo@google.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-13-skhawaja@google.com>
 <5be26af3-9d0c-40ce-bf58-9e98ef4a8670@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5be26af3-9d0c-40ce-bf58-9e98ef4a8670@linux.intel.com>

On Fri, Oct 09, 2026 at 10:24:28AM +0800, Baolu Lu wrote:
>On 9/21/26 08:48, Samiullah Khawaja wrote:
>>Reattach the restored domain to the preserved device using restored
>>domain ID. While reattaching do not setup the context and PASID entries
>>as those are preserved during liveupdate.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      |  32 +++++--
>>  drivers/iommu/intel/iommu.h      |  14 +++
>>  drivers/iommu/intel/liveupdate.c | 159 +++++++++++++++++++++++++++++++
>>  3 files changed, 197 insertions(+), 8 deletions(-)
>>
>>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>index c5044e834337..6d3cbe0745c9 100644
>>--- a/drivers/iommu/intel/iommu.c
>>+++ b/drivers/iommu/intel/iommu.c
>>@@ -2819,6 +2819,9 @@ static int blocking_domain_attach_dev(struct iommu_domain *domain,
>>  {
>>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>+	if (dev_iommu_restored_state(dev))
>>+		return -EBUSY;
>>+
>>  	iopf_for_domain_remove(info->domain ? &info->domain->domain : NULL, dev);
>>  	device_block_translation(dev);
>>  	return 0;
>>@@ -3187,6 +3190,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>>  {
>>  	int ret;
>>+	if (dev_iommu_restored_state(dev))
>>+		return intel_iommu_restore_device(domain, dev);
>>+
>>  	device_block_translation(dev);
>>  	ret = paging_domain_compatible(domain, dev);
>>@@ -3317,7 +3323,8 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>>  	info->iommu = iommu;
>>  	RB_CLEAR_NODE(&info->node);
>>  	if (dev_is_pci(dev)) {
>>-		if (ecap_dev_iotlb_support(iommu->ecap) &&
>>+		if (!dev_iommu_restored_state(dev) &&
>>+		    ecap_dev_iotlb_support(iommu->ecap) &&
>>  		    pci_ats_supported(pdev) &&
>>  		    dmar_ats_supported(pdev, iommu)) {
>>  			info->ats_supported = 1;
>>@@ -3421,12 +3428,16 @@ static void intel_iommu_release_device(struct device *dev)
>>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>  	struct intel_iommu *iommu = info->iommu;
>>-	iommu_disable_pci_pri(info);
>>-	iommu_disable_pci_ats(info);
>>+	if (!dev_iommu_restored_state(dev)) {
>>+		iommu_disable_pci_pri(info);
>>+		iommu_disable_pci_ats(info);
>>-	if (info->pasid_enabled) {
>>-		pci_disable_pasid(to_pci_dev(dev));
>>-		info->pasid_enabled = 0;
>>+		if (info->pasid_enabled) {
>>+			pci_disable_pasid(to_pci_dev(dev));
>>+			info->pasid_enabled = 0;
>>+		}
>>+	} else {
>>+		intel_iommu_detach_restored_device(dev);
>>  	}
>>  	mutex_lock(&iommu->iopf_lock);
>>@@ -3434,11 +3445,13 @@ static void intel_iommu_release_device(struct device *dev)
>>  		device_rbtree_remove(info);
>>  	mutex_unlock(&iommu->iopf_lock);
>>-	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev) &&
>>+	if (!dev_iommu_restored_state(dev) && sm_supported(iommu) &&
>>+	    !dev_is_real_dma_subdevice(dev) &&
>>  	    !context_copied(iommu, info->bus, info->devfn))
>>  		intel_pasid_teardown_sm_context(dev);
>>-	intel_pasid_free_table(dev);
>>+	if (!dev_iommu_restored_state(dev))
>>+		intel_pasid_free_table(dev);
>>  	intel_iommu_debugfs_remove_dev(info);
>>  	kfree(info);
>>  }
>>@@ -3900,6 +3913,9 @@ static int identity_domain_attach_dev(struct iommu_domain *domain,
>>  	struct intel_iommu *iommu = info->iommu;
>>  	int ret;
>>+	if (dev_iommu_restored_state(dev))
>>+		return -EBUSY;
>>+
>>  	device_block_translation(dev);
>>  	if (dev_is_real_dma_subdevice(dev))
>>diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>>index 3a2cb08c0ac1..25104644317c 100644
>>--- a/drivers/iommu/intel/iommu.h
>>+++ b/drivers/iommu/intel/iommu.h
>>@@ -1310,6 +1310,9 @@ void intel_iommu_unpreserve(struct iommu_device *iommu,
>>  void clear_unpreserved_context_entries(struct intel_iommu *iommu);
>>  void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>>  					       struct iommu_hw_ser *iommu_ser);
>>+int intel_iommu_restore_device(struct iommu_domain *domain,
>>+			       struct device *dev);
>>+int intel_iommu_detach_restored_device(struct device *dev);
>>  #else
>>  static inline void clear_unpreserved_context_entries(struct intel_iommu *iommu)
>>  {
>>@@ -1319,6 +1322,17 @@ static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu
>>  							     struct iommu_hw_ser *iommu_ser)
>>  {
>>  }
>>+
>>+static inline int intel_iommu_restore_device(struct iommu_domain *domain,
>>+					     struct device *dev)
>>+{
>>+	return -EOPNOTSUPP;
>>+}
>>+
>>+static inline int intel_iommu_detach_restored_device(struct device *dev)
>>+{
>>+	return -EOPNOTSUPP;
>>+}
>>  #endif
>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>>diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
>>index c9e553379683..6e6707eefc8c 100644
>>--- a/drivers/iommu/intel/liveupdate.c
>>+++ b/drivers/iommu/intel/liveupdate.c
>>@@ -351,6 +351,165 @@ void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>>  	BUG_ON(iommu_for_each_preserved_device(_restore_used_domain_ids, iommu));
>>  }
>>+static void domain_detach_reattached_iommu(struct dmar_domain *domain,
>>+					   struct intel_iommu *iommu)
>
>The naming is ambiguous. How about
>
>	domain_detach_restored_iommu()
>	domain_attach_restored_iommu()
>
>?

This looks good to me. Will update.
>
>>+{
>>+	struct iommu_domain_info *info;
>>+
>>+	guard(mutex)(&iommu->did_lock);
>>+	info = xa_load(&domain->iommu_array, iommu->seq_id);
>>+	if (--info->refcnt == 0) {
>>+		xa_erase(&domain->iommu_array, iommu->seq_id);
>>+		kfree(info);
>>+	}
>>+}
>>+
>>+static int domain_reattach_iommu(struct dmar_domain *domain,
>>+				 struct intel_iommu *iommu,
>>+				 struct iommu_device_ser *device_ser)
>>+{
>>+	struct iommu_domain_info *info, *curr;
>>+	struct iommu_domain_ser *domain_ser;
>>+	struct iommu_hw_ser *iommu_hw_ser;
>>+	int restored_did;
>>+	int ret;
>>+
>>+	if (!iommu_domain_restored_state(&domain->domain))
>>+		return -EINVAL;
>>+
>>+	if (!device_ser->domain_iommu_ser.domain_phys ||
>>+	    !device_ser->domain_iommu_ser.iommu_phys)
>>+		return -EINVAL;
>>+
>>+	domain_ser = phys_to_virt(device_ser->domain_iommu_ser.domain_phys);
>>+	if (domain_ser->restored_domain != &domain->domain)
>>+		return -EINVAL;
>>+
>>+	iommu_hw_ser = phys_to_virt(device_ser->domain_iommu_ser.iommu_phys);
>>+	if (iommu_hw_ser->type != IOMMU_INTEL ||
>>+	    iommu_hw_ser->intel.phys_addr != iommu->reg_phys)
>>+		return -EINVAL;
>>+
>>+	restored_did = device_ser->domain_iommu_ser.attachment_id;
>>+	if (!ida_exists(&iommu->domain_ida, restored_did))
>>+		return -EINVAL;
>>+
>>+	info = kzalloc_obj(*info);
>>+	if (!info)
>>+		return -ENOMEM;
>>+
>>+	guard(mutex)(&iommu->did_lock);
>>+	curr = xa_load(&domain->iommu_array, iommu->seq_id);
>>+	if (curr) {
>>+		curr->refcnt++;
>>+		kfree(info);
>>+		return 0;
>>+	}
>>+
>>+	info->refcnt	= 1;
>>+	info->did	= restored_did;
>>+	info->iommu	= iommu;
>>+	curr = xa_cmpxchg(&domain->iommu_array, iommu->seq_id,
>>+			  NULL, info, GFP_KERNEL);
>>+	if (curr) {
>>+		ret = xa_err(curr) ? : -EBUSY;
>>+		goto err_unlock;
>>+	}
>>+
>>+	return 0;
>>+
>>+err_unlock:
>>+	kfree(info);
>>+	return ret;
>>+}
>>+
>>+/**
>>+ * intel_iommu_restore_device() - Restore device domain attachment after live update
>>+ * @domain: Restored domain
>>+ * @dev: Restored device
>>+ *
>>+ * Return: 0 on success, or negative error code.
>>+ */
>>+int intel_iommu_restore_device(struct iommu_domain *domain,
>>+			       struct device *dev)
>
>How about renaming it intel_iommu_attach_restored_device() to pair with
>the detach helper?

Agreed. Will update.
>
>>+{
>>+	struct iommu_device_ser *device_ser = dev_iommu_restored_state(dev);
>>+	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>>+	struct intel_iommu *iommu = info->iommu;
>>+	unsigned long flags;
>>+	int ret;
>>+
>>+	if (!device_ser)
>>+		return -EINVAL;
>>+
>>+	if (dev_is_real_dma_subdevice(dev))
>>+		return -EOPNOTSUPP;
>
>The vmd subdevices rely on the host endpoint to restore the domain
>attachment, so instead of returning an error, it could return 0,
>indicating nothing to do?

This should never happen, as subdevices are not preserved, so this
function is never called for them. It is basically dead code, so I will
drop it.
>
>>+
>>+	ret = domain_reattach_iommu(dmar_domain, iommu, device_ser);
>>+	if (ret)
>>+		return ret;
>>+
>>+	info->domain = dmar_domain;
>>+	info->domain_attached = true;
>>+	spin_lock_irqsave(&dmar_domain->lock, flags);
>>+	list_add(&info->link, &dmar_domain->devices);
>>+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
>>+
>>+	ret = cache_tag_assign_domain(dmar_domain, dev, IOMMU_NO_PASID);
>>+	if (ret)
>>+		goto err;
>
>The restored domain is an immutable domain. It could only be freed; no
>map and unmap should happen on it. So why do you need to assign a cache
>tag for it?

Interesting.. this is a valid point. I will remove this.
>
>>+
>>+	ret = iopf_for_domain_set(domain, dev);
>
>ATS and PRI are not supported on the preserved devices, so the above is
>dead code, right?

Agreed. Will update.
>
>>+	if (ret)
>>+		goto err;
>>+
>>+	return 0;
>>+
>>+err:
>>+	/*
>>+	 * Detach the restored domain from device and iommu on failure, but keep
>>+	 * the hardware state intact.
>>+	 */
>>+	info->domain_attached = false;
>>+	cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
>>+	spin_lock_irqsave(&info->domain->lock, flags);
>>+	list_del(&info->link);
>>+	spin_unlock_irqrestore(&info->domain->lock, flags);
>>+
>>+	domain_detach_reattached_iommu(info->domain, iommu);
>>+	info->domain = NULL;
>>+	return ret;
>>+}
>>+
>>+int intel_iommu_detach_restored_device(struct device *dev)
>>+{
>>+	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>+	struct intel_iommu *iommu = info->iommu;
>>+	struct iommu_domain *domain;
>>+	unsigned long flags;
>>+
>>+	if (!info->domain_attached || !info->domain)
>>+		return -EINVAL;
>>+
>>+	domain = &info->domain->domain;
>>+	if (!iommu_domain_restored_state(domain))
>>+		return -EINVAL;
>>+
>>+	iopf_for_domain_remove(domain, dev);
>>+	cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
>>+	info->domain_attached = false;
>>+
>>+	spin_lock_irqsave(&info->domain->lock, flags);
>>+	list_del(&info->link);
>>+	spin_unlock_irqrestore(&info->domain->lock, flags);
>>+
>>+	domain_detach_reattached_iommu(info->domain, iommu);
>>+	info->domain = NULL;
>>+
>>+	return 0;
>>+}
>>+
>>  /**
>>   * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
>>   * @dev: Target device
>
>Thanks,
>baolu

Thanks,
Sami
