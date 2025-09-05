Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8367D34DCE1
	for <iommu@lists.linux.dev>; Fri,  5 Sep 2025 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757075166; cv=none; b=PKSmM0akluYgEddHWLKDpaYJRVWGUY1hjsO6+AqPnIhb3FqYMxBIj/RMxyLO69QQxCJ7PFkt+RXxe1kCf+SDfWZ/2Yq1S9M7Gri50jo26ws1lKXCcPPTxdp9ZJt10g/iuXIr2IB7nvrbRLDk4Uo/cFrkH53UxGU9/GHFHjXLQEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757075166; c=relaxed/simple;
	bh=UNbvGndv1S61WpjCG4QZ/lSTct5Dr7ON8Y6ehcau6GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXPo6OzFIE0XFF5/e8S1geXxTyPpLj/Mx8q1BmFkOX7ZgyA6Qb9VbM1O33vE83Iu/MvxPgXbHWzwILYr7HyZZ2Cq6YMmoXFgRAXI9NwrOJvT8ueiJzkJIjYLzQLaUFqE39XUiivw0MODPLS0e/9nBdJOhx+HQjmqEKrQzfXMCqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=FxeNlOWc; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="FxeNlOWc"
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 73A0152C54;
	Fri,  5 Sep 2025 14:25:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1757075156;
	bh=UNbvGndv1S61WpjCG4QZ/lSTct5Dr7ON8Y6ehcau6GM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FxeNlOWc0vnOtMnc53lZ6jehc7BQyGtRGRakNcUVX+Y41F0RGI/dg/TUrt5ErrtVS
	 h6/5xfwcj2gf+W1c9WSrNyKK/c/DN/rdL8E7aCyeqVxPOzPcmxQTcWfG8+YTyQBPNB
	 S2XLajyxNWPktg72WzR2UkocNLS0HyRRrSrGkPspypkEBYB2Jbq10MzXv+4sz0FtgH
	 vOeEVRFN1GIf2e2jFvExt2H55oGbgPiNAmzS0of2F1zfPQrch69HF2ntXfpvqNCWbW
	 BIEP+jwyLe0kMPqJBXaj9JupWfEah4l2x1H57ZzZoDruWBK8YuB1t6/yvvXef5YKZs
	 H81jPXIlKc7hA==
Date: Fri, 5 Sep 2025 14:25:55 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: will@kernel.org, christophe.jaillet@wanadoo.fr,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/amd: use str_plural() to simplify the code
Message-ID: <aLrW096GmNn0o_5C@8bytes.org>
References: <20250818070556.458271-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818070556.458271-1-zhao.xichao@vivo.com>

On Mon, Aug 18, 2025 at 03:05:56PM +0800, Xichao Zhao wrote:
> Use the string choice helper function str_plural() to simplify the code.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/iommu/amd/iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.
