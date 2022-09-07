Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0F97E
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 08:42:59 +0000 (UTC)
Received: from 8bytes.org (p4ff2bb62.dip0.t-ipconnect.de [79.242.187.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 073E92409C6;
	Wed,  7 Sep 2022 10:42:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1662540178;
	bh=aeiwbQEgBpapvaY7ytdFXeTg25jW4Hho6BQgko/uSo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ybrvhuHH/0sg1fsiTj3xXvm7D6/3/FoRWzLfkVes9BH5BckhJWiA9sO2useBgL0F6
	 D/km/dQBfJ9a1CcIiFJdkR+x8bGmVRDc67aqVciFVMaQ2pdxY28TB/kkh4u+qT4+qD
	 Ymg8xe7mkW5IssYhgYkEGQQ2So35beEjUo8QoGQ1PB36+PFDZcuFL75SjaezUUJMkx
	 iRSTPkUaSAVMC0EdY6vL85GweUbx+gKc21We8y300j1CILSqr8eOIKUVM00qDywKvW
	 IysM5xiCcgOPnPjIfaBWIZZqxthWKe2lx9XesiYHjSv87Hp7lG6eIvXY9wy83NROUn
	 Le27lTQGmj5qg==
Date: Wed, 7 Sep 2022 10:42:56 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Suman Anna <s-anna@ti.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	iommu@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/omap: fix buffer overflow in debugfs
Message-ID: <YxhZkCUD4UbUKLOp@8bytes.org>
References: <YuvYh1JbE3v+abd5@kili>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuvYh1JbE3v+abd5@kili>

On Thu, Aug 04, 2022 at 05:32:39PM +0300, Dan Carpenter wrote:
>  drivers/iommu/omap-iommu-debug.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.
