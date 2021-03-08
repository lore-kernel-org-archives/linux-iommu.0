Return-Path: <SRS0=OBKs=IG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEE6C433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Mar 2021 16:24:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F5D065226
	for <iommu@archiver.kernel.org>; Mon,  8 Mar 2021 16:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5D065226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D01586058A;
	Mon,  8 Mar 2021 16:24:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F9rGUogFXZJb; Mon,  8 Mar 2021 16:24:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8ED46F4D4;
	Mon,  8 Mar 2021 16:24:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9269CC000B;
	Mon,  8 Mar 2021 16:24:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 954A5C0001
 for <iommu@lists.linux-foundation.org>; Mon,  8 Mar 2021 16:24:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8914F400E0
 for <iommu@lists.linux-foundation.org>; Mon,  8 Mar 2021 16:24:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yX-SCHBUoUaU for <iommu@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 16:24:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F2C7400D6
 for <iommu@lists.linux-foundation.org>; Mon,  8 Mar 2021 16:24:16 +0000 (UTC)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DvNmq6Dy2z67wj5;
 Tue,  9 Mar 2021 00:18:19 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 17:24:13 +0100
Received: from [10.210.165.214] (10.210.165.214) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 16:24:12 +0000
Subject: Re: [PATCH 1/1] Revert "iommu/iova: Retry from last rb tree node if
 iova search fails"
To: Robin Murphy <robin.murphy@arm.com>, "Leizhen (ThunderTown)"
 <thunder.leizhen@huawei.com>, Will Deacon <will@kernel.org>, Joerg Roedel
 <joro@8bytes.org>, iommu <iommu@lists.linux-foundation.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
References: <20210129092120.1482-1-thunder.leizhen@huawei.com>
 <5505b1e5-2450-d5c4-6d77-5bb21fd0b6a1@huawei.com>
 <e8ff095f-7b7c-da38-3675-cd3c1ee84b1a@arm.com>
 <7e18829a-3e7e-cc82-9d33-366cf2025624@huawei.com>
 <4c634a22-7168-b51c-a012-2009fc03e6c3@arm.com>
 <d090b869-b3ac-fecc-9efd-d870e43e0d99@huawei.com>
 <eacd5ccd-ab5a-27fe-6542-deaefd597d11@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <c58abbec-7220-b440-98d4-d1026a8feed4@huawei.com>
Date: Mon, 8 Mar 2021 16:22:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <eacd5ccd-ab5a-27fe-6542-deaefd597d11@arm.com>
Content-Language: en-US
X-Originating-IP: [10.210.165.214]
X-ClientProxiedBy: lhreml739-chm.china.huawei.com (10.201.108.189) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: Vijayanand Jitta <vjitta@codeaurora.org>, Linuxarm <linuxarm@huawei.com>
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

