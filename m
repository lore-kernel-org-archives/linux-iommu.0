Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DA6C433F5
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 12:23:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D10A6416AF;
	Fri,  4 Mar 2022 12:23:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mjZTjjOzDkd2; Fri,  4 Mar 2022 12:23:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9D0FA416B5;
	Fri,  4 Mar 2022 12:23:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AC65C0012;
	Fri,  4 Mar 2022 12:23:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29150C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 12:23:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 023C060FCF
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 12:23:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NVnexiT1cHUh for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 12:23:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0BEFB60FC9
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 12:23:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EC58143D;
 Fri,  4 Mar 2022 04:23:08 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DA963F70D;
 Fri,  4 Mar 2022 04:23:03 -0800 (PST)
Message-ID: <1648bc97-a0d3-4051-58d0-e24fa9e9d183@arm.com>
Date: Fri, 4 Mar 2022 12:22:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v7 01/11] iommu: Add DMA ownership management interfaces
Content-Language: en-GB
To: Lu Baolu <baolu.lu@linux.intel.com>, eric.auger@redhat.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson
 <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
References: <20220228005056.599595-1-baolu.lu@linux.intel.com>
 <20220228005056.599595-2-baolu.lu@linux.intel.com>
 <c75b6e04-bc1b-b9f6-1a44-bf1567a8c19d@redhat.com>
 <7a3dc977-0c5f-6d88-6d3a-8e49bc717690@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <7a3dc977-0c5f-6d88-6d3a-8e49bc717690@linux.intel.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, kvm@vger.kernel.org,
 Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Diana Craciun <diana.craciun@oss.nxp.com>,
 Dan Williams <dan.j.williams@intel.com>, Li Yang <leoyang.li@nxp.com>,
 Will Deacon <will@kernel.org>, Dmitry Osipenko <digetx@gmail.com>
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

