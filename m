Return-Path: <SRS0=Qw1r=KC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA307C433ED
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 09:52:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B3D6145E
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 09:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B3D6145E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF8CE40FAD;
	Fri,  7 May 2021 09:52:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AsPNUR2ZQ-D1; Fri,  7 May 2021 09:52:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4062D40F9F;
	Fri,  7 May 2021 09:52:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15520C000E;
	Fri,  7 May 2021 09:52:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D222FC0001
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 09:52:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B1F034038D
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 09:52:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xAXe8SHovA9X for <iommu@lists.linux-foundation.org>;
 Fri,  7 May 2021 09:52:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id AA4B540165
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 09:52:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E87AE106F;
 Fri,  7 May 2021 02:52:46 -0700 (PDT)
Received: from [10.57.59.124] (unknown [10.57.59.124])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B85233F718;
 Fri,  7 May 2021 02:52:44 -0700 (PDT)
Subject: Re: [PATCH v3 09/10] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
To: Steven Price <steven.price@arm.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20210420082751.1829-1-shameerali.kolothum.thodi@huawei.com>
 <20210420082751.1829-10-shameerali.kolothum.thodi@huawei.com>
 <501cd986-7f9c-9aa7-b4e9-f2ef98fb7a95@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <8c7dad26-b286-3974-9316-78ce1129ebe3@arm.com>
Date: Fri, 7 May 2021 10:52:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <501cd986-7f9c-9aa7-b4e9-f2ef98fb7a95@arm.com>
Content-Language: en-GB
Cc: jon@solid-run.com, linuxarm@huawei.com, guohanjun@huawei.com,
 Sami.Mujawar@arm.com, wanghuiqiang@huawei.com
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

