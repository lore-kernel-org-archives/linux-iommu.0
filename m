Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A621C05
	for <iommu@lists.linux.dev>; Mon, 17 Apr 2023 08:55:13 +0000 (UTC)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1poK6b-0001cB-Kj; Mon, 17 Apr 2023 10:20:57 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
 Olof Johansson <olof@lixom.net>, Chao Wang <D202280639@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com,
 Chao Wang <D202280639@hust.edu.cn>, Dongliang Mu <dzm91@hust.edu.cn>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Fix unwind goto issue
Date: Mon, 17 Apr 2023 10:20:56 +0200
Message-ID: <6931079.K2JlShyGXD@diego>
In-Reply-To: <20230417030421.2777-1-D202280639@hust.edu.cn>
References: <20230417030421.2777-1-D202280639@hust.edu.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 17. April 2023, 05:04:21 CEST schrieb Chao Wang:
> Smatch complains that
> drivers/iommu/rockchip-iommu.c:1306 rk_iommu_probe() warn: missing unwind goto?
> 
> The rk_iommu_probe function, after obtaining the irq value through
> platform_get_irq, directly returns an error if the returned value
> is negative, without releasing any resources.
> 
> Fix this by adding a new error handling label "err_pm_disable" and
> use a goto statement to redirect to the error handling process. In
> order to preserve the original semantics, set err to the value of irq.
> 
> Fixes: 1aa55ca9b14a ("iommu/rockchip: Move irq request past pm_runtime_enable")
> Signed-off-by: Chao Wang <D202280639@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>

Looking at the code, that makes a lot of sense.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



