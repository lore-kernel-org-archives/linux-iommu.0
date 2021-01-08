Return-Path: <SRS0=te8u=GL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A5AC433E0
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 14:30:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26F4C235FC
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 14:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F4C235FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A8AE5875C1;
	Fri,  8 Jan 2021 14:30:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ljiE9a1-ZqV7; Fri,  8 Jan 2021 14:30:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D51BA875BB;
	Fri,  8 Jan 2021 14:30:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C76ADC0891;
	Fri,  8 Jan 2021 14:30:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B75C0C013A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 14:30:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9C74C2E137
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 14:30:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 58wjdBJQ7XJ9 for <iommu@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 14:30:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id 8F9A0204FE
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 14:30:20 +0000 (UTC)
IronPort-SDR: 7tz7ZuTVlmzLBC0SAw0QquoiHLbR1oQGEt5MvE+mW0kmshOaqx//ki7mdLIP1s4y3SP7fIQ7SL
 GJwRCr9twrbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="196170180"
X-IronPort-AV: E=Sophos;i="5.79,331,1602572400"; d="scan'208";a="196170180"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2021 06:30:19 -0800
IronPort-SDR: 0WcXinTtOqmXRH+ssqMVt7oInIC49n/2sVXMAKgO6YT0i/PfHb/l28llC0ZE7rmhvrWTSgCkYK
 Jt8+INlJngwg==
X-IronPort-AV: E=Sophos;i="5.79,331,1602572400"; d="scan'208";a="380136511"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.173.91])
 ([10.249.173.91])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2021 06:30:16 -0800
Subject: Re: [PATCH 2/5] iommu/vt-d: Fix unaligned addresses for
 intel_flush_svm_range_dev()
To: Will Deacon <will@kernel.org>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
 <20201231005323.2178523-2-baolu.lu@linux.intel.com>
 <20210105190357.GA12182@willie-the-truck>
 <f8c7f124-48ab-f74f-a5cb-51b0ca4785ac@linux.intel.com>
 <9b26b7ac-b5c7-f38a-a078-b53a6b6bf375@linux.intel.com>
 <20210108140932.GA4811@willie-the-truck>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <72be0717-80ea-b0c3-9118-da8559158839@linux.intel.com>
Date: Fri, 8 Jan 2021 22:30:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210108140932.GA4811@willie-the-truck>
Content-Language: en-US
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Guo Kaijie <Kaijie.Guo@intel.com>
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

