Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BC9C433EF
	for <iommu@archiver.kernel.org>; Thu, 10 Feb 2022 00:52:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11DA960E5F;
	Thu, 10 Feb 2022 00:52:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y4uCLzp0m9zm; Thu, 10 Feb 2022 00:52:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E04EC60E46;
	Thu, 10 Feb 2022 00:52:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0C4EC001A;
	Thu, 10 Feb 2022 00:52:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE010C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 00:52:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C953B60E5E
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 00:52:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rP9_qg3uZBCG for <iommu@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 00:52:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D834D60E5A
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 00:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644454345; x=1675990345;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=3TVWAm9LlhlLa2IkCVU8wnRmJGrW+1uk41RrCt4p/Tc=;
 b=PERytT4rZuUuJxcR8dsxSXtK7gJYlKRsYVkbc+2p0eWUTsivHtGLsINT
 w966UFL76ejPV6plQc4Fn5dXbfqxCutee8qZl0nZNYGJ3DaPbIv5xYbGY
 uSWM5ymqEyUzSkgrFReX7WdtQDNtkJhjFLHnt9dqN6eSLNxcnt3Rggb6f
 3Pbj2k4MXHENFGNC/acGGSa7qRK7giDWzJNs28fG5j+ZfrVa0lkV9gpDc
 qj2g7ypTZRAB4bFj8KrFslRSyNOFDujDfZ/RwtEf7+jtrc83kqw2iBhpS
 T1g+YJXHHQGn4ZyoQ6spp3DknXWj9kzO3MPot46JiizXuy9sEcvQXvvZ0 Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="248210953"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; d="scan'208";a="248210953"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2022 16:52:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; d="scan'208";a="678968070"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2022 16:52:21 -0800
Message-ID: <27fbcb02-4f13-3377-eadd-e689ce063348@linux.intel.com>
Date: Thu, 10 Feb 2022 08:51:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 08/10] iommu: Remove unused argument in
 is_attach_deferred
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Ben Skeggs <bskeggs@redhat.com>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-9-baolu.lu@linux.intel.com>
 <290a89f0-8318-6130-468c-6412add62cfb@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <290a89f0-8318-6130-468c-6412add62cfb@arm.com>
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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

T24gMi85LzIyIDk6NTIgUE0sIFJvYmluIE11cnBoeSB3cm90ZToKPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+
PiBpbmRleCAyYjVmNGU1N2E4YmIuLjgwZjEyOTRiZTYzNCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy9pb21tdS9pbnRlbC9pb21tdS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUu
Ywo+PiBAQCAtNTA1Miw4ICs1MDUyLDcgQEAgaW50ZWxfaW9tbXVfZGV2X2Rpc2FibGVfZmVhdChz
dHJ1Y3QgZGV2aWNlICpkZXYsIAo+PiBlbnVtIGlvbW11X2Rldl9mZWF0dXJlcyBmZWF0KQo+PiDC
oMKgwqDCoMKgIH0KPj4gwqAgfQo+PiAtc3RhdGljIGJvb2wgaW50ZWxfaW9tbXVfaXNfYXR0YWNo
X2RlZmVycmVkKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwKPj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBkZXZpY2UgKmRldikKPj4gK3N0
YXRpYyBib29sIGludGVsX2lvbW11X2lzX2F0dGFjaF9kZWZlcnJlZChzdHJ1Y3QgZGV2aWNlICpk
ZXYpCj4+IMKgIHsKPj4gwqDCoMKgwqDCoCByZXR1cm4gYXR0YWNoX2RlZmVycmVkKGRldik7Cj4g
Cj4gU2VlbXMgbGlrZSB0aGVyZSdzIG5vIG5lZWQgdG8gd3JhcCB0aGlzIG5vdz8KClllcy4gSXQn
cyBwb2ludGxlc3MuCgpCZXN0IHJlZ2FyZHMsCmJhb2x1CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
