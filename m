Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09D0168D2
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="tb5eKP64"
Received: from 8bytes.org (p4ffe149c.dip0.t-ipconnect.de [79.254.20.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A42BF1A45BC;
	Mon, 16 Oct 2023 09:37:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1697441874;
	bh=iFDKFS21j+PdzHEuBrJScpzUlh6ZN6wATcDa0c2Kovo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tb5eKP64ylz8V5E5bq3xJiABsjlgXYyijqKJnfE1NvMYLDD2BhZvoSIuDjDi5Rg2u
	 uFcPmKn/3wNO2ld4If1K0I1YN+GKmSu1SGFjUqmQ/h5CAM12O48d5GPVSmAFpMqBh7
	 VpcXxFgLWSt85q/RN7/fLtJ/nxKglm4rfXlq3Uy/erZ2NwbHPjwDQZVE8knNCzNEte
	 hZ5hBVg+8E4uV3hYW1hUlX4Anvb/VzF2YMKsnyYTUAMVwi1d8ENgWItb2QNerFkCTk
	 Dc2/l8DA4YIC5G28+VEgn9/rl7d8sSE+w0X7+TgsFeXwx8W6w+yvmXstzrWn6+2bOx
	 Mn+FUAH8n8S4A==
Date: Mon, 16 Oct 2023 09:37:53 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iommu/virtio: Add __counted_by for struct
 viommu_request and use struct_size()
Message-ID: <ZSzoUVQINYrYSv8k@8bytes.org>
References: <ZSRFW0yDlDo8+at3@work>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSRFW0yDlDo8+at3@work>

On Mon, Oct 09, 2023 at 12:24:27PM -0600, Gustavo A. R. Silva wrote:
>  drivers/iommu/virtio-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

