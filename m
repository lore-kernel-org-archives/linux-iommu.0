Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E747BC43334
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 09:16:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76D8760E58;
	Tue, 28 Jun 2022 09:16:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 76D8760E58
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a8uErpAY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HCn03mcM5_X3; Tue, 28 Jun 2022 09:16:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC0B4606C6;
	Tue, 28 Jun 2022 09:16:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EC0B4606C6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFFD5C0032;
	Tue, 28 Jun 2022 09:16:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E11AC002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 09:16:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5807041676
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 09:16:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5807041676
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=a8uErpAY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o0mNfXWlbgHE for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 09:16:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EC3A84160A
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EC3A84160A
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 09:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656407760; x=1687943760;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=OHaCPTb3tQJyC9jPefSdwGvmT4LNH8ytKUBKidFJYOM=;
 b=a8uErpAYwuBcT4Evt5LYV7Fs3RBm8ID9xg7Xd5TL+tLjhSbEIFLhQAn6
 J6JqAHqRsM6yXs380WoGQTbDs+IS66xHgnSIycrJh0WNvShZgKcB6Ae3w
 33+mEHokFwO8Lq50fDr8mdK9O9XHRTIoVYEJh/gBqgPZBzjb3DVlWXjqF
 yGK+pWWs3d/W2jMTBIV0Ey9liiobX1QYoq6K5TFrXIJDJsu93BPuSEYQ5
 E5SvUUh/TzKaM7PBRCnHYr6OqTz5brNQWx9vtKkD2vaERgXy3DVaeSbzP
 9WUME0fwY78hw/iCKSriK6SaR8oWFCm3qQeWuA0iakRUxt2a40T3jnH1r w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="279232384"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="279232384"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 02:10:18 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="594708620"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.254.212.145])
 ([10.254.212.145])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 02:10:14 -0700
Message-ID: <75b17c70-1658-91ea-0992-1be769550943@linux.intel.com>
Date: Tue, 28 Jun 2022 17:10:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
 <faacb997-0c0a-04e1-903d-53857f463214@linux.intel.com>
 <693a3604-d70b-e08c-2621-7f0cb9bdb6ca@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <693a3604-d70b-e08c-2621-7f0cb9bdb6ca@linux.intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
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

