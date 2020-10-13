Return-Path: <SRS0=IGn4=DU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B797C433E7
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 01:33:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0771920870
	for <iommu@archiver.kernel.org>; Tue, 13 Oct 2020 01:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0771920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9F2AE859C1;
	Tue, 13 Oct 2020 01:33:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gWoOcfED6NuF; Tue, 13 Oct 2020 01:33:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 05CD0858B8;
	Tue, 13 Oct 2020 01:33:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC10FC07FF;
	Tue, 13 Oct 2020 01:33:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACA18C0051
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 01:33:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8DB0D858B8
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 01:33:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L50CaM1qMaLX for <iommu@lists.linux-foundation.org>;
 Tue, 13 Oct 2020 01:33:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4511585886
 for <iommu@lists.linux-foundation.org>; Tue, 13 Oct 2020 01:33:39 +0000 (UTC)
IronPort-SDR: zua9V1RD2b65sfJiwq0y7gxt11/tH7Z2YEcXByTo6pb2epkvTs4Dm0lYeh1wQQzrzLyoSZB66E
 TCMFGsHgttzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165940944"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="165940944"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 18:33:34 -0700
IronPort-SDR: Y6yiBB3WfuSZvQ7Y0hQ4ROweobdg0z9sw5yFkMPE7W3vzIAe7DMevaTuqdKlB0DWfjuiUiaZsZ
 /m5zaXYPGGgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; d="scan'208";a="345095782"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 12 Oct 2020 18:33:31 -0700
Subject: Re: [PATCH next] iommu: intel: make DMAR_TABLE select IOMMU_API
To: Bartosz Golaszewski <brgl@bgdev.pl>, David Woodhouse
 <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
References: <20201012123105.32652-1-brgl@bgdev.pl>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0071e295-51c7-3496-df59-c5712cef93a2@linux.intel.com>
Date: Tue, 13 Oct 2020 09:27:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012123105.32652-1-brgl@bgdev.pl>
Content-Language: en-US
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

SGksCgpPbiAxMC8xMi8yMCA4OjMxIFBNLCBCYXJ0b3N6IEdvbGFzemV3c2tpIHdyb3RlOgo+IEZy
b206IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJnb2xhc3pld3NraUBiYXlsaWJyZS5jb20+Cj4gCj4g
U2luY2UgY29tbWl0IGM0MGFhYWFjMTAxOCAoImlvbW11L3Z0LWQ6IEdyYWNlZnVsbHkgaGFuZGxl
IERNQVIgdW5pdHMKPiB3aXRoIG5vIHN1cHBvcnRlZCBhZGRyZXNzIHdpZHRocyIpIGRtYXIuYyBu
ZWVkcyBzdHJ1Y3QgaW9tbXVfZGV2aWNlIHRvCj4gYmUgZGVmaW5lZC4gV2UgbmVlZCB0byB1bmNv
bmRpdGlvbmFsbHkgc2VsZWN0IElPTU1VX0FQSSB3aGVuIERNQVJfVEFCTEUKPiBpcyBzZWxlY3Rl
ZC4gVGhpcyBmaXhlcyB0aGUgZm9sbG93aW5nIGJ1aWxkIGVycm9yIHdoZW4gSU9NTVVfQVBJIGlz
IG5vdAo+IHNlbGVjdGVkOgo+IAo+IGRyaXZlcnMvaW9tbXUvaW50ZWwvZG1hci5jOiBJbiBmdW5j
dGlvbiDigJhmcmVlX2lvbW114oCZOgo+IGRyaXZlcnMvaW9tbXUvaW50ZWwvZG1hci5jOjExMzk6
NDE6IGVycm9yOiDigJhzdHJ1Y3QgaW9tbXVfZGV2aWNl4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg
4oCYb3Bz4oCZCj4gICAxMTM5IHwgIGlmIChpbnRlbF9pb21tdV9lbmFibGVkICYmIGlvbW11LT5p
b21tdS5vcHMpIHsKClRoYW5rcyEKCkhvdyBhYm91dCBtYWtpbmcgaXQgc3ltbWV0cmljIHdpdGgg
dGhlIHJlZ2lzdHJhdGlvbiBjb2RlPwoKCWlmIChpbnRlbF9pb21tdV9lbmFibGVkICYmICFpb21t
dS0+ZHJoZC0+aWdub3JlZCkKCkJlc3QgcmVnYXJkcywKYmFvbHUKCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KPiAKPiBGaXhlczogYzQwYWFhYWMx
MDE4ICgiaW9tbXUvdnQtZDogR3JhY2VmdWxseSBoYW5kbGUgRE1BUiB1bml0cyB3aXRoIG5vIHN1
cHBvcnRlZCBhZGRyZXNzIHdpZHRocyIpCj4gU2lnbmVkLW9mZi1ieTogQmFydG9zeiBHb2xhc3pl
d3NraSA8YmdvbGFzemV3c2tpQGJheWxpYnJlLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvaW9tbXUv
aW50ZWwvS2NvbmZpZyB8IDIgKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL0tjb25m
aWcgYi9kcml2ZXJzL2lvbW11L2ludGVsL0tjb25maWcKPiBpbmRleCA1MzM3ZWUxNTg0YjAuLmY4
MTRiNzU4NWJhOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL0tjb25maWcKPiAr
KysgYi9kcml2ZXJzL2lvbW11L2ludGVsL0tjb25maWcKPiBAQCAtMSwxMyArMSwxMyBAQAo+ICAg
IyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5Cj4gICAjIEludGVsIElPTU1V
IHN1cHBvcnQKPiAgIGNvbmZpZyBETUFSX1RBQkxFCj4gKwlzZWxlY3QgSU9NTVVfQVBJCj4gICAJ
Ym9vbAo+ICAgCj4gICBjb25maWcgSU5URUxfSU9NTVUKPiAgIAlib29sICJTdXBwb3J0IGZvciBJ
bnRlbCBJT01NVSB1c2luZyBETUEgUmVtYXBwaW5nIERldmljZXMiCj4gICAJZGVwZW5kcyBvbiBQ
Q0lfTVNJICYmIEFDUEkgJiYgKFg4NiB8fCBJQTY0KQo+ICAgCXNlbGVjdCBETUFfT1BTCj4gLQlz
ZWxlY3QgSU9NTVVfQVBJCj4gICAJc2VsZWN0IElPTU1VX0lPVkEKPiAgIAlzZWxlY3QgTkVFRF9E
TUFfTUFQX1NUQVRFCj4gICAJc2VsZWN0IERNQVJfVEFCTEUKPiAKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
