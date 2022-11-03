Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73226FD6
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 13:45:56 +0000 (UTC)
Received: from 8bytes.org (p5b00664c.dip0.t-ipconnect.de [91.0.102.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 37959260071;
	Thu,  3 Nov 2022 14:45:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1667483155;
	bh=Iaiwo7D9Rrw+sA+ig2mBhOxAtfQms7zTRxU6Y1I83wo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZIZarNibES9GXaW2YPZMWbtBZX38/M2lt66BfCckVxHK0D/MRIWKwqgSPtXfrcyZ
	 uqBz6uZxR9RfhM6h45WAznECc6bGef64KgCS50GwUWE4c0cFsfLjcCByMzZpkMCbtB
	 kFyyOoTlN6r4hYnzJ+4Vl9fQ9nfi9xNnKjRiMzIhuXlHufmnWxhJYwEkSa5mCq7fHV
	 Im32yC+2FFPuVqa8tTCYAyNzSHSY3WBzqRt9yUPHd7JcLu8DTu1ccGYa9oR3sO8GWU
	 QxO3dCJhKOT18+CuJ98cJj/LA8M7C0U4OUaO68W5XHtBmeovEvG/tNSZ/T+SkSOtB6
	 WQEkLz97G1lWA==
Date: Thu, 3 Nov 2022 14:45:53 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH] iommu: fsl_pamu: Replace NO_IRQ by 0
Message-ID: <Y2PGEbh9zFtRqrPP@8bytes.org>
References: <2a2570a8d12c80a7d36837b6c586daa708ca09d7.1665033732.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a2570a8d12c80a7d36837b6c586daa708ca09d7.1665033732.git.christophe.leroy@csgroup.eu>

On Thu, Oct 06, 2022 at 07:24:03AM +0200, Christophe Leroy wrote:
>  drivers/iommu/fsl_pamu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
