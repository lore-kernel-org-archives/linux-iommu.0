Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2EB346E7A
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778172743; cv=none; b=rJgz/27jgSlsfAfS7DIK4FaWxL31ro8jO2PvZDGUXHYTvzCUwf/XG15lmQYatyfQQnwBT0xuiX5ePeqG+yMO6+csq+QfBZV1jPVPgYFR4dwoGI7nT3mLUxUuf7fAbo26w70KLTPmqw8racijfqgk+TnB7qmW1VFfvezUm39M1QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778172743; c=relaxed/simple;
	bh=1ru2kTEbiaxGDhtsW3+iRy+k8GjCkWQuz0hTRiFgBjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SowfGxHkiMab4hswrbyjEOHvVkKjhUtTVoEv9fvv8tquFJ1jEEamQu49dBrh+oqDhZZlZDTzwRIQORQ0S5aL7xHtlqt8bKaA/6N99rrSv3c+9vLhfXP0eUb7UYHRRf4cVIDu+F8ivqkv8fnw6V0kdFD4+9WCcOz6AsvIa32/ciQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LQd0KB9f; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LQd0KB9f"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b46da8c48eso110505ad.1
        for <iommu@lists.linux.dev>; Thu, 07 May 2026 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778172741; x=1778777541; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hxt15R9Do9bnwlfCs2VrOW/Q0eumEFUxda7bzIZj6C8=;
        b=LQd0KB9fjCkYHqt5WN5eoZQmiLD9iQN8C/lte6SQ1LDPJjQ4puJgqGApxhkePvuxyU
         feQiA0dmuRel2EvZlNJGbtFa6o2xKsUbyTvwoHAnJ+7yv9+NeVvGpbVcTcz5mNUHolRS
         KQw6IIw4pHgJkJYALf2MjRCiDxeAjDm9IxTJJucElMQbI5hQaR8BBQ3CBJE2kPY1bxxT
         1JBBntpltLZodL/h00M+XIMGNwLPCdDk7w0HR03AQawkCbnHWCOrjn0heFDN7E5wu8Vk
         ZYhLk6n8WYRD8OKMvmN7kP6wbpaKBm14Q7H6PZq2mJUnL3obKuD4WtFOvQKO+jrDErBu
         0nVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778172741; x=1778777541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hxt15R9Do9bnwlfCs2VrOW/Q0eumEFUxda7bzIZj6C8=;
        b=j+ZIzYQaRZsyZ73PrQh0gclZ2us4/8Lg9oOsHOhbwl9sEwEnTJKCN+v6iGonzBXqBG
         qddDlzelUXpUSWof1iGF9n7Sm8suwSRnbihnOckJAh3uOrip7uqRDtHcerBe1pML9A4H
         nH121LWPTJi/+c2uVrgEGKgI6VNt5BN+StxMmpnGmdnPIVsn1njx4a92MqL+rSYcKBaz
         lNYXacDo2UkNpCZRQd6ffDCSeNbxwF+kuVsXjhvGFkFPYoAVDgJncBPd42XR2befthCr
         BSvlUR5cnI6YnkWmWPlvKn4OTsxMcQNhQWM1gGEo4theRk9xRMSdTsbC2lMcDOhFFJWP
         lchA==
X-Forwarded-Encrypted: i=1; AFNElJ+IIIdRjos2VG2nfnMKstn1Khe4+EB4cSftrEVNIQcHQb1qWjqC3ZWpLZIgTaD8bv77N04lPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxE3si/71GnBWzWUY1t/P330VoVtVj3oSvCfTuDUIu0CHr4vZsQ
	g6TOtvG6p/i0+8xKUJnDn9jSx7EwP6oiIEgatR4Uhd1mr0iMm6xLh6yBmLsTr/2oGA==
