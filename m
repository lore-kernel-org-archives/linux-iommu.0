Return-Path: <SRS0=XGcg=MI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF47C12002
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 12:53:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309B0613F7
	for <iommu@archiver.kernel.org>; Fri, 16 Jul 2021 12:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309B0613F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00B8160DBA;
	Fri, 16 Jul 2021 12:53:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uJMeTtSPk9mi; Fri, 16 Jul 2021 12:53:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D135D60586;
	Fri, 16 Jul 2021 12:53:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD08BC0010;
	Fri, 16 Jul 2021 12:53:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87A7EC000E
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 12:53:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7498B405C8
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 12:53:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u0lKVR1ETXrt for <iommu@lists.linux-foundation.org>;
 Fri, 16 Jul 2021 12:53:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F1C4540547
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 12:53:54 +0000 (UTC)
Received: by mail-lj1-x22d.google.com with SMTP id a6so13946551ljq.3
 for <iommu@lists.linux-foundation.org>; Fri, 16 Jul 2021 05:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qIXbeXJh4xnnEzuHiviZSGnyTwYzRolVv7/vAGelNEs=;
 b=q2rZp/6nSgaheqyIunCgxYXSuuGtsUM9Kxe6YSWEUSVa8m4HR9M550GEna0DbKCld4
 NFPhETlg88j3zKUvUNJDQOTs9OOrvzJ0Yw31Ft7lIDvZh46LIN8B/QDdymrB+R9kngdn
 iSMvIHQIPlRnh7vjcM0rRipTcoWTZJwTCricYH6j1WyYW9QfHw6qR35NAiyKmfiJbU4p
 B+YdqUrrl5oWJQr//Rlq8MFhObpPHhitazQ7PMXwAAYBHlTNyhcDe0mdAwmfbrYyviTv
 +msCwjHytPxKeR4FGfbgaX4epcky1MgE3ET35AyE9x2OEs1ysmWcNyKsAKwWIHDeX0Sl
 9qFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qIXbeXJh4xnnEzuHiviZSGnyTwYzRolVv7/vAGelNEs=;
 b=iUkkLQZm5WlFAoyFP16rIjcpbFiXVTVSIsBXwtbq6nEvpmuliqf4ZzwHxYrbi6otdg
 eywKbp8p1zXSkGkpP0wLUiow2rJrYO3+hWr/F1dSHH0idxV2jLhgh/L85zXh0cesxcJU
 B9NY9CB6hb0qyiJ6YmbLatj2RXcZccSVTdReh1IfKdPbQ73HgPHFoL+LX821HRjIZpKc
 jdN+3Agxj0F0bh+F0rjBo/lDoKhfRs5cunH4+IqJeSRqfCkpe5UKd/SDOO/FI50n+NR/
 r2I3usTJuN+0MtQzgiZ0t7NzpAvrjA7/cUgs874/mvy2MndI22Qgyn/7MchOQSnQlwg6
 5cNQ==
X-Gm-Message-State: AOAM533iMOGQjnECua6PRuVAr7A+Lf91zGBgmZW1N1bDWfWfAK09Lb1m
 t0XTH0mQUK+lLp/tSrlNNAlRcrm7jeeWZvA89Fs=
X-Google-Smtp-Source: ABdhPJz6XvfF9zHYInIIdr4DqTpU+AALXgxYTbgQHJoS1YdKtGx6AiJE1OQvdOZmYfk51pX27uPsiE/B8leffF7w82w=
X-Received: by 2002:a2e:b8cc:: with SMTP id s12mr9033565ljp.66.1626440032739; 
 Fri, 16 Jul 2021 05:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210715170011.GA17324@lst.de>
 <20210716083934.154992-1-rm.skakun@gmail.com>
 <20210716093551.GA17981@lst.de>
In-Reply-To: <20210716093551.GA17981@lst.de>
From: Roman Skakun <rm.skakun@gmail.com>
Date: Fri, 16 Jul 2021 15:53:41 +0300
Message-ID: <CADu_u-OYA+Z_y-DBLxyUYGhmLVMtLggmZ_SnRiEtw9EGrO4oGg@mail.gmail.com>
Subject: Re: [PATCH v2] dma-mapping: use vmalloc_to_page for vmalloc addresses
To: Christoph Hellwig <hch@lst.de>, Stefano Stabellini <sstabellini@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Andrii Anisov <andrii_anisov@epam.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 linux-kernel@vger.kernel.org, Roman Skakun <rm.skakun@gmail.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 iommu@lists.linux-foundation.org, Roman Skakun <Roman_Skakun@epam.com>,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>
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

