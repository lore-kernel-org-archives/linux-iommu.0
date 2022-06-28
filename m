Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE12EC433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 06:28:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A94060672;
	Tue, 28 Jun 2022 06:28:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A94060672
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ls9RLgZW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gBZN4zyFpHPl; Tue, 28 Jun 2022 06:28:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D98556058B;
	Tue, 28 Jun 2022 06:28:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D98556058B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5996C0039;
	Tue, 28 Jun 2022 06:28:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61670C002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 06:28:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2E4E682FC9
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 06:28:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2E4E682FC9
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ls9RLgZW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OPn3Ks5iwOv3 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 06:28:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58B8C814BA
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58B8C814BA
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 06:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656397701; x=1687933701;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=9IUUyhkLUoG7pm0kZNfCYFqtdjz75ZQTTtDHGO+EHGI=;
 b=ls9RLgZWL2bTspO5d1OP1H+7myZCnjX8UDIIlPY8aH6Eo7ddGCgDAu5B
 F85IiYPgac6Ae3jOy/RwvBg/7MErCLU5+0aWJOhyFPc4xxiVErfksvW9a
 26nz0sH1p0I6TfW92OwlUfiJ3iq+ygJ8y8MRJKhZFEBSN9QBjIGy4mQW3
 nvXG0WP+rpYGNxoC9f1NTBKB5xLPvHwlTPc0YsdcQqDUVWAj7Olfe6RqB
 1MB/1nThl7Uh+SCT+ArsLIDIU2h+dwNOuTRFYTzkuGTQe1TRnlnC8Ylya
 7/5kO6XNoPTX1EkVAhQBJpiYWUDxWp/IgWFNLHI5IDMebgPrCl/ztpn23 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="264690615"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="264690615"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2022 23:28:20 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="646773805"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64])
 ([10.249.169.64])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2022 23:28:16 -0700
Message-ID: <693a3604-d70b-e08c-2621-7f0cb9bdb6ca@linux.intel.com>
Date: Tue, 28 Jun 2022 14:28:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
 <faacb997-0c0a-04e1-903d-53857f463214@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <faacb997-0c0a-04e1-903d-53857f463214@linux.intel.com>
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

