Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F5C37CD4F
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217333; cv=none; b=YjYiWqXBRDJJetGDCoNGsfq8Ks5HtAQaB9CLjvzhnxe5KOwIQLuE6ctKuXENekEchnRLLlyWPJvT7P22G56tPu2tOirb248OcJElTCHDo/8dCv+jENTJf1qd4TzKpfNdIH4/dmwcsvnAwxs76Pygh06H3cBtwsgwoT8wpjf7tl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217333; c=relaxed/simple;
	bh=HtyRYeO1F1mHvikYxkPLNdLupXC4fBREsTuVb8Of8Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umbqNfkuvHCyfJS7YSfdVJB8qfM57CdSuVBpcM2gYhh1gYJAEUgjxciBZZEvroQVE77l0GLou1g6tccsBcZVMxztfFkMj5+eXTIszsd7avZWAULYqA1hhZDXSto9shM7dRVaDWqsiHszv3vGVekvYCg242cQTqY6239MuVp9dXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n2wweldF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n2wweldF"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba180a022dso15ad.1
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 12:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779217331; x=1779822131; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rA3l2l1qf0c3PJEWCBDErkIAF/hCSQNHn0RYU9kZx5g=;
        b=n2wweldFohBWLaRvum53eJl987n0sZopbkkDoj8PeKgEMzL1ScBxwOG+OmKxD/HqA6
         Bv1LndRL8xgzRmlZgEo5zH0Q/D/ybvh7OX2LrA7kXmkcwRlbzUCmsaiQlDAwtwobFP2q
         o0Ndmb82fXNdt9M8d27vhpt96VIib+yAIFPJBfl80cD5CU/iffBcfvQJDQYlNy1np+St
         0tz+4rRqommomdQo7sVUItwC0Tkp778XApUwqbX5cFSLyF2OM+Xz56PswO0vPhtxwKRa
         grDr3X3ezUs7Ck9tacpC9Loms20jhzxXdzhNsz1h3fTFZSo5YEe3rVC8+fLMyf8JY0zr
         6G1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779217331; x=1779822131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rA3l2l1qf0c3PJEWCBDErkIAF/hCSQNHn0RYU9kZx5g=;
        b=NKUXHLs93iexzg52lJ2/hyr9qZZ77T/Yt0Zm8gKbTTdMqZ/k47/6rYAFY+gcZpO2QF
         hZ17tbkLSWowSk8GKlvWksodoxnrLgtb2M4KuGi7zzIkEqXOqg1jiRNK4ce+IAiC60Sl
         7frQSyVdUI+YNU+5jAIlXNw3BIwzD/dpOfMoLJfRXgfzfY5wofpP/bEenGtoXKnTPowu
         YKB1l5ThQjXsW861CUNmYQOdexjUAAbrHVfDK9tOFya1x3OiIK2LNCYC2OObioFQt682
         XTPXhi35F7VbDvQhaIDuGEbuZF1Rq480KmdWYE6wn5Lb3YkAvvVMpuRYnGqtsgQ7q+xT
         HegA==
X-Gm-Message-State: AOJu0YxnOMlMc3lxZOd7RSillMcgctOuT8Qy6nZiQpxh9rxgk+/Y/rSn
	U8AJNozKiZttF4pWYj4K/J8UZLR14c8L5k6r2lw3cNonT4nZk+tz2KceN/0geeK3+g==
X-Gm-Gg: Acq92OEWCngI2ZCFl2h7QLrIQZkbCQFdOSfX+JSbBu6XF1SbVxodaTqZ0jQw3J0Udmv
	RjETli+Wfa6cyyFECi5RVcSNDzvVp0VXwDh/DtM8/kAG6arQ1N/TjYuqMnvp9Ara/gbzDC2IkXu
	mF3+xyWoaEPrY8LQuIyMw8PBj5WBdl5PmUUWwn+BGIpv5QjPULUSoUZeF5UPjxJqh/xCWGKzh8X
	HMvgb+CHoI5Gt/QT+VtZV1yxuXshUZNo+N0wA/vB+uuPi8sYJcwrmOF6frMALr1LsPqHHN7+/za
	j4fY5Ldq6GVjkBQL5Ldaw06EQxa9/ZEoe5IgdF4HrRjLFEv7/KogrJfhofGfQzzpbceytiANWUA
	Coe+FOv1fZDx4YTPyJUh3XuBEcC4l/iBu8Ip95v8wTGyIjELvIzMaQiBJv0r+9hGpuBbWqAO2uI
	XfyA05EVID1hyOnKkMMUIZlp31VjMbMjAc5t1REEVUSuPx3BVoUm94hBaFo5rgKCFH8J3shg==
X-Received: by 2002:a17:902:e788:b0:2b0:b0c9:96e2 with SMTP id d9443c01a7336-2bdb32c0349mr6198875ad.21.1779217330325;
        Tue, 19 May 2026 12:02:10 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19664220sm17245650b3a.4.2026.05.19.12.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:02:09 -0700 (PDT)
Date: Tue, 19 May 2026 19:02:06 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 1/3] PCI/ATS: Ensure pci_ats_supported() is PF-aware
 for VFs
Message-ID: <agyzpVjLtxgr-BFt@google.com>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-2-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260519135323.1558777-2-praan@google.com>

On Tue, May 19, 2026 at 01:53:20PM +0000, Pranjal Shrivastava wrote:
>Update pci_ats_supported() to additionally check the associated PF's
>status when called on a VF. This ensures that PF-level quirks and
>untrusted status are correctly propagated to VFs, providing a robust
>support check that aligns with the kernel's PF-centric ATS configuration
>model and is immune to the timing of VF-specific fixups.
>
>Signed-off-by: Pranjal Shrivastava <praan@google.com>
>---
> drivers/pci/ats.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>index ec6c8dbdc5e9..a5fa7745bce8 100644
>--- a/drivers/pci/ats.c
>+++ b/drivers/pci/ats.c
>@@ -40,10 +40,13 @@ void pci_ats_init(struct pci_dev *dev)
>  */
> bool pci_ats_supported(struct pci_dev *dev)
> {
>-	if (!dev->ats_cap)
>+	if (!dev->ats_cap || dev->untrusted)
> 		return false;
>
>-	return (dev->untrusted == 0);
>+	if (dev->is_virtfn)
>+		return pci_ats_supported(pci_physfn(dev));
>+
>+	return true;
> }
> EXPORT_SYMBOL_GPL(pci_ats_supported);
>
>-- 
>2.54.0.563.g4f69b47b94-goog
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
