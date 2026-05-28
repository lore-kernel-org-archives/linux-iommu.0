Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30053264DF
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 07:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779953363; cv=none; b=VLJbRjDoHpAj28oto0ralLAHv6OY8ZJbsGEWJjGYu8asGbTPC1ijLTmQvrlad5iY2uSmHX3wFki/TaunlIiUG8xd4/T/aebsEq6eEFh/xw6/pedwrBrXDrW+jFGvOPRpiHLc5/9r8upFVLePyiRJQ8JattCXoc9xpp+L81nF2Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779953363; c=relaxed/simple;
	bh=N8kz9y60HqcvGzx4b/h4G/sfvR6Tf0kpHL5zDV4ta00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoEAHXbBMkJa2jxLZFO9SEn1vmhKiv4WN2WXmDlRrtnsCsTwoZJXs76pmBxgHn9OHdNS1oRgDj3P/4yfISWtENhPyxMzZLy87F4r7QjH1zKYYAcwbI5aduDrq6oDSTQ9c+dXkGiJTFJX/7STMbHCzcIHz2ZuqutAWNTjaOHk5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc5001a5b4667a2accba1.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:1a5b:4667:a2ac:cba1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DCA4E1C5A79;
	Thu, 28 May 2026 09:29:20 +0200 (CEST)
Date: Thu, 28 May 2026 09:29:19 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com, 
	suravee.suthikulpanit@amd.com, Sudheer Dantuluri <dantuluris@google.com>, 
	Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Subject: Re: [PATCH] iommu/amd: Fix premature break in init_iommu_one()
Message-ID: <ahfuwfxAGQkkqlPL@8bytes.org>
References: <20260517122925.5735-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517122925.5735-1-vasant.hegde@amd.com>

On Sun, May 17, 2026 at 12:29:25PM +0000, Vasant Hegde wrote:
>  drivers/iommu/amd/init.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Applied, thanks.
