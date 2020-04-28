Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04F7C83001
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 15:14:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93FC2206D7
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 15:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlHwcr3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FC2206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6675422812;
	Tue, 28 Apr 2020 15:14:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZuFKggpJ-DcT; Tue, 28 Apr 2020 15:14:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1B4E820462;
	Tue, 28 Apr 2020 15:14:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D8E9C0863;
	Tue, 28 Apr 2020 15:14:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2A8BC0172
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 15:14:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8B5F7227B1
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 15:14:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FBoS4YPIuZkg for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 15:14:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 4F5DA20462
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 15:14:44 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id x4so3218732wmj.1
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 08:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=l31iHzi+Qs0wCkNpZUkmQ43l/0Uer53q54jbPNk9/tA=;
 b=KlHwcr3gTyxBlExVYMYEDezxp2MypKFK+c6Ao/6WCZFEdvxM87IzFhahTJWpvBuNZM
 cFsfktXWaoRij0YPRZs+CfSAAapta3x5PTjTct9nKzkeYlY/uKwbfbgFnN7gjjy2NYs8
 oeXIVDldzCGpa4IeFQvUz5qM0thtnyU+gBnAqzy88i4+rnZ7PFIvhnjWZjEFzSIO0kbL
 p0p19jj+iD6Xh5Tg8gXjuda6JrLj+r8F56iRtpn0tm/B5pquPdIB0hA4jaipWC68ssNv
 HlJNAQ+DAB1ZQ2u1gjAfaSG5//xbPSnz+CTuBZi+htDjig8onvuhS9nFWJ1tLfXTRyp2
 zKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=l31iHzi+Qs0wCkNpZUkmQ43l/0Uer53q54jbPNk9/tA=;
 b=d7zhfXW4QhtgTQep5QLiupNpqF6cT9CBPYwfK8xMaCsGrXvAau6JZINu8ZIgsl+OC7
 LkrbXjg27s3f5j4uy8gY2UOCvr14QhO8TmLke8GeEcaaGgGR5mDH7DlvR5EM746FrNmM
 gzDW5im23BJl6ovTqqzC9O3aj9ywdePzLWw39idNmAKZAAyp0xBqM3g5T8SJG1oVMyQp
 nKqsC6r0qvKxjm2Ic6AyNn5TXOZqTdno6di61xpZuxV22jTgpktuk7H/KPSavhcD7CXO
 yO9zmCczuUgVsDD2+hplrZNT9WvuuOjs0TDz7uwZN2tK2RmUvJKU/GgcW6D5lLWzj5fe
 ge/A==
X-Gm-Message-State: AGi0PuYpa1oh3+kcv6UCkB0m2LayzfauLfI8INwf2f5GEph65wQPz7x/
 ggOIqJgYvh3polMN4/Xo1xg=
X-Google-Smtp-Source: APiQypL8H3EcxyO7rOvNQpM8a9StjgW5VyI7nmqOUuAgjrQlknQi+ypDm7LmhWDvCqyCCbM8wblpgQ==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr4857338wmi.182.1588086882730; 
 Tue, 28 Apr 2020 08:14:42 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id s8sm25807970wru.38.2020.04.28.08.14.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 28 Apr 2020 08:14:42 -0700 (PDT)
Subject: Re: [RFC 02/17] drm: amdgpu: fix sg_table nents vs. orig_nents misuse
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20200428132005.21424-1-m.szyprowski@samsung.com>
 <CGME20200428132023eucas1p2a1993145eef91506698aa8c9750a7e43@eucas1p2.samsung.com>
 <20200428132005.21424-3-m.szyprowski@samsung.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c462d1f0-8daa-76bb-a7fd-5e0d687975d5@gmail.com>
Date: Tue, 28 Apr 2020 17:14:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200428132005.21424-3-m.szyprowski@samsung.com>
Content-Language: en-US
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Sumit Semwal <sumit.semwal@linaro.org>,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

