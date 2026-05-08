Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95271D9663
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 02:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778207826; cv=none; b=KRHDag+Wp8lD4uGSYlf3gLzGplJ7BxiTtmkKZdc1VGNJY8gjpm+l7FcU7bWl2F8JgQwjpdiidGX5PVtaN/AHUI0sW/vIiTW1ZstFirYMOrQD+D5/ngeWrUc2ivBgnyXte+MVkgyV1TUn5a4QaKd87SHlHFjwCB64PFboMhTWhco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778207826; c=relaxed/simple;
	bh=7XLyoxiXiPTIEisakBIKoC72jfxRTH7b0MQFmabanUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvoUyiGYrOFivCye+N+u6/8L+NItF3yulcxCJjjBwBc+6TCWKkUYZWbfVAXKAW9mZHvB1ZVJ0JpICF7iT/Ii1YqSu0ltvln9sFHWdEowrzYyf6+YAVKFCY+pg0Mg4Ob2XdGe8OFfBa3Rq7Vs0BnFbiHPr32LGrEFUnFzfqCEvuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TjvLK7RH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TjvLK7RH"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so32775ad.0
        for <iommu@lists.linux.dev>; Thu, 07 May 2026 19:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778207821; x=1778812621; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8wvvHwrpsrKEDb2OQono0ByW7h8DSGBYa8qQB5qgDR4=;
        b=TjvLK7RHbDb5Jc8BjQrV17tk9+CafyE2BLpp9TUdrV3O1Tk834tWzjE6WUw2fF96UT
         mnbGnyQsZ5i0sD+skJv8iVLd8V0nfpR1q2akX4OYmceq43WPIpEWwGhuTZ0MEwhS9Jav
         lOxkqQzN0ucKooJoE/gWnhziCWAdrN5vzEjFT/PsIWh6KLltya+ioHK0lWvTHXHk2z5B
         IgsS3PoBbrVsRq6pnneefyYjs3mhcZ39cAcxnHMxyOMxe3nYd9y0UoHakBvOjzDTM3yf
         PPH6Ven9JA/3WX3rTFnUKHewJAE+MzRBrhVoeHEpLMd0WJkNHHYEeA09qoAmPTOLQEjv
         mcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778207821; x=1778812621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wvvHwrpsrKEDb2OQono0ByW7h8DSGBYa8qQB5qgDR4=;
        b=K15n16Ez9nhMWtvQ+uN/Fb1K3e2HduD+OnYdy7dsOoBui7SxZsW6rWUIl+sG1lYHAL
         bB+TIxqpWC/uiHb28VVQDrsVykg3lHM8QLjGUwoJGJc3Bp5vafsfQR91KEeXr2nMnbbL
         EadCRJrjSZ1hzfd3hjVl4f2KWnwugNYWelbTyC7dGRST5XlB4Si5qVUF1MvFGojuZOf/
         8QcaKgI9B9xg6gDigpItcLsUa2evOC3CW1q+EgpoO02qTty6HvZ6su725XP1TXGLj01I
         y3syKky1DIDvVRLgyzPiyDWaREVAgA3WGekiBKFr5sLLMqBjUVcJKNG91D4XobmdGVbw
         E1Xg==
X-Forwarded-Encrypted: i=1; AFNElJ/2nJ2EgZLE3W2RtgdLL5eXgO/EKXcp7OPFcq9rLsTLNL67SALD14EfS6DZigsrgr1QuFwOPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjyQopEAPY0RKGJSZNyF5fCiwU9zvHtvFWfS6QMQ0m88taoS5+
	X0SS12XNw+e0iBYDhtC6AeI2+C7tdSNY2ybPa++l5zOnpC2tdPythuXpuz8rYPiF5Q==
