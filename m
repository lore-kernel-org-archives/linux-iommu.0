Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313299;
	b=B+ckkMMm9TVFyqzWwgQi6hvLMrm4CvI+F08wqcHyqcFj2zfUFw9+Ar306w48WxemspFT
	 V5TocB0fPQscmCVYGpKMPgWnsos2wl5sG+KSzxLqLvNZ8DV7aDMid9c71ji/DJIPiLb+N
	 L+0OTScH1gkV1H/pbp31TSva/PZiBFuBGpxfJNhNaxmllivEI0WTFBr1p2i93HW1+BR5d
	 3/4Z0uwAqauxDQnPe07Fd5LTNrzy8pPFqNNf5p4WF/NOwdufu7G+DWGV8OR4i4tLIbYJ7
	 MHBO4qFTH0CT2Jw6kln7qO8pl0ZD5G6zlmtzRN89BTKRmv+4Jo4kIV3Ngd4pnkCOb8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Vn+1r0fXkT/Pxt7Z8ODGIrb/O48lJ8IHe/qMz+85vCk=;
	b=3bnY5BFG/Q8U0lUeESaejMqILb1jfp3ZUCm1kE4jF9R4KLjALKPqkqV312zEhxBVVSj5
	 W5X4zfLnoAe4hq3NTZ8OL00vxdf/yoiWaF40JcsbxA1sx4LDZYh4CBbR9MXFckzRCzfvI
	 60m4Y8Pa/s9GurntFgwnmf32f8orKEVweJoN+M+Zpo9C1SyyAABDXMMMeH4wEvK9EZAnx
	 hlDT7an4sGiKooQHEUGPrusVnjvrVpII1jNNeEQ2/gFjNEv2ExRk1dgmnRWQ6CtcHFT2Z
	 osmQ3KCrD983gtUedDPhn2dPdcjaDSEbeRHYUZpPXSuJLGh6Enf8TVtAW0/NGZWT3aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MWDvg7sP;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53FA606A31D
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 22:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B53FA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=MWDvg7sP
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e9f6a16afcso11895ad.1
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 15:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793313298; x=1793918098; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vn+1r0fXkT/Pxt7Z8ODGIrb/O48lJ8IHe/qMz+85vCk=;
        b=MWDvg7sPKBEoUiqQESQXZv6VA5OJ7qCXGrIU5igB/C+yeiZPZA+WG+RBLj9sxfCxCh
         lrzKsL/rFjqtKwHKGn7kJuPT73FSZN4+vwJfDz/LHhmUBxW6Ijf6Ougm1GsKYKpEMwV7
         GqKmKTxyEGVBi2K56R+fLLgjHX80rl2iUAP00kOM+7qBhDQp8Rj78jZvYZdaF3crmikW
         gQ/rAAFGGfp0qtbIMzNpSxnXGgrnBVF3IdQKM/976+Eq2itgHWdpsHrjT5Vmed0uJokh
         vncSyqdc9EXADbNg1vToiJaZBTiiEx2gRxseIC5BI+9cwmpM7224HZ1WLeYNHX+qYS0Q
         OL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793313298; x=1793918098;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vn+1r0fXkT/Pxt7Z8ODGIrb/O48lJ8IHe/qMz+85vCk=;
        b=L940bDUYXlv0DJ08aVXLJ9lHBjJ1OZ32/Kb01yPvTMeQd/x50qaZ6lS6JJGMpAYYn6
         6edZ0lhs1D9DOUeBLQyRFn047nIh20YIOX4y89UY/CgTl+WazfQPFsND2LUO8hlwsqk6
         rFzbKM5N8pv2qCgPqIYcpGrmp+OUES9eyXYrOBddxOC6aS8JgqHFAbEwi8fF65DolknD
         s0zmoaXtyW1W8haxJ+BakE1RL4ZJaFU5/inLgf86QF32CmN/AlcoOnSMzoCbDLXrb3qq
         q55kUzxroal5Id+mD016aNE7Q9y98N7RoEvkmERd7m71I5gHBvafBKA1RxVbmkKQXmc+
         fX1g==
