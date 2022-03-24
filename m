Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E185C433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 19:34:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F883417B4;
	Thu, 24 Mar 2022 19:34:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gES39_2EztBn; Thu, 24 Mar 2022 19:34:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4528E41732;
	Thu, 24 Mar 2022 19:34:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DD2BC001A;
	Thu, 24 Mar 2022 19:34:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12947C000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 19:34:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E1D4060A6F
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 19:34:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jy5omWunvRbb for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 19:34:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1F02B60759
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 19:34:38 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id h7so9840680lfl.2
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 12:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7ocr+zNBzLy/6V5R8wtgclLYODnbC8wqaRaDBOcpGsE=;
 b=WXJOxqP+A5zMAAeglXUwwXwm6CdqHnTIlvW7/xITHkfLm0l9NrhvUsL/He558mycRA
 VdKU9P7nwZJx35e0DULKlv5C9sFMFPTxUzNh9GE1D85zKtfkg1cfIBWUR6eKr8fMZSMt
 poa1NyRAI1YJ+p+Bz/tVZQpcDzOAbj8llkHVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7ocr+zNBzLy/6V5R8wtgclLYODnbC8wqaRaDBOcpGsE=;
 b=dMndCwHLPrLXBztnIJDcBtUGMUIp/btQSvBVlsI4P5bz+X3Yljm2oplROu2A0qhP4C
 pEsb2K/YTdolRLPXckOs1d/X0b0FM8/qPmPws6jPaCCpGoSbY+qag9A4s3AkCR+VCcEd
 wvbpWZr262PKXEBw6nFFnJbnzJofQqp1UNS9gWUoJryh5boYDLpq5gHXauLoHMnK6xVl
 wPa0nnDyPsRnGaC+cb0qnzdS2gFnCwtlfkHZjZduFFfOqAja1vWlAQPs/WLl4SsuzyLi
 wB1ZTAFj8BIRin2Pz0NxI7uWnliqHlz0syPb+zWLDzR3h4/LyMelV7/1QK/BWOVWLqej
 N7sw==
X-Gm-Message-State: AOAM532pu5PcGhzJWie4GnCeZH4UxoBrN4SjB5yOC6fEkafc2hwdi3BR
 g1CYU0zIoT+sYIwz9ZOU2kOiJCoKXNk2sVGDT09MnQ==
X-Google-Smtp-Source: ABdhPJxZ/iIdVstRNDp4xJX7QoPqlcBUwZOU6GCOLBc1+q6gk67dY6JcZbgWxefeQWF+ZaI43XNujg==
X-Received: by 2002:a05:6512:ea7:b0:44a:2d87:fffc with SMTP id
 bi39-20020a0565120ea700b0044a2d87fffcmr4924508lfb.290.1648150475513; 
 Thu, 24 Mar 2022 12:34:35 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com.
 [209.85.208.180]) by smtp.gmail.com with ESMTPSA id
 x11-20020a2e9dcb000000b00249800fc660sm438076ljj.17.2022.03.24.12.34.34
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Mar 2022 12:34:35 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id r22so7567852ljd.4
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 12:34:34 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr4836615lfb.435.1648150029811; Thu, 24
 Mar 2022 12:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name>
 <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de> <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
 <871qyr9t4e.fsf@toke.dk>
In-Reply-To: <871qyr9t4e.fsf@toke.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 Mar 2022 12:26:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
Message-ID: <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Netdev <netdev@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 stable <stable@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Halil Pasic <pasic@linux.ibm.com>, iommu <iommu@lists.linux-foundation.org>,
 Olha Cherevyk <olha.cherevyk@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Bizon <mbizon@freebox.fr>, Paolo Abeni <pabeni@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gVGh1LCBNYXIgMjQsIDIwMjIgYXQgMTA6MDcgQU0gVG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu
