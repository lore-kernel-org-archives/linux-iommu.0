Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436CF8F55
	for <iommu@lists.linux.dev>; Tue, 29 Nov 2022 15:09:05 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id DC0ED660165C;
	Tue, 29 Nov 2022 15:09:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1669734542;
	bh=dcuFXuyUO4u2FBDicBX43KEncCSh9cUMs/11eeCUzvE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oRMCZegNrpohvspElhK3dFjkl2MLJhdHERN+KOOENUn1PFF53MgBppv674WTAuEvx
	 QDA+e6aiZoab1UgigopWThqHrLYkmK8Gno5V3KfTGMN3zyx0A5tp9L/+GgU0YxYZCF
	 bJNf9Hv58eG07SYbbSrTI5/3aNIPc2Fr6EvyVg9wvQJh3Mc9bKGMooE5vzkaiYxPd+
	 p331lpCfejTFCnrLV/4zrm7z74g4EkiClCwmTHBhNsmtTTYgwF99uAv5EzEdsvE7ur
	 nW1qe0FzC6GZPmZz0nFmeDEskx9aq/fsSHI/q9EBS8PdsCd1Pg+WHv+5jji1HDQn4+
	 ebZJPlzFVL05g==
Message-ID: <c2c32931-1fec-fcd1-8120-2d66b55d3f1f@collabora.com>
Date: Tue, 29 Nov 2022 16:08:59 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] iommu/mediatek: Fix crash on isr after kexec()
Content-Language: en-US
To: Ricardo Ribalda <ribalda@chromium.org>, Joerg Roedel <joro@8bytes.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Yong Wu <yong.wu@mediatek.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221125-mtk-iommu-v2-0-e168dff7d43e@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221125-mtk-iommu-v2-0-e168dff7d43e@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 28/11/22 23:16, Ricardo Ribalda ha scritto:
> If the system is rebooted via isr(), the IRQ handler might be triggerd
> before the domain is initialized. Resulting on an invalid memory access
> error.
> 
> Fix:
> [    0.500930] Unable to handle kernel read from unreadable memory at virtual address 0000000000000070
> [    0.501166] Call trace:
> [    0.501174]  report_iommu_fault+0x28/0xfc
> [    0.501180]  mtk_iommu_isr+0x10c/0x1c0
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


