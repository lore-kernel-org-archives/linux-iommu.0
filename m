Return-Path: <SRS0=z3hi=EK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F30C2D0A3
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 07:18:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3112224E
	for <iommu@archiver.kernel.org>; Wed,  4 Nov 2020 07:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3112224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id CC00386C6A;
	Wed,  4 Nov 2020 07:18:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fF7Ss+MS44jn; Wed,  4 Nov 2020 07:18:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6A27C8688D;
	Wed,  4 Nov 2020 07:18:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FD95C0889;
	Wed,  4 Nov 2020 07:18:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27FC4C0051
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 07:18:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 151C08688D
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 07:18:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ONninGtlgJ4k for <iommu@lists.linux-foundation.org>;
 Wed,  4 Nov 2020 07:18:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 207C886772
 for <iommu@lists.linux-foundation.org>; Wed,  4 Nov 2020 07:18:13 +0000 (UTC)
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4CQyfj73tRz51D1;
 Wed,  4 Nov 2020 15:18:05 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 4 Nov 2020 15:18:09 +0800
Received: from [10.174.185.137] (10.174.185.137) by
 dggema765-chm.china.huawei.com (10.1.198.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 4 Nov 2020 15:18:09 +0800
Subject: Re: Some questions about arm_lpae_install_table
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
References: <6778678e-df81-f7e2-235d-6390ff6384ac@huawei.com>
 <20201103091130.GA4403@willie-the-truck>
 <e5772a9c-df32-e865-3d0b-90f24ff233c0@arm.com>
From: Kunkun Jiang <jiangkunkun@huawei.com>
Message-ID: <6ad9732c-caa4-0049-3fa2-c193e5dc6a88@huawei.com>
Date: Wed, 4 Nov 2020 15:17:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <e5772a9c-df32-e865-3d0b-90f24ff233c0@arm.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.137]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggema765-chm.china.huawei.com (10.1.198.207)
X-CFilter-Loop: Reflected
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

