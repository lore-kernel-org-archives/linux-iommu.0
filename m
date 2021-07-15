Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463C5C07E96
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 06:29:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE3D461178
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 06:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3D461178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A238640411;
	Thu, 15 Jul 2021 06:29:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BtZ-hgS-Yd7n; Thu, 15 Jul 2021 06:29:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 48C7A403F0;
	Thu, 15 Jul 2021 06:29:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30E78C001A;
	Thu, 15 Jul 2021 06:29:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84E47C000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 06:29:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6376E40404
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 06:29:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aOKoKaEdWzhG for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 06:29:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A5C74403F0
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 06:29:16 +0000 (UTC)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GQPT04QJtzXtJ0;
 Thu, 15 Jul 2021 14:23:32 +0800 (CST)
Received: from dggpemm500022.china.huawei.com (7.185.36.162) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 14:29:11 +0800
Received: from [10.174.185.67] (10.174.185.67) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 14:29:10 +0800
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
To: "Tian, Kevin" <kevin.tian@intel.com>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
 <7ea349f8-8c53-e240-fe80-382954ba7f28@huawei.com>
 <BN9PR11MB5433A9B792441CAF21A183A38C129@BN9PR11MB5433.namprd11.prod.outlook.com>
From: Shenming Lu <lushenming@huawei.com>
Message-ID: <a8edb2c1-9c9c-6204-072c-4f1604b7dace@huawei.com>
Date: Thu, 15 Jul 2021 14:29:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5433A9B792441CAF21A183A38C129@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.67]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500022.china.huawei.com (7.185.36.162)
X-CFilter-Loop: Reflected
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti
 Wankhede <kwankhede@nvidia.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@nvidia.com>,
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>,
 "parav@mellanox.com" <parav@mellanox.com>, "Alex Williamson
 \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>, "Enrico Weigelt,
 metux IT consult" <lkml@metux.net>, David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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

