Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447F430AAC2
	for <iommu@lists.linux.dev>; Sat, 10 Jan 2026 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768040127; cv=none; b=NnnyBWSrTR6cfMF+2t6c58iyh74J00EUslLrhwcEqaIngLZ/5MXcvtVzDGPa7aJ4Rsib4o9pkjTqO2GybDy6Nj5JM9hiphEYciR4/fV0xGmJFmHlnsP5rle9o1q7LLnGtTnlv4/oCCNMvf8k5HWDHYfoldcfgkdzJhWDEkkN2xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768040127; c=relaxed/simple;
	bh=DEa91GITfQq0xAVB+V/DgqtSoDnyax4wWtgfjH6t8uM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKUzzppFbN4FxDzWL/EgtY+DDlgFaq7Ju/q0hl1yu51ZYCilaBp4Kg8VGL0hV1nHu9CyxtB0jnMlW3rzyTfm1on2jfNSPp8DVxNWl9cIyZt/cNfNr4FyDrSv0bgP1TBsLp9Ht2qsM55YDXjmzOrSM7v+krG/h36OXCCrkb5cfK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Ud8NMZhy; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Ud8NMZhy"
Received: from 8bytes.org (p200300f6af1d9600dfc71246d978d903.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:dfc7:1246:d978:d903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 3F7775F02F;
	Sat, 10 Jan 2026 11:15:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1768040125;
	bh=DEa91GITfQq0xAVB+V/DgqtSoDnyax4wWtgfjH6t8uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ud8NMZhyj1nHny1wbIBrGssjRuCb1dW7VFjpM/keqBgJnLyv3776aeabfED/z1Qvu
	 JkIjqElEnXbjIk18PlmVUjkX95XdurmdZZy1vLKgSlH3xWZ9SaQHxzHY/cvcxMvB4j
	 6gEAiJK1HqyHXUugZ4nfxROYKtQcm9aGwjAnC8vArSAESyUqUFnP2qnFBNtc7+YaFL
	 kkM6Cn6Wy2qn+jRTx+ZLZ24r3lyJz2brbCFXxzOn3jzzVAIdeePctHi+pvsLO1if9W
	 DsWAjdJt1v5dehbDtT4KGx92N8mdW5UJxdtOiyPqO+w26/etLMbPEP9O00ZVCg7DYL
	 LiZrsYUpWrBEg==
Date: Sat, 10 Jan 2026 11:15:23 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Alper Ak <alperyasinak1@gmail.com>
Cc: tjeznach@rivosinc.com, Dan Carpenter <error27@gmail.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/riscv: Fix unsigned comparison with negative error
 code
Message-ID: <mrufqpwz3sfpren7lqfukyqw3bnjhpvgo7huxhx7fbdwt3j3pn@mfv6ptky2kgt>
References: <20251222151550.987992-1-alperyasinak1@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222151550.987992-1-alperyasinak1@gmail.com>

On Mon, Dec 22, 2025 at 06:15:49PM +0300, Alper Ak wrote:
> -	iommu->irqs_count = platform_irq_count(pdev);
> -	if (iommu->irqs_count <= 0)
> +	ret = platform_irq_count(pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	iommu->irqs_count = ret;
> +
> +	if (!iommu->irqs_count)
>  		return dev_err_probe(dev, -ENODEV,
>  				     "no IRQ resources provided\n");

Separate the ret < 0 and ret == 0 checks is wrong, just check them in one if
statement and return the dev_err_probe() value as before.

-Joerg