T24gMDgvMDMvMjAyMSAxNToxNSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiBJIGZpZ3VyZSB0aGF0
IHlvdSdyZSB0YWxraW5nIGFib3V0IDRlODlkY2U3MjUyMSBub3cuIEkgd291bGQgaGF2ZSAKPj4g
bGlrZWQgdG8ga25vdyB3aGljaCByZWFsLWxpZmUgcHJvYmxlbSBpdCBzb2x2ZWQgaW4gcHJhY3Rp
Y2UuCj4gCj4gIEZyb20gd2hhdCBJIHJlbWVtYmVyLCB0aGUgcHJvYmxlbSByZXBvcnRlZCB3YXMg
YmFzaWNhbGx5IHRoZSBvbmUgCj4gaWxsdXN0cmF0ZWQgaW4gdGhhdCBjb21taXQgYW5kIHRoZSBv
bmUgSSBhbGx1ZGVkIHRvIGFib3ZlIC0gbmFtZWx5IHRoYXQgCj4gY2VydGFpbiBhbGxvY2F0aW9u
IHBhdHRlcm5zIHdpdGggYSBicm9hZCBtaXggb2Ygc2l6ZXMgYW5kIHJlbGF0aXZlIAo+IGxpZmV0
aW1lcyBlbmQgdXAgcHVzaGluZyB0aGUgY2FjaGVkIFBGTiBkb3duIHRvIHRoZSBib3R0b20gb2Yg
dGhlIAo+IGFkZHJlc3Mgc3BhY2Ugc3VjaCB0aGF0IGFsbG9jYXRpb25zIHN0YXJ0IGZhaWxpbmcg
ZGVzcGl0ZSB0aGVyZSBzdGlsbCAKPiBiZWluZyBzdWZmaWNpZW50IGZyZWUgc3BhY2Ugb3ZlcmFs
bCwgd2hpY2ggd2FzIGJyZWFraW5nIHNvbWUgbWVkaWEgCj4gd29ya2xvYWQuIFdoYXQgd2FzIG9y
aWdpbmFsbHkgcHJvcG9zZWQgd2FzIGFuIG92ZXJjb21wbGljYXRlZCBwYWxhdmVyIAo+IHdpdGgg
RE1BIGF0dHJpYnV0ZXMgYW5kIGEgd2hvbGUgZXh0cmEgYWxsb2NhdGlvbiBhbGdvcml0aG0gcmF0
aGVyIHRoYW4gCj4ganVzdCBmaXhpbmcgdGhlIGNsZWFybHkgdW5pbnRlbmRlZCBhbmQgYnJva2Vu
IGJlaGF2aW91ci4KCm9rLCBmaW5lLiBJIGp1c3Qgd29uZGVyZWQgaWYgdGhpcyB3YXMgYSB0aGVv
cmV0aWNhbCBwcm9ibGVtIG9ubHkuCgo+IAo+Pj4gV2hpbGUgbWF4MzJfYWxsb2Nfc2l6ZSBpbmRp
cmVjdGx5IHRyYWNrcyB0aGUgbGFyZ2VzdCpjb250aWd1b3VzKiAKPj4+IGF2YWlsYWJsZSBzcGFj
ZSwgb25lIG9mIHRoZSBpZGVhcyBmcm9tIHdoaWNoIGl0IGdyZXcgd2FzIHRvIHNpbXBseSBrZWVw
Cj4+PiBjb3VudCBvZiB0aGUgdG90YWwgbnVtYmVyIG9mIGZyZWUgUEZOcy4gSWYgeW91J3JlIHJl
YWxseSBzcGVuZGluZwo+Pj4gc2lnbmlmaWNhbnQgdGltZSBkZXRlcm1pbmluZyB0aGF0IHRoZSB0
cmVlIGlzIGZ1bGwsIGFzIG9wcG9zZWQgdG8ganVzdAo+Pj4gdGFraW5nIGxvbmdlciB0byBldmVu
dHVhbGx5IHN1Y2NlZWQsIHRoZW4gaXQgbWlnaHQgYmUgcmVsYXRpdmVseQo+Pj4gaW5ub2N1b3Vz
IHRvIHRhY2sgb24gdGhhdCBzZW1pLXJlZHVuZGFudCBleHRyYSBhY2NvdW50aW5nIGFzIGEKPj4+
IHNlbGYtY29udGFpbmVkIHF1aWNrIGZpeCBmb3IgdGhhdCB3b3JzdCBjYXNlLgo+Pj4KCi4uLgoK
Pj4KPj4gRXZlbiBpZiBpdCBpcyB3ZXJlIGNvbmZpZ3VyYWJsZSwgd291bGRuJ3QgaXQgbWFrZSBz
ZW5zZSB0byBoYXZlIGl0IAo+PiBjb25maWd1cmFibGUgcGVyIElPVkEgZG9tYWluPwo+IAo+IFBl
cmhhcHMsIGJ1dCBJIGRvbid0IHNlZSB0aGF0IGJlaW5nIGF0IGFsbCBlYXN5IHRvIGltcGxlbWVu
dC4gV2UgY2FuJ3QgCj4gYXJiaXRyYXJpbHkgKmluY3JlYXNlKiB0aGUgc2NvcGUgb2YgY2FjaGlu
ZyBvbmNlIGEgZG9tYWluIGlzIGFjdGl2ZSBkdWUgCj4gdG8gdGhlIHNpemUtcm91bmRpbmctdXAg
cmVxdWlyZW1lbnQsIHdoaWNoIHdvdWxkIGJlIHByb2hpYml0aXZlIHRvIAo+IGxhcmdlciBhbGxv
Y2F0aW9ucyBpZiBhcHBsaWVkIHVuaXZlcnNhbGx5Lgo+IAoKQWdyZWVkLgoKQnV0IGhhdmluZyB0
aGF0IChhbGwgSU9WQXMgc2l6ZXMgYmVpbmcgY2FjaGVhYmxlKSBhdmFpbGFibGUgY291bGQgYmUg
CnJlYWxseSBncmVhdCwgdGhvdWdoLCBmb3Igc29tZSBzaXR1YXRpb25zLgoKPj4gRnVydGhlcm1v
cmUsIGFzIG1lbnRpb25lZCBhYm92ZSwgSSBzdGlsbCB3YW50IHRvIHNvbHZlIHRoaXMgSU9WQSBh
Z2luZyAKPj4gaXNzdWUsIGFuZCB0aGlzIGZpeGVkIFJDQUNIRSBSQU5HRSBzaXplIHNlZW1zIHRv
IGJlIHRoZSBhdCB0aGUgY2VudGVyIAo+PiBvZiB0aGF0IHByb2JsZW0uCj4+Cj4+Pgo+Pj4+IEFz
IGZvciA0ZTg5ZGNlNzI1MjEsIHNvIGV2ZW4gaWYgaXQncyBwcm9wZXIgdG8gcmV0cnkgZm9yIGEg
ZmFpbGVkIAo+Pj4+IGFsbG9jLAo+Pj4+IGl0IGlzIG5vdCBhbHdheXMgbmVjZXNzYXJ5LiBJIG1l
YW4sIGlmIHdlJ3JlIGxpbWl0aW5nIG91cnNlbHZlcyB0byAzMmIKPj4+PiBzdWJzcGFjZSBmb3Ig
dGhpcyBTQUMgdHJpY2sgYW5kIHdlIGZhaWwgdGhlIGFsbG9jLCB0aGVuIHdlIGNhbiB0cnkgdGhl
Cj4+Pj4gc3BhY2UgYWJvdmUgMzJiIGZpcnN0IChpZiB1c2FibGUpLiBJZiB0aGF0IGZhaWxzLCB0
aGVuIHJldHJ5IHRoZXJlLiBJCj4+Pj4gZG9uJ3Qgc2VlIGEgbmVlZCB0byByZXRyeSB0aGUgMzJi
IHN1YnNwYWNlIGlmIHdlJ3JlIG5vdCBsaW1pdGVkIHRvIGl0Lgo+Pj4+IEhvdyBhYm91dCBpdD8g
V2UgdHJpZWQgdGhhdCBpZGVhIGFuZCBpdCBsb29rcyB0byBqdXN0IGFib3V0IHJlc3RvcmUKPj4+
PiBwZXJmb3JtYW5jZS4KPj4+IFRoZSB0aGluZyBpcywgaWYgeW91IGRvIGhhdmUgYW4gYWN0dWFs
IFBDSSBkZXZpY2Ugd2hlcmUgREFDIG1pZ2h0IG1lYW4gYQo+Pj4gMzMlIHRocm91Z2hwdXQgbG9z
cyBhbmQgeW91J3JlIG1hcHBpbmcgYSBsb25nLWxpdmVkIGJ1ZmZlciwgb3IgeW91J3JlIG9uCj4+
PiBvbmUgb2YgdGhlc2Ugc3lzdGVtcyB3aGVyZSBmaXJtd2FyZSBmYWlscyB0byBkb2N1bWVudCBh
ZGRyZXNzIGxpbWl0cyBhbmQKPj4+IHVzaW5nIHRoZSBmdWxsIElPTU1VIGFkZHJlc3Mgd2lkdGgg
cXVpZXRseSBicmVha3MgdGhpbmdzLCB0aGVuIHlvdQo+Pj4gYWxtb3N0IGNlcnRhaW5seSpkbyrC
oCB3YW50IHRoZSBhbGxvY2F0b3IgdG8gYWN0dWFsbHkgZG8gYSBwcm9wZXIgam9iIG9mCj4+PiB0
cnlpbmcgdG8gc2F0aXNmeSB0aGUgZ2l2ZW4gcmVxdWVzdC4KPj4KPj4gSWYgdGhvc2UgY29uZGl0
aW9ucyB3ZXJlIHRydWUsIHRoZW4gaXQgc2VlbXMgcXVpdGUgYSB0ZW51b3VzIHBvc2l0aW9uLCAK
Pj4gc28gdHJ5aW5nIHRvIGhlbHAgdGhhdCBzY2VuYXJpbyBpbiBnZW5lcmFsIHRlcm1zIHdpbGwg
aGF2ZSBsaW1pdGVkIAo+PiBlZmZpY2FjeS4KPiAKPiBTdGlsbCwgSSdkIGJlIGN1cmlvdXMgdG8g
c2VlIGlmIG1ha2luZyB0aGUgcmVzdGFydCBhIGJpdCBjbGV2ZXJlciBvZmZlcnMgCj4gYSBub3Rp
Y2VhYmxlIGltcHJvdmVtZW50LiBJSVJDIEkgc3VnZ2VzdGVkIGl0IGF0IHRoZSB0aW1lLCBidXQg
aW4gdGhlIAo+IGVuZCB0aGUgcHVzaCB3YXMganVzdCB0byBnZXQgKnNvbWV0aGluZyogbWVyZ2Vk
LgoKU29ycnkgdG8gc2F5LCBJIGp1c3QgdGVzdGVkIHRoYXQgKCJpb21tdS9pb3ZhOiBJbXByb3Zl
IHJlc3RhcnQgbG9naWMiKSAKYW5kIHRoZXJlIGlzIG5vIG9idmlvdXMgaW1wcm92ZW1lbnQuCgpJ
J2xsIGhhdmUgYSBmdXJ0aGVyIGxvb2sgYXQgd2hhdCBtaWdodCBiZSBnb2luZyBvbi4KClRoYW5r
cyB2ZXJ5IG11Y2gsCkpvaG4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
