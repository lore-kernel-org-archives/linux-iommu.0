Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5667C433E0
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 14:58:35 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4B2E206E2
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 14:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ0SxbRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4B2E206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7409E8BD39;
	Wed,  1 Jul 2020 14:58:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ye2Y9zfT3TYp; Wed,  1 Jul 2020 14:58:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6DCCF8BD3A;
	Wed,  1 Jul 2020 14:58:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54D99C0865;
	Wed,  1 Jul 2020 14:58:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0180DC0733
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 14:58:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DE2C58A921
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 14:58:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J5CU6PBwNlml for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jul 2020 14:58:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9E1378A91C
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 14:58:31 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id a6so18427052wmm.0
 for <iommu@lists.linux-foundation.org>; Wed, 01 Jul 2020 07:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tgomHUILfZO2QPwClmFfP2483eQY3sI8aZ9EHBd/lIQ=;
 b=RQ0SxbRTQhidycgq3WYUSZbnKfe+n9/V49qTfwFGk7/owVD8bpNstPfIrZYl0E2FpI
 jIXMuiKhK6ik1mxttOPWBkABcQEv2KmHTifuwX7J5Iv9mwAaTJD2yHTHm8hpfA2b4Txq
 2/pGuY85dYKHUlKPbjhlcKR+VziLZ/uB7juZqi9ZCVmIBKjMxbd2c4m4g/5AL+lRzGXa
 ECtvl8SZ1tM5AqQ7qrVaE1puhcpnlT9OEhSj+9OdbVe4AU4AI7KNpU4MAy+5YHwauzJo
 MKueCkh6Med+xUnkGH5Vs1HAd+DhTz2R5UMtCdaEV3SYhSgxCWsoHYUDodmy+CJ8vhJ2
 2cTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=tgomHUILfZO2QPwClmFfP2483eQY3sI8aZ9EHBd/lIQ=;
 b=GwDL0ELmGK6gqdIx6VwUvdy9oSqm32ePdC4e5swph4GHKxtxf7Cg1QzyJaGsJcdG5M
 4S5lYuw7yoGmxWsAltW1ZgE+t+w2Fo2TL6i81xiuLwY6aMBteLclJZhCT0VXc+UrQCfo
 Omj8WCbt9PIHsaSK7vxLG7q5lNBo4uwDpCFUcyLh4bUtrE0bZiR4lGSTb2yI07FVGBAB
 e4d75/zLwDQeq2qFbscR75iZoik9Z4BezxRe6d4DfSVd8JvtSpw1PXQJdo4NfAySDrU4
 D8uG2OT/IHMHmCB3Y4D5ymlOSNtgQ/52l19OLCVnxqy30akEWyB/KgDb/+0LMziVm7DF
 DNJw==
X-Gm-Message-State: AOAM533HwaoHm9WgkPq2i974RQxmp8UAe5eh4UH4l70lrpZqQwlNdk7a
 WINMX31wv5jQoNUqG9GOWuc=
X-Google-Smtp-Source: ABdhPJwD3eaD0V351RwesreOGJ4Dbb/SccQjhHooP1D3LI8EeI8ESRHiysZTJ6iJhY0sWa2TxIIXZQ==
X-Received: by 2002:a1c:6a03:: with SMTP id f3mr7030351wmc.58.1593615509962;
 Wed, 01 Jul 2020 07:58:29 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.138])
 by smtp.gmail.com with ESMTPSA id 65sm6414888wmd.20.2020.07.01.07.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 07:58:29 -0700 (PDT)
Subject: Re: [PATCH v5 04/10] iommu/mediatek: Setting MISC_CTRL register
To: chao hao <Chao.Hao@mediatek.com>
References: <20200629071310.1557-1-chao.hao@mediatek.com>
 <20200629071310.1557-5-chao.hao@mediatek.com>
 <0e9ceba8-0cc4-44a1-148c-1c9a6b3844ce@gmail.com>
 <1593514398.2581.7.camel@mbjsdccf07>
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b9a68cda-bb2e-c9f3-4e44-c201df06c396@gmail.com>
Date: Wed, 1 Jul 2020 16:58:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593514398.2581.7.camel@mbjsdccf07>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, FY Yang <fy.yang@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 30/06/2020 12:53, chao hao wrote:
> On Mon, 2020-06-29 at 11:28 +0200, Matthias Brugger wrote:
>>
>> On 29/06/2020 09:13, Chao Hao wrote:
>>> Add F_MMU_IN_ORDER_WR_EN and F_MMU_STANDARD_AXI_MODE_BIT definition
>>> in MISC_CTRL register.
>>> F_MMU_STANDARD_AXI_MODE_BIT:
>>>   If we set F_MMU_STANDARD_AXI_MODE_BIT(bit[3][19] = 0, not follow
>>> standard AXI protocol), iommu will send urgent read command firstly
>>> compare with normal read command to improve performance.
>>
>> Can you please help me to understand the phrase. Sorry I'm not a AXI specialist.
>> Does this mean that you will send a 'urgent read command' which is not described
>> in the specifications instead of a normal read command?
> 
> ok.
> iommu sends read command to next bus_node normally(we can name it to
> cmd1), when cmd1 isn't handled by next bus_node, iommu has a urgent read
> command is needed to be sent(we can name it to cmd2), iommu will send
> cmd2 and replace cmd1. So cmd2 is handled by next bus_node firstly and
> cmd2 will be handled secondly.
> But for standard AXI protocol, it will ignore the priority of read
> command and only be handled in order. So cmd2 is handled by next
> bus_node after cmd1 is done.
> 

