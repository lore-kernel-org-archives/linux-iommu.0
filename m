Return-Path: <SRS0=4dF3=NP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C627C4320E
	for <iommu@archiver.kernel.org>; Tue, 24 Aug 2021 13:25:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A874161058
	for <iommu@archiver.kernel.org>; Tue, 24 Aug 2021 13:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A874161058
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 77E9280DD6;
	Tue, 24 Aug 2021 13:25:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N1Igj-oAI72q; Tue, 24 Aug 2021 13:25:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4BDB580CE6;
	Tue, 24 Aug 2021 13:25:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27C55C0010;
	Tue, 24 Aug 2021 13:25:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E0CAC000E
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 13:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6EDEA40183
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 13:25:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QvqieqJ3dMn4 for <iommu@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 13:25:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com
 [209.85.222.44])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3BA46400BE
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 13:25:51 +0000 (UTC)
Received: by mail-ua1-f44.google.com with SMTP id l24so6099812uai.1
 for <iommu@lists.linux-foundation.org>; Tue, 24 Aug 2021 06:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=syaKgflsTsKksibAkkBHSqJs9/gSQgOP1HHJcM5Pues=;
 b=ASHuA2QQ69Wl/F+auQh1lnqudAYJy4wTXl8/qp8hXnN/6ChCcIfNyYgMsfDNcAxm68
 I7YR78ZeKauPWbOmbh/JOdjXSrduvFVT9q7pK0w0FTY2O8g3TOwYWytEg4F/RRiQL1fD
 meSIrpQ7OvWcNxSp21ulGbjS8Wn53vjxzxfS5fL/V8LDadpKHX7YGR2y/YNObRT9vvM5
 UHsz3xkfbBFcg8u7LHmsv+ko7cYFVLmBmXNccb8HKNob7n91v1qF+5x+UC37sOV8iT6t
 qsxzfpsZ3SXQQoMrrHqUCO0xWjVxFVmQjpXHHbNN41TysnqCmgnl6ofX+L/eY59SDR+0
 T19w==
X-Gm-Message-State: AOAM5315WykO7eAUtsclA5SAXYSJKXHDSMhr45OstbFdzQbDU0SbztyI
 JOMNIzuwf8egUyNlchcoW1uuFGhdV5YUCFUqahg=
X-Google-Smtp-Source: ABdhPJxREVGG1KSJjSDtkir6RHgR3j1Fua2WWCBDp0vkLxgAKtEdCnz3EEW+Wiu0VV+kqymGJpveE5LwOep3+HjphiA=
X-Received: by 2002:a67:6e86:: with SMTP id j128mr27277219vsc.26.1629811550108; 
 Tue, 24 Aug 2021 06:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1628682048.git.robin.murphy@arm.com>
 <155b5c621cd8936472e273a8b07a182f62c6c20d.1628682049.git.robin.murphy@arm.com>
In-Reply-To: <155b5c621cd8936472e273a8b07a182f62c6c20d.1628682049.git.robin.murphy@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Aug 2021 15:25:38 +0200
Message-ID: <CAMuHMdX+VSr0TJabMBNqob0MkD2o0RBNp8E5QYNx0jFucW1Aew@mail.gmail.com>
Subject: Re: [PATCH v4 15/24] iommu/io-pgtable: Remove non-strict quirk
To: Robin Murphy <robin.murphy@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Doug Anderson <dianders@chromium.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, rajatja@google.com,
 Will Deacon <will@kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