CgpPbiAyMDIxLTA1LTA2IDE2OjE3LCBTdGV2ZW4gUHJpY2Ugd3JvdGU6Cj4gT24gMjAvMDQvMjAy
MSAwOToyNywgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToKPj4gRnJvbTogSm9uIE5ldHRsZXRvbiA8
am9uQHNvbGlkLXJ1bi5jb20+Cj4+Cj4+IENoZWNrIGlmIHRoZXJlIGlzIGFueSBSTVIgaW5mbyBh
c3NvY2lhdGVkwqB3aXRoIHRoZSBkZXZpY2VzIGJlaGluZAo+PiB0aGUgU01NVSBhbmQgaWYgYW55
LCBpbnN0YWxsIGJ5cGFzcyBTTVJzIGZvciB0aGVtLiBUaGlzIGlzIHRvCj4+IGtlZXAgYW55IG9u
Z29pbmcgdHJhZmZpYyBhc3NvY2lhdGVkIHdpdGggdGhlc2UgZGV2aWNlcyBhbGl2ZQo+PiB3aGVu
IHdlIGVuYWJsZS9yZXNldCBTTU1VIGR1cmluZyBwcm9iZSgpLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5
OiBKb24gTmV0dGxldG9uIDxqb25Ac29saWQtcnVuLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogU2hh
bWVlciBLb2xvdGh1bSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPgo+PiAt
LS0KPj4gwqAgZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuYyB8IDQyICsrKysr
KysrKysrKysrKysrKysrKysrKysrKwo+PiDCoCBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9h
cm0tc21tdS5oIHzCoCAyICsrCj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygr
KQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUu
YyAKPj4gYi9kcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jCj4+IGluZGV4IGQ4
YzZiZmRlNmE2MS4uNGQyZjkxNjI2ZDg3IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2Fy
bS9hcm0tc21tdS9hcm0tc21tdS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11
L2FybS1zbW11LmMKPj4gQEAgLTIxMDIsNiArMjEwMiw0MyBAQCBlcnJfcmVzZXRfcGxhdGZvcm1f
b3BzOiBfX21heWJlX3VudXNlZDsKPj4gwqDCoMKgwqDCoCByZXR1cm4gZXJyOwo+PiDCoCB9Cj4+
ICtzdGF0aWMgdm9pZCBhcm1fc21tdV9ybXJfaW5zdGFsbF9ieXBhc3Nfc21yKHN0cnVjdCBhcm1f
c21tdV9kZXZpY2UgCj4+ICpzbW11KQo+PiArewo+PiArwqDCoMKgIHN0cnVjdCBpb21tdV9ybXIg
KmU7Cj4+ICvCoMKgwqAgaW50IGksIGNudCA9IDA7Cj4+ICvCoMKgwqAgdTMyIHNtcjsKPj4gKwo+
PiArwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBzbW11LT5udW1fbWFwcGluZ19ncm91cHM7IGkrKykg
ewo+PiArwqDCoMKgwqDCoMKgwqAgc21yID0gYXJtX3NtbXVfZ3IwX3JlYWQoc21tdSwgQVJNX1NN
TVVfR1IwX1NNUihpKSk7Cj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIUZJRUxEX0dFVChBUk1fU01N
VV9TTVJfVkFMSUQsIHNtcikpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+
PiArCj4+ICvCoMKgwqDCoMKgwqDCoCBsaXN0X2Zvcl9lYWNoX2VudHJ5KGUsICZzbW11LT5ybXJf
bGlzdCwgbGlzdCkgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoRklFTERfR0VUKEFS
TV9TTU1VX1NNUl9JRCwgc21yKSAhPSBlLT5zaWQpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgY29udGludWU7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc21tdS0+
c21yc1tpXS5pZCA9IEZJRUxEX0dFVChBUk1fU01NVV9TTVJfSUQsIHNtcik7Cj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHNtbXUtPnNtcnNbaV0ubWFzayA9IEZJRUxEX0dFVChBUk1fU01NVV9T
TVJfTUFTSywgc21yKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc21tdS0+c21yc1tpXS52
YWxpZCA9IHRydWU7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc21tdS0+czJjcnNb
aV0udHlwZSA9IFMyQ1JfVFlQRV9CWVBBU1M7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNt
bXUtPnMyY3JzW2ldLnByaXZjZmcgPSBTMkNSX1BSSVZDRkdfREVGQVVMVDsKPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc21tdS0+czJjcnNbaV0uY2JuZHggPSAweGZmOwo+PiArCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGNudCsrOwo+PiArwqDCoMKgwqDCoMKgwqAgfQo+PiArwqDCoMKg
IH0KPiAKPiBJZiBJIHVuZGVyc3RhbmQgdGhpcyBjb3JyZWN0bHkgLSB0aGlzIGlzIGxvb2tpbmcg
YXQgdGhlIGN1cnJlbnQKPiAoaGFyZHdhcmUpIGNvbmZpZ3VyYXRpb24gb2YgdGhlIFNNTVUgYW5k
IGF0dGVtcHRpbmcgdG8gcHJlc2VydmUgYW55Cj4gYnlwYXNzIFNNUnMuIEhvd2V2ZXIgZnJvbSB3
aGF0IEkgY2FuIHRlbGwgaXQgc3VmZmVycyBmcm9tIHRoZSBmb2xsb3dpbmcKPiB0d28gcHJvYmxl
bXM6Cj4gCj4gIMKgKGEpIE9ubHkgdGhlIElEIG9mIHRoZSBTTVIgaXMgYmVpbmcgY2hlY2tlZCwg
bm90IHRoZSBNQVNLLiBTbyBpZiB0aGUKPiBmaXJtd2FyZSBoYXMgc2V0dXAgYW4gU01SIG1hdGNo
aW5nIGEgbnVtYmVyIG9mIHN0cmVhbXMgdGhpcyB3aWxsIGJyZWFrLgo+IAo+ICDCoChiKSBUaGUg
U01NVSBtaWdodCBub3QgYmUgZW5hYmxlZCBhdCBhbGwgKENMSUVOVFBEPT0xKSBvciBieXBhc3MK
PiBlbmFibGVkIGZvciB1bm1hdGNoZWQgc3RyZWFtcyAoVVNGQ0ZHPT0wKS4KClllcywgdHJ5aW5n
IHRvIGluZmVyIGFueXRoaW5nIGZyb20gdGhlIGN1cnJlbnQgU01NVSBoYXJkd2FyZSBzdGF0ZSBp
cyAKYm9ndXMgLSBjb25zaWRlciB3aGF0IHlvdSBtaWdodCBmaW5kIGxlZnQgb3ZlciBhZnRlciBh
IGtleGVjLCBmb3IgCmluc3RhbmNlLiBUaGUgKm9ubHkqIHdheSB0byBkZXRlY3QgdGhlIHByZXNl
bmNlIGFuZCBhcHBsaWNhYmlsaXR5IG9mIApSTVJzIGlzIHRvIGxvb2sgYXQgdGhlIGFjdHVhbCBS
TVIgbm9kZXMgaW4gdGhlIElPUlQuCgpJZ25vcmUgd2hhdCB3ZSBsZXQgdGhlIFF1YWxjb21tIEFD
UEkgYm9vdGxvYWRlciBoYWNrIGRvIC0gdGhhdCB3aG9sZSAKaW1wbGVtZW50YXRpb24gaXMgInNw
ZWNpYWwiLgoKUm9iaW4uCgo+IENlcnRhaW5seSBpbiBteSB0ZXN0IHNldHVwIGNhc2UgKGIpIGFw
cGxpZXMgYW5kIHNvIHRoaXMgZG9lc24ndCB3b3JrLgo+IFBlcmhhcHMgc29tZXRoaW5nIGxpa2Ug
dGhlIGJlbG93IHdvdWxkIHdvcmsgYmV0dGVyPyAoSXQgd29ya3MgaW4gdGhlCj4gY2FzZSBvZiB0
aGUgU01NVSBub3QgZW5hYmxlZCAtIEkndmUgbm90IHRlc3RlZCBjYXNlIChhKSkuCj4gCj4gU3Rl
dmUKPiAKPiAtLS0tODwtLS0tCj4gc3RhdGljIHZvaWQgYXJtX3NtbXVfcm1yX2luc3RhbGxfYnlw
YXNzX3NtcihzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNlICpzbW11KQo+IHsKPiAgwqDCoMKgwqBzdHJ1
Y3QgaW9tbXVfcm1yICplOwo+ICDCoMKgwqDCoGludCBpLCBjbnQgPSAwOwo+ICDCoMKgwqDCoHUz
MiBzbXI7Cj4gIMKgwqDCoMKgdTMyIHJlZzsKPiAKPiAgwqDCoMKgwqByZWcgPSBhcm1fc21tdV9n
cjBfcmVhZChzbW11LCBBUk1fU01NVV9HUjBfc0NSMCk7Cj4gCj4gIMKgwqDCoMKgaWYgKChyZWcg
JiBBUk1fU01NVV9zQ1IwX1VTRkNGRykgJiYgIShyZWcgJiBBUk1fU01NVV9zQ1IwX0NMSUVOVFBE
KSkgewo+ICDCoMKgwqDCoMKgwqDCoCAvKgo+ICDCoMKgwqDCoMKgwqDCoMKgICogU01NVSBpcyBh
bHJlYWR5IGVuYWJsZWQgYW5kIGRpc2FsbG93aW5nIGJ5cGFzcywgc28gcHJlc2VydmUKPiAgwqDC
oMKgwqDCoMKgwqDCoCAqIHRoZSBleGlzdGluZyBTTVJzCj4gIMKgwqDCoMKgwqDCoMKgwqAgKi8K
PiAgwqDCoMKgwqDCoMKgwqAgZm9yIChpID0gMDsgaSA8IHNtbXUtPm51bV9tYXBwaW5nX2dyb3Vw
czsgaSsrKSB7Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc21yID0gYXJtX3NtbXVfZ3IwX3Jl
YWQoc21tdSwgQVJNX1NNTVVfR1IwX1NNUihpKSk7Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKCFGSUVMRF9HRVQoQVJNX1NNTVVfU01SX1ZBTElELCBzbXIpKQo+ICDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc21t
dS0+c21yc1tpXS5pZCA9IEZJRUxEX0dFVChBUk1fU01NVV9TTVJfSUQsIHNtcik7Cj4gIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc21tdS0+c21yc1tpXS5tYXNrID0gRklFTERfR0VUKEFSTV9TTU1V
X1NNUl9NQVNLLCBzbXIpOwo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNtbXUtPnNtcnNbaV0u
dmFsaWQgPSB0cnVlOwo+ICDCoMKgwqDCoMKgwqDCoCB9Cj4gIMKgwqDCoMKgfQo+IAo+ICDCoMKg
wqDCoGxpc3RfZm9yX2VhY2hfZW50cnkoZSwgJnNtbXUtPnJtcl9saXN0LCBsaXN0KSB7Cj4gIMKg
wqDCoMKgwqDCoMKgIHUzMiBzaWQgPSBlLT5zaWQ7Cj4gCj4gIMKgwqDCoMKgwqDCoMKgIGkgPSBh
cm1fc21tdV9maW5kX3NtZShzbW11LCBzaWQsIH4wKTsKPiAgwqDCoMKgwqDCoMKgwqAgaWYgKGkg
PCAwKQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+ICDCoMKgwqDCoMKgwqDC
oCBpZiAoc21tdS0+czJjcnNbaV0uY291bnQgPT0gMCkgewo+ICDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHNtbXUtPnNtcnNbaV0uaWQgPSBzaWQ7Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc21t
dS0+c21yc1tpXS5tYXNrID0gfjA7Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc21tdS0+c21y
c1tpXS52YWxpZCA9IHRydWU7Cj4gIMKgwqDCoMKgwqDCoMKgIH0KPiAgwqDCoMKgwqDCoMKgwqAg
c21tdS0+czJjcnNbaV0uY291bnQrKzsKPiAgwqDCoMKgwqDCoMKgwqAgc21tdS0+czJjcnNbaV0u
dHlwZSA9IFMyQ1JfVFlQRV9CWVBBU1M7Cj4gIMKgwqDCoMKgwqDCoMKgIHNtbXUtPnMyY3JzW2ld
LnByaXZjZmcgPSBTMkNSX1BSSVZDRkdfREVGQVVMVDsKPiAgwqDCoMKgwqDCoMKgwqAgc21tdS0+
czJjcnNbaV0uY2JuZHggPSAweGZmOwo+IAo+ICDCoMKgwqDCoMKgwqDCoCBjbnQrKzsKPiAgwqDC
oMKgwqB9Cj4gCj4gIMKgwqDCoMKgaWYgKChyZWcgJiBBUk1fU01NVV9zQ1IwX1VTRkNGRykgJiYg
IShyZWcgJiBBUk1fU01NVV9zQ1IwX0NMSUVOVFBEKSkgewo+ICDCoMKgwqDCoMKgwqDCoCAvKiBS
ZW1vdmUgdGhlIHZhbGlkIGJpdCBmb3IgdW51c2VkIFNNUnMgKi8KPiAgwqDCoMKgwqDCoMKgwqAg
Zm9yIChpID0gMDsgaSA8IHNtbXUtPm51bV9tYXBwaW5nX2dyb3VwczsgaSsrKSB7Cj4gIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKHNtbXUtPnMyY3JzW2ldLmNvdW50ID09IDApCj4gIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzbW11LT5zbXJzW2ldLnZhbGlkID0gZmFsc2U7Cj4g
IMKgwqDCoMKgwqDCoMKgIH0KPiAgwqDCoMKgwqB9Cj4gCj4gIMKgwqDCoMKgZGV2X25vdGljZShz
bW11LT5kZXYsICJcdHByZXNlcnZlZCAlZCBib290IG1hcHBpbmclc1xuIiwgY250LAo+ICDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBjbnQgPT0gMSA/ICIiIDogInMiKTsKPiB9Cl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
