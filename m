Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA95433A5
	for <iommu@lists.linux.dev>; Wed, 30 Jul 2025 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888041; cv=none; b=c5mRTm3iEBcQBRzDFjamwX35rPg3/JmufPkAQ4eOAGXgKrdgXZJmcN0++qebZyW/PX2yP2a7mmad/uTRjBSVTlN9TSktlBOVnIv2iraG9WvmM7+ghpxuViX+q/czz5AF5MJFLpDaYm5FF5trYqVFA/YpliPU3RjkWFU64mo2xRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888041; c=relaxed/simple;
	bh=dCek+LVoEASGAo11jE4aq2PC6g9GeAbOlhCDXCoh3U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUa9YBOlVoQuch0UwpS3T5TBmqNi+JgxcHyttO3cX+Bl7imtaURQvAz+hlwG1ttukIexRxaTFOu0GWqu6a+3pQtsCEOkO5TJYxiVImJUYNYp4I9NjLCB61khHWmWOpgNvuCuiASRkWCj2zm+VLtWvmCF8cl1FUWHcJ1h3lEFB3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ta0Zs8wF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ta0Zs8wF"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-456007cfcd7so87425e9.1
        for <iommu@lists.linux.dev>; Wed, 30 Jul 2025 08:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753888038; x=1754492838; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FwnA2oNKgnZXUtMiDazVBO1hROK96MeArFT9225UuGA=;
        b=Ta0Zs8wF5JGZWIF2MESj238/IK7jWJexH3CR5VIZ/ghSdut1c4kdBAoq787lI3fR/3
         VsTiVBgJXWGt5pj1SpphFMcnnnq+TSbJAI2aLVXWZawutJ4e1JR/On/CckF0cAI03Z5H
         pUiaIz4/PpBZthYgCnhkeej+rblz0/LDOkt1poG1RvNw58e+WK0TYzjncl519nAwhM0w
         lWSYKXDtRMD7431ECgpJ3QBbkXH9qyNnx2NDmwCKRFkTqrZR+r8OlIzcITwOIrx9Pmy0
         /r7yCqpPp7b7buAsrDmF6ZVGXI9SzZ4ppdXba3geZMlhbaOC9kBvXAGFUSjwU+x8HQXy
         nwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753888038; x=1754492838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwnA2oNKgnZXUtMiDazVBO1hROK96MeArFT9225UuGA=;
        b=KTM5aPSRkPEI79hYmJKgRVy6b6TsnvefVN3PMaiud+PUF8uHFB3gA3QAhQztWFgJnc
         Be7iPmg6/aI5J6jyNwuuOp9Xm9rMjlBJHWNiYGic1V3rKT2CKs9nq4T+Iur6qs/+bTN9
         c1QDmCgB5uysQkWwWpK+fflxZa4SFhTJiPLp7LgrkSS7ACyrhBDoT1Je0GWKareUxZZj
         xZpQdgXJi/TKcOlGWheSr9h/xIYsMyXOJ1Yd5g13RynKfNHzn6Qb9fzeHn74CBrpqvvD
         rYwOyfluQ9/8mCSkjjf86DRTtc2wJTpeeOxoE3lrHrRi8Ns06mIozV0zxFHzVIvQ1X0n
         XdBw==
X-Forwarded-Encrypted: i=1; AJvYcCV2KvH1B25WWtXPIutIR9oiAJwrdz0D7J+lFiKdE8Xt2ruv1pEB9eRlhJkQFxUbUrE1Pbem8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzU7I24Y/uKEe1lu32tA0o81TGSLsO7VwFpkVGBQ1VaiPOXNDYn
	X/ooofYn46JsBIzDP6QT65GDJ39AH9lFSeRu4JRL1qDxbN+aQprpxLUjYrDFzShynA==
