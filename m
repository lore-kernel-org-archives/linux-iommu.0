Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617D0188737
	for <iommu@lists.linux.dev>; Tue, 31 Dec 2024 06:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735627938; cv=none; b=qZVKzw9fvehAsb+e0aOl/WlzPVqgNpkEu7SphXF+UearJDmHXkwMW+GtScH+SpxZ/DPk9ys78JCLINbjaDD6KsEUvEmVlNAAX6qm6cao3KIJfl5R8ikg+awspq/l4OX7fg9nIos60nv6cIZppE418lXRAO7xTIVb1KWnfv7Yleg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735627938; c=relaxed/simple;
	bh=xXo+KADoHaQGw0TGa0makbceYBpXZicUv3gnes5Lv18=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lR/w4znu0sHSqg+KI786JU5w+lTu2Rlo9SqnSz1qvnbI9NelHcBGUfLepp3JrB+INT9NeNfMqy1d58/eNmGqGw/pNkrYWEIOHk/N0qZLeewxktgPbtAgTEcBRwycWFCtsKzIXSwGv0GEii/2NH0cbIkpXNy2E5ANZoyegK1Jt7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=K3lPR81x; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="K3lPR81x"
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
	by cmsmtp with ESMTPS
	id ST7AtisEO09RnSW6ytAWry; Tue, 31 Dec 2024 06:52:16 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id SW6tt1feOZTzLSW6vtLBTV; Tue, 31 Dec 2024 06:52:14 +0000
X-Authority-Analysis: v=2.4 cv=L+wbQfT8 c=1 sm=1 tr=0 ts=6773949e
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=-pn6D5nKLtMA:10 a=VwQbUJbxAAAA:8
 a=vU9dKmh3AAAA:8 a=pbaDQQ2OCVbHVibE1FAA:9 a=QEXdDO2ut3YA:10
 a=rsP06fVo5MYu2ilr0aT5:22 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/u73Um15xmTGtKDdrsLX74+vHUKU4mr/x9iAVeor0mo=; b=K3lPR81xDLiKvK3ySdyCvcwLbY
	hPfzer/gndUsOPPobdlGPFwW425FqTxM1LbXmmEdd39ZH7tVpB1cDqKsS/BeFmvFPIy8bPJYO7cod
	Ggj276JFjTL68ubplbMrlYhAkk9QSTy967BtN9XxMYA/8UNgqPT4/lHNlxwELxN1loiXcV9tzomCm
	I2m544HjvFsPY7NqbcCHWyrdDscHmZSUFZ0BqZW274jujFlDaqhVb48sFlz3dV6hwmO3zhCMTX+uT
	TEOAJ33uXMMAjYm3pd8wxCsjGfXsOgw6siJdRFdT2f2C7tB3xXRTk1++0jOX/M4181lxnJGD/CqCc
	fkZFU3ww==;
Received: from [122.165.245.213] (port=60114 helo=[192.168.1.5])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1tSW6h-003DJk-0W;
	Tue, 31 Dec 2024 12:21:59 +0530
Message-ID: <ed2ed7da-8c01-41c5-8215-d07892da3596@linumiz.com>
Date: Tue, 31 Dec 2024 12:21:50 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH RESEND 00/22] Add support for A100/A133 display
To: Andre Przywara <andre.przywara@arm.com>
References: <20241227-a133-display-support-v1-0-abad35b3579c@linumiz.com>
 <314b6bbe-613e-41a6-955e-50db6e11ef8e@linumiz.com>
 <20241230141150.3d0c3ae6@donnerap.manchester.arm.com>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <20241230141150.3d0c3ae6@donnerap.manchester.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1tSW6h-003DJk-0W
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.5]) [122.165.245.213]:60114
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 9
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHS9ILg9a42gXIJGV0Wmuvu1XCEARGH34Pb6kFYi+n4U51sg63r0TFfjzcGpNncbqp7h9GE4VUnzYBEAcL6+eiNu+nQxanti3PEsHjixekOkMKJHVTln
 sywIVgTfD1cf/gczBIonmxqPP3/y1oFl+b0o8iLhyOf2xYv/lH61OCuKNEZtcGNUG3+YyDkt7Rub5eNY844KfrNHHR2oq9aRAeU=

On 12/30/24 7:41 PM, Andre Przywara wrote:
> On Fri, 27 Dec 2024 20:06:30 +0530
> Parthiban <parthiban@linumiz.com> wrote:
> 
>> On 12/27/24 6:30 PM, Parthiban Nallathambi wrote:
>>> This series depends on [1] for the eMMC/MMC controller to work and
>>> [2] (lined up for 6.14) which adds support for the sram nodes and
>>> display engine extends it's usage. Idea of this series to get initial
>>> feedback and adjust, which will be rebased for 6.14 once [2] is merged.
>>>
>>> This patch series adds support for A133 display pipeline based on
>>> LVDS. dt-bindigs are organized in the start and later with code
>>> changes.
>>>
>>> PHY is shared between DSI and LVDS, so to control the PHY specific
>>> to DSI/LVDS, phy_ops set_mode is introduced. To enable the DSI
>>> using set_mode, analog control register MIPI Enable is used, which
>>> may not be available for A31 (shares the same driver).
>>>
>>> Otherwise, A133 also got hidden independent display engine i.e
>>> mixer + tcon top to handle parallel display. But this patch series
>>> adds only support for the 1 mixer which is documented.
>>>
>>> [1]: https://lore.kernel.org/linux-sunxi/20241109003739.3440904-1-masterr3c0rd@epochal.quest/
>>> [2]: https://lore.kernel.org/linux-sunxi/20241218-a100-syscon-v2-0-dae60b9ce192@epochal.quest/
>>>
>>> Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>  
>> Apologize for polluting with resend again. My internal mail server got blocked due to
>> volume count, which resulted in incomplete series again.
> 
> I guess an incomplete send was the reason for the original resend? Please
> note this at the top of the cover letter then, otherwise it's not easy
> to see why you send something again. Something like:
> 
> *** Re-sent due to mail server not sending out the complete series. ***
Yes I did add that using b4 as below, but "b4 send --resend" didn't pick the
updated cover letter though. I will check with "--reflect" next time.

EDIT:
Due to internal mail server issue, [3] missed few patches in series.
So am resending to hope that it will get through this time. Sorry
to pollute.

[3]: https://lore.kernel.org/linux-sunxi/20241227-a133-display-support-v1-0-13b52f71fb14@linumiz.com
> 
> It also helps to split up the recipients, so that everyone gets the cover
> letter, but only the respective subsystem maintainers get the patches
> touching their subsystem. I would CC: the DT maintainers on every patch,
> though.
> It's a bit more complicated to set up, but keeps the noise down for those
> large-ish series, for instance for the IOMMU people, who presumably have
> little interest in DT or graphics code.
The whole series based on b4 and the list is auto prepared using
"b4 prep --auto-to-cc".

Sure, I will add the dt list in all the patches. Also many thanks for your
review and feedback.

Thanks,
Parthiban

> 
> Cheers,
> Andre
> 
>> I will fix the mail server issue before resending the series. Sorry.
>>
>> Thanks,
>> Parthiban
>>
>>
> 
> 

