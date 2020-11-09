Return-Path: <SRS0=JucZ=EP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A647FC388F7
	for <iommu@archiver.kernel.org>; Mon,  9 Nov 2020 11:13:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B294520897
	for <iommu@archiver.kernel.org>; Mon,  9 Nov 2020 11:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B294520897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2678E84DD4;
	Mon,  9 Nov 2020 11:13:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XczzasrJZ_5v; Mon,  9 Nov 2020 11:13:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A555284C19;
	Mon,  9 Nov 2020 11:13:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B028C0889;
	Mon,  9 Nov 2020 11:13:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E3C8C016F
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 11:13:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F06A784DD4
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 11:13:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zHdof3s5glqW for <iommu@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 11:13:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2657784C19
 for <iommu@lists.linux-foundation.org>; Mon,  9 Nov 2020 11:13:07 +0000 (UTC)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CV7bT5CWnz67JSw;
 Mon,  9 Nov 2020 19:11:17 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 9 Nov 2020 12:13:03 +0100
Received: from [10.210.172.102] (10.210.172.102) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 9 Nov 2020 11:13:02 +0000
Subject: Re: [PATCH v5 2/2] iommu/iova: Free global iova rcache on iova alloc
 failure
To: Robin Murphy <robin.murphy@arm.com>, <vjitta@codeaurora.org>,
 <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
 <linux-kernel@vger.kernel.org>
References: <1601451864-5956-1-git-send-email-vjitta@codeaurora.org>
 <1601451864-5956-2-git-send-email-vjitta@codeaurora.org>
 <ff318311-77e8-b235-37dd-7b1b5f5d8ed9@arm.com>
 <e1e5b24a-512b-7279-8341-7f4495718ece@huawei.com>
 <5293135b-3a28-4edc-0515-61e595600bba@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <0477c95c-03fd-98f6-8bf4-9a567826310f@huawei.com>
Date: Mon, 9 Nov 2020 11:12:54 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <5293135b-3a28-4edc-0515-61e595600bba@arm.com>
Content-Language: en-US
X-Originating-IP: [10.210.172.102]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: vinmenon@codeaurora.org, kernel-team@android.com
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

