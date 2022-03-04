Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BE1C433FE
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 10:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BD2660BA9;
	Fri,  4 Mar 2022 10:43:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lsTbl-W2p6Gr; Fri,  4 Mar 2022 10:43:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A2B446002E;
	Fri,  4 Mar 2022 10:43:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71AA3C0012;
	Fri,  4 Mar 2022 10:43:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88655C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 10:43:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 74ACF40235
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 10:43:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uvVJkO5jICJY for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 10:43:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A722C401F4
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 10:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646390603; x=1677926603;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=WgTGiC6INkrQSj9hdXkuWQiP89mzXyrTFpQnEljce20=;
 b=f5srtxyEBr0Q0exx/bleFGgP/1qJOZP89006xQvCzuCOLjdHM2mrNEwz
 GUu7orCzGwGSZG59YK/Fs3R1W2J7CQ9hyBbBVCNKYhKTkZn9JeXkqZ5HI
 6jKpzrpvbbLS29irl9pnPXshtQvFlZcCW5IR5fjDe4eJLmiAyPWj8pXLk
 dbwxNS+TOaBPsO/+lx6aOvC7d/xWWJE8sSQCCg7TdQ2VVu44AvjsBWbUq
 7PHC925GxF+o1jx4jcA933Ci8XluikhB45/i7PFvMhQNz4l6V9oqIrxrl
 suGDEa48EQVY9JJKz6x/ze80GR8rtlzqDoUQjU7oe/0JfiPuD6aZ5Acx6 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="252777283"
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; d="scan'208";a="252777283"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2022 02:43:23 -0800
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; d="scan'208";a="508948776"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.31])
 ([10.254.209.31])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2022 02:43:13 -0800
Message-ID: <7a3dc977-0c5f-6d88-6d3a-8e49bc717690@linux.intel.com>
Date: Fri, 4 Mar 2022 18:43:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v7 01/11] iommu: Add DMA ownership management interfaces
Content-Language: en-US
To: eric.auger@redhat.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson
 <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
References: <20220228005056.599595-1-baolu.lu@linux.intel.com>
 <20220228005056.599595-2-baolu.lu@linux.intel.com>
 <c75b6e04-bc1b-b9f6-1a44-bf1567a8c19d@redhat.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <c75b6e04-bc1b-b9f6-1a44-bf1567a8c19d@redhat.com>
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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

