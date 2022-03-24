Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F451C433F5
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 12:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3EE7E40184;
	Thu, 24 Mar 2022 12:35:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0mtDEtOvBOOb; Thu, 24 Mar 2022 12:35:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A0FE740125;
	Thu, 24 Mar 2022 12:35:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77224C001A;
	Thu, 24 Mar 2022 12:35:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0D81C000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 12:35:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E78941C69
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 12:35:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2jUtQL6rxUNU for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 12:35:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4803841C66
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 12:35:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57BF11FB;
 Thu, 24 Mar 2022 05:35:16 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B9F03F73D;
 Thu, 24 Mar 2022 05:35:12 -0700 (PDT)
Message-ID: <b56621da-0f8a-06d5-15a1-7034e4274620@arm.com>
Date: Thu, 24 Mar 2022 12:35:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] PCI: hv: Propagate coherence from VMbus device to
 PCI device
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
To: Michael Kelley <mikelley@microsoft.com>, sthemmin@microsoft.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, rafael@kernel.org, lenb@kernel.org,
 lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
 bhelgaas@google.com, hch@lst.de, m.szyprowski@samsung.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <1648067472-13000-1-git-send-email-mikelley@microsoft.com>
 <1648067472-13000-3-git-send-email-mikelley@microsoft.com>
 <e6d9af22-df69-bf6a-7877-b916918d0682@arm.com>
In-Reply-To: <e6d9af22-df69-bf6a-7877-b916918d0682@arm.com>
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

