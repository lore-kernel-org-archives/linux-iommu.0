Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1DD13731
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 14:18:30 +0000 (UTC)
Received: from 8bytes.org (p200300f6af03f600fd690381fa83412b.dip0.t-ipconnect.de [IPv6:2003:f6:af03:f600:fd69:381:fa83:412b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 047AA28012B;
	Fri, 14 Jul 2023 16:18:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1689344310;
	bh=x48tQJuhRIcBK8H22bowqvguJJwO4RiPk3c8qAoIwxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dp0bpR/TN6JUtC2kVopJCIWL6JgKs6ep/uDNil4nOncAjdx8i5643rC7XpfbQz/oJ
	 wgX9d0iHrf47FXFmQrKlkn0a5k+oRW/Rjt5TwtyqQEDOR7pfTD8WHZw/UCRS/LIveP
	 OSmROeqVdXZUilMAGUgu/5sGLXgLm49sLKwT7kn9SDvlImkJH9oNxb703qm7xKePAX
	 PBM6w4VEduBYW2BkfgUdSLjpn1OFW1KX9lVucEWP0DXrMJnJfvV91CTMOIl4+y9qIW
	 h9QFUSCMuH/lBX/VDf+rJh4J74YqmNnc7QumgOwcWATRgJkKv5DQt1+D14HLkRoQNi
	 /TGV0Evt5GVKg==
Date: Fri, 14 Jul 2023 16:18:28 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iommu: rockchip: Fix directory table address
 encoding
Message-ID: <ZLFZNH_6HIxkYS4n@8bytes.org>
References: <20230617182540.3091374-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230617182540.3091374-1-jonas@kwiboo.se>

On Sat, Jun 17, 2023 at 06:25:43PM +0000, Jonas Karlman wrote:
> Jonas Karlman (2):
>   iommu: rockchip: Fix directory table address encoding
>   iommu: rockchip: Allocate tables from all available memory for IOMMU
>     v2
> 
>  drivers/iommu/rockchip-iommu.c | 50 +++++++---------------------------
>  1 file changed, 10 insertions(+), 40 deletions(-)

Applied, thanks.
