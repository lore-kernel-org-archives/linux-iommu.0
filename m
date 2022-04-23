Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8BFC433EF
	for <iommu@archiver.kernel.org>; Sat, 23 Apr 2022 09:41:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22F0860C30;
	Sat, 23 Apr 2022 09:41:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IkxXVZCLTgYH; Sat, 23 Apr 2022 09:41:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D57A360B91;
	Sat, 23 Apr 2022 09:41:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A98EEC0039;
	Sat, 23 Apr 2022 09:41:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5D1DC002D
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 09:41:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C47F3418F8
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 09:41:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nn4ITUI2fuMP for <iommu@lists.linux-foundation.org>;
 Sat, 23 Apr 2022 09:41:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3BEF741845
 for <iommu@lists.linux-foundation.org>; Sat, 23 Apr 2022 09:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650706869; x=1682242869;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=hBODXYIZdwIa4pvC2+O751g19pA25+K1CDHEV6UNNiU=;
 b=ev9ipihno1UL2xbBFN4nSLem7N3dziCTfui2aaR1/bg302TXfEC6tQq7
 ml96YWa3PthuQEsWvww08+NBKphAGBc49ZbK1bO5BtbiUZbJ5E1TJ1VYn
 Zeo0ymKvKwWTMycybjjapJCkhJk+1j4aBco25J/5GaTyDzWeoN78VE2/v
 YH4Vak+1S9aXo/TBREMVK8MyHDHX3prJlHITKGCD2NTbk6CTTQui1Y0xd
 TFgs35SkB3ID6EazKa2JudO4SexueVBdL9WSkyJCeQsaBZStQN+W5e9VR
 +TtQ0sR2WzJjENGwFWtwp9BJNe9YJrQ0UN24gK+pjPerYd+z3EDqpqJt9 g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="262468547"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; d="scan'208";a="262468547"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2022 02:41:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; d="scan'208";a="578340638"
Received: from yjsun1-mobl.ccr.corp.intel.com (HELO [10.255.31.217])
 ([10.255.31.217])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2022 02:41:05 -0700
Message-ID: <48744abf-bd9b-927d-9ca3-a3e4bdc07fbb@linux.intel.com>
Date: Sat, 23 Apr 2022 17:41:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 02/13] iommu: Move bus setup to IOMMU device registration
Content-Language: en-US
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1649935679.git.robin.murphy@arm.com>
 <e607a32be8e84c56d65160902f4bd3fb434ee9d3.1649935679.git.robin.murphy@arm.com>
 <d838c7f8-2d31-2327-9b4d-c05b06a516bb@linux.intel.com>
 <1d9a2146-9e48-ba97-d049-5d2332ebbd3a@arm.com>
 <d928d256-b1bc-2d45-a9c3-382edfe67b80@linux.intel.com>
 <7f693a3a-bbab-237a-af9a-4395e501a5b2@arm.com>
 <36764562-ad54-b192-4084-842fee8fca78@linux.intel.com>
 <8cd04084-54d0-9e10-f16f-99541e42d7eb@arm.com>
 <f72349ab-19d9-ed9f-28a7-6654fd5556cd@linux.intel.com>
 <60d6a35e-5d12-b8c2-b0d2-7155965a10e5@linux.intel.com>
In-Reply-To: <60d6a35e-5d12-b8c2-b0d2-7155965a10e5@linux.intel.com>
Cc: jean-philippe@linaro.org, zhang.lyra@gmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, gerald.schaefer@linux.ibm.com,
 linux-arm-kernel@lists.infradead.org
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

