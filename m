Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8134C53E0D
	for <iommu@lists.linux.dev>; Fri, 12 Apr 2024 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916242; cv=none; b=UEUFfksNIlRtqm2sDT/nCDl/Aunt+ZQmmVvx0urq+FtsX+31WTOfdpVm1y04eQIkyX8F/CreYMqv6p28cVJL9iHuUCrRXMLCYXJbNXMC+ti61Qy6QfIKrKCBu8HQlF6uE0SRE1wALobMTA7e7eSAcLsj8UOqxEqB248AzUmDmkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916242; c=relaxed/simple;
	bh=rQ+wN+SOnCj/1Hr/zwq6ferWoNK2a/Q6i6l+Bm6HCro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjPE608e4vwDX7UA1XMwPb5nCqZoEprqpJ1ap6+iJouMf+kL9O7ZyUyDZrp63+sO2548dQdLpQrgHRbgvGgFUpUF4SK58Xa0lb6kiFjuaDcG1Gz+SJhEXRZANnFci2RWE6gknImyqkqnRo7AtVf5iFHcjrud5k275oOTDjzWBJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=oE04KvwE; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="oE04KvwE"
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6F25728239B;
	Fri, 12 Apr 2024 12:03:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1712916239;
	bh=rQ+wN+SOnCj/1Hr/zwq6ferWoNK2a/Q6i6l+Bm6HCro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oE04KvwEfRcdQdDIuFc6acFDgNz/UgWqZleIAXO0EqEj3ISgmj0T8bdXXCgrdOvRF
	 g0lWF73fyLcON7Z6lIWNB+VpZLiC/WdytRTwuwoCLG+Xmbp2tOPkboChjgsmQl7DCV
	 edv9K+MK2CBiZMtSr6+xeYA0RJCAyuUHBSp/nhOxGTualYrovVX7xGkS29x9omKSv6
	 m2D40Wa3vLXQ16zEEC/6CQyBr3de+6s+tOJyLZXaYfsczUUfFtCElB2hvnLTExuLbS
	 xZqGXMtQyuoElFYRNhnA673IKfaadPJPJTAIFmrFxIQAl5JAiQWK5Jjl+c1872/QV6
	 KOTfD+ZLH2lQQ==
Date: Fri, 12 Apr 2024 12:03:58 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com, bp@alien8.de,
	Ashish Kalra <ashish.kalra@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 rc] iommu/amd: Do not enable SNP when V2 page table is
 enabled
Message-ID: <ZhkHDtLJyBRITKWq@8bytes.org>
References: <20240410085702.31869-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410085702.31869-1-vasant.hegde@amd.com>

On Wed, Apr 10, 2024 at 08:57:02AM +0000, Vasant Hegde wrote:
> Changes in v3:
>   - Updated description and added Reviewed-by tag.
> 
> -Vasant
> 
>  drivers/iommu/amd/init.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)

Applied, thanks.
