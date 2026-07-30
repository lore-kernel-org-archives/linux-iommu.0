Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2722C40B0F6
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416157; cv=none; b=f1Pgig1GRZgf5x0SWrnTEY/pB8R7BQTp0agN45avrF5A2wkCq7+d/HCBblamAs9OtHflNrZxTOM9D8Ph0pq1OxtKiWtzs/KLnJKQyLzjlaSMc9hNyuw1240eL8U8QtS9hzurEUeyQqGhIZpDjrFAZlSKeXfhN9W9/OYgSw6J4J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416157; c=relaxed/simple;
	bh=XSWePFMNKPTzBfdKR+7/OFW3vkhEkw72AIcIoGxKSLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EW/c5X3AJ1oghAZDKmFOdi/M6pyovAoLol63g7wJVve5gJ74FfAjqH+dCMTepIduRh8ZywsGrO0NaUHDqm+/3ZmPgpnn1DGqF2fhkEepCwMvY3ScIyxso0R+xitRa4yW/FS9W/PMit2KhFqkKhsFZBbSSvZx3Dw26fdC0zc9hNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc50014f63e0f2a030593.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:14f6:3e0f:2a03:593])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 25821240AB9;
	Thu, 30 Jul 2026 14:55:54 +0200 (CEST)
Date: Thu, 30 Jul 2026 14:55:53 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Logan Odell <loganodell@google.com>
Cc: robin.murphy@arm.com, will@kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, mclapinski@google.com, skhawaja@google.com
Subject: Re: [PATCH v3] iommu/iova: Move CPU magazine init to first insert
Message-ID: <amtJyQp1aGbuyUmu@8bytes.org>
References: <20260727155720.2692587-1-loganodell@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727155720.2692587-1-loganodell@google.com>

On Mon, Jul 27, 2026 at 08:57:20AM -0700, Logan Odell wrote:
>  drivers/iommu/iova.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)

Applied, thanks.

