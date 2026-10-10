Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A0E381C4
	for <iommu@lists.linux.dev>; Sat, 10 Oct 2026 01:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791597512; cv=none; b=gJJ4BfYoNGUMFpKNTPWarZ7jrFYX5+cGAEVf248x5XTL7Fe2KFs4nxyyJ0oyWAJEgdHJiHgrpJsQBm0g6ZBdmrAleBWfS6EkqSRN17HFo6B3DIyD9s3YjzeG7eOxYvWQkY7vAkwxomDaS0PpHXrKudwRYssieX82Rlsuix4gwks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791597512; c=relaxed/simple;
	bh=xPIPpJ/LPdzWJUyfrcRd+WQOom000RG2r9Joqzd9rI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJMMFYgRXKbcuT/x0nsNc/xvnGuccW0NnJj3ZcGyoq5vaFoNXGQejv9T7gTntgMUq60l6GQPAJuqATe0Oi0/diQzauFszmHPCa2U1Ah+dHnCEwnUQwGPdScZk+HbNAiLIqhhpHWSpxjzEoYAno6Tr3VTdiEx8Yc9ZWso4RivfU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f3a0+dSG; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f3a0+dSG"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2db33db4de9so9715ad.0
        for <iommu@lists.linux.dev>; Fri, 09 Oct 2026 18:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791597509; x=1792202309; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z81fDu3igV0vcLPfVDZMEj7VAfH/V/82fC4dwENKIik=;
        b=f3a0+dSG5em++pyU+G1+BjWU+NYX2OSkfTT+aQ5cOREu/rhSDHQ+hWJ/QdJETeFH3d
         9CEfSCAFOdIAsK/sQXzZNPlB8jGdgxBBZCO+xlAY5XSUXZEjGf3ddWXLLW5URJSjrhwl
         LzbcJwI8SGsbGKc3+HXY+TWscbGt+rKTBb/WIvXkcEv3zCanLLaikREUoOGQebRF/0nO
         VydBeeIk1qCOAf25wH3mF2LiRuXw9EOnzoJjRyz8gLvszv+bjvjB4DpfzXeCPGgu1La2
         nMMlqiOGwMJx2pTiT6Cew0Q9LXY3349K7N5m0cvGtT6qGXHKTsfQLhYL+gqDLoGJOY0K
         CV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791597509; x=1792202309;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z81fDu3igV0vcLPfVDZMEj7VAfH/V/82fC4dwENKIik=;
        b=jK66+lQYxChq1742I1czmTL5pDWs7tdz+KaZYHJsKJq8eTCfnC1URhOtOEbu/8iijY
         ija9nhQ2RRvqqtlVm7+TryA78ExQX9lG0zVoQ4iIO4WgKks0rZn84h8O9WUOjTyHCVsl
         3xZxP9Y9K5x3ACSaCFsZ/d9yu57cHQHJWtOvtrIq7t7cCZS6KBe9YMAyOsjwG9VhYZPp
         Il2lZF6dcLOUT9oLgYMWJekmIa07ZZmuiz8F7O9/XQyXvFNjw0s+sb9jUS166cPMGZjF
         7NPUsV0syDKu4OJhj60zjyO5SC/ap297mFw6MU/Bup3AvReIkfbrf9zL+SAdD4gk4o9d
         bZ0Q==
X-Forwarded-Encrypted: i=1; AKwUvBxwbZPeqYJdoau2pZ4nzwM+IQLiemRIAd4J2z9Ik3EZa/whkjmDEuXIBtdajm8pq74Rdehv5Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYJRL+xc27ZZFekaZrpjymQ3UWQxa9H7VKIfJOULtxzPYvKxlZ50
	uhCqSDM0VRZYitEfWMvrwoIe5Pntb1vlQLFPtHSYPLoWElXqHfUIn5VXaV8KojfsqQ==
