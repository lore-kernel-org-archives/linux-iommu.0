Return-Path: <SRS0=xf59=C2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A99BC433E2
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 18:24:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0BDE2220F
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 18:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BDE2220F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6299C876E7;
	Thu, 17 Sep 2020 18:24:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NO4eCVmF+wu0; Thu, 17 Sep 2020 18:24:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 45AF8876E6;
	Thu, 17 Sep 2020 18:24:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 283BFC0864;
	Thu, 17 Sep 2020 18:24:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4082C0051
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 18:24:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C1C7D20414
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 18:24:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ABVJ+Ze6LBEe for <iommu@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 18:24:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by silver.osuosl.org (Postfix) with ESMTPS id AEB93203F9
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 18:24:09 +0000 (UTC)
IronPort-SDR: izd0PAc9GC8RbPIUGVGX/RtaoksBzioZYJKzL17RkeYfkYzkPOTc38Zx89/2UugCPs1LPw8+Ah
 QZ1v1BWaljpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="147452644"
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; d="scan'208";a="147452644"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2020 11:17:57 -0700
IronPort-SDR: lLeZ+Fj9HzGIdwJB/CGAkBh8htdhAwiJF5jEAiEwe0vmFBMC2bi6DYC5f7/W0jXsyCzaAjhco0
 LJna/xBO4xwQ==
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; d="scan'208";a="303042892"
Received: from jpan9-mobl2.amr.corp.intel.com (HELO localhost)
 ([10.212.182.111])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2020 11:17:56 -0700
Date: Thu, 17 Sep 2020 11:17:54 -0700
From: "Jacob Pan (Jun)" <jacob.jun.pan@intel.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200917111754.00006bcc@intel.com>
In-Reply-To: <69ec9537-460f-2351-fa90-c31aaeef3c4b@redhat.com>
References: <20200915113341.GW904879@nvidia.com>
 <20200915181154.GA70770@otc-nc-03>
 <20200915184510.GB1573713@nvidia.com>
 <20200915150851.76436ca1@jacob-builder>
 <20200915235126.GK1573713@nvidia.com>
 <20200915171319.00003f59@linux.intel.com>
 <20200916150754.GE6199@nvidia.com>
 <20200916163343.GA76252@otc-nc-03>
 <20200916170113.GD3699@nvidia.com>
 <20200916112110.000024ee@intel.com>
 <20200916183841.GI6199@nvidia.com>
 <20200916160901.000046ec@intel.com>
 <69ec9537-460f-2351-fa90-c31aaeef3c4b@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 "Raj, Ashok" <ashok.raj@intel.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com, yi.y.sun@intel.com,
 Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org,
 jacob.jun.pan@intel.com, Jason Gunthorpe <jgg@nvidia.com>, hao.wu@intel.com,
 jun.j.tian@intel.com
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

