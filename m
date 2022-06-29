Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1655BC43334
	for <iommu@archiver.kernel.org>; Wed, 29 Jun 2022 22:42:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8412B41B69;
	Wed, 29 Jun 2022 22:42:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8412B41B69
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=cX1QqveB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IxyIyxcqjfQO; Wed, 29 Jun 2022 22:41:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6B13341B60;
	Wed, 29 Jun 2022 22:41:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6B13341B60
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4ACE7C002D;
	Wed, 29 Jun 2022 22:41:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6072FC0011
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 22:41:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2C82260E98
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 22:41:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2C82260E98
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com
 header.a=rsa-sha256 header.s=20200525 header.b=cX1QqveB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rLU1AvEO1hCT for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 22:41:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A49560ACD
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A49560ACD
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jun 2022 22:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=yVJkquctrxAoNz8gXWxalQPFR+kficMZVVuKxSIBo/w=; b=cX1QqveBfo+xPu7dGHmrnO0J7K
 qJxZ/4a3qviR2YsYxAl441tnDslX7UZLKVNl7dECkLbDJBrODx24Z1FZZ2YR0gfK4Qx5bFxKsdnV+
 ayp9miFGsznMYxLuJT8qz8m4U8lbLvb0m6Ihhj5N+dY9xmE7ZIBt8+8ePCpdzZ/dd2H7pg8bVqEIL
 vOvuRL9kWAgEKZ7udv7uSElDfsGN0ygRfue2iteXV1Evx26BlZvoCj9t2OzZA3JRHuGstDkn2hrBY
 PycWefQB0v5JZG34eFp4p3I7HwaoFTdQBv3Qpo6sU7xpIDA51IeoXpZk0+KoB2vKszKIczOjopgNy
 fM05bfoA==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230]
 helo=[192.168.11.155]) by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <logang@deltatee.com>)
 id 1o6gNZ-002ZYA-Ie; Wed, 29 Jun 2022 16:41:50 -0600
Message-ID: <626de61d-e85e-bc9f-9e3d-836a408c859f@deltatee.com>
Date: Wed, 29 Jun 2022 16:41:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-9-logang@deltatee.com>
 <feecc6fe-a16e-11f2-33c8-3de7c96b9ad5@arm.com>
 <f56181fb-7035-a775-22b1-77f97d6ec52c@deltatee.com>
 <7f0673e1-433b-65fb-1d2b-c3e4adeebf87@arm.com>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <7f0673e1-433b-65fb-1d2b-c3e4adeebf87@arm.com>
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, dave.b.minturn@intel.com,
 martin.oliveira@eideticom.com, rcampbell@nvidia.com, jgg@nvidia.com,
 jhubbard@nvidia.com, dave.hansen@linux.intel.com, willy@infradead.org,
 christian.koenig@amd.com, jgg@ziepe.ca, ckulkarnilinux@gmail.com,
 jason@jlekstrand.net, daniel.vetter@ffwll.ch, helgaas@kernel.org,
 dan.j.williams@intel.com, sbates@raithlin.com, ira.weiny@intel.com, hch@lst.de,
 jianxin.xiong@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v7 08/21] iommu/dma: support PCI P2PDMA pages in dma-iommu
 map_sg
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Jason Ekstrand <jason@jlekstrand.net>,
 Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>, Stephen Bates <sbates@raithlin.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

