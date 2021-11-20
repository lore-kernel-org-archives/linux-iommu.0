Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A053C433FE
	for <iommu@archiver.kernel.org>; Sat, 20 Nov 2021 11:20:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0710860706;
	Sat, 20 Nov 2021 11:20:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RzUM1okmrUyr; Sat, 20 Nov 2021 11:20:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E145D60008;
	Sat, 20 Nov 2021 11:20:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8CB4C001E;
	Sat, 20 Nov 2021 11:20:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FEDCC0012
 for <iommu@lists.linux-foundation.org>; Sat, 20 Nov 2021 11:20:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2AD4960706
 for <iommu@lists.linux-foundation.org>; Sat, 20 Nov 2021 11:20:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 85YsY8D06IAB for <iommu@lists.linux-foundation.org>;
 Sat, 20 Nov 2021 11:20:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8340A60008
 for <iommu@lists.linux-foundation.org>; Sat, 20 Nov 2021 11:20:50 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="234388336"
X-IronPort-AV: E=Sophos;i="5.87,250,1631602800"; d="scan'208";a="234388336"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2021 03:20:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,250,1631602800"; d="scan'208";a="496214393"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 20 Nov 2021 03:20:44 -0800
Subject: Re: [PATCH 01/11] iommu: Add device dma ownership set/release
 interfaces
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
References: <20211115020552.2378167-1-baolu.lu@linux.intel.com>
 <20211115020552.2378167-2-baolu.lu@linux.intel.com>
 <YZJdJH4AS+vm0j06@infradead.org>
 <cc7ce6f4-b1ec-49ef-e245-ab6c330154c2@linux.intel.com>
 <20211116134603.GA2105516@nvidia.com>
 <BN9PR11MB5433639E43C37C5D2462BD718C9B9@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20211118133325.GO2105516@nvidia.com>
 <BN9PR11MB5433E5B63E575E2232DFBBE48C9C9@BN9PR11MB5433.namprd11.prod.outlook.com>
 <75100dfd-9cfe-9f3d-531d-b4d30de03e76@linux.intel.com>
 <20211119150612.jhsvsbzisvux2lga@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <48cf6b2b-28ee-178d-6471-460e781e7b20@linux.intel.com>
Date: Sat, 20 Nov 2021 19:16:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211119150612.jhsvsbzisvux2lga@8bytes.org>
Content-Language: en-US
Cc: Alex Williamson <alex.williamson@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <will@kernel.org>,
 Diana Craciun <diana.craciun@oss.nxp.com>
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

