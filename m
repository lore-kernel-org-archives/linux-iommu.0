Return-Path: <SRS0=HmBJ=3Q=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42463C2D0DB
	for <iommu@archiver.kernel.org>; Mon, 27 Jan 2020 19:04:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B10206D3
	for <iommu@archiver.kernel.org>; Mon, 27 Jan 2020 19:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCrKmB53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B10206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DADF084EF0;
	Mon, 27 Jan 2020 19:04:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Nit5X8Gz3W7; Mon, 27 Jan 2020 19:04:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 651F4844D5;
	Mon, 27 Jan 2020 19:04:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4BA25C0177;
	Mon, 27 Jan 2020 19:04:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DE96C0171
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jan 2020 19:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 33634845DC
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jan 2020 19:04:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F4JF5z1eHjHG for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jan 2020 19:04:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 28A09844D5
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jan 2020 19:04:07 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id s10so4406630wmh.3
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jan 2020 11:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FEVoEiqONVVEfRgrb4jYFHNXvstm/3IJLIBoszrG8E8=;
 b=mCrKmB53Tc8iXS9VK6XdMGjA634XC/YrxWJI6kWx0EyRC3mlIiDUWG0YtTtscfrhJl
 HWXf5VzTITxzN1RDZ2YtEyqd3Jxvn4x7x3t9+YLslM8g6RyE1qZbIYtEfJBq2ifYlUOL
 cdhoOJuEYhdch6nOdg6OGGgvTU/DTaFZpkPydtvo0isqqYZCVwZop87i/3QM/WWtKNbq
 mTsVDJTdvECQiEV/o4uiktCZVYa420zzZqrIDRP2PyAmL/+RBo3vXuBwqYhfthZ3pkMo
 0TQ42M/jgrUCTPE9KJxjUj2X0LDA36ji0T9B0veXAckKtrpmj8ixlViguUqRueyno0VG
 j5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FEVoEiqONVVEfRgrb4jYFHNXvstm/3IJLIBoszrG8E8=;
 b=lckoPz0DdWa6vmA8KKg3vVOBQDWiq2IRVESfp1Wdrs+7ydyys9eXaWnrBPYMBCbsCt
 RcyfydfP3ZSFTwJJgfT+ulJKMGh9eoOxD0a5Z3hq8SAv1NtJik2b4HqPJQudrv3y3ap3
 bOM5n8N5f2OxlAFs5EJO5kHMToLpv1G7AXhykJzt8D6LAMyH4OXH6a5nfJu7Vu1spsTM
 3YUeOZ5uebpyTTQqMhroWJ4/PDdYjmizk3tDEI+8pPMrPjmYla4iW9nnPurJ4vXbvXev
 rbNnMsoqvIuqjQ0ZqXbw+Ot5+k9IjBmaUHYR21olScunUAYOvpOCH2AYZ9Hir9omWxdZ
 S5Rw==
X-Gm-Message-State: APjAAAW85rouFnu5I10a5x5VZgyCS2ooPW1ra+LTznPE34b1cffiA1Wo
 hyLRhS/hWXBeY3DwwIgUZAc=
X-Google-Smtp-Source: APXvYqz2IG4netFWL6hQ+QROxWQ2m1AXRn8u0EXsRRZIHAxWXGl4qEsNsa1ggsEuZ+frMCNqLyEHcA==
X-Received: by 2002:a1c:a515:: with SMTP id o21mr81724wme.85.1580151845654;
 Mon, 27 Jan 2020 11:04:05 -0800 (PST)
Received: from jernej-laptop.localnet (cpe-194-152-20-232.static.triera.net.
 [194.152.20.232])
 by smtp.gmail.com with ESMTPSA id i8sm22085691wro.47.2020.01.27.11.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2020 11:04:04 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH 3/3] arm64: dts: allwinner: h6: Add IOMMU
Date: Mon, 27 Jan 2020 20:04:02 +0100
Message-ID: <2140600.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20200127142339.crxsuunzec5drfe2@gilmour.lan>
References: <cover.b2a9e1507135d81e726fcbb65137665a7f0ab74f.1579696927.git-series.maxime@cerno.tech>
 <5320339.DvuYhMxLoT@jernej-laptop>
 <20200127142339.crxsuunzec5drfe2@gilmour.lan>
MIME-Version: 1.0
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

