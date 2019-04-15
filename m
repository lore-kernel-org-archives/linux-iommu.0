Return-Path: <SRS0=E2BV=SR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE05C282DD
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 12:05:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D9FB20833
	for <iommu@archiver.kernel.org>; Mon, 15 Apr 2019 12:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Io6I2v0a";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iQg3Zp+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9FB20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 50B69EF3;
	Mon, 15 Apr 2019 12:05:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 10F5EEF2
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 12:05:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0E9472C3
	for <iommu@lists.linux-foundation.org>;
	Mon, 15 Apr 2019 12:05:36 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6C89F6188E; Mon, 15 Apr 2019 12:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1555329936;
	bh=WEkLI02HkMlfLPjkCRB4kQX+Yc8CE5+4/CD8RPw+AQc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=Io6I2v0a0cW7kANYfTUWUp+lAt1d2CzHnZ4hl9YOfSFer1Z6OikDywOcQS9FiYuuT
	p345UC1wX+7CUS2/NgSS/h6o+XCGSKfar8P6P676a6P/BhbkvzmqGE4IPnT/nOFrtn
	171u/2XClzWK4uVdqQIhCvyaRlAAfwtB8Azb0p1Y=
Received: from [10.79.129.68]
	(blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com
	[103.229.18.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: vivek.gautam@smtp.codeaurora.org)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 07F0E61793;
	Mon, 15 Apr 2019 12:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1555329931;
	bh=WEkLI02HkMlfLPjkCRB4kQX+Yc8CE5+4/CD8RPw+AQc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=iQg3Zp+9/4ZOq2F8j4H95sttETImEvHggDy3OJvA9dhTo+yXLicyrrVNgqys+vu7C
	Xupq0TjJ1SrhiP4StLWG5C1yjGfvU4pX/K6lfV8yNmhuYToLc0qeBV5a2ryrUhthus
	s9ClfyFm+iSDNhOwbZydMUySttYaON2ec2JBHuOk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 07F0E61793
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
	spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Add SID information to context fault
	log
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	will.deacon@arm.com, iommu@lists.linux-foundation.org
References: <20190415080734.6843-1-vivek.gautam@codeaurora.org>
	<e5945adb-a1a3-1743-e671-39707276fad6@arm.com>
From: Vivek Gautam <vivek.gautam@codeaurora.org>
Message-ID: <4cfc7b3b-bc74-6b37-19f5-40b6394fa762@codeaurora.org>
Date: Mon, 15 Apr 2019 17:35:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e5945adb-a1a3-1743-e671-39707276fad6@arm.com>
Content-Language: en-US
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Message-ID: <20190415120527.lC0nb4qZfEo7LqLFx1FztIrbjDrXkHs9d3EZadvykSs@z>

Ck9uIDQvMTUvMjAxOSAzOjExIFBNLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMTUvMDQvMjAx
OSAwOTowNywgVml2ZWsgR2F1dGFtIHdyb3RlOgo+PiBFeHRyYWN0IHRoZSBTSUQgYW5kIGFkZCB0
aGUgaW5mb3JtYXRpb24gdG8gY29udGV4dCBmYXVsdCBsb2cuCj4+IFRoaXMgaXMgc3BlY2lhbGx5
IHVzZWZ1bCBpbiBhIGRpc3RyaWJ1dGVkIHNtbXUgYXJjaGl0ZWN0dXJlCj4+IHdoZXJlIG11bHRp
cGxlIG1hc3RlcnMgYXJlIGNvbm5lY3RlZCB0byBzbW11LiBTSUQgaW5mb3JtYXRpb24KPj4gaGVs
cHMgdG8gcXVpY2tseSBpZGVudGlmeSB0aGUgZmF1bHRpbmcgbWFzdGVyIGRldmljZS4KPgo+IEht
bSwgZ2l2ZW4gaG93IGl0J3MgVU5LTk9XTiBmb3IgdHJhbnNsYXRpb24gZmF1bHRzLCB3aGljaCBh
cmUgYXJndWFibHkgCj4gdGhlIG1vc3QgbGlrZWx5IGNvbnRleHQgZmF1bHQsIEkgcmVja29uIGl0
IHByb2JhYmx5IG1ha2VzIG1vcmUgc2Vuc2UgCj4gdG8ganVzdCBkdW1wIHRoZSByYXcgcmVnaXN0
ZXIgdmFsdWUgZm9yIHRoZSB1c2VyIHRvIGludGVycHJldCwgYXMgd2UgCj4gZG8gZm9yIGZzci9m
c3luci4KCgpUaGFua3MgUm9iaW4uIFN1cmUgd2lsbCB1cGRhdGUgaXQgdG8gZHVtcCB0aGUgcmF3
IHJlZ2lzdGVyIHZhbHVlLgoKUmVnYXJkcwpWaXZlawoKPgo+IFJvYmluLgo+Cj4+IFNpZ25lZC1v
ZmYtYnk6IFZpdmVrIEdhdXRhbSA8dml2ZWsuZ2F1dGFtQGNvZGVhdXJvcmEub3JnPgo+PiAtLS0K
Pj4gwqAgZHJpdmVycy9pb21tdS9hcm0tc21tdS1yZWdzLmggfMKgIDQgKysrKwo+PiDCoCBkcml2
ZXJzL2lvbW11L2FybS1zbW11LmPCoMKgwqDCoMKgIHwgMTQgKysrKysrKysrKysrLS0KPj4gwqAg
MiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0tc21tdS1yZWdzLmggCj4+IGIvZHJpdmVycy9p
b21tdS9hcm0tc21tdS1yZWdzLmgKPj4gaW5kZXggYTEyMjZlNGFiNWY4Li5lNWJlMDM0NGI2MTAg
MTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvYXJtLXNtbXUtcmVncy5oCj4+ICsrKyBiL2Ry
aXZlcnMvaW9tbXUvYXJtLXNtbXUtcmVncy5oCj4+IEBAIC0xNDcsNiArMTQ3LDEwIEBAIGVudW0g
YXJtX3NtbXVfczJjcl9wcml2Y2ZnIHsKPj4gwqAgI2RlZmluZSBDQkFSX0lSUFRORFhfU0hJRlTC
oMKgwqDCoMKgwqDCoCAyNAo+PiDCoCAjZGVmaW5lIENCQVJfSVJQVE5EWF9NQVNLwqDCoMKgwqDC
oMKgwqAgMHhmZgo+PiDCoCArI2RlZmluZSBBUk1fU01NVV9HUjFfQ0JGUlNZTlJBKG4pwqDCoMKg
ICgweDQwMCArICgobikgPDwgMikpCj4+ICsjZGVmaW5lIENCRlJTWU5SQV9WMl9TSURfTUFTS8Kg
wqDCoMKgwqDCoMKgIDB4ZmZmZgo+PiArI2RlZmluZSBDQkZSU1lOUkFfVjFfU0lEX01BU0vCoMKg
wqDCoMKgwqDCoCAweDdmZmYKPj4gKwo+PiDCoCAjZGVmaW5lIEFSTV9TTU1VX0dSMV9DQkEyUihu
KcKgwqDCoMKgwqDCoMKgICgweDgwMCArICgobikgPDwgMikpCj4+IMKgICNkZWZpbmUgQ0JBMlJf
Ulc2NF8zMkJJVMKgwqDCoMKgwqDCoMKgICgwIDw8IDApCj4+IMKgICNkZWZpbmUgQ0JBMlJfUlc2
NF82NEJJVMKgwqDCoMKgwqDCoMKgICgxIDw8IDApCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lv
bW11L2FybS1zbW11LmMgYi9kcml2ZXJzL2lvbW11L2FybS1zbW11LmMKPj4gaW5kZXggMDQ1ZDkz
ODg0MTY0Li5hYTM0MjZkYzY4ZDAgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvYXJtLXNt
bXUuYwo+PiArKysgYi9kcml2ZXJzL2lvbW11L2FybS1zbW11LmMKPj4gQEAgLTU3NSw3ICs1NzUs
MTAgQEAgc3RhdGljIGlycXJldHVybl90IGFybV9zbW11X2NvbnRleHRfZmF1bHQoaW50IAo+PiBp
cnEsIHZvaWQgKmRldikKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYXJtX3NtbXVfZG9tYWluICpzbW11
X2RvbWFpbiA9IHRvX3NtbXVfZG9tYWluKGRvbWFpbik7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGFy
bV9zbW11X2NmZyAqY2ZnID0gJnNtbXVfZG9tYWluLT5jZmc7Cj4+IMKgwqDCoMKgwqAgc3RydWN0
IGFybV9zbW11X2RldmljZSAqc21tdSA9IHNtbXVfZG9tYWluLT5zbW11Owo+PiArwqDCoMKgIHZv
aWQgX19pb21lbSAqZ3IxX2Jhc2UgPSBBUk1fU01NVV9HUjEoc21tdSk7Cj4+IMKgwqDCoMKgwqAg
dm9pZCBfX2lvbWVtICpjYl9iYXNlOwo+PiArwqDCoMKgIHUzMiBjYmZyc3lucmE7Cj4+ICvCoMKg
wqAgdTE2IHNpZDsKPj4gwqAgwqDCoMKgwqDCoCBjYl9iYXNlID0gQVJNX1NNTVVfQ0Ioc21tdSwg
Y2ZnLT5jYm5keCk7Cj4+IMKgwqDCoMKgwqAgZnNyID0gcmVhZGxfcmVsYXhlZChjYl9iYXNlICsg
QVJNX1NNTVVfQ0JfRlNSKTsKPj4gQEAgLTU4Niw5ICs1ODksMTYgQEAgc3RhdGljIGlycXJldHVy
bl90IGFybV9zbW11X2NvbnRleHRfZmF1bHQoaW50IAo+PiBpcnEsIHZvaWQgKmRldikKPj4gwqDC
oMKgwqDCoCBmc3luciA9IHJlYWRsX3JlbGF4ZWQoY2JfYmFzZSArIEFSTV9TTU1VX0NCX0ZTWU5S
MCk7Cj4+IMKgwqDCoMKgwqAgaW92YSA9IHJlYWRxX3JlbGF4ZWQoY2JfYmFzZSArIEFSTV9TTU1V
X0NCX0ZBUik7Cj4+IMKgICvCoMKgwqAgY2JmcnN5bnJhID0gcmVhZGxfcmVsYXhlZChncjFfYmFz
ZSArCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFSTV9TTU1VX0dSMV9D
QkZSU1lOUkEoY2ZnLT5jYm5keCkpOwo+PiArwqDCoMKgIGlmIChzbW11LT52ZXJzaW9uID4gQVJN
X1NNTVVfVjEpCj4+ICvCoMKgwqDCoMKgwqDCoCBzaWQgPSBjYmZyc3lucmEgJiBDQkZSU1lOUkFf
VjJfU0lEX01BU0s7Cj4+ICvCoMKgwqAgZWxzZQo+PiArwqDCoMKgwqDCoMKgwqAgc2lkID0gY2Jm
cnN5bnJhICYgQ0JGUlNZTlJBX1YxX1NJRF9NQVNLOwo+PiArCj4+IMKgwqDCoMKgwqAgZGV2X2Vy
cl9yYXRlbGltaXRlZChzbW11LT5kZXYsCj4+IC3CoMKgwqAgIlVuaGFuZGxlZCBjb250ZXh0IGZh
dWx0OiBmc3I9MHgleCwgaW92YT0weCUwOGx4LCBmc3lucj0weCV4LCAKPj4gY2I9JWRcbiIsCj4+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZnNyLCBpb3ZhLCBmc3luciwgY2ZnLT5j
Ym5keCk7Cj4+ICvCoMKgwqAgIlVuaGFuZGxlZCBjb250ZXh0IGZhdWx0OiBmc3I9MHgleCwgaW92
YT0weCUwOGx4LCBmc3lucj0weCV4LCAKPj4gY2I9JWQgc2lkID0gJXVcbiIsCj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZnNyLCBpb3ZhLCBmc3luciwgY2ZnLT5jYm5keCwgc2lk
KTsKPj4gwqAgwqDCoMKgwqDCoCB3cml0ZWwoZnNyLCBjYl9iYXNlICsgQVJNX1NNTVVfQ0JfRlNS
KTsKPj4gwqDCoMKgwqDCoCByZXR1cm4gSVJRX0hBTkRMRUQ7Cj4+Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
