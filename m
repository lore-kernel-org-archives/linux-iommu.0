Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793379509;
	b=ujCkS5275IJIYofPIH9RwUbhUOYb+64ZZuQV46G+9D9wPZcK6s7ry14w9aG07yRPGjKf
	 swOEb/cYSKX++t7ofe1tXtC9vR53ygnuF46WCf62tDw3T/ytaWhWqd6+dJigenJRCp3Fw
	 9V9KiomQDVvvk5FGmGpvTk1oC2SiBUd6VIuSzRnhpj/RPfmdKWbFxNy1Pbzg0geuRoPrf
	 FPa4a2hB8EfqCnupxE0qh2qoaHWmFdz+uD77ay/wyohQVfQQ9KDhFiLMFX1bGT8e7sQZx
	 Z3QLyKIGGGCVI/Bio6HoTWMYMDlms+3foXSPbFZAG9vupYnRECSNMxeWa/F3H6avA7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793379509;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Of8qcGhrASNngOAxz8m59rDteGhCMKDYRjobFeTSxhE=;
	b=KtaMpR60RdcBXW5oGWG/Gq9sUpacJvSC/ZE+dLADfMWNNuEd+n6AGCPHC3dgE0wZiZbl
	 lF3O7uqMaRJSdZN5qKFaWzGx9pX+hfuA/xqhmF8NIvdKMakn72cusgCQAMftwByRdpGg9
	 x22QXTr3EIJzbhJvTfmefttRmIjitUCdcwvI+x7/fzPpFQeQB2TjXJNCANEDo00yyrB9f
	 vWGX/WRQsnRjPsy1+bwAC8MMwlzdNZ/jIae4Ys+z40SOy0NYGqwFV2bCMqvVySaNT6Hmc
	 g97LZ/wpEp8UlFUeV5UYDGoqVKRcwS6yb+In7fWOk8dRAmYjyF7NNQyHW3LF5WsKQQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFE3606A31A
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 16:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABFE3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91bb5795792so10857116d6.2
        for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 09:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793379506; x=1793984306; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Of8qcGhrASNngOAxz8m59rDteGhCMKDYRjobFeTSxhE=;
        b=jMjBOdilJVON1kWhiH57iroR7wzXWrRyQ/2SG8NXJ52R67/g4f2btxacOXyBMZH4FD
         5MM7EjG2ICGA+DsjSU1M33wtuZ2gS38nNUEmbM1OyjdHZz+l8L7unrRoH8ZJQ3TYhebS
         RlWCSiRHfyQrj9/wAJk+2LIww1u5qWVVr/NWcQZgZROR6MQiFAPId9PLVeMsYt8ogg2N
         8gCVGDjsvr7fZlUMgkczDF0PstltP0BDn/8xRcD57kE8v7mlHB3rcKRqI7fjOCNiv0p3
         Q322yBWa2svFHbM36rCWRR6ke9Se9fQkHEYET4Af3c6wadDoJdqPXN0rQfmJKi22Aor2
         9OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793379506; x=1793984306;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Of8qcGhrASNngOAxz8m59rDteGhCMKDYRjobFeTSxhE=;
        b=I4vf59uoCM8hqAYwB8/D8PYdLXD3E2DNcKTQL04BJGPmxS1M8mmgEeySLr3nZPlJZr
         b+P10ee3kdKbzQ/IfcQYf/Y7ShrfcMastWogjpPRUpOVjNnLrqpD+HmlKOTsU17lXTBS
         CNwnDqBrFqClT2D0k6n+SNVS30QYtvT3Bm6aJLVFCmbMhzFeeKFz7tTSuiBXDP/HQKyB
         iLiQDJsqOXYhc1UNudEL3t2C6hVd9hgZfM6xdPk/HAXSdOfQWvmBAmMwSWkf63tcRMvO
         m6K28vhbSVuU8wf91a7P0F/Jzqz6rX99xoribTe9/5CZ5VCcjjIKRViY/x7ES8+nENKT
         n2DA==
