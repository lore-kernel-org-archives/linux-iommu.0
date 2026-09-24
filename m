Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE32141F346
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 19:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277664; cv=none; b=Hu4bI9W+Kiyzrrpr9LpVexF40nhJN2n2j3ErND2YtESL7AWJ07NpMF6RAxaTq/xsC2iDeTfaiFeL+grq7EZpa6Q7AcDdl+hx2hYpd9gCsOXDPXlRW5acCU5EEyf1Zx9N3X+ghStadWibTjDxW29pKH4CIYcMmNqdt+jLMAdCVnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277664; c=relaxed/simple;
	bh=Rj3lvDiN2NQIPY8+Fcb1qFFhsTlk6MawBPpka9LgHOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/zkg71q3zF+/uIQ+umR0pYL3iYlfuRM0snDF2eoL69WMD3zuzYqWZjdsuUEn0fZvv4ROlJWo52+D/mxX9mCoZkkBw3jsgHSRWMAcWsGeyx1Gy5qahnQwEqVBMH67JMg7Q/+rn6GOaOcqFAgiZfzcLldJPjWGGMSAvlSAev7jnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FQknbwjk; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FQknbwjk"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-340f56c44b0so36338eec.1
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 12:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790277658; x=1790882458; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wndndcOgS9UQetfbY1PV7Ii3PybmfQMjB1dSgomByBI=;
        b=FQknbwjkKVUmfNcq8C5V5wtFe0b7RSq7V4u+UHn4fUfpvmL98wtKVQ3tdd/YmShsy4
         gc653flGfXn6yG1CIe2sK+reLnJRyLbLd/8Ug5mBZxr5uN9St2cKqReQYrWWsWMi3cu+
         hB483TmUQ/Lh3wXjOCxOwGtjejV2VhyzUhDkKgyIYlTkMftUvYzMI2+aDA0cOaV1U2/T
         HjGPDjDIYd3QD/DM4X9m2C29kW3pd7ICf3RUY0x3O6SlolSdezzE+u2mJoRN0xRRXbLV
         hXzVptAMiutQVHQ0YgBUsABPmmq6y2EtI8ONmPGkZLA/KmJDDTn3fqJpPh/biR2sMSjf
         8Ksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790277658; x=1790882458;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wndndcOgS9UQetfbY1PV7Ii3PybmfQMjB1dSgomByBI=;
        b=hnwMbcZuFgkkUoI/xc5q+t7HfAPJCzAeILQSq5lTOUO8rKcPI4JxXQfupWcv5Okb3l
         oF5zbUKXVLqYkBi+vDFChFP68PcmgVO1DXExN4G8SQFrEJxOu34JtnAcDP9nCpy8suzb
         x9YbiRwOhfDWmVLAxfBGY3xvWSf8TPv13AQTVXkTMl00NSG9ZpyWahZdVoZolXPrkSnK
         YZEQdZKgQTWArBJ24BkrLhVqZ5Dn2u5hM1UVUEeZ5rP7WscdGlg1TpqfT5ssHSzezOQZ
         7OQFa+QrJ6LVu8nF55rITj8fzYPG+xkAmJF4DLGi/1fn8NSY8cHtOBu0vF9VkmVKBD6l
         VaGA==
X-Forwarded-Encrypted: i=1; AKwUvBxizcb6oyoplbj80icW+YK4qdvR8XzMisYuitePynkJcaO3s4BaZags3hUahkjCQcbtFpukoA==@lists.linux.dev
X-Gm-Message-State: AFuF++n171UvRyfzH+0wocZ65aMNOXLWUkQskNEkCpsAJsv1b/pcrkW8
	O1fkDTIN0Jh05uQrCnubwv161rzNNbtEMfJ/UCu1oX2Zcdnn1WjtcseJKgNts093kew=
