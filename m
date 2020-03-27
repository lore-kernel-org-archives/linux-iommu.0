Return-Path: <SRS0=HkIk=5M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21C4C43331
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 23:41:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CFB2071B
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 23:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CFB2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 49BEB2042B;
	Fri, 27 Mar 2020 23:41:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oWaHk97Svh9r; Fri, 27 Mar 2020 23:41:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E6E7D2041C;
	Fri, 27 Mar 2020 23:41:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8B7FC1D7C;
	Fri, 27 Mar 2020 23:41:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A78AC0177
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 23:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 26FAC884BE
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 23:41:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uqtGNHRcN6j3 for <iommu@lists.linux-foundation.org>;
 Fri, 27 Mar 2020 23:41:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 11BFC88426
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 23:41:17 +0000 (UTC)
IronPort-SDR: ijMETLb5ROYgTuN2yUmEPfY7q0QL7BtqYSLpoC0qPe9BjFO7rbqNfcqByL0gvA5HK6rOPrrB0/
 HSnAQ71g9WNQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2020 16:41:16 -0700
IronPort-SDR: ngS9OYOSHXIg2UyGp+aPeAjjJ6RVJ0VCTVig+06C2N9UpvTsLgX7gKcvmibvN+FFsWBSDHlhhj
 0073ApSfWqEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,314,1580803200"; d="scan'208";a="251299291"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga006.jf.intel.com with ESMTP; 27 Mar 2020 16:41:14 -0700
Date: Fri, 27 Mar 2020 16:47:01 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 10/10] iommu/vt-d: Register PASID notifier for status
 change
Message-ID: <20200327164701.5cfee1c3@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED65A@SHSMSX104.ccr.corp.intel.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-11-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED65A@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

