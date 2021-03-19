Return-Path: <SRS0=1/OX=IR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02A7C433DB
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 17:43:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C02F6197D
	for <iommu@archiver.kernel.org>; Fri, 19 Mar 2021 17:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C02F6197D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 230E34EE46;
	Fri, 19 Mar 2021 17:43:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iE-8m_sU8rF8; Fri, 19 Mar 2021 17:43:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id C89104EE40;
	Fri, 19 Mar 2021 17:43:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABB16C000A;
	Fri, 19 Mar 2021 17:43:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 369CFC0001
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 17:43:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C6BA40153
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 17:43:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8wsqY5_jn1Tm for <iommu@lists.linux-foundation.org>;
 Fri, 19 Mar 2021 17:43:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4525540150
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 17:43:29 +0000 (UTC)
Received: by mail-qt1-x834.google.com with SMTP id h7so7365089qtx.3
 for <iommu@lists.linux-foundation.org>; Fri, 19 Mar 2021 10:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iWTtZbypaf/PF2oQYz1A8g+KNh4Q43Kmkq97Z+9FFUk=;
 b=RZ8KV58bU6hT5xo1d8j69eB+xYu9PwsR1DUzm4JnjujlbFPkxX19l+TrXPhFoENqI9
 UekvOvessVkWGvQzjwXdRZo/Xtz+Pd2X6yr/faMZrkpS1kgw3YFLV8BUBlfxl+yqTOyl
 nIDNs4K0qzG4VawE/gPrVmbPq35/269R7x0foWrqOS+u8/r1+5eMEl8eJ9mpI3rYNlCX
 x98lwBlwszN78buHwV+wrxFvSjXQQeIuk/m9Kvr5IB9g8shrutwn8M3Yh9V7HjnaT1qO
 0FwnRVnPEvTrg26od1exkj5aIc0H/v0NJ5djK6caq1hRRQBxRc4dQdmGtQfAVfovcjct
 DNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iWTtZbypaf/PF2oQYz1A8g+KNh4Q43Kmkq97Z+9FFUk=;
 b=rx1kjGsQNAyhytZbh1735ViIB/vDdD0Kd6QiAyE45P8w2ZH1K1T7wi0L0nrwp4VRSg
 eKb3auxYKYNOmux+ZFvkqTinje4AsoOQLRuD9Ky2qXkxWyXZlwsd4jUTzB63RBlkaJ6M
 ld1qrAeF886vtWU84+8YViLHq2sSBvHzN/bhYhgryzl6NonGqbNbA4kDJ+fChTUcJS1J
 H2pthzykrO+tumM9utIAS50JyNHbSA6kNfo62OYaboIKrs+qmtHuUMjyrjaud0X87eK7
 W/M6jZWXs9gAROCCtYLvKPZiEFP5w0EIjsacFN7DMn6YZlEv1YyZTdOsqlQEzJQUujaN
 lFfA==
X-Gm-Message-State: AOAM532UeQ2P2vWBvKMcVtxFr72iznPO9dtFB7nvfXble9GwnUqENJOE
 LrX8LGEatXpYEsPwIfdTvuI=
X-Google-Smtp-Source: ABdhPJzsKP4zRyN3mmwQMyhxZcSpQe+K/iD/QF4iLyw7BrQBsrz5LJu85mN8QYNj7cytu/OQKAJc6Q==
X-Received: by 2002:ac8:a4c:: with SMTP id f12mr9582644qti.329.1616175808072; 
 Fri, 19 Mar 2021 10:43:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:dfe0:49f0:4c4a:ea4e:c31a:9352?
 ([2600:1700:dfe0:49f0:4c4a:ea4e:c31a:9352])
 by smtp.gmail.com with ESMTPSA id p5sm5151652qkj.35.2021.03.19.10.43.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Mar 2021 10:43:27 -0700 (PDT)
Subject: Re: [PATCH] ARM: Qualify enabling of swiotlb_init()
To: Christoph Hellwig <hch@lst.de>
References: <20210319040333.183827-1-f.fainelli@gmail.com>
 <20210319130731.GB2624@lst.de>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d4308ead-d561-19f6-510c-45e61613de54@gmail.com>
Date: Fri, 19 Mar 2021 10:43:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210319130731.GB2624@lst.de>
Content-Language: en-US
Cc: opendmb@gmail.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 open list <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
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



On 3/19/2021 6:07 AM, Christoph Hellwig wrote:
> On Thu, Mar 18, 2021 at 09:03:33PM -0700, Florian Fainelli wrote:
>>  #ifdef CONFIG_ARM_LPAE
>> +	if (swiotlb_force == SWIOTLB_FORCE ||
>> +	    max_pfn > arm_dma_pfn_limit)
> 
> Does arm_dma_pfn_limit do the right thing even with the weirdest
> remapping ranges?  Maybe a commen here would be useful.

It gets assigned to either 0xffffffff or PHYS_OFFSET + arm_dma_zone_size
- 1 which is obtained from the machine descriptor, so I expect it to do
the right thing, it works for a Pi 4 in 32-bit mode for instance. This
is conditional upon enabling CONFIG_ZONE_DMA for ARM, and will otherwise
keep its original value of 0, so this should be safe AFAICT.

> 
>> +		swiotlb_init(1);
>> +	else
>> +		swiotlb_force = SWIOTLB_NO_FORCE;
> 
> Konrad: what do you think of setting swiotlb_force to SWIOTLB_NO_FORCE
> and only switching it to SWIOTLB_NORMAL when swiotlb_init* is called?
> That kind makes more sense than forcing the callers to do it.
> 
> While we're at it, I think swiotlb_force should probably be renamed to
> swiotlb_mode or somethng like that.
Agreed.
-- 
Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