T24gMjAyMi0wMy0yNCAxMjoyMywgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjItMDMtMjMg
MjA6MzEsIE1pY2hhZWwgS2VsbGV5IHdyb3RlOgo+PiBQQ0kgcGFzcy10aHJ1IGRldmljZXMgaW4g
YSBIeXBlci1WIFZNIGFyZSByZXByZXNlbnRlZCBhcyBhIFZNQnVzCj4+IGRldmljZSBhbmQgYXMg
YSBQQ0kgZGV2aWNlLsKgIFRoZSBjb2hlcmVuY2Ugb2YgdGhlIFZNYnVzIGRldmljZSBpcwo+PiBz
ZXQgYmFzZWQgb24gdGhlIFZNYnVzIG5vZGUgaW4gQUNQSSwgYnV0IHRoZSBQQ0kgZGV2aWNlIGhh
cyBubwo+PiBBQ1BJIG5vZGUgYW5kIGRlZmF1bHRzIHRvIG5vdCBoYXJkd2FyZSBjb2hlcmVudC7C
oCBUaGlzIHJlc3VsdHMKPj4gaW4gZXh0cmEgc29mdHdhcmUgY29oZXJlbmNlIG1hbmFnZW1lbnQg
b3ZlcmhlYWQgb24gQVJNNjQgd2hlbgo+PiBkZXZpY2VzIGFyZSBoYXJkd2FyZSBjb2hlcmVudC4K
Pj4KPj4gRml4IHRoaXMgYnkgc2V0dGluZyB1cCB0aGUgUENJIGhvc3QgYnVzIHNvIHRoYXQgbm9y
bWFsCj4+IFBDSSBtZWNoYW5pc21zIHdpbGwgcHJvcGFnYXRlIHRoZSBjb2hlcmVuY2Ugb2YgdGhl
IFZNYnVzCj4+IGRldmljZSB0byB0aGUgUENJIGRldmljZS4gVGhlcmUncyBubyBlZmZlY3Qgb24g
eDg2L3g2NCB3aGVyZQo+PiBkZXZpY2VzIGFyZSBhbHdheXMgaGFyZHdhcmUgY29oZXJlbnQuCj4g
Cj4gSG9uZXN0bHksIEkgZG9uJ3QgaGF0ZSB0aGlzIDopCj4gCj4gSXQgc2VlbXMgY29uY2VwdHVh
bGx5IGFjY3VyYXRlLCBhcyBmYXIgYXMgSSB1bmRlcnN0YW5kLCBhbmQgaW4gCj4gZnVuY3Rpb25h
bCB0ZXJtcyBJJ20gc3RhcnRpbmcgdG8gdGhpbmsgaXQgbWlnaHQgZXZlbiBiZSB0aGUgbW9zdCBj
b3JyZWN0IAo+IGFwcHJvYWNoIGFueXdheS4gSW4gdGhlIHBoeXNpY2FsIHdvcmxkIHdlIG1pZ2h0
IGJlIHN1cnByaXNlZCB0byBmaW5kIHRoZSAKPiBQQ0kgc2lkZSBvZiBhIGhvc3QgYnJpZGdlCgpB
bmQgb2YgY291cnNlIGJ5ICJ0aGUgUENJIHNpZGUgb2YgYSBob3N0IGJyaWRnZSIgSSB0aGluayBJ
IGFjdHVhbGx5IG1lYW4gCiJhIFBDSSByb290IGJ1cyIsIGJlY2F1c2UgaW4gbXkgc2xvcHB5IHRl
cm1pbm9sb2d5IEknbSB0aGlua2luZyBhYm91dCAKaGFyZHdhcmUgYnJpZGdpbmcgZnJvbSBQQ0ko
ZSkgdG8gc29tZSBTb0MtaW50ZXJuYWwgcHJvdG9jb2wsIHdoaWNoIGRvZXMgCm5vdCBoYXZlIHRv
IGltcGx5IGFuIGFjdHVhbCBQQ0ktdmlzaWJsZSBIb3N0IEJyaWRnZSBkZXZpY2UuLi4KClJvYmlu
LgoKPiBiZWhpbmQgYW55dGhpbmcgb3RoZXIgdGhhbiBzb21lIHBsYXRmb3JtL0FDUEkgCj4gZGV2
aWNlIHJlcHJlc2VudGluZyB0aGUgb3RoZXIgc2lkZSBvZiBhIHBoeXNpY2FsIGhvc3QgYnJpZGdl
IG9yIHJvb3QgCj4gY29tcGxleCwgYnV0IHdobydzIHRvIHNheSB0aGF0IGEgcGFyYXZpcnR1YWwg
d29ybGQgY2FuJ3QgcHJlc2VudCBhIG1vcmUgCj4gYWJzdHJhY3QgdG9wb2xvZ3k/IEVpdGhlciB3
YXksIGEgb25lLWxpbmUgd2F5IG9mIHR5aW5nIGluIHRvIHRoZSAKPiBzdGFuZGFyZCBmbG93IGlz
IGhhcmQgdG8gdHVybiBkb3duLgo+IAo+IEFja2VkLWJ5OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11
cnBoeUBhcm0uY29tPgo+IAo+PiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEtlbGxleSA8bWlrZWxs
ZXlAbWljcm9zb2Z0LmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNp
LWh5cGVydi5jIHwgOSArKysrKysrKysKPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2
LmMgCj4+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMKPj4gaW5kZXggYWUw
YmMyZi4uODhiM2I1NiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2kt
aHlwZXJ2LmMKPj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMKPj4g
QEAgLTM0MDQsNiArMzQwNCwxNSBAQCBzdGF0aWMgaW50IGh2X3BjaV9wcm9iZShzdHJ1Y3QgaHZf
ZGV2aWNlICpoZGV2LAo+PiDCoMKgwqDCoMKgIGhidXMtPmJyaWRnZS0+ZG9tYWluX25yID0gZG9t
Owo+PiDCoCAjaWZkZWYgQ09ORklHX1g4Ngo+PiDCoMKgwqDCoMKgIGhidXMtPnN5c2RhdGEuZG9t
YWluID0gZG9tOwo+PiArI2VsaWYgZGVmaW5lZChDT05GSUdfQVJNNjQpCj4+ICvCoMKgwqAgLyoK
Pj4gK8KgwqDCoMKgICogU2V0IHRoZSBQQ0kgYnVzIHBhcmVudCB0byBiZSB0aGUgY29ycmVzcG9u
ZGluZyBWTWJ1cwo+PiArwqDCoMKgwqAgKiBkZXZpY2UuIFRoZW4gdGhlIFZNYnVzIGRldmljZSB3
aWxsIGJlIGFzc2lnbmVkIGFzIHRoZQo+PiArwqDCoMKgwqAgKiBBQ1BJIGNvbXBhbmlvbiBpbiBw
Y2liaW9zX3Jvb3RfYnJpZGdlX3ByZXBhcmUoKSBhbmQKPj4gK8KgwqDCoMKgICogcGNpX2RtYV9j
b25maWd1cmUoKSB3aWxsIHByb3BhZ2F0ZSBkZXZpY2UgY29oZXJlbmNlCj4+ICvCoMKgwqDCoCAq
IGluZm9ybWF0aW9uIHRvIGRldmljZXMgY3JlYXRlZCBvbiB0aGUgYnVzLgo+PiArwqDCoMKgwqAg
Ki8KPj4gK8KgwqDCoCBoYnVzLT5zeXNkYXRhLnBhcmVudCA9IGhkZXYtPmRldmljZS5wYXJlbnQ7
Cj4+IMKgICNlbmRpZgo+PiDCoMKgwqDCoMKgIGhidXMtPmhkZXYgPSBoZGV2Owo+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gaW9tbXUgbWFpbGluZyBs
aXN0Cj4gaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPiBodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
