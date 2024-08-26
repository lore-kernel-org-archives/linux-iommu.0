Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D672376E6
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 07:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656683; cv=none; b=ExdvojNQL83d5bBV/71KygRYVyLGjTlfgZNS8OLgb/ZQ1YXJPa0MERoOFsUL/2w/4itOCNeYvgEVMee+xlkTvYMfr63ed0oMyztJuqaEtbVPnJETcGk7/VOWlgeGagrd5ElOHXBBHMglhOQ6JIp8PgXS6nBn0HDJ+p99YG+kEDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656683; c=relaxed/simple;
	bh=SrfGpDRBuTS4lFW7iDjHMd5hZljZmPt+QeG5j+/mYlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5L5RXzZ2g4x5z5jNdjwMnVKsRPyqJmyEcpMdPBoZwPEYqyayTtwEiq3GM1YPtv8G8hfqyQ4VySdMSy3DMUSfAhU9Nps6zVnjFZg4akjR2Czh3hJ300E6IB8yQ6msWmPmkUUObLGSTJacHLV2mofij/iynaNAv0WRmu1B4qIaRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=4tTyxA39; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="4tTyxA39"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 112A3283F77;
	Mon, 26 Aug 2024 09:18:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1724656680;
	bh=SrfGpDRBuTS4lFW7iDjHMd5hZljZmPt+QeG5j+/mYlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=4tTyxA39pD2R+hDblAP5P18EcaXZYpEHPV1IuzHAiQlP1wawyDnwas9KR9qHim2kZ
	 r52371afFatBb/SqNCj8Ef38XeAQcBNddCXOZBorTRb2/9oE0az+gzUYivNZXU2s32
	 QSzCCWwkxHlQUJL7KXSyq8i+O4q/ohtyfxVKo7PSkGsuAIWFfHj9uqj6D1Qst6pNB+
	 6XMlIlK9lgItgLIoRDNozaWU38xHdX/qelWPaobkoru6GpskiCGL7RSxCDW9QPtage
	 dAAD9J0uIYI5GDWFl/hCE0SPGJumy0OQ54hJ2oFZD7wnM0PZkLelgGNwbZIC77Ad2R
	 xac6sdRNhPw9g==
Date: Mon, 26 Aug 2024 09:17:58 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH] MAINTAINERS: Add Jean-Philippe as SMMUv3 SVA reviewer
Message-ID: <ZswsJjoOxs5lK7eR@8bytes.org>
References: <20240823165454.1064-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823165454.1064-1-will@kernel.org>

On Fri, Aug 23, 2024 at 05:54:54PM +0100, Will Deacon wrote:
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)

Applied for -rc, thanks.
