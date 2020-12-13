Return-Path: <SRS0=Joyy=FR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68304C4361B
	for <iommu@archiver.kernel.org>; Sun, 13 Dec 2020 22:23:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF4CB23130
	for <iommu@archiver.kernel.org>; Sun, 13 Dec 2020 22:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4CB23130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7D9B985A76;
	Sun, 13 Dec 2020 22:23:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JI-8jlNxW-3G; Sun, 13 Dec 2020 22:23:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C60AB85A60;
	Sun, 13 Dec 2020 22:23:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD0A3C088E;
	Sun, 13 Dec 2020 22:23:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 034E2C013B
 for <iommu@lists.linux-foundation.org>; Sun, 13 Dec 2020 22:23:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E4F0586B52
 for <iommu@lists.linux-foundation.org>; Sun, 13 Dec 2020 22:23:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 19VM6ckAgQ8B for <iommu@lists.linux-foundation.org>;
 Sun, 13 Dec 2020 22:23:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id DD35086B50
 for <iommu@lists.linux-foundation.org>; Sun, 13 Dec 2020 22:23:35 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id t16so14578849wra.3
 for <iommu@lists.linux-foundation.org>; Sun, 13 Dec 2020 14:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding;
 bh=CpcQA8y5EOMq3kxe+epOyGnBZa2hF+OyoL02C9lsUQc=;
 b=ZMi5sSWUaK69ViITjTridS92Bcvx1bo8hcNEXZgc639d6QkecMcoDJXx2Ty2vfDWsL
 vS8Di+YOgabWa59QCIRWKoA8EeTlp5hIqh+LJfZX0b/c1QDx4kKNTgj6YqI2LNfwYgQ+
 tknZjAAQbQ1GMrpHFKL3UuZwAgMj6wniWqGnYJ4o+7vw0lWtNXX/e0CQkVHulVnBIBGf
 KPY7yrZWso5R+Bhtjk+B1S6HyJ+dFeX+SkijdXJweSHaRi6oidgHp7nyKpQZOVbNXkM/
 PfFCYYcyS7eX+N0DDhghQHvbpU0WepBwT3s3NGtaWO6QoAuQLg8MzpAReABeLzKHSr6W
 rvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=CpcQA8y5EOMq3kxe+epOyGnBZa2hF+OyoL02C9lsUQc=;
 b=F165hWm2C16na0Ah4fa1LZ1keUIrTCu2Z0DLpi1QVsbHpOYT1LeJppfDpkXg6DvDpo
 ppjRSSSy9n4dOPUMG+ui/0y/KGjm+buPOM7OIHMINTNGC0/wovw9JILUYgi9Ut1tBZhX
 2B+Q/GXg0Z6XeRvzMBNjuZSfCj8I+g6nf6q3a5huWY+3POFqG2HhIAgn3gEW4Sdf4qY1
 E2sii9+t9JmA3yeKv7pa6U8piawnGpzrNbxzPPlQnlm6uJSozT5m+6OVTH9F7v+Y4xUY
 7SxNdnQPt23XdRmFNPcmQpYo6cxNXX55LzPjdgSgN/aobVKc4GBRD47c6/Hs+kjBogzq
 rjhA==
X-Gm-Message-State: AOAM532wCPTAhAewBhOhNzedCf+rphnZZPuK1pwk524gzsKpBFIZB0Tm
 EQUUoY3Hm+gf8mZ8/zp7OZA=
X-Google-Smtp-Source: ABdhPJzzon2KHWc4xidKp2hBmJ8xDBSQePw9hQt0t2LBm2prz8oVNxrcYmCcJG/KkwRJkutLYv4zbA==
X-Received: by 2002:a5d:6751:: with SMTP id l17mr25652773wrw.73.1607898214399; 
 Sun, 13 Dec 2020 14:23:34 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:7d4b:496c:666e:80c7?
 (p200300ea8f0655007d4b496c666e80c7.dip0.t-ipconnect.de.
 [2003:ea:8f06:5500:7d4b:496c:666e:80c7])
 by smtp.googlemail.com with ESMTPSA id d15sm28245730wrx.93.2020.12.13.14.23.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Dec 2020 14:23:33 -0800 (PST)
