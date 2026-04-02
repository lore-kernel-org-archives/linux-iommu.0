Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CEE32ED32
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115195; cv=none; b=RBIAXVZYVxDojKT7kH7TACwzlvt8oqsZToWPdzttFbF8f38zKDv6ST5Sf5iM7hRZocIk83QDh/8c5IuD6YO3SIVBTbPC2IoHiH83nh/IDWt84sJAOZdTAdNqBLiUgTtt/7o290DGL42oywmaO00DCgktCk+GVFJNoNUzMjkTTkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115195; c=relaxed/simple;
	bh=6yG6wSnz4ToyGHPBR+oticR/hibKPy7gVsqkqWVaKXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcUarPuSRHL4fzEu8+ziKe7MLP1hYjZPNoMeEMfVK7kREqt3QgRhnMKDPu0Rh4rGdqPz5SaD5wqvKOpIip0k+FfSQ0dJXS7yyWjUbGedqBeHGZnSfo9UticaiJ6l9E/v8zZmbnnvnKF6whuB5Ax3iNDQNG2JPwvRspwIE6voe+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=FK/EO4Hl; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="FK/EO4Hl"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 6721B1A7158;
	Thu,  2 Apr 2026 09:33:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1775115192;
	bh=6yG6wSnz4ToyGHPBR+oticR/hibKPy7gVsqkqWVaKXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FK/EO4HlcX+OLMVjgZAeZtks+1J68La3QA2iTMfidntOoNyiA6H/O/ifIV4poTuGx
	 jH+vDGAzF+td+st4EP4uIxQcyICkvsfGKOA06zBPj9iSg1LaEA99tUGyXqWeyhb7HG
	 r4+/b4YtzB/h34x6l0zRuovLJ1chmb13/fKko38GJMPREmAfy2CqOcMgPqFGWPxPAt
	 MzjP1nOhsPjM4n7krHz/rJdT6r7Zp9aoVpx7DUQVhjb4jFMZ1bd2bKCiCWk3Jw8W93
	 saI6QEKowS1dpM5I8klv82NxR7PUK/L3KR4wJCWLELachVX8/YjRYAgEVhAxYH64BK
	 svebucjp1dmOA==
Date: Thu, 2 Apr 2026 09:33:12 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Magnus Kalland <magnus@dolphinics.com>
Cc: vasant.hegde@amd.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com, dhsrivas@amd.com, 
	jonas@dolphinics.com, larsk@dolphinics.com, torel@simula.no
Subject: Re: [PATCH v4] iommu/amd: Invalidate IRT cache for DMA aliases
Message-ID: <zloboj7ie2nlkchbqkq67d4zoolbn4lvp7ah2hmluznnov5tnv@a76hwaajlted>
References: <20260401112021.76806-1-magnus@dolphinics.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401112021.76806-1-magnus@dolphinics.com>

On Wed, Apr 01, 2026 at 01:19:22PM +0200, Magnus Kalland wrote:
>  drivers/iommu/amd/iommu.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)

Applied, thanks.
