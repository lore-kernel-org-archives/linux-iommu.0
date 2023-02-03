Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CC01FB4;
	Fri,  3 Feb 2023 10:21:36 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id EF54A223E73;
	Fri,  3 Feb 2023 11:21:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1675419696;
	bh=aNTbAULS7WsWPSOr/TReq3Mz/0kZAyyR8eXbUDeUWRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UpFKNyxyIFsx8S0NQ982PN/4BwNkSFDbL+Z6uxkQO7EOPZwdC7j0iinDL/mrr4t4o
	 lbBvvvtO1il46wDSoJOxxL8HLq1ao/yAc51Lxf9uUUqeEsNGxlWRIFy9nVftaVN5AR
	 FYo6IKSmNUkRFivi0or3CecJPjM8amf0bnh5IYe40fc9dZ7KevQMvybu5pnoJfrMb/
	 Jal6Tat9buiK45YnJbkalAIbLjcUVAjG8nx8mHQtZWjKuNZeM92JZuz9Ilnpzb8mD2
	 HGCVb5OMIahRuKf8HfCZnRmz+hGVGTyxifIBTaJDbcvEOYNnOCGRnZNTiPKALxNbZU
	 MXIMMmFt89MEg==
Date: Fri, 3 Feb 2023 11:21:29 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Samuel Holland <samuel@sholland.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v2 0/6] iommu/sun50i: Allwinner D1 support
Message-ID: <Y9zgKUUjjPq8ifPn@8bytes.org>
References: <20230103010903.11181-1-samuel@sholland.org>
 <Y8qvIRXcCdLZjDCK@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8qvIRXcCdLZjDCK@8bytes.org>

Hi Samuel,

On Fri, Jan 20, 2023 at 04:11:30PM +0100, Joerg Roedel wrote:
> Once this is fixed I will include the arm/allwinner branch into my next
> branch again.

Since there was no reply to this I nuked the patches from the IOMMU
tree. If this is still relevant please resubmit them after the next
merge window.

Regards,

	Joerg
