Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4044AC433F5
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 04:31:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5AF460C2C;
	Tue,  8 Feb 2022 04:31:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H8VBWPiW1aZh; Tue,  8 Feb 2022 04:31:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BFCE460BA4;
	Tue,  8 Feb 2022 04:31:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2280C001A;
	Tue,  8 Feb 2022 04:31:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D3D3C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 04:31:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6BF6A40500
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 04:31:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7rBscatYSNBZ for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 04:31:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A852640275
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 04:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644294674; x=1675830674;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=sLnwdFLCJ4UV9sC7s0su5wmh+vi9Lj/1fhIUEK9dmJA=;
 b=CEPicDEFT3t+tPWDNF0MPnbp6zColuEf4UENBKbMeW4AaT4PDeVh/k3I
 zKeHTQBLdexNu8X80dWJh8pDW0+oqiIu6HYlWKXPDq90wL1qQRN+Z9B1A
 HaLk2c3r/lncX/cOhsjSJCKA3qTy3MJwJ3/phASwingAN2anITEvzW7Ev
 EibjWZn1jMknCgJYM/SCswkO2n4lgRLT//4cfeLQE6JURSnWn9htrzhaU
 EdtqwQlUcRM4hpH2QPXBZWf58MKMZpvIu8waTneSPzFX3bwHL2ih7heFS
 rCaEyh3Y4/FlVA5npZS8dWjb27j49OFi4B5u1RJD3uXn/JuCbJ+s4ljFy Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="229517314"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="229517314"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 20:31:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="677985554"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 20:31:07 -0800
Message-ID: <d658fd8d-00a2-273f-2685-dee55b96705e@linux.intel.com>
Date: Tue, 8 Feb 2022 12:29:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 04/10] iommu/vt-d: Remove iova_cache_get/put()
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, Joerg Roedel <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Liu Yi L <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
 <20220207064142.1092846-5-baolu.lu@linux.intel.com>
 <ce1183f5-cec1-9438-4b5d-a4a99b046ab6@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <ce1183f5-cec1-9438-4b5d-a4a99b046ab6@huawei.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

T24gMi83LzIyIDY6MzkgUE0sIEpvaG4gR2Fycnkgd3JvdGU6Cj4gT24gMDcvMDIvMjAyMiAwNjo0
MSwgTHUgQmFvbHUgd3JvdGU6Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2lv
bW11LmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKPj4gaW5kZXggNTgzZWMwZmE0YWMx
Li5lOGQ1ODY1NDM2MWMgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUu
Ywo+PiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKPj4gQEAgLTMzNDgsOSArMzM0
OCw2IEBAIHN0YXRpYyBpbmxpbmUgaW50IGlvbW11X2RldmluZm9fY2FjaGVfaW5pdCh2b2lkKQo+
PiDCoCBzdGF0aWMgaW50IF9faW5pdCBpb21tdV9pbml0X21lbXBvb2wodm9pZCkKPj4gwqAgewo+
PiDCoMKgwqDCoMKgIGludCByZXQ7Cj4+IC3CoMKgwqAgcmV0ID0gaW92YV9jYWNoZV9nZXQoKTsK
Pj4gLcKgwqDCoCBpZiAocmV0KQo+PiAtwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPj4gwqDC
oMKgwqDCoCByZXQgPSBpb21tdV9kb21haW5fY2FjaGVfaW5pdCgpOwo+PiDCoMKgwqDCoMKgIGlm
IChyZXQpCj4+IEBAIC0zMzYyLDcgKzMzNTksNiBAQCBzdGF0aWMgaW50IF9faW5pdCBpb21tdV9p
bml0X21lbXBvb2wodm9pZCkKPj4gwqDCoMKgwqDCoCBrbWVtX2NhY2hlX2Rlc3Ryb3koaW9tbXVf
ZG9tYWluX2NhY2hlKTsKPj4gwqAgZG9tYWluX2Vycm9yOgo+IAo+IG5pdDogaXMgdGhpcyBsYWJl
bCBzdGlsbCByZWFsbHkgcmVxdWlyZWQ/IG9ubHkgZmFpbHVyZXMgaW4gCj4gaW9tbXVfZG9tYWlu
X2NhY2hlX2luaXQoKSBqdW1wIHRvIGl0LCBhbmQgdGhhdCBjYW4gcmV0dXJuIGRpcmVjdGx5IG5v
dy4KCkl0IHdpbGwgYmUgY2xlYW5lZCB1cCBpbiB0aGUgbmV4dCBwYXRjaC4KCj4gCj4gVGhhbmtz
LAo+IEpvaG4KPiAKPj4gLcKgwqDCoCBpb3ZhX2NhY2hlX3B1dCgpOwo+IAoKQmVzdCByZWdhcmRz
LApiYW9sdQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
