Return-Path: <SRS0=gbr8=VX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC743C76191
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 01:57:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AA3D22C7C
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 01:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA3D22C7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 40106D89;
	Fri, 26 Jul 2019 01:57:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B61C7AEF
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 01:57:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4BFC5224
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 01:57:32 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Jul 2019 18:57:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; d="scan'208";a="181722703"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga002.jf.intel.com with ESMTP; 25 Jul 2019 18:57:26 -0700
Subject: Re: [PATCH v5 02/10] iommu/vt-d: Use per-device dma_ops
To: Christoph Hellwig <hch@lst.de>
References: <20190725031717.32317-1-baolu.lu@linux.intel.com>
	<20190725031717.32317-3-baolu.lu@linux.intel.com>
	<20190725054413.GC24527@lst.de>
	<bc831f88-5b19-7531-00aa-a7577dd5c1ac@linux.intel.com>
	<20190725114348.GA30957@lst.de>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a098359a-0f89-6028-68df-9f83718df256@linux.intel.com>
Date: Fri, 26 Jul 2019 09:56:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725114348.GA30957@lst.de>
Content-Language: en-US
Cc: alan.cox@intel.com, Stefano Stabellini <sstabellini@kernel.org>,
	ashok.raj@intel.com, Jonathan Corbet <corbet@lwn.net>,
	pengfei.xu@intel.com, Ingo Molnar <mingo@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, kevin.tian@intel.com,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	mika.westerberg@linux.intel.com, Juergen Gross <jgross@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	jacob.jun.pan@intel.com, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

SGksCgpPbiA3LzI1LzE5IDc6NDMgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIFRo
dSwgSnVsIDI1LCAyMDE5IGF0IDAzOjE4OjAzUE0gKzA4MDAsIEx1IEJhb2x1IHdyb3RlOgo+Pj4g
RG9uJ3Qgd2UgbmVlZCB0byBrZWVwIHRoaXMgYml0IHNvIHRoYXQgd2Ugc3RpbGwgYWxsb3cgdGhl
IElPTU1VCj4+PiB0byBhY3QgaWYgdGhlIGRldmljZSBoYXMgYSB0b28gc21hbGwgRE1BIG1hc2sg
dG8gYWRkcmVzcyBhbGwgbWVtb3J5IGluCj4+PiB0aGUgc3lzdGVtLCBldmVuIGlmIGlmIGl0IHNo
b3VsZCBvdGhlcndpc2UgYmUgaWRlbnRpdHkgbWFwcGVkPwo+Pj4KPj4KPj4gVGhpcyBjaGVja2lu
ZyBoYXBwZW5zIG9ubHkgd2hlbiBkZXZpY2UgaXMgdXNpbmcgYW4gaWRlbnRpdHkgbWFwcGVkCj4+
IGRvbWFpbi4gSWYgdGhlIGRldmljZSBoYXMgYSBzbWFsbCBETUEgbWFzaywgc3dpb3RsYiB3aWxs
IGJlIHVzZWQgZm9yCj4+IGhpZ2ggbWVtb3J5IGFjY2Vzcy4KPj4KPj4gVGhpcyBpcyBzdXBwb3Nl
ZCB0byBiZSBoYW5kbGVkIGluIGRtYV9kaXJlY3RfbWFwX3BhZ2UoKToKPj4KPj4gICAgICAgICAg
aWYgKHVubGlrZWx5KCFkbWFfZGlyZWN0X3Bvc3NpYmxlKGRldiwgZG1hX2FkZHIsIHNpemUpKSAm
Jgo+PiAgICAgICAgICAgICAgIXN3aW90bGJfbWFwKGRldiwgJnBoeXMsICZkbWFfYWRkciwgc2l6
ZSwgZGlyLCBhdHRycykpIHsKPj4gICAgICAgICAgICAgICAgICByZXBvcnRfYWRkcihkZXYsIGRt
YV9hZGRyLCBzaXplKTsKPj4gICAgICAgICAgICAgICAgICByZXR1cm4gRE1BX01BUFBJTkdfRVJS
T1I7Cj4+ICAgICAgICAgIH0KPiAKPiBXZWxsLCB5ZXMuICBCdXQgdGhlIHBvaW50IGlzIHRoYXQg
dGhlIGN1cnJlbnQgY29kZSB1c2VzIGR5bmFtaWMgaW9tbXUKPiBtYXBwaW5ncyBldmVuIGlmIHRo
ZSBkZXZpY2VzIGlzIGluIHRoZSBpZGVudGl0eSBtYXBwZWQgZG9tYWluIHdoZW4gdGhlCj4gZG1h
IG1hc2sg0ZZzIHRvbyBzbWFsbCB0byBtYXAgYWxsIG1lbW9yeSBkaXJlY3RseS4gIFlvdXIgY2hh
bmdlIG1lYW5zIGl0Cj4gd2lsbCBub3cgdXNlIHN3aW90bGIgd2hpY2ggaXMgbW9zdCBsaWtlbHkg
Z29pbmcgdG8gYmUgYSBsb3QgbW9yZQoKQnkgZGVmYXVsdCwgd2UgdXNlIERNQSBkb21haW4uIFRo
ZSBwcml2aWxlZ2VkIHVzZXJzIGFyZSBhYmxlIHRvIGNoYW5nZQp0aGlzIHdpdGggZ2xvYmFsIGtl
cm5lbCBwYXJhbWV0ZXIgb3IgcGVyLWdyb3VwIGRlZmF1bHQgZG9tYWluIHR5cGUgdW5kZXIKZGlz
Y3Vzc2lvbi4gSW4gYW5vdGhlciB3b3JkLCB1c2Ugb2YgaWRlbnRpdHkgZG9tYWluIGlzIGEgY2hv
aWNlIG9mIHRoZQpwcml2aWxlZ2VkIHVzZXIgd2hvIHNob3VsZCBjb25zaWRlciB0aGUgcG9zc2li
bGUgYm91bmNlIGJ1ZmZlciBvdmVyaGVhZC4KCkkgdGhpbmsgY3VycmVudCBjb2RlIGRvZXNuJ3Qg
ZG8gdGhlIHJpZ2h0IHRoaW5nLiBUaGUgdXNlciBhc2tzIHRoZSBpb21tdQpkcml2ZXIgdG8gdXNl
IGlkZW50aXR5IGRvbWFpbiBmb3IgYSBkZXZpY2UsIGJ1dCB0aGUgZHJpdmVyIGZvcmNlIGl0IGJh
Y2sKdG8gRE1BIGRvbWFpbiBiZWNhdXNlIG9mIHRoZSBkZXZpY2UgYWRkcmVzcyBjYXBhYmlsaXR5
LgoKPiBleHBlbnNpdmUuICBJIGRvbid0IHRoaW5rIHRoYXQgdGhpcyBjaGFuZ2UgaXMgYSBnb29k
IGlkZWEsIGFuZCBldmVuIGlmCj4gd2UgZGVjaWRlIHRoYXQgdGhpcyBpcyBhIGdvb2QgaWRlYSBh
ZnRlciBhbGwgdGhhdCBzaG91bGQgYmUgZG9uZSBpbiBhCj4gc2VwYXJhdGUgcHJlcCBwYXRjaCB0
aGF0IGV4cGxhaW5zIHRoZSByYXRpb25hbGUuCgpZZXMuIE1ha2Ugc2Vuc2UuCgpCZXN0IHJlZ2Fy
ZHMsCkJhb2x1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
