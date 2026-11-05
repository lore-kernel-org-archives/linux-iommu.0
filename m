Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793839783;
	b=NeOE69RxnV0Tn+SlUP/xij7eEfqpQl47uEHKv6ZntjwRqlmRdc0UUU9hdIsXUKk9sNIm
	 eC/JyXLC2wiXUzl5w7H1DCyxfjbJG+J3f5e/gir9ByIiPBbYtu3U0AGqESj5B3X3+i9DZ
	 e1tIFu0N8+zGbu0xuNMKvjqsH9JJJTt3MBcUvp8pl511DCS3z2wn6Hdv6TU0rYHs6krZ2
	 X3kLyVgyk+cL8O9MG146/d4pI0yFb6RdnkpRyAs99TOZTo6qMZJgCc2a5cvI53h01bL25
	 vHEY05RUjc7566rHsuLXur+UmQE33rJ/ydzKUCPlk7HnG6yEF3zr8dqMIonA84kmdDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=LRIt6wL5JukeI7CutNHrB30kNWGfRXMCU9CjLoUJZrc=;
	b=S5YumowsQYYzSFH9/p9Rj2eeEerASHjT5BEHUN/e9tAXYPUAljX3A/jtQL69TmtH61vS
	 bIIXkP73hkUwsJpJkvqPVg/byfqiHpWPe5UUR8+mzaiMLyKTLfWMUwO4EQ1PT2ujv8s4f
	 eze0zXyaVCuwV3uR7I2PmJM2Ikbbo2WnbL9lCyigdY56BtPcasAFmy2JFq8zhPaRKts6D
	 eCN7h1azJkmqDGKqLWr57tjJdm6Gqfv3tipr5YN6IVnqZFYgnrEDrb7iSKEPhX7Thw2O+
	 yZermgYLNSFVd/tWOVhQqHzzONadyL+Z+TX6DyW6QmX0Fvqq+X/fosqWgdE3w9KCr+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ndKc2xO9;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81962606A328
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 00:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81962606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ndKc2xO9
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eadf48fb2dso527557e0c.1
        for <iommu@lists.linux.dev>; Wed, 04 Nov 2026 16:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793839776; x=1794444576; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LRIt6wL5JukeI7CutNHrB30kNWGfRXMCU9CjLoUJZrc=;
        b=ndKc2xO9qRF+OKJwv1QYrJYRG4w/ryz08TB1k+CdsREJjFgwxIiQHk8aHmzGtYI2WW
         8iNuWO/V5yO0Ykgh8rpuHdJaLnagtHIc2IDtiUU9tue+gudgfGwLrTdnI2w8ZUjJv0cB
         IS7ToXM4byqAfiXONzvOUrnUtl/ryf6+b3P9zI+Q+9XMyQQSwg9xCw21uYyKMzv0HGrV
         uw4AjjYjDd2+tB75X/qCto+/iZ5ZePzLaa/4EdGPrJCUqaUDF64CzUS6LvXX59F5jvXq
         zBte0B5xKu9tp7JkK+nWG7KFKzVtnVlIRTRM7v9FAr6cBv0nszokoBXSaqkATOEmcwuA
         ZKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793839776; x=1794444576;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LRIt6wL5JukeI7CutNHrB30kNWGfRXMCU9CjLoUJZrc=;
        b=qFPeHGgghhRJTWWa86EWVx9XUFvRpSLOLyzqgs9to3xc/jZPUj4zH5Q3NTIivPMChY
         Xs/eiZbx8k1a/nNBoF/7OgxNdvTygSDnkZ94a2roII4MUDYiTnu8ciZbCaqCRVW845kC
         WZiAdM56DCdcx4t7zKftj+Q5HM0U8o0qTfCk13GX4ra+rE+K0NoyV084CE6Jc+YU+S0U
         jsZqv0sww4dRtPjK8P4AwQ/8kx0BoKMS/QSkBMgYp5YNzFkGV58BrbDkqyRibUvW9d1t
         S5sD13tT0MXP0721h0N28iAoAyO2nAloA0NDBxnaRUgXJ1igsY+vlLBz3TRSnfUWIRWO
         yE/g==