CgpPbiAyMDIyLTA2LTI5IDEzOjE1LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMi0wNi0y
OSAxNjo1NywgTG9nYW4gR3VudGhvcnBlIHdyb3RlOgo+Pgo+Pgo+Pgo+PiBPbiAyMDIyLTA2LTI5
IDA2OjA3LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+PiBPbiAyMDIyLTA2LTE1IDE3OjEyLCBMb2dh
biBHdW50aG9ycGUgd3JvdGU6Cj4+Pj4gV2hlbiBhIFBDSSBQMlBETUEgcGFnZSBpcyBzZWVuLCBz
ZXQgdGhlIElPVkEgbGVuZ3RoIG9mIHRoZSBzZWdtZW50Cj4+Pj4gdG8gemVybyBzbyB0aGF0IGl0
IGlzIG5vdCBtYXBwZWQgaW50byB0aGUgSU9WQS4gVGhlbiwgaW4gZmluYWxpc2Vfc2coKSwKPj4+
PiBhcHBseSB0aGUgYXBwcm9wcmlhdGUgYnVzIGFkZHJlc3MgdG8gdGhlIHNlZ21lbnQuIFRoZSBJ
T1ZBIGlzIG5vdAo+Pj4+IGNyZWF0ZWQgaWYgdGhlIHNjYXR0ZXJsaXN0IG9ubHkgY29uc2lzdHMg
b2YgUDJQRE1BIHBhZ2VzLgo+Pj4+Cj4+Pj4gQSBQMlBETUEgcGFnZSBtYXkgaGF2ZSB0aHJlZSBw
b3NzaWJsZSBvdXRjb21lcyB3aGVuIGJlaW5nIG1hcHBlZDoKPj4+PiDCoMKgwqAgMSkgSWYgdGhl
IGRhdGEgcGF0aCBiZXR3ZWVuIHRoZSB0d28gZGV2aWNlcyBkb2Vzbid0IGdvIHRocm91Z2gKPj4+
PiDCoMKgwqDCoMKgwqAgdGhlIHJvb3QgcG9ydCwgdGhlbiBpdCBzaG91bGQgYmUgbWFwcGVkIHdp
dGggYSBQQ0kgYnVzIGFkZHJlc3MKPj4+PiDCoMKgwqAgMikgSWYgdGhlIGRhdGEgcGF0aCBnb2Vz
IHRocm91Z2ggdGhlIGhvc3QgYnJpZGdlLCBpdCBzaG91bGQgYmUKPj4+PiBtYXBwZWQKPj4+PiDC
oMKgwqDCoMKgwqAgbm9ybWFsbHkgd2l0aCBhbiBJT01NVSBJT1ZBLgo+Pj4+IMKgwqDCoCAzKSBJ
dCBpcyBub3QgcG9zc2libGUgZm9yIHRoZSB0d28gZGV2aWNlcyB0byBjb21tdW5pY2F0ZSBhbmQg
dGh1cwo+Pj4+IMKgwqDCoMKgwqDCoCB0aGUgbWFwcGluZyBvcGVyYXRpb24gc2hvdWxkIGZhaWwg
KGFuZCBpdCB3aWxsIHJldHVybgo+Pj4+IC1FUkVNT1RFSU8pLgo+Pj4+Cj4+Pj4gU2ltaWxhciB0
byBkbWEtZGlyZWN0LCB0aGUgc2dfZG1hX21hcmtfcGNpX3AycGRtYSgpIGZsYWcgaXMgdXNlZCB0
bwo+Pj4+IGluZGljYXRlIGJ1cyBhZGRyZXNzIHNlZ21lbnRzLiBPbiB1bm1hcCwgUDJQRE1BIHNl
Z21lbnRzIGFyZSBza2lwcGVkCj4+Pj4gb3ZlciB3aGVuIGRldGVybWluaW5nIHRoZSBzdGFydCBh
bmQgZW5kIElPVkEgYWRkcmVzc2VzLgo+Pj4+Cj4+Pj4gV2l0aCB0aGlzIGNoYW5nZSwgdGhlIGZs
YWdzIHZhcmlhYmxlIGluIHRoZSBkbWFfbWFwX29wcyBpcyBzZXQgdG8KPj4+PiBETUFfRl9QQ0lf
UDJQRE1BX1NVUFBPUlRFRCB0byBpbmRpY2F0ZSBzdXBwb3J0IGZvciBQMlBETUEgcGFnZXMuCj4+
Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBMb2dhbiBHdW50aG9ycGUgPGxvZ2FuZ0BkZWx0YXRlZS5j
b20+Cj4+Pj4gUmV2aWV3ZWQtYnk6IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+Cj4+
Pj4gLS0tCj4+Pj4gwqDCoCBkcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jIHwgNjgKPj4+PiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0KPj4+PiDCoMKgIDEgZmlsZSBjaGFu
Z2VkLCA2MSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvaW9tbXUvZG1hLWlvbW11LmMgYi9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5j
Cj4+Pj4gaW5kZXggZjkwMjUxNTcyYTVkLi5iMDFjYTBjNmE3YWIgMTAwNjQ0Cj4+Pj4gLS0tIGEv
ZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvZG1hLWlv
bW11LmMKPj4+PiBAQCAtMjEsNiArMjEsNyBAQAo+Pj4+IMKgwqAgI2luY2x1ZGUgPGxpbnV4L2lv
dmEuaD4KPj4+PiDCoMKgICNpbmNsdWRlIDxsaW51eC9pcnEuaD4KPj4+PiDCoMKgICNpbmNsdWRl
IDxsaW51eC9saXN0X3NvcnQuaD4KPj4+PiArI2luY2x1ZGUgPGxpbnV4L21lbXJlbWFwLmg+Cj4+
Pj4gwqDCoCAjaW5jbHVkZSA8bGludXgvbW0uaD4KPj4+PiDCoMKgICNpbmNsdWRlIDxsaW51eC9t
dXRleC5oPgo+Pj4+IMKgwqAgI2luY2x1ZGUgPGxpbnV4L3BjaS5oPgo+Pj4+IEBAIC0xMDYyLDYg
KzEwNjMsMTYgQEAgc3RhdGljIGludCBfX2ZpbmFsaXNlX3NnKHN0cnVjdCBkZXZpY2UgKmRldiwK
Pj4+PiBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnLCBpbnQgbmVudHMsCj4+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc2dfZG1hX2FkZHJlc3MocykgPSBETUFfTUFQUElOR19FUlJPUjsKPj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzZ19kbWFfbGVuKHMpID0gMDsKPj4+PiDCoMKgICvCoMKgwqDCoMKg
wqDCoCBpZiAoaXNfcGNpX3AycGRtYV9wYWdlKHNnX3BhZ2UocykpICYmICFzX2lvdmFfbGVuKSB7
Cj4+Pgo+Pj4gTG9naWNhbGx5LCBzaG91bGQgd2Ugbm90IGJlIGFibGUgdG8gdXNlIHNnX2lzX2Rt
YV9idXNfYWRkcmVzcygpIGhlcmU/IEkKPj4+IHRoaW5rIGl0IHNob3VsZCBiZSBmZWFzaWJsZSwg
YW5kIHNpbXBsZXIsIHRvIHByZXBhcmUgdGhlIHAycCBzZWdtZW50cwo+Pj4gdXAtZnJvbnQsIHN1
Y2ggdGhhdCBhdCB0aGlzIHBvaW50IGFsbCB3ZSBuZWVkIHRvIGRvIGlzIHJlc3RvcmUgdGhlCj4+
PiBvcmlnaW5hbCBsZW5ndGggKGlmIGV2ZW4gdGhhdCwgc2VlIGJlbG93KS4KPj4KPj4gUGVyIG15
IHByZXZpb3VzIGVtYWlsLCBubywgYmVjYXVzZSBzZ19pc19kbWFfYnVzX2FkZHJlc3MoKSBpcyBu
b3Qgc2V0Cj4+IHlldCBhbmQgbm90IG1lYW50IHRvIHRlbGwgeW91IHNvbWV0aGluZyBhYm91dCB0
aGUgcGFnZS4gVGhhdCBmbGFnIHdpbGwKPj4gYmUgc2V0IGJlbG93IGJ5IHBjaV9wMnBkbWFfbWFw
X2J1c19zZWdtZW50KCkgYW5kIHRoZW4gY2hlY2tkIGluCj4+IGlvbW11X2RtYV91bm1hcF9zZygp
IHRvIGRldGVybWluZSBpZiB0aGUgZG1hX2FkZHJlc3MgaW4gdGhlIHNlZ21lbnQKPj4gbmVlZHMg
dG8gYmUgdW5tYXBwZWQuCj4gCj4gSSBrbm93IGl0J3Mgbm90IHNldCB5ZXQgYXMtaXM7IEknbSBz
dWdnZXN0aW5nIHRoaW5ncyBzaG91bGQgYmUKPiByZXN0cnVjdHVyZWQgc28gdGhhdCBpdCAqd291
bGQgYmUqLiBJbiB0aGUgbG9naWNhbCBkZXNpZ24gb2YgdGhpcyBjb2RlLAo+IHRoZSBETUEgYWRk
cmVzc2VzIGFyZSBlZmZlY3RpdmVseSBkZXRlcm1pbmVkIGluIGlvbW11X2RtYV9tYXBfc2coKSwg
YW5kCj4gX19maW5hbGlzZV9zZygpIG1lcmVseSBjb252ZXJ0cyB0aGVtIGZyb20gYSByZWxhdGl2
ZSB0byBhbiBhYnNvbHV0ZSBmb3JtCj4gKGFsb25nIHdpdGggdW5kb2luZyB0aGUgb3RoZXIgdHJp
Y2tlcnkpLiBUaHVzIHRoZSBjYWxsIHRvCj4gcGNpX3AycGRtYV9tYXBfYnVzX3NlZ21lbnQoKSBh
YnNvbHV0ZWx5IGJlbG9uZ3MgaW4gdGhlIG1haW4KPiBpb21tdV9tYXBfc2coKSBsb29wLgoKSSBk
b24ndCBzZWUgaG93IHRoYXQgY2FuIHdvcms6IF9fZmluYWxpc2Vfc2coKSBkb2VzIG1vcmUgdGhh
biBjb252ZXJ0CnRoZW0gZnJvbSByZWxhdGl2ZSB0byBhYnNvbHV0ZSwgaXQgYWxzbyBmaWd1cmVz
IG91dCB3aGljaCBTRyBlbnRyeSB3aWxsCmNvbnRhaW4gd2hpY2ggZG1hX2FkZHJlc3Mgc2VnbWVu
dC4gV2hpY2ggc2VnbWVudCBhIFAyUERNQSBhZGRyZXNzIG5lZWRzCnRvIGJlIHByb2dyYW1tZWQg
aW50byBkZXBlbmRzIG9uIHRoZSBob3cgJ2N1cicgaXMgY2FsY3VsYXRlZCB3aGljaCBpbgp0dXJu
IGRlcGVuZHMgb24gdGhpbmdzIGxpa2Ugc2VnX21hc2sgYW5kIG1heF9sZW4uIFRoaXMgY2FsY3Vs
YXRpb24gaXMKbm90IGRvbmUgaW4gaW9tbXVfZG1hX21hcF9zZygpIHNvIEkgZG9uJ3Qgc2VlIGhv
dyB0aGVyZSdzIGFueSBob3BlIG9mCmFzc2lnbmluZyB0aGUgYnVzIGFkZHJlc3MgZm9yIHRoZSBQ
MlAgc2VnbWVudHMgaW4gdGhhdCBmdW5jdGlvbi4KCklmIHRoZXJlJ3MgYSB3YXkgdG8gcmVzdHJ1
Y3R1cmUgdGhpbmdzIHNvIHRoYXQncyBwb3NzaWJsZSB0aGF0IEknbSBub3QKc2VlaW5nLCBJJ20g
b3BlbiB0byBpdCBidXQgaXQncyBjZXJ0YWlubHkgbm90IGltbWVkaWF0ZWx5IG9idmlvdXMuCgo+
Pj4+ICsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzd2l0Y2ggKG1hcF90eXBlKSB7Cj4+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBQQ0lfUDJQRE1BX01BUF9CVVNfQUREUjoK
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qCj4+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICogQSB6ZXJvIGxlbmd0aCB3aWxsIGJlIGlnbm9yZWQgYnkK
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBpb21tdV9tYXBfc2coKSBh
bmQgdGhlbiBjYW4gYmUgZGV0ZWN0ZWQKPj4+Cj4+PiBJZiB0aGF0IGlzIHJlcXVpcmVkIGJlaGF2
aW91ciB0aGVuIGl0IG5lZWRzIGFuIGV4cGxpY2l0IGNoZWNrIGluCj4+PiBpb21tdV9tYXBfc2co
KSB0byBndWFyYW50ZWUgKGFuZCBkb2N1bWVudCkgaXQuIEl0J3Mgb25seSBieSBjaGFuY2UgdGhh
dAo+Pj4gX19pb21tdV9tYXAoKSBoYXBwZW5zIHRvIHJldHVybiBzdWNjZXNzIGZvciBzaXplID09
IDAgKmlmKiBhbGwgdGhlIG90aGVyCj4+PiBhcmd1bWVudHMgc3RpbGwgbGluZSB1cCwgd2hpY2gg
aXMgYSBmYXIgY3J5IGZyb20gYSBzYWZlIG5vLW9wLgo+Pgo+PiBXaGF0IHNob3VsZCBzdWNoIGEg
Y2hlY2sgbG9vayBsaWtlPyBJIGNvdWxkIGNlcnRhaW5seSBhZGQgc29tZSBjb21tZW50cwo+PiB0
byBpb21tdV9tYXBfc2coKSwgYnV0IEkgZG9uJ3Qgc2VlIHdoYXQgdGhlIGNvZGUgd291bGQgbmVl
ZCB0byBjaGVjawo+PiBmb3IuLi4KPiAKPiBJJ2Qgc2F5IGEgY2hlY2sgZm9yIHplcm8tbGVuZ3Ro
IHNlZ21lbnRzIHdvdWxkIGxvb2sgbGlrZSAiaWYgKHNnLT5sZW5ndGgKPiA9PSAwKSIsIG1vc3Qg
bGlrZWx5IHdpdGggYSAiY29udGludWU7IiBvbiB0aGUgZm9sbG93aW5nIGxpbmUuCgpPaCwgdGhh
dCdzIHByZXR0eSBzaW1wbGUgdG8gYWRkLiBXaWxsIGNoYW5nZS4KCj4+PiBIb3dldmVyLCByYXRo
ZXIgdGhhbiBwbGF5IHlldCBtb3JlIHNpbGx5IHRyaWNrcywgSSB0aGluayBpdCB3b3VsZCBtYWtl
Cj4+PiBldmVuIG1vcmUgc2Vuc2UgdG8gbWFrZSBpb21tdV9tYXBfc2coKSBwcm9wZXJseSBhd2Fy
ZSBhbmQgYWJsZSB0byBza2lwCj4+PiBkaXJlY3QgcDJwIHNlZ21lbnRzIG9uIGl0cyBvd24uIE9u
Y2UgaXQgYmVjb21lcyBub3JtYWwgdG8gcGFzcyBtaXhlZAo+Pj4gc2NhdHRlcmxpc3RzIGFyb3Vu
ZCwgaXQncyBvbmx5IGEgbWF0dGVyIG9mIHRpbWUgdW50aWwgb25lIGVuZHMgdXAgYmVpbmcKPj4+
IGhhbmRlZCB0byBhIGRyaXZlciB3aGljaCBtYW5hZ2VzIGl0cyBvd24gSU9NTVUgZG9tYWluLCBh
bmQgdGhlbiB3aGF0Pwo+Pgo+PiBJIHN1cHBvc2Ugd2UgY2FuIGFkZCBhbm90aGVyIGNhbGwgdG8g
aXNfcGNpX3AycGRtYV9wYWdlKCkgaW5zaWRlCj4+IGlvbW11X21hcF9zZygpIGlmIHlvdSB0aGlu
ayB0aGF0IGlzIGNsZWFuZXIuIFNlZW1zIGxpa2UgbW9yZSB3b3JrIG9uIHRoZQo+PiBmYXN0IHBh
dGggdG8gbWUsIGJ1dCBJJ20gbm90IG9wcG9zZWQgdG8gaXQuCj4gCj4gSSB3YXMgdGhpbmtpbmcg
bW9yZSBvZiBzZ19pc19kbWFfYnVzX2FkZHJlc3MoKSBidXQgYWRtaXR0ZWRseSB1bmRlciBteQo+
IGluaXRpYWwgbWlzYXBwcmVoZW5zaW9uIG9mIHRoYXQuIEkgc3VwcG9zZSB0aGVyZSdzIHN0aWxs
IGEgdGVudW91cwo+IGFyZ3VtZW50IHRoYXQgZXZlbiB0aG91Z2ggd2UncmUgbm90IGFjdHVhbGx5
IGNvbnN1bWluZyBzZ19kbWFfYWRkcmVzcygpCj4gYXQgdGhhdCBwb2ludCwgaWYgYSBzZWdtZW50
ICpoYXMqIGJlZW4gZWFybWFya2VkIGZvciBkaXJlY3QgcDJwLCB0aGVuCj4gc2tpcHBpbmcgaXQg
cmF0aGVyIHRoYW4gbWFwcGluZyBpdCBhdCB0aGUgcm9vdCBjb21wbGV4IFRBIHRoYXQncwo+IHBy
b2JhYmx5IG5ldmVyIGdvaW5nIHRvIHNlZSB0aG9zZSB0cmFuc2FjdGlvbnMgbWlnaHQgc2VlbSB0
aGUgbW9yZQo+IGxvZ2ljYWwgY2hvaWNlLgo+IAo+IEhvd2V2ZXIgaXQncyBhbGwgYSBiaXQgaHlw
b3RoZXRpY2FsLCBhbmQgbm90IHNpZ25pZmljYW50bHkgY2xlYW5lciB0aGFuCj4gYSB6ZXJvLXNp
emUgc3BlY2lhbCBjYXNlLCBzbyBJJ20gbm90IHBhcnRpY3VsYXJseSB0aWVkIHRvIHRoZSBpZGVh
IGVpdGhlci4KClllYWgsIGxvb2tpbmcgYXQgaXQgY2xvc2VyLCBJIGNhbid0IHNlZSBob3cgdG8g
Z2V0IHJpZCBvZiB0aGUgemVybyBzaXplCnNwZWNpYWwgY2FzZSB3aXRob3V0IGRvaW5nIHRoZSB3
aG9sZSBwY2lfcDJwZG1hX21hcF90eXBlKCkgY2FsY3VsYXRpb24KdHdpY2Ugd2hpY2ggd2UgcmVh
bGx5IHdhbnQgdG8gYXZvaWQuCgpMb2dhbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
