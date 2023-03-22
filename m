Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9C46FAA
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 13:57:04 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 7AFD1242DBF;
	Wed, 22 Mar 2023 14:57:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1679493423;
	bh=Vb7ZiH4WrN7nhEeTSahG6w9edkD1EeU/gIytgAeWVhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=4Hy+KMJi4Hl2Ru7ECCjW6gi1yvgI+xcG+63qnEtGf9WM2O8KfR6U5rBQp3VZiNA8C
	 krRfqLUzb1wjK87VLlz6A4E5y/JCvKEbjIo1FWrtQPruM4nryxDHwCQ0TjIVad5rRK
	 L5cmUZ4DobCWlE8VOOAyEluQqvFhtjmHtrHzY2pc3owkYZFW8cy8mgL8Q+uiIe/dha
	 +N2qd6nztykd8S6BiM+q5MTJnmexTS21+sS2w0M7f50F8MTMJCWJF1zlHF0ms3zMwp
	 xrIxc5dgKBHeGJ/SYUxZMXzVJZ7Jxv3sOY2a7KFeIuGR/65ACmprBLdOoUIgItwYmI
	 B+K54ABssbSHg==
Date: Wed, 22 Mar 2023 14:57:02 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Rob Herring <robh@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	devicetree@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: omap: Use of_property_read_bool() for boolean
 properties
Message-ID: <ZBsJLkRjBsaVG/64@8bytes.org>
References: <20230310144709.1542980-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144709.1542980-1-robh@kernel.org>

On Fri, Mar 10, 2023 at 08:47:09AM -0600, Rob Herring wrote:
>  drivers/iommu/omap-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied with minor style fixes in the commit message.
