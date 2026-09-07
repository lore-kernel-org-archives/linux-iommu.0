Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDC0439F9B
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 13:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786218; cv=none; b=quXOVLSKw3hxuDqgV6YO6lc5FXTGm/Sw3Ru3rsrAM8mWOMuto3Sgn4ZvDb1so3mGZOZXrag1aM88rL6CVlliMspdTlypW9LfAAmowDaYNHErZiYdnCZb2MEYE4kBmhjh7TeQ63Hn+EsNoVAoUf8sseb9bcnCDRfnIbNWBhe0Rr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786218; c=relaxed/simple;
	bh=qLk4CpThOvR613kp6RlruMZyDmaltbGcEs7khkycMSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpxMtMY+VrSytHUEnhFFuy+Gu2jOFJBPbLa3fmUwOT0MX1gDZmq9v6tWZI0vbfyQ33tMMG25TBLxomGYMp24qUfWfXfBG0zvax5yJ0tMg/b1UUw8iadz7Nh3WFZW9MjGKd7aSTkCYz5+iKAGTVOqrypzpor6JaZmnpu9ARfgxCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af085a0015db8e28914752a6.dip0.t-ipconnect.de [IPv6:2003:f6:af08:5a00:15db:8e28:9147:52a6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id B51F3209FF5;
	Mon,  7 Sep 2026 15:03:24 +0200 (CEST)
Date: Mon, 7 Sep 2026 15:03:23 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: suravee.suthikulpanit@amd.com, vasant.hegde@amd.com, will@kernel.org, 
	robin.murphy@arm.com, jgg@nvidia.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Fix ineffective error check in nested domain
 allocation
Message-ID: <ap62C_NgciyduxGj@8bytes.org>
References: <20260825100554.2787577-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825100554.2787577-1-hemanth.selam@gmail.com>

On Tue, Aug 25, 2026 at 03:35:54PM +0530, Hemanth Selam wrote:
>  drivers/iommu/amd/nested.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Queued for -rc, thanks.
