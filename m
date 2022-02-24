Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098A0C433EF
	for <iommu@archiver.kernel.org>; Thu, 24 Feb 2022 05:23:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5BC940270;
	Thu, 24 Feb 2022 05:23:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zm0uQJ6FEb0w; Thu, 24 Feb 2022 05:23:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 82C2440210;
	Thu, 24 Feb 2022 05:23:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 568D4C0021;
	Thu, 24 Feb 2022 05:23:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CFE1C0011
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 05:23:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1350240215
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 05:23:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gwQns_U4R5rr for <iommu@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 05:23:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4DF5540210
 for <iommu@lists.linux-foundation.org>; Thu, 24 Feb 2022 05:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645680183; x=1677216183;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1VYAA0otK3uOMli0TWlsKVdJIhmRQYoEYeddYTO8BbE=;
 b=iPU11W5iIAKG6Hjulr9H/JFKSavNJOj5l9ACU8Fe7QhrAaNP/SkfVObt
 ICP8xMvfG5cnU8I/+vwxdnQn9gBxq4AkgMbrWBWk9KBichOwtynhvNZUm
 sk9S2AwXW9eBKLDrAtNBYxh6NYHDEbxxJ73bwqtP3XSq6ZzaO3JjJ07SZ
 K6Z+RjG12I2+84la1Oi/c0+lxQwePzkXaEzYsgwp4OyrxmDljcAWHSrbr
 d6vR/X+2lJ6D7xy0hkIDjQsPq2l9Rq4gURTp6TG5tJv87i0h1N5afovZv
 ytbfMfRo3Pyu08xdRiNoh72nL3NcufwRoIEZN3VZyvNeIs4HPNosTvzOd w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="312869715"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; d="scan'208";a="312869715"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2022 21:23:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; d="scan'208";a="684159597"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2022 21:22:53 -0800
Message-ID: <10a96a85-d7e9-7ac6-9c8d-f0e8b4597f01@linux.intel.com>
Date: Thu, 24 Feb 2022 13:21:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 01/11] iommu: Add dma ownership management interfaces
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson
 <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
References: <20220218005521.172832-1-baolu.lu@linux.intel.com>
 <20220218005521.172832-2-baolu.lu@linux.intel.com>
 <f830c268-daca-8e8f-a429-0c80496a7273@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <f830c268-daca-8e8f-a429-0c80496a7273@arm.com>
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Daniel Vetter <daniel@ffwll.ch>
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

