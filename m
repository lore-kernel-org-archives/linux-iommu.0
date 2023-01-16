Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1840A1852
	for <iommu@lists.linux.dev>; Mon, 16 Jan 2023 09:46:21 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id A6E0766029A5;
	Mon, 16 Jan 2023 09:46:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1673862380;
	bh=nYQprZYDKKBXvoouxOYysIQde0DT4K7g+1YTSkKBGiU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fCApfwp9woRngKm4ZG1JqCe1yX4d8c7xfrO7LrW+GG7lSywzWwWeeIwU3Dum54yfK
	 nUpHOLQzwI4kPzWF5uawdu3O5okGrLLMWS6AZAuIUS7y3MRp7her0w3C/6cW8e7cAf
	 97Yq+BWJjT4xBp4HVbtgi5O62P0aYr5TpXd0YA+Bz366oVzInpp1V2X+Dm1+aSsIQu
	 eUh3Jv4RfX4pbC8GZwZZCuqnLHeSuFo22t/tvMCwwqrnoABMVR2hZ9VLwwNOqkiWQO
	 zpQnYL3o+9v+DHRHXmmrFVWm94uTnVxRhjS1yL7gjLXoD0jYCT2D1XefE24Ex6XaDm
	 HHjZgdmtzZfhQ==
Message-ID: <1a9a09d5-58e2-badc-6d1c-fe2008c305f9@collabora.com>
Date: Mon, 16 Jan 2023 10:46:16 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 07/10] iommu/mediatek: Add a gap for the iova regions
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
 <20230113060133.9394-8-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230113060133.9394-8-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/01/23 07:01, Yong Wu ha scritto:
> Currenly masters can not indicate its special dma-ranges. Prepare
> for vcodec. some vcodec end address is address + size, if our size
> is 4G, the end address may be 0x2_0000_0000. and the
> register is u32, then it may get zero. thus add a gap(8M) for
> all the regions.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

I definitely agree on the fact that we do *need* this series... but this
particular commit looks like a hack.

I'm not convinced: I have a hunch that this one will sooner or later backfire
on us and break things again... at the same time, I'm not sure how to do this
properly at this point (I didn't do any research, anyway).

Ideas?

Regards,
Angelo

