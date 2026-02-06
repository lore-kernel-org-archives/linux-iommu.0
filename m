Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D6336D508
	for <iommu@lists.linux.dev>; Fri,  6 Feb 2026 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372958; cv=none; b=ezAJB5kaC/n3fhrgXSa5k4x6tOFOQUh9JqIlQN44sMHArB25WVjhnntMBOWSKHUYRkcvx+ha7Ba/kb3Kc+CdOUaHzwC3ljQVBjyEXR02tbth8Dle8XzTOlRk1edDDFsmmFXpaTFeSXpWKj3R8U2JHFWKgCLqC5OTSsT1HP/wKSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372958; c=relaxed/simple;
	bh=d+q6Gvg12JH8zuXhOcVqNJufl9AU7dHO65lkzMffrXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3G37Df4Lr0IfJGskPuyswWpgrkYQ3nVNWMpi/K8DTpH4g0bT8T7SZq8KEAtA7/DDKMlep5uZ+NKqNXiPxc7HTO/Xwp6sveALiR4ZiTOBqjKhlbh9TIZQwGz049dhGDjJ54IsiN6HP8y1vmP7CDP2ktvS71yOnp3OryM000hTEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=wmrE9qOD; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="wmrE9qOD"
Received: from 8bytes.org (p200300f6af1d96001ee0b275ea67cb0a.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:1ee0:b275:ea67:cb0a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7E46F1A1A96;
	Fri,  6 Feb 2026 11:06:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1770372366;
	bh=d+q6Gvg12JH8zuXhOcVqNJufl9AU7dHO65lkzMffrXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wmrE9qODg98S9DXJZbjXgr2gJwxZ2KyF59CR+YwDr928j/eUi00iq5lsOA5OxhXx4
	 2MU0Fzmo6Qi233zmQ8ubXh5Wcr5fFm2kuYiDUYIMZ5TT8zVkEl9BW55V1g1OEOIujH
	 Jt9gxvV7Ew++6tSfBjyes96qerzWiJ4+zwmOeIdKUu1l2DjU89D6Bkpi81sWNrKGOG
	 t+d5+Bu0Bip6HGrrO7kLA1LGD5kZw/h54k+zOPT0rCtB1m1tRKSlyYVu3zp9uCGoGr
	 2gp/T4XYy1UBB9OnyXBCA4IP9QzLqnjTclaMI1rF8Nl1FL/PwhQb/n0BRM6ZUZr36/
	 C+7IFpY/uX1BQ==
Date: Fri, 6 Feb 2026 11:06:05 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Magnus Kalland <magnus@dolphinics.com>
Cc: iommu@lists.linux.dev, jonas@dolphinics.com, larsk@dolphinics.com, 
	linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com, torel@simula.no, 
	vasant.hegde@amd.com
Subject: Re: [PATCH v2] iommu/amd: Invalidate IRT cache for DMA aliases
Message-ID: <blunl44eynudctpiqrlp4czdohmet7spwu4c7svc2pdmauaves@vfzpu55vtv25>
References: <fwtqfdk3m7qrazj4bfutl4grac46agtxztc3p2lqnejt2wyexu@lztyomxrm3pk>
 <20260205140059.11857-2-magnus@dolphinics.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205140059.11857-2-magnus@dolphinics.com>

On Thu, Feb 05, 2026 at 03:01:00PM +0100, Magnus Kalland wrote:
>  drivers/iommu/amd/iommu.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)

This does not apply cleanly on the iommu/next branch or the iommu/amd/amd-vi
branch. Please rebase to the next -rc1 when it comes out and re-send.

-Joerg
