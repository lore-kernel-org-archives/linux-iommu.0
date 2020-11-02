Return-Path: <SRS0=oYak=EI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28843C388F2
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 23:39:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A55A422268
	for <iommu@archiver.kernel.org>; Mon,  2 Nov 2020 23:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55A422268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5BBB585F09;
	Mon,  2 Nov 2020 23:39:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c1WfSbrMi_3k; Mon,  2 Nov 2020 23:39:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9FF858598A;
	Mon,  2 Nov 2020 23:39:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82AE6C0889;
	Mon,  2 Nov 2020 23:39:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CF0DDC0051
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 23:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B367687322
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 23:39:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ycZu32jXGxCS for <iommu@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 23:39:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CBA1E872FC
 for <iommu@lists.linux-foundation.org>; Mon,  2 Nov 2020 23:39:26 +0000 (UTC)
IronPort-SDR: dtPsq/qf400EqZiyeu1FSMrzuQdZ4zAqZ1aqnqZK4/fmmXFe+IXFtZgTFuK70gyVG9dhqoFkn4
 npc8r9P2jNlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="155957924"
X-IronPort-AV: E=Sophos;i="5.77,446,1596524400"; d="scan'208";a="155957924"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2020 15:39:25 -0800
IronPort-SDR: V6dSkkgktjKnDH00TCGYsOm+CRknORWWDzuIhJKnyld/or8rgSHThWBHGoGL3B6IZohXN25J+4
 d8zpFfGvYOhA==
X-IronPort-AV: E=Sophos;i="5.77,446,1596524400"; d="scan'208";a="336324618"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2020 15:39:25 -0800
Date: Mon, 2 Nov 2020 15:41:52 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v3 01/14] docs: Document IO Address Space ID (IOASID) APIs
Message-ID: <20201102154152.0e95ab98@jacob-builder>
In-Reply-To: <20201030101827.GB122147@myrica>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1601329121-36979-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20201020135809.GA1515830@myrica>
 <20201026140506.1349dbb5@jacob-builder>
 <20201030101827.GB122147@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.pan.linux@gmail.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-api@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 linux-doc@vger.kernel.org, iommu@lists.linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Dave Jiang <dave.jiang@intel.com>, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Yi Sun <yi.y.sun@intel.com>
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

