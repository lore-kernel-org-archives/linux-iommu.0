Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D13C43334
	for <iommu@archiver.kernel.org>; Mon, 27 Jun 2022 13:04:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 525156106A;
	Mon, 27 Jun 2022 13:04:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 525156106A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PMmxpXtH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mWJTROsnWEDV; Mon, 27 Jun 2022 13:04:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 00C6160BB4;
	Mon, 27 Jun 2022 13:04:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 00C6160BB4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB9C2C0032;
	Mon, 27 Jun 2022 13:04:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE799C002D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 13:04:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8999560BD2
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 13:04:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8999560BD2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JIBBAcNpj2Fj for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 13:04:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01D7860BB4
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 01D7860BB4
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jun 2022 13:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656335041; x=1687871041;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=pvt1FnCHqt1/XWnPYD13BBulCVA6oKyVYSxAmRYprsc=;
 b=PMmxpXtHAE7quvc3kgcYlCK0mbRB60OPGYe895lPdnRtXANeANQp4vCJ
 v8GyEL2+/gFm1WOb06+MSxfjSUDvWgRXk9F1bKme3FPwOVSQIJ8D8o/pI
 kplBcBA2R5yBD6xg9XiC9JJMD6AvkIQBxtqF7xAa9XrEc/NFLzuRascN6
 ChRVvuMbuI0RWceJTPMxFEv2vKc2RFFYTC2R1OrRiQu7qou1iWJTxIynL
 HOb5kQiaOZTaAkhPLFY4Nm2FSdGluQqfnuv5P0/xjIxM0A/uaWtb6m2ik
 ZEmpPgZquA3haAhUP8cBtNZzTmrWhDjDsagMgql0y5UGbAbuCjyQVGuab A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="282535787"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; d="scan'208";a="282535787"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2022 06:03:59 -0700
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; d="scan'208";a="646418348"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.254.210.224])
 ([10.254.210.224])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2022 06:03:55 -0700
Message-ID: <faacb997-0c0a-04e1-903d-53857f463214@linux.intel.com>
Date: Mon, 27 Jun 2022 21:03:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20220621144353.17547-11-baolu.lu@linux.intel.com>
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

