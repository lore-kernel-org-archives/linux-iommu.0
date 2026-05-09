Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EB9393DFB
	for <iommu@lists.linux.dev>; Sat,  9 May 2026 23:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778369375; cv=none; b=MomEmAVq8ydm6+w47q5YDtLkGpodq2QO9F2V4KrRc9Q3eWbxxL8uKjNL+a5CDOHEkqd6E7nYeeXkChRZ3A+3UcJ65/RW8PvXWwigH62hSsmIX7a5j0BkdqFGFtXSRXt4jhZVq0VquIVUvjA1wV2CGmlB1yjkxq7MEpY9D2Az+i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778369375; c=relaxed/simple;
	bh=sce070X88mUVBdz9b9Y4+DDwl2h8zEkLOKh5Apexnnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngpA3NDaeuV3gcpD6PL8GB6i7cZd61ZT04iaAMHmDINmlio53XORwDlKcpM8kg5DrD1aEVMMxyUs/6q3n+fmWoR2j2SS1WqtcvaaGp25+czYrdPF+Mag4a5/ueoRHI29qY8Qv231tEGdwlG8hgCHJC1N0P1vQBQ5+szPnYVSo5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TKS03tp3; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TKS03tp3"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so49929876d6.2
        for <iommu@lists.linux.dev>; Sat, 09 May 2026 16:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778369373; x=1778974173; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sce070X88mUVBdz9b9Y4+DDwl2h8zEkLOKh5Apexnnk=;
        b=TKS03tp3PaIHG0roBKMv0YUFMmjXGUm6hR/LVK1tEW85eFnpgc6eRl7RoJ8CT4BFW3
         BwKofKWHYEF1x5rnc2/74p1g7K+ke5vr0PDqTkz23rnuLbbst8BF6CkZ1Qnof4UmqJ3/
         ZnbeuD4KgKOjImzpKO1OrzqDB7GlCgyxhJQl1ZyK3u3Vg53M5s3WvvXVt67nFjp3dXKS
         6Vf7MimECp/CJxOCSzclKKYKM9ylAiijk0OpSPO7i44fgSFBjuYDBYRscJoRqyV0yJkf
         qNWaywXuCuzo6SWl71loa8uEFi8TWtsVcLXmLoFI+a6qnxp7N1ZiQb48s9YX3l1CbobC
         erWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778369373; x=1778974173;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sce070X88mUVBdz9b9Y4+DDwl2h8zEkLOKh5Apexnnk=;
        b=pNePlJ/HO2tK/v9x9cZ3hgsuTi75oEFllyNwg7kl/AUZ5UGoQqCYic2NX+mTTRPaRt
         2Fmv1HkBP2mj4qRhEGPJ9mcElPsQ8I9xW/gc0kchkNsIj65Kx1kWh2PKdRFFGIPkUmoC
         znqdfGOGIno7r5CURUqGr9GFIkT8QFN8ho9jQix/owf5+OoGj0DO8BPq4fgbmFoZvUyt
         qmaKWGGpU0/ULXBBcfk3nUpUGO0wCv4lpCwO3fkmW3bQeXlY+6ksk4fVPEmWZbN7bmZX
         iWohUh/7t6hbJjF0Rb7ELsfsfPenvwFKAtyK+fthClY4AW/COnm/zwGtPEyqVzVzHETi
         lpig==
X-Forwarded-Encrypted: i=1; AFNElJ+glH9igAUYeE964/81uBp2n7v/I2V6SvDmZGBIGNZ95rQua0xUtU1rEHsa9f845P/VSEF2tw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywf+HFZmhGQ18dLdbB5FT/mIkTzxGkhh9bjgJsBOHUX+uA1Mwe4
	KyljvoOmt9RlAOl/4odJXtcqdSmIVWrsm+OXOADVJzHDAY6Er6ZkgUtHmCYP8Vt+60MFDuJ0iVR
	aRexe/Gk=
X-Gm-Gg: Acq92OES2UqlxYDy8BFZzx50RpRKU0FceB/A5T9UfXftEWbFsTIj4rCzDd9xHhqgyDD
	WQoLriyXw/yc85nUpAjUn6ANw+WZExLTFjDB3MfV8HBDNxRIBLSIsCsqFlE2BQvQqfMrU1Zz6HA
	yE1/32KTrmjtQYNH12CgeC2vYOXwFrFDew+pmZiPLqEcN2U8QdC5staDV8RXX6L/m2jXd5iMpcz
	xnbx/RYvSquIbd4NKCf6JEwbclo1f+jQajntxVQRVU4FtRNBICMvRZacy2jNv3lVvA4VGiYOAdw
	p54pI2HyX6w2syOXjrLElIkkJDDLLwv7XjsG7dGNze+vPBZAdP+rz4wszYKqAg49TNIbaGS7ByT
	D9vpBpTzdhUby3rhm3R+U9E3SHLrkUN4Cu/c/sWnKcBoGAJwZbcmY/Tx4vitLzVEv/a+9ez+oZC
	6RwiTPCzmq+NG5pTXlq2ugEnJOxcev0FaxvodFTfLCKa849rs5PNHdtLM3U1BPh1T1saaDyzPRh
	ijgWQ==
X-Received: by 2002:a05:6214:3a8a:b0:8bd:de6d:c33a with SMTP id 6a1803df08f44-8bdde6dc799mr202539986d6.21.1778369372915;
        Sat, 09 May 2026 16:29:32 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3a33fab4sm53837756d6.23.2026.05.09.16.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 16:29:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wLr6x-00000002NrB-31tQ;
	Sat, 09 May 2026 20:29:31 -0300
Date: Sat, 9 May 2026 20:29:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 04/25] iommu/arm-smmu-v3: Move TLB range invalidation
 into common code
Message-ID: <20260509232931.GJ9285@ziepe.ca>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-5-smostafa@google.com>
 <20260501124143.GB6912@ziepe.ca>
 <afiN1UwS9q6F6A_v@google.com>
 <afoYBYIJOTClsdLS@ziepe.ca>
 <afoeIVIGE-JjYy22@google.com>
 <afsPfEzgGtAFrN5P@ziepe.ca>
 <afxd8Km40A5ulZvd@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afxd8Km40A5ulZvd@google.com>

On Thu, May 07, 2026 at 09:40:00AM +0000, Mostafa Saleh wrote:
> But that doesn’t solve the problem, which is: At some point, whether
> eagerly from the page table code, through gather sync or a fancy
> invalidation array, the driver will need to populate a range
> invalidation command (tg, ttl, scale...) and this logic is better
> shared with the main driver which is this patch does.

My point is this patch doesn't share enough. If you do need to issue
invalidations then share everything below the top level tlbi entry
point and don't try to make a pkvm version of the entire logic just by
ripping out the range logic.

There is no reason for pkvm to need a different algorithm
here. Especially when you get to supporting ATS and multiple devices
and smmus you may as well just use the whole thing.

Which is why I suggested to copy the entire call chain into a shared
file

Jason
