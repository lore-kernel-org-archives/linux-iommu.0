Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A1F28FC
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 13:28:57 +0000 (UTC)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A082F242DB0;
	Wed, 22 Mar 2023 14:28:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1679491736;
	bh=xzUg4Z/FHszuW2KVA1ZLV5mcSCCJr9A0LsJBZ8Gs/M0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VNS9vkU1oFeyGhXbmwXje3elBKlv8CCIbNHQQMhA8h9OwUA5KpdZZEKFhPSXgVmOp
	 EOHr24ciH3a5t0kEw+/9IqTsLtz21cwTmm6xv442JJ3Xq2J8ofwluP4j+X9CqSP+5Y
	 xlXc85FeC/2y/yqrfUz6kiOOMOfXe2pszwwJGgrVOZ7skR19MPvmzJM61hj+z662hd
	 UYfm6Blphqi8fiPyN/xxMqWRIKO4T/gmgdh+HT/PlxYYoYn8gm8hboBxS8JSxtzcdh
	 /3QSSoP5eyD0PsTueJOkJw+xrZMrysldvKU2labpEfe03IsYcy4mwxOui6RBGs2l+z
	 6nyxTYeLKDMqg==
Date: Wed, 22 Mar 2023 14:28:55 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] iommu/ipmmu-vmsa: remove R-Car H3 ES1.* handling
Message-ID: <ZBsCl1uwEK1N7Jon@8bytes.org>
References: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
 <20230307163041.3815-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307163041.3815-2-wsa+renesas@sang-engineering.com>

On Tue, Mar 07, 2023 at 05:30:29PM +0100, Wolfram Sang wrote:
>  drivers/iommu/ipmmu-vmsa.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

Btw, b4 reported DKIM issues with your submission, can you please check?
