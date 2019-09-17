Return-Path: <SRS0=TfYV=XM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF1AC4CECE
	for <iommu@archiver.kernel.org>; Tue, 17 Sep 2019 12:52:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3F932171F
	for <iommu@archiver.kernel.org>; Tue, 17 Sep 2019 12:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F932171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6CBE214A6;
	Tue, 17 Sep 2019 12:52:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 67B5B14A4
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 12:52:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
	[209.85.210.67])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 72CE182F
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 12:52:43 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id g25so2971649otl.0
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 05:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=cGu+OKqa8P9FhmcrfusKIEOBVN7wjkZzGzIlcpxnAM4=;
	b=EqdKoArOQjmOGB2bFGsScXO+LxCnQNLGfMiDy7n62yY4H1aZrk0vLgbrs1azGOecTK
	tIm0h+z7q/m4zotPgTla6NlpEDNRnzd8UpBedIx6VGNWtMWkCLvlgSeXQaTb58b8eGKy
	6pTzTWM81L1ariZGcc2NTxD1UsxEfoXdExB5OIy2wwp61/wGsdofqiELhyhxjkv2IjSc
	SEeERvK2W9ABAcinwvfVyHuTbYZZsT06pMVAXqC+bEK116BMSXUuxYi+gldBIUaHtpdx
	NAv2bXS1lSyF5WvjkkpJVil6qlUJAT2mbtLi1fENc0Iv0Fxfh8UBkE07WZXvqHUPXQDc
	o9RA==
X-Gm-Message-State: APjAAAUfOv1ysuZhvLYggNUHujisI0ZhtvK6gkJStS1x+YZNrt3sJQO5
	XimTkDgfKAlFnpzFUgE4SbIZstK8kIqkjtHk900=
X-Google-Smtp-Source: APXvYqwF7djb29BU4JOekDq/w2ATaouFkjTZStu1zawPVEUhoivXp7Jzh/X/ybbkO0GGmU/IOqDimmtEJFBAiFablnE=
X-Received: by 2002:a9d:5a06:: with SMTP id v6mr2514884oth.250.1568724762614; 
	Tue, 17 Sep 2019 05:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190824132846.8589-1-u.kleine-koenig@pengutronix.de>
	<20190824132846.8589-2-u.kleine-koenig@pengutronix.de>
	<20190913215809.GA11833@bogus>
	<CAMuHMdV+pwoAA0zH_vQf2nKqzrgHP8rcMStyJbnuu2qviFC_qg@mail.gmail.com>
	<20190917101303.t5otztdus7y3ayau@pengutronix.de>
	<489c90fb-a135-4fd8-ecb9-46404bd3c234@axentia.se>
	<20190917122530.3xy7sut3xdvzlomj@pengutronix.de>
