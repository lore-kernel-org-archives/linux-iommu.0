Return-Path: <SRS0=lDjG=O4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D847C433F5
	for <iommu@archiver.kernel.org>; Fri,  8 Oct 2021 11:59:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D5260FD9
	for <iommu@archiver.kernel.org>; Fri,  8 Oct 2021 11:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 30D5260FD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E9EA940515;
	Fri,  8 Oct 2021 11:59:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JVeROIVvd4ft; Fri,  8 Oct 2021 11:59:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 87DE1404F9;
	Fri,  8 Oct 2021 11:59:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DD2DC0011;
	Fri,  8 Oct 2021 11:59:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9305C000D
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 11:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BB214404F9
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 11:59:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vmIhaREShlKe for <iommu@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 11:59:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 12D3A40151
 for <iommu@lists.linux-foundation.org>; Fri,  8 Oct 2021 11:59:29 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="207301998"
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; d="scan'208";a="207301998"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2021 04:59:29 -0700
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; d="scan'208";a="489436095"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.185])
 ([10.254.215.185])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2021 04:59:27 -0700
Subject: Re: [PATCH v1 1/2] iommu/vt-d: Move intel_iommu_ops to header file
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20210729163538.40101-1-andriy.shevchenko@linux.intel.com>
 <3c7663db-5b1e-3e00-3ff1-381c7a107ac9@linux.intel.com>
 <YV3LYqmsijqVAa5Y@smile.fi.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6cb6f2eb-700a-fbc9-2b3f-cca95c8db64d@linux.intel.com>
Date: Fri, 8 Oct 2021 19:59:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YV3LYqmsijqVAa5Y@smile.fi.intel.com>
Content-Language: en-US
Cc: Joerg Roedel <jroedel@suse.de>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>
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

SGkgQW5keSwKCk9uIDIwMjEvMTAvNyAwOjE0LCBBbmR5IFNoZXZjaGVua28gd3JvdGU6Cj4gT24g
RnJpLCBKdWwgMzAsIDIwMjEgYXQgMTA6MjA6MDhBTSArMDgwMCwgTHUgQmFvbHUgd3JvdGU6Cj4+
IEhpIEFuZHksCj4+Cj4+IE9uIDcvMzAvMjEgMTI6MzUgQU0sIEFuZHkgU2hldmNoZW5rbyB3cm90
ZToKPj4+IENvbXBpbGVyIGlzIG5vdCBoYXBweSBhYm91dCBoaWRkZW4gZGVjbGFyYXRpb24gb2Yg
aW50ZWxfaW9tbXVfb3BzLgo+Pj4KPj4+IC4uLi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmM6
NDE0OjI0OiB3YXJuaW5nOiBzeW1ib2wgJ2ludGVsX2lvbW11X29wcycgd2FzIG5vdCBkZWNsYXJl
ZC4gU2hvdWxkIGl0IGJlIHN0YXRpYz8KPj4+Cj4+PiBNb3ZlIGRlY2xhcmF0aW9uIHRvIGhlYWRl
ciBmaWxlIHRvIG1ha2UgY29tcGlsZXIgaGFwcHkuCj4+Cj4+IFRoYW5rcyBmb3IgdGhlIGNsZWFu
dXAuIFNoYXJpbmcgZGF0YSBzdHJ1Y3R1cmVzIGJldHdlZW4gZGlmZmVyZW50IGZpbGVzCj4+IGRv
ZXNuJ3Qgc2VlbSB0byBiZSBhIGdvb2QgZGVzaWduLiBIb3cgYWJvdXQgYWRkaW5nIGEgaGVscGVy
IHNvIHRoYXQgdGhlCj4+IGludGVsX2lvbW11X29wcyBjb3VsZCBiZSBhIHN0YXRpYyBvbmU/Cj4g
Cj4gSSBkb24ndCBzZWUgYW55IGNoYW5nZSBpbiB0aGUgdXBzdHJlYW0uIFdoYXQncyB0aGUgcGxh
bj8KPiBDYW4gd2UgdGFrZSBteSBwYXRjaCBhcyBhIHF1aWNrIGZpeD8KPiAKClRoaXMgcGF0Y2gg
d2lsbCBjYXVzZSBiZWxvdyBidWlsZCBlcnJvcjoKCmRyaXZlcnMvaW9tbXUvaW50ZWwvZG1hci5j
OiBJbiBmdW5jdGlvbiDigJhhbGxvY19pb21tdeKAmToKZHJpdmVycy9pb21tdS9pbnRlbC9kbWFy
LmM6MTE0MDo0NzogZXJyb3I6IOKAmGludGVsX2lvbW11X29wc+KAmSB1bmRlY2xhcmVkIAooZmly
c3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pOyBkaWQgeW91IG1lYW4g4oCYaW50ZWxfaW9tbXVfZ3Jv
dXBz4oCZPwogIDExNDAgfCAgIGVyciA9IGlvbW11X2RldmljZV9yZWdpc3RlcigmaW9tbXUtPmlv
bW11LCAmaW50ZWxfaW9tbXVfb3BzLCAKTlVMTCk7CiAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn4KICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludGVsX2lvbW11X2dy
b3Vwcwpkcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYzoxMTQwOjQ3OiBub3RlOiBlYWNoIHVuZGVj
bGFyZWQgaWRlbnRpZmllciBpcyAKcmVwb3J0ZWQgb25seSBvbmNlIGZvciBlYWNoIGZ1bmN0aW9u
IGl0IGFwcGVhcnMgaW4KbWFrZVszXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI3Nzog
ZHJpdmVycy9pb21tdS9pbnRlbC9kbWFyLm9dIEVycm9yCgppZgoKIyBDT05GSUdfSU5URUxfSU9N
TVUgaXMgbm90IHNldApDT05GSUdfSVJRX1JFTUFQPXkKCkJlc3QgcmVnYXJkcywKYmFvbHUKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
