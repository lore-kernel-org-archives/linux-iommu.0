Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAC73290A6
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779098524; cv=none; b=aykqgpddrYoU36H4LM2qioOPxGuCOsUw/QryLHLxCGXTe4eCBrNibtxg+vAsT6oVDlqoAS41CR+WEJD9D2ai5cg9fxw+gDjXEqrANV0o50XQllk1qs4Pwncv31EtpWuLq/p4JRtWqZA+kMuLK9DaJp55i/DT5L+nzN8KDPwtGhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779098524; c=relaxed/simple;
	bh=+uNpgAuOVfN6qgRkrWEDp6LOZz8aiVnozDLX8gPsA/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STgRC2aHEgP7KWUzuQc0REBIrsH7YjEBlyBgczU1FUwBefMPDqmqc42nz5idXQR6pV2gwjdQgpFgGN5byBvQQaErfcuMieiqJ6187D3AKMp5wv+0XPG/MIGa6tblqvDaLK88wPCv9CgEv4byV//0umD7MFUnvQQ90SQ+Clma9+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=megOarJa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="megOarJa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1779098521;
	bh=+uNpgAuOVfN6qgRkrWEDp6LOZz8aiVnozDLX8gPsA/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=megOarJa4PorMb7FNPHfAcn90/VwHzYDGoqgcGwUm1KLGv9mMBqu0ZUVXUowEXhUX
	 SvVw/N9PaL+/JvumOafJwJCSbB1wFCBd8/tAEKXVa1sRKdePie/nIH1Rj3kifrbJOL
	 /xOhlEJExyYhEfMkkkPe5nQ7MZ8aMNYHcoWgLpXT81pza5CPcdbbx/3/aFEzrhGUMl
	 G6pSe6IRlnhNbNPRCbpUJ+w4xzf2HOIrxh/UcRE7Kr0l+LXopNkLGktGb8ZOaSM89i
	 xlu5RvMB/QQ4PRL090Gs5X6Dlj++0SZ+VbXpe8Ep/+qqsMvwp1VWyuznIboAJ1bQ1w
	 sqRzNiz9XYrkw==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A342B17E0443;
	Mon, 18 May 2026 12:02:00 +0200 (CEST)
Message-ID: <1a8b6793-661f-4676-bb29-6c1ee11a3ce9@collabora.com>
Date: Mon, 18 May 2026 12:02:00 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] memory: mtk-smi: Add a flag skip_rpm
To: =?UTF-8?B?WHVlcWkgWmhhbmcgKOW8oOmbqueQpik=?= <Xueqi.Zhang@mediatek.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
 "krzk@kernel.org" <krzk@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc: =?UTF-8?B?V2VuZHktU1QgTGluICjmnpfoqanluq0p?= <Wendy-ST.Lin@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20250320073625.25225-1-xueqi.zhang@mediatek.com>
 <20250320073625.25225-3-xueqi.zhang@mediatek.com>
 <46e0e1f1-e094-40f9-99f9-22678bb40d39@collabora.com>
 <198865fb3184926d0b1b4e4855b5f863ad0d6a20.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <198865fb3184926d0b1b4e4855b5f863ad0d6a20.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/18/26 09:16, Xueqi Zhang (张雪琦) wrote:
> Hi Angelo,
> 
> First of all, please accept my apologies for the delayed response. I
> have been deeply occupied with MT8196 Aluminium pKVM SMMU and SMI
> related tasks recently.
> 
> Regarding your question, my previous description in the patch was not
> accurate enough and may have caused some confusion. In fact, not
> all SMI commons have their backup/restore handled by the RTFF
> hardware. The SMI commons are distributed across various subsystems
> (e.g., mminfra, venc, display, cam, etc.). Currently, only the SMI
> common under the mminfra subsystem is backed up and restored by
> the RTFF hardware.
> 
> Therefore, I believe adding a specific 'skip_rpm' flag is more
> appropriate here. If we were to differentiate this based on a new
> MTK_SMI_GEN3 type, it would imply that all SMI common modules of
> that generation would skip the RPM operations, which is not the
> intended behavior.
> 
> To make this clearer, I plan to update the commit message in the
> next version as follows:
> 
> Subject: memory: mtk-smi: Add skip_rpm flag for certain MT8196 SMI
> commons

memory: mtk-smi: Allow no clocks for RTFF managed SMI commons

> 
> Body:
> On MT8196, certain SMI commons are backed up and restored by the RTFF
> hardware rather than by software.
> 
> For these specific SMI commons, software-controlled register backup
> and restore in the runtime callback is no longer necessary. Therefore,
> introduce a 'skip_rpm' flag to bypass these redundant RPMoperations
> for these SMI commons.
> 
> What do you think about this approach?
> 

