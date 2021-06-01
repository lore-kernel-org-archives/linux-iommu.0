Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E5AC47080
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 12:30:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13922613B1
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 12:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13922613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CF08840266;
	Tue,  1 Jun 2021 12:30:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jorUu_TBBebw; Tue,  1 Jun 2021 12:30:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id AC50D40004;
	Tue,  1 Jun 2021 12:30:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F3ECC000D;
	Tue,  1 Jun 2021 12:30:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D5D7C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 12:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 647844047A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 12:30:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SI4BskfDFT5G for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 12:30:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 331634045D
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 12:30:44 +0000 (UTC)
IronPort-SDR: 6I1t2ld5Lz8g+S3ogo+NeC/SUGVkARjzbOAf41HVXiUG6S1zr+7LEuU2KeiuIpr4ptq53tQEoj
 kZDmaBrFDVZA==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="203533455"
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; d="scan'208";a="203533455"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2021 05:30:43 -0700
IronPort-SDR: pmRj6eQl7X0Fy7iIH1MbbbVkU0DGVu7qw6nbeDY/T4pbyT5C2VCpozjuvAh/HOtbhAPZWRXLJ7
 5LEqbVipItug==
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; d="scan'208";a="479260607"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.9])
 ([10.254.213.9])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2021 05:30:37 -0700
Subject: Re: [RFC] /dev/ioasid uAPI proposal
To: Shenming Lu <lushenming@huawei.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Alex Williamson (alex.williamson@redhat.com)" <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <c9c066ae-2a25-0799-51a7-0ca47fff41a1@huawei.com>
 <aa1624bf-e472-2b66-1d20-54ca23c19fd2@linux.intel.com>
 <ed4f6e57-4847-3ed2-75de-cea80b2fbdb8@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <01fe5034-42c8-6923-32f1-e287cc36bccc@linux.intel.com>
Date: Tue, 1 Jun 2021 20:30:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <ed4f6e57-4847-3ed2-75de-cea80b2fbdb8@huawei.com>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Kirti Wankhede <kwankhede@nvidia.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>,
 Robin Murphy <robin.murphy@arm.com>
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