X-Forwarded-Encrypted: i=1; AKwUvBxfPPb0oOTMX5RGsZbbhvn3GcSVaKEZECZw0EzxLgESSapkevU+UnPy1B4tpHBF85iutweV8w==@lists.linux.dev
X-Gm-Message-State: APuU4Z8c3JpfIqs42ytcoFvzs5Z7owMl+y07ppANeV8W/LUYnwTk9YeC
	LYYBmkMNPdT+g0vcRHtAaI1A9EG5UBxXBdO6D6s+IhmoXWPLzeyth1jnU0D0ZksVFME=
X-Gm-Gg: AYBFou3nKBVWqE7qaGGgsbXrDqX8CGOq+/1wXUSPWJ2h2jfAmZmDcNmiL7hilreGX2Y
	93cAxFrSgF6Q6oEdUohdHwru3QzEy8871SWhSUrnbOexlhPaX6E0erNaU1L1vHxYWSmG6zQsOVl
	nQlOz7HFAyW0ZavwTCFBdoqngHH62iNV8p6lQvPkEhHehu6DChruG41ers3yQRQPgbcZlx4s+/2
	q8m+S3wxyWgdHtUhz/3avA3pAUOtsi66vsIi8mLTk+ikiY1BUNh/cUK2RUyywufbSjfx2bFda80
	ZASA8NxND8CpaSt7I/hpVQx9+czreXv0NC7kGomG627Etqj31cuML5YuP1JM+4Dn0udZg5toCnw
	EHjC9jbpXZZ3e3y86vW9bMnx6lT2ePVGmLW/vvGxixwOrwvdBya42PXzJJ2j0E0d4QjN/+wBZUF
	IGD2zeXJI0SEAjhW0nKff4AEw+uoUt9Y34wAP73fqpe3P+y5WcdysQSfDpAS7P+Zd7mzNNOCMuY
	hg3oB5Dp12+0At4lKdSvY6GeJ7OyAyop9auJq9VAmaeNyqAPgV3xDmCe5BjqLuq8b0YKhF/I9QD
	XxZ+uyv5T1q6RWT2S40pNRslDT10cZchMRN/HEgMK3B8kDpwNZPYZGNnziFriAyciwQaaaQmwnO
	4M6u8DTlMRWk=
X-Received: by 2002:a05:6102:5126:b0:7cc:56a:58e0 with SMTP id ada2fe7eead31-7d0725e16d4mr6016853137.21.1793839776242;
        Wed, 04 Nov 2026 16:49:36 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d9a9ca31sm3266318241.10.2026.11.04.16.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 16:49:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOlfb-00000000cqL-0257;
	Wed, 04 Nov 2026 20:49:35 -0400
Date: Wed, 4 Nov 2026 20:49:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
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
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v8 12/15] iommufd/viommu: Allow PCI TSM backends to
 provide vIOMMU operations
Message-ID: <20261105004934.GE3889730@ziepe.ca>
References: <20261104161632.3547423-1-aneesh.kumar@kernel.org>
 <20261104161632.3547423-13-aneesh.kumar@kernel.org>
 <20261104152351.00002565@linux.microsoft.com>
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
In-Reply-To: <20261104152351.00002565@linux.microsoft.com>

On Wed, Nov 04, 2026 at 03:23:51PM -0800, Jacob Pan wrote:

> I am thinking MSHV/pKVM can register an assignment-only tsm_dev to
> leverage this? Could PCI/TSM support this role without device-security?

It is certainly not what TSM was originally imagined for, but with our
new arrangement, yah maybe so?

TSM basically just becomes this weird overlay driver on the PCI device
that does stuff. Some of the stuff it might do:
 - Register an attestation subsystem device to do SPDM
 - Register to allow iommufd to create a viommu
 - Some status sysfs ?
 - ??

It all seems separable and composable to me, so if you don't want to
launch an attestation subsystem device because there is no SPDM then I
think that might be OK?

Another option would be to somehow obtain the viommu from the kvm file
descriptor and rely on the fd to handle the module pinning/etc. I
don't know how to do that nicely with the way the modules work
though..

Jason