X-Gm-Gg: AYBFou0LdkyS7fgAB++8vpfkiFef8mQPk0/WrNe5TDQ0yDLmSK+LWM5nJJt+5ILII7P
	zBORB2FbAabxlwYQjSJspxDcsRqOvARuNU2S2LRkkMPUiVtV/mii5buV/qAdYw3wH60RSozIwXW
	fWhjXlSZMss15qSwl1yodt+t4oXq8dZjMqrIgKYqYCK+TmZzthZaEfHitGOQCA3NcOdBKtAeuAa
	J1xZt8JqF+VYD61P7LHQyb6CdgEx4rYiFR53sffmtPFlqWfqBzlOPr4/EXGi58vnAGkWzNmim2Z
	oPsApfjcTBJYx/FEkOFA9BNdHdRnpDNNy6RYXQtqpVWPDBUGkFQBJKa4qw5OHJcKo74mOXNjF7P
	uLx8rm2McWNqbemHHo6j3QUKtQzVvSwyOPukzLdEv50m+hwLRFokGxBo1eefnR8yCMNPHebsVV3
	KAa8OfCqhRmun1SRJ32emP32RpA1LjY1U/UeDy9TdAcJrIsEq5Ri6wnSbfsUCqFO4DHpy2+oOxV
	F0R4BzZLO/Ik0GI/4DMwbYTLS48X0XSywGxIx6/db4FZm052FjFUEEzfkkZgwMHAAFFpKGmTJtw
	/XE=
X-Received: by 2002:a17:902:e812:b0:2c7:f688:f22f with SMTP id d9443c01a7336-2e87e2d0534mr528555ad.13.1791597508516;
        Fri, 09 Oct 2026 18:58:28 -0700 (PDT)
Received: from google.com (163.1.145.34.bc.googleusercontent.com. [34.145.1.163])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896a518e6absm1781181b3a.0.2026.10.09.18.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 18:58:26 -0700 (PDT)
Date: Sat, 10 Oct 2026 01:58:22 +0000
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
Subject: Re: [PATCH v5 10/18] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
Message-ID: <asmHoJcu68ztLuz0@google.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-11-skhawaja@google.com>
 <2f42037f-b7b8-4ced-a945-d1d12eb70249@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2f42037f-b7b8-4ced-a945-d1d12eb70249@linux.intel.com>

On Fri, Oct 09, 2026 at 09:44:31AM +0800, Baolu Lu wrote:
>On 9/21/26 08:48, Samiullah Khawaja wrote:
>>During boot fetch the preserved state of IOMMU unit and if found then
>>restore the state.
>>
>>- Reuse the root_table that was preserved in the previous kernel.
>>- Reclaim the domain ids of the preserved domains for each preserved
>>   devices so these are not acquired by another domain.
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      | 111 +++++++++++++++++++------------
>>  drivers/iommu/intel/iommu.h      |   7 ++
>>  drivers/iommu/intel/liveupdate.c |  79 ++++++++++++++++++++++
>>  3 files changed, 154 insertions(+), 43 deletions(-)
>>
>>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>index 474c926172c5..c5044e834337 100644
>>--- a/drivers/iommu/intel/iommu.c
>>+++ b/drivers/iommu/intel/iommu.c
>>@@ -987,28 +987,30 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
>>  	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
>>  }
>>-static void disable_dmar_iommu(struct intel_iommu *iommu)
>>+static void release_dmar_iommu(struct intel_iommu *iommu)
>
>Can we put the code refactor in a separate patch? Mixing it with a
>feature patch makes it hard for review.
>