SGkgSmFzb24sCk9uIFRodSwgMTcgU2VwIDIwMjAgMTE6NTM6NDkgKzA4MDAsIEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+Cndyb3RlOgoKPiBPbiAyMDIwLzkvMTcg5LiK5Y2INzowOSwg
SmFjb2IgUGFuIChKdW4pIHdyb3RlOgo+ID4gSGkgSmFzb24sCj4gPiBPbiBXZWQsIDE2IFNlcCAy
MDIwIDE1OjM4OjQxIC0wMzAwLCBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPgo+ID4g
d3JvdGU6Cj4gPiAgCj4gPj4gT24gV2VkLCBTZXAgMTYsIDIwMjAgYXQgMTE6MjE6MTBBTSAtMDcw
MCwgSmFjb2IgUGFuIChKdW4pIHdyb3RlOiAgCj4gPj4+IEhpIEphc29uLAo+ID4+PiBPbiBXZWQs
IDE2IFNlcCAyMDIwIDE0OjAxOjEzIC0wMzAwLCBKYXNvbiBHdW50aG9ycGUKPiA+Pj4gPGpnZ0Bu
dmlkaWEuY29tPiB3cm90ZToKPiA+Pj4gICAgICAKPiA+Pj4+IE9uIFdlZCwgU2VwIDE2LCAyMDIw
IGF0IDA5OjMzOjQzQU0gLTA3MDAsIFJhaiwgQXNob2sgd3JvdGU6ICAKPiA+Pj4+PiBPbiBXZWQs
IFNlcCAxNiwgMjAyMCBhdCAxMjowNzo1NFBNIC0wMzAwLCBKYXNvbiBHdW50aG9ycGUKPiA+Pj4+
PiB3cm90ZTogIAo+ID4+Pj4+PiBPbiBUdWUsIFNlcCAxNSwgMjAyMCBhdCAwNToyMjoyNlBNIC0w
NzAwLCBKYWNvYiBQYW4gKEp1bikKPiA+Pj4+Pj4gd3JvdGU6ICAKPiA+Pj4+Pj4+PiBJZiB1c2Vy
IHNwYWNlIHdhbnRzIHRvIGJpbmQgcGFnZSB0YWJsZXMsIGNyZWF0ZSB0aGUgUEFTSUQKPiA+Pj4+
Pj4+PiB3aXRoIC9kZXYvc3ZhLCB1c2UgaW9jdGxzIHRoZXJlIHRvIHNldHVwIHRoZSBwYWdlIHRh
YmxlCj4gPj4+Pj4+Pj4gdGhlIHdheSBpdCB3YW50cywgdGhlbiBwYXNzIHRoZSBub3cgY29uZmln
dXJlZCBQQVNJRCB0byBhCj4gPj4+Pj4+Pj4gZHJpdmVyIHRoYXQgY2FuIHVzZSBpdC4gIAo+ID4+
Pj4+Pj4gQXJlIHdlIHRhbGtpbmcgYWJvdXQgYmFyZSBtZXRhbCBTVkE/ICAKPiA+Pj4+Pj4gV2hh
dCBhIHdlaXJkIHRlcm0uICAKPiA+Pj4+PiBHbGFkIHlvdSBub3RpY2VkIGl0IGF0IHY3IDotKQo+
ID4+Pj4+Cj4gPj4+Pj4gQW55IHN1Z2dlc3Rpb25zIG9uIHNvbWV0aGluZyBsZXNzIHdlaXJkIHRo
YW4KPiA+Pj4+PiBTaGFyZWQgVmlydHVhbCBBZGRyZXNzaW5nPyBUaGVyZSBpcyBhIHJlYXNvbiB3
aHkgd2UgbW92ZWQgZnJvbQo+ID4+Pj4+IFNWTSB0byBTVkEuICAKPiA+Pj4+IFNWQSBpcyBmaW5l
LCB3aGF0IGlzICJiYXJlIG1ldGFsIiBzdXBwb3NlZCB0byBtZWFuPwo+ID4+Pj4gICAgICAKPiA+
Pj4gV2hhdCBJIG1lYW50IGhlcmUgaXMgc2hhcmluZyB2aXJ0dWFsIGFkZHJlc3MgYmV0d2VlbiBE
TUEgYW5kIGhvc3QKPiA+Pj4gcHJvY2Vzcy4gVGhpcyByZXF1aXJlcyBkZXZpY2VzIHBlcmZvcm0g
RE1BIHJlcXVlc3Qgd2l0aCBQQVNJRCBhbmQKPiA+Pj4gdXNlIElPTU1VIGZpcnN0IGxldmVsL3N0
YWdlIDEgcGFnZSB0YWJsZXMuCj4gPj4+IFRoaXMgY2FuIGJlIGZ1cnRoZXIgZGl2aWRlZCBpbnRv
IDEpIHVzZXIgU1ZBIDIpIHN1cGVydmlzb3IgU1ZBCj4gPj4+IChzaGFyaW5nIGluaXRfbW0pCj4g
Pj4+Cj4gPj4+IE15IHBvaW50IGlzIHRoYXQgL2Rldi9zdmEgaXMgbm90IHVzZWZ1bCBoZXJlIHNp
bmNlIHRoZSBkcml2ZXIgY2FuCj4gPj4+IHBlcmZvcm0gUEFTSUQgYWxsb2NhdGlvbiB3aGlsZSBk
b2luZyBTVkEgYmluZC4gIAo+ID4+IE5vLCB5b3UgYXJlIHRoaW5raW5nIHRvbyBzbWFsbC4KPiA+
Pgo+ID4+IExvb2sgYXQgVkRQQSwgaXQgaGFzIGEgU1ZBIHVBUEkuIFNvbWUgSFcgbWlnaHQgdXNl
IFBBU0lEIGZvciB0aGUKPiA+PiBTVkEuIAo+ID4gQ291bGQgeW91IHBvaW50IHRvIG1lIHRoZSBT
VkEgVUFQST8gSSBjb3VsZG4ndCBmaW5kIGl0IGluIHRoZQo+ID4gbWFpbmxpbmUuIFNlZW1zIFZE
UEEgdXNlcyBWSE9TVCBpbnRlcmZhY2U/ICAKPiAKPiAKPiBJdCdzIHRoZSB2aG9zdF9pb3RsYl9t
c2cgZGVmaW5lZCBpbiB1YXBpL2xpbnV4L3Zob3N0X3R5cGVzLmguCj4gClRoYW5rcyBmb3IgdGhl
IHBvaW50ZXIsIGZvciBjb21wbGV0ZSB2U1ZBIGZ1bmN0aW9uYWxpdHkgd2Ugd291bGQgbmVlZAox
IFRMQiBmbHVzaCAoSU9UTEIgYW5kIFBBU0lEIGNhY2hlIGV0Yy4pCjIgUEFTSUQgYWxsb2MvZnJl
ZQozIGJpbmQvdW5iaW5kIHBhZ2UgdGFibGVzIG9yIFBBU0lEIHRhYmxlcwo0IFBhZ2UgcmVxdWVz
dCBzZXJ2aWNlCgpTZWVtcyB2aG9zdF9pb3RsYl9tc2cgY2FuIGJlIHVzZWQgZm9yICMxIHBhcnRp
YWxseS4gQW5kIHRoZQpwcm9wb3NhbCBpcyB0byBwbHVjayBvdXQgdGhlIHJlc3QgaW50byAvZGV2
L3NkYT8gU2VlbXMgYXdrd2FyZCBhcyBBbGV4CnBvaW50ZWQgb3V0IGVhcmxpZXIgZm9yIHNpbWls
YXIgc2l0dWF0aW9uIGluIFZGSU8uCgo+IAo+ID4gIAo+ID4+IFdoZW4gVkRQQSBpcyB1c2VkIGJ5
IERQREsgaXQgbWFrZXMgc2Vuc2UgdGhhdCB0aGUgUEFTSUQgd2lsbCBiZSBTVkEKPiA+PiBhbmQg
MToxIHdpdGggdGhlIG1tX3N0cnVjdC4KPiA+PiAgCj4gPiBJIHN0aWxsIGRvbid0IHNlZSB3aHkg
YmFyZSBtZXRhbCBEUERLIG5lZWRzIHRvIGdldCBhIGhhbmRsZSBvZiB0aGUKPiA+IFBBU0lELiAg
Cj4gCj4gCj4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IGl0IG1heToKPiAKPiAtIGhhdmUgYSB1
bmlmaWVkIHVBUEkgd2l0aCB2U1ZBOiBhbGxvYywgYmluZCwgdW5iaW5kLCBmcmVlCkdvdCB5b3Vy
IHBvaW50LCBidXQgdlNWQSBuZWVkcyBtb3JlIHRoYW4gdGhlc2UKCj4gLSBsZWF2ZSB0aGUgYmlu
ZGluZyBwb2xpY3kgdG8gdXNlcnNwYWNlIGluc3RlYWQgb2YgdGhlIHVzaW5nIGEKPiBpbXBsaWVk
IG9uZSBpbiB0aGUga2VucmVsCj4gCk9ubHkgaWYgbmVjZXNzYXJ5LgoKPiAKPiA+IFBlcmhhcHMg
dGhlIFNWQSBwYXRjaCB3b3VsZCBleHBsYWluLiBPciBhcmUgeW91IHRhbGtpbmcgYWJvdXQKPiA+
IHZEUEEgRFBESyBwcm9jZXNzIHRoYXQgaXMgdXNlZCB0byBzdXBwb3J0IHZpcnRpby1uZXQtcG1k
IGluIHRoZQo+ID4gZ3Vlc3Q/IAo+ID4+IFdoZW4gVkRQQSBpcyB1c2VkIGJ5IHFlbXUgaXQgbWFr
ZXMgc2Vuc2UgdGhhdCB0aGUgUEFTSUQgd2lsbCBiZSBhbgo+ID4+IGFyYml0YXJ5IElPVkEgbWFw
IGNvbnN0cnVjdGVkIHRvIGJlIDE6MSB3aXRoIHRoZSBndWVzdCB2Q1BVCj4gPj4gcGh5c2ljYWwg
bWFwLiAvZGV2L3N2YSBhbGxvd3MgYSBzaW5nbGUgdUFQSSB0byBkbyB0aGlzIGtpbmQgb2YKPiA+
PiBzZXR1cCwgYW5kIHFlbXUgY2FuIHN1cHBvcnQgaXQgd2hpbGUgc3VwcG9ydGluZyBhIHJhbmdl
IG9mIFNWQQo+ID4+IGtlcm5lbCBkcml2ZXJzLiBWRFBBIGFuZCB2ZmlvLW1kZXYgYXJlIG9idmlv
dXMgaW5pdGlhbCB0YXJnZXRzLgo+ID4+Cj4gPj4gKkJPVEgqIGFyZSBuZWVkZWQuCj4gPj4KPiA+
PiBJbiBnZW5lcmFsIGFueSB1QVBJIGZvciBQQVNJRCBzaG91bGQgaGF2ZSB0aGUgb3B0aW9uIHRv
IHVzZSBlaXRoZXIKPiA+PiB0aGUgbW1fc3RydWN0IFNWQSBQQVNJRCAqT1IqIGEgUEFTSUQgZnJv
bSAvZGV2L3N2YS4gSXQgY29zdHMKPiA+PiB2aXJ0dWFsbHkgbm90aGluZyB0byBpbXBsZW1lbnQg
dGhpcyBpbiB0aGUgZHJpdmVyIGFzIFBBU0lEIGlzIGp1c3QKPiA+PiBhIG51bWJlciwgYW5kIGdp
dmVzIHNvIG11Y2ggbW9yZSBmbGV4YWJpbGl0eS4KPiA+PiAgCj4gPiBOb3QgcmVhbGx5IG5vdGhp
bmcgaW4gdGVybXMgb2YgUEFTSUQgbGlmZSBjeWNsZXMuIEZvciBleGFtcGxlLCBpZgo+ID4gdXNl
ciB1c2VzIHVhY2NlIGludGVyZmFjZSB0byBvcGVuIGFuIGFjY2VsZXJhdG9yLCBpdCBnZXRzIGFu
Cj4gPiBGRF9hY2MuIFRoZW4gaXQgb3BlbnMgL2Rldi9zdmEgdG8gYWxsb2NhdGUgUEFTSUQgdGhl
biBnZXQgYW5vdGhlcgo+ID4gRkRfcGFzaWQuIFRoZW4gd2UgcGFzcyBGRF9wYXNpZCB0byB0aGUg
ZHJpdmVyIHRvIGJpbmQgcGFnZSB0YWJsZXMsCj4gPiBwZXJoYXBzIG11bHRpcGxlIGRyaXZlcnMu
IE5vdyB3ZSBoYXZlIHRvIHdvcnJ5IGFib3V0IElmIEZEX3Bhc2lkCj4gPiBnZXRzIGNsb3NlZCBi
ZWZvcmUgRkRfYWNjKHMpIGNsb3NlZCBhbmQgYWxsIHRoZXNlIHJhY2UgY29uZGl0aW9ucy4gIAo+
IAo+IAo+IEknbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgdGhpcy4gQnV0IHRoaXMgZGVtb25zdHJh
dGVzIHRoZSBmbGV4aWJpbGl0eQo+IG9mIGFuIHVuaWZpZWQgdUFQSS4gRS5nIGl0IGFsbG93cyB2
RFBBIGFuZCBWRklPIGRldmljZSB0byB1c2UgdGhlCj4gc2FtZSBQQUlTRCB3aGljaCBjYW4gYmUg
c2hhcmVkIHdpdGggYSBwcm9jZXNzIGluIHRoZSBndWVzdC4KPiAKVGhpcyBpcyBmb3IgdXNlciBE
TUEgbm90IGZvciB2U1ZBLiBJIHdhcyBjb250ZW5kaW5nIHRoYXQgL2Rldi9zdmEKY3JlYXRlcyB1
bm5lY2Vzc2FyeSBzdGVwcyBmb3Igc3VjaCB1c2FnZS4KCkZvciB2U1ZBLCBJIHRoaW5rIHZEUEEg
YW5kIFZGSU8gY2FuIHBvdGVudGlhbGx5IHNoYXJlIGJ1dCBJIGFtIG5vdApzZWVpbmcgY29udmlu
Y2luZyBiZW5lZml0cy4KCklmIGEgZ3Vlc3QgcHJvY2VzcyB3YW50cyB0byBkbyBTVkEgd2l0aCBh
IFZGSU8gYXNzaWduZWQgZGV2aWNlIGFuZCBhCnZEUEEtYmFja2VkIHZpcnRpby1uZXQgYXQgdGhl
IHNhbWUgdGltZSwgaXQgbWlnaHQgYmUgYSBsaW1pdGF0aW9uIGlmClBBU0lEIGlzIG5vdCBtYW5h
Z2VkIHZpYSBhIGNvbW1vbiBpbnRlcmZhY2UuIEJ1dCBJIGFtIG5vdCBzdXJlIGhvdyB2RFBBClNW
QSBzdXBwb3J0IHdpbGwgbG9vayBsaWtlLCBkb2VzIGl0IHN1cHBvcnQgZ0lPVkE/IG5lZWQgdmly
dGlvIElPTU1VPwoKPiBGb3IgdGhlIHJhY2UgY29uZGl0aW9uLCBpdCBjb3VsZCBiZSBwcm9iYWJs
eSBzb2x2ZWQgd2l0aCByZWZjbnQuCj4gCkFncmVlZCBidXQgdGhlIGJlc3Qgc29sdXRpb24gbWln
aHQgYmUgbm90IHRvIGhhdmUgdGhlIHByb2JsZW0gaW4gdGhlCmZpcnN0IHBsYWNlIDopCgo+IFRo
YW5rcwo+IAo+IAo+ID4KPiA+IElmIHdlIGRvIG5vdCBleHBvc2UgRkRfcGFzaWQgdG8gdGhlIHVz
ZXIsIHRoZSB0ZWFyZG93biBpcyBtdWNoCj4gPiBzaW1wbGVyIGFuZCBzdHJlYW1saW5lZC4gRm9s
bG93aW5nIGVhY2ggRkRfYWNjIGNsb3NlLCBQQVNJRCB1bmJpbmQKPiA+IGlzIHBlcmZvcm1lZC4g
Cj4gPj4+IFlpIGNhbiBjb3JyZWN0IG1lIGJ1dCB0aGlzIHNldCBpcyBpcyBhYm91dCBWRklPLVBD
SSwgVkZJTy1tZGV2Cj4gPj4+IHdpbGwgYmUgaW50cm9kdWNlZCBsYXRlci4gIAo+ID4+IExhc3Qg
cGF0Y2ggaXM6Cj4gPj4KPiA+PiAgICB2ZmlvL3R5cGUxOiBBZGQgdlNWQSBzdXBwb3J0IGZvciBJ
T01NVS1iYWNrZWQgbWRldnMKPiA+Pgo+ID4+IFNvIHByZXR0eSBoYXJkIHRvIHNlZSBob3cgdGhp
cyBpcyBub3QgYWJvdXQgdmZpby1tZGV2LCBhdCBsZWFzdCBhCj4gPj4gbGl0dGxlLi4KPiA+Pgo+
ID4+IEphc29uICAKPiA+Cj4gPiBUaGFua3MsCj4gPgo+ID4gSmFjb2IKPiA+ICAKPiAKCgpUaGFu
a3MsCgpKYWNvYgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