X-Forwarded-Encrypted: i=1; AKwUvBwxNPl8t+3xr/0G968NzC6gG2eKz4hdhe4lmSpf0kY/bwKvPWqLx/85t4LiMH4WOS1s+Bxyxw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKYlGJD9wSefvr6N0i1vQ85gghcu2dWPXwFFcf99R2diog/2HHD
	1NaPPv5Q96OTOP71537xmz7qLyYScqpiLzAmEJ05qG66kP39b+18Kk4YL9hgAGx46A==
X-Gm-Gg: AYBFou1T7zW8GPdiJQA9fBAVHRXLlOPXQLLDfLKUmfNafFxDF+Igxtvylr+DCs4h8R0
	cw0Ilv/j+eV7+g684tnU7Ru85BzkJT3YPhYsMoFcHjsESZ/VqcEJVdAmfCcEs2f2o/v7wwjN2Gb
	YKPR0ywP1iSLPh203gvZomifGjGBNrAu1rwPpMUcJ2ffslbtf18DhjETuDaufZNGZqilHzm4Vfc
	nV4quspfozNGcG5pCkm4OGghvbvRV44o9GVKmjz6GVTSxg4DXcmI/CRDX9ug0XMTvKYj80uHYie
	S/222r+VNs8iw+P0kOLNEy5SIuBH1e3RYsqlHdQnDrB3yAfvBKlJO0ar058v6biJcDriXMMiMca
	+937HeSmG+hV+3Y6WyUVCRnCK63j4G4+QdjVQ7Oh25Bw/wjuTtt9EzkbsC2PKYVR2uuWNWRgDgi
	Vt2rbQ4qiYq5OzJYqRHQNYOBqiIeviHEFtiww/R+lbRstqO0UJv4ATiXtOmN3SofHeI/ELC8DzW
	0EChwXuoRcBRjdhMLEA754o1Zguttb0R16mu5DJCgrENFd3Qw8xDj3nKa6aMiYmQkz7VzWlkFis
	ZGzWb5+q3A9LUTsYeiGfj7mc9Ziv5MX/74ESKYgsI8/johOFmvRgoauY0r78UfyOLGnbdenMGFe
	gcAmu8opLv/cZY1FU/1UjzAns6rwh9dhkALtazTQvl5Y=
X-Received: by 2002:a17:902:ccc2:b0:2d5:db38:8013 with SMTP id d9443c01a7336-2eb1ececd67mr7233115ad.18.1793313297370;
        Thu, 29 Oct 2026 15:34:57 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3927ff6bsm43495ad.52.2026.10.29.15.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:34:55 -0700 (PDT)
Date: Thu, 29 Oct 2026 22:34:51 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse <dwmw2@infradead.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 13/18] iommu/vt-d: Handle reattach of the restored
 domain
Message-ID: <auPC2pByvuW5uHyH@google.com>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-14-skhawaja@google.com>
 <faeedd16-a271-4ced-be1a-7bd70860bcdc@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <faeedd16-a271-4ced-be1a-7bd70860bcdc@linux.intel.com>

