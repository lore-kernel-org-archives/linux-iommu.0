Return-Path: <SRS0=TrXs=EJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C265CC2D0A3
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 10:22:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B93D206F1
	for <iommu@archiver.kernel.org>; Tue,  3 Nov 2020 10:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B93D206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D6EEC20356;
	Tue,  3 Nov 2020 10:22:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0EIe8Yj5kvrG; Tue,  3 Nov 2020 10:22:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9F4C020029;
	Tue,  3 Nov 2020 10:22:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8243DC0889;
	Tue,  3 Nov 2020 10:22:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2382C0051
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 10:21:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B07E887149
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 10:21:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lkxjRRxBTFN9 for <iommu@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 10:21:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6B0E58713F
 for <iommu@lists.linux-foundation.org>; Tue,  3 Nov 2020 10:21:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C78E2139F;
 Tue,  3 Nov 2020 02:21:57 -0800 (PST)
Received: from [10.57.54.223] (unknown [10.57.54.223])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B00D53F66E;
 Tue,  3 Nov 2020 02:21:56 -0800 (PST)
Subject: Re: Some questions about arm_lpae_install_table
To: Will Deacon <will@kernel.org>, Kunkun Jiang <jiangkunkun@huawei.com>
References: <6778678e-df81-f7e2-235d-6390ff6384ac@huawei.com>
 <20201103091130.GA4403@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e5772a9c-df32-e865-3d0b-90f24ff233c0@arm.com>
Date: Tue, 3 Nov 2020 10:21:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103091130.GA4403@willie-the-truck>
Content-Language: en-GB
Cc: wanghaibin.wang@huawei.com, iommu@lists.linux-foundation.org,
 zhukeqian1@huawei.com
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

