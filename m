Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47E6BE40
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 03:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727838559; cv=none; b=THiRwPOgaiWvPluaVzI0VftrEx0ONYyZMX6NdVlhIjhpff+uW68iFS82RWq2+hrNiHtTuvhFCiFLeHM0kW26Wc+dacZ9YFEj0Lam7rIIa+zFHfieDWia7GWi7fZO+ydaK9U44dcZAujnczEigbxrdjt4fdVE57sdlhhoef8Y2Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727838559; c=relaxed/simple;
	bh=TQqFkTNSBcKj/3jywJA1QIPBBqJ23KUNHG19JpQTK+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hBZ2i6zQHShFu5G1i/q8m6fklo+7hmmRfN3zIKReCkmTcMXJQkUE1csxqn1lE7m14eqLjzrSXf5yzDTy03I/ez6F1jQgSZr+UYRY4Bc/gnFAB2JFrwi5uyXMn/J6s3JYzG63ZnGDHuUZP3BCBr3z75XdMEm9mIsRWRJ25nmyx48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RHBZzYqC; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RHBZzYqC"
X-UUID: b29240e8806b11ef8b96093e013ec31c-20241002
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:Message-ID; bh=2g8tKHBs88WWFxv64z1cVEtqY0rKkhBPjnwbXsFsUyc=;
	b=RHBZzYqCGrEb7nWfjAmIuZFK3yrcirmULc7g/ukJvsQXo0vCbUxrAor7sUJ9IP9k7UFoULRrNjvt5Nry/DE8BfNZa6z95JFjKa2+BAgvbqO5wXbtYi2y7ACZ77R32S459hgCVu7m+uXQNKy3jpfqTW28BmHrV8/0eMoyx2DGCDQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:72dfb011-11b6-4428-8c0f-2cb8c0d0216a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:03f92988-3a5d-4d9e-b012-e875acfb157d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b29240e8806b11ef8b96093e013ec31c-20241002
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1639784707; Wed, 02 Oct 2024 11:09:11 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 2 Oct 2024 11:09:10 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 2 Oct 2024 11:09:09 +0800
Message-ID: <7f212146-3dc7-9a0d-baf4-ac7a5b845060@mediatek.com>
Date: Wed, 2 Oct 2024 11:09:07 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 5/5] dt-bindings: display: mediatek: dpi: correct
 power-domains property
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, Simona Vetter
	<simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Rohit Agarwal
	<rohiagar@chromium.org>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>, Bear Wang <bear.wang@mediatek.com>, Pablo Sun
	<pablo.sun@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, Sen Chu
	<sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>, MediaTek
 Chromebook Upstream <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	Chen-Yu Tsai <wenst@chromium.org>, Jitao Shi <jitao.shi@mediatek.com>
References: <20240930083854.7267-1-macpaul.lin@mediatek.com>
 <20240930083854.7267-5-macpaul.lin@mediatek.com>
 <20241002015120.GA236278-robh@kernel.org>
From: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20241002015120.GA236278-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 10/2/24 09:51, Rob Herring wrote:
> 	
> 
> External email : Please do not click links or open attachments until you 
> have verified the sender or the content.
> 
> On Mon, Sep 30, 2024 at 04:38:54PM +0800, Macpaul Lin wrote:
>> The MediaTek DPI module is typically associated with one of the
>> following multimedia power domains:
>>  - POWER_DOMAIN_DISPLAY
>>  - POWER_DOMAIN_VDOSYS
>>  - POWER_DOMAIN_MM
>> The specific power domain used varies depending on the SoC design.
>> 
>> These power domains are shared by multiple devices within the SoC.
>> In most cases, these power domains are enabled by other devices.
>> As a result, the DPI module of legacy SoCs often functions correctly
>> even without explicit configuration.
>> 
>> It is recommended to explicitly add the appropriate power domain
>> property to the DPI node in the device tree. Hence drop the
>> compatible checking for specific SoCs.
>> 
>> Fixes: 5474d49b2f79 ("dt-bindings: display: mediatek: dpi: Add power domains")
>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
>> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
>> ---
>>  .../display/mediatek/mediatek,dpi.yaml        | 24 ++++++++-----------
>>  1 file changed, 10 insertions(+), 14 deletions(-)
> 
> You missed Krzysztof's R-by tag.
> 

Oh, I just missed that reply for v3 in the mailbox
and thought it still need to be reviewed.
I just found Krzysztof's R-by tag in the mailbox right now.

I'll send an update for this patch set.
Thanks for the reminder.

Regards,
Macpaul Lin
