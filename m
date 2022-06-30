Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EA2C433EF
	for <iommu@archiver.kernel.org>; Thu, 30 Jun 2022 21:22:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 153AC60F84;
	Thu, 30 Jun 2022 21:22:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 153AC60F84
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=VJXKRmwb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AXmz9PhH7CJa; Thu, 30 Jun 2022 21:22:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A52D360B6C;
	Thu, 30 Jun 2022 21:22:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A52D360B6C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 706F8C002D;
	Thu, 30 Jun 2022 21:22:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 128BAC0011
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 21:22:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9DF0423A2
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 21:22:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D9DF0423A2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com
 header.a=rsa-sha256 header.s=20200525 header.b=VJXKRmwb
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c16bukMEL3uJ for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 21:22:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89C80423A1
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89C80423A1
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jun 2022 21:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=lcE0RG7zHjzAvuVO13dlZQZgYUdkoKNtHGwpbVB8WSY=; b=VJXKRmwbrfTeru4GStEgHnOFcn
 0clAFOb+uSboDe5lSH6bYXIDyM3A7FV1m1Gv40/1WK+WmKuyU4GcovIZln8u/dOZNroWCwnZTCILD
 UngbBjeNR9R/2lSaYm9F4nCbknUpbtSWveSI8iaLewadz2cRFT6Ts07ys3AhLJ5hULu5Qjjr9GbyR
 sj5HECu0OR4z2h2JvEHhTUp5YwFApvTKp5tE7hTFr3k6HO4YBl53QWu7GFrHxx2lVEGROAalhImzW
 soOQzHUJ3ws78RKLCrt/8AG1InmS7nqUSlYNP+aV7cYdnXQFj+ilO5CQMJjbF5y0acg1lAZ0SkjVv
 HipxMV4Q==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10]) by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <logang@deltatee.com>)
 id 1o71bm-003Olq-2k; Thu, 30 Jun 2022 15:21:55 -0600
Message-ID: <fd9da4cd-b395-fe06-c056-7ffc9f1f55cf@deltatee.com>
Date: Thu, 30 Jun 2022 15:21:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-CA
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-9-logang@deltatee.com>
 <feecc6fe-a16e-11f2-33c8-3de7c96b9ad5@arm.com>
 <f56181fb-7035-a775-22b1-77f97d6ec52c@deltatee.com>
 <7f0673e1-433b-65fb-1d2b-c3e4adeebf87@arm.com>
 <626de61d-e85e-bc9f-9e3d-836a408c859f@deltatee.com>
 <f9c1e41b-d2a8-61fe-0888-4f0f988912a7@arm.com>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <f9c1e41b-d2a8-61fe-0888-4f0f988912a7@arm.com>
X-SA-Exim-Connect-IP: 24.64.144.200
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

