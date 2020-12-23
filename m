Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9E8C433E0
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 13:05:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 978592247F
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 13:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978592247F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3F2D7868C2;
	Wed, 23 Dec 2020 13:05:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sc2XfBgwGRCF; Wed, 23 Dec 2020 13:05:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B2B478689A;
	Wed, 23 Dec 2020 13:05:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 951E5C1825;
	Wed, 23 Dec 2020 13:05:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71737C0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 13:05:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 69040203D9
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 13:05:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A6tH+GF3JWuU for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 13:05:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 508B12034C
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 13:05:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D5B330E;
 Wed, 23 Dec 2020 05:05:30 -0800 (PST)
Received: from [10.57.34.90] (unknown [10.57.34.90])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B1333F66E;
 Wed, 23 Dec 2020 05:05:28 -0800 (PST)
Subject: Re: [PATCH v2 3/7] iommu/arm-smmu: Add dependency on io-pgtable
 format modules
To: isaacm@codeaurora.org
References: <1608597876-32367-1-git-send-email-isaacm@codeaurora.org>
 <1608597876-32367-4-git-send-email-isaacm@codeaurora.org>
 <3b0c191d-3fd0-73db-c1e3-4a80aa7953d7@arm.com>
 <e47f14b81d90772346ef28c9a7fd3365@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b86f5972-2e9c-20bd-eee3-ee3ea53d5fe6@arm.com>
