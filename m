Received: from mail-qv2-f32.google.com (mail-qv2-f32.google.com [74.125.230.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EAF4E3222
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616466; cv=none; b=kzVFrylfJOeVb01IWy2Zv4lPl/l41fjudaH3mECxo8pFYmZslomMiWAqRzeKVddPgFjd1XL+C+rlpp7UVmL/ejvmYOHuL6XMJSaWiModfXQ4rSfWPpyzqqA+hW/zaXpx6vWqCldY+iN7kS5S7/Q0DD+qnH7+N6ha7f9J3+wQu/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616466; c=relaxed/simple;
	bh=v0Tvegi3Y0r41uqGe1gwF29EUW2tl7b6bRd3HIgumbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFgdwqt2QFMeyprww47z2mMXdZN0bJ3/0HcMGY8JCz3+ZuBKBXwzbFBFd6U/kRGsU8PMWrdR0YPiy/Tmq1dqMuGDpMt9MDyxaHUgfAxox9WJ68+Lfu1Y8w8kfAGP09c9wEntIBvf/MPnJM7IvTesfGW+QwQxEo5dHwbAd5nX/hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=P6i2U8EA; arc=none smtp.client-ip=74.125.230.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="P6i2U8EA"
Received: by mail-qv2-f32.google.com with SMTP id 6a1803df08f44-91782711448so2193976d6.2
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 10:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790616463; x=1791221263; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Snkhkpv5tfQYCAgHHo/k8kMLGqfuMfM+gSc1uL+OvlM=;
        b=P6i2U8EAbHXFOHGvkKP+Om9lK3tqhddORYaIjoQ+RoLN6g2Glp9z35s9zIMUPCLn1d
         blhfwiDIdAMsvLIgHt9XDAbF6BNTDYIyZRl2dtSrbWlPvzm/ofvyjOEfkO3l5MKc/2G8
         UmtRSSBMCkIm2/K6NUsC7LySwqLzeNiIOI88GFwqhhylqZOJLitQowjYctH1cIn9CQzs
         J9cEvVntmBdkRgKMk/i8ixtKo7RLTA4E0i35PRGVuYdau9WQkSylIKkyeM1csLFz4ZJj
         8tTcaAxYnq2JQYEqvSbxIsN0eZwd1nCUBUNjxp6Xh755rvUE6XsNYtL9OP3LI4pvb7Km
         0SbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790616463; x=1791221263;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Snkhkpv5tfQYCAgHHo/k8kMLGqfuMfM+gSc1uL+OvlM=;
        b=zdEDlKd9C8xpnYli4Oa6EKT5yEYO5msPhTAdsi03uUW0pgZwbFs9T8mj+Smc1wzziT
         ldrV6t5aA37L/iUYVTV38TXHvfbIXGtGbaC/C8u+us6z6Dgafa/8dJgBpzbaahz1ZWFY
         x6qA8XEe7+h2jogmvnrYi+TtQxuzd+kIjV/l0Kpb+5G/fWS8kko5QkLFqIaV9slMGb/W
         1PEDoYg7ekYQp0wP8QDCmJj2wY5x26+mMyoNPavmwENAwp9fpojFU5oRfBi1zVgKXPaj
         4Z1u9h45w+6zMM2eE6wVzEqs+m1tOwC+v8J4tz/ZkYVp/KlfkBTzD7YL1KWdhzN1jnfl
         udXA==
X-Forwarded-Encrypted: i=1; AKwUvBwncOJdC2AraT3Dm4ph+nSc8nmEoRyvN4Skh2avxg8rk398qnuA4NqUGLdSJwsYcZmIvaZTLg==@lists.linux.dev
X-Gm-Message-State: AFuF++lpHTF9aXeptlIOVOwgRZqOhvbRYh7lgRI+8hwFYXf9pRdaeHLX
	8u5GZi58U8cpn5ihDKV/tq3NGgExBNsBSE1vbjOBpmgbvGpCyI91CIZ6YL2cYKSFKic=
X-Gm-Gg: AYBFou2yLAADl9PiOCMzUZ/JYwlqqKyN5V0GZ1zihymevK/5GJccaADTxhldSjWwQEE
	HEKd9+CxUuYuQT4jcSeiIJjYps1qXQ4zldnuyE6ZkOhkBPeGIzFKiK+fahQxrhF7Cw/3e8njr9B
	r7zRI1Sl9t6Xnw2b7wuqOxeAqHcSWHiGuaEPa11eIYwSyt6RXtUjsz50qnXjuM+E8l8XezLeEHN
	8odaHNhTmKp/6ygTgH7IMWtfP/7YPIL1SFpFL7WPQpcCyVfvCFs2zNJAPCJdbk/OdUPD3ef25dZ
	0Z8FP+J1kzmO1NPFFc42H8ibuDOp7p+NE9a/2CI1qYUGd8+hcG+RWjGCZOWSVjD1fx7zAxa+YN/
	dMt+jYX67qKzP6fH+glIR/ZxzdqoD+nx6YZpSZzluYp9QfD0w+s6IzxIjVucAdzIUAO187vPAHM
	sxyelAXqp1f4mM0yFIsB6ibUDTuJKBEw+XdAemNfyOLJ/e
X-Received: by 2002:a05:6214:ca2:b0:915:e892:d932 with SMTP id 6a1803df08f44-915e892f966mr81063516d6.3.1790616463265;
        Mon, 28 Sep 2026 10:27:43 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9144b6335f6sm57161666d6.11.2026.09.28.10.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:27:42 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xBF8f-00000007NXN-3v3H;
	Mon, 28 Sep 2026 14:27:41 -0300
Date: Mon, 28 Sep 2026 14:27:41 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>
Subject: Re: [PATCH] iommu/amd: Make PerfOpt compulsory for APUs in identity
Message-ID: <20260928172741.GJ163130@ziepe.ca>
References: <20260928045050.955165-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928045050.955165-1-superm1@kernel.org>

On Sun, Sep 27, 2026 at 11:50:50PM -0500, Mario Limonciello (AMD) wrote:
> PerfOpt is only a feature usable by integrated GPUs and only in identity
> mode.  Instead of leaving a policy knob in amdgpu, just turn it on when
> an integrated GPU in an APU is in identity. Re-use the heuristic in
> amd_iommu_def_domain_type() to make this decision.
> 
> This drops quite a bit of compatibility glue.  There was a refcounting
> system, exported symbols, and device attach/detach logic.  By just setting
> it immediately it's a lot more straightforward.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  50 -----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  12 --
>  drivers/iommu/amd/amd_iommu.h              |   2 +-
>  drivers/iommu/amd/amd_iommu_types.h        |   3 -
>  drivers/iommu/amd/init.c                   |   3 +-
>  drivers/iommu/amd/iommu.c                  | 234 ++++-----------------
>  include/linux/amd-iommu.h                  |  11 -
>  8 files changed, 48 insertions(+), 268 deletions(-)

Diffing across the originals to net them out it is much smaller:

 5 files changed, 122 insertions(+), 1 deletion(-)

And I think this is much better , but I have a few questions

Why is this setting and clearing perf_opt in dev_data?

I expect probe to make a determination if this device has the special
path and if so then there should be a permanent flag in the dev_data.

Based on that flag amd_iommu_def_domain_type() can return identity to
override things

When the driver does an identity attachment it would enable the
perfopt and write out the right DTE for it.

Whenever the driver removes that identity it would disable the
perf_opt. These points are all marked out in the attach function flow
you don't need another variable to keep track, or the funny logic to
block things. All you want is an attached identity domain that is
"optimized".

Release goes to blocked which should already disable it, so no need to
disable it again in amd_iommu_release_device()

The repeated pattern is a bit much:
+       if (dev_data->perfopt) {
+               if (WARN_ON(amd_iommu_perfopt_clear(iommu)))
+                       dev_err(dev, "IOMMU%d: failed to clear PerfOpt on release\n",
+                               iommu->index);

Clear should probably just do the warn on and not return any error
code. It is never OK to allow this to fail..

I'm also scratching my head a bit why the global register needs to be
set/unset like this? Does that global bit completely bypass the iommu
for a single special device? With no way to discover from FW which BDF
is the special device? If this is the right guess please document this
in a comment around __perfopt_write (and again that's awful, ACPI
should have a pointer to the special device so the OS can understand
this)

Jason
