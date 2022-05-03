Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A303C433F5
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 16:34:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF39A82735;
	Tue,  3 May 2022 16:34:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z4F_zru3o2CC; Tue,  3 May 2022 16:34:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6B7AD823F6;
	Tue,  3 May 2022 16:34:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52370C0032;
	Tue,  3 May 2022 16:34:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1802FC002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 16:34:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC44C60B09
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 16:34:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C01hxbiN3Q3h for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 16:34:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 727F560AFF
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 16:34:15 +0000 (UTC)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kt57H5zF8z67MnZ;
 Wed,  4 May 2022 00:31:07 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Tue, 3 May 2022 18:34:11 +0200
Received: from A2006125610.china.huawei.com (10.202.227.178) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 3 May 2022 17:34:04 +0100
To: <linux-arm-kernel@lists.infradead.org>, <linux-acpi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Subject: [PATCH v12 0/9] ACPI/IORT: Support for IORT RMR node
Date: Tue, 3 May 2022 17:33:21 +0100
Message-ID: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.202.227.178]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Cc: robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, hch@infradead.org, guohanjun@huawei.com,
 Sami.Mujawar@arm.com, will@kernel.org, wanghuiqiang@huawei.com
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
From: Shameer Kolothum via iommu <iommu@lists.linux-foundation.org>
Reply-To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkKCnYxMSAtLT4gdjEyCiAgLU1pbm9yIGZpeCBpbiBwYXRjaCAjNCB0byBhZGRyZXNzIHRoZSBp
c3N1ZSByZXBvcnRlZCBieSB0aGUga2VybmVsIHRlc3Qgcm9ib3QuCiAgLUFkZGVkIFItYnkgdGFn
cyBieSBDaHJpc3RvcGgocGF0Y2ggIzEpIGFuZCBMb3JlbnpvKHBhdGNoICM0KS4KICAtQWRkZWQg
VC1ieSBmcm9tIFN0ZXZlIHRvIGFsbCByZWxldmFudCBwYXRjaGVzLiBNYW55IHRoYW5rcyEuCgpQ
bGVhc2Ugbm90ZSwgdGhpcyBzZXJpZXMgaGFzIGEgZGVwZW5kZW5jeSBvbiB0aGUgQUNQSUNBIGhl
YWRlciBwYXRjaApoZXJlWzFdLiAKClBsZWFzZSB0YWtlIGEgbG9vayBhbmQgbGV0IG1lIGtub3cu
CgpUaGFua3MsClNoYW1lZXIKWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC80NDYxMDM2
MS5mTURRaWRjQzZHQGtyZWFjaGVyLwoKRnJvbSBvbGQ6CldlIGhhdmUgZmFjZWQgaXNzdWVzIHdp
dGggMzQwOGlNUiBSQUlEIGNvbnRyb2xsZXIgY2FyZHMgd2hpY2gKZmFpbCB0byBib290IHdoZW4g
U01NVSBpcyBlbmFibGVkLiBUaGlzIGlzIGJlY2F1c2UgdGhlc2UKY29udHJvbGxlcnMgbWFrZSB1
c2Ugb2YgaG9zdCBtZW1vcnkgZm9yIHZhcmlvdXMgY2FjaGluZyByZWxhdGVkCnB1cnBvc2VzIGFu
ZCB3aGVuIFNNTVUgaXMgZW5hYmxlZCB0aGUgaU1SIGZpcm13YXJlIGZhaWxzIHRvCmFjY2VzcyB0
aGVzZSBtZW1vcnkgcmVnaW9ucyBhcyB0aGVyZSBpcyBubyBtYXBwaW5nIGZvciB0aGVtLgpJT1JU
IFJNUiBwcm92aWRlcyBhIHdheSBmb3IgVUVGSSB0byBkZXNjcmliZSBhbmQgcmVwb3J0IHRoZXNl
Cm1lbW9yeSByZWdpb25zIHNvIHRoYXQgdGhlIGtlcm5lbCBjYW4gbWFrZSBhIHVuaXR5IG1hcHBp
bmcgZm9yCnRoZXNlIGluIFNNTVUuCgpDaGFuZ2UgSGlzdG9yeToKCnYxMCAtLT4gdjExCsKgLUFk
ZHJlc3NlZCBDaHJpc3RvcGgncyBjb21tZW50cy4gV2Ugbm93IGhhdmUgYSDCoGNhbGxiYWNrIHRv
IAogIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbiB0byBmcmVlIGFsbCByZWxhdGVkIG1lbW9yeSBh
bmQgYWxzb8KgZHJvcHBlZAogIHRoZSBGVyBzcGVjaWZpYyB1bmlvbiBhbmQgbm93IGhhcyBhIGNv
bnRhaW5lciBzdHJ1Y3QgaW9tbXVfaW9ydF9ybXJfZGF0YS4KICBTZWUgcGF0Y2hlcyAjMSAmICM0
CiAtQWRkZWQgUi1ieSBmcm9tIENocmlzdG9waC4KIC1Ecm9wcGVkIFItYnkgZnJvbSBMb3Jlbnpv
IGZvciBwYXRjaGVzICM0ICYgIzUgZHVlIHRvIHRoZSBhYm92ZSBjaGFuZ2VzLgogLUFsc28gZHJv
cHBlZCBULWJ5IGZyb20gU3RldmUgYW5kIExhdXJlbnRpdS4gTWFueSB0aGFua3PCoGZvciB5b3Vy
IHRlc3QKICBlZmZvcnRzLiBJIGhhdmXCoGRvbmUgYmFzaWMgc2FuaXR5IHRlc3Rpbmcgb24gbXkg
cGxhdGZvcm0gYnV0IHBsZWFzZQogIGRvIGl0IGFnYWluIGF0IHlvdXIgZW5kLgoKdjkgLS0+IHYx
MAogLSBEcm9wcGVkIHBhdGNoICMxICgiQWRkIHRlbXBvcmFyeSBSTVIgbm9kZSBmbGFnIGRlZmlu
aXRpb25zIikgc2luY2UKICAgdGhlIEFDUElDQSBoZWFkZXIgdXBkYXRlcyBwYXRjaCBpcyBub3cg
aW4gdGhlIG1haWxpbmcgbGlzdAogLSBCYXNlZCBvbiB0aGUgc3VnZ2VzdGlvbiBmcm9tIENocmlz
dG9waCwgaW50cm9kdWNlZCBhIAogICByZXN2X3JlZ2lvbl9mcmVlX2Z3X2RhdGEoKSBjYWxsYmFj
ayBpbiBzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gYW5kCiAgIHVzZWQgdGhhdCB0byBmcmVlIFJN
UiBzcGVjaWZpYyBtZW1vcnkgYWxsb2NhdGlvbnMuCgp2OCAtLT4gdjkKwqAtIEFkcmVzc2VkIGNv
bW1lbnRzIGZyb20gUm9iaW4gb24gaW50ZXJmYWNlcy4KwqAtIEFkZHJlc3NlZCBjb21tZW50cyBm
cm9tIExvcmVuem8uCgp2NyAtLT4gdjgKwqAgLSBQYXRjaCAjMSBoYXMgdGVtcCBkZWZpbml0aW9u
cyBmb3IgUk1SIHJlbGF0ZWQgY2hhbmdlcyB0aWxsCsKgIMKgIHRoZSBBQ1BJQ0EgaGVhZGVyIGNo
YW5nZXMgYXJlIHBhcnQgb2Yga2VybmVsLgrCoCAtIE5vIGVhcmx5IHBhcnNpbmcgb2YgUk1SIG5v
ZGUgaW5mbyBhbmQgaXMgb25seSBwYXJzZWQgYXQgdGhlCsKgIMKgIHRpbWUgb2YgdXNlLgrCoCAt
IENoYW5nZXMgdG8gdGhlIFJNUiBnZXQvcHV0IEFQSSBmb3JtYXQgY29tcGFyZWQgdG8gdGhlCsKg
IMKgIHByZXZpb3VzIHZlcnNpb24uCsKgIC0gU3VwcG9ydCBmb3IgUk1SIGRlc2NyaXB0b3Igc2hh
cmVkIGJ5IG11bHRpcGxlIHN0cmVhbSBJRHMuCgp2NiAtLT4gdjcKwqAtZml4IHBvaW50ZWQgb3V0
IGJ5IFN0ZXZlIHRvIHRoZSBTTU1VdjIgU01SIGJ5cGFzcyBpbnN0YWxsIGluIHBhdGNoICM4LgoK
djUgLS0+IHY2Ci0gQWRkcmVzc2VkIGNvbW1lbnRzIGZyb20gUm9iaW4gJiBMb3JlbnpvLgrCoCA6
IE1vdmVkIGlvcnRfcGFyc2Vfcm1yKCkgdG8gYWNwaV9pb3J0X2luaXQoKSBmcm9tCsKgIMKgIGlv
cnRfaW5pdF9wbGF0Zm9ybV9kZXZpY2VzKCkuCsKgIDogUmVtb3ZlZCB1c2Ugb2Ygc3RydWN0IGlv
cnRfcm1yX2VudHJ5IGR1cmluZyB0aGUgaW5pdGlhbArCoCDCoCBwYXJzZS4gVXNpbmcgc3RydWN0
IGlvbW11X3Jlc3ZfcmVnaW9uIGluc3RlYWQuCsKgIDogUmVwb3J0IFJNUiBhZGRyZXNzIGFsaWdu
bWVudCBhbmQgb3ZlcmxhcCBlcnJvcnMsIGJ1dCBjb250aW51ZS4KwqAgOiBSZXdvcmtlZCBhcm1f
c21tdV9pbml0X2J5cGFzc19zdGVzKCkgKHBhdGNoICMgNikuCi0gVXBkYXRlZCBTTU1VdjIgYnlw
YXNzIFNNUiBjb2RlLiBUaGFua3MgdG8gSm9uIE4gKHBhdGNoICM4KS4KLSBTZXQgSU9NTVUgcHJv
dGVjdGlvbiBmbGFncyhJT01NVV9DQUNIRSwgSU9NTVVfTU1JTykgYmFzZWQKwqAgb24gVHlwZSBv
ZiBSTVIgcmVnaW9uLiBTdWdnZXN0ZWQgYnkgSm9uIE4uCgp2NCAtLT4gdjUKwqAtQWRkZWQgYSBm
d19kYXRhIHVuaW9uIHRvIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbiBhbmQgcmVtb3ZlZArCoCBz
dHJ1Y3QgaW9tbXVfcm1yIChCYXNlZCBvbiBjb21tZW50cyBmcm9tIEpvZXJnL1JvYmluKS4KwqAt
QWRkZWQgaW9tbXVfcHV0X3JtcnMoKSB0byByZWxlYXNlIG1lbS4KwqAtVGhhbmtzIHRvIFN0ZXZl
IGZvciB2ZXJpZnlpbmcgb24gU01NVXYyLCBidXQgbm90IGFkZGVkIHRoZSBUZXN0ZWQtYnkKwqAg
eWV0IGJlY2F1c2Ugb2YgdGhlIGFib3ZlIGNoYW5nZXMuCgp2MyAtLT52NAotSW5jbHVkZWQgdGhl
IFNNTVV2MiBTTVIgYnlwYXNzIGluc3RhbGwgY2hhbmdlcyBzdWdnZXN0ZWQgYnkKwqBTdGV2ZShw
YXRjaCAjNykKLUFzIHBlciBSb2JpbidzIGNvbW1lbnRzLCBSTVIgcmVzZXJ2ZSBpbXBsZW1lbnRh
dGlvbiBpcyBub3cKwqBtb3JlIGdlbmVyaWMgwqAocGF0Y2ggIzgpIGFuZCBkcm9wcGVkIHYzIHBh
dGNoZXMgOCBhbmQgMTAuCi1SZWJhc2UgdG8gNS4xMy1yYzEKClJGQyB2MiAtLT4gdjMKwqAtRHJv
cHBlZCBSRkMgdGFnIGFzIHRoZSBBQ1BJQ0EgaGVhZGVyIGNoYW5nZXMgYXJlIG5vdyByZWFkeSB0
byBiZQrCoCBwYXJ0IG9mIDUuMTNbMF0uIEJ1dCB0aGlzIHNlcmllcyBzdGlsbCBoYXMgYSBkZXBl
bmRlbmN5IG9uIHRoYXQgcGF0Y2guCsKgLUFkZGVkIElPUlQgRS5iIHJlbGF0ZWQgY2hhbmdlcyhu
b2RlIGZsYWdzLCBfRFNNIGZ1bmN0aW9uIDUgY2hlY2tzIGZvcgrCoCBQQ0llKS4KwqAtQ2hhbmdl
ZCBSTVIgdG8gc3RyZWFtIGlkIG1hcHBpbmcgZnJvbSBNOk4gdG8gTToxIGFzIHBlciB0aGUgc3Bl
YyBhbmQKwqAgZGlzY3Vzc2lvbiBoZXJlWzFdLgrCoC1MYXN0IHR3byBwYXRjaGVzIGFkZCBzdXBw
b3J0IGZvciBTTU1VdjIoVGhhbmtzIHRvIEpvbiBOZXR0bGV0b24hKQoKSm9uIE5ldHRsZXRvbiAo
MSk6CiAgaW9tbXUvYXJtLXNtbXU6IEdldCBhc3NvY2lhdGVkIFJNUiBpbmZvIGFuZCBpbnN0YWxs
IGJ5cGFzcyBTTVIKClNoYW1lZXIgS29sb3RodW0gKDgpOgogIGlvbW11OiBJbnRyb2R1Y2UgYSBj
YWxsYmFjayB0byBzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24KICBBQ1BJL0lPUlQ6IE1ha2UgaW9y
dF9pb21tdV9tc2lfZ2V0X3Jlc3ZfcmVnaW9ucygpIHJldHVybiB2b2lkCiAgQUNQSS9JT1JUOiBQ
cm92aWRlIGEgZ2VuZXJpYyBoZWxwZXIgdG8gcmV0cmlldmUgcmVzZXJ2ZSByZWdpb25zCiAgQUNQ
SS9JT1JUOiBBZGQgc3VwcG9ydCB0byByZXRyaWV2ZSBJT1JUIFJNUiByZXNlcnZlZCByZWdpb25z
CiAgQUNQSS9JT1JUOiBBZGQgYSBoZWxwZXIgdG8gcmV0cmlldmUgUk1SIGluZm8gZGlyZWN0bHkK
ICBpb21tdS9hcm0tc21tdS12MzogSW50cm9kdWNlIHN0cnRhYiBpbml0IGhlbHBlcgogIGlvbW11
L2FybS1zbW11LXYzOiBSZWZhY3RvciBhcm1fc21tdV9pbml0X2J5cGFzc19zdGVzKCkgdG8gZm9y
Y2UKICAgIGJ5cGFzcwogIGlvbW11L2FybS1zbW11LXYzOiBHZXQgYXNzb2NpYXRlZCBSTVIgaW5m
byBhbmQgaW5zdGFsbCBieXBhc3MgU1RFCgogZHJpdmVycy9hY3BpL2FybTY0L2lvcnQuYyAgICAg
ICAgICAgICAgICAgICB8IDM2MCArKysrKysrKysrKysrKysrKystLQogZHJpdmVycy9pb21tdS9h
cm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyB8ICA3OCArKysrLQogZHJpdmVycy9pb21tdS9h
cm0vYXJtLXNtbXUvYXJtLXNtbXUuYyAgICAgICB8ICA1MiArKysKIGRyaXZlcnMvaW9tbXUvZG1h
LWlvbW11LmMgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0KIGRyaXZlcnMvaW9tbXUvaW9tbXUu
YyAgICAgICAgICAgICAgICAgICAgICAgfCAgMTYgKy0KIGluY2x1ZGUvbGludXgvYWNwaV9pb3J0
LmggICAgICAgICAgICAgICAgICAgfCAgMTQgKy0KIGluY2x1ZGUvbGludXgvaW9tbXUuaCAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMTAgKwogNyBmaWxlcyBjaGFuZ2VkLCA0ODYgaW5zZXJ0aW9u
cygrKSwgNDYgZGVsZXRpb25zKC0pCgotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
