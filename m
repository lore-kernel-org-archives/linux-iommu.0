Return-Path: <SRS0=4E9V=2A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B049DC43603
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 01:30:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 781B52073D
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 01:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 781B52073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 45F3C87C89;
	Tue, 10 Dec 2019 01:30:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wu+3Zc-PYM2z; Tue, 10 Dec 2019 01:30:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 48A0887E17;
	Tue, 10 Dec 2019 01:30:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 336C4C1D7D;
	Tue, 10 Dec 2019 01:30:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 300D5C0881
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 01:30:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C87E72041C
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 01:30:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I01gYBl4EC0F for <iommu@lists.linux-foundation.org>;
 Tue, 10 Dec 2019 01:30:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 4F87B20384
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 01:30:26 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 17:30:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,297,1571727600"; d="scan'208";a="224982730"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
 ([10.239.159.136])
 by orsmga002.jf.intel.com with ESMTP; 09 Dec 2019 17:30:24 -0800
Subject: Re: dmar pte read access not set error messages on hp dl388 gen8
 systems
To: Jerry Snitselaar <jsnitsel@redhat.com>
References: <2d4e0c05-f0ee-d4b1-d2ed-24197811b097@linux.intel.com>
 <20191205022551.janpwjvr4kei5r7c@cantor>
 <d5981dee-d37b-a725-ed94-8864f3dd7602@linux.intel.com>
 <20191205025320.oiulo3msfcggdlv5@cantor>
 <d5fbedce-7a06-79b4-75fa-0aa3cc3ef73b@linux.intel.com>
 <20191206072453.5jjwrjedqbjimx45@cantor>
 <0f82007e-9887-d6b2-08e5-9c430c920b36@linux.intel.com>
 <20191207022914.7uccwkmgadz4hvbf@cantor>
 <20191207024118.uwwzthqifh2dca5q@cantor>
 <7979b838-e2c5-4064-490c-8e0884909715@linux.intel.com>
 <20191210005234.kanygdcjgsgo7z6j@cantor>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <77d3ca8e-cb8c-4392-fa99-c55daa263b8e@linux.intel.com>
Date: Tue, 10 Dec 2019 09:29:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191210005234.kanygdcjgsgo7z6j@cantor>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org
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

