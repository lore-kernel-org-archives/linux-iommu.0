Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C981A807
	for <iommu@lists.linux.dev>; Mon, 27 Mar 2023 07:49:51 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 093496603082;
	Mon, 27 Mar 2023 08:49:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1679903383;
	bh=Wigh5ZkT6PUuW6n+/iXN9rF147ZZhApXRlVFqVwLC+c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SMdmt5Cw1Lb0mW0Kv0Sqi3TEb5dSZ2fc8It4iiI8AFGy5/ZG85rnJmxXpAAardCBz
	 yDWyYzLoX0zjh45pFeH8RgMc0tIg7HnPKhhTLxWkwBwvAmZGaqg+he+8/tPW3kb9Ec
	 NTE9n05G6G7ivAa21j5vEaqh6faJCNeBpmdMyCic5v3q6xwTXegiENtLPwSDE4t/AE
	 DBYrS8vgTiAUZTWEUTqT4jYA8VPIvdN4i/Hp38Zo+RxibSTOe5Mcha6U700m98WAd5
	 8Oez93U/UlZxQY3vkwSsF/Ey+EjnVtJCcq45MQ6gbiLywAY1u4leiSvaeLQYV6+Dv7
	 6hcQFgz3Kuuyg==
Message-ID: <c2410688-8343-9c29-a7a3-9e30b6696449@collabora.com>
Date: Mon, 27 Mar 2023 09:49:40 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] iommu/mediatek: fix a reversed test in probe
To: Dan Carpenter <error27@gmail.com>, Yong Wu <yong.wu@mediatek.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "Chengci.Xu" <chengci.xu@mediatek.com>, iommu@lists.linux.dev,
 linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
References: <88c83ce7-5d1a-44a8-b9bf-0d01cfea24db@kili.mountain>
Content-Language: en-US
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <88c83ce7-5d1a-44a8-b9bf-0d01cfea24db@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/03/23 12:07, Dan Carpenter ha scritto:
> The dma_set_mask() function returns negative error codes on failure but
> this code is testing for zero instead.
> 
> Fixes: f4b49c7c5e67 ("iommu/mediatek: Set dma_mask for PGTABLE_PA_35_EN")
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


