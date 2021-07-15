Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D532C12002
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 03:20:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 122E861374
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 03:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122E861374
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B921A60763;
	Thu, 15 Jul 2021 03:20:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BfZt2crGqx7X; Thu, 15 Jul 2021 03:20:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8AFF06069B;
	Thu, 15 Jul 2021 03:20:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BD7CC0010;
	Thu, 15 Jul 2021 03:20:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E186C000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 03:20:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05A2083CF7
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 03:20:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6O9eTkKy50mN for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 03:20:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A292683C6D
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 03:20:49 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GQKKz5SXlz7tWX;
 Thu, 15 Jul 2021 11:17:11 +0800 (CST)
Received: from dggpemm500022.china.huawei.com (7.185.36.162) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 11:20:44 +0800
Received: from [10.174.185.67] (10.174.185.67) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 11:20:43 +0800
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
To: "Tian, Kevin" <kevin.tian@intel.com>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
From: Shenming Lu <lushenming@huawei.com>
Message-ID: <7ea349f8-8c53-e240-fe80-382954ba7f28@huawei.com>
Date: Thu, 15 Jul 2021 11:20:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
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

T24gMjAyMS83LzkgMTU6NDgsIFRpYW4sIEtldmluIHdyb3RlOgo+IDQuNi4gSS9PIHBhZ2UgZmF1
bHQKPiArKysrKysrKysrKysrKysrKysrCj4gCj4gdUFQSSBpcyBUQkQuIEhlcmUgaXMganVzdCBh
Ym91dCB0aGUgaGlnaC1sZXZlbCBmbG93IGZyb20gaG9zdCBJT01NVSBkcml2ZXIKPiB0byBndWVz
dCBJT01NVSBkcml2ZXIgYW5kIGJhY2t3YXJkcy4gVGhpcyBmbG93IGFzc3VtZXMgdGhhdCBJL08g
cGFnZSBmYXVsdHMKPiBhcmUgcmVwb3J0ZWQgdmlhIElPTU1VIGludGVycnVwdHMuIFNvbWUgZGV2
aWNlcyByZXBvcnQgZmF1bHRzIHZpYSBkZXZpY2UKPiBzcGVjaWZpYyB3YXkgaW5zdGVhZCBvZiBn
b2luZyB0aHJvdWdoIHRoZSBJT01NVS4gVGhhdCB1c2FnZSBpcyBub3QgY292ZXJlZAo+IGhlcmU6
Cj4gCj4gLSAgIEhvc3QgSU9NTVUgZHJpdmVyIHJlY2VpdmVzIGEgSS9PIHBhZ2UgZmF1bHQgd2l0
aCByYXcgZmF1bHRfZGF0YSB7cmlkLCAKPiAgICAgcGFzaWQsIGFkZHJ9Owo+IAo+IC0gICBIb3N0
IElPTU1VIGRyaXZlciBpZGVudGlmaWVzIHRoZSBmYXVsdGluZyBJL08gcGFnZSB0YWJsZSBhY2Nv
cmRpbmcgdG8KPiAgICAge3JpZCwgcGFzaWR9IGFuZCBjYWxscyB0aGUgY29ycmVzcG9uZGluZyBm
YXVsdCBoYW5kbGVyIHdpdGggYW4gb3BhcXVlCj4gICAgIG9iamVjdCAocmVnaXN0ZXJlZCBieSB0
aGUgaGFuZGxlcikgYW5kIHJhdyBmYXVsdF9kYXRhIChyaWQsIHBhc2lkLCBhZGRyKTsKPiAKPiAt
ICAgSU9BU0lEIGZhdWx0IGhhbmRsZXIgaWRlbnRpZmllcyB0aGUgY29ycmVzcG9uZGluZyBpb2Fz
aWQgYW5kIGRldmljZSAKPiAgICAgY29va2llIGFjY29yZGluZyB0byB0aGUgb3BhcXVlIG9iamVj
dCwgZ2VuZXJhdGVzIGFuIHVzZXIgZmF1bHRfZGF0YSAKPiAgICAgKGlvYXNpZCwgY29va2llLCBh
ZGRyKSBpbiB0aGUgZmF1bHQgcmVnaW9uLCBhbmQgdHJpZ2dlcnMgZXZlbnRmZCB0byAKPiAgICAg
dXNlcnNwYWNlOwo+IAoKSGksIEkgaGF2ZSBzb21lIGRvdWJ0cyBoZXJlOgoKRm9yIG1kZXYsIGl0
IHNlZW1zIHRoYXQgdGhlIHJpZCBpbiB0aGUgcmF3IGZhdWx0X2RhdGEgaXMgdGhlIHBhcmVudCBk
ZXZpY2UncywKdGhlbiBpbiB0aGUgdlNWQSBzY2VuYXJpbywgaG93IGNhbiB3ZSBnZXQgdG8ga25v
dyB0aGUgbWRldihjb29raWUpIGZyb20gdGhlCnJpZCBhbmQgcGFzaWQ/CgpBbmQgZnJvbSB0aGlz
IHBvaW50IG9mIHZpZXfvvIx3b3VsZCBpdCBiZSBiZXR0ZXIgdG8gcmVnaXN0ZXIgdGhlIG1kZXYK
KGlvbW11X3JlZ2lzdGVyX2RldmljZSgpKSB3aXRoIHRoZSBwYXJlbnQgZGV2aWNlIGluZm8/CgpU
aGFua3MsClNoZW5taW5nCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