T24gMjAyMS83LzE1IDExOjU1LCBUaWFuLCBLZXZpbiB3cm90ZToKPj4gRnJvbTogU2hlbm1pbmcg
THUgPGx1c2hlbm1pbmdAaHVhd2VpLmNvbT4KPj4gU2VudDogVGh1cnNkYXksIEp1bHkgMTUsIDIw
MjEgMTE6MjEgQU0KPj4KPj4gT24gMjAyMS83LzkgMTU6NDgsIFRpYW4sIEtldmluIHdyb3RlOgo+
Pj4gNC42LiBJL08gcGFnZSBmYXVsdAo+Pj4gKysrKysrKysrKysrKysrKysrKwo+Pj4KPj4+IHVB
UEkgaXMgVEJELiBIZXJlIGlzIGp1c3QgYWJvdXQgdGhlIGhpZ2gtbGV2ZWwgZmxvdyBmcm9tIGhv
c3QgSU9NTVUgZHJpdmVyCj4+PiB0byBndWVzdCBJT01NVSBkcml2ZXIgYW5kIGJhY2t3YXJkcy4g
VGhpcyBmbG93IGFzc3VtZXMgdGhhdCBJL08gcGFnZQo+PiBmYXVsdHMKPj4+IGFyZSByZXBvcnRl
ZCB2aWEgSU9NTVUgaW50ZXJydXB0cy4gU29tZSBkZXZpY2VzIHJlcG9ydCBmYXVsdHMgdmlhIGRl
dmljZQo+Pj4gc3BlY2lmaWMgd2F5IGluc3RlYWQgb2YgZ29pbmcgdGhyb3VnaCB0aGUgSU9NTVUu
IFRoYXQgdXNhZ2UgaXMgbm90Cj4+IGNvdmVyZWQKPj4+IGhlcmU6Cj4+Pgo+Pj4gLSAgIEhvc3Qg
SU9NTVUgZHJpdmVyIHJlY2VpdmVzIGEgSS9PIHBhZ2UgZmF1bHQgd2l0aCByYXcgZmF1bHRfZGF0
YSB7cmlkLAo+Pj4gICAgIHBhc2lkLCBhZGRyfTsKPj4+Cj4+PiAtICAgSG9zdCBJT01NVSBkcml2
ZXIgaWRlbnRpZmllcyB0aGUgZmF1bHRpbmcgSS9PIHBhZ2UgdGFibGUgYWNjb3JkaW5nIHRvCj4+
PiAgICAge3JpZCwgcGFzaWR9IGFuZCBjYWxscyB0aGUgY29ycmVzcG9uZGluZyBmYXVsdCBoYW5k
bGVyIHdpdGggYW4gb3BhcXVlCj4+PiAgICAgb2JqZWN0IChyZWdpc3RlcmVkIGJ5IHRoZSBoYW5k
bGVyKSBhbmQgcmF3IGZhdWx0X2RhdGEgKHJpZCwgcGFzaWQsIGFkZHIpOwo+Pj4KPj4+IC0gICBJ
T0FTSUQgZmF1bHQgaGFuZGxlciBpZGVudGlmaWVzIHRoZSBjb3JyZXNwb25kaW5nIGlvYXNpZCBh
bmQgZGV2aWNlCj4+PiAgICAgY29va2llIGFjY29yZGluZyB0byB0aGUgb3BhcXVlIG9iamVjdCwg
Z2VuZXJhdGVzIGFuIHVzZXIgZmF1bHRfZGF0YQo+Pj4gICAgIChpb2FzaWQsIGNvb2tpZSwgYWRk
cikgaW4gdGhlIGZhdWx0IHJlZ2lvbiwgYW5kIHRyaWdnZXJzIGV2ZW50ZmQgdG8KPj4+ICAgICB1
c2Vyc3BhY2U7Cj4+Pgo+Pgo+PiBIaSwgSSBoYXZlIHNvbWUgZG91YnRzIGhlcmU6Cj4+Cj4+IEZv
ciBtZGV2LCBpdCBzZWVtcyB0aGF0IHRoZSByaWQgaW4gdGhlIHJhdyBmYXVsdF9kYXRhIGlzIHRo
ZSBwYXJlbnQgZGV2aWNlJ3MsCj4+IHRoZW4gaW4gdGhlIHZTVkEgc2NlbmFyaW8sIGhvdyBjYW4g
d2UgZ2V0IHRvIGtub3cgdGhlIG1kZXYoY29va2llKSBmcm9tCj4+IHRoZQo+PiByaWQgYW5kIHBh
c2lkPwo+Pgo+PiBBbmQgZnJvbSB0aGlzIHBvaW50IG9mIHZpZXfvvIx3b3VsZCBpdCBiZSBiZXR0
ZXIgdG8gcmVnaXN0ZXIgdGhlIG1kZXYKPj4gKGlvbW11X3JlZ2lzdGVyX2RldmljZSgpKSB3aXRo
IHRoZSBwYXJlbnQgZGV2aWNlIGluZm8/Cj4+Cj4gCj4gVGhpcyBpcyB3aGF0IGlzIHByb3Bvc2Vk
IGluIHRoaXMgUkZDLiBBIHN1Y2Nlc3NmdWwgYmluZGluZyBnZW5lcmF0ZXMgYSBuZXcKPiBpb21t
dV9kZXYgb2JqZWN0IGZvciBlYWNoIHZmaW8gZGV2aWNlLiBGb3IgbWRldiB0aGlzIG9iamVjdCBp
bmNsdWRlcyAKPiBpdHMgcGFyZW50IGRldmljZSwgdGhlIGRlZlBBU0lEIG1hcmtpbmcgdGhpcyBt
ZGV2LCBhbmQgdGhlIGNvb2tpZSAKPiByZXByZXNlbnRpbmcgaXQgaW4gdXNlcnNwYWNlLiBMYXRl
ciBpdCBpcyBpb21tdV9kZXYgYmVpbmcgcmVjb3JkZWQgaW4KPiB0aGUgYXR0YWNoaW5nX2RhdGEg
d2hlbiB0aGUgbWRldiBpcyBhdHRhY2hlZCB0byBhbiBJT0FTSUQ6Cj4gCj4gCXN0cnVjdCBpb21t
dV9hdHRhY2hfZGF0YSAqX19pb21tdV9kZXZpY2VfYXR0YWNoKAo+IAkJc3RydWN0IGlvbW11X2Rl
diAqZGV2LCB1MzIgaW9hc2lkLCB1MzIgcGFzaWQsIGludCBmbGFncyk7Cj4gCj4gVGhlbiB3aGVu
IGEgZmF1bHQgaXMgcmVwb3J0ZWQsIHRoZSBmYXVsdCBoYW5kbGVyIGp1c3QgbmVlZHMgdG8gZmln
dXJlIG91dCAKPiBpb21tdV9kZXYgYWNjb3JkaW5nIHRvIHtyaWQsIHBhc2lkfSBpbiB0aGUgcmF3
IGZhdWx0IGRhdGEuCj4gCgpZZWFoLCB3ZSBoYXZlIHRoZSBkZWZQQVNJRCB0aGF0IG1hcmtzIHRo
ZSBtZGV2IGFuZCByZWZlcnMgdG8gdGhlIGRlZmF1bHQKSS9PIGFkZHJlc3Mgc3BhY2UsIGJ1dCBo
b3cgYWJvdXQgdGhlIG5vbi1kZWZhdWx0IEkvTyBhZGRyZXNzIHNwYWNlcz8KSXMgdGhlcmUgYSBj
YXNlIHRoYXQgdHdvIGRpZmZlcmVudCBtZGV2cyAob24gdGhlIHNhbWUgcGFyZW50IGRldmljZSkK
YXJlIHVzZWQgYnkgdGhlIHNhbWUgcHJvY2VzcyBpbiB0aGUgZ3Vlc3QsIHRodXMgaGF2ZSBhIHNh
bWUgcGFzaWQgcm91dGUKaW4gdGhlIHBoeXNpY2FsIElPTU1VPyBJdCBzZWVtcyB0aGF0IHdlIGNh
bid0IGZpZ3VyZSBvdXQgdGhlIG1kZXYgZnJvbQp0aGUgcmlkIGFuZCBwYXNpZCBpbiB0aGlzIGNh
c2UuLi4KCkRpZCBJIG1pc3VuZGVyc3RhbmQgc29tZXRoaW5nPy4uLiA6LSkKClRoYW5rcywKU2hl
bm1pbmcKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
