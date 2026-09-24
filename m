Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AAD476CCB
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248979; cv=none; b=TB1z2cDLl82WEML0A8fUE6uG85dP9BPSKF8rEpD5QMxFnTNjzTlK7a+BeJ07xHfu5zJUBFRGIfEeh14/yHV8wnsR4dOSe7Y/WsCuSKrzCeMPMYr0BX5SqUI/1s5+GluPJx9Gtyb01f333lwiQXI3+vy0UqJQupko+BK36OV1S1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248979; c=relaxed/simple;
	bh=upj1Qi6EO6O83Z3dqzwNdYyq92GxjGBCbVO1O7+n8tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AflxanSn4xtU1WjK/dsPJXPHt83aEi8yNOSEzQBM+2WqB6rGbM4ZtZBeEASPJtG55N/Qv8Qjz5p6vPmjgxJJE2bC3uYVY1LLTuKMNP/58N4dhs2N5KPy9hmH989OP69R72poACaCFjC+Hl07mfWLxhVWuVOAiUBfLCc4YTyudJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00e4ccc4fdbbd66590.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:e4cc:c4fd:bbd6:6590])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id CCDE61C7465;
	Thu, 24 Sep 2026 13:22:56 +0200 (CEST)
Date: Thu, 24 Sep 2026 13:22:55 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>
Cc: will@kernel.org, robin.murphy@arm.com, baolu.lu@linux.intel.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/sva: remove iommu_sva_present flag
Message-ID: <arUIAoZlcYruNHd4@8bytes.org>
References: <aoq8VGFL/Mdjd/M5@hostpc>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoq8VGFL/Mdjd/M5@hostpc>

On Sun, Aug 23, 2026 at 05:24:36PM +0800, Zhaoyu Liu wrote:
>  drivers/iommu/iommu-sva.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)

Applied, thanks.
