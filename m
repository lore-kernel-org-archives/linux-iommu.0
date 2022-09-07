Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0759F5C81
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 13:45:29 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9925F40793;
	Wed,  7 Sep 2022 15:45:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1662558328;
	bh=iFiaRZ7atn07KtTJA7EX1xTm4N7M+wbNCgbxCsXt6Ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GiCtPyNdqHxtBjuEcikhA6TYHpIaQ8bPP05J5GUs6etfMDU5/fh+/tAQEiWCD3/FM
	 W1C4r/FZ5AAo9bF/QzBv6+1Rhp3LdH3aE7kxnw/hcSIhnI99R6EcVy/cylBBHUXSC1
	 mx/+c26Hu8aIG3aVAbc7es7hp3tYgRCWywpbZs3FoCuZHmGY0QFCgESio3LKtGdWc1
	 YCheiFy5UAybYr2J5c1+XeS5JHBq27r9oIPjf5F6r6sKHWmJ9WXVUs0cSgqlWzRDI5
	 RT5HFx7gNd7EkPFG/nM+y9aWj0GU55rXpE77WTcZarorEyMrZc4gMzwx4Jx9QtDOMK
	 gPhl4x0trSGcw==
Date: Wed, 7 Sep 2022 15:45:27 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: will@kernel.org, robin.murphy@arm.com,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] iommu/virtio: Fix interaction with VFIO
Message-ID: <Yxigd/hKLp8g6UfJ@8bytes.org>
References: <20220825154622.86759-1-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825154622.86759-1-jean-philippe@linaro.org>

On Thu, Aug 25, 2022 at 04:46:24PM +0100, Jean-Philippe Brucker wrote:
> Cc: stable@vger.kernel.org
> Fixes: e8ae0e140c05 ("vfio: Require that devices support DMA cache coherence")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> Since v2 [1], I tried to refine the commit message.
> This fix is needed for v5.19 and v6.0.

Applied for 6.0, thanks.

