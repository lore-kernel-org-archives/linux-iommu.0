Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDC71D3648
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 11:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116421; cv=none; b=ZCEozsJnOBg/AejLkpPR+ericxDPj7PYZGfk3M4S9TsJuA8yKdqWltqcZ+G8hmuSc7VOgDv8D13DYoSDLiLYCdi/7N1X72u28A3B+7a26uG7w3c+s2aKjF8E/yonPvvKyb6RXXYmeuJ4OQ+7C3Atb/RrqOjdVJZ+serromRUNCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116421; c=relaxed/simple;
	bh=6QkgyBDKShlQ0y/cx9QH4amUPnbLqaaOreh4ogVY54Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6ko4ujE7CSNp6VVw86XwJ0vrhsyn4HGQDoeE2zvG2bkB9msPVr3kboZmBHpevn0F/45JXOOBYL631XPBpgAeoFAFjiL4Nfj/lCciz4K4jKAJTT6CF2HXyqb86FrA/JwbrN4cWxTTVdEH7fi0i4RQUqbL3gk1Y71pyZYfkqUlek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RBBTP2RU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RBBTP2RU"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so148105e9.0
        for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 04:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730116417; x=1730721217; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s8ohfpnIEvg7feisWnyEQsAMOz4YBMRZ4DT963EvlJY=;
        b=RBBTP2RU/jxVMRQ4Vv22cCLCiebTK7ea4VlLlrf9wK1K9d38Q2PMTsA2EQ8I0WaHjI
         mdWxc8XmGkeJlj1dBY142q5O1YW0/Y13JwL9iJ2QsSBzPClJ098AF8DwvCAJbqWzfTwr
         3Gw0oOdSSWENV74IGyPyCdHmEBSgQJV9l+Ato8oW6Hr6Ob/17MlhuSZmJUQDxOEPNGag
         G4LQ+U3K1IE1H3T4jt5ElCwGA8KhLyhBhfPVezJhe+jSn0aaajWNf1TCB3MRpRg2FFxh
         rovgrm+mcAs4xOZRMzN11LrfWHPiObsi9U5ROuPT7aMTqRFmw327Tn4bK+IXhxJCZGur
         8Mzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730116417; x=1730721217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8ohfpnIEvg7feisWnyEQsAMOz4YBMRZ4DT963EvlJY=;
        b=vvoB7MtP5jMmhwm+eQHgYm9yYwdUY077ySaUhLzcjFIPLlcWRQmJzXlRm7k1l3s8R6
         tiIGaUecJUZtvQnMtySSZ78+9bPV4vL2pbEmC/KCIuBl7owkMOoRMuAXp2UfURecGwJ8
         tqYYi1en+w9pN18QwdtZ7C5o74uGLdYY7osBTlVDLWu7RbhwZZISCm96D+2JSe/QHVx1
         xfQa2rCP4OFJR3BE/eQSfsLpq+/WAyue7kcGM3NLbRDAAiEj2VjuHnrgzMbqEL6pVeig
         uzTs7g7GZH9Aby9LqSEiqiFuEqjqRu2asUa3d0Rguy5wPPu/weNKkaCyNgyIv24H45S7
         nxFw==
X-Gm-Message-State: AOJu0Ywm2pEINcRK3SU2tihPMFPtw321E/Jy4m7PORQ6hhxmoW0ahf/K
	iSaMd+xE0+0A1zp20iL4VrZF206l4GuXX6oiiC2jov7SPSifzuKDZNh4aM14HA==
X-Google-Smtp-Source: AGHT+IFAG1wQgZSHD4GZ1FDVInCNhg5i9ZX5wl+jOWzRo1tsON7IOnOTabrNuttxFekm1NvUnzUp2w==
X-Received: by 2002:a05:600c:1e8f:b0:426:66a0:6df6 with SMTP id 5b1f17b1804b1-4319ab034e8mr4472705e9.0.1730116417455;
        Mon, 28 Oct 2024 04:53:37 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4319359527asm106666165e9.16.2024.10.28.04.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:53:36 -0700 (PDT)
Date: Mon, 28 Oct 2024 11:53:33 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	"open list:DRM DRIVER for Qualcomm Adreno GPUs" <dri-devel@lists.freedesktop.org>,
	"open list:DRM DRIVER for Qualcomm Adreno GPUs" <freedreno@lists.freedesktop.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joao Martins <joao.m.martins@oracle.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	"open list:DRM DRIVER for Qualcomm Adreno GPUs" <linux-arm-msm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sean Paul <sean@poorly.run>, Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v9 0/4] io-pgtable-arm + drm/msm: Extend iova fault
 debugging
Message-ID: <Zx97PU7cUEVCnpPl@google.com>
References: <20240827181717.187245-1-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827181717.187245-1-robdclark@gmail.com>

Hi Rob,

On Tue, Aug 27, 2024 at 11:17:08AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> This series extends io-pgtable-arm with a method to retrieve the page
> table entries traversed in the process of address translation, and then
> beefs up drm/msm gpu devcore dump to include this (and additional info)
> in the devcore dump.
> 
> This is a respin of https://patchwork.freedesktop.org/series/94968/
> (minus a patch that was already merged)
> 
> v2: Fix an armv7/32b build error in the last patch
> v3: Incorperate Will Deacon's suggestion to make the interface
>     callback based.
> v4: Actually wire up the callback
> v5: Drop the callback approach
> v6: Make walk-data struct pgtable specific and rename
>     io_pgtable_walk_data to arm_lpae_io_pgtable_walk_data
> v7: Re-use the pgtable walker added for arm_lpae_read_and_clear_dirty()
> v8: Pass pte pointer to callback so it can modify the actual pte
> v9: Fix selftests_running case
> 
> Rob Clark (4):
>   iommu/io-pgtable-arm: Make pgtable walker more generic
>   iommu/io-pgtable-arm: Re-use the pgtable walk for iova_to_phys
>   iommu/io-pgtable-arm: Add way to debug pgtable walk
>   drm/msm: Extend gpu devcore dumps with pgtbl info

Do you have plans to post another version of this series, as I am
working on some patches, that would use some of the common page walk
logic, so it would be more convenient to have them upstream.
Otherwise, I can have your series as a dependency.

Thanks,
Mostafa


> 
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  10 ++
>  drivers/gpu/drm/msm/msm_gpu.c           |   9 ++
>  drivers/gpu/drm/msm/msm_gpu.h           |   8 ++
>  drivers/gpu/drm/msm/msm_iommu.c         |  22 ++++
>  drivers/gpu/drm/msm/msm_mmu.h           |   3 +-
>  drivers/iommu/io-pgtable-arm.c          | 149 +++++++++++++++---------
>  include/linux/io-pgtable.h              |  15 +++
>  7 files changed, 160 insertions(+), 56 deletions(-)
> 
> -- 
> 2.46.0
> 
