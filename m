Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A463DD52C
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426687; cv=none; b=oniAZFkYQkIArCChnPM63SyCDf2RdrGIuikZxBnDEXQdZZNHSaSAkVhamsTqXKrbvH5sUFdH+Gnl+VQqCfkK5ATFMeErmnqm3PQfJLJN6/FJLiXfEdO4sjMRZvNBxRKgddhIIo6Wx1CS6RKlmjt1K1qBxE3kzKZOwnPObEx9CNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426687; c=relaxed/simple;
	bh=0qxNb0CImZ7Y6yg+F786kCKDYDie+t88orCSqmVuTBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q06mJj3KKGkPXwS1SdInvqSpYwwRYFKP2OtXX4f5UJahXA9imxDfPKmZxk+2XVYicDDpoDKSU60ezpIV/NGtn0g080b4jeWTOlpDEWjhewW2M05K7BYulwCZUqR0PJHP5WV0UQDiWTquGXxZtQTFuzBUtDEbN7PVbRO1r41A918=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fX09w0lW; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fX09w0lW"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cd7ecedf2cso255806985a.3
        for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 11:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773426685; x=1774031485; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zQGCXWZbNaSYnb2f/K2OJx848xGu9ABhmecVVHvXBkw=;
        b=fX09w0lWkrQ3wbdI4TTvaTym7d5MtSBYKsP1u4amEDL0OXpsaha1Vm3txVuP6efgLb
         +vKPZaNAb8u5hox6tN6mb6WnqYSmduMdWP45yU+khaXFjAdCxu1FBcV/1F9Ei4S0G4ya
         0hD/cR2czbEOVMWlWWreKRiPBtiF/+r4aSJrC8YRf0ADHO1kwCsFox1ogSs+boSL23id
         SpeqFs5x/L1+P0f0k5gBlS9vazxE1YnkEr37ikJ/0IF9qDtz0SSkYVb/284mM249cFoE
         zW1yqtj5nWaHACKOkrSPe7E1Nhr4F9LqdR4VRv6awiHS2Pv2iXVbd+htRWz5sZsdu12q
         FXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773426685; x=1774031485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQGCXWZbNaSYnb2f/K2OJx848xGu9ABhmecVVHvXBkw=;
        b=AtH36a8HFtRsd5UcD/EEaVlrwC2NlQEDvXh9BAHcGb7JcWtymSelbkv1dM1+9Usa1x
         mQk+ZGCLRTHziMKnTP0Kvqg//Tys5hQmd6iE6KcAzg+lBu+gvdu6Z+ptaW7ti5mN6hQf
         VeznIx3MrQT4BvM9LAcvcnHjNd7FeaPEWar6x6SZTGEa8/ceyiVXhGY7Qve/24H+HNGL
         nQE0WMSW/hFyCTBClVi0M4v3sZGmsgRF3eUXqX2kJFz3tQ4bTW612Uv2ZcheoPXYXHBP
         0z6Bfg5cmOFeQQLFEHvvs4Q6ImhA/xYprcDA0egIZM183mvEyJPHW6n7IUUrja2Ah+bz
         XGwg==
X-Gm-Message-State: AOJu0Yxqdx2TjSb1JkQvsnkrYFLc4WV0qRxMQ4261nunFpOVapOiDot7
	C5JYSGbUDlPdWp/2tm2mv9wAcnv7CtZGQAP3a7h7feH0wXXd4IruUWQZGkSotT440mE=
