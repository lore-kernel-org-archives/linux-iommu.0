Return-Path: <SRS0=vqUx=OG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F7DC433F5
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 09:40:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEEE4611CA
	for <iommu@archiver.kernel.org>; Thu, 16 Sep 2021 09:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CEEE4611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A03160675;
	Thu, 16 Sep 2021 09:40:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oyhpAYRZ2FPo; Thu, 16 Sep 2021 09:40:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9FFEF60687;
	Thu, 16 Sep 2021 09:40:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 654C4C0011;
	Thu, 16 Sep 2021 09:40:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CDD2C000D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 09:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 180D7823E0
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 09:40:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p4G7DzPJKpAJ for <iommu@lists.linux-foundation.org>;
 Thu, 16 Sep 2021 09:40:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 396BC823DD
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 09:40:42 +0000 (UTC)
Received: by mail-lf1-x132.google.com with SMTP id p29so16047397lfa.11
 for <iommu@lists.linux-foundation.org>; Thu, 16 Sep 2021 02:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=f4r5L82T8lVgmjDxktA/sisuupFmx7x30+6IlhMnYag=;
 b=jPcF0P+cHfyIuFllT9s+XQDbpTKL/DP/WZ12xBmDnC0LZJsbJeGpydQ+nj1jG3vyhQ
 MXkF+s9f9DZe82C3OUmuCqssXSW6Xy1D8PFT7XMOVkyU74aEXJL7HBQJL//WLAcHnHlT
 6JAWY0XBjZ7XwV9xpdiHpNmVxyHHj5cWcQPRN6QHBZx1dqJ5C5ttXeA+io6IcnyWEI1q
 dTKH6A8fDq2gQ2GNoUTTZGZkVAhST9ZUJ+pdKy05GPpnzXG3EkGwi93ZGAuCS4fkFkql
 PEeqVQZUULvnCU7rK1P4+9aDwbpW2w/MkOtNecCIBYtcqqkOy4RB/4LhCrlLfobSeeON
 wc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=f4r5L82T8lVgmjDxktA/sisuupFmx7x30+6IlhMnYag=;
 b=Diyza1qyL/WxQuxssOk3i20SYGJc3jTcw86pLQOB2reEwaodDMH9e1InCl+TX4hqCF
 Dic/7L0/+WchKO4UHnNj5PSxGCPzLWMtZeuB4YowhUKnd/FBTm1BlHOW+UhNImJQrQtD
 Sxs0LRrM81D3MKSukkexP4kkKTCKq2d9/G5dW9xxqaFSgEpZOI5IcL3Yt8Ggdq12Ds93
 vzx1DlaIJkFHTHyaoU94orkgYaPZcGwHXixWDUJHHElefH/FBPhs/eJ/4rF+RHiXfJvU
 EKoH5rXfjoJfX0AwWp2KqmWNR1DNxaQOuozyB4s1aD75gWUSHL7yKI/Bdah49b6qLssR
 UvBg==
X-Gm-Message-State: AOAM532Jba/lepiN3T7JZBUqinnkjdCQwpmw7XOGkr63FyoCh/s/yjYq
 Zov4jF9ndCGJFswP6IS0dL9hVx6+yrA3ok7jkIE=
X-Google-Smtp-Source: ABdhPJyIIyf4A7fhfDx7l6dTfpk1Ec/zzEqy4u9mdnznrZCiaqfyA9V5XQj08EEuePeq9U7P318zvMYzkOuwjxToNGM=
X-Received: by 2002:a2e:1508:: with SMTP id s8mr3587923ljd.240.1631785239506; 
 Thu, 16 Sep 2021 02:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210914151016.3174924-1-Roman_Skakun@epam.com>
 <7c04db79-7de1-93ff-0908-9bad60a287b9@suse.com> <20210914153046.GB815@lst.de>
 <alpine.DEB.2.21.2109141838290.21985@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.2109141838290.21985@sstabellini-ThinkPad-T480s>
