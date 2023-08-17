Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6095CDDA5
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 11:02:28 +0000 (UTC)
Received: from 8bytes.org (p4ffe1bae.dip0.t-ipconnect.de [79.254.27.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id D6999280B2F;
	Thu, 17 Aug 2023 13:02:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1692270148;
	bh=nRkn7fOfqFHavbPR49fgCUe/i704RikzR80RviVwJY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qIjupLY3I/slS3GTF1zSkIKkxjsbtGea2yBN1emCSgAA4GDOhySkg6daVYiV6Yobj
	 a6KCQRldqIHGK6lBByNgGFJkFL/1jypOSobytaWQrl6Lnrgv/Y3kvq/3yR2TTg4kSU
	 iP548rCcpNTxbVPvldt0vGYbLAFaD4IdNnuXonGUELR43idvIxPrXAKlFw8mRYmHpF
	 KH9QgW7Id19WYOBWHUxnHZ45H96UYyuXlX6PxJx0dg9UFO+59/RI02LdOvILJ6I0Ry
	 0lt2tLFRWR46ilhUolpuECo4AUqXuacKk7bvE11thZxXA5K/zRSOQUS4g5dMwzro/T
	 xgCUSzmkqdwvw==
Date: Thu, 17 Aug 2023 13:02:26 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 6.6
Message-ID: <ZN3-QmYVxcYVGFwq@8bytes.org>
References: <20230815135145.GA12068@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815135145.GA12068@willie-the-truck>

On Tue, Aug 15, 2023 at 02:51:46PM +0100, Will Deacon wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates

Pulled, thanks Will.
