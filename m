Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AD7C433FE
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 14:11:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 316AF409E9;
	Fri,  4 Mar 2022 14:11:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aTHTNHIuBcZK; Fri,  4 Mar 2022 14:11:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4FD3E40137;
	Fri,  4 Mar 2022 14:11:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33D3DC0012;
	Fri,  4 Mar 2022 14:11:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0D76C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 14:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B8FD960D76
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 14:11:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8_znFXOdQDR9 for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 14:11:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8765060A9C
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 14:11:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEB871424;
 Fri,  4 Mar 2022 06:11:00 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB4983F70D;
 Fri,  4 Mar 2022 06:10:56 -0800 (PST)
Message-ID: <e2698dbe-18e2-1a82-8a12-fe45bc9be534@arm.com>
Date: Fri, 4 Mar 2022 14:10:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v7 01/11] iommu: Add DMA ownership management interfaces
Content-Language: en-GB
To: eric.auger@redhat.com, Lu Baolu <baolu.lu@linux.intel.com>,
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
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <350a8e09-08a9-082b-3ad1-b711c7d98d73@redhat.com>
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

T24gMjAyMi0wMy0wNCAxMzo1NSwgRXJpYyBBdWdlciB3cm90ZToKPiBIaSBSb2JpbiwKPiAKPiBP
biAzLzQvMjIgMToyMiBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiBPbiAyMDIyLTAzLTA0IDEw
OjQzLCBMdSBCYW9sdSB3cm90ZToKPj4+IEhpIEVyaWMsCj4+Pgo+Pj4gT24gMjAyMi8zLzQgMTg6
MzQsIEVyaWMgQXVnZXIgd3JvdGU6Cj4+Pj4gSSBoaXQgYSBXQVJOX09OKCkgd2hlbiB1bmJpbmRp
bmcgYW4gZTEwMDBlIGRyaXZlciBqdXN0IGFmdGVyIGJvb3Q6Cj4+Pj4KPj4+PiBzdWRvIG1vZHBy
b2JlIC12IHZmaW8tcGNpCj4+Pj4gZWNobyB2ZmlvLXBjaSB8IHN1ZG8gdGVlIC1hCj4+Pj4gL3N5
cy9idXMvcGNpL2RldmljZXMvMDAwNDowMTowMC4wL2RyaXZlcl9vdmVycmlkZQo+Pj4+IHZmaW8t
cGNpCj4+Pj4gZWNobyAwMDA0OjAxOjAwLjAgfCBzdWRvIHRlZSAtYcKgIC9zeXMvYnVzL3BjaS9k
cml2ZXJzL2UxMDAwZS91bmJpbmQKPj4+Pgo+Pj4+Cj4+Pj4gW8KgIDM5MC4wNDI4MTFdIC0tLS0t
LS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQo+Pj4+IFvCoCAzOTAuMDQ2NDY4XSBXQVJO
SU5HOiBDUFU6IDQyIFBJRDogNTU4OSBhdCBkcml2ZXJzL2lvbW11L2lvbW11LmM6MzEyMwo+Pj4+
IGlvbW11X2RldmljZV91bnVzZV9kZWZhdWx0X2RvbWFpbisweDY4LzB4MTAwCj4+Pj4gW8KgIDM5
MC4wNTY3MTBdIE1vZHVsZXMgbGlua2VkIGluOiB2ZmlvX3BjaSB2ZmlvX3BjaV9jb3JlIHZmaW9f
dmlycWZkCj4+Pj4gdmZpb19pb21tdV90eXBlMSB2ZmlvIHh0X0NIRUNLU1VNIHh0X01BU1FVRVJB
REUgeHRfY29ubnRyYWNrIGlwdF9SRUpFQ1QKPj4+PiBuZl9yZWplY3RfaXB2NCBuZnRfY29tcGF0
IG5mdF9jaGFpbl9uYXQgbmZfbmF0IG5mX2Nvbm50cmFjawo+Pj4+IG5mX2RlZnJhZ19pcHY2IG5m
X2RlZnJhZ19pcHY0IG5mX3RhYmxlcyBuZm5ldGxpbmsgYnJpZGdlIHN0cCBsbGMgcmZraWxsCj4+
Pj4gc3VucnBjIHZmYXQgZmF0IG1seDVfaWIgaWJfdXZlcmJzIGliX2NvcmUgYWNwaV9pcG1pIGlw
bWlfc3NpZgo+Pj4+IGlwbWlfZGV2aW50ZiBpcG1pX21zZ2hhbmRsZXIgY3BwY19jcHVmcmVxIGRy
bSB4ZnMgbGliY3JjMzJjCj4+Pj4gbWx4NV9jb3JlIHNnCj4+Pj4gbWx4ZncgY3JjdDEwZGlmX2Nl
IHRscyBnaGFzaF9jZSBzaGEyX2NlIHNoYTI1Nl9hcm02NCBzaGExX2NlIHNic2FfZ3dkdAo+Pj4+
IGUxMDAwZSBwc2FtcGxlIHNkaGNpX2FjcGkgYWhjaV9wbGF0Zm9ybSBzZGhjaSBsaWJhaGNpX3Bs
YXRmb3JtCj4+Pj4gcWNvbV9lbWFjCj4+Pj4gbW1jX2NvcmUgaGRtYSBoZG1hX21nbXQgZG1fbWly
cm9yIGRtX3JlZ2lvbl9oYXNoIGRtX2xvZyBkbV9tb2QgZnVzZQo+Pj4+IFvCoCAzOTAuMTEwNjE4
XSBDUFU6IDQyIFBJRDogNTU4OSBDb21tOiB0ZWUgS2R1bXA6IGxvYWRlZCBOb3QgdGFpbnRlZAo+
Pj4+IDUuMTcuMC1yYzQtbHUtdjctb2ZmaWNpYWwrICMyNAo+Pj4+IFvCoCAzOTAuMTE5Mzg0XSBI
YXJkd2FyZSBuYW1lOiBXSVdZTk4gUURGMjQwMCBSZWZlcmVuY2UgRXZhbHVhdGlvbgo+Pj4+IFBs
YXRmb3JtIENWOTAtTEExMTUtUDEyMC9RREYyNDAwIEN1c3RvbWVyIFJlZmVyZW5jZSBCb2FyZCwg
QklPUwo+Pj4+IDBBQ0pBNTcwCj4+Pj4gMTEvMDUvMjAxOAo+Pj4+IFvCoCAzOTAuMTMyNDkyXSBw
c3RhdGU6IGEwNDAwMDA1IChOekN2IGRhaWYgK1BBTiAtVUFPIC1UQ08gLURJVCAtU1NCUwo+Pj4+
IEJUWVBFPS0tKQo+Pj4+IFvCoCAzOTAuMTM5NDM2XSBwYyA6IGlvbW11X2RldmljZV91bnVzZV9k
ZWZhdWx0X2RvbWFpbisweDY4LzB4MTAwCj4+Pj4gW8KgIDM5MC4xNDUxNjVdIGxyIDogaW9tbXVf
ZGV2aWNlX3VudXNlX2RlZmF1bHRfZG9tYWluKzB4MzgvMHgxMDAKPj4+PiBbwqAgMzkwLjE1MDg5
NF0gc3AgOiBmZmZmODAwMDBmYmIzYmMwCj4+Pj4gW8KgIDM5MC4xNTQxOTNdIHgyOTogZmZmZjgw
MDAwZmJiM2JjMCB4Mjg6IGZmZmYwM2MwY2Y2YjI0MDAgeDI3Ogo+Pj4+IDAwMDAwMDAwMDAwMDAw
MDAKPj4+PiBbwqAgMzkwLjE2MTMxMV0geDI2OiAwMDAwMDAwMDAwMDAwMDAwIHgyNTogMDAwMDAw
MDAwMDAwMDAwMCB4MjQ6Cj4+Pj4gZmZmZjAzYzBjN2NjNTcyMAo+Pj4+IFvCoCAzOTAuMTY4NDI5
XSB4MjM6IGZmZmYwM2MwYzJiOWQxNTAgeDIyOiBmZmZmYjRlNjFkZjIyM2Y4IHgyMToKPj4+PiBm
ZmZmYjRlNjFkZjIyM2Y4Cj4+Pj4gW8KgIDM5MC4xNzU1NDddIHgyMDogZmZmZjAzYzdjMDNjMzc1
OCB4MTk6IGZmZmYwM2M3YzAzYzM3MDAgeDE4Ogo+Pj4+IDAwMDAwMDAwMDAwMDAwMDAKPj4+PiBb
wqAgMzkwLjE4MjY2NV0geDE3OiAwMDAwMDAwMDAwMDAwMDAwIHgxNjogMDAwMDAwMDAwMDAwMDAw
MCB4MTU6Cj4+Pj4gMDAwMDAwMDAwMDAwMDAwMAo+Pj4+IFvCoCAzOTAuMTg5NzgzXSB4MTQ6IDAw
MDAwMDAwMDAwMDAwMDAgeDEzOiAwMDAwMDAwMDAwMDAwMDMwIHgxMjoKPj4+PiBmZmZmMDNjMGQ1
MTljZDgwCj4+Pj4gW8KgIDM5MC4xOTY5MDFdIHgxMTogN2Y3ZjdmN2Y3ZjdmN2Y3ZiB4MTA6IDAw
MDAwMDAwMDAwMDBkYzAgeDkgOgo+Pj4+IGZmZmZiNGU2MjBiNTRmOGMKPj4+PiBbwqAgMzkwLjIw
NDAxOV0geDggOiBmZmZmMDNjMGNmNmIzMjIwIHg3IDogZmZmZjRlZjEzMmJiYTAwMCB4NiA6Cj4+
Pj4gMDAwMDAwMDAwMDAwMDBmZgo+Pj4+IFvCoCAzOTAuMjExMTM3XSB4NSA6IGZmZmYwM2MwYzJi
OWYxMDggeDQgOiBmZmZmMDNjMGQ1MWY2NDM4IHgzIDoKPj4+PiAwMDAwMDAwMDAwMDAwMDAwCj4+
Pj4gW8KgIDM5MC4yMTgyNTVdIHgyIDogZmZmZjAzYzBjZjZiMjQwMCB4MSA6IDAwMDAwMDAwMDAw
MDAwMDAgeDAgOgo+Pj4+IDAwMDAwMDAwMDAwMDAwMDAKPj4+PiBbwqAgMzkwLjIyNTM3NF0gQ2Fs
bCB0cmFjZToKPj4+PiBbwqAgMzkwLjIyNzgwNF3CoCBpb21tdV9kZXZpY2VfdW51c2VfZGVmYXVs
dF9kb21haW4rMHg2OC8weDEwMAo+Pj4+IFvCoCAzOTAuMjMzMTg3XcKgIHBjaV9kbWFfY2xlYW51
cCsweDM4LzB4NDQKPj4+PiBbwqAgMzkwLjIzNjkxOV3CoCBfX2RldmljZV9yZWxlYXNlX2RyaXZl
cisweDFhOC8weDI2MAo+Pj4+IFvCoCAzOTAuMjQxNTE5XcKgIGRldmljZV9kcml2ZXJfZGV0YWNo
KzB4NTAvMHhkMAo+Pj4+IFvCoCAzOTAuMjQ1Njg2XcKgIHVuYmluZF9zdG9yZSsweGY4LzB4MTIw
Cj4+Pj4gW8KgIDM5MC4yNDkyNDVdwqAgZHJ2X2F0dHJfc3RvcmUrMHgzMC8weDQ0Cj4+Pj4gW8Kg
IDM5MC4yNTI4OTFdwqAgc3lzZnNfa2Zfd3JpdGUrMHg1MC8weDYwCj4+Pj4gW8KgIDM5MC4yNTY1
MzddwqAga2VybmZzX2ZvcF93cml0ZV9pdGVyKzB4MTM0LzB4MWNjCj4+Pj4gW8KgIDM5MC4yNjA5
NjRdwqAgbmV3X3N5bmNfd3JpdGUrMHhmMC8weDE4Ywo+Pj4+IFvCoCAzOTAuMjY0Njk2XcKgIHZm
c193cml0ZSsweDIzMC8weDJkMAo+Pj4+IFvCoCAzOTAuMjY4MDgyXcKgIGtzeXNfd3JpdGUrMHg3
NC8weDEwMAo+Pj4+IFvCoCAzOTAuMjcxNDY3XcKgIF9fYXJtNjRfc3lzX3dyaXRlKzB4MjgvMHgz
Ywo+Pj4+IFvCoCAzOTAuMjc1MzczXcKgIGludm9rZV9zeXNjYWxsLmNvbnN0cHJvcC4wKzB4NTgv
MHhmMAo+Pj4+IFvCoCAzOTAuMjgwMDYxXcKgIGVsMF9zdmNfY29tbW9uLmNvbnN0cHJvcC4wKzB4
MTYwLzB4MTY0Cj4+Pj4gW8KgIDM5MC4yODQ5MjJdwqAgZG9fZWwwX3N2YysweDM0LzB4Y2MKPj4+
PiBbwqAgMzkwLjI4ODIyMV3CoCBlbDBfc3ZjKzB4MzAvMHgxNDAKPj4+PiBbwqAgMzkwLjI5MTM0
Nl3CoCBlbDB0XzY0X3N5bmNfaGFuZGxlcisweGE0LzB4MTMwCj4+Pj4gW8KgIDM5MC4yOTU1OTld
wqAgZWwwdF82NF9zeW5jKzB4MWEwLzB4MWE0Cj4+Pj4gW8KgIDM5MC4yOTkyNDVdIC0tLVsgZW5k
IHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQo+Pj4+Cj4+Pj4KPj4+PiBJIHB1dCBzb21lIHRy
YWNlcyBpbiB0aGUgY29kZSBhbmQgSSBjYW4gc2VlIHRoYXQKPj4+PiBpb21tdV9kZXZpY2VfdXNl
X2RlZmF1bHRfZG9tYWluKCkgZWZmZWN0aXZlbHkgaXMgY2FsbGVkIG9uCj4+Pj4gMDAwNDowMTow
MC4wIGUxMDAwZSBkZXZpY2Ugb24gcGNpX2RtYV9jb25maWd1cmUoKSBidXQgYXQgdGhhdCB0aW1l
Cj4+Pj4gdGhlIGlvbW11IGdyb3VwIGlzIE5VTEw6Cj4+Pj4gW8KgwqAgMTAuNTY5NDI3XSBlMTAw
MGUgMDAwNDowMTowMC4wOiAtLS0tLS0gRU5UUlkgcGNpX2RtYV9jb25maWd1cmUKPj4+PiBkcml2
ZXJfbWFuYWdlZF9hcmVhPTAKPj4+PiBbwqDCoCAxMC41Njk0MzFdIGUxMDAwZSAwMDA0OjAxOjAw
LjA6ICoqKioKPj4+PiBpb21tdV9kZXZpY2VfdXNlX2RlZmF1bHRfZG9tYWluIEVOVFJZCj4+Pj4g
W8KgwqAgMTAuNTY5NDMzXSBlMTAwMGUgMDAwNDowMTowMC4wOiAqKioqCj4+Pj4gaW9tbXVfZGV2
aWNlX3VzZV9kZWZhdWx0X2RvbWFpbiBubyBncm91cAo+Pj4+IFvCoMKgIDEwLjU2OTQzNV0gZTEw
MDBlIDAwMDQ6MDE6MDAuMDogcGNpX2RtYV9jb25maWd1cmUKPj4+PiBpb21tdV9kZXZpY2VfdXNl
X2RlZmF1bHRfZG9tYWluIHJldHVybmVkIDAKPj4+PiBbwqDCoCAxMC41Njk0OTJdIGUxMDAwZSAw
MDA0OjAxOjAwLjA6IEFkZGluZyB0byBpb21tdSBncm91cCAzCj4+Pj4KPj4+PiBeXl50aGUgZ3Jv
dXAgaXMgYWRkZWQgYWZ0ZXIgdGhlCj4+Pj4gaW9tbXVfZGV2aWNlX3VzZV9kZWZhdWx0X2RvbWFp
bigpIGNhbGwKPj4+PiBTbyB0aGUgZ3JvdXAtPm93bmVyX2NudCBpcyBub3QgaW5jcmVtZW50ZWQg
YXMgZXhwZWN0ZWQuCj4+Pgo+Pj4gVGhhbmsgeW91IGZvciByZXBvcnRpbmcgdGhpcy4gRG8geW91
IGhhdmUgYW55IGlkZWEgd2h5IHRoZSBkcml2ZXIgaXMKPj4+IGxvYWRlZCBiZWZvcmUgaW9tbXVf
cHJvYmVfZGV2aWNlKCk/Cj4+Cj4+IFVyZ2gsIHRoaXMgaXMgdGhlIGhvcnJpYmxlIGZpcm13YXJl
LWRhdGEtb3JkZXJpbmcgdGhpbmcgYWdhaW4uIFRoZQo+PiBzdHVmZiBJJ3ZlIGJlZW4gc2F5aW5n
IGFib3V0IGhhdmluZyB0byByZXdvcmsgdGhlIHdob2xlIC5kbWFfY29uZmlndXJlCj4+IG1lY2hh
bmlzbSBpbiB0aGUgbmVhciBmdXR1cmUgaXMgdG8gZml4IHRoaXMgcHJvcGVybHkuCj4+Cj4+IFRo
ZSBzdW1tYXJ5IGlzIHRoYXQgaW4gcGF0Y2ggIzQsIGNhbGxpbmcKPj4gaW9tbXVfZGV2aWNlX3Vz
ZV9kZWZhdWx0X2RvbWFpbigpICpiZWZvcmUqIHtvZixhY3BpfV9kbWFfY29uZmlndXJlIGlzCj4+
IGN1cnJlbnRseSBhIHByb2JsZW0uIEFzIHRoaW5ncyBzdGFuZCwgdGhlIElPTU1VIGRyaXZlciBp
Z25vcmVkIHRoZQo+PiBpbml0aWFsIGlvbW11X3Byb2JlX2RldmljZSgpIGNhbGwgd2hlbiB0aGUg
ZGV2aWNlIHdhcyBhZGRlZCwgc2luY2UgYXQKPj4gdGhhdCBwb2ludCBpdCBoYWQgbm8gZndzcGVj
IHlldC4gSW4gdGhpcyBzaXR1YXRpb24sCj4+IHtvZixhY3BpfV9pb21tdV9jb25maWd1cmUoKSBh
cmUgcmV0cmlnZ2VyaW5nIGlvbW11X3Byb2JlX2RldmljZSgpCj4+IGFmdGVyIHRoZSBJT01NVSBk
cml2ZXIgaGFzIHNlZW4gdGhlIGZpcm13YXJlIGRhdGEgdmlhIC5vZl94bGF0ZSB0bwo+PiBsZWFy
biB0aGF0IGl0IGl0IGFjdHVhbGx5IHJlc3BvbnNpYmxlIGZvciB0aGUgZ2l2ZW4gZGV2aWNlLgo+
IAo+IHRoYW5rIHlvdSBmb3IgcHJvdmlkaW5nIHRoZSBpbmZvLiBIb3BlIHRoaXMgaXMgc29tZXRo
aW5nIEx1IGNhbiB3b3JrIGFyb3VuZC4KCkhvcGVmdWxseSBpdCdzIGp1c3QgYSBjYXNlIG9mIGZs
aXBwaW5nIHRoZSBjYWxscyBhcm91bmQsIHNvIHRoYXQgCmlvbW11X3VzZV9kZWZhdWx0X2RvbWFp
bigpIGdvZXMgYXQgdGhlIGVuZCwgYW5kIGNhbGxzIAphcmNoX3RlYXJkb3duX2RtYV9vcHMoKSBp
ZiBpdCBmYWlscy4gRnJvbSBhIHF1aWNrIHNraW0gSSAqdGhpbmsqIHRoYXQgCnNob3VsZCBzdGls
bCB3b3JrIG91dCB0byB0aGUgZGVzaXJlZCBiZWhhdmlvdXIgKG9yIGF0IGxlYXN0IGNsb3NlIGVu
b3VnaCAKdGhhdCB3ZSBjYW4gbW92ZSBmb3J3YXJkIHdpdGhvdXQgYSBjaXJjdWxhciBkZXBlbmRl
bmN5IGJldHdlZW4gZml4ZXMuLi4pCgpSb2Jpbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
