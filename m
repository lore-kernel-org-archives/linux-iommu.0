Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A325879C7
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 08:53:09 +0000 (UTC)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 1F74A6602FA0;
	Tue, 21 Mar 2023 08:53:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1679388781;
	bh=m8krUlfEMzWvYG3Z7812/SraCrcFCYtiocAiyGHHk50=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=odF+CO0D/NjEfMrngDbx4lrjRMM8eYnCD5bRYAqzygx6g1eisJAG8QrJixU868bYP
	 Sg90JXu87V/cgunFX+wAmkj8LeVtXjofOrXwGOuOHWbmm6rANrgxomdVjIf6S+RI/I
	 4DQLVuPQi2yn5Vot4PNkUmi2a6nLhCAegprNr8FHvs9FyXlwFMXL2ruLg+ovwKmr1n
	 C8rjGtKm2MndGIqfbeeggEe+MRMpnY1UdHoQCMyYbLzPtDS2B8vrQBBW/O2JO+vH6a
	 zhsHcymVgn5LzMsBjvqF5eRPg7uaHgg5Sx63Aeidofs49TwH1C47/4RRPzjwRtXpEP
	 jCvOHRXVf77Aw==
Message-ID: <287bb13f-5a4b-7769-7f3f-a94ee7ca645d@collabora.com>
Date: Tue, 21 Mar 2023 09:52:58 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v9 2/7] iommu/mediatek: Fix two IOMMU share pagetable
 issue
To: =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
Cc: "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>, "robh+dt@kernel.org"
 <robh+dt@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 =?UTF-8?B?SmlhbmppYW8gWmVuZyAo5pu+5YGl5aejKQ==?=
 <Jianjiao.Zeng@mediatek.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 =?UTF-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= <Chengci.Xu@mediatek.com>,
 =?UTF-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= <Mingyuan.Ma@mediatek.com>,
 "will@kernel.org" <will@kernel.org>
References: <20230317085541.20447-1-yong.wu@mediatek.com>
 <20230317085541.20447-3-yong.wu@mediatek.com>
 <47cac7a6-c069-64a2-7979-b879b075058f@collabora.com>
 <e724eb4b63901fd2ba9f7957d1a3cd6fdd234bf4.camel@mediatek.com>
Content-Language: en-US
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <e724eb4b63901fd2ba9f7957d1a3cd6fdd234bf4.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 21/03/23 07:50, Yong Wu (吴勇) ha scritto:
> On Fri, 2023-03-17 at 10:34 +0100, AngeloGioacchino Del Regno wrote:
>> Il 17/03/23 09:55, Yong Wu ha scritto:
>>> From: "Chengci.Xu" <chengci.xu@mediatek.com>
>>>
>>> Prepare for mt8188 to fix a two IOMMU HWs share pagetable issue.
>>>
>>> We have two MM IOMMU HWs in mt8188, one is VPP-IOMMU, another is
>>> VDO-IOMMU.
>>> The 2 MM IOMMU HWs share pagetable don't work in this case:
>>>    a) VPP-IOMMU probe firstly.
>>>    b) VDO-IOMMU probe.
>>>    c) The master for VDO-IOMMU probe (means frstdata is vpp-iommu).
>>>    d) The master in another domain probe. No matter it is vdo or
>>> vpp.
>>> Then it still create a new pagetable in step d). The problem is
>>> "frstdata->bank[0]->m4u_dom" was not initialized. Then when d)
>>> enter, it
>>> still create a new one.
>>>
>>> In this patch, we create a new variable "share_dom" for this share
>>> pgtable case, it should be helpful for readable. and put all the
>>> share
>>> pgtable logic in the mtk_iommu_domain_finalise.
>>>
>>> In mt8195, the master of VPP-IOMMU probes before than VDO-IOMMU
>>> from its dtsi node sequence, we don't see this issue in it. Prepare
>>> for
>>> mt8188.
>>>
>>> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>
>> I'm not sure whether this is *not* a fix... if a specific platform
>> wasn't
>> affected, this may still be a logic mistake... to be cautious, I
>> would
>> still add a Fixes tag to this one.
> 
> I think you are right. If we need add the Fixes tag, it should fix this
> one: 645b87c190c9 ("iommu/mediatek: Fix 2 HW sharing pgtable issue").
> 
> Before I thought the code flow was changed a lot. I added the bank
> structure and removed the mtk_iommu.h, I'm a bit afraid that this fix
> patch can not be applied clean, then it will introduce confuse when
> applying to the previous version for the maintainers.
> 
> Meanwhile, After mt8195, mt8186/mt6795/m8365/6795 were merged in
> upstream. All of them don't have this sharing case, thus I thought this
> fix it is not so necessary.
> 
> What's your opinion? and should I send this one separately if I add the
> fixes tag?
> 

Well, it would be nicer to send it separately but, realistically, the
described issue does *not* happen on the previous kernel releases for
the supported SoCs... so it's not necessary to split this.

Add the Fixes tag and send this again inside of this series, that's
going to be fine.

Thanks!
Angelo

