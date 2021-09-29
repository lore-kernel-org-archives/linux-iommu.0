Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECF8C433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 21:16:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DC8961504
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 21:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6DC8961504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 38B34421EF;
	Wed, 29 Sep 2021 21:16:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CZLJa3OWERSE; Wed, 29 Sep 2021 21:16:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2419A421EE;
	Wed, 29 Sep 2021 21:16:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0128CC0011;
	Wed, 29 Sep 2021 21:16:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E314C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 21:16:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D7F283FB6
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 21:16:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uxUKrDVqUZb1 for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 21:16:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3063483F7D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 21:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=RfrWfjCRN+UowtRVbNA3b2L6enFhSnjdcCuQt0d3QdI=; b=sx8iDLgZqm9oV/jPtvYl6hWxOJ
 izKJEIZpDyBIKLWz8FDerUW5k2MT7pPtfUTyZiEU6bE7HoV7pneW/CZR2zMIxsytGbyq8vFegsKGv
 49LSCi3qE6cFcuu3ANDMzF0wHUfqas6dQodjbfxt/8zHWnBhP9N8kOEENBNUjLrsTXNl90Sahn8H0
 HAUhhk1jLu1tfiA5AYOXEg4lkZh0pmHiPlunotwWT39n20HVUlZzMB6xXhNwz+2qZPfnc/8Ia0J5E
 FZIAlxHcWmAecE99N9j4B2rg3AG9XIO/VHcG1DdeZNocY4lVPpt+WxirDMZKAHuss1OBzFQ0yFB23
 svZcaJZQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mVgvW-0006Bq-H1; Wed, 29 Sep 2021 15:15:43 -0600
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-2-logang@deltatee.com>
 <20210928183219.GJ3544071@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3f3abc6b-0a80-dbb6-f9dc-8a4cc33c975c@deltatee.com>
Date: Wed, 29 Sep 2021 15:15:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928183219.GJ3544071@ziepe.ca>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com,
 robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org,
 jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net,
 dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch,
 willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com,
 christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 01/20] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
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