SGkhCgpEbmUgcG9uZWRlbGplaywgMjcuIGphbnVhciAyMDIwIG9iIDE1OjIzOjM5IENFVCBqZSBN
YXhpbWUgUmlwYXJkIG5hcGlzYWwoYSk6Cj4gSGkgSmVybmVqLAo+IAo+IE9uIEZyaSwgSmFuIDI0
LCAyMDIwIGF0IDA5OjU0OjIzUE0gKzAxMDAsIEplcm5laiDFoGtyYWJlYyB3cm90ZToKPiA+IERu
ZSBzcmVkYSwgMjIuIGphbnVhciAyMDIwIG9iIDEzOjQ0OjA5IENFVCBqZSBNYXhpbWUgUmlwYXJk
IG5hcGlzYWwoYSk6Cj4gPiA+IE5vdyB0aGF0IHdlIGhhdmUgYSBkcml2ZXIgZm9yIHRoZSBJT01N
VSwgbGV0J3Mgc3RhcnQgdXNpbmcgaXQuCj4gPiA+IAo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNYXhp
bWUgUmlwYXJkIDxtYXhpbWVAY2Vybm8udGVjaD4KPiA+ID4gLS0tCj4gPiA+IAo+ID4gPiAgYXJj
aC9hcm02NC9ib290L2R0cy9hbGx3aW5uZXIvc3VuNTBpLWg2LmR0c2kgfCAxMSArKysrKysrKysr
Kwo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykKPiA+ID4gCj4gPiA+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2FsbHdpbm5lci9zdW41MGktaDYuZHRzaQo+
ID4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvYWxsd2lubmVyL3N1bjUwaS1oNi5kdHNpIGluZGV4
Cj4gPiA+IDI5ODI0MDgxYjQzYi4uODYwOGJjZjFjNTJjIDEwMDY0NAo+ID4gPiAtLS0gYS9hcmNo
L2FybTY0L2Jvb3QvZHRzL2FsbHdpbm5lci9zdW41MGktaDYuZHRzaQo+ID4gPiArKysgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2FsbHdpbm5lci9zdW41MGktaDYuZHRzaQo+ID4gPiBAQCAtNTMsNiAr
NTMsNyBAQAo+ID4gPiAKPiA+ID4gIAlkZTogZGlzcGxheS1lbmdpbmUgewo+ID4gPiAgCQo+ID4g
PiAgCQljb21wYXRpYmxlID0gImFsbHdpbm5lcixzdW41MGktaDYtZGlzcGxheS1lbmdpbmUiOwo+
ID4gPiAgCQlhbGx3aW5uZXIscGlwZWxpbmVzID0gPCZtaXhlcjA+Owo+ID4gPiAKPiA+ID4gKwkJ
aW9tbXVzID0gPCZpb21tdSAwPjsKPiA+ID4gCj4gPiA+ICAJCXN0YXR1cyA9ICJkaXNhYmxlZCI7
Cj4gPiA+ICAJCj4gPiA+ICAJfTsKPiA+IAo+ID4gSXNuJ3QgaW9tbXUgcHJvcGVydHkgb2YgdGhl
IG1peGVyIG5vZGU/IEFmdGVyIGFsbCwgbWl4ZXIgaXMgdGhlIG9uZSB3aGljaAo+ID4gcmVhZHMg
b25lIG9yIG1vcmUgZnJhbWVidWZmZXJzLiBPbmNlIHNlY29uZCBtaXhlciBpcyBkZWZpbmVkLCB3
b3VsZCB5b3UKPiA+IHB1dAo+ID4gYW5vdGhlciBpb21tdSBwaGFuZGxlIGhlcmU/Cj4gCj4gWW91
J3JlIHJpZ2h0LiBJIGFkZGVkIGl0IGR1cmluZyB0aGUgZWFybHkgZGV2LCBhbmQgZm9yZ290IHRv
IHJlbW92ZQo+IGl0LiBUaGFua3MhCgpSZW1vdmUgaXQgb3IgbW92ZSBpdD8gSSBndWVzcyBlbmFi
bGluZyBpb21tdSBzdXBwb3J0IGluIGVhY2ggZHJpdmVyIG5lZWRzIGEgCmJpdCBtb3JlIHdvcmsg
dGhhbiBqdXN0IHJlZmVyZW5jaW5nIGlvbW11IG5vZGUsIHJpZ2h0PyBBdCBsZWFzdCBpbiBzdWNo
IGNhc2UgCmJ1ZmZlcnMgZG9uJ3QgbmVlZCB0byBiZSBhbGxvY2F0ZWQgYnkgQ01BLCB3aGljaCBz
dW40aS1kcm0gZHJpdmVyIGN1cnJlbnRseSAKdXNlLgoKSSBqdXN0IHRha2UgYW5vdGhlciBsb29r
IGF0IEJTUCBrZXJuZWwgYW5kIGl0IHNlZW1zIHRoYXQgb25seSBvbmUgY2hhbm5lbCBpcyAKdXNl
ZCBmb3Igd2hvbGUgZGlzcGxheSBzdGFjay4gVGhhdCB3b3VsZCBtZWFuIHRoYXQgYm90aCBtaXhl
cnMgd291bGQgaGF2ZSBzYW1lIAppb21tdSBwaGFuZGxlLCByaWdodD8gQ29uZnVzaW5nbHkgZW5v
dWdoLCBERTIgaW9tbXUgY2hhbm5lbCBzZWVtcyB0byBiZSBmb3IgCmRlaW50ZXJsYWNlIGNvcmUu
CgpCZXN0IHJlZ2FyZHMsCkplcm5lagoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