X-Gm-Gg: ATEYQzyB1fL2tZSFPIIoC043/ac4ZGtuzZSp7P5u4ctYt/hNYntgEfX4KOsW2on4Iew
	o0jcnB/+9/rbjhU66eSX+hWOo67zAVmqNZmmmYpqo6rvMqVKu5wbrPH+YjC7QOlYO4u2IKUZt3r
	/qpUW/xjcUW+cnV6gQCBuvYTt00ZmPgLX97P2SkJ6CSH9ciI7jEFlNdnf8jLy1ZjrPMFZ6iWi2r
	DWLcyH9VMAbPOFDBMFOMxasJOAyPVLtOoiXsjtHEp1ASTabDhp04oa7B7mNxc20VUYI3no6TsjY
	lg9mcbukXMe38stDPa8m0ZI5CqNWKe+S09Mf1Y1yR7N0S/hFEfOi85wXbb3GxHm8zOg+RVcuzNG
	jnaTQ+35jPWPaHFwQ7OR5NsashmZMtqdZlf8yDJ9w3RNAbCh0EIHkivA/LNBgC8B9m+W/ngH4Ym
	kGr+riOhY5FsUBTRfcmEtQRqNWW+u397IFxG2SDPCDS6u1E1qQvPZEImXTyN8K0sxROWeBmP03f
	EJ0cPzk
X-Received: by 2002:a05:620a:254f:b0:883:c768:200a with SMTP id af79cd13be357-8cdb5ab3617mr580862385a.32.1773426685412;
        Fri, 13 Mar 2026 11:31:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda2152a41sm611787885a.43.2026.03.13.11.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 11:31:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w17IB-00000007Lp5-3hF7;
	Fri, 13 Mar 2026 15:31:23 -0300
Date: Fri, 13 Mar 2026 15:31:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
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
Message-ID: <20260313183123.GK1704121@ziepe.ca>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-2-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309111704.2330479-2-aneesh.kumar@kernel.org>

On Mon, Mar 09, 2026 at 04:47:02PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Add optional KVM association to IOMMU_VIOMMU_ALLOC by introducing
> IOMMU_VIOMMU_KVM_FD and iommu_viommu_alloc::kvm_vm_fd.
> 
> When the flag is set, iommufd validates that kvm_vm_fd refers to a KVM
> VM file and stores a referenced struct file in the vIOMMU object, so
> later iommufd operations can safely resolve the owning VM.
> 
> This is preparatory plumbing for subsequent patches that bind TDI state
> to the associated KVM VM.
> 
> The patch also switch file_is_kvm from EXPORT_SYMBOL_FOR_KVM_INTERNAL to
> EXPORT_SYMBOL_GPL so that iommu module can use that.

I'd want Sean to approve this..

But given we once discussed it is better to hold on to the file * than
the kvm as it leaks less kvm stuff I think this is the right approach.

>  #include <linux/types.h>
>  #include <linux/xarray.h>
> +#include <linux/file.h>
>  #include <uapi/linux/iommufd.h>
>  
>  struct device;
> @@ -58,6 +59,7 @@ struct iommufd_object {
>  	unsigned int id;
>  };
>  
> +struct kvm;

That is a weird place to put the forward declaration? How about at the
top of the file with the others?

> +/**
> + * define IOMMU_VIOMMU_KVM_FD - Flag indicating a valid KVM VM file descriptor
> + *
> + * Set this flag when allocating a viommu instance that should be associated
> + * with a specific KVM VM. If this flag is not provided,
> + * @iommu_viommu_alloc::kvm_vm_fd is ignored.
> + */
> +#define IOMMU_VIOMMU_KVM_FD	BIT(0)

BIT isn't used in this uapi header, lets not start.

Other cases are using an enum to group the flags

>  /**
>   * struct iommu_viommu_alloc - ioctl(IOMMU_VIOMMU_ALLOC)
>   * @size: sizeof(struct iommu_viommu_alloc)
> - * @flags: Must be 0
> + * @flags: Supported flags (IOMMU_VIOMMU_KVM_FD)

So you can say 'see enum xyz' here

> @@ -1105,6 +1115,7 @@ struct iommu_viommu_alloc {
>  	__u32 data_len;
>  	__u32 __reserved;
>  	__aligned_u64 data_uptr;
> +	__s32 kvm_vm_fd;

Add padding to keep to 8 byte alignment


> @@ -5481,7 +5481,7 @@ bool file_is_kvm(struct file *file)
>  {
>  	return file && file->f_op == &kvm_vm_fops;
>  }
> -EXPORT_SYMBOL_FOR_KVM_INTERNAL(file_is_kvm);
> +EXPORT_SYMBOL_GPL(file_is_kvm);

Probably put this in its own patch 

Jason