CgpPbiAyMDIyLTA2LTMwIDA4OjU2LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMi0wNi0y
OSAyMzo0MSwgTG9nYW4gR3VudGhvcnBlIHdyb3RlOgo+Pgo+Pgo+PiBPbiAyMDIyLTA2LTI5IDEz
OjE1LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+PiBPbiAyMDIyLTA2LTI5IDE2OjU3LCBMb2dhbiBH
dW50aG9ycGUgd3JvdGU6Cj4+Pj4KPj4+Pgo+Pj4+Cj4+Pj4gT24gMjAyMi0wNi0yOSAwNjowNywg
Um9iaW4gTXVycGh5IHdyb3RlOgo+Pj4+PiBPbiAyMDIyLTA2LTE1IDE3OjEyLCBMb2dhbiBHdW50
aG9ycGUgd3JvdGU6Cj4+Pj4+PiBXaGVuIGEgUENJIFAyUERNQSBwYWdlIGlzIHNlZW4sIHNldCB0
aGUgSU9WQSBsZW5ndGggb2YgdGhlIHNlZ21lbnQKPj4+Pj4+IHRvIHplcm8gc28gdGhhdCBpdCBp
cyBub3QgbWFwcGVkIGludG8gdGhlIElPVkEuIFRoZW4sIGluCj4+Pj4+PiBmaW5hbGlzZV9zZygp
LAo+Pj4+Pj4gYXBwbHkgdGhlIGFwcHJvcHJpYXRlIGJ1cyBhZGRyZXNzIHRvIHRoZSBzZWdtZW50
LiBUaGUgSU9WQSBpcyBub3QKPj4+Pj4+IGNyZWF0ZWQgaWYgdGhlIHNjYXR0ZXJsaXN0IG9ubHkg
Y29uc2lzdHMgb2YgUDJQRE1BIHBhZ2VzLgo+Pj4+Pj4KPj4+Pj4+IEEgUDJQRE1BIHBhZ2UgbWF5
IGhhdmUgdGhyZWUgcG9zc2libGUgb3V0Y29tZXMgd2hlbiBiZWluZyBtYXBwZWQ6Cj4+Pj4+PiDC
oMKgwqDCoCAxKSBJZiB0aGUgZGF0YSBwYXRoIGJldHdlZW4gdGhlIHR3byBkZXZpY2VzIGRvZXNu
J3QgZ28gdGhyb3VnaAo+Pj4+Pj4gwqDCoMKgwqDCoMKgwqAgdGhlIHJvb3QgcG9ydCwgdGhlbiBp
dCBzaG91bGQgYmUgbWFwcGVkIHdpdGggYSBQQ0kgYnVzCj4+Pj4+PiBhZGRyZXNzCj4+Pj4+PiDC
oMKgwqDCoCAyKSBJZiB0aGUgZGF0YSBwYXRoIGdvZXMgdGhyb3VnaCB0aGUgaG9zdCBicmlkZ2Us
IGl0IHNob3VsZCBiZQo+Pj4+Pj4gbWFwcGVkCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoCBub3JtYWxs
eSB3aXRoIGFuIElPTU1VIElPVkEuCj4+Pj4+PiDCoMKgwqDCoCAzKSBJdCBpcyBub3QgcG9zc2li
bGUgZm9yIHRoZSB0d28gZGV2aWNlcyB0byBjb21tdW5pY2F0ZSBhbmQKPj4+Pj4+IHRodXMKPj4+
Pj4+IMKgwqDCoMKgwqDCoMKgIHRoZSBtYXBwaW5nIG9wZXJhdGlvbiBzaG91bGQgZmFpbCAoYW5k
IGl0IHdpbGwgcmV0dXJuCj4+Pj4+PiAtRVJFTU9URUlPKS4KPj4+Pj4+Cj4+Pj4+PiBTaW1pbGFy
IHRvIGRtYS1kaXJlY3QsIHRoZSBzZ19kbWFfbWFya19wY2lfcDJwZG1hKCkgZmxhZyBpcyB1c2Vk
IHRvCj4+Pj4+PiBpbmRpY2F0ZSBidXMgYWRkcmVzcyBzZWdtZW50cy4gT24gdW5tYXAsIFAyUERN
QSBzZWdtZW50cyBhcmUgc2tpcHBlZAo+Pj4+Pj4gb3ZlciB3aGVuIGRldGVybWluaW5nIHRoZSBz
dGFydCBhbmQgZW5kIElPVkEgYWRkcmVzc2VzLgo+Pj4+Pj4KPj4+Pj4+IFdpdGggdGhpcyBjaGFu
Z2UsIHRoZSBmbGFncyB2YXJpYWJsZSBpbiB0aGUgZG1hX21hcF9vcHMgaXMgc2V0IHRvCj4+Pj4+
PiBETUFfRl9QQ0lfUDJQRE1BX1NVUFBPUlRFRCB0byBpbmRpY2F0ZSBzdXBwb3J0IGZvciBQMlBE
TUEgcGFnZXMuCj4+Pj4+Pgo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogTG9nYW4gR3VudGhvcnBlIDxs
b2dhbmdAZGVsdGF0ZWUuY29tPgo+Pj4+Pj4gUmV2aWV3ZWQtYnk6IEphc29uIEd1bnRob3JwZSA8
amdnQG52aWRpYS5jb20+Cj4+Pj4+PiAtLS0KPj4+Pj4+IMKgwqDCoCBkcml2ZXJzL2lvbW11L2Rt
YS1pb21tdS5jIHwgNjgKPj4+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLQo+Pj4+Pj4gwqDCoMKgIDEgZmlsZSBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspLCA3IGRl
bGV0aW9ucygtKQo+Pj4+Pj4KPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2RtYS1p
b21tdS5jIGIvZHJpdmVycy9pb21tdS9kbWEtaW9tbXUuYwo+Pj4+Pj4gaW5kZXggZjkwMjUxNTcy
YTVkLi5iMDFjYTBjNmE3YWIgMTAwNjQ0Cj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2RtYS1p
b21tdS5jCj4+Pj4+PiArKysgYi9kcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jCj4+Pj4+PiBAQCAt
MjEsNiArMjEsNyBAQAo+Pj4+Pj4gwqDCoMKgICNpbmNsdWRlIDxsaW51eC9pb3ZhLmg+Cj4+Pj4+
PiDCoMKgwqAgI2luY2x1ZGUgPGxpbnV4L2lycS5oPgo+Pj4+Pj4gwqDCoMKgICNpbmNsdWRlIDxs
aW51eC9saXN0X3NvcnQuaD4KPj4+Pj4+ICsjaW5jbHVkZSA8bGludXgvbWVtcmVtYXAuaD4KPj4+
Pj4+IMKgwqDCoCAjaW5jbHVkZSA8bGludXgvbW0uaD4KPj4+Pj4+IMKgwqDCoCAjaW5jbHVkZSA8
bGludXgvbXV0ZXguaD4KPj4+Pj4+IMKgwqDCoCAjaW5jbHVkZSA8bGludXgvcGNpLmg+Cj4+Pj4+
PiBAQCAtMTA2Miw2ICsxMDYzLDE2IEBAIHN0YXRpYyBpbnQgX19maW5hbGlzZV9zZyhzdHJ1Y3Qg
ZGV2aWNlICpkZXYsCj4+Pj4+PiBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnLCBpbnQgbmVudHMsCj4+
Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNnX2RtYV9hZGRyZXNzKHMpID0gRE1BX01BUFBJ
TkdfRVJST1I7Cj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNnX2RtYV9sZW4ocykgPSAw
Owo+Pj4+Pj4gwqDCoMKgICvCoMKgwqDCoMKgwqDCoCBpZiAoaXNfcGNpX3AycGRtYV9wYWdlKHNn
X3BhZ2UocykpICYmICFzX2lvdmFfbGVuKSB7Cj4+Pj4+Cj4+Pj4+IExvZ2ljYWxseSwgc2hvdWxk
IHdlIG5vdCBiZSBhYmxlIHRvIHVzZSBzZ19pc19kbWFfYnVzX2FkZHJlc3MoKQo+Pj4+PiBoZXJl
PyBJCj4+Pj4+IHRoaW5rIGl0IHNob3VsZCBiZSBmZWFzaWJsZSwgYW5kIHNpbXBsZXIsIHRvIHBy
ZXBhcmUgdGhlIHAycCBzZWdtZW50cwo+Pj4+PiB1cC1mcm9udCwgc3VjaCB0aGF0IGF0IHRoaXMg
cG9pbnQgYWxsIHdlIG5lZWQgdG8gZG8gaXMgcmVzdG9yZSB0aGUKPj4+Pj4gb3JpZ2luYWwgbGVu
Z3RoIChpZiBldmVuIHRoYXQsIHNlZSBiZWxvdykuCj4+Pj4KPj4+PiBQZXIgbXkgcHJldmlvdXMg
ZW1haWwsIG5vLCBiZWNhdXNlIHNnX2lzX2RtYV9idXNfYWRkcmVzcygpIGlzIG5vdCBzZXQKPj4+
PiB5ZXQgYW5kIG5vdCBtZWFudCB0byB0ZWxsIHlvdSBzb21ldGhpbmcgYWJvdXQgdGhlIHBhZ2Uu
IFRoYXQgZmxhZyB3aWxsCj4+Pj4gYmUgc2V0IGJlbG93IGJ5IHBjaV9wMnBkbWFfbWFwX2J1c19z
ZWdtZW50KCkgYW5kIHRoZW4gY2hlY2tkIGluCj4+Pj4gaW9tbXVfZG1hX3VubWFwX3NnKCkgdG8g
ZGV0ZXJtaW5lIGlmIHRoZSBkbWFfYWRkcmVzcyBpbiB0aGUgc2VnbWVudAo+Pj4+IG5lZWRzIHRv
IGJlIHVubWFwcGVkLgo+Pj4KPj4+IEkga25vdyBpdCdzIG5vdCBzZXQgeWV0IGFzLWlzOyBJJ20g
c3VnZ2VzdGluZyB0aGluZ3Mgc2hvdWxkIGJlCj4+PiByZXN0cnVjdHVyZWQgc28gdGhhdCBpdCAq
d291bGQgYmUqLiBJbiB0aGUgbG9naWNhbCBkZXNpZ24gb2YgdGhpcyBjb2RlLAo+Pj4gdGhlIERN
QSBhZGRyZXNzZXMgYXJlIGVmZmVjdGl2ZWx5IGRldGVybWluZWQgaW4gaW9tbXVfZG1hX21hcF9z
ZygpLCBhbmQKPj4+IF9fZmluYWxpc2Vfc2coKSBtZXJlbHkgY29udmVydHMgdGhlbSBmcm9tIGEg
cmVsYXRpdmUgdG8gYW4gYWJzb2x1dGUgZm9ybQo+Pj4gKGFsb25nIHdpdGggdW5kb2luZyB0aGUg
b3RoZXIgdHJpY2tlcnkpLiBUaHVzIHRoZSBjYWxsIHRvCj4+PiBwY2lfcDJwZG1hX21hcF9idXNf
c2VnbWVudCgpIGFic29sdXRlbHkgYmVsb25ncyBpbiB0aGUgbWFpbgo+Pj4gaW9tbXVfbWFwX3Nn
KCkgbG9vcC4KPj4KPj4gSSBkb24ndCBzZWUgaG93IHRoYXQgY2FuIHdvcms6IF9fZmluYWxpc2Vf
c2coKSBkb2VzIG1vcmUgdGhhbiBjb252ZXJ0Cj4+IHRoZW0gZnJvbSByZWxhdGl2ZSB0byBhYnNv
bHV0ZSwgaXQgYWxzbyBmaWd1cmVzIG91dCB3aGljaCBTRyBlbnRyeSB3aWxsCj4+IGNvbnRhaW4g
d2hpY2ggZG1hX2FkZHJlc3Mgc2VnbWVudC4gV2hpY2ggc2VnbWVudCBhIFAyUERNQSBhZGRyZXNz
IG5lZWRzCj4+IHRvIGJlIHByb2dyYW1tZWQgaW50byBkZXBlbmRzIG9uIHRoZSBob3cgJ2N1cicg
aXMgY2FsY3VsYXRlZCB3aGljaCBpbgo+PiB0dXJuIGRlcGVuZHMgb24gdGhpbmdzIGxpa2Ugc2Vn
X21hc2sgYW5kIG1heF9sZW4uIFRoaXMgY2FsY3VsYXRpb24gaXMKPj4gbm90IGRvbmUgaW4gaW9t
bXVfZG1hX21hcF9zZygpIHNvIEkgZG9uJ3Qgc2VlIGhvdyB0aGVyZSdzIGFueSBob3BlIG9mCj4+
IGFzc2lnbmluZyB0aGUgYnVzIGFkZHJlc3MgZm9yIHRoZSBQMlAgc2VnbWVudHMgaW4gdGhhdCBm
dW5jdGlvbi4KPj4KPj4gSWYgdGhlcmUncyBhIHdheSB0byByZXN0cnVjdHVyZSB0aGluZ3Mgc28g
dGhhdCdzIHBvc3NpYmxlIHRoYXQgSSdtIG5vdAo+PiBzZWVpbmcsIEknbSBvcGVuIHRvIGl0IGJ1
dCBpdCdzIGNlcnRhaW5seSBub3QgaW1tZWRpYXRlbHkgb2J2aW91cy4KPiAKPiBIdWg/IEl0J3Mg
c3RpbGwgdmlydHVhbGx5IHRoZSBzYW1lIHRoaW5nOyBpb21tdV9kbWFfbWFwX3NnKCkgY2FsbHMK
PiBwY2lfcDJwZG1hX21hcF9idXNfc2VnbWVudChzKSBhbmQgc2V0cyBzLT5sZW5ndGggdG8gMCBp
Zgo+IFBDSV9QMlBETUFfTUFQX0JVU19BRERSLCB0aGVuIF9fZmluYWxpc2Vfc2coKSBjYW4gdXNl
Cj4gc2dfaXNfZG1hX2J1c19hZGRyZXNzKHMpIGluIHBsYWNlIG9mIGlzX3BjaV9wMnBkbWFfcGFn
ZShzZ19wYWdlKHMpKSwgYW5kCj4ganVzdCBwcm9wYWdhdGUgdGhlIERNQSBhZGRyZXNzIGFuZCBv
cmlnaW5hbCBsZW5ndGggZnJvbSBzIHRvIGN1ci4KPiAKPiBIZXJlIHlvdSd2ZSB3cml0dGVuIGEg
cGF0Y2ggd2hpY2ggbG9va3MgdG8gY29ycmVjdGx5IGludGVycnVwdCBhbnkKPiBvbmdvaW5nIGNv
bmNhdGVuYXRpb24gc3RhdGUgYW5kIGNvbnZleSBzb21lIGRhdGEgZnJvbSB0aGUgZ2l2ZW4gaW5w
dXQKPiBzZWdtZW50IHRvIHRoZSBhcHByb3ByaWF0ZSBvdXRwdXQgc2VnbWVudCwgc28gSSdtIGJh
ZmZsZWQgYnkgd2h5IHlvdSdkCj4gdGhpbmsgeW91IGNvdWxkbid0IGRvIHdoYXQgeW91J3ZlIGFs
cmVhZHkgZG9uZS4KCkFoLCBJIHVuZGVyc3RhbmQgbm93LCB0aGFua3MgZm9yIHRoZSBwYXRpZW5j
ZS4gSXQgdG9vayBtZSBhIGNvdXBsZSBvZgpyZWFkIHRocm91Z2hzIGJlZm9yZSBJIGdvdCBpdCwg
YnV0IEkgZmlndXJlZCBpdCBvdXQgYW5kIG5vdyBoYXZlIGEKd29ya2luZyBpbXBsZW1lbnRhdGlv
biB0aGF0IGxvb2tzIHJlYWxseSBuaWNlLiBJdCdzIGEgYmlnIGltcHJvdmVtZW50Cm5vdCBuZWVk
aW5nIHRoZSB0d28gZGlmZmVyZW50IFAyUERNQSBoZWxwZXJzLgoKSSdsbCBzZW5kIGEgdjggb2Yg
anVzdCB0aGUgZmlyc3QgMTMgcGF0Y2hlcyBuZXh0IHdlZWsgYWZ0ZXIgYSBiaXQgbW9yZQp0ZXN0
aW5nLiBJJ3ZlIHB1dCBhIGRyYWZ0IGdpdCBicmFuY2ggaGVyZSBpZiB5b3Ugd2FudCB0byBsb29r
IGF0IGl0CmJlZm9yZSB0aGF0OgoKaHR0cHM6Ly9naXRodWIuY29tL3NiYXRlczEzMDI3Mi9saW51
eC1wMnBtZW0gIHAycGRtYV9tYXBfdjgKClRoYW5rcyEKCkxvZ2FuCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
