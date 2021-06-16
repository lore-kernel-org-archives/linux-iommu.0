Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EC6C48BE6
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 08:42:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A839A610EA
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 08:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A839A610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74028827C9;
	Wed, 16 Jun 2021 08:42:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jGAgghAmXMw3; Wed, 16 Jun 2021 08:42:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7272582564;
	Wed, 16 Jun 2021 08:42:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4462FC000E;
	Wed, 16 Jun 2021 08:42:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3849C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 08:42:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA081401CF
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 08:42:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Nl2QLJVTQWw for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 08:42:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A45D84017D
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 08:42:24 +0000 (UTC)
IronPort-SDR: Sh0/ByB5VfuhBL3XSa4g9kKjR47RILAhJK0dtV8VaozvTUqYNvdvzj8V/SAvArndMSbAr6EiFM
 WqjiHItkSgAg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="291770841"
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; d="scan'208";a="291770841"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2021 01:42:23 -0700
IronPort-SDR: XkMrx79+dB/mNC/PtGc2214acDd1tQm3kKMHkMe7U42BlYgoA1S0+ARJaX4DmyEBki/aLU+Wte
 49DGkPS1dyLg==
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; d="scan'208";a="484805084"
Received: from hchan3-mobl1.gar.corp.intel.com (HELO [10.254.212.123])
 ([10.254.212.123])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2021 01:42:20 -0700
Subject: Re: [PATCH v12 3/5] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To: Robin Murphy <robin.murphy@arm.com>, John Garry <john.garry@huawei.com>,
 joro@8bytes.org, will@kernel.org, dwmw2@infradead.org
References: <1623414043-40745-1-git-send-email-john.garry@huawei.com>
 <1623414043-40745-4-git-send-email-john.garry@huawei.com>
 <f3940a3f-d1c1-148d-e4b5-51cecf924ff5@linux.intel.com>
 <03675e2f-c3a6-ce33-ef96-f9ae544b2d13@huawei.com>
 <824db374-dc82-a9ea-b162-2f51e70ef999@linux.intel.com>
 <c3e1bb30-e1a9-08d7-0787-06a0bb119461@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a4b794be-6648-c088-877d-cdf8762151f6@linux.intel.com>
Date: Wed, 16 Jun 2021 16:42:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c3e1bb30-e1a9-08d7-0787-06a0bb119461@arm.com>
Content-Language: en-US
Cc: linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
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

T24gMjAyMS82LzE1IDE2OjI1LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMS0wNi0xNSAw
ODoyNiwgTHUgQmFvbHUgd3JvdGU6Cj4+IEhpIEpvaG4sCj4+Cj4+IE9uIDYvMTQvMjEgNDowMyBQ
TSwgSm9obiBHYXJyeSB3cm90ZToKPj4+IE9uIDEyLzA2LzIwMjEgMDM6MTQsIEx1IEJhb2x1IHdy
b3RlOgo+Pj4+IE9uIDIwMjEvNi8xMSAyMDoyMCwgSm9obiBHYXJyeSB3cm90ZToKPj4+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvS2NvbmZpZyBiL2RyaXZlcnMvaW9tbXUvS2NvbmZpZwo+
Pj4+PiBpbmRleCAyYTcxMzQ3NjExZDQuLjQ0NjczNTNmOTgxYiAxMDA2NDQKPj4+Pj4gLS0tIGEv
ZHJpdmVycy9pb21tdS9LY29uZmlnCj4+Pj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvS2NvbmZpZwo+
Pj4+PiBAQCAtOTQsNiArOTQsNyBAQCBjaG9pY2UKPj4+Pj4gwqDCoMKgwqDCoCBwcm9tcHQgIklP
TU1VIGRlZmF1bHQgRE1BIG1vZGUiCj4+Pj4+IMKgwqDCoMKgwqAgZGVwZW5kcyBvbiBJT01NVV9E
TUEKPj4+Pj4gK8KgwqDCoCBkZWZhdWx0IElPTU1VX0RFRkFVTFRfTEFaWSBpZiBJTlRFTF9JT01N
VQo+Pj4+PiDCoMKgwqDCoMKgIGRlZmF1bHQgSU9NTVVfREVGQVVMVF9TVFJJQ1QKPj4+Pgo+Pj4+
IElmIHR3byBkZWZhdWx0IHZhbHVlcyBhcmUgZGlmZmVyZW50LiBXaGljaCBvbmUgd2lsbCBiZSBv
dmVycmlkZGVuPwo+Pj4KPj4+IElmIEkgdW5kZXJzdGFuZCB5b3VyIHF1ZXN0aW9uIGNvcnJlY3Rs
eSwgSSB0aGluayB5b3UgYXJlIGFza2luZyBpZiAKPj4+IGJvdGggYXJlIHNldDoKPj4+IENPTkZJ
R19JT01NVV9ERUZBVUxUX0xBWlk9eQo+Pj4gQ09ORklHX0lPTU1VX0RFRkFVTFRfU1RSSUNUPXkK
Pj4+Cj4+PiBJZiB0aGlzIGhhcHBlbnMsIHRoZW4gbWFrZSBkZWZjb25maWcgY29tcGxhaW5zIGFi
b3V0IGJvdGggYmVpbmcgc2V0LCAKPj4+IGFuZCBzZWxlY3RzIHRoZSAybmQsIHdoYXRldmVyIHRo
YXQgaXMuCj4+Cj4+IE9uIHg4NiwgSW50ZWwgb3IgQU1ELCB0aGlzIHdpbGwgYmUKPj4KPj4gwqDC
oMKgwqDCoHByb21wdCAiSU9NTVUgZGVmYXVsdCBETUEgbW9kZSIKPj4gwqDCoMKgwqDCoMKgIGRl
cGVuZHMgb24gSU9NTVVfRE1BCj4+IMKgwqDCoMKgwqDCoCBkZWZhdWx0IElPTU1VX0RFRkFVTFRf
TEFaWQo+PiDCoMKgwqDCoMKgwqAgZGVmYXVsdCBJT01NVV9ERUZBVUxUX1NUUklDVAo+Pgo+PiB3
aGljaCB3aWxsIGJlIGRlZmF1bHQsIExBWlkgb3IgU1RSSUNUPyBXaWxsIGl0IGNhdXNlIGNvbXBs
YWlucz8KPiAKPiBTZWUgRG9jdW1lbnRhdGlvbi9rYnVpbGQva2NvbmZpZy1sYW5ndWFnZS5yc3Q6
Cj4gCj4gIMKgIEEgY29uZmlnIG9wdGlvbiBjYW4gaGF2ZSBhbnkgbnVtYmVyIG9mIGRlZmF1bHQg
dmFsdWVzLiBJZiBtdWx0aXBsZQo+ICDCoCBkZWZhdWx0IHZhbHVlcyBhcmUgdmlzaWJsZSwgb25s
eSB0aGUgZmlyc3QgZGVmaW5lZCBvbmUgaXMgYWN0aXZlLgoKR2V0IGl0LiBUaGFuayB5b3UsIFJv
YmluLgoKQmVzdCByZWdhcmRzLApiYW9sdQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
