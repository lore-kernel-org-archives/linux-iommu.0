Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199700;
	b=Zd3Z1RooAMPApibfDeV2Hg+OM4gPoPo9/54IKokG9shMU1Api3f8FGVy/o6P2bgfHIGQ
	 hr7jPSDcxJL9t0326T2jJfgdyxw9jme2cp+6feZNgNh9wCVgiLFoWFrgGx+EGJmMBZ0ND
	 BmPFtTO46g56F0yjkC3o86UY1+Hjp8I14AdbOKIJQt3eyB+UW4h+76SSan/vn9h+NI+Sb
	 T67lqtGJoRGK+1nrqFx2DNGw+TJ4HAwM6Y2oNpktVdOA1theIXJ1EicqHNBO5CIw+pW1t
	 fcKtV2wIvU4t7yMLnFTGBifrYXjf0v/I4ZhMPsYzSoBZQvwMqD3ibL5x9kYH1L9rTWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199700;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jPtMMj+TNQI4z5t6onBp93FYMjBvk5RvCFaoZZ65vCY=;
	b=WHq8UESPz90QW5RX3cPZ+rDlC5ooAuaMlKloP0gZyN83OxP6vb9H4l+9BIY7rDlWTJ7H
	 fKCDAnsnV4m4f5RGw8rROrAViu3WrUNKD0vmt/sDq3oI5a6/kE0d7/GPHaY3yqhbhaO2d
	 c8LEyBsvXiO1yMPlKUKn7Q87aZa4052C0QXxG/iH3gaGBP23nDGMOQg5zBCWIoezH9yJP
	 wSHisHRT4KGPwj6xNFRtLTRyPPrr/f4cLqJLgabwl4X0OZmoBPv965Y9/thVvGRIEhodq
	 IkxggoBetLk3n1eu8UZ2spVRHu43b9+oLV5D3fDgL+wZYT5wHFO3hsjVoc1g7Hiqg6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=LpK6y4kK;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C86160A2617
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 18:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C86160A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=LpK6y4kK
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-9210f2622ccso14952396d6.3
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 10:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795199699; x=1795804499; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jPtMMj+TNQI4z5t6onBp93FYMjBvk5RvCFaoZZ65vCY=;
        b=LpK6y4kKQHtJpPg0vaBR8RoIMnkx2pmladg9Hr8I37G41AdTqnPgVsD49m73sPiHPk
         aZCFfYDZbG+pH8TmftABJLFSg9ce4yjRTvW0AQV84OR0+C6RLA+RsI4B2KP3D1fdS+1Y
         7wNH7/8MeLvgrmykkS8d8CSZfHXTBLqQxa4HSzExgZkBYyOgBXwCjwcYO43xt0mCvXyw
         3lW+AQVV29S90RV3ipkcHbJqKoZrqdx+/N7q/qmZd6o9Ck1P7bO4XVLkWKsZOyVTMPk2
         NfdRoNFJ/DxdxsL2bsP9373F4GdWUH/8H+yUfP1Byl12uP5Q/JHQTLO5BoNFMf4czXpk
         eHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795199699; x=1795804499;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jPtMMj+TNQI4z5t6onBp93FYMjBvk5RvCFaoZZ65vCY=;
        b=du24B/3N7D8Z96wd/yEFJyvA9cOXHexiDAlKqhIjOBDDMcxp7e8awS88bMwgZg1lXJ
         hjFtJLDUVKXxYGDQOQNj0gCIDc517/HewYK0hO7BUkbc1Gz8gpMvH6acAxTmCXROz6aX
         0zO7Rbpa7zpUafgj7mxOXJQz4QRs0teC4+LqkEhd5YZZE+WSPRpaNxJmIl6n0HHkAV2H
         4Cszkg3pb4b4DOcfduD7arTFmDumXkM8WCrKOUeUdETCKp4M41ZJq7sUFjtXCSMjUbFb
         VTEXft+2rrvWMALNtfYv1vGlsMFBlHoNxBOj71QichVz9c7Vr7ufDVNhyFFZ7wojI948
         DA9A==
X-Forwarded-Encrypted: i=1; AL+hErEgD+2eBaiLoAxFUafz6mfW609lthDESSZEvQ+OKiLLHb7F5Dlsgwas89UZosqgumbyLcuOBw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9SUneQEea45kmnRNJXrJVILIqmPYLiMNqf9lDjwjgaFvLBnCpJ
	te6fDfvOSjJKOyslP6v3QABgZIQ2/NbMvpzQEyj46ktl84Au58au7paEeyJ/fTLkmlQ=
X-Gm-Gg: AZFdTZcixQxBFzEkLhMe6vAAGEr0uKApTdWUUcdxLlot8YfSUdUrk9WrtZEXjXzm7RB
	N3VO62hqbBsDBaOChSFDXbk6ux4YflJChWLOF23XA16ZeOICfg7HNC1+zqHpmch6pgRIvkRCzW0
	HFUahOkteX3DGbfwGWB7PxTIpvjKdb2N8PBseUBWXmP+iKU10zMbxUO2M2/rU4DV1/xLVcMZRqc
	Y7/Pm6hiX9owxvuj4u+CwGGG0jIgIoORG0GNBzA+pxQ6chaoFqhPgErWpsRkn7SysgD0CFllu6c
	QSkG1kevx9FF9YisOfhcWUVF9VfTWXeCuFqs7HovqD9MTzVFvLHJwjBJodqK2MqOIDpO6a/gdL8
	fAEBnZfszVhnwQL2lXK1ImsZvmvjUNfM9r6L9A2E22Rlx+2t/0DLtdhsplXHtn19Yx9OdiiDcej
	rjHFfR7JpmImBQeS2pZR60r7HdHrhKE3r7VPLJJF3ybdVigNyC4rWppxnXmm7UilU0gWYwgCqm0
	E9At4UqE4/KuQ8gq20EG50RXslkpZIEzuBr+vnzvyrv2xsjFRXJjCzaLYsFW1fstt087eyvhtrR
	6ESz1Q==
X-Received: by 2002:a05:6214:4881:b0:921:152a:4e48 with SMTP id 6a1803df08f44-92134b1abb5mr65747176d6.32.1795199698766;
        Fri, 20 Nov 2026 10:34:58 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a16754sm32821016d6.39.2026.11.20.10.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:34:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xUTRp-00000004jZ9-0OT6;
	Fri, 20 Nov 2026 14:34:57 -0400
Date: Fri, 20 Nov 2026 14:34:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, Alex Williamson <alex@shazbot.org>,
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
	Xu Yilun <yilun.xu@linux.intel.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, iommu@lists.linux.dev,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v9 09/13] iommufd/viommu: Select vIOMMU operations before
 allocation
Message-ID: <20261120183457.GQ3115493@ziepe.ca>
References: <20261116081935.85372-1-aneesh.kumar@kernel.org>
 <20261116081935.85372-10-aneesh.kumar@kernel.org>
 <20261120094207.00002e89@linux.microsoft.com>
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
In-Reply-To: <20261120094207.00002e89@linux.microsoft.com>

On Fri, Nov 20, 2026 at 09:42:07AM -0800, Jacob Pan wrote:
> > Temporarily disable AMD vIOMMU allocation by returning NULL from
> > amd_iommufd_get_viommu_ops() while the vIOMMU interfaces are being
> > updated.
> > 
> why? if this merged, it would break AMD driver vIOMMU functionality.
> And not temporary as I didn't see enabling in this set.

It is broken already, it is missing some series to finish it. It was a
mistake to leave it on like this.

Jason
