Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D28C433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 16:09:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3BDC64E4D
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 16:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BDC64E4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CB9683759;
	Thu, 18 Mar 2021 16:09:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G_W_GvWKb1kP; Thu, 18 Mar 2021 16:09:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41ED1836A5;
	Thu, 18 Mar 2021 16:09:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16FFEC000B;
	Thu, 18 Mar 2021 16:09:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51172C0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 16:09:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2A0C84EBB8
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 16:09:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5FVbLvgWSZek for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 16:09:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E8CD84EBB9
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 16:09:26 +0000 (UTC)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F1Ww628xgz681Nc;
 Fri, 19 Mar 2021 00:00:54 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 18 Mar 2021 17:09:22 +0100
Received: from [10.47.0.142] (10.47.0.142) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 18 Mar
 2021 16:09:21 +0000
Subject: Re: [PATCH 2/2] iommu/iova: Improve restart logic
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>
References: <03931d86c0ad71f44b29394e3a8d38bfc32349cd.1614962123.git.robin.murphy@arm.com>
 <076b3484d1e5057b95d8c387c894bd6ad2514043.1614962123.git.robin.murphy@arm.com>
 <c1181e3b-cdf3-c658-1c57-8ec86d034f4b@huawei.com>
 <d8e80756-a628-3a0d-77ac-1e9df734f1c5@huawei.com>
 <6cea11f9-e98d-98cb-6789-93abd8833fa0@huawei.com>
 <878f4f77-97ee-898d-eb05-4548cf00ec27@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <b9417479-4e45-8b31-bc32-d20739c97a10@huawei.com>
Date: Thu, 18 Mar 2021 16:07:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <878f4f77-97ee-898d-eb05-4548cf00ec27@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.0.142]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: vjitta@codeaurora.org, iommu@lists.linux-foundation.org,
 Linuxarm <linuxarm@huawei.com>, linux-kernel@vger.kernel.org
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