X-Gm-Gg: Acq92OHsTMgANbyeoY2IauH1dATlu41Z8G6kMFuD5yu7xZxAB1sx3HrZ+LRKA0E4Ztc
	Vb3q1b5AkPGhv77DV+1flRIAXnNRERsxPOFOdc1Fxno9jyF3uYkWlc9MBYJBd8evKyd6AWKyEta
	usx9bRefL8fLCq97bytyH9AGB7ke2sZuDTZkC29u04v+wNs3xZFeL/ufz+EIGaerZZjQoeaSS0Q
	IOsvFzGJrZQehcLoIBQYlSTemTdon9Fs8STUzEKKwR+8hPQ0+nxybEYY0kgfvACpMQq2EKJwwQq
	YtUV6Bx0fCVo9ujEAqv4OGk2kbDjvqGDHeRbVUx7b6zDULckbXlCIWacKhfjMWtn4rzwVY3sp9W
	QjpRqKjezv3NrQ8DBqsXmXrcpdJCPwTNJ3fL82HKZJ4BJ+CX+6juH1hXh+B7l3p9ZGp0Iq4MhuU
	rQySack7OT1iQgjKQHdopjgcEiYBrAmYMOPUuFM+l8Psm1Z10BdDdPYUw3RRBwT2PytJ8P4vkdw
	md6zyJp
X-Received: by 2002:a17:903:2c7:b0:2b4:641a:6b7c with SMTP id d9443c01a7336-2bae5ae409amr643225ad.13.1778172740873;
        Thu, 07 May 2026 09:52:20 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bae783dc45sm2176155ad.39.2026.05.07.09.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:52:20 -0700 (PDT)
Date: Thu, 7 May 2026 16:52:18 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 10/16] iommu: Restore and reattach preserved domains
 to devices
Message-ID: <afzBptf2YsmdJ8V8@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-11-skhawaja@google.com>
 <a88649ec-de69-43ed-a364-dcbfef09dfa6@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a88649ec-de69-43ed-a364-dcbfef09dfa6@linux.intel.com>

On Thu, May 07, 2026 at 09:54:27PM +0800, Baolu Lu wrote:
>On 4/28/2026 1:56 AM, Samiullah Khawaja wrote:
>>Restore the preserved domains by restoring the page tables using restore
>>IOMMU domain op. Reattach the preserved domain to the device during
>>default domain setup. While attaching, reuse the domain ID that was used
>>in the previous kernel. The context entry setup is not needed as that is
>>preserved during liveupdate.
>>
>>Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      | 49 ++++++++++++++------
>>  drivers/iommu/intel/iommu.h      |  3 +-
>>  drivers/iommu/intel/nested.c     |  2 +-
>>  drivers/iommu/iommu.c            | 61 ++++++++++++++++++++++++-
>>  drivers/iommu/liveupdate.c       | 78 ++++++++++++++++++++++++++++++++
>>  include/linux/iommu-liveupdate.h | 50 ++++++++++++++++++++
>>  6 files changed, 224 insertions(+), 19 deletions(-)
>
>Please split the changes in the Intel iommu driver and the iommu core
>into different patches.

Agreed. I will split these.
>
>>
>>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>index 4118a0861f38..b90757164cd8 100644
>>--- a/drivers/iommu/intel/iommu.c
>>+++ b/drivers/iommu/intel/iommu.c
>>@@ -1031,7 +1031,8 @@ static bool first_level_by_default(struct intel_iommu *iommu)
>>  	return true;
>>  }
>>-int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
>>+int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu,
>>+			int restore_did)
>
>How about using a new helper for restored domain? For example,
>
>	int domain_reattach_iommu(...)
>
>or
>
>	int domain_restore_iommu(...)

Agreed. I didn't do this to avoid code duplication, but I think this
might be much clean. Also in the restore path, the did test can also be
done as you pointed out below.
>
>>  {
>>  	struct iommu_domain_info *info, *curr;
>>  	int num, ret = -ENOSPC;
>>@@ -1051,8 +1052,11 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
>>  		return 0;
>>  	}
>>-	num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
>>-			      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
>>+	if (restore_did >= IDA_START_DID)
>>+		num = restore_did;
>
>For a preserved domain ID, do we need to check whether it has been
>reserved from the ida pool?