SGkgV2lsbCBhbmQgUm9iaW4sCgpTb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHkuCgpPbiAyMDIwLzEx
LzMgMTg6MjEsIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMDIwLTExLTAzIDA5OjExLCBXaWxs
IERlYWNvbiB3cm90ZToKPj4gT24gVHVlLCBOb3YgMDMsIDIwMjAgYXQgMTE6MDA6MjdBTSArMDgw
MCwgS3Vua3VuIEppYW5nIHdyb3RlOgo+Pj4gUmVjZW50bHksIEkgaGF2ZSByZWFkIGFuZCBsZWFy
bmVkIHRoZSBjb2RlIHJlbGF0ZWQgdG8gaW8tcGd0YWJsZS1hcm0uYy4KPj4+IFRoZXJlCj4+PiBh
cmUgdHdvIHF1ZXN0aW9uIG9uIGFybV9scGFlX2luc3RhbGxfdGFibGUuCj4+Pgo+Pj4gMeOAgXRo
ZSBmaXJzdAo+Pj4KPj4+PiBzdGF0aWMgYXJtX2xwYWVfaW9wdGUgYXJtX2xwYWVfaW5zdGFsbF90
YWJsZShhcm1fbHBhZV9pb3B0ZSAqdGFibGUsCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGFybV9scGFlX2lvcHRlICpwdGVwLAo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBhcm1fbHBhZV9pb3B0ZSBjdXJyLAo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaW9fcGd0YWJsZV9jZmcgCj4+Pj4gKmNmZykKPj4+PiB7
Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBhcm1fbHBhZV9pb3B0ZSBvbGQsIG5ldzsKPj4+Pgo+Pj4+
IMKgwqDCoMKgwqDCoMKgwqAgbmV3ID0gX19wYSh0YWJsZSkgfCBBUk1fTFBBRV9QVEVfVFlQRV9U
QUJMRTsKPj4+PiDCoMKgwqDCoMKgwqDCoMKgIGlmIChjZmctPnF1aXJrcyAmIElPX1BHVEFCTEVf
UVVJUktfQVJNX05TKQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5ldyB8
PSBBUk1fTFBBRV9QVEVfTlNUQUJMRTsKPj4+Pgo+Pj4+IMKgwqDCoMKgwqDCoMKgIC8qCj4+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgICogRW5zdXJlIHRoZSB0YWJsZSBpdHNlbGYgaXMgdmlzaWJsZSBi
ZWZvcmUgaXRzIFBURSBjYW4gYmUuCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgICogV2hpbHN0IHdl
IGNvdWxkIGdldCBhd2F5IHdpdGggY21weGNoZzY0X3JlbGVhc2UgYmVsb3csIAo+Pj4+IHRoaXMK
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgKiBkb2Vzbid0IGhhdmUgYW55IG9yZGVyaW5nIHNlbWFu
dGljcyB3aGVuICFDT05GSUdfU01QLgo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+Pj4+IMKg
wqDCoMKgwqDCoMKgwqAgZG1hX3dtYigpOwo+Pj4+Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBvbGQg
PSBjbXB4Y2hnNjRfcmVsYXhlZChwdGVwLCBjdXJyLCBuZXcpOwo+Pj4+Cj4+Pj4gwqDCoMKgwqDC
oMKgwqDCoCBpZiAoY2ZnLT5jb2hlcmVudF93YWxrIHx8IChvbGQgJiBBUk1fTFBBRV9QVEVfU1df
U1lOQykpCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIG9sZDsK
Pj4+Pgo+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgLyogRXZlbiBpZiBpdCdzIG5vdCBvdXJzLCB0aGVy
ZSdzIG5vIHBvaW50IHdhaXRpbmc7IGp1c3QgCj4+Pj4ga2ljayBpdAo+Pj4+ICovCj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoCBfX2FybV9scGFlX3N5bmNfcHRlKHB0ZXAsIGNmZyk7Cj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoCBpZiAob2xkID09IGN1cnIpCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgV1JJVEVfT05DRSgqcHRlcCwgbmV3IHwgQVJNX0xQQUVfUFRFX1NXX1NZTkMpOwo+
Pj4+Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gb2xkOwo+Pj4+IH0KPj4+Cj4+PiBJZiBh
bm90aGVyIHRocmVhZCBjaGFuZ2VzIHRoZSBwdGVwIGJldHdlZW4gY21weGNoZzY0X3JlbGF4ZWQg
YW5kCj4+PiBXUklURV9PTkNFKCpwdGVwLCBuZXcgfCBBUk1fTFBBRV9QVEVfU1dfU1lOQyksIHRo
ZSBvcGVyYXRpb24KPj4+IFdSSVRFX09OQ0Ugd2lsbCBvdmVyd3JpdGUgdGhlIGNoYW5nZS4KPj4K
Pj4gQ2FuIHlvdSBwbGVhc2UgcHJvdmlkZSBhbiBleGFtcGxlIG9mIGEgY29kZSBwYXRoIHdoZXJl
IHRoaXMgaGFwcGVucz8gVGhlCj4+IGlkZWEgaXMgdGhhdCBDUFVzIGNhbiByYWNlIG9uIHRoZSBj
bXB4Y2hnKCksIGJ1dCB0aGVyZSB3aWxsIG9ubHkgYmUgb25lCj4+IHdpbm5lci4KPgo+IFRoZSBv
bmx5IHdheSBhIHRhYmxlIGVudHJ5IGNhbiBzdWRkZW5seSBkaXNhcHBlYXIgaXMgaW4gYSByYWNl
IHRoYXQgCj4gaW52b2x2ZXMgbWFwcGluZyBvciB1bm1hcHBpbmcgYSB3aG9sZSBibG9jay90YWJs
ZS1zaXplZCByZWdpb24sIHdoaWxlIAo+IHNpbXVsdGFuZW91c2x5IG1hcHBpbmcgYSBwYWdlICp3
aXRoaW4qIHRoYXQgcmVnaW9uLiBZZXMsIGlmIHNvbWVvbmUgCj4gdXNlcyB0aGUgQVBJIGluIGEg
bm9uc2Vuc2ljYWwgYW5kIGNvbXBsZXRlbHkgaW52YWxpZCB3YXkgdGhhdCBjYW5ub3QgCj4gaGF2
ZSBhIHByZWRpY3RhYmxlIG91dGNvbWUsIHRoZXkgZ2V0IGFuIHVucHJlZGljdGFibGUgb3V0Y29t
ZS4gV2hvb3AgCj4gZGUgZG8uLi4KPgpZZXMsIGFzIFJvYmluIG1lbnRpb25lZCwgdGhlcmUgd2ls
bCBiZSBhbiB1bnByZWRpY3RhYmxlIG91dGNvbWUgaW4gZXh0cmVtZQpjYXNlcy4gTm93LCB3ZSBo
YXZlIHR3byBBUElzIG1hcHBpbmcgYW5kIHVubWFwcGluZyB0byBhbHRlciBhIGJsb2NrL3BhZ2UK
ZGVzY3JpcHRvci4gSSB3b3JyeSBhYm91dCB0aGF0IGl0IG1heSBiZcKgIGluY3JlYXNpbmdseSBk
aWZmaWN1bHQgdG8gYWRkIApBUEkgaW4KdGhlIGZ1dHVyZS4KCj4+PiAy44CBdGhlIHNlY29uZAo+
Pj4KPj4+PiBmb3IgKGkgPSAwOyBpIDwgdGFibGVzeiAvIHNpemVvZihwdGUpOyBpKyssIGJsa19w
YWRkciArPSBzcGxpdF9zeikgewo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IC8qIFVubWFwISAqLwo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChp
ID09IHVubWFwX2lkeCkKPj4+PiBjb250aW51ZTsKPj4+Pgo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIF9fYXJtX2xwYWVfaW5pdF9wdGUoZGF0YSwgYmxrX3BhZGRyLCBwdGUs
IGx2bCwKPj4+PiAmdGFibGVwW2ldKTsKPj4+PiB9Cj4+Pj4KPj4+PiBwdGUgPSBhcm1fbHBhZV9p
bnN0YWxsX3RhYmxlKHRhYmxlcCwgcHRlcCwgYmxrX3B0ZSwgY2ZnKTsKPj4+Cj4+PiBXaGVuIGFs
dGVyaW5nIGEgdHJhbnNsYXRpb24gdGFibGUgZGVzY3JpcHRvciBpbmNsdWRlIHNwbGl0IGEgYmxv
Y2sgaW50bwo+Pj4gY29uc3RpdHVlbnQgZ3JhbnVsZXMsIHRoZSBBcm12OC1BIGFuZCBTTU1VdjMg
YXJjaGl0ZWN0dXJlcyByZXF1aXJlCj4+PiBhIGJyZWFrLWJlZm9yZS1tYWtlIHByb2NlZHVyZS4g
QnV0IGluIHRoZSBmdW5jdGlvbiAKPj4+IGFybV9scGFlX3NwbGl0X2Jsa191bm1hcCwKPj4+IGl0
IGNoYW5nZXMgYSBibG9jayBkZXNjcmlwdG9yIHRvIGFuIGVxdWl2YWxlbnQgc3BhbiBvZiBwYWdl
IAo+Pj4gdHJhbnNsYXRpb25zCj4+PiBkaXJlY3RseS4gSXMgaXQgYXBwcm9wcmlhdGUgdG8gZG8g
c28/Cj4+Cj4+IEJyZWFrLWJlZm9yZS1tYWtlIGRvZXNuJ3QgcmVhbGx5IHdvcmsgZm9yIHRoZSBT
TU1VIGJlY2F1c2UgZmF1bHRzIGFyZQo+PiBnZW5lcmFsbHkgZmF0YWwuCj4+Cj4+IEFyZSB5b3Ug
c2VlaW5nIHByb2JsZW1zIGluIHByYWN0aWNlIHdpdGggdGhpcyBjb2RlPwo+Cj4gVEJIIEkgZG8g
c3RpbGwgd29uZGVyIGlmIHdlIHNob3VsZG4ndCBqdXN0IGdldCByaWQgb2Ygc3BsaXRfYmxrX3Vu
bWFwIAo+IGFuZCBhbGwgaXRzIGNvbXBsZXhpdHkuIE90aGVyIGRyaXZlcnMgdHJlYXQgYW4gdW5t
YXAgb2YgYSBwYWdlIGZyb20gYSAKPiBibG9jayBlbnRyeSBhcyBzaW1wbHkgdW5tYXBwaW5nIHRo
ZSB3aG9sZSBibG9jaywgYW5kIHRoYXQncyB0aGUgCj4gYmVoYXZpb3VyIFZGSU8gc2VlbXMgdG8g
ZXhwZWN0LiBNeSBvbmx5IHdvcnJ5IGlzIHRoYXQgaXQncyBiZWVuIGFyb3VuZCAKPiBsb25nIGVu
b3VnaCB0aGF0IHRoZXJlIG1pZ2h0IGJlIHNvbWUgaG9ycmlibGUgb3V0LW9mLXRyZWUgY29kZSB0
aGF0IAo+ICppcyogcmVseWluZyBvbiBpdCwgZGVzcGl0ZSB0aGUgZmFjdCB0aGF0IGl0J3MgaW1w
b3NzaWJsZSB0byBpbXBsZW1lbnQgCj4gaW4gYSB3YXkgdGhhdCdzIGRlZmluaXRlbHkgMTAwJSBz
YWZlIDovCj4KPiBSb2Jpbi4KPiAuCkkgaGF2ZSBub3QgZW5jb3VudGVyZWQgYSBwcm9ibGVtLiBJ
IG1lYW4gU01NVSBoYXMgc3VwcG9ydGVkIEJCTUwgZmVhdHVyZQppbiBTTU1VdjMuMi4gTWF5YmUg
d2UgY2FuIHVzZSB0aGlzIGZlYXR1cmUgdG8gdXBkYXRlIHRyYW5zbGF0aW9uIHRhYmxlIAp3aXRo
b3V0CmJyZWFrLWJlZm9yZS1tYWtlLgoKTG9vayBmb3J3YXJkIHRvIHlvdXIgcmVwbHkuCgpUaGFu
a3MsCkt1bmt1biBKaWFuZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9t
bXU=
