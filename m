Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886A8C433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 14:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C54F60B69;
	Thu, 28 Apr 2022 14:43:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TRuBf1mvXcY5; Thu, 28 Apr 2022 14:43:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8EFCC60A88;
	Thu, 28 Apr 2022 14:43:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 422D4C0032;
	Thu, 28 Apr 2022 14:43:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 233B3C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1022F40155
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:43:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ilFuzvDYLSDF for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 14:43:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id B89F1400BF
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 14:43:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 917281474;
 Thu, 28 Apr 2022 07:43:49 -0700 (PDT)
Received: from [10.1.31.24] (e122027.cambridge.arm.com [10.1.31.24])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79F853F5A1;
 Thu, 28 Apr 2022 07:43:47 -0700 (PDT)
Message-ID: <242c9f39-a604-1ef7-77ab-b50ec4eac359@arm.com>
Date: Thu, 28 Apr 2022 15:43:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v11 0/9] ACPI/IORT: Support for IORT RMR node
Content-Language: en-GB
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20220422162907.1276-1-shameerali.kolothum.thodi@huawei.com>
From: Steven Price <steven.price@arm.com>
In-Reply-To: <20220422162907.1276-1-shameerali.kolothum.thodi@huawei.com>
Cc: robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
 hch@infradead.org, guohanjun@huawei.com, Sami.Mujawar@arm.com, will@kernel.org,
 wanghuiqiang@huawei.com
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