T24gMDMvMTEvMjAyMCAxNTo1OSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4+IGFsbG9jIGZhaWx1
cmUgZXZlbiBhZnRlciByZXRyeSBhcyBnbG9iYWwKPj4+PiByY2FjaGUgaXMgaG9sZGluZyB0aGUg
aW92YSdzIHdoaWNoIGNhbiBjYXVzZSBmcmFnbWVudGF0aW9uLgo+Pj4+IFNvLCBmcmVlIHRoZSBn
bG9iYWwgaW92YSByY2FjaGUgYXMgd2VsbCBhbmQgdGhlbiBnbyBmb3IgdGhlCj4+Pj4gcmV0cnku
Cj4+Pgo+Pgo+PiBJZiB3ZSBkbyBjbGVhciBhbGwgdGhlIENQVSByY2FjaGVzLCBpdCB3b3VsZCBu
aWNlIHRvIGhhdmUgc29tZXRoaW5nIAo+PiBpbW1lZGlhdGVseSBhdmFpbGFibGUgdG8gcmVwbGVu
aXNoLCBpLmUuIHVzZSB0aGUgZ2xvYmFsIHJjYWNoZSwgCj4+IGluc3RlYWQgb2YgZmx1c2hpbmcg
aXQsIGlmIHRoYXQgaXMgbm90IHJlcXVpcmVkLi4uCj4gCj4gSWYgd2UndmUgcmVhY2hlZCB0aGUg
cG9pbnQgb2YgY2xlYXJpbmcgKmFueSogY2FjaGVzLCB0aG91Z2gsIEkgdGhpbmsgYW55IAo+IGhv
cGUgb2YgbWFpbnRhaW5pbmcgcGVyZm9ybWFuY2UgaXMgYWxyZWFkeSBsb25nIGdvbmUuIFdlJ3Zl
IHdhbGtlZCB0aGUgCj4gcmJ0cmVlIGZvciB0aGUgZW50aXJlIGFkZHJlc3Mgc3BhY2UgYW5kIGZv
dW5kIHRoYXQgaXQncyBzdGlsbCB0b28gZnVsbCAKPiB0byBhbGxvY2F0ZSBmcm9tOyB3ZSdyZSB0
ZWV0ZXJpbmcgb24gdGhlIGJyaW5rIG9mIGhhcmQgZmFpbHVyZSBhbmQgdGhpcyAKPiBpcyBhIGxh
c3QtZGl0Y2ggYXR0ZW1wdCB0byBjbGF3IGJhY2sgYXMgbXVjaCBhcyBwb3NzaWJsZSBpbiB0aGUg
aG9wZSAKPiB0aGF0IGl0IGdpdmVzIHVzIGEgdXNhYmxlIHNwYWNlLiA+Cj4gVEJIIEknbSBub3Qg
ZW50aXJlbHkgc3VyZSB3aGF0IGFsbG9jYXRpb24gcGF0dGVybiB3YXMgZXhwZWN0ZWQgYnkgdGhl
IAo+IG9yaWdpbmFsIGNvZGUgc3VjaCB0aGF0IHB1cmdpbmcgb25seSBzb21lIG9mIHRoZSBjYWNo
ZXMgbWFkZSBzZW5zZSwKCkknZCBzYXkgdGhhdCB0aGUgYXNzdW1wdGlvbiBpcyB0aGF0IG9uY2Ug
dGhlIENQVSByY2FjaGVzIGFyZSBmbHVzaGVkLCAKdGhlbiB3ZSBzaG91bGQgaGF2ZSBzcGFjZSBh
Z2Fpbi4gTm8gbmVlZCB0byBnbyBhbnkgZnVydGhlci4KCj4gbm9yIAo+IHdoYXQga2luZCBvZiBw
YXR0ZXJuIGxlYWRzIHRvIGxvdHMgb2Ygc21hbGxlciBJT1ZBcyBiZWluZyBhbGxvY2F0ZWQsIAo+
IGZyZWVkLCBhbmQgbmV2ZXIgcmV1c2VkIHRvIHRoZSBwb2ludCBvZiBibG9ja2luZyBsYXJnZXIg
YWxsb2NhdGlvbnMsIGJ1dCAKPiBlaXRoZXIgd2F5IHRoZSByZWFzb25pbmcgZG9lcyBhdCBsZWFz
dCBzZWVtIHRvIGhvbGQgdXAgaW4gYWJzdHJhY3QuCgpPaywgYnV0IEknZCBsaWtlIHRvIHNlZSB0
aGF0IGhhcmQgZmFpbHVyZSAoaWYgeW91IGdldCBteSBtZWFuaW5nKS4gCkZsdXNoaW5nIHRoZSBk
ZXBvdCByY2FjaGUgbWF5IGJlIHBhcGVyaW5nIG92ZXIgc29tZSBvdGhlciBidWcuCgpFaXRoZXIg
d2F5LCBJIGRvbid0IGZlZWwgdG8gc3Ryb25nbHksIHNvIGlmIHlvdSdyZSBoYXBweSB0aGVuIEkg
d29uJ3QgCnRyeSB0byBibG9jaywgc28gW2FwYXJ0IGZyb20gY29tbWVudCwgYmVsb3ddOgpBY2tl
ZC1ieTogSm9obiBHYXJyeSA8am9obi5nYXJyeUBodWFxd2VpLmNvbT4KCj4gCj4+PiBUaGlzIGxv
b2tzIHJlYXNvbmFibGUgdG8gbWUgLSBpdCdzIG1pbGRseSBhbm5veWluZyB0aGF0IHdlIGVuZCB1
cCAKPj4+IHdpdGggc28gbWFueSBzaW1pbGFyLWxvb2tpbmcgZnVuY3Rpb25zLAo+Pgo+PiBXZWxs
IEkgZGlkIGFkZCBhIGZ1bmN0aW9uIHRvIGNsZWFyIGFsbCBDUFUgcmNhY2hlcyBoZXJlLCBpZiB5
b3Ugd291bGQgCj4+IGxpa2UgdG8gY2hlY2s6Cj4+Cj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LWlvbW11LzE2MDM3MzM1MDEtMjExMDA0LTItZ2l0LXNlbmQtZW1haWwtam9obi5nYXJy
eUBodWF3ZWkuY29tLyAKPiAKPiAKPiBJIHdhcyB0aGlua2luZyBtb3JlIG9mIHRoZSB3YXkgZnJl
ZV9pb3ZhX3JjYWNoZXMoKSwgCj4gZnJlZV9jcHVfY2FjaGVkX2lvdmFzKCksIGFuZCBmcmVlX2ds
b2JhbF9jYWNoZWRfaW92YXMoKSBhbGwgbG9vayBwcmV0dHkgCj4gbXVjaCB0aGUgc2FtZSBzaGFw
ZSBhdCBhIGdsYW5jZS4KPiAKPj4+IGJ1dCB0aGUgbmVjZXNzYXJ5IGRpZmZlcmVuY2VzIGFyZSBy
aWdodCBkb3duIGluIHRoZSBtaWRkbGUgb2YgdGhlIAo+Pj4gbG9vcHMgc28gbm90aGluZyBjYW4g
cmVhc29uYWJseSBiZSBmYWN0b3JlZCBvdXQgOigKPj4+Cj4+PiBSZXZpZXdlZC1ieTogUm9iaW4g
TXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4KPj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogVmlq
YXlhbmFuZCBKaXR0YSA8dmppdHRhQGNvZGVhdXJvcmEub3JnPgo+Pj4+IC0tLQo+Pj4+IMKgIGRy
aXZlcnMvaW9tbXUvaW92YS5jIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysKPj4+PiDCoCAx
IGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW9tbXUvaW92YS5jIGIvZHJpdmVycy9pb21tdS9pb3ZhLmMKPj4+PiBpbmRleCBjM2Ex
YThlLi5mYWY5YjEzIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW92YS5jCj4+Pj4g
KysrIGIvZHJpdmVycy9pb21tdS9pb3ZhLmMKPj4+PiBAQCAtMjUsNiArMjUsNyBAQCBzdGF0aWMg
dm9pZCBpbml0X2lvdmFfcmNhY2hlcyhzdHJ1Y3QgaW92YV9kb21haW4gCj4+Pj4gKmlvdmFkKTsK
Pj4+PiDCoCBzdGF0aWMgdm9pZCBmcmVlX2lvdmFfcmNhY2hlcyhzdHJ1Y3QgaW92YV9kb21haW4g
KmlvdmFkKTsKPj4+PiDCoCBzdGF0aWMgdm9pZCBmcV9kZXN0cm95X2FsbF9lbnRyaWVzKHN0cnVj
dCBpb3ZhX2RvbWFpbiAqaW92YWQpOwo+Pj4+IMKgIHN0YXRpYyB2b2lkIGZxX2ZsdXNoX3RpbWVv
dXQoc3RydWN0IHRpbWVyX2xpc3QgKnQpOwo+Pj4+ICtzdGF0aWMgdm9pZCBmcmVlX2dsb2JhbF9j
YWNoZWRfaW92YXMoc3RydWN0IGlvdmFfZG9tYWluICppb3ZhZCk7Cj4+Cj4+IGEgdGhvdWdodDog
SXQgd291bGQgYmUgZ3JlYXQgaWYgdGhlIGZpbGUgY291bGQgYmUgcmVhcnJhbmdlZCBhdCBzb21l
IAo+PiBwb2ludCB3aGVyZSB3ZSBkb24ndCByZXF1aXJlIHNvIG1hbnkgZm9yd2FyZCBkZWNsYXJh
dGlvbnMuCj4+Cj4+Pj4gwqAgdm9pZAo+Pj4+IMKgIGluaXRfaW92YV9kb21haW4oc3RydWN0IGlv
dmFfZG9tYWluICppb3ZhZCwgdW5zaWduZWQgbG9uZyBncmFudWxlLAo+Pj4+IEBAIC00NDIsNiAr
NDQzLDcgQEAgYWxsb2NfaW92YV9mYXN0KHN0cnVjdCBpb3ZhX2RvbWFpbiAqaW92YWQsIAo+Pj4+
IHVuc2lnbmVkIGxvbmcgc2l6ZSwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZmx1c2hfcmNhY2hl
ID0gZmFsc2U7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGZvcl9lYWNoX29ubGluZV9jcHUoY3B1
KQo+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZyZWVfY3B1X2NhY2hlZF9pb3Zhcyhj
cHUsIGlvdmFkKTsKPj4+PiArwqDCoMKgwqDCoMKgwqAgZnJlZV9nbG9iYWxfY2FjaGVkX2lvdmFz
KGlvdmFkKTsKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byByZXRyeTsKPj4+PiDCoMKgwqDC
oMKgIH0KPj4+PiBAQCAtMTA1Nyw1ICsxMDU5LDI2IEBAIHZvaWQgZnJlZV9jcHVfY2FjaGVkX2lv
dmFzKHVuc2lnbmVkIGludCBjcHUsIAo+Pj4+IHN0cnVjdCBpb3ZhX2RvbWFpbiAqaW92YWQpCj4+
Pj4gwqDCoMKgwqDCoCB9Cj4+Pj4gwqAgfQo+Pj4+ICsvKgo+Pj4+ICsgKiBmcmVlIGFsbCB0aGUg
SU9WQSByYW5nZXMgb2YgZ2xvYmFsIGNhY2hlCj4+Pj4gKyAqLwo+Pj4+ICtzdGF0aWMgdm9pZCBm
cmVlX2dsb2JhbF9jYWNoZWRfaW92YXMoc3RydWN0IGlvdmFfZG9tYWluICppb3ZhZCkKPj4+PiAr
ewo+Pj4+ICvCoMKgwqAgc3RydWN0IGlvdmFfcmNhY2hlICpyY2FjaGU7Cj4+Pj4gK8KgwqDCoCB1
bnNpZ25lZCBsb25nIGZsYWdzOwo+Pj4+ICvCoMKgwqAgaW50IGksIGo7Cj4+Pj4gKwo+Pj4+ICvC
oMKgwqAgZm9yIChpID0gMDsgaSA8IElPVkFfUkFOR0VfQ0FDSEVfTUFYX1NJWkU7ICsraSkgewo+
Pj4+ICvCoMKgwqDCoMKgwqDCoCByY2FjaGUgPSAmaW92YWQtPnJjYWNoZXNbaV07Cj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgIHNwaW5fbG9ja19pcnFzYXZlKCZyY2FjaGUtPmxvY2ssIGZsYWdzKTsKPj4+
PiArwqDCoMKgwqDCoMKgwqAgZm9yIChqID0gMDsgaiA8IHJjYWNoZS0+ZGVwb3Rfc2l6ZTsgKytq
KSB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW92YV9tYWdhemluZV9mcmVlX3BmbnMo
cmNhY2hlLT5kZXBvdFtqXSwgaW92YWQpOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlv
dmFfbWFnYXppbmVfZnJlZShyY2FjaGUtPmRlcG90W2pdKTsKPj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByY2FjaGUtPmRlcG90W2pdID0gTlVMTDsKPj4KPj4gSSBkb24ndCB0aGluayB0aGF0
IE5VTExpZnkgaXMgc3RyaWN0bHkgbmVjZXNzYXJ5Cj4gCj4gVHJ1ZSwgd2UgZG9uJ3QgZXhwbGlj
aXRseSBjbGVhciBkZXBvdCBlbnRyaWVzIGluIF9faW92YV9yY2FjaGVfZ2V0KCkgZm9yIAo+IG5v
cm1hbCBvcGVyYXRpb24sIHNvIHRoZXJlJ3Mgbm90IG11Y2ggcG9pbnQgaW4gZG9pbmcgc28gaGVy
ZS4KClJpZ2h0LCBzbyBmb3IgY29uc2lzdGVuY3ksIEkgdGhpbmsgdGhhdCBpdCB3b3VsZCBiZSBu
aWNlIG5vdCB0byBOVUxMaWZ5LCAKZm9yIGNvbnNpc3RlbmN5LgoKPiAKPiBSb2Jpbi4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
