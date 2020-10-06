Return-Path: <SRS0=boqS=DN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90F6C41604
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 14:29:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CA99204EF
	for <iommu@archiver.kernel.org>; Tue,  6 Oct 2020 14:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="BFD//pwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA99204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8F95B8503D;
	Tue,  6 Oct 2020 14:29:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hIysde8XTWh9; Tue,  6 Oct 2020 14:29:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D9AC684F6F;
	Tue,  6 Oct 2020 14:29:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD20AC07FF;
	Tue,  6 Oct 2020 14:29:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87405C0051
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 14:28:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 680E78484B
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 14:28:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2jHnwtgqTLjP for <iommu@lists.linux-foundation.org>;
 Tue,  6 Oct 2020 14:28:58 +0000 (UTC)
X-Greylist: delayed 01:01:05 by SQLgrey-1.7.6
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
 [209.85.166.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3D4AE8362D
 for <iommu@lists.linux-foundation.org>; Tue,  6 Oct 2020 14:28:58 +0000 (UTC)
Received: by mail-io1-f66.google.com with SMTP id y13so13222135iow.4
 for <iommu@lists.linux-foundation.org>; Tue, 06 Oct 2020 07:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marek-ca.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YRYuE1oST5rCsSRo3ftJBgKrW6I4XszeRlUEeyGTNfA=;
 b=BFD//pwAX/64KPt0LEII7XnZhATo+5u4Ci1QUGZnXAvcyoZpf216nBIukB8S0lNR+o
 /SBnsKFNycdO4FaqhrrvOl8q9yUCUD0kMtxCFrm+T3BuOtGJqNoq/vuatu/yUwFaui3W
 wG/q9rVWqGvQF3DH1sF8weJvvvE2/FsOJioQK368BV9SL2poAmn8GeN+if4sevucB6tf
 8BV+2/e4V/R+9zg6ETBTYxp+Q6woapII4/lMg/2r2Ql9+NA7asVIWxgARtsMmyYoMq2K
 YKB5J7l4MgFdsyryEbJBhC2DmC2IwuvI3od1/Cu2zgJfsaaVHr58x1zSeFV0fZQiWrdf
 Hg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YRYuE1oST5rCsSRo3ftJBgKrW6I4XszeRlUEeyGTNfA=;
 b=qvihPruxR8w+AAawPpPsLGcvqOnMBe6jyNg+G29wZr3g074ynekcdN0JYTRLjEZLvm
 wKZoAc8UesihK7UzzeuXBiOHNWxWVjqwlQycAw9VL5lDdd7gmxz6Cza1BTdNNt9cgYcG
 o/XizCWAONSi/2DZ1BTKY5NyJPRzRM/+2geOw1GHGcHSbpnzvF9a/+vtCo5tKwAWZznZ
 Ghrllse4nt2iVFys/ql6qu5bglarvdtRakg4IUe0iT+C+Z0tcwwi0AdSnuR1UArzzi68
 iYhAXPndDHAdtOeKVDrTkxFYoZNSmh781fzPVG4DbVpkHVFwCgxaYv68YfH2L8a+r+MH
 yOMA==
X-Gm-Message-State: AOAM531ua6d+kN62uRLRpl9WGesDkM4nN2RmL4y6/LPO6+1wGwmuSp1q
 U5ExZO5tp9CSg5hnXZ9dWblg+sNb46tN7v96
X-Google-Smtp-Source: ABdhPJw4Z7YWS8t/L1IK8utu6wKe+vRmf2v1MdzI4qau8wJptX2TFHJ6aQoGZURrxgM6eCoWFpwqPw==
X-Received: by 2002:a05:620a:1287:: with SMTP id
 w7mr2490783qki.335.1601990468080; 
 Tue, 06 Oct 2020 06:21:08 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
 by smtp.gmail.com with ESMTPSA id 192sm2477887qkm.110.2020.10.06.06.21.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 06:21:07 -0700 (PDT)
Subject: Re: [PATCH 2/3] drm/msm: add DRM_MSM_GEM_SYNC_CACHE for non-coherent
 cache maintenance
To: Christoph Hellwig <hch@infradead.org>
References: <20201001002709.21361-1-jonathan@marek.ca>
 <20201001002709.21361-3-jonathan@marek.ca>
 <20201002075321.GA7547@infradead.org>
 <b22fb797-67b0-a912-1d23-2b47c9a9e674@marek.ca>
 <20201005082914.GA31702@infradead.org>
 <3e0b91be-e4a4-4ea5-7d58-6e71b8d51932@marek.ca>
 <20201006072306.GA12834@infradead.org>
From: Jonathan Marek <jonathan@marek.ca>
Message-ID: <148a1660-f0fc-7163-2240-6b94725342b5@marek.ca>
Date: Tue, 6 Oct 2020 09:19:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20201006072306.GA12834@infradead.org>
Content-Language: en-US
Cc: David Airlie <airlied@linux.ie>, freedreno@lists.freedesktop.org,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <dri-devel@lists.freedesktop.org>,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 "open list:DRM DRIVER FOR MSM ADRENO GPU" <linux-arm-msm@vger.kernel.org>,
 Sean Paul <sean@poorly.run>, Robin Murphy <robin.murphy@arm.com>
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

On 10/6/20 3:23 AM, Christoph Hellwig wrote:
> On Mon, Oct 05, 2020 at 10:35:43AM -0400, Jonathan Marek wrote:
>> The cache synchronization doesn't have anything to do with IOMMU (for
>> example: cache synchronization would be useful in cases where drm/msm
>> doesn't use IOMMU).
> 
> It has to do with doing DMA.  And we have two frameworks for doing DMA:
> either the DMA API which is for general driver use, and which as part of
> the design includes cache maintainance hidden behind the concept of
> ownership transfers.  And we have the much more bare bones IOMMU API.
> 
> If people want to use the "raw" IOMMU API with not cache coherent
> devices we'll need a cache maintainance API that goes along with it.
> It could either be formally part of the IOMMU API or be separate.
> 
>> What is needed is to call arch_sync_dma_for_{cpu,device} (which is what I
>> went with initially, but then decided to re-use drm/msm's
>> sync_for_{cpu,device}). But you are also saying those functions aren't for
>> driver use, and I doubt IOMMU maintainers will want to add wrappers for
>> these functions just to satisfy this "not for driver use" requirement.
> 
> arch_sync_dma_for_{cpu,device} are low-level helpers (and not very
> great ones at that).  The definitively should not be used by drivers.
> They would be very useful buildblocks for a IOMMU cache maintainance
> API.
> 
> Of course the best outcome would be if we could find a way for the MSM
> drm driver to just use DMA API and not deal with the lower level
> abstractions.  Do you remember why the driver went for use of the IOMMU
> API?
> 

One example why drm/msm can't use DMA API is multiple page table support 
(that is landing in 5.10), which is something that definitely couldn't 
work with DMA API.

Another one is being able to choose the address for mappings, which 
AFAIK DMA API can't do (somewhat related to this: qcom hardware often 
has ranges of allowed addresses, which the dma_mask mechanism fails to 
represent, what I see is drivers using dma_mask as a "maximum address", 
and since addresses are allocated from the top it generally works)

But let us imagine drm/msm switches to using DMA API. a2xx GPUs have 
their own very basic MMU (implemented by msm_gpummu.c), that will need 
to implement dma_map_ops, which will have to call 
arch_sync_dma_for_{cpu,device}. So drm/msm still needs to call 
arch_sync_dma_for_{cpu,device} in that scenario.







_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
