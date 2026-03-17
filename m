Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FBD2C21C0
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 12:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773750801; cv=none; b=sIhp8/GG6hpn1lJtOsXinar2mDiLXTAaN1MnJAwO+aTlyef0PJzLCRDeMReqkgobIBamKJUnzFRRf+GCZMbwPVAVzMcIHAZfTllo0sBJJwinZRBWXinfHyUcO6uXFrq80SSJqi3Ks/2a/nE6/25tTSJL6a531kCgcYhVCfWwTY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773750801; c=relaxed/simple;
	bh=FiOuMdDSbGm2mEP7XOt8aUZDpnt4g+7n1N0mpC9oAPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fT0equOKcmRdadL4+ZmZ+Uo1QJc2b+Bt9YPKTdJ+c3tNlF5O0PfMx0X9ZCvdIYNFrdQb0LS7Oe0hgleVgTGlK94xFmmaoG8r4OvCzjV3LS9eypKGMaREGyA/jOsznMjvd4zav51AWUHtXA21ZGWSCxceBikMwCey/YcikcwN1So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=oDAiOHf9; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="oDAiOHf9"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 418721A5911;
	Tue, 17 Mar 2026 13:33:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1773750797;
	bh=FiOuMdDSbGm2mEP7XOt8aUZDpnt4g+7n1N0mpC9oAPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDAiOHf9ltVUCm85QMSgsWHzzQs3tWcwCBud0Du9OzfzcaTzvS9OMprDY4VAH593J
	 jQY+B3hiwrkm19opRGwPBZj9hWM144Y9jDKGszDx9L90A753ggOo+ZfXg9GaWbRvhf
	 UV10RNNQPjzieiJNtuiUIN2HVNqQDQyWBf72uwuE5cWdg8ITU8f5ANVvJPFvHHs4Z7
	 MO2UBqoQNCrTglzVcrFYP9DHHOlp70hEXLLqWgCwUz9GNLTPntbHAXyzrVDGaBXHsw
	 CC3MtWn7azh8BpU03GvvKxoZax/H7r5W58el1D/igwe5lkX+RMBe1fpNgfql8/a857
	 pf/2fpjRaOXWQ==
Date: Tue, 17 Mar 2026 13:33:16 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, dnaim@cachyos.org, Mario.Limonciello@amd.com
Subject: Re: [PATCH v3] iommu: Fix mapping check for 0x0 to avoid re-mapping
 it
Message-ID: <qzwqyiuwkbgskydkg3bnotdp7eruaoxbec7b4b3x7v6altqapk@i64rcmyt25u7>
References: <20260227080638.208693-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227080638.208693-1-lkml@antheas.dev>

On Fri, Feb 27, 2026 at 09:06:37AM +0100, Antheas Kapenekakis wrote:
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Fixes: 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> 
> ---
> V2: https://lore.kernel.org/all/20260226204400.15573-1-lkml@antheas.dev/
> V1: https://lore.kernel.org/lkml/20260221235050.2558321-1-lkml@antheas.dev/
> 
> Changes since V2:
>   - When addr is 0, check for address 1 instead. Add Suggested by for
>     Robin. This is an alternate fix.
> 
> Changes since V1:
>   - Remove closes tag. Turns out there are multiple compounding bugs.
>     See [1]
>   - Remove warn log
>   - Remove the addr check and make skipping universal
>   - Cleanup commit message
> 
> [1] https://github.com/CachyOS/linux-cachyos/issues/704
> ---
>  drivers/iommu/iommu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied, thanks
