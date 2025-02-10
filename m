Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631D322FE13
	for <iommu@lists.linux.dev>; Mon, 10 Feb 2025 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195678; cv=none; b=lTmAsriCn89aVLk9L1lqbAUGhK4IRfTS4lvMjHG/l6uJQkWeW9yormD6SZQC+wcZnWF9lCXNQQL6xb3SCSp+fOfn71Ysm70jCILfcoCvlGo3ElGTIx9mrjgDJN7TQb4h1WSCbCsz+QA4B4NnEQgWm0vtrI7gDzWa3Wu2DCYoNpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195678; c=relaxed/simple;
	bh=EBmfMK4QS4pRei/f9tG8t1B1Uy6mxxxzUibxUE2WFGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAogCzU09msuFUOsfA6iZSA00FTfvUPC88x0BuQr0VQfopTthMMPro6P/RrHDnLNQvebhMvU185aI6pCx4oJSC2M60qWM673czNa7pz1wxuANksxBTg9Mi/FoKhav2FTIU0V1OJpNdpG4QU8kyehbGH4OcXOIhAvEou6rEh/eWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=B4e0Rq7E; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="B4e0Rq7E"
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 433D9418B7;
	Mon, 10 Feb 2025 14:54:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1739195675;
	bh=EBmfMK4QS4pRei/f9tG8t1B1Uy6mxxxzUibxUE2WFGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B4e0Rq7EAJ/KduRAts1i6TqvgMdBMhq2DyPa6y7OdYrRgShK0HQquWG2DgzDTmejk
	 Lgisezy8olcnndZb8M5bvDQXrFywkawgZbPyFpu2Sapif+s3wBYDP8ITUhP0z5GPy0
	 uecqVSz2WK40Qaqv82ryJOpZrDkKKoJpp2QqgB/EmVEijuDuuLgQkByQhBG9GsDn/A
	 wj6UTeqyrOgzSLhw6yd0GEIRqKHrlkvi/aOeQdDAknbdvE8vpSpoCh96WqwlSOI+pE
	 n9NtPTL8+DPa/U7LZqJZ0m1DaIRCANDABJ2KQ9FaUwwO/9y7TinUQaiz5ADTz7Rzrn
	 +VA7pSgdEKI2Q==
Date: Mon, 10 Feb 2025 14:54:34 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu: Fix a spelling error
Message-ID: <Z6oFGsruWIy1HUnb@8bytes.org>
References: <20250128190522.70800-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128190522.70800-1-eahariha@linux.microsoft.com>

On Tue, Jan 28, 2025 at 07:05:21PM +0000, Easwar Hariharan wrote:
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  drivers/iommu/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Added a commit message and applied for -rc, thanks.

