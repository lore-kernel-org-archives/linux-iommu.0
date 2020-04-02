Return-Path: <SRS0=urD1=5S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9704C2D0F3
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 15:48:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF472063A
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 15:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF472063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8711489276;
	Thu,  2 Apr 2020 15:48:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Eck5KuUnI5qN; Thu,  2 Apr 2020 15:48:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1366989230;
	Thu,  2 Apr 2020 15:48:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE1C5C1AE2;
	Thu,  2 Apr 2020 15:48:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B331C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 15:48:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EDF7789273
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 15:48:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7QYiBjRc+UI2 for <iommu@lists.linux-foundation.org>;
 Thu,  2 Apr 2020 15:48:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 710B589230
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 15:48:51 +0000 (UTC)
IronPort-SDR: 5E8qgo6zb5M8ukIP7Oz/2w/xrJKocuzPws61OteR5mCU3n+XcMBueMhEXCFbTK4z2Xk2h7tTvr
 a3UUmEmcjEHA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2020 08:48:50 -0700
IronPort-SDR: KEe169meLIkf/vdOOwURi2neV19Ws31MpLRpkg89lEXup7r2SGjaTaWNXhMRk0b2QZoFy4X97l
 /vpNoWLNO2bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; d="scan'208";a="249872084"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga003.jf.intel.com with ESMTP; 02 Apr 2020 08:48:50 -0700
Date: Thu, 2 Apr 2020 08:54:38 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH V10 08/11] iommu/vt-d: Add svm/sva invalidate function
Message-ID: <20200402085438.38d7bd80@jacob-builder>
In-Reply-To: <d1cd2852-876a-b072-8576-962a6e61b9a9@redhat.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584746861-76386-9-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA0AB@SHSMSX104.ccr.corp.intel.com>
 <3215b83c-81f7-a30f-fe82-a51f29d7b874@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D800D67@SHSMSX104.ccr.corp.intel.com>
 <20200331135807.4e9976ab@jacob-builder>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D803C33@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A21D52E@SHSMSX104.ccr.corp.intel.com>
 <d1cd2852-876a-b072-8576-962a6e61b9a9@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

T24gV2VkLCAxIEFwciAyMDIwIDA5OjMyOjM3ICswMjAwCkF1Z2VyIEVyaWMgPGVyaWMuYXVnZXJA
cmVkaGF0LmNvbT4gd3JvdGU6Cgo+ID4gSSBkaWRu4oCZdCByZWFkIHRocm91Z2ggYWxsIGNvbW1l
bnRzLiBIZXJlIGlzIGEgY29uY2VybiB3aXRoIHRoaXMgMi1ECj4gPiB0YWJsZSwgdGhlIGlvbW11
IGNhY2hlIHR5cGUgaXMgZGVmaW5lZCBhcyBiZWxvdy4gSSBzdXBwb3NlIHRoZXJlIGlzCj4gPiBh
IHByb2JsZW0gaGVyZS4gSWYgSSdtIHVzaW5nIElPTU1VX0NBQ0hFX0lOVl9UWVBFX1BBU0lELCBp
dCB3aWxsCj4gPiBiZXlvbmQgdGhlIDItRCB0YWJsZS4KPiA+IAo+ID4gLyogSU9NTVUgcGFnaW5n
IHN0cnVjdHVyZSBjYWNoZSAqLwo+ID4gI2RlZmluZSBJT01NVV9DQUNIRV9JTlZfVFlQRV9JT1RM
QiAgICAgICgxIDw8IDApIC8qIElPTU1VIElPVExCICovCj4gPiAjZGVmaW5lIElPTU1VX0NBQ0hF
X0lOVl9UWVBFX0RFVl9JT1RMQiAgKDEgPDwgMSkgLyogRGV2aWNlIElPVExCICovCj4gPiAjZGVm
aW5lIElPTU1VX0NBQ0hFX0lOVl9UWVBFX1BBU0lEICAgICAgKDEgPDwgMikgLyogUEFTSUQgY2Fj
aGUgKi8KPiA+ICNkZWZpbmUgSU9NTVVfQ0FDSEVfSU5WX1RZUEVfTlIgICAgICAgICAoMykgIAo+
IG91cHMgaW5kZWVkCgpJIHRoaW5rIGl0IGlzIG5vdCBhbiBpc3N1ZSwgc2luY2Ugd2UgdXNlIGJp
dCBwb3NpdGlvbiBub3QgdGhlIHJhdyBjYWNoZQp0eXBlIGFzIGluZGV4IGludG8gdGhlIDJEIGFy
cmF5LiBSaWdodD8KCmZvcl9lYWNoX3NldF9iaXQoY2FjaGVfdHlwZSwgCgogcmV0ID0gdG9fdnRk
X2dyYW51bGFyaXR5KGNhY2hlX3R5cGUsIGludl9pbmZvLT5ncmFudWxhcml0eSwgJgoKc3RhdGlj
IGlubGluZSBpbnQgdG9fdnRkX2dyYW51bGFyaXR5KGludCB0eXBlLCBpbnQgZ3JhbnUsIGludCAq
dnRkX2dyYW51KQp7CgoJKnZ0ZF9ncmFudSA9IGludl90eXBlX2dyYW51X3RhYmxlW3R5cGVdW2dy
YW51XTsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
