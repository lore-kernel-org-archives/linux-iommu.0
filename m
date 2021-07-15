Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE11C07E96
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 08:14:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5473C61106
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 08:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5473C61106
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C8CD83CAB;
	Thu, 15 Jul 2021 08:14:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sodN-BxzZBiA; Thu, 15 Jul 2021 08:14:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ED38183C8B;
	Thu, 15 Jul 2021 08:14:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3C02C0010;
	Thu, 15 Jul 2021 08:14:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A950C000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 08:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C1CA40638
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 08:14:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YuOSsFjcPpzC for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 08:14:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6FA7340147
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 08:14:18 +0000 (UTC)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GQRrw5Mgtzcd91;
 Thu, 15 Jul 2021 16:10:56 +0800 (CST)
Received: from dggpemm500022.china.huawei.com (7.185.36.162) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 16:14:14 +0800
Received: from [10.174.185.67] (10.174.185.67) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 16:14:13 +0800
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
To: "Tian, Kevin" <kevin.tian@intel.com>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
 <7ea349f8-8c53-e240-fe80-382954ba7f28@huawei.com>
 <BN9PR11MB5433A9B792441CAF21A183A38C129@BN9PR11MB5433.namprd11.prod.outlook.com>
 <a8edb2c1-9c9c-6204-072c-4f1604b7dace@huawei.com>
 <BN9PR11MB54336D6A8CAE31F951770A428C129@BN9PR11MB5433.namprd11.prod.outlook.com>
From: Shenming Lu <lushenming@huawei.com>
Message-ID: <5962d403-80c4-0ac4-4f37-96b055a2b4d0@huawei.com>
Date: Thu, 15 Jul 2021 16:14:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB54336D6A8CAE31F951770A428C129@BN9PR11MB5433.namprd11.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [10.174.185.67]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

