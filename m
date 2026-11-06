Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979977;
	b=n3CF7YyP7/RviPuJUoFt1LQiP1B5A4jN7Jyw1SjHwS3KHFGaDmlL9lgkFrygTEfoa+Bi
	 C0Q9edg9y9s0HcZW7+fxH7LRWgxq41FSRmi0klRkCbbu1qVixqElby0oRjq2So3iAOaht
	 IYJfMQESHnqNQVQHR8fF+eMm+wvcg/ftYkgvwf6Hx4ptufJLLtnUuhIYkTehZh23cXfQx
	 V/zk6kDa6PqhrqEN1yOjVWd+FMxic/qKrGtbwPGjgudsd8vTRlMvtMsbknVolcPOXh+94
	 YB5nj/2Rc+IIwYgA44vwWvIWIlNxQveMJf9bD3deFlqK8u6fJDZvXBlQlJXSiUcvQVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979977;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DMfYqX4g38gmV5SsvfE0mNfeNdT0ejHam1Ov/jg/J7Q=;
	b=PL2PyyZR2uAtCGdkawLfgui5JKR5FbnuvApcHK3bjHG2amFX3UUvnkqspcvhx1+wZ9yu
	 sAs7UPa5VKsKxQRFodaYqara/FoyHKV0besS4+YwgH0/uiXVLpsZvDWzgF5bcOjkfLDXT
	 B4qA/WiM79Nts5KLf+jrVNB9mkhB2XE3/FmDBuQnzbGu7hWw8zsgXQkDPVYoMXXM309vF
	 yiPT+LjtooGp67vBYo8ZAM/M5JOZc5YrWn1nt74pLVh6dXaT96fYCTe5k+xuArD+298qG
	 f+vvHUSRJs3y2mhBnZYHfRQsVcNGQtW3p5KM2o3AaLYCc232TH1gGJhsoS1spAAB0vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFC1606A32C
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 15:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EFC1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00c8b813848b737b26.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:c8b8:1384:8b73:7b26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0B953241A1E;
	Fri,  6 Nov 2026 16:46:16 +0100 (CET)
Date: Fri, 6 Nov 2026 16:46:14 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev
Subject: Re: [PATCH 0/5][PULL REQUEST] AMD-Vi updates for v7.4-rcX
Message-ID: <au32KqLCsHqlXN1k@8bytes.org>
References: <20261105163219.601561-1-vasant.hegde@amd.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105163219.601561-1-vasant.hegde@amd.com>

On Thu, Nov 05, 2026 at 04:32:14PM +0000, Vasant Hegde wrote:
> Akshay Jindal (1):
>   iommu/amd: Skip non-IVMD entries when parsing IVRS memory definitions
> 
> Dheeraj Kumar Srivastava (1):
>   iommu/amd: Clear amd_iommu_snp_en if snp_rmptable_init() fails
> 
> Jean-Christophe Guillain (1):
>   iommu/amd: Fix NULL pointer dereference for GPUs without upstream
>     bridge
> 
> Kevin Mitchell (1):
>   iommu/amd: remove obsolete domain pointer warning on release
> 
> Mario Limonciello (AMD) (1):
>   iommu/amd: Enable PerfOpt automatically for integrated GPUs

Applied and sent upstream, thanks Vasant.
