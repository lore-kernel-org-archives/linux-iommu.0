Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B31C433EF
	for <iommu@archiver.kernel.org>; Fri, 25 Feb 2022 02:21:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B31C383EBC;
	Fri, 25 Feb 2022 02:21:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hXykSrWYfaRh; Fri, 25 Feb 2022 02:21:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7222F83EB7;
	Fri, 25 Feb 2022 02:21:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15588C001A;
	Fri, 25 Feb 2022 02:21:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51044C0011
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 02:21:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 390B8607C0
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 02:21:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LG42u5n2hSvB for <iommu@lists.linux-foundation.org>;
 Fri, 25 Feb 2022 02:21:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3428360598
 for <iommu@lists.linux-foundation.org>; Fri, 25 Feb 2022 02:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645755693; x=1677291693;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=s5vp1IwT5k3ngcFntxcnnAVcfrBnrLVYi2lHOnKIQaQ=;
 b=OtjMjr2w2FBBrF+6GCCe2RiPEcbllZlV/n5ISjhkr69Wa7xPvC/rMrjj
 utJIJhQU+jUzHWhEfuFXMg57O07VXNo4VNQP1KBBbOUwUDYrn7YwDff8h
 LkPA276pYvZNszFf1QYuuycOTH+pPIiFrtrTbwkbJ5zXEWX0ZIWs4npuI
 FAN++LOupj5zAnZG0c3FvgPn56D/KF74NohE/nbQt6bipt7I8G1MvKPKc
 /fvXJErrP8W43hTwojHowF/nwVBd6O4BCXiXEpxl7t4KQrjzg7zp3PrZh
 BJjX4RcljfPMZdDRd0l/sLhrShSOri2jTrPTXrUqDndIAw2noGnjWqoPc g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="235909424"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="235909424"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2022 18:21:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; d="scan'208";a="533392203"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 24 Feb 2022 18:21:30 -0800
Message-ID: <9a3d9767-e63b-0bcc-99a9-5e1cf9c31493@linux.intel.com>
Date: Fri, 25 Feb 2022 10:20:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] iommu/vt-d: Add RPLS to quirk list to skip TE disabling
Content-Language: en-US
To: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 "Surendrakumar Upadhyay, TejaskumarX"
 <tejaskumarx.surendrakumar.upadhyay@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
References: <20220223062957.31797-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
 <8dcb852f-ef40-5b93-3713-a2d701d90320@linux.intel.com>
 <2eb4e522d6294a6ade91b89ea1c5cc7c8dac1e51.camel@intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <2eb4e522d6294a6ade91b89ea1c5cc7c8dac1e51.camel@intel.com>
Cc: "Talla, RavitejaX Goud" <ravitejax.goud.talla@intel.com>
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

