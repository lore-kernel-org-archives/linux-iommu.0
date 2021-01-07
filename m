Return-Path: <SRS0=iLvA=GK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AA8C433E6
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 23:53:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A5B2368A
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 23:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A5B2368A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 295DB2E110;
	Thu,  7 Jan 2021 23:53:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aE0O-sHFxZ+5; Thu,  7 Jan 2021 23:52:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F2F362E10D;
	Thu,  7 Jan 2021 23:52:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3A43C0891;
	Thu,  7 Jan 2021 23:52:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0962C013A
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 23:52:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 54FD32E10D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 23:52:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nVWNLMvSNIaM for <iommu@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 23:52:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by silver.osuosl.org (Postfix) with ESMTPS id 5B3FE20341
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 23:52:52 +0000 (UTC)
IronPort-SDR: ujlM8coLWaa2MHSkds8tzS0V7VD6ffvIPKBt0aqvrxxzgezwV5LfHBeDVnvd0ajG/fCDSSTLtr
 yplDcqBsUABQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="156697474"
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; d="scan'208";a="156697474"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2021 15:52:52 -0800
IronPort-SDR: STUYzP1dmLk5rXkzTQFfUHnw4R0sK1nl2mGZ8Xx/VvgmNgfthmWjQSqGTB1GPv3B9u0R6fZTvR
 qJkph4PCMZ3g==
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; d="scan'208";a="379907722"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.31.120])
 ([10.255.31.120])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2021 15:52:49 -0800
To: Will Deacon <will@kernel.org>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
 <20201231005323.2178523-2-baolu.lu@linux.intel.com>
 <20210105190357.GA12182@willie-the-truck>
 <f8c7f124-48ab-f74f-a5cb-51b0ca4785ac@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/5] iommu/vt-d: Fix unaligned addresses for
 intel_flush_svm_range_dev()
Message-ID: <9b26b7ac-b5c7-f38a-a078-b53a6b6bf375@linux.intel.com>
Date: Fri, 8 Jan 2021 07:52:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <f8c7f124-48ab-f74f-a5cb-51b0ca4785ac@linux.intel.com>
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