T24gMjAyMi0wMy0wNCAxMDo0MywgTHUgQmFvbHUgd3JvdGU6Cj4gSGkgRXJpYywKPiAKPiBPbiAy
MDIyLzMvNCAxODozNCwgRXJpYyBBdWdlciB3cm90ZToKPj4gSSBoaXQgYSBXQVJOX09OKCkgd2hl
biB1bmJpbmRpbmcgYW4gZTEwMDBlIGRyaXZlciBqdXN0IGFmdGVyIGJvb3Q6Cj4+Cj4+IHN1ZG8g
bW9kcHJvYmUgLXYgdmZpby1wY2kKPj4gZWNobyB2ZmlvLXBjaSB8IHN1ZG8gdGVlIC1hCj4+IC9z
eXMvYnVzL3BjaS9kZXZpY2VzLzAwMDQ6MDE6MDAuMC9kcml2ZXJfb3ZlcnJpZGUKPj4gdmZpby1w
Y2kKPj4gZWNobyAwMDA0OjAxOjAwLjAgfCBzdWRvIHRlZSAtYcKgIC9zeXMvYnVzL3BjaS9kcml2
ZXJzL2UxMDAwZS91bmJpbmQKPj4KPj4KPj4gW8KgIDM5MC4wNDI4MTFdIC0tLS0tLS0tLS0tLVsg
Y3V0IGhlcmUgXS0tLS0tLS0tLS0tLQo+PiBbwqAgMzkwLjA0NjQ2OF0gV0FSTklORzogQ1BVOiA0
MiBQSUQ6IDU1ODkgYXQgZHJpdmVycy9pb21tdS9pb21tdS5jOjMxMjMKPj4gaW9tbXVfZGV2aWNl
X3VudXNlX2RlZmF1bHRfZG9tYWluKzB4NjgvMHgxMDAKPj4gW8KgIDM5MC4wNTY3MTBdIE1vZHVs
ZXMgbGlua2VkIGluOiB2ZmlvX3BjaSB2ZmlvX3BjaV9jb3JlIHZmaW9fdmlycWZkCj4+IHZmaW9f
aW9tbXVfdHlwZTEgdmZpbyB4dF9DSEVDS1NVTSB4dF9NQVNRVUVSQURFIHh0X2Nvbm50cmFjayBp
cHRfUkVKRUNUCj4+IG5mX3JlamVjdF9pcHY0IG5mdF9jb21wYXQgbmZ0X2NoYWluX25hdCBuZl9u
YXQgbmZfY29ubnRyYWNrCj4+IG5mX2RlZnJhZ19pcHY2IG5mX2RlZnJhZ19pcHY0IG5mX3RhYmxl
cyBuZm5ldGxpbmsgYnJpZGdlIHN0cCBsbGMgcmZraWxsCj4+IHN1bnJwYyB2ZmF0IGZhdCBtbHg1
X2liIGliX3V2ZXJicyBpYl9jb3JlIGFjcGlfaXBtaSBpcG1pX3NzaWYKPj4gaXBtaV9kZXZpbnRm
IGlwbWlfbXNnaGFuZGxlciBjcHBjX2NwdWZyZXEgZHJtIHhmcyBsaWJjcmMzMmMgbWx4NV9jb3Jl
IHNnCj4+IG1seGZ3IGNyY3QxMGRpZl9jZSB0bHMgZ2hhc2hfY2Ugc2hhMl9jZSBzaGEyNTZfYXJt
NjQgc2hhMV9jZSBzYnNhX2d3ZHQKPj4gZTEwMDBlIHBzYW1wbGUgc2RoY2lfYWNwaSBhaGNpX3Bs
YXRmb3JtIHNkaGNpIGxpYmFoY2lfcGxhdGZvcm0gcWNvbV9lbWFjCj4+IG1tY19jb3JlIGhkbWEg
aGRtYV9tZ210IGRtX21pcnJvciBkbV9yZWdpb25faGFzaCBkbV9sb2cgZG1fbW9kIGZ1c2UKPj4g
W8KgIDM5MC4xMTA2MThdIENQVTogNDIgUElEOiA1NTg5IENvbW06IHRlZSBLZHVtcDogbG9hZGVk
IE5vdCB0YWludGVkCj4+IDUuMTcuMC1yYzQtbHUtdjctb2ZmaWNpYWwrICMyNAo+PiBbwqAgMzkw
LjExOTM4NF0gSGFyZHdhcmUgbmFtZTogV0lXWU5OIFFERjI0MDAgUmVmZXJlbmNlIEV2YWx1YXRp
b24KPj4gUGxhdGZvcm0gQ1Y5MC1MQTExNS1QMTIwL1FERjI0MDAgQ3VzdG9tZXIgUmVmZXJlbmNl
IEJvYXJkLCBCSU9TIDBBQ0pBNTcwCj4+IDExLzA1LzIwMTgKPj4gW8KgIDM5MC4xMzI0OTJdIHBz
dGF0ZTogYTA0MDAwMDUgKE56Q3YgZGFpZiArUEFOIC1VQU8gLVRDTyAtRElUIC1TU0JTCj4+IEJU
WVBFPS0tKQo+PiBbwqAgMzkwLjEzOTQzNl0gcGMgOiBpb21tdV9kZXZpY2VfdW51c2VfZGVmYXVs
dF9kb21haW4rMHg2OC8weDEwMAo+PiBbwqAgMzkwLjE0NTE2NV0gbHIgOiBpb21tdV9kZXZpY2Vf
dW51c2VfZGVmYXVsdF9kb21haW4rMHgzOC8weDEwMAo+PiBbwqAgMzkwLjE1MDg5NF0gc3AgOiBm
ZmZmODAwMDBmYmIzYmMwCj4+IFvCoCAzOTAuMTU0MTkzXSB4Mjk6IGZmZmY4MDAwMGZiYjNiYzAg
eDI4OiBmZmZmMDNjMGNmNmIyNDAwIHgyNzoKPj4gMDAwMDAwMDAwMDAwMDAwMAo+PiBbwqAgMzkw
LjE2MTMxMV0geDI2OiAwMDAwMDAwMDAwMDAwMDAwIHgyNTogMDAwMDAwMDAwMDAwMDAwMCB4MjQ6
Cj4+IGZmZmYwM2MwYzdjYzU3MjAKPj4gW8KgIDM5MC4xNjg0MjldIHgyMzogZmZmZjAzYzBjMmI5
ZDE1MCB4MjI6IGZmZmZiNGU2MWRmMjIzZjggeDIxOgo+PiBmZmZmYjRlNjFkZjIyM2Y4Cj4+IFvC
oCAzOTAuMTc1NTQ3XSB4MjA6IGZmZmYwM2M3YzAzYzM3NTggeDE5OiBmZmZmMDNjN2MwM2MzNzAw
IHgxODoKPj4gMDAwMDAwMDAwMDAwMDAwMAo+PiBbwqAgMzkwLjE4MjY2NV0geDE3OiAwMDAwMDAw
MDAwMDAwMDAwIHgxNjogMDAwMDAwMDAwMDAwMDAwMCB4MTU6Cj4+IDAwMDAwMDAwMDAwMDAwMDAK
Pj4gW8KgIDM5MC4xODk3ODNdIHgxNDogMDAwMDAwMDAwMDAwMDAwMCB4MTM6IDAwMDAwMDAwMDAw
MDAwMzAgeDEyOgo+PiBmZmZmMDNjMGQ1MTljZDgwCj4+IFvCoCAzOTAuMTk2OTAxXSB4MTE6IDdm
N2Y3ZjdmN2Y3ZjdmN2YgeDEwOiAwMDAwMDAwMDAwMDAwZGMwIHg5IDoKPj4gZmZmZmI0ZTYyMGI1
NGY4Ywo+PiBbwqAgMzkwLjIwNDAxOV0geDggOiBmZmZmMDNjMGNmNmIzMjIwIHg3IDogZmZmZjRl
ZjEzMmJiYTAwMCB4NiA6Cj4+IDAwMDAwMDAwMDAwMDAwZmYKPj4gW8KgIDM5MC4yMTExMzddIHg1
IDogZmZmZjAzYzBjMmI5ZjEwOCB4NCA6IGZmZmYwM2MwZDUxZjY0MzggeDMgOgo+PiAwMDAwMDAw
MDAwMDAwMDAwCj4+IFvCoCAzOTAuMjE4MjU1XSB4MiA6IGZmZmYwM2MwY2Y2YjI0MDAgeDEgOiAw
MDAwMDAwMDAwMDAwMDAwIHgwIDoKPj4gMDAwMDAwMDAwMDAwMDAwMAo+PiBbwqAgMzkwLjIyNTM3
NF0gQ2FsbCB0cmFjZToKPj4gW8KgIDM5MC4yMjc4MDRdwqAgaW9tbXVfZGV2aWNlX3VudXNlX2Rl
ZmF1bHRfZG9tYWluKzB4NjgvMHgxMDAKPj4gW8KgIDM5MC4yMzMxODddwqAgcGNpX2RtYV9jbGVh
bnVwKzB4MzgvMHg0NAo+PiBbwqAgMzkwLjIzNjkxOV3CoCBfX2RldmljZV9yZWxlYXNlX2RyaXZl
cisweDFhOC8weDI2MAo+PiBbwqAgMzkwLjI0MTUxOV3CoCBkZXZpY2VfZHJpdmVyX2RldGFjaCsw
eDUwLzB4ZDAKPj4gW8KgIDM5MC4yNDU2ODZdwqAgdW5iaW5kX3N0b3JlKzB4ZjgvMHgxMjAKPj4g
W8KgIDM5MC4yNDkyNDVdwqAgZHJ2X2F0dHJfc3RvcmUrMHgzMC8weDQ0Cj4+IFvCoCAzOTAuMjUy
ODkxXcKgIHN5c2ZzX2tmX3dyaXRlKzB4NTAvMHg2MAo+PiBbwqAgMzkwLjI1NjUzN13CoCBrZXJu
ZnNfZm9wX3dyaXRlX2l0ZXIrMHgxMzQvMHgxY2MKPj4gW8KgIDM5MC4yNjA5NjRdwqAgbmV3X3N5
bmNfd3JpdGUrMHhmMC8weDE4Ywo+PiBbwqAgMzkwLjI2NDY5Nl3CoCB2ZnNfd3JpdGUrMHgyMzAv
MHgyZDAKPj4gW8KgIDM5MC4yNjgwODJdwqAga3N5c193cml0ZSsweDc0LzB4MTAwCj4+IFvCoCAz
OTAuMjcxNDY3XcKgIF9fYXJtNjRfc3lzX3dyaXRlKzB4MjgvMHgzYwo+PiBbwqAgMzkwLjI3NTM3
M13CoCBpbnZva2Vfc3lzY2FsbC5jb25zdHByb3AuMCsweDU4LzB4ZjAKPj4gW8KgIDM5MC4yODAw
NjFdwqAgZWwwX3N2Y19jb21tb24uY29uc3Rwcm9wLjArMHgxNjAvMHgxNjQKPj4gW8KgIDM5MC4y
ODQ5MjJdwqAgZG9fZWwwX3N2YysweDM0LzB4Y2MKPj4gW8KgIDM5MC4yODgyMjFdwqAgZWwwX3N2
YysweDMwLzB4MTQwCj4+IFvCoCAzOTAuMjkxMzQ2XcKgIGVsMHRfNjRfc3luY19oYW5kbGVyKzB4
YTQvMHgxMzAKPj4gW8KgIDM5MC4yOTU1OTldwqAgZWwwdF82NF9zeW5jKzB4MWEwLzB4MWE0Cj4+
IFvCoCAzOTAuMjk5MjQ1XSAtLS1bIGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0KPj4K
Pj4KPj4gSSBwdXQgc29tZSB0cmFjZXMgaW4gdGhlIGNvZGUgYW5kIEkgY2FuIHNlZSB0aGF0IAo+
PiBpb21tdV9kZXZpY2VfdXNlX2RlZmF1bHRfZG9tYWluKCkgZWZmZWN0aXZlbHkgaXMgY2FsbGVk
IG9uIAo+PiAwMDA0OjAxOjAwLjAgZTEwMDBlIGRldmljZSBvbiBwY2lfZG1hX2NvbmZpZ3VyZSgp
IGJ1dCBhdCB0aGF0IHRpbWUgdGhlIAo+PiBpb21tdSBncm91cCBpcyBOVUxMOgo+PiBbwqDCoCAx
MC41Njk0MjddIGUxMDAwZSAwMDA0OjAxOjAwLjA6IC0tLS0tLSBFTlRSWSBwY2lfZG1hX2NvbmZp
Z3VyZSAKPj4gZHJpdmVyX21hbmFnZWRfYXJlYT0wCj4+IFvCoMKgIDEwLjU2OTQzMV0gZTEwMDBl
IDAwMDQ6MDE6MDAuMDogKioqKiAKPj4gaW9tbXVfZGV2aWNlX3VzZV9kZWZhdWx0X2RvbWFpbiBF
TlRSWQo+PiBbwqDCoCAxMC41Njk0MzNdIGUxMDAwZSAwMDA0OjAxOjAwLjA6ICoqKiogCj4+IGlv
bW11X2RldmljZV91c2VfZGVmYXVsdF9kb21haW4gbm8gZ3JvdXAKPj4gW8KgwqAgMTAuNTY5NDM1
XSBlMTAwMGUgMDAwNDowMTowMC4wOiBwY2lfZG1hX2NvbmZpZ3VyZSAKPj4gaW9tbXVfZGV2aWNl
X3VzZV9kZWZhdWx0X2RvbWFpbiByZXR1cm5lZCAwCj4+IFvCoMKgIDEwLjU2OTQ5Ml0gZTEwMDBl
IDAwMDQ6MDE6MDAuMDogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDMKPj4KPj4gXl5edGhlIGdyb3Vw
IGlzIGFkZGVkIGFmdGVyIHRoZQo+PiBpb21tdV9kZXZpY2VfdXNlX2RlZmF1bHRfZG9tYWluKCkg
Y2FsbAo+PiBTbyB0aGUgZ3JvdXAtPm93bmVyX2NudCBpcyBub3QgaW5jcmVtZW50ZWQgYXMgZXhw
ZWN0ZWQuCj4gCj4gVGhhbmsgeW91IGZvciByZXBvcnRpbmcgdGhpcy4gRG8geW91IGhhdmUgYW55
IGlkZWEgd2h5IHRoZSBkcml2ZXIgaXMKPiBsb2FkZWQgYmVmb3JlIGlvbW11X3Byb2JlX2Rldmlj
ZSgpPwoKVXJnaCwgdGhpcyBpcyB0aGUgaG9ycmlibGUgZmlybXdhcmUtZGF0YS1vcmRlcmluZyB0
aGluZyBhZ2Fpbi4gVGhlIHN0dWZmIApJJ3ZlIGJlZW4gc2F5aW5nIGFib3V0IGhhdmluZyB0byBy
ZXdvcmsgdGhlIHdob2xlIC5kbWFfY29uZmlndXJlIAptZWNoYW5pc20gaW4gdGhlIG5lYXIgZnV0
dXJlIGlzIHRvIGZpeCB0aGlzIHByb3Blcmx5LgoKVGhlIHN1bW1hcnkgaXMgdGhhdCBpbiBwYXRj
aCAjNCwgY2FsbGluZyAKaW9tbXVfZGV2aWNlX3VzZV9kZWZhdWx0X2RvbWFpbigpICpiZWZvcmUq
IHtvZixhY3BpfV9kbWFfY29uZmlndXJlIGlzIApjdXJyZW50bHkgYSBwcm9ibGVtLiBBcyB0aGlu
Z3Mgc3RhbmQsIHRoZSBJT01NVSBkcml2ZXIgaWdub3JlZCB0aGUgCmluaXRpYWwgaW9tbXVfcHJv
YmVfZGV2aWNlKCkgY2FsbCB3aGVuIHRoZSBkZXZpY2Ugd2FzIGFkZGVkLCBzaW5jZSBhdCAKdGhh
dCBwb2ludCBpdCBoYWQgbm8gZndzcGVjIHlldC4gSW4gdGhpcyBzaXR1YXRpb24sIAp7b2YsYWNw
aX1faW9tbXVfY29uZmlndXJlKCkgYXJlIHJldHJpZ2dlcmluZyBpb21tdV9wcm9iZV9kZXZpY2Uo
KSBhZnRlciAKdGhlIElPTU1VIGRyaXZlciBoYXMgc2VlbiB0aGUgZmlybXdhcmUgZGF0YSB2aWEg
Lm9mX3hsYXRlIHRvIGxlYXJuIHRoYXQgCml0IGl0IGFjdHVhbGx5IHJlc3BvbnNpYmxlIGZvciB0
aGUgZ2l2ZW4gZGV2aWNlLgoKUm9iaW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