SGkgRXJpYywKCk9uIDIwMjIvMy80IDE4OjM0LCBFcmljIEF1Z2VyIHdyb3RlOgo+IEkgaGl0IGEg
V0FSTl9PTigpIHdoZW4gdW5iaW5kaW5nIGFuIGUxMDAwZSBkcml2ZXIganVzdCBhZnRlciBib290
Ogo+IAo+IHN1ZG8gbW9kcHJvYmUgLXYgdmZpby1wY2kKPiBlY2hvIHZmaW8tcGNpIHwgc3VkbyB0
ZWUgLWEKPiAvc3lzL2J1cy9wY2kvZGV2aWNlcy8wMDA0OjAxOjAwLjAvZHJpdmVyX292ZXJyaWRl
Cj4gdmZpby1wY2kKPiBlY2hvIDAwMDQ6MDE6MDAuMCB8IHN1ZG8gdGVlIC1hwqAgL3N5cy9idXMv
cGNpL2RyaXZlcnMvZTEwMDBlL3VuYmluZAo+IAo+IAo+IFvCoCAzOTAuMDQyODExXSAtLS0tLS0t
LS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0KPiBbwqAgMzkwLjA0NjQ2OF0gV0FSTklORzog
Q1BVOiA0MiBQSUQ6IDU1ODkgYXQgZHJpdmVycy9pb21tdS9pb21tdS5jOjMxMjMKPiBpb21tdV9k
ZXZpY2VfdW51c2VfZGVmYXVsdF9kb21haW4rMHg2OC8weDEwMAo+IFvCoCAzOTAuMDU2NzEwXSBN
b2R1bGVzIGxpbmtlZCBpbjogdmZpb19wY2kgdmZpb19wY2lfY29yZSB2ZmlvX3ZpcnFmZAo+IHZm
aW9faW9tbXVfdHlwZTEgdmZpbyB4dF9DSEVDS1NVTSB4dF9NQVNRVUVSQURFIHh0X2Nvbm50cmFj
ayBpcHRfUkVKRUNUCj4gbmZfcmVqZWN0X2lwdjQgbmZ0X2NvbXBhdCBuZnRfY2hhaW5fbmF0IG5m
X25hdCBuZl9jb25udHJhY2sKPiBuZl9kZWZyYWdfaXB2NiBuZl9kZWZyYWdfaXB2NCBuZl90YWJs
ZXMgbmZuZXRsaW5rIGJyaWRnZSBzdHAgbGxjIHJma2lsbAo+IHN1bnJwYyB2ZmF0IGZhdCBtbHg1
X2liIGliX3V2ZXJicyBpYl9jb3JlIGFjcGlfaXBtaSBpcG1pX3NzaWYKPiBpcG1pX2RldmludGYg
aXBtaV9tc2doYW5kbGVyIGNwcGNfY3B1ZnJlcSBkcm0geGZzIGxpYmNyYzMyYyBtbHg1X2NvcmUg
c2cKPiBtbHhmdyBjcmN0MTBkaWZfY2UgdGxzIGdoYXNoX2NlIHNoYTJfY2Ugc2hhMjU2X2FybTY0
IHNoYTFfY2Ugc2JzYV9nd2R0Cj4gZTEwMDBlIHBzYW1wbGUgc2RoY2lfYWNwaSBhaGNpX3BsYXRm
b3JtIHNkaGNpIGxpYmFoY2lfcGxhdGZvcm0gcWNvbV9lbWFjCj4gbW1jX2NvcmUgaGRtYSBoZG1h
X21nbXQgZG1fbWlycm9yIGRtX3JlZ2lvbl9oYXNoIGRtX2xvZyBkbV9tb2QgZnVzZQo+IFvCoCAz
OTAuMTEwNjE4XSBDUFU6IDQyIFBJRDogNTU4OSBDb21tOiB0ZWUgS2R1bXA6IGxvYWRlZCBOb3Qg
dGFpbnRlZAo+IDUuMTcuMC1yYzQtbHUtdjctb2ZmaWNpYWwrICMyNAo+IFvCoCAzOTAuMTE5Mzg0
XSBIYXJkd2FyZSBuYW1lOiBXSVdZTk4gUURGMjQwMCBSZWZlcmVuY2UgRXZhbHVhdGlvbgo+IFBs
YXRmb3JtIENWOTAtTEExMTUtUDEyMC9RREYyNDAwIEN1c3RvbWVyIFJlZmVyZW5jZSBCb2FyZCwg
QklPUyAwQUNKQTU3MAo+IDExLzA1LzIwMTgKPiBbwqAgMzkwLjEzMjQ5Ml0gcHN0YXRlOiBhMDQw
MDAwNSAoTnpDdiBkYWlmICtQQU4gLVVBTyAtVENPIC1ESVQgLVNTQlMKPiBCVFlQRT0tLSkKPiBb
wqAgMzkwLjEzOTQzNl0gcGMgOiBpb21tdV9kZXZpY2VfdW51c2VfZGVmYXVsdF9kb21haW4rMHg2
OC8weDEwMAo+IFvCoCAzOTAuMTQ1MTY1XSBsciA6IGlvbW11X2RldmljZV91bnVzZV9kZWZhdWx0
X2RvbWFpbisweDM4LzB4MTAwCj4gW8KgIDM5MC4xNTA4OTRdIHNwIDogZmZmZjgwMDAwZmJiM2Jj
MAo+IFvCoCAzOTAuMTU0MTkzXSB4Mjk6IGZmZmY4MDAwMGZiYjNiYzAgeDI4OiBmZmZmMDNjMGNm
NmIyNDAwIHgyNzoKPiAwMDAwMDAwMDAwMDAwMDAwCj4gW8KgIDM5MC4xNjEzMTFdIHgyNjogMDAw
MDAwMDAwMDAwMDAwMCB4MjU6IDAwMDAwMDAwMDAwMDAwMDAgeDI0Ogo+IGZmZmYwM2MwYzdjYzU3
MjAKPiBbwqAgMzkwLjE2ODQyOV0geDIzOiBmZmZmMDNjMGMyYjlkMTUwIHgyMjogZmZmZmI0ZTYx
ZGYyMjNmOCB4MjE6Cj4gZmZmZmI0ZTYxZGYyMjNmOAo+IFvCoCAzOTAuMTc1NTQ3XSB4MjA6IGZm
ZmYwM2M3YzAzYzM3NTggeDE5OiBmZmZmMDNjN2MwM2MzNzAwIHgxODoKPiAwMDAwMDAwMDAwMDAw
MDAwCj4gW8KgIDM5MC4xODI2NjVdIHgxNzogMDAwMDAwMDAwMDAwMDAwMCB4MTY6IDAwMDAwMDAw
MDAwMDAwMDAgeDE1Ogo+IDAwMDAwMDAwMDAwMDAwMDAKPiBbwqAgMzkwLjE4OTc4M10geDE0OiAw
MDAwMDAwMDAwMDAwMDAwIHgxMzogMDAwMDAwMDAwMDAwMDAzMCB4MTI6Cj4gZmZmZjAzYzBkNTE5
Y2Q4MAo+IFvCoCAzOTAuMTk2OTAxXSB4MTE6IDdmN2Y3ZjdmN2Y3ZjdmN2YgeDEwOiAwMDAwMDAw
MDAwMDAwZGMwIHg5IDoKPiBmZmZmYjRlNjIwYjU0ZjhjCj4gW8KgIDM5MC4yMDQwMTldIHg4IDog
ZmZmZjAzYzBjZjZiMzIyMCB4NyA6IGZmZmY0ZWYxMzJiYmEwMDAgeDYgOgo+IDAwMDAwMDAwMDAw
MDAwZmYKPiBbwqAgMzkwLjIxMTEzN10geDUgOiBmZmZmMDNjMGMyYjlmMTA4IHg0IDogZmZmZjAz
YzBkNTFmNjQzOCB4MyA6Cj4gMDAwMDAwMDAwMDAwMDAwMAo+IFvCoCAzOTAuMjE4MjU1XSB4MiA6
IGZmZmYwM2MwY2Y2YjI0MDAgeDEgOiAwMDAwMDAwMDAwMDAwMDAwIHgwIDoKPiAwMDAwMDAwMDAw
MDAwMDAwCj4gW8KgIDM5MC4yMjUzNzRdIENhbGwgdHJhY2U6Cj4gW8KgIDM5MC4yMjc4MDRdwqAg
aW9tbXVfZGV2aWNlX3VudXNlX2RlZmF1bHRfZG9tYWluKzB4NjgvMHgxMDAKPiBbwqAgMzkwLjIz
MzE4N13CoCBwY2lfZG1hX2NsZWFudXArMHgzOC8weDQ0Cj4gW8KgIDM5MC4yMzY5MTldwqAgX19k
ZXZpY2VfcmVsZWFzZV9kcml2ZXIrMHgxYTgvMHgyNjAKPiBbwqAgMzkwLjI0MTUxOV3CoCBkZXZp
Y2VfZHJpdmVyX2RldGFjaCsweDUwLzB4ZDAKPiBbwqAgMzkwLjI0NTY4Nl3CoCB1bmJpbmRfc3Rv
cmUrMHhmOC8weDEyMAo+IFvCoCAzOTAuMjQ5MjQ1XcKgIGRydl9hdHRyX3N0b3JlKzB4MzAvMHg0
NAo+IFvCoCAzOTAuMjUyODkxXcKgIHN5c2ZzX2tmX3dyaXRlKzB4NTAvMHg2MAo+IFvCoCAzOTAu
MjU2NTM3XcKgIGtlcm5mc19mb3Bfd3JpdGVfaXRlcisweDEzNC8weDFjYwo+IFvCoCAzOTAuMjYw
OTY0XcKgIG5ld19zeW5jX3dyaXRlKzB4ZjAvMHgxOGMKPiBbwqAgMzkwLjI2NDY5Nl3CoCB2ZnNf
d3JpdGUrMHgyMzAvMHgyZDAKPiBbwqAgMzkwLjI2ODA4Ml3CoCBrc3lzX3dyaXRlKzB4NzQvMHgx
MDAKPiBbwqAgMzkwLjI3MTQ2N13CoCBfX2FybTY0X3N5c193cml0ZSsweDI4LzB4M2MKPiBbwqAg
MzkwLjI3NTM3M13CoCBpbnZva2Vfc3lzY2FsbC5jb25zdHByb3AuMCsweDU4LzB4ZjAKPiBbwqAg
MzkwLjI4MDA2MV3CoCBlbDBfc3ZjX2NvbW1vbi5jb25zdHByb3AuMCsweDE2MC8weDE2NAo+IFvC
oCAzOTAuMjg0OTIyXcKgIGRvX2VsMF9zdmMrMHgzNC8weGNjCj4gW8KgIDM5MC4yODgyMjFdwqAg
ZWwwX3N2YysweDMwLzB4MTQwCj4gW8KgIDM5MC4yOTEzNDZdwqAgZWwwdF82NF9zeW5jX2hhbmRs
ZXIrMHhhNC8weDEzMAo+IFvCoCAzOTAuMjk1NTk5XcKgIGVsMHRfNjRfc3luYysweDFhMC8weDFh
NAo+IFvCoCAzOTAuMjk5MjQ1XSAtLS1bIGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0K
PiAKPiAKPiBJIHB1dCBzb21lIHRyYWNlcyBpbiB0aGUgY29kZSBhbmQgSSBjYW4gc2VlIHRoYXQg
aW9tbXVfZGV2aWNlX3VzZV9kZWZhdWx0X2RvbWFpbigpIGVmZmVjdGl2ZWx5IGlzIGNhbGxlZCBv
biAwMDA0OjAxOjAwLjAgZTEwMDBlIGRldmljZSBvbiBwY2lfZG1hX2NvbmZpZ3VyZSgpIGJ1dCBh
dCB0aGF0IHRpbWUgdGhlIGlvbW11IGdyb3VwIGlzIE5VTEw6Cj4gWyAgIDEwLjU2OTQyN10gZTEw
MDBlIDAwMDQ6MDE6MDAuMDogLS0tLS0tIEVOVFJZIHBjaV9kbWFfY29uZmlndXJlIGRyaXZlcl9t
YW5hZ2VkX2FyZWE9MAo+IFsgICAxMC41Njk0MzFdIGUxMDAwZSAwMDA0OjAxOjAwLjA6ICoqKiog
aW9tbXVfZGV2aWNlX3VzZV9kZWZhdWx0X2RvbWFpbiBFTlRSWQo+IFsgICAxMC41Njk0MzNdIGUx
MDAwZSAwMDA0OjAxOjAwLjA6ICoqKiogaW9tbXVfZGV2aWNlX3VzZV9kZWZhdWx0X2RvbWFpbiBu
byBncm91cAo+IFsgICAxMC41Njk0MzVdIGUxMDAwZSAwMDA0OjAxOjAwLjA6IHBjaV9kbWFfY29u
ZmlndXJlIGlvbW11X2RldmljZV91c2VfZGVmYXVsdF9kb21haW4gcmV0dXJuZWQgMAo+IFsgICAx
MC41Njk0OTJdIGUxMDAwZSAwMDA0OjAxOjAwLjA6IEFkZGluZyB0byBpb21tdSBncm91cCAzCj4g
Cj4gXl5edGhlIGdyb3VwIGlzIGFkZGVkIGFmdGVyIHRoZQo+IGlvbW11X2RldmljZV91c2VfZGVm
YXVsdF9kb21haW4oKSBjYWxsCj4gU28gdGhlIGdyb3VwLT5vd25lcl9jbnQgaXMgbm90IGluY3Jl
bWVudGVkIGFzIGV4cGVjdGVkLgoKVGhhbmsgeW91IGZvciByZXBvcnRpbmcgdGhpcy4gRG8geW91
IGhhdmUgYW55IGlkZWEgd2h5IHRoZSBkcml2ZXIgaXMKbG9hZGVkIGJlZm9yZSBpb21tdV9wcm9i
ZV9kZXZpY2UoKT8KCkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
