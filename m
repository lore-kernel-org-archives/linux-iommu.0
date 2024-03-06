Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537BE135403
	for <iommu@lists.linux.dev>; Wed,  6 Mar 2024 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743236; cv=none; b=g5YP+AlBfAqvDHDAnVyORT2ibaA2rXu7jn5d2wrY4k4nhgEvSaveJCohqD/IgIeq7s3Qr5UhbacmRSSA1AsjFUUl2Ljrtyphp5bnr74Qfm85M84icOiUripVOhyBeOFD84cGYp90tU90hyvhDL95YBhVfwa7t16WbAdvn3zB/ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743236; c=relaxed/simple;
	bh=DzK8eeew7owQbLWBsnwtpFXZ2gPBFj5rnJtQIM4ikNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PU/pu8ol6oPPYv6kgZbiaiB1HvJ5oLyVdo3ihtolDHt5Yq8cmMWlIp3pMioqLUABjt6PjaHvVCsiaG9PksahY/4Sgm/v4OvBKW3lZzNO2qE/9vM1z/nQ1Ap0UhLv1qnewe2YNBDYIWTtbXb8CW/vemMQ7Pzu5Ti5DlXmVYt8s6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=VvZ2tEfw; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="VvZ2tEfw"
Received: from 8bytes.org (p4ffe0c3c.dip0.t-ipconnect.de [79.254.12.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 15B751C85E6;
	Wed,  6 Mar 2024 17:40:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1709743233;
	bh=DzK8eeew7owQbLWBsnwtpFXZ2gPBFj5rnJtQIM4ikNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VvZ2tEfwn2bqRzHS/qHGD1wjA5vJ9Lwb+SpS9Xzeyd3iF5xLQnSRn2H9meRXaLsiC
	 sIDk3RVghO8bZPyXTv4oFmAKcCaD8gFuuxpACD9REdbNCJV5mA8s4lKWS7JT52lBoA
	 VlIcO3k5WJagMlFckeHt+aqxRwG+IEVBDqc1zhN+waw0VClxL0MLISRsUoG9INsBIl
	 VHgj2O4gNC2c6oLC2aSWRM0XHCYcrLae2/x5GPgn6/uQ5BPIe6TUoiPJZM1E7iMz5R
	 vkgI6rTxzJiUkgCL4NPntkl+EdSDAIgbHwBNuaMnMS+HNR1PazdGGltEpe4Fr1wmKA
	 T0WNYi/tYLc0w==
Date: Wed, 6 Mar 2024 17:40:31 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, will@kernel.org,
	mhklinux@outlook.com, petr@tesarici.cz, hch@lst.de
Subject: Re: [PATCH] iommu/dma: Document min_align_mask assumption
Message-ID: <Zeicf08_vcO3oYnn@8bytes.org>
References: <dbb4d2d8e5d1691ac9a6c67e9758904e6c447ba5.1709553942.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbb4d2d8e5d1691ac9a6c67e9758904e6c447ba5.1709553942.git.robin.murphy@arm.com>

On Mon, Mar 04, 2024 at 12:05:42PM +0000, Robin Murphy wrote:
> iommu-dma does not explicitly reference min_align_mask since we already
> assume that that will be less than or equal to any typical IOVA granule.
> We wouldn't realistically expect to see the case where it is larger, and
> that would be non-trivial to support, however for the sake of reasoning
> (particularly around the interaction with SWIOTLB), let's clearly
> enforce the assumption.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 5 +++++
>  1 file changed, 5 insertions(+)

Applied, thanks Robin.
