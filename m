Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAF61C29;
	Fri,  3 Feb 2023 09:56:24 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id BB7B9223E73;
	Fri,  3 Feb 2023 10:56:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1675418183;
	bh=3XqqievITw2t2QG1VwV+Emtnj2p5q/klm0HM7CYydoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQ55Ae8f6qZltkzapqlC1R0Lsz+kmr+C4OjHZQeHmTNOPC0ANU2Ue1neqVWMl99eY
	 +nbBi7pqTcUEeR8p4kRpdwUa+TKdzLtsisMb1ASTyKTU8XdMFceaPpmN6h8HnTHN0N
	 2zciLEBxdMu/Otln2qCwjHJYnkV4L2nbFxGtzaNUHo6axcZr/XcSbarmgMYo0JkUeR
	 FT3X5dZlrf07UMoxhBd/dote/Coksgxge11kLbgbFh1z69xQm/agecUV85ZA6io1Jt
	 Eh/65jFF83cZ9nTC2WWJ4Qsdkb0vT5Svd9SM5KZ3QuN+rSYPsj+tqm4QVgI+HRp+Sa
	 JqS/VmTTB+zfQ==
Date: Fri, 3 Feb 2023 10:56:22 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Sven Peter <sven@svenpeter.dev>
Cc: Hector Martin <marcan@marcan.st>, Will Deacon <will@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dart: Fix apple_dart_device_group for PCI groups
Message-ID: <Y9zaRgki00RypvvC@8bytes.org>
References: <20230128113532.94651-1-sven@svenpeter.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128113532.94651-1-sven@svenpeter.dev>

On Sat, Jan 28, 2023 at 12:35:32PM +0100, Sven Peter wrote:
> pci_device_group() can return an already existing IOMMU group if the PCI
> device's pagetables have to be shared with another one due to bus
> toplogy, isolation features and/or DMA alias quirks.
> apple_dart_device_group() however assumes that the group has just been
> created and overwrites its iommudata which will eventually lead to
> apple_dart_release_group leaving stale entries in sid2group.
> Fix that by merging the iommudata if the returned group already exists.
> 
> Fixes: f0b636804c7c ("iommu/dart: Clear sid2group entry when a group is freed")
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/iommu/apple-dart.c | 51 ++++++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 7 deletions(-)

Applied, thanks.
