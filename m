Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250681EBFE3
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742541505; cv=none; b=cJ5MKJshGsnewU0obDzi+niN6jhp0eAUQjZLOyrW510My2X/3r7+jy7hOL9DVJ8jvfl5omCV3g5dQre0clSGzm4Cz0l+aqJ2Kdq08wsJ3964YLH6hsHlqR7r+P3Nhr0gtpbFHDSfkgmICs+XZpltAykUPE8xiAImjSZX/aPPYIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742541505; c=relaxed/simple;
	bh=jwHCvObC/KNyBTv0DiVjPXJVAqUfrHgLVnqxTMor9K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCYzKwbaWAyp/HJ2V/tr9USkyKMlKHCNJAJBErVpK3RuEH6FjPYYDT5hCN3zI6w2lNgyw9ambe5VhrjX8QolcoJYuOG3omUCpg2LamYCR3KFwIqeOR69zf+D+HI5sP7iP5mjs3i1wlZczECtjfc8/qKi0x2J8BKqeFtDY6T7oOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZhkQEZxi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZhkQEZxi"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2242ac37caeso91125ad.1
        for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 00:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742541503; x=1743146303; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jw2vNpybPCVuX/v6xAl+GdK1At9+x6m0OEpSnKsaMkU=;
        b=ZhkQEZxivSyILgn1qfXq1VvU66TEcvytwGPwbk1func11GUKrbU+rMwTwA7fAJV8GX
         6Y6mAvYbNrvpsrG393VmWENfe1WAdRK7QUKmyh+cWL03BdWEUoVM9md+cbk6QbfDhaTi
         NmpDpJLOpGkCySbnTmlmsQ+QE9aEQBjO9DFqiftQpJDVOMhqZP4XK1gI4q93XguZrNJp
         MbHib7X7cMEj/8P8LRypkkJbnMO11oVi6iLqVFQnsW6Y86TkWceHiRffVog1TxJDqNy5
         kWi8ZopublaMKVi3jfd6qerNUYvlIdKXN/s9PhCgQNSC1G6ADOQ4v/P0kHDbQgRdttBC
         2DtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742541503; x=1743146303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jw2vNpybPCVuX/v6xAl+GdK1At9+x6m0OEpSnKsaMkU=;
        b=u3VljM7W39f/8TPyxWB/+/vQ4FxoadBymbylAdQG6OXtwgobPiPEK1GYU25TsUHyEy
         epyyZGTSgcqcE4kRUgxzp+/bdj6VMXY0EMFEmqpMZCEgsz2s5RiF/d4WupxXv22Rnj9P
         yiQ+0IvyiT/6PTgmcQloNIglP1zMWgU4ds7SsFNRbF8eERcM1gjO2vxTQiqOJyvSQjB6
         seQiIyxT2pgEP+Ko+R6HYK0brBB83HUkmiIIf17tZG3Ujii5puHLiDYHYsv0uZ7NraYM
         sDAXYXbIFmO+xwYo/hNkz2T9rgs8kuaDoqgK47QVx99Dg+TrUwS/7/OcdhDSfw6/8GYY
         Lz4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZXJSuVnY6v2Cxe1Tc1/aa7jcCLxEg6N7FfZWnADjr2Me8x8FT1i/lFOeC83AqUy9eLtg0SQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDYh18lXr4JfI213Op+LIoCsfQqdS7hSGHEIrgAoPZv33nMUQg
	l33zDRT8l7YjVuJhAQjSm/qpAGq4SbRjESnAFd5Jx8MPdG6641hdEhhzSCdUCbntkUT8Gd2NVnN
	hTw==
X-Gm-Gg: ASbGncsf/F5euOQv6KOgZ5tP1OQPuNx1Tqoe+tuH2K/SliD6s3INf6EqVdpyKDBC8pC
	i2k59qBiYkJxPW9x22aq9LRQ4aT3GGRsCc2arPSnj/jzXt790tdenrxH9/75y63nse+T38w5t6d
	TKp7fH66QSsRaziDdYrV8nMqQvHYm94+Ahkbk5F7En+jd3G/oSNX6snuKmtlUtdR/FQjx8gTdqd
	RfKA0j0tVuOtDHaGMsZtGYycukYlndBBAze2WaWw4CAd6S7L7pDnlMVBnZ6QJYD6XrSDh0XVVZJ
	2QFR+ulWbHmhkKAGQrw50RkQJ7yVSnqtcJt8JNgLXsVcsYsw8bPzW1X6BjClE8GN4EtpRKfW1Wz
	/E8M=
X-Google-Smtp-Source: AGHT+IGKB7mjuTcB4qOfGRT8FLFl5rRI2m4ialLvr7Ln2GXnSWiW/ah0grXskxwzpysFlmKw1G3WUA==
X-Received: by 2002:a17:903:98d:b0:220:ce33:6385 with SMTP id d9443c01a7336-227844c198fmr1390535ad.9.1742541503101;
        Fri, 21 Mar 2025 00:18:23 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611d580sm1092506b3a.119.2025.03.21.00.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:18:22 -0700 (PDT)
Date: Fri, 21 Mar 2025 07:18:15 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] iommu: Split out and tidy up Arm Kconfig
Message-ID: <Z90St0D6hyphtOID@google.com>
References: <a614ec86ba78c09cd16e348f633f6bb38793391f.1742480488.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a614ec86ba78c09cd16e348f633f6bb38793391f.1742480488.git.robin.murphy@arm.com>

On Thu, Mar 20, 2025 at 02:21:28PM +0000, Robin Murphy wrote:
> There are quite a lot of options for the Arm drivers, still all buried
> in the top-level Kconfig. For ease of use and consistency with all the
> other subdirectories, break these out into drivers/arm. For similar
> clarity and self-consistency, also tweak the ARM_SMMU sub-options to use
> "if" instead of "depends", to match ARM_SMMU_V3. Lastly also clean up
> the slightly messy description of ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT as
> highlighted by Geert - by now we really shouldn't need commentary on
> v4.x kernel behaviour anyway - and downgrade it to EXPERT as the first
> step in the 6-year-old threat to remove it entirely.
> 
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/Kconfig     | 157 +-------------------------------------
>  drivers/iommu/arm/Kconfig | 144 ++++++++++++++++++++++++++++++++++
>  2 files changed, 145 insertions(+), 156 deletions(-)
>  create mode 100644 drivers/iommu/arm/Kconfig
> 

Thanks for this! It looks good.
I was able to toggle configs and build for arm64.

> +
> +config QCOM_IOMMUa
Nit: I don't have much context but:

1. Shall this be in .../arm/Kconfig? Is this an custom
implementation of some arm-smmu version? If yes, then maybe we can
update the help string while at it?

> +	# Note: iommu drivers cannot (yet?) be built as modules

2. I don't think this is true now? Shall we remove this comment?

> +	bool "Qualcomm IOMMU Support"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on !GENERIC_ATOMIC64	# for IOMMU_IO_PGTABLE_LPAE
> +	select QCOM_SCM
> +	select IOMMU_API
> +	select IOMMU_IO_PGTABLE_LPAE
> +	select ARM_DMA_USE_IOMMU
> +	help
> +	  Support for IOMMU on certain Qualcomm SoCs.
> 

With the above nits:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