From: Roman Skakun <rm.skakun@gmail.com>
Date: Thu, 16 Sep 2021 12:40:28 +0300
Message-ID: <CADu_u-OjpYB0-B=tLKYsZH=auvQF-o7PJb-11W=1emY8jaA-mg@mail.gmail.com>
Subject: Re: [PATCH] swiotlb: set IO TLB segment size via cmdline
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Jan Beulich <jbeulich@suse.com>,
 Will Deacon <will@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>,
 Christoph Hellwig <hch@lst.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Muchun Song <songmuchun@bytedance.com>, Thomas Gleixner <tglx@linutronix.de>,
 Juergen Gross <jgross@suse.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Andrii Anisov <andrii_anisov@epam.com>, linuxppc-dev@lists.ozlabs.org,
 Randy Dunlap <rdunlap@infradead.org>, linux-mips@vger.kernel.org,
 iommu <iommu@lists.linux-foundation.org>, Roman Skakun <roman_skakun@epam.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, Robin Murphy <robin.murphy@arm.com>,
 Mike Rapoport <rppt@kernel.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgU3RlZmFubywKCj4gQWxzbywgT3B0aW9uIDEgbGlzdGVkIGluIHRoZSB3ZWJwYWdlIHNlZW1z
IHRvIGJlIGEgbG90IGJldHRlci4gQW55Cj4gcmVhc29uIHlvdSBjYW4ndCBkbyB0aGF0PyBCZWNh
dXNlIHRoYXQgb3B0aW9uIGJvdGggc29sdmVzIHRoZSBwcm9ibGVtCj4gYW5kIGluY3JlYXNlcyBw
ZXJmb3JtYW5jZS4KClllcywgT3B0aW9uIDEgaXMgcHJvYmFibHkgbW9yZSBlZmZpY2llbnQuCkJ1
dCBJIHVzZSBhbm90aGVyIHBsYXRmb3JtIHVuZGVyIFhlbiB3aXRob3V0IERNQSBhZGp1c3RtZW50
IGZ1bmN0aW9uYWxpdHkuCkkgcGlubmVkIHRoaXMgd2VicGFnZSBvbmx5IGZvciBleGFtcGxlIHRv
IGRlc2NyaWJlIHRoZSBzaW1pbGFyIHByb2JsZW0gSSBoYWQuCgpDaGVlcnMsClJvbWFuCgrRgdGA
LCAxNSDRgdC10L3Rgi4gMjAyMSDQsy4g0LIgMDQ6NTEsIFN0ZWZhbm8gU3RhYmVsbGluaSA8c3N0
YWJlbGxpbmlAa2VybmVsLm9yZz46Cgo+Cj4gT24gVHVlLCAxNCBTZXAgMjAyMSwgQ2hyaXN0b3Bo
IEhlbGx3aWcgd3JvdGU6Cj4gPiBPbiBUdWUsIFNlcCAxNCwgMjAyMSBhdCAwNToyOTowN1BNICsw
MjAwLCBKYW4gQmV1bGljaCB3cm90ZToKPiA+ID4gSSdtIG5vdCBjb252aW5jZWQgdGhlIHN3aW90
bGIgdXNlIGRlc2NyaWJlIHRoZXJlIGZhbGxzIHVuZGVyICJpbnRlbmRlZAo+ID4gPiB1c2UiIC0g
bWFwcGluZyBhIDEyODB4NzIwIGZyYW1lYnVmZmVyIGluIGEgc2luZ2xlIGNodW5rPyAoQXMgYW4g
YXNpZGUsCj4gPiA+IHRoZSBib3R0b20gb2YgdGhpcyBwYWdlIGlzIGFsc28gY29uZnVzaW5nLCBh
cyBmb2xsb3dpbmcgIlRoZW4gd2UgY2FuCj4gPiA+IGNvbmZpcm0gdGhlIG1vZGlmaWVkIHN3aW90
bGIgc2l6ZSBpbiB0aGUgYm9vdCBsb2c6IiB0aGVyZSBpcyBhIGxvZwo+ID4gPiBmcmFnbWVudCBz
aG93aW5nIHRoZSBzYW1lIG9yaWdpbmFsIHNpemUgb2YgNjRNYi4KPiA+Cj4gPiBJdCBkb2Vzbid0
LiAgV2UgYWxzbyBkbyBub3QgYWRkIGhhY2tzIHRvIHRoZSBrZXJuZWwgZm9yIHdoYWNreSBvdXQK
PiA+IG9mIHRyZWUgbW9kdWxlcy4KPgo+IEFsc28sIE9wdGlvbiAxIGxpc3RlZCBpbiB0aGUgd2Vi
cGFnZSBzZWVtcyB0byBiZSBhIGxvdCBiZXR0ZXIuIEFueQo+IHJlYXNvbiB5b3UgY2FuJ3QgZG8g
dGhhdD8gQmVjYXVzZSB0aGF0IG9wdGlvbiBib3RoIHNvbHZlcyB0aGUgcHJvYmxlbQo+IGFuZCBp
bmNyZWFzZXMgcGVyZm9ybWFuY2UuCgoKCi0tCkJlc3QgUmVnYXJkcywgUm9tYW4uCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
