Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09FFC433E1
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 15:17:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A03C2073E
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 15:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="q9Bxtrvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A03C2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4DD0D885E2;
	Tue, 30 Jun 2020 15:17:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PJcK2QxwptO4; Tue, 30 Jun 2020 15:17:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4B42D885D2;
	Tue, 30 Jun 2020 15:17:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20882C0865;
	Tue, 30 Jun 2020 15:17:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB2B3C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 15:17:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A133C87CAE
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 15:17:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ogej+vf8wpjK for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 15:17:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D3F3E87ACE
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 15:17:54 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5efb57700000>; Tue, 30 Jun 2020 08:17:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 30 Jun 2020 08:17:54 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 30 Jun 2020 08:17:54 -0700
Received: from [10.26.75.203] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 15:17:47 +0000
Subject: Re: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for dual
 ARM MMU-500 usage
To: Robin Murphy <robin.murphy@arm.com>, Krishna Reddy <vdumpa@nvidia.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-2-vdumpa@nvidia.com>
 <53bfa5c8-c32d-6fa3-df60-a18ab33ca1c2@nvidia.com>
 <d59b7220-168c-419f-db16-194307e11065@arm.com>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <a9d6b11b-d904-153a-6363-6e3a8f62e03f@nvidia.com>
Date: Tue, 30 Jun 2020 16:17:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d59b7220-168c-419f-db16-194307e11065@arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593530224; bh=91KsOAnm+BDzvr6bvaKraTo/wHSaB0sGjCjoXk18ABA=;
 h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=q9BxtrvgjxBZFZAUIswW2E+r9jYacMdtRAXU31UzobonciMILCOiTgOrglSBJWXOC
 Nw3Ld3OJhRkalYzLHH6M6kaQEDByt/jtTjFRrLnlErsAZMdnejdtXGLw1KUiIWGYpb
 xAYw9H68xASCHxw1KB8ySRZZPWT/UC0ykO89X7KdmPhuSFwModgBnGKcX3mANhq4cA
 1jUaHUwaV277q2HZRs76LVNMDr7HqpnG3uB5TjwjQR+mgZW16EGe8bO4ySAU87ovHL
 KC7amklSwvERe8WmBdhZcfamoWB3m75rZDrJSuvtt9Sh3dSz214FWxGsEZkOkFxGhS
 u+d/2ZM3DBT1A==
Cc: talho@nvidia.com, treding@nvidia.com, bhuntsman@nvidia.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mperttunen@nvidia.com, nicoleotsuka@gmail.com, snikam@nvidia.com,
 nicolinc@nvidia.com, linux-tegra@vger.kernel.org, yhsu@nvidia.com,
 praithatha@nvidia.com, will@kernel.org, linux-arm-kernel@lists.infradead.org,
 bbiswas@nvidia.com
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