T24gMi8yNC8yMiAyOjAwIEFNLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMi0wMi0xOCAw
MDo1NSwgTHUgQmFvbHUgd3JvdGU6Cj4gWy4uLl0KPj4gKy8qKgo+PiArICogaW9tbXVfZ3JvdXBf
Y2xhaW1fZG1hX293bmVyKCkgLSBTZXQgRE1BIG93bmVyc2hpcCBvZiBhIGdyb3VwCj4+ICsgKiBA
Z3JvdXA6IFRoZSBncm91cC4KPj4gKyAqIEBvd25lcjogQ2FsbGVyIHNwZWNpZmllZCBwb2ludGVy
LiBVc2VkIGZvciBleGNsdXNpdmUgb3duZXJzaGlwLgo+PiArICoKPj4gKyAqIFRoaXMgaXMgdG8g
c3VwcG9ydCBiYWNrd2FyZCBjb21wYXRpYmlsaXR5IGZvciB2ZmlvIHdoaWNoIG1hbmFnZXMKPj4g
KyAqIHRoZSBkbWEgb3duZXJzaGlwIGluIGlvbW11X2dyb3VwIGxldmVsLiBOZXcgaW52b2NhdGlv
bnMgb24gdGhpcwo+PiArICogaW50ZXJmYWNlIHNob3VsZCBiZSBwcm9oaWJpdGVkLgo+PiArICov
Cj4+ICtpbnQgaW9tbXVfZ3JvdXBfY2xhaW1fZG1hX293bmVyKHN0cnVjdCBpb21tdV9ncm91cCAq
Z3JvdXAsIHZvaWQgKm93bmVyKQo+PiArewo+PiArwqDCoMKgIGludCByZXQgPSAwOwo+PiArCj4+
ICvCoMKgwqAgbXV0ZXhfbG9jaygmZ3JvdXAtPm11dGV4KTsKPj4gK8KgwqDCoCBpZiAoZ3JvdXAt
Pm93bmVyX2NudCkgewo+IAo+IFRvIGNsYXJpZnkgdGhlIGNvbW1lbnQgYnVyaWVkIGluIHRoZSBv
dGhlciB0aHJlYWQsIEkgcmVhbGx5IHRoaW5rIHdlIAo+IHNob3VsZCBqdXN0IHVuY29uZGl0aW9u
YWxseSBmbGFnIHRoZSBlcnJvciBoZXJlLi4uCj4gCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoZ3Jv
dXAtPm93bmVyICE9IG93bmVyKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IC1F
UEVSTTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byB1bmxvY2tfb3V0Owo+PiArwqDC
oMKgwqDCoMKgwqAgfQo+PiArwqDCoMKgIH0gZWxzZSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAo
Z3JvdXAtPmRvbWFpbiAmJiBncm91cC0+ZG9tYWluICE9IGdyb3VwLT5kZWZhdWx0X2RvbWFpbikg
ewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSAtRUJVU1k7Cj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGdvdG8gdW5sb2NrX291dDsKPj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4gKwo+
PiArwqDCoMKgwqDCoMKgwqAgZ3JvdXAtPm93bmVyID0gb3duZXI7Cj4+ICvCoMKgwqDCoMKgwqDC
oCBpZiAoZ3JvdXAtPmRvbWFpbikKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19pb21tdV9k
ZXRhY2hfZ3JvdXAoZ3JvdXAtPmRvbWFpbiwgZ3JvdXApOwo+PiArwqDCoMKgIH0KPj4gKwo+PiAr
wqDCoMKgIGdyb3VwLT5vd25lcl9jbnQrKzsKPj4gK3VubG9ja19vdXQ6Cj4+ICvCoMKgwqAgbXV0
ZXhfdW5sb2NrKCZncm91cC0+bXV0ZXgpOwo+PiArCj4+ICvCoMKgwqAgcmV0dXJuIHJldDsKPj4g
K30KPj4gK0VYUE9SVF9TWU1CT0xfR1BMKGlvbW11X2dyb3VwX2NsYWltX2RtYV9vd25lcik7Cj4+
ICsKPj4gKy8qKgo+PiArICogaW9tbXVfZ3JvdXBfcmVsZWFzZV9kbWFfb3duZXIoKSAtIFJlbGVh
c2UgRE1BIG93bmVyc2hpcCBvZiBhIGdyb3VwCj4+ICsgKiBAZ3JvdXA6IFRoZSBncm91cC4KPj4g
KyAqCj4+ICsgKiBSZWxlYXNlIHRoZSBETUEgb3duZXJzaGlwIGNsYWltZWQgYnkgaW9tbXVfZ3Jv
dXBfY2xhaW1fZG1hX293bmVyKCkuCj4+ICsgKi8KPj4gK3ZvaWQgaW9tbXVfZ3JvdXBfcmVsZWFz
ZV9kbWFfb3duZXIoc3RydWN0IGlvbW11X2dyb3VwICpncm91cCkKPj4gK3sKPj4gK8KgwqDCoCBt
dXRleF9sb2NrKCZncm91cC0+bXV0ZXgpOwo+PiArwqDCoMKgIGlmIChXQVJOX09OKCFncm91cC0+
b3duZXJfY250IHx8ICFncm91cC0+b3duZXIpKQo+PiArwqDCoMKgwqDCoMKgwqAgZ290byB1bmxv
Y2tfb3V0Owo+PiArCj4+ICvCoMKgwqAgaWYgKC0tZ3JvdXAtPm93bmVyX2NudCA+IDApCj4+ICvC
oMKgwqDCoMKgwqDCoCBnb3RvIHVubG9ja19vdXQ7Cj4gCj4gLi4uYW5kIGVxdWl2YWxlbnRseSBq
dXN0IHNldCBvd25lcl9jbnQgZGlyZWN0bHkgdG8gMCBoZXJlLiBJIGRvbid0IHNlZSBhIAo+IHJl
YWxpc3RpYyB1c2UtY2FzZSBmb3IgYW55IGRyaXZlciB0byBjbGFpbSB0aGUgc2FtZSBncm91cCBt
b3JlIHRoYW4gCj4gb25jZSwgYW5kIGFsbG93aW5nIGl0IGluIHRoZSBBUEkganVzdCBmZWVscyBs
aWtlIG9wZW5pbmcgdXAgdmFyaW91cyAKPiBwb3RlbnRpYWwgY29ybmVycyBmb3IgdGhpbmdzIHRv
IGdldCBvdXQgb2Ygc3luYy4KClllYWghIEJvdGggbWFrZSBzZW5zZSB0byBtZS4gSSB3aWxsIGFs
c28gZHJvcCB0aGUgb3duZXIgdG9rZW4gaW4gdGhlIEFQSQphcyBpdCdzIHVubmVjZXNzYXJ5IGFu
eW1vcmUgYWZ0ZXIgdGhlIGNoYW5nZS4KCj4gSSB0aGluayB0aGF0J3MgdGhlIG9ubHkgc2lnbmlm
aWNhbnQgY29uY2VybiBJIGhhdmUgbGVmdCB3aXRoIHRoZSBzZXJpZXMgCj4gYXMgYSB3aG9sZSAt
IHlvdSBjYW4gY29uc2lkZXIgbXkgb3RoZXIgZ3J1bWJsZXMgbm9uLWJsb2NraW5nIDopCgpUaGFu
ayB5b3UgYW5kIHZlcnkgYXBwcmVjaWF0ZWQgZm9yIHlvdXIgdGltZSEKCkJlc3QgcmVnYXJkcywK
YmFvbHUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
