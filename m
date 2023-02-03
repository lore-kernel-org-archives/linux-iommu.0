Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9ED1863
	for <iommu@lists.linux.dev>; Fri,  3 Feb 2023 09:36:38 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 73C5E223F6F;
	Fri,  3 Feb 2023 10:36:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1675416991;
	bh=MJr0U0H4vWr6dntPE5wdZe7S5oX61+Ig68suUDwFqYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aOtkEv5c5w+rwJC/LWUQ+1HNWG5XG8Q3VOB2fycj1Ml0t0gUfeS9lrEQFEBC5Mogq
	 W4wKBcN/XfUXnjKESXSTE1LNl0nyk/tp5TD0oexckKB8wh2aTpoNx0KdOow5cJ2lH7
	 4UrJR0RKm6GwAXDNpL+/Sp8BQNjBknRI1nQ0tmCEmavA3x5+5nagd3FIVo92Erl+Cx
	 n0R5igBQoBbmUZCEjXwoLxlAwxNgf2l8yMgxJh09FgyzJt8b2GYIOodUnAtcsFhUfB
	 71R5WJ6rfn2TC6ewwDbf8DYVkMGfBKRmSA+xcc4k7pEKcXEd5LfMC5PW9LiqJbG2LV
	 TjqsmSfBl9m9g==
Date: Fri, 3 Feb 2023 10:36:30 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, robin.murphy@arm.com, will@kernel.org,
	suravee.suthikulpanit@amd.com, Matt Fagnani <matt.fagnani@bell.net>
Subject: Re: [PATCH 3/3] iommu/amd: Call BUG_ON in page fault hanlder path if
 domain is NULL
Message-ID: <Y9zVnkfEp3bC+UfL@8bytes.org>
References: <20230113135956.5788-1-vasant.hegde@amd.com>
 <20230113135956.5788-3-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113135956.5788-3-vasant.hegde@amd.com>

On Fri, Jan 13, 2023 at 01:59:56PM +0000, Vasant Hegde wrote:
> If IOMMU domain for device group is not setup properly then we may hit
> IOMMU page fault. Current page fault handler assumes that domain is
> always setup and it will hit NULL pointer dereference (see below sample log).
> 
> This is mostly programming error and difficult to recover from here. Hence
> call BUG_ON().

I agree with Robin here, a BUG_ON() is no improvement over a NULL-ptr
dereference. Just handle the domain == NULL case so that this code-path
will not crash.

Thanks,

	Joerg
