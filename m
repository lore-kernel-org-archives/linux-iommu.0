Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4686AB4
	for <iommu@lists.linux.dev>; Thu, 13 Apr 2023 14:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D31C433EF;
	Thu, 13 Apr 2023 14:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681394564;
	bh=toUJAtCrtg8LEJy9Yrb0cmiaJy1wTLCM49brD95V6HA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VSKEM3cqD8z8wYXLcbj567Z2lKWJgtfVQQZqIUM3sbydPQ4AmsoMPnQ2GK+UV8djQ
	 NNicdq3ZXJNFOm4gZCg8+0rV3MryNpENJYHUyVmLv0ciY7DOb2TXovz8Hx7wYJOx0z
	 +/QfP1HaF08QMeeXEKdw9o05MB5v5ggM4Rl8O8ee+3J0VpxM4/uGDUVEWENnKNxoYc
	 xlwY+iKNypf8PxGqXI5vlOmwF8HeRX2uNXYLsnipSbA2mnB08aBDT/4L1YrCduBNea
	 J2RQpy4lv/L/ZcIDZzApX7Bu/FsUv3wLfimbam4yXhtfNbm0zJUJG6L/5QxeW9lhen
	 qCDgt+TvT581A==
Date: Thu, 13 Apr 2023 07:02:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
Message-ID: <20230413070243.4fa2fd6a@kernel.org>
In-Reply-To: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Apr 2023 14:40:25 +0100 Robin Murphy wrote:
> CC: Linus Torvalds <torvalds@linux-foundation.org>
> CC: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Tested-by: Jakub Kicinski <kuba@kernel.org>