SGksCgpPbiAxMi8xMC8xOSA4OjUyIEFNLCBKZXJyeSBTbml0c2VsYWFyIHdyb3RlOgo+IE9uIFN1
biBEZWMgMDggMTksIEx1IEJhb2x1IHdyb3RlOgo+PiBIaSwKPj4KPj4gT24gMTIvNy8xOSAxMDo0
MSBBTSwgSmVycnkgU25pdHNlbGFhciB3cm90ZToKPj4+IE9uIEZyaSBEZWMgMDYgMTksIEplcnJ5
IFNuaXRzZWxhYXIgd3JvdGU6Cj4+Pj4gT24gU2F0IERlYyAwNyAxOSwgTHUgQmFvbHUgd3JvdGU6
Cj4+Pj4+IEhpIEplcnJ5LAo+Pj4+Pgo+Pj4+PiBPbiAxMi82LzE5IDM6MjQgUE0sIEplcnJ5IFNu
aXRzZWxhYXIgd3JvdGU6Cj4+Pj4+PiBPbiBGcmkgRGVjIDA2IDE5LCBMdSBCYW9sdSB3cm90ZToK
Pj4+Pj4+IFtzbmlwXQo+Pj4+Pj4+Cj4+Pj4+Pj4gQ2FuIHlvdSBwbGVhc2UgdHJ5IGJlbG93IGNo
YW5nZT8gTGV0J3MgY2hlY2sgd2hldGhlciB0aGUgYWZlbmRpbmcKPj4+Pj4+PiBhZGRyZXNzIGhh
cyBiZWVuIG1hcHBlZCBmb3IgZGV2aWNlIDAxLjAwLjIuCj4+Pj4+Pj4KPj4+Pj4+PiAkIGdpdCBk
aWZmCj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYyBiL2RyaXZlcnMv
aW9tbXUvaW9tbXUuYwo+Pj4+Pj4+IGluZGV4IGRiN2JmZDRmMmQyMC4uZDlkYWY2NmJlODQ5IDEw
MDY0NAo+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW9tbXUuYwo+Pj4+Pj4+ICsrKyBiL2Ry
aXZlcnMvaW9tbXUvaW9tbXUuYwo+Pj4+Pj4+IEBAIC02NjMsNiArNjYzLDggQEAgc3RhdGljIGlu
dCAKPj4+Pj4+PiBpb21tdV9ncm91cF9jcmVhdGVfZGlyZWN0X21hcHBpbmdzKHN0cnVjdCBpb21t
dV9ncm91cCAqZ3JvdXAsCj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0ID0gaW9tbXVfbWFwKGRvbWFpbiwgYWRkciwgYWRkciwgCj4+Pj4+Pj4g
cGdfc2l6ZSwgZW50cnktPnByb3QpOwo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZXQpCj4+Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Owo+Pj4+Pj4+
ICsKPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZGV2X2luZm8oZGV2LCAiU2V0dGluZyBpZGVudGl0eSBtYXAgCj4+Pj4+Pj4gWzB4JUx4IC0gMHgl
THhdIGZvciBncm91cCAlZFxuIiwgYWRkciwgYWRkciArIHBnX3NpemUsIGdyb3VwLT5pZCk7Cj4+
Pj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+Pj4+Pj4KPj4+Pj4+PiDCoMKg
wqDCoMKgwqAgfQo+Pj4+Pj4+Cj4+Pj4+Pj4gSSBhbSBkb3VidGluZyB0aGF0IGRldmljZSAwMS4w
MC4yIGlzIG5vdCBpbiB0aGUgZGV2aWNlIHNjb3BlIG9mCj4+Pj4+Pj4KPj4+Pj4+PiBbwqDCoMKg
IDQuNDg1MTA4XSBETUFSOiBSTVJSIGJhc2U6IDB4MDAwMDAwYmRmNmYwMDAgZW5kOiAKPj4+Pj4+
PiAweDAwMDAwMGJkZjdlZmZmCj4+Pj4+Pj4KPj4+Pj4+PiBCeSB0aGUgd2F5LCBkb2VzIGRldmlj
ZSAwMS4wMC4yIHdvcmtzIHdlbGwgYWZ0ZXIgYmluZGluZyB0aGUgZHJpdmVyPwo+Pj4+Pj4+Cj4+
Pj4+Pgo+Pj4+Pj4gV2hlbiBJIGJvb3QgaXQgd2l0aCBwYXNzdGhyb3VnaCBpdCBkb2Vzbid0IGdl
dCB0byBhIHBvaW50IHdoZXJlIEkgY2FuCj4+Pj4+PiBsb2dpbi4gSSB0aGluayB0aGUgc2VyaWFs
IGNvbnNvbGUgb24gdGhlc2Ugc3lzdGVtcyBpcyB0aWVkIHRvIHRoZSAKPj4+Pj4+IGlsbywKPj4+
Pj4+IHNvIHRoZSBjb25zZXJ2ZXIgY29ubmVjdGlvbiBjb3VsZCBiZSBtYWtpbmcgdGhpbmdzCj4+
Pj4+PiB3b3JzZS4gVW5mb3J0dW5hdGVseSB0aGUgc3lzdGVtIGlzIHJlbW90ZS4gSSBzaG91bGQg
aGF2ZSBtb3JlIHRpbWUgCj4+Pj4+PiBub3cKPj4+Pj4+IHRvIGZvY3VzIG9uIGRlYnVnZ2luZyB0
aGlzLgo+Pj4+Pj4KPj4+Pj4+IEF0dGFjaGluZyBjb25zb2xlIG91dHB1dCBmb3IgdGhlIGFib3Zl
IHBhdGNoLgo+Pj4+Pgo+Pj4+PiBJdCBzZWVtcyB0aGF0IGRldmljZSAwMS4wMC4yIGlzbid0IGlu
IHRoZSBzY29wZSBvZiBSTVJSIFtiYXNlOgo+Pj4+PiAweDAwMDAwMGJkZjZmMDAwIGVuZDogMHgw
MDAwMDBiZGY3ZWZmZl0uIEJ1dCBpdCBzdGlsbCB0cmllcyB0byBhY2Nlc3MKPj4+Pj4gdGhlIGFk
ZHJlc3Mgd2l0aGluIGl0LCBoZW5jZSBmYXVsdHMgZ2VuZXJhdGVkLgo+Pj4+Pgo+Pj4+PiBZb3Ug
Y2FuIGNoZWNrIGl0IHdpdGggQUNQSS9ETUFSIHRhYmxlLgo+Pj4+Pgo+Pj4+PiBCZXN0IHJlZ2Fy
ZHMsCj4+Pj4+IGJhb2x1Cj4+Pj4+Cj4+Pj4KPj4+PiBJIGJlbGlldmUgaXQgaXMgdGhlIDNyZCBl
bmRwb2ludCBkZXZpY2UgZW50cnkgaW4gZG1hciBkYXRhIGJlbG93Lgo+Pj4+IFNvIHF1ZXN0aW9u
IGFib3V0IHJlcXVlc3RfZGVmYXVsdF9kb21haW5fZm9yX2Rldi4gU2luY2UgYSBkbWEgbWFwcGlu
Zwo+Pj4+IGlzIGFscmVhZHkgZG9uZSBmb3IgMS4wMC4wLCBhbmQgdGhhdCBzZXRzIHRoZSBkZWZh
dWx0X2RvbWFpbiBmb3IgdGhlCj4+Pj4gZ3JvdXAgKEkgdGhpbmspLCB3b24ndCBpdCBiYWlsIG91
dCBmb3IgMS4wMC4yIGF0IHRoaXMgY2hlY2s/Cj4+Pj4KPj4+PiDCoMKgwqDCoGlmIChncm91cC0+
ZGVmYXVsdF9kb21haW4gJiYgZ3JvdXAtPmRlZmF1bHRfZG9tYWluLT50eXBlID09IHR5cGUpCj4+
Pj4gwqDCoMKgwqDCoMKgwqAgZ290byBvdXQ7Cj4+Pj4KPj4+Cj4+PiBPciBJIGd1ZXNzIHJlcXVl
c3RfZGVmYXVsdF9kb21haW5fZm9yX2RldiB3b3VsZG4ndCBldmVuIGJlIGNhbGxlZCBmb3IgCj4+
PiAxLjAwLjIuCj4+PiBpbnRlbF9pb21tdV9hZGRfZGV2aWNlIGl0IHdvdWxkbid0IGV2ZW4gY2Fs
bCBvbmUgb2YgdGhlIHJlcXVlc3QKPj4+IGZ1bmN0aW9ucyB3aXRoIDEuMDAuMiBzaW5jZSBkb21h
aW4tPnR5cGUgd291bGQgYmUgZG1hIGZyb20gMS4wMC4wLCAKPj4+IGFuZCBkZXZpY2VfZGVmX2Rv
bWFpbl90eXBlCj4+PiBzaG91bGQgcmV0dXJuIGRtYS4KPj4KPj4gQ2FuIHlvdSBwbGVhc2UgYWRk
IHNvbWUgZGVidWcgbWVzc2FnZXMgYW5kIGNoZWNrIHdoYXQgcmVhbGx5IGhhcHBlbnMKPj4gaGVy
ZT8KPj4KPj4gQmVzdCByZWdhcmRzLAo+PiBiYW9sdQo+Pgo+IAo+IFvCoMKgIDI1LjAwMDU0NF0g
cGNpIDAwMDA6MDE6MDAuMDogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDI1Cj4gW8KgwqAgMjUuNTAy
MjQzXSBwY2kgMDAwMDowMTowMC4wOiBETUFSOiBkb21haW4tPnR5cGUgaXMgaWRlbnRpdHnCoCA8
PCAKPiBpbnRlbF9pb21tdV9hZGRfZGV2aWNlIChhbGxvY2VkIGluIGlvbW11X2dyb3VwX2dldF9m
b3JfZGV2KQo+IFvCoMKgIDI1LjUwNDIzOV0gcGNpIDAwMDA6MDE6MDAuMDogRE1BUjogZGV2aWNl
IGRlZmF1bHQgZG9tYWluIHR5cGUgaXMgCj4gZG1hLiByZXF1ZXN0aW5nIGRtYSBkb21haW7CoCA8
PCBpbnRlbF9pb21tdV9hZGRfZGV2aWNlCj4gW8KgwqAgMjUuNTA3OTU0XSBwY2kgMDAwMDowMTow
MC4wOiBVc2luZyBpb21tdSBkbWEgbWFwcGluZ8KgwqDCoCA8PCAKPiByZXF1ZXN0X2RlZmF1bHRf
ZG9tYWluX2Zvcl9kZXbCoCAobm93IGRlZmF1bHQgZG9tYWluIGZvciBncm91cCBpcyBkbWEpCj4g
W8KgwqAgMjUuNTA5NzY1XSBwY2kgMDAwMDowMTowMC4xOiBBZGRpbmcgdG8gaW9tbXUgZ3JvdXAg
MjUKPiBbwqDCoCAyNS41MTE1MTRdIHBjaSAwMDAwOjAxOjAwLjE6IERNQVI6IGRvbWFpbi0+dHlw
ZSBpcyBkbWHCoCA8PCAKPiBpbnRlbF9pb21tdV9hZGRfZGV2aWNlCj4gW8KgwqAgMjUuNTEzMjYz
XSBwY2kgMDAwMDowMTowMC4xOiBETUFSOiBkZXZpY2UgZGVmYXVsdCBkb21haW4gdHlwZSBpcyAK
PiBpZGVudGl0eS4gcmVxdWVzdGluZyBpZGVudGl0eSBkb21haW7CoCA8PCBpbnRlbF9pb21tdV9h
ZGRfZGV2aWNlCj4gW8KgwqAgMjUuNTE2NDM1XSBwY2kgMDAwMDowMTowMC4xOiBkb24ndCBjaGFu
Z2UgbWFwcGluZ3Mgb2YgZXhpc3RpbmcgCj4gZGV2aWNlcy7CoMKgwqAgPDwgcmVxdWVzdF9kZWZh
dWx0X2RvbWFpbl9mb3JfZGV2Cj4gW8KgwqAgMjUuNTE4NjY5XSBwY2kgMDAwMDowMTowMC4xOiBE
TUFSOiBEZXZpY2UgdXNlcyBhIHByaXZhdGUgaWRlbnRpdHkgCj4gZG9tYWluLsKgIDw8IGludGVs
X2lvbW11X2FkZF9kZXZpY2UKPiBbwqDCoCAyNS41MjEwNjFdIHBjaSAwMDAwOjAxOjAwLjI6IEFk
ZGluZyB0byBpb21tdSBncm91cCAyNQo+IFvCoMKgIDI1LjUyMjc5MV0gcGNpIDAwMDA6MDE6MDAu
MjogRE1BUjogZG9tYWluLT50eXBlIGlzIGRtYcKgIDw8IAo+IGludGVsX2lvbW11X2FkZF9kZXZp
Y2UKPiBbwqDCoCAyNS41MjQ3MDZdIHBjaSAwMDAwOjAxOjAwLjQ6IEFkZGluZyB0byBpb21tdSBn
cm91cCAyNQo+IFvCoMKgIDI1LjUyNjQ1OF0gcGNpIDAwMDA6MDE6MDAuNDogRE1BUjogZG9tYWlu
LT50eXBlIGlzIGRtYcKgIDw8IAo+IGludGVsX2lvbW11X2FkZF9kZXZpY2UKPiBbwqDCoCAyNS41
MjgyMTNdIHBjaSAwMDAwOjAxOjAwLjQ6IERNQVI6IGRldmljZSBkZWZhdWx0IGRvbWFpbiB0eXBl
IGlzIAo+IGlkZW50aXR5LiByZXF1ZXN0aW5nIGlkZW50aXR5IGRvbWFpbsKgIDw8IGludGVsX2lv
bW11X2FkZF9kZXZpY2UKPiBbwqDCoCAyNS41MzEyODRdIHBjaSAwMDAwOjAxOjAwLjQ6IGRvbid0
IGNoYW5nZSBtYXBwaW5ncyBvZiBleGlzdGluZyAKPiBkZXZpY2VzLsKgwqDCoCA8PCByZXF1ZXN0
X2RlZmF1bHRfZG9tYWluX2Zvcl9kZXYKPiBbwqDCoCAyNS41MzM1MDBdIHBjaSAwMDAwOjAxOjAw
LjQ6IERNQVI6IERldmljZSB1c2VzIGEgcHJpdmF0ZSBpZGVudGl0eSAKPiBkb21haW4uwqAgPDwg
aW50ZWxfaW9tbXVfYWRkX2RldmljZQo+IAo+IFNvIHRoZSBkb21haW4gdHlwZSBpcyBkbWEgYWZ0
ZXIgMDE6MDAuMCBnZXRzIGFkZGVkLCBhbmQgd2hlbgo+IGludGVsX2lvbW11X2FkZF9kZXZpY2Ug
aXMgY2FsbGVkIGZvciAwMTowMC4yIGl0IHdpbGwgZ28gaW50byB0aGUgaWYKPiBzZWN0aW9uLiBT
aW5jZSB0aGUgZGV2aWNlIGRlZmF1bHQgZG9tYWluIHR5cGUgZm9yIDAxOjAwLjIgaXMgZG1hCj4g
bm90aGluZyBoYXBwZW5zIGluIHRoZXJlLCBhbmQgaXQgZ29lcyBvbiB0byAwMTowMC40LiBJcyB0
aGUgInByaXZhdGUKPiBpZGVudGl0eSBkb21haW4iIG1lc3NhZ2UgcmVhbGx5IGFjY3VyYXRlIHNp
bmNlIGV2ZXJ5b25lIHdpbGwgdXNlCj4gc2lfZG9tYWluPyBBZGRpbmcgc29tZSBtb3JlIGRlYnVn
Z2luZy4KClRoZSBmYWN0cyB0aGF0IHdlIGhhdmUgc2VlbjoKCjEpIDAxLjAwLjIgdXNlcyB0aGUg
ZGVmYXVsdCBkb21haW4gaW4gZ3JvdXAgMjUuIFRoZSBkb21haW4gdHlwZSBvZiB0aGlzCiAgICBk
ZWZhdWx0IGRvbWFpbiBpcyBETUEuCgoyKSBpb21tdV9ncm91cF9jcmVhdGVfZGlyZWN0X21hcHBp
bmdzKCkgKnNob3VsZCogYmUgY2FsbGVkIHdoZW4gYWRkaW5nCiAgICAwMS4wMC4yIGludG8gZ3Jv
dXAgMjUuIEFzIHRoZSByZXN1bHQsIFJNUlIgZm9yIHRoaXMgZGV2aWNlICpzaG91bGQqCiAgICBi
ZSBpZGVudGl0eSBtYXBwZWQuCgozKSBCeSBjaGVja2luZyBETUFSIHRhYmxlLCBSTVJSICgweDAw
MDAwMGJkZjZmMDAwIH4gMHgwMDAwMDBiZGY3ZWZmZikgaXMKICAgIHJlcG9ydGVkIGZvciBkZXZp
Y2UgMDEuMDAuMi4KClRoZSBwcm9ibGVtIGlzIHRoYXQgUk1SUiAoMHgwMDAwMDBiZGY2ZjAwMCB+
IDB4MDAwMDAwYmRmN2VmZmYpIGhhc24ndAphY3R1YWxseSBiZWVuIG1hcHBlZCwgYXMgdGhlIHJl
c3VsdCBJT01NVSBmYXVsdHMgZ2VuZXJhdGVkIHdoZW4gZGV2aWNlCnRyeSB0byBhY2Nlc3MgdGhp
cyByYW5nZS4KClNvIEkgZ3Vlc3MgeW91IGNvdWxkIGFkZCBtb3JlIGRlYnVnIG1lc3NhZ2UgdG8g
Y2hlY2sgd2h5CmlvbW11X2dyb3VwX2NyZWF0ZV9kaXJlY3RfbWFwcGluZ3MoKSBkb2Vzbid0IGRv
IHRoZSByaWdodCB0aGluZz8KCkJlc3QgcmVnYXJkcywKYmFvbHUKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