SGkgV2lsbCwKCk9uIDIwMjEvMS82IDk6MDksIEx1IEJhb2x1IHdyb3RlOgo+IEhpIFdpbGwsCj4g
Cj4gSGFwcHkgTmV3IFllYXIhCj4gCj4gT24gMjAyMS8xLzYgMzowMywgV2lsbCBEZWFjb24gd3Jv
dGU6Cj4+IE9uIFRodSwgRGVjIDMxLCAyMDIwIGF0IDA4OjUzOjIwQU0gKzA4MDAsIEx1IEJhb2x1
IHdyb3RlOgo+Pj4gVGhlIFZULWQgaGFyZHdhcmUgd2lsbCBpZ25vcmUgdGhvc2UgQWRkciBiaXRz
IHdoaWNoIGhhdmUgYmVlbiBtYXNrZWQgYnkKPj4+IHRoZSBBTSBmaWVsZCBpbiB0aGUgUEFTSUQt
YmFzZWQtSU9UTEIgaW52YWxpZGF0aW9uIGRlc2NyaXB0b3IuIEFzIHRoZQo+Pj4gcmVzdWx0LCBp
ZiB0aGUgc3RhcnRpbmcgYWRkcmVzcyBpbiB0aGUgZGVzY3JpcHRvciBpcyBub3QgYWxpZ25lZCB3
aXRoCj4+PiB0aGUgYWRkcmVzcyBtYXNrLCBzb21lIElPVExCIGNhY2hlcyBtaWdodCBub3QgaW52
YWxpZGF0ZS4gSGVuY2UgcGVvcGxlCj4+PiB3aWxsIHNlZSBiZWxvdyBlcnJvcnMuCj4+Pgo+Pj4g
WyAxMDkzLjcwNDY2MV0gZG1hcl9mYXVsdDogMjkgY2FsbGJhY2tzIHN1cHByZXNzZWQKPj4+IFsg
MTA5My43MDQ2NjRdIERNQVI6IERSSEQ6IGhhbmRsaW5nIGZhdWx0IHN0YXR1cyByZWcgMwo+Pj4g
WyAxMDkzLjcxMjczOF0gRE1BUjogW0RNQSBSZWFkXSBSZXF1ZXN0IGRldmljZSBbN2E6MDIuMF0g
UEFTSUQgMgo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZhdWx0IGFkZHIgN2Y4
MWM5NjhkMDAwIFtmYXVsdCByZWFzb24gMTEzXQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFNNOiBQcmVzZW50IGJpdCBpbiBmaXJzdC1sZXZlbCBwYWdpbmcgZW50cnkgaXMgY2xl
YXIKPj4+Cj4+PiBGaXggdGhpcyBieSB1c2luZyBhbGlnbmVkIGFkZHJlc3MgZm9yIFBBU0lELWJh
c2VkLUlPVExCIGludmFsaWRhdGlvbi4KPj4+Cj4+PiBGaXhlczogMWM0Zjg4YjdmMWY5MiAoImlv
bW11L3Z0LWQ6IFNoYXJlZCB2aXJ0dWFsIGFkZHJlc3MgaW4gc2NhbGFibGUgCj4+PiBtb2RlIikK
Pj4+IFJlcG9ydGVkLWFuZC10ZXN0ZWQtYnk6IEd1byBLYWlqaWUgPEthaWppZS5HdW9AaW50ZWwu
Y29tPgo+Pj4gU2lnbmVkLW9mZi1ieTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNv
bT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9pb21tdS9pbnRlbC9zdm0uYyB8IDIyICsrKysrKysr
KysrKysrKysrKysrLS0KPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL3N2
bS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9zdm0uYwo+Pj4gaW5kZXggNjk1NjY2OTVkMDMyLi5i
MTZhNDc5MWFjZmIgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL3N2bS5jCj4+
PiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL3N2bS5jCj4+PiBAQCAtMTE4LDggKzExOCwxMCBA
QCB2b2lkIGludGVsX3N2bV9jaGVjayhzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlvbW11KQo+Pj4gwqDC
oMKgwqDCoCBpb21tdS0+ZmxhZ3MgfD0gVlREX0ZMQUdfU1ZNX0NBUEFCTEU7Cj4+PiDCoCB9Cj4+
PiAtc3RhdGljIHZvaWQgaW50ZWxfZmx1c2hfc3ZtX3JhbmdlX2RldiAoc3RydWN0IGludGVsX3N2
bSAqc3ZtLCBzdHJ1Y3QgCj4+PiBpbnRlbF9zdm1fZGV2ICpzZGV2LAo+Pj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGFkZHJlc3MsIHVuc2lnbmVkIGxvbmcg
cGFnZXMsIGludCBpaCkKPj4+ICtzdGF0aWMgdm9pZCBfX2ZsdXNoX3N2bV9yYW5nZV9kZXYoc3Ry
dWN0IGludGVsX3N2bSAqc3ZtLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc3RydWN0IGludGVsX3N2bV9kZXYgKnNkZXYsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGFkZHJlc3MsCj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIHBhZ2VzLCBpbnQgaWgpCj4+PiDCoCB7
Cj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBxaV9kZXNjIGRlc2M7Cj4+PiBAQCAtMTcwLDYgKzE3Miwy
MiBAQCBzdGF0aWMgdm9pZCBpbnRlbF9mbHVzaF9zdm1fcmFuZ2VfZGV2IChzdHJ1Y3QgCj4+PiBp
bnRlbF9zdm0gKnN2bSwgc3RydWN0IGludGVsX3N2bV9kCj4+PiDCoMKgwqDCoMKgIH0KPj4+IMKg
IH0KPj4+ICtzdGF0aWMgdm9pZCBpbnRlbF9mbHVzaF9zdm1fcmFuZ2VfZGV2KHN0cnVjdCBpbnRl
bF9zdm0gKnN2bSwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc3RydWN0IGludGVsX3N2bV9kZXYgKnNkZXYsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgYWRkcmVzcywKPj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBwYWdlcywg
aW50IGloKQo+Pj4gK3sKPj4+ICvCoMKgwqAgdW5zaWduZWQgbG9uZyBzaGlmdCA9IGlsb2cyKF9f
cm91bmR1cF9wb3dfb2ZfdHdvKHBhZ2VzKSk7Cj4+PiArwqDCoMKgIHVuc2lnbmVkIGxvbmcgYWxp
Z24gPSAoMVVMTCA8PCAoVlREX1BBR0VfU0hJRlQgKyBzaGlmdCkpOwo+Pj4gK8KgwqDCoCB1bnNp
Z25lZCBsb25nIHN0YXJ0ID0gQUxJR05fRE9XTihhZGRyZXNzLCBhbGlnbik7Cj4+PiArwqDCoMKg
IHVuc2lnbmVkIGxvbmcgZW5kID0gQUxJR04oYWRkcmVzcyArIChwYWdlcyA8PCBWVERfUEFHRV9T
SElGVCksIAo+Pj4gYWxpZ24pOwo+Pj4gKwo+Pj4gK8KgwqDCoCB3aGlsZSAoc3RhcnQgPCBlbmQp
IHsKPj4+ICvCoMKgwqDCoMKgwqDCoCBfX2ZsdXNoX3N2bV9yYW5nZV9kZXYoc3ZtLCBzZGV2LCBz
dGFydCwgYWxpZ24gPj4gCj4+PiBWVERfUEFHRV9TSElGVCwgaWgpOwo+Pj4gK8KgwqDCoMKgwqDC
oMKgIHN0YXJ0ICs9IGFsaWduOwo+Pj4gK8KgwqDCoCB9Cj4+PiArfQo+Pgo+PiBHaXZlbiB0aGF0
IHRoaXMgb25seSBzZWVtcyB0byBiZSBjYWxsZWQgZnJvbSBpbnRlbF9pbnZhbGlkYXRlX3Jhbmdl
KCksIAo+PiB3aGljaAo+PiBoYXMgdG8gY29tcHV0ZSAncGFnZXMnIG9ubHkgdG8gaGF2ZSBpdCBw
dWxsZWQgYXBhcnQgYWdhaW4gaGVyZSwgCj4+IHBlcmhhcHMgaXQKPj4gd291bGQgYmUgY2xlYW5l
ciBmb3IgaW50ZWxfZmx1c2hfc3ZtX3JhbmdlKCkgdG8gdGFrZSBzb21ldGhpbmcgbGlrZSBhbgo+
PiAnb3JkZXInIGFyZ3VtZW50IGluc3RlYWQ/Cj4+Cj4+IFdoYXQgZG8geW91IHRoaW5rPwo+IAo+
IFdlIG5lZWQgdG8gY2xlYW4gdXAgaGVyZS4gSXQncyBkdXBsaWNhdGUgd2l0aCB0aGUgcWlfZmx1
c2hfcGlvdGxiKCkKPiBoZWxwZXIuIEkgaGF2ZSBhIHBhdGNoIHVuZGVyIHRlc3RpbmcgZm9yIHRo
aXMuIEkgd2lsbCBwb3N0IGl0IGZvciByZXZpZXcKPiBsYXRlci4KCkknbSBzb3JyeSwgYWJvdmUg
cmVwbHkgaXMgYSBsaXR0bGUgdmFndWUuCgpJIG1lYW50IHRvIHNheSwgbGV0J3MgdGFrZSAncGFn
ZXMnIGFzIHRoZSBhcmd1bWVudC4gV2UgYXJlIGdvaW5nIHRvIHVzZQpxaV9mbHVzaF9waW90bGIo
KSBoZXJlIHRvIGF2b2lkIGR1cGxpY2F0ZSBRSSBpbnRlcmFjdGlvbnMuIFRoZQpxaV9mbHVzaF9w
aW90bGIoKSBoZWxwZXIgYWxzbyB0YWtlcyAncGFnZXMnLCBzbyBrZWVwICdwYWdlcycgaGVyZSB3
aWxsCm1ha2UgdGhpbmdzIGVhc2llci4KCk15IGNsZWFudXAgcGF0Y2ggaXMgZm9yIHY1LjEyLiBD
YW4geW91IHBsZWFzZSB0YWtlIHRoaXMgZm9yIHY1LjExPwoKQmVzdCByZWdhcmRzLApiYW9sdQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
