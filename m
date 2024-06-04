Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ABD144D21
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502345; cv=none; b=KRDtyF8H/l1eSFbZD7QFgn+6Uz3x/WCjllgK7Z8Fvx41uyWKCy2a6E6x6LCUYQo+Ad3/3gTzczQqBYEr8j9IwAp7sHHe/3GdFGCWEMASvolgGNlUYLVLrs9DTdkihUyVojBOPEmyR1GsrL6Hfr9uA2DRGhxVdbcu9mIipq1US5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502345; c=relaxed/simple;
	bh=HVhuyjCHc3tDHKT63Z5JPU+pxgXAj4gF+DpRMeBJw68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlu+9SipLrRNwlGX6cfW1gnn8F8tTI2uXBhAYQ/T+DX/y9TZex0ax9sAmyYelpKV0FnkpjftN3F48j1V4Qk1VnQeyk1tEJDCxnzOX5wvaMbz3NCgng6k9q/UQNP/ZiX2jgOb5uHyCsIeYPv1zNNNDuotWp1oiAZdv6G0kA0HkBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=B5dYP6FA; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="B5dYP6FA"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 683D71C7901;
	Tue,  4 Jun 2024 13:59:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1717502342;
	bh=HVhuyjCHc3tDHKT63Z5JPU+pxgXAj4gF+DpRMeBJw68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B5dYP6FApOSL9LFD/pKHlgs2+T2Wql2mS4LPpuo1A9jEnNuTheER0JO3ohCnt6uQM
	 5LcrO031KzhuThtKWtHBioydhmNqy/0uvJ3GIFS3kwYmSWmeFg97w3eQObrVwDsVH4
	 TR14wW6tKl8uxrb5LtYvZ1BDgLyrx+D5AblpSvBJTQdDTQYheXNL/6uFw71rnLyeOc
	 XNk4/YE5/IvQDMOWHyNS1NtIrAzOURJsJTkefqgpN8dthKu2XPw/I+AroRloKTlLYx
	 9RF7TyKmxCRa4HEcFceFpHLpL066Py++KHMpBuNSVkGaeP7by7s9QyQZPLiiBL9Qol
	 auIL0lNzP/3Yg==
Date: Tue, 4 Jun 2024 13:59:01 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] iommu/amd: Fix workqueue name
Message-ID: <Zl8BhTVAuO30dvLK@8bytes.org>
References: <20240529113900.5798-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529113900.5798-1-vasant.hegde@amd.com>

On Wed, May 29, 2024 at 11:39:00AM +0000, Vasant Hegde wrote:
> Workqueue name length is crossing WQ_NAME_LEN limit. Fix it by changing
> name format. New format : "iopf_queue/amdvi-<iommu-devid>"
> 
> kernel warning:
>   [   11.146912] workqueue: name exceeds WQ_NAME_LEN. Truncating to: iopf_queue/amdiommu-0xc002-iopf
> 
> Reported-by: Borislav Petkov <bp@alien8.de>
> Fixes: 61928bab9d26 ("iommu/amd: Define per-IOMMU iopf_queue")
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/ppr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.