PiAKPiBXZWxsIHllYWgsIGluIHlvdXIgcGFydGljdWxhciBjYXNlIHlvdSdyZSBhbGxvY2F0aW5n
IGZyb20gYSBoZWF2aWx5IAo+IG92ZXItY29udGVuZGVkIGFkZHJlc3Mgc3BhY2UsIHNvIG11Y2gg
b2YgdGhlIHRpbWUgaXQgaXMgZ2VudWluZWx5IGZ1bGwuIAo+IFBsdXMgeW91J3JlIHByaW1hcmls
eSBjaHVybmluZyBvbmUgb3IgdHdvIHNpemVzIG9mIElPVkEsIHNvIHRoZXJlJ3MgYSAKPiBoaWdo
IGNoYW5jZSB0aGF0IHlvdSB3aWxsIGVpdGhlciBhbGxvY2F0ZSBpbW1lZGlhdGVseSBmcm9tIHRo
ZSBjYWNoZWQgCj4gbm9kZSAoYWZ0ZXIgYSBwcmV2aW91cyBmcmVlKSwgb3Igc2VhcmNoIHRoZSB3
aG9sZSBzcGFjZSBhbmQgZmFpbC4gSW4gCj4gY2FzZSBpdCB3YXMgbWlzc2VkLCBzZWFyY2hpbmcg
b25seSBzb21lIGFyYml0cmFyeSBzdWJzZXQgb2YgdGhlIHNwYWNlIAo+IGJlZm9yZSBnaXZpbmcg
dXAgaXMgbm90IGEgZ29vZCBiZWhhdmlvdXIgZm9yIGFuIGFsbG9jYXRvciB0byBoYXZlIGluIAo+
IGdlbmVyYWwuCj4gCj4+PiBTbyBzaW5jZSB0aGUgcmV0cnkgbWVhbnMgdGhhdCB3ZSBzZWFyY2gg
dGhyb3VnaCB0aGUgY29tcGxldGUgcGZuIAo+Pj4gcmFuZ2UgbW9zdCBvZiB0aGUgdGltZSAoZHVl
IHRvIHBvb3Igc3VjY2VzcyByYXRlKSwgd2Ugc2hvdWxkIGJlIGFibGUgCj4+PiB0byBkbyBhIGJl
dHRlciBqb2IgYXQgbWFpbnRhaW5pbmcgYW4gYWNjdXJhdGUgbWF4IGFsbG9jIHNpemUsIGJ5IAo+
Pj4gY2FsY3VsYXRpbmcgaXQgZnJvbSB0aGUgcmFuZ2Ugc2VhcmNoLCBhbmQgbm90IHJlbHlpbmcg
b24gbWF4IGFsbG9jIAo+Pj4gZmFpbGVkIG9yIHJlc2V0dGluZyBpdCBmcmVxdWVudGx5LiBIb3Bl
ZnVsbHkgdGhhdCB3b3VsZCBtZWFuIHRoYXQgCj4+PiB3ZSdyZSBzbWFydGVyIGFib3V0IG5vdCB0
cnlpbmcgdGhlIGFsbG9jYXRpb24uCj4+Cj4+IFNvIEkgdHJpZWQgdGhhdCBvdXQgYW5kIHdlIHNl
ZW0gdG8gYmUgYWJsZSB0byBzY3JhcCBiYWNrIGFuIAo+PiBhcHByZWNpYWJsZSBhbW91bnQgb2Yg
cGVyZm9ybWFuY2UuIE1heWJlIDgwJSBvZiBvcmlnaW5hbCwgd2l0aCB3aXRoIAo+PiBhbm90aGVy
IGNoYW5nZSwgYmVsb3cuCj4gCj4gVEJIIGlmIHlvdSByZWFsbHkgd2FudCB0byBtYWtlIGFsbG9j
YXRpb24gbW9yZSBlZmZpY2llbnQgSSB0aGluayB0aGVyZSAKPiBhcmUgbW9yZSByYWRpY2FsIGNo
YW5nZXMgdGhhdCB3b3VsZCBiZSB3b3J0aCBleHBlcmltZW50aW5nIHdpdGgsIGxpa2UgCj4gdXNp
bmcgc29tZSBmb3JtIG9mIGF1Z21lbnRlZCByYnRyZWUgdG8gYWxzbyBlbmNvZGUgdGhlIGFtb3Vu
dCBvZiBmcmVlIAo+IHNwYWNlIHVuZGVyIGVhY2ggYnJhbmNoLCBvciByZXByZXNlbnRpbmcgdGhl
IGZyZWUgc3BhY2UgaW4gaXRzIG93biAKPiBwYXJhbGxlbCB0cmVlLCBvciB3aGV0aGVyIHNvbWUg
b3RoZXIgc3RydWN0dXJlIGVudGlyZWx5IG1pZ2h0IGJlIGEgCj4gYmV0dGVyIGJldCB0aGVzZSBk
YXlzLgo+IAo+IEFuZCBpZiB5b3UganVzdCB3YW50IHRvIG1ha2UgeW91ciB0aGluZyBhY2NlcHRh
Ymx5IGZhc3QsIG5vdyBJJ20gZ29pbmcgCj4gdG8gc2F5IHN0aWNrIGEgcXVpcmsgc29tZXdoZXJl
IHRvIGZvcmNlIHRoZSAiZm9yY2VkYWMiIG9wdGlvbiBvbiB5b3VyIAo+IHBsYXRmb3JtIDspCj4g
CgpFYXNpZXIgc2FpZCB0aGFuIGRvbmUgOikKCkJ1dCBzdGlsbCwgSSdkIGxpa2UgdG8ganVzdCBi
ZSBhYmxlIHRvIGNhY2hlIGFsbCBJT1ZBIHNpemVzIGZvciBteSBETUEgCmVuZ2luZSwgc28gd2Ug
c2hvdWxkIG5vdCBoYXZlIHRvIGdvIG5lYXIgdGhlIFJCIHRyZWUgb2Z0ZW4uCgpJIGhhdmUgcHV0
IHRvZ2V0aGVyIGEgc2VyaWVzIHRvIGFsbG93IHVwcGVyIGxpbWl0IG9mIHJjYWNoZSByYW5nZSBi
ZSAKaW5jcmVhc2VkIHBlciBkb21haW4uIFNvIG5hdHVyYWxseSB0aGF0IGdpdmVzIGJldHRlciBw
ZXJmb3JtYW5jZSB0aGFuIHdlIApvcmlnaW5hbGx5IGhhZC4KCkkgZG9uJ3Qgd2FudCB0byBwcmVq
dWRpY2UgdGhlIHNvbHV0aW9uIGJ5IHNheWluZyB3aGF0IEkgdGhpbmsgb2YgaXQgbm93LCAKc28g
d2lsbCBzZW5kIGl0IG91dC4uLgoKCj4gWy4uLl0KPj4+Pj4gQEAgLTIxOSw3ICsyNTYsNyBAQCBz
dGF0aWMgaW50IF9fYWxsb2NfYW5kX2luc2VydF9pb3ZhX3JhbmdlKHN0cnVjdCAKPj4+Pj4gaW92
YV9kb21haW4gKmlvdmFkLAo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGxvd19wZm4gPT0g
aW92YWQtPnN0YXJ0X3BmbiAmJiByZXRyeV9wZm4gPCBsaW1pdF9wZm4pIHsKPj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaGlnaF9wZm4gPSBsaW1pdF9wZm47Cj4+Pj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGxvd19wZm4gPSByZXRyeV9wZm47Cj4+Pj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGN1cnIgPSAmaW92YWQtPmFuY2hvci5ub2RlOwo+Pj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBjdXJyID0gaW92YV9maW5kX2xpbWl0KGlvdmFkLCBsaW1pdF9wZm4pOwo+
Pgo+Pgo+PiBJIHNlZSB0aGF0IGl0IGlzIG5vdyBhcHBsaWVkLiBIb3dldmVyLCBhbHRlcm5hdGl2
ZWx5IGNvdWxkIHdlIGp1c3QgYWRkIAo+PiBhIHplcm8tbGVuZ3RoIDMyYiBib3VuZGFyeSBtYXJr
ZXIgbm9kZSBmb3IgdGhlIDMyYiBwZm4gcmVzdGFydCBwb2ludD8KPiAKPiBUaGF0IHdvdWxkIG5l
ZWQgc3BlY2lhbCBjYXNlcyBhbGwgb3ZlciB0aGUgcGxhY2UgdG8gcHJldmVudCB0aGUgbWFya2Vy
IAo+IGdldHRpbmcgbWVyZ2VkIGludG8gcmVzZXJ2YXRpb25zIG9yIGhpdCBieSBsb29rdXBzLCBh
bmQgYXQgd29yc3QgYnJlYWsgCj4gdGhlIG9yZGVyaW5nIG9mIHRoZSB0cmVlIGlmIGEgbGVnaXRp
bWF0ZSBub2RlIHN0cmFkZGxlcyB0aGUgYm91bmRhcnkuIEkgCj4gZGlkIGNvbnNpZGVyIGhhdmlu
ZyB0aGUgaW5zZXJ0L2RlbGV0ZSByb3V0aW5lcyBrZWVwIHRyYWNrIG9mIHlldCBhbm90aGVyIAo+
IGNhY2hlZCBub2RlIGZvciB3aGF0ZXZlcidzIGN1cnJlbnRseSB0aGUgZmlyc3QgdGhpbmcgYWJv
dmUgdGhlIDMyLWJpdCAKPiBib3VuZGFyeSwgYnV0IEkgd2FzIHdvcnJpZWQgdGhhdCBtaWdodCBi
ZSBhIGJpdCB0b28gaW52YXNpdmUuCgpZZWFoLCBJIGRpZCB0aGluayBvZiB0aGF0LiBJIGRvbid0
IHRoaW5rIHRoYXQgaXQgd291bGQgaGF2ZSB0b28gbXVjaCAKb3ZlcmhlYWQuCgo+IAo+IEZXSVcg
SSdtIGN1cnJlbnRseSBwbGFubmluZyB0byBjb21lIGJhY2sgdG8gdGhpcyBhZ2FpbiB3aGVuIEkg
aGF2ZSBhIGJpdCAKPiBtb3JlIHRpbWUsIHNpbmNlIHRoZSBvcHRpbXVtIHRoaW5nIHRvIGRvICht
b2R1bG8gcmVwbGFjaW5nIHRoZSBlbnRpcmUgCj4gYWxnb3JpdGhtLi4uKSBpcyBhY3R1YWxseSB0
byBtYWtlIHRoZSBzZWNvbmQgcGFydCBvZiB0aGUgc2VhcmNoIAo+ICp1cHdhcmRzKiBmcm9tIHRo
ZSBjYWNoZWQgbm9kZSB0byB0aGUgbGltaXQuIEZ1cnRoZXJtb3JlLCB0byByZXZpdmUgbXkgCj4g
YXJjaC9hcm0gY29udmVyc2lvbiBJIHRoaW5rIHdlJ3JlIHJlYWxpc3RpY2FsbHkgZ29pbmcgdG8g
bmVlZCBhIAo+IGNvbXBhdGliaWxpdHkgb3B0aW9uIGZvciBib3R0b20tdXAgYWxsb2NhdGlvbiB0
byBhdm9pZCB0b28gbWFueSBuYXN0eSAKPiBzdXJwcmlzZXMsIHNvIEknZCBsaWtlIHRvIGdlbmVy
YWxpc2UgdGhpbmdzIHRvIHRhY2tsZSBib3RoIGNvbmNlcm5zIGF0IAo+IG9uY2UuCj4gCgpUaGFu
a3MsCkpvaG4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
