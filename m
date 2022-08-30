Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED62762E
	for <iommu@lists.linux.dev>; Tue, 30 Aug 2022 08:16:07 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 3A4296601E8E;
	Tue, 30 Aug 2022 09:16:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1661847366;
	bh=RhuI1yWgn6gBmBPlwuNO0blBF1o/qMPbrqYFzGXSElc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I9oUDCAEb9L0xz0DoNFHbqEET2qL1Ufphb+wJ8rP9EgCO/z/ANEHOT9UkG/LBRDwS
	 oITPjXyUNlvIFwVc0RFlLK7qJTFrzAs/gnFnDEEupkCPEGCi8oandZaRei1xIHsPuH
	 ulV+22EC5nFoI2olm6FomJ9ebFU0CWHsvsOWbWCfBtVBk/iTuLbJgRHAGeQXmBnVDx
	 s3/Z4e1iZ8Nao3dY6kaf9UTPqO26x0gZXuj4ae7GCqLWy6YdTttt77s9R6h1tBrOyI
	 krCPKCybm6XUoR/GTi+V/oLbpPD//aIOO+fh/uB1T7BpRsqLxY2AFD4+NsVmd5JVQ7
	 ocVQ9+UvWrGCg==
Message-ID: <b681d321-8fc9-90c0-70e7-18d1f970b572@collabora.com>
Date: Tue, 30 Aug 2022 10:16:02 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 5/6] iommu/mediatek: Improve safety for mediatek,smi
 property in larb nodes
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mingyuan.ma@mediatek.com, yf.wang@mediatek.com, libo.kang@mediatek.com,
 chengci.xu@mediatek.com, youlin.pei@mediatek.com, anan.sun@mediatek.com,
 xueqi.zhang@mediatek.com, Guenter Roeck <groeck@chromium.org>,
 Dan Carpenter <dan.carpenter@oracle.com>
References: <20220824064306.21495-1-yong.wu@mediatek.com>
 <20220824064306.21495-6-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220824064306.21495-6-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/08/22 08:43, Yong Wu ha scritto:
> No functional change. Just improve safety from dts.
> 
> All the larbs that connect to one IOMMU must connect with the same
> smi-common. This patch checks all the mediatek,smi property for each
> larb, If their mediatek,smi are different, it will return fails.
> Also avoid there is no available smi-larb nodes.
> 
> Suggested-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

