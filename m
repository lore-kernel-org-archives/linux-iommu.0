Return-Path: <SRS0=NT7l=KQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C78AC433B4
	for <iommu@archiver.kernel.org>; Fri, 21 May 2021 06:53:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF49613BE
	for <iommu@archiver.kernel.org>; Fri, 21 May 2021 06:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF49613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F22E84580;
	Fri, 21 May 2021 06:53:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o-qPZJTWXylF; Fri, 21 May 2021 06:53:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id AADAD84589;
	Fri, 21 May 2021 06:53:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FA01C000D;
	Fri, 21 May 2021 06:53:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6365CC0001
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 06:53:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 48D9940208
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 06:53:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MbSdwNi10tiU for <iommu@lists.linux-foundation.org>;
 Fri, 21 May 2021 06:53:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A085401FD
 for <iommu@lists.linux-foundation.org>; Fri, 21 May 2021 06:53:08 +0000 (UTC)
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FmcgD5sj3zCswv;
 Fri, 21 May 2021 14:50:16 +0800 (CST)
Received: from dggema765-chm.china.huawei.com (10.1.198.207) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 14:53:04 +0800
Received: from [10.174.185.210] (10.174.185.210) by
 dggema765-chm.china.huawei.com (10.1.198.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 21 May 2021 14:53:04 +0800
Subject: Re: [RFC PATCH v1 0/2] iommu/arm-smmu-v3: Add some parameter check in
 __arm_smmu_tlb_inv_range()
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, "Eric
 Auger" <eric.auger@redhat.com>, "moderated list:ARM SMMU DRIVERS"
 <linux-arm-kernel@lists.infradead.org>, "open list:IOMMU DRIVERS"
 <iommu@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
References: <20210519094307.3275-1-jiangkunkun@huawei.com>
 <c577a7cc-8db3-5802-53cb-985f0c7216b3@arm.com>
From: Kunkun Jiang <jiangkunkun@huawei.com>
Message-ID: <0f4e8394-72e1-e837-d98f-4998b9a71097@huawei.com>
Date: Fri, 21 May 2021 14:53:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c577a7cc-8db3-5802-53cb-985f0c7216b3@arm.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.210]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
 dggema765-chm.china.huawei.com (10.1.198.207)
X-CFilter-Loop: Reflected
Cc: wanghaibin.wang@huawei.com
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