IDx0b2tlQHRva2UuZGs+IHdyb3RlOgo+Cj4gUmlnaHQsIGJ1dCBpcyB0aGF0IHN5bmNfZm9yX2Rl
dmljZSBjYWxsIHJlYWxseSBuZWVkZWQ/CgpXZWxsLCBpbWFnaW5lIHRoYXQgeW91IGhhdmUgYSBu
b24tY2FjaGUtY29oZXJlbnQgRE1BIChub3QgYm91bmNlCmJ1ZmZlcnMgLSBqdXN0IGJhZCBoYXJk
d2FyZSkuLi4KClNvIHRoZSBkcml2ZXIgZmlyc3QgZG9lcyB0aGF0IGRtYV9zeW5jX3NpbmdsZV9m
b3JfY3B1KCkgZm9yIHRoZSBDUFUKc2VlIHRoZSBjdXJyZW50IHN0YXRlIChmb3IgdGhlIG5vbi1j
YWNoZS1jb2hlcmVudCBjYXNlIGl0IHdvdWxkIGp1c3QKaW52YWxpZGF0ZSBjYWNoZXMpLgoKVGhl
IGRyaXZlciB0aGVuIGV4YW1pbmVzIHRoZSBjb21tYW5kIGJ1ZmZlciBzdGF0ZSwgc2VlcyB0aGF0
IGl0J3MKc3RpbGwgaW4gcHJvZ3Jlc3MsIGFuZCBkb2VzIHRoYXQgcmV0dXJuIC1FSU5QUk9HUkVT
Uy4KCkl0J3MgYWN0dWFsbHkgdmVyeSBuYXR1cmFsIGluIHRoYXQgc2l0dWF0aW9uIHRvIGZsdXNo
IHRoZSBjYWNoZXMgZnJvbQp0aGUgQ1BVIHNpZGUgYWdhaW4uIEFuZCBzbyBkbWFfc3luY19zaW5n
bGVfZm9yX2RldmljZSgpIGlzIGEgZmFpcmx5CnJlYXNvbmFibGUgdGhpbmcgdG8gZG8gaW4gdGhh
dCBzaXR1YXRpb24uCgpCdXQgaXQgZG9lc24ndCBzZWVtICpyZXF1aXJlZCosIG5vLiBUaGUgQ1BV
IGNhY2hlcyBvbmx5IGhhdmUgYSBjb3B5IG9mCnRoZSBkYXRhIGluIHRoZW0sIG5vIHdyaXRlYmFj
ayBuZWVkZWQgKGFuZCB3cml0ZWJhY2sgd291bGRuJ3Qgd29yawpzaW5jZSBETUEgZnJvbSB0aGUg
ZGV2aWNlIG1heSBiZSBpbiBwcm9ncmVzcykuCgpTbyBJIGRvbid0IHRoaW5rIHRoZSBkbWFfc3lu
Y19zaW5nbGVfZm9yX2RldmljZSgpIGlzICp3cm9uZyogcGVyIHNlLApiZWNhdXNlIHRoZSBDUFUg
ZGlkbid0IGFjdHVhbGx5IGRvIGFueSBtb2RpZmljYXRpb25zLgoKQnV0IHllcywgSSB0aGluayBp
dCdzIHVubmVjZXNzYXJ5IC0gYmVjYXVzZSBhbnkgbGF0ZXIgQ1BVIGFjY2Vzc2VzCndvdWxkIG5l
ZWQgdGhhdCBkbWFfc3luY19zaW5nbGVfZm9yX2NwdSgpIGFueXdheSwgd2hpY2ggc2hvdWxkCmlu
dmFsaWRhdGUgYW55IHN0YWxlIGNhY2hlcy4KCkFuZCBpdCBjbGVhcmx5IGRvZXNuJ3Qgd29yayBp
biBhIGJvdW5jZS1idWZmZXIgc2l0dWF0aW9uLCBidXQgaG9uZXN0bHkKSSBkb24ndCB0aGluayBh
ICJDUFUgbW9kaWZpZWQgYnVmZmVycyBjb25jdXJyZW50bHkgd2l0aCBETUEiIGNhbgoqZXZlciog
d29yayBpbiB0aGF0IHNpdHVhdGlvbiwgc28gSSB0aGluayBpdCdzIHdyb25nIGZvciBhIGJvdW5j
ZQpidWZmZXIgbW9kZWwgdG8gZXZlciBkbyBhbnl0aGluZyBpbiB0aGUgZG1hX3N5bmNfc2luZ2xl
X2Zvcl9kZXZpY2UoKQpzaXR1YXRpb24uCgpEb2VzIHJlbW92aW5nIHRoYXQgZG1hX3N5bmNfc2lu
Z2xlX2Zvcl9kZXZpY2UoKSBhY3R1YWxseSBmaXggdGhlCnByb2JsZW0gZm9yIHRoZSBhdGggZHJp
dmVyPwoKVGhlcmUncyBhIGZhaXIgbnVtYmVyIG9mIHRob3NlIGRtYV9zeW5jX3NpbmdsZV9mb3Jf
ZGV2aWNlKCkgdGhpbmdzIGFsbApvdmVyLiBDb3VsZCB3ZSBmaW5kIG1pcy11c2VzIGFuZCB3YXJu
IGFib3V0IHRoZW0gc29tZSB3YXk/IEl0IHNlZW1zIHRvCmJlIGEgdmVyeSBuYXR1cmFsIHRoaW5n
IHRvIGRvIGluIHRoaXMgY29udGV4dCwgYnV0IGJvdW5jZSBidWZmZXJpbmcKZG9lcyBtYWtlIHRo
ZW0gdmVyeSBmcmFnaWxlLgoKICAgICAgICAgICAgICAgICBMaW51cwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
