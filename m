Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60430ECD
	for <iommu@lists.linux.dev>; Fri, 21 Jul 2023 05:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5010BC433C8;
	Fri, 21 Jul 2023 05:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1689917083;
	bh=uP1GA5LBzxRoakiLor42MSUvmlqDpFH4ESIV2TvRqCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lq3Duzd2fRaNRhbeUDc8UBA5W9RVp9qjauw+jXEO1Ka5jdmuo9hM8OBSiQaUTGpwo
	 6pOYwJckjq3Bvb8suy5j9tvrx+BpCzj9x6IPr6iyjlBj7wUp0mzdc0uCdgTZIu6Sty
	 K5jf7ORuWEuEL9R4cik04yOvVr+0xmXit1TyxUgA=
Date: Fri, 21 Jul 2023 07:24:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: stable@vger.kernel.org, easwar.hariharan@microsoft.com,
	catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net,
	robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 5.15 0/4] ARM64 errata for stable kernel 5.15 and above
Message-ID: <2023072113-charm-manual-de9e@gregkh>
References: <1689895414-17425-1-git-send-email-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1689895414-17425-1-git-send-email-eahariha@linux.microsoft.com>

On Thu, Jul 20, 2023 at 04:23:30PM -0700, Easwar Hariharan wrote:
> From: Easwar Hariharan <easwar.hariharan@microsoft.com>
> 
> This series works around a few ARM64 errata. Please pick these up for
> v6.1 and v6.4 as well.

The first 3 patches here are all in 6.1.y and 6.4.y, so how can they
also be added there?

thanks,

greg k-h
