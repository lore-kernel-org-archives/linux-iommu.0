Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4563446B6
	for <iommu@lists.linux.dev>; Tue,  3 Feb 2026 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770125263; cv=none; b=XI/SdMfjG+DcsQ87Yud54QUlgDvpf3RYIaVD96gi80cw8RZC6h7XNfmjvgIY05OEl5O5HdrpKSG9YbTurulHZhcLuA/835TiLsUdNYV/7yohmsgHJwKvZHvvEgyorYFtdzCD7nI4I6bSRfOk0usb7aaDiptm5m7IxVhl7aLRAI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770125263; c=relaxed/simple;
	bh=+dVc1riDL4Fpqhgeppt7G+kYdpSj9LDSSRzTrko8hUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jS2Wv8xk+G8bkPrO/shEJ7Xw8b8tbzF3U28yPrOSZ2xw2f/Paqa//MIFixfh5xIKRKCdQrLW7qqt5ii55ntO7GnIUea9yDGBsvXMiEe5yK9U5XFA2txGyFT0EBvcdAXc/GgoUiuHT3SFYhURiFqgTdZhCYidNw4GnsgX6d7jLHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=TMFGEt4m; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="TMFGEt4m"
Received: from 8bytes.org (p200300f6af1d96000d555eefe9f0908c.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:d55:5eef:e9f0:908c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 58F811C10E5;
	Tue,  3 Feb 2026 14:27:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1770125255;
	bh=+dVc1riDL4Fpqhgeppt7G+kYdpSj9LDSSRzTrko8hUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TMFGEt4mHp3zmaQHpYMZli3NRKmEejlqa8wcjjOIm6Grh91H+ngusGzMShR1ir3az
	 AMbNMS9p69sQNqKen2zJRgKP3dfUGKxK01uCjoeKTB1p76oR48fLEHCsLK367Kuj9j
	 Iob6UZheqmMtcVPWr9EG+ZYHkpBAWmkbSaH5H+KpRFz2CLSS7X8Eekna0u+qR+zqp5
	 nfY1XTmXdLE6UrYWyV0jzCS16DKCq+fLIZFpEW0rMD3kKDHfwH254QSlbBo73GD1SE
	 NIRqgBm8Cq8HIIQR0o0P3eo62Vud41xQ+wZbCF0QejMDHS3b1xj4Bd/HvlY5ZDdJW2
	 dzxLs+XrVFm2A==
Date: Tue, 3 Feb 2026 14:27:34 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, vasant.hegde@amd.com, 
	suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com, 
	linux-kernel@vger.kernel.org, Srikanth.Aithal@amd.com, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2] iommu/amd: serialize sequence allocation under
 concurrent TLB invalidations
Message-ID: <ky3dom2xc45ct6gtqv33avztqah3ol2rkgjmwvdz5zewureaz5@afiuoaz3tid4>
References: <c20ac675bae8565ca6307eae65efe8b71345e62d.1769054653.git.Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c20ac675bae8565ca6307eae65efe8b71345e62d.1769054653.git.Ankit.Soni@amd.com>

On Thu, Jan 22, 2026 at 03:30:38PM +0000, Ankit Soni wrote:
>  drivers/iommu/amd/amd_iommu_types.h |  2 +-
>  drivers/iommu/amd/init.c            |  2 +-
>  drivers/iommu/amd/iommu.c           | 18 ++++++++++++------
>  3 files changed, 14 insertions(+), 8 deletions(-)

Applied, thanks.
