Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DE74086B
	for <iommu@lists.linux.dev>; Fri,  1 Mar 2024 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709297660; cv=none; b=gbw9DoT0zXvyHb+a+AUHPd8SwtDlQpBHtBe6aNxWCJTQY/HIwkYeXkxSlQkdyyscnA6IlrUXuk2Dxb4n6gXgx7OnN1HI0SjkqMSXXBF4kp1oLM7QVZMhFhMfH5Xje3AMtr9szTnKOTLtjUToOkO5JBwPAmFtOUDY9JyOsf+/u4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709297660; c=relaxed/simple;
	bh=RlOTojB1WrxiBSIgGdoSe1kmYX6YyS/mIeUDv6h3h8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPxLeJO0IN2yXVOf20csuWShD8ob/oxipJ+EzTeGRyO7py2eHsbJhkdZmlGgxjtxk470nI5ohcSt6fteNqhOnf34DENjcbUFnjbl+wXBI9UFORh2/8sg6c6mDR0bTQvq9/aJsXQQFRpR2r4ywQ5kqfSijV8Vt4rgLqC5IgJQFAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=xd3dGNzG; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="xd3dGNzG"
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 21DC41C1D53;
	Fri,  1 Mar 2024 13:54:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1709297658;
	bh=RlOTojB1WrxiBSIgGdoSe1kmYX6YyS/mIeUDv6h3h8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xd3dGNzGSqM8OmeEoO5bgWEgEJ5J/qky05JZkZpW5qZ90YZnoNaccH3yLDz7QMr+S
	 RPvjjTNd/1g+fwubU9TIQIIdTPp8BMTmah7NtEjWdNXtbZa3zbV9OPuGG4AiCfBsYf
	 n6kIGriwFoAWptGCwNI7jSzW1nPFFSpVbawv8b8Sl1DejtOHbn79Ed8wBq1IK9/bzf
	 M2RkMQmE4fHafw+eIrE+tUEBGmKvqC3AdrGj5eKZwNnu9v8tOf9Jqyt5Ni8xZ9jW0i
	 aTrbGHrZ5G2Mj9rVBrep/jcQIxT1ngmZnSPn4cCIgFAJUph8ItCh7xXf+cNF52i+Bx
	 A7eWAknskZFFQ==
Date: Fri, 1 Mar 2024 13:54:17 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Will Deacon <will@kernel.org>, jean-philippe <jean-philippe@linaro.org>,
	Jason Gunthorpe <jgg@nvidia.com>, baolu.lu@linux.intel.com,
	"Zhang, Tina" <tina.zhang@intel.com>, kevin.tian@intel.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc] iommu/sva: Fix SVA handle sharing in multi device case
Message-ID: <ZeHP-fJ5PNIi-9i2@8bytes.org>
References: <20240227064821.128-1-zhangfei.gao@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227064821.128-1-zhangfei.gao@linaro.org>

On Tue, Feb 27, 2024 at 06:48:21AM +0000, Zhangfei Gao wrote:
> iommu_sva_bind_device will directly goto out in multi-device
> case when found existing domain, ignoring list_add handle,
> which causes the handle to fail to be shared.
> 
> Fixes: 65d4418c5002 ("iommu/sva: Restore SVA handle sharing")
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Applied, thanks.
