Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C05AC433EF
	for <iommu@archiver.kernel.org>; Mon,  7 Mar 2022 03:29:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A4397404B2;
	Mon,  7 Mar 2022 03:29:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BCDWAgmJc9SX; Mon,  7 Mar 2022 03:29:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D6A7C40193;
	Mon,  7 Mar 2022 03:29:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA207C0012;
	Mon,  7 Mar 2022 03:29:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A06E7C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 03:29:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 894F081259
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 03:29:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NZlY5HgZ3YJP for <iommu@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 03:29:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B4F581258
 for <iommu@lists.linux-foundation.org>; Mon,  7 Mar 2022 03:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646623758; x=1678159758;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=6xQOf0kATP8C8A35Fbf8Z13oskeZPkNu1nz+qlvE+1I=;
 b=IBOnpAnGjqo8EmZmg+puo8i6ecovSxsOwKIBmMjzIgul+3Oiw7RUlqFL
 XhqwnoeIEGXKXa2+fVPo9Otr7ilkcdXGB1RqOX/nKHsQtsbTPKBS63kq7
 zjopwseBXC+B4tvzzM8wGpIbM8SjskDTcyEvBQSzu5pqxy2Nx+spJrdxQ
 dlwTwRK/TqwcyvUo+jWOsrk2gtcrmq0eZ7ZDn0Fa3F3hMqEhQfbHyDoUc
 9ZF4CgIilL5bEcBM+4iaYv+kn4PL5K0YnaPRYMMa0yGvtmR1pNZeCnwr8
 7RKqavtjT2/YxxBTag26kojRUKC0cbsqiaxCJYURP/3/SRJeTMVgqmPrr Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10278"; a="251864350"
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; d="scan'208";a="251864350"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2022 19:29:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,160,1643702400"; d="scan'208";a="687400858"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 06 Mar 2022 19:29:11 -0800
Message-ID: <b1a5db0a-0373-5ca0-6256-85a96d029ec9@linux.intel.com>
Date: Mon, 7 Mar 2022 11:27:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v7 01/11] iommu: Add DMA ownership management interfaces
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, eric.auger@redhat.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson
 <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
References: <20220228005056.599595-1-baolu.lu@linux.intel.com>
 <20220228005056.599595-2-baolu.lu@linux.intel.com>
 <c75b6e04-bc1b-b9f6-1a44-bf1567a8c19d@redhat.com>
 <7a3dc977-0c5f-6d88-6d3a-8e49bc717690@linux.intel.com>
 <1648bc97-a0d3-4051-58d0-e24fa9e9d183@arm.com>
 <350a8e09-08a9-082b-3ad1-b711c7d98d73@redhat.com>
 <e2698dbe-18e2-1a82-8a12-fe45bc9be534@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <e2698dbe-18e2-1a82-8a12-fe45bc9be534@arm.com>
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

