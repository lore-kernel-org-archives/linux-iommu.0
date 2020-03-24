Return-Path: <SRS0=P7ka=5J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D052BC41621
	for <iommu@archiver.kernel.org>; Tue, 24 Mar 2020 12:37:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3F382070A
	for <iommu@archiver.kernel.org>; Tue, 24 Mar 2020 12:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F382070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7D1AE87C89;
	Tue, 24 Mar 2020 12:37:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wUzlT-b3d+hm; Tue, 24 Mar 2020 12:37:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8716F866B3;
	Tue, 24 Mar 2020 12:37:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70561C1D7C;
	Tue, 24 Mar 2020 12:37:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B5D2C0177
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 12:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3A3FB86DD6
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 12:37:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vuws0MCmDYHq for <iommu@lists.linux-foundation.org>;
 Tue, 24 Mar 2020 12:37:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0EF9686DCF
 for <iommu@lists.linux-foundation.org>; Tue, 24 Mar 2020 12:37:30 +0000 (UTC)
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 08F63D81F8624C83A5A8;
 Tue, 24 Mar 2020 12:37:28 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML712-CAH.china.huawei.com (10.201.108.35) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 24 Mar 2020 12:37:27 +0000
Received: from [127.0.0.1] (10.210.165.24) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 12:37:26 +0000
Subject: Re: arm-smmu-v3 high cpu usage for NVMe
To: Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>
References: <20190821151749.23743-1-will@kernel.org>
 <b2a6e26d-6d0d-7f0d-f222-589812f701d2@huawei.com>
 <20200318205313.GB8094@willie-the-truck>
 <c6ab8020-dc06-0c7d-7a41-e792d90f97ba@huawei.com>
 <20200319184349.GA1697676@myrica>
 <c9ebe17d-66b8-1b8c-cc2c-5be0bd1501a7@huawei.com>
 <20200320111842.GD1702630@myrica>
 <b412fc9c-6266-e320-0769-f214d7752675@huawei.com>
 <5198fcffc8ad6233e0274ebff9e9aa5f@kernel.org>
 <cca67355-672d-81c5-3d37-72004eb8f14f@huawei.com>
 <dd375cf6bffacd82174c84a4c7d46283@kernel.org>
 <0e00de15-596a-d342-f3cb-e19c389294e6@huawei.com>
 <20200324104307.57d2cde0@why>
 <4c5e2482-1493-6bb7-d592-58cd027d39f9@huawei.com>
 <10d5bcb3-e7c4-18f0-ede6-9fd8f0385254@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <9f1c719f-b876-66a1-2d3e-7787e1f1ed9f@huawei.com>
Date: Tue, 24 Mar 2020 12:37:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <10d5bcb3-e7c4-18f0-ede6-9fd8f0385254@arm.com>
Content-Language: en-US
X-Originating-IP: [10.210.165.24]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Mark Rutland <mark.rutland@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Ming Lei <ming.lei@redhat.com>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, Julien Thierry <julien.thierry.kdev@gmail.com>
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

