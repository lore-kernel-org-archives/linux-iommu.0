Return-Path: <SRS0=J3yl=YT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CB1CA9EBD
	for <iommu@archiver.kernel.org>; Sat, 26 Oct 2019 07:05:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA7B920679
	for <iommu@archiver.kernel.org>; Sat, 26 Oct 2019 07:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7B920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6C8C6C59;
	Sat, 26 Oct 2019 07:05:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4D27F900
	for <iommu@lists.linux-foundation.org>;
	Sat, 26 Oct 2019 07:05:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8849B14D
	for <iommu@lists.linux-foundation.org>;
	Sat, 26 Oct 2019 07:05:41 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	26 Oct 2019 00:05:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; d="scan'208";a="224136893"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by fmsmga004.fm.intel.com with ESMTP; 26 Oct 2019 00:05:37 -0700
Subject: Re: [PATCH v7 11/11] iommu/vt-d: Add svm/sva invalidate function
To: "Tian, Kevin" <kevin.tian@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, 
	LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <1571946904-86776-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1571946904-86776-12-git-send-email-jacob.jun.pan@linux.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D5CDE06@SHSMSX104.ccr.corp.intel.com>
	<5e9d2372-a8b5-9a26-1438-c1a608bfad6d@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d0375121-7893-bb06-45f3-209a0cff12de@linux.intel.com>
Date: Sat, 26 Oct 2019 15:03:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5e9d2372-a8b5-9a26-1438-c1a608bfad6d@linux.intel.com>
Content-Language: en-US
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Jonathan Cameron <jic23@kernel.org>
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

