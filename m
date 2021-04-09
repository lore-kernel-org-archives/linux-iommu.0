Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736F5C433B4
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 20:33:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B58861108
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 20:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B58861108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB9E683FA9;
	Fri,  9 Apr 2021 20:33:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1aHHcE3vDty1; Fri,  9 Apr 2021 20:33:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C4CE83F7C;
	Fri,  9 Apr 2021 20:33:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDE22C000B;
	Fri,  9 Apr 2021 20:33:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE41BC000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 20:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BDF72401CF
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 20:33:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dAsPlNidt3gI for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 20:33:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9CF9F401C9
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 20:33:08 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id i4so3464221pjk.1
 for <iommu@lists.linux-foundation.org>; Fri, 09 Apr 2021 13:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YmjR93qCqegX3FGNjwT1OaY2wVRNUBHdvrhmcB6wp3k=;
 b=MBFz1qSnHO1OD5HIq9T0FM2Sd5UPMML3yXeFiU5ETM7PUE/0v+k5ZKf4b8zL6HhqiZ
 dmjfJJVKF247gq7iYoSUUHbesy4eGsEUMHcdngCOw2H8KIkqSYnZy5oaqp504EGBYblc
 WDGfvU6/MPnlGyL/6PVU+gZ3c28MafUWBS34v3BaHhkcCNStwFZLtKdu6Nsx9EYekY3r
 C4fdD3bJJYkiRTWRCe6a13IL3Sikmo3WiLht9+8F3L5r8R0JLkm1VYRkf2XS/OwvRFWW
 XPr4fopVY/gSmZUC3om9qfbNrbJe6wtNcWeesD8Dx11Rt1kB2RD+bECEXaBblNiEBO4O
 Cfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YmjR93qCqegX3FGNjwT1OaY2wVRNUBHdvrhmcB6wp3k=;
 b=G9GM8Aolh+slRogRLqikpqxzcdkA2UEhNcI0IOzHvtLMmEtiqsIc8dvx25YMQpSzRE
 UqJHg5i1rE8gl7Qb3FoJzKEROOgNXjKXl6z+jN7HtoSJSk6xAHVfMnz8mBXdmtBl4Ct3
 0ANOSxXGDsbChCBdsPMQWgBi0QTQguGiBkEhut1NtfeE/ZPmQCn1dFmPG/ig0FwiVXCX
 aowrSP4P2LUf318FE7V+68dEPae3fZYYUGeg3ypBZoZJgfXCu6BbyQev6E8qbw9H+pMB
 7p9E31vaaMlQVQ16tRfPiyCPlX5VIQSgAM1Do/FE2AuuVaC2/Vy7iMi19Rhs455OfU3H
 snDw==
X-Gm-Message-State: AOAM533Zdf4kjI906UEBGP/WtwA3gB1NmdU7pQke0aiZw23ghv3L3/za
 0X+4o4iliWsDkJKGQgLx1NTQolemUnE=
X-Google-Smtp-Source: ABdhPJzkGN8DYaD4/IkbI3C/UZZwqNDsearZIzx2JHEcKQqZYQPWgThlHlIvtCt6ufDcz7yN0cz93g==
X-Received: by 2002:a17:902:8306:b029:e6:125c:1a3a with SMTP id
 bd6-20020a1709028306b02900e6125c1a3amr14954461plb.65.1618000387597; 
 Fri, 09 Apr 2021 13:33:07 -0700 (PDT)
Received: from [10.230.2.159] ([192.19.228.250])
 by smtp.gmail.com with ESMTPSA id v123sm2968201pfb.80.2021.04.09.13.33.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Apr 2021 13:33:07 -0700 (PDT)
Subject: Re: [PATCH v3] swiotlb: Make SWIOTLB_NO_FORCE perform no allocation
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20210321033740.312500-1-f.fainelli@gmail.com>
 <20210323015350.399493-1-f.fainelli@gmail.com> <20210324084250.GA4474@lst.de>
 <2ad22811-24e8-0776-3e55-ea2a4ac55f55@gmail.com>
 <YHCr2ziJxmISCcEW@Konrads-MacBook-Pro.local>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6bb1088e-f502-951b-ab0f-cfc872834a5e@gmail.com>
Date: Fri, 9 Apr 2021 13:33:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YHCr2ziJxmISCcEW@Konrads-MacBook-Pro.local>
Content-Language: en-US
Cc: "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 linux-kernel@vger.kernel.org
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



On 4/9/2021 12:32 PM, Konrad Rzeszutek Wilk wrote:
> On Thu, Apr 08, 2021 at 08:13:07PM -0700, Florian Fainelli wrote:
>>
>>
>> On 3/24/2021 1:42 AM, Christoph Hellwig wrote:
>>> On Mon, Mar 22, 2021 at 06:53:49PM -0700, Florian Fainelli wrote:
>>>> When SWIOTLB_NO_FORCE is used, there should really be no allocations of
>>>> default_nslabs to occur since we are not going to use those slabs. If a
>>>> platform was somehow setting swiotlb_no_force and a later call to
>>>> swiotlb_init() was to be made we would still be proceeding with
>>>> allocating the default SWIOTLB size (64MB), whereas if swiotlb=noforce
>>>> was set on the kernel command line we would have only allocated 2KB.
>>>>
>>>> This would be inconsistent and the point of initializing default_nslabs
>>>> to 1, was intended to allocate the minimum amount of memory possible, so
>>>> simply remove that minimal allocation period.
>>>>
>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>
>>> Looks good,
>>>
>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>
>>
>> Thanks! Konrad, can you apply this patch to your for-linus-5.13 branch
>> if you are also happy with it?
> 
> It should be now visible?

Not seeing it here:

https://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git/log/?h=devel/for-linus-5.13
-- 
Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