Date: Wed, 23 Dec 2020 13:05:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e47f14b81d90772346ef28c9a7fd3365@codeaurora.org>
Content-Language: en-GB
Cc: kernel-team@android.com, will@kernel.org, pdaly@codeaurora.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 pratikp@codeaurora.org
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMjAyMC0xMi0yMiAxOTo0OSwgaXNhYWNtQGNvZGVhdXJvcmEub3JnIHdyb3RlOgo+IE9uIDIw
MjAtMTItMjIgMTE6MjcsIFJvYmluIE11cnBoeSB3cm90ZToKPj4gT24gMjAyMC0xMi0yMiAwMDo0
NCwgSXNhYWMgSi4gTWFuamFycmVzIHdyb3RlOgo+Pj4gVGhlIFNNTVUgZHJpdmVyIGRlcGVuZHMg
b24gdGhlIGF2YWlsYWJpbGl0eSBvZiB0aGUgQVJNIExQQUUgYW5kCj4+PiBBUk0gVjdTIGlvLXBn
dGFibGUgZm9ybWF0IGNvZGUgdG8gd29yayBwcm9wZXJseS4gSW4gcHJlcGFyYXRpb24KPj4KPj4g
Tml0OiB3ZSBkb24ndCByZWFsbHkgZGVwZW5kIG9uIHY3cyAtIHdlICpjYW4qIHVzZSBpdCBpZiBp
dCdzCj4+IGF2YWlsYWJsZSwgYWRkcmVzcyBjb25zdHJhaW50cyBhcmUgc3VpdGFibGUsIGFuZCB0
aGUgU01NVQo+PiBpbXBsZW1lbnRhdGlvbiBhY3R1YWxseSBzdXBwb3J0cyBpdCAobWFueSBkb24n
dCksIGJ1dCB3ZSBjYW4gc3RpbGwKPj4gcXVpdGUgaGFwcGlseSBub3QgdXNlIGl0IGV2ZW4gc28u
IExQQUUgaXMgbWFuZGF0b3J5IGluIHRoZQo+PiBhcmNoaXRlY3R1cmUgc28gdGhhdCdzIG91ciBv
bmx5IGhhcmQgcmVxdWlyZW1lbnQsIGVtYm9kaWVkIGluIHRoZQo+PiBrY29uZmlnIHNlbGVjdC4K
Pj4KPj4gVGhpcyBkb2VzIG1lYW4gdGhlcmUgbWF5IHRlY2huaWNhbGx5IHN0aWxsIGJlIGEgY29y
bmVyIGNhc2UgaW52b2x2aW5nCj4+IEFSTV9TTU1VPXkgYW5kIElPX1BHVEFCTEVfQVJNX1Y3Uz1t
LCBidXQgYXQgd29yc3QgaXQncyBub3cgYSBydW50aW1lCj4+IGZhaWx1cmUgcmF0aGVyIHRoYW4g
YSBidWlsZCBlcnJvciwgc28gdW5sZXNzIGFuZCB1bnRpbCBhbnlvbmUKPj4gZGVtb25zdHJhdGVz
IHRoYXQgaXQgYWN0dWFsbHkgbWF0dGVycyBJIGRvbid0IGZlZWwgcGFydGljdWxhcmx5Cj4+IGlu
Y2xpbmVkIHRvIGdpdmUgaXQgbXVjaCB0aG91Z2h0Lgo+Pgo+PiBSb2Jpbi4KPj4KPiBPa2F5LCBJ
J2xsIGZpeCB1cCB0aGUgY29tbWl0IG1lc3NhZ2UsIGFzIHdlbGwgYXMgdGhlIGNvZGUsIHNvIHRo
YXQgaXQKPiBvbmx5IGRlcGVuZHMgb24gaW8tcGd0YWJsZS1hcm0uCgpXZWxsLCBJSVVDIGl0IHdv
dWxkIG1ha2Ugc2Vuc2UgdG8ga2VlcCB0aGUgc29mdGRlcCBmb3Igd2hlbiB0aGUgdjdzIAptb2R1
bGUgKmlzKiBwcmVzZW50OyBJIGp1c3Qgd2FudGVkIHRvIGNsYXJpZnkgdGhhdCBpdCdzIG1vcmUg
b2YgYSAKbmljZS10by1oYXZlIHJhdGhlciB0aGFuIGEgbmVjZXNzaXR5LgoKUm9iaW4uCgo+IFRo
YW5rcywKPiBJc2FhYwo+Pj4gZm9yIGhhdmluZyB0aGUgaW8tcGd0YWJsZSBmb3JtYXRzIGFzIG1v
ZHVsZXMsIGFkZCBhICJwcmUiCj4+PiBkZXBlbmRlbmN5IHdpdGggTU9EVUxFX1NPRlRERVAoKSB0
byBlbnN1cmUgdGhhdCB0aGUgaW8tcGd0YWJsZQo+Pj4gZm9ybWF0IG1vZHVsZXMgYXJlIGxvYWRl
ZCBiZWZvcmUgbG9hZGluZyB0aGUgQVJNIFNNTVUgZHJpdmVyIG1vZHVsZS4KPj4+Cj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBJc2FhYyBKLiBNYW5qYXJyZXMgPGlzYWFjbUBjb2RlYXVyb3JhLm9yZz4KPj4+
IC0tLQo+Pj4gwqAgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuYyB8IDEgKwo+
Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4+Pgo+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LmMgCj4+PiBiL2RyaXZlcnMvaW9t
bXUvYXJtL2FybS1zbW11L2FybS1zbW11LmMKPj4+IGluZGV4IGQ4YzZiZmQuLmE3MjY0OWYgMTAw
NjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jCj4+PiAr
KysgYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jCj4+PiBAQCAtMjM1MSwz
ICsyMzUxLDQgQEAgTU9EVUxFX0RFU0NSSVBUSU9OKCJJT01NVSBBUEkgZm9yIEFSTSAKPj4+IGFy
Y2hpdGVjdGVkIFNNTVUgaW1wbGVtZW50YXRpb25zIik7Cj4+PiDCoCBNT0RVTEVfQVVUSE9SKCJX
aWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPiIpOwo+Pj4gwqAgTU9EVUxFX0FMSUFTKCJwbGF0
Zm9ybTphcm0tc21tdSIpOwo+Pj4gwqAgTU9EVUxFX0xJQ0VOU0UoIkdQTCB2MiIpOwo+Pj4gK01P
RFVMRV9TT0ZUREVQKCJwcmU6IGlvLXBndGFibGUtYXJtIGlvLXBndGFibGUtYXJtLXY3cyIpOwo+
Pj4KPj4KPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
Pj4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKPj4gbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCj4+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
