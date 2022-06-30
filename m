Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFD0CCA47F
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 19:26:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4272A40AC1;
	Thu, 30 Jun 2022 19:26:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4272A40AC1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=iWoDQJ/d
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5TiCCAu6AuwG; Thu, 30 Jun 2022 19:26:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 00D8240A21;
	Thu, 30 Jun 2022 19:26:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 00D8240A21
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC427C002D;
	Thu, 30 Jun 2022 19:26:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E1A4C0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 19:26:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 385C8608B7
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 19:26:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 385C8608B7
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=iWoDQJ/d
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZUn_MjJ3FoHA for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 19:26:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B6716059F
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0B6716059F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 19:26:15 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id x4so363018pfq.2
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 12:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=BGB9eQ8ZjliFMgcRVKHE6urD7afsm+Bb1aKDYwW5Jfo=;
 b=iWoDQJ/dSdAde8AnIfDLxTdgiCOtOm+79LF23IYKQzTSvSChn0RKCEgkrj6yW/aq/L
 Ng7bKjXng0gluiBq2N+qXVNpXYJtqS/oCtHvj7VFuOyHwQQMfGgLnLNQOCJAEJPkpiFz
 k9OtgFn1UYqtdFU3SJ6Burv7HN7xACp19dipB8UXOnRrfrcJd6leCbIArojfXdQMEk7Y
 dmdguQ+pTW3/V2p6m9x2fWOO9yUsbTxLRRBRVk14fYaRWck/UzINDGudetShPegD8vs/
 9UYWZVqajm4CeiChNVdfJ+MpdaPqsySivwBLzVcXqDzRte+YXhoifrJyNvp0EqNB047u
 BQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=BGB9eQ8ZjliFMgcRVKHE6urD7afsm+Bb1aKDYwW5Jfo=;
 b=UWrUQ7u7Div+96KsnsG5ZwibGckfyNr1AVNLLnt989LoCxPoSJdXq732O7CxkSjuut
 akcsIJsA0aZqonjqAQUoRlMD3W8PtsSY7jmRdWemjZv/OGcrrgQ9gt3ktbvsd4yQiFKL
 hXhgqsSl9qFJXWcSH5F2390UxMlmfgpTa7TkeakIy26BQy0i8313cD7UBCwuahrOjT56
 78hLZ6C8Q3huY4C4hJtHdoVIp8c/Fzeg2yxzRT4XhD8Ium8jnFBRH5I51y0WL5KFk/8z
 rV0UTiGGrHu8Uj0MHRElHWm5kys6cyR37HapbhaAu+0DOCVKNqBwXLZyfZLZ59aRBAYx
 Ej/w==
X-Gm-Message-State: AJIora+6vuQKP8Dyi8XqPiy5UFn9G1u8hJwaY+397CDELzUmR/nT5++x
 UJkchKCQnDtdT6U5HPk4Nak=
X-Google-Smtp-Source: AGRyM1tk83J3rH/OFTSOHRQYyzuFUGQ/lxtqXLEqqvb1V70fRLzAxXraPK8BYuQ19iCr74oVBVR7bQ==
X-Received: by 2002:a63:4a0b:0:b0:40d:d4c1:131f with SMTP id
 x11-20020a634a0b000000b0040dd4c1131fmr8603747pga.242.1656617175475; 
 Thu, 30 Jun 2022 12:26:15 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:b411:35d2:9458:bbe5?
 ([2001:df0:0:200c:b411:35d2:9458:bbe5])
 by smtp.gmail.com with ESMTPSA id
 c18-20020a621c12000000b0051bbd79fc9csm13969994pfc.57.2022.06.30.12.26.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jun 2022 12:26:14 -0700 (PDT)
Message-ID: <13e45965-4e55-11b1-bfdc-59efaad27464@gmail.com>
Date: Fri, 1 Jul 2022 07:26:05 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
References: <20220617125750.728590-1-arnd@kernel.org>
 <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com>
 <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com>
 <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
 <CAK8P3a1ivqYB38c_QTjG8e85ZBnCB6HEa-6LR1HDc8shG1Pwmw@mail.gmail.com>
 <b1edec96-ccb2-49d6-323b-1abc0dc37a50@gmail.com>
 <YrvwZi9NQSpFjStX@infradead.org>
From: Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <YrvwZi9NQSpFjStX@infradead.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, scsi <linux-scsi@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Miquel van Smoorenburg <mikevs@xs4all.net>,
 Denis Efremov <efremov@linux.com>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Khalid Aziz <khalid@gonehiking.org>, Arnd Bergmann <arnd@kernel.org>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Matt Wang <wwentao@vmware.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Salyzyn <salyzyn@android.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 alpha <linux-alpha@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Maciej W . Rozycki" <macro@orcam.me.uk>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgQ2hyaXN0b3BoLAoKT24gMjkvMDYvMjIgMTg6MjUsIENocmlzdG9waCBIZWxsd2lnIHdyb3Rl
