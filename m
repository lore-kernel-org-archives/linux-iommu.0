Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EC1C43334
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 11:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2CDCB408B2;
	Tue, 28 Jun 2022 11:53:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2CDCB408B2
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L7LDzEAW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3rdK1NW8rA-7; Tue, 28 Jun 2022 11:53:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 73F39408A1;
	Tue, 28 Jun 2022 11:53:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 73F39408A1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46B68C0032;
	Tue, 28 Jun 2022 11:53:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD29CC002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 11:53:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E3798141E
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 11:53:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E3798141E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=L7LDzEAW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5lehAtZNuBUA for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 11:53:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86CCE81414
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 86CCE81414
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 11:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656417226; x=1687953226;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Ajn0hyQvZuCFAHtCWj0xQ7s0Zvw6UN66/hjKZRjJUTE=;
 b=L7LDzEAWQHQBWE0ACEy0GicvnRSUxcK/muW/fhiNj/n5dqTlfBrQktta
 fRmR5quhed6kHIryOn295rhFiLHV3NwbcFKRhfpeamtwSOQ++eY98EJN3
 fnAMszuC8iEXpKV9GOxLlluQZp/yUfsWUOnqdECCi8jbJ3jZgseiMotQk
 C/4Zxd7wHJQkjbl/7vKynH1HgLi2SkBDgvh2on3/vxZa+lCt/FKpG8pKc
 OKgTlSDsb2ppEQ2/70PR+K6zJxA7PdzOCMyLwO2aucc+O54tr2dpmynPY
 RrvyIlNjYKRbjqE6leBPnMhF3zSw3XNUct7K+9uceLmAl1OBRNRDqRuj+ A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="279265602"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="279265602"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 04:53:45 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="646882963"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64])
 ([10.249.169.64])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 04:53:41 -0700
Message-ID: <935ca9e3-28c9-99af-5609-41bb1500b2b3@linux.intel.com>
Date: Tue, 28 Jun 2022 19:53:39 +0800
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
 <693a3604-d70b-e08c-2621-7f0cb9bdb6ca@linux.intel.com>
 <75b17c70-1658-91ea-0992-1be769550943@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <75b17c70-1658-91ea-0992-1be769550943@linux.intel.com>
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

