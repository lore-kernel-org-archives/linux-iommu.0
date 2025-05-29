Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3171928E5F0
	for <iommu@lists.linux.dev>; Thu, 29 May 2025 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748551584; cv=none; b=gKYVsGylb8JAVxureQhO+7lgprcBCl404gbV3BbS4CPoNJOgeWnAd1GZHcGjv5E4lOQN7Y52QDqntV8oUXOnQjAWLzck7Pj/AZHBCatYuL2wdhieyeQ+7k5gKe5RyVO4Df1I9V3hK28y7blY5NFnuKoyoVPiFYGwWaNkyhLOEA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748551584; c=relaxed/simple;
	bh=/6z1v/qNBfUFOoxicD1V48QdZQfp4IVH4S3L1yiqKHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GG/v2WNJjHQJxtGTpNnqkmK58a4+V4yJbrmeT3r6tweIDOuvcBlfvjNeEpeXAarg+K0eTI+Qoy4khcaCp8c3wj/3fomzADpLubVg5qubQyDi/28ScPTOopBk1LnNZTmUwLsQhxd5zjaROm/UdM26LcvgnoiwSZA84Ujf6WdRHyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=I0t6PiXS; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="I0t6PiXS"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30e542e4187so839540a91.3
        for <iommu@lists.linux.dev>; Thu, 29 May 2025 13:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1748551581; x=1749156381; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6TtaMd1HywfsuyRcNH/42AXM3iz/qus8mLnXbozVUkA=;
        b=I0t6PiXSoZrBF9J5KO5c/+TWwhbLPDqzCbnETq88BbHJPm/JDwrvmZ/8E/8s/2vcH7
         ghjD5okdEGDLVyuLJxOJp4VGX+y7J0PyeqPWffzJWl92rDOnFCFoVs4tVNd/41Zqw25x
         o57NpwVM74chDLx0+ulFXTGCKz23JhENKaFX/IKV98gYVzM0pq4aOT1jj5wXCM0OFShr
         60bbKWMLDPMpCO0YTzObVuWqVuqxAQfYxw0/vH5B0lF8EOdavfcmaRhb/9Xh78ZdfaVF
         1kaV9VTGps6KzYs55kZh0lPj/GmBF7ugYQjgukohSYZyElelLr1CTl4huFDqY+sDpdbv
         hzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748551581; x=1749156381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TtaMd1HywfsuyRcNH/42AXM3iz/qus8mLnXbozVUkA=;
        b=sANFSp+0MkQNB2X9/nDtJ8z4GIwvfnZILNVZR4qChwMIrINptGLLN3PiJLTExsd3/t
         +oAua2aTGIfC8WBRhu8CnJQeLf12c458h6G7CUTH63Y6kYAemFB4rB9DEhIrh32nxL+H
         +gvwkn8iXd4QaXtQqhqNPGl5E8PsBtfLaEI2xzgUXCPP4vLElauoW5AlPFTZSHY39zrr
         32VBYF966r6KgUdkgeYAGzPYPTj6/lJFtdZ1Ae/0CD9T81Bblh9b6jt3IV/feyeFXy/0
         9IaflzzXZfouIGmQYrBo5ihefopEcssDsq2clqzJEGfaiFtVWVj2Q1l+m1s2PN+2LJS5
         cbTg==
X-Forwarded-Encrypted: i=1; AJvYcCWgWHaKXXSL/zA5Cich04m0N7BMZfeZKLRzqJ+690SSGeW7a5CEAS+Umcg78P1rqwyAcslT5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtXF10zMQ5ftUQdKfAgaqYU6tFQffVFy44eMO2xbJw/l7Mx384
	UN2Hqb0rJvQJyaNI7C+zBHTwyZLE+2G/Ju5c6Ipk6QdlTXFM20aHnrIlmKvuFZS8PkU=
X-Gm-Gg: ASbGncub/am963ks3hNvCy9piM3NtsGmCFNbSpzqHyf6I6C4litp0o5zV7VQKNF5Ovl
	uBOhLx85SIhwMz0+DE2Q27sdUPQX1k0kPWbNqdFkePa7/3cO6RnFKoF4d4AszKdHN7DFAyqt8jK
	mkt6+sP4pRwFGrpWYoku8leWbPzoj/QNk7GwgbvUDnADVYDnfJTH9p+foBD8otOfMrc/kJ1H8lk
	fRSRO8snfFtsI8qxVn/uljkaZoYbhrforZiGmA73CoWPg3t+HxwrqXxWY1cdYA2BPWerSl91S4h
	6RLhS5xIgFweVKQpi6Po0DUJ/FgOUauBgJXeQruUJCMzac/0xDeWcXQLkLMjQY/U6mVvyA==
X-Google-Smtp-Source: AGHT+IEO8HwssTrnrLL8DGNfi7UDT2JfkJIUURFRStahz0gCmflYidew8g3m8w3QvBPF+GZDsBP2sw==
X-Received: by 2002:a17:90b:1d89:b0:311:f99e:7f51 with SMTP id 98e67ed59e1d1-312415329famr1432137a91.18.1748551581341;
        Thu, 29 May 2025 13:46:21 -0700 (PDT)
Received: from tjeznach.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd9486sm16245345ad.67.2025.05.29.13.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 13:46:20 -0700 (PDT)
Date: Thu, 29 May 2025 13:46:17 -0700
From: Tomasz Jeznach <tjeznach@rivosinc.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Alim Akhtar <alim.akhtar@samsung.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
	Janne Grunau <j@jannau.net>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Neal Gompa <neal@gompa.dev>, Orson Zhai <orsonzhai@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Clark <robdclark@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Sven Peter <sven@svenpeter.dev>,
	Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, virtualization@lists.linux.dev,
	Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, patches@lists.linux.dev
Subject: Re: [PATCH 3/7] iommu: Remove ops.pgsize_bitmap from drivers that
 don't use it
Message-ID: <aDjHmR7ZVTbsSITO@tjeznach.ba.rivosinc.com>
References: <0-v1-7c5282b0c334+2db-iommu_rm_ops_pgsize_jgg@nvidia.com>
 <3-v1-7c5282b0c334+2db-iommu_rm_ops_pgsize_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3-v1-7c5282b0c334+2db-iommu_rm_ops_pgsize_jgg@nvidia.com>

On Tue, Apr 29, 2025 at 11:34:13AM -0300, Jason Gunthorpe wrote:
> These drivers all set the domain->pgsize_bitmap in their
> domain_alloc_paging() functions, so the ops value is never used. Delete
> it.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/apple-dart.c       | 1 -
>  drivers/iommu/intel/iommu.c      | 1 -
>  drivers/iommu/iommufd/selftest.c | 1 -
>  drivers/iommu/riscv/iommu.c      | 1 -
>  drivers/iommu/virtio-iommu.c     | 6 ++----
>  5 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index bb57092ca90110..2d0d31ba28860a 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1533,7 +1533,6 @@ static void riscv_iommu_release_device(struct device *dev)
>  }
>  
>  static const struct iommu_ops riscv_iommu_ops = {
> -	.pgsize_bitmap = SZ_4K,
>  	.of_xlate = riscv_iommu_of_xlate,
>  	.identity_domain = &riscv_iommu_identity_domain,
>  	.blocked_domain = &riscv_iommu_blocking_domain,

Reviewed-by: Tomasz Jeznach <tjeznach@rivosinc.com> # for RISC-V

Sorry for the delayed response.
- Tomasz
