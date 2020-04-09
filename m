Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40773C2BB86
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 11:50:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14BBC20BED
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 11:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NtywfqhK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BBC20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DCDCF22246;
	Thu,  9 Apr 2020 11:50:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bLCGy56aPuvY; Thu,  9 Apr 2020 11:50:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CF2D51FE2F;
	Thu,  9 Apr 2020 11:50:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA7E7C1D7E;
	Thu,  9 Apr 2020 11:50:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5A91C0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 11:47:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CF63E20509
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 11:47:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ry0m7+0tqk0B for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 11:47:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by silver.osuosl.org (Postfix) with ESMTPS id 3E88D203CA
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 11:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1586432792;
 bh=YwvQtuxsbR6y98B1sZKqlpMCtNJicqz5rAzgfjwA858=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=NtywfqhKf5xtBSc1YrTOaznz6c9Nsstc/Lv2gCCziLCgksZYTlxFRSu0uxPOYqZ7Y
 FueKCzdJHDsUFZgWaWXpnYxSD5WTIVbJ5tkg0amoBMgthzjh+nRKWb6Ut2SjftO70l
 j1Mf5sABzCMDIMwL6naGVsHGgJTjPJBHHnMA7nRY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.10.46] ([88.151.74.233]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MdNcG-1inRw81Wvw-00ZMlH; Thu, 09
 Apr 2020 13:46:32 +0200
Subject: Re: [PATCH 19/28] gpu/drm: remove the powerpc hack in
 drm_legacy_sg_alloc
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Vetter <daniel@ffwll.ch>, Christoph Hellwig <hch@lst.de>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-20-hch@lst.de>
 <20200408122504.GO3456981@phenom.ffwll.local>
 <eb48f7b6327e482ea9911b129210c0417ab48345.camel@kernel.crashing.org>
From: Gerhard Pircher <gerhard_pircher@gmx.net>
Openpgp: preference=signencrypt
Autocrypt: addr=gerhard_pircher@gmx.net; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d4a82787-5dd2-ccde-79b4-ff44848ba04e@gmx.net>
Date: Thu, 9 Apr 2020 13:46:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <eb48f7b6327e482ea9911b129210c0417ab48345.camel@kernel.crashing.org>
Content-Language: de-AT
X-Provags-ID: V03:K1:o+8/nGO7SOvNhc10lyIj+DkVb/dgMNqZpIt89ODEsaP3R7B372X
 CFPKuGNuA413MUsQR7p9FFMdVf2IGA0u9bDZzYzGrskLoPKL+wG3y7FqWmsmvBINib9zAPL
 3+lKCFTcgREGV5zEJOsGaHNHNnIcRaOpWMIoYXGs9KxywGC6t08XQ4CP1jARTv/jpZPK/Xs
 zfGB7nB7x/W8Ea7CqI8kA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GHa6pIyhWV4=:rp1Fqsv7AN42t3IKZBpAjw
 Im8gUzt7++Zu6cOwN/L0G0W1FZDOyWN0GC5gc0pxXuR6+LwHwHdiN7XtyrWbXsc9dH66ZLsUc
 ocFxh2/tyVcCXkjFsUUAfGUYKlmYiz+O3ob5RRMzoR8SpBTfb8d167TvE81HqCRzvuTntxkEN
 io+vs67wuH9OZiBo51wsVOvNruSXWU2439c/auVWFwkabMlPGhygU2PzXQKJghPTH5A0Kf49d
 IRVI2TDQRAlyj8UgcHWJmCbOvrB1pQ9ZcWJlJ6qJgJzdiI34qkqTVljpPSRcEWNgTYYdqPCOo
 ZrB4Teu5yIwn53Sr230aOhC4x2SZIyjbTvvuAQwAbMJDX43nUKlRqZj1L1/IPYjvGeeAUj7HA
 1eVUjHB2jTosnl6/ZSzUUjzDothJizKrJfhOlymM4oE5mO2HL04zIp3JlX882NWgP6+xCt4AB
 P7IUA3FLrKAW8Wt14iV1XwcmynT1Sci5agn6rWwc4gnWLFHN3LD3kZNip1Ii0WzNIoOF3vBdG
 3IcfxDk1y4bfSsqojDmaIvuxf+ehOkoT4rWMHWd6hMAROs6gb75p5T0FOQSxlCKqS3anM/3j9
 Jh6xvR7kCkrhyXGuyVsbAspKf+7PRWG9K9STDrbJlrS3MjBwglDm73UR2oDAIM0zdyqD9q5Np
 1PyXEXsmu4Lim7E2JQY0J8Yo9Mdo+Pj6EQRTFEePKMpKriF40ZzDT/pI6s95JvVBfczCEWlQi
 G5hQPcLOhzxgKfMsqN8LuyyCrz/XVAO3K0XdmnAFsJ5t+XEA2biiT8gNqi8lScrjQ/vhWaTMd
 EjiWFJLmOYhvwgCsgVk9wyzJGOKmSurvMbU2+BIYwqeF77ZFl07J/2uqtBx7GPGyO3msu8z9v
 RTCJ6G/OxhtDrQjs98oeUPQBpYPZaidykmI8YA1D1zQX184Dx5zMsBRvIcB3Sy78nldIu8TRG
 nI7RmPxA5FKrIyIxFMPA7I14Q7nP56bJjVpNjhITih0i9d/OiHK0yYiBe1ioAFrATzezESzXg
 YLTmQrcRjinR0l920eqgeGIp5OyMrfwSN1OQ8L4dsq6K2K6uJ3IIP2ukhqKK02WGPMFhXmnjc
 3YJ3MKh5/ICmHNn/VnL9n31JbyOqZO2DNWRbvaIDs/WDns3ASDwlr338i6IsLIYR2igBeVKdg
 uBqAs+aRuxHLNiiGgHJjOM8MdEDjcgR09+RhG/eFHNy65PlAIJ392wXN04OLPBfTDWQrkWE5f
 hFDTQ3qeo7BRfIaZK
X-Mailman-Approved-At: Thu, 09 Apr 2020 11:50:28 +0000
Cc: linux-hyperv@vger.kernel.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 "K. Y. Srinivasan" <kys@microsoft.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Laura Abbott <labbott@redhat.com>, Nitin Gupta <ngupta@vflare.org>,
 Haiyang Zhang <haiyangz@microsoft.com>, linaro-mm-sig@lists.linaro.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
 iommu@lists.linux-foundation.org, bpf@vger.kernel.org,
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

Am 09.04.20 um 10:54 schrieb Benjamin Herrenschmidt:
> On Wed, 2020-04-08 at 14:25 +0200, Daniel Vetter wrote:
>> On Wed, Apr 08, 2020 at 01:59:17PM +0200, Christoph Hellwig wrote:
>>> If this code was broken for non-coherent caches a crude powerpc hack
>>> isn't going to help anyone else.  Remove the hack as it is the last
>>> user of __vmalloc passing a page protection flag other than PAGE_KERNEL.
>>
>> Well Ben added this to make stuff work on ppc, ofc the home grown dma
>> layer in drm from back then isn't going to work in other places. I guess
>> should have at least an ack from him, in case anyone still cares about
>> this on ppc. Adding Ben to cc.
>
> This was due to some drivers (radeon ?) trying to use vmalloc pages for
> coherent DMA, which means on those 4xx powerpc's need to be non-cached.
>
> There were machines using that (440 based iirc), though I honestly
> can't tell if anybody still uses any of it.
The first-gen amigaone platform (6xx/book32s) uses the radeon driver
together with non-coherent DMA. However this only ever worked reliably
for DRI1.

br,
Gerhard

> Cheers,
> Ben.
>
>> -Daniel
>>
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>> ---
>>>  drivers/gpu/drm/drm_scatter.c | 11 +----------
>>>  1 file changed, 1 insertion(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_scatter.c b/drivers/gpu/drm/drm_scatter.c
>>> index ca520028b2cb..f4e6184d1877 100644
>>> --- a/drivers/gpu/drm/drm_scatter.c
>>> +++ b/drivers/gpu/drm/drm_scatter.c
>>> @@ -43,15 +43,6 @@
>>>
>>>  #define DEBUG_SCATTER 0
>>>
>>> -static inline void *drm_vmalloc_dma(unsigned long size)
>>> -{
>>> -#if defined(__powerpc__) && defined(CONFIG_NOT_COHERENT_CACHE)
>>> -	return __vmalloc(size, GFP_KERNEL, pgprot_noncached_wc(PAGE_KERNEL));
>>> -#else
>>> -	return vmalloc_32(size);
>>> -#endif
>>> -}
>>> -
>>>  static void drm_sg_cleanup(struct drm_sg_mem * entry)
>>>  {
>>>  	struct page *page;
>>> @@ -126,7 +117,7 @@ int drm_legacy_sg_alloc(struct drm_device *dev, void *data,
>>>  		return -ENOMEM;
>>>  	}
>>>
>>> -	entry->virtual = drm_vmalloc_dma(pages << PAGE_SHIFT);
>>> +	entry->virtual = vmalloc_32(pages << PAGE_SHIFT);
>>>  	if (!entry->virtual) {
>>>  		kfree(entry->busaddr);
>>>  		kfree(entry->pagelist);
>>> --
>>> 2.25.1
>>>
>>
>>
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
