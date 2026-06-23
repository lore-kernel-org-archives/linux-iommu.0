Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37803101C0
	for <iommu@lists.linux.dev>; Tue, 23 Jun 2026 00:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782174418; cv=none; b=OnWgIUXi8tvVAOa1z4WD45ZiZqd95OPMuGDNu5vfHgr7OgVgp0hgYbYXTctsUhbQaSEftgmSjPcBmPEgoJJGAYe5kT7aMyZL/yDSvuHCDbEfhHVcwBf4xQ1JoTaXGWKETdWeHHEOpZmB7VPDFHv5ZujrKIdBbrQPlnbyzJK7Gzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782174418; c=relaxed/simple;
	bh=Mvpv5fk7EqlynV6gqt/65OUkuuW/xeN1GfXtNQ6g2Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeDQA//m/BiTQicFKgB/AVkQV2oLHgdSH54+hHQHNl9+QqqSTPCjSQHDI/SDwg+4diiUts5Ktnh0LwFEy9Hz5bwnAyhYhUiAsGQtJqrMeQRJHPGwv1zxxAYvdmTVH5+Ww76nplZFyQkyQlH5baTfbkDPkfEFmecDdMsrWPyNgD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X3DK3bPn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X3DK3bPn"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c69fa0b1f8so23725ad.0
        for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 17:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782174416; x=1782779216; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dnnvmp3kEWC924WaK9RNBF9LgizMYwDhSueWIubs0Ho=;
        b=X3DK3bPnzNVyWxlXboHfSzsOvH4DOAS/7eJWcfcJuOCyPwFObcKBT4l1zThaN9y32J
         p7+Cobuqxv6jkN6nQxvg41CkzYmqy6LscCu1ZHbLGYPFfWiZiqgyAFAWEjhTBhKjCyJz
         mXLrGMGh6Y1Gd2MYBxXzoYaiWdkywkSTpjIuXdFMaPK/Xsi1fM8pgH/K/iMS0g8pTG3e
         J2nzXTXS9xR9Gs3zvIwoNDsTYz1mCcFnsEQXvZi94dOWdNLvrI5JhWTfq0BE78F+M8Iu
         mLLNbo6GGjCAZatw0JEbInW1gpxZ14wCDAnjdmSTrXnmnUqSyU/E0b0ts9ljs4YroxtC
         ylQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782174416; x=1782779216;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dnnvmp3kEWC924WaK9RNBF9LgizMYwDhSueWIubs0Ho=;
        b=dm3kb6tlkbPlFz0kdcrAbJLZ6oLeJpW3vb6iJDXUwqtR8Wq8wK6TSCIH12hz4pgHOD
         1LG1KzIQ1FRpNriZ0AQLLjSew+sGD/Wk2wIMskVOivFAZOzI1Wb8iTqW1fpx2EhAsg1x
         GQvks4WZLMaWX8l7y9s6GSB0l1JTLIGJHGuOPSYvEdWMfV38ssAkBHI/mRPFOK5zRFDF
         SAGMahY5TT6IdA3aR0AltggUT0cJGrZnath/yvFC65FpkF4uMGazD25awQS+LsVDC5z8
         s32ZuTBSfYecXszpC/SNdrPdNKDrsC0NGBc6P7uA/k9wcgM6oeqlQ9CQlIM0h7PRQiK9
         KMsw==
X-Forwarded-Encrypted: i=1; AHgh+RqFvhmFRFyYQ5nlSspyFnNnkfPrJas2xmlGjYtimJswJzodzHq9Ddk1UxH7MZXtjeYtt5+N9w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzl8C1AMWaxWomgUeEcQ5lALKm+xCmXOenR5+CCr4oAuyawzKPB
	9H1inzOEg7kFmOup//wohM9yY9ASmpUvy09rHi8j9ziM4djB3JkR9K5xyg91DWJnSw==
X-Gm-Gg: AfdE7cnh1GHBZk9e/XhSFloAOK02zOVwlG9fPKHjZwnNCuavPSxT6vgJs8A34/NmPeE
	rW2PCHHD0Yv5/ot+ktwwwYyIhhRDMlXl2b8kz6Z2eALXIBS4vw8O1iy777jqOJNXB7uqiq7fuo8
	tQttaT7vW3WTMFXAeSGwInlL01O+J1xG8j1XllrUjbkEoryV7aSZUY2gFl8rVE0YzoGqPSd4hYZ
	qM+Vs0+CA6X8+7IMvtD+ooAXDsQIrmu3hEWqhWS0gvmC6RK2aKxi9/GT/AHYlvPl4hHIMEhAiGN
	EORcBadEUk92Z4No9fOGwoVM5nFOdbnvc7norXphR0D6aZ6afBlAJB6jE7MwxG2WW3oaFODtBGs
	9ZhoOSBJiKVEHUy0Cbi8qJyjkVua8Budo+blbheuAEFrAr12FvpbOo105Is2yS8c8MFGnhreXGO
	MkpFPB/F8MvVMwuWhRPaxWBWsYh7XmxV/btun9BJ4YlZhp0MsoQoxG6+CC0uhlnlOtJ8Y7/N79v
	vulXw9M
