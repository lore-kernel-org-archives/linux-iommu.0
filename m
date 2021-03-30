Return-Path: <SRS0=H7Zn=I4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD70C433DB
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 21:14:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD2C9619D2
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 21:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2C9619D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CB276086E;
	Tue, 30 Mar 2021 21:14:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3FbwdqrAB3XY; Tue, 30 Mar 2021 21:14:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C8586005E;
	Tue, 30 Mar 2021 21:14:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FE85C000C;
	Tue, 30 Mar 2021 21:14:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FDDCC000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 21:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4E67940399
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 21:14:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9ePX81kMRwzq for <iommu@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 21:14:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 37A054034A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 21:14:42 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id c3so17347195qkc.5
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 14:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=+ggozfWBPW8IuLIjloW6WSrwVHoKc5x/0lF7TLz027Y=;
 b=vOri9Y+PBjDsorPl7YPFn8uYnFAt2bbwsF1irc/UoeCWg2FuGAdfhAmAryiWLbwGfP
 8M58Ydu/8nmNIQZaelGmUC+1PwKtGx/U3S58yFNQYQR8+S7fxKOL6j43RFKSz6szPcxf
 XgnGXQjJRLLXz8x4Vx8ThJpjB37S3//llCWahX/nc81rmmrDQjKFL2/ldUdWYSaz5FoL
 MJhdcD4a26Z5pT0WThRfN9bssZv2xJE2A0KuyNzfd8N+51UI/iF4q9Ldplkya1yqsnA4
 CFdt8s9V9XYeXKr5b1pbWKRcq19TLStc9Rew6TF2GLruCKfKBuIdCvEHPM1SzUxfks1f
 uajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=+ggozfWBPW8IuLIjloW6WSrwVHoKc5x/0lF7TLz027Y=;
 b=BxyvF8isBUgxh/f7jfaXhGI2ysdSLywycsiegER2SQHAk5pMZrnoMuKGKNp4mAOaLH
 mRvrP/nvXI/2v/y1eX2xR3lvbFDvj5H/fGYka+IbUHg5c92SlgyUnqyq7DOF+Cv1Jm5K
 1ky4ZlYS+B8NjbEhGWs//ktsSDPRjIIgGqV7M7sRt5QHviJMsD85zg0OLpsJMY1hiOM2
 UB7R8SeM32eW/dDDwKWXJNWt+fUhhA2kELzMH3xm8u2EJ73DNXihyi/fBecFMJUOUBuQ
 GWsOxC6csNsdF2Kl97/iFrqgHdbmWJ1dRGZqtCswKzXZ/q2ORVZWDbwjQY+UcqkwiNZp
 a7jg==
X-Gm-Message-State: AOAM532nXltOsUy+zA0i4byeJesImYCOzOubgcYToICtu4vxKs6H9VJ1
 9wg2Pws85cW+aeDSvPtNfA4=
X-Google-Smtp-Source: ABdhPJwbD+N/GjB0AlKqJVMu0SfsvPdMs9oaHoiPjFBTbDnbbPd1HJfEWQMejjZPYQPo+ef3Vr0RGw==
X-Received: by 2002:a05:620a:2158:: with SMTP id
 m24mr231264qkm.306.1617138881199; 
 Tue, 30 Mar 2021 14:14:41 -0700 (PDT)
Received: from Gentoo ([143.244.44.215])
 by smtp.gmail.com with ESMTPSA id x21sm16567967qkj.25.2021.03.30.14.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Mar 2021 14:14:40 -0700 (PDT)
Date: Wed, 31 Mar 2021 02:44:22 +0530
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 24/30] Kconfig: Change Synopsys to Synopsis
Message-ID: <YGOUrpsQzrIPEHIU@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, dmaengine@vger.kernel.org,
 dri-devel@lists.freedesktop.org, hch@lst.de,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 dave.jiang@intel.com, dan.j.williams@intel.com,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org