CgpPbiAyMDIxLTA5LTI4IDEyOjMyIHAubS4sIEphc29uIEd1bnRob3JwZSB3cm90ZToKPiBPbiBU
aHUsIFNlcCAxNiwgMjAyMSBhdCAwNTo0MDo0MVBNIC0wNjAwLCBMb2dhbiBHdW50aG9ycGUgd3Jv
dGU6Cj4+ICBjb25maWcgUENJX1AyUERNQQo+PiAgCWJvb2wgIlBDSSBwZWVyLXRvLXBlZXIgdHJh
bnNmZXIgc3VwcG9ydCIKPj4gLQlkZXBlbmRzIG9uIFpPTkVfREVWSUNFCj4+ICsJZGVwZW5kcyBv
biBaT05FX0RFVklDRSAmJiA2NEJJVAo+IAo+IFBlcmhhcHMgYSBjb21tZW50IHRvIGV4cGxhaW4g
d2hhdCB0aGUgNjRiaXQgaXMgZG9pbmc/CgpBZGRlZC4KCj4+ICAJc2VsZWN0IEdFTkVSSUNfQUxM
T0NBVE9SCj4+ICAJaGVscAo+PiAgCSAgRW5hYmxl0ZUgZHJpdmVycyB0byBkbyBQQ0kgcGVlci10
by1wZWVyIHRyYW5zYWN0aW9ucyB0byBhbmQgZnJvbQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9zY2F0dGVybGlzdC5oIGIvaW5jbHVkZS9saW51eC9zY2F0dGVybGlzdC5oCj4+IGluZGV4
IDI2Njc1NGE1NTMyNy4uZTYyYjFjZjYzODZmIDEwMDY0NAo+PiArKysgYi9pbmNsdWRlL2xpbnV4
L3NjYXR0ZXJsaXN0LmgKPj4gQEAgLTY0LDYgKzY0LDIxIEBAIHN0cnVjdCBzZ19hcHBlbmRfdGFi
bGUgewo+PiAgI2RlZmluZSBTR19DSEFJTgkweDAxVUwKPj4gICNkZWZpbmUgU0dfRU5ECQkweDAy
VUwKPj4gIAo+PiArLyoKPj4gKyAqIGJpdCAyIGlzIHRoZSB0aGlyZCBmcmVlIGJpdCBpbiB0aGUg
cGFnZV9saW5rIG9uIDY0Yml0IHN5c3RlbXMgd2hpY2gKPj4gKyAqIGlzIHVzZWQgYnkgZG1hX3Vu
bWFwX3NnKCkgdG8gZGV0ZXJtaW5lIGlmIHRoZSBkbWFfYWRkcmVzcyBpcyBhIFBDSQo+PiArICog
YnVzIGFkZHJlc3Mgd2hlbiBkb2luZyBQMlBETUEuCj4+ICsgKiBOb3RlOiBDT05GSUdfUENJX1Ay
UERNQSBkZXBlbmRzIG9uIENPTkZJR182NEJJVCBiZWNhdXNlIG9mIHRoaXMuCj4+ICsgKi8KPj4g
Kwo+PiArI2lmZGVmIENPTkZJR19QQ0lfUDJQRE1BCj4+ICsjZGVmaW5lIFNHX0RNQV9QQ0lfUDJQ
RE1BCTB4MDRVTAo+IAo+IEFkZCBhIAo+IAlzdGF0aWNfYXNzZXJ0KF9fYWxpZ25vZl9fKHZvaWQg
KikgPT0gOCk7Cj4gCj4gPwoKR29vZCBpZGVhLiBUaG91Z2gsIEkgdGhpbmsgeW91ciBsaW5lIGlz
bid0IHF1aXRlIGNvcnJlY3QuIEkndmUgYWRkZWQ6CgpzdGF0aWNfYXNzZXJ0KF9fYWxpZ25vZl9f
KHN0cnVjdCBwYWdlKSA+PSA4KTsKCj4+ICsjZGVmaW5lIHNnX2lzX2RtYV9wY2lfcDJwZG1hKHNn
KSAoKHNnKS0+cGFnZV9saW5rICYgU0dfRE1BX1BDSV9QMlBETUEpCj4gCj4gSSd2ZSBiZWVuIGVu
Y291cmFnaW5nIHBlb3BsZSB0byB1c2Ugc3RhdGljIGlubGluZXMgbW9yZS4uCgpJIGFsc28gcHJl
ZmVyIHN0YXRpYyBpbmxpbmVzLCBidXQgSSB1c3VhbGx5IGZvbGxvdyB0aGUgc3R5bGUgb2YgdGhl
IGNvZGUKSSdtIGNoYW5naW5nLiBJbiBhbnkgY2FzZSwgSSd2ZSBjaGFuZ2VkIHRvIHN0YXRpYyBp
bmxpbmVzIHNpbWlsYXIgdG8KeW91ciBleGFtcGxlLgoKPj4gIC8qKgo+PiAgICogc2dfYXNzaWdu
X3BhZ2UgLSBBc3NpZ24gYSBnaXZlbiBwYWdlIHRvIGFuIFNHIGVudHJ5Cj4+IEBAIC04NiwxMyAr
MTAzLDEzIEBAIHN0cnVjdCBzZ19hcHBlbmRfdGFibGUgewo+PiAgICoqLwo+PiAgc3RhdGljIGlu
bGluZSB2b2lkIHNnX2Fzc2lnbl9wYWdlKHN0cnVjdCBzY2F0dGVybGlzdCAqc2csIHN0cnVjdCBw
YWdlICpwYWdlKQo+PiAgewo+PiAtCXVuc2lnbmVkIGxvbmcgcGFnZV9saW5rID0gc2ctPnBhZ2Vf
bGluayAmIChTR19DSEFJTiB8IFNHX0VORCk7Cj4+ICsJdW5zaWduZWQgbG9uZyBwYWdlX2xpbmsg
PSBzZy0+cGFnZV9saW5rICYgU0dfUEFHRV9MSU5LX01BU0s7Cj4gCj4gSSB0aGluayB0aGlzIHNo
b3VsZCBqdXN0IGJlICcmIFNHX0VORCcsIHNnX2Fzc2lnbl9wYWdlKCkgZG9lc24ndCBsb29rCj4g
bGlrZSBpdCBzaG91bGQgZXZlciBiZSB1c2VkIG9uIGEgc2dfY2hhaW4gZW50cnksIHNvIHRoaXMg
aXMganVzdAo+IHRyeWluZyB0byBwcmVzZXJ2ZSB0aGUgZW5kIHN0YW1wLgoKUGVyaGFwcywgYnV0
IEknbSBub3QgY29tZm9ydGFibGUgbWFraW5nIHRoYXQgY2hhbmdlIGluIHRoaXMgcGF0Y2ggb3IK
c2VyaWVzLiBUaG91Z2gsIEkndmUgcmV2ZXJ0ZWQgdGhpcyBzcGVjaWZpYyBjaGFuZ2UgaW4gbXkg
cGF0Y2ggc28Kc2dfYXNzaWduX3BhZ2UoKSB3aWxsIGNsZWFyIFNHX0RNQV9QQ0lfUDJQRE1BLgoK
TG9nYW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
