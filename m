Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965BE8F54
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 22:22:51 +0000 (UTC)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1piMcK-0006Di-Gz; Fri, 31 Mar 2023 23:49:04 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Steven Price <steven.price@arm.com>
Cc: Steven Price <steven.price@arm.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, John Keeping <john@metanate.com>
Subject:
 Re: [PATCH v4] iommu/rockchip: Add missing set_platform_dma_ops callback
Date: Fri, 31 Mar 2023 23:49:03 +0200
Message-ID: <2077066.bB369e8A3T@diego>
In-Reply-To: <20230331095154.2671129-1-steven.price@arm.com>
References: <20230331095154.2671129-1-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Freitag, 31. M=E4rz 2023, 11:51:54 CEST schrieb Steven Price:
> Similar to exynos, we need a set_platform_dma_ops() callback for proper
> operation on ARM 32 bit after recent changes in the IOMMU framework
> (detach ops removal). But also the use of a NULL domain is confusing.
>=20
> Rework the code to add support for IOMMU_DOMAIN_IDENTITY and a singleton
> rk_identity_domain which is assigned to domain when using an identity
> mapping rather than "detaching". This makes the code easier to reason abo=
ut.
>=20
> Signed-off-by: Steven Price <steven.price@arm.com>

My knowledge of IOMMU magic is not that deep. Nevertheless I do believe
to mostly understand the change and the splats on my rk3288-pinky are gone
now with this patch:

Acked-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>




