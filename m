Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820702;
	b=KACBBHpaO6h2n32h0f/NcZRz0oYrbTVdNXObXf5hgSgc8uE3gMpa96vKOPvOXBVsA2QE
	 qU/5cAda7NOvneB1h5AC1Jia4EcAYyPVHv2V+k0XgFyKckhy8hTCuSBY0CRi3ZkvUw6Xr
	 Wz0hhse674YViPhQb0TAnr5DMA7iqhZttx2UzfyZqzjNehN+trhw+waEOdjjL6LlWLsf+
	 uE+kCZZhB/FvWGUfggX7AFCjuygU9X/GHV2n6lbj4yrMgCe3VnIFNEoWtDmmiedkow05C
	 hgf8s5LeW7f/w2B5q0v4TTeWDig9R0ETx7rHUx2fphOwDNNIuVxwi8v+yQHAKVu06fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820702;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=U6VmJzWY8/ktSu1tEfSH85YFZcsMq7VS8KWsZUWMCkc=;
	b=sEHGj8mfVD8/guwbeIhDsmYXb4JA6TIeZbQotGHBfAbj6SBM9jySymvvk3ld+DUD733/
	 qlGH4Pm4KcIRcn4W3uv5bc+6/TrBCu1zzUaXAGkg3qZ/NMizS3geDFFqoJBPwdXX9KKjr
	 jiaNiEyIDuyPz6C+e5bg9rmlb/XPyFWHHWziQUaSKH9CYw6X7JD0geIhSLFg9OC9KiHnh
	 Xg88U4eOu+GWabqzgHEQS26gSnbuBKmVarosLHmIsJja2ocXjRfOXg90nzuxuyXcWmiaT
	 6st/LG3DQ1Si9psyVJ4MZ/SfqQevQRqeVOl8e9ym3E5AHH43896gl+lwQ0ptNz1SBzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=aZF2fgHy;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA66607815F
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 19:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CA66607815F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=aZF2fgHy
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-930c0f9c1b1so110929385a.1
        for <iommu@lists.linux.dev>; Wed, 04 Nov 2026 11:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793820700; x=1794425500; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U6VmJzWY8/ktSu1tEfSH85YFZcsMq7VS8KWsZUWMCkc=;
        b=aZF2fgHyE9mnvl3X61e2VkPAHfCrMPOYdf5ZhTibRly+mKA/yoqmTwxaXAme/LnatB
         U330YTlRa0eLsuh43WR+VsEFLuqG0Wm6nrhzwZcabJnen5PMk4ajZT1qSDw4S+qA4Kds
         pEhUCts9uYOBN6QiIb++T9QJiOMjWWepwmd9hXBA/DfEXusvFTyJiZfolHwdqqUPTj4v
         ICON4Bpc/+Y4G1AXsvBhL9RrrdDeM5V6MZQkQ0ggVB5Rd9CEDrz85HO1vIGPN10kMl6t
         6X3bQQd5UWPjDTsYMhGZR+dabKwDz9WlIjfaRNPWoRWsXpp/s6xXuwjv82eIWJT+UxTr
         tCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793820700; x=1794425500;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U6VmJzWY8/ktSu1tEfSH85YFZcsMq7VS8KWsZUWMCkc=;
        b=gkSVr5BU/XQN0iRu2z/2rwyYaWkX28Be68lEy+pokWHAlj/97GDf3bzX4tDdrd0FL7
         9NLLHVqsGUh4uXD+CHIX8R8iNWN+5EG54FLODtKLh/Od0N20YA7SHxgBJcbP5w963Vii
         42CA+5s+7O0dvLw+ZsUZBOEAvdyseCJlTm2tC5tE17L9utW3HKHD8epMPC9vtKu27keR
         NDUjzN56/dFu8XcZA2H7S64G1GwoN85PdShfQusQWY6rGwIULFqmbRHrrMnZbqqWysWm
         pPOa2Cv0jsl7TPY5s6BSd4joavD/EIdggbJNYNR/TNBptmQZFk550LRd7pC7k7FGtWEX
         kNgA==
