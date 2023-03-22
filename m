Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690C328FC;
	Wed, 22 Mar 2023 13:27:13 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E3C57242DA5;
	Wed, 22 Mar 2023 14:27:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1679491632;
	bh=/6m5yG9DudYmkEEdukc2oCkTOzjwQANZcn2PD4YI7Rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gq7SER5KnPf3lzcNvuz2FDcun3p0eWoQq4/iIIrySyx/MduM8NPNIockrvRSMF+N+
	 9RFlVlb8xn/L0h037ZGvoecf92g2pErnVqMm7cgSW9Ij2UIXifQ1uyZXYzeyc1C2Ho
	 aOx77XYV1ome7bSYxg0BrEjFrrB/UX3k7KiX8yI6PeaoZ9rLYFfUimzZIgajgUrAGT
	 I7k5fMjcwCb1qgSVJ8YUja7MbQlT6s7VSqfu6AVoJRtyqP8AXANcpfU7gwP7F38Nvv
	 sGL9dpXrR+eNpYNZI4//nq49Iz46a7mCAO7W2shYvcQ+SfBIcWuVNaDNQr99Iii1yU
	 M5AKfR9ZrwBqg==
Date: Wed, 22 Mar 2023 14:27:10 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Nick Alcock <nick.alcock@oracle.com>
Cc: mcgrof@kernel.org, linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
	Will Deacon <will@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 07/27] iommu/sun50i: remove MODULE_LICENSE in non-modules
Message-ID: <ZBsCLiCnZFGbZG0r@8bytes.org>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
 <20230224150811.80316-8-nick.alcock@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224150811.80316-8-nick.alcock@oracle.com>

On Fri, Feb 24, 2023 at 03:07:51PM +0000, Nick Alcock wrote:
>  drivers/iommu/sun50i-iommu.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.
