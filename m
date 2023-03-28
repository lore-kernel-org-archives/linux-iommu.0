Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E273433D9
	for <iommu@lists.linux.dev>; Tue, 28 Mar 2023 13:13:59 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E1528243320;
	Tue, 28 Mar 2023 15:13:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1680009239;
	bh=siVvYTCQb0ZSa9thXjSJwXr3U3XCeqEfC9Xp+vXUmBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UoUs0ZbMCV++pSZwoOHyya0Ceb6ZFRWrm84QzYVZLDMaOuG1wmDpX6m7GR9n+jlAg
	 6HAISvLJHQYWRusrZ0gyUHPMdB6guGI9yNd1oh0BZX18UE3GwQkgMm961ximZv6m1i
	 kZWehK4xif5GTKsvdR1+Wnhz1sdUge+hfycyf2PE25DgUvsqEoBPAWbptJoleduBaf
	 4DO7bnoxgmsoBSqv8l4EP2hWTT9/VK9ukrvRNLJmj3aOgIdDcX1fn2yJnW9OjgqRIU
	 RBqLFW+nlGAjSpt//fqLcGfi4p6Bo9hAVltBZCPoKRq0/J6tTQMrWWTz6CX97z9Vt4
	 I2RUEI0xakbew==
Date: Tue, 28 Mar 2023 15:13:57 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, Baolu Lu <baolu.lu@linux.intel.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH V3 0/2] Add reattaching support and fix memory leak issue
Message-ID: <ZCLoFSRnzl/xLo9L@8bytes.org>
References: <20230313075017.668204-1-chunyan.zhang@unisoc.com>
 <CAAfSe-tg7JwakdCcoLn3Ws_164HcsT21pWHkjjw0Qqwy8PWkhQ@mail.gmail.com>
 <ZCFNRfpUHbaGBvJb@8bytes.org>
 <CAAfSe-stDTabua1EMQBF-xp_=zyn6yzrRR9VFmzyQ6jwzufMfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAfSe-stDTabua1EMQBF-xp_=zyn6yzrRR9VFmzyQ6jwzufMfA@mail.gmail.com>

On Tue, Mar 28, 2023 at 10:57:30AM +0800, Chunyan Zhang wrote:
> Have sent it to you.

I see, can you please re-send the patch-set to me from a properly
configures email domain?

Regards,

	Joerg
