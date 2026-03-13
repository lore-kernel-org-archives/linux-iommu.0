Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586B93DE444
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426849; cv=none; b=FQXZTo5PCAIOztxoXejBFSDz5zjqTQ8hfBWtKLjIvWAJL+tfHSPzHnk6/zlYvIZCV3A7R6qrlPf+DyKIcS7tcbwVqXHv/aBOTvSQekTW0Tlx0KgHU2djQObT1jZSIrABZ1rIHFBpM7XUT5++I0334i7MOeuzqVTYMyz7IYsthfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426849; c=relaxed/simple;
	bh=ixTPhrH4yxjOjUAI1IZHEE8s/TP9E8YXfjx9uEw6cE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hY8D5ncMuTOBoxBbeoneLluPSXdShoAXLoQRp1uypZkUWdaHF6607v8As0S6dbz6VHbGnW8IGouaMKUeEsY0nroa2XUg6rJe62V4N5sHe4v+8ORNcyqb8L2Qjyep7eFYfezFETy3fctyqnqvwn65EU6ETBP1kOIJm0Awx4LGufE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ajVwyTUr; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ajVwyTUr"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-89a465bd7edso19069296d6.0
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 11:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773426845; x=1774031645; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ETmpjYkPNXw5/q7d3Ssx+upItrwKqh5NDijfiDruMZ0=;
        b=ajVwyTUrvJzp737bTwnag3qGPvsc1BxBJye1lOakfPkw0KmAHM4YVdqHPS7LRahJiI
         s64iB0KtGzhmjjw8xCMfl79As9mteaMQfI0a+tc5TNUye0BSw75Km7bNXJYjUPuragtY
         9HzUYnLAIT78fMbrvu07Yukn1VybTdytDixBjBNwmlU7KQp1sh7gxj1usJOgcorxZTbF
         ovQMjTpjVQ6Nrub6qYvqenRgNJ00C9I9oOvdpKvtIgaONdAYDAQXy1u1p9XyXcFItKff
         Nau7KDY/2hjbKlUo5irvzeVi0fmLwn+cSprotuT2LdOXSXFv7lJjNWTe2KVBgCTCzSoy
         y2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773426845; x=1774031645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETmpjYkPNXw5/q7d3Ssx+upItrwKqh5NDijfiDruMZ0=;
        b=QSAS7oaMC7qq2jfher4+aBimwerW2nnAh1DI63qppMfH889/eI/2Z3gQPVdN5sFEVH
         vVVDD7u1RbrW2l3CFx/bUl24+m76iMflxrOCzEYSnJygZpL5ePJozGb+WM8zIZgAswGS
         4C+XAof/NVAi6+FK/jFEAfbvZWojYm14uQOqSTSZwkEo5ldlRdGPcMjS7H4IVcldRmrP
         n77ell2kcytRrbF9G7ruwkdhcJurqgdrIV3ACp2FcpJhwcv6FRv23zXjpmzRrtt8KSoE
         LTV3O6g7+WWJ4eQqfMzNx56botf1hvGnK3/bZHKrjUqKd+iBbyZA1ZEO+25f9jm7C7vg
         nvPg==
X-Forwarded-Encrypted: i=1; AJvYcCUSi/XLdojFgQIoUpgT5pRrYuAyasGgHSWmRGl2lHi5l4CmKnPSnM8kSXa+2bp0NqQc/qkGhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLDdiGEC0LhHEWKWddwW9a9M2oFN9lOHFhr01C1qWwWNkE7Qcy
	U30njsFWt7l6xy8R/6Zmj6yBl0CAJu9tvWcn7T7Eod2US7yJZwjZgvdA+En8scMhldo=
X-Gm-Gg: ATEYQzy4P1HZpPpuEJwqshpH0N/3UWwoFQr+3YcajWal/FZ8pxS7TPw+ZtYnEiWGZ/E
	vLIelpDif//YOXmv7KYY7mmHbCEukcQsUG+uXc++PYfkzJAp7SCsMaD8nJnwu+GXyBhhIUhCmA6
	e0PrCKwmTfx9+e5J7pHoH0YNfPhLtISxbJ4PB4mPI+FmbFGL7UJmgaYY04IUeDYhacV/XzSuX8T
	2I1AmpjkQ85ocrXaeUwDVdlacEGOhyZunk5y/HCJuc8mMhCV98gRQ62KbjSnwJc/A/5fOPmSmmt
	ydRQyLaNtwrY8S7MDWxtioAdlEgoeTq9uo9py6SVcdFVAhGnIj74DPK2BD72wXLUcAu4v2XOVV9
	GqtxEoSLl5Jd43FsOTFsGRWog1S/BK0puX+yMWvlC6nRzA7gEDOxj1Z/5TUiUEi/EjEZFP8Ij65
	bzwdTKvS6+s15Qf/YyBNsqytKkj63pFLYHQYv6mbmf31FzlNTlihulrHGfy2ZvN/v4BJ9f36UD/
	Rn/bxat
X-Received: by 2002:a05:6214:5010:b0:89a:502:6060 with SMTP id 6a1803df08f44-89a81d4cb1fmr61055306d6.25.1773426844964;
        Fri, 13 Mar 2026 11:34:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65d0289dsm58661806d6.40.2026.03.13.11.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 11:34:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w17Kl-00000007Lsf-2UJ3;
	Fri, 13 Mar 2026 15:34:03 -0300
Date: Fri, 13 Mar 2026 15:34:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 1/3] iommufd/viommu: Allow associating a KVM VM fd
 with a vIOMMU
Message-ID: <20260313183403.GL1704121@ziepe.ca>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-2-aneesh.kumar@kernel.org>
 <abOrdFR4L2n334MR@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abOrdFR4L2n334MR@Asurada-Nvidia>

On Thu, Mar 12, 2026 at 11:15:16PM -0700, Nicolin Chen wrote:
> On Mon, Mar 09, 2026 at 04:47:02PM +0530, Aneesh Kumar K.V (Arm) wrote:
> > Add optional KVM association to IOMMU_VIOMMU_ALLOC by introducing
> > IOMMU_VIOMMU_KVM_FD and iommu_viommu_alloc::kvm_vm_fd.
> > 
> > When the flag is set, iommufd validates that kvm_vm_fd refers to a KVM
> > VM file and stores a referenced struct file in the vIOMMU object, so
> > later iommufd operations can safely resolve the owning VM.
> > 
> > This is preparatory plumbing for subsequent patches that bind TDI state
> > to the associated KVM VM.
> > 
> > The patch also switch file_is_kvm from EXPORT_SYMBOL_FOR_KVM_INTERNAL to
> > EXPORT_SYMBOL_GPL so that iommu module can use that.
> 
> struct vfio_device has the kvm pointer already. So, I think it
> could be forwarded from VFIO side v.s. via userspace ioctl.
> 
> Shammer had two patches before and Jason partially reviewed. I
> took those for a side project but haven't sent anywhere. Would
> you please check if they for you?
> 
> https://github.com/nicolinc/iommufd/commits/wip/viommu_kvm

That looks pretty reasonable

Raises the point we should not allow mixing kvm pointers, so no matter
what the vfio, idev, viommu all need to agree, and the code should
check that too, eg when associating an idev with a viommu

Jason
