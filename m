Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AD1C433EF
	for <iommu@archiver.kernel.org>; Fri, 17 Jun 2022 12:41:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34A9640889;
	Fri, 17 Jun 2022 12:41:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 34A9640889
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1MN-XFG1fE_b; Fri, 17 Jun 2022 12:41:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8D2C340917;
	Fri, 17 Jun 2022 12:41:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D2C340917
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59C84C0032;
	Fri, 17 Jun 2022 12:41:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B720BC002D
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 12:41:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8FAA1612DB
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 12:41:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8FAA1612DB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k5B-InL2KHUW for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jun 2022 12:41:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C21560E51
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4C21560E51
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jun 2022 12:41:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D27F12FC;
 Fri, 17 Jun 2022 05:41:38 -0700 (PDT)
Received: from [10.1.31.15] (e122027.cambridge.arm.com [10.1.31.15])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D734A3F7F5;
 Fri, 17 Jun 2022 05:41:35 -0700 (PDT)
Message-ID: <03b03d88-87cd-0b29-863b-2cb2a9a117d1@arm.com>
Date: Fri, 17 Jun 2022 13:41:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
Content-Language: en-GB
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
From: Steven Price <steven.price@arm.com>
In-Reply-To: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
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

T24gMTUvMDYvMjAyMiAxMToxMCwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToKPiBIaQo+IAo+IHYx
MiAtLT4gdjEzCj4gICAtTm8gY2hhbmdlcy4gUmViYXNlZCB0byA1LjE5LXJjMS4KPiAgIC1QaWNr
ZWQgdXAgdGFncyByZWNlaXZlZCBmcm9tIExhdXJlbnRpdSwgSGFuanVuIGFuZCBXaWxsLiBUaGFu
a3MhLgoKWW91J3ZlIGFscmVhZHkgZ290IG15IFRlc3RlZC1ieSB0YWdzLCBidXQganVzdCB0byBj
b25maXJtIEkgZ2F2ZSB0aGlzIGEKc3BpbiBhbmQgaXQgd29ya3MgZmluZS4KClRoYW5rcywKClN0
ZXZlCgo+IAo+IFRoYW5rcywKPiBTaGFtZWVyCj4gCj4gRnJvbSBvbGQ6Cj4gV2UgaGF2ZSBmYWNl
ZCBpc3N1ZXMgd2l0aCAzNDA4aU1SIFJBSUQgY29udHJvbGxlciBjYXJkcyB3aGljaAo+IGZhaWwg
dG8gYm9vdCB3aGVuIFNNTVUgaXMgZW5hYmxlZC4gVGhpcyBpcyBiZWNhdXNlIHRoZXNlCj4gY29u
dHJvbGxlcnMgbWFrZSB1c2Ugb2YgaG9zdCBtZW1vcnkgZm9yIHZhcmlvdXMgY2FjaGluZyByZWxh
dGVkCj4gcHVycG9zZXMgYW5kIHdoZW4gU01NVSBpcyBlbmFibGVkIHRoZSBpTVIgZmlybXdhcmUg
ZmFpbHMgdG8KPiBhY2Nlc3MgdGhlc2UgbWVtb3J5IHJlZ2lvbnMgYXMgdGhlcmUgaXMgbm8gbWFw
cGluZyBmb3IgdGhlbS4KPiBJT1JUIFJNUiBwcm92aWRlcyBhIHdheSBmb3IgVUVGSSB0byBkZXNj
cmliZSBhbmQgcmVwb3J0IHRoZXNlCj4gbWVtb3J5IHJlZ2lvbnMgc28gdGhhdCB0aGUga2VybmVs
IGNhbiBtYWtlIGEgdW5pdHkgbWFwcGluZyBmb3IKPiB0aGVzZSBpbiBTTU1VLgo+IAo+IENoYW5n
ZSBIaXN0b3J5Ogo+IAo+IHYxMSAtLT4gdjEyCj4gICAtTWlub3IgZml4IGluIHBhdGNoICM0IHRv
IGFkZHJlc3MgdGhlIGlzc3VlIHJlcG9ydGVkIGJ5IHRoZSBrZXJuZWwgdGVzdCByb2JvdC4KPiAg
IC1BZGRlZCBSLWJ5IHRhZ3MgYnkgQ2hyaXN0b3BoKHBhdGNoICMxKSBhbmQgTG9yZW56byhwYXRj
aCAjNCkuCj4gICAtQWRkZWQgVC1ieSBmcm9tIFN0ZXZlIHRvIGFsbCByZWxldmFudCBwYXRjaGVz
LiBNYW55IHRoYW5rcyEuCj4gCj4gdjEwIC0tPiB2MTEKPiDCoC1BZGRyZXNzZWQgQ2hyaXN0b3Bo
J3MgY29tbWVudHMuIFdlIG5vdyBoYXZlIGEgwqBjYWxsYmFjayB0byAKPiAgIHN0cnVjdCBpb21t
dV9yZXN2X3JlZ2lvbiB0byBmcmVlIGFsbCByZWxhdGVkIG1lbW9yeSBhbmQgYWxzb8KgZHJvcHBl
ZAo+ICAgdGhlIEZXIHNwZWNpZmljIHVuaW9uIGFuZCBub3cgaGFzIGEgY29udGFpbmVyIHN0cnVj
dCBpb21tdV9pb3J0X3Jtcl9kYXRhLgo+ICAgU2VlIHBhdGNoZXMgIzEgJiAjNAo+ICAtQWRkZWQg
Ui1ieSBmcm9tIENocmlzdG9waC4KPiAgLURyb3BwZWQgUi1ieSBmcm9tIExvcmVuem8gZm9yIHBh
dGNoZXMgIzQgJiAjNSBkdWUgdG8gdGhlIGFib3ZlIGNoYW5nZXMuCj4gIC1BbHNvIGRyb3BwZWQg
VC1ieSBmcm9tIFN0ZXZlIGFuZCBMYXVyZW50aXUuIE1hbnkgdGhhbmtzwqBmb3IgeW91ciB0ZXN0
Cj4gICBlZmZvcnRzLiBJIGhhdmXCoGRvbmUgYmFzaWMgc2FuaXR5IHRlc3Rpbmcgb24gbXkgcGxh
dGZvcm0gYnV0IHBsZWFzZQo+ICAgZG8gaXQgYWdhaW4gYXQgeW91ciBlbmQuCj4gCj4gdjkgLS0+
IHYxMAo+ICAtIERyb3BwZWQgcGF0Y2ggIzEgKCJBZGQgdGVtcG9yYXJ5IFJNUiBub2RlIGZsYWcg
ZGVmaW5pdGlvbnMiKSBzaW5jZQo+ICAgIHRoZSBBQ1BJQ0EgaGVhZGVyIHVwZGF0ZXMgcGF0Y2gg
aXMgbm93IGluIHRoZSBtYWlsaW5nIGxpc3QKPiAgLSBCYXNlZCBvbiB0aGUgc3VnZ2VzdGlvbiBm
cm9tIENocmlzdG9waCwgaW50cm9kdWNlZCBhIAo+ICAgIHJlc3ZfcmVnaW9uX2ZyZWVfZndfZGF0
YSgpIGNhbGxiYWNrIGluIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbiBhbmQKPiAgICB1c2VkIHRo
YXQgdG8gZnJlZSBSTVIgc3BlY2lmaWMgbWVtb3J5IGFsbG9jYXRpb25zLgo+IAo+IHY4IC0tPiB2
OQo+IMKgLSBBZHJlc3NlZCBjb21tZW50cyBmcm9tIFJvYmluIG9uIGludGVyZmFjZXMuCj4gwqAt
IEFkZHJlc3NlZCBjb21tZW50cyBmcm9tIExvcmVuem8uCj4gCj4gdjcgLS0+IHY4Cj4gwqAgLSBQ
YXRjaCAjMSBoYXMgdGVtcCBkZWZpbml0aW9ucyBmb3IgUk1SIHJlbGF0ZWQgY2hhbmdlcyB0aWxs
Cj4gwqAgwqAgdGhlIEFDUElDQSBoZWFkZXIgY2hhbmdlcyBhcmUgcGFydCBvZiBrZXJuZWwuCj4g
wqAgLSBObyBlYXJseSBwYXJzaW5nIG9mIFJNUiBub2RlIGluZm8gYW5kIGlzIG9ubHkgcGFyc2Vk
IGF0IHRoZQo+IMKgIMKgIHRpbWUgb2YgdXNlLgo+IMKgIC0gQ2hhbmdlcyB0byB0aGUgUk1SIGdl
dC9wdXQgQVBJIGZvcm1hdCBjb21wYXJlZCB0byB0aGUKPiDCoCDCoCBwcmV2aW91cyB2ZXJzaW9u
Lgo+IMKgIC0gU3VwcG9ydCBmb3IgUk1SIGRlc2NyaXB0b3Igc2hhcmVkIGJ5IG11bHRpcGxlIHN0
cmVhbSBJRHMuCj4gCj4gdjYgLS0+IHY3Cj4gwqAtZml4IHBvaW50ZWQgb3V0IGJ5IFN0ZXZlIHRv
IHRoZSBTTU1VdjIgU01SIGJ5cGFzcyBpbnN0YWxsIGluIHBhdGNoICM4Lgo+IAo+IHY1IC0tPiB2
Ngo+IC0gQWRkcmVzc2VkIGNvbW1lbnRzIGZyb20gUm9iaW4gJiBMb3JlbnpvLgo+IMKgIDogTW92
ZWQgaW9ydF9wYXJzZV9ybXIoKSB0byBhY3BpX2lvcnRfaW5pdCgpIGZyb20KPiDCoCDCoCBpb3J0
X2luaXRfcGxhdGZvcm1fZGV2aWNlcygpLgo+IMKgIDogUmVtb3ZlZCB1c2Ugb2Ygc3RydWN0IGlv
cnRfcm1yX2VudHJ5IGR1cmluZyB0aGUgaW5pdGlhbAo+IMKgIMKgIHBhcnNlLiBVc2luZyBzdHJ1
Y3QgaW9tbXVfcmVzdl9yZWdpb24gaW5zdGVhZC4KPiDCoCA6IFJlcG9ydCBSTVIgYWRkcmVzcyBh
bGlnbm1lbnQgYW5kIG92ZXJsYXAgZXJyb3JzLCBidXQgY29udGludWUuCj4gwqAgOiBSZXdvcmtl
ZCBhcm1fc21tdV9pbml0X2J5cGFzc19zdGVzKCkgKHBhdGNoICMgNikuCj4gLSBVcGRhdGVkIFNN
TVV2MiBieXBhc3MgU01SIGNvZGUuIFRoYW5rcyB0byBKb24gTiAocGF0Y2ggIzgpLgo+IC0gU2V0
IElPTU1VIHByb3RlY3Rpb24gZmxhZ3MoSU9NTVVfQ0FDSEUsIElPTU1VX01NSU8pIGJhc2VkCj4g
wqAgb24gVHlwZSBvZiBSTVIgcmVnaW9uLiBTdWdnZXN0ZWQgYnkgSm9uIE4uCj4gCj4gdjQgLS0+
IHY1Cj4gwqAtQWRkZWQgYSBmd19kYXRhIHVuaW9uIHRvIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lv
biBhbmQgcmVtb3ZlZAo+IMKgIHN0cnVjdCBpb21tdV9ybXIgKEJhc2VkIG9uIGNvbW1lbnRzIGZy
b20gSm9lcmcvUm9iaW4pLgo+IMKgLUFkZGVkIGlvbW11X3B1dF9ybXJzKCkgdG8gcmVsZWFzZSBt
ZW0uCj4gwqAtVGhhbmtzIHRvIFN0ZXZlIGZvciB2ZXJpZnlpbmcgb24gU01NVXYyLCBidXQgbm90
IGFkZGVkIHRoZSBUZXN0ZWQtYnkKPiDCoCB5ZXQgYmVjYXVzZSBvZiB0aGUgYWJvdmUgY2hhbmdl
cy4KPiAKPiB2MyAtLT52NAo+IC1JbmNsdWRlZCB0aGUgU01NVXYyIFNNUiBieXBhc3MgaW5zdGFs
bCBjaGFuZ2VzIHN1Z2dlc3RlZCBieQo+IMKgU3RldmUocGF0Y2ggIzcpCj4gLUFzIHBlciBSb2Jp
bidzIGNvbW1lbnRzLCBSTVIgcmVzZXJ2ZSBpbXBsZW1lbnRhdGlvbiBpcyBub3cKPiDCoG1vcmUg
Z2VuZXJpYyDCoChwYXRjaCAjOCkgYW5kIGRyb3BwZWQgdjMgcGF0Y2hlcyA4IGFuZCAxMC4KPiAt
UmViYXNlIHRvIDUuMTMtcmMxCj4gCj4gUkZDIHYyIC0tPiB2Mwo+IMKgLURyb3BwZWQgUkZDIHRh
ZyBhcyB0aGUgQUNQSUNBIGhlYWRlciBjaGFuZ2VzIGFyZSBub3cgcmVhZHkgdG8gYmUKPiDCoCBw
YXJ0IG9mIDUuMTNbMF0uIEJ1dCB0aGlzIHNlcmllcyBzdGlsbCBoYXMgYSBkZXBlbmRlbmN5IG9u
IHRoYXQgcGF0Y2guCj4gwqAtQWRkZWQgSU9SVCBFLmIgcmVsYXRlZCBjaGFuZ2VzKG5vZGUgZmxh
Z3MsIF9EU00gZnVuY3Rpb24gNSBjaGVja3MgZm9yCj4gwqAgUENJZSkuCj4gwqAtQ2hhbmdlZCBS
TVIgdG8gc3RyZWFtIGlkIG1hcHBpbmcgZnJvbSBNOk4gdG8gTToxIGFzIHBlciB0aGUgc3BlYyBh
bmQKPiDCoCBkaXNjdXNzaW9uIGhlcmVbMV0uCj4gwqAtTGFzdCB0d28gcGF0Y2hlcyBhZGQgc3Vw
cG9ydCBmb3IgU01NVXYyKFRoYW5rcyB0byBKb24gTmV0dGxldG9uISkKPiAKPiBKb24gTmV0dGxl
dG9uICgxKToKPiAgIGlvbW11L2FybS1zbW11OiBHZXQgYXNzb2NpYXRlZCBSTVIgaW5mbyBhbmQg
aW5zdGFsbCBieXBhc3MgU01SCj4gCj4gU2hhbWVlciBLb2xvdGh1bSAoOCk6Cj4gICBpb21tdTog
SW50cm9kdWNlIGEgY2FsbGJhY2sgdG8gc3RydWN0IGlvbW11X3Jlc3ZfcmVnaW9uCj4gICBBQ1BJ
L0lPUlQ6IE1ha2UgaW9ydF9pb21tdV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucygpIHJldHVybiB2b2lk
Cj4gICBBQ1BJL0lPUlQ6IFByb3ZpZGUgYSBnZW5lcmljIGhlbHBlciB0byByZXRyaWV2ZSByZXNl
cnZlIHJlZ2lvbnMKPiAgIEFDUEkvSU9SVDogQWRkIHN1cHBvcnQgdG8gcmV0cmlldmUgSU9SVCBS
TVIgcmVzZXJ2ZWQgcmVnaW9ucwo+ICAgQUNQSS9JT1JUOiBBZGQgYSBoZWxwZXIgdG8gcmV0cmll
dmUgUk1SIGluZm8gZGlyZWN0bHkKPiAgIGlvbW11L2FybS1zbW11LXYzOiBJbnRyb2R1Y2Ugc3Ry
dGFiIGluaXQgaGVscGVyCj4gICBpb21tdS9hcm0tc21tdS12MzogUmVmYWN0b3IgYXJtX3NtbXVf
aW5pdF9ieXBhc3Nfc3RlcygpIHRvIGZvcmNlCj4gICAgIGJ5cGFzcwo+ICAgaW9tbXUvYXJtLXNt
bXUtdjM6IEdldCBhc3NvY2lhdGVkIFJNUiBpbmZvIGFuZCBpbnN0YWxsIGJ5cGFzcyBTVEUKPiAK
PiAgZHJpdmVycy9hY3BpL2FybTY0L2lvcnQuYyAgICAgICAgICAgICAgICAgICB8IDM2MCArKysr
KysrKysrKysrKysrKystLQo+ICBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21t
dS12My5jIHwgIDc4ICsrKystCj4gIGRyaXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11
LmMgICAgICAgfCAgNTIgKysrCj4gIGRyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMgICAgICAgICAg
ICAgICAgICAgfCAgIDIgKy0KPiAgZHJpdmVycy9pb21tdS9pb21tdS5jICAgICAgICAgICAgICAg
ICAgICAgICB8ICAxNiArLQo+ICBpbmNsdWRlL2xpbnV4L2FjcGlfaW9ydC5oICAgICAgICAgICAg
ICAgICAgIHwgIDE0ICstCj4gIGluY2x1ZGUvbGludXgvaW9tbXUuaCAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMTAgKwo+ICA3IGZpbGVzIGNoYW5nZWQsIDQ4NiBpbnNlcnRpb25zKCspLCA0NiBk
ZWxldGlvbnMoLSkKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
