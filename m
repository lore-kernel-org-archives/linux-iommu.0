Return-Path: <SRS0=5N08=DA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C3EC4727D
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 08:37:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0DC238E3
	for <iommu@archiver.kernel.org>; Wed, 23 Sep 2020 08:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSsqMwkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0DC238E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8D069866EA;
	Wed, 23 Sep 2020 08:37:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pHtD5PVpSLQR; Wed, 23 Sep 2020 08:37:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EF60286234;
	Wed, 23 Sep 2020 08:37:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2949C0859;
	Wed, 23 Sep 2020 08:37:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA5C5C0051
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 07:45:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D1458203E5
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 07:45:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ud2IBXlHc41N for <iommu@lists.linux-foundation.org>;
 Wed, 23 Sep 2020 07:45:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com
 [209.85.219.193])
 by silver.osuosl.org (Postfix) with ESMTPS id CD863203F3
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 07:45:34 +0000 (UTC)
Received: by mail-yb1-f193.google.com with SMTP id k18so6024076ybh.1
 for <iommu@lists.linux-foundation.org>; Wed, 23 Sep 2020 00:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=/GHpmKCCGcexOvtlcyC9uP2q4Nd41VuwJ5FfEQainNU=;
 b=HSsqMwkLY+zUqzjY7UyjOZKpIvQ7wlqcBiaPf6F2IIb2yOEO87qCbmqf4tXTT04Zb1
 2tVgBD5mbMmp9WJWzAZ0ZFFOqDckzewIHs9K5CuT8fblr2U4C9o+33xhpCtPplzwCqdd
 +N7hzAecUTUdHBPwoXABtx948UViuFkLgzwybNmquwMZcmk5UGQA566K1s2kcgc3VoZW
 C/TGc0bC/+w1Amsy2S93XHYOa/l7yLFFBfOhv8XbrmmNSpLFIcdkkdzT3XXbpYR5F6hQ
 vPySNn6CYb7OyBEiSqTMMgeEbvSAwMCWibKqNpZrGTTbtWz6UKAqP2lz2hoDgPOgeAKx
 CMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=/GHpmKCCGcexOvtlcyC9uP2q4Nd41VuwJ5FfEQainNU=;
 b=LqHTbPy8XKdsYhECqQJdlVBs3lF2MH4A6qELkgM50oeZHCbvMPLXC9BeYnBAs1EPfY
 P7dFEbFyVYJZ8Tx3fnV4j7ZoDI2nNa2Mz1Q3BrE9pWajJtwJe2mw3d75Ys6VQkZGC9dz
 iqUZt6bulBOicOSZx6YUBOR7X50Y6IAPdbbvYdAkKfjbtHJKiCAH8SPHE4+8O55dKWn7
 wfucTOk/7K58u5LBwZqnsP7Dx8jpfPR6bmfGbu+Df0LWxj5tQz5jgGtKplwipsVFCJUK
 /guOlU/oGO6Hs9RkicsjrUZTzTmaafcZSaNSbZTBxi+7T5Q2H4N0/EFrbST5Ud1Agt52
 3hzg==
X-Gm-Message-State: AOAM531L5a6x6/wbnxs3OiYciXn4inljdaQN6Ur1n3I8aZz9gU9kTeaA
 fie+WULrXnUtoQnfRY9LxATbt/B5DrL/IU2j+ps=
X-Google-Smtp-Source: ABdhPJwTbE5iL/lGdCAxASuHqeib/oo/4BHL2s4NmZET3Mh4YBt2LS13hfc0AT8zSCatXXrEJzBHAnvsusQ6jAIgnfI=
X-Received: by 2002:a25:320b:: with SMTP id y11mr10422663yby.394.1600847133912; 
 Wed, 23 Sep 2020 00:45:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a26:9820:0:0:0:0:0 with HTTP; Wed, 23 Sep 2020 00:45:33
 -0700 (PDT)
In-Reply-To: <20200923065808.GA16366@lst.de>
References: <CAEC9eQOX9BHX4v5aY2cfCT=T-ZHA7y0xF7aiZhW9xzG4fme36Q@mail.gmail.com>
 <CAEC9eQPaeF9=Li74x9RrSHyDgRZ6b653yBRu6EYsaU+eSj2wsQ@mail.gmail.com>
 <59cda41f-170c-a1ad-a345-bc38b9ed4d73@arm.com>
 <CGME20200424161534eucas1p29177cad5b4790d392acb69a335a3992e@eucas1p2.samsung.com>
 <CAOD6ATrWYLPT0ydz2vFhNwWhqHum_q_pyCe=oGJWOcEqjmNOqQ@mail.gmail.com>
 <11584d09-5995-6133-3bd3-8f7a0afd0e01@samsung.com>
 <20200923065808.GA16366@lst.de>
From: Ajay kumar <ajaynumb@gmail.com>
Date: Wed, 23 Sep 2020 13:15:33 +0530
Message-ID: <CAEC9eQMoqYBU_9H9QoAwwayR8u2MK4aMDvTocOqrPRK3cuVeHw@mail.gmail.com>
Subject: Re: IOVA allocation dependency between firmware buffer and remaining
 buffers
To: Christoph Hellwig <hch@lst.de>
X-Mailman-Approved-At: Wed, 23 Sep 2020 08:37:13 +0000
Cc: jean-philippe@linaro.org, will@kernel.org, linux-mm@kvack.org,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Shaik Ameer Basha <shaik.ameer@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>
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

Hello all,

We pretty much tried to solve the same issue here with a new API in DMA-IOMMU:
https://lore.kernel.org/linux-iommu/20200811054912.GA301@infradead.org/T/

Christopher- the user part would be MFC devices on exynos platforms

Thanks,
Ajay
On 9/23/20, Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Sep 23, 2020 at 08:48:26AM +0200, Marek Szyprowski wrote:
>> Hi Shaik,
>>
>> I've run into similar problem while adapting S5P-MFC and Exynos4-IS
>> drivers for generic IOMMU-DMA framework. Here is my first solution:
>> https://lore.kernel.org/linux-samsung-soc/20200918144833.14618-1-m.szyprowski@samsung.com/T/
>>
>>
>>
>> It allows to remap given buffer at the specific IOVA address, although
>> it doesn't guarantee that those specific addresses won't be later used
>> by the IOVA allocator. Probably it would make sense to add an API for
>> generic IOMMU-DMA framework to mark the given IOVA range as
>> reserved/unused to protect them.
>
> If you want to use IOVA addresses in a device otherwise managed by
> dma-iommu we need to expose an API through the dma API.  Can you please
> include the iommu list in the discussion of your series?
>
> I don't think using the raw IOMMU API is a very idea in these drivers,
> we probably want a way to change the allocator algorithm or hint the
> next IOVA and keep using the normal DMA API.  Maybe Robin has a better
> idea.
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
