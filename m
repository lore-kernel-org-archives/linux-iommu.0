Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DACA353EF3
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896981; cv=none; b=sEaSic9TZW4Rw1/F7pw1HDrRDiJOnnodlix71x7yz1Pd18M/mr+Kf9McyBaTiECDS1SKJUukPjPRN+cvXXPInCBgub+Y6R8N+BDucRx24hd1/k4EUGN8IxVI9ii5JqEHu8E73tpeeBZ/LMZ3C8rv9kUOXh47Q68MpmPRSuFkE/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896981; c=relaxed/simple;
	bh=VveELzghzgx92/9Qy6YBiAz7Qpzrc96gg9l7rbe1IL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSiRxGlg4v9yJyeTUofgnj5PrLeEzTsYICWnFLdopgwAac5EsKVmwzNfhjTBrUUAVMpVzTiwkTSfO+oblWUWoViD2JLmIGafyKu2TifFNrcwqlxb0DAbHHe7RF9/GjguBrL/nwh5A9p4eZ2GZVNluNOe88LgtGhujMwDzL2vQIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wTArlDcd; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wTArlDcd"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so170745e9.1
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 05:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777896979; x=1778501779; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NU4R8Qu0lIhzaFVACH0M7ebEyvf+bx2epSGVPFsYcB0=;
        b=wTArlDcdiWuk57KD5k6gLQhQ3Q9ffhz66WxY9QXitKGJIS2J2O0KyWdZA9TwUe6PLf
         uBl+tPfoJUxHIMQC0882g474/xXSXnmxXbzjoa6YevTafv3qsNXSnKkyttI8m8YXDoee
         +mBdbhftHtD3o3o3XrDvk1vLw3qahyyKzjdQLYO/SsSSaJPRIUywnGDj6Tecx8CfSU5N
         90DBgAPQ95/gXT59BEZE5rNeMSPCFPYftO0HmwLmLO4bXhC9F8RUlGZl+Ohu9PnNcMcm
         rQMC4viLyocBDR3a2dqJlr6tOimb6VppcmKtIDDeKf4HpCrsBjlPyqNs3uSqryMgquX0
         kpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777896979; x=1778501779;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NU4R8Qu0lIhzaFVACH0M7ebEyvf+bx2epSGVPFsYcB0=;
        b=IzeUwd1LIlZ4S38ETY2uG2p3aM9LAlCF16U/jk0BvxxbMnOjKtISLy2xklujfsA7Jm
         HmcK2QyU0kZSq+RhbLHrFn7JoFZtl3xzM5sfYEw+k7C3khLly42QQLGjWGGj36eesest
         tEwf5CsR1ix+f5CGzbsa0KNjrhrbamQXXAGRsPTwJd7NdlcbroqeL6JY1tMYRCrKIms5
         q9bAUFrLmn19G4WK1Q64ulidIuOsb4tlpTGu3MfeeByLeXGBc5zX2W7w+dEH0UymXEwi
         t7dNQzJd8OPIBC6tJCaKvI4KWuhSHeqZUPbhDKDQhjbOD8qvZy0oXyOFF64A7JaDU2cg
         htDQ==
X-Forwarded-Encrypted: i=1; AFNElJ9722Y+H2uIxW08UfpfkniQt8127pTI2uQ6cQZR2QbmpDt3b9NJuJUT8r0wAtVIvSV/WYf5Fw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzj8LwfPykxU/QPjU5Aqyi0diK8ZGg+yu+IpImv/50nJO//jdm8
	ERS6b85Oj15sFnh2mZOwJNzrv7et2Cm1Lu9hjwnrx0AUoA/PPN6w6+0hhXfS6KNubQ==
X-Gm-Gg: AeBDieum67fMMGDPcmLtdL1nWIBrW9HztKc/60+6Tlp+sPIYpL+aFjhKFuNCm/IRLN9
	2GMBaETadS5XTSWoH9r3nywvO1iGZgr1XszH2IEChxJgyN98F40neeH+wDZqT0lKVGHSFXp8iyI
	jByjwVDvJczyFPm617ElwBcBGFX6PUDVWZf+xef0ALLOcEfbJXtEVOSn0urHrEvbDMWV4iZUQ0I
	NNyB01dlkMxCegSgRDAhVL64dYxTneZmeIj/SGK6yZrDmxnF3i7xk674Y2NKELQ6q62+ZQKVTVw
	EIbBtMGG8j0kwI49euVC9k1EKcDiJ3mVALkyvcnbeiUslF1bf3HHRyRCbrZreAR7Hd3dtHe3OnN
	sdLgcOCtoBM+XRUV4VB7QwO0jrQsYEyf/SCuMgqsbApfu1yPxwOA5cbF9jgIlM6T6Vt98KvXQ1G
	sZpuh0brfEg7bY9A5cD+dveZGN6LbYQ/0Cblu4gqK4tKkJJl/vBBozBkBSROUelLQKZ8tWoTlpv
	iJQbw==
X-Received: by 2002:a05:600c:4e8d:b0:489:1ace:d0d3 with SMTP id 5b1f17b1804b1-48ac3159bbcmr153605e9.3.1777896977198;
        Mon, 04 May 2026 05:16:17 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8ea7cf97sm29764334f8f.6.2026.05.04.05.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:16:16 -0700 (PDT)
Date: Mon, 4 May 2026 12:16:13 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 05/25] iommu/arm-smmu-v3: Move IDR parsing to common
 functions
Message-ID: <afiODW2sVMeOj3Ag@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-6-smostafa@google.com>
 <20260501124716.GD6912@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260501124716.GD6912@ziepe.ca>

On Fri, May 01, 2026 at 09:47:16AM -0300, Jason Gunthorpe wrote:
> On Fri, May 01, 2026 at 11:19:07AM +0000, Mostafa Saleh wrote:
> > Move parsing of IDRs to functions so that it can be re-used
> > +unsigned long smmu_idr5_to_pgsize(u32 reg)
> > +{
> > +	unsigned long pgsize_bitmap = 0;
> > +
> > +	if (reg & IDR5_GRAN64K)
> > +		pgsize_bitmap |= SZ_64K | SZ_512M;
> > +	if (reg & IDR5_GRAN16K)
> > +		pgsize_bitmap |= SZ_16K | SZ_32M;
> > +	if (reg & IDR5_GRAN4K)
> > +		pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;
> > +	return pgsize_bitmap;
> > +}
> 
> I think this should include:
> 
> > +	smmu->oas = smmu_idr5_to_oas(reg);
> > +	if (smmu->oas == 52)
> >  		smmu->pgsize_bitmap |= 1ULL << 42; /* 4TB */
> > -		break;
> 
> ie it should return the supported page sizes by inspecting all the
> idrs and don't leave this tricky bit to be open coded..

This way was easier as each function only returns one thing, otherwise
we have to pass stuff by address as we can’t pass the smmu struct as it
is not shared between the drivers.
But no strong opinion, I can change that.

Thanks,
Mostafa

> 
> Jason
