Return-Path: <SRS0=7Zqx=JL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3853C433B4
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 14:12:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 428E2611CC
	for <iommu@archiver.kernel.org>; Wed, 14 Apr 2021 14:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428E2611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E22E540E65;
	Wed, 14 Apr 2021 14:12:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FHUUrg-_ERcv; Wed, 14 Apr 2021 14:12:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9808F40E47;
	Wed, 14 Apr 2021 14:12:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 788D9C000C;
	Wed, 14 Apr 2021 14:12:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB507C000A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:12:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A0E1840E4E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:12:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3TGDeUKcT7ax for <iommu@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 14:12:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB51F40E47
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 14:12:16 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 kk2-20020a17090b4a02b02900c777aa746fso10898994pjb.3
 for <iommu@lists.linux-foundation.org>; Wed, 14 Apr 2021 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vp40JX7MD1oyRAb9Y8UvaxNthRrEWLT17bpKIw89Vp8=;
 b=hgK+6erZ/ZaIIki51J5aG86ePrPsolHe2qeKZ3mg0eC79G+Ei/Bl8NcW1/owX7Xdvd
 rmz970jRX+yXh0X9NH6qR54n+i8aLCInwqGmBYXVE5Pz/41ZSjaa2XardvhUTDY0Cs8p
 Yb8qSrX8YZkIaX1LZOMsIyyp2AANwpQbaD0TPaGWdD1+oDzIhG4EZDWR4UpDRE/xVuCQ
 N8pnfMt21Jt8oaHjNOazLwIuBchS7NTnnWhbxgVR/eiJnPPzM4uD+eQIsTwsTcftdTN2
 PLFnQlYAW0zxbCBAw867haMamI/S87JyMzhiPrlCaEk/1uzEh5rdFQu8pm1apetFdwCW
 YVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vp40JX7MD1oyRAb9Y8UvaxNthRrEWLT17bpKIw89Vp8=;
 b=YmEOEHFdUX8TfNPNKE1Ds8uXePYXLVs+4qMp/BKIpnw4Ii2yBnsTISjX3xRNTwiLNX
 +A5LSEsdhAp/yCz5lcqwBe6nrzj+bYdH+Kbzwo/B7UFnEX6RgOqX3+olPwE7qOkaVouM
 S71MyM8GlKxmFeajThCuLqa6nChTD/Sp6abPasJPdWQIrN3O9Y8rSdtTqfJqIZY3fh3l
 pB0V37tIQeL/BSx/G9M3zV9mcDPR7+29bTElHy9x/wG2VIXPsVNIW71/r5OT1TSOjMtN
 IpdbYAT4UMahft3FmzRhoOfGN+rptnomFwEmq9/Hf2OrvDRGapo8+5vwnVJQIrtCA0P4
 C2Jw==
X-Gm-Message-State: AOAM530BjcefUBOifDrGPEM5z/3AjXeMSgcC+FTYksJQK3MpskzmTJlV
 yT//bRz+MQDz70Rhw8W36as=
X-Google-Smtp-Source: ABdhPJza5jUB4sMZoDE0tC09q1IDVXc3SViDZwxG00IgG6HA9/9/9np52gjLQ2051sKXN15McHj8Hw==
X-Received: by 2002:a17:90a:ee95:: with SMTP id
 i21mr4068778pjz.160.1618409536393; 
 Wed, 14 Apr 2021 07:12:16 -0700 (PDT)
Received: from ?IPv6:2404:f801:0:6:8000::a31c? ([2404:f801:9000:1a:efeb::a31c])
 by smtp.gmail.com with ESMTPSA id i18sm6579059pfq.168.2021.04.14.07.12.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Apr 2021 07:12:16 -0700 (PDT)
Subject: Re: [RFC V2 PATCH 9/12] swiotlb: Add bounce buffer remap address
 setting function
To: Christoph Hellwig <hch@lst.de>
References: <20210413152217.3386288-1-ltykernel@gmail.com>
 <20210413152217.3386288-10-ltykernel@gmail.com>
 <20210414064358.GA25877@lst.de>
From: Tianyu Lan <ltykernel@gmail.com>
Message-ID: <963fc95f-915e-99a2-aa5c-63ae8e2c6591@gmail.com>
Date: Wed, 14 Apr 2021 22:12:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210414064358.GA25877@lst.de>
Content-Language: en-US
Cc: thomas.lendacky@amd.com, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, brijesh.singh@amd.com, vkuznets@redhat.com,
 robin.murphy@arm.com, sunilmut@microsoft.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 4/14/2021 2:43 PM, Christoph Hellwig wrote:
> On Tue, Apr 13, 2021 at 11:22:14AM -0400, Tianyu Lan wrote:
>> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>>
>> For Hyper-V isolation VM with AMD SEV SNP, the bounce buffer(shared memory)
>> needs to be accessed via extra address space(e.g address above bit39).
>> Hyper-V code may remap extra address space outside of swiotlb. swiotlb_bounce()
>> needs to use remap virtual address to copy data from/to bounce buffer. Add
>> new interface swiotlb_set_bounce_remap() to do that.
> 
> I have no way to review what this actually doing when you only Cc me
> on a single patch.  Please make sure everyone is Cced on the whole
> series to enable proper review.
> 

Sure. I will resend all patches. Thanks for reminder.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
