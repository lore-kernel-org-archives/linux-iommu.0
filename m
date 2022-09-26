Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ED07B
	for <iommu@lists.linux.dev>; Mon, 26 Sep 2022 11:29:18 +0000 (UTC)
Received: from 8bytes.org (p549ad5ad.dip0.t-ipconnect.de [84.154.213.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 91B6740790;
	Mon, 26 Sep 2022 13:29:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1664191757;
	bh=YA1KSBb4TMFaxBoVsTEJxPWbD1tkx3//7XWiLOD4VIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9bcKGS//ADiVjJTEkE0h/1m03kSrokYWZhHCGIQ1XlQdhxKx1y6EGicsZRYtlb7E
	 cYLfDxbnCk58Tq4jPg1o6HyxVlJ/v3i0DUnQTwk9F8STxZfCaxqwjssY0xJWFf0PbN
	 e8OWm5V3EMJ46ogOJXbpaHv1R1TMaGQ2Y6C1AupxU3u03Y+C7GMWuOde/XB/2w+fDJ
	 aop3jnc8fNyD6UgKeR4n5YOhWhNKnyHDOokdEw8DXwZHNOj9k+ts/HuHNe5REVwoAy
	 Ri/rfa9VMn2dVpIi8J0GdVbbRXogDnFjx0vDM9vSU5qbsapB1pnS8ccxHB/b4awUBo
	 u0r4Jpkz9Ap3g==
Date: Mon, 26 Sep 2022 13:29:16 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 0/5] amd/iommu: Cleanup and fixes
Message-ID: <YzGNDGe5rTtWmlcp@8bytes.org>
References: <20220912063248.7909-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912063248.7909-1-vasant.hegde@amd.com>

On Mon, Sep 12, 2022 at 06:32:43AM +0000, Vasant Hegde wrote:
> This series contains few fixes like better handling of error path, fixing
> sparse warning and trivial cleanup like removing outdated, etc.
> 
> Vasant Hegde (5):
>   iommu/amd: Free domain id in error path
>   iommu/amd: Protect domain update with domain_lock
>   iommu/amd: Free domain ID after domain_flush_pages
>   iommu/amd: Remove outdated comment
>   iommu/amd: Fix sparse warning

Applied patch 1 and 3-5, thanks Vasant.
