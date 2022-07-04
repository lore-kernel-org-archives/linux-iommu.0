Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684BCC43334
	for <iommu@archiver.kernel.org>; Mon,  4 Jul 2022 13:39:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F18878274E;
	Mon,  4 Jul 2022 13:39:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F18878274E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qgZX_rJrSl3h; Mon,  4 Jul 2022 13:39:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C255382768;
	Mon,  4 Jul 2022 13:39:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C255382768
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9446FC002D;
	Mon,  4 Jul 2022 13:39:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75D08C002D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 13:38:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C6DD8274E
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 13:38:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C6DD8274E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HuN7nm0vaHGu for <iommu@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 13:38:56 +0000 (UTC)
X-Greylist: delayed 00:17:01 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C12C8827FA
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C12C8827FA
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jul 2022 13:38:55 +0000 (UTC)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.55])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Lc5xz61v9zkWpk;
 Mon,  4 Jul 2022 21:19:51 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Jul 2022 21:21:50 +0800
Subject: Re: [PATCH v3 4/4] vfio: Require that devices support DMA cache
 coherence
To: Jason Gunthorpe <jgg@nvidia.com>, Cornelia Huck <cohuck@redhat.com>, David
 Woodhouse <dwmw2@infradead.org>, <iommu@lists.linux-foundation.org>, Joerg
 Roedel <joro@8bytes.org>, <kvm@vger.kernel.org>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>