QW0gMjguMDQuMjAgdW0gMTU6MTkgc2NocmllYiBNYXJlayBTenlwcm93c2tpOgo+IFRoZSBEb2N1
bWVudGF0aW9uL0RNQS1BUEktSE9XVE8udHh0IHN0YXRlcyB0aGF0IGRtYV9tYXBfc2cgcmV0dXJu
cyB0aGUKPiBudW1lciBvZiB0aGUgY3JlYXRlZCBlbnRyaWVzIGluIHRoZSBETUEgYWRkcmVzcyBz
cGFjZS4gSG93ZXZlciB0aGUKPiBzdWJzZXF1ZW50IGNhbGxzIHRvIGRtYV9zeW5jX3NnX2Zvcl97
ZGV2aWNlLGNwdX0gYW5kIGRtYV91bm1hcF9zZyBtdXN0IGJlCj4gY2FsbGVkIHdpdGggdGhlIG9y
aWdpbmFsIG51bWJlciBvZiBlbnRyaWVzIHBhc3NlZCB0byBkbWFfbWFwX3NnLiBUaGUKPiBzZ190
YWJsZS0+bmVudHMgaW4gdHVybiBob2xkcyB0aGUgcmVzdWx0IG9mIHRoZSBkbWFfbWFwX3NnIGNh
bGwgYXMgc3RhdGVkCj4gaW4gaW5jbHVkZS9saW51eC9zY2F0dGVybGlzdC5oLiBBZGFwdCB0aGUg
Y29kZSB0byBvYmV5IHRob3NlIHJ1bGVzLgo+Cj4gU2lnbmVkLW9mZi1ieTogTWFyZWsgU3p5cHJv
d3NraSA8bS5zenlwcm93c2tpQHNhbXN1bmcuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5jIHwgNyArKysrLS0tCj4gICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgICAgIHwgOCArKysrLS0tLQo+ICAgMiBmaWxl
cyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMKPiBpbmRleCA0M2Q4ZWQ3Li40ZGY4
MTNlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFf
YnVmLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5j
Cj4gQEAgLTMwNyw4ICszMDcsOSBAQCBzdGF0aWMgc3RydWN0IHNnX3RhYmxlICphbWRncHVfZG1h
X2J1Zl9tYXAoc3RydWN0IGRtYV9idWZfYXR0YWNobWVudCAqYXR0YWNoLAo+ICAgCQlpZiAoSVNf
RVJSKHNndCkpCj4gICAJCQlyZXR1cm4gc2d0Owo+ICAgCj4gLQkJaWYgKCFkbWFfbWFwX3NnX2F0
dHJzKGF0dGFjaC0+ZGV2LCBzZ3QtPnNnbCwgc2d0LT5uZW50cywgZGlyLAo+IC0JCQkJICAgICAg
RE1BX0FUVFJfU0tJUF9DUFVfU1lOQykpCj4gKwkJc2d0LT5uZW50cyA9IGRtYV9tYXBfc2dfYXR0
cnMoYXR0YWNoLT5kZXYsIHNndC0+c2dsLCBzZ3QtPm9yaWdfbmVudHMsCj4gKwkJCQkJICAgICAg
ZGlyLCBETUFfQVRUUl9TS0lQX0NQVV9TWU5DKTsKPiArCQlpZiAoIXNndC0+bmVudHMpCj4gICAJ
CQlnb3RvIGVycm9yX2ZyZWU7Cj4gICAJCWJyZWFrOwo+ICAgCj4gQEAgLTM0OSw3ICszNTAsNyBA
QCBzdGF0aWMgdm9pZCBhbWRncHVfZG1hX2J1Zl91bm1hcChzdHJ1Y3QgZG1hX2J1Zl9hdHRhY2ht
ZW50ICphdHRhY2gsCj4gICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBhbWRncHVfdHRt
X2FkZXYoYm8tPnRiby5iZGV2KTsKPiAgIAo+ICAgCWlmIChzZ3QtPnNnbC0+cGFnZV9saW5rKSB7
Cj4gLQkJZG1hX3VubWFwX3NnKGF0dGFjaC0+ZGV2LCBzZ3QtPnNnbCwgc2d0LT5uZW50cywgZGly
KTsKPiArCQlkbWFfdW5tYXBfc2coYXR0YWNoLT5kZXYsIHNndC0+c2dsLCBzZ3QtPm9yaWdfbmVu
dHMsIGRpcik7Cj4gICAJCXNnX2ZyZWVfdGFibGUoc2d0KTsKPiAgIAkJa2ZyZWUoc2d0KTsKPiAg
IAl9IGVsc2Ugewo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiBpbmRl
eCBkNTU0M2MyLi41ZjMxNTg1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90dG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV90dG0uYwo+IEBAIC0xMDQzLDcgKzEwNDMsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV90dG1fdHRf
cGluX3VzZXJwdHIoc3RydWN0IHR0bV90dCAqdHRtKQo+ICAgewo+ICAgCXN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2ID0gYW1kZ3B1X3R0bV9hZGV2KHR0bS0+YmRldik7Cj4gICAJc3RydWN0IGFt
ZGdwdV90dG1fdHQgKmd0dCA9ICh2b2lkICopdHRtOwo+IC0JdW5zaWduZWQgbmVudHM7Cj4gICAJ
aW50IHI7Cj4gICAKPiAgIAlpbnQgd3JpdGUgPSAhKGd0dC0+dXNlcmZsYWdzICYgQU1ER1BVX0dF
TV9VU0VSUFRSX1JFQURPTkxZKTsKPiBAQCAtMTA1OSw4ICsxMDU4LDkgQEAgc3RhdGljIGludCBh
bWRncHVfdHRtX3R0X3Bpbl91c2VycHRyKHN0cnVjdCB0dG1fdHQgKnR0bSkKPiAgIAo+ICAgCS8q
IE1hcCBTRyB0byBkZXZpY2UgKi8KPiAgIAlyID0gLUVOT01FTTsKPiAtCW5lbnRzID0gZG1hX21h
cF9zZyhhZGV2LT5kZXYsIHR0bS0+c2ctPnNnbCwgdHRtLT5zZy0+bmVudHMsIGRpcmVjdGlvbik7
Cj4gLQlpZiAobmVudHMgPT0gMCkKPiArCXR0bS0+c2ctPm5lbnRzID0gZG1hX21hcF9zZyhhZGV2
LT5kZXYsIHR0bS0+c2ctPnNnbCwKPiArCQkJCSAgICB0dG0tPnNnLT5vcmlnX25lbnRzLCBkaXJl
Y3Rpb24pOwo+ICsJaWYgKHR0bS0+c2ctPm5lbnRzID09IDApCj4gICAJCWdvdG8gcmVsZWFzZV9z
ZzsKPiAgIAo+ICAgCS8qIGNvbnZlcnQgU0cgdG8gbGluZWFyIGFycmF5IG9mIHBhZ2VzIGFuZCBk
bWEgYWRkcmVzc2VzICovCj4gQEAgLTEwOTEsNyArMTA5MSw3IEBAIHN0YXRpYyB2b2lkIGFtZGdw
dV90dG1fdHRfdW5waW5fdXNlcnB0cihzdHJ1Y3QgdHRtX3R0ICp0dG0pCj4gICAJCXJldHVybjsK
PiAgIAo+ICAgCS8qIHVubWFwIHRoZSBwYWdlcyBtYXBwZWQgdG8gdGhlIGRldmljZSAqLwo+IC0J
ZG1hX3VubWFwX3NnKGFkZXYtPmRldiwgdHRtLT5zZy0+c2dsLCB0dG0tPnNnLT5uZW50cywgZGly
ZWN0aW9uKTsKPiArCWRtYV91bm1hcF9zZyhhZGV2LT5kZXYsIHR0bS0+c2ctPnNnbCwgdHRtLT5z
Zy0+b3JpZ19uZW50cywgZGlyZWN0aW9uKTsKPiAgIAo+ICAgCXNnX2ZyZWVfdGFibGUodHRtLT5z
Zyk7Cj4gICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