X-Gm-Gg: Acq92OGo+pba1RxOKUUdk3Nwv/jMxNsN54KmsRowqLWcyPHK6fcV3rZwO8yxObiVdvi
	yX4z10elkxTXCM/Z0btKS31iNudflf9/zEpGruiO2/bm/Wy0Z7VpACpFzjxXIygXZWxe4CLWT8z
	wYD1xsBjz2kgN5u46IRREQeg3APOriAho/GRb1JMlqGJW/LDeI3rju53+bNjCB6v86oGGFTfpO7
	roajkpWVDwSPjmzsaalJHw9EeiqLhqVTfJon7l0RU4J7pdv2LNAB5rFIuc73M/h4cD5tfJ2xcWA
	6XQChonfzhFTgDA+NfPKT4G5UV5VFjmnBDWnLYU1tliRZ5m/IUDi4j7rEf8s/pBBBshFUVGj8zO
	fb2kpw61TGhWLuzKq10f/feyF+1FvYgCwCMy6pI4KIEZmIjosFQyHQ8+UX5AGTIQTGXRyz2C41i
	7YoNswnKEj6Qi6fWpkq7GHi67SD/F0wn9BPcn13AEFTtvCfyPOlseDLGr+qcGHbX81veSroQ==
X-Received: by 2002:a17:902:c40b:b0:2b0:d1f4:f601 with SMTP id d9443c01a7336-2baee82c9famr1274245ad.15.1778207820573;
        Thu, 07 May 2026 19:37:00 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c80e7sm12834136b3a.31.2026.05.07.19.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 19:36:59 -0700 (PDT)
Date: Fri, 8 May 2026 02:36:56 +0000
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
Subject: Re: [PATCH v2 07/16] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
Message-ID: <af023TAT1m3oA9ez@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-8-skhawaja@google.com>
 <a968550d-2cab-47fd-8639-a8747a8a7535@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a968550d-2cab-47fd-8639-a8747a8a7535@linux.intel.com>

On Thu, May 07, 2026 at 02:25:14PM +0800, Baolu Lu wrote:
>On 4/28/26 01:56, Samiullah Khawaja wrote:
>>Add implementation of the device and iommu presevation in a separate
>>file. Also set the device and iommu preserve/unpreserve ops in the
>>struct iommu_ops.
>>
>>During normal shutdown the iommu translation is disabled. Since the root
>>table is preserved during live update, it needs to be cleaned up and the
>>context entries of the unpreserved devices need to be cleared.
>
>This is not related to preserve/unpreserve ops and could be made in a
>separated patch?

Agreed. I will move this stuff to a separate patch.
>
>>
>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>---
>>  MAINTAINERS                      |   1 +
>>  drivers/iommu/intel/Makefile     |   1 +
>>  drivers/iommu/intel/iommu.c      |  52 +++++++++++-
>>  drivers/iommu/intel/iommu.h      |  28 +++++++
>>  drivers/iommu/intel/liveupdate.c | 139 +++++++++++++++++++++++++++++++
>>  drivers/iommu/iommu.c            |  18 ++++
>>  include/linux/iommu-liveupdate.h |  10 +++
>>  include/linux/iommu.h            |  14 ++++
>>  include/linux/kho/abi/iommu.h    |  18 ++++
>>  9 files changed, 277 insertions(+), 4 deletions(-)
>>  create mode 100644 drivers/iommu/intel/liveupdate.c
>>
>>diff --git a/MAINTAINERS b/MAINTAINERS
>>index 980041955abc..9f5c02c6c8c1 100644
>>--- a/MAINTAINERS
>>+++ b/MAINTAINERS
>>@@ -13495,6 +13495,7 @@ M:	Samiullah Khawaja <skhawaja@google.com>
>>  R:	Pranjal Shrivastava <praan@google.com>
>>  L:	iommu@lists.linux.dev
>>  S:	Maintained
>>+F:	drivers/iommu/intel/liveupdate.c
>
>This file is deeply integrated into the Intel IOMMU driver. Maintaining
>it separately from the rest of the driver would add unnecessary
>complexity. I suggest merging this entry into the existing Intel IOMMU
>block so they can be managed together.

I understand your concern. This file is driver specific and should
definitely be routed through your tree.

My goal with listing it here wasn't to change the merge path, but rather
to ensure I am responsible for the liveupdate-specific logic in this
file. Because this file acts as the backend to the generic Live Update
framework, keeping it tied to the Liveupdate IOMMU entry helps guarantee
that future changes stay architecturally aligned and tested across the
whole liveupdate feature.

