Return-Path: <SRS0=xVSy=SS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D13CC10F13
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 14:13:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A5A223DE
	for <iommu@archiver.kernel.org>; Tue, 16 Apr 2019 14:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A5A223DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2E11AFEC;
	Tue, 16 Apr 2019 14:13:25 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D6221CD4
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 14:13:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 42F87828
	for <iommu@lists.linux-foundation.org>;
	Tue, 16 Apr 2019 14:13:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06BE3EBD;
	Tue, 16 Apr 2019 07:13:23 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C8FF3F59C;
	Tue, 16 Apr 2019 07:13:18 -0700 (PDT)
Subject: Re: [PATCH 6/9] iommu/amd: Implement map_atomic
To: Tom Murphy <tmurphy@arista.com>, iommu@lists.linux-foundation.org
References: <20190411184741.27540-1-tmurphy@arista.com>
	<20190411184741.27540-7-tmurphy@arista.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <78f2114b-0dcb-2dcf-c3b3-411e064b079f@arm.com>
Date: Tue, 16 Apr 2019 15:13:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411184741.27540-7-tmurphy@arista.com>
Content-Language: en-GB
Cc: David Brown <david.brown@linaro.org>, linux-samsung-soc@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>, dima@arista.com,
	Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	murphyt7@tcd.ie, Andy Gross <andy.gross@linaro.org>,
	Kukjin Kim <kgene@kernel.org>, linux-mediatek@lists.infradead.org,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-rockchip@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190416141316.ezdiYwVGT_6EPNH-2t6BpXv0TQ2da07K7dgOxiBBxmI@z>

