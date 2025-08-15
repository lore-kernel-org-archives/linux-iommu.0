Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BF72FB978
	for <iommu@lists.linux.dev>; Fri, 15 Aug 2025 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252083; cv=none; b=f/+b85RQZZpMr3d2fLt9in/v+yp8EvYJSivCY5VknWCTdffyEv+TGsoT9vL5+haft2sHcI2DbQNXlpY6MJVdiOQfUqR20jJ6MCvOoTWuOJtcMqPQibFeU17QmuniKZrNfNqRX0E34Hp4iZc+wAC/R+QeS0IGwUP0c0CeDplIbSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252083; c=relaxed/simple;
	bh=8FsMk8obAbD+bD00DJ3mYVUDhP/6yoGCi9VNK8VjAFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kv5IUKADTT8MtxF3jEy4y+NMV1egHyx9zVS1BTVKvn+/qR3WauAcBxA1L+ZXpHy7EPOYhTBdIULn9NF+WOolC4V9uRd0Kh/azcl5xt6xs8mi1kbz0YSunSalaoI3xVZtAE5MJa6djkw64N2KiATqUtsQgPJusUf2PKo5QIe/m90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=vr83j4M1; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="vr83j4M1"
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1230051EB3;
	Fri, 15 Aug 2025 12:01:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1755252080;
	bh=8FsMk8obAbD+bD00DJ3mYVUDhP/6yoGCi9VNK8VjAFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vr83j4M161TRumIMrKEvi+KvnRunX7jsFjaLirpQXvcspcrBGkXldm3ThsgnoZ5Qy
	 NCBKCI3ax+d6zc3PWT8F0CHJKLxateKkwvY8hc3Eo4+e15qlLuUPyP/PRniOY8IvuB
	 yAVNHniRaJjENv0Veyh6CzWG3G+RJqGjK8UIcMTtDLiNpJ9q2hKamIlXXNN1YaLuE9
	 QvRpPvOOMcbej3WQqTt36aH1OGxKMjXyHwDFKKQ4NWkdv0VseU59P9tjftFifX41Rn
	 ADnsERYP6xf08gdiO2QOZsZdsSJN3oDEZpdjDWU1BMTZ7Yimbf5NpSVu8EthNUeFxK
	 /LoYnW0ys8Liw==
Date: Fri, 15 Aug 2025 12:01:18 +0200
From: Joerg Roedel <joro@8bytes.org>
To: XianLiang Huang <huangxianliang@lanxincomputing.com>
Cc: tjeznach@rivosinc.com, markus.elfring@web.de, will@kernel.org,
	robin.murphy@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/riscv: prevent NULL deref in iova_to_phys
Message-ID: <aJ8FbvCJEOj2XjT-@8bytes.org>
References: <20250815071244.13982-1-huangxianliang@lanxincomputing.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815071244.13982-1-huangxianliang@lanxincomputing.com>

On Fri, Aug 15, 2025 at 03:12:44PM +0800, XianLiang Huang wrote:
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 2d0d31ba2886..0eae2f4bdc5e 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1283,7 +1283,7 @@ static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
>  	unsigned long *ptr;
>  
>  	ptr = riscv_iommu_pte_fetch(domain, iova, &pte_size);
> -	if (_io_pte_none(*ptr) || !_io_pte_present(*ptr))
> +	if (!ptr)
>  		return 0;

Zero is usually not an invalid physical address, or is it on RISC-V?

-Joerg