X-Gm-Gg: AYBFou33nTuhm3GoDMSz8ft5ufjOi8BkBZvbY0luTmBu5CHxA3Y2RLrOsCqoJCfMlnm
	AlXvPpqjOouHQBaxNdV5HWc8NsoGsaptwJM4rxbHlwsdtbm09q+u9CxOp9wJpe9PrKd7/OjRwwh
	RtcKD8ZVYujtVkNQ3PUo8PwfKgsbNdoApLAmg/p9pVTofva4P7e1UGj5YcUaZRSAd7OHPNIoxvA
	oA88+UZ0hrdMm9Dws2cx11kTUcaWU6+jmJdBPlO7OZUXH+P4xr/iadFd0A86cA1FqWCgo3lxYmz
	AZ78fNfPc7phl3w3Bb+bau6bKGibL3P61xfLckxv6KJeT200xw7mW+/gpuK51TShSxBA38MTcrA
	zCroFK0aTrN5Gxm3Wcj51TqJfCIh2PXjelrvDcQRwg1pl6u/ty+1Ewvwf4Ap5x6XQXMuujtClW2
	M+TtWMfDofeZfuwn0k1Mga7cw+mr3J6uO9yojXMc76+lau
X-Received: by 2002:a05:693c:8201:b0:339:7572:7b2b with SMTP id 5a478bee46e88-34000737ac9mr2950958eec.24.1790277658136;
        Thu, 24 Sep 2026 12:20:58 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145632298sm611644eec.22.2026.09.24.12.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 12:20:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x9p02-00000000UV0-1Zib;
	Thu, 24 Sep 2026 16:20:54 -0300
Date: Thu, 24 Sep 2026 16:20:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>, Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v6 00/11] iommufd: Infrastructure for vIOMMU creation
 for confidential guests and guest TSM requests
Message-ID: <20260924192054.GA16465@ziepe.ca>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <CO1PR11MB48358E3116CC6CF34E6437658C812@CO1PR11MB4835.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR11MB48358E3116CC6CF34E6437658C812@CO1PR11MB4835.namprd11.prod.outlook.com>

On Thu, Sep 24, 2026 at 07:48:08AM +0000, Tian, Kevin wrote:
> > From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> > Sent: Thursday, September 17, 2026 10:02 PM
> > 
> > This series adds the IOMMUFD and PCI/TSM infrastructure required for device
> > assignment. It introduces an IOMMUFD-owned vIOMMU provider registry and
> > the
> > IOMMU_VDEVICE_TSM_REQ ioctl.
> > 
> > The series adds a vIOMMU provider abstraction that allows a subsystem
> > other than the physical IOMMU driver to implement a vIOMMU type. It groups
> > the vIOMMU operations with their module owner and private data, and makes
> > that implementation discoverable during vIOMMU allocation.
> > 
> > External providers are selected by exact vIOMMU type. When no provider
> > matches, vIOMMU creation falls back to the physical IOMMU driver. Once a
> > provider matches, its result is authoritative and failures do not trigger
> > fallback.
> > 
> 
> I wonder whether this abstraction is necessary.

The main purpose and point would be to keep the TSM code in TSM and
out of iommu drivers.

And we don't want a module dependency from iommu -> tsm either..

> The underlying IOMMU driver still needs to understand this vIOMMU type
> to check vendor-specific compatibility and provide the relevant hardware
> parameters.

It shouldn't, if the user requestes a TSM iommu type that should go
directly to the TSM driver, and the TSM driver should involve its
physical iommu as necessary.

> There may also be further vendor-specific interactions between
> the IOMMU and TSM drivers.

This is the big question - how big is the entanglement. ARM's is
small. What is Intel like?

If Intel and ARM are small, and they should be because the T=1 VIOMMU
is entirely handled by TDX/RMM for security, then I feel this is the
right way for them. It keeps the code nicely isolated with only a tiny
bridge.

AMD is probably not like that.

> In that case, the abstraction risks becoming little more than a
> connection between two vendor-specific drivers, while making it
> harder to maintain a clear scope for its operations.

Glancing through these patches I think the abstraction may be too big,
really the point is to allow TSM to create a viommu, I'm a little
confused why there is so much stuff here.

> Would it be simpler to provide helper APIs and let the IOMMU driver use
> its own interface to delegate vIOMMU operations to the TSM driver? 

Now iommu driver module depends on TSM, do not want.

Jason