That would be kind-of ok, but keep in mind: pm_runtime doesn't only manage clocks.

I think that the best option here would be to allow having no clocks instead,
and to still call pm_runtime_{en,dis}able() - as that would get a bit more
future-proof, should any other (newer, older, etc) SoC need to declare any power
domain but still no clocks.

So at this point, I think that just doing something like:

	if (common->plat->has_gals) {
		if (common->plat->rtff_managed) <--- not "skip_rpm"
			clk_required = 0;
		else if (common->plat->type == MTK_SMI_GEN2)
			clk_required = MTK_SMI_COM_GALS_REQ_CLK_NR;
		else if (common->plat->type == MTK_SMI_GEN2_SUB_COMM)
			clk_required = MTK_SMI_SUB_COM_GALS_REQ_CLK_NR;
	}

should be sufficient (and/or check zero required clocks in smi_dts_clk_init).

Cheers,
Angelo

> Thanks,
> Xueqi
> 
> On Thu, 2025-03-20 at 13:11 +0100, AngeloGioacchino Del Regno wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>
>>
>> Il 20/03/25 08:36, Xueqi Zhang ha scritto:
>>> MT8196 SMI commons is backed up/restored by RTFF HW.
>>> It doesn't need SW control the register backup/store
>>> in the runtime callback.Therefore, add a flag skip_rpm
>>> to help skip RPM operations for SMI commons.
>>>
>>> Signed-off-by: Xueqi Zhang <xueqi.zhang@mediatek.com>
>>
>> So the MT8196 SMI common doesn't require any clocks?
>>
>> That's fine for me, but this looks bloody similar to MT6989's SMI
>> common, which
>> is SMI GEN3 and not GEN2....
>>
>> ....so, are you sure that you need a `skip_rpm` flag and not new
>> MTK_SMI_GEN3 and
>> MTK_SMI_GEN3_SUB_COMM types? :-)
>>
>> Regards,
>> Angelo
>>
>>> ---
>>>    drivers/memory/mtk-smi.c | 11 ++++++++---
>>>    1 file changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
>>> index a8f5467d6b31..b9affa3c3185 100644
>>> --- a/drivers/memory/mtk-smi.c
>>> +++ b/drivers/memory/mtk-smi.c
>>> @@ -123,6 +123,7 @@ static const char * const mtk_smi_common_clks[]
>>> = {"apb", "smi", "gals0", "gals1
>>>    struct mtk_smi_common_plat {
>>>        enum mtk_smi_type       type;
>>>        bool                    has_gals;
>>> +     bool                    skip_rpm;
>>>        u32                     bus_sel; /* Balance some larbs to
>>> enter mmu0 or mmu1 */
>>>
>>>        const struct mtk_smi_reg_pair   *init;
>>> @@ -547,6 +548,9 @@ static int mtk_smi_dts_clk_init(struct device
>>> *dev, struct mtk_smi *smi,
>>>    {
>>>        int i, ret;
>>>
>>> +     if (smi->plat->skip_rpm)
>>> +             return 0;
>>> +
>>>        for (i = 0; i < clk_nr_required; i++)
>>>                smi->clks[i].id = clks[i];
>>>        ret = devm_clk_bulk_get(dev, clk_nr_required, smi->clks);
>>> @@ -783,7 +787,7 @@ static int mtk_smi_common_probe(struct
>>> platform_device *pdev)
>>>        common->dev = dev;
>>>        common->plat = of_device_get_match_data(dev);
>>>
>>> -     if (common->plat->has_gals) {
>>> +     if (!common->plat->skip_rpm && common->plat->has_gals) {
>>>                if (common->plat->type == MTK_SMI_GEN2)
>>>                        clk_required = MTK_SMI_COM_GALS_REQ_CLK_NR;
>>>                else if (common->plat->type == MTK_SMI_GEN2_SUB_COMM)
>>> @@ -814,13 +818,14 @@ static int mtk_smi_common_probe(struct
>>> platform_device *pdev)
>>>        }
>>>
>>>        /* link its smi-common if this is smi-sub-common */
>>> -     if (common->plat->type == MTK_SMI_GEN2_SUB_COMM) {
>>> +     if (common->plat->type == MTK_SMI_GEN2_SUB_COMM && !common-
>>>> plat->skip_rpm) {
>>>                ret = mtk_smi_device_link_common(dev, &common-
>>>> smi_common_dev);
>>>                if (ret < 0)
>>>                        return ret;
>>>        }
>>>
>>> -     pm_runtime_enable(dev);
>>> +     if (!common->plat->skip_rpm)
>>> +             pm_runtime_enable(dev);
>>>        platform_set_drvdata(pdev, common);
>>>        return 0;
>>>    }
>>
>>