SGksCgrlnKggMjAyMi82LzIxIDIyOjQzLCBMdSBCYW9sdSDlhpnpgZM6Cj4gVHdlYWsgdGhlIEkv
TyBwYWdlIGZhdWx0IGhhbmRsaW5nIGZyYW1ld29yayB0byByb3V0ZSB0aGUgcGFnZSBmYXVsdHMg
dG8KPiB0aGUgZG9tYWluIGFuZCBjYWxsIHRoZSBwYWdlIGZhdWx0IGhhbmRsZXIgcmV0cmlldmVk
IGZyb20gdGhlIGRvbWFpbi4KPiBUaGlzIG1ha2VzIHRoZSBJL08gcGFnZSBmYXVsdCBoYW5kbGlu
ZyBmcmFtZXdvcmsgcG9zc2libGUgdG8gc2VydmUgbW9yZQo+IHVzYWdlIHNjZW5hcmlvcyBhcyBs
b25nIGFzIHRoZXkgaGF2ZSBhbiBJT01NVSBkb21haW4gYW5kIGluc3RhbGwgYSBwYWdlCj4gZmF1
bHQgaGFuZGxlciBpbiBpdC4gU29tZSB1bnVzZWQgZnVuY3Rpb25zIGFyZSBhbHNvIHJlbW92ZWQg
dG8gYXZvaWQKPiBkZWFkIGNvZGUuCj4KPiBUaGUgaW9tbXVfZ2V0X2RvbWFpbl9mb3JfZGV2X3Bh
c2lkKCkgd2hpY2ggcmV0cmlldmVzIGF0dGFjaGVkIGRvbWFpbgo+IGZvciBhIHtkZXZpY2UsIFBB
U0lEfSBwYWlyIGlzIHVzZWQuIEl0IHdpbGwgYmUgdXNlZCBieSB0aGUgcGFnZSBmYXVsdAo+IGhh
bmRsaW5nIGZyYW1ld29yayB3aGljaCBrbm93cyB7ZGV2aWNlLCBQQVNJRH0gcmVwb3J0ZWQgZnJv
bSB0aGUgaW9tbXUKPiBkcml2ZXIuIFdlIGhhdmUgYSBndWFyYW50ZWUgdGhhdCB0aGUgU1ZBIGRv
bWFpbiBkb2Vzbid0IGdvIGF3YXkgZHVyaW5nCj4gSU9QRiBoYW5kbGluZywgYmVjYXVzZSB1bmJp
bmQoKSB3YWl0cyBmb3IgcGVuZGluZyBmYXVsdHMgd2l0aAo+IGlvcGZfcXVldWVfZmx1c2hfZGV2
KCkgYmVmb3JlIGZyZWVpbmcgdGhlIGRvbWFpbi4gSGVuY2UsIHRoZXJlJ3Mgbm8gbmVlZAo+IHRv
IHN5bmNocm9uaXplIGxpZmUgY3ljbGUgb2YgdGhlIGlvbW11IGRvbWFpbnMgYmV0d2VlbiB0aGUg
dW5iaW5kKCkgYW5kCj4gdGhlIGludGVycnVwdCB0aHJlYWRzLgo+Cj4gU2lnbmVkLW9mZi1ieTog
THUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4KPiBSZXZpZXdlZC1ieTogSmVhbi1Q
aGlsaXBwZSBCcnVja2VyIDxqZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc+Cj4gLS0tCj4gICBkcml2
ZXJzL2lvbW11L2lvLXBnZmF1bHQuYyB8IDY0ICsrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA1NyBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvLXBnZmF1bHQuYyBiL2RyaXZl
cnMvaW9tbXUvaW8tcGdmYXVsdC5jCj4gaW5kZXggYWVlOWUwMzMwMTJmLi40ZjI0ZWM3MDM0Nzkg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9pb21tdS9pby1wZ2ZhdWx0LmMKPiArKysgYi9kcml2ZXJz
L2lvbW11L2lvLXBnZmF1bHQuYwo+IEBAIC02OSw2OSArNjksMTggQEAgc3RhdGljIGludCBpb3Bm
X2NvbXBsZXRlX2dyb3VwKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGlvcGZfZmF1bHQgKmlv
cGYsCj4gICAJcmV0dXJuIGlvbW11X3BhZ2VfcmVzcG9uc2UoZGV2LCAmcmVzcCk7Cj4gICB9Cj4g
ICAKPiAtc3RhdGljIGVudW0gaW9tbXVfcGFnZV9yZXNwb25zZV9jb2RlCj4gLWlvcGZfaGFuZGxl
X3NpbmdsZShzdHJ1Y3QgaW9wZl9mYXVsdCAqaW9wZikKPiAtewo+IC0Jdm1fZmF1bHRfdCByZXQ7
Cj4gLQlzdHJ1Y3QgbW1fc3RydWN0ICptbTsKPiAtCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1h
Owo+IC0JdW5zaWduZWQgaW50IGFjY2Vzc19mbGFncyA9IDA7Cj4gLQl1bnNpZ25lZCBpbnQgZmF1
bHRfZmxhZ3MgPSBGQVVMVF9GTEFHX1JFTU9URTsKPiAtCXN0cnVjdCBpb21tdV9mYXVsdF9wYWdl
X3JlcXVlc3QgKnBybSA9ICZpb3BmLT5mYXVsdC5wcm07Cj4gLQllbnVtIGlvbW11X3BhZ2VfcmVz
cG9uc2VfY29kZSBzdGF0dXMgPSBJT01NVV9QQUdFX1JFU1BfSU5WQUxJRDsKPiAtCj4gLQlpZiAo
IShwcm0tPmZsYWdzICYgSU9NTVVfRkFVTFRfUEFHRV9SRVFVRVNUX1BBU0lEX1ZBTElEKSkKPiAt
CQlyZXR1cm4gc3RhdHVzOwo+IC0KPiAtCW1tID0gaW9tbXVfc3ZhX2ZpbmQocHJtLT5wYXNpZCk7
Cj4gLQlpZiAoSVNfRVJSX09SX05VTEwobW0pKQo+IC0JCXJldHVybiBzdGF0dXM7Cj4gLQo+IC0J
bW1hcF9yZWFkX2xvY2sobW0pOwo+IC0KPiAtCXZtYSA9IGZpbmRfZXh0ZW5kX3ZtYShtbSwgcHJt
LT5hZGRyKTsKPiAtCWlmICghdm1hKQo+IC0JCS8qIFVubWFwcGVkIGFyZWEgKi8KPiAtCQlnb3Rv
IG91dF9wdXRfbW07Cj4gLQo+IC0JaWYgKHBybS0+cGVybSAmIElPTU1VX0ZBVUxUX1BFUk1fUkVB
RCkKPiAtCQlhY2Nlc3NfZmxhZ3MgfD0gVk1fUkVBRDsKPiAtCj4gLQlpZiAocHJtLT5wZXJtICYg
SU9NTVVfRkFVTFRfUEVSTV9XUklURSkgewo+IC0JCWFjY2Vzc19mbGFncyB8PSBWTV9XUklURTsK
PiAtCQlmYXVsdF9mbGFncyB8PSBGQVVMVF9GTEFHX1dSSVRFOwo+IC0JfQo+IC0KPiAtCWlmIChw
cm0tPnBlcm0gJiBJT01NVV9GQVVMVF9QRVJNX0VYRUMpIHsKPiAtCQlhY2Nlc3NfZmxhZ3MgfD0g
Vk1fRVhFQzsKPiAtCQlmYXVsdF9mbGFncyB8PSBGQVVMVF9GTEFHX0lOU1RSVUNUSU9OOwo+IC0J
fQo+IC0KPiAtCWlmICghKHBybS0+cGVybSAmIElPTU1VX0ZBVUxUX1BFUk1fUFJJVikpCj4gLQkJ
ZmF1bHRfZmxhZ3MgfD0gRkFVTFRfRkxBR19VU0VSOwo+IC0KPiAtCWlmIChhY2Nlc3NfZmxhZ3Mg
JiB+dm1hLT52bV9mbGFncykKPiAtCQkvKiBBY2Nlc3MgZmF1bHQgKi8KPiAtCQlnb3RvIG91dF9w
dXRfbW07Cj4gLQo+IC0JcmV0ID0gaGFuZGxlX21tX2ZhdWx0KHZtYSwgcHJtLT5hZGRyLCBmYXVs
dF9mbGFncywgTlVMTCk7Cj4gLQlzdGF0dXMgPSByZXQgJiBWTV9GQVVMVF9FUlJPUiA/IElPTU1V
X1BBR0VfUkVTUF9JTlZBTElEIDoKPiAtCQlJT01NVV9QQUdFX1JFU1BfU1VDQ0VTUzsKPiAtCj4g
LW91dF9wdXRfbW06Cj4gLQltbWFwX3JlYWRfdW5sb2NrKG1tKTsKPiAtCW1tcHV0KG1tKTsKPiAt
Cj4gLQlyZXR1cm4gc3RhdHVzOwo+IC19Cj4gLQoKT25jZSB0aGUgaW9wZl9oYW5kbGVfc2luZ2xl
KCkgaXMgcmVtb3ZlZCwgdGhlIG5hbWUgb2YgCmlvcGZfaGFuZGxlX2dyb3VwKCkgbG9va3MgYSBs
aXR0bGUgd2VpcmVkCgphbmQgY29uZnVzZWQsIGRvZXMgdGhpcyBncm91cCBtZWFuIHRoZSBpb21t
dSBncm91cCAoZG9tYWluKSA/IHdoaWxlIEkgCnRha2Ugc29tZSBtaW51dGVzIHRvCgpsb29rIGlu
dG8gdGhlIGNvZGUsIG9oLCBtZWFucyBhIGJhdGNoIC8gbGlzdCAvIHF1ZXVlwqAgb2YgaW9wZnMg
LCBhbmQgCmlvcGZfaGFuZGxlX2dyb3VwKCkgYmVjb21lcyBhCgpnZW5lcmljIGlvcGZfaGFuZGxl
cigpIC4KCkRvZSBpdCBtYWtlIHNlbnNlIHRvIHJldmlzZSB0aGUgbmFtZXMgb2YgaW9wZl9oYW5k
bGVfZ3JvdXAoKSwgCmlvcGZfY29tcGxldGVfZ3JvdXAswqAgaW9wZl9ncm91cCBpbgoKdGhpcyBw
YXRjaCBzZXQgPwoKClRoYW5rcywKCkV0aGFuCgo+ICAgc3RhdGljIHZvaWQgaW9wZl9oYW5kbGVf
Z3JvdXAoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ICAgewo+ICAgCXN0cnVjdCBpb3BmX2dy
b3VwICpncm91cDsKPiArCXN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbjsKPiAgIAlzdHJ1Y3Qg
aW9wZl9mYXVsdCAqaW9wZiwgKm5leHQ7Cj4gICAJZW51bSBpb21tdV9wYWdlX3Jlc3BvbnNlX2Nv
ZGUgc3RhdHVzID0gSU9NTVVfUEFHRV9SRVNQX1NVQ0NFU1M7Cj4gICAKPiAgIAlncm91cCA9IGNv
bnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgaW9wZl9ncm91cCwgd29yayk7Cj4gKwlkb21haW4gPSBp
b21tdV9nZXRfZG9tYWluX2Zvcl9kZXZfcGFzaWQoZ3JvdXAtPmRldiwKPiArCQkJCWdyb3VwLT5s
YXN0X2ZhdWx0LmZhdWx0LnBybS5wYXNpZCk7Cj4gKwlpZiAoIWRvbWFpbiB8fCAhZG9tYWluLT5p
b3BmX2hhbmRsZXIpCj4gKwkJc3RhdHVzID0gSU9NTVVfUEFHRV9SRVNQX0lOVkFMSUQ7Cj4gICAK
PiAgIAlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoaW9wZiwgbmV4dCwgJmdyb3VwLT5mYXVsdHMs
IGxpc3QpIHsKPiAgIAkJLyoKPiBAQCAtMTM5LDcgKzg4LDggQEAgc3RhdGljIHZvaWQgaW9wZl9o
YW5kbGVfZ3JvdXAoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+ICAgCQkgKiBmYXVsdHMgaW4g
dGhlIGdyb3VwIGlmIHRoZXJlIGlzIGFuIGVycm9yLgo+ICAgCQkgKi8KPiAgIAkJaWYgKHN0YXR1
cyA9PSBJT01NVV9QQUdFX1JFU1BfU1VDQ0VTUykKPiAtCQkJc3RhdHVzID0gaW9wZl9oYW5kbGVf
c2luZ2xlKGlvcGYpOwo+ICsJCQlzdGF0dXMgPSBkb21haW4tPmlvcGZfaGFuZGxlcigmaW9wZi0+
ZmF1bHQsCj4gKwkJCQkJCSAgICAgIGRvbWFpbi0+ZmF1bHRfZGF0YSk7Cj4gICAKPiAgIAkJaWYg
KCEoaW9wZi0+ZmF1bHQucHJtLmZsYWdzICYKPiAgIAkJICAgICAgSU9NTVVfRkFVTFRfUEFHRV9S
RVFVRVNUX0xBU1RfUEFHRSkpCgotLSAKImZpcm0sIGVuZHVyaW5nLCBzdHJvbmcsIGFuZCBsb25n
LWxpdmVkIgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
aW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
