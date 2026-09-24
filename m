Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610B4477E58
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790250999; cv=none; b=UwgCd+BWbe+Jx33gp61d7bgWewMNxwTFEPFSGVZa0oy9rPl6nOWOYTbePuAnaZFuY7aYkV2F8W5A3hvQOjQqcHUKVIBHxXxp7Oc3GcUDWuwUrSNEl+0b0p9mJAsPCzmNxyr+4BBIsuvvgaqwnRf2Ni2Lj0wvYtZ3W20Y/Xf9ou4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790250999; c=relaxed/simple;
	bh=usx3y/nV3kOQCl3kf6ZF1KTxRDgLfWkgTWYHW3TmNq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dV7N2foGva3m3Krmh9IatbqlBz9rW84k/xOhE/mS8YSWLuaePoyfh2Mrgw/Wl476Kzv/1A1Uupam6sw0lGe3dr/2RkS1vLcAgT4KJhHcD1x0sAc7vyJr+YBMto0uk4Q6wlD2n+2xwmhNY+7bFvAxyx7pbhL279Eg/lPaA6tZ7TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00e4ccc4fdbbd66590.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:e4cc:c4fd:bbd6:6590])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id F3BAA1C7465;
	Thu, 24 Sep 2026 13:56:35 +0200 (CEST)
Date: Thu, 24 Sep 2026 13:56:34 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com, 
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH] iommu/amd: Move GA log allocation to init
Message-ID: <arUP5PGEs_XzX8PN@8bytes.org>
References: <20260911104317.5183-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911104317.5183-1-vasant.hegde@amd.com>

On Fri, Sep 11, 2026 at 10:43:17AM +0000, Vasant Hegde wrote:
>  drivers/iommu/amd/init.c | 74 +++++++++++++++++++++++-----------------
>  1 file changed, 42 insertions(+), 32 deletions(-)

Applied, thanks.