SGkgRXRoYW4sCgpPbiAyMDIyLzYvMjcgMjE6MDMsIEV0aGFuIFpoYW8gd3JvdGU6Cj4gSGksCj4g
Cj4g5ZyoIDIwMjIvNi8yMSAyMjo0MywgTHUgQmFvbHUg5YaZ6YGTOgo+PiBUd2VhayB0aGUgSS9P
IHBhZ2UgZmF1bHQgaGFuZGxpbmcgZnJhbWV3b3JrIHRvIHJvdXRlIHRoZSBwYWdlIGZhdWx0cyB0
bwo+PiB0aGUgZG9tYWluIGFuZCBjYWxsIHRoZSBwYWdlIGZhdWx0IGhhbmRsZXIgcmV0cmlldmVk
IGZyb20gdGhlIGRvbWFpbi4KPj4gVGhpcyBtYWtlcyB0aGUgSS9PIHBhZ2UgZmF1bHQgaGFuZGxp
bmcgZnJhbWV3b3JrIHBvc3NpYmxlIHRvIHNlcnZlIG1vcmUKPj4gdXNhZ2Ugc2NlbmFyaW9zIGFz
IGxvbmcgYXMgdGhleSBoYXZlIGFuIElPTU1VIGRvbWFpbiBhbmQgaW5zdGFsbCBhIHBhZ2UKPj4g
ZmF1bHQgaGFuZGxlciBpbiBpdC4gU29tZSB1bnVzZWQgZnVuY3Rpb25zIGFyZSBhbHNvIHJlbW92
ZWQgdG8gYXZvaWQKPj4gZGVhZCBjb2RlLgo+Pgo+PiBUaGUgaW9tbXVfZ2V0X2RvbWFpbl9mb3Jf
ZGV2X3Bhc2lkKCkgd2hpY2ggcmV0cmlldmVzIGF0dGFjaGVkIGRvbWFpbgo+PiBmb3IgYSB7ZGV2
aWNlLCBQQVNJRH0gcGFpciBpcyB1c2VkLiBJdCB3aWxsIGJlIHVzZWQgYnkgdGhlIHBhZ2UgZmF1
bHQKPj4gaGFuZGxpbmcgZnJhbWV3b3JrIHdoaWNoIGtub3dzIHtkZXZpY2UsIFBBU0lEfSByZXBv
cnRlZCBmcm9tIHRoZSBpb21tdQo+PiBkcml2ZXIuIFdlIGhhdmUgYSBndWFyYW50ZWUgdGhhdCB0
aGUgU1ZBIGRvbWFpbiBkb2Vzbid0IGdvIGF3YXkgZHVyaW5nCj4+IElPUEYgaGFuZGxpbmcsIGJl
Y2F1c2UgdW5iaW5kKCkgd2FpdHMgZm9yIHBlbmRpbmcgZmF1bHRzIHdpdGgKPj4gaW9wZl9xdWV1
ZV9mbHVzaF9kZXYoKSBiZWZvcmUgZnJlZWluZyB0aGUgZG9tYWluLiBIZW5jZSwgdGhlcmUncyBu
byBuZWVkCj4+IHRvIHN5bmNocm9uaXplIGxpZmUgY3ljbGUgb2YgdGhlIGlvbW11IGRvbWFpbnMg
YmV0d2VlbiB0aGUgdW5iaW5kKCkgYW5kCj4+IHRoZSBpbnRlcnJ1cHQgdGhyZWFkcy4KPj4KPj4g
U2lnbmVkLW9mZi1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4KPj4gUmV2
aWV3ZWQtYnk6IEplYW4tUGhpbGlwcGUgQnJ1Y2tlciA8amVhbi1waGlsaXBwZUBsaW5hcm8ub3Jn
Pgo+PiAtLS0KPj4gwqAgZHJpdmVycy9pb21tdS9pby1wZ2ZhdWx0LmMgfCA2NCArKysrKy0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNyBpbnNl
cnRpb25zKCspLCA1NyBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9t
bXUvaW8tcGdmYXVsdC5jIGIvZHJpdmVycy9pb21tdS9pby1wZ2ZhdWx0LmMKPj4gaW5kZXggYWVl
OWUwMzMwMTJmLi40ZjI0ZWM3MDM0NzkgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW8t
cGdmYXVsdC5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW8tcGdmYXVsdC5jCj4+IEBAIC02OSw2
OSArNjksMTggQEAgc3RhdGljIGludCBpb3BmX2NvbXBsZXRlX2dyb3VwKHN0cnVjdCBkZXZpY2Ug
KmRldiwgCj4+IHN0cnVjdCBpb3BmX2ZhdWx0ICppb3BmLAo+PiDCoMKgwqDCoMKgIHJldHVybiBp
b21tdV9wYWdlX3Jlc3BvbnNlKGRldiwgJnJlc3ApOwo+PiDCoCB9Cj4+IC1zdGF0aWMgZW51bSBp
b21tdV9wYWdlX3Jlc3BvbnNlX2NvZGUKPj4gLWlvcGZfaGFuZGxlX3NpbmdsZShzdHJ1Y3QgaW9w
Zl9mYXVsdCAqaW9wZikKPj4gLXsKPj4gLcKgwqDCoCB2bV9mYXVsdF90IHJldDsKPj4gLcKgwqDC
oCBzdHJ1Y3QgbW1fc3RydWN0ICptbTsKPj4gLcKgwqDCoCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3Qg
KnZtYTsKPj4gLcKgwqDCoCB1bnNpZ25lZCBpbnQgYWNjZXNzX2ZsYWdzID0gMDsKPj4gLcKgwqDC
oCB1bnNpZ25lZCBpbnQgZmF1bHRfZmxhZ3MgPSBGQVVMVF9GTEFHX1JFTU9URTsKPj4gLcKgwqDC
oCBzdHJ1Y3QgaW9tbXVfZmF1bHRfcGFnZV9yZXF1ZXN0ICpwcm0gPSAmaW9wZi0+ZmF1bHQucHJt
Owo+PiAtwqDCoMKgIGVudW0gaW9tbXVfcGFnZV9yZXNwb25zZV9jb2RlIHN0YXR1cyA9IElPTU1V
X1BBR0VfUkVTUF9JTlZBTElEOwo+PiAtCj4+IC3CoMKgwqAgaWYgKCEocHJtLT5mbGFncyAmIElP
TU1VX0ZBVUxUX1BBR0VfUkVRVUVTVF9QQVNJRF9WQUxJRCkpCj4+IC3CoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gc3RhdHVzOwo+PiAtCj4+IC3CoMKgwqAgbW0gPSBpb21tdV9zdmFfZmluZChwcm0tPnBh
c2lkKTsKPj4gLcKgwqDCoCBpZiAoSVNfRVJSX09SX05VTEwobW0pKQo+PiAtwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIHN0YXR1czsKPj4gLQo+PiAtwqDCoMKgIG1tYXBfcmVhZF9sb2NrKG1tKTsKPj4g
LQo+PiAtwqDCoMKgIHZtYSA9IGZpbmRfZXh0ZW5kX3ZtYShtbSwgcHJtLT5hZGRyKTsKPj4gLcKg
wqDCoCBpZiAoIXZtYSkKPj4gLcKgwqDCoMKgwqDCoMKgIC8qIFVubWFwcGVkIGFyZWEgKi8KPj4g
LcKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X3B1dF9tbTsKPj4gLQo+PiAtwqDCoMKgIGlmIChwcm0t
PnBlcm0gJiBJT01NVV9GQVVMVF9QRVJNX1JFQUQpCj4+IC3CoMKgwqDCoMKgwqDCoCBhY2Nlc3Nf
ZmxhZ3MgfD0gVk1fUkVBRDsKPj4gLQo+PiAtwqDCoMKgIGlmIChwcm0tPnBlcm0gJiBJT01NVV9G
QVVMVF9QRVJNX1dSSVRFKSB7Cj4+IC3CoMKgwqDCoMKgwqDCoCBhY2Nlc3NfZmxhZ3MgfD0gVk1f
V1JJVEU7Cj4+IC3CoMKgwqDCoMKgwqDCoCBmYXVsdF9mbGFncyB8PSBGQVVMVF9GTEFHX1dSSVRF
Owo+PiAtwqDCoMKgIH0KPj4gLQo+PiAtwqDCoMKgIGlmIChwcm0tPnBlcm0gJiBJT01NVV9GQVVM
VF9QRVJNX0VYRUMpIHsKPj4gLcKgwqDCoMKgwqDCoMKgIGFjY2Vzc19mbGFncyB8PSBWTV9FWEVD
Owo+PiAtwqDCoMKgwqDCoMKgwqAgZmF1bHRfZmxhZ3MgfD0gRkFVTFRfRkxBR19JTlNUUlVDVElP
TjsKPj4gLcKgwqDCoCB9Cj4+IC0KPj4gLcKgwqDCoCBpZiAoIShwcm0tPnBlcm0gJiBJT01NVV9G
QVVMVF9QRVJNX1BSSVYpKQo+PiAtwqDCoMKgwqDCoMKgwqAgZmF1bHRfZmxhZ3MgfD0gRkFVTFRf
RkxBR19VU0VSOwo+PiAtCj4+IC3CoMKgwqAgaWYgKGFjY2Vzc19mbGFncyAmIH52bWEtPnZtX2Zs
YWdzKQo+PiAtwqDCoMKgwqDCoMKgwqAgLyogQWNjZXNzIGZhdWx0ICovCj4+IC3CoMKgwqDCoMKg
wqDCoCBnb3RvIG91dF9wdXRfbW07Cj4+IC0KPj4gLcKgwqDCoCByZXQgPSBoYW5kbGVfbW1fZmF1
bHQodm1hLCBwcm0tPmFkZHIsIGZhdWx0X2ZsYWdzLCBOVUxMKTsKPj4gLcKgwqDCoCBzdGF0dXMg
PSByZXQgJiBWTV9GQVVMVF9FUlJPUiA/IElPTU1VX1BBR0VfUkVTUF9JTlZBTElEIDoKPj4gLcKg
wqDCoMKgwqDCoMKgIElPTU1VX1BBR0VfUkVTUF9TVUNDRVNTOwo+PiAtCj4+IC1vdXRfcHV0X21t
Ogo+PiAtwqDCoMKgIG1tYXBfcmVhZF91bmxvY2sobW0pOwo+PiAtwqDCoMKgIG1tcHV0KG1tKTsK
Pj4gLQo+PiAtwqDCoMKgIHJldHVybiBzdGF0dXM7Cj4+IC19Cj4+IC0KPiAKPiBPbmNlIHRoZSBp
b3BmX2hhbmRsZV9zaW5nbGUoKSBpcyByZW1vdmVkLCB0aGUgbmFtZSBvZiAKPiBpb3BmX2hhbmRs
ZV9ncm91cCgpIGxvb2tzIGEgbGl0dGxlIHdlaXJlZAo+IAo+IGFuZCBjb25mdXNlZCwgZG9lcyB0
aGlzIGdyb3VwIG1lYW4gdGhlIGlvbW11IGdyb3VwIChkb21haW4pID8gd2hpbGUgSSAKPiB0YWtl
IHNvbWUgbWludXRlcyB0bwoKTm8uIFRoaXMgaXMgbm90IHRoZSBpb21tdSBncm91cC4gSXQncyBw
YWdlIHJlcXVlc3QgZ3JvdXAgZGVmaW5lZCBieSB0aGUKUENJIFNJRyBzcGVjLiBNdWx0aXBsZSBw
YWdlIHJlcXVlc3RzIGNvdWxkIGJlIHB1dCBpbiBhIGdyb3VwIHdpdGggYQpzYW1lIGdyb3VwIGlk
LiBBbGwgcGFnZSByZXF1ZXN0cyBpbiBhIGdyb3VwIGNvdWxkIGJlIHJlc3BvbmRlZCB0byBkZXZp
Y2UKaW4gb25lIHNob3QuCgpCZXN0IHJlZ2FyZHMsCmJhb2x1Cgo+IAo+IGxvb2sgaW50byB0aGUg
Y29kZSwgb2gsIG1lYW5zIGEgYmF0Y2ggLyBsaXN0IC8gcXVldWXCoCBvZiBpb3BmcyAsIGFuZCAK
PiBpb3BmX2hhbmRsZV9ncm91cCgpIGJlY29tZXMgYQo+IAo+IGdlbmVyaWMgaW9wZl9oYW5kbGVy
KCkgLgo+IAo+IERvZSBpdCBtYWtlIHNlbnNlIHRvIHJldmlzZSB0aGUgbmFtZXMgb2YgaW9wZl9o
YW5kbGVfZ3JvdXAoKSwgCj4gaW9wZl9jb21wbGV0ZV9ncm91cCzCoCBpb3BmX2dyb3VwIGluCj4g
Cj4gdGhpcyBwYXRjaCBzZXQgPwo+IAo+IAo+IFRoYW5rcywKPiAKPiBFdGhhbgo+IAo+PiDCoCBz
dGF0aWMgdm9pZCBpb3BmX2hhbmRsZV9ncm91cChzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCj4+
IMKgIHsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgaW9wZl9ncm91cCAqZ3JvdXA7Cj4+ICvCoMKgwqAg
c3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCBpb3BmX2Zh
dWx0ICppb3BmLCAqbmV4dDsKPj4gwqDCoMKgwqDCoCBlbnVtIGlvbW11X3BhZ2VfcmVzcG9uc2Vf
Y29kZSBzdGF0dXMgPSBJT01NVV9QQUdFX1JFU1BfU1VDQ0VTUzsKPj4gwqDCoMKgwqDCoCBncm91
cCA9IGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgaW9wZl9ncm91cCwgd29yayk7Cj4+ICvCoMKg
wqAgZG9tYWluID0gaW9tbXVfZ2V0X2RvbWFpbl9mb3JfZGV2X3Bhc2lkKGdyb3VwLT5kZXYsCj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ3JvdXAtPmxhc3RfZmF1bHQuZmF1bHQu
cHJtLnBhc2lkKTsKPj4gK8KgwqDCoCBpZiAoIWRvbWFpbiB8fCAhZG9tYWluLT5pb3BmX2hhbmRs
ZXIpCj4+ICvCoMKgwqDCoMKgwqDCoCBzdGF0dXMgPSBJT01NVV9QQUdFX1JFU1BfSU5WQUxJRDsK
Pj4gwqDCoMKgwqDCoCBsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoaW9wZiwgbmV4dCwgJmdyb3Vw
LT5mYXVsdHMsIGxpc3QpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIC8qCj4+IEBAIC0xMzksNyAr
ODgsOCBAQCBzdGF0aWMgdm9pZCBpb3BmX2hhbmRsZV9ncm91cChzdHJ1Y3Qgd29ya19zdHJ1Y3Qg
Cj4+ICp3b3JrKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGZhdWx0cyBpbiB0aGUgZ3JvdXAg
aWYgdGhlcmUgaXMgYW4gZXJyb3IuCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAoc3RhdHVzID09IElPTU1VX1BBR0VfUkVTUF9TVUNDRVNTKQo+PiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdGF0dXMgPSBpb3BmX2hhbmRsZV9zaW5nbGUoaW9wZik7
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXR1cyA9IGRvbWFpbi0+aW9wZl9oYW5kbGVy
KCZpb3BmLT5mYXVsdCwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZG9tYWluLT5mYXVsdF9kYXRhKTsKPj4gwqDCoMKgwqDCoMKg
wqDCoMKgIGlmICghKGlvcGYtPmZhdWx0LnBybS5mbGFncyAmCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBJT01NVV9GQVVMVF9QQUdFX1JFUVVFU1RfTEFTVF9QQUdFKSkKPiAKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxp
bmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