T24gMjQvMDMvMjAyMCAxMjowNywgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjAtMDMtMjQg
MTE6NTUgYW0sIEpvaG4gR2Fycnkgd3JvdGU6Cj4+IE9uIDI0LzAzLzIwMjAgMTA6NDMsIE1hcmMg
WnluZ2llciB3cm90ZToKPj4+IE9uIFR1ZSwgMjQgTWFyIDIwMjAgMDk6MTg6MTAgKzAwMDAKPj4+
IEpvaG4gR2Fycnk8am9obi5nYXJyeUBodWF3ZWkuY29tPsKgIHdyb3RlOgo+Pj4KPj4+PiBPbiAy
My8wMy8yMDIwIDA5OjE2LCBNYXJjIFp5bmdpZXIgd3JvdGU6Cj4+Pj4KPj4+PiArIEp1bGllbiwg
TWFyawo+Pj4+Cj4+Pj4gSGkgTWFyYywKPj4+Pgo+Pj4+Pj4+IFRpbWUgdG8gZW5hYmxlIHBzZXVk
by1OTUlzIGluIHRoZSBQTVV2MyBkcml2ZXIuLi4KPj4+Pj4+Pgo+Pj4+Pj4gRG8geW91IGtub3cg
aWYgdGhlcmUgaXMgYW55IHBsYW4gZm9yIHRoaXM/Cj4+Pj4+IFRoZXJlIHdhcy4gSnVsaWVuIFRo
aWVycnkgaGFzIGEgYnVuY2ggb2YgcGF0Y2hlcyBmb3IgdGhhdCBbMV0sIGJ1dCAKPj4+Pj4gdGhl
eSA+IG5lZWRzCj4+Pj4+IHJldml2aW5nLgo+Pj4+Pgo+Pj4+IFNvIHRob3NlIHBhdGNoZXMgc3Rp
bGwgYXBwbHkgY2xlYW5seSAoYXBhcnQgZnJvbSB0aGUga3ZtIHBhdGNoLCB3aGljaAo+Pj4+IEkg
Y2FuIHNraXAsIEkgc3VwcG9zZSkgYW5kIGJ1aWxkLCBzbyBJIGNhbiB0cnkgdGhpcyBJIGZpZ3Vy
ZS4gSXMKPj4+PiB0aGVyZSBhbnl0aGluZyBlbHNlIHdoaWNoIEkgc2hvdWxkIGVuc3VyZSBvciBr
bm93IGFib3V0PyBBcGFydCBmcm9tCj4+Pj4gZW5hYmxlIENPTkZJR19BUk02NF9QU1VFRE9fTk1J
Lgo+Pj4gWW91IG5lZWQgdG8gbWFrZSBzdXJlIHRoYXQgeW91ciBmaXJtd2FyZSBzZXRzIFNDUl9F
TDMuRklRIHRvIDEuIE15IEQwNQo+Pj4gaGFzIGl0IHNldCB0byAwLCBwcmV2ZW50aW5nIG1lIGZy
b20gYmVpbmcgYWJsZSB0byB1c2UgdGhlIGZlYXR1cmUKPj4+IChoaW50LCBudWRnZS4uLjstKS4K
Pj4KPj4gWWVhaCwgYXBwYXJlbnRseSBpdCdzIHNldCBvbiBvdXIgRDA2Q1MgYm9hcmQsIGJ1dCBJ
IGp1c3QgbmVlZCB0byAKPj4gZG91YmxlIGNoZWNrIHRoZSBGVyB2ZXJzaW9uIHdpdGggb3VyIEZX
IGd1eS4KPiAKPiBIb3BlZnVsbHkgeW91IHNhdyB0aGUgaGVscCBmb3IgQ09ORklHX0FSTTY0X1BT
VUVET19OTUkgYWxyZWFkeSwgYnV0IAo+IHNpbmNlIGl0J3Mgbm90IGJlZW4gY2FsbGVkIG91dDoK
PiAKPiAgwqDCoMKgwqDCoCBUaGlzIGhpZ2ggcHJpb3JpdHkgY29uZmlndXJhdGlvbiBmb3IgaW50
ZXJydXB0cyBuZWVkcyB0byBiZQo+ICDCoMKgwqDCoMKgwqDCoMKgwqAgZXhwbGljaXRseSBlbmFi
bGVkIGJ5IHNldHRpbmcgdGhlIGtlcm5lbCBwYXJhbWV0ZXIKPiAgwqDCoMKgwqDCoMKgwqDCoMKg
ICJpcnFjaGlwLmdpY3YzX3BzZXVkb19ubWkiIHRvIDEuCgpZZWFoLCBJIHNhdyB0aGF0IGJ5IGNo
YW5jZSBzb21ld2hlcmUgZWxzZSBwcmV2aW91c2x5LgoKPiAKPiBGV0lXIEkgYmVsaWV2ZSBpcyBp
cyBzdGlsbCBvbiB0aGUgcGxhbiBmb3Igc29tZW9uZSBoZXJlIHRvIGR1c3Qgb2ZmIHRoZSAKPiBQ
TVUgcE5NSSBwYXRjaGVzIGF0IHNvbWUgcG9pbnQuCgpDb29sLiBXZWxsIEkgY2FuIHRyeSB0byBl
eHBlcmltZW50IHdpdGggd2hhdCBKdWxpZW4gaGFkIGF0IHY0IGZvciBub3cuCgpDaGVlcnMsCkpv
aG4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
