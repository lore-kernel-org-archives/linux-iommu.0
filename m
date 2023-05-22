Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D798D1428D
	for <iommu@lists.linux.dev>; Mon, 22 May 2023 15:03:32 +0000 (UTC)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C073B2434D7;
	Mon, 22 May 2023 17:03:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1684767812;
	bh=W2Fq+gkFMlwVicsPZzZGJ6rF+QXMXtfRpZ84MkbCh8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0MdHcxe1Ncak+rCXaDuSrhO3D3GtmxFkIB+AKd5MCKFu3BNrETgFP64UOYdl+/XXV
	 tZ3iIojkktIoVlXIFSSBMeNV+qGhABiXTGTN2USBjxpQwsa5UN2qK21S663pQpOrzW
	 mCdurgyAlqBU9+T4CeUwPfJ2qVGgFPbljvyRygev/H6YApL9LjCP5U74Rs4jvBU1hS
	 W3tc2c45jSG2MF4qnhSjrpYyIhx2dJAGMhXtO2XLGkDGVh9JyM8vOQjTWxPN+QLFnR
	 E/d5asUmAFxFk5+gX6z+qBzk8+i374nyL8ZEBVXnojRHn2oYT/wTNUMaq4AXX0J+km
	 FNmRthkkBVTtg==
Date: Mon, 22 May 2023 17:03:30 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Chao Wang <D202280639@hust.edu.cn>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Heiko Stuebner <heiko@sntech.de>, Marc Zyngier <maz@kernel.org>,
	Olof Johansson <olof@lixom.net>,
	hust-os-kernel-patches@googlegroups.com,
	Dongliang Mu <dzm91@hust.edu.cn>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Fix unwind goto issue
Message-ID: <ZGuEQifvdEgRyrp9@8bytes.org>
References: <20230417030421.2777-1-D202280639@hust.edu.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417030421.2777-1-D202280639@hust.edu.cn>

On Mon, Apr 17, 2023 at 03:04:21AM +0000, Chao Wang wrote:
>  drivers/iommu/rockchip-iommu.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Applied for 6.4, thanks.