SGksIEJhb2x1CgrlnKggMjAyMi82LzI4IDE0OjI4LCBCYW9sdSBMdSDlhpnpgZM6Cj4gSGkgRXRo
YW4sCj4KPiBPbiAyMDIyLzYvMjcgMjE6MDMsIEV0aGFuIFpoYW8gd3JvdGU6Cj4+IEhpLAo+Pgo+
PiDlnKggMjAyMi82LzIxIDIyOjQzLCBMdSBCYW9sdSDlhpnpgZM6Cj4+PiBUd2VhayB0aGUgSS9P
IHBhZ2UgZmF1bHQgaGFuZGxpbmcgZnJhbWV3b3JrIHRvIHJvdXRlIHRoZSBwYWdlIGZhdWx0cyB0
bwo+Pj4gdGhlIGRvbWFpbiBhbmQgY2FsbCB0aGUgcGFnZSBmYXVsdCBoYW5kbGVyIHJldHJpZXZl
ZCBmcm9tIHRoZSBkb21haW4uCj4+PiBUaGlzIG1ha2VzIHRoZSBJL08gcGFnZSBmYXVsdCBoYW5k
bGluZyBmcmFtZXdvcmsgcG9zc2libGUgdG8gc2VydmUgbW9yZQo+Pj4gdXNhZ2Ugc2NlbmFyaW9z
IGFzIGxvbmcgYXMgdGhleSBoYXZlIGFuIElPTU1VIGRvbWFpbiBhbmQgaW5zdGFsbCBhIHBhZ2UK
Pj4+IGZhdWx0IGhhbmRsZXIgaW4gaXQuIFNvbWUgdW51c2VkIGZ1bmN0aW9ucyBhcmUgYWxzbyBy
ZW1vdmVkIHRvIGF2b2lkCj4+PiBkZWFkIGNvZGUuCj4+Pgo+Pj4gVGhlIGlvbW11X2dldF9kb21h
aW5fZm9yX2Rldl9wYXNpZCgpIHdoaWNoIHJldHJpZXZlcyBhdHRhY2hlZCBkb21haW4KPj4+IGZv
ciBhIHtkZXZpY2UsIFBBU0lEfSBwYWlyIGlzIHVzZWQuIEl0IHdpbGwgYmUgdXNlZCBieSB0aGUg
cGFnZSBmYXVsdAo+Pj4gaGFuZGxpbmcgZnJhbWV3b3JrIHdoaWNoIGtub3dzIHtkZXZpY2UsIFBB
U0lEfSByZXBvcnRlZCBmcm9tIHRoZSBpb21tdQo+Pj4gZHJpdmVyLiBXZSBoYXZlIGEgZ3VhcmFu
dGVlIHRoYXQgdGhlIFNWQSBkb21haW4gZG9lc24ndCBnbyBhd2F5IGR1cmluZwo+Pj4gSU9QRiBo
YW5kbGluZywgYmVjYXVzZSB1bmJpbmQoKSB3YWl0cyBmb3IgcGVuZGluZyBmYXVsdHMgd2l0aAo+
Pj4gaW9wZl9xdWV1ZV9mbHVzaF9kZXYoKSBiZWZvcmUgZnJlZWluZyB0aGUgZG9tYWluLiBIZW5j
ZSwgdGhlcmUncyBubyAKPj4+IG5lZWQKPj4+IHRvIHN5bmNocm9uaXplIGxpZmUgY3ljbGUgb2Yg
dGhlIGlvbW11IGRvbWFpbnMgYmV0d2VlbiB0aGUgdW5iaW5kKCkgYW5kCj4+PiB0aGUgaW50ZXJy
dXB0IHRocmVhZHMuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxp
bnV4LmludGVsLmNvbT4KPj4+IFJldmlld2VkLWJ5OiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGpl
YW4tcGhpbGlwcGVAbGluYXJvLm9yZz4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9pb21tdS9pby1w
Z2ZhdWx0LmMgfCA2NCAKPj4+ICsrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Cj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA1NyBkZWxldGlvbnMoLSkK
Pj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pby1wZ2ZhdWx0LmMgYi9kcml2ZXJz
L2lvbW11L2lvLXBnZmF1bHQuYwo+Pj4gaW5kZXggYWVlOWUwMzMwMTJmLi40ZjI0ZWM3MDM0Nzkg
MTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2lvLXBnZmF1bHQuYwo+Pj4gKysrIGIvZHJp
dmVycy9pb21tdS9pby1wZ2ZhdWx0LmMKPj4+IEBAIC02OSw2OSArNjksMTggQEAgc3RhdGljIGlu
dCBpb3BmX2NvbXBsZXRlX2dyb3VwKHN0cnVjdCBkZXZpY2UgCj4+PiAqZGV2LCBzdHJ1Y3QgaW9w
Zl9mYXVsdCAqaW9wZiwKPj4+IMKgwqDCoMKgwqAgcmV0dXJuIGlvbW11X3BhZ2VfcmVzcG9uc2Uo
ZGV2LCAmcmVzcCk7Cj4+PiDCoCB9Cj4+PiAtc3RhdGljIGVudW0gaW9tbXVfcGFnZV9yZXNwb25z
ZV9jb2RlCj4+PiAtaW9wZl9oYW5kbGVfc2luZ2xlKHN0cnVjdCBpb3BmX2ZhdWx0ICppb3BmKQo+
Pj4gLXsKPj4+IC3CoMKgwqAgdm1fZmF1bHRfdCByZXQ7Cj4+PiAtwqDCoMKgIHN0cnVjdCBtbV9z
dHJ1Y3QgKm1tOwo+Pj4gLcKgwqDCoCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYTsKPj4+IC3C
oMKgwqAgdW5zaWduZWQgaW50IGFjY2Vzc19mbGFncyA9IDA7Cj4+PiAtwqDCoMKgIHVuc2lnbmVk
IGludCBmYXVsdF9mbGFncyA9IEZBVUxUX0ZMQUdfUkVNT1RFOwo+Pj4gLcKgwqDCoCBzdHJ1Y3Qg
aW9tbXVfZmF1bHRfcGFnZV9yZXF1ZXN0ICpwcm0gPSAmaW9wZi0+ZmF1bHQucHJtOwo+Pj4gLcKg
wqDCoCBlbnVtIGlvbW11X3BhZ2VfcmVzcG9uc2VfY29kZSBzdGF0dXMgPSBJT01NVV9QQUdFX1JF
U1BfSU5WQUxJRDsKPj4+IC0KPj4+IC3CoMKgwqAgaWYgKCEocHJtLT5mbGFncyAmIElPTU1VX0ZB
VUxUX1BBR0VfUkVRVUVTVF9QQVNJRF9WQUxJRCkpCj4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IHN0YXR1czsKPj4+IC0KPj4+IC3CoMKgwqAgbW0gPSBpb21tdV9zdmFfZmluZChwcm0tPnBhc2lk
KTsKPj4+IC3CoMKgwqAgaWYgKElTX0VSUl9PUl9OVUxMKG1tKSkKPj4+IC3CoMKgwqDCoMKgwqDC
oCByZXR1cm4gc3RhdHVzOwo+Pj4gLQo+Pj4gLcKgwqDCoCBtbWFwX3JlYWRfbG9jayhtbSk7Cj4+
PiAtCj4+PiAtwqDCoMKgIHZtYSA9IGZpbmRfZXh0ZW5kX3ZtYShtbSwgcHJtLT5hZGRyKTsKPj4+
IC3CoMKgwqAgaWYgKCF2bWEpCj4+PiAtwqDCoMKgwqDCoMKgwqAgLyogVW5tYXBwZWQgYXJlYSAq
Lwo+Pj4gLcKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X3B1dF9tbTsKPj4+IC0KPj4+IC3CoMKgwqAg
aWYgKHBybS0+cGVybSAmIElPTU1VX0ZBVUxUX1BFUk1fUkVBRCkKPj4+IC3CoMKgwqDCoMKgwqDC
oCBhY2Nlc3NfZmxhZ3MgfD0gVk1fUkVBRDsKPj4+IC0KPj4+IC3CoMKgwqAgaWYgKHBybS0+cGVy
bSAmIElPTU1VX0ZBVUxUX1BFUk1fV1JJVEUpIHsKPj4+IC3CoMKgwqDCoMKgwqDCoCBhY2Nlc3Nf
ZmxhZ3MgfD0gVk1fV1JJVEU7Cj4+PiAtwqDCoMKgwqDCoMKgwqAgZmF1bHRfZmxhZ3MgfD0gRkFV
TFRfRkxBR19XUklURTsKPj4+IC3CoMKgwqAgfQo+Pj4gLQo+Pj4gLcKgwqDCoCBpZiAocHJtLT5w
ZXJtICYgSU9NTVVfRkFVTFRfUEVSTV9FWEVDKSB7Cj4+PiAtwqDCoMKgwqDCoMKgwqAgYWNjZXNz
X2ZsYWdzIHw9IFZNX0VYRUM7Cj4+PiAtwqDCoMKgwqDCoMKgwqAgZmF1bHRfZmxhZ3MgfD0gRkFV
TFRfRkxBR19JTlNUUlVDVElPTjsKPj4+IC3CoMKgwqAgfQo+Pj4gLQo+Pj4gLcKgwqDCoCBpZiAo
IShwcm0tPnBlcm0gJiBJT01NVV9GQVVMVF9QRVJNX1BSSVYpKQo+Pj4gLcKgwqDCoMKgwqDCoMKg
IGZhdWx0X2ZsYWdzIHw9IEZBVUxUX0ZMQUdfVVNFUjsKPj4+IC0KPj4+IC3CoMKgwqAgaWYgKGFj
Y2Vzc19mbGFncyAmIH52bWEtPnZtX2ZsYWdzKQo+Pj4gLcKgwqDCoMKgwqDCoMKgIC8qIEFjY2Vz
cyBmYXVsdCAqLwo+Pj4gLcKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X3B1dF9tbTsKPj4+IC0KPj4+
IC3CoMKgwqAgcmV0ID0gaGFuZGxlX21tX2ZhdWx0KHZtYSwgcHJtLT5hZGRyLCBmYXVsdF9mbGFn
cywgTlVMTCk7Cj4+PiAtwqDCoMKgIHN0YXR1cyA9IHJldCAmIFZNX0ZBVUxUX0VSUk9SID8gSU9N
TVVfUEFHRV9SRVNQX0lOVkFMSUQgOgo+Pj4gLcKgwqDCoMKgwqDCoMKgIElPTU1VX1BBR0VfUkVT
UF9TVUNDRVNTOwo+Pj4gLQo+Pj4gLW91dF9wdXRfbW06Cj4+PiAtwqDCoMKgIG1tYXBfcmVhZF91
bmxvY2sobW0pOwo+Pj4gLcKgwqDCoCBtbXB1dChtbSk7Cj4+PiAtCj4+PiAtwqDCoMKgIHJldHVy
biBzdGF0dXM7Cj4+PiAtfQo+Pj4gLQo+Pgo+PiBPbmNlIHRoZSBpb3BmX2hhbmRsZV9zaW5nbGUo
KSBpcyByZW1vdmVkLCB0aGUgbmFtZSBvZiAKPj4gaW9wZl9oYW5kbGVfZ3JvdXAoKSBsb29rcyBh
IGxpdHRsZSB3ZWlyZWQKPj4KPj4gYW5kIGNvbmZ1c2VkLCBkb2VzIHRoaXMgZ3JvdXAgbWVhbiB0
aGUgaW9tbXUgZ3JvdXAgKGRvbWFpbikgPyB3aGlsZSBJIAo+PiB0YWtlIHNvbWUgbWludXRlcyB0
bwo+Cj4gTm8uIFRoaXMgaXMgbm90IHRoZSBpb21tdSBncm91cC4gSXQncyBwYWdlIHJlcXVlc3Qg
Z3JvdXAgZGVmaW5lZCBieSB0aGUKPiBQQ0kgU0lHIHNwZWMuIE11bHRpcGxlIHBhZ2UgcmVxdWVz
dHMgY291bGQgYmUgcHV0IGluIGEgZ3JvdXAgd2l0aCBhCj4gc2FtZSBncm91cCBpZC4gQWxsIHBh
Z2UgcmVxdWVzdHMgaW4gYSBncm91cCBjb3VsZCBiZSByZXNwb25kZWQgdG8gZGV2aWNlCj4gaW4g
b25lIHNob3QuCgpUaGFua3MgeW91ciBleHBsYWluYXRpb24sIHVuZGVyc3RhbmQgdGhlIGNvbmNl
cHQgb2YgUENJZSBQUkcuwqAgSSBtZWFudAoKZG8gd2Ugc3RpbGwgaGF2ZSB0aGUgbmVjZXNzaXR5
IHRvIG1lbnRpb24gdGhlICJncm91cCIgaGVyZSBpbiB0aGUgbmFtZQoKaW9wZl9oYW5kbGVfZ3Jv
dXAoKSzCoCB3aGljaCBvbmUgaXMgYmV0dGVyID8gaW9wZl9oYW5kbGVfcHJnKCkgb3IKCmlvcGZf
aGFuZGxlcigpLMKgIHBlcmhhcHMgbm9uZSBvZiB0aGVtID8gOikKCgpUaGFua3PvvIwKCkV0aGFu
Cgo+Cj4gQmVzdCByZWdhcmRzLAo+IGJhb2x1Cj4KPj4KPj4gbG9vayBpbnRvIHRoZSBjb2RlLCBv
aCwgbWVhbnMgYSBiYXRjaCAvIGxpc3QgLyBxdWV1ZcKgIG9mIGlvcGZzICwgYW5kIAo+PiBpb3Bm
X2hhbmRsZV9ncm91cCgpIGJlY29tZXMgYQo+Pgo+PiBnZW5lcmljIGlvcGZfaGFuZGxlcigpIC4K
Pj4KPj4gRG9lIGl0IG1ha2Ugc2Vuc2UgdG8gcmV2aXNlIHRoZSBuYW1lcyBvZiBpb3BmX2hhbmRs
ZV9ncm91cCgpLCAKPj4gaW9wZl9jb21wbGV0ZV9ncm91cCzCoCBpb3BmX2dyb3VwIGluCj4+Cj4+
IHRoaXMgcGF0Y2ggc2V0ID8KPj4KPj4KPj4gVGhhbmtzLAo+Pgo+PiBFdGhhbgo+Pgo+Pj4gwqAg
c3RhdGljIHZvaWQgaW9wZl9oYW5kbGVfZ3JvdXAoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+
Pj4gwqAgewo+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgaW9wZl9ncm91cCAqZ3JvdXA7Cj4+PiArwqDC
oMKgIHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbjsKPj4+IMKgwqDCoMKgwqAgc3RydWN0IGlv
cGZfZmF1bHQgKmlvcGYsICpuZXh0Owo+Pj4gwqDCoMKgwqDCoCBlbnVtIGlvbW11X3BhZ2VfcmVz
cG9uc2VfY29kZSBzdGF0dXMgPSBJT01NVV9QQUdFX1JFU1BfU1VDQ0VTUzsKPj4+IMKgwqDCoMKg
wqAgZ3JvdXAgPSBjb250YWluZXJfb2Yod29yaywgc3RydWN0IGlvcGZfZ3JvdXAsIHdvcmspOwo+
Pj4gK8KgwqDCoCBkb21haW4gPSBpb21tdV9nZXRfZG9tYWluX2Zvcl9kZXZfcGFzaWQoZ3JvdXAt
PmRldiwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ3JvdXAtPmxhc3RfZmF1
bHQuZmF1bHQucHJtLnBhc2lkKTsKPj4+ICvCoMKgwqAgaWYgKCFkb21haW4gfHwgIWRvbWFpbi0+
aW9wZl9oYW5kbGVyKQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHN0YXR1cyA9IElPTU1VX1BBR0VfUkVT
UF9JTlZBTElEOwo+Pj4gwqDCoMKgwqDCoCBsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoaW9wZiwg
bmV4dCwgJmdyb3VwLT5mYXVsdHMsIGxpc3QpIHsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAvKgo+
Pj4gQEAgLTEzOSw3ICs4OCw4IEBAIHN0YXRpYyB2b2lkIGlvcGZfaGFuZGxlX2dyb3VwKHN0cnVj
dCB3b3JrX3N0cnVjdCAKPj4+ICp3b3JrKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBmYXVs
dHMgaW4gdGhlIGdyb3VwIGlmIHRoZXJlIGlzIGFuIGVycm9yLgo+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKi8KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoc3RhdHVzID09IElPTU1VX1BBR0Vf
UkVTUF9TVUNDRVNTKQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhdHVzID0gaW9wZl9o
YW5kbGVfc2luZ2xlKGlvcGYpOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhdHVzID0g
ZG9tYWluLT5pb3BmX2hhbmRsZXIoJmlvcGYtPmZhdWx0LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZG9tYWluLT5mYXVsdF9k
YXRhKTsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIShpb3BmLT5mYXVsdC5wcm0uZmxhZ3Mg
Jgo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIElPTU1VX0ZBVUxUX1BBR0VfUkVR
VUVTVF9MQVNUX1BBR0UpKQo+Pgo+Ci0tIAoiZmlybSwgZW5kdXJpbmcsIHN0cm9uZywgYW5kIGxv
bmctbGl2ZWQiCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
