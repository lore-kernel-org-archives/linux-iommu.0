Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100D72F7AA6
	for <iommu@lists.linux.dev>; Mon, 20 Oct 2025 10:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760956560; cv=none; b=hb//PGCBITsWsB/+9iN3Md0TGkxtBcPTMbONPjj8j7M8s1Z/x+lByytzu9hke/xDzXqBvDH3BEjSMpafavMV+/i9w0CRCnQYhBQNQabENhHdMp9u90/HnqpfYJ3HOq4et4b0HiQ+F8iKJ/0qE6oBw/OV09AjtF8u7PWVBP8HTQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760956560; c=relaxed/simple;
	bh=T2bTjeEiXishWJMDed7e8b6WcF3hdcjPE0PZ6daxeDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6rnTbgbq2JmTZ1VXxxWdZakF1mvzK1iFC7KR8sW+7I2gIFOVHr+qIGCFQHPAnu+U/ykZE4eT0oxs58PCKKozNwazDnhkimqTSfN6+51QJM1tD/0Cfdvjec608KBrvYql/bBkBqVgd0D6LaA4/pwyGdq8Xd3eZhs4RxgEwy0QLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SLIN3qii; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SLIN3qii"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760956557;
	bh=T2bTjeEiXishWJMDed7e8b6WcF3hdcjPE0PZ6daxeDw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SLIN3qiigHADvtevtw9JAxryBVw1YW2Jsp1rISqSf9IqCj38HEDINt6ak1gJZTGnL
	 Kn3Y28G/jlgU5NamokPY10phpd62eXiZ52/6VLxFOLu/ruzZ3Uz02WycehDfewMTs8
	 dmxM3RihZrVGia0h/8BfFZNL+s20zjePKSymUz802Rb00aUnd8AlD1k8nUZ31h/ClN
	 0vssb9Ng/9zU3gjI2MIK867gO/78fIzJiXJo467YmtQtF00/ddae39wiNYCIyn+F4X
	 qkV34DFUsiE25+pJUsjf4shhIePF+u4P1XjYTKZgC2+nrluWL76L+QpecNUSOHvZAi
	 pTZLo3HbaR9Fw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C05C417E1404;
	Mon, 20 Oct 2025 12:35:56 +0200 (CEST)
Message-ID: <3fdeaa04-15e2-4455-a78c-627abb767830@collabora.com>
Date: Mon, 20 Oct 2025 12:35:55 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] iommu/mediatek: simplify dt parsing error
 handling
To: Johan Hovold <johan@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Sven Peter <sven@kernel.org>,
 Janne Grunau <j@jannau.net>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Thierry Reding <thierry.reding@gmail.com>, Krishna Reddy
 <vdumpa@nvidia.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251020045318.30690-1-johan@kernel.org>
 <20251020045318.30690-8-johan@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20251020045318.30690-8-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/10/25 06:53, Johan Hovold ha scritto:
> As previously documented by commit 26593928564c ("iommu/mediatek: Add
> error path for loop of mm_dts_parse"), the id mapping may not be linear
> so the whole larb array needs to be iterated on devicetree parsing
> errors.
> 
> Simplify the loop by iterating from index zero while dropping the
> redundant NULL check for consistency with later cleanups.
> 
> Also add back the comment which was removed by commit 462e768b55a2
> ("iommu/mediatek: Fix forever loop in error handling") to prevent anyone
> from trying to optimise the loop by iterating backwards from 'i'.
> 
> Cc: Yong Wu <yong.wu@mediatek.com>
> Acked-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


