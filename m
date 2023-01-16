Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73801852
	for <iommu@lists.linux.dev>; Mon, 16 Jan 2023 09:47:42 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id DE05766029A5;
	Mon, 16 Jan 2023 09:47:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1673862461;
	bh=Bi0LyqQK4GWY1Ub5Pdhd6qMahi91orrfMiE8nK6JIz0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BS1A2rSgwQzv530FIKEIUyNV1xiNqGYshvqFGXRgU5NZuLsZ5AOg4DYPqsFZ3ctfQ
	 7UeVXXvu/vWqo6R5KDVwlsChgluFozDJLxdT7UiK5fzgqHgL1E33+0w7yR4yru1ZsH
	 hp9zkXN81fCJe1h8app/ACfQroKC4F1EFOhcgYKCALq1OtYN+CjTbHanmY6fptW1yh
	 tNltHpWHgoSpa/SnDzop0ztS7u+GxL7EeRSp8ftYUX/eSh1dhWyO5hW7434xjXgmjy
	 /V5B/6Ok1MPkoi355O689AC6fDF/zhVSYCICaqYqGyW8S5uD3J+Hfolsfxa0sQFScP
	 GNjY/lg4Eujkw==
Message-ID: <491732f6-dc45-4f54-5d59-591818f70ebe@collabora.com>
Date: Mon, 16 Jan 2023 10:47:38 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 10/10] arm64: dts: mt8186: Add dma-ranges for the parent
 "soc" node
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Hans Verkuil <hverkuil@xs4all.nl>, nfraprado@collabora.com,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 mingyuan.ma@mediatek.com, yf.wang@mediatek.com, libo.kang@mediatek.com,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
 chengci.xu@mediatek.com, youlin.pei@mediatek.com, anan.sun@mediatek.com
References: <20230113060133.9394-1-yong.wu@mediatek.com>
 <20230113060133.9394-11-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230113060133.9394-11-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/01/23 07:01, Yong Wu ha scritto:
> Prepare for the MM nodes whose dma-ranges(iova range) is 16GB.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


