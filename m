Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537DD2AE66
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 00:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013052; cv=none; b=UK7Ku0GscK6h6fUF1ZSAz52vx/1EZK1rv4XdLIeHqNylLAO6/z/BN1ll7NYkVz34MHB4W0oxuXa/qYicE7KEYx+RuZx1D4SUXZ8NkeddsU4zrazG7NVRm4cX/vluVZcOc7GSXQhZHic9nku/st4IbHkNdkWvfrAoBBnIGv9wifs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013052; c=relaxed/simple;
	bh=Lnj8ZPF5lrE7Xc/uMpcIj9FkYaJnkbOF/02TZqJAndk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFouicNriPYfCuNab9zfHis7MGLQ48z9D/zCeDe9YOIAN63WJ1GRUokCoMKisMZEUs5iZwQzqwmKfWMaX/CpU1sCaVa6vNxkPY4c0H2CTcy5/LU03P+GJL+5QbLTzqE7s0s5DNGAaWruDwpEZhpvaQfvzASz9huE+AG84F+CN00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kF5Qojpx; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kF5Qojpx"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47210ab1283so5177301cf.1
        for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 16:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740013049; x=1740617849; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0/Q3pmbQgFaUMEz//cVYqBy+kD1niHA/UXy9NuQBpQc=;
        b=kF5Qojpx79ywMURVFU28xSrJ1+x1dCApCVPKvv152iY9vW9Izx/oTHeTb1QjaYTpbg
         6LubDvqU+/KoPS5KaImuNOpgqkmMrYHEfBFeZ8p+b6ZeuVXy/eM/+aRw0lqmkDdG87c/
         5cinHHn88KNlmNBz9NtqKkEioXLZhWYtMl+Ufd6pY9TF0B3Kp00gzzN/VL+btGAwj3V5
         G3IgeThWZaSR8NOWgDLGtj5Rel2Sm0AUsqBagZDaBWH3aUYmvfZFkRfU/vcZrpqG8XBv
         E157VtOZAhZcY7G/cfPCoBu5wAT3KksAGWP1SaxSHAe1t0SichcD1Guixeita0qEJBxy
         1MjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740013049; x=1740617849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/Q3pmbQgFaUMEz//cVYqBy+kD1niHA/UXy9NuQBpQc=;
        b=exNQ43u1xeFnXhJvxZfvXTqv/wAmiU42HyuMt07OudtveuR4Tf2VFybTke1uYV6++O
         ek1OaJF2WFpdx+/nrXuGbYgNBCdvQ53z1nDOPlHv+cLo7MZe6cBaMJZJ1RF1O1d8aPfE
         JHtfB4XBhQs1lwJHps6m24Q6Hh/I6umbyMi3fk0sThNQoFQjonS8iF9GoOJCCgpF2N79
         xFa84izpkA1K2hcnZFjJ7kS9Ym42Z4Lgqc9QnxvR0W6wvss5JPmMUnOcMdgZFINpz0vW
         36JZMa2l/kUOosTaDkpvk3pk/thlS8x5ZpiDpM0dTGfC0SiDpEmsFamPD4jX6EybTvs/
         N9gA==
X-Forwarded-Encrypted: i=1; AJvYcCVRpcU1SB7r7NPgvGAp0PA3F885xsgNzJ6bwW4Rb2SHREADPEk4p76YaJkKVKCxAR+NABmfiA==@lists.linux.dev
X-Gm-Message-State: AOJu0YypEsT5Yjc5Da6Oxgwf+6fGq5/ym3KhPHV9iubb29P4Z08nsKYM
	PMQyvcabuG0fu5wvdoBesgyH1+sBbpJbTrnfLilgIeAsRA/9ABeHIl9maG5bgkA=
