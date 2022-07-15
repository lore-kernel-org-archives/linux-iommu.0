Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F4520E0
	for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 08:25:16 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id AA9C21F88; Fri, 15 Jul 2022 10:25:14 +0200 (CEST)
Date: Fri, 15 Jul 2022 10:25:13 +0200
From: Joerg Roedel <joro@8bytes.org>
To: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com, Matthias Brugger <matthias.bgg@gmail.com>,
	Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
	iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] iommu/mediatek: Log with dev_err_probe when failing to
 parse dts
Message-ID: <YtEkaa+CCCz0l61q@8bytes.org>
References: <20220712214427.544860-1-nfraprado@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220712214427.544860-1-nfraprado@collabora.com>

On Tue, Jul 12, 2022 at 05:44:27PM -0400, Nícolas F. R. A. Prado wrote:
> mtk_iommu_mm_dts_parse() can fail with EPROBE_DEFER if not all larbs
> have probed yet, so use dev_err_probe() to avoid logging as an error in
> that case. Also drop the return value from the message since it's
> already printed by dev_err_probe(), and add the missing newline at the
> end.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Applied, thanks.
