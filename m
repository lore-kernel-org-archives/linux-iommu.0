Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10D8356777
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787776228; cv=none; b=uy1DBQiigTOqlGLiTHmAR4XQ2ulx1g4PBqpza4GfnZQwQH5TGqWcb8hSV3IXtOWCRzuvs1DppYDRN/bJkpMvcltZTwAcC8okMmLBnLeW4Brjr4P8WUCW3arcrtf/JOFOFlPpjDqFP7swDJIN2ivTRVRGI43MDb0+X0skvRqdEH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787776228; c=relaxed/simple;
	bh=0kgi22xNJcVO36+dXKeosv/aiOf0RymZDzU7O1fom8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KG1cZvJAICDYWwtRq8g4QPymXqY2KiW8zdu0bFe9I+GqasmZaBfpvB+FaSIniTDNHjf82QnxZSLnrlKi5B+B87vxJ0R0WKpWroikn5FvQJd4EMORJeY46CdRn8nkL2pac9gbhbamWuW5yY2R+SajzulXW/U5jDsCGxf3KQ1m2D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HQGeXCH5; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HQGeXCH5"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d3b445a84fso7445ad.1
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 13:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787776226; x=1788381026; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tviHa9iHC75nfLCPdWJnLGm9+adY8MzlYYxeJUkpU14=;
        b=HQGeXCH567ED1/IoUdxyck+JB5+f+r88UvrCStuXe0+zumX/2HdUnqvDEpBZXfOwTc
         bFGI8m6CWd6MUaN8rk6Q57p85eTK5QnNteQWXHHZxId/ulOrG/cy00qKEg9xzlWmVZb5
         SDxZzkt5Z5s9WiRm+gByG67LvjmD2Jre+lZRSM+E/y+WWcRPxcsnhib+S3iVAJaYbB4o
         IcR8//kiOvCO4VlTYzlBQY7uhWqvXZjAUG8Za25o5VfwQOUZQymRq4Lua4SASA9/Xo46
         gBV75JWkKTOZgwqxwKkkqohK3bfqzItk2jowdw0SA+uVJQovoZCLi5GzNxTpoOSXHvS4
         yx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787776226; x=1788381026;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tviHa9iHC75nfLCPdWJnLGm9+adY8MzlYYxeJUkpU14=;
        b=GtaqpLqit8oQZMNaPJ/8mQCMBXpEulnI3FFYbTwW5GkbBiUGPQ4IldF1PptHdhiD5B
         mtaz7G6MnqijtiN6eXs+XNJdCgtG62vr+LTzbO5V5uHxEY63WCWIELaRyC8QIN65gvux
         xKsVkJraNktQAn3BUOZmAaZyrzsykv93YBfMhksIx+2kB1rd8ps0BkN0B6/Ka/+Aeyjf
         U2r89suBKtqTKrQHOlmCa6Srv0hEE5pzUonotS5E3e2WeAR2HRG+Le97sWjBY3PSSJyI
         L23SgODtQYqh06QvVMpbG7FUd2Z4DXOSKAXXiYftW1Nm5lPDLMw+ya1shOSG1taI+Snt
         +45Q==
X-Forwarded-Encrypted: i=1; AHgh+RqEsW6MoTE+GkgONJaM9A3T+sp+jR9oL6DCl9A43FxliFLzsQZkd0AaXhvSC5bfsOGsUxRp7Q==@lists.linux.dev
X-Gm-Message-State: AFuF++mTQYHMJKzZnld5Z9wg+cFRkFIfaWOqZ7ZqWY3x0502fs8vTGBH
	JzA8t3jJ2n658ip43zWA7+Bt7zaC8qndgsmd+GNNI5X+QqO6MPlQzHOELzfCvhmygA==
X-Gm-Gg: AR+sD105/Gh9GAzUcqkAGF2XtYYANY7SNoQ7vYZv859UOhFRuXQEHkDNfhOE+hwDigq
	lFCJfttxacMENAjPhoVgLKwfohvlSw4CeAdSR+okakf5NZp1VaUDXfpHGMNZ9UJHDCf1S8te5fp
	JF83nYZCqediUzYEOYp7x7MmXGaRCIEpYQja0XL9cZeqKY5OwluOMVbF3MqoN4dE9kSwTwv9q7V
	KnXvpVlm4Fd8WU+Sb7HzdAk4bmI5So9fcIfp13WcPv5QHiH7HGOTbNKp0No4zrgeDFFmAldez6N
	WQNEwxmdy+kUCg6yjIpSFwAl2wCldqDMd6faRaY13uRAnwoAul8VrUyVKLc0K0SuLa2qysjqHCh
	PbKInfx6DfaBeXmbnUTHcQlW06TiJkzT/hPeLxsxZ/V6N7yLhlZlWO+eYdTOkNk87ky3n8VmRUw
	uzePEzpv85lLdUe/dklr4egvc4Wknp0+rH3NObJegw+gBxzfH9Eg9wq6YiqAf3/+zd/WDQrXs4q
	9b8BVf+S7sTIIyjpIQwHi54KEbw60fLPDC7K+vLlvDPwIhxModSgRE/xns=