Ogo+IE9uIFdlZCwgSnVuIDI5LCAyMDIyIGF0IDA5OjM4OjAwQU0gKzEyMDAsIE1pY2hhZWwgU2No
bWl0eiB3cm90ZToKPj4gVGhhdCdzIG9uZSBvZiB0aGUgJ2xpYmVydGllcycgSSBhbGx1ZGVkIHRv
LiBUaGUgcmVhc29uIEkgbGVmdCB0aGVzZSBpbiBpcwo+PiB0aGF0IEknbSBub25lIHRvbyBjZXJ0
YWluIHdoYXQgZGV2aWNlIGZlYXR1cmUgdGhlIERNQSBBUEkgdXNlcyB0byBkZWNpZGUgYQo+PiBk
ZXZpY2UgaXNuJ3QgY2FjaGUtY29oZXJlbnQuCj4gVGhlIERNQSBBUEkgZG9lcyBub3QgbG9vayBh
dCBkZXZpY2UgZmVhdHVyZXMgYXQgYWxsLiAgSXQgbmVlZHMgdG8gYmUKPiB0b2xkIHNvIGJ5IHRo
ZSBwbGF0Zm9ybSBjb2RlLiAgT25jZSBhbiBhcmNoaXRlY3R1cmUgaW1wbGVtZW50cyB0aGUKPiBo
b29rcyB0byBzdXBwb3J0IG5vbi1jb2hlcmVudCBETUEgYWxsIGRldmljZXMgYXJlIHRyZWF0ZWQg
YXMKPiBub24tY29oZXJlbnQgYnkgZGVmYXVsdCB1bmxlc3Mgb3ZlcnJpZGVuIGJ5IHRoZSBhcmNo
aXRlY3R1cmUgZWl0aGVyCj4gZ2xvYmFsbHkgKHVzaW5nIHRoZSBnbG9iYWwgZG1hX2RlZmF1bHRf
Y29oZXJlbnQgdmFyaWFibGUpIG9yIHBlci1kZXZpY2UKPiAodXNpbmcgdGhlIGRldi0+ZG1hX2Nv
aGVyZW50IGZpZWxkLCB1c3VhbGx5IHNldCBieSBhcmNoX3NldHVwX2RtYV9vcHMpLgpIYXZlbid0
IGdvdCBhbnkgb2YgdGhhdCwgc28gbm9uLWNvaGVyZW50IERNQSBpcyBhbGwgd2UgY2FuIHVzZSAo
ZXZlbiAKdGhvdWdoIHNvbWUgb2YgdGhlIFJBTSB1c2VkIGZvciBib3VuY2UgYnVmZmVycyBtYXkg
YWN0dWFsbHkgYmUgY29oZXJlbnQgCmR1ZSB0byB0aGUgcGFnZSB0YWJsZSBjYWNoZSBiaXRzKS4K
Pgo+PiBJZiBpdCdzIGRldi0+Y29oZXJlbnRfZG1hX21hc2ssIHRoZSB3YXkgSSBzZXQKPj4gdXAg
dGhlIGRldmljZSBpbiB0aGUgYTMwMDAgZHJpdmVyIHNob3VsZCBsZWF2ZSB0aGUgY29oZXJlbnQg
bWFzayB1bmNoYW5nZWQuCj4+IEZvciB0aGUgWm9ycm8gZHJpdmVycywgZGV2aWNlcyBhcmUgc2V0
IHVwIHRvIHVzZSB0aGUgc2FtZSBzdG9yYWdlIHRvIHN0b3JlCj4+IG5vcm1hbCBhbmQgY29oZXJl
bnQgbWFza3MgLSBzb21ldGhpbmcgd2UgbW9zdCBsaWtlbHkgd2FudCB0byBjaGFuZ2UuIEkgbmVl
ZAo+PiB0byB0aGluayBhYm91dCB0aGUgcmFtaWZpY2F0aW9ucyBvZiB0aGF0Lgo+IE5vLCB0aGUg
Y29oZXJlbnQgbWFzayBpcyBzbGlnaHRseSBtaXNuYW1lZCBhbWQgbm90IGFjdHVhbGx5IHJlbGF0
ZWQuCgpUaGFua3MsIHRoYXQgaGFkIG1lIGNvbmZ1c2VkLgoKQ2hlZXJzLAoKIMKgwqDCoCBNaWNo
YWVsCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
