Return-Path: <SRS0=dGrv=MV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A257CC432BE
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 10:17:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4338260E09
	for <iommu@archiver.kernel.org>; Thu, 29 Jul 2021 10:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4338260E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0972D40025;
	Thu, 29 Jul 2021 10:17:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YHRCJQdQiMa6; Thu, 29 Jul 2021 10:17:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5500C400D8;
	Thu, 29 Jul 2021 10:17:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E551C001A;
	Thu, 29 Jul 2021 10:17:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2EF8C000E
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 10:17:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CCA7440025
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 10:17:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SJQA1U-qRRcb for <iommu@lists.linux-foundation.org>;
 Thu, 29 Jul 2021 10:17:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E3FA400D8
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 10:17:22 +0000 (UTC)
Received: by mail-lf1-x12f.google.com with SMTP id y34so9983174lfa.8
 for <iommu@lists.linux-foundation.org>; Thu, 29 Jul 2021 03:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kXIpgpDKWbPbcNkG2dNNt5Cm/6h4seJQ12NmUxex3VI=;
 b=ixDe9DEzvJT3GNrG6sd8nZ0dMqhEBzRdvDa2qi1gcvZPMQuLiyUYGrBZkHMiYzDc4q
 MVK00Tch8pEyNp5CCkOL2juHmsHHMj/mGQ/r+yTIJy3ayEVmx9PrGDNjvybuMw6p0kAI
 KkALVoLLgisef8ftDy3kY+lF8dp4ec9xJs8ULTVhYu6kT93lxPnmH8kyRkqv0+b5CqxF
 Oll6V/zPYc2xFDbtBUsdC2cfW8Swe7F53sKGiESCTI+tgVnV3Ko3XTz6s6lbzEdCIfwN
 l3pxNMoUzl9ibAd9b7uxw5gc78FJK3uyfWVRMwaZS9VmWI8+x7cni/PHCcdvqmGE7B2M
 QpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kXIpgpDKWbPbcNkG2dNNt5Cm/6h4seJQ12NmUxex3VI=;
 b=iBbmlIRP9n6iIq37IDHSE08UWBlbd11vLktSNJM6YouEkt4nO7tGH8ImNUyMQSmh5X
 G4m6s6ZeGBkH6Qg6RfeWVAO0f1QHVuR7EGGxIqbHewDmBiURJU6Nf8GLaga0xR8v1LKL
 fe+iW/ioDCB7OYF9pRt7QGCZhYdN5GHec3sYms0gz89ELyoL0hnvN6MWkTRyvHczJ+8c
 aHyK+tzk/CBRAIPbogJj+bHa8IOvVKYlNckR9ZWcr9bj0ehuB3PPrDa3gRsm0Wg2o4CC
 yh70xLm1FYWp3XkiAmb/ro0mM1ccHCh8GQKXuMe3R4qDQi9QjXo1TWXAf3tykrmPvbSA
 FAvw==
X-Gm-Message-State: AOAM530BmpEgJh+SbYwXz6xXME6CTfuXVtr5Z3LDKFcRFnTDtwqa7hSK
 PX3Qlp112Yh8ka21k2R1Y2wT/yMRDLDAo2JpPac=
X-Google-Smtp-Source: ABdhPJxOC4twswUSAFRe3iPHlwAeCnVaeZ0RUAwFCHfdasp6unUrsj1RSp870lwZLb8qEPCJX8Vb9ioXQMptGuXCAgM=
X-Received: by 2002:a05:6512:321c:: with SMTP id
 d28mr3190353lfe.203.1627553840300; 
 Thu, 29 Jul 2021 03:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <YPz+qQ6dbZVDbMwu@infradead.org>
 <CAHk-=wi2OMmUkZFdQ0=uYmGeC3sv3eYw-p1=d51pJS-XVKaM2A@mail.gmail.com>
 <957943ce-c50e-1560-6f1b-aea0a1c9a114@oracle.com>
 <alpine.DEB.2.21.2107261212500.10122@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.2107261212500.10122@sstabellini-ThinkPad-T480s>
From: Roman Skakun <rm.skakun@gmail.com>
Date: Thu, 29 Jul 2021 13:17:09 +0300
Message-ID: <CADu_u-OG0pMQN_nD5ayYOmNRWDn1VSPT05s5ddSQkoemYf_Sew@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping fix for Linux 5.14
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Roman Skakun <rm.skakun@epam.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 iommu <iommu@lists.linux-foundation.org>, Roman Skakun <roman_skakun@epam.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
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