SGkgV2lsbCwKCk9uIDIwMjEvMS84IDIyOjA5LCBXaWxsIERlYWNvbiB3cm90ZToKPiBIaSBMdSwK
PiAKPiBPbiBGcmksIEphbiAwOCwgMjAyMSBhdCAwNzo1Mjo0N0FNICswODAwLCBMdSBCYW9sdSB3
cm90ZToKPj4gT24gMjAyMS8xLzYgOTowOSwgTHUgQmFvbHUgd3JvdGU6Cj4+PiBPbiAyMDIxLzEv
NiAzOjAzLCBXaWxsIERlYWNvbiB3cm90ZToKPj4+PiBPbiBUaHUsIERlYyAzMSwgMjAyMCBhdCAw
ODo1MzoyMEFNICswODAwLCBMdSBCYW9sdSB3cm90ZToKPj4+Pj4gQEAgLTE3MCw2ICsxNzIsMjIg
QEAgc3RhdGljIHZvaWQgaW50ZWxfZmx1c2hfc3ZtX3JhbmdlX2Rldgo+Pj4+PiAoc3RydWN0IGlu
dGVsX3N2bSAqc3ZtLCBzdHJ1Y3QgaW50ZWxfc3ZtX2QKPj4+Pj4gIMKgwqDCoMKgwqAgfQo+Pj4+
PiAgwqAgfQo+Pj4+PiArc3RhdGljIHZvaWQgaW50ZWxfZmx1c2hfc3ZtX3JhbmdlX2RldihzdHJ1
Y3QgaW50ZWxfc3ZtICpzdm0sCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc3RydWN0IGludGVsX3N2bV9kZXYgKnNkZXYsCj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBhZGRyZXNzLAo+
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVk
IGxvbmcgcGFnZXMsIGludCBpaCkKPj4+Pj4gK3sKPj4+Pj4gK8KgwqDCoCB1bnNpZ25lZCBsb25n
IHNoaWZ0ID0gaWxvZzIoX19yb3VuZHVwX3Bvd19vZl90d28ocGFnZXMpKTsKPj4+Pj4gK8KgwqDC
oCB1bnNpZ25lZCBsb25nIGFsaWduID0gKDFVTEwgPDwgKFZURF9QQUdFX1NISUZUICsgc2hpZnQp
KTsKPj4+Pj4gK8KgwqDCoCB1bnNpZ25lZCBsb25nIHN0YXJ0ID0gQUxJR05fRE9XTihhZGRyZXNz
LCBhbGlnbik7Cj4+Pj4+ICvCoMKgwqAgdW5zaWduZWQgbG9uZyBlbmQgPSBBTElHTihhZGRyZXNz
ICsgKHBhZ2VzIDw8Cj4+Pj4+IFZURF9QQUdFX1NISUZUKSwgYWxpZ24pOwo+Pj4+PiArCj4+Pj4+
ICvCoMKgwqAgd2hpbGUgKHN0YXJ0IDwgZW5kKSB7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBfX2Zs
dXNoX3N2bV9yYW5nZV9kZXYoc3ZtLCBzZGV2LCBzdGFydCwgYWxpZ24gPj4KPj4+Pj4gVlREX1BB
R0VfU0hJRlQsIGloKTsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHN0YXJ0ICs9IGFsaWduOwo+Pj4+
PiArwqDCoMKgIH0KPj4+Pj4gK30KPj4+Pgo+Pj4+IEdpdmVuIHRoYXQgdGhpcyBvbmx5IHNlZW1z
IHRvIGJlIGNhbGxlZCBmcm9tCj4+Pj4gaW50ZWxfaW52YWxpZGF0ZV9yYW5nZSgpLCB3aGljaAo+
Pj4+IGhhcyB0byBjb21wdXRlICdwYWdlcycgb25seSB0byBoYXZlIGl0IHB1bGxlZCBhcGFydCBh
Z2FpbiBoZXJlLAo+Pj4+IHBlcmhhcHMgaXQKPj4+PiB3b3VsZCBiZSBjbGVhbmVyIGZvciBpbnRl
bF9mbHVzaF9zdm1fcmFuZ2UoKSB0byB0YWtlIHNvbWV0aGluZyBsaWtlIGFuCj4+Pj4gJ29yZGVy
JyBhcmd1bWVudCBpbnN0ZWFkPwo+Pj4+Cj4+Pj4gV2hhdCBkbyB5b3UgdGhpbms/Cj4+Pgo+Pj4g
V2UgbmVlZCB0byBjbGVhbiB1cCBoZXJlLiBJdCdzIGR1cGxpY2F0ZSB3aXRoIHRoZSBxaV9mbHVz
aF9waW90bGIoKQo+Pj4gaGVscGVyLiBJIGhhdmUgYSBwYXRjaCB1bmRlciB0ZXN0aW5nIGZvciB0
aGlzLiBJIHdpbGwgcG9zdCBpdCBmb3IgcmV2aWV3Cj4+PiBsYXRlci4KPj4KPj4gSSdtIHNvcnJ5
LCBhYm92ZSByZXBseSBpcyBhIGxpdHRsZSB2YWd1ZS4KPj4KPj4gSSBtZWFudCB0byBzYXksIGxl
dCdzIHRha2UgJ3BhZ2VzJyBhcyB0aGUgYXJndW1lbnQuIFdlIGFyZSBnb2luZyB0byB1c2UKPj4g
cWlfZmx1c2hfcGlvdGxiKCkgaGVyZSB0byBhdm9pZCBkdXBsaWNhdGUgUUkgaW50ZXJhY3Rpb25z
LiBUaGUKPj4gcWlfZmx1c2hfcGlvdGxiKCkgaGVscGVyIGFsc28gdGFrZXMgJ3BhZ2VzJywgc28g
a2VlcCAncGFnZXMnIGhlcmUgd2lsbAo+PiBtYWtlIHRoaW5ncyBlYXNpZXIuCj4+Cj4+IE15IGNs
ZWFudXAgcGF0Y2ggaXMgZm9yIHY1LjEyLiBDYW4geW91IHBsZWFzZSB0YWtlIHRoaXMgZm9yIHY1
LjExPwo+IAo+IEFoIHNvcnJ5LCBJIGRpZG4ndCByZWFsaXNlIHRoYXQgd2FzIHlvdXIgcGxhbi4g
UGxlYXNlIGp1c3QgaW5jbHVkZSB0aGlzCj4gcGF0Y2ggaW4gYSBzZXJpZXMgb2YgMiB3aGVuIHlv
dSBwb3N0IGEgZml4ZWQgdmVyc2lvbiBvZiB0aGUgdHJhY2UgZXZlbnQKPiByZW1vdmFsIGFuZCB0
aGVuIEknbGwgcXVldWUgdGhlbSB1cCBuZXh0IHdlZWssIGFzIEkndmUgYWxyZWFkeSBwcmVwYXJl
ZAo+IHRoZSBwdWxsIGZvciB0b2RheS4KClN1cmUgYW5kIHNvcnJ5IGZvciBteSB2YWd1ZSByZXBs
eS4KCj4gCj4gQXBvbG9naWVzLAoKSXQncyBva2F5LiA6LSkKCj4gCj4gV2lsbAo+IAoKQmVzdCBy
ZWdhcmRzLApiYW9sdQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