PiBUZWNobmljYWxseSB0aGlzIGxvb2tzIGdvb2QuICBCdXQgZ2l2ZW4gdGhhdCBleHBvc2luZyBh
IGhlbHBlcgo+IHRoYXQgZG9lcyBlaXRoZXIgdm1hbGxvY190b19wYWdlIG9yIHZpcnRfdG9fcGFn
ZSBpcyBvbmUgb2YgdGhlCj4gbmV2ZXIgZW5kaW5nIE1NIGRpc2N1c3Npb25zIEkgZG9uJ3Qgd2Fu
dCB0byBnZXQgaW50byB0aGF0IGRpc2N1c3Npb24KPiBhbmQganVzdCBrZWVwIGl0IGxvY2FsIGlu
IHRoZSBETUEgY29kZS4KPgo+IEFyZSB5b3UgZmluZSB3aXRoIG1lIGFwcGx5aW5nIHRoaXMgdmVy
c2lvbj8KCkxvb2tzIGdvb2QgdG8gbWUsIHRoYW5rcyEKQnV0LCBTdGVmYW5vIGFza2VkIG1lIGFi
b3V0IHVzaW5nIGNyZWF0ZWQgaGVscGVyIGluIHRoZQp4ZW5fc3dpb3RsYl9mcmVlX2NvaGVyZW50
KCkKYW5kIEkgY3JlYXRlZCBhIHBhdGNoIGFjY29yZGluZyB0byB0aGlzIG1lbnRpb24uCgpXZSBj
YW4gbWVyZ2UgdGhpcyBwYXRjaCBhbmQgY3JlYXRlIGEgbmV3IG9uZSBmb3IKeGVuX3N3aW90bGJf
ZnJlZV9jb2hlcmVudCgpIGxhdGVyLgoK0L/RgiwgMTYg0LjRjtC7LiAyMDIxINCzLiDQsiAxMjoz
NSwgQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+Ogo+Cj4gVGVjaG5pY2FsbHkgdGhpcyBs
b29rcyBnb29kLiAgQnV0IGdpdmVuIHRoYXQgZXhwb3NpbmcgYSBoZWxwZXIKPiB0aGF0IGRvZXMg
ZWl0aGVyIHZtYWxsb2NfdG9fcGFnZSBvciB2aXJ0X3RvX3BhZ2UgaXMgb25lIG9mIHRoZQo+IG5l
dmVyIGVuZGluZyBNTSBkaXNjdXNzaW9ucyBJIGRvbid0IHdhbnQgdG8gZ2V0IGludG8gdGhhdCBk
aXNjdXNzaW9uCj4gYW5kIGp1c3Qga2VlcCBpdCBsb2NhbCBpbiB0aGUgRE1BIGNvZGUuCj4KPiBB
cmUgeW91IGZpbmUgd2l0aCBtZSBhcHBseWluZyB0aGlzIHZlcnNpb24/Cj4KPiAtLS0KPiBGcm9t
IDQwYWM5NzFlYWI4OTMzMGQ2MTUzZTc3MjFlODhhY2QyZDk4ODMzZjkgTW9uIFNlcCAxNyAwMDow
MDowMCAyMDAxCj4gRnJvbTogUm9tYW4gU2tha3VuIDxSb21hbl9Ta2FrdW5AZXBhbS5jb20+Cj4g
RGF0ZTogRnJpLCAxNiBKdWwgMjAyMSAxMTozOTozNCArMDMwMAo+IFN1YmplY3Q6IGRtYS1tYXBw
aW5nOiBoYW5kbGUgdm1hbGxvYyBhZGRyZXNzZXMgaW4KPiAgZG1hX2NvbW1vbl97bW1hcCxnZXRf
c2d0YWJsZX0KPgo+IHhlbi1zd2lvdGxiIGNhbiB1c2Ugdm1hbGxvYyBiYWNrZWQgYWRkcmVzc2Vz
IGZvciBkbWEgY29oZXJlbnQgYWxsb2NhdGlvbnMKPiBhbmQgdXNlcyB0aGUgY29tbW9uIGhlbHBl
cnMuICBQcm9wZXJseSBoYW5kbGUgdGhlbSB0byB1bmJyZWFrIFhlbiBvbgo+IEFSTSBwbGF0Zm9y
bXMuCj4KPiBGaXhlczogMWI2NWM0ZTVhOWFmICgic3dpb3RsYi14ZW46IHVzZSB4ZW5fYWxsb2Mv
ZnJlZV9jb2hlcmVudF9wYWdlcyIpCj4gU2lnbmVkLW9mZi1ieTogUm9tYW4gU2tha3VuIDxyb21h
bl9za2FrdW5AZXBhbS5jb20+Cj4gUmV2aWV3ZWQtYnk6IEFuZHJpaSBBbmlzb3YgPGFuZHJpaV9h
bmlzb3ZAZXBhbS5jb20+Cj4gW2hjaDogc3BsaXQgdGhlIHBhdGNoLCByZW5hbWVkIHRoZSBoZWxw
ZXJzXQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+IC0t
LQo+ICBrZXJuZWwvZG1hL29wc19oZWxwZXJzLmMgfCAxMiArKysrKysrKysrLS0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEva2VybmVsL2RtYS9vcHNfaGVscGVycy5jIGIva2VybmVsL2RtYS9vcHNfaGVscGVycy5jCj4g
aW5kZXggOTEwYWU2OWNhZTc3Li5hZjRhNmVmNDhjZTAgMTAwNjQ0Cj4gLS0tIGEva2VybmVsL2Rt
YS9vcHNfaGVscGVycy5jCj4gKysrIGIva2VybmVsL2RtYS9vcHNfaGVscGVycy5jCj4gQEAgLTUs
NiArNSwxMyBAQAo+ICAgKi8KPiAgI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXAtb3BzLmg+Cj4KPiAr
c3RhdGljIHN0cnVjdCBwYWdlICpkbWFfY29tbW9uX3ZhZGRyX3RvX3BhZ2Uodm9pZCAqY3B1X2Fk
ZHIpCj4gK3sKPiArICAgICAgIGlmIChpc192bWFsbG9jX2FkZHIoY3B1X2FkZHIpKQo+ICsgICAg
ICAgICAgICAgICByZXR1cm4gdm1hbGxvY190b19wYWdlKGNwdV9hZGRyKTsKPiArICAgICAgIHJl
dHVybiB2aXJ0X3RvX3BhZ2UoY3B1X2FkZHIpOwo+ICt9Cj4gKwo+ICAvKgo+ICAgKiBDcmVhdGUg
c2NhdHRlci1saXN0IGZvciB0aGUgYWxyZWFkeSBhbGxvY2F0ZWQgRE1BIGJ1ZmZlci4KPiAgICov
Cj4gQEAgLTEyLDcgKzE5LDcgQEAgaW50IGRtYV9jb21tb25fZ2V0X3NndGFibGUoc3RydWN0IGRl
dmljZSAqZGV2LCBzdHJ1Y3Qgc2dfdGFibGUgKnNndCwKPiAgICAgICAgICAgICAgICAgIHZvaWQg
KmNwdV9hZGRyLCBkbWFfYWRkcl90IGRtYV9hZGRyLCBzaXplX3Qgc2l6ZSwKPiAgICAgICAgICAg
ICAgICAgIHVuc2lnbmVkIGxvbmcgYXR0cnMpCj4gIHsKPiAtICAgICAgIHN0cnVjdCBwYWdlICpw
YWdlID0gdmlydF90b19wYWdlKGNwdV9hZGRyKTsKPiArICAgICAgIHN0cnVjdCBwYWdlICpwYWdl
ID0gZG1hX2NvbW1vbl92YWRkcl90b19wYWdlKGNwdV9hZGRyKTsKPiAgICAgICAgIGludCByZXQ7
Cj4KPiAgICAgICAgIHJldCA9IHNnX2FsbG9jX3RhYmxlKHNndCwgMSwgR0ZQX0tFUk5FTCk7Cj4g
QEAgLTMyLDYgKzM5LDcgQEAgaW50IGRtYV9jb21tb25fbW1hcChzdHJ1Y3QgZGV2aWNlICpkZXYs
IHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLAo+ICAgICAgICAgdW5zaWduZWQgbG9uZyB1c2Vy
X2NvdW50ID0gdm1hX3BhZ2VzKHZtYSk7Cj4gICAgICAgICB1bnNpZ25lZCBsb25nIGNvdW50ID0g
UEFHRV9BTElHTihzaXplKSA+PiBQQUdFX1NISUZUOwo+ICAgICAgICAgdW5zaWduZWQgbG9uZyBv
ZmYgPSB2bWEtPnZtX3Bnb2ZmOwo+ICsgICAgICAgc3RydWN0IHBhZ2UgKnBhZ2UgPSBkbWFfY29t
bW9uX3ZhZGRyX3RvX3BhZ2UoY3B1X2FkZHIpOwo+ICAgICAgICAgaW50IHJldCA9IC1FTlhJTzsK
Pgo+ICAgICAgICAgdm1hLT52bV9wYWdlX3Byb3QgPSBkbWFfcGdwcm90KGRldiwgdm1hLT52bV9w
YWdlX3Byb3QsIGF0dHJzKTsKPiBAQCAtNDMsNyArNTEsNyBAQCBpbnQgZG1hX2NvbW1vbl9tbWFw
KHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsCj4gICAgICAg
ICAgICAgICAgIHJldHVybiAtRU5YSU87Cj4KPiAgICAgICAgIHJldHVybiByZW1hcF9wZm5fcmFu
Z2Uodm1hLCB2bWEtPnZtX3N0YXJ0LAo+IC0gICAgICAgICAgICAgICAgICAgICAgIHBhZ2VfdG9f
cGZuKHZpcnRfdG9fcGFnZShjcHVfYWRkcikpICsgdm1hLT52bV9wZ29mZiwKPiArICAgICAgICAg
ICAgICAgICAgICAgICBwYWdlX3RvX3BmbihwYWdlKSArIHZtYS0+dm1fcGdvZmYsCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgdXNlcl9jb3VudCA8PCBQQUdFX1NISUZULCB2bWEtPnZtX3BhZ2Vf
cHJvdCk7Cj4gICNlbHNlCj4gICAgICAgICByZXR1cm4gLUVOWElPOwo+IC0tCj4gMi4zMC4yCj4K
CgotLSAKQmVzdCBSZWdhcmRzLCBSb21hbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2lvbW11
