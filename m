Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4079C1D7984
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864556; cv=none; b=jiPr888yt+qR5x06SIMU/5tNYzH4ITqfY7KR3W13A151G7mFnzeRZJrlSpE4t8swmTJFrWDEKgn2ukdbFibMCD5skytOfVw5EcSW+2yS4fm867FTt4FWxafZMs9G3j8xMuxrdAoQJmDp29i+UYlwU+Rj57XwvE/NBIe2BVA76mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864556; c=relaxed/simple;
	bh=FzTrLc2om9+1l5jtnWbTspGkiMVBW06XTiqacFk1Xxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnVjekInxE5/vCbsAg+TN1MuUCKN//3HmMRzczOwlw9QJH3O8hbwbYXk8kVG+OukYaUQD0LwQHlfG9lR7XiPSsNTeZvT4jnGRCbbOKb9MGHkxCq2eJfCHBzWEiP6s2LF9IvZxwI6csPhkCFhS2QKf/TmGlE3sW3WpoOXbxSthJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=VSBbzOTk; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="VSBbzOTk"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C7DDE458E7;
	Thu, 13 Mar 2025 12:15:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741864552;
	bh=FzTrLc2om9+1l5jtnWbTspGkiMVBW06XTiqacFk1Xxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VSBbzOTkAExwQaMqe8V2djsDFie6qGO4SpzAhwxEfyfrXfVjZiiOlq5x9D5XNkszZ
	 dUki4rWoeB47V8XavnKRXQm1oH9ufWAfBunkYrk/vHTweEgECWVKezCIxLtYhOTS5b
	 kxWpp3wOPRT2CpidXpMJ8QYA3Al5sBzIlQ5/VTcf2HTmeJXWMraDwVZAog4TKtdHVk
	 UjMpAcBbnxqlAcF+fX+rS3+MVWJI5c+1rzpF03oKA2NYe1ZOFbrUZq4WFcrbhGHldZ
	 4VUzc6bEKopt5eC6IRNUy1Wl9ysw3ilZMRfVOnuws+YJUv6AunVCPp/8Gl6zR2q0ok
	 bA7kHFMie19NA==
Date: Thu, 13 Mar 2025 12:15:51 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, vasant.hegde@amd.com
Subject: Re: [PATCH 0/4] iommu/amd: Enable support for up to 2K interrupts per
Message-ID: <Z9K-ZwK1JzoJ1lZ4@8bytes.org>
References: <20250307095822.2274-1-sarunkod@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307095822.2274-1-sarunkod@amd.com>

On Fri, Mar 07, 2025 at 03:28:18PM +0530, Sairaj Kodilkar wrote:
> Kishon Vijay Abraham I (1):
>   iommu/amd: Enable support for up to 2K interrupts per function
> 
> Sairaj Kodilkar (3):
>   iommu/amd: Introduce generic function to set multibit feature value
>   iommu/amd: Replace slab cache allocator with page allocator
>   iommu/amd: Rename DTE_INTTABLEN* and MAX_IRQS_PER_TABLE macro
> 
>  drivers/iommu/amd/amd_iommu_types.h | 27 ++++++-----
>  drivers/iommu/amd/init.c            | 65 +++++++++++---------------
>  drivers/iommu/amd/iommu.c           | 72 +++++++++++++++++++++--------
>  3 files changed, 94 insertions(+), 70 deletions(-)

Applied, thanks.
