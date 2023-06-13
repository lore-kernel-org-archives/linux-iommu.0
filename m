Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F100C33E3
	for <iommu@lists.linux.dev>; Tue, 13 Jun 2023 17:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9AFC433D9;
	Tue, 13 Jun 2023 17:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686679131;
	bh=SN1c/tgjkGIHNQlQuVRRt3ENTwVyc5rr1jQndTSnNPA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gjuTLOWKQ0f0t1t+eXxvOqKAE5a5XSnWt8lZ4MGD6TnCVey0N+LZpf1M5cZnHssGN
	 mtqJRyQbqJgW6Fe6DPq8FOSMsBsbUs2U8CKPisiFoMgmD57rOMe49ITPZZjX/VoF1U
	 pshQi6kO0CAppFvNb3UACJHmYCpH2k9qTZHAKqD0rB7A3tUeAFYEsf76VX3Aoo5070
	 nw2qnguYZVT6C7LIyDt0KAnHJmzdmNqeCu6Vmevg49PU8+1Sv5U7F/gjI+ZW2LF6BZ
	 lNXO95czJ0577EXYUbAX8a+nkHLCL/b1JUN+LgZhVm1OoXwMDFzDRYptW3Ld+en6zU
	 lUbesI7QbpKag==
Date: Tue, 13 Jun 2023 10:58:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
Message-ID: <20230613105850.30172085@kernel.org>
In-Reply-To: <ZDk83vpIarQ9jWa7@8bytes.org>
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
	<ZDk83vpIarQ9jWa7@8bytes.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Apr 2023 13:45:34 +0200 Joerg Roedel wrote:
> Thanks for working on this, I think this is good to go. But given the
> issues we had with last attempt I'd like to have this in linux-next for
> a few weeks before sending it upstream. Therefore I will defer this
> patch and merge it early in the next cycle.

Is this patch queued up? I don't see it in linux-next and we keep
hitting this issue in production. After a few NIC reconfigurations
IOMMU starts consuming 90+% of CPU time.