X-Forwarded-Encrypted: i=1; AKwUvBxgZWTxBM51yCc1Sy5t9G2QvKOCfnQh99c0FmGW1U39W+T0btdOMrSSzDYGG8KWd6KN72DUQA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJnwGIKCLmeplRmIDc/BoWIGgraxPtAWpAJDmsa6DR8lDyGdOLK
	ZWMqcvthkX3AEzjv0Hc7+HXAKVpj9Rgoi+1AbdYwOGPQm/bLGzPmkMYIgNlauzZCj7Q=
X-Gm-Gg: AYBFou2yIUwXaNdQoeTyvMM8tLq4Auj7SjSQUVE/7NlfHi2/ScDlidVV6QBm6XGHNlc
	LfSkPQ9CBsmwjDUsvrcyGcArbR4UQEIaaJBd26B4BFcKtnWnoc6DW3vpAcIUO3jruCxwe2grT6M
	3N1id+/LwWsTKta4WlcreoOCbh63EwpeQGXABnCnBEuYd4LhwLB9OrkR6pTSa06oPhPK588OPEG
	wstI1zBNILMyCrhO/uwEGA1hsvnb15teSYVxQFBn7fTOj3lTPkFFStWLBtpjF1LzYhYvOnlbzQ0
	S94H7x15cLPguUr57d0GGM4pIWWxzTGN8P4wCNmutkWmLYmgJzSilYQ8MT+K6oBlt1gEwj5WQr9
	67RRJ5p8tnoJyUvJjbGAN559RtQpo0Cbb61wz1iI4xa5nOB79ZVE2BRb5TsYC5bh0tx10qS1HvG
	PTBfC6jJZ+6Elx4KlRr16mW6+pEXcvFXCQo4obXE6pEr+7klzUHM6YJjM4x9mXxz83YSg7J+tnQ
	l+NgXhbc7pbgFT8fJpxGWYr2+dNFYw1ZbHgPZNR8cAvEBPBEAXeHw3u8QiN4cKFtPjY8m2oURmi
	1FcNEbFOmiz/Pzf8S9M2mUOjpcs9iZLDFxgvQLSAbCGGVi+nKWucTO9O/qFMSokzP3LiNcd6gRU
	PJivZFukel8k=
X-Received: by 2002:a05:6214:226b:b0:91b:ec0b:9671 with SMTP id 6a1803df08f44-91ca4b9a540mr46456036d6.52.1793379506439;
        Fri, 30 Oct 2026 09:58:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca80700b5sm19825486d6.38.2026.10.30.09.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 09:58:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xMpvt-000000019rO-0nKn;
	Fri, 30 Oct 2026 13:58:25 -0300
Date: Fri, 30 Oct 2026 13:58:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v7 08/16] iommufd/viommu: Keep a reference to the KVM file
Message-ID: <20261030165825.GE3889730@ziepe.ca>
References: <20261008055955.4014342-1-aneesh.kumar@kernel.org>
 <20261008055955.4014342-9-aneesh.kumar@kernel.org>
 <20261014105913.00001217@linux.microsoft.com>
 <yq5aecd9aupx.fsf@kernel.org>
 <CO1PR11MB48351C4BD0BAD3BF6AFB2E0C8C6D2@CO1PR11MB4835.namprd11.prod.outlook.com>
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
In-Reply-To: <CO1PR11MB48351C4BD0BAD3BF6AFB2E0C8C6D2@CO1PR11MB4835.namprd11.prod.outlook.com>

On Fri, Oct 30, 2026 at 07:54:04AM +0000, Tian, Kevin wrote:

> Besides, it might be a good idea to return an error if idev->kvm_file is
> NULL in iommufd_viommu_alloc_ioctl(). I don't think the viommu logic
> is designed for native application...

That's probably going too far..

It should be possible to fully test most of the viommu stuff without
an actual kvm, for example.

Jason