In-Reply-To: <20190917122530.3xy7sut3xdvzlomj@pengutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Sep 2019 14:52:31 +0200
Message-ID: <CAMuHMdXk5uSk-v4vYVR1YO46gQd0mRYy5eEM6wOHqgkRTfyn-g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] of: Let of_for_each_phandle fallback to
	non-negative cell_count
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	Linux I2C <linux-i2c@vger.kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Will Deacon <will@kernel.org>, Peter Rosin <peda@axentia.se>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SGkgVXdlLAoKT24gVHVlLCBTZXAgMTcsIDIwMTkgYXQgMjoyNSBQTSBVd2UgS2xlaW5lLUvDtm5p
Zwo8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPiB3cm90ZToKPiBPbiBUdWUsIFNlcCAx
NywgMjAxOSBhdCAxMToyNTo0NkFNICswMDAwLCBQZXRlciBSb3NpbiB3cm90ZToKPiA+IE9uIDIw
MTktMDktMTcgMTI6MTMsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOgo+ID4gPiBPbiBUdWUsIFNl
cCAxNywgMjAxOSBhdCAxMTo0MDoyNUFNICswMjAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6
Cj4gPiA+PiBPbiBGcmksIFNlcCAxMywgMjAxOSBhdCAxMTo1OCBQTSBSb2IgSGVycmluZyA8cm9i
aEBrZXJuZWwub3JnPiB3cm90ZToKPiA+ID4+PiBPbiBTYXQsIDI0IEF1ZyAyMDE5IDE1OjI4OjQ2
ICswMjAwLCA9P1VURi04P3E/VXdlPTIwS2xlaW5lLUs9QzM9QjZuaWc/PSAgICAgICAgICB3cm90
ZToKPiA+ID4+Pj4gUmVmZXJlbmNpbmcgZGV2aWNlIHRyZWUgbm9kZXMgZnJvbSBhIHByb3BlcnR5
IGFsbG93cyB0byBwYXNzIGFyZ3VtZW50cy4KPiA+ID4+Pj4gVGhpcyBpcyBmb3IgZXhhbXBsZSB1
c2VkIGZvciByZWZlcmVuY2luZyBncGlvcy4gVGhpcyBsb29rcyBhcyBmb2xsb3dzOgo+ID4gPj4+
Pgo+ID4gPj4+PiAgICAgICBncGlvX2N0cmw6IGdwaW8tY29udHJvbGxlciB7Cj4gPiA+Pj4+ICAg
ICAgICAgICAgICAgI2dwaW8tY2VsbHMgPSA8Mj4KPiA+ID4+Pj4gICAgICAgICAgICAgICAuLi4K
PiA+ID4+Pj4gICAgICAgfQo+ID4gPj4+Pgo+ID4gPj4+PiAgICAgICBzb21lb3RoZXJub2RlIHsK
PiA+ID4+Pj4gICAgICAgICAgICAgICBncGlvcyA9IDwmZ3Bpb19jdHJsIDUgMCAmZ3Bpb19jdHJs
IDMgMD47Cj4gPiA+Pj4+ICAgICAgICAgICAgICAgLi4uCj4gPiA+Pj4+ICAgICAgIH0KPiA+ID4+
Pj4KPiA+ID4+Pj4gVG8ga25vdyB0aGUgbnVtYmVyIG9mIGFyZ3VtZW50cyB0aGlzIG11c3QgYmUg
ZWl0aGVyIGZpeGVkLCBvciB0aGUKPiA+ID4+Pj4gcmVmZXJlbmNlZCBub2RlIGlzIGNoZWNrZWQg
Zm9yIGEgJGNlbGxzX25hbWUgKGhlcmU6ICIjZ3Bpby1jZWxscyIpCj4gPiA+Pj4+IHByb3BlcnR5
IGFuZCB3aXRoIHRoaXMgaW5mb3JtYXRpb24gdGhlIHN0YXJ0IG9mIHRoZSBzZWNvbmQgcmVmZXJl
bmNlIGNhbgo+ID4gPj4+PiBiZSBkZXRlcm1pbmVkLgo+ID4gPj4+Pgo+ID4gPj4+PiBDdXJyZW50
bHkgcmVndWxhdG9ycyBhcmUgcmVmZXJlbmNlZCB3aXRoIG5vIGFkZGl0aW9uYWwgYXJndW1lbnRz
LiBUbwo+ID4gPj4+PiBhbGxvdyBzb21lIG9wdGlvbmFsIGFyZ3VtZW50cyB3aXRob3V0IGhhdmlu
ZyB0byBjaGFuZ2UgYWxsIHJlZmVyZW5jZWQKPiA+ID4+Pj4gbm9kZXMgdGhpcyBjaGFuZ2UgaW50
cm9kdWNlcyBhIHdheSB0byBzcGVjaWZ5IGEgZGVmYXVsdCBjZWxsX2NvdW50LiBTbwo+ID4gPj4+
PiB3aGVuIGEgcGhhbmRsZSBpcyBwYXJzZWQgd2UgY2hlY2sgZm9yIHRoZSAkY2VsbHNfbmFtZSBw
cm9wZXJ0eSBhbmQgdXNlCj4gPiA+Pj4+IGl0IGFzIGJlZm9yZSBpZiBwcmVzZW50LiBJZiBpdCBp
cyBub3QgcHJlc2VudCB3ZSBmYWxsIGJhY2sgdG8KPiA+ID4+Pj4gY2VsbHNfY291bnQgaWYgbm9u
LW5lZ2F0aXZlIGFuZCBvbmx5IGZhaWwgaWYgY2VsbHNfY291bnQgaXMgc21hbGxlciB0aGFuCj4g
PiA+Pj4+IHplcm8uCj4gPiA+Pj4+Cj4gPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUt
S8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+Cj4gPiA+Pgo+ID4gPj4gVGhp
cyBpcyBub3cgY29tbWl0IGU0MmVlNjEwMTdmNThjZDkgKCJvZjogTGV0IG9mX2Zvcl9lYWNoX3Bo
YW5kbGUgZmFsbGJhY2sKPiA+ID4+IHRvIG5vbi1uZWdhdGl2ZSBjZWxsX2NvdW50IikgaW4gcm9i
aC9mb3ItbmV4dCwgd2hpY2ggY2F1c2VzIGEgbG9jay11cCB3aGVuCj4gPiA+PiBib290aW5nIGEg
c2htb2JpbGVfZGVmY29uZmlnIGtlcm5lbCBvbiByOGE3NzkxL2tvZWxzY2g6Cj4gPiA+Pgo+ID4g
Pj4gcmN1OiBJTkZPOiByY3Vfc2NoZWQgc2VsZi1kZXRlY3RlZCBzdGFsbCBvbiBDUFUKCj4gT2gg
eWVhaCwgeW91J3JlIHJpZ2h0LiBJJ20gYSBiaXQgZGlzYXBwb2ludGVkIHRoYXQgSSBkaWRuJ3Qg
c3BvdCB0aGlzCj4gbXlzZWxmIDotfAo+Cj4gVW50ZXN0ZWQgcGF0Y2ggdG8gZml4IHRoaXMgcHJv
YmxlbToKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL29mL2Jhc2UuYyBiL2RyaXZlcnMvb2YvYmFz
ZS5jCj4gaW5kZXggMmYyNWQyZGZlY2ZhLi4yNmY3YTIxZDcxODcgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9vZi9iYXNlLmMKPiArKysgYi9kcml2ZXJzL29mL2Jhc2UuYwo+IEBAIC0xMjg0LDYgKzEy
ODQsMTMgQEAgaW50IG9mX3BoYW5kbGVfaXRlcmF0b3JfaW5pdChzdHJ1Y3Qgb2ZfcGhhbmRsZV9p
dGVyYXRvciAqaXQsCj4gICAgICAgICBjb25zdCBfX2JlMzIgKmxpc3Q7Cj4gICAgICAgICBpbnQg
c2l6ZTsKPgo+ICsgICAgICAgLyoKPiArICAgICAgICAqIG9uZSBvZiBjZWxsX2NvdW50IG9yIGNl
bGxzX25hbWUgbXVzdCBiZSBwcm92aWRlZCB0byBkZXRlcm1pbmUgdGhlCj4gKyAgICAgICAgKiBh
cmd1bWVudCBsZW5ndGguCj4gKyAgICAgICAgKi8KPiArICAgICAgIGlmIChjZWxsX2NvdW50IDwg
MCAmJiAhY2VsbHNfbmFtZSkKPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gKwo+
ICAgICAgICAgbWVtc2V0KGl0LCAwLCBzaXplb2YoKml0KSk7Cj4KPiAgICAgICAgIGxpc3QgPSBv
Zl9nZXRfcHJvcGVydHkobnAsIGxpc3RfbmFtZSwgJnNpemUpOwo+IEBAIC0xNzY1LDYgKzE3NzIs
MTggQEAgaW50IG9mX2NvdW50X3BoYW5kbGVfd2l0aF9hcmdzKGNvbnN0IHN0cnVjdCBkZXZpY2Vf
bm9kZSAqbnAsIGNvbnN0IGNoYXIgKmxpc3RfbmEKPiAgICAgICAgIHN0cnVjdCBvZl9waGFuZGxl
X2l0ZXJhdG9yIGl0Owo+ICAgICAgICAgaW50IHJjLCBjdXJfaW5kZXggPSAwOwo+Cj4gKyAgICAg
ICAvKiBJZiBjZWxsc19uYW1lIGlzIE5VTEwgd2UgYXNzdW1lIGFuIGNlbGxfY291bnQgb2YgMCAq
LwoKYSBjZWxsIGNvdW50Cgo+ICsgICAgICAgaWYgKGNlbGxzX25hbWUgPT0gTlVMTCkgewo+ICsg
ICAgICAgICAgICAgICBjb25zdCBfX2JlMzIgKmxpc3Q7Cj4gKyAgICAgICAgICAgICAgIGludCBz
aXplOwo+ICsKPiArICAgICAgICAgICAgICAgbGlzdCA9IG9mX2dldF9wcm9wZXJ0eShucCwgbGlz
dF9uYW1lLCAmc2l6ZSk7Cj4gKyAgICAgICAgICAgICAgIGlmICghbGlzdCkKPiArICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gLUVOT0VOVDsKPiArCj4gKyAgICAgICAgICAgICAgIHJldHVy
biBzaXplIC8gc2l6ZW9mKCpsaXN0KTsKPiArICAgICAgIH0KPiArCj4gICAgICAgICByYyA9IG9m
X3BoYW5kbGVfaXRlcmF0b3JfaW5pdCgmaXQsIG5wLCBsaXN0X25hbWUsIGNlbGxzX25hbWUsIC0x
KTsKPiAgICAgICAgIGlmIChyYykKPiAgICAgICAgICAgICAgICAgcmV0dXJuIHJjOwoKVGhhbmtz
LCB0aGF0IGZpeGVzIHRoZSBib290IGZvciBtZSEKClRlc3RlZC1ieTogR2VlcnQgVXl0dGVyaG9l
dmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4KCkdye29ldGplLGVldGluZ31zLAoKICAgICAg
ICAgICAgICAgICAgICAgICAgR2VlcnQKCi0tIApHZWVydCBVeXR0ZXJob2V2ZW4gLS0gVGhlcmUn
cyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3JnCgpJbiBw
ZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxsIG15c2Vs
ZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBqdXN0IHNh
eSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
