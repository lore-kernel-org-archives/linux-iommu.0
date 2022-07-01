Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C0CC433EF
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 08:12:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C093F60804;
	Fri,  1 Jul 2022 08:12:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C093F60804
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EGL5Mk9G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ybo8b5H4bXpI; Fri,  1 Jul 2022 08:12:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A532560864;
	Fri,  1 Jul 2022 08:12:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A532560864
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75C59C0032;
	Fri,  1 Jul 2022 08:12:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D692EC002D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 08:12:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AF3FA41835
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 08:12:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AF3FA41835
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EGL5Mk9G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9cQGqwRbdyB3 for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 08:12:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 82D7341716
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 82D7341716
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 08:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656663149; x=1688199149;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=uIBc20BRpWux/L4QNgzOIj1nZj/HX/ViDlZzamfMVRw=;
 b=EGL5Mk9G9WyJV+cuOM82r8PgPRKjWjjdhbkkaO7JKh1ZknEJbN1GP/a/
 vO7+0nrPke/y1unCrdLFLIavL/T5lQ295VHssu9ci/pAllu3S4OkFfele
 e2nAUQAXypvBx/HjUwJjgj7YIa5rOVG2BBBR/zdguZnOTRHh5dYX6TJiq
 Z4ZqXHRytBp1lGPm9egUtOQJg8xAu0wmWz+P8QC5zSbZeqOYaCshz12rq
 nF+EWmq7AUfHLuVa+638UngcPCxzgxwhlPtT/WjlA/cRHPVC/2akPAWyJ
 YAV+s4ZuqydBmSogE5Vv9KA6D3ue5BSpxP3yBG+ETU7ARgJv0mDjXO6jP g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="346574310"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="346574310"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2022 01:12:28 -0700
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; d="scan'208";a="659344362"
Received: from wenjuhe-mobl1.ccr.corp.intel.com (HELO [10.249.171.195])
 ([10.249.171.195])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2022 01:12:26 -0700
Message-ID: <50a05134-349a-0921-2a70-63f303bf86a4@linux.intel.com>
Date: Fri, 1 Jul 2022 16:12:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 00/11] iommu/vt-d: Optimize the use of locks
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
 <BN9PR11MB527645CF20DA53BF9009A9118CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527645CF20DA53BF9009A9118CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>
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

T24gMjAyMi83LzEgMTU6NTMsIFRpYW4sIEtldmluIHdyb3RlOgo+PiBGcm9tOiBMdSBCYW9sdSA8
YmFvbHUubHVAbGludXguaW50ZWwuY29tPgo+PiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMjksIDIw
MjIgMzo0NyBQTQo+Pgo+PiB2MzoKPj4gICAtIFNwbGl0IHJlZHVjdGlvbiBvZiBsb2NrIHJhbmdl
cyBmcm9tIGNoYW5naW5nIGlycXNhdmUuCj4+ICAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC0KPj4gaW9tbXUvQk45UFIxMU1CNTI3NjBBM0Q3QzZCRjFBRjlDOUQzNDY1OENBQTlAQk45
UFIxMU1CNTI3Ni4KPj4gbmFtcHJkMTEucHJvZC5vdXRsb29rLmNvbS8KPj4gICAtIEZ1bGx5IGlu
aXRpYWxpemUgdGhlIGRldl9pbmZvIGJlZm9yZSBhZGRpbmcgaXQgdG8gdGhlIGxpc3QuCj4+ICAg
ICBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC0KPj4gaW9tbXUvQk45UFIxMU1CNTI3NjRE
N0NEODY0NDhDNUU0RUI0NjY2OENBQTlAQk45UFIxMU1CNTI3Ni4KPj4gbmFtcHJkMTEucHJvZC5v
dXRsb29rLmNvbS8KPj4gICAtIFZhcmlvdXMgY29kZSBhbmQgY29tbWVudHMgcmVmaW5lbWVudC4K
Pj4KPiAKPiBUaGlzIGRvZXNuJ3Qgc2F5IHdoeSBvcmlnaW5hbCBwYXRjaDIgd2FzIHJlbW92ZWQ6
Cj4gCj4gCSJpb21tdS92dC1kOiBSZW1vdmUgZm9yX2VhY2hfZGV2aWNlX2RvbWFpbigpIgo+IAo+
IEl0IHRvb2sgbWUgYSB3aGlsZSB0byByZWFsaXplIHRoYXQgaXQncyBhbHJlYWR5IGNvdmVyZWQg
YnkgeW91ciBhbm90aGVyCj4gcGF0Y2ggZml4aW5nIFJJRDJQQVNJRC4g8J+YigoKTXkgZmF1bHQh
IEkgZm9yZ290IHRvIG1lbnRpb24gaXQgaW4gdGhlIGNoYW5nZSBsb2cuIFNvcnJ5IGFib3V0IGl0
LgoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vaW9tbXU=
