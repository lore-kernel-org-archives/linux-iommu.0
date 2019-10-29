Return-Path: <SRS0=m6Z5=YW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FE9CA9EC4
	for <iommu@archiver.kernel.org>; Tue, 29 Oct 2019 19:20:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B1620862
	for <iommu@archiver.kernel.org>; Tue, 29 Oct 2019 19:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B1620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 39BAEC91;
	Tue, 29 Oct 2019 19:20:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5983C9CA
	for <iommu@lists.linux-foundation.org>;
	Tue, 29 Oct 2019 19:20:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2CE798A
	for <iommu@lists.linux-foundation.org>;
	Tue, 29 Oct 2019 19:20:54 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	29 Oct 2019 12:20:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,245,1569308400"; d="scan'208";a="401258365"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by fmsmga006.fm.intel.com with ESMTP; 29 Oct 2019 12:20:53 -0700
Date: Tue, 29 Oct 2019 12:25:17 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v7 11/11] iommu/vt-d: Add svm/sva invalidate function
Message-ID: <20191029122517.3d4876c7@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D5DF155@SHSMSX104.ccr.corp.intel.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1571946904-86776-12-git-send-email-jacob.jun.pan@linux.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D5CDE06@SHSMSX104.ccr.corp.intel.com>
	<5e9d2372-a8b5-9a26-1438-c1a608bfad6d@linux.intel.com>
	<d0375121-7893-bb06-45f3-209a0cff12de@linux.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D5DB7D9@SHSMSX104.ccr.corp.intel.com>
	<20191028091049.04f2d83f@jacob-builder>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D5DF155@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