SGksIFN0ZWZhbm8hCgo+IEkgZG9uJ3Qga25vdyBvbiB3aGljaCBwbGF0Zm9ybSBSb21hbiBTa2Fr
dW4gKENDJ2VkKSBmb3VuZCB0aGUgcHJvYmxlbS4KPiBCdXQgaWYgd2UgbG9vayBhdCBhcmNoL2Fy
bS9tbS9kbWEtbWFwcGluZy5jOl9fZG1hX2FsbG9jLCBvbmUgb2YgdGhlCj4gcG9zc2libGUgb3B0
aW9ucyBpcyB0aGUgInJlbWFwX2FsbG9jYXRvciIsIHdoaWNoIGNhbGxzCj4gX19hbGxvY19yZW1h
cF9idWZmZXIsIHdoaWNoIGNhbGxzIGRtYV9jb21tb25fY29udGlndW91c19yZW1hcCwgd2hpY2gK
PiBjYWxscyB2bWFwLgoKVXNpbmcgIFJlbmVzYXMgUi1jYXIgSDMgcGxhdGZvcm0uCkkgaGF2ZSB0
ZXN0ZWQgdGhpcyBjYXNlIG9uIDE6MSBkb20wIHdpdGggPCA0R0IgbWVtb3J5LCBidXQgdGhpcyBj
YXNlCnN0aWxsIGV4aXN0cy4KSSdtIHN0aWxsIHdvbmRlcmluZyB3aHkgeGVuLXN3aW90bGIgbWFw
cGVkIHZtYWxsb2MnZWQgYWRkcmVzc2VzIGZvcgpsb3cgbWVtb3J5IERNQSBhZGRyZXNzZXMuCgrQ
v9C9LCAyNiDQuNGO0LsuIDIwMjEg0LMuINCyIDIzOjAzLCBTdGVmYW5vIFN0YWJlbGxpbmkgPHNz
dGFiZWxsaW5pQGtlcm5lbC5vcmc+Ogo+Cj4gT24gTW9uLCAyNiBKdWwgMjAyMSwgQm9yaXMgT3N0
cm92c2t5IHdyb3RlOgo+ID4gT24gNy8yNS8yMSAxMjo1MCBQTSwgTGludXMgVG9ydmFsZHMgd3Jv
dGU6Cj4gPiA+IE9uIFNhdCwgSnVsIDI0LCAyMDIxIGF0IDExOjAzIFBNIENocmlzdG9waCBIZWxs
d2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4gd3JvdGU6Cj4gPiA+Cj4gPiA+PiAgIC0gaGFuZGxlIHZt
YWxsb2MgYWRkcmVzc2VzIGluIGRtYV9jb21tb25fe21tYXAsZ2V0X3NndGFibGV9Cj4gPiA+PiAg
ICAgKFJvbWFuIFNrYWt1bikKPiA+ID4gSSd2ZSBwdWxsZWQgdGhpcywgYnV0IG15IHJlYWN0aW9u
IGlzIHRoYXQgd2UndmUgdHJpZWQgdG8gYXZvaWQgdGhpcyBpbgo+ID4gPiB0aGUgcGFzdC4gV2h5
IGlzIFhlbiB1c2luZyB2bWFsbG9jJ2VkIGFkZHJlc3NlcyBhbmQgcGFzc2luZyB0aG9zZSBpbgo+
ID4gPiB0byB0aGUgZG1hIG1hcHBpbmcgcm91dGluZXM/Cj4gPiA+Cj4gPiA+IEl0ICpzbWVsbHMq
IHRvIG1lIGxpa2UgYSBYZW4tc3dpb3RsYiBidWcsIGFuZCBpdCB3b3VsZCBoYXZlIGJlZW4KPiA+
ID4gYmV0dGVyIHRvIHRyeSB0byBmaXggaXQgdGhlcmUuIFdhcyB0aGF0IGp1c3QgdG9vIHBhaW5m
dWw/Cj4gPgo+ID4KPiA+IFN0ZWZhbm8gd2lsbCBwcm9iYWJseSBrbm93IGJldHRlciBidXQgdGhp
cyBhcHBlYXJzIHRvIGhhdmUgc29tZXRoaW5nIHRvIGRvIHdpdGggaG93IFBpIChhbmQgcG9zc2li
bHkgbW9yZSBBUk0gc3lzdGVtcz8pIG1hbmFnZSBETUEgbWVtb3J5OiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy94ZW4tZGV2ZWwvQ0FEel9XRDVMbjdQZTFXQUZwNzNkMk16OXd4c3B6VEUzV2dBSnVz
cDVTOExYND04M0J3QG1haWwuZ21haWwuY29tLy4KPgo+IFRoZSBvcmlnaW5hbCBpc3N1ZSB3YXMg
Zm91bmQgb24gdGhlIFJhc3BiZXJyeSBQaSA0LCBhbmQgdGhlIGZpeCB3YXMgaW4KPiBzd2lvdGxi
LXhlbi5jLCBjb21taXQgOGIxZTg2OGY2LiBNb3JlIHJlY2VudGx5LCBSb21hbiByZWFsaXplZCB0
aGF0Cj4gZG1hX2NvbW1vbl9tbWFwIG1pZ2h0IGFsc28gZW5kIHVwIGNhbGxpbmcgdmlydF90b19w
YWdlIG9uIGEgdm1hbGxvYwo+IGFkZHJlc3MuIFRoaXMgaXMgdGhlIGZpeCBmb3IgdGhhdC4KPgo+
Cj4gV2h5IGlzIFhlbiB1c2luZyB2bWFsbG9jJ2VkIGFkZHJlc3NlcyB3aXRoIGRtYSByb3V0aW5l
cyBhdCBhbGw/Cj4KPiBYZW4gaXMgYWN0dWFsbHkganVzdCBjYWxsaW5nIHRoZSByZWd1bGFyIGRt
YV9kaXJlY3RfYWxsb2MgdG8gYWxsb2NhdGUKPiBwYWdlcyAoeGVuX3N3aW90bGJfYWxsb2NfY29o
ZXJlbnQgLT4geGVuX2FsbG9jX2NvaGVyZW50X3BhZ2VzIC0+Cj4gZG1hX2RpcmVjdF9hbGxvYyku
IGRtYV9kaXJlY3RfYWxsb2MgaXMgdGhlIGdlbmVyaWMgaW1wbGVtZW50YXRpb24uIEJhY2sKPiB3
aGVuIHRoZSBvcmlnaW5hbCBpc3N1ZSB3YXMgZm91bmQsIGRtYV9kaXJlY3RfYWxsb2MgcmV0dXJu
ZWQgYSB2bWFsbG9jCj4gYWRkcmVzcyBvbiBSUGk0Lgo+Cj4gVGhlIG9yaWdpbmFsIGFuYWx5c2lz
IHdhcyAieGVuX2FsbG9jX2NvaGVyZW50X3BhZ2VzKCkgZXZlbnR1YWxseSBjYWxscwo+IGFyY2hf
ZG1hX2FsbG9jKCkgaW4gcmVtYXAuYyB3aGljaCBzdWNjZXNzZnVsbHkgYWxsb2NhdGVzIHBhZ2Vz
IGZyb20KPiBhdG9taWMgcG9vbC4iIFNlZSBodHRwczovL21hcmMuaW5mby8/bD14ZW4tZGV2ZWwm
bT0xNTg4NzgxNzMyMDc3NzUuCj4KPgo+IEkgZG9uJ3Qga25vdyBvbiB3aGljaCBwbGF0Zm9ybSBS
b21hbiBTa2FrdW4gKENDJ2VkKSBmb3VuZCB0aGUgcHJvYmxlbS4KPiBCdXQgaWYgd2UgbG9vayBh
dCBhcmNoL2FybS9tbS9kbWEtbWFwcGluZy5jOl9fZG1hX2FsbG9jLCBvbmUgb2YgdGhlCj4gcG9z
c2libGUgb3B0aW9ucyBpcyB0aGUgInJlbWFwX2FsbG9jYXRvciIsIHdoaWNoIGNhbGxzCj4gX19h
bGxvY19yZW1hcF9idWZmZXIsIHdoaWNoIGNhbGxzIGRtYV9jb21tb25fY29udGlndW91c19yZW1h
cCwgd2hpY2gKPiBjYWxscyB2bWFwLgo+Cj4gU28gdW5mb3J0dW5hdGVseSBpdCBzZWVtcyB0aGF0
IG9uIGNlcnRhaW4gYXJjaC9wbGF0Zm9ybXMKPiBkbWFfYWxsb2NfY29oZXJlbnQgY2FuIHJldHVy
biBhIHZtYXAnZWQgYWRkcmVzcy4gU28gSSB3b3VsZCBpbWFnaW5lIHRoaXMKPiBpc3N1ZSBjb3Vs
ZCBhbHNvIGhhcHBlbiBvbiBuYXRpdmUgKHdpdGhvdXQgWGVuKSwgYXQgbGVhc3QgaW4gdGhlb3J5
LgoKCgotLSAKQmVzdCBSZWdhcmRzLCBSb21hbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
