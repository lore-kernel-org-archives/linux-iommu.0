Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B874C433F5
	for <iommu@archiver.kernel.org>; Sat,  7 May 2022 08:33:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27B1760E17;
	Sat,  7 May 2022 08:33:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hT3iLyfWyP53; Sat,  7 May 2022 08:33:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4DACC60E15;
	Sat,  7 May 2022 08:33:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF656C0039;
	Sat,  7 May 2022 08:33:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD674C002D
 for <iommu@lists.linux-foundation.org>; Sat,  7 May 2022 08:33:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B447640915
 for <iommu@lists.linux-foundation.org>; Sat,  7 May 2022 08:33:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EqHrxx_bAYpN for <iommu@lists.linux-foundation.org>;
 Sat,  7 May 2022 08:33:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8879B4090C
 for <iommu@lists.linux-foundation.org>; Sat,  7 May 2022 08:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651912385; x=1683448385;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=RBU8lfPbnJq0/IUDWjwcu17pUEjRs6Stfy9C+m2jzMs=;
 b=REQLKspCi7KiyR2n0dFZHx4vIfFY3T+q0vB5ccpa7Dvn6WzoAwHa5Ape
 jjTEkQz/GbG8rAFwiT4q0Nivp0Anwd+Wfp/jzdcxRtzLawnjX8Gkvdg+B
 k1BFUVNhZ527GFlxhvPQRWddm7YnxkgFfiSRqkH1heXlUloohJRQFNWYn
 2eJE9zm+0FITJvJU7VhJv61e+UqGNJ6hvxpVLYUU1hPfdziyq89Hc6WzY
 8K0s3vwqaIgaMyQDEPm4Q0NSODjuJvInKOypD7pVFPdKVu3GNrZ1Iu3D1
 ImSJXDLk7oei9GnV2+D2mh0EjZVgd0wPXMaTMV0n/n976JKUmi8F1yzoE g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="293893103"
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; d="scan'208";a="293893103"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2022 01:33:04 -0700
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; d="scan'208";a="586422113"
Received: from zhuangxi-mobl.ccr.corp.intel.com (HELO [10.255.30.94])
 ([10.255.30.94])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2022 01:33:00 -0700
Message-ID: <669fb111-9821-aadc-acbf-de42bc551fc4@linux.intel.com>
Date: Sat, 7 May 2022 16:32:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 04/12] iommu/sva: Basic data structures for SVA
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-5-baolu.lu@linux.intel.com> <YnFv0ps0Ad8v+7uH@myrica>
 <d490e542-140c-58c3-bb11-9990795272b1@linux.intel.com>
In-Reply-To: <d490e542-140c-58c3-bb11-9990795272b1@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Robin Murphy <robin.murphy@arm.com>
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

SGkgSmVhbiwKCk9uIDIwMjIvNS81IDE0OjQyLCBCYW9sdSBMdSB3cm90ZToKPiBPbiAyMDIyLzUv
NCAwMjowOSwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOgo+PiBPbiBNb24sIE1heSAwMiwg
MjAyMiBhdCAwOTo0ODozNEFNICswODAwLCBMdSBCYW9sdSB3cm90ZToKPj4+IFVzZSBiZWxvdyBk
YXRhIHN0cnVjdHVyZXMgZm9yIFNWQSBpbXBsZW1lbnRhdGlvbiBpbiB0aGUgSU9NTVUgY29yZToK
Pj4+Cj4+PiAtIHN0cnVjdCBpb21tdV9zdmFfaW9hcwo+Pj4gwqDCoCBSZXByZXNlbnQgdGhlIEkv
TyBhZGRyZXNzIHNwYWNlIHNoYXJlZCB3aXRoIGFuIGFwcGxpY2F0aW9uIENQVSAKPj4+IGFkZHJl
c3MKPj4+IMKgwqAgc3BhY2UuIFRoaXMgc3RydWN0dXJlIGhhcyBhIDE6MSByZWxhdGlvbnNoaXAg
d2l0aCBhbiBtbV9zdHJ1Y3QuIEl0Cj4+PiDCoMKgIGdyYWJzIGEgIm1tLT5tbV9jb3VudCIgcmVm
Y291bnQgZHVyaW5nIGNyZWF0aW9uIGFuZCBkcm9wIGl0IG9uIAo+Pj4gcmVsZWFzZS4KPj4KPj4g
RG8gd2UgYWN0dWFsbHkgbmVlZCB0aGlzIHN0cnVjdHVyZT/CoCBBdCB0aGUgbW9tZW50IGl0IG9u
bHkga2VlcHMgdHJhY2sgb2YKPj4gYm9uZHMsIHdoaWNoIHdlIGNhbiBtb3ZlIHRvIHN0cnVjdCBk
ZXZfaW9tbXUuIFJlcGxhY2luZyBpdCBieSBhIG1tIAo+PiBwb2ludGVyCj4+IGluIHN0cnVjdCBp
b21tdV9kb21haW4gc2ltcGxpZmllcyB0aGUgZHJpdmVyIGFuZCBzZWVtcyB0byB3b3JrCj4gCj4g
RmFpciBlbm91Z2guCj4gCj4gK3N0cnVjdCBpb21tdV9zdmFfaW9hcyB7Cj4gK8KgwqDCoCBzdHJ1
Y3QgbW1fc3RydWN0ICptbTsKPiArwqDCoMKgIGlvYXNpZF90IHBhc2lkOwo+ICsKPiArwqDCoMKg
IC8qIENvdW50ZXIgb2YgZG9tYWlucyBhdHRhY2hlZCB0byB0aGlzIGlvYXMuICovCj4gK8KgwqDC
oCByZWZjb3VudF90IHVzZXJzOwo+ICsKPiArwqDCoMKgIC8qIEFsbCBiaW5kaW5ncyBhcmUgbGlu
a2VkIGhlcmUuICovCj4gK8KgwqDCoCBzdHJ1Y3QgbGlzdF9oZWFkIGJvbmRzOwo+ICt9Owo+IAo+
IEJ5IG1vdmluZyBAbW0gdG8gc3RydWN0IGlvbW11X2RvbWFpbiBhbmQgQGJvbmRzIHRvIHN0cnVj
dCBkZXZfaW9tbXUsIHRoZQo+IGNvZGUgbG9va3Mgc2ltcGxlci4gVGhlIG1tLCBzdmEgZG9tYWlu
IGFuZCBwZXItZGV2aWNlIGRldl9pb21tdSBhcmUKPiBndWFyYW50ZWVkIHRvIGJlIHZhbGlkIGR1
cmluZyBiaW5kKCkgYW5kIHVuYmluZCgpLgo+IAo+IFdpbGwgaGVhZCB0aGlzIGRpcmVjdGlvbiBp
biB0aGUgbmV4dCB2ZXJzaW9uLgoKSSdtIHRyeWluZyB0byBpbXBsZW1lbnQgdGhpcyBpZGVhIGlu
IHJlYWwgY29kZS4gSXQgc2VlbXMgdGhhdCB3ZSBuZWVkCmFkZGl0aW9uYWwgZmllbGRzIGluIHN0
cnVjdCBpb21tdV9kb21haW4gdG8gdHJhY2sgd2hpY2ggZGV2aWNlcyB0aGUgbW0Kd2FzIGJvdW5k
IHRvLiBJdCBkb2Vzbid0IHNpbXBsaWZ5IHRoZSBjb2RlIG11Y2guIEFueSB0aG91Z2h0cz8KCkJl
c3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
