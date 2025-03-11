Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119B35680
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 13:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741698915; cv=none; b=QZiDuVj3Mo0Rsepn2r4Nf+/aG4HyCUg0TlBSk46Uy3yRQcA9BLvcG21QP6ebG/pAL3RhaKDFOuGHZx6c/50G0enfRBPgM4KQ1cdsqawTpd6EK3/1N4pIUh8Y/7MvkWqew7q62LCOvMsKVyqxf48BQGx7PeKXa6XSE80UcUH0/qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741698915; c=relaxed/simple;
	bh=5rBouzA5ngZzdOL7plSCJDVP3pR56/JX8o/OYsWjk84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMaDyMT+WAe2od7gi+y6Ql6GPi4naxuz9IciSGai1EXuqscAKsePUzV3jAMwxs8pVgPXBxMZj1jS4Fz+cygCifoFv2xQtCBUOXH0747Z9O1EnVpjHhazG7gAplFt8Kr4qTBpyetZQcLZrPu27/XqrZUHojo3yMBhawv4tqsNyKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=UdWpvjhu; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="UdWpvjhu"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 362FD4507E;
	Tue, 11 Mar 2025 14:15:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741698906;
	bh=5rBouzA5ngZzdOL7plSCJDVP3pR56/JX8o/OYsWjk84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UdWpvjhuSPUTc99yhcU6GjBIpOCU9aP+9cfG9gLhEumyfid+90D4p713r3tRAFjYq
	 IY+aHO7tp8T0bAUxfRkKPJYFlS4wT+Hexz+SVpIkCWcUhvlWnIfWvECzbBzv67To2z
	 mzvGeXrX+n9WvnDkJSOpS9ruDWNZz3GB09jKD5yMHoSetJOTbKicxSyFtx4XqoOPO8
	 nks0QZPUrRZ7e3Cuojv58dRazmW90XQWHeHm+B0PXC444kWWaViUnI0nX3qrKX6emI
	 joE42xEnS7afPMd98FhM0QVnGa1QmAHC6Gp+giqLMlMb/l1g9agIwfEApnWqIDCuf/
	 6sZTaBSSzwZog==
Date: Tue, 11 Mar 2025 14:15:04 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, yong.wu@mediatek.com,
	thierry.reding@gmail.com, vdumpa@nvidia.com
Subject: Re: [PATCH] iommu: Unexport iommu_fwspec_free()
Message-ID: <Z9A3WJSgUPjROev6@8bytes.org>
References: <36e245489361de2d13db22a510fa5c79e7126278.1740667667.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36e245489361de2d13db22a510fa5c79e7126278.1740667667.git.robin.murphy@arm.com>

This patch triggered two compile issues on ARM32, which I fixed up in my
tree:

On Thu, Feb 27, 2025 at 02:47:47PM +0000, Robin Murphy wrote:
>  static struct iommu_device *mtk_iommu_v1_probe_device(struct device *dev)
>  {
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct iommu_fwspec *fwspec = NULL

Missing semicolon here.

>  	struct of_phandle_args iommu_spec;
>  	struct mtk_iommu_v1_data *data;
>  	int err, idx = 0, larbid, larbidx;
>  	struct device_link *link;
>  	struct device *larbdev;
>  
> -	/*
> -	 * In the deferred case, free the existed fwspec.
> -	 * Always initialize the fwspec internally.
> -	 */
> -	if (fwspec) {
> -		iommu_fwspec_free(dev);
> -		fwspec = dev_iommu_fwspec_get(dev);
> -	}
> -
>  	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
>  					   "#iommu-cells",
>  					   idx, &iommu_spec)) {
> @@ -476,6 +467,9 @@ static struct iommu_device *mtk_iommu_v1_probe_device(struct device *dev)
>  		idx++;
>  	}
>  
> +	if (!fwspec)
> +		return -ENODEV;
> +

Wrong return type here.

Please be more cautious next time and make sure to compile-test all
changed files of a patch.

Thanks,

	Joerg
