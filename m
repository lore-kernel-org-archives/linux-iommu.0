Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4D33C73EF
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123179; cv=none; b=s+NljV+B0gjvUuoGsxbyUe99Tw//JCG4AwSrl8bx8eexVnxf5XHtX8Z6w6orWjPabcvj3AkzAD3yJ0hbCu0Y7vcO7A3dSxiNzlim/YCcPKQOCjhzaql+ARf/cJvubJEPgPBaY0bf6V2vDsoumNSNokS+CR0d8MopwS6S3ihrtFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123179; c=relaxed/simple;
	bh=x4HyE57YPoMf/yt9TYVPiWeTgpr8QUxrV7uYHdaxUuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0b3heA0ENpfA5AdapzOGUieSTPHBlY9v/bJ6WEZLLO+e4lrcua3RXT8qbhmc8wsXoxPq1ebtzGgAO+rjhhnWE2xDaGHE9JEaRwW6J+ZoSE4sGseSREQ5IRLHfRC4K4XkP+86dqs4BG+xIi9jTlkWxzynLIUn6yA866jsBpGddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=mTQDhOal; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="mTQDhOal"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id F19901A6210;
	Thu,  2 Apr 2026 11:46:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1775123169;
	bh=x4HyE57YPoMf/yt9TYVPiWeTgpr8QUxrV7uYHdaxUuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mTQDhOalvHzaySdiuMvqlDfsFlg4zVqrPh2gxBV+Px/KyyzCyuBcn3QICGQZRUth4
	 ynYwAZY+Hbrc1kg24HKx4ZHIB7Wl87w7zuZ+hAqE4+OB0WeNurXovu7mrf0ysLtwFL
	 eHzSBPmQO4l08nZ3jXywq71aNCGb2tAV+c0RqoZlOshdXFRF3uKIKCY5Ea7Zg9aRO5
	 v22h09ihevDC6NHhMXHCPDu+KgbHf+hFeP3JVNbHKADCi8vji1HixREm7fZtTsNPra
	 83fsgpwamvU+F6lpU5UvO7gr17In+vBqnagUN6OJHpOrTIL+QHr/w6lvy10PBDVIGJ
	 5aoSqKgFRybeQ==
Date: Thu, 2 Apr 2026 11:46:07 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Magnus Kalland <magnus@dolphinics.com>
Cc: dhsrivas@amd.com, iommu@lists.linux.dev, jonas@dolphinics.com, 
	larsk@dolphinics.com, linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com, 
	torel@simula.no, vasant.hegde@amd.com
Subject: Re: [PATCH v4] iommu/amd: Invalidate IRT cache for DMA aliases
Message-ID: <vjmaoa3wyildzgj5gvmptgrkiel4lx6uu5vwtkymzrz7ndswig@q4puvu65kdn2>
References: <zloboj7ie2nlkchbqkq67d4zoolbn4lvp7ah2hmluznnov5tnv@a76hwaajlted>
 <20260402075239.19851-1-magnus@dolphinics.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402075239.19851-1-magnus@dolphinics.com>

On Thu, Apr 02, 2026 at 09:51:24AM +0200, Magnus Kalland wrote:
> Hi Joerg,
> 
> > > drivers/iommu/amd/iommu.c | 30 +++++++++++++++++++++++-------
> > > 1 file changed, 23 insertions(+), 7 deletions(-)
> 
> > Applied, thanks.
> 
> I just sent a v5 addressing the requested changes from v4 from Vasant.
> 
> Please apply v5 instead.

Replaced v4 with v5, thanks for the heads-up.