X-Gm-Gg: ASbGncv/YNdWjAX/P2FgS62AqDcA7Pkfpzh/9KFNqjeLUnp5f/COTci127eFy02p7Ia
	oEDL6A4KtzEVYYedtt/8DGQBuX+QbPopRLFmHcjFuQ+udBp0Chh4QOxgE38KvZQBdS+8oewvpzZ
	L67LjOAPk27FPN1MoAfAbeNrd9xsgErO0nOlXpuBN8Nt5223JL2JotGmvJBS15sGVEx0lJE9xcC
	2/gLODRT0Gc3FtD96wHoPX+N7g2Mlj8qZsJx/trzoFHJUEvmVLF7Jh1gmg1mbhIvpNzBQ6UQhYN
	5mHeFkUWdXACStsyUysD2lZCTSinZGXjkDvvNrUVOc6T6HbDaATQJIRbdV2UUeUI8QWVrVt8Z+U
	QhXk9U6C6MzZ6n8fCFL1UNAEuFB02ZP11L9TssF70j37YFCfoPJ2tIHoJB5iC2fe/GNQD
X-Google-Smtp-Source: AGHT+IFXd4tj1Gi+aSqsAPlyaWZo7LbAx7OS/cZ5blys8+9sDywLpzMvfiK5whFAaT6QiTiBqgdEJA==
X-Received: by 2002:a05:600c:8b66:b0:455:fd3e:4e12 with SMTP id 5b1f17b1804b1-45893a978a1mr1755975e9.4.1753888038295;
        Wed, 30 Jul 2025 08:07:18 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588ee11c91sm35868305e9.4.2025.07.30.08.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 08:07:17 -0700 (PDT)
Date: Wed, 30 Jul 2025 15:07:14 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v3 29/29] iommu/arm-smmu-v3-kvm: Add IOMMU ops
Message-ID: <aIo1ImP7R7VhRpVE@google.com>
References: <20250728175316.3706196-1-smostafa@google.com>
 <20250728175316.3706196-30-smostafa@google.com>
 <20250730144253.GM26511@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250730144253.GM26511@ziepe.ca>

On Wed, Jul 30, 2025 at 11:42:53AM -0300, Jason Gunthorpe wrote:
> On Mon, Jul 28, 2025 at 05:53:16PM +0000, Mostafa Saleh wrote:
> > Register the SMMUv3 through IOMMU ops, that only support identity
> > domains. This allows the driver to know which device are currently used
> > to properly enable/disable then.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 92 ++++++++++++++++++-
> >  1 file changed, 91 insertions(+), 1 deletion(-)
> 
> Can you split the new iommu subysstem driver out please? I think I
> asked this before.

Sorry, maybe I misunderstood, do you mean split this patch into multiple
patches or split all KVM SMMUv3 driver out of this series?

> 
> This series is big, reviewing a new iommu driver should be done separately.
> 
> Please review all the comments for the verisilicon driver, I think
> many of the remarks apply here too:

Thanks, I will go through them.

> 
>  - Domain attachment looks questionable. Please do not have
>    attach/detach language at all in the hypervisor facing API.

I am not sure I understand this one, the hypervisor API has no
attach/detach APIs?
We only notify the hypervisor via “enable/disable” hypercalls when
devices are attached or released (as only IDENTITY DOMAIN is supported)
so it can enable or disable translation.

>  - Get the ordering and APIs right so replace works. You need this to support RMRs

I see, we can’t support bypass for security reasons, but we can enable
the identity map for such devices.

>  - Use a blocking domain not some unclear detatch idea

There is not a single detach in this driver, we only support attach and release
operation, which just goes to the hypervisor as enable/disable identity.

>  - Use a blocking domain for release

I see, I can add “blocked_domain” similar to “arm_smmu_blocked_domain”
which just disables the device translation, I will look into, I am just
concerned it's more code as this driver only supports a single domain
type.

>  - Use the smmu-v3 approach for the fwspec, don't store things in the drvdata.

This is using “dev_iommu_fwspec_get” similar to the SMMUv3 driver,
am I missing something?

The driver only save the "struct arm_smmu_device" in drvdata, which is
exactly what the other driver does (which allows us to re-use a lot of
the code)

Thanks,
Mostafa


> 
> Jason