Sure, I will move it to a separate patch.
>
>>  {
>>-	/*
>>-	 * All iommu domains must have been detached from the devices,
>>-	 * hence there should be no domain IDs in use.
>>-	 */
>>-	if (WARN_ON(!ida_is_empty(&iommu->domain_ida)))
>>-		return;
>>+	struct iommu_hw_ser *iommu_ser;
>>-	if (iommu->gcmd & DMA_GCMD_TE)
>>-		iommu_disable_translation(iommu);
>>-}
>>+	iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
>>+	if (!iommu_ser) {

Thinking about this, failure when restoring a preserved iommu should be
considered fatal as the preserved devices attached to this preserved
iommu may continue to DMA using preserved mappings. The PCI core doesn't
preserve the driver binding so a preserved device can end up with a non
vfio-pci driver. Even disabling translation here is worse as the device
will continue to DMA using the IOVAs that will be treated as physical
addresses, causing memory corruption. I will treat this as fatal and add
a comment to explain.
>>+		/*
>>+		 * All iommu domains must have been detached from the devices,
>>+		 * hence there should be no domain IDs in use.
>>+		 */
>>+		WARN_ON(!ida_is_empty(&iommu->domain_ida));
>>+
>>+		if ((iommu->gcmd & DMA_GCMD_TE))
>>+			iommu_disable_translation(iommu);
>>+	}
>>-static void free_dmar_iommu(struct intel_iommu *iommu)
>>-{
>>  	if (iommu->copied_tables) {
>>  		bitmap_free(iommu->copied_tables);
>>  		iommu->copied_tables = NULL;
>>  	}
>>-	/* free context mapping */
>>-	free_context_table(iommu);
>>+	/* free context mapping if there is no serialized state. */
>>+	if (!iommu_ser)
>>+		free_context_table(iommu);
>>  	if (ecap_prs(iommu->ecap))
>>  		intel_iommu_finish_prq(iommu);
>>@@ -1632,12 +1634,19 @@ static int copy_translation_tables(struct intel_iommu *iommu)
>>  static int __init init_dmars(void)
>>  {
>>+	struct iommu_hw_ser *iommu_ser;
>>  	struct dmar_drhd_unit *drhd;
>>  	struct intel_iommu *iommu;
>>  	int ret;
>>  	for_each_iommu(iommu, drhd) {
>>+		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
>>  		if (drhd->ignored) {
>>+			if (WARN_ON(iommu_ser)) {
>>+				ret = -EINVAL;
>>+				goto free_iommu;
>>+			}
>>+
>>  			iommu_disable_translation(iommu);
>>  			continue;
>>  		}
>>@@ -1655,7 +1664,9 @@ static int __init init_dmars(void)
>>  		}
>>  		intel_iommu_init_qi(iommu);
>>-		init_translation_status(iommu);
>>+
>>+		if (!iommu_ser)
>>+			init_translation_status(iommu);
>>  		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
>>  			iommu_disable_translation(iommu);
>>@@ -1664,14 +1675,18 @@ static int __init init_dmars(void)
>>  				iommu->name);
>>  		}
>>-		/*
>>-		 * TBD:
>>-		 * we could share the same root & context tables
>>-		 * among all IOMMU's. Need to Split it later.
>>-		 */
>>-		ret = iommu_alloc_root_entry(iommu);
>>-		if (ret)
>>-			goto free_iommu;
>>+		if (iommu_ser) {
>>+			intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);
>>+		} else {
>>+			/*
>>+			 * TBD:
>>+			 * we could share the same root & context tables
>>+			 * among all IOMMU's. Need to Split it later.
>>+			 */
>>+			ret = iommu_alloc_root_entry(iommu);
>>+			if (ret)
>>+				goto free_iommu;
>>+		}
>>  		if (translation_pre_enabled(iommu)) {
>>  			pr_info("Translation already enabled - trying to copy translation structures\n");
>>@@ -1707,7 +1722,10 @@ static int __init init_dmars(void)
>>  	 */
>>  	for_each_active_iommu(iommu, drhd) {
>>  		iommu_flush_write_buffer(iommu);
>>-		iommu_set_root_entry(iommu);
>>+
>>+		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
>>+		if (!iommu_ser)
>>+			iommu_set_root_entry(iommu);
>>  	}
>>  	check_tylersburg_isoch();
>>@@ -1752,10 +1770,8 @@ static int __init init_dmars(void)
>>  	return 0;
>>  free_iommu:
>>-	for_each_active_iommu(iommu, drhd) {
>>-		disable_dmar_iommu(iommu);
>>-		free_dmar_iommu(iommu);
>>-	}
>>+	for_each_active_iommu(iommu, drhd)
>>+		release_dmar_iommu(iommu);
>>  	return ret;
>>  }
>>@@ -2136,17 +2152,28 @@ int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
>>  static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>>  {
>>  	struct intel_iommu *iommu = dmaru->iommu;
>>+	struct iommu_hw_ser *iommu_ser;
>>  	int ret;
>>+	/* Use IOMMU HW unit MMIO base to identify the preserved state. */
>>+	iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
>>+
>>  	/*
>>  	 * Disable translation if already enabled prior to OS handover.
>>  	 */
>>-	if (iommu->gcmd & DMA_GCMD_TE)
>>+	if (!iommu_ser && iommu->gcmd & DMA_GCMD_TE)
>>  		iommu_disable_translation(iommu);
>>-	ret = iommu_alloc_root_entry(iommu);
>>-	if (ret)
>>-		goto out;
>>+	if (iommu_ser) {
>>+		if (WARN_ON(dmaru->ignored))
>>+			return -EINVAL;
>>+
>>+		intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);
>>+	} else {
>>+		ret = iommu_alloc_root_entry(iommu);
>>+		if (ret)
>>+			goto out;
>>+	}
>>  	intel_svm_check(iommu);
>>@@ -2165,23 +2192,23 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>>  	if (ecap_prs(iommu->ecap)) {
>>  		ret = intel_iommu_enable_prq(iommu);
>>  		if (ret)
>>-			goto disable_iommu;
>>+			goto out;
>>  	}
>>  	ret = dmar_set_interrupt(iommu);
>>  	if (ret)
>>-		goto disable_iommu;
>>+		goto out;
>>+
>>+	if (!iommu_ser)
>>+		iommu_set_root_entry(iommu);
>>-	iommu_set_root_entry(iommu);
>>  	iommu_enable_translation(iommu);
>>  	iommu_disable_protect_mem_regions(iommu);
>>  	return 0;
>>-disable_iommu:
>>-	disable_dmar_iommu(iommu);
>>  out:
>>-	free_dmar_iommu(iommu);
>>+	release_dmar_iommu(iommu);
>>  	return ret;
>>  }
>>@@ -2195,12 +2222,10 @@ int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
>>  	if (iommu == NULL)
>>  		return -EINVAL;
>>-	if (insert) {
>>+	if (insert)
>>  		ret = intel_iommu_add(dmaru);
>>-	} else {
>>-		disable_dmar_iommu(iommu);
>>-		free_dmar_iommu(iommu);
>>-	}
>>+	else
>>+		release_dmar_iommu(iommu);
>>  	return ret;
>>  }
>>diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>>index 4feb5bd76b18..3a2cb08c0ac1 100644
>>--- a/drivers/iommu/intel/iommu.h
>>+++ b/drivers/iommu/intel/iommu.h
>>@@ -1308,10 +1308,17 @@ int intel_iommu_preserve(struct iommu_device *iommu,
>>  void intel_iommu_unpreserve(struct iommu_device *iommu,
>>  			    struct iommu_hw_ser *iommu_ser);
>>  void clear_unpreserved_context_entries(struct intel_iommu *iommu);
>>+void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>>+					       struct iommu_hw_ser *iommu_ser);
>>  #else
>>  static inline void clear_unpreserved_context_entries(struct intel_iommu *iommu)
>>  {
>>  }
>>+
>>+static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>>+							     struct iommu_hw_ser *iommu_ser)
>>+{
>>+}
>>  #endif
>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>>diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
>>index 501dc0e9cc0a..c9e553379683 100644
>>--- a/drivers/iommu/intel/liveupdate.c
>>+++ b/drivers/iommu/intel/liveupdate.c
>>@@ -272,6 +272,85 @@ static int preserve_iommu_context_tables(struct device_domain_info *info)
>>  	return 0;
>>  }
>>+static void restore_iommu_context(struct intel_iommu *iommu)
>>+{
>>+	struct context_entry *context;
>>+	int i;
>>+
>>+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
>>+		context = iommu_context_addr(iommu, i, 0, 0);
>>+		if (context)
>>+			iommu_restore_pages(virt_to_phys(context));
>
>Why not use the serialized context_tables_bitmap as the source of truth,
>and check it against the present bits?

Sounds good. The root entries of the unpreserved context tables are
cleared during shutdown, so the present bits should match the bitmap. I
will use the context_tables_bitmap and check it against the present
bits.
>
>>+
>>+		if (!sm_supported(iommu))
>>+			continue;
>>+
>>+		context = iommu_context_addr(iommu, i, 0x80, 0);
>>+		if (context)
>>+			iommu_restore_pages(virt_to_phys(context));
>>+	}
>>+}
>>+
>>+static int _restore_used_domain_ids(struct iommu_device_ser *ser, void *arg)
>>+{
>>+	int id = ser->domain_iommu_ser.attachment_id;
>>+	struct iommu_hw_ser *iommu_hw_ser;
>>+	struct intel_iommu *iommu = arg;
>>+	int ret;
>>+
>>+	if (WARN_ON(!ser->domain_iommu_ser.iommu_phys))
>>+		return 0;
>>+
>>+	iommu_hw_ser = phys_to_virt(ser->domain_iommu_ser.iommu_phys);
>>+	if (iommu_hw_ser->type != IOMMU_INTEL)
>>+		return 0;
>>+
>>+	/* Only allocate domain ID from associated IOMMU HW unit */
>>+	if (iommu_hw_ser->intel.phys_addr != iommu->reg_phys)
>>+		return 0;
>>+
>>+	guard(mutex)(&iommu->did_lock);
>>+
>>+	/*
>>+	 * The domain IDs are reclaimed while the IOMMU HW unit is being
>>+	 * restored and not registered with the IOMMU core. So if the ID already
>>+	 * exists, it is safe to assume that a preserved device sharing the same
>>+	 * domain ID reclaimed it.
>>+	 */
>>+	if (ida_exists(&iommu->domain_ida, id))
>>+		return 0;
>>+
>>+	ret = ida_alloc_range(&iommu->domain_ida, id, id, GFP_KERNEL);
>>+	if (ret < 0)
>>+		return ret;
>
>Commit 12a2ea2d91be ("iommu/vt-d: Handle DID reservation errors when
>copying context tables") on the iommu/next branch introduced a new
>helper named reserve_domain_id() for reserving a domain ID inherited
>from the previous kernel. Could it be reused here?

Sure, I will rebase this on top of iommu/next plus dependencies and use
reserve_domain_id().
>
>>+
>>+	return 0;
>>+}
>>+
>>+/**
>>+ * intel_iommu_liveupdate_restore_root_table() - Restore root table and reclaim domain IDs
>>+ * @iommu: Target IOMMU
>>+ * @iommu_ser: Serialized IOMMU hardware state from previous kernel
>>+ *
>>+ * Restores the preserved root table and context tables for the IOMMU hardware
>>+ * instance across Live Update, and reclaims all domain IDs previously allocated
>>+ * to preserved devices so they are not reused.
>>+ */
>>+void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>>+					       struct iommu_hw_ser *iommu_ser)
>>+{
>
>This restores the preserved root table without checking the new
>environment. Is it possible that kexec has a different kernel command
>line (say intel_iommu=sm_off) for the new kernel than the previous
>kernel? sm_supported(iommu) will then return a value different from the
>real hardware configuration.

Agreed. I will add sanity checks to handle these.
>
>>+	if (!iommu_ser->intel.restored)
>>+		iommu_restore_pages(iommu_ser->intel.root_table);
>>+
>>+	iommu->root_entry = __va(iommu_ser->intel.root_table);
>
>Why does the above line execute no matter the value of
>iommu_ser->intel.restored? It would be more readable if the code looked
>like...
>
>	if (iommu_ser->intel.restored)
>		return;
>
>	iommu_restore_pages(iommu_ser->intel.root_table);
>	... ...
>
>Or I overlooked anything?

Good point. I will update this.
>
>>+
>>+	if (!iommu_ser->intel.restored)
>>+		restore_iommu_context(iommu);
>>+
>>+	iommu_ser->intel.restored = 1;
>>+	BUG_ON(iommu_for_each_preserved_device(_restore_used_domain_ids, iommu));
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
