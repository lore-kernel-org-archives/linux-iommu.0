Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE9FC433FE
	for <iommu@archiver.kernel.org>; Wed, 24 Nov 2021 12:44:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 820FC4044D;
	Wed, 24 Nov 2021 12:44:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CU4wOnfORgno; Wed, 24 Nov 2021 12:44:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EA44A401C0;
	Wed, 24 Nov 2021 12:44:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C21C4C002E;
	Wed, 24 Nov 2021 12:44:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D58FDC0012
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 12:44:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B6D7E80D01
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 12:44:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z_YUBTiHQLAK for <iommu@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 12:44:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DDB4480CD8
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 12:44:44 +0000 (UTC)
Received: by mail-yb1-xb33.google.com with SMTP id v7so7070139ybq.0
 for <iommu@lists.linux-foundation.org>; Wed, 24 Nov 2021 04:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6YcgzZLwDUNcL02PHE9Uaenl/CwhsN1SwBv9B1Ruuzc=;
 b=eo3Rc02HwuWVktpOIxv+10QH9q901HbfiAdG925qhXSyAdU5Tpdm6+D2e55a67DWhJ
 zAXb/sN2oDHTRAncZ5KFNY+yw5oOT4J0yZMVDgUl+HN6HjR+Zb7olKXgmRfMsGLQyrBg
 u5XAg51I5akwR8REPC6Ux9GjZHA+l3+yULmXTWwJJ3TJzKGTh1bk92wu3iPadLuEwckb
 Alh9sQuApLdhl2b4zJ/sxeU8KP+Tmv3EloyPoB7WplvZ3pp7lvqvSWhPULsF35JWMtIi
 9p5epIEEXrS7JX+LAHKjDqIqYJ6/zagARF5ePSp3dVvVUir+cYQzZ/IWa+qi0wgBjQJb
 A0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6YcgzZLwDUNcL02PHE9Uaenl/CwhsN1SwBv9B1Ruuzc=;
 b=ZKO4Y/Vi01tfVKChOsOxhr/75pWMiVwe/sQIOWwvF3tonfXkUGx9YzKBJvrdiJGGT3
 eqnePevKBGNxKGpVg1bq8xCe1DiYVXrLe0ZR0VJQJb22IMHAWVxvgIzCAdA2TtOUtHvp
 sTHx2GziomZRUb51v3H1FfGmyHVx544oKLYtpC8UY+o9o+7d+Dyze7HAb+h2Ofjvpntf
 SHKKGASyECs5ZwJS6mwKxB9cPDglbR8cwWe7OVKGiVLL+DHQwMbo7+nIk0XmSGLwRZsY
 fWRVm9p7VuZLer8ULaxbdZ1umm9gjiecMmmjiF1U/h6qF5W3D1No9l1LkkLwQwlE48MK
 xddw==
X-Gm-Message-State: AOAM53170mDCxKbSrG6HhnK95g518tB79KKBcua9/CT2vsLyFgRsFem4
 vE9dMYZriq+EvtiJi2kI+ttuMZimcQgtvEhI0W0=
X-Google-Smtp-Source: ABdhPJysYTZnsf7KZmH2S6chrFbipTzxZtp2LIae4nRuHTZSh4Lg/2XMgNatlNQNMjW97PSDu9QTKTA1qcAgFyAK6VY=
X-Received: by 2002:a25:45:: with SMTP id 66mr18207748yba.464.1637757883804;
 Wed, 24 Nov 2021 04:44:43 -0800 (PST)
MIME-Version: 1.0
References: <20211124021325.858139-1-knaerzche@gmail.com>
 <2895944.ZOkXcVNkQQ@diego>
In-Reply-To: <2895944.ZOkXcVNkQQ@diego>
From: Peter Geis <pgwipeout@gmail.com>
Date: Wed, 24 Nov 2021 07:44:32 -0500
Message-ID: <CAMdYzYo=6H3NaBDZ2rQnDUr89rnA0rvxWGfEbRP6sQGt7+vB3w@mail.gmail.com>
Subject: Re: [PATCH] iommu/rockchip: Fix PAGE_DESC_HI_MASKs for RK3568
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Alex Bee <knaerzche@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 iommu <iommu@lists.linux-foundation.org>, Will Deacon <will@kernel.org>,
 arm-mail-list <linux-arm-kernel@lists.infradead.org>
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

