Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E136E1CCB26
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442292; cv=none; b=Ysq1nWifqpS5KKbUgWgbKcGoraYH1UkWLjmUIIG4HBxO9FjNwto0PxompnthWVbCX3a4W5zqQ3OY8sNe8j4862VXM7VI6ce34C1SOt2ZGivKfU0p9E5vpTn8Njir6m9hB5Pn3iU3/lxBZGzDmaLiHPIPnjjX8Ufg+p2qR+qnGBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442292; c=relaxed/simple;
	bh=oM9rqioAhnUrjEwjaS2fdituWw7xWpwMO2VanpVQxL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmDL6zBezTplMrKetkjI87nOMq4d/CGaYPPZL0xODVVhy2QB9B72tuMvFYV6h7mJfZ+DRyhZnw/cSQvEGnS0WaDTIgOGcLACpdxTwTHOZjfg2S3gp/hEu4FeXvUNhms7evKXTZloVoQ7Y7IjzX21pDNpTFi53kIYsQSUM/oPfK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=CY7iI9Ec; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="CY7iI9Ec"
Received: from 8bytes.org (p4ffe1f47.dip0.t-ipconnect.de [79.254.31.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5A2D8285A43;
	Wed,  4 Sep 2024 11:31:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1725442282;
	bh=oM9rqioAhnUrjEwjaS2fdituWw7xWpwMO2VanpVQxL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CY7iI9EcERa8E7yo1dCaylrLKz/lA/TuNle+W8sARzGYzdSaRgyxSE0AZvYmEOXDT
	 yZfJb9PDqKHjIdF2SL8ZJzfsk+LO5jzHnPMOAVx4Yk1MImIfhrw3Dw3Koraks4Xnje
	 wQgLvY3IFrIsJzFiq1aodiIgVhaDkjc63w5Ev82E0dsg9yGVYR/X15Ncnn790Of7DQ
	 8mb+v7w7NKtU3pzCqiagr8hHe6ih7OXix+S6A0iaxToLF+oEyukh48L/mEF6H9UDHP
	 sU9MbAQbhfLnGeJAyd8TF3EPiyAnJOPCfmQO4ID1nMM+XnJXGW1UnszRZuddZIY+hN
	 0wAqmde2TeoHA==
Date: Wed, 4 Sep 2024 11:31:21 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Use of_property_present()
Message-ID: <Ztgo6YImt1KetSCy@8bytes.org>
References: <20240731191312.1710417-6-robh@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731191312.1710417-6-robh@kernel.org>

On Wed, Jul 31, 2024 at 01:12:44PM -0600, Rob Herring (Arm) wrote:
> Use of_property_present() to test for property presence rather than
> of_(find|get)_property(). This is part of a larger effort to remove
> callers of of_find_property() and similar functions. of_find_property()
> leaks the DT struct property and data pointers which is a problem for
> dynamically allocated nodes which may be freed.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/iommu/fsl_pamu_domain.c | 4 +---
>  drivers/iommu/of_iommu.c        | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)

Applied, thanks.