T24gVHVlLCAyOSBPY3QgMjAxOSAxODo1MjowMSArMDAwMAoiVGlhbiwgS2V2aW4iIDxrZXZpbi50
aWFuQGludGVsLmNvbT4gd3JvdGU6Cgo+ID4gRnJvbTogSmFjb2IgUGFuIFttYWlsdG86amFjb2Iu
anVuLnBhbkBsaW51eC5pbnRlbC5jb21dCj4gPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDI5LCAy
MDE5IDEyOjExIEFNCj4gPiAKPiA+IE9uIE1vbiwgMjggT2N0IDIwMTkgMDY6MDY6MzMgKzAwMDAK
PiA+ICJUaWFuLCBLZXZpbiIgPGtldmluLnRpYW5AaW50ZWwuY29tPiB3cm90ZToKPiA+ICAgCj4g
PiA+ID4gPj4+ICvCoMKgwqAgLyogUEFTSUQgYmFzZWQgZGV2IFRMQnMsIG9ubHkgc3VwcG9ydCBh
bGwgUEFTSURzIG9yCj4gPiA+ID4gPj4+IHNpbmdsZSBQQVNJRCAqLwo+ID4gPiA+ID4+PiArwqDC
oMKgIHsxLCAxLCAwfSwgIAo+ID4gPiA+ID4+Cj4gPiA+ID4gPj4gSSBmb3Jnb3QgcHJldmlvdXMg
ZGlzY3Vzc2lvbi4gaXMgaXQgbmVjZXNzYXJ5IHRvIHBhc3MgZG93bgo+ID4gPiA+ID4+IGRldiBU
TEIgaW52YWxpZGF0aW9uCj4gPiA+ID4gPj4gcmVxdWVzdHM/IENhbiBpdCBiZSBoYW5kbGVkIGJ5
IGhvc3QgaU9NTVUgZHJpdmVyCj4gPiA+ID4gPj4gYXV0b21hdGljYWxseT8gIAo+ID4gPiA+ID4K
PiA+ID4gPiA+IE9uIGhvc3QgU1ZBLCB3aGVuIGEgbWVtb3J5IGlzIHVubWFwcGVkLCBkcml2ZXIg
Y2FsbGJhY2sgd2lsbAo+ID4gPiA+ID4gaW52YWxpZGF0ZSBkZXYgSU9UTEIgZXhwbGljaXRseS4g
U28gSSBndWVzcyB3ZSBuZWVkIHRvIHBhc3MKPiA+ID4gPiA+IGRvd24gaXQgZm9yIGd1ZXN0IGNh
c2UuIFRoaXMgaXMgYWxzbyByZXF1aXJlZCBmb3IgZ3Vlc3QgaW92YQo+ID4gPiA+ID4gb3ZlciAx
c3QgbGV2ZWwgdXNhZ2UgYXMgZmFyIGFzIGNhbiBzZWUuCj4gPiA+ID4gPiAgCj4gPiA+ID4KPiA+
ID4gPiBTb3JyeSwgSSBjb25mdXNlZCBndWVzdCB2SU9WQSBhbmQgZ3Vlc3QgdlNWQS4gRm9yIGd1
ZXN0IHZJT1ZBLAo+ID4gPiA+IG5vIGRldmljZSBUTEIgaW52YWxpZGF0aW9uIHBhc3MgZG93bi4g
QnV0IGN1cnJlbnRseSBmb3IgZ3Vlc3QKPiA+ID4gPiB2U1ZBLCBkZXZpY2UgVExCIGludmFsaWRh
dGlvbiBpcyBwYXNzZWQgZG93bi4gUGVyaGFwcyB3ZSBjYW4KPiA+ID4gPiBhdm9pZCBwYXNzaW5n
IGRvd24gZGV2IFRMQiBmbHVzaCBqdXN0IGxpa2Ugd2hhdCB3ZSBhcmUgZG9pbmcKPiA+ID4gPiBm
b3IgZ3Vlc3QgSU9WQS4gIAo+ID4gPgo+ID4gPiBJIHRoaW5rIGRldiBUTEIgaXMgZnVsbHkgaGFu
ZGxlZCB3aXRoaW4gSU9NTVUgZHJpdmVyIHRvZGF5LiBJdAo+ID4gPiBkb2Vzbid0IHJlcXVpcmUg
ZGV2aWNlIGRyaXZlciB0byBleHBsaWNpdCB0b2dnbGUuIFdpdGggdGhpcyB0aGVuCj4gPiA+IHdl
IGNhbiBmdWxseSB2aXJ0dWFsaXplIGd1ZXN0IGRldiBUTEIgaW52YWxpZGF0aW9uIHJlcXVlc3Qg
dG8KPiA+ID4gc2F2ZSBvbmUgc3lzY2FsbCwgc2luY2UgdGhlIGhvc3QgaXMgc3VwcG9zZWQgdG8g
Zmx1c2ggZGV2IFRMQgo+ID4gPiB3aGVuIHNlcnZpbmcgdGhlIGVhcmxpZXIgSU9UTEIgaW52YWxp
ZGF0aW9uIHBhc3MtZG93bi4gIAo+ID4gCj4gPiBJbiB0aGUgcHJldmlvdXMgZGlzY3Vzc2lvbnMs
IHdlIHRob3VnaHQgYWJvdXQgbWFraW5nIElPVExCIGZsdXNoCj4gPiBpbmNsdXNpdmUsIHdoZXJl
IElPVExCIGZsdXNoIHdvdWxkIGFsd2F5cyBpbmNsdWRlIGRldmljZSBUTEIgZmx1c2guCj4gPiBC
dXQgd2UgdGhvdWdodCBzdWNoIGJlaGF2aW9yIGNhbm5vdCBiZSBhc3N1bWVkIGZvciBhbGwgVk1N
cywgc29tZQo+ID4gbWF5IHN0aWxsIGRvIGV4cGxpY2l0IGRldiBUTEIgZmx1c2guIFNvIGZvciBj
b21wbGV0ZW5lc3MsIHdlCj4gPiBpbmNsdWRlZCBkZXYgVExCIGhlcmUuICAKPiAKPiBpcyB0aGVy
ZSBzdWNoIGV4YW1wbGUgb3IgYSBsaW5rIHRvIHByZXZpb3VzIGRpc2N1c3Npb24/IEhlcmUgd2Ug
YXJlCj4gdGFsa2luZyBhYm91dCBob3N0IElPTU1VIGRyaXZlciBiZWhhdmlvciwgaW5zdGVhZCBv
ZiBWTU0uIEJ1dCBJJ20KPiBub3Qgc3Ryb25nIG9uIHRoaXMsIHNpbmNlIGl0J3MgbW9yZSBhbiBv
cHRpbWl6YXRpb24uIEJ1dCB0aGVyZSByZW1haW5zCj4gb25lIHVuY2xlYXIgYXJlYS4gSWYgd2Ug
ZG8gd2FudCB0byBzdXBwb3J0IHN1Y2ggdXNhZ2Ugd2l0aCBleHBsaWNpdAo+IGRldiBUTEIgZmx1
c2gsIGhvdyBkb2VzIGhvc3QgSU9NTVUgZHJpdmVyIGF2b2lkIGRvaW5nIGltcGxpY2l0Cj4gZGV2
IFRMQiBmbHVzaCB3aGVuIHNlcnZpbmcgaW90bGIgaW52YWxpZGF0aW9uIHJlcXVlc3Q/IElzIGl0
IGFscmVhZHkKPiBkZXNpZ25lZCBzdWNoIHdheSB0aGF0IHVzZXItcGFzc2VkLWRvd24gaW90bGIg
aW52YWxpZGF0aW9uIHJlcXVlc3QKPiBvbmx5IGludmFsaWRhdGVzIGlvdGxiIHdoaWxlIGtlcm5l
bC10cmlnZ2VyZWQgaW90bGIgaW52YWxpZGF0aW9uIHN0aWxsCj4gZG9lcyBpbXBsaWNpdCBkZXYg
VExCIGZsdXNoPwo+IApUaGUgY3VycmVudCBkZXNpZ24gd2l0aCB2SU9NTVUgaW4gUUVNVSB3aWxs
IHByZXZlbnQgZXhwbGljaXQgZGV2IFRMQgpmbHVzaC4gSG9zdCB3aWxsIGFsd2F5cyBkbyBpbmNs
dXNpdmUgSU9UTEIgYW5kIGRldiBUTEIgZmx1c2ggb24gSU9UTEIKZmx1c2ggcmVxdWVzdC4KCkZv
ciBvdGhlciBWTU0gd2hpY2ggZG9lcyBub3QgZG8gdGhpcyBvcHRpbWl6YXRpb24sIHdlIGp1c3Qg
bGVhdmUgYQpwYXRoIGZvciBleHBsaWNpdCBkZXYgVExCIGZsdXNoLiBSZWR1bmRhbnQgYnV0IGZv
ciBJT01NVSBkcml2ZXIKcGVyc3BlY3RpdmUgaXQgaXMgY29tcGxldGUuIFdlIGRvbid0IGF2b2lk
IHRoZSByZWR1bmRhbmN5IGFzIHRoZXJlIGlzCm5vIGRhbWFnZSBvdXRzaWRlIHRoZSBndWVzdCwg
anVzdCBhcyB3ZSBkb24ndCBwcmV2ZW50IGd1ZXN0IGRvaW5nIHRoZQpzYW1lIGZsdXNoIHR3aWNl
LgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
