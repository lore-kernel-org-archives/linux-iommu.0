Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDCD79C7
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 09:45:05 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 0BEE56602093;
	Tue, 21 Mar 2023 09:45:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1679391903;
	bh=MfgH9kI/J8HvDNSUKB+LMmh8WlnXibnNiOcRHaqZMCc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cv5yLixWewfHjPko9/R2VAC+R9aTUDpe5te5+99sM9m02Lf5+i10n/VBE5UZDrECg
	 Kd768vVHTpncD6AY2b6HY/NafWaLUFjnXk03rMPCgQnQwBzqh+iV9h2ZeiQPqeNsE8
	 eZ5f9RTa09c9ltWv/Ji887ol6d5Xsn/EpqQhQ9u9F+HtdKeY49rr5iihzHxkuTwvC/
	 d3uEQc8lviWYszp3unZQ3fEbxC7oCeWGPis91I6gXSb/xTEER0DfbIcfZ0mOA5674R
	 L2M2+kzxjhTsgy2bWkfNjFHwfFs3i0Qr5ZhaDnKccwBpoCA4Oxg/fBr9B8ZGRuAKgP
	 Eww4HDfQmLj7g==
Message-ID: <c01b41ef-c005-3a12-567f-bde67f4b125c@collabora.com>
Date: Tue, 21 Mar 2023 10:45:00 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 08/10] iommu/mtk_iommu_v1: Convert to platform remove
 callback returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-mediatek@lists.infradead.org, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org
References: <20230321084125.337021-1-u.kleine-koenig@pengutronix.de>
 <20230321084125.337021-9-u.kleine-koenig@pengutronix.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230321084125.337021-9-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 21/03/23 09:41, Uwe Kleine-König ha scritto:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