SGkgYWdhaW4sCgpPbiAxMC8yNi8xOSAxMDo0MCBBTSwgTHUgQmFvbHUgd3JvdGU6Cj4gSGksCj4g
Cj4gT24gMTAvMjUvMTkgMzoyNyBQTSwgVGlhbiwgS2V2aW4gd3JvdGU6Cj4+PiBGcm9tOiBKYWNv
YiBQYW4gW21haWx0bzpqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbV0KPj4+IFNlbnQ6IEZy
aWRheSwgT2N0b2JlciAyNSwgMjAxOSAzOjU1IEFNCj4+Pgo+Pj4gV2hlbiBTaGFyZWQgVmlydHVh
bCBBZGRyZXNzIChTVkEpIGlzIGVuYWJsZWQgZm9yIGEgZ3Vlc3QgT1MgdmlhCj4+PiB2SU9NTVUs
IHdlIG5lZWQgdG8gcHJvdmlkZSBpbnZhbGlkYXRpb24gc3VwcG9ydCBhdCBJT01NVSBBUEkgYW5k
Cj4+PiBkcml2ZXIKPj4+IGxldmVsLiBUaGlzIHBhdGNoIGFkZHMgSW50ZWwgVlQtZCBzcGVjaWZp
YyBmdW5jdGlvbiB0byBpbXBsZW1lbnQKPj4+IGlvbW11IHBhc3Nkb3duIGludmFsaWRhdGUgQVBJ
IGZvciBzaGFyZWQgdmlydHVhbCBhZGRyZXNzLgo+Pj4KPj4+IFRoZSB1c2UgY2FzZSBpcyBmb3Ig
c3VwcG9ydGluZyBjYWNoaW5nIHN0cnVjdHVyZSBpbnZhbGlkYXRpb24KPj4+IG9mIGFzc2lnbmVk
IFNWTSBjYXBhYmxlIGRldmljZXMuIEVtdWxhdGVkIElPTU1VIGV4cG9zZXMgcXVldWUKPj4+IGlu
dmFsaWRhdGlvbiBjYXBhYmlsaXR5IGFuZCBwYXNzZXMgZG93biBhbGwgZGVzY3JpcHRvcnMgZnJv
bSB0aGUgZ3Vlc3QKPj4+IHRvIHRoZSBwaHlzaWNhbCBJT01NVS4KPj4KPj4gc3BlY2lmaWNhbGx5
IHlvdSBtYXkgY2xhcmlmeSB0aGF0IG9ubHkgaW52YWxpZGF0aW9ucyByZWxhdGVkIHRvCj4+IGZp
cnN0LWxldmVsIHBhZ2UgdGFibGUgaXMgcGFzc2VkIGRvd24sIGJlY2F1c2UgaXQncyBndWVzdAo+
PiBzdHJ1Y3R1cmUgYmVpbmcgYm91bmQgdG8gdGhlIGZpcnN0LWxldmVsLiBvdGhlciBkZXNjcmlw
dG9ycwo+PiBhcmUgZW11bGF0ZWQgb3IgdHJhbnNsYXRlZCBpbnRvIG90aGVyIG5lY2Vzc2FyeSBv
cGVyYXRpb25zLgo+Pgo+Pj4KPj4+IFRoZSBhc3N1bXB0aW9uIGlzIHRoYXQgZ3Vlc3QgdG8gaG9z
dCBkZXZpY2UgSUQgbWFwcGluZyBzaG91bGQgYmUKPj4+IHJlc29sdmVkIHByaW9yIHRvIGNhbGxp
bmcgSU9NTVUgZHJpdmVyLiBCYXNlZCBvbiB0aGUgZGV2aWNlIGhhbmRsZSwKPj4+IGhvc3QgSU9N
TVUgZHJpdmVyIGNhbiByZXBsYWNlIGNlcnRhaW4gZmllbGRzIGJlZm9yZSBzdWJtaXQgdG8gdGhl
Cj4+PiBpbnZhbGlkYXRpb24gcXVldWUuCj4+Cj4+IHdoYXQgaXMgZGV2aWNlIElEPyBpdCdzIGEg
Yml0IGNvbmZ1c2luZyB0ZXJtIGhlcmUuCj4+Cj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogSmFjb2Ig
UGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVsLmNvbT4KPj4+IFNpZ25lZC1vZmYtYnk6IEFz
aG9rIFJhaiA8YXNob2sucmFqQGludGVsLmNvbT4KPj4+IFNpZ25lZC1vZmYtYnk6IExpdSwgWWkg
TCA8eWkubC5saXVAbGludXguaW50ZWwuY29tPgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL2lvbW11
L2ludGVsLWlvbW11LmMgfCAxNzAKPj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTcwIGluc2VydGlvbnMoKykKPj4+
Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jIGIvZHJpdmVycy9p
b21tdS9pbnRlbC1pb21tdS5jCj4+PiBpbmRleCA1ZmFiMzJmYmM0YjQuLmE3M2U3NmQ2NDU3YSAx
MDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYwo+Pj4gKysrIGIvZHJp
dmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4+PiBAQCAtNTQ5MSw2ICs1NDkxLDE3NSBAQCBzdGF0
aWMgdm9pZAo+Pj4gaW50ZWxfaW9tbXVfYXV4X2RldGFjaF9kZXZpY2Uoc3RydWN0IGlvbW11X2Rv
bWFpbiAqZG9tYWluLAo+Pj4gwqDCoMKgwqDCoCBhdXhfZG9tYWluX3JlbW92ZV9kZXYodG9fZG1h
cl9kb21haW4oZG9tYWluKSwgZGV2KTsKPj4+IMKgIH0KPj4+Cj4+PiArLyoKPj4+ICsgKiAyRCBh
cnJheSBmb3IgY29udmVydGluZyBhbmQgc2FuaXRpemluZyBJT01NVSBnZW5lcmljIFRMQiAKPj4+
IGdyYW51bGFyaXR5IHRvCj4+PiArICogVlQtZCBncmFudWxhcml0eS4gSW52YWxpZGF0aW9uIGlz
IHR5cGljYWxseSBpbmNsdWRlZCBpbiB0aGUgdW5tYXAKPj4+IG9wZXJhdGlvbgo+Pj4gKyAqIGFz
IGEgcmVzdWx0IG9mIERNQSBvciBWRklPIHVubWFwLiBIb3dldmVyLCBmb3IgYXNzaWduZWQgZGV2
aWNlIHdoZXJlCj4+PiBndWVzdAo+Pj4gKyAqIGNvdWxkIG93biB0aGUgZmlyc3QgbGV2ZWwgcGFn
ZSB0YWJsZXMgd2l0aG91dCBiZWluZyBzaGFkb3dlZCBieSAKPj4+IFFFTVUuCj4+PiBJbgo+Pj4g
KyAqIHRoaXMgY2FzZSB0aGVyZSBpcyBubyBwYXNzIGRvd24gdW5tYXAgdG8gdGhlIGhvc3QgSU9N
TVUgYXMgYSAKPj4+IHJlc3VsdCBvZgo+Pj4gdW5tYXAKPj4+ICsgKiBpbiB0aGUgZ3Vlc3QuIE9u
bHkgaW52YWxpZGF0aW9ucyBhcmUgdHJhcHBlZCBhbmQgcGFzc2VkIGRvd24uCj4+PiArICogSW4g
YWxsIGNhc2VzLCBvbmx5IGZpcnN0IGxldmVsIFRMQiBpbnZhbGlkYXRpb24gKHJlcXVlc3Qgd2l0
aCAKPj4+IFBBU0lEKSBjYW4gYmUKPj4+ICsgKiBwYXNzZWQgZG93biwgdGhlcmVmb3JlIHdlIGRv
IG5vdCBpbmNsdWRlIElPVExCIGdyYW51bGFyaXR5IGZvciAKPj4+IHJlcXVlc3QKPj4+ICsgKiB3
aXRob3V0IFBBU0lEIChzZWNvbmQgbGV2ZWwpLgo+Pj4gKyAqCj4+PiArICogRm9yIGFuIGV4YW1w
bGUsIHRvIGZpbmQgdGhlIFZULWQgZ3JhbnVsYXJpdHkgZW5jb2RpbmcgZm9yIElPVExCCj4+PiAr
ICogdHlwZSBhbmQgcGFnZSBzZWxlY3RpdmUgZ3JhbnVsYXJpdHkgd2l0aGluIFBBU0lEOgo+Pj4g
KyAqIFg6IGluZGV4ZWQgYnkgaW9tbXUgY2FjaGUgdHlwZQo+Pj4gKyAqIFk6IGluZGV4ZWQgYnkg
ZW51bSBpb21tdV9pbnZfZ3JhbnVsYXJpdHkKPj4+ICsgKiBbSU9NTVVfQ0FDSEVfSU5WX1RZUEVf
SU9UTEJdW0lPTU1VX0lOVl9HUkFOVV9BRERSXQo+Pj4gKyAqCj4+PiArICogR3JhbnVfbWFwIGFy
cmF5IGluZGljYXRlcyB2YWxpZGl0eSBvZiB0aGUgdGFibGUuIDE6IHZhbGlkLCAwOiAKPj4+IGlu
dmFsaWQKPj4+ICsgKgo+Pj4gKyAqLwo+Pj4gK2NvbnN0IHN0YXRpYyBpbnQKPj4+IGludl90eXBl
X2dyYW51X21hcFtJT01NVV9DQUNIRV9JTlZfVFlQRV9OUl1bSU9NTVVfSU5WX0dSQU4KPj4+IFVf
TlJdID0gewo+Pj4gK8KgwqDCoCAvKiBQQVNJRCBiYXNlZCBJT1RMQiwgc3VwcG9ydCBQQVNJRCBz
ZWxlY3RpdmUgYW5kIHBhZ2Ugc2VsZWN0aXZlICovCj4+PiArwqDCoMKgIHswLCAxLCAxfSwKPj4+
ICvCoMKgwqAgLyogUEFTSUQgYmFzZWQgZGV2IFRMQnMsIG9ubHkgc3VwcG9ydCBhbGwgUEFTSURz
IG9yIHNpbmdsZSBQQVNJRCAqLwo+Pj4gK8KgwqDCoCB7MSwgMSwgMH0sCj4+Cj4+IEkgZm9yZ290
IHByZXZpb3VzIGRpc2N1c3Npb24uIGlzIGl0IG5lY2Vzc2FyeSB0byBwYXNzIGRvd24gZGV2IFRM
QiAKPj4gaW52YWxpZGF0aW9uCj4+IHJlcXVlc3RzPyBDYW4gaXQgYmUgaGFuZGxlZCBieSBob3N0
IGlPTU1VIGRyaXZlciBhdXRvbWF0aWNhbGx5Pwo+IAo+IE9uIGhvc3QgU1ZBLCB3aGVuIGEgbWVt
b3J5IGlzIHVubWFwcGVkLCBkcml2ZXIgY2FsbGJhY2sgd2lsbCBpbnZhbGlkYXRlCj4gZGV2IElP
VExCIGV4cGxpY2l0bHkuIFNvIEkgZ3Vlc3Mgd2UgbmVlZCB0byBwYXNzIGRvd24gaXQgZm9yIGd1
ZXN0IGNhc2UuCj4gVGhpcyBpcyBhbHNvIHJlcXVpcmVkIGZvciBndWVzdCBpb3ZhIG92ZXIgMXN0
IGxldmVsIHVzYWdlIGFzIGZhciBhcyBjYW4KPiBzZWUuCj4gCgpTb3JyeSwgSSBjb25mdXNlZCBn
dWVzdCB2SU9WQSBhbmQgZ3Vlc3QgdlNWQS4gRm9yIGd1ZXN0IHZJT1ZBLCBubyBkZXZpY2UKVExC
IGludmFsaWRhdGlvbiBwYXNzIGRvd24uIEJ1dCBjdXJyZW50bHkgZm9yIGd1ZXN0IHZTVkEsIGRl
dmljZSBUTEIKaW52YWxpZGF0aW9uIGlzIHBhc3NlZCBkb3duLiBQZXJoYXBzIHdlIGNhbiBhdm9p
ZCBwYXNzaW5nIGRvd24gZGV2IFRMQgpmbHVzaCBqdXN0IGxpa2Ugd2hhdCB3ZSBhcmUgZG9pbmcg
Zm9yIGd1ZXN0IElPVkEuCgpCZXN0IHJlZ2FyZHMsCmJhb2x1Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