SGkgUm9iaW4sCgpPbiAyMDIxLzUvMTkgMTg6MDEsIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAy
MDIxLTA1LTE5IDEwOjQzLCBLdW5rdW4gSmlhbmcgd3JvdGU6Cj4+IEhpIGFsbCwKPj4KPj4gVGhp
cyBzZXQgb2YgcGF0Y2hlcyBzb2x2ZXMgc29tZSBlcnJvcnMgd2hlbiBJIHRlc3RlZCB0aGUgU01N
VSBuZXN0ZWQgCj4+IG1vZGUuCj4+Cj4+IFRlc3Qgc2NlbmFyaW8gZGVzY3JpcHRpb246Cj4+IGd1
ZXN0IGtlcm5lbDogNEtCIHRyYW5zbGF0aW9uIGdyYW51bGUKPj4gaG9zdCBrZXJuZWw6IDE2S0Ig
dHJhbnNsYXRpb24gZ3JhbnVsZQo+Pgo+PiBlcnJvcnM6Cj4+IDEuIGVuY291bnRlcmVkIGFuIGVu
ZGxlc3MgbG9vcCBpbiBfX2FybV9zbW11X3RsYl9pbnZfcmFuZ2UgYmVjYXVzZQo+PiBudW1fcGFn
ZXMgaXMgMAo+PiAyLiBlbmNvdW50ZXJlZCBDRVJST1JfSUxMIGJlY2F1c2UgdGhlIGZpZWxkcyBv
ZiBUTEIgaW52YWxpZGF0aW9uCj4+IGNvbW1hbmQgYXJlIGFzIGZvbGxvdzogVEcgPSAyLCBOVU0g
PSAwLCBTQ0FMRSA9IDAsIFRUTCA9IDAuIFRoZQo+PiBjb21iaW5hdGlvbiBpcyBleGFjdGx5IHRo
ZSBraW5kIG9mIHJlc2VydmVkIGNvbWJpbmF0aW9uIHBvaW50ZWQKPj4gb3V0IGluIHRoZSBTTU1V
djMgc3BlYyhwYWdlIDE0My0xNDQsIHZlcnNpb24gRC5hKQo+Pgo+PiBJbiBteSBvcGluaW9uLCBp
dCBpcyBtb3JlIGFwcHJvcHJpYXRlIHRvIGFkZCBwYXJhbWV0ZXIgY2hlY2sgaW4KPj4gX19hcm1f
c21tdV90bGJfaW52X3JhbmdlKCksIGFsdGhvdWdoIHRoZXNlIHByb2JsZW1zIG9ubHkgYXBwZWFy
ZWQKPj4gd2hlbiBJIHRlc3RlZCB0aGUgU01NVSBuZXN0ZWQgbW9kZS4gV2hhdCBkbyB5b3UgdGhp
bms/Cj4KPiBGV0lXIEkgdGhpbmsgaXQgd291bGQgYmUgYmV0dGVyIHRvIGZpeCB0aGUgY2FsbGVy
IHRvIG5vdCBpc3N1ZSBicm9rZW4gCj4gY29tbWFuZHMgaW4gdGhlIGZpcnN0IHBsYWNlLiBUaGUg
a2VybmVsIHNob3VsZG4ndCBkbyBzbyBmb3IgaXRzZWxmIAo+IChhbmQgZGVmaW5pdGVseSBuZWVk
cyBmaXhpbmcgaWYgaXQgZXZlciBkb2VzKSwgc28gaXQgc291bmRzIGxpa2UgdGhlIAo+IG5lc3Rp
bmcgaW1wbGVtZW50YXRpb24gbmVlZHMgdG8gZG8gYSBiaXQgbW9yZSB2YWxpZGF0aW9uIG9mIHdo
YXQgaXQncyAKPiBwYXNzaW5nIHRocm91Z2guClRoYW5rcyBmb3IgeW91ciByZXBseS4KSSB3aWxs
IHJlcG9ydCB0aGVzZSBlcnJvcnMgdG8gRXJpYyBhbmQgZGlzY3VzcyBob3cgdG8gZml4IHRoZW0u
CgpUaGFua3MsCkt1bmt1biBKaWFuZwo+Cj4gUm9iaW4uCj4KPj4gVGhpcyBzZXJpZXMgaW5jbHVk
ZSBwYXRjaGVzIGFzIGJlbG93Ogo+PiBQYXRjaCAxOgo+PiAtIGFsaWduIHRoZSBpbnZhbGlkIHJh
bmdlIHdpdGggbGVhZiBwYWdlIHNpemUgdXB3YXJkcyB3aGVuIHNtbXUKPj4gc3VwcG9ydHMgUklM
Cj4+Cj4+IFBhdGNoIDI6Cj4+IC0gYWRkIGEgY2hlY2sgdG8gc3RhbmRhcmRpemUgZ3JhbnVsZSBz
aXplIHdoZW4gc21tdSBzdXBwb3J0cyBSSUwKPj4KPj4gS3Vua3VuIEppYW5nICgyKToKPj4gwqDC
oCBpb21tdS9hcm0tc21tdS12MzogQWxpZ24gaW52YWxpZCByYW5nZSB3aXRoIGxlYWYgcGFnZSBz
aXplIHVwd2FyZHMKPj4gwqDCoMKgwqAgd2hlbiBzdXBwb3J0IFJJTAo+PiDCoMKgIGlvbW11L2Fy
bS1zbW11LXYzOiBTdGFuZGFyZGl6ZSBncmFudWxlIHNpemUgd2hlbiBzdXBwb3J0IFJJTAo+Pgo+
PiDCoCBkcml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS12My9hcm0tc21tdS12My5jIHwgOSArKysr
KysrKysKPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQo+Pgo+IC4KCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5n
IGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