T24gMjAyMS83LzE1IDE0OjQ5LCBUaWFuLCBLZXZpbiB3cm90ZToKPj4gRnJvbTogU2hlbm1pbmcg
THUgPGx1c2hlbm1pbmdAaHVhd2VpLmNvbT4KPj4gU2VudDogVGh1cnNkYXksIEp1bHkgMTUsIDIw
MjEgMjoyOSBQTQo+Pgo+PiBPbiAyMDIxLzcvMTUgMTE6NTUsIFRpYW4sIEtldmluIHdyb3RlOgo+
Pj4+IEZyb206IFNoZW5taW5nIEx1IDxsdXNoZW5taW5nQGh1YXdlaS5jb20+Cj4+Pj4gU2VudDog
VGh1cnNkYXksIEp1bHkgMTUsIDIwMjEgMTE6MjEgQU0KPj4+Pgo+Pj4+IE9uIDIwMjEvNy85IDE1
OjQ4LCBUaWFuLCBLZXZpbiB3cm90ZToKPj4+Pj4gNC42LiBJL08gcGFnZSBmYXVsdAo+Pj4+PiAr
KysrKysrKysrKysrKysrKysrCj4+Pj4+Cj4+Pj4+IHVBUEkgaXMgVEJELiBIZXJlIGlzIGp1c3Qg
YWJvdXQgdGhlIGhpZ2gtbGV2ZWwgZmxvdyBmcm9tIGhvc3QgSU9NTVUKPj4gZHJpdmVyCj4+Pj4+
IHRvIGd1ZXN0IElPTU1VIGRyaXZlciBhbmQgYmFja3dhcmRzLiBUaGlzIGZsb3cgYXNzdW1lcyB0
aGF0IEkvTyBwYWdlCj4+Pj4gZmF1bHRzCj4+Pj4+IGFyZSByZXBvcnRlZCB2aWEgSU9NTVUgaW50
ZXJydXB0cy4gU29tZSBkZXZpY2VzIHJlcG9ydCBmYXVsdHMgdmlhCj4+IGRldmljZQo+Pj4+PiBz
cGVjaWZpYyB3YXkgaW5zdGVhZCBvZiBnb2luZyB0aHJvdWdoIHRoZSBJT01NVS4gVGhhdCB1c2Fn
ZSBpcyBub3QKPj4+PiBjb3ZlcmVkCj4+Pj4+IGhlcmU6Cj4+Pj4+Cj4+Pj4+IC0gICBIb3N0IElP
TU1VIGRyaXZlciByZWNlaXZlcyBhIEkvTyBwYWdlIGZhdWx0IHdpdGggcmF3IGZhdWx0X2RhdGEg
e3JpZCwKPj4+Pj4gICAgIHBhc2lkLCBhZGRyfTsKPj4+Pj4KPj4+Pj4gLSAgIEhvc3QgSU9NTVUg
ZHJpdmVyIGlkZW50aWZpZXMgdGhlIGZhdWx0aW5nIEkvTyBwYWdlIHRhYmxlIGFjY29yZGluZyB0
bwo+Pj4+PiAgICAge3JpZCwgcGFzaWR9IGFuZCBjYWxscyB0aGUgY29ycmVzcG9uZGluZyBmYXVs
dCBoYW5kbGVyIHdpdGggYW4gb3BhcXVlCj4+Pj4+ICAgICBvYmplY3QgKHJlZ2lzdGVyZWQgYnkg
dGhlIGhhbmRsZXIpIGFuZCByYXcgZmF1bHRfZGF0YSAocmlkLCBwYXNpZCwgYWRkcik7Cj4+Pj4+
Cj4+Pj4+IC0gICBJT0FTSUQgZmF1bHQgaGFuZGxlciBpZGVudGlmaWVzIHRoZSBjb3JyZXNwb25k
aW5nIGlvYXNpZCBhbmQgZGV2aWNlCj4+Pj4+ICAgICBjb29raWUgYWNjb3JkaW5nIHRvIHRoZSBv
cGFxdWUgb2JqZWN0LCBnZW5lcmF0ZXMgYW4gdXNlciBmYXVsdF9kYXRhCj4+Pj4+ICAgICAoaW9h
c2lkLCBjb29raWUsIGFkZHIpIGluIHRoZSBmYXVsdCByZWdpb24sIGFuZCB0cmlnZ2VycyBldmVu
dGZkIHRvCj4+Pj4+ICAgICB1c2Vyc3BhY2U7Cj4+Pj4+Cj4+Pj4KPj4+PiBIaSwgSSBoYXZlIHNv
bWUgZG91YnRzIGhlcmU6Cj4+Pj4KPj4+PiBGb3IgbWRldiwgaXQgc2VlbXMgdGhhdCB0aGUgcmlk
IGluIHRoZSByYXcgZmF1bHRfZGF0YSBpcyB0aGUgcGFyZW50IGRldmljZSdzLAo+Pj4+IHRoZW4g
aW4gdGhlIHZTVkEgc2NlbmFyaW8sIGhvdyBjYW4gd2UgZ2V0IHRvIGtub3cgdGhlIG1kZXYoY29v
a2llKSBmcm9tCj4+Pj4gdGhlCj4+Pj4gcmlkIGFuZCBwYXNpZD8KPj4+Pgo+Pj4+IEFuZCBmcm9t
IHRoaXMgcG9pbnQgb2Ygdmlld++8jHdvdWxkIGl0IGJlIGJldHRlciB0byByZWdpc3RlciB0aGUg
bWRldgo+Pj4+IChpb21tdV9yZWdpc3Rlcl9kZXZpY2UoKSkgd2l0aCB0aGUgcGFyZW50IGRldmlj
ZSBpbmZvPwo+Pj4+Cj4+Pgo+Pj4gVGhpcyBpcyB3aGF0IGlzIHByb3Bvc2VkIGluIHRoaXMgUkZD
LiBBIHN1Y2Nlc3NmdWwgYmluZGluZyBnZW5lcmF0ZXMgYSBuZXcKPj4+IGlvbW11X2RldiBvYmpl
Y3QgZm9yIGVhY2ggdmZpbyBkZXZpY2UuIEZvciBtZGV2IHRoaXMgb2JqZWN0IGluY2x1ZGVzCj4+
PiBpdHMgcGFyZW50IGRldmljZSwgdGhlIGRlZlBBU0lEIG1hcmtpbmcgdGhpcyBtZGV2LCBhbmQg
dGhlIGNvb2tpZQo+Pj4gcmVwcmVzZW50aW5nIGl0IGluIHVzZXJzcGFjZS4gTGF0ZXIgaXQgaXMg
aW9tbXVfZGV2IGJlaW5nIHJlY29yZGVkIGluCj4+PiB0aGUgYXR0YWNoaW5nX2RhdGEgd2hlbiB0
aGUgbWRldiBpcyBhdHRhY2hlZCB0byBhbiBJT0FTSUQ6Cj4+Pgo+Pj4gCXN0cnVjdCBpb21tdV9h
dHRhY2hfZGF0YSAqX19pb21tdV9kZXZpY2VfYXR0YWNoKAo+Pj4gCQlzdHJ1Y3QgaW9tbXVfZGV2
ICpkZXYsIHUzMiBpb2FzaWQsIHUzMiBwYXNpZCwgaW50IGZsYWdzKTsKPj4+Cj4+PiBUaGVuIHdo
ZW4gYSBmYXVsdCBpcyByZXBvcnRlZCwgdGhlIGZhdWx0IGhhbmRsZXIganVzdCBuZWVkcyB0byBm
aWd1cmUgb3V0Cj4+PiBpb21tdV9kZXYgYWNjb3JkaW5nIHRvIHtyaWQsIHBhc2lkfSBpbiB0aGUg
cmF3IGZhdWx0IGRhdGEuCj4+Pgo+Pgo+PiBZZWFoLCB3ZSBoYXZlIHRoZSBkZWZQQVNJRCB0aGF0
IG1hcmtzIHRoZSBtZGV2IGFuZCByZWZlcnMgdG8gdGhlIGRlZmF1bHQKPj4gSS9PIGFkZHJlc3Mg
c3BhY2UsIGJ1dCBob3cgYWJvdXQgdGhlIG5vbi1kZWZhdWx0IEkvTyBhZGRyZXNzIHNwYWNlcz8K
Pj4gSXMgdGhlcmUgYSBjYXNlIHRoYXQgdHdvIGRpZmZlcmVudCBtZGV2cyAob24gdGhlIHNhbWUg
cGFyZW50IGRldmljZSkKPj4gYXJlIHVzZWQgYnkgdGhlIHNhbWUgcHJvY2VzcyBpbiB0aGUgZ3Vl
c3QsIHRodXMgaGF2ZSBhIHNhbWUgcGFzaWQgcm91dGUKPj4gaW4gdGhlIHBoeXNpY2FsIElPTU1V
PyBJdCBzZWVtcyB0aGF0IHdlIGNhbid0IGZpZ3VyZSBvdXQgdGhlIG1kZXYgZnJvbQo+PiB0aGUg
cmlkIGFuZCBwYXNpZCBpbiB0aGlzIGNhc2UuLi4KPj4KPj4gRGlkIEkgbWlzdW5kZXJzdGFuZCBz
b21ldGhpbmc/Li4uIDotKQo+Pgo+IAo+IE5vLiBZb3UgYXJlIHJpZ2h0IG9uIHRoaXMgY2FzZS4g
SSBkb24ndCB0aGluayB0aGVyZSBpcyBhIHdheSB0byAKPiBkaWZmZXJlbnRpYXRlIG9uZSBtZGV2
IGZyb20gdGhlIG90aGVyIGlmIHRoZXkgY29tZSBmcm9tIHRoZQo+IHNhbWUgcGFyZW50IGFuZCBh
dHRhY2hlZCBieSB0aGUgc2FtZSBndWVzdCBwcm9jZXNzLiBJbiB0aGlzCj4gY2FzZSB0aGUgZmF1
bHQgY291bGQgYmUgcmVwb3J0ZWQgb24gZWl0aGVyIG1kZXYgKGUuZy4gdGhlIGZpcnN0Cj4gbWF0
Y2hpbmcgb25lKSB0byBnZXQgaXQgZml4ZWQgaW4gdGhlIGd1ZXN0Lgo+IAoKT0suIFRoYW5rcywK
ClNoZW5taW5nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
