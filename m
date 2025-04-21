Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFA0219E4
	for <iommu@lists.linux.dev>; Mon, 21 Apr 2025 06:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745215272; cv=none; b=U0oR/wEq7vtCQEr3b1nFgRZ1oV8AtBnfpZ4lrPyB+X5HAWKVPjT/iQZRjCoKa75qFWmB3BbLhQWslNNIp9qzsRYc6/XbZIRqs76QXc6v5EbLeucE9GaPbQ0I98VVc7GZM2gVXzpkAw45SkhP8g9Rz5z8SZ3QFa5F0uktnHa44DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745215272; c=relaxed/simple;
	bh=Qj1s8hJ9DXiEm9MNH49j1b4bMmSc2pA7qd4oNUeIcbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ixSzh3TdewogNneRk7zr1IvS1CDRr7p/7NZ0xWD8RDDn4oFdo2mCFECd1dPZ/kX5WRsSzq4QkZUEdcvw9b2NrRca1FsznVkcHOBb0h6yzZaS1NOwMI2Hcx7v936A+aQjXB8xjSByxiSniXYjS0phrxbnTbiGyA5mIJUeL75Vwww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c+X4iAYc; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c+X4iAYc"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5499c5d9691so4182249e87.2
        for <iommu@lists.linux.dev>; Sun, 20 Apr 2025 23:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745215269; x=1745820069; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qj1s8hJ9DXiEm9MNH49j1b4bMmSc2pA7qd4oNUeIcbI=;
        b=c+X4iAYcSzXA/Bfx0ZhPx5l2Ea3E/mv4vWWpYJJ/zz2sPXl217XpFGdEdAqFPhAOKL
         gnxXXBiwMw6nsdZLgeJL44oo1VTAnMuci5DD+kyKxh8b9VfjVTH17WrBkMRf35mRcnhm
         KOPXMRTbf/Rjh8AEcytsVmfs78yrTUdUOZz0I3Q5XP/rsEZV8DvB8DqSKXiHiCH5ZOV3
         397L+pmeYNbfyfzac2NK7lWIy3z+ejk7jvrWldWDoemdJdcsZTjhmmpIyJfgd/WMfKLX
         XcP8BkCo9vh76zVSgKJ+kol9lssNvtfZ2TXJOztpwZTIsytrJfF56wHWW2x6zstWc+qi
         acKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745215269; x=1745820069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qj1s8hJ9DXiEm9MNH49j1b4bMmSc2pA7qd4oNUeIcbI=;
        b=j22mBzzP+TqAWwecQqSCnij/Nl4U34UeILwlQC56GlSBD0pGnVz5KIxGPX1fvR+M6S
         oFt6MI0UJwGhc4gIXKihfFsSF3SOHtTDpwIxyMS43cTNDCNd06tiAA2BgLTVa3GDKWEH
         cfpGtzhIQSJDtIFmQu639TzzJiwrFkHRlbqntJtyzfHoRkGhl0YmDmM/rTCjSxa3zaO+
         3upVXkGdmo+pOhj36qK/K2Faac6PyotVM22jHcZaPZt5OOcWdCvRSqAIM91s6e+ifkK9
         CZHPFEaSYLWmQAOWO5LZ/9XtgksBrYu8NZgV7k4j0FFPizZB1ARA2HkQ7eY3Tg7amhx3
         Hedw==
X-Forwarded-Encrypted: i=1; AJvYcCWGtvKkaphejmMWmteV8+3LageVHvwdFq4VsL693F/i7pwm9v918/5vu735hlrNxVB3EGUe2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQOSztc2eRWp+pNBr/JMFXm1YjJXdZR/eTEC3surd/9aBbF+OO
	21ERpMkJd5dNp4fIYwj014ozgL1izP31lBksmJaNRBw0vr9OxQ4orlknlJq6RPBdM784RL+DZHd
	qP9x9OJSaRl68DIWi2NnXyygvWZX1FGv2NgFp5A==
X-Gm-Gg: ASbGncvR2y5v07KbRZDd/8EsD9C1d4s6uYOFnBTIWdBypwYQl4khGGpU/gUr3RJipMu
	m0C8SCGzFv731c/nKhUlrTJpfIrA5EvPbH91aijTc+soZEmpaKNxoBRpysNkkAR5tWaqMMO/fuo
	scL64HwCbon11j+hNJVegIMB8Plw0=
X-Google-Smtp-Source: AGHT+IFpdIjOtEnxzjKCdjSva/bFhUKuTrOh7qIYruUBQR/M2P/bhrI3sjKrLZhTnHSoz7nebIh9KQbhGyVxmzuzWZo=
X-Received: by 2002:a05:6512:3dab:b0:54d:6555:44a6 with SMTP id
 2adb3069b0e04-54d6e65777bmr2612352e87.36.1745215268658; Sun, 20 Apr 2025
 23:01:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250418080130.1844424-1-baolu.lu@linux.intel.com>
In-Reply-To: <20250418080130.1844424-1-baolu.lu@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 21 Apr 2025 14:00:56 +0800
X-Gm-Features: ATxdqUF2Hbg6JZF5AMHnIGWAfLBf6Ntwc6Ex8d-AAeUImsUJKzLj3aUJE2ShbcQ
Message-ID: <CABQgh9Ehp+mMyHLzCrpkMN88mD8+T9144Nx-YtyVez7Rq5h76A@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] iommu: Remove IOMMU_DEV_FEAT_SVA/_IOPF
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghuay@nvidia.com>, Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Apr 2025 at 16:01, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> The new method for driver fault reporting support relies on the domain
> to specify a iopf_handler. The driver should detect this and setup the
> HW when fault capable domains are attached.
>
> Move SMMUv3 to use this method and have VT-D validate support during
> attach so that all three fault capable drivers have a no-op FEAT_SVA and
> _IOPF. Then remove them.
>
> This was initiated by Jason. I'm following up to remove FEAT_IOPF and
> further clean up.
>
> The whole series is also available at github:
> https://github.com/LuBaolu/intel-iommu/commits/iommu_no_feat-v5
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks Baolu for the re-spin.
Re-tested OK

Thanks
