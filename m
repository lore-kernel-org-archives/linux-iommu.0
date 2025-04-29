Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379E925F7AD
	for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 21:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745963279; cv=none; b=Wmd/V09LtCUythuZMrMdOxK8WcLRhh/zeJK+X9c66t/AG15qmXywmVfujnNFbhWZ1XDmt+vXBUxUEpWkN2Fz+XAIhCcltPD9jmGJLjJTxJqD/t882Frz6MPwu9Tao1TcmE2QMCOkkSARJ81z0EmKgA8fyPfsHJt/oHSY1ZXe9CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745963279; c=relaxed/simple;
	bh=Duhnxo2adP6UJYufvvUxQ7vXQx/l15K0ZRqltJQCe/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrfL06bloiV3mScTAqMNnGxCyU0kkj038fnajbkvBjIYtOE3u0wiaYzsrPAsB6BGZIcwPSGOIRAbmrOey/Jovi6L/00kc6Xji4Zv35e9Cc8fX6hF1LnRThaXNqpBjC6xe7e9QFGJ2DgWvl33P6lSOzwNo9mfq4FhQisWXnxLvuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mhkicR1o; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mhkicR1o"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2264c9d0295so240065ad.0
        for <iommu@lists.linux.dev>; Tue, 29 Apr 2025 14:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745963277; x=1746568077; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lCmXc+ODhBacc+4C2xK0F/Ie+nOBoW/7aTrNsgbeX88=;
        b=mhkicR1ov5ciLJhqxO/kbv521kR8r+0Z5S9/x/1oU4Zyjc5qCZvjEgE4ZjNpS1TMle
         cVEJeWqXVmYgoUZLQ3w2cnY/1CZnW2QijkKzzxULubNtWTCB8e+gUuG0sB2TheDwsiAS
         KSeinml6aRh40lUEVUTdkeIxVgLFoZlhoFUPQuc+a0UuvItPTZCqwNeybm+3nHfjZrjJ
         sL069iMqtQj19pbO7e6VONBtLu6WrSkgB0nUepUZWks2hWjD81p93oCWhRn+DdU8dKN3
         Ff+9VgSZx3ClXFe72bzkX24Ebr1+IGL1o5VEY4eXivwcTeSXkTj9iwNgiqg3hJRLcOci
         djhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745963277; x=1746568077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCmXc+ODhBacc+4C2xK0F/Ie+nOBoW/7aTrNsgbeX88=;
        b=ddcTF7Jr/o62J98wtW0BrY5M89DUY2i7s9d+Ouguf0JL3M5I9E7F3nr8fXTvMxXegx
         ZmTm69EbHihP+bdLBjfbD4X5uWz5aVwHHU+/61ZGNwYs43yRDfRaqpjMjiIB4j8g0mA3
         XglrVOMgZjqALk7kP2qWivZtfRUu4Z/AxCd/y2zOcqFdaa7u6qkgvlixkkHV6GfACv6A
         y3J/cXCpX7xfnNkN+HGvBTafXe1wc+W8onTPSg2AmRtq8vC/dcp3AiWRZUKX7paTyLAY
         lptn+Isr7O37mCHHr2FFyQ9eliv22kzUiRY9eP7MaiKbUHf4eKK0t/fkdC+1+g6nrmk7
         kw3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvPJM8hhqg/tKtGEOpcB0euIxy4UfhKx6lVUcpJDclcdE47Frf6UExYCCKAGW460wkoDGu4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAy1GBXkHcN5PVSvFi1UYtE9MEuKSWMpojoXKGN2U7zlsnkdDq
	0FaH21ebOCTf3p97pTUJ3B62r5zzGddW2D+FZb7hORitA1evZnCtXdzxbJ6b0w==
X-Gm-Gg: ASbGncvruylXSQmnft1ovsRiSOrlvQ/V1BzAzu4iL3RyN3ycswL+6tkKHgfxE55LmX1
	+yntTZctfRaBjW6Be3LIPtp6XrfzXFCqFMrStjqBDxc8u5lz43plHwsoLSnKoJaaD7UFKvakhfZ
	s/J6wGUHpXUcl2Ff7d+oA5IVBSc/2nwkh+kuP/foI9o5bvcgJkwquPOoCbanDF7xPJZPMuyfhYq
	KiGfR3zZjw7g1D02QJ67ZzkEnv2IyqJZBN2HvwHSDiC3rx+VZLrPFebGr/uEs/KLMx18jAW5/QQ
	HEzUqBU/uBlPZuJOBUdH9uJM+Cci1CWWxlIMOEjtEr2sNjxSnIlZQWendZGgDT3EEH9Kykne
X-Google-Smtp-Source: AGHT+IFMqCAjaX52HtimqP3RondUOuNsl/Pw968hKtIW8LO6HydfSjoFrb+e/I5aVwqY3qXA13e21w==
X-Received: by 2002:a17:902:f649:b0:216:7aaa:4c5f with SMTP id d9443c01a7336-22df53e42e4mr308665ad.3.1745963277038;
        Tue, 29 Apr 2025 14:47:57 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a34a119ffsm32042a91.21.2025.04.29.14.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 14:47:56 -0700 (PDT)
Date: Tue, 29 Apr 2025 21:47:46 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v2 18/22] iommu/tegra241-cmdqv: Use request_threaded_irq
Message-ID: <aBFJAhpnPoUh-wQC@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <fb97e2407ebad5240f3981bbf4121a75ccd1ea57.1745646960.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb97e2407ebad5240f3981bbf4121a75ccd1ea57.1745646960.git.nicolinc@nvidia.com>

On Fri, Apr 25, 2025 at 10:58:13PM -0700, Nicolin Chen wrote:
> A vIRQ can be reported only from a threaded IRQ context. Change to use
> to request_threaded_irq to support that.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Acked-by: Pranjal Shrivastava <praan@google.com>

> ---
>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> index dd7d030d2e89..ba029f7d24ce 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
> @@ -824,8 +824,9 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
>  	cmdqv->dev = smmu->impl_dev;
>  
>  	if (cmdqv->irq > 0) {
> -		ret = request_irq(irq, tegra241_cmdqv_isr, 0, "tegra241-cmdqv",
> -				  cmdqv);
> +		ret = request_threaded_irq(irq, NULL, tegra241_cmdqv_isr,
> +					   IRQF_ONESHOT, "tegra241-cmdqv",
> +					   cmdqv);
>  		if (ret) {
>  			dev_err(cmdqv->dev, "failed to request irq (%d): %d\n",
>  				cmdqv->irq, ret);
> -- 
> 2.43.0
> 
