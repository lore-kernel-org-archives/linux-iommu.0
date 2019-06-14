Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78240C31E44
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 09:41:13 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 578262082C
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 09:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578262082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1A520E2B;
	Fri, 14 Jun 2019 09:41:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3D2F2AE0
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 09:41:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 8EFA3174
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 09:41:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A2482B;
	Fri, 14 Jun 2019 02:41:10 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9ADC3F718;
	Fri, 14 Jun 2019 02:42:52 -0700 (PDT)
Subject: Re: [RFC PATCH v6 1/5] iommu: add an exported function to get minimum
	page size for a domain
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, joro@8bytes.org,
	axboe@kernel.dk, ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1560421215-10750-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5e295ec3-39c9-de8a-a649-0aeeb0078ae3@arm.com>
Date: Fri, 14 Jun 2019 10:41:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1560421215-10750-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Content-Language: en-GB
Cc: linux-renesas-soc@vger.kernel.org, linux-block@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org, hch@lst.de
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gMTMvMDYvMjAxOSAxMToyMCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6Cj4gVGhpcyBwYXRj
aCBhZGRzIGFuIGV4cG9ydGVkIGZ1bmN0aW9uIHRvIGdldCBtaW5pbXVtIHBhZ2Ugc2l6ZSBmb3IK
PiBhIGRvbWFpbi4gVGhpcyBwYXRjaCBhbHNvIG1vZGlmaWVzIHNpbWlsYXIgY29kZXMgb24gdGhl
IGlvbW11LmMuCgpIZWgsIHNlZWluZyB0aGlzIGdhdmUgbWUgYSBnZW51aW5lIGTDqWrDoCB2dSBt
b21lbnQuLi4KCi4uLmJ1dCBpdCB0dXJucyBvdXQgSSBhY3R1YWxseSAqaGF2ZSogcmV2aWV3ZWQg
dGhpcyBwYXRjaCBiZWZvcmUgOikKCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMDVlY2E2
MDEtMDI2NC04MTQxLWNlZWItN2VmN2FkNWQ1NjUwQGFybS5jb20vCgpSb2Jpbi4KCj4gU2lnbmVk
LW9mZi1ieTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMu
Y29tPgo+IC0tLQo+ICAgZHJpdmVycy9pb21tdS9pb21tdS5jIHwgMTggKysrKysrKysrKysrKysr
LS0tCj4gICBpbmNsdWRlL2xpbnV4L2lvbW11LmggfCAgMSArCj4gICAyIGZpbGVzIGNoYW5nZWQs
IDE2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW9tbXUvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+IGluZGV4IDJhOTA2Mzgu
LjdlZDE2YWYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5jCj4gKysrIGIvZHJp
dmVycy9pb21tdS9pb21tdS5jCj4gQEAgLTI4MCw2ICsyODAsMTggQEAgaW9tbXVfaW5zZXJ0X2Rl
dmljZV9yZXN2X3JlZ2lvbnMoc3RydWN0IGxpc3RfaGVhZCAqZGV2X3Jlc3ZfcmVnaW9ucywKPiAg
IAlyZXR1cm4gcmV0Owo+ICAgfQo+ICAgCj4gKy8qKgo+ICsgKiBpb21tdV9nZXRfbWluaW11bV9w
YWdlX3NpemUgLSBnZXQgbWluaW11bSBwYWdlIHNpemUgZm9yIGEgZG9tYWluCj4gKyAqIEBkb21h
aW46IHRoZSBkb21haW4KPiArICoKPiArICogQWxsb3cgaW9tbXUgZHJpdmVyIHRvIGdldCBhIG1p
bmltdW0gcGFnZSBzaXplIGZvciBhIGRvbWFpbi4KPiArICovCj4gK3Vuc2lnbmVkIGxvbmcgaW9t
bXVfZ2V0X21pbmltdW1fcGFnZV9zaXplKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbikKPiAr
ewo+ICsJcmV0dXJuIDFVTCA8PCBfX2Zmcyhkb21haW4tPnBnc2l6ZV9iaXRtYXApOwo+ICt9Cj4g
K0VYUE9SVF9TWU1CT0xfR1BMKGlvbW11X2dldF9taW5pbXVtX3BhZ2Vfc2l6ZSk7Cj4gKwo+ICAg
aW50IGlvbW11X2dldF9ncm91cF9yZXN2X3JlZ2lvbnMoc3RydWN0IGlvbW11X2dyb3VwICpncm91
cCwKPiAgIAkJCQkgc3RydWN0IGxpc3RfaGVhZCAqaGVhZCkKPiAgIHsKPiBAQCAtNTU4LDcgKzU3
MCw3IEBAIHN0YXRpYyBpbnQgaW9tbXVfZ3JvdXBfY3JlYXRlX2RpcmVjdF9tYXBwaW5ncyhzdHJ1
Y3QgaW9tbXVfZ3JvdXAgKmdyb3VwLAo+ICAgCj4gICAJQlVHX09OKCFkb21haW4tPnBnc2l6ZV9i
aXRtYXApOwo+ICAgCj4gLQlwZ19zaXplID0gMVVMIDw8IF9fZmZzKGRvbWFpbi0+cGdzaXplX2Jp
dG1hcCk7Cj4gKwlwZ19zaXplID0gaW9tbXVfZ2V0X21pbmltdW1fcGFnZV9zaXplKGRvbWFpbik7
Cj4gICAJSU5JVF9MSVNUX0hFQUQoJm1hcHBpbmdzKTsKPiAgIAo+ICAgCWlvbW11X2dldF9yZXN2
X3JlZ2lvbnMoZGV2LCAmbWFwcGluZ3MpOwo+IEBAIC0xNTk1LDcgKzE2MDcsNyBAQCBpbnQgaW9t
bXVfbWFwKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwgdW5zaWduZWQgbG9uZyBpb3ZhLAo+
ICAgCQlyZXR1cm4gLUVJTlZBTDsKPiAgIAo+ICAgCS8qIGZpbmQgb3V0IHRoZSBtaW5pbXVtIHBh
Z2Ugc2l6ZSBzdXBwb3J0ZWQgKi8KPiAtCW1pbl9wYWdlc3ogPSAxIDw8IF9fZmZzKGRvbWFpbi0+
cGdzaXplX2JpdG1hcCk7Cj4gKwltaW5fcGFnZXN6ID0gaW9tbXVfZ2V0X21pbmltdW1fcGFnZV9z
aXplKGRvbWFpbik7Cj4gICAKPiAgIAkvKgo+ICAgCSAqIGJvdGggdGhlIHZpcnR1YWwgYWRkcmVz
cyBhbmQgdGhlIHBoeXNpY2FsIG9uZSwgYXMgd2VsbCBhcwo+IEBAIC0xNjU1LDcgKzE2NjcsNyBA
QCBzdGF0aWMgc2l6ZV90IF9faW9tbXVfdW5tYXAoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWlu
LAo+ICAgCQlyZXR1cm4gMDsKPiAgIAo+ICAgCS8qIGZpbmQgb3V0IHRoZSBtaW5pbXVtIHBhZ2Ug
c2l6ZSBzdXBwb3J0ZWQgKi8KPiAtCW1pbl9wYWdlc3ogPSAxIDw8IF9fZmZzKGRvbWFpbi0+cGdz
aXplX2JpdG1hcCk7Cj4gKwltaW5fcGFnZXN6ID0gaW9tbXVfZ2V0X21pbmltdW1fcGFnZV9zaXpl
KGRvbWFpbik7Cj4gICAKPiAgIAkvKgo+ICAgCSAqIFRoZSB2aXJ0dWFsIGFkZHJlc3MsIGFzIHdl
bGwgYXMgdGhlIHNpemUgb2YgdGhlIG1hcHBpbmcsIG11c3QgYmUKPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC9pb21tdS5oIGIvaW5jbHVkZS9saW51eC9pb21tdS5oCj4gaW5kZXggOTFhZjIy
YS4uN2U1M2I0MyAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2lvbW11LmgKPiArKysgYi9p
bmNsdWRlL2xpbnV4L2lvbW11LmgKPiBAQCAtMzY2LDYgKzM2Niw3IEBAIGV4dGVybiBpbnQgaW9t
bXVfcmVxdWVzdF9kbWFfZG9tYWluX2Zvcl9kZXYoc3RydWN0IGRldmljZSAqZGV2KTsKPiAgIGV4
dGVybiBzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gKgo+ICAgaW9tbXVfYWxsb2NfcmVzdl9yZWdp
b24ocGh5c19hZGRyX3Qgc3RhcnQsIHNpemVfdCBsZW5ndGgsIGludCBwcm90LAo+ICAgCQkJZW51
bSBpb21tdV9yZXN2X3R5cGUgdHlwZSk7Cj4gK2V4dGVybiB1bnNpZ25lZCBsb25nIGlvbW11X2dl
dF9taW5pbXVtX3BhZ2Vfc2l6ZShzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4pOwo+ICAgZXh0
ZXJuIGludCBpb21tdV9nZXRfZ3JvdXBfcmVzdl9yZWdpb25zKHN0cnVjdCBpb21tdV9ncm91cCAq
Z3JvdXAsCj4gICAJCQkJCXN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpOwo+ICAgCj4gCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
