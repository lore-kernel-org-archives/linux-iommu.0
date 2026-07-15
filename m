Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C203B894B
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784144257; cv=none; b=CO7/hf0JZVgomLTjxmEDiBnxWPKLelukTV69f/Qw5Lrb0J5iN2op+Ad5askjnJlYrVx7LUNc/deJUJbsb2bnMK6jUqhXYCY/UJlMteCc3Yo6If/0O/4puZhIXUmXykgzZyXeg9WJq2fl3T2SWILRCs9maioVwkFY0rMObkrfrvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784144257; c=relaxed/simple;
	bh=eYNN6RWU07VAIXpqxw2a0aPtaKc6eCAW3usyhGGWdKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9teJcTjsQKrymXHSPmQYvhi2iapXrdjiOEcMMVrgS+uznWYPWtL2k5B4vVBe6o5w8jjCufC4vfY+ovitRwo93UTpKd0q5pPCps4loZ5zwKdHptW3tkGbc1upo37Muu2ErA/o9N3vDPiMIh5+2s4248B0OIKsY1CThQ2x3f2qJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=O+CcPxwK; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="O+CcPxwK"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e622cc874so399833385a.0
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784144254; x=1784749054; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OujpRFSpw/QAEHNMk5YVjM7csawMlwgTgeHiHNUlLio=;
        b=O+CcPxwKri+8zWsYtWADfLky7zxHh2GrnaeMS9x/qMfPm7J9fP+qYAswv0cughqhPc
         rji1rJl8gCyLmOOvLX+lGrvYo6loA8BW0QpSPlE+jozZ14zQlhdwCpxhqtmzxvUrVtY0
         vXM+bweroAKPE1SGQy7jwEUWkpQR8FMLwHQuyrlwt//ThZKOIexhn7rRRxpdRmK02btS
         m07H/KGQ4nfB7wJorIVmX94LC6Odauh9VOLVpNz9pv6ZPQV7pmpLZfuMVIwt1hMIzfeX
         A6V1TxoxlMi5FFoEWmp6jleJ56bF7SR0YuK0oKpnUq1O0porAeSn78aQD4fn1uHPryhN
         rplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784144254; x=1784749054;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OujpRFSpw/QAEHNMk5YVjM7csawMlwgTgeHiHNUlLio=;
        b=jo2nLiUA96EG6YxgTB7HjmvTQouDB0GmpE8eiIHPk+xoThRKd4jAywt0L0ME/xWB+t
         MwwI0fJir/9l6/+3tjTyA4/vAMdLoR84FVWtOvmLH5J8gGfuoQOO1U3YZGZ0soE7+2m+
         Y/P8ymTfuUBq1rir09HoaKINEnjLMdMOXViOzhbdyndAnxLcuDC6f3CITduLJMioIrxU
         Qjl1loW9JENV6dDCFeGXgECxvr12wSzFXbtSF+c/WwM9NqDHRsnc/OJCMHRIWT3q2DUA
         mobOybLMO//MTNoaNT72MC2I8JIU3ljv+BVfjQF7i6ix9j3aUA+HEvPZJn2S1MJ13F6x
         y3OQ==
X-Forwarded-Encrypted: i=1; AHgh+RploLiWMJEsaOlrmngJlyUQWC59ON0SwxJ0zCfdhPd5RPvvYpwIE9aQq7h2V2Lu36mlgZoQeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIkegiIMMHelLDomyH0JZBAG9uB27DietNrZlPuloW6SWDiI1/
	F/xh6pGe1+Z8UIQQkMrmKF/4C9BSHG+AMisxegWX0afWmA59QAsGybRZ3pSCHigYdVQ=
X-Gm-Gg: AfdE7clx3Xjy+grp28mIy8xvSRWMSg8T3Cg6PmI1H71/B5rMIttwNRcDdaqJ/1L3186
	eCjlB6pqrxwyIEXg3MUjxoU1khq3Oja9SB2XcWbIKGQMm1oJ9dPpkkDKjVOwoxaLTes+pGnkCey
	OPBBQz7G7lsDEHZjzRkfb0pivhqOIW9O5Vx+t9A7d1yXzYg9Nvxq69s8ILtgL6o4SU+jYR1TfAk
	e7jtJ83ZJXS2nZlZq3V3R4k4P4gNXxfpxsJzbTWhp6VFFqBJw+mKv+bRAPTcUvBrqEmWeeFP7VQ
	6L+pZJcZ3bxcNb/FTSoP2r/Q48gimTtMo85DBgluVBMU6JaTVyZ9aKffAFTyS9+drM5DH2RNsoP
	BUwgCgFZy1DNGvYjI6pBDkQ14GNfEffWMX5KrXci2aenzgSr+Lq6MdzvTWXxU
X-Received: by 2002:ac8:5805:0:b0:51c:12bf:d4a3 with SMTP id d75a77b69052e-51e3c2cc193mr94283961cf.52.1784144253535;
        Wed, 15 Jul 2026 12:37:33 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caab6e9f4sm144211471cf.2.2026.07.15.12.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 12:37:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wk5QC-00000000tnI-0nFm;
	Wed, 15 Jul 2026 16:37:32 -0300
Date: Wed, 15 Jul 2026 16:37:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: weimin xiong <xiongwm2026@163.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v1 2/4] iommu/arm-smmu-v3: Fix fwnode lookup lifetime
 handling
Message-ID: <20260715193732.GA210048@ziepe.ca>
References: <20260714060930.220277-1-xiongwm2026@163.com>
 <20260714060930.220277-3-xiongwm2026@163.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714060930.220277-3-xiongwm2026@163.com>

On Tue, Jul 14, 2026 at 02:09:28PM +0800, weimin xiong wrote:
> bus_find_device_by_fwnode() returns a device with its reference count
> incremented. arm_smmu_get_by_fwnode() drops that reference before
> reading the driver data, which leaves the returned pointer derived from
> a device after its reference has been released.
> 
> Read the driver data before put_device() and return NULL directly when
> the lookup fails.
> 
> Signed-off-by: weimin xiong <xiongwm2026@163.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