X-Forwarded-Encrypted: i=1; AKwUvBwGUq6swV5JSyPU4vzAkinwTHS1l6z8I0C2cBG1PEkfJXFr80lziUBNaqLKgw9zHLmYh1kSwg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9wz5rqZiRc2ogDVh+m3fcI7hpbNObXrGgg3Q3FDq4+vMyUVi7i
	Du/iHOecpqN/+L20wfeqS7ekCKQC5RcX9NvImHetInFTpP0K5sru6N6pvSBEMSXJXaE=
X-Gm-Gg: AYBFou2gO8f+rdL8f+GypuRpVMtllPDtqRYSNpuztS0v3M9OI+dhXfqPTq3/YtXfnLr
	4pHbeIvEu7nPQG8un7WTLezqw43CAnWn1wFY3XMW/EXhpofZpv0e9bWnlu3LH21xvirpmkucCF6
	z7MeVqrlfdmEV7N3yfb734A5Hk6+xUWLLOjScLPLTUW+UjP+1sRhjg4hqtJ5WQk9fo8uwr9qr8L
	g81RfkyBBGHNH0GXM16TT27IZtdH9aZzc0KtXhPl/0M0QwellXOELyyD1bwDKJ+8lTNd1zSAmc2
	mZWTvgAHBpfLlSwwz1kESXhIMFSfQLEyDVpLeA+P+AQ/1pAxhalBTwDMJuIRrNLJX+DRxAcVdG7
	FeztLGbL+Gsf3XwfquiTcqY9/8cLaaT/iim35T1a20+bqDtPAbZWsDjG3BaiFe0TdkLQ+KsVpV/
	27ancTtCg4f7snK6grFN8oeYFvqK3+vFwKtrD92ccqvqTIYnQoWY+bumZS/Ciexrx/XJJ9X5wI6
	8wNkFYrdVr/Pw2rWV3zFKt2EcL0vdDHAeUdFFLwdnGPBcwqJyKERj1mOwsLXrNplUnLRB02gONd
	mKTf/VdLuL027+uOrD+E9xXdKklvurQC2DJ7YN1ERgxp7cyz8tqeVfHzAG98EhqxKHL46HLtgLa
	dxswJMszxWA==
X-Received: by 2002:a05:620a:1a24:b0:93c:6534:d04d with SMTP id af79cd13be357-9442167725emr2767779185a.35.1793820700269;
        Wed, 04 Nov 2026 11:31:40 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4844991sm278199585a.28.2026.11.04.11.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:31:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOghv-0000000HG9b-0zIw;
	Wed, 04 Nov 2026 15:31:39 -0400
Date: Wed, 4 Nov 2026 15:31:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v8 13/15] iommufd/viommu: Allow vIOMMUs without a parent
 HWPT
Message-ID: <20261104193139.GB3889730@ziepe.ca>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-14-aneesh.kumar@kernel.org>
 <auuBjRjQwXl7UvvO@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auuBjRjQwXl7UvvO@nvidia.com>

On Wed, Nov 04, 2026 at 11:03:41AM -0800, Nicolin Chen wrote:
> On Wed, Nov 04, 2026 at 09:46:30PM +0530, Aneesh Kumar K.V (Arm) wrote:
> > VIOMMU_ALLOC currently requires a nesting parent HWPT_PAGING even when
> > the selected vIOMMU implementation has no use for one. This would force
> > implementations such as the following Arm Realm vIOMMU to create an
> > unused parent.
> 
> IIRC, MSI on ARM still goes through the NS pathway. So, it wouldn't
> be "unused" if the device attaches to it (or its nested hwpts)?

It is unused by the RMM VIOMMU. I think that is what is Aneesh is
explaining.

> By dropping the nesting parent from VIOMMU, it just simplifies the
> attachment to an S1 paging hwpt, right?

Yes.

The VMM must always maintain a S1 paging attachment that is the
identity map of the VM on all devices, same action as when there is no
viommu.

Jason
