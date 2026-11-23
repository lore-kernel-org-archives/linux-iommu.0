Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429906;
	b=Y6nzmA7zHg2cYGNl84PMY27svmDEdHTelAmDuVSYlIuc6ncNmrAO18uSBhaOTkaJaeg8
	 rEzYcyklBb3J3oTXiZW4PhybevWgDDQJrSLU5nRclIKYuSWKEI5M8nIub5zLLQmA6FI6N
	 naFHs+9u1STVB4K0SDnSvcBAXrsik0RgHlYdLuq9ZxO29NSAuO1znLkLycnhvvpehDoKc
	 Uyyg823jxmkgD3z0fdRC+a1BFxgturjIu25pJTPUKCnXvfcT8FlvMA0iQ/u8vL0xL0IDW
	 qGxrxOz0r3XzgDh59no2wZZkLmpXiSSNW+TYf9b+YsOMSIv2PqPckSsnLKMVMo/gkrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429906;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kWwm2LO8jLAywfexdnKv+KQglI5Zy5I2r2hAxvVQ9Uc=;
	b=tmdXA8LdUppNsaLurEnhpRzVOTd4+5UgMKNG4EKOkUgImgcjk2GwDuqnficb0pV3dX8F
	 zhbR6wNzS9Wmb+1Nz1tDphqwk7ANNkjZoLuA3z+wNuCfQ0TMPkUKbkl00KcD0uIfX/elv
	 5xJRYAX+6kpgqrBTScp4OI1fZ7M+7yJvIHs5pjw7GEqYpWyR9AWmZRPsXi2hXM7aMnUEQ
	 2xRR7QhU9GN0EgWNKreF4Yl8y0fNZFoBWkl7KH0CbX2avl2rN3A5OwHTtNStYcSG5dLZI
	 5ZemaQnDubGmN1rvQbKrX11SsWKhSyIAeXLQMzLIKZpX84W0LcehW5Gh1+pHVN5AKgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BACE606A31E
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 10:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BACE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9F5482436B3;
	Mon, 23 Nov 2026 11:31:44 +0100 (CET)
Date: Mon, 23 Nov 2026 11:31:43 +0100
From: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: aiyengar1990@gmail.com
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/3] iommu/vsi: Fix the domain locking and a probe leak
Message-ID: <awQWAaaqvPe-gN01@8bytes.org>
References: <20261114-iommu-vsi-fixes-v1-0-1fc7728dfd35@gmail.com>
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
In-Reply-To: <20261114-iommu-vsi-fixes-v1-0-1fc7728dfd35@gmail.com>

On Sat, Nov 14, 2026 at 12:14:24AM +0000, Arun Iyengar via B4 Relay wrote:
> Arun Iyengar (3):
>       iommu/vsi: Don't use the identity domain as a paging domain
>       iommu/vsi: Unlink the IOMMU from its old domain under that domain's lock
>       iommu/vsi: Unprepare the clocks when getting the IRQ fails

Applied, thanks.