X-Received: by 2002:a17:903:b0e:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2d72a67b81amr2346875ad.2.1787776225466;
        Wed, 26 Aug 2026 13:30:25 -0700 (PDT)
Received: from google.com (210.87.127.34.bc.googleusercontent.com. [34.127.87.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1befce3b8sm1387309a12.5.2026.08.26.13.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 13:30:24 -0700 (PDT)
Date: Wed, 26 Aug 2026 20:30:19 +0000
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
Subject: Re: [PATCH v4 08/18] iommu/vt-d: Clear unpreserved context entries
 during shutdown
Message-ID: <ao9ADjoGzgNX4t1M@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-9-skhawaja@google.com>
 <446684d8-44d0-47c5-9301-172c55efd950@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <446684d8-44d0-47c5-9301-172c55efd950@linux.intel.com>

On Wed, Aug 26, 2026 at 04:05:51PM +0800, Baolu Lu wrote:
>On 8/8/26 10:27, Samiullah Khawaja wrote:
>>During normal shutdown the iommu translation is disabled. Since the root
>>table is preserved during live update, it needs to be cleaned up and the
>>context entries of the unpreserved devices and root entries for the
>>unpreserved context tables need to be cleared.
>
>The key assumption here seems to be that, during a live-update kexec,
>most devices do not go through the normal iommu release path. Otherwise,
>their context entries should already be torn down in the
>iommu_release_device path.

Also there is another part that the root table entries of unpreserved
context tables also need to be removed. So even if the devices went
through the release path, the context tables used by those devices are
not removed by the Intel IOMMU driver.
>
>Could you please confirm this assumption and add some short note in the
>comments or commit message?

Yes, I can add a short note in the comment here and also in the commit
message.
>
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      |  15 +++-
>>  drivers/iommu/intel/iommu.h      |   5 ++
>>  drivers/iommu/intel/liveupdate.c | 140 +++++++++++++++++++++++++++++++
>>  3 files changed, 158 insertions(+), 2 deletions(-)
>>
>>+

[snip]

>>+static void clear_unpreserved_context(struct device_domain_info *info, u8 bus, u8 devfn)
>>+{
>>+	struct context_entry *context;
>>+
>>+	/*
>>+	 * This cleanup is done during shutdown, so it should be fine to only
>>+	 * clear the entries here and issue one global invalidation later to
>>+	 * invalidate all cleared entries.
>>+	 *
>>+	 * Note that the device IOTLB invalidation for unpreserved devices is
>>+	 * skipped this way, but that should not be needed as the devices are
>>+	 * quiesced at this point. This should improve the performance of the
>>+	 * cleanup process and avoids any invalidation timeouts because drivers
>>+	 * might have moved devices to D3 state.
>>+	 */
>>+	context = iommu_context_addr(info->iommu, bus, devfn, 0);
>>+	if (context) {
>>+		context_clear_entry(context);
>>+		__iommu_flush_cache(info->iommu, context, sizeof(*context));
>
>For tearing down a present context entry, please follow the VT-d
>recommended sequence:
>
>- clear only the Present bit,
>- flush the updated entry to memory if necessary,
>- issue the required cache invalidations,

Do we still need the individual cache invalidations if we issue global
invalidations (context, pasid-cache and iotlb), after clearing all
entries, as they would be done if a new root table was being setup?

Looking at the VT-d specs (Invalidation of Translation Caches), each
invalidation type (cache, pasid and iotlb) defines granularity in both
register and queue based interface. And the granularity indicates that
Global invalidations clear the cached entries for that specific type.
For example following text is used for each cache type (in queue
interface):

   Context-cache:
   Global Invalidation (01b): All context-cache entries cached at the
   remapping hardware are invalidated.

   Pasid-cache:
   Global Invalidation (11b): All PASID-cache entries are invalidated.

   Iotlb:
   Global Invalidation (01b):
   - All IOTLB entries are invalidated.
   - All paging-structure-cache entries are invalidated.

A similar note about using Global invalidation is suggested in the specs
when setting up root table (Set Root Table Pointer Operation).

   ... software must perform a global invalidate of the contextcache,
   PASID-cache (if applicable), and IOTLB, in that order. This is
   required to ensure hardware references only the remapping structures
   referenced by the new root table pointer and not stale cached entries.

Also please note that this is happening during dmar unit teardown and
system shutdown, and while the context table entries in root table are
being cleared, the memory is not freed until the global invalidation is
issued.

Since this is during shutdown, issuing global invalidations instead of
multiple individual invalidations for devices and aliases is simpler and
would likely also have shutdown time improvements and reduce the
blackout time during liveupdate.

Please let me know if my global invalidations and granularity
understanding is not correct.

I added a comment at the top of this function to explain this, let me
know if you want me to expand it with more details.

>- then clear the remaining fields of the entry.
>
>>+	}
>>+}
>>+
>>+static int clear_unpreserved_alias_cb(struct pci_dev *pdev, u16 alias, void *data)
>>+{
>>+	struct device_domain_info *info = data;
>>+
>>+	clear_unpreserved_context(info, PCI_BUS_NUM(alias), alias & 0xff);
>>+	return 0;
>>+}
>>+
>>+static int clear_unpreserve_context_entry_fn(struct device *dev,
>>+					     struct iommu_device *iommu_dev,
>>+					     void *arg)
>>+{
>>+	struct device_domain_info *info;
>>+	struct context_entry *context;
>>+
>>+	info = dev_iommu_priv_get(dev);
>>+	if (!info)
>>+		return 0;
>>+
>>+	if (!dev_is_pci(dev) || !dev_iommu_preserved_state(dev))
>>+		goto out_unpreserved;
>>+
>>+	/*
>>+	 * PRE use cases are not supported with Live Update and a preservation
>>+	 * attempt on such domains returns an error. But Intel IOMMU driver
>>+	 * enables PRE by default on all devices that support it. For preserved
>>+	 * entries, the PRE needs to be disabled so preserved PCI devices do not
>>+	 * generate PRQs, during kexec, as translations are kept enabled during
>>+	 * live update. There is no need to disable these for DMA aliases.
>>+	 */
>>+	if (sm_supported(info->iommu)) {
>>+		context = iommu_context_addr(info->iommu, info->bus, info->devfn, 0);
>
>Nit: please add a brief comment explaining why locking is not needed at
>this call site.

Will do in next revision.
>
>>+		if (context) {
>>+			context_clear_sm_pre(context);
>
>For cache invalidation considerations when changing the PRE bit in a
>present context entry, please follow the VT-d spec guidance (Table 28,
>“Guidance to Software for Invalidations”).

Please see note above the regarding global invalidations.
>
>>+			__iommu_flush_cache(info->iommu, context, sizeof(*context));
>> +		}> +	}
>>+
>>+	return 0;
>>+
>>+out_unpreserved:
>>+	if (dev_is_pci(dev))
>>+		pci_for_each_dma_alias(to_pci_dev(dev),
>>+					clear_unpreserved_alias_cb, info);
>>+	else
>>+		clear_unpreserved_context(info, info->bus, info->devfn);
>>+
>>+	return 0;
>>+}
>>+
>>+/**
>>+ * clear_unpreserved_context_entries() - Clear context entries for unpreserved devices
>>+ * @iommu: Target IOMMU
>>+ *
>>+ * Clear the context entries of unpreserved devices during shutdown before kexec.
>>+ */
>>+void clear_unpreserved_context_entries(struct intel_iommu *iommu)
>>+{
>>+	struct iommu_dev_iter iter = {
>>+		.fn = clear_unpreserve_context_entry_fn,
>>+		.iommu = &iommu->iommu,
>>+		.arg = NULL,
>>+
>>+	};
>>+
>>+	/*
>>+	 * Clear context entries for unpreserved devices.
>>+	 *
>>+	 * Note that the error can be ignored as the iterator function does not
>>+	 * fail.
>>+	 */
>>+	iommu_for_each_dev(&iter);
>>+
>>+	/* Clear reference to unpreserved context tables */
>>+	clear_unpreserved_context_root_entries(iommu,
>>+					       iommu_preserved_state(&iommu->iommu));
>>+
>>+	/*
>>+	 * Some devices might not have teardown/detached properly depending on
>>+	 * whether a proper device remove is done before kexec is triggered.
>>+	 * Also unpreserved context tables and entries are removed during
>>+	 * shutdown. So issue global invalidations to remove references to
>>+	 * unpreserved tables and entries.
>>+	 */
>>+	iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
>>+	if (sm_supported(iommu))
>>+		qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
>>+	iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);

Global invalidations are issued here after doing all the clear work.
>>+}
>>+
>>  static void unpreserve_iommu_context_tables(struct intel_iommu *iommu,
>>  					    struct iommu_hw_ser *ser)
>>  {
>
>Thanks,
>baolu

Thanks for looking at this.

Sami
