Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4D6105
	for <iommu@lists.linux.dev>; Mon, 19 Sep 2022 14:20:43 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 6965766019EE;
	Mon, 19 Sep 2022 15:20:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1663597236;
	bh=zJDw7len3NGEkOF3/FseuWbZ3frYleqkiO3IoRDifyI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fkN0UoM4m/diw/YQMalwhdGPC0zU5COVJTISdis76ZDSdEFrMnqY937cKHUKckZ8T
	 7EH5laJCWNf7FA76lpKUnrIoQMTO/La94Vht3RCih9lLqJo2yJYQ+qYv9xEqtx5mD8
	 hHnl930qhtMPiYnjOVWvjcUbjUJKDdD5baUP0dCheeggCa+00XmsPIS+YmkOWigHl/
	 wkHpbe4m2MA/W+laINZB0ULUPH7UuFESTTFBIbA83ITgE48wBW8iG1lzsqaKOQOWQe
	 bkcWU3gGwipbFZ1MMuV1EZ+UBvell74zBsQInFNayr8bsVzGTb4o5fdDSB7o8CTiSL
	 TOMbaAZhS32bw==
Message-ID: <b412f7dd-8e12-3eb9-6e0d-5db230bd3de1@collabora.com>
Date: Mon, 19 Sep 2022 16:20:32 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5 2/6] iommu/mediatek: Use component_match_add
Content-Language: en-US
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, mingyuan.ma@mediatek.com,
 yf.wang@mediatek.com, libo.kang@mediatek.com, chengci.xu@mediatek.com,
 youlin.pei@mediatek.com, anan.sun@mediatek.com, xueqi.zhang@mediatek.com,
 Guenter Roeck <groeck@chromium.org>, Dan Carpenter <dan.carpenter@oracle.com>
References: <20220919092405.8256-1-yong.wu@mediatek.com>
 <20220919092405.8256-3-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220919092405.8256-3-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/09/22 11:24, Yong Wu ha scritto:
> In order to simplify the error patch(avoid call of_node_put), Use
> component_match_add instead component_match_add_release since we are only
> interested in the "device" here. Then we could always call of_node_put in
> normal path.
> 
> Strictly this is not a fixes patch, but it is a prepare for adding the
> error path, thus I add a Fixes tag too.
> 
> Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


