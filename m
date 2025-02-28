Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CC3277037
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 19:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740771145; cv=none; b=Pwjiz+6bdFmN82o5hf9p3kgL6WbW0IXbesSB0C2Ww92f0WSWFOfLGZ0LDVojiUfJH+TZyMTioxmi5JSpYkrnkdCx/3+OPQpDlirN/VnsJJVXmxdAerX7+JktCpdtuT9fLlZ9ds1D3zDCkbta4dNfkQBbnKtdARIshSkEf9ITqJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740771145; c=relaxed/simple;
	bh=sUQoD/oUM2YIJUykZgTKKV8h/csrykSBi4575KKh/QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnC7cS25wFiXtlLfT+FAxU1e66QpmSL29YtBzD3zm3VcgpWCjeIZ2pEv6DIKfRShqdbudSCCvRL6tFVpLxPAk3YjRQgC0r9RTq1BAReIl8eIRzfOHKYlCm4tTg3iF0f4RrulhsD7OGbMXtSbMl7cHuSso2yRcgW7lT36eMWSZCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LBOTy3T1; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LBOTy3T1"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c095b5365eso165662885a.1
        for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 11:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740771143; x=1741375943; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s8ahLP6tau5z9zFvNaThnA7Wz1kGZZr7teXmDUhSLis=;
        b=LBOTy3T1cjgRgua1VqhuWBJhu5zYW+Xghy/RTAJE9O8ubRkmrGoyYUnGWMnlalHsrT
         T4qe4rNvCR9ly1K1DmVM61xGbJQ0661aO2NboTFPvXnSdHyaYADBPGjetsX69K8iAEEF
         MxuCZlXYBxcOwcAVEGMUpGS0YUeKO4OZzy2TbOdh1bED3ipG/r5BYh8PUP1o4HHt5p1A
         DpcFT1dUOrRXZ3VKwfGGAaVD3oASiUpGXmtN5IRgGbu3wZjYI0xYEUpSfWhiVzJF55i+
         ijac8Pvi/28HSfFV5Nn6Sa7hec0oPFXhyB3U+hAFu0mj2nI3Z4xFJT5K+5Qcp0x3FdS7
         N7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740771143; x=1741375943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8ahLP6tau5z9zFvNaThnA7Wz1kGZZr7teXmDUhSLis=;
        b=xAq704UvbuIksJQW/8geqGckrsCdEyZewka0ne787LtDpzYW0/eNBm9FwlTs8capqj
         OZmHLoab5B52mWJSDS0azlPMmUSL3vI6/qnRtQl934aH8CQG8boDBuFH7QWcUVfzlLnJ
         0Qh1p3qZCypfGXm8M1osGQ9KlS5PVOMiaJe5pBOwc5gB7bEmq9nbLEywFICP9k2BBL62
         MmENpsqkub4yRB9TCNy0rWaZY2vKdI+VXupkQljXXaBI1tuBzA2QOmX1cs4iJuaFIkNj
         R2R01wOB8RI2q5YIrgLezyEWkFU8cLE9/o1s6KY59uK8LXRdmXHZFVMWGByF390IQWM/
         HEbw==
X-Forwarded-Encrypted: i=1; AJvYcCUxnccwBsAQQcU0CxNDv+rZYJ0DdBoMJAfIoczgxWanlTj/ZS31gwmjCoWvpegQKSOK1VsNEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyagVbILkBpWMSa0cVyGW6PPhPnhehmtAoVaakdgJLnXgXkaSuU
	MjCRACGii7JliC+dJgFf9AFROzBOVLLTVwbgV4BGjk8Z9d/7G5iskaQOir5zM/c=
X-Gm-Gg: ASbGncsD852TkNmz6xjI1UJE8k/xyrsZRDz2tPNFznTHQ0IBMuzdKl6NExGO+peGSgO
	kwPBqEmL/GlqglX7uKG9XMRCYMbosAJGk1vFUqdNTAH2TUiOfHw7LT+mSjuhaPbqTDPNBUqnuKs
	AGCo7J7eLHHjk6eYKjNImW9p6H2dvcPlEjbIZg7cLFYsqZDwLMBzU2t5e9jO9NECr29w+WTv7QS
	HmLy/Jxn2bFEZZrkJ0EPKHwGo92vqYDG+b7SFWrIhwEg3+F2+X4hL4U6JlHaFVgFvqrR7GazWol
	aTJ1zx3oZ08ZARek3W6knPamA4wDQ9VMFQDQgGi++V85mdgp4c1mDo3Z87j1OgtGc7O0+3CuM5U
	=
X-Google-Smtp-Source: AGHT+IGfp/qlV0bFdQ4UlFF5bJNQ0s1CsbH7fJWc4GjD61AnOXb+ucW0858X/QRyI+8xsu26VjRTjg==
X-Received: by 2002:a05:620a:668d:b0:7c3:9d4c:8193 with SMTP id af79cd13be357-7c39d4c81bfmr429574885a.5.1740771142740;
        Fri, 28 Feb 2025 11:32:22 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976da283sm25082546d6.111.2025.02.28.11.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 11:32:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1to65t-00000000Th1-2Pej;
	Fri, 28 Feb 2025 15:32:21 -0400
Date: Fri, 28 Feb 2025 15:32:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: ryan.roberts@arm.com, suzuki.poulose@arm.com,
	yang@os.amperecomputing.com, catalin.marinas@arm.com,
	will@kernel.org, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, joey.gouly@arm.com, oliver.upton@linux.dev,
	james.morse@arm.com, broonie@kernel.org, maz@kernel.org,
	david@redhat.com, akpm@linux-foundation.org, nicolinc@nvidia.com,
	mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2 4/4] iommu/arm: Add BBM Level 2 smmu feature
Message-ID: <20250228193221.GM5011@ziepe.ca>
References: <20250228182403.6269-2-miko.lenczewski@arm.com>
 <20250228182403.6269-6-miko.lenczewski@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250228182403.6269-6-miko.lenczewski@arm.com>

On Fri, Feb 28, 2025 at 06:24:04PM +0000, Mikołaj Lenczewski wrote:
> For supporting BBM Level 2 for userspace mappings, we want to ensure
> that the smmu also supports its own version of BBM Level 2. Luckily, the
> smmu spec (IHI 0070G 3.21.1.3) is stricter than the aarch64 spec (DDI
> 0487K.a D8.16.2), so already guarantees that no aborts are raised when
> BBM level 2 is claimed.
> 
> Add the feature and testing for it under arm_smmu_sva_supported().
> 
> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> ---
>  arch/arm64/kernel/cpufeature.c                  | 7 +++----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 3 +++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 3 +++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 4 ++++
>  4 files changed, 13 insertions(+), 4 deletions(-)

This patch looks good, for what it does. However for bisection safety
it should be earlier, before the patches that change the page table
algorithms to be unsafe for the SMMU.

However, I've heard people talking about shipping chips that have CPUs
with BBML2 but SMMUs without.

On such a system it seems like your series would break previously
working SVA support because this patch will end up disabling it?

Though I see your MIDR_REV list is limited, so perhaps that worry
doesn't effect any real chips made with those families? I am trying to
check some NVIDIA products against this list..

Jason
