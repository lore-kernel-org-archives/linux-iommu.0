Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDF7C47080
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 03:33:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2174861287
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 03:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2174861287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E12F74044D;
	Tue,  1 Jun 2021 03:33:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jW3MdoL4fpC6; Tue,  1 Jun 2021 03:33:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3DF684044C;
	Tue,  1 Jun 2021 03:33:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 155E2C000D;
	Tue,  1 Jun 2021 03:33:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D066EC0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 03:33:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AED0B608CD
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 03:33:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RShmo9jk-kT3 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 03:33:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD559608AB
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 03:33:27 +0000 (UTC)
IronPort-SDR: Wx3Hff40XXoFxNUL2BofQXaUU7vvPsxG+9hCNiFcdc5qVvCQ3FlXZGS1Z6M11XQl1HZbSgPX5F
 UqbugjGFiuZw==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="183823509"
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; d="scan'208";a="183823509"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2021 20:33:26 -0700
IronPort-SDR: hWv9gZ/v1Rg/j6rwSPAEfgndJxtn8+EjJ3Cy1+em23/J9XgeBux0ZyqUv2KJ1s8JdVzfMrqObA
 cwsk4YhUwooA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; d="scan'208";a="437890972"
Received: from yiliu-dev.bj.intel.com (HELO yiliu-dev) ([10.238.156.135])
 by orsmga007.jf.intel.com with ESMTP; 31 May 2021 20:33:23 -0700
Date: Tue, 1 Jun 2021 11:31:52 +0800
From: Liu Yi L <yi.l.liu@linux.intel.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210601113152.6d09e47b@yiliu-dev>
In-Reply-To: <78ee2638-1a03-fcc8-50a5-81040f677e69@redhat.com>
References: <MWHPR11MB1886422D4839B372C6AB245F8C239@MWHPR11MB1886.namprd11.prod.outlook.com>
 <f510f916-e91c-236d-e938-513a5992d3b5@redhat.com>
 <20210531164118.265789ee@yiliu-dev>
 <78ee2638-1a03-fcc8-50a5-81040f677e69@redhat.com>
Organization: IAGS/SSE(OTC)
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "Alex Williamson (alex.williamson@redhat.com)\"\"
 <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>"@osuosl.org,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, David Woodhouse <dwmw2@infradead.org>
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