T24gMjAyMi82LzI4IDE3OjEwLCBFdGhhbiBaaGFvIHdyb3RlOgo+IEhpLCBCYW9sdQo+IAo+IOWc
qCAyMDIyLzYvMjggMTQ6MjgsIEJhb2x1IEx1IOWGmemBkzoKPj4gSGkgRXRoYW4sCj4+Cj4+IE9u
IDIwMjIvNi8yNyAyMTowMywgRXRoYW4gWmhhbyB3cm90ZToKPj4+IEhpLAo+Pj4KPj4+IOWcqCAy
MDIyLzYvMjEgMjI6NDMsIEx1IEJhb2x1IOWGmemBkzoKPj4+PiBUd2VhayB0aGUgSS9PIHBhZ2Ug
ZmF1bHQgaGFuZGxpbmcgZnJhbWV3b3JrIHRvIHJvdXRlIHRoZSBwYWdlIGZhdWx0cyB0bwo+Pj4+
IHRoZSBkb21haW4gYW5kIGNhbGwgdGhlIHBhZ2UgZmF1bHQgaGFuZGxlciByZXRyaWV2ZWQgZnJv
bSB0aGUgZG9tYWluLgo+Pj4+IFRoaXMgbWFrZXMgdGhlIEkvTyBwYWdlIGZhdWx0IGhhbmRsaW5n
IGZyYW1ld29yayBwb3NzaWJsZSB0byBzZXJ2ZSBtb3JlCj4+Pj4gdXNhZ2Ugc2NlbmFyaW9zIGFz
IGxvbmcgYXMgdGhleSBoYXZlIGFuIElPTU1VIGRvbWFpbiBhbmQgaW5zdGFsbCBhIHBhZ2UKPj4+
PiBmYXVsdCBoYW5kbGVyIGluIGl0LiBTb21lIHVudXNlZCBmdW5jdGlvbnMgYXJlIGFsc28gcmVt
b3ZlZCB0byBhdm9pZAo+Pj4+IGRlYWQgY29kZS4KPj4+Pgo+Pj4+IFRoZSBpb21tdV9nZXRfZG9t
YWluX2Zvcl9kZXZfcGFzaWQoKSB3aGljaCByZXRyaWV2ZXMgYXR0YWNoZWQgZG9tYWluCj4+Pj4g
Zm9yIGEge2RldmljZSwgUEFTSUR9IHBhaXIgaXMgdXNlZC4gSXQgd2lsbCBiZSB1c2VkIGJ5IHRo
ZSBwYWdlIGZhdWx0Cj4+Pj4gaGFuZGxpbmcgZnJhbWV3b3JrIHdoaWNoIGtub3dzIHtkZXZpY2Us
IFBBU0lEfSByZXBvcnRlZCBmcm9tIHRoZSBpb21tdQo+Pj4+IGRyaXZlci4gV2UgaGF2ZSBhIGd1
YXJhbnRlZSB0aGF0IHRoZSBTVkEgZG9tYWluIGRvZXNuJ3QgZ28gYXdheSBkdXJpbmcKPj4+PiBJ
T1BGIGhhbmRsaW5nLCBiZWNhdXNlIHVuYmluZCgpIHdhaXRzIGZvciBwZW5kaW5nIGZhdWx0cyB3
aXRoCj4+Pj4gaW9wZl9xdWV1ZV9mbHVzaF9kZXYoKSBiZWZvcmUgZnJlZWluZyB0aGUgZG9tYWlu
LiBIZW5jZSwgdGhlcmUncyBubyAKPj4+PiBuZWVkCj4+Pj4gdG8gc3luY2hyb25pemUgbGlmZSBj
eWNsZSBvZiB0aGUgaW9tbXUgZG9tYWlucyBiZXR3ZWVuIHRoZSB1bmJpbmQoKSBhbmQKPj4+PiB0
aGUgaW50ZXJydXB0IHRocmVhZHMuCj4+Pj4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBMdSBCYW9sdSA8
YmFvbHUubHVAbGludXguaW50ZWwuY29tPgo+Pj4+IFJldmlld2VkLWJ5OiBKZWFuLVBoaWxpcHBl
IEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZz4KPj4+PiAtLS0KPj4+PiDCoCBkcml2
ZXJzL2lvbW11L2lvLXBnZmF1bHQuYyB8IDY0IAo+Pj4+ICsrKysrLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCj4+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwg
NTcgZGVsZXRpb25zKC0pCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pby1w
Z2ZhdWx0LmMgYi9kcml2ZXJzL2lvbW11L2lvLXBnZmF1bHQuYwo+Pj4+IGluZGV4IGFlZTllMDMz
MDEyZi4uNGYyNGVjNzAzNDc5IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW8tcGdm
YXVsdC5jCj4+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9pby1wZ2ZhdWx0LmMKPj4+PiBAQCAtNjks
NjkgKzY5LDE4IEBAIHN0YXRpYyBpbnQgaW9wZl9jb21wbGV0ZV9ncm91cChzdHJ1Y3QgZGV2aWNl
IAo+Pj4+ICpkZXYsIHN0cnVjdCBpb3BmX2ZhdWx0ICppb3BmLAo+Pj4+IMKgwqDCoMKgwqAgcmV0
dXJuIGlvbW11X3BhZ2VfcmVzcG9uc2UoZGV2LCAmcmVzcCk7Cj4+Pj4gwqAgfQo+Pj4+IC1zdGF0
aWMgZW51bSBpb21tdV9wYWdlX3Jlc3BvbnNlX2NvZGUKPj4+PiAtaW9wZl9oYW5kbGVfc2luZ2xl
KHN0cnVjdCBpb3BmX2ZhdWx0ICppb3BmKQo+Pj4+IC17Cj4+Pj4gLcKgwqDCoCB2bV9mYXVsdF90
IHJldDsKPj4+PiAtwqDCoMKgIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tOwo+Pj4+IC3CoMKgwqAgc3Ry
dWN0IHZtX2FyZWFfc3RydWN0ICp2bWE7Cj4+Pj4gLcKgwqDCoCB1bnNpZ25lZCBpbnQgYWNjZXNz
X2ZsYWdzID0gMDsKPj4+PiAtwqDCoMKgIHVuc2lnbmVkIGludCBmYXVsdF9mbGFncyA9IEZBVUxU
X0ZMQUdfUkVNT1RFOwo+Pj4+IC3CoMKgwqAgc3RydWN0IGlvbW11X2ZhdWx0X3BhZ2VfcmVxdWVz
dCAqcHJtID0gJmlvcGYtPmZhdWx0LnBybTsKPj4+PiAtwqDCoMKgIGVudW0gaW9tbXVfcGFnZV9y
ZXNwb25zZV9jb2RlIHN0YXR1cyA9IElPTU1VX1BBR0VfUkVTUF9JTlZBTElEOwo+Pj4+IC0KPj4+
PiAtwqDCoMKgIGlmICghKHBybS0+ZmxhZ3MgJiBJT01NVV9GQVVMVF9QQUdFX1JFUVVFU1RfUEFT
SURfVkFMSUQpKQo+Pj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gc3RhdHVzOwo+Pj4+IC0KPj4+
PiAtwqDCoMKgIG1tID0gaW9tbXVfc3ZhX2ZpbmQocHJtLT5wYXNpZCk7Cj4+Pj4gLcKgwqDCoCBp
ZiAoSVNfRVJSX09SX05VTEwobW0pKQo+Pj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gc3RhdHVz
Owo+Pj4+IC0KPj4+PiAtwqDCoMKgIG1tYXBfcmVhZF9sb2NrKG1tKTsKPj4+PiAtCj4+Pj4gLcKg
wqDCoCB2bWEgPSBmaW5kX2V4dGVuZF92bWEobW0sIHBybS0+YWRkcik7Cj4+Pj4gLcKgwqDCoCBp
ZiAoIXZtYSkKPj4+PiAtwqDCoMKgwqDCoMKgwqAgLyogVW5tYXBwZWQgYXJlYSAqLwo+Pj4+IC3C
oMKgwqDCoMKgwqDCoCBnb3RvIG91dF9wdXRfbW07Cj4+Pj4gLQo+Pj4+IC3CoMKgwqAgaWYgKHBy
bS0+cGVybSAmIElPTU1VX0ZBVUxUX1BFUk1fUkVBRCkKPj4+PiAtwqDCoMKgwqDCoMKgwqAgYWNj
ZXNzX2ZsYWdzIHw9IFZNX1JFQUQ7Cj4+Pj4gLQo+Pj4+IC3CoMKgwqAgaWYgKHBybS0+cGVybSAm
IElPTU1VX0ZBVUxUX1BFUk1fV1JJVEUpIHsKPj4+PiAtwqDCoMKgwqDCoMKgwqAgYWNjZXNzX2Zs
YWdzIHw9IFZNX1dSSVRFOwo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBmYXVsdF9mbGFncyB8PSBGQVVM
VF9GTEFHX1dSSVRFOwo+Pj4+IC3CoMKgwqAgfQo+Pj4+IC0KPj4+PiAtwqDCoMKgIGlmIChwcm0t
PnBlcm0gJiBJT01NVV9GQVVMVF9QRVJNX0VYRUMpIHsKPj4+PiAtwqDCoMKgwqDCoMKgwqAgYWNj
ZXNzX2ZsYWdzIHw9IFZNX0VYRUM7Cj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGZhdWx0X2ZsYWdzIHw9
IEZBVUxUX0ZMQUdfSU5TVFJVQ1RJT047Cj4+Pj4gLcKgwqDCoCB9Cj4+Pj4gLQo+Pj4+IC3CoMKg
wqAgaWYgKCEocHJtLT5wZXJtICYgSU9NTVVfRkFVTFRfUEVSTV9QUklWKSkKPj4+PiAtwqDCoMKg
wqDCoMKgwqAgZmF1bHRfZmxhZ3MgfD0gRkFVTFRfRkxBR19VU0VSOwo+Pj4+IC0KPj4+PiAtwqDC
oMKgIGlmIChhY2Nlc3NfZmxhZ3MgJiB+dm1hLT52bV9mbGFncykKPj4+PiAtwqDCoMKgwqDCoMKg
wqAgLyogQWNjZXNzIGZhdWx0ICovCj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0X3B1dF9t
bTsKPj4+PiAtCj4+Pj4gLcKgwqDCoCByZXQgPSBoYW5kbGVfbW1fZmF1bHQodm1hLCBwcm0tPmFk
ZHIsIGZhdWx0X2ZsYWdzLCBOVUxMKTsKPj4+PiAtwqDCoMKgIHN0YXR1cyA9IHJldCAmIFZNX0ZB
VUxUX0VSUk9SID8gSU9NTVVfUEFHRV9SRVNQX0lOVkFMSUQgOgo+Pj4+IC3CoMKgwqDCoMKgwqDC
oCBJT01NVV9QQUdFX1JFU1BfU1VDQ0VTUzsKPj4+PiAtCj4+Pj4gLW91dF9wdXRfbW06Cj4+Pj4g
LcKgwqDCoCBtbWFwX3JlYWRfdW5sb2NrKG1tKTsKPj4+PiAtwqDCoMKgIG1tcHV0KG1tKTsKPj4+
PiAtCj4+Pj4gLcKgwqDCoCByZXR1cm4gc3RhdHVzOwo+Pj4+IC19Cj4+Pj4gLQo+Pj4KPj4+IE9u
Y2UgdGhlIGlvcGZfaGFuZGxlX3NpbmdsZSgpIGlzIHJlbW92ZWQsIHRoZSBuYW1lIG9mIAo+Pj4g
aW9wZl9oYW5kbGVfZ3JvdXAoKSBsb29rcyBhIGxpdHRsZSB3ZWlyZWQKPj4+Cj4+PiBhbmQgY29u
ZnVzZWQsIGRvZXMgdGhpcyBncm91cCBtZWFuIHRoZSBpb21tdSBncm91cCAoZG9tYWluKSA/IHdo
aWxlIEkgCj4+PiB0YWtlIHNvbWUgbWludXRlcyB0bwo+Pgo+PiBOby4gVGhpcyBpcyBub3QgdGhl
IGlvbW11IGdyb3VwLiBJdCdzIHBhZ2UgcmVxdWVzdCBncm91cCBkZWZpbmVkIGJ5IHRoZQo+PiBQ
Q0kgU0lHIHNwZWMuIE11bHRpcGxlIHBhZ2UgcmVxdWVzdHMgY291bGQgYmUgcHV0IGluIGEgZ3Jv
dXAgd2l0aCBhCj4+IHNhbWUgZ3JvdXAgaWQuIEFsbCBwYWdlIHJlcXVlc3RzIGluIGEgZ3JvdXAg
Y291bGQgYmUgcmVzcG9uZGVkIHRvIGRldmljZQo+PiBpbiBvbmUgc2hvdC4KPiAKPiBUaGFua3Mg
eW91ciBleHBsYWluYXRpb24sIHVuZGVyc3RhbmQgdGhlIGNvbmNlcHQgb2YgUENJZSBQUkcuwqAg
SSBtZWFudAo+IAo+IGRvIHdlIHN0aWxsIGhhdmUgdGhlIG5lY2Vzc2l0eSB0byBtZW50aW9uIHRo
ZSAiZ3JvdXAiIGhlcmUgaW4gdGhlIG5hbWUKPiAKPiBpb3BmX2hhbmRsZV9ncm91cCgpLMKgIHdo
aWNoIG9uZSBpcyBiZXR0ZXIgPyBpb3BmX2hhbmRsZV9wcmcoKSBvcgo+IAo+IGlvcGZfaGFuZGxl
cigpLMKgIHBlcmhhcHMgbm9uZSBvZiB0aGVtID8gOikKCk9oISBTb3JyeSBmb3IgdGhlIG1pc3Vu
ZGVyc3RhbmRpbmcuCgpJIGhhdmUgbm8gc3Ryb25nIGZlZWxpbmcgdG8gY2hhbmdlIHRoaXMgbmFt
aW5nLiA6LSkgQWxsIHRoZSBuYW1lcwpleHByZXNzIHdoYXQgdGhlIGhlbHBlciBkb2VzLiBKZWFu
IGlzIHRoZSBhdXRob3Igb2YgdGhpcyBmcmFtZXdvcmsuIElmCmhlIGhhcyB0aGUgc2FtZSBpZGVh
IGFzIHlvdSwgSSBkb24ndCBtaW5kIHJlbmFtaW5nIGl0IGluIHRoaXMgcGF0Y2guCgpCZXN0IHJl
Z2FyZHMsCmJhb2x1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
