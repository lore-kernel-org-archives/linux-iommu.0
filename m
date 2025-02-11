Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BB91F1905
	for <iommu@lists.linux.dev>; Tue, 11 Feb 2025 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739276241; cv=none; b=R95jCcNgE6BJUaTnUhGTQntgvTrSV6rXSDydVLvyetYFDm3vK9pd1XAfmjt5c90GoAinh7Dp6u6fIVHh1yHXf0FCP2k2lHInaLzf/QHIRhffOd2cRaDSNnoybFNNgoZ3QbdgCY2B3XS5S0MO2bY8G+Rly0Si5llxsG9lOd20eFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739276241; c=relaxed/simple;
	bh=6aUhrzJlTBy3sWK4uKb4ZsjibWQEe12+QrvuuiLN5UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVYuOFZgwPis0oNF/qtLEln5NJLvKrm9eklP5HYSNiaoqwXIA6+gOk1my02w2/zQjgjJEyNS+3pGHQCrTY+dxzNPNqMqf6FdtTfF6bCw8xGGFJc/7NXL6sHZlbDobDJxPY1J4wFYZs5NkXdUO0ISCrTt3HbppVhiywUxr+xrNWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=d/TGtefH; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="d/TGtefH"
Date: Tue, 11 Feb 2025 07:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739276226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6aUhrzJlTBy3sWK4uKb4ZsjibWQEe12+QrvuuiLN5UY=;
	b=d/TGtefHLpW6ZjTac2OFk42U5TbMYSEGR2nBO4lgoKgazhrXof5x39MQ7j1ph76yUNjqSp
	wRI1Agy8c5q0nXK+6T4vTXWdlNAj+Q0y/OlcBjb4LjXb/o9zmPeFg1EFnIXfUVdsHzvc3/
	O/Fzm+Y4QLmJdwh9O6j8Z7hBvDEiNxqDC2IMFr35lSvKJ5ygr8VfWk18LrZ5Vh9g9Sp8Va
	/+IyeB6SoZIXl+qxOCHBgVj7h28znjHgyuWIimTLOhNHHYwfSOyob4KaDX0yCSZ2t0rPQo
	2iFxYmafjdXT/TZz2WlN5wsg36AyKUVNvfmN/VztiNAzPRFPMa95B4GmolOSAA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iommu/dart: Reject identity domain for locked DARTs
Message-ID: <Z6s_vXUrZjyhECC2@blossom>
References: <20250210-locked-dart-v1-0-5d97fe247f35@rosenzweig.io>
 <20250210-locked-dart-v1-4-5d97fe247f35@rosenzweig.io>
 <5d82d549-663f-4438-922a-6831e57e80b5@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d82d549-663f-4438-922a-6831e57e80b5@gmail.com>
X-Migadu-Flow: FLOW_OUT

> > Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> > Signed-off-by: Janne Grunau <j@jannau.net>
> The submitter's sign-off must be the last sign-off. It appears that you are the author
> of this patch, so drop Janne's sign-off.

Thanks, fixed in v2.
