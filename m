Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BB27481
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 14:40:09 +0000 (UTC)
Received: from 8bytes.org (p5b00664c.dip0.t-ipconnect.de [91.0.102.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 25EC3260071;
	Thu,  3 Nov 2022 15:40:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1667486408;
	bh=mf7OaYDXqcld8wWiThewtp/HY8K7iFfmoq1U0fGzWYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RA9UJnn49z7YdSAgp2I3/ITuIe6U3r/qp5fYYYQl9uSVuXJ0oXXKPVvXwFIIP7hof
	 T+soRndeNz7S6wfdPlU1l8xvCdOa8XEe7++RJ45KApiY5K44K7bGxAHVysyURjIEK4
	 9/ce/q8sba0zIYjDXm5qu044uLR5yFUnQRQr+8VgUJ8ApsSGQ76WZTnUITRlUtD/h4
	 MG6QOT9yNBG13JSBCvEeIE9bIEpebJzigzTjvFM/PR0/S/7N7jhS5uEYKXQ3SEEtmp
	 Qj+fpFbC7cBGsGVG5+K5aVwPskLhhXc7pj94xXvDhImSYs/NeeY/KH+yKSMwkVkdIQ
	 A0kywvgTobOLA==
Date: Thu, 3 Nov 2022 15:40:06 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: remove variable cnt
Message-ID: <Y2PSxkHG2X1Vc+vN@8bytes.org>
References: <20221024134301.2158939-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024134301.2158939-1-colin.i.king@gmail.com>

On Mon, Oct 24, 2022 at 02:43:01PM +0100, Colin Ian King wrote:
> Variable cnt is just being incremented and it's never used
> anywhere else. The variable and the increment are redundant so
> remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/iommu/amd/iommu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Adjusted subject and applied to x86/amd branch, thanks.

