Return-Path: <SRS0=a71q=DT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81E5C433DF
	for <iommu@archiver.kernel.org>; Mon, 12 Oct 2020 08:45:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 261BF20773
	for <iommu@archiver.kernel.org>; Mon, 12 Oct 2020 08:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261BF20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6AE6787115;
	Mon, 12 Oct 2020 08:45:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cyw+OqcJDEji; Mon, 12 Oct 2020 08:45:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B61C0815B5;
	Mon, 12 Oct 2020 08:45:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93783C0052;
	Mon, 12 Oct 2020 08:45:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DBADC0051
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 08:45:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EDF5D20774
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 08:45:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LwEo02dYN2J1 for <iommu@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 08:45:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by silver.osuosl.org (Postfix) with ESMTPS id AB66E203FD
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 08:45:18 +0000 (UTC)
IronPort-SDR: J2Ms4XsPYP1g2BXz93+vUj8ft5HX7beMqE9c2cMQS6wF+7Qjy3etsfFlms5vvpGTn0V5WTtIAb
 M83GiqwOmhCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="162242242"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; d="scan'208";a="162242242"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 01:45:17 -0700
IronPort-SDR: dRqT+ZMfCQGeam5bOf0lovKBjTKZDVf3sJIcKcMjl1w0YRl6x9nU3ddhqLbiHDWO03k4U53lr/
 YOCXdKC8ds6w==
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; d="scan'208";a="529872823"
Received: from ereuven9-mobl1.ger.corp.intel.com (HELO [10.252.38.175])
 ([10.252.38.175])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2020 01:45:15 -0700
Subject: Re: [PATCH v4 0/7] Convert the intel iommu driver to the dma-iommu api
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Tom Murphy <murphyt7@tcd.ie>, David Woodhouse <dwmw2@infradead.org>,
 Christoph Hellwig <hch@infradead.org>
References: <20200927063437.13988-1-baolu.lu@linux.intel.com>
 <e999e371-6d36-ffea-542f-a5f4b230b0ed@linux.intel.com>
 <c2af9a9d-1cae-b8f7-a0b3-880574060a23@linux.intel.com>
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <8bac9e91-36a0-c1d6-a887-4d60567ac75a@linux.intel.com>
Date: Mon, 12 Oct 2020 09:44:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c2af9a9d-1cae-b8f7-a0b3-880574060a23@linux.intel.com>
Content-Language: en-US
Cc: Intel-gfx@lists.freedesktop.org, Ashok Raj <ashok.raj@intel.com>,
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

Ck9uIDI5LzA5LzIwMjAgMDE6MTEsIEx1IEJhb2x1IHdyb3RlOgo+IEhpIFR2cnRrbywKPiAKPiBP
biA5LzI4LzIwIDU6NDQgUE0sIFR2cnRrbyBVcnN1bGluIHdyb3RlOgo+Pgo+PiBPbiAyNy8wOS8y
MDIwIDA3OjM0LCBMdSBCYW9sdSB3cm90ZToKPj4+IEhpLAo+Pj4KPj4+IFRoZSBwcmV2aW91cyBw
b3N0IG9mIHRoaXMgc2VyaWVzIGNvdWxkIGJlIGZvdW5kIGhlcmUuCj4+Pgo+Pj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMjAyMDA5MTIwMzIyMDAuMTE0ODktMS1iYW9sdS5s
dUBsaW51eC5pbnRlbC5jb20vIAo+Pj4KPj4+Cj4+PiBUaGlzIHZlcnNpb24gaW50cm9kdWNlIGEg
bmV3IHBhdGNoIFs0LzddIHRvIGZpeCBhbiBpc3N1ZSByZXBvcnRlZCBoZXJlLgo+Pj4KPj4+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11LzUxYTFiYWVjLTQ4ZDEtYzBhYy0xODFi
LTFmYmE5MmFhNDI4ZEBsaW51eC5pbnRlbC5jb20vIAo+Pj4KPj4+Cj4+PiBUaGVyZSBhcmVuJ3Qg
YW55IG90aGVyIGNoYW5nZXMuCj4+Pgo+Pj4gUGxlYXNlIGhlbHAgdG8gdGVzdCBhbmQgcmV2aWV3
Lgo+Pj4KPj4+IEJlc3QgcmVnYXJkcywKPj4+IGJhb2x1Cj4+Pgo+Pj4gTHUgQmFvbHUgKDMpOgo+
Pj4gwqDCoCBpb21tdTogQWRkIHF1aXJrIGZvciBJbnRlbCBncmFwaGljIGRldmljZXMgaW4gbWFw
X3NnCj4+Cj4+IFNpbmNlIEkgZG8gaGF2ZSBwYXRjaGVzIHRvIGZpeCBpOTE1IHRvIGhhbmRsZSB0
aGlzLCBkbyB3ZSB3YW50IHRvIAo+PiBjby1vcmRpbmF0ZSB0aGUgdHdvIGFuZCBhdm9pZCBoYXZp
bmcgdG8gYWRkIHRoaXMgcXVpcmsgYW5kIHRoZW4gbGF0ZXIgCj4+IHJlbW92ZSBpdD8gT3IgeW91
IHdhbnQgdG8gZ28gdGhlIHN0YWdlZCBhcHByb2FjaD8KPiAKPiBJIGhhdmUgbm8gcHJlZmVyZW5j
ZS4gSXQgZGVwZW5kcyBvbiB3aGljaCBwYXRjaCBnb2VzIGZpcnN0LiBMZXQgdGhlCj4gbWFpbnRh
aW5lcnMgaGVscCBoZXJlLgoKRllJIHdlIGhhdmUgbWVyZ2VkIHRoZSByZXF1aXJlZCBpOTE1IHBh
dGNoZXMgdG8gb3V0IHRyZWUgbGFzdCB3ZWVrIG9yIApzby4gSSAqdGhpbmsqIHRoaXMgbWVhbnMg
dGhleSB3aWxsIGdvIGludG8gNS4xMS4gU28gdGhlIGk5MTUgc3BlY2lmaWMgCndvcmthcm91bmQg
cGF0Y2ggd2lsbCBub3QgYmUgbmVlZGVkIGluIEludGVsIElPTU1VLgoKUmVnYXJkcywKClR2cnRr
bwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