Yes, I will add a sanity check once I move this logic into separate
function.
>
>>+	else
>>+		num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
>>+				      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
>>  	if (num < 0) {
>>  		pr_err("%s: No free domain ids\n", iommu->name);
>>  		goto err_unlock;
>>@@ -1320,10 +1324,14 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>>  {
>>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>  	struct intel_iommu *iommu = info->iommu;
>>+	struct device_ser *device_ser = NULL;
>>  	unsigned long flags;
>>  	int ret;
>>-	ret = domain_attach_iommu(domain, iommu);
>>+	device_ser = dev_iommu_restored_state(dev);
>>+
>>+	ret = domain_attach_iommu(domain, iommu,
>>+				  dev_iommu_restore_did(dev, &domain->domain));
>
>What is the expected behavior if there is a mismatch between the
>restored state and the availability of a domain ID? Specifically, if
>device_ser is found but dev_iommu_restore_did() fails (returns -1), how
>should the driver proceed in that case?

The restore of the domain should fail in this case, as this is
unexpected behaviour, as the DID should be preserved in the previous
kernel and in this (new) kernel the did should have been reclaimed
during iommu HW restore.

But I think we can sanity check these in the separate restore function.
I will rework this.
>
>>  	if (ret)
>>  		return ret;
>>@@ -1336,16 +1344,18 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>>  	if (dev_is_real_dma_subdevice(dev))
>>  		return 0;
>>-	if (!sm_supported(iommu))
>>-		ret = domain_context_mapping(domain, dev);
>>-	else if (intel_domain_is_fs_paging(domain))
>>-		ret = domain_setup_first_level(iommu, domain, dev,
>>-					       IOMMU_NO_PASID, NULL);
>>-	else if (intel_domain_is_ss_paging(domain))
>>-		ret = domain_setup_second_level(iommu, domain, dev,
>>-						IOMMU_NO_PASID, NULL);
>>-	else if (WARN_ON(true))
>>-		ret = -EINVAL;
>>+	if (!device_ser) {
>>+		if (!sm_supported(iommu))
>>+			ret = domain_context_mapping(domain, dev);
>>+		else if (intel_domain_is_fs_paging(domain))
>>+			ret = domain_setup_first_level(iommu, domain, dev,
>>+						       IOMMU_NO_PASID, NULL);
>>+		else if (intel_domain_is_ss_paging(domain))
>>+			ret = domain_setup_second_level(iommu, domain, dev,
>>+							IOMMU_NO_PASID, NULL);
>>+		else if (WARN_ON(true))
>>+			ret = -EINVAL;
>>+	}
>>  	if (ret)
>>  		goto out_block_translation;
>>@@ -3170,6 +3180,15 @@ int paging_domain_compatible(struct iommu_domain *domain, struct device *dev)
>>  	struct intel_iommu *iommu = info->iommu;
>>  	int ret = -EINVAL;
>>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>>+	/*
>>+	 * Restored IOMMU domains are already attached to the device and can
>>+	 * only be freed. So no need to check the compatibility.
>>+	 */
>>+	if (iommu_domain_restored_state(domain))
>>+		return 0;
>>+#endif
>>+
>>  	if (intel_domain_is_fs_paging(dmar_domain))
>>  		ret = paging_domain_compatible_first_stage(dmar_domain, iommu);
>>  	else if (intel_domain_is_ss_paging(dmar_domain))
>>@@ -3647,7 +3666,7 @@ domain_add_dev_pasid(struct iommu_domain *domain,
>>  	if (!dev_pasid)
>>  		return ERR_PTR(-ENOMEM);
>>-	ret = domain_attach_iommu(dmar_domain, iommu);
>>+	ret = domain_attach_iommu(dmar_domain, iommu, -1);
>>  	if (ret)
>>  		goto out_free;
>>diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>>index b0ec0b471a43..8e37acf7de12 100644
>>--- a/drivers/iommu/intel/iommu.h
>>+++ b/drivers/iommu/intel/iommu.h
>>@@ -1182,7 +1182,8 @@ void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
>>   */
>>  #define QI_OPT_WAIT_DRAIN		BIT(0)
>>-int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
>>+int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu,
>>+			int restore_did);
>>  void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
>>  void device_block_translation(struct device *dev);
>>  int paging_domain_compatible(struct iommu_domain *domain, struct device *dev);
>>diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
>>index 2b979bec56ce..6e13f697b463 100644
>>--- a/drivers/iommu/intel/nested.c
>>+++ b/drivers/iommu/intel/nested.c
>>@@ -40,7 +40,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
>>  		return ret;
>>  	}
>>-	ret = domain_attach_iommu(dmar_domain, iommu);
>>+	ret = domain_attach_iommu(dmar_domain, iommu, -1);
>>  	if (ret) {
>>  		dev_err_ratelimited(dev, "Failed to attach domain to iommu\n");
>>  		return ret;
>
>Thanks,
>baolu

Thanks,
Sami
