Return-Path: <SRS0=eogA=LY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D749C11F65
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 14:02:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B7961418
	for <iommu@archiver.kernel.org>; Wed, 30 Jun 2021 14:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B7961418
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C0E69404C2;
	Wed, 30 Jun 2021 14:02:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J9-c35luMewD; Wed, 30 Jun 2021 14:02:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A3886404A3;
	Wed, 30 Jun 2021 14:02:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66E07C0010;
	Wed, 30 Jun 2021 14:02:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 338D8C0010
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 14:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 11061415B6
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 14:02:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BiB3-x_yy1IW for <iommu@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 14:02:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id CE5214159D
 for <iommu@lists.linux-foundation.org>; Wed, 30 Jun 2021 14:02:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05ED36D;
 Wed, 30 Jun 2021 07:02:02 -0700 (PDT)
Received: from [10.57.40.45] (unknown [10.57.40.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99D623F718;
 Wed, 30 Jun 2021 07:02:00 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm: Cleanup resources in case of probe error path
To: Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>
References: <20210608164559.204023-1-ameynarkhede03@gmail.com>
 <CGME20210630124816eucas1p27563f0a456c0196e20937619aa2f8d26@eucas1p2.samsung.com>
 <26f6a765-37c8-d63a-a779-384f095d5770@samsung.com>
 <20210630125940.GA8515@willie-the-truck>
 <4e3b1685-323e-2a7e-3aae-7c21b28fc65f@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <bc07bd52-ed2e-0a44-80a7-36b581018b40@arm.com>
Date: Wed, 30 Jun 2021 15:01:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4e3b1685-323e-2a7e-3aae-7c21b28fc65f@samsung.com>
Content-Language: en-GB
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-kernel@vger.kernel.org, Amey Narkhede <ameynarkhede03@gmail.com>,
 Jon Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

T24gMjAyMS0wNi0zMCAxNDo0OCwgTWFyZWsgU3p5cHJvd3NraSB3cm90ZToKPiBPbiAzMC4wNi4y
MDIxIDE0OjU5LCBXaWxsIERlYWNvbiB3cm90ZToKPj4gT24gV2VkLCBKdW4gMzAsIDIwMjEgYXQg
MDI6NDg6MTVQTSArMDIwMCwgTWFyZWsgU3p5cHJvd3NraSB3cm90ZToKPj4+IE9uIDA4LjA2LjIw
MjEgMTg6NDUsIEFtZXkgTmFya2hlZGUgd3JvdGU6Cj4+Pj4gSWYgZGV2aWNlIHJlZ2lzdHJhdGlv
biBmYWlscywgcmVtb3ZlIHN5c2ZzIGF0dHJpYnV0ZQo+Pj4+IGFuZCBpZiBzZXR0aW5nIGJ1cyBj
YWxsYmFja3MgZmFpbHMsIHVucmVnaXN0ZXIgdGhlIGRldmljZQo+Pj4+IGFuZCBjbGVhbnVwIHRo
ZSBzeXNmcyBhdHRyaWJ1dGUuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBBbWV5IE5hcmtoZWRl
IDxhbWV5bmFya2hlZGUwM0BnbWFpbC5jb20+Cj4+PiBUaGlzIHBhdGNoIGxhbmRlZCBpbiBsaW51
eC1uZXh0IHNvbWUgdGltZSBhZ28gYXMgY29tbWl0IDI0OWM5ZGM2YWEwZAo+Pj4gKCJpb21tdS9h
cm06IENsZWFudXAgcmVzb3VyY2VzIGluIGNhc2Ugb2YgcHJvYmUgZXJyb3IgcGF0aCIpLiBBZnRl
cgo+Pj4gYmlzZWN0aW5nIGFuZCBzb21lIG1hbnVhbCBzZWFyY2hpbmcgSSBmaW5hbGx5IGZvdW5k
IHRoYXQgaXQgaXMKPj4+IHJlc3BvbnNpYmxlIGZvciBicmVha2luZyBzMmlkbGUgb24gRHJhZ29u
Qm9hcmQgNDEwYy4gSGVyZSBpcyB0aGUgbG9nCj4+PiAoY2FwdHVyZWQgd2l0aCBub19jb25zb2xl
X3N1c3BlbmQpOgo+Pj4KPj4+ICMgdGltZSBydGN3YWtlIC1zMTAgLW1tZW0KPj4+IHJ0Y3dha2U6
IHdha2V1cCBmcm9tICJtZW0iIHVzaW5nIC9kZXYvcnRjMCBhdCBUaHUgSmFuwqAgMSAwMDowMjox
MyAxOTcwCj4+PiBQTTogc3VzcGVuZCBlbnRyeSAoczJpZGxlKQo+Pj4gRmlsZXN5c3RlbXMgc3lu
YzogMC4wMDIgc2Vjb25kcwo+Pj4gRnJlZXppbmcgdXNlciBzcGFjZSBwcm9jZXNzZXMgLi4uIChl
bGFwc2VkIDAuMDA2IHNlY29uZHMpIGRvbmUuCj4+PiBPT00ga2lsbGVyIGRpc2FibGVkLgo+Pj4g
RnJlZXppbmcgcmVtYWluaW5nIGZyZWV6YWJsZSB0YXNrcyAuLi4gKGVsYXBzZWQgMC4wMDQgc2Vj
b25kcykgZG9uZS4KPj4+IFVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJl
ZmVyZW5jZSBhdCB2aXJ0dWFsIGFkZHJlc3MKPj4+IDAwMDAwMDAwMDAwMDAwNzAKPj4+IE1lbSBh
Ym9ydCBpbmZvOgo+Pj4gICAgwqAgRVNSID0gMHg5NjAwMDAwNgo+Pj4gICAgwqAgRUMgPSAweDI1
OiBEQUJUIChjdXJyZW50IEVMKSwgSUwgPSAzMiBiaXRzCj4+PiAgICDCoCBTRVQgPSAwLCBGblYg
PSAwCj4+PiAgICDCoCBFQSA9IDAsIFMxUFRXID0gMAo+Pj4gICAgwqAgRlNDID0gMHgwNjogbGV2
ZWwgMiB0cmFuc2xhdGlvbiBmYXVsdAo+Pj4gRGF0YSBhYm9ydCBpbmZvOgo+Pj4gICAgwqAgSVNW
ID0gMCwgSVNTID0gMHgwMDAwMDAwNgo+Pj4gICAgwqAgQ00gPSAwLCBXblIgPSAwCj4+PiB1c2Vy
IHBndGFibGU6IDRrIHBhZ2VzLCA0OC1iaXQgVkFzLCBwZ2RwPTAwMDAwMDAwOGFkMDgwMDAKPj4+
IFswMDAwMDAwMDAwMDAwMDcwXSBwZ2Q9MDgwMDAwMDA4NWMzYzAwMywgcDRkPTA4MDAwMDAwODVj
M2MwMDMsCj4+PiBwdWQ9MDgwMDAwMDA4OGRjZjAwMywgcG1kPTAwMDAwMDAwMDAwMDAwMDAKPj4+
IEludGVybmFsIGVycm9yOiBPb3BzOiA5NjAwMDAwNiBbIzFdIFBSRUVNUFQgU01QCj4+PiBNb2R1
bGVzIGxpbmtlZCBpbjogYmx1ZXRvb3RoIGVjZGhfZ2VuZXJpYyBlY2MgcmZraWxsIGlwdjYgYXg4
ODc5NmIKPj4+IHZlbnVzX2VuYyB2ZW51c19kZWMgdmlkZW9idWYyX2RtYV9jb250aWcgYXNpeCBj
cmN0MTBkaWZfY2UgYWR2NzUxMQo+Pj4gc25kX3NvY19tc204OTE2X2FuYWxvZyBxY29tX3NwbWlf
dGVtcF9hbGFybSBydGNfcG04eHh4IHFjb21fcG9uCj4+PiBxY29tX2NhbXNzIHFjb21fc3BtaV92
YWRjIHZpZGVvYnVmMl9kbWFfc2cgcWNvbV92YWRjX2NvbW1vbiBtc20KPj4+IHZlbnVzX2NvcmUg
djRsMl9md25vZGUgdjRsMl9hc3luYyBzbmRfc29jX21zbTg5MTZfZGlnaXRhbAo+Pj4gdmlkZW9i
dWYyX21lbW9wcyBzbmRfc29jX2xwYXNzX2FwcTgwMTYgc25kX3NvY19scGFzc19jcHUgdjRsMl9t
ZW0ybWVtCj4+PiBzbmRfc29jX2xwYXNzX3BsYXRmb3JtIHNuZF9zb2NfYXBxODAxNl9zYmMgdmlk
ZW9idWYyX3Y0bDIKPj4+IHNuZF9zb2NfcWNvbV9jb21tb24gcWNvbV9ybmcgdmlkZW9idWYyX2Nv
bW1vbiBpMmNfcWNvbV9jY2kgcW5vY19tc204OTE2Cj4+PiB2aWRlb2RldiBtYyBpY2Nfc21kX3Jw
bSBtZHRfbG9hZGVyIHNvY2luZm8gZGlzcGxheV9jb25uZWN0b3Igcm10ZnNfbWVtCj4+PiBDUFU6
IDEgUElEOiAxNTIyIENvbW06IHJ0Y3dha2UgTm90IHRhaW50ZWQgNS4xMy4wLW5leHQtMjAyMTA2
MjkgIzM1OTIKPj4+IEhhcmR3YXJlIG5hbWU6IFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBB
UFEgODAxNiBTQkMgKERUKQo+Pj4gcHN0YXRlOiA4MDAwMDAwNSAoTnpjdiBkYWlmIC1QQU4gLVVB
TyAtVENPIEJUWVBFPS0tKQo+Pj4gcGMgOiBtc21fcnVudGltZV9zdXNwZW5kKzB4MWMvMHg2MCBb
bXNtXQo+Pj4gbHIgOiBtc21fcG1fc3VzcGVuZCsweDE4LzB4MzggW21zbV0KPj4+IC4uLgo+Pj4g
Q2FsbCB0cmFjZToKPj4+ICAgIMKgbXNtX3J1bnRpbWVfc3VzcGVuZCsweDFjLzB4NjAgW21zbV0K
Pj4+ICAgIMKgbXNtX3BtX3N1c3BlbmQrMHgxOC8weDM4IFttc21dCj4+PiAgICDCoGRwbV9ydW5f
Y2FsbGJhY2srMHg4NC8weDM3OAo+PiBJIHdvbmRlciBpZiB3ZSdyZSBtaXNzaW5nIGEgcG1fcnVu
dGltZV9kaXNhYmxlKCkgY2FsbCBvbiB0aGUgZmFpbHVyZSBwYXRoPwo+PiBpLmUuIHNvbWV0aGlu
ZyBsaWtlIHRoZSBkaWZmIGJlbG93Li4uCj4gCj4gSSd2ZSBjaGVja2VkIGFuZCBpdCBkb2Vzbid0
IGZpeCBhbnl0aGluZy4KCldoYXQncyBoYXBwZW5lZCBwcmV2aW91c2x5PyBIYXMgYW4gSU9NTVUg
YWN0dWFsbHkgZmFpbGVkIHRvIHByb2JlLCBvciBpcyAKdGhpcyBhIGZpZGRseSAiY29kZSBtb3Zl
bWVudCB1bnZlaWxzIGxhdGVudCBidWcgZWxzZXdoZXJlIiBraW5kIG9mIAp0aGluZz8gVGhlcmUg
ZG9lc24ndCBsb29rIHRvIGJlIG11Y2ggY2FwYWJsZSBvZiBnb2luZyB3cm9uZyBpbiAKbXNtX3J1
bnRpbWVfc3VzcGVuZCgpIGl0c2VsZiwgc28gaXMgdGhlIERSTSBkcml2ZXIgYWxzbyBpbiBhIGJy
b2tlbiAKaGFsZi1wcm9iZWQgc3RhdGUgd2hlcmUgaXQncyBsZWZ0IGl0cyBwbV9ydW50aW1lX29w
cyBiZWhpbmQgd2l0aG91dCBpdHMgCmRydmRhdGEgYmVpbmcgdmFsaWQ/CgpSb2Jpbi4KCj4gCj4+
IFdpbGwKPj4KPj4gLS0tPjgKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvYXJtL2Fy
bS1zbW11L3Fjb21faW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L3Fjb21faW9t
bXUuYwo+PiBpbmRleCAyNWVkNDQ0ZmY5NGQuLmNlOGYzNTQ3NTVkMCAxMDA2NDQKPj4gLS0tIGEv
ZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvcWNvbV9pb21tdS5jCj4+ICsrKyBiL2RyaXZlcnMv
aW9tbXUvYXJtL2FybS1zbW11L3Fjb21faW9tbXUuYwo+PiBAQCAtODM2LDE0ICs4MzYsMTQgQEAg
c3RhdGljIGludCBxY29tX2lvbW11X2RldmljZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQo+PiAgICAgICAgICAgcmV0ID0gZGV2bV9vZl9wbGF0Zm9ybV9wb3B1bGF0ZShkZXYp
Owo+PiAgICAgICAgICAgaWYgKHJldCkgewo+PiAgICAgICAgICAgICAgICAgICBkZXZfZXJyKGRl
diwgIkZhaWxlZCB0byBwb3B1bGF0ZSBpb21tdSBjb250ZXh0c1xuIik7Cj4+IC0gICAgICAgICAg
ICAgICByZXR1cm4gcmV0Owo+PiArICAgICAgICAgICAgICAgZ290byBlcnJfcG1fZGlzYWJsZTsK
Pj4gICAgICAgICAgIH0KPj4gICAgCj4+ICAgICAgICAgICByZXQgPSBpb21tdV9kZXZpY2Vfc3lz
ZnNfYWRkKCZxY29tX2lvbW11LT5pb21tdSwgZGV2LCBOVUxMLAo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBkZXZfbmFtZShkZXYpKTsKPj4gICAgICAgICAgIGlmIChy
ZXQpIHsKPj4gICAgICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICJGYWlsZWQgdG8gcmVnaXN0
ZXIgaW9tbXUgaW4gc3lzZnNcbiIpOwo+PiAtICAgICAgICAgICAgICAgcmV0dXJuIHJldDsKPj4g
KyAgICAgICAgICAgICAgIGdvdG8gZXJyX3BtX2Rpc2FibGU7Cj4+ICAgICAgICAgICB9Cj4+ICAg
IAo+PiAgICAgICAgICAgcmV0ID0gaW9tbXVfZGV2aWNlX3JlZ2lzdGVyKCZxY29tX2lvbW11LT5p
b21tdSwgJnFjb21faW9tbXVfb3BzLCBkZXYpOwo+PiBAQCAtODY5LDYgKzg2OSw5IEBAIHN0YXRp
YyBpbnQgcWNvbV9pb21tdV9kZXZpY2VfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikKPj4gICAgCj4+ICAgIGVycl9zeXNmc19yZW1vdmU6Cj4+ICAgICAgICAgICBpb21tdV9kZXZp
Y2Vfc3lzZnNfcmVtb3ZlKCZxY29tX2lvbW11LT5pb21tdSk7Cj4+ICsKPj4gK2Vycl9wbV9kaXNh
YmxlOgo+PiArICAgICAgIHBtX3J1bnRpbWVfZGlzYWJsZShkZXYpOwo+PiAgICAgICAgICAgcmV0
dXJuIHJldDsKPj4gICAgfQo+Pgo+IEJlc3QgcmVnYXJkcwo+IApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