References: <cover.1616971780.git.unixbhaskar@gmail.com>
 <1262e9e62498f961e5172205e66a9ef7c6f0f69d.1616971780.git.unixbhaskar@gmail.com>
 <8f80fb1b-b2d0-b66a-24b0-bd92dc6cd4b6@arm.com>
MIME-Version: 1.0
In-Reply-To: <8f80fb1b-b2d0-b66a-24b0-bd92dc6cd4b6@arm.com>
Cc: dave.jiang@intel.com, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 dmaengine@vger.kernel.org, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org, hch@lst.de
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
Content-Type: multipart/mixed; boundary="===============3689746146266742377=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============3689746146266742377==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZkHisyvIHxtmch2f"
Content-Disposition: inline


--ZkHisyvIHxtmch2f
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 12:43 Tue 30 Mar 2021, Robin Murphy wrote:
>On 2021-03-29 00:53, Bhaskar Chowdhury wrote:
>> s/Synopsys/Synopsis/  .....two different places.
>
>Erm, that is definitely not a typo... :/
>

>> ..and for some unknown reason it introduce a empty line deleted and added
>> back.
>
>Presumably your editor is configured to trim trailing whitespace on save.
>
>Furthermore, there are several instances in the other patches where your
>"corrections" are grammatically incorrect, I'm not sure what the deal is
>with patch #14, and you've also used the wrong subsystem name (it should
>be "dmaengine"). It's great to want to clean things up, but please pay a
>bit of care and attention to what you're actually doing.


Thank you so much, I shall be more careful.
>
>Robin.
>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>   drivers/dma/Kconfig | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> index 0c2827fd8c19..30e8cc26f43b 100644
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -170,15 +170,15 @@ config DMA_SUN6I
>>   	  Support for the DMA engine first found in Allwinner A31 SoCs.
>>
>>   config DW_AXI_DMAC
>> -	tristate "Synopsys DesignWare AXI DMA support"
>> +	tristate "Synopsis DesignWare AXI DMA support"
>>   	depends on OF || COMPILE_TEST
>>   	depends on HAS_IOMEM
>>   	select DMA_ENGINE
>>   	select DMA_VIRTUAL_CHANNELS
>>   	help
>> -	  Enable support for Synopsys DesignWare AXI DMA controller.
>> +	  Enable support for Synopsis DesignWare AXI DMA controller.
>>   	  NOTE: This driver wasn't tested on 64 bit platform because
>> -	  of lack 64 bit platform with Synopsys DW AXI DMAC.
>> +	  of lack 64 bit platform with Synopsis DW AXI DMAC.
>>
>>   config EP93XX_DMA
>>   	bool "Cirrus Logic EP93xx DMA support"
>> @@ -394,7 +394,7 @@ config MOXART_DMA
>>   	select DMA_VIRTUAL_CHANNELS
>>   	help
>>   	  Enable support for the MOXA ART SoC DMA controller.
>> -
>> +
>>   	  Say Y here if you enabled MMP ADMA, otherwise say N.
>>
>>   config MPC512X_DMA
>> --
>> 2.26.3
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>

--ZkHisyvIHxtmch2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBjlK0ACgkQsjqdtxFL
KRV/Awf/WgJ4kZNXg13Lymj81qWKh0xQChcPR1byavkwRKFeyk4mIQDv4/V33f03
x8lKJRgdvwchbQrJXtz1HkobUN2Yx2wQ8aprpF+kOiv0brN8c7TE92xf7dxnjL7T
3SSjbN44aYkmCCyV/Em37qXQi4/WrhZbP70K2P89e++Xsjb/rElNBwlmQzyjx0Jt
KIiXNgr5vFaqJOtwrMFOwDqparI5v70FJjHSTjZMHPPJTiIuYwMSl4r57ABV2s+7
jXyj1J6ePWL0sfX8h4eo2sBFtcuirP8NZMJbHw4lA0JG8FE6nBDAiFohWucgPBdo
8vzWlWSOOWJTt5N84XfYEPiJB1caGg==
=WK+C
-----END PGP SIGNATURE-----

--ZkHisyvIHxtmch2f--

--===============3689746146266742377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============3689746146266742377==--
