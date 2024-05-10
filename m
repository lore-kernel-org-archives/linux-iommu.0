Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2E15490E
	for <iommu@lists.linux.dev>; Fri, 10 May 2024 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715324701; cv=none; b=slIZPEk2phHhDZU8bvlWydIb1aZEu4smqmCSbE7qDUCHvG372KPkt1nH7cQImsCcJTAq0aF0b1KibLEUqC8Nd0v3pLE8pXAAR7wNrEEsTqX922aPpZKDAqxQTG3Ki0k1uiLsONIZAg7we29SArcwCWcFxFT/IRfqOoIJ9p2za40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715324701; c=relaxed/simple;
	bh=cKTcfaQrnih/HQaG4vLIiNASL4N4ftFxPR1yWJb+Wq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvgzeAnWZ32ja6NjG95uPFN0m6iMVSU+Ow7iFtxG8XP38lzjLDCpNWGaWdWVNzoGdNPLxt/8J9ZvJPKdQclJDF9aZK6UKYHPCswUyfgGiQhF+Tdw76nnaxcVVtVI6C5NJCJSIS2EJtPtPMzr2bdejhz9tD7VgzkhxwqGU57wNxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=MoPy6Iy4; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="MoPy6Iy4"
Received: from 8bytes.org (p4ffe0bdf.dip0.t-ipconnect.de [79.254.11.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DB7661C278C;
	Fri, 10 May 2024 09:04:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1715324692;
	bh=cKTcfaQrnih/HQaG4vLIiNASL4N4ftFxPR1yWJb+Wq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MoPy6Iy42oUItgPBd5q7Q4UIz4C2ajA+DFJxUhVLCAQ7jqXLngTSOVNhh+NotUpFz
	 ybKcJ0fbUhhmIqsTAk5Hr/3AGEEUyj3kvLwXM38lhdb9d8Bgu+23PX/qkX5f4MHqeD
	 UGTn6bp2Pu5GMP0yTJ871A8aQnGxqcyxOKeFehEbbGKZ+/IEKyGbB5tENc8x5OJovr
	 xuLvkfGKHKGDm7gcVZJzQLONour78XrT7Kd8e+VcVfYcH0ZSZTq3jMbrkfGwquXOXV
	 gOy32yn60v9lsYcBltUuYuVWYzk3RFlsp6MHYYzROuV9lSOAF5GxeDnTn6dxqLSiY2
	 PVVmhHouzkQyg==
Date: Fri, 10 May 2024 09:04:50 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] arm64: Properly clean up iommu-dma remnants
Message-ID: <Zj3HEqZLOlrMNR38@8bytes.org>
References: <d4cc20cbb0c45175e98dd76bf187e2ad6421296d.1714472573.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4cc20cbb0c45175e98dd76bf187e2ad6421296d.1714472573.git.robin.murphy@arm.com>

On Tue, Apr 30, 2024 at 11:22:53AM +0100, Robin Murphy wrote:
>  arch/arm64/Kconfig          | 1 -
>  arch/arm64/mm/dma-mapping.c | 8 --------
>  2 files changed, 9 deletions(-)

Applied, thanks.
