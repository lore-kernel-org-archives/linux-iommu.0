Return-Path: <SRS0=la/L=VW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1A9C76194
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 11:43:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D41A229F9
	for <iommu@archiver.kernel.org>; Thu, 25 Jul 2019 11:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D41A229F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6FDB1EF7;
	Thu, 25 Jul 2019 11:43:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DA117EF2
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 11:43:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 42A96775
	for <iommu@lists.linux-foundation.org>;
	Thu, 25 Jul 2019 11:43:52 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 137C168BFE; Thu, 25 Jul 2019 13:43:49 +0200 (CEST)
Date: Thu, 25 Jul 2019 13:43:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 02/10] iommu/vt-d: Use per-device dma_ops
Message-ID: <20190725114348.GA30957@lst.de>
References: <20190725031717.32317-1-baolu.lu@linux.intel.com>
	<20190725031717.32317-3-baolu.lu@linux.intel.com>
	<20190725054413.GC24527@lst.de>
	<bc831f88-5b19-7531-00aa-a7577dd5c1ac@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bc831f88-5b19-7531-00aa-a7577dd5c1ac@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: alan.cox@intel.com, Christoph Hellwig <hch@lst.de>,
	Stefano Stabellini <sstabellini@kernel.org>, ashok.raj@intel.com,
	Jonathan Corbet <corbet@lwn.net>, pengfei.xu@intel.com,
	Ingo Molnar <mingo@redhat.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

T24gVGh1LCBKdWwgMjUsIDIwMTkgYXQgMDM6MTg6MDNQTSArMDgwMCwgTHUgQmFvbHUgd3JvdGU6
Cj4+IERvbid0IHdlIG5lZWQgdG8ga2VlcCB0aGlzIGJpdCBzbyB0aGF0IHdlIHN0aWxsIGFsbG93
IHRoZSBJT01NVQo+PiB0byBhY3QgaWYgdGhlIGRldmljZSBoYXMgYSB0b28gc21hbGwgRE1BIG1h
c2sgdG8gYWRkcmVzcyBhbGwgbWVtb3J5IGluCj4+IHRoZSBzeXN0ZW0sIGV2ZW4gaWYgaWYgaXQg
c2hvdWxkIG90aGVyd2lzZSBiZSBpZGVudGl0eSBtYXBwZWQ/Cj4+Cj4KPiBUaGlzIGNoZWNraW5n
IGhhcHBlbnMgb25seSB3aGVuIGRldmljZSBpcyB1c2luZyBhbiBpZGVudGl0eSBtYXBwZWQKPiBk
b21haW4uIElmIHRoZSBkZXZpY2UgaGFzIGEgc21hbGwgRE1BIG1hc2ssIHN3aW90bGIgd2lsbCBi
ZSB1c2VkIGZvcgo+IGhpZ2ggbWVtb3J5IGFjY2Vzcy4KPgo+IFRoaXMgaXMgc3VwcG9zZWQgdG8g
YmUgaGFuZGxlZCBpbiBkbWFfZGlyZWN0X21hcF9wYWdlKCk6Cj4KPiAgICAgICAgIGlmICh1bmxp
a2VseSghZG1hX2RpcmVjdF9wb3NzaWJsZShkZXYsIGRtYV9hZGRyLCBzaXplKSkgJiYKPiAgICAg
ICAgICAgICAhc3dpb3RsYl9tYXAoZGV2LCAmcGh5cywgJmRtYV9hZGRyLCBzaXplLCBkaXIsIGF0
dHJzKSkgewo+ICAgICAgICAgICAgICAgICByZXBvcnRfYWRkcihkZXYsIGRtYV9hZGRyLCBzaXpl
KTsKPiAgICAgICAgICAgICAgICAgcmV0dXJuIERNQV9NQVBQSU5HX0VSUk9SOwo+ICAgICAgICAg
fQoKV2VsbCwgeWVzLiAgQnV0IHRoZSBwb2ludCBpcyB0aGF0IHRoZSBjdXJyZW50IGNvZGUgdXNl
cyBkeW5hbWljIGlvbW11Cm1hcHBpbmdzIGV2ZW4gaWYgdGhlIGRldmljZXMgaXMgaW4gdGhlIGlk
ZW50aXR5IG1hcHBlZCBkb21haW4gd2hlbiB0aGUKZG1hIG1hc2sg0ZZzIHRvbyBzbWFsbCB0byBt
YXAgYWxsIG1lbW9yeSBkaXJlY3RseS4gIFlvdXIgY2hhbmdlIG1lYW5zIGl0CndpbGwgbm93IHVz
ZSBzd2lvdGxiIHdoaWNoIGlzIG1vc3QgbGlrZWx5IGdvaW5nIHRvIGJlIGEgbG90IG1vcmUKZXhw
ZW5zaXZlLiAgSSBkb24ndCB0aGluayB0aGF0IHRoaXMgY2hhbmdlIGlzIGEgZ29vZCBpZGVhLCBh
bmQgZXZlbiBpZgp3ZSBkZWNpZGUgdGhhdCB0aGlzIGlzIGEgZ29vZCBpZGVhIGFmdGVyIGFsbCB0
aGF0IHNob3VsZCBiZSBkb25lIGluIGEKc2VwYXJhdGUgcHJlcCBwYXRjaCB0aGF0IGV4cGxhaW5z
IHRoZSByYXRpb25hbGUuCgo+IEJlc3QgcmVnYXJkcywKPiBCYW9sdQotLS1lbmQgcXVvdGVkIHRl
eHQtLS0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