SGkgSmVhbi1QaGlsaXBwZSwKCk9uIEZyaSwgMzAgT2N0IDIwMjAgMTE6MTg6MjcgKzAxMDAsIEpl
YW4tUGhpbGlwcGUgQnJ1Y2tlcgo8amVhbi1waGlsaXBwZUBsaW5hcm8ub3JnPiB3cm90ZToKCj4g
T24gTW9uLCBPY3QgMjYsIDIwMjAgYXQgMDI6MDU6MDZQTSAtMDcwMCwgSmFjb2IgUGFuIHdyb3Rl
Ogo+ID4gPiBUaGlzIGxvb2tzIGdvb2QgdG8gbWUsIHdpdGggc21hbGwgY29tbWVudHMgYmVsb3cu
Cj4gPiA+ICAgCj4gPiBDYW4gSSBhZGQgeW91ciBSZXZpZXdlZC1ieSB0YWcgYWZ0ZXIgYWRkcmVz
c2luZyB0aGUgY29tbWVudHM/ICAKPiAKPiBZZXMgc3VyZSwgdGhpcyB0b29rIGZvcmV2ZXIgdG8g
cmV2aWV3IHNvIEknbSBoYXBweSBub3QgdG8gZG8gYW5vdGhlcgo+IHBhc3MgOikKPiAKSSBhbSBh
ZnJhaWQgSSBoYXZlIHRvIGFzayBmb3IgYW5vdGhlciByb3VuZCBvZiByZXZpZXdzIHNpbmNlIGl0
IHdhcwpzdWdnZXN0ZWQgdG8ga2VlcCBJT0FTSUQgYWxsb2NhdGlvbiBpbnRlcmZhY2UgaW5kZXBl
bmRlbnQsIGluc3RlYWQgb2YgYmVpbmcKcGFydCBvZiBWRklPIFVBUEkuIFlpIGFuZCBJIGFyZSB3
b3JraW5nIG91dCB0aGUgZGV0YWlscyB0byBjb21lIHVwIHdpdGggYQpQb0MuIEFzIHlvdSBtaWdo
dCBiZSBhd2FyZSwgdGhlIG5lZWQgZm9yIHRoaXMgaW5kZXBlbmRlbnQgaW50ZXJmYWNlIGlzIHRo
YXQKd2UgbWF5IGhhdmUgbXVsdGlwbGUgdXNlcnMgb2YgUEFTSUQsIGUuZyBWRFBBLCB1c2VyIHNw
YWNlIGRyaXZlcnMsIGV0Yy4KVGhlIElPQVNJRCB1c2VyIGludGVyZmFjZSBhbHNvIGhhcyBzbGln
aHQgaW1wYWN0IG9uIHRoZSBJT0FTSUQgY29yZSBjb2RlLAp3aGljaCBpcyB3aHkgSSBhbSBzbG93
IGluIHJlc3BvbnNlIHRvIHlvdXIgY29kZSByZXZpZXcuIFdpbGwgaW5jb3Jwb3JhdGUKeW91ciBy
ZXZpZXcgaW4gdGhlIG5leHQgcm91bmQgd2l0aCBzdXBwb3J0IG9mIGluZGVwZW5kZW50IHVzZXIg
QVBJLgpNdWNoIGFwcHJlY2lhdGVkIQoKPiAKPiA+ID4gPiArRWFjaCBJT0FTSUQgc2V0IGlzIGNy
ZWF0ZWQgd2l0aCBhIHRva2VuLCB3aGljaCBjYW4gYmUgb25lIG9mIHRoZQo+ID4gPiA+ICtmb2xs
b3dpbmcgdG9rZW4gdHlwZXM6Cj4gPiA+ID4gKwo+ID4gPiA+ICsgLSBJT0FTSURfU0VUX1RZUEVf
TlVMTCAoQXJiaXRyYXJ5IHU2NCB2YWx1ZSkgICAgCj4gPiA+IAo+ID4gPiBNYXliZSBOVUxMIGlz
bid0IHRoZSBiZXN0IG5hbWUgdGhlbi4gTk9ORT8KPiA+ID4gICAKPiA+IEFncmVlZCwgJ05PTkUn
IG1ha2VzIG1vcmUgc2Vuc2UuICAKPiAKPiBBbHRob3VnaCBwYXRjaCA1IG9ubHkgYWxsb3dzIGEg
TlVMTCB0b2tlbiBmb3IgdGhpcyB0eXBlLiBTbyB0aGUgbmFtZSBzZWVtcwo+IGZpbmUsIHlvdSBj
b3VsZCBqdXN0IGZpeCB0aGlzIGRlc2NyaXB0aW9uLgo+IApPSy4KCj4gCj4gPiA+ID4gK0lPQVNJ
RCBjb3JlIGhhcyB0aGUgbm90aW9uIG9mICJjdXN0b20gYWxsb2NhdG9yIiBzdWNoIHRoYXQgZ3Vl
c3QKPiA+ID4gPiBjYW4gK3JlZ2lzdGVyIHZpcnR1YWwgY29tbWFuZCBhbGxvY2F0b3IgdGhhdCBw
cmVjZWRlcyB0aGUgZGVmYXVsdAo+ID4gPiA+IG9uZS4gICAgCj4gPiA+IAo+ID4gPiAiU3VwZXJz
ZWRlcyIsIHJhdGhlciB0aGFuICJwcmVjZWRlcyI/Cj4gPiA+ICAgCj4gPiBNeSB1bmRlcnN0YW5k
aW5nIGlzIHRoYXQgJ3N1cGVyc2VkZScgbWVhbnMgcmVwbGFjZSBzb21ldGhpbmcgYnV0Cj4gPiAn
cHJlY2VkZScgbWVhbnMgZ2V0IGluIGZyb250IG9mIHNvbWV0aGluZy4gSSBkbyB3YW50IHRvIGVt
cGhhc2lzIHRoYXQKPiA+IHRoZSBjdXN0b20gYWxsb2NhdG9yIHRha2VzIHByZWNlZGVuY2Ugb3Zl
ciB0aGUgZGVmYXVsdCBhbGxvY2F0b3IuICAKPiAKPiBSaWdodCBpdCdzIGFtYmlndW91cy4gVGhl
IGN1c3RvbSBhbGxvY2F0b3IgZG9lcyBlbnRpcmVseSByZXBsYWNlIHRoZQo+IGFsbG9jYXRpb24g
YWN0aW9uLCBidXQgdGhlIGRlZmF1bHQgb25lIGlzIHN0aWxsIHVzZWQgZm9yIHN0b3JhZ2UuIEFu
eXdheSwKPiB5b3UgY2FuIGxlYXZlIHRoaXMuCj4gCk9LCgo+IAo+ID4gPiA+ICtMZXQncyBleGFt
aW5lIHRoZSBJT0FTSUQgbGlmZSBjeWNsZSBhZ2FpbiB3aGVuIGZyZWUgaGFwcGVucwo+ID4gPiA+
ICpiZWZvcmUqICt1bmJpbmQuIFRoaXMgY291bGQgYmUgYSByZXN1bHQgb2YgbWlzYmVoYXZpbmcg
Z3Vlc3RzIG9yCj4gPiA+ID4gY3Jhc2guIEFzc3VtaW5nICtWRklPIGNhbm5vdCBlbmZvcmNlIHVu
YmluZC0+ZnJlZSBvcmRlci4gTm90aWNlCj4gPiA+ID4gdGhhdCB0aGUgc2V0dXAgcGFydCB1cCAr
dW50aWwgc3RlcCAjMTIgaXMgaWRlbnRpY2FsIHRvIHRoZSBub3JtYWwKPiA+ID4gPiBjYXNlLCB0
aGUgZmxvdyBiZWxvdyBzdGFydHMgK3dpdGggc3RlcCAxMy4KPiA+ID4gPiArCj4gPiA+ID4gKzo6
Cj4gPiA+ID4gKwo+ID4gPiA+ICsgICAgIFZGSU8gICAgICAgIElPTU1VICAgICAgICBLVk0gICAg
ICAgIFZEQ00gICAgICAgIElPQVNJRAo+ID4gPiA+IFJlZgo+ID4gPiA+ICsgICAuLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4K
PiA+ID4gPiArICAgMTMgLS0tLS0tLS0gR1VFU1QgU1RBUlRTIERNQSAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQo+ID4gPiA+ICsgICAxNCAtLS0tLS0tLSAqR1VFU1QgTUlTQkVIQVZFUyEhISog
LS0tLS0tLS0tLS0tLS0tLQo+ID4gPiA+ICsgICAxNSBpb2FzaWRfZnJlZSgpCj4gPiA+ID4gKyAg
IDE2Cj4gPiA+ID4gaW9hc2lkX25vdGlmeShGUkVFKQo+ID4gPiA+ICsgICAxNyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hcmtfZnJlZV9wZW5kaW5nCj4gPiA+
ID4gKDEpICAgIAo+ID4gPiAKPiA+ID4gQ291bGQgd2UgdXNlIHN1cGVyc2NyaXB0IMK5wrLCs+KB
tCBmb3IgZm9vdG5vdGVzPyBUaGVzZSBsb29rIGxpa2UgZnVuY3Rpb24KPiA+ID4gcGFyYW1ldGVy
cwo+ID4gPiAgIAo+ID4geWVzLCBtdWNoIGJldHRlcgo+ID4gICAKPiA+ID4gPiArICAgMTggICAg
ICAgICAgICAgICAgICAgICAgICAgIGt2bV9uYl9oYW5kbGVyKEZSRUUpCj4gPiA+ID4gKyAgIDE5
ICAgICAgICAgICAgICAgICAgICAgICAgICB2bWNzX3VwZGF0ZV9hdG9taWMoKQo+ID4gPiA+ICsg
ICAyMCAgICAgICAgICAgICAgICAgICAgICAgICAgaW9hc2lkX3B1dF9sb2NrZWQoKSAgIC0+ICAg
ICAgICAgICAzCj4gPiA+ID4gKyAgIDIxICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB2ZGNtX25iX2hhbmRsZXIoRlJFRSkKPiA+ID4gPiArICAgMjIgICAgICAgICAgICBpb21tX25i
X2hhbmRsZXIoRlJFRSkgICAgCj4gPiA+IAo+ID4gPiBpb21tdV9uYl9oYW5kbGVyCj4gPiA+ICAg
Cj4gPiBnb3QgaXQKPiA+ICAgCj4gPiA+ID4gKyAgIDIzIGlvYXNpZF9mcmVlKCkgcmV0dXJucygy
KSAgICAgICAgICBzY2hlZHVsZV93b3JrKCkKPiA+ID4gPiAyICAgIAo+ID4gPiAKPiA+ID4gSSBj
b21wbGV0ZWx5IGxvc3QgdHJhY2sgaGVyZSwgY291bGRuJ3QgZmlndXJlIG91dCBpbiB3aGljaCBk
aXJlY3Rpb24KPiA+ID4gdG8gcmVhZCB0aGUgZGlhZ3JhbS4gV2hhdCB3b3JrIGlzIHNjaGVkdWxl
ZD8gIAo+ID4gVGhlIHRpbWUgbGluZSBnb2VzIGRvd253YXJkIGJ1dCB3ZSBvbmx5IGNvbnRyb2wg
dGhlIG5vdGlmaWNhdGlvbiBvcmRlcgo+ID4gaW4gdGVybXMgb2Ygd2hlbiB0aGUgZXZlbnRzIGFy
ZSByZWNlaXZlZC4gU29tZSBjb21wbGV0aW9ucyBhcmUgYXN5bmMKPiA+IHRodXMgb3V0IG9mIG9y
ZGVyIGRvbmUgYnkgd29yayBpdGVtcy4gVGhlIG9ubHkgaW4tb3JkZXIgY29tcGxldGlvbiBpcwo+
ID4gdGhlIEtWTSB1cGRhdGUgb2YgaXRzIFBBU0lEIHRyYW5zbGF0aW9uIHRhYmxlLgo+ID4gCj4g
PiBBZnRlciAjMjMsIHRoZSBhc3luYyB3b3JrcyBhcmUgc2NoZWR1bGVkIHRvIGNvbXBsZXRlIGNs
ZWFuIHVwIHdvcmsKPiA+IG91dHNpZGUgdGhlIHNwaW5sb2NrKGhlbGQgYnkgdGhlIGNhbGxlciBv
ZiB0aGUgYXRvbWljIG5vdGlmaWVyKS4KPiA+IAo+ID4gQW55IHN1Z2dlc3Rpb25zIHRvIGltcHJv
dmUgdGhlIHJlYWRhYmlsaXR5IG9mIHRoZSB0aW1lIGxpbmU/ICAKPiAKPiBNYXliZSBleHBsYWlu
IHdoYXQgaGFwcGVucyBmcm9tIGxpbmUgMjM6IGlvYXNpZF9mcmVlKCkgc2NoZWR1bGVzLi4uIGEg
RlJFRQo+IG5vdGlmaWNhdGlvbj8gV2hpY2ggaGFwcGVucyBvbiBsaW5lIDI0IChjb3JyZXNwb25k
aW5nIHRvIHRoZSBzZWNvbmQKPiBzY2hlZHVsZV93b3JrKCk/KSBhbmQgaXMgaGFuZGxlZCBieSAo
YSkgVkRDTSB0byBjbGVhciB0aGUgZGV2aWNlIGNvbnRleHQKPiBhbmQgKGIpIElPTU1VIHRvIGNs
ZWFyIHRoZSBQQVNJRCBjb250ZXh0LCBib3RoIGVuZGluZyB1cCBkcm9wcGluZyB0aGVpcgo+IHJl
Zi4KPiAKR290IGl0LCBJIHdpbGwgYWRkIHRoYXQuCgo+ID4gICAKPiA+ID4gV2h5IGRvZXMgdGhl
IElPTU1VIGRyaXZlciBkcm9wCj4gPiA+IGl0cyByZWZlcmVuY2UgdG8gdGhlIElPQVNJRCBiZWZv
cmUgdW5iZGluZF9ncGFzaWQoKT8KPiA+ID4gICAKPiA+IFRoaXMgaXMgdGhlIGV4Y2VwdGlvbiBj
YXNlIHdoZXJlIHVzZXJzcGFjZSBpc3N1ZXMgSU9BU0lEIGZyZWUgYmVmb3JlCj4gPiB1bmJpbmRf
Z3Bhc2lkKCkuIFRoZSBlcXVpdmFsZW50IG9mIHVuYmluZCBpcyBwZXJmb3JtZWQgaW4gdGhlCj4g
PiBJT0FTSURfRlJFRSBub3RpZmljYXRpb24gaGFuZGxlci4gSW4gSU9BU0lEX0ZSRUUgaGFuZGxl
ciwgcmVmZXJlbmNlIGlzCj4gPiBkcm9wcGVkIGFuZCBwcml2YXRlIGRhdGEgZGVsZXRlZC4gQWZ0
ZXIgdGhhdCwgaWYgdW5iaW5kIGNvbWVzIHRvIElPTU1VCj4gPiBkcml2ZXIsIGl0IHdpbGwgbm90
IGZpbmQgSU9BU0lEIHByaXZhdGUgZGF0YSB0aGVyZWZvcmUganVzdCByZXR1cm4uICAKPiAKPiBS
aWdodCBvay4gQXMgeW91IG5vdGVkIGJlbG93IHRoZSBkYW1hZ2UgaXMgY2F1c2VkIGJ5IGFuZCBs
aW1pdGVkIHRvIHRoZQo+IGd1ZXN0LCBzbyBJIHRoaW5rIGl0J3MgZmluZS4KPiAKT0suCgo+ID4g
ICAKPiA+ID4gPiArICAgMjQgICAgICAgICAgICBzY2hlZHVsZV93b3JrKCkgICAgICAgIHZkZXZf
Y2xlYXJfd2soaHBhc2lkKQo+ID4gPiA+ICsgICAyNSAgICAgICAgICAgIHRlYXJkb3duX3Bhc2lk
X3drKCkKPiA+ID4gPiArICAgMjYgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlv
YXNpZF9wdXQoKSAtPiAgICAgICAgICAgMQo+ID4gPiA+ICsgICAyNyAgICAgICAgICAgIGlvYXNp
ZF9wdXQoKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwCj4gPiA+ID4gKyAg
IDI4ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJlY2xh
aW1lZAo+ID4gPiA+ICsgICAyOSB1bmJpbmRfZ3Bhc2lkKCkKPiA+ID4gPiArICAgMzAgICAgICAg
ICAgICBpb21tdV91bmJpbmQoKS0+aW9hc2lkX2ZpbmQoKSBGYWlscygzKQo+ID4gPiA+ICsgICAt
LS0tLS0tLS0tLS0tLSBOZXcgTGlmZSBDeWNsZSBCZWdpbiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCj4gPiA+ID4gKwo+ID4gPiA+ICtOb3RlOgo+ID4gPiA+ICsKPiA+ID4gPiArMS4gQnkg
bWFya2luZyBJT0FTSUQgRlJFRV9QRU5ESU5HIGF0IHN0ZXAgIzE3LCBubyBuZXcgcmVmZXJlbmNl
cwo+ID4gPiA+IGNhbiBiZQo+ID4gPiA+ICsgICBoZWxkLiBpb2FzaWRfZ2V0L2ZpbmQoKSB3aWxs
IHJldHVybiAtRU5PRU5UOyAgICAKPiA+ID4gCj4gPiA+IHMvaGVsZC90YWtlbgo+ID4gPiAgIAo+
ID4gR290IGl0Lgo+ID4gICAKPiA+ID4gVGhhbmtzLAo+ID4gPiBKZWFuCj4gPiA+ICAgCj4gPiA+
ID4gKzIuIEFmdGVyIHN0ZXAgIzIzLCBhbGwgZXZlbnRzIGNhbiBnbyBvdXQgb2Ygb3JkZXIuIFNo
YWxsIG5vdCBhZmZlY3QKPiA+ID4gPiArICAgdGhlIG91dGNvbWUuCj4gPiA+ID4gKzMuIElPTU1V
IGRyaXZlciBmYWlscyB0byBmaW5kIHByaXZhdGUgZGF0YSBmb3IgdW5iaW5kaW5nLiBJZgo+ID4g
PiA+IHVuYmluZCBpcwo+ID4gPiA+ICsgICBjYWxsZWQgYWZ0ZXIgdGhlIHNhbWUgSU9BU0lEIGlz
IGFsbG9jYXRlZCBmb3IgdGhlIHNhbWUgZ3Vlc3QKPiA+ID4gPiBhZ2FpbiwKPiA+ID4gPiArICAg
dGhpcyBpcyBhIHByb2dyYW1taW5nIGVycm9yLiBUaGUgZGFtYWdlIGlzIGxpbWl0ZWQgdG8gdGhl
IGd1ZXN0Cj4gPiA+ID4gKyAgIGl0c2VsZiBzaW5jZSB1bmJpbmQgcGVyZm9ybXMgcGVybWlzc2lv
biBjaGVja2luZyBiYXNlZCBvbiB0aGUKPiA+ID4gPiArICAgSU9BU0lEIHNldCBhc3NvY2lhdGVk
IHdpdGggdGhlIGd1ZXN0IHByb2Nlc3MuICAKPiAKPiAiZ3Vlc3QgcHJvY2VzcyIgY2FuIGJlIGNv
bmZ1c2luZyAocHJvY2VzcyBydW4gYnkgdGhlIGd1ZXN0PyksIGp1c3QgImd1ZXN0Igo+IG1pZ2h0
IGJlIGJldHRlci4KPiAKPiBUaGFua3MsCj4gSmVhbgoKClRoYW5rcywKCkphY29iCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
