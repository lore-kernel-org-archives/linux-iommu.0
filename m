Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04F5369D45
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567546; cv=none; b=bdQ7u9uI7rFgm6YLsf0dOyoge16PlTJ0Ltjnyo2z1X23Qxu0gaS3g1MpCe7svY0iXD6+rk+kvSLlzZI6u1XXaJvI5hSY5YeaqdvluIppo1/ZXEhUfz6/ptSzkUbUfRFXvX9YLjtfuxjJdpPL512hnQ5GnnJLGrBiSrIBN3Yfhmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567546; c=relaxed/simple;
	bh=SOt5i2BywBkXFWly41PQ3BQqKk6IVCQhp/5l3Wfdr+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCQiDCdx5j1pzY8Hogu5MBIeOGd8bh6khTwe823ztugkZwRb4EOOuS0UmIao0chBo/zJo9mNuGzpBMfMFutinITAye/xL5wlj8/6IHJ9bfRMo8cV2cx6nPwOxjiwx1T30iA25bxLB+tWkdbu+1i2JzhvxCCSDpugcTl3lXHEsDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mt4TxIBp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mt4TxIBp"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf2d865383so13355ad.1
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 16:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781567545; x=1782172345; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UbKI26CmQkmpXGjuaVtHQErivgQSDI5Xz1YBBq2PiBs=;
        b=mt4TxIBp514cYU4uX8Ml1lbpWrmk3+oeAzwCvpi5ldMLCB3oSRPREjptRZshVPLXom
         1nkD/YCBf8mr8A5QbY5KwDIt1eEzgnNyglGpSB8dxN0fR8JPtVbxF2/x9N0HvrhWoFVi
         qFg1zMSg9oAvFhOhqvG6rYD4yv+SDSEmffK8fEZP6PAa3zIVYHBNfA9Js/AbGpSfrErt
         vvduWfEvd0GOs5qC8NDJwP7fl0x2d4HqNPIi93YDvf+Lj/GoZK8a6nq5qCG6RBaGj0DB
         eI/RdCIfrbaeS2pOCc4C4NfOBCchI7LCzzoC7FMsuC5I/F8RHDzP50hmAIqPy9UJMLag
         vX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781567545; x=1782172345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbKI26CmQkmpXGjuaVtHQErivgQSDI5Xz1YBBq2PiBs=;
        b=JTu8QpSk4bU5xUzIa1oU6U5oGWiVMIh+eejFx2TSAY9OUAzt9LUtF5Vri0SmA26Ts4
         YGk3JXZuXQmmqX1vh3TF+oUYQnE5N3TlZwxpkHWO9dTbwN90TFeIEVJhO9jv1T3KXT8k
         FcIHv5IHt9s3KwQD54F32ky80q5qywEDAZz3XudG9bu4eRrdDQ8FgbvKmyY4svouSAK4
         UCkRAXiB7tCZAjKggKBFNfaZwqndif0j5kohavwQ42cbNDuMdGLxU2rL45u/BWH6PeFI
         z1/ckeu9IfRrl7GDDJj5vxKDrXWFJBpKW/kSUAcGXH5/M9fZ0EGwSeZ9wUPhYJuVyx4h
         kpZg==
X-Gm-Message-State: AOJu0YxlB1WLkvnMZuUyn5GTPGiu5dNiYIyvudTdRuLNtDVomH/tT0Wx
	HnXlTT3jyZBtZpA0bvwIfPDWP+ho9rOID17NZSBjc9nZb1aRGIrbDLlYCCivpuu1uQ==
X-Gm-Gg: Acq92OGB6fpgr10MBKJYIr3a7Eia8X4m0RrVuTcLAPcrZXYfr9uz7k0FA2IEvAmsutD
	V2WZNhdaEODIsFX1Wtlt5NNZW8VkCsZYaFa5Pv1HpLtKFVbTm4nQZml6rWW2fZZ1Og1HV4HhBXM
	P7luBe5oyNcLc0YayCE0zCIZjqvXu7TepAozBN8ogisjowFsxP1pq604uZKSn/RY5Aj4+KeioFI
	01ornfWLhCq8ZYFbUVNFdZXBT1xbpaCxdD9rE5sjJzuwMxRWj2C4+lm85Nnbq0Tbemz9gosnkCb
	XU6zKwaCgTZsiydI1w8EBgu9X/JPs77gOEQS4QwIA3qAxRP1B9N+rwEvtKSJW0gMpLBJu9s9QT7
	YM8WO/1k7q8lJ5lpu3lof078x0eT1LumwkaSWuFdzgJ/IrRrqTJgJD/AADfeL2sm8RH0hrqQ4+r
	Y5jZW6EkwYZPkTnteNJqWGaSI9ejSpTxk3vNq0DKK5V733q6RyR5ydhpRQDHc4
X-Received: by 2002:a17:903:1a2e:b0:2bd:6dad:7ccd with SMTP id d9443c01a7336-2c69c30a638mr593135ad.25.1781567544491;
        Mon, 15 Jun 2026 16:52:24 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc9fa8sm11601182b3a.32.2026.06.15.16.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 16:52:23 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:52:18 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v8 3/4] iommu/arm-smmu-v3: Standardize ATS enablement
 failure reporting
Message-ID: <ajCQMhErQ8TdFDmY@google.com>
References: <20260604182116.3179005-1-praan@google.com>
 <20260604182116.3179005-4-praan@google.com>
 <20260612133638.GG1962447@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612133638.GG1962447@nvidia.com>

On Fri, Jun 12, 2026 at 10:36:38AM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 04, 2026 at 06:21:15PM +0000, Pranjal Shrivastava wrote:
> > Update arm_smmu_enable_ats() to wrap the pci_enable_ats() call in
> > WARN_ON(). Since probe-time checks now preclude configuration errors
> > any failure during hardware enablement is considered a kernel bug.
> > 
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> > +	 /*
> > +	  * Since pci_prepare_ats() has already verified the HW capability
> > +	  * and programmed the STE, pci_enable_ats() should not fail here.
> > +	  */
> > +	if (WARN_ON(pci_enable_ats(pdev, stu)))
> >  		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
> >  }
> 
> I would fold the dev_err string into the WARN though

Ack. Sent out a v9:

https://lore.kernel.org/all/20260615235037.259909-1-praan@google.com/

Thanks,
Praan