On Thu, Oct 29, 2026 at 04:28:30PM +0800, Baolu Lu wrote:
>On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
>>Reattach the restored domain to the preserved device using restored
>>domain ID. While reattaching do not setup the context and PASID entries
>>as those are preserved during liveupdate.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      |  34 ++++++--
>>  drivers/iommu/intel/iommu.h      |  14 ++++
>>  drivers/iommu/intel/liveupdate.c | 131 +++++++++++++++++++++++++++++++
>>  3 files changed, 171 insertions(+), 8 deletions(-)
>>
>>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>index ecec057f78dd..4f01aa34ccb5 100644
>>--- a/drivers/iommu/intel/iommu.c
>>+++ b/drivers/iommu/intel/iommu.c
>>@@ -2926,6 +2926,9 @@ static int blocking_domain_attach_dev(struct iommu_domain *domain,
>>  				      struct device *dev,
>>  				      struct iommu_domain *old)
>>  {
>>+	if (dev_iommu_restored_state(dev))
>>+		return -EBUSY;
>>+
>
>There is a contract between the iommu core and iommu drivers that
>attaching a blocking domain must always succeed. Otherwise, some
>existing code paths will break.
>
>My understanding is that "block DMA" is always a legitimate request, but
>we don't expect it while the device is in the restored state. So perhaps
>we could trigger a WARN here and continue tearing down the preserved
>entry?

For restore device we try to not block the DMA unless the entity that
preserved in the previous kernel restores it. But you are raising a fair
point, I will see if we can make sure in the core that this is only
called from the core when there is a legitimate reason to block DMA in
case of restored devices. Then we can remove this check from here.
>
>>  	iopf_for_domain_remove(old, dev);
>>  	device_block_translation(dev);
>>  	return 0;
>>@@ -3294,6 +3297,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>>  {
>>  	int ret;
>>+	if (dev_iommu_restored_state(dev))
>>+		return intel_iommu_attach_restored_device(domain, dev);
>>+
>>  	device_block_translation(dev);
>>  	ret = paging_domain_compatible(domain, dev);
>>@@ -3424,7 +3430,8 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>>  	info->iommu = iommu;
>>  	RB_CLEAR_NODE(&info->node);
>>  	if (dev_is_pci(dev)) {
>>-		if (ecap_dev_iotlb_support(iommu->ecap) &&
>>+		if (!dev_iommu_restored_state(dev) &&
>>+		    ecap_dev_iotlb_support(iommu->ecap) &&
>>  		    pci_ats_supported(pdev) &&
>>  		    dmar_ats_supported(pdev, iommu)) {
>>  			info->ats_supported = 1;
>>@@ -3529,12 +3536,16 @@ static void intel_iommu_release_device(struct device *dev)
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
>>@@ -3542,11 +3553,15 @@ static void intel_iommu_release_device(struct device *dev)
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
>>+	else
>>+		kfree(info->pasid_table);
>>  	intel_iommu_debugfs_remove_dev(info);
>>  	kfree(info);
>>  }
>>@@ -4003,6 +4018,9 @@ static int identity_domain_attach_dev(struct iommu_domain *domain,
>>  	struct intel_iommu *iommu = info->iommu;
>>  	int ret;
>>+	if (dev_iommu_restored_state(dev))
>>+		return -EBUSY;
>>+
>>  	device_block_translation(dev);
>>  	if (dev_is_real_dma_subdevice(dev))
>>diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>>index 260c7a5b1240..f910e5383e12 100644
>>--- a/drivers/iommu/intel/iommu.h
>>+++ b/drivers/iommu/intel/iommu.h
>>@@ -1322,6 +1322,9 @@ void clear_unpreserved_context_entries(struct intel_iommu *iommu);
>>  void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>>  					       struct iommu_hw_ser *iommu_ser);
>>  void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu);
>>+int intel_iommu_attach_restored_device(struct iommu_domain *domain,
>>+				       struct device *dev);
>>+int intel_iommu_detach_restored_device(struct device *dev);
>>  #else
>>  static inline void clear_unpreserved_context_entries(struct intel_iommu *iommu)
>>  {
>>@@ -1335,6 +1338,17 @@ static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu
>>  static inline void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu)
>>  {
>>  }
>>+
>>+static inline int intel_iommu_attach_restored_device(struct iommu_domain *domain,
>>+						     struct device *dev)
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
>
>It appears that there is no way to replace the restored domain, because
>nothing ever clears IOMMU_SER_FLAG_INCOMING or dev->iommu->device_ser.
>As a result, if iommufd later tries to move the device to a new hwpt,
>the attempt will always fail.
>
>I assume this is intended for this phase, and that the actual
>replacement will be handled in a later phase. If so, please mention this
>in the commit message.

Yes, this is intentional for this phase. I will add a note about this in
the commit message also.
>
>>diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
>>index 36816d3651e6..665ebb81bd61 100644
>>--- a/drivers/iommu/intel/liveupdate.c
>>+++ b/drivers/iommu/intel/liveupdate.c
>>@@ -394,6 +394,137 @@ void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu)
>>  		      iommu->name);
>>  }
>>+static void domain_detach_restored_iommu(struct dmar_domain *domain,
>>+					 struct intel_iommu *iommu)
>>+{
>>+	struct iommu_domain_info *info;
>>+
>>+	guard(mutex)(&iommu->did_lock);
>>+	info = xa_load(&domain->iommu_array, iommu->seq_id);
>>+	if (--info->refcnt == 0) {
>>+		xa_erase(&domain->iommu_array, iommu->seq_id);
>>+		kfree(info);
>>+	}
>
>This seems to be different from normal domain_detach_iommu(), which
>looks like this,
>
>        if (--info->refcnt == 0) {
>                ida_free(&iommu->domain_ida, info->did);
>                xa_erase(&domain->iommu_array, iommu->seq_id);
>                kfree(info);
>        }
>
>why ida_free() is skipped in the restored path?

The restored device can be removed and probed again while the PASID and
context entries stay intact. So the restored did is not freed in this
path. Once the domain is reclaimed by the iommufd, then it takes the
normal detach path.

>
>>+}
>>+
>>+static int domain_attach_restored_iommu(struct dmar_domain *domain,
>>+					struct intel_iommu *iommu,
>>+					struct iommu_device_ser *device_ser)
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
>>+	if (!device_ser->attachment.domain_phys ||
>>+	    !device_ser->iommu_phys)
>>+		return -EINVAL;
>>+
>>+	domain_ser = phys_to_virt(device_ser->attachment.domain_phys);
>>+	if (domain_ser->restored_domain != &domain->domain)
>>+		return -EINVAL;
>>+
>>+	iommu_hw_ser = phys_to_virt(device_ser->iommu_phys);
>>+	if (iommu_hw_ser->type != IOMMU_SER_TYPE_INTEL ||
>>+	    iommu_hw_ser->intel.phys_addr != iommu->reg_phys)
>>+		return -EINVAL;
>>+
>>+	restored_did = device_ser->attachment.attachment_id;
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
>
>		if (WARN_ON(curr->did != restored_did))
>			return -EINVAL;