T24gMTEvMDQvMjAxOSAxOTo0NywgVG9tIE11cnBoeSB3cm90ZToKPiBJbnN0ZWFkIG9mIHVzaW5n
IGEgc3BpbiBsb2NrIEkgcmVtb3ZlZCB0aGUgbXV0ZXggbG9jayBmcm9tIGJvdGggdGhlCj4gYW1k
X2lvbW11X21hcCBhbmQgYW1kX2lvbW11X3VubWFwIHBhdGggYXMgd2VsbC4gaW9tbXVfbWFwIGRv
ZXNu4oCZdCBsb2NrCj4gd2hpbGUgbWFwcGluZyBhbmQgc28gaWYgaW9tbXVfbWFwIGlzIGNhbGxl
ZCBieSB0d28gZGlmZmVyZW50IHRocmVhZHMgb24KPiB0aGUgc2FtZSBpb3ZhIHJlZ2lvbiBpdCBy
ZXN1bHRzIGluIGEgcmFjZSBjb25kaXRpb24gZXZlbiB3aXRoIHRoZSBsb2Nrcy4KPiBTbyB0aGUg
bG9ja2luZyBpbiBhbWRfaW9tbXVfbWFwIGFuZCBhbWRfaW9tbXVfdW5tYXAgZG9lc24ndCBhZGQg
YW55IHJlYWwKPiBwcm90ZWN0aW9uLiBUaGUgc29sdXRpb24gdG8gdGhpcyBpcyBmb3Igd2hhdGV2
ZXIgbWFuYWdlcyB0aGUgYWxsb2NhdGVkCj4gaW92YeKAmXMgZXh0ZXJuYWxseSB0byBtYWtlIHN1
cmUgaW9tbXVfbWFwIGlzbuKAmXQgY2FsbGVkIHR3aWNlIG9uIHRoZSBzYW1lCj4gcmVnaW9uIGF0
IHRoZSBzYW1lIHRpbWUuCgpOb3RlIHRoYXQgdGhhdCBhc3N1bXB0aW9uIGlzIG5vdCBuZWNlc3Nh
cmlseSBzdWZmaWNpZW50IC0gZXZlbiB3aXRoIApjb3JyZWN0IGFkZHJlc3Mgc3BhY2UgbWFuYWdl
bWVudCB5b3UgY2FuIGhhdmUgY2FzZXMgbGlrZSB0d28gdGhyZWFkcyAKbWFwcGluZyBhZGphY2Vu
dCBwYWdlcywgd2hlcmUgZXZlbiB0aG91Z2h0IHRoZXkgYXJlIHRhcmdldGluZyBkaWZmZXJlbnQg
ClBURXMgdGhleSBjYW4gcmFjZSB0byBpbnN0YWxsL21vZGlmeSBpbnRlcm1lZGlhdGUgbGV2ZWxz
IG9mIHRoZSAKcGFnZXRhYmxlLiBJIGJlbGlldmUgQU1EIGlzIGFjdHVhbGx5IE9LIGluIHRoYXQg
cmVnYXJkLCBidXQgc29tZSBkcml2ZXJzIAoqYXJlKiByZWx5aW5nIG9uIGxvY2tpbmcgZm9yIGNv
cnJlY3RuZXNzIHNvIGl0IGNhbid0IGp1c3QgYmUgCnVuZXF1aXZvY2FsbHkgcmVtb3ZlZCBldmVy
eXdoZXJlLgoKUm9iaW4uCgo+IFNpZ25lZC1vZmYtYnk6IFRvbSBNdXJwaHkgPHRtdXJwaHlAYXJp
c3RhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvaW9tbXUvYW1kX2lvbW11LmMgfCAyNSArKysrKysr
KysrKysrKysrKystLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwg
NyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hbWRfaW9tbXUu
YyBiL2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11LmMKPiBpbmRleCAyZDRlZTEwNjI2YjQuLmI0NWUw
ZTAzM2FkYyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lvbW11L2FtZF9pb21tdS5jCj4gKysrIGIv
ZHJpdmVycy9pb21tdS9hbWRfaW9tbXUuYwo+IEBAIC0zMDg5LDEyICszMDg5LDEyIEBAIHN0YXRp
YyBpbnQgYW1kX2lvbW11X2F0dGFjaF9kZXZpY2Uoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tLAo+
ICAgCXJldHVybiByZXQ7Cj4gICB9Cj4gICAKPiAtc3RhdGljIGludCBhbWRfaW9tbXVfbWFwKHN0
cnVjdCBpb21tdV9kb21haW4gKmRvbSwgdW5zaWduZWQgbG9uZyBpb3ZhLAo+IC0JCQkgcGh5c19h
ZGRyX3QgcGFkZHIsIHNpemVfdCBwYWdlX3NpemUsIGludCBpb21tdV9wcm90KQo+ICtzdGF0aWMg
aW50IF9fYW1kX2lvbW11X21hcChzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb20sIHVuc2lnbmVkIGxv
bmcgaW92YSwKPiArCQkJIHBoeXNfYWRkcl90IHBhZGRyLCBzaXplX3QgcGFnZV9zaXplLCBpbnQg
aW9tbXVfcHJvdCwKPiArCQkJIGdmcF90IGdmcCkKPiAgIHsKPiAgIAlzdHJ1Y3QgcHJvdGVjdGlv
bl9kb21haW4gKmRvbWFpbiA9IHRvX3Bkb21haW4oZG9tKTsKPiAgIAlpbnQgcHJvdCA9IDA7Cj4g
LQlpbnQgcmV0Owo+ICAgCj4gICAJaWYgKGRvbWFpbi0+bW9kZSA9PSBQQUdFX01PREVfTk9ORSkK
PiAgIAkJcmV0dXJuIC1FSU5WQUw7Cj4gQEAgLTMxMDQsMTEgKzMxMDQsMjEgQEAgc3RhdGljIGlu
dCBhbWRfaW9tbXVfbWFwKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbSwgdW5zaWduZWQgbG9uZyBp
b3ZhLAo+ICAgCWlmIChpb21tdV9wcm90ICYgSU9NTVVfV1JJVEUpCj4gICAJCXByb3QgfD0gSU9N
TVVfUFJPVF9JVzsKPiAgIAo+IC0JbXV0ZXhfbG9jaygmZG9tYWluLT5hcGlfbG9jayk7Cj4gLQly
ZXQgPSBpb21tdV9tYXBfcGFnZShkb21haW4sIGlvdmEsIHBhZGRyLCBwYWdlX3NpemUsIHByb3Qs
IEdGUF9LRVJORUwpOwo+IC0JbXV0ZXhfdW5sb2NrKCZkb21haW4tPmFwaV9sb2NrKTsKPiArCXJl
dHVybiBpb21tdV9tYXBfcGFnZShkb21haW4sIGlvdmEsIHBhZGRyLCBwYWdlX3NpemUsIHByb3Qs
IGdmcCk7Cj4gK30KPiAgIAo+IC0JcmV0dXJuIHJldDsKPiArc3RhdGljIGludCBhbWRfaW9tbXVf
bWFwKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbSwgdW5zaWduZWQgbG9uZyBpb3ZhLAo+ICsJCQkg
cGh5c19hZGRyX3QgcGFkZHIsIHNpemVfdCBwYWdlX3NpemUsIGludCBpb21tdV9wcm90KQo+ICt7
Cj4gKwlyZXR1cm4gX19hbWRfaW9tbXVfbWFwKGRvbSwgaW92YSwgcGFkZHIsIHBhZ2Vfc2l6ZSwg
aW9tbXVfcHJvdCwKPiArCQkJR0ZQX0tFUk5FTCk7Cj4gK30KPiArCj4gK3N0YXRpYyBpbnQgYW1k
X2lvbW11X21hcF9hdG9taWMoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tLCB1bnNpZ25lZCBsb25n
IGlvdmEsCj4gKwkJCSBwaHlzX2FkZHJfdCBwYWRkciwgc2l6ZV90IHBhZ2Vfc2l6ZSwgaW50IGlv
bW11X3Byb3QpCj4gK3sKPiArCXJldHVybiBfX2FtZF9pb21tdV9tYXAoZG9tLCBpb3ZhLCBwYWRk
ciwgcGFnZV9zaXplLCBpb21tdV9wcm90LAo+ICsJCQlHRlBfQVRPTUlDKTsKPiAgIH0KPiAgIAo+
ICAgc3RhdGljIHNpemVfdCBhbWRfaW9tbXVfdW5tYXAoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9t
LCB1bnNpZ25lZCBsb25nIGlvdmEsCj4gQEAgLTMyNjIsNiArMzI3Miw3IEBAIGNvbnN0IHN0cnVj
dCBpb21tdV9vcHMgYW1kX2lvbW11X29wcyA9IHsKPiAgIAkuYXR0YWNoX2RldiA9IGFtZF9pb21t
dV9hdHRhY2hfZGV2aWNlLAo+ICAgCS5kZXRhY2hfZGV2ID0gYW1kX2lvbW11X2RldGFjaF9kZXZp
Y2UsCj4gICAJLm1hcCA9IGFtZF9pb21tdV9tYXAsCj4gKwkubWFwX2F0b21pYyA9IGFtZF9pb21t
dV9tYXBfYXRvbWljLAo+ICAgCS51bm1hcCA9IGFtZF9pb21tdV91bm1hcCwKPiAgIAkuaW92YV90
b19waHlzID0gYW1kX2lvbW11X2lvdmFfdG9fcGh5cywKPiAgIAkuYWRkX2RldmljZSA9IGFtZF9p
b21tdV9hZGRfZGV2aWNlLAo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