T24gMi8yNC8yMiA5OjM5IFBNLCBWaXZpLCBSb2RyaWdvIHdyb3RlOgo+IE9uIFRodSwgMjAyMi0w
Mi0yNCBhdCAxMzo0MiArMDgwMCwgTHUgQmFvbHUgd3JvdGU6Cj4+IE9uIDIvMjMvMjIgMjoyOSBQ
TSwgVGVqYXMgVXBhZGh5YXkgd3JvdGU6Cj4+PiBUaGUgVlQtZCBzcGVjIHJlcXVpcmVzICgxMC40
LjQgR2xvYmFsIENvbW1hbmQgUmVnaXN0ZXIsIFRFCj4+PiBmaWVsZCkgdGhhdDoKPj4+Cj4+PiBI
YXJkd2FyZSBpbXBsZW1lbnRhdGlvbnMgc3VwcG9ydGluZyBETUEgZHJhaW5pbmcgbXVzdCBkcmFp
bgo+Pj4gYW55IGluLWZsaWdodCBETUEgcmVhZC93cml0ZSByZXF1ZXN0cyBxdWV1ZWQgd2l0aGlu
IHRoZQo+Pj4gUm9vdC1Db21wbGV4IGJlZm9yZSBjb21wbGV0aW5nIHRoZSB0cmFuc2xhdGlvbiBl
bmFibGUKPj4+IGNvbW1hbmQgYW5kIHJlZmxlY3RpbmcgdGhlIHN0YXR1cyBvZiB0aGUgY29tbWFu
ZCB0aHJvdWdoCj4+PiB0aGUgVEVTIGZpZWxkIGluIHRoZSBHbG9iYWwgU3RhdHVzIHJlZ2lzdGVy
Lgo+Pj4KPj4+IFVuZm9ydHVuYXRlbHksIHNvbWUgaW50ZWdyYXRlZCBncmFwaGljIGRldmljZXMg
ZmFpbCB0byBkbwo+Pj4gc28gYWZ0ZXIgc29tZSBraW5kIG9mIHBvd2VyIHN0YXRlIHRyYW5zaXRp
b24uIEFzIHRoZQo+Pj4gcmVzdWx0LCB0aGUgc3lzdGVtIG1pZ2h0IHN0dWNrIGluIGlvbW11X2Rp
c2FibGVfdHJhbnNsYXRpCj4+PiBvbigpLCB3YWl0aW5nIGZvciB0aGUgY29tcGxldGlvbiBvZiBU
RSB0cmFuc2l0aW9uLgo+Pj4KPj4+IFRoaXMgYWRkcyBSUExTIHRvIGEgcXVpcmsgbGlzdCBmb3Ig
dGhvc2UgZGV2aWNlcyBhbmQgc2tpcHMKPj4+IFRFIGRpc2FibGluZyBpZiB0aGUgcXVyaWsgaGl0
cy4KPj4+Cj4+PiBGaXhlczogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9pbnRl
bC8tL2lzc3Vlcy80ODk4Cj4+PiBGaXhlczogTENLLTEwNzg5Cj4+Cj4+IFJlbW92ZSB0aGlzIHBs
ZWFzZS4KPiAKPiBnb29kIGNhdGNoLiBXcm9uZyB1c2Ugb2YgRml4ZXMgdGFnLgo+ICJGaXhlczoi
IHNob3VsZCBvbmx5IGJlIHVzZWQgZm9yIHBhdGNoZXMgZml4aW5nIG90aGVyIHBhdGNoZXMgYW5k
Cj4gbWVudGlvbmluZyB0aGUgY29tbWl0IGlkLgoKVGhpcyBpcyBzdGlsbCBhIGZpeCBwYXRjaCwg
cmlnaHQ/IElmIHNvLAoKRml4ZXM6IGIxMDEyY2E4ZGM0ZjkgImlvbW11L3Z0LWQ6IFNraXAgVEUg
ZGlzYWJsaW5nIG9uIHF1aXJreSBnZnggCmRlZGljYXRlZCBpb21tdSIKQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcKCj4gCj4gQmFvbHUsCj4gY291bGQgeW91IG1pbmQgaWYgd2UgdXNlCj4gCj4g
Q2xvc2VzOiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2ludGVsLy0vaXNzdWVz
LzQ4OTgKPiAKPiBvciBtYXliZQo+IAo+IFJlZmVyZW5jZXM6IGh0dHBzOi8vZ2l0bGFiLmZyZWVk
ZXNrdG9wLm9yZy9kcm0vaW50ZWwvLS9pc3N1ZXMvNDg5OAo+IAo+IFRoaXMgbGFzdCBvbmUgc2Vl
bXMgdG8gYmUgdGhlIG9uZSB1c2UgaW4gZHJpdmVycy9pb21tdQo+IGFuZCB0aGUgQ2xvc2VzIGlz
IHdoYXQgd2UgdXNlIGluIGRybS1pbnRlbCwgaGVuY2UgdGhlIG9uZSB1c2VkCj4gd2l0aCBnaXRs
YWIuZnJlZWRlc2t0b3AgbGlua3MgaW4gZ2VuZXJhbC4KCkhvdyBhYm91dCAiTGluazoiPwoKQXMg
RG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3Qgc3RhdGVzOgoKSWYg
cmVsYXRlZCBkaXNjdXNzaW9ucyBvciBhbnkgb3RoZXIgYmFja2dyb3VuZCBpbmZvcm1hdGlvbiBi
ZWhpbmQgdGhlIGNoYW5nZQpjYW4gYmUgZm91bmQgb24gdGhlIHdlYiwgYWRkICdMaW5rOicgdGFn
cyBwb2ludGluZyB0byBpdC4gSW4gY2FzZSB5b3VyIHBhdGNoCmZpeGVzIGEgYnVnLCBmb3IgZXhh
bXBsZSwgYWRkIGEgdGFnIHdpdGggYSBVUkwgcmVmZXJlbmNpbmcgdGhlIHJlcG9ydCBpbiB0aGUK
bWFpbGluZyBsaXN0IGFyY2hpdmVzIG9yIGEgYnVnIHRyYWNrZXI7IGlmIHRoZSBwYXRjaCBpcyBh
IHJlc3VsdCBvZiBzb21lCmVhcmxpZXIgbWFpbGluZyBsaXN0IGRpc2N1c3Npb24gb3Igc29tZXRo
aW5nIGRvY3VtZW50ZWQgb24gdGhlIHdlYiwgcG9pbnQgdG8KaXQuCgoKPiAKPj4KPj4+IFRlc3Rl
ZC1ieTogUmF2aXRlamEgR291ZCBUYWxsYSA8cmF2aXRlamF4LmdvdWQudGFsbGFAaW50ZWwuY29t
Pgo+Pj4gQ2M6IFJvZHJpZ28gVml2aSA8cm9kcmlnby52aXZpQGludGVsLmNvbT4KPj4+IFNpZ25l
ZC1vZmYtYnk6IFRlamFzIFVwYWRoeWF5Cj4+PiA8dGVqYXNrdW1hcnguc3VyZW5kcmFrdW1hci51
cGFkaHlheUBpbnRlbC5jb20+Cj4gCj4geW91IGNhbiBrZWVwIG15IHJ2LWIKPiAKPj4+IC0tLQo+
Pj4gIMKgIGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyB8IDIgKy0KPj4+ICDCoCAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jCj4+PiBiL2RyaXZlcnMvaW9tbXUvaW50ZWwv
aW9tbXUuYwo+Pj4gaW5kZXggOTJmZWEzZmJiYjExLi5iZTk0ODc1MTY2MTcgMTAwNjQ0Cj4+PiAt
LS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKPj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUv
aW50ZWwvaW9tbXUuYwo+Pj4gQEAgLTU3NDMsNyArNTc0Myw3IEBAIHN0YXRpYyB2b2lkIHF1aXJr
X2lnZnhfc2tpcF90ZV9kaXNhYmxlKHN0cnVjdAo+Pj4gcGNpX2RldiAqZGV2KQo+Pj4gIMKgwqDC
oMKgwqDCoMKgwqB2ZXIgPSAoZGV2LT5kZXZpY2UgPj4gOCkgJiAweGZmOwo+Pj4gIMKgwqDCoMKg
wqDCoMKgwqBpZiAodmVyICE9IDB4NDUgJiYgdmVyICE9IDB4NDYgJiYgdmVyICE9IDB4NGMgJiYK
Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZlciAhPSAweDRlICYmIHZlciAhPSAweDhhICYm
IHZlciAhPSAweDk4ICYmCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmVyICE9IDB4OWEpCj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmVyICE9IDB4OWEgJiYgdmVyICE9IDB4YTcpCj4+PiAg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm47Cj4+PiAgICAKPj4+ICDCoMKg
wqDCoMKgwqDCoMKgaWYgKHJpc2t5X2RldmljZShkZXYpKQo+Pgo+PiBUaGlzIGlzIGEgcXVpcmsg
Zm9yIGludGVncmF0ZWQgZ3JhcGhpYyBkZXZpY2UuIFJvZHJpZ28sIGRvZXMgdGhpcwo+PiBoYXJk
d2FyZSBuZWVkcyB0aGlzIHF1aXJrIGFzIHdlbGw/Cj4gCj4gWWVzLCAweGE3KiBhcmUgUlBMLVMg
dGhhdCBhcmUgaW50ZWdyYXRlZCBhbmQgdmVyeSBzaW1pbGFyIHRvIDB4NDYqCj4gKEFETC1TKQoK
VGhhbmsgeW91IGZvciBjb25maXJtaW5nIHRoaXMgcXVpcmsuCgo+IAo+IEkgd291bGQgcHJlZmVy
IHRvIGhhdmUgYSBtb3JlIGV4cGFuZGVkIGxpc3QgaW5zdGVhZCBvZiBncm91cCBvciBhdAo+IGxl
YXN0IHNvbWUgZGVmaW5lcyB3aXRoIHRoZSBwbGF0Zm9ybSBuYW1lcy4KClllYWghIFRoYXQncyBi
ZXR0ZXIuCgpCZXN0IHJlZ2FyZHMsCmJhb2x1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
