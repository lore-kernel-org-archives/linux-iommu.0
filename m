Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9611FBC
	for <iommu@lists.linux.dev>; Fri,  3 Feb 2023 11:12:22 +0000 (UTC)
Received: from 8bytes.org (p5b006afb.dip0.t-ipconnect.de [91.0.106.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id EEC52224208;
	Fri,  3 Feb 2023 12:12:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1675422741;
	bh=IV9BRtJ8GANJXdxODgM8/VDAzQ2MnUltb3LAeS1jo/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lKRS5HEApW3/sf5UIiAmxv08Jbzf8IV1CEEsLzKOU1PM4+75ey29qIXUOomigEj51
	 zHlArz8QPVAExNLyQCmhBZPcsfLzxqwQ7+O3AB560HmO+ps6HwG2CQiBsAwbPuT4BD
	 pWL3O8zZNO9xUwdQyeXIPpSc4LQUmP2wIfPdzZRm1vj9kVX8COlh1cJ+YDAdyujVib
	 +80w8kppxxZZaR144zam4qhJ15/AcMnnLx3bzq68ULJaTqDW1aOeTCYAROCb0F2td9
	 W7XWIu4bgqFlrGqPbD83goFGYpjHYN5glpX7CeoCv/GlBDDbz84sn5Ce6zo2u0aHpE
	 tEnTBxersyC7w==
Date: Fri, 3 Feb 2023 12:12:19 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, robin.murphy@arm.com, will@kernel.org,
	suravee.suthikulpanit@amd.com, Matt Fagnani <matt.fagnani@bell.net>
Subject: Re: [PATCH 3/3] iommu/amd: Call BUG_ON in page fault hanlder path if
 domain is NULL
Message-ID: <Y9zsE800/NhF8unH@8bytes.org>
References: <20230113135956.5788-1-vasant.hegde@amd.com>
 <20230113135956.5788-3-vasant.hegde@amd.com>
 <Y9zVnkfEp3bC+UfL@8bytes.org>
 <8f161d2b-2c00-5a91-5799-36746af5b32c@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f161d2b-2c00-5a91-5799-36746af5b32c@amd.com>

Hi Vasant

On Fri, Feb 03, 2023 at 04:10:33PM +0530, Vasant Hegde wrote:
> Initially I was thinking of logging error message and return. But it will hit
> device faults continuously.  Also we don't have nice way to recover from this
> condition.
> 
> So I thought crashing here with explicit BUG_ON is better. But I agree with
> Robin's comment. We don't really get anything extra with BUG_ON. We should be
> able to figureout crash reason based on NULL pointer dereference easily.
> 
> Do you want me to just add explicit log here? Otherwise I am fine dropping this
> patch (3/3). I think we still need first two patches from this series.

The best for now is to print a ratelimited error message and just return
from the handler. The ratelimit ensures that no misbehaving device can
flood the kernel log.

Regards,

	Joerg