Thanks. So I propose change this part of the commit message to something like:
F_MMU_STANDARD_AXI_MODE_BIT:
If we set F_MMU_STANDARD_AXI_MODE_EN_MASK (bit[3][19] = 0, not follow standard
AXI protocol), the iommu will priorize sending of urgent read command over a
normal read command. This improves the performance.

>>
>>> F_MMU_IN_ORDER_WR_EN:
>>>   If we set F_MMU_IN_ORDER_WR_EN(bit[1][17] = 0, out-of-order write), iommu
>>> will re-order write command and send more higher priority write command
>>> instead of sending write command in order. The feature be controlled
>>> by OUT_ORDER_EN macro definition.

F_MMU_IN_ORDER_WR_EN:
If we set F_MMU_IN_ORDER_WR_EN_MASK (bit[1][17] = 0, out-of-order write), the
iommu will re-order write commands and send the write command with higher
priority. Otherwise the sending of write commands will be done in order. The
feature is controlled by OUT_ORDER_WR_EN platform data flag.


>>>
>>> Cc: Matthias Brugger <matthias.bgg@gmail.com>
>>> Suggested-by: Yong Wu <yong.wu@mediatek.com>
>>> Signed-off-by: Chao Hao <chao.hao@mediatek.com>
>>> ---
>>>  drivers/iommu/mtk_iommu.c | 12 +++++++++++-
>>>  drivers/iommu/mtk_iommu.h |  1 +
>>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>>> index 8f81df6cbe51..67b46b5d83d9 100644
>>> --- a/drivers/iommu/mtk_iommu.c
>>> +++ b/drivers/iommu/mtk_iommu.c
>>> @@ -42,6 +42,9 @@
>>>  #define F_INVLD_EN1				BIT(1)
>>>  
>>>  #define REG_MMU_MISC_CTRL			0x048
>>> +#define F_MMU_IN_ORDER_WR_EN			(BIT(1) | BIT(17))
>>> +#define F_MMU_STANDARD_AXI_MODE_BIT		(BIT(3) | BIT(19))
>>
>> Wouldn't it make more sense to name it F_MMU_STANDARD_AXI_MODE_EN?
> ok, you are right.
> 1'b1: follow standard axi protocol
> 

What about
F_MMU_IN_ORDER_WR_EN_MASK
F_MMU_STANDARD_AXI_MODE_EN_MASK

Background is that we have to set/unset two bits to enable or disable the
feature, so it's a mask we have to apply to the register.

Regards,
Matthias

>>
>>> +
>>>  #define REG_MMU_DCM_DIS				0x050
>>>  
>>>  #define REG_MMU_CTRL_REG			0x110
>>> @@ -574,10 +577,17 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
>>>  	}
>>>  	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
>>>  
>>> +	regval = readl_relaxed(data->base + REG_MMU_MISC_CTRL);
>>
>> We only need to read regval in the else branch.
> 
> ok, I got it. thanks
> 
>>
>>>  	if (MTK_IOMMU_HAS_FLAG(data->plat_data, RESET_AXI)) {
>>>  		/* The register is called STANDARD_AXI_MODE in this case */
>>> -		writel_relaxed(0, data->base + REG_MMU_MISC_CTRL);
>>> +		regval = 0;
>>> +	} else {
>>> +		/* For mm_iommu, it can improve performance by the setting */
>>> +		regval &= ~F_MMU_STANDARD_AXI_MODE_BIT;
>>> +		if (MTK_IOMMU_HAS_FLAG(data->plat_data, OUT_ORDER_EN))
>>> +			regval &= ~F_MMU_IN_ORDER_WR_EN;
>>>  	}
>>> +	writel_relaxed(regval, data->base + REG_MMU_MISC_CTRL);
>>>  
>>>  	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
>>>  			     dev_name(data->dev), (void *)data)) {
>>> diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
>>> index 7cc39f729263..4b780b651ef4 100644
>>> --- a/drivers/iommu/mtk_iommu.h
>>> +++ b/drivers/iommu/mtk_iommu.h
>>> @@ -22,6 +22,7 @@
>>>  #define HAS_BCLK			BIT(1)
>>>  #define HAS_VLD_PA_RNG			BIT(2)
>>>  #define RESET_AXI			BIT(3)
>>> +#define OUT_ORDER_EN			BIT(4)
>>
>> Maybe something like OUT_ORDER_WR_EN, to make clear that it's about the the
>> write path.
>>
> ok, thanks for your advice.
> 
>>>  
>>>  #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
>>>  		((((pdata)->flags) & (_x)) == (_x))
>>>
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