However, I think I will add a dedicated 'IOMMU VT-d LIVEUPDATE' block
where you are also listed as maintainer, and the patches for this file
should absolutely continue to flow through the Intel IOMMU tree.
>
>>  F:	drivers/iommu/liveupdate.c
>>  F:	include/linux/iommu-liveupdate.h
>>  F:	include/linux/kho/abi/iommu.h
>>diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
>>index ada651c4a01b..d38fc101bc35 100644
>>+

[snip]
>>+static void unpreserve_iommu_context_table(struct intel_iommu *iommu, int end)
>>+{
>>+	struct context_entry *context;
>>+	int i;
>>+
>>+	for (i = 0; i < end; i++) {
>>+		context = iommu_context_addr(iommu, i, 0, 0);
>>+		if (context)
>>+			iommu_unpreserve_page(context);
>>+
>>+		if (!sm_supported(iommu))
>>+			continue;
>>+
>>+		context = iommu_context_addr(iommu, i, 0x80, 0);
>>+		if (context)
>>+			iommu_unpreserve_page(context);
>>+	}
>>+}
>>+
>>+static int preserve_iommu_context_table(struct intel_iommu *iommu)
>
>Since this function preserves all context tables, should it be renamed
>to preserve_iommu_context_tables()?

Agreed. Will change this.
>
>>+{
>>+	struct context_entry *context;
>>+	int ret;
>>+	int i;
>>+
>>+	for (i = 0; i < ROOT_ENTRY_NR; i++) {
>>+		/*
>>+		 * Alloc the context tables now to make sure the iommu unit is
>>+		 * properly preserved. These might stay unused and wastes around
>>+		 * 32MB max in scalable mode.
>>+		 */
>
>Instead of allocating and preserving context tables for all root entries
>(as noted, can waste up to 32MB), could we restrict this only to the
>entries possibly in use by active PCI devices?

I think the hotplug devices or VFs created through SR-IOV will be missed
that way. Lets say device A is preserved and the associated iommu is
also preserved. And then a new device B is hotplugged and preserved,
then the context table for that will be missed.

Since we don't track the context_tables that are preserved, there is no
way to incremently preserve the new-ones. Let me look into the behaviour
of KHO, maybe we can make the preserve call idempotent and do these
incrementally.
>
>>+		spin_lock(&iommu->lock);
>>+		context = iommu_context_addr(iommu, i, 0, 1);
>>+		spin_unlock(&iommu->lock);
>>+		if (!context) {
>>+			ret = -ENOMEM;
>>+			goto error;
>>+		}

[snip]
>>diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>index 1c424b32c5fc..999be5127c65 100644
>>--- a/include/linux/iommu.h
>>+++ b/include/linux/iommu.h
>>@@ -1207,6 +1207,20 @@ static inline void *dev_iommu_priv_get(struct device *dev)
>>  void dev_iommu_priv_set(struct device *dev, void *priv);
>>+typedef int (*iommu_dev_iter_fn)(struct device *dev,
>>+				 struct iommu_device *iommu, void *arg);
>>+
>>+/**
>>+ * struct iommu_dev_iter - Iterator for devices attached to an IOMMU
>>+ */
>>+struct iommu_dev_iter {
>>+	struct iommu_device *iommu;
>>+	iommu_dev_iter_fn fn;
>>+	void *arg;
>>+};
>>+
>>+void iommu_for_each_dev(struct iommu_dev_iter *iter);
>
>Is a generic helper necessary here? I am concerned about potential races
>with concurrent operations especially probe_device or release_device.
>And also the hot-plug/unplug scenarios?
>
>Since the current preservation logic is limited to PCI devices, it might
>be safer and simpler to use the existing for_each_pci_dev() for this
>specific case instead of introducing a new generic helper?

The helper is used late during shutdown to clean up context entries for
devices that are not preserved. During this phase, the system is
quiescent and hotplug is disabled, so there are no races with concurrent
probe or release operations.

I was using for_each_pci_dev() in previous version, but the iterator is
needed to clear context entries of both PCI and non-PCI devices that are
unpreserved.

Please also see related comments on previous version:
https://lore.kernel.org/all/ab3R54-kyHGDEW9L@google.com/
>
>>+
>>  extern struct mutex iommu_probe_device_lock;
>>  int iommu_probe_device(struct device *dev);

[snip]
>>+	};
>>  } __packed;
>>  /**
>
>Thanks,
>baolu
>

Thanks,
Sami