Agreed. I will add this.

>
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
>>+ * intel_iommu_attach_restored_device() - Restore device domain attachment after live update
>>+ * @domain: Restored domain
>>+ * @dev: Restored device
>>+ *
>>+ * Return: 0 on success, or negative error code.
>>+ */
>>+int intel_iommu_attach_restored_device(struct iommu_domain *domain,
>>+				       struct device *dev)
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
>
>The context and PASID table entries are not touched in the restore path.
>That's fine, but it would be better to check that the hardware
>configuration matches the restored domain before trusting it, at least
>the physical address of the page table and the domain ID. With that
>check in place, it would be reasonable to skip
>paging_domain_compatible().

Since the page table address and the domain ID are both programmed into
the context and PASID tables, and both of those are preserved, we can
rely on the KHO preservation of the memory to assume the correctness
here. We already rely on the KHO preservation for the page tables
themselves, including the mappings. Also note that the RTADDR check
during restore gives a sanity check on the root table being used by the
live hardware.

>
>>+	ret = domain_attach_restored_iommu(dmar_domain, iommu, device_ser);
>>+	if (ret)
>>+		return ret;
>>+
>>+	info->domain = dmar_domain;
>>+	info->domain_attached = true;
>>+	spin_lock_irqsave(&dmar_domain->lock, flags);
>>+	list_add(&info->link, &dmar_domain->devices);
>>+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
>>+
>>+	return 0;
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
>>+	info->domain_attached = false;
>>+
>>+	spin_lock_irqsave(&info->domain->lock, flags);
>>+	list_del(&info->link);
>>+	spin_unlock_irqrestore(&info->domain->lock, flags);
>>+
>>+	domain_detach_restored_iommu(info->domain, iommu);
>>+	info->domain = NULL;
>>+
>>+	return 0;
>>+}
>>+
>>  enum pasid_lu_op {
>>  	PASID_LU_OP_PRESERVE = 1,
>>  	PASID_LU_OP_UNPRESERVE,
>
>Thanks,
>baolu
