Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B0A145B16
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502484; cv=none; b=j01IY6IrBJaIL/vYZJztQoIxkbPTMCUPJKqI+m4UmCRfO9RvT+PUFqL4zlIxNKJqSWKdz0nJPkzvSTyoq5SoWEgibw6VqQlx50w0YLIK9WwIavEvZUHNa5ZkTNxQlGZoNleZkUQydhWVyoTNcs0gqObq78xNrr8dH9ifDn6kf6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502484; c=relaxed/simple;
	bh=4jTs2PUbhK+YR8mj72dXxJhiV6zvOnHVyGeVRVFIgVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8rmi5P4b9aSHhHLDgj1QUiKp7Va2E38GM+XLgcy6piB9FTWeUzlQqNReCVdCBAJI3IPyDZ3USN/P+d0g1pTa7RvolU2oEPw5myWyMUy4qUY2gzL02XAxiyJdIhM6iyI3ou1amU8Y1vBBTNs9X8phBpE7UtI5mqwrtC0irzBZqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=ZoLmeUGu; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="ZoLmeUGu"
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 472E81C7AEB;
	Tue,  4 Jun 2024 14:01:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1717502481;
	bh=4jTs2PUbhK+YR8mj72dXxJhiV6zvOnHVyGeVRVFIgVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZoLmeUGupavrmUFrDsrdSKLPpYpNw1EjZz1OgGRAWUx55xW9I1bAZI3W4t5YbNyWM
	 ofZ03xofGoPTz8cginFba3pxZMgXTRBavF52gGqTatXmUvKIhGFNBrAR7FoZpMq+WN
	 gulxWlPpnRa9HYmKl9HbUNYb0tNTShpUD5h1+J2cN1/nrwIqZ3pJH3/gxAlVKEyct+
	 TqNERYdNJUB8E8orU6FfjRZ+gDIo8yFG5odlF98jsvJ0jU0/1eDhOfyEak5NkHp9RB
	 aeSEHLmwwtjea35H6GKciBfuwvbG7tGHnKPjwqjVxnCpq6oQlJpjpqB9C7qr8jQRZr
	 67KmNLha0SvSQ==
Date: Tue, 4 Jun 2024 14:01:20 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com,
	Borislav Petkov <bp@alien8.de>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Chris Bainbridge <chris.bainbridge@gmail.com>
Subject: Re: [PATCH rc v2] iommu/amd: Fix Invalid wait context issue
Message-ID: <Zl8CED2U4HS6-SKo@8bytes.org>
References: <20240530084801.10758-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530084801.10758-1-vasant.hegde@amd.com>

On Thu, May 30, 2024 at 08:48:01AM +0000, Vasant Hegde wrote:
>  drivers/iommu/amd/iommu.c | 48 +++++++++++++++++++--------------------
>  drivers/iommu/amd/ppr.c   | 22 ++++--------------
>  2 files changed, 28 insertions(+), 42 deletions(-)

Applied, thanks.
