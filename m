Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429672;
	b=t8fjuD4+odAAkKpDBNubZ1KPQUlZNmOLjDxxmuSvt+s31ZTQ2kxRJggAXbCkny87TxfP
	 /ghb8feKbzwEfB4O98Zslw7meddO9x504su6SC6YEmY1hDU+PA8LfmbN0yutrbS9B0+wN
	 4JMOK4PRzIwNV7w7/eNHqx+himghdgz8Cf9ofx/zrQmYeAFUMK69Gdqtb2bTwL5Y73hrK
	 DxdXGJtpkgTQOQYlDwrB+WOqi96U/831OQbw4rwcy331wMPAr5r7tkPIF+AJalv8Ar/rK
	 4odOuGNc5BovWqFqCpsarr6zZjzd5iydJx3DLuW6pd9uhhEjsobwbmR7I6cymx2cf8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429672;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=P/fjNOsxL+AtNCe+JS3FMFLuB7GlTW24nnaYIg5FTsM=;
	b=3KzX7bqBkD2obFatcyjNrUxYWvusTqjRIOtsprRvC0sosSIX2ycXNnrAUZBGfBhasW1U
	 GfrVhYm5ph3s+kJp0Q8ZXOzRxTroDQ++eKwoaFPm8xhApXpF1cxp5FrKhVygju4y9Ztrf
	 DARfv5eipu5Hxq6bjNpFiNX9BOK+SeXCkgu4W5cQMXSsdFpMhu54NWQJFb91Of3FfCJai
	 AAJe1UkUoEdn30xth6ZcU5S9d826MI+qISK8i1nyUhdfsDhN2mhGP0bwg2FBhaXZPGapv
	 QTJu8//+3Qhk5yCwSbuxzAF0bi5WFWTFpZZvIsxxgmShHK6Nn7pBEDpKfnb1l6GgnUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E29606A330
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 10:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11E29606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DE41B244826;
	Mon, 23 Nov 2026 11:27:50 +0100 (CET)
Date: Mon, 23 Nov 2026 11:27:49 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: Daniel Golle <daniel@makrotopia.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joerg.roedel@amd.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vsi: keep the runtime PM callbacks without PM_SLEEP
Message-ID: <awQVEpz3c3dlQ7i2@8bytes.org>
References: <e8114502dc91f5fb709509291fdd85e27545dfb6.1792716048.git.daniel@makrotopia.org>
 <50f5f070-49cc-4a1b-a100-5cf918fed54f@collabora.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50f5f070-49cc-4a1b-a100-5cf918fed54f@collabora.com>

On Mon, Oct 26, 2026 at 09:33:14AM +0100, Benjamin Gaignard wrote:
> > Fixes: 917ace84b770 ("iommu: Add verisilicon IOMMU driver")
> 
> Thanks for the patch.
> 
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Applied, thanks.
