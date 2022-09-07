Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7517B7E
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 08:40:22 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5D6B62409C4;
	Wed,  7 Sep 2022 10:40:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1662540021;
	bh=FSBpp/y0z4vjZV/mdV44zORy2LwZYiyM4DbV1aKDbRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=7Z74576AM6ShpDy7S5m9m4pRUygSyMQjSKZTOEGirKUvwmCeYdWfaMZ4sp2PQWQtM
	 QjVWM2mN0iejjvy/cYBXrZhwRIcoK3kcM3i8TXiA65U+lLyUeUgtbtcseSxJCa0Jxy
	 rH6ROj3Ojh7Xdqo3bY1x8iiyLJvNTT0oCKiD8O43iQvZJtNEw/znmazms8aoOFo2NQ
	 mDK4LniWwT4UJ5+cFyWgIlWFdFCmgC2ME5DzfDgsuiv1vG5HUXVDGa/Roxz6YIvsmp
	 6Fz83ZhDm++zUl9wMEPF/I9gnKV+96Vfl0yvPtNZnuww4JD0C9HoULiM9D7NOoYUNK
	 1+OGyzc5CZAgg==
Date: Wed, 7 Sep 2022 10:40:20 +0200
From: Joerg Roedel <joro@8bytes.org>
To: John Sperbeck <jsperbeck@google.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Logan Odell <loganodell@google.com>, iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/amd: use full 64-bit value in
 build_completion_wait()
Message-ID: <YxhY9KUh1CJVvSk+@8bytes.org>
References: <20220801192229.3358786-1-jsperbeck@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801192229.3358786-1-jsperbeck@google.com>

On Mon, Aug 01, 2022 at 07:22:29PM +0000, John Sperbeck wrote:
> We started using a 64 bit completion value.  Unfortunately, we only
> stored the low 32-bits, so a very large completion value would never
> be matched in iommu_completion_wait().
> 
> Fixes: c69d89aff393 ("iommu/amd: Use 4K page for completion wait write-back semaphore")
> Signed-off-by: John Sperbeck <jsperbeck@google.com>
> ---
>  drivers/iommu/amd/iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied for 6.0, thanks.