T24gMjAyMi80LzIzIDE3OjAwLCBMdSBCYW9sdSB3cm90ZToKPiBPbiAyMDIyLzQvMjMgMTY6NTEs
IEx1IEJhb2x1IHdyb3RlOgo+PiBPbiAyMDIyLzQvMjMgMTY6MzcsIFJvYmluIE11cnBoeSB3cm90
ZToKPj4+IE9uIDIwMjItMDQtMjMgMDk6MDEsIEx1IEJhb2x1IHdyb3RlOgo+Pj4+IEhpIFJvYmlu
LAo+Pj4+Cj4+Pj4gT24gMjAyMi80LzE5IDE1OjIwLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+Pj4+
IE9uIDIwMjItMDQtMTkgMDA6MzcsIEx1IEJhb2x1IHdyb3RlOgo+Pj4+Pj4gT24gMjAyMi80LzE5
IDY6MDksIFJvYmluIE11cnBoeSB3cm90ZToKPj4+Pj4+PiBPbiAyMDIyLTA0LTE2IDAxOjA0LCBM
dSBCYW9sdSB3cm90ZToKPj4+Pj4+Pj4gT24gMjAyMi80LzE0IDIwOjQyLCBSb2JpbiBNdXJwaHkg
d3JvdGU6Cj4+Pj4+Pj4+PiBAQCAtMTg4MywyNyArMTkwMCwxMiBAQCBzdGF0aWMgaW50IGlvbW11
X2J1c19pbml0KHN0cnVjdCAKPj4+Pj4+Pj4+IGJ1c190eXBlICpidXMpCj4+Pj4+Pj4+PiDCoMKg
ICovCj4+Pj4+Pj4+PiDCoCBpbnQgYnVzX3NldF9pb21tdShzdHJ1Y3QgYnVzX3R5cGUgKmJ1cywg
Y29uc3Qgc3RydWN0IAo+Pj4+Pj4+Pj4gaW9tbXVfb3BzICpvcHMpCj4+Pj4+Pj4+PiDCoCB7Cj4+
Pj4+Pj4+PiAtwqDCoMKgIGludCBlcnI7Cj4+Pj4+Pj4+PiAtCj4+Pj4+Pj4+PiAtwqDCoMKgIGlm
IChvcHMgPT0gTlVMTCkgewo+Pj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGJ1cy0+aW9tbXVfb3Bz
ID0gTlVMTDsKPj4+Pj4+Pj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+Pj4+Pj4+IC3C
oMKgwqAgfQo+Pj4+Pj4+Pj4gLQo+Pj4+Pj4+Pj4gLcKgwqDCoCBpZiAoYnVzLT5pb21tdV9vcHMg
IT0gTlVMTCkKPj4+Pj4+Pj4+ICvCoMKgwqAgaWYgKGJ1cy0+aW9tbXVfb3BzICYmIG9wcyAmJiBi
dXMtPmlvbW11X29wcyAhPSBvcHMpCj4+Pj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJu
IC1FQlVTWTsKPj4+Pj4+Pj4+IMKgwqDCoMKgwqAgYnVzLT5pb21tdV9vcHMgPSBvcHM7Cj4+Pj4+
Pj4+Cj4+Pj4+Pj4+IERvIHdlIHN0aWxsIG5lZWQgdG8ga2VlcCBhYm92ZSBsaW5lcyBpbiBidXNf
c2V0X2lvbW11KCk/Cj4+Pj4+Pj4KPj4+Pj4+PiBJdCBwcmVzZXJ2ZXMgdGhlIGV4aXN0aW5nIGJl
aGF2aW91ciB1bnRpbCBlYWNoIGNhbGxzaXRlIGFuZCBpdHMgCj4+Pj4+Pj4gYXNzb2NpYXRlZCBl
cnJvciBoYW5kbGluZyBhcmUgcmVtb3ZlZCBsYXRlciBvbiwgd2hpY2ggc2VlbXMgbGlrZSAKPj4+
Pj4+PiBhcyBnb29kIGEgdGhpbmcgdG8gZG8gYXMgYW55LiBTaW5jZSBJJ20gYWxyZWFkeSByZWxh
eGluZyAKPj4+Pj4+PiBpb21tdV9kZXZpY2VfcmVnaXN0ZXIoKSB0byBhIHdhcm4tYnV0LWNvbnRp
bnVlIGJlaGF2aW91ciB3aGlsZSBpdCAKPj4+Pj4+PiBrZWVwcyB0aGUgYnVzIG9wcyBvbiBsaWZl
LXN1cHBvcnQgaW50ZXJuYWxseSwgSSBmaWd1cmVkIG5vdCAKPj4+Pj4+PiBjaGFuZ2luZyB0b28g
bXVjaCBhdCBvbmNlIHdvdWxkIG1ha2UgaXQgZWFzaWVyIHRvIGJpc2VjdCBhbnkgCj4+Pj4+Pj4g
cG90ZW50aWFsIGlzc3VlcyBhcmlzaW5nIGZyb20gdGhpcyBmaXJzdCBzdGVwLgo+Pj4+Pj4KPj4+
Pj4+IEZhaXIgZW5vdWdoLiBUaGFuayB5b3UgZm9yIHRoZSBleHBsYW5hdGlvbi4KPj4+Pj4+Cj4+
Pj4+PiBEbyB5b3UgaGF2ZSBhIHB1YmxpYyB0cmVlIHRoYXQgSSBjb3VsZCBwdWxsIHRoZXNlIHBh
dGNoZXMgYW5kIHRyeSAKPj4+Pj4+IHRoZW0KPj4+Pj4+IG9uIGFuIEludGVsIGhhcmR3YXJlPyBP
ciBwZXJoYXBzIHlvdSBoYXZlIGRvbmUgdGhpcz8gSSBsaWtlIHRoZSB3aG9sZQo+Pj4+Pj4gaWRl
YSBvZiB0aGlzIHNlcmllcywgYnV0IGl0J3MgYmV0dGVyIHRvIHRyeSBpdCB3aXRoIGEgcmVhbCBo
YXJkd2FyZS4KPj4+Pj4KPj4+Pj4gSSBoYXZlbid0IGJvdGhlcmVkIHdpdGggc2VwYXJhdGUgYnJh
bmNoZXMgc2luY2UgdGhlcmUncyBzbyBtYW55IAo+Pj4+PiBkaWZmZXJlbnQgcGllY2VzIGluLWZs
aWdodCwgYnV0IG15IGNvbXBsZXRlICh1bnN0YWJsZSkgZGV2ZWxvcG1lbnQgCj4+Pj4+IGJyYW5j
aCBjYW4gYmUgZm91bmQgaGVyZToKPj4+Pj4KPj4+Pj4gaHR0cHM6Ly9naXRsYWIuYXJtLmNvbS9s
aW51eC1hcm0vbGludXgtcm0vLS9jb21taXRzL2lvbW11L2J1cwo+Pj4+Pgo+Pj4+PiBGb3Igbm93
IEknZCByZWNvbW1lbmQgd2luZGluZyB0aGUgaGVhZCBiYWNrIHRvICJpb21tdTogQ2xlYW4gdXAg
Cj4+Pj4+IGJ1c19zZXRfaW9tbXUoKSIgZm9yIHRlc3RpbmcgLSBzb21lIG9mIHRoZSBwYXRjaGVz
IGFib3ZlIHRoYXQgaGF2ZSAKPj4+Pj4gYWxyZWFkeSBiZWVuIHBvc3RlZCBhbmQgcGlja2VkIHVw
IGJ5IHRoZWlyIHJlc3BlY3RpdmUgc3Vic3lzdGVtcywgCj4+Pj4+IGJ1dCBvdGhlcnMgYXJlIGlu
Y29tcGxldGUgYW5kIGJhcmVseSBjb21waWxlLXRlc3RlZC4gSSdsbCBwcm9iYWJseSAKPj4+Pj4g
cmVhcnJhbmdlIGl0IGxhdGVyIHRoaXMgd2VlayB0byBiZXR0ZXIgcmVmbGVjdCB3aGF0J3MgaGFw
cGVuZWQgc28gZmFyLgo+Pj4+Cj4+Pj4gSSB3b3VuZCB0aGUgaGVhZCBiYWNrIHRvICJpb21tdTog
Q2xlYW4gdXAgYnVzX3NldF9pb21tdSIgYW5kIHRlc3RlZCBpdAo+Pj4+IG9uIGFuIEludGVsIG1h
Y2hpbmUuIEl0IGdvdCBzdHVjayBkdXJpbmcgYm9vdC4gVGhpcyB0ZXN0IHdhcyBvbiBhIAo+Pj4+
IHJlbW90ZQo+Pj4+IG1hY2hpbmUgYW5kIEkgaGF2ZSBubyBtZWFucyB0byBhY2Nlc3MgaXQgcGh5
c2ljYWxseS4gU28gSSBjYW4ndCBnZXQgYW55Cj4+Pj4ga2VybmVsIGRlYnVnZ2luZyBtZXNzYWdl
cy4gKEkgaGF2ZSB0byB3b3JrIGZyb20gaG9tZSB0aGVzZSBkYXlzLiA6LSgpCj4+Pj4KPj4+PiBJ
IGd1ZXNzIGl0J3MgZHVlIHRvIHRoZSBmYWN0IHRoYXQgaW50ZWxfaW9tbXVfcHJvYmVfZGV2aWNl
KCkgY2FsbGJhY2sKPj4+PiBvbmx5IHdvcmtzIGZvciB0aGUgcGNpIGRldmljZXMuIFRoZSBpc3N1
ZSBvY2N1cnMgd2hlbiBwcm9iaW5nIGEgZGV2aWNlCj4+Pj4gb3RoZXIgdGhhbiBhIFBDSSBvbmUu
Cj4+Pgo+Pj4gWWVhaCwgSSB3YXMgd29uZGVyaW5nIGlmIHRoYXQgd291bGQgYmUgc2lnbmlmaWNh
bnQsIHNpbmNlIGl0J3MgdGhlIAo+Pj4gb25seSBkcml2ZXIgdGhhdCBuZXZlciByZWdpc3RlcmVk
IGl0c2VsZiBmb3IgcGxhdGZvcm1fYnVzX3R5cGUgc28gCj4+PiB3b24ndCBoYXZlIGFjdHVhbGx5
IHNlZW4gdGhvc2UgY2FsbHMgYmVmb3JlLiBJJ20gaW5jbGluZWQgdG8gYm9kZ2UgCj4+PiB0aGF0
IGFzIGJlbG93IGZvciBub3csIGFzIGxvbmcgYXMgaXQgdGhlbiB3b3JrcyBPSyBpbiB0ZXJtcyBv
ZiB0aGUgCj4+PiByZXN0IG9mIHRoZSBjaGFuZ2VzLgo+Pj4KPj4+IFRoYW5rcywKPj4+IFJvYmlu
Lgo+Pj4KPj4+IC0tLS0tPjgtLS0tLQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50
ZWwvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+Pj4gaW5kZXggOWZhMWI5
ODE4NmEzLi42ZTM1OWY5MmVjMDAgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVs
L2lvbW11LmMKPj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+Pj4gQEAgLTQ1
NjUsNiArNDU2NSwxMCBAQCBzdGF0aWMgc3RydWN0IGlvbW11X2RldmljZSAKPj4+ICppbnRlbF9p
b21tdV9wcm9iZV9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KQo+Pj4gwqDCoMKgwqDCoCB1bnNp
Z25lZCBsb25nIGZsYWdzOwo+Pj4gwqDCoMKgwqDCoCB1OCBidXMsIGRldmZuOwo+Pj4KPj4+ICvC
oMKgwqAgLyogQU5ERCBwbGF0Zm9ybSBkZXZpY2Ugc3VwcG9ydCBuZWVkcyBmaXhpbmcgKi8KPj4+
ICvCoMKgwqAgaWYgKCFwZGV2KQo+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBFUlJfUFRSKC1F
Tk9ERVYpOwo+Pj4gKwo+Pj4gwqDCoMKgwqDCoCBpb21tdSA9IGRldmljZV90b19pb21tdShkZXYs
ICZidXMsICZkZXZmbik7Cj4+PiDCoMKgwqDCoMKgIGlmICghaW9tbXUpCj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIEVSUl9QVFIoLUVOT0RFVik7Cj4+Cj4+IEkgaGF2ZW4ndCBzZWVuIGFu
eSByZWFsIEFOREQgcGxhdGZvcm0gZGV2aWNlcywgaGVuY2UgdGhpcyB3b3JrcyBmb3IgbWUuCj4g
Cj4gT3IgbW9yZSBwcmVjaXNlbHksIHJldHVybiBOVUxMIHdoZW4gQGRldiBnb2VzIHRocm91Z2gg
ZGV2aWNlX3RvX2lvbW11KCk/Cj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwv
aW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+IGluZGV4IGRmNWM2MmVjZjk0
Mi4uMGQ0NDc3MzllMDc2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUu
Ywo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+IEBAIC03OTcsOCArNzk3LDEx
IEBAIHN0cnVjdCBpbnRlbF9pb21tdSAqZGV2aWNlX3RvX2lvbW11KHN0cnVjdCBkZXZpY2UgCj4g
KmRldiwgdTggKmJ1cywgdTggKmRldmZuKQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcGZfcGRldiA9IHBjaV9waHlzZm4ocGRldik7Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBkZXYgPSAmcGZfcGRldi0+ZGV2Owo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc2VnbWVudCA9IHBjaV9kb21haW5fbnIocGRldi0+YnVzKTsKPiAtwqDCoMKgwqDCoMKg
IH0gZWxzZSBpZiAoaGFzX2FjcGlfY29tcGFuaW9uKGRldikpCj4gK8KgwqDCoMKgwqDCoCB9IGVs
c2UgaWYgKGhhc19hY3BpX2NvbXBhbmlvbihkZXYpKSB7Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBkZXYgPSAmQUNQSV9DT01QQU5JT04oZGV2KS0+ZGV2Owo+ICvCoMKgwqDCoMKg
wqAgfSBlbHNlIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gTlVMTDsK
PiArwqDCoMKgwqDCoMKgIH0KPiAKPiAgwqDCoMKgwqDCoMKgwqAgcmN1X3JlYWRfbG9jaygpOwo+
ICDCoMKgwqDCoMKgwqDCoCBmb3JfZWFjaF9pb21tdShpb21tdSwgZHJoZCkgewoKUm9iaW4sIHBs
ZWFzZSBpZ25vcmUgdGhpcy4gImhhc19hY3BpX2NvbXBhbmlvbihkZXYpIiBpc24ndCBlcXVhbCB0
byBhbgpBTkREIGRldmljZS4gUGxlYXNlIHVzZSB5b3Vycy4gU29ycnkgZm9yIHRoZSBub2lzZS4K
CkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