SGkgUm9iaW4sCgpPbiBXZWQsIEF1ZyAxMSwgMjAyMSBhdCAyOjI0IFBNIFJvYmluIE11cnBoeSA8
cm9iaW4ubXVycGh5QGFybS5jb20+IHdyb3RlOgo+IElPX1BHVEFCTEVfUVVJUktfTk9OX1NUUklD
VCB3YXMgbmV2ZXIgYSB2ZXJ5IGNvbWZvcnRhYmxlIGZpdCwgc2luY2UgaXQncwo+IG5vdCBhIHF1
aXJrIG9mIHRoZSBwYWdldGFibGUgZm9ybWF0IGl0c2VsZi4gTm93IHRoYXQgd2UgaGF2ZSBhIG1v
cmUKPiBhcHByb3ByaWF0ZSB3YXkgdG8gY29udmV5IG5vbi1zdHJpY3QgdW5tYXBzLCB0aG91Z2gs
IHRoaXMgbGFzdCBvZiB0aGUKPiBub24tcXVpcmsgcXVpcmtzIGNhbiBhbHNvIGdvLCBhbmQgd2l0
aCB0aGUgZmx1c2ggcXVldWUgY29kZSBhbHNvIG5vdwo+IGVuZm9yY2luZyBpdHMgb3duIG9yZGVy
aW5nIHdlIGNhbiBoYXZlIGEgbG92ZWx5IGNsZWFudXAgYWxsIHJvdW5kLgo+Cj4gU2lnbmVkLW9m
Zi1ieTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4KClRoYW5rcyBmb3IgeW91
ciBwYXRjaCwgd2hpY2ggaXMgbm93IGNvbW1pdCBhOGU1ZjA0NDU4YzRlNDk2CigiaW9tbXUvaW8t
cGd0YWJsZTogUmVtb3ZlIG5vbi1zdHJpY3QgcXVpcmsiKSBpbiBpb21tdS9uZXh0LgoKPiAtLS0g
YS9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLXY3cy5jCj4gKysrIGIvZHJpdmVycy9pb21t
dS9pby1wZ3RhYmxlLWFybS12N3MuYwo+IEBAIC03MDAsMTQgKzcwMCw3IEBAIHN0YXRpYyBzaXpl
X3QgX19hcm1fdjdzX3VubWFwKHN0cnVjdCBhcm1fdjdzX2lvX3BndGFibGUgKmRhdGEsCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQVJNX1Y3U19CTE9D
S19TSVpFKGx2bCArIDEpKTsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHB0ZXAg
PSBpb3B0ZV9kZXJlZihwdGVbaV0sIGx2bCwgZGF0YSk7Cj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBfX2FybV92N3NfZnJlZV90YWJsZShwdGVwLCBsdmwgKyAxLCBkYXRhKTsKPiAt
ICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2UgaWYgKGlvcC0+Y2ZnLnF1aXJrcyAmIElPX1BH
VEFCTEVfUVVJUktfTk9OX1NUUklDVCkgewo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLyoKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIE9yZGVyIHRoZSBQVEUg
dXBkYXRlIGFnYWluc3QgcXVldWVpbmcgdGhlIElPVkEsIHRvCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgKiBndWFyYW50ZWUgdGhhdCBhIGZsdXNoIGNhbGxiYWNrIGZyb20gYSBk
aWZmZXJlbnQgQ1BVCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBoYXMgb2Jz
ZXJ2ZWQgaXQgYmVmb3JlIHRoZSBUTEJJQUxMIGNhbiBiZSBpc3N1ZWQuCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKi8KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHNtcF93bWIoKTsKPiAtICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2Ugewo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoIWdhdGhlci0+cXVldWVkKSB7CgpJZiBDT05GSUdf
SU9NTVVfQVBJPW46CgplcnJvcjog4oCYc3RydWN0IGlvbW11X2lvdGxiX2dhdGhlcuKAmSBoYXMg
bm8gbWVtYmVyIG5hbWVkIOKAmHF1ZXVlZOKAmQoKVGhpcyBjYW4gYmUgcmVwcm9kdWNlZCB1c2lu
ZyBlLmcuIHNobW9iaWxlX2RlZmNvbmZpZyB3aXRoCiAgICBDT05GSUdfSU9NTVVfU1VQUE9SVD15
CiAgICBDT05GSUdfSU9NTVVfSU9fUEdUQUJMRV9BUk1WN1M9eQoKCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBpb19wZ3RhYmxlX3RsYl9hZGRfcGFnZShpb3AsIGdhdGhlciwgaW92
YSwgYmxrX3NpemUpOwo+ICAgICAgICAgICAgICAgICAgICAgICAgIH0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICBpb3ZhICs9IGJsa19zaXplOwoKPiAtLS0gYS9kcml2ZXJzL2lvbW11L2lvLXBn
dGFibGUtYXJtLmMKPiArKysgYi9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLmMKPiBAQCAt
NjM4LDE0ICs2MzgsNyBAQCBzdGF0aWMgc2l6ZV90IF9fYXJtX2xwYWVfdW5tYXAoc3RydWN0IGFy
bV9scGFlX2lvX3BndGFibGUgKmRhdGEsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpb19wZ3RhYmxlX3RsYl9mbHVzaF93YWxrKGlvcCwgaW92YSArIGkgKiBzaXplLCBzaXplLAo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBBUk1fTFBBRV9HUkFOVUxFKGRhdGEpKTsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF9fYXJtX2xwYWVfZnJlZV9wZ3RhYmxlKGRhdGEsIGx2bCArIDEsIGlvcHRlX2RlcmVmKHB0
ZSwgZGF0YSkpOwo+IC0gICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoaW9wLT5jZmcu
cXVpcmtzICYgSU9fUEdUQUJMRV9RVUlSS19OT05fU1RSSUNUKSB7Cj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAvKgo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICog
T3JkZXIgdGhlIFBURSB1cGRhdGUgYWdhaW5zdCBxdWV1ZWluZyB0aGUgSU9WQSwgdG8KPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIGd1YXJhbnRlZSB0aGF0IGEgZmx1c2ggY2Fs
bGJhY2sgZnJvbSBhIGRpZmZlcmVudCBDUFUKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAqIGhhcyBvYnNlcnZlZCBpdCBiZWZvcmUgdGhlIFRMQklBTEwgY2FuIGJlIGlzc3VlZC4K
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLwo+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc21wX3dtYigpOwo+IC0gICAgICAgICAgICAgICAgICAgICAgIH0gZWxz
ZSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIGlmICghZ2F0aGVyLT5xdWV1ZWQp
IHsKCklmIENPTkZJR19JT01NVV9BUEk9bjoKCmVycm9yOiDigJhzdHJ1Y3QgaW9tbXVfaW90bGJf
Z2F0aGVy4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYcXVldWVk4oCZCgpUaGlzIGNhbiBiZSBy
ZXByb2R1Y2VkIHVzaW5nIGUuZy4gc2htb2JpbGVfZGVmY29uZmlnIHdpdGgKICAgIENPTkZJR19J
T01NVV9TVVBQT1JUPXkKICAgIENPTkZJR19JT01NVV9JT19QR1RBQkxFX0xQQUU9eQoKPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlvX3BndGFibGVfdGxiX2FkZF9wYWdlKGlvcCwg
Z2F0aGVyLCBpb3ZhICsgaSAqIHNpemUsIHNpemUpOwo+ICAgICAgICAgICAgICAgICAgICAgICAg
IH0KPgoKUGVyaGFwcyAic2VsZWN0IElPTU1VX0FQSSIgc2hvdWxkIGJlIGFkZGVkIChtb3ZlZCBm
cm9tIGluZGl2aWR1YWwKZHJpdmVycykgdG8gYm90aCBJT01NVV9JT19QR1RBQkxFX0FSTVY3UyBh
bmQgSU9NTVVfSU9fUEdUQUJMRV9MUEFFPwpPciBpb21tdV9pb3RsYl9nYXRoZXIucXVldWVkIHNo
b3VsZCBub3QgYmUgYWNjZXNzZWQgaGVyZSwgb3IgdGhlCmFjY2VzcyB3cmFwcGVkIGludG8gYSBz
dGF0aWMgaW5saW5lIGhlbHBlciBmdW5jdGlvbiB3aXRoIGEgZHVtbXkgZm9yCnRoZSBDT05GSUdf
SU9NTVVfQVBJPW4gY2FzZT8KCkdye29ldGplLGVldGluZ31zLAoKICAgICAgICAgICAgICAgICAg
ICAgICAgR2VlcnQKCi0tIApHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExp
bnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBwZXJzb25hbCBjb252
ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4g
QnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1l
ciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAtLSBMaW51cyBUb3J2YWxkcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