Ck9uIDMwLzA2LzIwMjAgMTU6NTMsIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMDIwLTA2LTMw
IDA5OjE5LCBKb24gSHVudGVyIHdyb3RlOgo+Pgo+PiBPbiAzMC8wNi8yMDIwIDAxOjEwLCBLcmlz
aG5hIFJlZGR5IHdyb3RlOgo+Pj4gTlZJRElBJ3MgVGVncmExOTQgU29DIHVzZXMgdHdvIEFSTSBN
TVUtNTAwcyB0b2dldGhlciB0byBpbnRlcmxlYXZlCj4+PiBJT1ZBIGFjY2Vzc2VzIGFjcm9zcyB0
aGVtLgo+Pj4gQWRkIE5WSURJQSBpbXBsZW1lbnRhdGlvbiBmb3IgZHVhbCBBUk0gTU1VLTUwMHMg
YW5kIGFkZCBuZXcgY29tcGF0aWJsZQo+Pj4gc3RyaW5nIGZvciBUZWdyYTE5NCBTb0MgU01NVSB0
b3BvbG9neS4KPj4KPj4gVGhlcmUgaXMgbm8gZGVzY3JpcHRpb24gaGVyZSBvZiB0aGUgM3JkIFNN
TVUgdGhhdCB5b3UgbWVudGlvbiBiZWxvdy4KPj4gSSB0aGluayB0aGF0IHdlIHNob3VsZCBkZXNj
cmliZSB0aGUgZnVsbCBwaWN0dXJlIGhlcmUuCj4+IMKgCj4+PiBTaWduZWQtb2ZmLWJ5OiBLcmlz
aG5hIFJlZGR5IDx2ZHVtcGFAbnZpZGlhLmNvbT4KCi4uLgoKPj4+ICtzdGF0aWMgdm9pZCBudmlk
aWFfc21tdV90bGJfc3luYyhzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNlICpzbW11LCBpbnQKPj4+IHBh
Z2UsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgc3luYywgaW50IHN0YXR1
cykKPj4+ICt7Cj4+PiArwqDCoMKgIHVuc2lnbmVkIGludCBkZWxheTsKPj4+ICsKPj4+ICvCoMKg
wqAgYXJtX3NtbXVfd3JpdGVsKHNtbXUsIHBhZ2UsIHN5bmMsIDApOwo+Pj4gKwo+Pj4gK8KgwqDC
oCBmb3IgKGRlbGF5ID0gMTsgZGVsYXkgPCBUTEJfTE9PUF9USU1FT1VUX0lOX1VTOyBkZWxheSAq
PSAyKSB7Cj4+Cj4+IFNvIHdlIGFyZSBkb3VibGluZyB0aGUgZGVsYXkgZXZlcnkgdGltZT8gSXMg
dGhpcyBiZXR0ZXIgdGhhbiBqdXN0IHVzaW5nCj4+IHRoZSBzYW1lIG9uIGVhY2ggbG9vcD8KPiAK
PiBUaGlzIGlzIHRoZSBzYW1lIGxvZ2ljIGFzIHRoZSBtYWluIGRyaXZlciAoc2VlIDg1MTNjODkz
MDA2OSkgLSB0aGUgc3luYwo+IGlzIGV4cGVjdGVkIHRvIGNvbXBsZXRlIHJlbGF0aXZlbHkgcXVp
Y2tseSwgaGVuY2Ugd2h5IHdlIGhhdmUgdGhlIGlubmVyCj4gc3BpbiBsb29wIHRvIGF2b2lkIHRo
ZSBkZWxheSBlbnRpcmVseSBpbiB0aGUgdHlwaWNhbCBjYXNlLCBhbmQgdGhlCj4gbG9uZ2VyIGl0
J3MgdGFraW5nLCB0aGUgbW9yZSBsaWtlbHkgaXQgaXMgdGhhdCBzb21ldGhpbmcncyB3cm9uZyBh
bmQgaXQKPiB3aWxsIG5ldmVyIGNvbXBsZXRlIGFueXdheS4gUmVhbGlzdGljYWxseSwgYSBoZWF2
aWx5IGxvYWRlZCBTTU1VIGF0IGEKPiBtb2Rlc3QgY2xvY2sgcmF0ZSBtaWdodCB0YWtlIHVzIHRo
cm91Z2ggYSBjb3VwbGUgb2YgaXRlcmF0aW9ucyBvZiB0aGUKPiBvdXRlciBsb29wLCBidXQgYmV5
b25kIHRoYXQgd2UncmUgcHJldHR5IG11Y2gganVzdCBraWxsaW5nIHRpbWUgdW50aWwgd2UKPiBk
ZWNsYXJlIGl0IHdlZGdlZCBhbmQgZ2l2ZSB1cCwgYW5kIGJ5IHRoZW4gdGhlcmUncyBub3QgbXVj
aCBwb2ludCBpbgo+IGJ1cm5pbmcgcG93ZXIgZnJhbnRpY2FsbHkgaGFtZXJpbmcgb24gdGhlIGlu
dGVyY29ubmVjdC4KCkFoIE9LLiBUaGVuIG1heWJlIHdlIHNob3VsZCBtb3ZlIHRoZSBkZWZpbml0
aW9ucyBmb3IgVExCX0xPT1BfVElNRU9VVAphbmQgVExCX1NQSU5fQ09VTlQgaW50byB0aGUgYXJt
LXNtbXUuaCBzbyB0aGF0IHdlIGNhbiB1c2UgdGhlbSBkaXJlY3RseQppbiB0aGlzIGZpbGUgaW5z
dGVhZCBvZiByZWRlZmluaW5nIHRoZW0uIFRoZW4gaXQgbWF5YmUgY2xlYXIgdGhhdCB0aGVzZQph
cmUgcGFydCBvZiB0aGUgbWFpbiBkcml2ZXIuCgogPj4+ICtzdHJ1Y3QgYXJtX3NtbXVfZGV2aWNl
ICpudmlkaWFfc21tdV9pbXBsX2luaXQoc3RydWN0IGFybV9zbW11X2RldmljZQo+Pj4gKnNtbXUp
Cj4+PiArewo+Pj4gK8KgwqDCoCB1bnNpZ25lZCBpbnQgaTsKPj4+ICvCoMKgwqAgc3RydWN0IG52
aWRpYV9zbW11ICpudmlkaWFfc21tdTsKPj4+ICvCoMKgwqAgc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShzbW11LT5kZXYpOwo+Pj4gKwo+Pj4gK8KgwqDC
oCBudmlkaWFfc21tdSA9IGRldm1fa3phbGxvYyhzbW11LT5kZXYsIHNpemVvZigqbnZpZGlhX3Nt
bXUpLAo+Pj4gR0ZQX0tFUk5FTCk7Cj4+PiArwqDCoMKgIGlmICghbnZpZGlhX3NtbXUpCj4+PiAr
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7Cj4+PiArCj4+PiArwqDCoMKg
IG52aWRpYV9zbW11LT5zbW11ID0gKnNtbXU7Cj4+PiArwqDCoMKgIC8qIEluc3RhbmNlIDAgaXMg
aW9yZW1hcHBlZCBieSBhcm0tc21tdS5jIGFmdGVyIHRoaXMgZnVuY3Rpb24KPj4+IHJldHVybnMg
Ki8KPj4+ICvCoMKgwqAgbnZpZGlhX3NtbXUtPm51bV9pbnN0ID0gMTsKPj4+ICsKPj4+ICvCoMKg
wqAgZm9yIChpID0gMTsgaSA8IE1BWF9TTU1VX0lOU1RBTkNFUzsgaSsrKSB7Cj4+PiArwqDCoMKg
wqDCoMKgwqAgc3RydWN0IHJlc291cmNlICpyZXM7Cj4+PiArCj4+PiArwqDCoMKgwqDCoMKgwqAg
cmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCBpKTsKPj4+
ICvCoMKgwqDCoMKgwqDCoCBpZiAoIXJlcykKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJy
ZWFrOwo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoMKgIG52aWRpYV9zbW11LT5iYXNlc1tpXSA9IGRl
dm1faW9yZW1hcF9yZXNvdXJjZShzbW11LT5kZXYsIHJlcyk7Cj4+PiArwqDCoMKgwqDCoMKgwqAg
aWYgKElTX0VSUihudmlkaWFfc21tdS0+YmFzZXNbaV0pKQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIEVSUl9DQVNUKG52aWRpYV9zbW11LT5iYXNlc1tpXSk7Cj4+PiArCj4+PiAr
wqDCoMKgwqDCoMKgwqAgbnZpZGlhX3NtbXUtPm51bV9pbnN0Kys7Cj4+PiArwqDCoMKgIH0KPj4+
ICsKPj4+ICvCoMKgwqAgbnZpZGlhX3NtbXUtPnNtbXUuaW1wbCA9ICZudmlkaWFfc21tdV9pbXBs
Owo+Pj4gK8KgwqDCoCAvKgo+Pj4gK8KgwqDCoMKgICogRnJlZSB0aGUgYXJtX3NtbXVfZGV2aWNl
IHN0cnVjdCBhbGxvY2F0ZWQgaW4gYXJtLXNtbXUuYy4KPj4+ICvCoMKgwqDCoCAqIE9uY2UgdGhp
cyBmdW5jdGlvbiByZXR1cm5zLCBhcm0tc21tdS5jIHdvdWxkIHVzZSBhcm1fc21tdV9kZXZpY2UK
Pj4+ICvCoMKgwqDCoCAqIGFsbG9jYXRlZCBhcyBwYXJ0IG9mIG52aWRpYV9zbW11IHN0cnVjdC4K
Pj4+ICvCoMKgwqDCoCAqLwo+Pj4gK8KgwqDCoCBkZXZtX2tmcmVlKHNtbXUtPmRldiwgc21tdSk7
Cj4+Cj4+IFdoeSBkb24ndCB3ZSBqdXN0IHN0b3JlIHRoZSBwb2ludGVyIG9mIHRoZSBzbW11IHN0
cnVjdCBwYXNzZWQgdG8gdGhpcwo+PiBmdW5jdGlvbgo+PiBpbiB0aGUgbnZpZGlhX3NtbXUgc3Ry
dWN0IGFuZCB0aGVuIHdlIGRvIG5vdCBuZWVkIHRvIGZyZWUgdGhpcyBoZXJlLgo+PiBJbiBvdGhl
cgo+PiB3b3JkcyBtYWtlIC4uLgo+Pgo+PiDCoCBzdHJ1Y3QgbnZpZGlhX3NtbXUgewo+PiDCoMKg
wqDCoHN0cnVjdCBhcm1fc21tdV9kZXZpY2XCoMKgwqAgKnNtbXU7Cj4+IMKgwqDCoMKgdW5zaWdu
ZWQgaW50wqDCoMKgwqDCoMKgwqAgbnVtX2luc3Q7Cj4+IMKgwqDCoMKgdm9pZCBfX2lvbWVtwqDC
oMKgwqDCoMKgwqAgKmJhc2VzW01BWF9TTU1VX0lOU1RBTkNFU107Cj4+IMKgIH07Cj4+Cj4+IFRo
aXMgc2VlbXMgbW9yZSBhcHByb3ByaWF0ZSwgdGhhbiBjb3B5aW5nIHRoZSBzdHJ1Y3QgYW5kIGZy
ZWVpbmcgbWVtb3J5Cj4+IGFsbG9jYXRlZCBlbHNlLXdoZXJlLgo+IAo+IEJ1dCB0aGVuIGhvdyBk
byB5b3UgZ2V0IGJhY2sgdG8gc3RydWN0IG52aWRpYV9zbW11IGdpdmVuIGp1c3QgYSBwb2ludGVy
Cj4gdG8gc3RydWN0IGFybV9zbW11X2RldmljZT8KCkFoIHllcyBvZiBjb3Vyc2UgdGhhdCBpcyB3
aGF0IEkgd2FzIG1pc3NpbmcuIEkgd29uZGVyZWQgd2hhdCB3YXMgZ29pbmcKb24gaGVyZS4gU28g
SSB0aGluayB3ZSBzaG91bGQgYWRkIGEgbmljZSBjb21tZW50IGluIHRoZSBhYm92ZSBmdW5jdGlv
bgpvZiB3aHkgd2UgYXJlIGNvcHlpbmcgdGhpcyBhbmQgY2Fubm90IHNpbXBseSBzdG9yZSB0aGUg
cG9pbnRlci4KCkNoZWVycwpKb24KCi0tIApudnB1YmxpYwpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