References: <4-v3-2cf356649677+a32-intel_no_snoop_jgg@nvidia.com>
Message-ID: <40454b70-11e1-f9a1-6c26-27e7340f2109@hisilicon.com>
Date: Mon, 4 Jul 2022 21:21:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <4-v3-2cf356649677+a32-intel_no_snoop_jgg@nvidia.com>
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
From: "chenxiang \(M\) via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "chenxiang \(M\)" <chenxiang66@hisilicon.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGksCgpXZSBlbmNvdW50ZXIgYSBpc3N1ZSB3aXRoIHRoZSBwYXRjaDogb3VyIHBsYXRmb3JtIGlz
IEFSTTY0LCBhbmQgd2UgcnVuIApEUERLIHdpdGggc21tdSBkaXNhYmxlIG9uIFZNICh3aXRob3V0
IGlvbW11PXNtbXV2MyBldGMpLAoKc28gd2UgdXNlIG5vaW9tbXUgbW9kZSB3aXRoIGVuYWJsZV91
bnNhZmVfbm9pb21tdV9tb2RlPTEgdG8gcGFzc3Rocm91Z2ggCnRoZSBkZXZpY2UgdG8gVk0gd2l0
aCBmb2xsb3dpbmcgc3RlcHMgKHRob3NlIHN0ZXBzIGFyZSBvbiBWTSkgOgoKaW5zbW9kIHZmaW8u
a28gZW5hYmxlX3Vuc2FmZV9ub2lvbW11X21vZGU9MQppbnNtb2QgdmZpb192aXJxZmQua28KaW5z
bW9kIHZmaW8tcGNpLWNvcmUua28KaW5zbWRvIHZmaW8tcGNpLmtvCmluc21vZCB2ZmlvX2lvbW11
X3R5cGUxLmtvCgplY2hvIHZmaW8tcGNpID4gL3N5cy9idXMvcGNpL2RldmljZXMvMDAwMDowMDow
Mi4wL2RyaXZlcl9vdmVycmlkZQplY2hvIDAwMDA6MDA6MDIuMCA+IC9zeXMvYnVzL3BjaS9kcml2
ZXJzX3Byb2JlIC0tLS0tLS0tLS0tLS0tLS0tLSBmYWlsZWQKCkkgZmluZCB0aGF0IHZmaW8tcGNp
IGRldmljZSBpcyBub3QgcHJvYmVkIGJlY2F1c2Ugb2YgdGhlIGFkZGl0aW9uYWwgCmNoZWNrLiBJ
dCB3b3JrcyB3ZWxsIHdpdGhvdXQgdGhpcyBwYXRjaC4KCkRvIHdlIG5lZWQgdG8gc2tpcCB0aGUg
Y2hlY2sgaWYgZW5hYmxlX3Vuc2FmZV9ub2lvbW11X21vZGU9MT8KCkJlc3QgcmVnYXJkcywKClhp
YW5nIENoZW4KCgrlnKggMjAyMi80LzExIDIzOjE2LCBKYXNvbiBHdW50aG9ycGUg5YaZ6YGTOgo+
IElPTU1VX0NBQ0hFIG1lYW5zIHRoYXQgbm9ybWFsIERNQXMgZG8gbm90IHJlcXVpcmUgYW55IGFk
ZGl0aW9uYWwgY29oZXJlbmN5Cj4gbWVjaGFuaXNtIGFuZCBpcyB0aGUgYmFzaWMgdUFQSSB0aGF0
IFZGSU8gZXhwb3NlcyB0byB1c2Vyc3BhY2UuIEZvcgo+IGluc3RhbmNlIFZGSU8gYXBwbGljYXRp
b25zIGxpa2UgRFBESyB3aWxsIG5vdCB3b3JrIGlmIGFkZGl0aW9uYWwgY29oZXJlbmN5Cj4gb3Bl
cmF0aW9ucyBhcmUgcmVxdWlyZWQuCj4KPiBUaGVyZWZvcmUgY2hlY2sgSU9NTVVfQ0FQX0NBQ0hF
X0NPSEVSRU5DWSBsaWtlIHZkcGEgJiB1c25pYyBkbyBiZWZvcmUKPiBhbGxvd2luZyBhbiBJT01N
VSBiYWNrZWQgVkZJTyBkZXZpY2UgdG8gYmUgY3JlYXRlZC4KPgo+IFJldmlld2VkLWJ5OiBLZXZp
biBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4KPiBBY2tlZC1ieTogQWxleCBXaWxsaWFtc29u
IDxhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbT4KPiBBY2tlZC1ieTogUm9iaW4gTXVycGh5IDxy
b2Jpbi5tdXJwaHlAYXJtLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBHdW50aG9ycGUgPGpn
Z0BudmlkaWEuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92ZmlvL3ZmaW8uYyB8IDcgKysrKysrKwo+
ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmZpby92ZmlvLmMgYi9kcml2ZXJzL3ZmaW8vdmZpby5jCj4gaW5kZXggYTQ1NTUwMTRiZDFl
NzIuLjllZGFkNzY3Y2ZkYWQzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmZpby92ZmlvLmMKPiAr
KysgYi9kcml2ZXJzL3ZmaW8vdmZpby5jCj4gQEAgLTgxNSw2ICs4MTUsMTMgQEAgc3RhdGljIGlu
dCBfX3ZmaW9fcmVnaXN0ZXJfZGV2KHN0cnVjdCB2ZmlvX2RldmljZSAqZGV2aWNlLAo+ICAgCj4g
ICBpbnQgdmZpb19yZWdpc3Rlcl9ncm91cF9kZXYoc3RydWN0IHZmaW9fZGV2aWNlICpkZXZpY2Up
Cj4gICB7Cj4gKwkvKgo+ICsJICogVkZJTyBhbHdheXMgc2V0cyBJT01NVV9DQUNIRSBiZWNhdXNl
IHdlIG9mZmVyIG5vIHdheSBmb3IgdXNlcnNwYWNlIHRvCj4gKwkgKiByZXN0b3JlIGNhY2hlIGNv
aGVyZW5jeS4KPiArCSAqLwo+ICsJaWYgKCFpb21tdV9jYXBhYmxlKGRldmljZS0+ZGV2LT5idXMs
IElPTU1VX0NBUF9DQUNIRV9DT0hFUkVOQ1kpKQo+ICsJCXJldHVybiAtRUlOVkFMOwo+ICsKPiAg
IAlyZXR1cm4gX192ZmlvX3JlZ2lzdGVyX2RldihkZXZpY2UsCj4gICAJCXZmaW9fZ3JvdXBfZmlu
ZF9vcl9hbGxvYyhkZXZpY2UtPmRldikpOwo+ICAgfQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
