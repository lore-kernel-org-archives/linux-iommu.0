Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5640823CC
	for <iommu@lists.linux.dev>; Mon,  5 Dec 2022 10:46:29 +0000 (UTC)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 059022202AB;
	Mon,  5 Dec 2022 11:46:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1670237188;
	bh=DZstiAjHSdQuEbR9+/Iz/H3P6d7QmsPAw9MqDo8doG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eH3Wk83pZgulySkItoSK6/qHpHlbbH7WyzT+3oj4A9DrnFPuHy5AxmMVNQxuqNGYG
	 qT46b3l6nDkeziVWGCj45KzbXS/DMyctxzs4vPcTZ70ameYyT2uyZRGSUV0tg6xv8A
	 iTIojMgW9i6WkMd/vmJ74YWA8q1jmjPSK1SeWIt/YiGczFoFcK3id6w2Y1Q5HIZwQI
	 iPYApacu/RFV/NW9u4pNWBVKNh4H7/7lpVg+KRYBvzZXRpVWN+/6IeRUWfcfuXWCvJ
	 f7NgbeAmr1+5QaDnef9DRQvM27+2pKa3ro5Gu87vx+JBQKqNjyq0bVNfeqgmWCv5Zz
	 9xJYHKyqCyvNQ==
Date: Mon, 5 Dec 2022 11:46:26 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Yong Wu <yong.wu@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
	libo.kang@mediatek.com, chengci.xu@mediatek.com,
	youlin.pei@mediatek.com, anan.sun@mediatek.com,
	xueqi.zhang@mediatek.com, Guenter Roeck <groeck@chromium.org>,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v7 0/6] iommu/mediatek: Improve safety from invalid dts
 input
Message-ID: <Y43MAvPRx2BrRy/X@8bytes.org>
References: <20221018024258.19073-1-yong.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018024258.19073-1-yong.wu@mediatek.com>

On Tue, Oct 18, 2022 at 10:42:52AM +0800, Yong Wu wrote:
> Guenter Roeck (1):
>   iommu/mediatek: Validate number of phandles associated with
>     "mediatek,larbs"
> 
> Yong Wu (5):
>   iommu/mediatek: Add platform_device_put for recovering the device
>     refcnt
>   iommu/mediatek: Use component_match_add
>   iommu/mediatek: Add error path for loop of mm_dts_parse
>   iommu/mediatek: Improve safety for mediatek,smi property in larb nodes
>   iommu/mediatek: Remove unused "mapping" member from mtk_iommu_data

Applied, thanks.