T24gVHVlLCAxIEp1biAyMDIxIDEwOjM2OjM2ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgoKPiDl
nKggMjAyMS81LzMxIOS4i+WNiDQ6NDEsIExpdSBZaSBMIOWGmemBkzoKPiA+PiBJIGd1ZXNzIFZG
SU9fQVRUQUNIX0lPQVNJRCB3aWxsIGZhaWwgaWYgdGhlIHVuZGVybGF5ZXIgZG9lc24ndCBzdXBw
b3J0Cj4gPj4gaGFyZHdhcmUgbmVzdGluZy4gT3IgaXMgdGhlcmUgd2F5IHRvIGRldGVjdCB0aGUg
Y2FwYWJpbGl0eSBiZWZvcmU/ICAKPiA+IEkgdGhpbmsgaXQgY291bGQgZmFpbCBpbiB0aGUgSU9B
U0lEX0NSRUFURV9ORVNUSU5HLiBJZiB0aGUgZ3BhX2lvYXNpZAo+ID4gaXMgbm90IGFibGUgdG8g
c3VwcG9ydCBuZXN0aW5nLCB0aGVuIHNob3VsZCBmYWlsIGl0Lgo+ID4gIAo+ID4+IEkgdGhpbmsg
R0VUX0lORk8gb25seSB3b3JrcyBhZnRlciB0aGUgQVRUQUNILiAgCj4gPiB5ZXMuIEFmdGVyIGF0
dGFjaGluZyB0byBncGFfaW9hc2lkLCB1c2Vyc3BhY2UgY291bGQgR0VUX0lORk8gb24gdGhlCj4g
PiBncGFfaW9hc2lkIGFuZCBjaGVjayBpZiBuZXN0aW5nIGlzIHN1cHBvcnRlZCBvciBub3QuIHJp
Z2h0PyAgCj4gCj4gCj4gU29tZSBtb3JlIHF1ZXN0aW9uczoKPiAKPiAxKSBJcyB0aGUgaGFuZGxl
IHJldHVybmVkIGJ5IElPQVNJRF9BTExPQyBhbiBmZD8KCml0J3MgYW4gSUQgc28gZmFyIGluIHRo
aXMgcHJvcG9zYWwuCgo+IDIpIElmIHllcywgd2hhdCdzIHRoZSByZWFzb24gZm9yIG5vdCBzaW1w
bHkgdXNlIHRoZSBmZCBvcGVuZWQgZnJvbSAKPiAvZGV2L2lvYXMuIChUaGlzIGlzIHRoZSBxdWVz
dGlvbiB0aGF0IGlzIG5vdCBhbnN3ZXJlZCkgYW5kIHdoYXQgaGFwcGVucyAKPiBpZiB3ZSBjYWxs
IEdFVF9JTkZPIGZvciB0aGUgaW9hc2lkX2ZkPwo+IDMpIElmIG5vdCwgaG93IEdFVF9JTkZPIHdv
cms/CgpvaCwgbWlzc2VkIHRoaXMgcXVlc3Rpb24gaW4gcHJpb3IgcmVwbHkuIFBlcnNvbmFsbHks
IG5vIHNwZWNpYWwgcmVhc29uCnlldC4gQnV0IHVzaW5nIElEIG1heSBnaXZlIHVzIG9wcG9ydHVu
aXR5IHRvIGN1c3RvbWl6ZSB0aGUgbWFuYWdlbWVudApvZiB0aGUgaGFuZGxlLiBGb3Igb25lLCBi
ZXR0ZXIgbG9va3VwIGVmZmljaWVuY3kgYnkgdXNpbmcgeGFycmF5IHRvCnN0b3JlIHRoZSBhbGxv
Y2F0ZWQgSURzLiBGb3IgdHdvLCBjb3VsZCBjYXRlZ29yaXplIHRoZSBhbGxvY2F0ZWQgSURzCihw
YXJlbnQgb3IgbmVzdGVkKS4gR0VUX0lORk8ganVzdCB3b3JrcyB3aXRoIGFuIGlucHV0IEZEIGFu
ZCBhbiBJRC4KCj4gCj4gPiAgCj4gPj4+IAkvKiBCaW5kIGd1ZXN0IEkvTyBwYWdlIHRhYmxlICAq
Lwo+ID4+PiAJYmluZF9kYXRhID0gewo+ID4+PiAJCS5pb2FzaWQJPSBnaW92YV9pb2FzaWQ7Cj4g
Pj4+IAkJLmFkZHIJPSBnaW92YV9wZ3RhYmxlOwo+ID4+PiAJCS8vIGFuZCBmb3JtYXQgaW5mb3Jt
YXRpb24KPiA+Pj4gCX07Cj4gPj4+IAlpb2N0bChpb2FzaWRfZmQsIElPQVNJRF9CSU5EX1BHVEFC
TEUsICZiaW5kX2RhdGEpOwo+ID4+Pgo+ID4+PiAJLyogSW52YWxpZGF0ZSBJT1RMQiB3aGVuIHJl
cXVpcmVkICovCj4gPj4+IAlpbnZfZGF0YSA9IHsKPiA+Pj4gCQkuaW9hc2lkCT0gZ2lvdmFfaW9h
c2lkOwo+ID4+PiAJCS8vIGdyYW51bGFyIGluZm9ybWF0aW9uCj4gPj4+IAl9Owo+ID4+PiAJaW9j
dGwoaW9hc2lkX2ZkLCBJT0FTSURfSU5WQUxJREFURV9DQUNIRSwgJmludl9kYXRhKTsKPiA+Pj4K
PiA+Pj4gCS8qIFNlZSA1LjYgZm9yIEkvTyBwYWdlIGZhdWx0IGhhbmRsaW5nICovCj4gPj4+IAkK
PiA+Pj4gNS41LiBHdWVzdCBTVkEgKHZTVkEpCj4gPj4+ICsrKysrKysrKysrKysrKysrKwo+ID4+
Pgo+ID4+PiBBZnRlciBib290cyB0aGUgZ3Vlc3QgZnVydGhlciBjcmVhdGUgYSBHVkEgYWRkcmVz
cyBzcGFjZXMgKGdwYXNpZDEpIG9uCj4gPj4+IGRldjEuIERldjIgaXMgbm90IGFmZmVjdGVkIChz
dGlsbCBhdHRhY2hlZCB0byBnaW92YV9pb2FzaWQpLgo+ID4+Pgo+ID4+PiBBcyBleHBsYWluZWQg
aW4gc2VjdGlvbiA0LCB1c2VyIHNob3VsZCBhdm9pZCBleHBvc2UgRU5RQ01EIG9uIGJvdGgKPiA+
Pj4gcGRldiBhbmQgbWRldi4KPiA+Pj4KPiA+Pj4gVGhlIHNlcXVlbmNlIGFwcGxpZXMgdG8gYWxs
IGRldmljZSB0eXBlcyAoYmVpbmcgcGRldiBvciBtZGV2KSwgZXhjZXB0Cj4gPj4+IG9uZSBhZGRp
dGlvbmFsIHN0ZXAgdG8gY2FsbCBLVk0gZm9yIEVOUUNNRC1jYXBhYmxlIG1kZXY6ICAKPiA+PiBN
eSB1bmRlcnN0YW5kaW5nIGlzIEVOUUNNRCBpcyBJbnRlbCBzcGVjaWZpYyBhbmQgbm90IGEgcmVx
dWlyZW1lbnQgZm9yCj4gPj4gaGF2aW5nIHZTVkEuICAKPiA+IEVOUUNNRCBpcyBub3QgcmVhbGx5
IEludGVsIHNwZWNpZmljIGFsdGhvdWdoIG9ubHkgSW50ZWwgc3VwcG9ydHMgaXQgdG9kYXkuCj4g
PiBUaGUgUENJZSBETVdyIGNhcGFiaWxpdHkgaXMgdGhlIGNhcGFiaWxpdHkgZm9yIHNvZnR3YXJl
IHRvIGVudW1lcmF0ZSB0aGUKPiA+IEVOUUNNRCBzdXBwb3J0IGluIGRldmljZSBzaWRlLiB5ZXMs
IGl0IGlzIG5vdCBhIHJlcXVpcmVtZW50IGZvciB2U1ZBLiBUaGV5Cj4gPiBhcmUgb3J0aG9nb25h
bC4gIAo+IAo+IAo+IFJpZ2h0LCB0aGVuIGl0J3MgYmV0dGVyIHRvIG1lbnRpb24gRE1XciBpbnN0
ZWFkIG9mIGEgdmVuZG9yIHNwZWNpZmljIAo+IGluc3RydWN0aW9uIGluIGEgZ2VuZXJhbCBmcmFt
ZXdvcmsgbGlrZSBpb2FzaWQuCgpnb29kIHN1Z2dlc3Rpb24uIDopCgotLSAKUmVnYXJkcywKWWkg
TGl1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