SGkgUm9iaW4sCgpPbiAzLzQvMjIgMTA6MTAgUE0sIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAy
MDIyLTAzLTA0IDEzOjU1LCBFcmljIEF1Z2VyIHdyb3RlOgo+PiBIaSBSb2JpbiwKPj4KPj4gT24g
My80LzIyIDE6MjIgUE0sIFJvYmluIE11cnBoeSB3cm90ZToKPj4+IE9uIDIwMjItMDMtMDQgMTA6
NDMsIEx1IEJhb2x1IHdyb3RlOgo+Pj4+IEhpIEVyaWMsCj4+Pj4KPj4+PiBPbiAyMDIyLzMvNCAx
ODozNCwgRXJpYyBBdWdlciB3cm90ZToKPj4+Pj4gSSBoaXQgYSBXQVJOX09OKCkgd2hlbiB1bmJp
bmRpbmcgYW4gZTEwMDBlIGRyaXZlciBqdXN0IGFmdGVyIGJvb3Q6Cj4+Pj4+Cj4+Pj4+IHN1ZG8g
bW9kcHJvYmUgLXYgdmZpby1wY2kKPj4+Pj4gZWNobyB2ZmlvLXBjaSB8IHN1ZG8gdGVlIC1hCj4+
Pj4+IC9zeXMvYnVzL3BjaS9kZXZpY2VzLzAwMDQ6MDE6MDAuMC9kcml2ZXJfb3ZlcnJpZGUKPj4+
Pj4gdmZpby1wY2kKPj4+Pj4gZWNobyAwMDA0OjAxOjAwLjAgfCBzdWRvIHRlZSAtYcKgIC9zeXMv
YnVzL3BjaS9kcml2ZXJzL2UxMDAwZS91bmJpbmQKPj4+Pj4KPj4+Pj4KPj4+Pj4gW8KgIDM5MC4w
NDI4MTFdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQo+Pj4+PiBbwqAgMzkw
LjA0NjQ2OF0gV0FSTklORzogQ1BVOiA0MiBQSUQ6IDU1ODkgYXQgCj4+Pj4+IGRyaXZlcnMvaW9t
bXUvaW9tbXUuYzozMTIzCj4+Pj4+IGlvbW11X2RldmljZV91bnVzZV9kZWZhdWx0X2RvbWFpbisw
eDY4LzB4MTAwCj4+Pj4+IFvCoCAzOTAuMDU2NzEwXSBNb2R1bGVzIGxpbmtlZCBpbjogdmZpb19w
Y2kgdmZpb19wY2lfY29yZSB2ZmlvX3ZpcnFmZAo+Pj4+PiB2ZmlvX2lvbW11X3R5cGUxIHZmaW8g
eHRfQ0hFQ0tTVU0geHRfTUFTUVVFUkFERSB4dF9jb25udHJhY2sgCj4+Pj4+IGlwdF9SRUpFQ1QK
Pj4+Pj4gbmZfcmVqZWN0X2lwdjQgbmZ0X2NvbXBhdCBuZnRfY2hhaW5fbmF0IG5mX25hdCBuZl9j
b25udHJhY2sKPj4+Pj4gbmZfZGVmcmFnX2lwdjYgbmZfZGVmcmFnX2lwdjQgbmZfdGFibGVzIG5m
bmV0bGluayBicmlkZ2Ugc3RwIGxsYyAKPj4+Pj4gcmZraWxsCj4+Pj4+IHN1bnJwYyB2ZmF0IGZh
dCBtbHg1X2liIGliX3V2ZXJicyBpYl9jb3JlIGFjcGlfaXBtaSBpcG1pX3NzaWYKPj4+Pj4gaXBt
aV9kZXZpbnRmIGlwbWlfbXNnaGFuZGxlciBjcHBjX2NwdWZyZXEgZHJtIHhmcyBsaWJjcmMzMmMK
Pj4+Pj4gbWx4NV9jb3JlIHNnCj4+Pj4+IG1seGZ3IGNyY3QxMGRpZl9jZSB0bHMgZ2hhc2hfY2Ug
c2hhMl9jZSBzaGEyNTZfYXJtNjQgc2hhMV9jZSBzYnNhX2d3ZHQKPj4+Pj4gZTEwMDBlIHBzYW1w
bGUgc2RoY2lfYWNwaSBhaGNpX3BsYXRmb3JtIHNkaGNpIGxpYmFoY2lfcGxhdGZvcm0KPj4+Pj4g
cWNvbV9lbWFjCj4+Pj4+IG1tY19jb3JlIGhkbWEgaGRtYV9tZ210IGRtX21pcnJvciBkbV9yZWdp
b25faGFzaCBkbV9sb2cgZG1fbW9kIGZ1c2UKPj4+Pj4gW8KgIDM5MC4xMTA2MThdIENQVTogNDIg
UElEOiA1NTg5IENvbW06IHRlZSBLZHVtcDogbG9hZGVkIE5vdCB0YWludGVkCj4+Pj4+IDUuMTcu
MC1yYzQtbHUtdjctb2ZmaWNpYWwrICMyNAo+Pj4+PiBbwqAgMzkwLjExOTM4NF0gSGFyZHdhcmUg
bmFtZTogV0lXWU5OIFFERjI0MDAgUmVmZXJlbmNlIEV2YWx1YXRpb24KPj4+Pj4gUGxhdGZvcm0g
Q1Y5MC1MQTExNS1QMTIwL1FERjI0MDAgQ3VzdG9tZXIgUmVmZXJlbmNlIEJvYXJkLCBCSU9TCj4+
Pj4+IDBBQ0pBNTcwCj4+Pj4+IDExLzA1LzIwMTgKPj4+Pj4gW8KgIDM5MC4xMzI0OTJdIHBzdGF0
ZTogYTA0MDAwMDUgKE56Q3YgZGFpZiArUEFOIC1VQU8gLVRDTyAtRElUIC1TU0JTCj4+Pj4+IEJU
WVBFPS0tKQo+Pj4+PiBbwqAgMzkwLjEzOTQzNl0gcGMgOiBpb21tdV9kZXZpY2VfdW51c2VfZGVm
YXVsdF9kb21haW4rMHg2OC8weDEwMAo+Pj4+PiBbwqAgMzkwLjE0NTE2NV0gbHIgOiBpb21tdV9k
ZXZpY2VfdW51c2VfZGVmYXVsdF9kb21haW4rMHgzOC8weDEwMAo+Pj4+PiBbwqAgMzkwLjE1MDg5
NF0gc3AgOiBmZmZmODAwMDBmYmIzYmMwCj4+Pj4+IFvCoCAzOTAuMTU0MTkzXSB4Mjk6IGZmZmY4
MDAwMGZiYjNiYzAgeDI4OiBmZmZmMDNjMGNmNmIyNDAwIHgyNzoKPj4+Pj4gMDAwMDAwMDAwMDAw
MDAwMAo+Pj4+PiBbwqAgMzkwLjE2MTMxMV0geDI2OiAwMDAwMDAwMDAwMDAwMDAwIHgyNTogMDAw
MDAwMDAwMDAwMDAwMCB4MjQ6Cj4+Pj4+IGZmZmYwM2MwYzdjYzU3MjAKPj4+Pj4gW8KgIDM5MC4x
Njg0MjldIHgyMzogZmZmZjAzYzBjMmI5ZDE1MCB4MjI6IGZmZmZiNGU2MWRmMjIzZjggeDIxOgo+
Pj4+PiBmZmZmYjRlNjFkZjIyM2Y4Cj4+Pj4+IFvCoCAzOTAuMTc1NTQ3XSB4MjA6IGZmZmYwM2M3
YzAzYzM3NTggeDE5OiBmZmZmMDNjN2MwM2MzNzAwIHgxODoKPj4+Pj4gMDAwMDAwMDAwMDAwMDAw
MAo+Pj4+PiBbwqAgMzkwLjE4MjY2NV0geDE3OiAwMDAwMDAwMDAwMDAwMDAwIHgxNjogMDAwMDAw
MDAwMDAwMDAwMCB4MTU6Cj4+Pj4+IDAwMDAwMDAwMDAwMDAwMDAKPj4+Pj4gW8KgIDM5MC4xODk3
ODNdIHgxNDogMDAwMDAwMDAwMDAwMDAwMCB4MTM6IDAwMDAwMDAwMDAwMDAwMzAgeDEyOgo+Pj4+
PiBmZmZmMDNjMGQ1MTljZDgwCj4+Pj4+IFvCoCAzOTAuMTk2OTAxXSB4MTE6IDdmN2Y3ZjdmN2Y3
ZjdmN2YgeDEwOiAwMDAwMDAwMDAwMDAwZGMwIHg5IDoKPj4+Pj4gZmZmZmI0ZTYyMGI1NGY4Ywo+
Pj4+PiBbwqAgMzkwLjIwNDAxOV0geDggOiBmZmZmMDNjMGNmNmIzMjIwIHg3IDogZmZmZjRlZjEz
MmJiYTAwMCB4NiA6Cj4+Pj4+IDAwMDAwMDAwMDAwMDAwZmYKPj4+Pj4gW8KgIDM5MC4yMTExMzdd
IHg1IDogZmZmZjAzYzBjMmI5ZjEwOCB4NCA6IGZmZmYwM2MwZDUxZjY0MzggeDMgOgo+Pj4+PiAw
MDAwMDAwMDAwMDAwMDAwCj4+Pj4+IFvCoCAzOTAuMjE4MjU1XSB4MiA6IGZmZmYwM2MwY2Y2YjI0
MDAgeDEgOiAwMDAwMDAwMDAwMDAwMDAwIHgwIDoKPj4+Pj4gMDAwMDAwMDAwMDAwMDAwMAo+Pj4+
PiBbwqAgMzkwLjIyNTM3NF0gQ2FsbCB0cmFjZToKPj4+Pj4gW8KgIDM5MC4yMjc4MDRdwqAgaW9t
bXVfZGV2aWNlX3VudXNlX2RlZmF1bHRfZG9tYWluKzB4NjgvMHgxMDAKPj4+Pj4gW8KgIDM5MC4y
MzMxODddwqAgcGNpX2RtYV9jbGVhbnVwKzB4MzgvMHg0NAo+Pj4+PiBbwqAgMzkwLjIzNjkxOV3C
oCBfX2RldmljZV9yZWxlYXNlX2RyaXZlcisweDFhOC8weDI2MAo+Pj4+PiBbwqAgMzkwLjI0MTUx
OV3CoCBkZXZpY2VfZHJpdmVyX2RldGFjaCsweDUwLzB4ZDAKPj4+Pj4gW8KgIDM5MC4yNDU2ODZd
wqAgdW5iaW5kX3N0b3JlKzB4ZjgvMHgxMjAKPj4+Pj4gW8KgIDM5MC4yNDkyNDVdwqAgZHJ2X2F0
dHJfc3RvcmUrMHgzMC8weDQ0Cj4+Pj4+IFvCoCAzOTAuMjUyODkxXcKgIHN5c2ZzX2tmX3dyaXRl
KzB4NTAvMHg2MAo+Pj4+PiBbwqAgMzkwLjI1NjUzN13CoCBrZXJuZnNfZm9wX3dyaXRlX2l0ZXIr
MHgxMzQvMHgxY2MKPj4+Pj4gW8KgIDM5MC4yNjA5NjRdwqAgbmV3X3N5bmNfd3JpdGUrMHhmMC8w
eDE4Ywo+Pj4+PiBbwqAgMzkwLjI2NDY5Nl3CoCB2ZnNfd3JpdGUrMHgyMzAvMHgyZDAKPj4+Pj4g
W8KgIDM5MC4yNjgwODJdwqAga3N5c193cml0ZSsweDc0LzB4MTAwCj4+Pj4+IFvCoCAzOTAuMjcx
NDY3XcKgIF9fYXJtNjRfc3lzX3dyaXRlKzB4MjgvMHgzYwo+Pj4+PiBbwqAgMzkwLjI3NTM3M13C
oCBpbnZva2Vfc3lzY2FsbC5jb25zdHByb3AuMCsweDU4LzB4ZjAKPj4+Pj4gW8KgIDM5MC4yODAw
NjFdwqAgZWwwX3N2Y19jb21tb24uY29uc3Rwcm9wLjArMHgxNjAvMHgxNjQKPj4+Pj4gW8KgIDM5
MC4yODQ5MjJdwqAgZG9fZWwwX3N2YysweDM0LzB4Y2MKPj4+Pj4gW8KgIDM5MC4yODgyMjFdwqAg
ZWwwX3N2YysweDMwLzB4MTQwCj4+Pj4+IFvCoCAzOTAuMjkxMzQ2XcKgIGVsMHRfNjRfc3luY19o
YW5kbGVyKzB4YTQvMHgxMzAKPj4+Pj4gW8KgIDM5MC4yOTU1OTldwqAgZWwwdF82NF9zeW5jKzB4
MWEwLzB4MWE0Cj4+Pj4+IFvCoCAzOTAuMjk5MjQ1XSAtLS1bIGVuZCB0cmFjZSAwMDAwMDAwMDAw
MDAwMDAwIF0tLS0KPj4+Pj4KPj4+Pj4KPj4+Pj4gSSBwdXQgc29tZSB0cmFjZXMgaW4gdGhlIGNv
ZGUgYW5kIEkgY2FuIHNlZSB0aGF0Cj4+Pj4+IGlvbW11X2RldmljZV91c2VfZGVmYXVsdF9kb21h
aW4oKSBlZmZlY3RpdmVseSBpcyBjYWxsZWQgb24KPj4+Pj4gMDAwNDowMTowMC4wIGUxMDAwZSBk
ZXZpY2Ugb24gcGNpX2RtYV9jb25maWd1cmUoKSBidXQgYXQgdGhhdCB0aW1lCj4+Pj4+IHRoZSBp
b21tdSBncm91cCBpcyBOVUxMOgo+Pj4+PiBbwqDCoCAxMC41Njk0MjddIGUxMDAwZSAwMDA0OjAx
OjAwLjA6IC0tLS0tLSBFTlRSWSBwY2lfZG1hX2NvbmZpZ3VyZQo+Pj4+PiBkcml2ZXJfbWFuYWdl
ZF9hcmVhPTAKPj4+Pj4gW8KgwqAgMTAuNTY5NDMxXSBlMTAwMGUgMDAwNDowMTowMC4wOiAqKioq
Cj4+Pj4+IGlvbW11X2RldmljZV91c2VfZGVmYXVsdF9kb21haW4gRU5UUlkKPj4+Pj4gW8KgwqAg
MTAuNTY5NDMzXSBlMTAwMGUgMDAwNDowMTowMC4wOiAqKioqCj4+Pj4+IGlvbW11X2RldmljZV91
c2VfZGVmYXVsdF9kb21haW4gbm8gZ3JvdXAKPj4+Pj4gW8KgwqAgMTAuNTY5NDM1XSBlMTAwMGUg
MDAwNDowMTowMC4wOiBwY2lfZG1hX2NvbmZpZ3VyZQo+Pj4+PiBpb21tdV9kZXZpY2VfdXNlX2Rl
ZmF1bHRfZG9tYWluIHJldHVybmVkIDAKPj4+Pj4gW8KgwqAgMTAuNTY5NDkyXSBlMTAwMGUgMDAw
NDowMTowMC4wOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAgMwo+Pj4+Pgo+Pj4+PiBeXl50aGUgZ3Jv
dXAgaXMgYWRkZWQgYWZ0ZXIgdGhlCj4+Pj4+IGlvbW11X2RldmljZV91c2VfZGVmYXVsdF9kb21h
aW4oKSBjYWxsCj4+Pj4+IFNvIHRoZSBncm91cC0+b3duZXJfY250IGlzIG5vdCBpbmNyZW1lbnRl
ZCBhcyBleHBlY3RlZC4KPj4+Pgo+Pj4+IFRoYW5rIHlvdSBmb3IgcmVwb3J0aW5nIHRoaXMuIERv
IHlvdSBoYXZlIGFueSBpZGVhIHdoeSB0aGUgZHJpdmVyIGlzCj4+Pj4gbG9hZGVkIGJlZm9yZSBp
b21tdV9wcm9iZV9kZXZpY2UoKT8KPj4+Cj4+PiBVcmdoLCB0aGlzIGlzIHRoZSBob3JyaWJsZSBm
aXJtd2FyZS1kYXRhLW9yZGVyaW5nIHRoaW5nIGFnYWluLiBUaGUKPj4+IHN0dWZmIEkndmUgYmVl
biBzYXlpbmcgYWJvdXQgaGF2aW5nIHRvIHJld29yayB0aGUgd2hvbGUgLmRtYV9jb25maWd1cmUK
Pj4+IG1lY2hhbmlzbSBpbiB0aGUgbmVhciBmdXR1cmUgaXMgdG8gZml4IHRoaXMgcHJvcGVybHku
Cj4+Pgo+Pj4gVGhlIHN1bW1hcnkgaXMgdGhhdCBpbiBwYXRjaCAjNCwgY2FsbGluZwo+Pj4gaW9t
bXVfZGV2aWNlX3VzZV9kZWZhdWx0X2RvbWFpbigpICpiZWZvcmUqIHtvZixhY3BpfV9kbWFfY29u
ZmlndXJlIGlzCj4+PiBjdXJyZW50bHkgYSBwcm9ibGVtLiBBcyB0aGluZ3Mgc3RhbmQsIHRoZSBJ
T01NVSBkcml2ZXIgaWdub3JlZCB0aGUKPj4+IGluaXRpYWwgaW9tbXVfcHJvYmVfZGV2aWNlKCkg
Y2FsbCB3aGVuIHRoZSBkZXZpY2Ugd2FzIGFkZGVkLCBzaW5jZSBhdAo+Pj4gdGhhdCBwb2ludCBp
dCBoYWQgbm8gZndzcGVjIHlldC4gSW4gdGhpcyBzaXR1YXRpb24sCj4+PiB7b2YsYWNwaX1faW9t
bXVfY29uZmlndXJlKCkgYXJlIHJldHJpZ2dlcmluZyBpb21tdV9wcm9iZV9kZXZpY2UoKQo+Pj4g
YWZ0ZXIgdGhlIElPTU1VIGRyaXZlciBoYXMgc2VlbiB0aGUgZmlybXdhcmUgZGF0YSB2aWEgLm9m
X3hsYXRlIHRvCj4+PiBsZWFybiB0aGF0IGl0IGl0IGFjdHVhbGx5IHJlc3BvbnNpYmxlIGZvciB0
aGUgZ2l2ZW4gZGV2aWNlLgo+Pgo+PiB0aGFuayB5b3UgZm9yIHByb3ZpZGluZyB0aGUgaW5mby4g
SG9wZSB0aGlzIGlzIHNvbWV0aGluZyBMdSBjYW4gd29yayAKPj4gYXJvdW5kLgo+IAo+IEhvcGVm
dWxseSBpdCdzIGp1c3QgYSBjYXNlIG9mIGZsaXBwaW5nIHRoZSBjYWxscyBhcm91bmQsIHNvIHRo
YXQgCj4gaW9tbXVfdXNlX2RlZmF1bHRfZG9tYWluKCkgZ29lcyBhdCB0aGUgZW5kLCBhbmQgY2Fs
bHMgCj4gYXJjaF90ZWFyZG93bl9kbWFfb3BzKCkgaWYgaXQgZmFpbHMuIEZyb20gYSBxdWljayBz
a2ltIEkgKnRoaW5rKiB0aGF0IAo+IHNob3VsZCBzdGlsbCB3b3JrIG91dCB0byB0aGUgZGVzaXJl
ZCBiZWhhdmlvdXIgKG9yIGF0IGxlYXN0IGNsb3NlIGVub3VnaCAKPiB0aGF0IHdlIGNhbiBtb3Zl
IGZvcndhcmQgd2l0aG91dCBhIGNpcmN1bGFyIGRlcGVuZGVuY3kgYmV0d2VlbiBmaXhlcy4uLikK
ClRoaXMgaXMgYSByZWFzb25hYmxlIHNvbHV0aW9uIHRvIG1lLiBUaGFuayB5b3UgZm9yIHRoZSBp
bmZvcm1hdGlvbiBhbmQKc3VnZ2VzdGlvbi4KCkVyaWMsIEkgaGF2ZSB1cGRhdGVkIHRoZSBwYXRj
aCAjNCBhbmQgdXBsb2FkZWQgYSBuZXcgdmVyc2lvbiBoZXJlOgoKaHR0cHM6Ly9naXRodWIuY29t
L0x1QmFvbHUvaW50ZWwtaW9tbXUvY29tbWl0cy9pb21tdS1kbWEtb3duZXJzaGlwLXY4CgpDYW4g
eW91IHBsZWFzZSBnaXZlIGl0IGEgdHJ5PwoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QK
aW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
