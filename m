Return-Path: <SRS0=3qjS=37=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75902C352A4
	for <iommu@archiver.kernel.org>; Tue, 11 Feb 2020 00:24:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 486DF20708
	for <iommu@archiver.kernel.org>; Tue, 11 Feb 2020 00:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486DF20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 05AE2879B8;
	Tue, 11 Feb 2020 00:24:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qjibit1fu4ru; Tue, 11 Feb 2020 00:24:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8951C879A6;
	Tue, 11 Feb 2020 00:24:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B9BCC1D87;
	Tue, 11 Feb 2020 00:24:30 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14EAAC07FE
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 00:24:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 006F783AE3
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 00:24:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AJnnbhWz8n9y for <iommu@lists.linux-foundation.org>;
 Tue, 11 Feb 2020 00:24:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3437C822CA
 for <iommu@lists.linux-foundation.org>; Tue, 11 Feb 2020 00:24:28 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Feb 2020 16:24:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,426,1574150400"; d="scan'208";a="227343794"
Received: from yxu42x-mobl.ccr.corp.intel.com (HELO [10.254.210.203])
 ([10.254.210.203])
 by fmsmga008.fm.intel.com with ESMTP; 10 Feb 2020 16:24:25 -0800
Subject: Re: [PATCH] iommu/vt-d: Fix compile warning from intel-svm.h
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
References: <20200210093656.8961-1-joro@8bytes.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <723094c4-1c4c-7d52-d737-d0f201e634d6@linux.intel.com>
Date: Tue, 11 Feb 2020 08:24:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200210093656.8961-1-joro@8bytes.org>
Content-Language: en-US
Cc: Joerg Roedel <jroedel@suse.de>, David Woodhouse <dwmw2@infradead.org>,
 Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
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

SGkgSm9lcmcsCgpPbiAyMDIwLzIvMTAgMTc6MzYsIEpvZXJnIFJvZWRlbCB3cm90ZToKPiBGcm9t
OiBKb2VyZyBSb2VkZWwgPGpyb2VkZWxAc3VzZS5kZT4KPiAKPiBUaGUgaW50ZWxfc3ZtX2lzX3Bh
c2lkX3ZhbGlkKCkgbmVlZHMgdG8gYmUgbWFya2VkIGlubGluZSwgb3RoZXJ3aXNlIGl0Cj4gY2F1
c2VzIHRoZSBjb21waWxlIHdhcm5pbmcgYmVsb3c6Cj4gCj4gICAgQ0MgW01dICBkcml2ZXJzL2Rt
YS9pZHhkL2NkZXYubwo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBkcml2ZXJzL2RtYS9pZHhkL2Nk
ZXYuYzo5OjA6Cj4gLi9pbmNsdWRlL2xpbnV4L2ludGVsLXN2bS5oOjEyNToxMjogd2FybmluZzog
4oCYaW50ZWxfc3ZtX2lzX3Bhc2lkX3ZhbGlk4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3Vu
dXNlZC1mdW5jdGlvbl0KPiAgIHN0YXRpYyBpbnQgaW50ZWxfc3ZtX2lzX3Bhc2lkX3ZhbGlkKHN0
cnVjdCBkZXZpY2UgKmRldiwgaW50IHBhc2lkKQo+ICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn4KPiAKPiBSZXBvcnRlZC1ieTogQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjgu
ZGU+Cj4gRml4ZXM6IDE1MDYwYWJhNzE3MTEgKCdpb21tdS92dC1kOiBIZWxwZXIgZnVuY3Rpb24g
dG8gcXVlcnkgaWYgYSBwYXNpZCBoYXMgYW55IGFjdGl2ZSB1c2VycycpCj4gU2lnbmVkLW9mZi1i
eTogSm9lcmcgUm9lZGVsIDxqcm9lZGVsQHN1c2UuZGU+CgpBY2tlZC1ieTogTHUgQmFvbHUgPGJh
b2x1Lmx1QGxpbnV4LmludGVsLmNvbT4KCkJlc3QgcmVnYXJkcywKYmFvbHUKCj4gLS0tCj4gICBp
bmNsdWRlL2xpbnV4L2ludGVsLXN2bS5oIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
aW50ZWwtc3ZtLmggYi9pbmNsdWRlL2xpbnV4L2ludGVsLXN2bS5oCj4gaW5kZXggOTRmMDQ3YThh
ODQ1Li5kN2M0MDNkMGRkMjcgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9saW51eC9pbnRlbC1zdm0u
aAo+ICsrKyBiL2luY2x1ZGUvbGludXgvaW50ZWwtc3ZtLmgKPiBAQCAtMTIyLDcgKzEyMiw3IEBA
IHN0YXRpYyBpbmxpbmUgaW50IGludGVsX3N2bV91bmJpbmRfbW0oc3RydWN0IGRldmljZSAqZGV2
LCBpbnQgcGFzaWQpCj4gICAJQlVHKCk7Cj4gICB9Cj4gICAKPiAtc3RhdGljIGludCBpbnRlbF9z
dm1faXNfcGFzaWRfdmFsaWQoc3RydWN0IGRldmljZSAqZGV2LCBpbnQgcGFzaWQpCj4gK3N0YXRp
YyBpbmxpbmUgaW50IGludGVsX3N2bV9pc19wYXNpZF92YWxpZChzdHJ1Y3QgZGV2aWNlICpkZXYs
IGludCBwYXNpZCkKPiAgIHsKPiAgIAlyZXR1cm4gLUVJTlZBTDsKPiAgIH0KPiAKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0
CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