T24gRnJpLCAyNyBNYXIgMjAyMCAxMDoyMjo1NyArMDAwMAoiVGlhbiwgS2V2aW4iIDxrZXZpbi50
aWFuQGludGVsLmNvbT4gd3JvdGU6Cgo+ID4gRnJvbTogSmFjb2IgUGFuCj4gPiBTZW50OiBUaHVy
c2RheSwgTWFyY2ggMjYsIDIwMjAgMTo1NiBBTQo+ID4gCj4gPiBJbiBiYXJlIG1ldGFsIFNWQSwg
SU9NTVUgZHJpdmVyIGVuc3VyZXMgdGhhdCBJT0FTSUQgZnJlZSBjYWxsCj4gPiBhbHdheXMgY29t
ZXMgYWZ0ZXIgSU9BU0lEIHVuYmluZCBvcGVyYXRpb24uCj4gPiAKPiA+IEhvd2V2ZXIsIGZvciBn
dWVzdCBTVkEgdGhlIHVuYmluZCBhbmQgZnJlZSBjYWxsIGNvbWUgZnJvbSB1c2VyIHNwYWNlCj4g
PiB2aWEgVkZJTywgd2hpY2ggY291bGQgYmUgb3V0IG9mIG9yZGVyLiBUaGlzIHBhdGNoIHJlZ2lz
dGVycyBhCj4gPiBub3RpZmllciBibG9jayBpbiBjYXNlIElPQVNJRCBmcmVlKCkgY29tZXMgYmVm
b3JlIHVuYmluZCBzdWNoIHRoYXQKPiA+IFZULWQgZHJpdmVyIGNhbiB0YWtlIGFjdGlvbiB0byBj
bGVhbiB1cCBQQVNJRCBjb250ZXh0IGFuZCBkYXRhLiAgCj4gCj4gY2xlYXJseSB0aGUgcGF0Y2gg
aW5jbHVkZXMgbW9yZSB0aGFuIGFib3ZlIHVzYWdlLiBJdCBhbHNvIGhhbmRsZXMgdGhlCj4gYmlu
ZCB1c2FnZSB0byBub3RpZnkgS1ZNIGZvciBzZXR0aW5nIFBBU0lEIHRyYW5zbGF0aW9uIHRhYmxl
Lgo+IAo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaXUgWWkgTCA8eWkubC5saXVAaW50ZWwuY29t
Pgo+ID4gU2lnbmVkLW9mZi1ieTogSmFjb2IgUGFuIDxqYWNvYi5qdW4ucGFuQGxpbnV4LmludGVs
LmNvbT4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvaW9tbXUvaW50ZWwtc3ZtLmMgICB8IDY4Cj4gPiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KPiA+ICBpbmNsdWRl
L2xpbnV4L2ludGVsLWlvbW11LmggfCAgMSArCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA2OCBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lv
bW11L2ludGVsLXN2bS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC1zdm0uYwo+ID4gaW5kZXggZjUx
MTg1NWQxODdiLi43NzlkZDJjNmY5ZTEgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L2lu
dGVsLXN2bS5jCj4gPiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsLXN2bS5jCj4gPiBAQCAtMjMs
NiArMjMsNyBAQAo+ID4gICNpbmNsdWRlICJpbnRlbC1wYXNpZC5oIgo+ID4gCj4gPiAgc3RhdGlj
IGlycXJldHVybl90IHBycV9ldmVudF90aHJlYWQoaW50IGlycSwgdm9pZCAqZCk7Cj4gPiArc3Rh
dGljIERFRklORV9NVVRFWChwYXNpZF9tdXRleCk7Cj4gPiAKPiA+ICAjZGVmaW5lIFBSUV9PUkRF
UiAwCj4gPiAKPiA+IEBAIC05Miw2ICs5Myw2NSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgaW50ZWxf
c3ZtX2NhcGFibGUoc3RydWN0Cj4gPiBpbnRlbF9pb21tdSAqaW9tbXUpCj4gPiAgCXJldHVybiBp
b21tdS0+ZmxhZ3MgJiBWVERfRkxBR19TVk1fQ0FQQUJMRTsKPiA+ICB9Cj4gPiAKPiA+ICsjZGVm
aW5lIHBhc2lkX2xvY2tfaGVsZCgpIGxvY2tfaXNfaGVsZCgmcGFzaWRfbXV0ZXguZGVwX21hcCkK
PiA+ICsKPiA+ICtzdGF0aWMgaW50IHBhc2lkX3N0YXR1c19jaGFuZ2Uoc3RydWN0IG5vdGlmaWVy
X2Jsb2NrICpuYiwKPiA+ICsJCQkJdW5zaWduZWQgbG9uZyBjb2RlLCB2b2lkICpkYXRhKQo+ID4g
K3sKPiA+ICsJc3RydWN0IGlvYXNpZF9uYl9hcmdzICphcmdzID0gKHN0cnVjdCBpb2FzaWRfbmJf
YXJncwo+ID4gKilkYXRhOwo+ID4gKwlzdHJ1Y3QgaW50ZWxfc3ZtX2RldiAqc2RldjsKPiA+ICsJ
c3RydWN0IGludGVsX3N2bSAqc3ZtOwo+ID4gKwlpbnQgcmV0ID0gTk9USUZZX0RPTkU7Cj4gPiAr
Cj4gPiArCWlmIChjb2RlID09IElPQVNJRF9GUkVFKSB7Cj4gPiArCQkvKgo+ID4gKwkJICogVW5i
aW5kIGFsbCBkZXZpY2VzIGFzc29jaWF0ZWQgd2l0aCB0aGlzIFBBU0lECj4gPiB3aGljaCBpcwo+
ID4gKwkJICogYmVpbmcgZnJlZWQgYnkgb3RoZXIgdXNlcnMgc3VjaCBhcyBWRklPLgo+ID4gKwkJ
ICovCj4gPiArCQltdXRleF9sb2NrKCZwYXNpZF9tdXRleCk7Cj4gPiArCQlzdm0gPSBpb2FzaWRf
ZmluZChJTlZBTElEX0lPQVNJRF9TRVQsIGFyZ3MtPmlkLAo+ID4gTlVMTCk7Cj4gPiArCQlpZiAo
IXN2bSB8fCAhc3ZtLT5pb21tdSkKPiA+ICsJCQlnb3RvIGRvbmVfdW5sb2NrOyAgCj4gCj4gc2hv
dWxkIHdlIHRyZWF0ICFzdm0tPmlvbW11IGFzIGFuIGVycm9yIGNvbmRpdGlvbj8gaWYgbm90LCBk
byB5b3UgaGF2ZQo+IGFuIGV4YW1wbGUgd2hlbiBpdCBtYXkgb2NjdXIgaW4gbm9ybWFsIHNpdHVh
dGlvbj8KPiAKUmlnaHQsIHNob3VsZCBiZSBhbiBlcnJvci4gSW5pdGlhbGx5LCB1bmJpbmQgY291
bGQgcmV0cmlldmUgaW9tbXUgZnJvbQpzdHJ1Y3QgZGV2aWNlLCBidXQgd2l0aCBub3RpZmllciB3
ZSBoYXZlIHRvIHNldCBzdm0tPmlvbW11IGFsbCB0aGUgdGltZS4KCj4gPiArCj4gPiArCQlpZiAo
SVNfRVJSKHN2bSkpIHsKPiA+ICsJCQlyZXQgPSBOT1RJRllfQkFEOwo+ID4gKwkJCWdvdG8gZG9u
ZV91bmxvY2s7Cj4gPiArCQl9ICAKPiAKPiBzdm0tPmlvbW11IHNob3VsZCBiZSByZWZlcmVuY2Vk
IGFmdGVyIElTX0VSUiBjaGVjawo+IApHb29kIHBvaW50LCB3aWxsIG1vdmUgdXAuCj4gPiArCj4g
PiArCQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3JjdShzZGV2LCAmc3ZtLT5kZXZzLCBsaXN0LAo+ID4g
cGFzaWRfbG9ja19oZWxkKCkpIHsKPiA+ICsJCQkvKiBEb2VzIG5vdCBwb2lzb24gZm9yd2FyZCBw
b2ludGVyICovCj4gPiArCQkJbGlzdF9kZWxfcmN1KCZzZGV2LT5saXN0KTsKPiA+ICsJCQlpbnRl
bF9wYXNpZF90ZWFyX2Rvd25fZW50cnkoc3ZtLT5pb21tdSwKPiA+IHNkZXYtICAKPiA+ID5kZXYs
ICAKPiA+ICsJCQkJCQkgICAgc3ZtLT5wYXNpZCk7Cj4gPiArCQkJa2ZyZWVfcmN1KHNkZXYsIHJj
dSk7Cj4gPiArCj4gPiArCQkJLyoKPiA+ICsJCQkgKiBGcmVlIGJlZm9yZSB1bmJpbmQgb25seSBo
YXBwZW5zIHdpdGgKPiA+IGd1ZXN0IHVzYWdlZAo+ID4gKwkJCSAqIGhvc3QgUEFTSURzLiBJT0FT
SUQgZnJlZSB3aWxsIGRldGFjaAo+ID4gcHJpdmF0ZSBkYXRhCj4gPiArCQkJICogYW5kIGZyZWUg
dGhlIElPQVNJRCBlbnRyeS4gIAo+IAo+ICJndWVzdCB1c2FnZWQgaG9zdCBQQVNJRHMiPwo+IApJ
IG1lYW4gVk0gdXNlZCBQQVNJRCwgd2lsbCBjaGFuZ2UgdG8KLyoKICogRnJlZSBiZWZvcmUgdW5i
aW5kIG9ubHkgaGFwcGVucyB3aXRoIFBBU0lEcyB1c2VkCiAqIGJ5IFZNLiBJT0FTSUQgZnJlZSB3
aWxsIGRldGFjaCBwcml2YXRlIGRhdGEKICogYW5kIGZyZWUgdGhlIElPQVNJRCBlbnRyeS4KICov
Cgo+ID4gKwkJCSAqLwo+ID4gKwkJCWlmIChsaXN0X2VtcHR5KCZzdm0tPmRldnMpKQo+ID4gKwkJ
CQlrZnJlZShzdm0pOwo+ID4gKwkJfQo+ID4gKwkJbXV0ZXhfdW5sb2NrKCZwYXNpZF9tdXRleCk7
Cj4gPiArCj4gPiArCQlyZXR1cm4gTk9USUZZX09LOwo+ID4gKwl9Cj4gPiArCj4gPiArZG9uZV91
bmxvY2s6Cj4gPiArCW11dGV4X3VubG9jaygmcGFzaWRfbXV0ZXgpOwo+ID4gKwlyZXR1cm4gcmV0
Owo+ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMgc3RydWN0IG5vdGlmaWVyX2Jsb2NrIHBhc2lkX25i
ID0gewo+ID4gKwkJLm5vdGlmaWVyX2NhbGwgPSBwYXNpZF9zdGF0dXNfY2hhbmdlLAo+ID4gK307
Cj4gPiArCj4gPiArdm9pZCBpbnRlbF9zdm1fYWRkX3Bhc2lkX25vdGlmaWVyKHZvaWQpCj4gPiAr
ewo+ID4gKwlpb2FzaWRfYWRkX25vdGlmaWVyKCZwYXNpZF9uYik7Cj4gPiArfQo+ID4gKwo+ID4g
IHZvaWQgaW50ZWxfc3ZtX2NoZWNrKHN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXUpCj4gPiAgewo+
ID4gIAlpZiAoIXBhc2lkX3N1cHBvcnRlZChpb21tdSkpCj4gPiBAQCAtMjE5LDcgKzI3OSw2IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgbW11X25vdGlmaWVyX29wcwo+ID4gaW50ZWxfbW11b3BzID0g
ewo+ID4gIAkuaW52YWxpZGF0ZV9yYW5nZSA9IGludGVsX2ludmFsaWRhdGVfcmFuZ2UsCj4gPiAg
fTsKPiA+IAo+ID4gLXN0YXRpYyBERUZJTkVfTVVURVgocGFzaWRfbXV0ZXgpOwo+ID4gIHN0YXRp
YyBMSVNUX0hFQUQoZ2xvYmFsX3N2bV9saXN0KTsKPiA+IAo+ID4gICNkZWZpbmUgZm9yX2VhY2hf
c3ZtX2RldihzZGV2LCBzdm0sIGQpCQkJXAo+ID4gQEAgLTMxOSw2ICszNzgsNyBAQCBpbnQgaW50
ZWxfc3ZtX2JpbmRfZ3Bhc2lkKHN0cnVjdCBpb21tdV9kb21haW4KPiA+ICpkb21haW4sCj4gPiAg
CQkJc3ZtLT5ncGFzaWQgPSBkYXRhLT5ncGFzaWQ7Cj4gPiAgCQkJc3ZtLT5mbGFncyB8PSBTVk1f
RkxBR19HVUVTVF9QQVNJRDsKPiA+ICAJCX0KPiA+ICsJCXN2bS0+aW9tbXUgPSBpb21tdTsgIAo+
IAo+IGFoLCBpdCdzIGludGVyZXN0aW5nIHRvIHNlZSB3ZSBoYXZlIGEgZmllbGQgZGVmaW5lZCBi
ZWZvcmUgYnV0IG5ldmVyCj4gdXNlZC4g8J+Yigo+IApUaGUgdW5iaW5kIGNhbGwgY2FuIHJldHJp
ZXZlIGlvbW11IGZyb20gc3RydWN0IGRldmljZS4KCj4gPiAKPiA+ICAJCWlvYXNpZF9hdHRhY2hf
ZGF0YShkYXRhLT5ocGFzaWQsIHN2bSk7Cj4gPiAgCQlJTklUX0xJU1RfSEVBRF9SQ1UoJnN2bS0+
ZGV2cyk7Cj4gPiBAQCAtMzgzLDYgKzQ0MywxMSBAQCBpbnQgaW50ZWxfc3ZtX2JpbmRfZ3Bhc2lk
KHN0cnVjdCBpb21tdV9kb21haW4KPiA+ICpkb21haW4sCj4gPiAgCX0KPiA+ICAJc3ZtLT5mbGFn
cyB8PSBTVk1fRkxBR19HVUVTVF9NT0RFOwo+ID4gCj4gPiArCS8qCj4gPiArCSAqIE5vdGlmeSBL
Vk0gbmV3IGhvc3QtZ3Vlc3QgUEFTSUQgYmluZCBpcyByZWFkeS4gS1ZNIHdpbGwKPiA+IHNldCB1
cAo+ID4gKwkgKiBQQVNJRCB0cmFuc2xhdGlvbiB0YWJsZSB0byBzdXBwb3J0IGd1ZXN0IEVOUUNN
RC4KPiA+ICsJICovICAKPiAKPiBzaG91bGQgdGFrZSBpdCBhcyBhbiBleGFtcGxlIGluc3RlYWQg
b2YgdGhlIG9ubHkgcG9zc2libGUgdXNhZ2UuCj4gClRydWUsIHdlIGRvbjt0IGtub3cgd2hvIGlz
IGdldHRpbmcgbm90aWZpZWQuCgo+ID4gKwlpb2FzaWRfbm90aWZ5KGRhdGEtPmhwYXNpZCwgSU9B
U0lEX0JJTkQpOwo+ID4gIAlpbml0X3JjdV9oZWFkKCZzZGV2LT5yY3UpOwo+ID4gIAlsaXN0X2Fk
ZF9yY3UoJnNkZXYtPmxpc3QsICZzdm0tPmRldnMpOwo+ID4gICBvdXQ6Cj4gPiBAQCAtNDQwLDYg
KzUwNSw3IEBAIGludCBpbnRlbF9zdm1fdW5iaW5kX2dwYXNpZChzdHJ1Y3QgZGV2aWNlICpkZXYs
Cj4gPiBpbnQgcGFzaWQpCj4gPiAgCQkJCSAqIHVzZWQgYnkgYW5vdGhlci4KPiA+ICAJCQkJICov
Cj4gPiAgCQkJCWlvYXNpZF9hdHRhY2hfZGF0YShwYXNpZCwgTlVMTCk7Cj4gPiArCQkJCWlvYXNp
ZF9ub3RpZnkocGFzaWQsCj4gPiBJT0FTSURfVU5CSU5EKTsga2ZyZWUoc3ZtKTsKPiA+ICAJCQl9
Cj4gPiAgCQl9Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pbnRlbC1pb21tdS5oCj4g
PiBiL2luY2x1ZGUvbGludXgvaW50ZWwtaW9tbXUuaCBpbmRleCBmODUwNGE5ODA5ODEuLjY0Nzk5
MDY3ZWE1OAo+ID4gMTAwNjQ0IC0tLSBhL2luY2x1ZGUvbGludXgvaW50ZWwtaW9tbXUuaAo+ID4g
KysrIGIvaW5jbHVkZS9saW51eC9pbnRlbC1pb21tdS5oCj4gPiBAQCAtNzA4LDYgKzcwOCw3IEBA
IGV4dGVybiBzdHJ1Y3QgaW9tbXVfc3ZhICoKPiA+ICBpbnRlbF9zdm1fYmluZChzdHJ1Y3QgZGV2
aWNlICpkZXYsIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCB2b2lkCj4gPiAqZHJ2ZGF0YSk7IGV4dGVy
biB2b2lkIGludGVsX3N2bV91bmJpbmQoc3RydWN0IGlvbW11X3N2YSAqaGFuZGxlKTsKPiA+ICBl
eHRlcm4gaW50IGludGVsX3N2bV9nZXRfcGFzaWQoc3RydWN0IGlvbW11X3N2YSAqaGFuZGxlKTsK
PiA+ICtleHRlcm4gdm9pZCBpbnRlbF9zdm1fYWRkX3Bhc2lkX25vdGlmaWVyKHZvaWQpOwo+ID4g
Cj4gPiAgc3RydWN0IHN2bV9kZXZfb3BzOwo+ID4gCj4gPiAtLQo+ID4gMi43LjQKPiA+IAo+ID4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiA+IGlvbW11
IG1haWxpbmcgbGlzdAo+ID4gaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPiA+IGh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11ICAK
CltKYWNvYiBQYW5dCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