SGkgSm9lcmcsCgpPbiAxMS8xOS8yMSAxMTowNiBQTSwgSsO2cmcgUsO2ZGVsIHdyb3RlOgo+IE9u
IEZyaSwgTm92IDE5LCAyMDIxIGF0IDA3OjE0OjEwUE0gKzA4MDAsIEx1IEJhb2x1IHdyb3RlOgo+
PiBUaGUgc2luZ2xldG9uIGdyb3VwIHJlcXVpcmVtZW50IGZvciBpb21tdV9hdHRhY2gvZGV0YWNo
X2RldmljZSgpIHdhcwo+PiBhZGRlZCBieSBiZWxvdyBjb21taXQ6Cj4+Cj4+IGNvbW1pdCA0MjZh
MjczODM0ZWFlNjVhYmNmYzcxMzJhMjFhODViMzE1MWUwYmNlCj4+IEF1dGhvcjogSm9lcmcgUm9l
ZGVsIDxqcm9lZGVsQHN1c2UuZGU+Cj4+IERhdGU6ICAgVGh1IE1heSAyOCAxODo0MTozMCAyMDE1
ICswMjAwCj4+Cj4+ICAgICAgaW9tbXU6IExpbWl0IGlvbW11X2F0dGFjaC9kZXRhY2hfZGV2aWNl
IHRvIGRldmljZXMgd2l0aCB0aGVpciBvd24gZ3JvdXAKPj4KPj4gICAgICBUaGlzIHBhdGNoIGNo
YW5nZXMgdGhlIGJlaGF2aW9yIG9mIHRoZSBpb21tdV9hdHRhY2hfZGV2aWNlCj4+ICAgICAgYW5k
IGlvbW11X2RldGFjaF9kZXZpY2UgZnVuY3Rpb25zLiBXaXRoIHRoaXMgY2hhbmdlIHRoZXNlCj4+
ICAgICAgZnVuY3Rpb25zIG9ubHkgd29yayBvbiBkZXZpY2VzIHRoYXQgaGF2ZSB0aGVpciBvd24g
Z3JvdXAuCj4+ICAgICAgRm9yIGFsbCBvdGhlciBkZXZpY2VzIHRoZSBpb21tdV9ncm91cF9hdHRh
Y2gvZGV0YWNoCj4+ICAgICAgZnVuY3Rpb25zIG11c3QgYmUgdXNlZC4KPj4KPj4gICAgICBTaWdu
ZWQtb2ZmLWJ5OiBKb2VyZyBSb2VkZWwgPGpyb2VkZWxAc3VzZS5kZT4KPj4KPj4gSm9lcmcsY2Fu
IHlvdSBwbGVhc2Ugc2hlZCBzb21lIGxpZ2h0IG9uIHRoZSBiYWNrZ3JvdW5kIG9mIHRoaXMKPj4g
cmVxdWlyZW1lbnQ/IERvZXMgYWJvdmUgaWRlYSBvZiB0cmFuc2l0aW9uIGZyb20gc2luZ2xldG9u
IGdyb3VwCj4+IHRvIGdyb3VwIHdpdGggc2luZ2xlIGRyaXZlciBib3VuZCBtYWtlIHNlbnNlIHRv
IHlvdT8KPiAKPiBUaGlzIGNoYW5nZSBjYW1lIHRvIGJlIGJlY2F1c2UgdGhlIGlvbW11X2F0dGFj
aC9kZXRhY2hfZGV2aWNlKCkKPiBpbnRlcmZhY2UgZG9lc24ndCBmaXQgd2VsbCBpbnRvIGEgd29y
bGQgd2l0aCBpb21tdS1ncm91cHMuIERldmljZXMKPiB3aXRoaW4gYSBncm91cCBhcmUgYnkgZGVm
aW5pdGlvbiBub3QgaXNvbGF0ZWQgYmV0d2VlbiBlYWNoIG90aGVyLCBzbwo+IHRoZXkgbXVzdCBh
bGwgYmUgaW4gdGhlIHNhbWUgYWRkcmVzcyBzcGFjZSAoPT0gaW9tbXVfZG9tYWluKS4gU28gaXQK
PiBkb2Vzbid0IG1ha2Ugc2Vuc2UgdG8gYWxsb3cgYXR0YWNoaW5nIGEgc2luZ2xlIGRldmljZSB3
aXRoaW4gYSBncm91cCB0bwo+IGEgZGlmZmVyZW50IGlvbW11X2RvbWFpbi4KClRoYW5rcyBmb3Ig
dGhlIGV4cGxhbmF0aW9uLiBJdCdzIHZlcnkgaGVscGZ1bC4gVGhlcmUgc2VlbXMgdG8gYmUgYSBs
b3QKb2YgZGlzY3Vzc2lvbnMgYXJvdW5kIHRoaXMsIGJ1dCBJIGRpZG4ndCBzZWUgYW55IG1lYW5p
bmdmdWwgcmVhc29ucyB0bwpicmVhayB0aGUgYXNzdW1wdGlvbiBvZiAiYWxsIGRldmljZXMgaW4g
YSBncm91cCBiZWluZyBpbiBhIHNhbWUgYWRkcmVzcwpzcGFjZSIuCgpCZXN0IHJlZ2FyZHMsCmJh
b2x1Cgo+IAo+IEkga25vdyB0aGF0IGluIHRoZW9yeSBpdCBpcyBzYWZlIHRvIGFsbG93IGRldmlj
ZXMgd2l0aGluIGEgZ3JvdXAgdG8gYmUKPiBpbiBkaWZmZXJlbnQgZG9tYWlucyBiZWNhdXNlIHRo
ZXJlIGlvbW11LWdyb3VwcyBjYXRjaCBtdWx0aXBsZQo+IG5vbi1pc29sYXRpb24gY2FzZXM6Cj4g
Cj4gCTEpIERldmljZXMgYmVoaW5kIGEgbm9uLUFDUyBjYXBhYmxlIGJyaWRnZSBvciBtdWx0aXBs
ZSBmdW5jdGlvbnMKPiAJICAgb2YgYSBQQ0kgZGV2aWNlLiBIZXJlIGl0IGlzIHNhZmUgdG8gcHV0
IHRoZSBkZXZpY2VzIGludG8KPiAJICAgZGlmZmVyZW50IGlvbW11LWRvbWFpbnMgYXMgbG9uZyBh
cyBhbGwgYWZmZWN0ZWQgZGV2aWNlcyBhcmUKPiAJICAgY29udHJvbGxlZCBieSB0aGUgc2FtZSBv
d25lci4KPiAKPiAJMikgRGV2aWNlcyB3aGljaCBzaGFyZSBhIHNpbmdsZSByZXF1ZXN0LWlkIGFu
ZCBjYW4ndCBiZQo+IAkgICBkaWZmZXJlbnRpYXRlZCBieSB0aGUgSU9NTVUgaGFyZHdhcmUuIFRo
ZXNlIGFsd2F5cyBuZWVkIHRvIGJlCj4gCSAgIGluIHRoZSBzYW1lIGlvbW11X2RvbWFpbi4KPiAK
PiBUbyBsaWZ0IHRoZSBzaW5nbGUtZG9tYWluLXBlci1ncm91cCByZXF1aXJlbWVudCB0aGUgaW9t
bXUgY29yZSBjb2RlCj4gbmVlZHMgdG8gbGVhcm4gdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUg
dHdvIGNhc2VzIGFib3ZlLgo+IAo+IFJlZ2FyZHMsCj4gCj4gCUpvZXJnCj4gCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