T24gMjAyMC0xMS0wMyAwOToxMSwgV2lsbCBEZWFjb24gd3JvdGU6Cj4gT24gVHVlLCBOb3YgMDMs
IDIwMjAgYXQgMTE6MDA6MjdBTSArMDgwMCwgS3Vua3VuIEppYW5nIHdyb3RlOgo+PiBSZWNlbnRs
eSwgSSBoYXZlIHJlYWQgYW5kIGxlYXJuZWQgdGhlIGNvZGUgcmVsYXRlZCB0byBpby1wZ3RhYmxl
LWFybS5jLgo+PiBUaGVyZQo+PiBhcmUgdHdvIHF1ZXN0aW9uIG9uIGFybV9scGFlX2luc3RhbGxf
dGFibGUuCj4+Cj4+IDHjgIF0aGUgZmlyc3QKPj4KPj4+IHN0YXRpYyBhcm1fbHBhZV9pb3B0ZSBh
cm1fbHBhZV9pbnN0YWxsX3RhYmxlKGFybV9scGFlX2lvcHRlICp0YWJsZSwKPj4+ICDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFybV9scGFlX2lvcHRlICpwdGVwLAo+Pj4gIMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYXJtX2xwYWVfaW9wdGUgY3VyciwKPj4+ICDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBpb19wZ3RhYmxlX2NmZyAqY2ZnKQo+
Pj4gewo+Pj4gIMKgwqDCoMKgwqDCoMKgIGFybV9scGFlX2lvcHRlIG9sZCwgbmV3Owo+Pj4KPj4+
ICDCoMKgwqDCoMKgwqDCoCBuZXcgPSBfX3BhKHRhYmxlKSB8IEFSTV9MUEFFX1BURV9UWVBFX1RB
QkxFOwo+Pj4gIMKgwqDCoMKgwqDCoMKgIGlmIChjZmctPnF1aXJrcyAmIElPX1BHVEFCTEVfUVVJ
UktfQVJNX05TKQo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXcgfD0gQVJN
X0xQQUVfUFRFX05TVEFCTEU7Cj4+Pgo+Pj4gIMKgwqDCoMKgwqDCoCAvKgo+Pj4gIMKgwqDCoMKg
wqDCoMKgwqAgKiBFbnN1cmUgdGhlIHRhYmxlIGl0c2VsZiBpcyB2aXNpYmxlIGJlZm9yZSBpdHMg
UFRFIGNhbiBiZS4KPj4+ICDCoMKgwqDCoMKgwqDCoMKgICogV2hpbHN0IHdlIGNvdWxkIGdldCBh
d2F5IHdpdGggY21weGNoZzY0X3JlbGVhc2UgYmVsb3csIHRoaXMKPj4+ICDCoMKgwqDCoMKgwqDC
oMKgICogZG9lc24ndCBoYXZlIGFueSBvcmRlcmluZyBzZW1hbnRpY3Mgd2hlbiAhQ09ORklHX1NN
UC4KPj4+ICDCoMKgwqDCoMKgwqDCoMKgICovCj4+PiAgwqDCoMKgwqDCoMKgwqAgZG1hX3dtYigp
Owo+Pj4KPj4+ICDCoMKgwqDCoMKgwqDCoCBvbGQgPSBjbXB4Y2hnNjRfcmVsYXhlZChwdGVwLCBj
dXJyLCBuZXcpOwo+Pj4KPj4+ICDCoMKgwqDCoMKgwqDCoCBpZiAoY2ZnLT5jb2hlcmVudF93YWxr
IHx8IChvbGQgJiBBUk1fTFBBRV9QVEVfU1dfU1lOQykpCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybiBvbGQ7Cj4+Pgo+Pj4gIMKgwqDCoMKgwqDCoMKgIC8qIEV2ZW4g
aWYgaXQncyBub3Qgb3VycywgdGhlcmUncyBubyBwb2ludCB3YWl0aW5nOyBqdXN0IGtpY2sgaXQK
Pj4+ICovCj4+PiAgwqDCoMKgwqDCoMKgwqAgX19hcm1fbHBhZV9zeW5jX3B0ZShwdGVwLCBjZmcp
Owo+Pj4gIMKgwqDCoMKgwqDCoMKgIGlmIChvbGQgPT0gY3VycikKPj4+ICDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgV1JJVEVfT05DRSgqcHRlcCwgbmV3IHwgQVJNX0xQQUVfUFRFX1NX
X1NZTkMpOwo+Pj4KPj4+ICDCoMKgwqDCoMKgwqDCoCByZXR1cm4gb2xkOwo+Pj4gfQo+Pgo+PiBJ
ZiBhbm90aGVyIHRocmVhZCBjaGFuZ2VzIHRoZSBwdGVwIGJldHdlZW4gY21weGNoZzY0X3JlbGF4
ZWQgYW5kCj4+IFdSSVRFX09OQ0UoKnB0ZXAsIG5ldyB8IEFSTV9MUEFFX1BURV9TV19TWU5DKSwg
dGhlIG9wZXJhdGlvbgo+PiBXUklURV9PTkNFIHdpbGwgb3ZlcndyaXRlIHRoZSBjaGFuZ2UuCj4g
Cj4gQ2FuIHlvdSBwbGVhc2UgcHJvdmlkZSBhbiBleGFtcGxlIG9mIGEgY29kZSBwYXRoIHdoZXJl
IHRoaXMgaGFwcGVucz8gVGhlCj4gaWRlYSBpcyB0aGF0IENQVXMgY2FuIHJhY2Ugb24gdGhlIGNt
cHhjaGcoKSwgYnV0IHRoZXJlIHdpbGwgb25seSBiZSBvbmUKPiB3aW5uZXIuCgpUaGUgb25seSB3
YXkgYSB0YWJsZSBlbnRyeSBjYW4gc3VkZGVubHkgZGlzYXBwZWFyIGlzIGluIGEgcmFjZSB0aGF0
IAppbnZvbHZlcyBtYXBwaW5nIG9yIHVubWFwcGluZyBhIHdob2xlIGJsb2NrL3RhYmxlLXNpemVk
IHJlZ2lvbiwgd2hpbGUgCnNpbXVsdGFuZW91c2x5IG1hcHBpbmcgYSBwYWdlICp3aXRoaW4qIHRo
YXQgcmVnaW9uLiBZZXMsIGlmIHNvbWVvbmUgdXNlcyAKdGhlIEFQSSBpbiBhIG5vbnNlbnNpY2Fs
IGFuZCBjb21wbGV0ZWx5IGludmFsaWQgd2F5IHRoYXQgY2Fubm90IGhhdmUgYSAKcHJlZGljdGFi
bGUgb3V0Y29tZSwgdGhleSBnZXQgYW4gdW5wcmVkaWN0YWJsZSBvdXRjb21lLiBXaG9vcCBkZSBk
by4uLgoKPj4gMuOAgXRoZSBzZWNvbmQKPj4KPj4+IGZvciAoaSA9IDA7IGkgPCB0YWJsZXN6IC8g
c2l6ZW9mKHB0ZSk7IGkrKywgYmxrX3BhZGRyICs9IHNwbGl0X3N6KSB7Cj4+PiAgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIFVubWFwISAqLwo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAoaSA9PSB1bm1hcF9pZHgpCj4+PiBjb250aW51ZTsKPj4+Cj4+PiAg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fYXJtX2xwYWVfaW5pdF9wdGUoZGF0YSwg
YmxrX3BhZGRyLCBwdGUsIGx2bCwKPj4+ICZ0YWJsZXBbaV0pOwo+Pj4gfQo+Pj4KPj4+IHB0ZSA9
IGFybV9scGFlX2luc3RhbGxfdGFibGUodGFibGVwLCBwdGVwLCBibGtfcHRlLCBjZmcpOwo+Pgo+
PiBXaGVuIGFsdGVyaW5nIGEgdHJhbnNsYXRpb24gdGFibGUgZGVzY3JpcHRvciBpbmNsdWRlIHNw
bGl0IGEgYmxvY2sgaW50bwo+PiBjb25zdGl0dWVudCBncmFudWxlcywgdGhlIEFybXY4LUEgYW5k
IFNNTVV2MyBhcmNoaXRlY3R1cmVzIHJlcXVpcmUKPj4gYSBicmVhay1iZWZvcmUtbWFrZSBwcm9j
ZWR1cmUuIEJ1dCBpbiB0aGUgZnVuY3Rpb24gYXJtX2xwYWVfc3BsaXRfYmxrX3VubWFwLAo+PiBp
dCBjaGFuZ2VzIGEgYmxvY2sgZGVzY3JpcHRvciB0byBhbiBlcXVpdmFsZW50IHNwYW4gb2YgcGFn
ZSB0cmFuc2xhdGlvbnMKPj4gZGlyZWN0bHkuIElzIGl0IGFwcHJvcHJpYXRlIHRvIGRvIHNvPwo+
IAo+IEJyZWFrLWJlZm9yZS1tYWtlIGRvZXNuJ3QgcmVhbGx5IHdvcmsgZm9yIHRoZSBTTU1VIGJl
Y2F1c2UgZmF1bHRzIGFyZQo+IGdlbmVyYWxseSBmYXRhbC4KPiAKPiBBcmUgeW91IHNlZWluZyBw
cm9ibGVtcyBpbiBwcmFjdGljZSB3aXRoIHRoaXMgY29kZT8KClRCSCBJIGRvIHN0aWxsIHdvbmRl
ciBpZiB3ZSBzaG91bGRuJ3QganVzdCBnZXQgcmlkIG9mIHNwbGl0X2Jsa191bm1hcCAKYW5kIGFs
bCBpdHMgY29tcGxleGl0eS4gT3RoZXIgZHJpdmVycyB0cmVhdCBhbiB1bm1hcCBvZiBhIHBhZ2Ug
ZnJvbSBhIApibG9jayBlbnRyeSBhcyBzaW1wbHkgdW5tYXBwaW5nIHRoZSB3aG9sZSBibG9jaywg
YW5kIHRoYXQncyB0aGUgCmJlaGF2aW91ciBWRklPIHNlZW1zIHRvIGV4cGVjdC4gTXkgb25seSB3
b3JyeSBpcyB0aGF0IGl0J3MgYmVlbiBhcm91bmQgCmxvbmcgZW5vdWdoIHRoYXQgdGhlcmUgbWln
aHQgYmUgc29tZSBob3JyaWJsZSBvdXQtb2YtdHJlZSBjb2RlIHRoYXQgKmlzKiAKcmVseWluZyBv
biBpdCwgZGVzcGl0ZSB0aGUgZmFjdCB0aGF0IGl0J3MgaW1wb3NzaWJsZSB0byBpbXBsZW1lbnQg
aW4gYSAKd2F5IHRoYXQncyBkZWZpbml0ZWx5IDEwMCUgc2FmZSA6LwoKUm9iaW4uCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