X-Received: by 2002:a17:903:2c7:b0:2bd:63cb:c5be with SMTP id d9443c01a7336-2c7c7067d97mr672265ad.5.1782174415306;
        Mon, 22 Jun 2026 17:26:55 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc563c6e1sm8052094a12.15.2026.06.22.17.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 17:26:54 -0700 (PDT)
Date: Tue, 23 Jun 2026 00:26:51 +0000
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
Subject: Re: [PATCH v3 12/18] iommu/vt-d: Handle reattach of the restored
 domain
Message-ID: <ajnGMjFxhNCbW0To@google.com>
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-13-skhawaja@google.com>
 <01f53c50-f585-49a0-b7a2-fdf002049aea@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <01f53c50-f585-49a0-b7a2-fdf002049aea@linux.intel.com>

On Mon, Jun 22, 2026 at 01:44:06PM +0800, Baolu Lu wrote:
>On 6/15/26 07:37, Samiullah Khawaja wrote:
>>Reattach the restored domain to the preserved device using restored
>>domain ID. While reattaching do not setup the context and PASID entries
>>as those are preserved during liveupdate.
>>
>>Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
>>---
>>  drivers/iommu/intel/iommu.c      |  46 ++++++++++---
>>  drivers/iommu/intel/iommu.h      |  17 +++++
>>  drivers/iommu/intel/liveupdate.c | 111 +++++++++++++++++++++++++++++++
>>  3 files changed, 163 insertions(+), 11 deletions(-)
>>
>>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>index cd40e274482b..91b67ccba011 100644
>>--- a/drivers/iommu/intel/iommu.c
>>+++ b/drivers/iommu/intel/iommu.c
>>@@ -1311,10 +1311,16 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>>  {
>>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>  	struct intel_iommu *iommu = info->iommu;
>>+	struct iommu_device_ser *device_ser;
>>  	unsigned long flags;
>>  	int ret;
>>-	ret = domain_attach_iommu(domain, iommu);
>>+	device_ser = dev_iommu_restored_state(dev);
>>+	if (!device_ser)
>>+		ret = domain_attach_iommu(domain, iommu);
>>+	else
>>+		ret = intel_iommu_domain_reattach_iommu(domain,
>>+							iommu, device_ser);
>>  	if (ret)
>>  		return ret;
>>@@ -1327,16 +1333,20 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
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
>>+	} else if (!sm_supported(iommu)) {
>>+		iommu_enable_pci_ats(info);
>>+	}
>
>Instead of merging domain restoration into the attach_dev path, how
>about adding a new callback to restore a preserved domain for a device?

Even with a new callback, the driver still just fetches the restored
state and takes a different path. I am guessing we can just do the
following inside the driver to keep it clean:

static int intel_iommu_attach_device(struct iommu_domain *domain,
                                 	struct device *dev,
                                         struct iommu_domain *old)
{
	struct iommu_device_ser *device_ser = dev_iommu_restored_state(dev);

	if (device_ser)
		return _intel_iommu_restore_dev(domain, dev, device_ser);

	return _intel_iommu_attach_device(domain, dev, old);
}

This keeps the separation you want without touching the generic ops.
WDYT?

With the new callback, this check is just moved into the core inside
__iommu_attach_device(). I am concerned that later down the road when we
add PASID support, we will add restore_dev_pasid().

>Something like:
>
>diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>index b2f614367074..e61409f2d9fc 100644
>--- a/include/linux/iommu.h
>+++ b/include/linux/iommu.h
>@@ -748,6 +748,8 @@ struct iommu_ops {
>  * * <others>  - treated as ENODEV by the caller. Use is discouraged
>  * @set_dev_pasid: set or replace an iommu domain to a pasid of 
>device. The pasid of
>  *                 the device should be left in the old config in 
>error case.
>+ * @restore_dev: Set a domain that is restored from the previous 
>live-updated
>+ *               kernel to a device.
>  * @map_pages: map a physically contiguous set of pages of the same 
>size to
>  *             an iommu domain.
>  * @unmap_pages: unmap a number of pages of the same size from an 
>iommu domain
>@@ -772,6 +774,9 @@ struct iommu_ops {
> struct iommu_domain_ops {
>        int (*attach_dev)(struct iommu_domain *domain, struct device *dev,
>                          struct iommu_domain *old);
>+#ifdef CONFIG_IOMMU_LIVEUPDATE
>+       int (*restore_dev)(struct iommu_domain *domain, struct device *dev);
>+#endif
>        int (*set_dev_pasid)(struct iommu_domain *domain, struct 
>device *dev,
>                             ioasid_t pasid, struct iommu_domain *old);
>
>Thanks,
>baolu

Thanks,
Sami