X-Gm-Gg: ASbGncuidS5+Jh35eMoh/Cb0ywe+QJTcLvZfU4d36p/GwsS3Ng2TlAZvjRfAV8CySNa
	8SIvHIzcwkdqMflThle9aFJ9FRmbtAfprv9g4Ff/9V1nVv0fTaFBLMsqjvjl7El6JPQIrwdoTP7
	1WRdWRmSCmS5iWcGuzSTc5XCk/PYt+K2asKok2slSX24bHwDLGBkJ6XmdTvNb61EGs0xtcrZtZJ
	GUBcccTEMLBntf5dEmtZTUgeXXHokcJx6w4qYBt0nvvCyVvSisiWSJQTGQndMANq5RVXcSKxHin
	GIPSzpBEBl900oNy8TsvTeNk+9rkaQLRh9ay/x4C84SzXW9h2oCGHZ/7WMTNFmyH
X-Google-Smtp-Source: AGHT+IG5zCh9CoeLQY7rC+mk5ewFMnBFHyg7FBmH5U0ScrNRvZkI+aTZATrHIvB820rTi8JmR7A9wg==
X-Received: by 2002:a05:622a:1a02:b0:471:a2c7:b6be with SMTP id d75a77b69052e-471dbea0a25mr253348721cf.45.1740013049013;
        Wed, 19 Feb 2025 16:57:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f3f6e90bsm36101381cf.79.2025.02.19.16.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 16:57:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tkusZ-00000000D45-0QWL;
	Wed, 19 Feb 2025 20:57:27 -0400
Date: Wed, 19 Feb 2025 20:57:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Michael Roth <michael.roth@amd.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org, kvm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@lst.de>, Nikunj A Dadhania <nikunj@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Dionna Glaze <dionnaglaze@google.com>, Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev,
	Zhi Wang <zhiw@nvidia.com>, AXu Yilun <yilun.xu@linux.intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: Re: [RFC PATCH v2 12/22] iommufd: Allow mapping from guest_memfd
Message-ID: <20250220005727.GP3696814@ziepe.ca>
References: <20250218111017.491719-1-aik@amd.com>
 <20250218111017.491719-13-aik@amd.com>
 <20250218141634.GI3696814@ziepe.ca>
 <340d8dba-1b09-4875-8604-cd9f66ca1407@amd.com>
 <20250218235105.GK3696814@ziepe.ca>
 <06b850ab-5321-4134-9b24-a83aaab704bf@amd.com>
 <20250219133516.GL3696814@ziepe.ca>
 <20250219202324.uq2kq27kmpmptbwx@amd.com>
 <20250219203708.GO3696814@ziepe.ca>
 <20250219213037.ku2wi7oyd5kxtwiv@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219213037.ku2wi7oyd5kxtwiv@amd.com>

On Wed, Feb 19, 2025 at 03:30:37PM -0600, Michael Roth wrote:
> I think the documentation only mentioned 1G specifically since that's
> the next level up in host/nested page table mappings, and that more
> generally anything mapping at a higher granularity than 2MB would be
> broken down into individual checks on each 2MB range within. But it's
> quite possible things are handled differently for IOMMU so definitely
> worth confirming.

Hmm, well, I'd very much like it if we are all on the same page as to
why the new kernel parameters were needed. Joerg was definitely seeing
testing failures without them.

IMHO we should not require parameters like that, I expect the kernel
to fix this stuff on its own.

> But regardless, we'll still end up dealing with 4K RMP entries since
> we'll need to split 2MB RMP entries in response to private->conversions
> that aren't 2MB aligned/sized.

:( What is the point of even allowing < 2MP private/shared conversion?

> > Then the HW will not see IOPTEs that exceed the shared/private
> > granularity of the VM.
> 
> That sounds very interesting. It would allow us to use larger IOMMU
> mappings even for guest_memfd as it exists today, while still supporting
> shared memory discard and avoiding the additional host memory usage
> mentioned above. Are there patches available publicly?

https://patch.msgid.link/r/0-v1-01fa10580981+1d-iommu_pt_jgg@nvidia.com

I'm getting quite close to having something non-RFC that just does AMD
and the bare minimum. I will add you two to the CC

Jason
