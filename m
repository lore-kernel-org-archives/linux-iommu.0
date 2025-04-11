Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CB727E1BA
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 07:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744356273; cv=none; b=TKUP235kbmJl44DCzY8whYPfbDomFv0pEzemBRr/CODcFDhAIKRA1LP0ERfJz9i1Gi4ApGkxI6WdGGJy0X/iamrlHzOj92mOEAFZ8gHEcjPS4Cai4+KKT0FXNfiYKSwnwdorcvkav+KObWNIXXPsHzYHGXhN3ZQ5e9SEvPG3Ews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744356273; c=relaxed/simple;
	bh=BnMGd9mQ/j6myPqXH/oYhks+zqHnk4z0pX7RuLW/8PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSpBvuMc9zh0nKjp5+OBWXTEJpVtXouCdq0BbfPbzF2MW0Sp6UGYhxaN5dRVCotPwo3QHQtNJP060nJ4AqM2Ib2IBHviUkoDE/HScDPulZmYmWA09uI6gBWzvkuZUsA/yEuhNWkmfYWLgcGAsnd416wgvnp80hEu21CnokNJqq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=mpupdibO; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="mpupdibO"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 669634685C;
	Fri, 11 Apr 2025 09:24:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1744356269;
	bh=BnMGd9mQ/j6myPqXH/oYhks+zqHnk4z0pX7RuLW/8PY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mpupdibOtc2RFbignZRrn0x+Ex1YenivTyeIFIy87nVwibPZLZc946/P9db5obZpV
	 ffPt6Uei+y+Wmm0ef6K0CVOiOiNFgEFTSHlAwuvogrKTUNUKqDqskPYWANS1wy5xRz
	 M/QiOcuNFHgVCuy9+4SGqhmzO17i3OiPvDx0A4tPsX135Hm6mtMc7SKDG8Nqk9rLW6
	 DPBEKo0lSWuVsB4KYor25XES84CZS1ZYPFWYbVqRmutZfuIGnqRwHuxvcZK4MihmL3
	 0fT8CxOeVdiEgbnSG48wU4y37LngxXhM2KOj/MjgY/IcQjQnS2aRVvSBgaItSL0tt2
	 9C6uL8xSt15xg==
Date: Fri, 11 Apr 2025 09:24:28 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Register in a sensible order
Message-ID: <Z_jDrH5ijeqCE03F@8bytes.org>
References: <53be6667544de65a15415b699e38a9a965692e45.1742481687.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53be6667544de65a15415b699e38a9a965692e45.1742481687.git.robin.murphy@arm.com>

On Thu, Mar 20, 2025 at 02:41:27PM +0000, Robin Murphy wrote:
>  drivers/iommu/ipmmu-vmsa.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)

Applied, thanks.