T24gV2VkLCBOb3YgMjQsIDIwMjEgYXQgNTozNiBBTSBIZWlrbyBTdMO8Ym5lciA8aGVpa29Ac250
ZWNoLmRlPiB3cm90ZToKPgo+IEFtIE1pdHR3b2NoLCAyNC4gTm92ZW1iZXIgMjAyMSwgMDM6MTM6
MjUgQ0VUIHNjaHJpZWIgQWxleCBCZWU6Cj4gPiBXaXRoIHRoZSBzdWJtaXNzaW9uIG9mIGlvbW11
IGRyaXZlciBmb3IgUkszNTY4IGEgc3VidGxlIGJ1ZyB3YXMKPiA+IGludHJvZHVjZWQ6IFBBR0Vf
REVTQ19ISV9NQVNLMSBhbmQgUEFHRV9ERVNDX0hJX01BU0syIGhhdmUgdG8gYmUKPiA+IHRoZSBv
dGhlciB3YXkgYXJyb3VuZCAtIHRoYXQgbGVhZHMgdG8gcmFuZG9tIGVycm9ycywgZXNwZWNpYWxs
eSB3aGVuCj4gPiBhZGRyZXNzZXMgYmV5b25kIDMyIGJpdCBhcmUgdXNlZC4KPiA+Cj4gPiBGaXgg
aXQuCj4gPgo+ID4gRml4ZXM6IGM1NTM1NmM1MzRhYSAoImlvbW11OiByb2NrY2hpcDogQWRkIHN1
cHBvcnQgZm9yIGlvbW11IHYyIikKPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVlIDxrbmFlcnpj
aGVAZ21haWwuY29tPgo+ID4gLS0tCj4gPgo+ID4gSSd2ZSBmb3VuZCB0aGlzIGJ1Zywgd2hlbiB0
ZXN0aW5nIHRoZSByZWNlbnQgVk9QMiBzdWJtaXNzaW9uLCB3aGljaCBpcwo+ID4gdGhlIGZpcnN0
IHBlcnBoZXJpYWwgd2hpY2ggdXNlcyBpb21tdSBmb3IgUkszNTZ4LiBJIGNvdWxkIHVzZSBpdCBv
biBteQo+ID4gcXVhcnR6NjQgOEdCIGJvYXJkIG9ubHksIHdoZW4gbGltaXRpbmcgdGhlIGF2YWls
YWJsZSBtZW1vcnkgdG8gbGVzcyA0R0IuCj4gPgo+ID4gVGhpcyBwYXRjaCBmaXhlcyBpdC4KPiA+
Cj4gPiAgZHJpdmVycy9pb21tdS9yb2NrY2hpcC1pb21tdS5jIHwgNCArKy0tCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pb21tdS9yb2NrY2hpcC1pb21tdS5jIGIvZHJpdmVycy9pb21tdS9yb2Nr
Y2hpcC1pb21tdS5jCj4gPiBpbmRleCA1Y2IyNjA4MjBlZGEuLjdmMjNhZDYxYzA5NCAxMDA2NDQK
PiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvcm9ja2NoaXAtaW9tbXUuYwo+ID4gKysrIGIvZHJpdmVy
cy9pb21tdS9yb2NrY2hpcC1pb21tdS5jCj4gPiBAQCAtMjAwLDggKzIwMCw4IEBAIHN0YXRpYyBp
bmxpbmUgcGh5c19hZGRyX3QgcmtfZHRlX3B0X2FkZHJlc3ModTMyIGR0ZSkKPiA+ICAjZGVmaW5l
IERURV9ISV9NQVNLMiBHRU5NQVNLKDcsIDQpCj4gPiAgI2RlZmluZSBEVEVfSElfU0hJRlQxICAg
ICAgICAyNCAvKiBzaGlmdCBiaXQgOCB0byBiaXQgMzIgKi8KPiA+ICAjZGVmaW5lIERURV9ISV9T
SElGVDIgICAgICAgIDMyIC8qIHNoaWZ0IGJpdCA0IHRvIGJpdCAzNiAqLwo+ID4gLSNkZWZpbmUg
UEFHRV9ERVNDX0hJX01BU0sxICAgR0VOTUFTS19VTEwoMzksIDM2KQo+ID4gLSNkZWZpbmUgUEFH
RV9ERVNDX0hJX01BU0syICAgR0VOTUFTS19VTEwoMzUsIDMyKQo+ID4gKyNkZWZpbmUgUEFHRV9E
RVNDX0hJX01BU0sxICAgR0VOTUFTS19VTEwoMzUsIDMyKQo+ID4gKyNkZWZpbmUgUEFHRV9ERVND
X0hJX01BU0syICAgR0VOTUFTS19VTEwoMzksIDM2KQo+Cj4gV2l0aCB0aGlzIGNoYW5nZSB0aGUg
UEFHRV9ERVNDX0hJX01BU0sqIG5vdyBtYXRjaCB0aGUgb3RoZXIKPiBjb25zdGFudHMgYWJvdmUg
dGhlbSBpbiB3aGF0IGJpdHMgdGhleSBhY2Nlc3MsIHNvCj4KPiBSZXZpZXdlZC1ieTogSGVpa28g
U3R1ZWJuZXIgPGhlaWtvQHNudGVjaC5kZT4KPgo+CgpUZXN0ZWQgb24gdGhlIHF1YXJ0ejY0LWEg
Ym9hcmQgd2l0aCB0aGUgZXhwZXJpbWVudGFsIHZvcDIgZHJpdmVyLApjb25maXJtZWQgaXQgZml4
ZWQgdGhlIGlzc3VlLgoKVGVzdGVkLWJ5OiBQZXRlciBHZWlzIDxwZ3dpcGVvdXRAZ21haWwuY29t
PgoKPgo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+IExpbnV4LXJvY2tjaGlwIG1haWxpbmcgbGlzdAo+IExpbnV4LXJvY2tjaGlwQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LXJvY2tjaGlwCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
