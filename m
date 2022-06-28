Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E07C433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 11:27:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7672D82EA4;
	Tue, 28 Jun 2022 11:27:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7672D82EA4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IiVl2oGS--lx; Tue, 28 Jun 2022 11:27:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 532E182FA9;
	Tue, 28 Jun 2022 11:27:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 532E182FA9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FCF1C0032;
	Tue, 28 Jun 2022 11:27:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4613C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 11:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AFA0182FA9
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 11:27:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AFA0182FA9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GCWJEb8Btpkf for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 11:27:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B6F2582EA4
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B6F2582EA4
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 11:27:41 +0000 (UTC)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LXMhd247Pz6H6w8;
 Tue, 28 Jun 2022 19:25:21 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 13:27:38 +0200
Received: from [10.126.174.22] (10.126.174.22) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 12:27:37 +0100
Message-ID: <a2e717d0-c3e2-ea98-9d8b-cee1fd37c117@huawei.com>
Date: Tue, 28 Jun 2022 12:27:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v4 1/5] dma-mapping: Add dma_opt_mapping_size()
To: Robin Murphy <robin.murphy@arm.com>, <damien.lemoal@opensource.wdc.com>,
 <joro@8bytes.org>, <will@kernel.org>, <jejb@linux.ibm.com>,
 <martin.petersen@oracle.com>, <hch@lst.de>, <m.szyprowski@samsung.com>
References: <1656343521-62897-1-git-send-email-john.garry@huawei.com>
 <1656343521-62897-2-git-send-email-john.garry@huawei.com>
 <bbca5df5-8681-d6d9-201d-3d48b34e3001@arm.com>
In-Reply-To: <bbca5df5-8681-d6d9-201d-3d48b34e3001@arm.com>
X-Originating-IP: [10.126.174.22]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org, linuxarm@huawei.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 iommu@lists.linux-foundation.org
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gMjgvMDYvMjAyMiAxMjoyMywgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiArCj4+ICvCoMKgwqAg
c2l6ZV90Cj4+ICvCoMKgwqAgZG1hX29wdF9tYXBwaW5nX3NpemUoc3RydWN0IGRldmljZSAqZGV2
KTsKPj4gKwo+PiArUmV0dXJucyB0aGUgbWF4aW11bSBvcHRpbWFsIHNpemUgb2YgYSBtYXBwaW5n
IGZvciB0aGUgZGV2aWNlLiBNYXBwaW5nIAo+PiBsYXJnZQo+PiArYnVmZmVycyBtYXkgdGFrZSBs
b25nZXIgc28gZGV2aWNlIGRyaXZlcnMgYXJlIGFkdmlzZWQgdG8gbGltaXQgdG90YWwgRE1BCj4+
ICtzdHJlYW1pbmcgbWFwcGluZ3MgbGVuZ3RoIHRvIHRoZSByZXR1cm5lZCB2YWx1ZS4KPiAKPiBO
aXQ6IEknbSBub3Qgc3VyZSAiYWR2aXNlZCIgaXMgbmVjZXNzYXJpbHkgdGhlIHJpZ2h0IHRoaW5n
IHRvIHNheSBpbiAKPiBnZW5lcmFsIC0gdGhhdCdzIG9ubHkgcmVhbGx5IHRydWUgZm9yIGEgY2Fs
bGVyIHdobyBjYXJlcyBhYm91dCAKPiB0aHJvdWdocHV0IG9mIGNodXJuaW5nIHRocm91Z2ggc2hv
cnQtbGl2ZWQgbWFwcGluZ3MgbW9yZSB0aGFuIGFueXRoaW5nIAo+IGVsc2UsIGFuZCBkb2Vzbid0
IHRha2UgYSBzaWduaWZpY2FudCBoaXQgb3ZlcmFsbCBmcm9tIHNwbGl0dGluZyB1cCAKPiBsYXJn
ZXIgcmVxdWVzdHMuIEkgZG8gdGhpbmsgaXQncyBnb29kIHRvIGNsYXJpZnkgdGhlIGV4YWN0IGNv
bnRleHQgb2YgCj4gIm9wdGltYWwiIGhlcmUsIGJ1dCBJJ2QgcHJlZmVyIHRvIGJlIG9iamVjdGl2
ZWx5IGNsZWFyIHRoYXQgaXQncyBmb3IgCj4gd29ya2xvYWRzIHdoZXJlIHRoZSB1cC1mcm9udCBt
YXBwaW5nIG92ZXJoZWFkIGRvbWluYXRlcy4KCk9rLCBzdXJlLCBJIGNhbiBtYWtlIHRoYXQgY2xl
YXIuCgpUaGFua3MsCkpvaG4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
