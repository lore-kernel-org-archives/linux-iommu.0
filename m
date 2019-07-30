Return-Path: <SRS0=JEM9=V3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599EFC0650F
	for <iommu@archiver.kernel.org>; Tue, 30 Jul 2019 15:36:42 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9A6206E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jul 2019 15:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqV1ZTJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9A6206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E0AA32FE0;
	Tue, 30 Jul 2019 15:36:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D6C042FCA
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Jul 2019 15:26:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 95A07D3
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Jul 2019 15:26:05 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 46D89206E0;
	Tue, 30 Jul 2019 15:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564500365;
	bh=cyeRiBni7SuzwXceJSbBai+SAVPR79ccBM2xDiF7Qsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lqV1ZTJo+V6m8AOFtBhU9I32ADwWfOw/v5O54IHwgGH9d6LTFPbEo5tcntliWrtRB
	xP3CnUpzrubt1AH+/OzUsf5kgjV6+Uv3oh6HfTa2E5YFSEnxge64zSwPPnW9UtURRp
	KSadpsgy9Rp680FRBFXkOhVzfeaWaIUI2E2ZxH5g=
Date: Tue, 30 Jul 2019 16:26:01 +0100
From: Will Deacon <will@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v2] iommu: arm-smmu-v3: Mark expected switch fall-through
Message-ID: <20190730152600.643mg43y6567pchi@willie-the-truck>
References: <20190730152012.2615-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190730152012.2615-1-anders.roxell@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: robin.murphy@arm.com, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

T24gVHVlLCBKdWwgMzAsIDIwMTkgYXQgMDU6MjA6MTFQTSArMDIwMCwgQW5kZXJzIFJveGVsbCB3
cm90ZToKPiBOb3cgdGhhdCAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoIGlzIHBhc3NlZCB0byBHQ0Mg
YnkgZGVmYXVsdCwgdGhlCj4gZm9sbG93aW5nIHdhcm5pbmcgc2hvd3MgdXA6Cj4gCj4gLi4vZHJp
dmVycy9pb21tdS9hcm0tc21tdS12My5jOiBJbiBmdW5jdGlvbiDigJhhcm1fc21tdV93cml0ZV9z
dHJ0YWJfZW504oCZOgo+IC4uL2RyaXZlcnMvaW9tbXUvYXJtLXNtbXUtdjMuYzoxMTg5Ojc6IHdh
cm5pbmc6IHRoaXMgc3RhdGVtZW50IG1heSBmYWxsCj4gIHRocm91Z2ggWy1XaW1wbGljaXQtZmFs
bHRocm91Z2g9XQo+ICAgICBpZiAoZGlzYWJsZV9ieXBhc3MpCj4gICAgICAgIF4KPiAuLi9kcml2
ZXJzL2lvbW11L2FybS1zbW11LXYzLmM6MTE5MTozOiBub3RlOiBoZXJlCj4gICAgZGVmYXVsdDoK
PiAgICBefn5+fn5+Cj4gCj4gUmV3b3JrIHNvIHRoYXQgdGhlIGNvbXBpbGVyIGRvZXNuJ3Qgd2Fy
biBhYm91dCBmYWxsLXRocm91Z2guIE1ha2UgaXQKPiBjbGVhcmVyIGJ5IGNhbGxpbmcgJ0JVR19P
TigpJyB3aGVuIGRpc2FibGVfYnlwYXNzIGlzIHNldCwgYW5kIGFsd2F5cwo+ICdicmVhazsnCj4g
Cj4gU2lnbmVkLW9mZi1ieTogQW5kZXJzIFJveGVsbCA8YW5kZXJzLnJveGVsbEBsaW5hcm8ub3Jn
Pgo+IC0tLQo+ICBkcml2ZXJzL2lvbW11L2FybS1zbW11LXYzLmMgfCA0ICsrLS0KPiAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pb21tdS9hcm0tc21tdS12My5jIGIvZHJpdmVycy9pb21tdS9hcm0tc21tdS12
My5jCj4gaW5kZXggYTlhOWZhYmQzOTY4Li5jNWM5M2U0OGI0ZGIgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy9pb21tdS9hcm0tc21tdS12My5jCj4gKysrIGIvZHJpdmVycy9pb21tdS9hcm0tc21tdS12
My5jCj4gQEAgLTExODYsOCArMTE4Niw4IEBAIHN0YXRpYyB2b2lkIGFybV9zbW11X3dyaXRlX3N0
cnRhYl9lbnQoc3RydWN0IGFybV9zbW11X21hc3RlciAqbWFzdGVyLCB1MzIgc2lkLAo+ICAJCQlz
dGVfbGl2ZSA9IHRydWU7Cj4gIAkJCWJyZWFrOwo+ICAJCWNhc2UgU1RSVEFCX1NURV8wX0NGR19B
Qk9SVDoKPiAtCQkJaWYgKGRpc2FibGVfYnlwYXNzKQo+IC0JCQkJYnJlYWs7Cj4gKwkJCUJVR19P
TighZGlzYWJsZV9ieXBhc3MpOwo+ICsJCQlicmVhazsKPiAgCQlkZWZhdWx0Ogo+ICAJCQlCVUco
KTsgLyogU1RFIGNvcnJ1cHRpb24gKi8KPiAgCQl9Cj4gLS0gCj4gMi4yMC4xCgpBY2tlZC1ieTog
V2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4KCkpvZXJnIC0tIGlmIHlvdSdkIGxpa2UgdG8g
cGljayB0aGlzIHVwIGFzIGEgZml4LCBmZWVsIGZyZWUsIG90aGVyd2lzZSBJJ2xsCmluY2x1ZGUg
aXQgaW4gbXkgcHVsbCByZXF1ZXN0IGZvciA1LjQuCgpDaGVlcnMsCgpXaWxsCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