T24gMjAyMS82LzEgMTU6MTUsIFNoZW5taW5nIEx1IHdyb3RlOgo+IE9uIDIwMjEvNi8xIDEzOjEw
LCBMdSBCYW9sdSB3cm90ZToKPj4gSGkgU2hlbm1pbmcsCj4+Cj4+IE9uIDYvMS8yMSAxMjozMSBQ
TSwgU2hlbm1pbmcgTHUgd3JvdGU6Cj4+PiBPbiAyMDIxLzUvMjcgMTU6NTgsIFRpYW4sIEtldmlu
IHdyb3RlOgo+Pj4+IC9kZXYvaW9hc2lkIHByb3ZpZGVzIGFuIHVuaWZpZWQgaW50ZXJmYWNlIGZv
ciBtYW5hZ2luZyBJL08gcGFnZSB0YWJsZXMgZm9yCj4+Pj4gZGV2aWNlcyBhc3NpZ25lZCB0byB1
c2Vyc3BhY2UuIERldmljZSBwYXNzdGhyb3VnaCBmcmFtZXdvcmtzIChWRklPLCB2RFBBLAo+Pj4+
IGV0Yy4pIGFyZSBleHBlY3RlZCB0byB1c2UgdGhpcyBpbnRlcmZhY2UgaW5zdGVhZCBvZiBjcmVh
dGluZyB0aGVpciBvd24gbG9naWMgdG8KPj4+PiBpc29sYXRlIHVudHJ1c3RlZCBkZXZpY2UgRE1B
cyBpbml0aWF0ZWQgYnkgdXNlcnNwYWNlLgo+Pj4+Cj4+Pj4gVGhpcyBwcm9wb3NhbCBkZXNjcmli
ZXMgdGhlIHVBUEkgb2YgL2Rldi9pb2FzaWQgYW5kIGFsc28gc2FtcGxlIHNlcXVlbmNlcwo+Pj4+
IHdpdGggVkZJTyBhcyBleGFtcGxlIGluIHR5cGljYWwgdXNhZ2VzLiBUaGUgZHJpdmVyLWZhY2lu
ZyBrZXJuZWwgQVBJIHByb3ZpZGVkCj4+Pj4gYnkgdGhlIGlvbW11IGxheWVyIGlzIHN0aWxsIFRC
RCwgd2hpY2ggY2FuIGJlIGRpc2N1c3NlZCBhZnRlciBjb25zZW5zdXMgaXMKPj4+PiBtYWRlIG9u
IHRoaXMgdUFQSS4KPj4+Pgo+Pj4+IEl0J3MgYmFzZWQgb24gYSBsZW5ndGh5IGRpc2N1c3Npb24g
c3RhcnRpbmcgZnJvbSBoZXJlOgo+Pj4+ICAgICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtaW9tbXUvMjAyMTAzMzAxMzI4MzAuR08yMzU2MjgxQG52aWRpYS5jb20vCj4+Pj4KPj4+PiBJ
dCBlbmRzIHVwIHRvIGJlIGEgbG9uZyB3cml0aW5nIGR1ZSB0byBtYW55IHRoaW5ncyB0byBiZSBz
dW1tYXJpemVkIGFuZAo+Pj4+IG5vbi10cml2aWFsIGVmZm9ydCByZXF1aXJlZCB0byBjb25uZWN0
IHRoZW0gaW50byBhIGNvbXBsZXRlIHByb3Bvc2FsLgo+Pj4+IEhvcGUgaXQgcHJvdmlkZXMgYSBj
bGVhbiBiYXNlIHRvIGNvbnZlcmdlLgo+Pj4+Cj4+PiBbLi5dCj4+Pgo+Pj4+IC8qCj4+Pj4gIMKg
wqAgKiBQYWdlIGZhdWx0IHJlcG9ydCBhbmQgcmVzcG9uc2UKPj4+PiAgwqDCoCAqCj4+Pj4gIMKg
wqAgKiBUaGlzIGlzIFRCRC4gQ2FuIGJlIGFkZGVkIGFmdGVyIG90aGVyIHBhcnRzIGFyZSBjbGVh
cmVkIHVwLiBMaWtlbHkgaXQKPj4+PiAgwqDCoCAqIHdpbGwgYmUgYSByaW5nIGJ1ZmZlciBzaGFy
ZWQgYmV0d2VlbiB1c2VyL2tlcm5lbCwgYW4gZXZlbnRmZCB0byBub3RpZnkKPj4+PiAgwqDCoCAq
IHRoZSB1c2VyIGFuZCBhbiBpb2N0bCB0byBjb21wbGV0ZSB0aGUgZmF1bHQuCj4+Pj4gIMKgwqAg
Kgo+Pj4+ICDCoMKgICogVGhlIGZhdWx0IGRhdGEgaXMgcGVyIEkvTyBhZGRyZXNzIHNwYWNlLCBp
LmUuOiBJT0FTSUQgKyBmYXVsdGluZ19hZGRyCj4+Pj4gIMKgwqAgKi8KPj4+IEhpLAo+Pj4KPj4+
IEl0IHNlZW1zIHRoYXQgdGhlIGlvYXNpZCBoYXMgZGlmZmVyZW50IHVzYWdlIGluIGRpZmZlcmVu
dCBzaXR1YXRpb24sIGl0IGNvdWxkCj4+PiBiZSBkaXJlY3RseSB1c2VkIGluIHRoZSBwaHlzaWNh
bCByb3V0aW5nLCBvciBqdXN0IGEgdmlydHVhbCBoYW5kbGUgdGhhdCBpbmRpY2F0ZXMKPj4+IGEg
cGFnZSB0YWJsZSBvciBhIHZQQVNJRCB0YWJsZSAoc3VjaCBhcyB0aGUgR1BBIGFkZHJlc3Mgc3Bh
Y2UsIGluIHRoZSBzaW1wbGUKPj4+IHBhc3N0aHJvdWdoIGNhc2UsIHRoZSBETUEgaW5wdXQgdG8g
SU9NTVUgd2lsbCBqdXN0IGNvbnRhaW4gYSBTdHJlYW0gSUQsIG5vCj4+PiBTdWJzdHJlYW0gSUQp
LCByaWdodD8KPj4+Cj4+PiBBbmQgQmFvbHUgc3VnZ2VzdGVkIHRoYXQgc2luY2Ugb25lIGRldmlj
ZSBtaWdodCBjb25zdW1lIG11bHRpcGxlIHBhZ2UgdGFibGVzLAo+Pj4gaXQncyBtb3JlIHJlYXNv
bmFibGUgdG8gaGF2ZSBvbmUgZmF1bHQgaGFuZGxlciBwZXIgcGFnZSB0YWJsZS4gQnkgdGhpcywg
ZG8gd2UKPj4+IGhhdmUgdG8gbWFpbnRhaW4gc3VjaCBhbiBpb2FzaWQgaW5mbyBsaXN0IGluIHRo
ZSBJT01NVSBsYXllcj8KPj4gQXMgZGlzY3Vzc2VkIGVhcmxpZXIsIHRoZSBJL08gcGFnZSBmYXVs
dCBhbmQgY2FjaGUgaW52YWxpZGF0aW9uIHBhdGhzCj4+IHdpbGwgaGF2ZSAiZGV2aWNlIGxhYmVs
cyIgc28gdGhhdCB0aGUgaW5mb3JtYXRpb24gY291bGQgYmUgZWFzaWx5Cj4+IHRyYW5zbGF0ZWQg
YW5kIHJvdXRlZC4KPj4KPj4gU28gaXQncyBsaWtlbHkgdGhlIHBlci1kZXZpY2UgZmF1bHQgaGFu
ZGxlciByZWdpc3RlcmluZyBBUEkgaW4gaW9tbXUKPj4gY29yZSBjYW4gYmUga2VwdCwgYnV0IC9k
ZXYvaW9hc2lkIHdpbGwgYmUgZ3Jvd24gd2l0aCBhIGxheWVyIHRvCj4+IHRyYW5zbGF0ZSBhbmQg
cHJvcGFnYXRlIEkvTyBwYWdlIGZhdWx0IGluZm9ybWF0aW9uIHRvIHRoZSByaWdodAo+PiBjb25z
dW1lcnMuCj4gWWVhaCwgaGF2aW5nIGEgZ2VuZXJhbCBwcmVwcm9jZXNzaW5nIG9mIHRoZSBmYXVs
dHMgaW4gSU9BU0lEIHNlZW1zIHRvIGJlCj4gYSBkb2FibGUgZGlyZWN0aW9uLiBCdXQgc2luY2Ug
dGhlcmUgbWF5IGJlIG1vcmUgdGhhbiBvbmUgY29uc3VtZXIgYXQgdGhlCj4gc2FtZSB0aW1lLCB3
aG8gaXMgcmVzcG9uc2libGUgZm9yIHJlZ2lzdGVyaW5nIHRoZSBwZXItZGV2aWNlIGZhdWx0IGhh
bmRsZXI/CgpUaGUgZHJpdmVycyByZWdpc3RlciBwZXIgcGFnZSB0YWJsZSBmYXVsdCBoYW5kbGVy
cyB0byAvZGV2L2lvYXNpZCB3aGljaAp3aWxsIHRoZW4gcmVnaXN0ZXIgaXRzZWxmIHRvIGlvbW11
IGNvcmUgdG8gbGlzdGVuIGFuZCByb3V0ZSB0aGUgcGVyLQpkZXZpY2UgSS9PIHBhZ2UgZmF1bHRz
LiBUaGlzIGlzIGp1c3QgYSB0b3AgbGV2ZWwgdGhvdWdodC4gSGF2ZW4ndCBnb25lCnRocm91Z2gg
dGhlIGRldGFpbHMgeWV0LiBOZWVkIHRvIHdhaXQgYW5kIHNlZSB3aGF0IC9kZXYvaW9hc2lkIGZp
bmFsbHkKbG9va3MgbGlrZS4KCkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