T24gMjIvMDQvMjAyMiAxNzoyOCwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToKPiBIaQo+IAo+IHY5
IC0tPiB2MTAKPiDCoC1BZGRyZXNzZWQgQ2hyaXN0b3BoJ3MgY29tbWVudHMuIFdlIG5vdyBoYXZl
IGEgY2FsbGJhY2sgdG8gCj4gICBzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gdG8gZnJlZSBhbGwg
cmVsYXRlZCBtZW1vcnkgYW5kIGFsc28gZHJvcHBlZAo+ICAgdGhlIEZXIHNwZWNpZmljIHVuaW9u
IGFuZCBub3cgaGFzIGEgY29udGFpbmVyIHN0cnVjdCBpb21tdV9pb3J0X3Jtcl9kYXRhLgo+ICAg
U2VlIHBhdGNoZXMgIzEgJiAjNAo+ICAtQWRkZWQgUi1ieSBmcm9tIENocmlzdG9waC4KPiAgLURy
b3BwZWQgUi1ieSBmcm9tIExvcmVuem8gZm9yIHBhdGNoZXMgIzQgJiAjNSBkdWUgdG8gdGhlIGFi
b3ZlIGNoYW5nZXMuCj4gIC1BbHNvIGRyb3BwZWQgVC1ieSBmcm9tIFN0ZXZlIGFuZCBMYXVyZW50
aXUuIE1hbnkgdGhhbmtzwqBmb3IgeW91ciB0ZXN0Cj4gICBlZmZvcnRzLiBJIGhhdmXCoGRvbmUg
YmFzaWMgc2FuaXR5IHRlc3Rpbmcgb24gbXkgcGxhdGZvcm0gYnV0IHBsZWFzZQo+ICAgZ2l2ZSBp
dCBhIHRyeSBhdCB5b3VyIGVuZCBhcyB3ZWxsLgoKSSdtIGJhY2sgaW4gdGhlIG9mZmljZSBhbmQg
Z2l2ZW4gaXQgYSBzcGluLCBpdCdzIGFsbCBnb29kOgoKVGVzdGVkLWJ5OiBTdGV2ZW4gUHJpY2Ug
PHN0ZXZlbi5wcmljZUBhcm0uY29tPgoKVGhhbmtzLAoKU3RldmUKCj4gCj4gQXMgbWVudGlvbmVk
IGluIHYxMCwgdGhpcyBub3cgaGFzIGEgZGVwZW5kZW5jeSBvbiB0aGUgQUNQSUNBIGhlYWRlciBw
YXRjaAo+IGhlcmVbMV0uIAo+IAo+IFBsZWFzZSB0YWtlIGEgbG9vayBhbmQgbGV0IG1lIGtub3cu
Cj4gCj4gVGhhbmtzLAo+IFNoYW1lZXIKPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
LzQ0NjEwMzYxLmZNRFFpZGNDNkdAa3JlYWNoZXIvCj4gCj4gRnJvbSBvbGQ6Cj4gV2UgaGF2ZSBm
YWNlZCBpc3N1ZXMgd2l0aCAzNDA4aU1SIFJBSUQgY29udHJvbGxlciBjYXJkcyB3aGljaAo+IGZh
aWwgdG8gYm9vdCB3aGVuIFNNTVUgaXMgZW5hYmxlZC4gVGhpcyBpcyBiZWNhdXNlIHRoZXNlCj4g
Y29udHJvbGxlcnMgbWFrZSB1c2Ugb2YgaG9zdCBtZW1vcnkgZm9yIHZhcmlvdXMgY2FjaGluZyBy
ZWxhdGVkCj4gcHVycG9zZXMgYW5kIHdoZW4gU01NVSBpcyBlbmFibGVkIHRoZSBpTVIgZmlybXdh
cmUgZmFpbHMgdG8KPiBhY2Nlc3MgdGhlc2UgbWVtb3J5IHJlZ2lvbnMgYXMgdGhlcmUgaXMgbm8g
bWFwcGluZyBmb3IgdGhlbS4KPiBJT1JUIFJNUiBwcm92aWRlcyBhIHdheSBmb3IgVUVGSSB0byBk
ZXNjcmliZSBhbmQgcmVwb3J0IHRoZXNlCj4gbWVtb3J5IHJlZ2lvbnMgc28gdGhhdCB0aGUga2Vy
bmVsIGNhbiBtYWtlIGEgdW5pdHkgbWFwcGluZyBmb3IKPiB0aGVzZSBpbiBTTU1VLgo+IAo+IENo
YW5nZSBIaXN0b3J5Ogo+IAo+IHY5IC0tPiB2MTAKPiAgLSBEcm9wcGVkIHBhdGNoICMxICgiQWRk
IHRlbXBvcmFyeSBSTVIgbm9kZSBmbGFnIGRlZmluaXRpb25zIikgc2luY2UKPiAgICB0aGUgQUNQ
SUNBIGhlYWRlciB1cGRhdGVzIHBhdGNoIGlzIG5vdyBpbiB0aGUgbWFpbGluZyBsaXN0Cj4gIC0g
QmFzZWQgb24gdGhlIHN1Z2dlc3Rpb24gZnJvbSBDaHJpc3RvcGgsIGludHJvZHVjZWQgYSAKPiAg
ICByZXN2X3JlZ2lvbl9mcmVlX2Z3X2RhdGEoKSBjYWxsYmFjayBpbiBzdHJ1Y3QgaW9tbXVfcmVz
dl9yZWdpb24gYW5kCj4gICAgdXNlZCB0aGF0IHRvIGZyZWUgUk1SIHNwZWNpZmljIG1lbW9yeSBh
bGxvY2F0aW9ucy4KPiAKPiB2OCAtLT4gdjkKPiDCoC0gQWRyZXNzZWQgY29tbWVudHMgZnJvbSBS
b2JpbiBvbiBpbnRlcmZhY2VzLgo+IMKgLSBBZGRyZXNzZWQgY29tbWVudHMgZnJvbSBMb3Jlbnpv
Lgo+IAo+IHY3IC0tPiB2OAo+IMKgIC0gUGF0Y2ggIzEgaGFzIHRlbXAgZGVmaW5pdGlvbnMgZm9y
IFJNUiByZWxhdGVkIGNoYW5nZXMgdGlsbAo+IMKgIMKgIHRoZSBBQ1BJQ0EgaGVhZGVyIGNoYW5n
ZXMgYXJlIHBhcnQgb2Yga2VybmVsLgo+IMKgIC0gTm8gZWFybHkgcGFyc2luZyBvZiBSTVIgbm9k
ZSBpbmZvIGFuZCBpcyBvbmx5IHBhcnNlZCBhdCB0aGUKPiDCoCDCoCB0aW1lIG9mIHVzZS4KPiDC
oCAtIENoYW5nZXMgdG8gdGhlIFJNUiBnZXQvcHV0IEFQSSBmb3JtYXQgY29tcGFyZWQgdG8gdGhl
Cj4gwqAgwqAgcHJldmlvdXMgdmVyc2lvbi4KPiDCoCAtIFN1cHBvcnQgZm9yIFJNUiBkZXNjcmlw
dG9yIHNoYXJlZCBieSBtdWx0aXBsZSBzdHJlYW0gSURzLgo+IAo+IHY2IC0tPiB2Nwo+IMKgLWZp
eCBwb2ludGVkIG91dCBieSBTdGV2ZSB0byB0aGUgU01NVXYyIFNNUiBieXBhc3MgaW5zdGFsbCBp
biBwYXRjaCAjOC4KPiAKPiB2NSAtLT4gdjYKPiAtIEFkZHJlc3NlZCBjb21tZW50cyBmcm9tIFJv
YmluICYgTG9yZW56by4KPiDCoCA6IE1vdmVkIGlvcnRfcGFyc2Vfcm1yKCkgdG8gYWNwaV9pb3J0
X2luaXQoKSBmcm9tCj4gwqAgwqAgaW9ydF9pbml0X3BsYXRmb3JtX2RldmljZXMoKS4KPiDCoCA6
IFJlbW92ZWQgdXNlIG9mIHN0cnVjdCBpb3J0X3Jtcl9lbnRyeSBkdXJpbmcgdGhlIGluaXRpYWwK
PiDCoCDCoCBwYXJzZS4gVXNpbmcgc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uIGluc3RlYWQuCj4g
wqAgOiBSZXBvcnQgUk1SIGFkZHJlc3MgYWxpZ25tZW50IGFuZCBvdmVybGFwIGVycm9ycywgYnV0
IGNvbnRpbnVlLgo+IMKgIDogUmV3b3JrZWQgYXJtX3NtbXVfaW5pdF9ieXBhc3Nfc3RlcygpIChw
YXRjaCAjIDYpLgo+IC0gVXBkYXRlZCBTTU1VdjIgYnlwYXNzIFNNUiBjb2RlLiBUaGFua3MgdG8g
Sm9uIE4gKHBhdGNoICM4KS4KPiAtIFNldCBJT01NVSBwcm90ZWN0aW9uIGZsYWdzKElPTU1VX0NB
Q0hFLCBJT01NVV9NTUlPKSBiYXNlZAo+IMKgIG9uIFR5cGUgb2YgUk1SIHJlZ2lvbi4gU3VnZ2Vz
dGVkIGJ5IEpvbiBOLgo+IAo+IHY0IC0tPiB2NQo+IMKgLUFkZGVkIGEgZndfZGF0YSB1bmlvbiB0
byBzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gYW5kIHJlbW92ZWQKPiDCoCBzdHJ1Y3QgaW9tbXVf
cm1yIChCYXNlZCBvbiBjb21tZW50cyBmcm9tIEpvZXJnL1JvYmluKS4KPiDCoC1BZGRlZCBpb21t
dV9wdXRfcm1ycygpIHRvIHJlbGVhc2UgbWVtLgo+IMKgLVRoYW5rcyB0byBTdGV2ZSBmb3IgdmVy
aWZ5aW5nIG9uIFNNTVV2MiwgYnV0IG5vdCBhZGRlZCB0aGUgVGVzdGVkLWJ5Cj4gwqAgeWV0IGJl
Y2F1c2Ugb2YgdGhlIGFib3ZlIGNoYW5nZXMuCj4gCj4gdjMgLS0+djQKPiAtSW5jbHVkZWQgdGhl
IFNNTVV2MiBTTVIgYnlwYXNzIGluc3RhbGwgY2hhbmdlcyBzdWdnZXN0ZWQgYnkKPiDCoFN0ZXZl
KHBhdGNoICM3KQo+IC1BcyBwZXIgUm9iaW4ncyBjb21tZW50cywgUk1SIHJlc2VydmUgaW1wbGVt
ZW50YXRpb24gaXMgbm93Cj4gwqBtb3JlIGdlbmVyaWMgwqAocGF0Y2ggIzgpIGFuZCBkcm9wcGVk
IHYzIHBhdGNoZXMgOCBhbmQgMTAuCj4gLVJlYmFzZSB0byA1LjEzLXJjMQo+IAo+IFJGQyB2MiAt
LT4gdjMKPiDCoC1Ecm9wcGVkIFJGQyB0YWcgYXMgdGhlIEFDUElDQSBoZWFkZXIgY2hhbmdlcyBh
cmUgbm93IHJlYWR5IHRvIGJlCj4gwqAgcGFydCBvZiA1LjEzWzBdLiBCdXQgdGhpcyBzZXJpZXMg
c3RpbGwgaGFzIGEgZGVwZW5kZW5jeSBvbiB0aGF0IHBhdGNoLgo+IMKgLUFkZGVkIElPUlQgRS5i
IHJlbGF0ZWQgY2hhbmdlcyhub2RlIGZsYWdzLCBfRFNNIGZ1bmN0aW9uIDUgY2hlY2tzIGZvcgo+
IMKgIFBDSWUpLgo+IMKgLUNoYW5nZWQgUk1SIHRvIHN0cmVhbSBpZCBtYXBwaW5nIGZyb20gTTpO
IHRvIE06MSBhcyBwZXIgdGhlIHNwZWMgYW5kCj4gwqAgZGlzY3Vzc2lvbiBoZXJlWzFdLgo+IMKg
LUxhc3QgdHdvIHBhdGNoZXMgYWRkIHN1cHBvcnQgZm9yIFNNTVV2MihUaGFua3MgdG8gSm9uIE5l
dHRsZXRvbiEpCj4gCj4gSm9uIE5ldHRsZXRvbiAoMSk6Cj4gICBpb21tdS9hcm0tc21tdTogR2V0
IGFzc29jaWF0ZWQgUk1SIGluZm8gYW5kIGluc3RhbGwgYnlwYXNzIFNNUgo+IAo+IFNoYW1lZXIg
S29sb3RodW0gKDgpOgo+ICAgaW9tbXU6IEludHJvZHVjZSBhIGNhbGxiYWNrIHRvIHN0cnVjdCBp
b21tdV9yZXN2X3JlZ2lvbgo+ICAgQUNQSS9JT1JUOiBNYWtlIGlvcnRfaW9tbXVfbXNpX2dldF9y
ZXN2X3JlZ2lvbnMoKSByZXR1cm4gdm9pZAo+ICAgQUNQSS9JT1JUOiBQcm92aWRlIGEgZ2VuZXJp
YyBoZWxwZXIgdG8gcmV0cmlldmUgcmVzZXJ2ZSByZWdpb25zCj4gICBBQ1BJL0lPUlQ6IEFkZCBz
dXBwb3J0IHRvIHJldHJpZXZlIElPUlQgUk1SIHJlc2VydmVkIHJlZ2lvbnMKPiAgIEFDUEkvSU9S
VDogQWRkIGEgaGVscGVyIHRvIHJldHJpZXZlIFJNUiBpbmZvIGRpcmVjdGx5Cj4gICBpb21tdS9h
cm0tc21tdS12MzogSW50cm9kdWNlIHN0cnRhYiBpbml0IGhlbHBlcgo+ICAgaW9tbXUvYXJtLXNt
bXUtdjM6IFJlZmFjdG9yIGFybV9zbW11X2luaXRfYnlwYXNzX3N0ZXMoKSB0byBmb3JjZQo+ICAg
ICBieXBhc3MKPiAgIGlvbW11L2FybS1zbW11LXYzOiBHZXQgYXNzb2NpYXRlZCBSTVIgaW5mbyBh
bmQgaW5zdGFsbCBieXBhc3MgU1RFCj4gCj4gIGRyaXZlcnMvYWNwaS9hcm02NC9pb3J0LmMgICAg
ICAgICAgICAgICAgICAgfCAzNTkgKysrKysrKysrKysrKysrKysrLS0KPiAgZHJpdmVycy9pb21t
dS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyB8ICA3OCArKysrLQo+ICBkcml2ZXJzL2lv
bW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jICAgICAgIHwgIDUyICsrKwo+ICBkcml2ZXJzL2lv
bW11L2RtYS1pb21tdS5jICAgICAgICAgICAgICAgICAgIHwgICAyICstCj4gIGRyaXZlcnMvaW9t
bXUvaW9tbXUuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgMTYgKy0KPiAgaW5jbHVkZS9saW51
eC9hY3BpX2lvcnQuaCAgICAgICAgICAgICAgICAgICB8ICAxNCArLQo+ICBpbmNsdWRlL2xpbnV4
L2lvbW11LmggICAgICAgICAgICAgICAgICAgICAgIHwgIDEwICsKPiAgNyBmaWxlcyBjaGFuZ2Vk
LCA0ODUgaW5zZXJ0aW9ucygrKSwgNDYgZGVsZXRpb25zKC0pCj4gCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
