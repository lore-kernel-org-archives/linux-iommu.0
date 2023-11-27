Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC5017738
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="HDXDP6XK"
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 994461A4799;
	Mon, 27 Nov 2023 10:59:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1701079180;
	bh=4fArJRY/2HnzmxUj53izSkP6rBCg7+/g9dmdWslHlew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HDXDP6XK3tzZcqks7doJbHJjpzTD3i0Mcr7rXbKut6VMKq7tn41JGS+AgtrMqADUR
	 DycAaNxqepOoSCaUujibeVsWPBdWKwy/YnEvl3BOGnTDjOw6tYxvjmj9TF3hHtkWTB
	 7Jo4MA/GjrNKC/YLux0u1nUjvAd6zOmMNrFECfE1Oacsiqk93/HXFpYHWmqqG8/LTJ
	 ExUadNXoaVUy5ro2UpuFtenuUcPKFegLPml4oFD/4dG3oBRvhJrJg0C4CKE4EvrOnV
	 P7ZFvI6nA62KbgeKc6ThxcHO9BnIkfIpUkQAlMyEdjJG53UEF9bsmE+EyqXD4DztWo
	 903cjIF6XV4zQ==
Date: Mon, 27 Nov 2023 10:59:39 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
	kunwu.chan@hotmail.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Set variable amd_dirty_ops to static
Message-ID: <ZWRoiywi9Y5nlSOn@8bytes.org>
References: <20231120095342.1102999-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120095342.1102999-1-chentao@kylinos.cn>

On Mon, Nov 20, 2023 at 05:53:42PM +0800, Kunwu Chan wrote:
>  drivers/iommu/amd/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
