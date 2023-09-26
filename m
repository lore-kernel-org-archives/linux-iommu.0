Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E37863AF
	for <iommu@lists.linux.dev>; Tue, 26 Sep 2023 09:23:56 +0000 (UTC)
Received: from 8bytes.org (pd9fe9df8.dip0.t-ipconnect.de [217.254.157.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id E2C841A23D1;
	Tue, 26 Sep 2023 11:23:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1695720229;
	bh=Legx8pghp2+94NziKLZ4CvcEKmbmHcWOFVKODITRhqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8ujb3cqLDHZpaFN1xrZXyTf4keI83vpY2JaltVtYzGto6L+QTQEAZJgS2vl9kwUK
	 DpphmHZCH7mpeB2vD6YTOadMAjzSheL6Kz5cbrNkyoJVaeLAnu+66F21GXGSdPnuSb
	 2pPPbf6Y2FDsa0upFl88pDqIUSXbBNe9jCbSFG9PJbmAltoK8KoDcb0PqyQgb2LdjQ
	 E3pHKcFM5fImQ+/q2RuTAmmJFSTIH00kvvIs5O6BHu0sQOl+6hpww9IaDKQmfcAXA3
	 3TvkxQEBFoWDLmSHGJmcbHoSUuu1zJ4kpIXQYi1uvCLxvMKbt/QQBaYfWclJ1+1tty
	 e03KUKYWc5pZg==
Date: Tue, 26 Sep 2023 11:23:47 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, will@kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	m.szyprowski@samsung.com, heiko@sntech.de, thierry.reding@gmail.com,
	vdumpa@nvidia.com
Subject: Re: [PATCH 0/8] iommu: Clean up map/unmap ops
Message-ID: <ZRKjI12cdRikwlTu@8bytes.org>
References: <cover.1694525662.git.robin.murphy@arm.com>
 <ZRFbbyxB0AwC-V_5@8bytes.org>
 <2360630.NG923GbCHz@jernej-laptop>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2360630.NG923GbCHz@jernej-laptop>

On Mon, Sep 25, 2023 at 05:33:58PM +0200, Jernej Škrabec wrote:
> sun50i is meant to be placeholder (as mentioned in cover letter). It's
> replaced by:
> https://lore.kernel.org/linux-sunxi/20230912181941.2971036-1-jernej.skrabec@gmail.com/

Is the placeholder patch actually breaking the driver or just not
optimal yet?

Regards,

	Joerg
