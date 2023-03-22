Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB1433C4
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 13:52:45 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 2B1EA242DBF;
	Wed, 22 Mar 2023 14:52:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1679493164;
	bh=9yWRBpoVvxeKLMGL+P9NNJ0mmKe60w5zWL+Wt/uaLqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hTLFyAZBp+DzV5r7u1zD+je2RjLjo5WyZ0ifGSwZyY3A/kL9c0vD1vzJRUq9pZTHd
	 ORmhWcR9X1Rw1ppaxvQwg6cz6vsJWV+jC9TGHAcGju6dOCKa62wnbfgDCD5rVvnFOT
	 y+uWm5S4TMP35cnf5AGaEKAHE77BjterHiw0EEC0kOC2SDxAUuvmh8fE33MlZhvtyz
	 M/xW3MTFjjm79DSl9m6QYVoqTZwlBLl1VX4s0dQuGkg4H8LctXfBrZ5jpGsWwBXARz
	 BMe05o4m4E/5R0YSu5jB01A1OsVawzddgzRLDk4xtcHnDpiesbURZClQvFRcKHQLFu
	 VEtYIyU7FtCkA==
Date: Wed, 22 Mar 2023 14:52:43 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Spelling s/cpmxchg64/cmpxchg64/
Message-ID: <ZBsIK9653BX9rgWD@8bytes.org>
References: <eab156858147249d44463662eb9192202c39ab9f.1678295792.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eab156858147249d44463662eb9192202c39ab9f.1678295792.git.geert+renesas@glider.be>

On Wed, Mar 08, 2023 at 06:17:08PM +0100, Geert Uytterhoeven wrote:
>  drivers/iommu/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
