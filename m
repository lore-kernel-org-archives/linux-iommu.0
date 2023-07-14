Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B2320E8
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 14:09:23 +0000 (UTC)
Received: from 8bytes.org (p200300f6af03f600fd690381fa83412b.dip0.t-ipconnect.de [IPv6:2003:f6:af03:f600:fd69:381:fa83:412b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A363D28012A;
	Fri, 14 Jul 2023 16:09:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1689343760;
	bh=M0SoCIDigrh34C8zCDczRKfN4d2BWxv9UemPawpMyzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PiIRHazyMSRJ5zVVXJ3d6lwTAB9US7oCcdFwtoq0o/7dWHXrd/FmscTbP5T3StLSn
	 29q9QXhsW4g/LTXkIUSjUO6NOMBEfN8Iu2gcrxI0wP01YgV3y/HDjaUMcn1rHOU8Yq
	 UuMq4VkiuYRmcPQ7dkL7PbveQ/LyfXyyot1pDQ8rGT+91xtBqicpxtNnDdWIOSaKqN
	 3vOye471ooKK7U1U1Ot3EM4Rg2NgiSH5S1pRjmeELQuKUCor8pxVnqnF3eFcJokDkT
	 iJy/B5TGib0yV7wLejswTpkXV2ZjPFSh4LxNqpqxO3hx1D6fbzvNKDu4psEUqiurUl
	 +8tN/uOYBPG0g==
Date: Fri, 14 Jul 2023 16:09:19 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v4] iommu: Optimise PCI SAC address trick
Message-ID: <ZLFXD0WNDTCU5fHp@8bytes.org>
References: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8502b115b915d2a3fabde367e099e39106686c8.1681392791.git.robin.murphy@arm.com>

On Thu, Apr 13, 2023 at 02:40:25PM +0100, Robin Murphy wrote:
> To that end, implement a flag to refine the SAC business into a
> per-device policy that can automatically get itself out of the way if
> and when it stops being useful.

It is summer time and it may be the heat, but I am in a brave mood and
decided to give this a shoot. I applied it to the core branch and will
push it to linux-next for testing.

Regards,

	Joerg