Subject: Re: [PATCH v2] dma-mapping: add unlikely hint for error path in
 dma_mapping_error
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>
References: <39581f9a-0066-ad98-094d-d41082145e23@gmail.com>
 <93ac85090ffa4313a7dc87a38d1f6aa1@hisilicon.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <2faa40b9-e632-b9f3-6de0-471f0b7a6cae@gmail.com>
Date: Sun, 13 Dec 2020 22:23:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <93ac85090ffa4313a7dc87a38d1f6aa1@hisilicon.com>
Cc: "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Am 13.12.2020 um 22:27 schrieb Song Bao Hua (Barry Song):
> 
> 
>> -----Original Message-----
>> From: Heiner Kallweit [mailto:hkallweit1@gmail.com]
>> Sent: Monday, December 14, 2020 5:33 AM
>> To: Christoph Hellwig <hch@lst.de>; Marek Szyprowski
>> <m.szyprowski@samsung.com>; Robin Murphy <robin.murphy@arm.com>; Song Bao Hua
>> (Barry Song) <song.bao.hua@hisilicon.com>
>> Cc: open list:AMD IOMMU (AMD-VI) <iommu@lists.linux-foundation.org>; Linux
>> Kernel Mailing List <linux-kernel@vger.kernel.org>
>> Subject: [PATCH v2] dma-mapping: add unlikely hint for error path in
>> dma_mapping_error
>>
>> Zillions of drivers use the unlikely() hint when checking the result of
>> dma_mapping_error(). This is an inline function anyway, so we can move
>> the hint into this function and remove it from drivers.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> not sure if this is really necessary. It seems the original code
> is more readable. Readers can more easily understand we are
> predicting the branch based on the return value of
> dma_mapping_error().
> 
I basically see two points promoting the proposed change:
1. Driver authors shouldn't have to think (as far as possible) about
   whether a branch prediction hint could make sense for a standard
   core API call. I saw quite some past discussions about when
   something is unlikely enough so that an unlikely() makes sense.
   If the core can hide some more complexity from drivers, then
   I think it's a good thing.
2. If we ever want or have to change the use of unlikely with
   dma_mapping_error(), then we have to do it in just one place.

> Anyway, I don't object to this one. if other people like it, I am
> also ok with it.
> 
>> ---
>> v2:
>> Split the big patch into the change for dma-mapping.h and follow-up
>> patches per subsystem that will go through the trees of the respective
>> maintainers.
>> ---
>>  include/linux/dma-mapping.h | 2 +-
>>  kernel/dma/map_benchmark.c  | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index 2e49996a8..6177e20b5 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -95,7 +95,7 @@ static inline int dma_mapping_error(struct device *dev,
>> dma_addr_t dma_addr)
>>  {
>>  	debug_dma_mapping_error(dev, dma_addr);
>>
>> -	if (dma_addr == DMA_MAPPING_ERROR)
>> +	if (unlikely(dma_addr == DMA_MAPPING_ERROR))
>>  		return -ENOMEM;
>>  	return 0;
>>  }
>> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
>> index b1496e744..901420a5d 100644
>> --- a/kernel/dma/map_benchmark.c
>> +++ b/kernel/dma/map_benchmark.c
>> @@ -78,7 +78,7 @@ static int map_benchmark_thread(void *data)
>>
>>  		map_stime = ktime_get();
>>  		dma_addr = dma_map_single(map->dev, buf, PAGE_SIZE, map->dir);
>> -		if (unlikely(dma_mapping_error(map->dev, dma_addr))) {
>> +		if (dma_mapping_error(map->dev, dma_addr)) {
>>  			pr_err("dma_map_single failed on %s\n",
>>  				dev_name(map->dev));
>>  			ret = -ENOMEM;
>> --
>> 2.29.2
> 
> Thanks
> Barry
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
