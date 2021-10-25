Return-Path: <SRS0=+9ml=PN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A40C433EF
	for <iommu@archiver.kernel.org>; Mon, 25 Oct 2021 16:02:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E7B60C4B
	for <iommu@archiver.kernel.org>; Mon, 25 Oct 2021 16:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8E7B60C4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8738D80E25;
	Mon, 25 Oct 2021 16:02:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gzx9iecLBtRg; Mon, 25 Oct 2021 16:02:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 466CC80E16;
	Mon, 25 Oct 2021 16:02:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F391C0012;
	Mon, 25 Oct 2021 16:02:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 490FEC000E
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 16:02:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3400D4039B
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 16:02:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EtxpWPKoor2a for <iommu@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 16:01:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D954400B9
 for <iommu@lists.linux-foundation.org>; Mon, 25 Oct 2021 16:01:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A30891FB;
 Mon, 25 Oct 2021 09:01:58 -0700 (PDT)
Received: from [10.57.27.231] (unknown [10.57.27.231])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F7E53F5A1;
 Mon, 25 Oct 2021 09:01:56 -0700 (PDT)
Subject: Re: I got an IOMMU IO page fault. What to do now?
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <7a5123b0-6370-59dc-f0c2-8be5b370d9ba@molgen.mpg.de>
 <0cfccc44-6cc6-98f5-ecd6-2f376839ec18@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <bc7142a1-82d3-43bf-dee2-25f9297e7182@arm.com>
Date: Mon, 25 Oct 2021 17:01:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0cfccc44-6cc6-98f5-ecd6-2f376839ec18@gmail.com>
Content-Language: en-GB
Cc: x86@kernel.org, Xinhui Pan <Xinhui.Pan@amd.com>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Alex Deucher <alexander.deucher@amd.com>,
 it+linux-iommu@molgen.mpg.de, Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
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

T24gMjAyMS0xMC0yNSAxMjoyMywgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBIaSBQYXVsLAo+
IAo+IG5vdCBzdXJlIGhvdyB0aGUgSU9NTVUgZ2l2ZXMgb3V0IGFkZHJlc3NlcywgYnV0IHRoZSBw
cmludGVkIG9uZXMgbG9vayAKPiBzdXNwaWNpb3VzIHRvIG1lLiBTb21ldGhpbmcgbGlrZSB3ZSBh
cmUgdXNpbmcgYW4gaW52YWxpZCBhZGRyZXNzIGxpa2UgLTEgCj4gb3Igc2ltaWxhci4KCkZXSVcg
dGhvc2UgbG9vayBsaWtlIGJlbGlldmFibGUgRE1BIGFkZHJlc3NlcyB0byBtZSwgYXNzdW1pbmcg
dGhhdCB0aGUgCkRNQSBtYXBwaW5nIEFQSXMgYXJlIGJlaW5nIGJhY2tlZCBpb21tdV9kbWFfb3Bz
IGFuZCB0aGUgZGV2aWNlIGhhcyBhIAo0MC1iaXQgRE1BIG1hc2ssIHNpbmNlIHRoZSBJT1ZBIGFs
bG9jYXRvciB3b3JrcyB0b3AtZG93bi4KCkxpa2VseSBjYXVzZXMgYXJlIGVpdGhlciBhIHJhY2Ug
d2hlcmUgdGhlIGRtYV91bm1hcF8qKCkgY2FsbCBoYXBwZW5zIApiZWZvcmUgdGhlIGhhcmR3YXJl
IGhhcyByZWFsbHkgc3RvcHBlZCBhY2Nlc3NpbmcgdGhlIHJlbGV2YW50IGFkZHJlc3NlcywgCm9y
IHRoZSBkZXZpY2UncyBETUEgbWFzayBoYXMgYmVlbiBzZXQgbGFyZ2VyIHRoYW4gaXQgc2hvdWxk
IGJlLCBhbmQgdGh1cyAKdGhlIHVwcGVyIGJpdHMgaGF2ZSBiZWVuIHRydW5jYXRlZCBpbiB0aGUg
cm91bmQtdHJpcCB0aHJvdWdoIHRoZSBoYXJkd2FyZS4KCkdpdmVuIHRoZSBhZGRyZXNzZXMgaW52
b2x2ZWQsIG15IHN1c3BpY2lvbnMgd291bGQgaW5pdGlhbGx5IGxlYW4gdG93YXJkcyAKdGhlIGxh
dHRlciBjYXNlIC0gdGhlIGZhdWx0cyBhcmUgaW4gdGhlIHZlcnkgdG9wbW9zdCBwYWdlcyB3aGlj
aCBpbXBseSAKdGhleSdyZSB0aGUgZmlyc3QgdGhpbmdzIG1hcHBlZCBpbiB0aGF0IHJhbmdlLiBU
aGUgb3RoZXIgY29udHJpYnV0aW5nIApmYWN0b3IgYmVpbmcgdGhlIHRyaWNrIHRoYXQgdGhlIElP
VkEgYWxsb2NhdG9yIHBsYXlzIGZvciBQQ0kgZGV2aWNlcywgCndoZXJlIGl0IHRyaWVzIHRvIHBy
ZWZlciAzMi1iaXQgYWRkcmVzc2VzLiBUaHVzIHlvdSdyZSBvbmx5IGxpa2VseSB0byAKc2VlIHRo
aXMgaGFwcGVuIG9uY2UgeW91IGFscmVhZHkgaGF2ZSB+My41LTRHQiBvZiBsaXZlIERNQS1tYXBw
ZWQgbWVtb3J5IAp0byBleGhhdXN0IHRoZSAzMi1iaXQgSU9WQSBzcGFjZSAobWludXMgc29tZSBy
ZXNlcnZlZCBhcmVhcykgYW5kIHN0YXJ0IAphbGxvY2F0aW5nIGZyb20gdGhlIGZ1bGwgRE1BIG1h
c2suIFlvdSBzaG91bGQgYmUgYWJsZSB0byBjaGVjayB0aGF0IHdpdGggCmEgNS4xMyBvciBuZXdl
ciBrZXJuZWwgYnkgYm9vdGluZyB3aXRoICJpb21tdS5mb3JjZWRhYz0xIiBhbmQgc2VlaW5nIGlm
IAppdCBicmVha3MgaW1tZWRpYXRlbHkgKHVuZm9ydHVuYXRlbHkgd2l0aCBhbiBvbGRlciBrZXJu
ZWwgeW91J2QgaGF2ZSB0byAKbWFudWFsbHkgaGFjayBpb21tdV9kbWFfYWxsb2NfaW92YSgpIHRv
IHRoZSBzYW1lIGVmZmVjdCkuCgpSb2Jpbi4KCj4gQ2FuIHlvdSB0cnkgdGhhdCBvbiBhbiB1cCB0
byBkYXRlIGtlcm5lbCBhcyB3ZWxsPyBFLmcuIGlkZWFsbHkgYmxlZWRpbmcgCj4gZWRnZSBhbWQt
c3RhZ2luZy1kcm0tbmV4dCBmcm9tIEFsZXggcmVwb3NpdG9yeS4KPiAKPiBSZWdhcmRzLAo+IENo
cmlzdGlhbi4KPiAKPiBBbSAyNS4xMC4yMSB1bSAxMjoyNSBzY2hyaWViIFBhdWwgTWVuemVsOgo+
PiBEZWFyIExpbnV4IGZvbGtzLAo+Pgo+Pgo+PiBPbiBhIERlbGwgT3B0aVBsZXggNTA1NSwgTGlu
dXggNS4xMC4yNCBsb2dnZWQgdGhlIElPTU1VIG1lc3NhZ2VzIAo+PiBiZWxvdy4gKEdQVSBoYW5n
IGluIGFtZGdwdSBpc3N1ZSAjMTc2MiBbMV0gbWlnaHQgYmUgcmVsYXRlZC4pCj4+Cj4+IMKgwqDC
oCAkIGxzcGNpIC1ubiAtcyAwNTowMC4wCj4+IMKgwqDCoCAwNTowMC4wIFZHQSBjb21wYXRpYmxl
IGNvbnRyb2xsZXIgWzAzMDBdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCAKPj4gSW5jLiBbQU1E
L0FUSV0gT2xhbmQgW1JhZGVvbiBIRCA4NTcwIC8gUjcgMjQwLzM0MCBPRU1dIFsxMDAyOjY2MTFd
IAo+PiAocmV2IDg3KQo+PiDCoMKgwqAgJCBkbWVzZwo+PiDCoMKgwqAgW+KApl0KPj4gwqDCoMKg
IFs2MzE4Mzk5Ljc0NTI0Ml0gYW1kZ3B1IDAwMDA6MDU6MDAuMDogQU1ELVZpOiBFdmVudCBsb2dn
ZWQgCj4+IFtJT19QQUdFX0ZBVUxUIGRvbWFpbj0weDAwMGMgYWRkcmVzcz0weGZmZmZmZmYwYzAg
ZmxhZ3M9MHgwMDIwXQo+PiDCoMKgwqAgWzYzMTgzOTkuNzU3MjgzXSBhbWRncHUgMDAwMDowNTow
MC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCAKPj4gW0lPX1BBR0VfRkFVTFQgZG9tYWluPTB4MDAw
YyBhZGRyZXNzPTB4ZmZmZmZmZjdjMCBmbGFncz0weDAwMjBdCj4+IMKgwqDCoCBbNjMxODM5OS43
NjkxNTRdIGFtZGdwdSAwMDAwOjA1OjAwLjA6IEFNRC1WaTogRXZlbnQgbG9nZ2VkIAo+PiBbSU9f
UEFHRV9GQVVMVCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmZmZlMGMwIGZsYWdzPTB4MDAy
MF0KPj4gwqDCoMKgIFs2MzE4Mzk5Ljc4MDkxM10gYW1kZ3B1IDAwMDA6MDU6MDAuMDogQU1ELVZp
OiBFdmVudCBsb2dnZWQgCj4+IFtJT19QQUdFX0ZBVUxUIGRvbWFpbj0weDAwMGMgYWRkcmVzcz0w
eGZmZmZmZmZlYzAgZmxhZ3M9MHgwMDIwXQo+PiDCoMKgwqAgWzYzMTgzOTkuNzkyNzM0XSBhbWRn
cHUgMDAwMDowNTowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCAKPj4gW0lPX1BBR0VfRkFVTFQg
ZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZmZmZmZTVjMCBmbGFncz0weDAwMjBdCj4+IMKgwqDC
oCBbNjMxODM5OS44MDQzMDldIGFtZGdwdSAwMDAwOjA1OjAwLjA6IEFNRC1WaTogRXZlbnQgbG9n
Z2VkIAo+PiBbSU9fUEFHRV9GQVVMVCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmZmZkMGMw
IGZsYWdzPTB4MDAyMF0KPj4gwqDCoMKgIFs2MzE4Mzk5LjgxNjA5MV0gYW1kZ3B1IDAwMDA6MDU6
MDAuMDogQU1ELVZpOiBFdmVudCBsb2dnZWQgCj4+IFtJT19QQUdFX0ZBVUxUIGRvbWFpbj0weDAw
MGMgYWRkcmVzcz0weGZmZmZmZmVjYzAgZmxhZ3M9MHgwMDIwXQo+PiDCoMKgwqAgWzYzMTgzOTku
ODI3NDA3XSBhbWRncHUgMDAwMDowNTowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCAKPj4gW0lP
X1BBR0VfRkFVTFQgZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZmZmZmZDNjMCBmbGFncz0weDAw
MjBdCj4+IMKgwqDCoCBbNjMxODM5OS44Mzg3MDhdIGFtZGdwdSAwMDAwOjA1OjAwLjA6IEFNRC1W
aTogRXZlbnQgbG9nZ2VkIAo+PiBbSU9fUEFHRV9GQVVMVCBkb21haW49MHgwMDBjIGFkZHJlc3M9
MHhmZmZmZmZjMGMwIGZsYWdzPTB4MDAyMF0KPj4gwqDCoMKgIFs2MzE4Mzk5Ljg1MDAyOV0gYW1k
Z3B1IDAwMDA6MDU6MDAuMDogQU1ELVZpOiBFdmVudCBsb2dnZWQgCj4+IFtJT19QQUdFX0ZBVUxU
IGRvbWFpbj0weDAwMGMgYWRkcmVzcz0weGZmZmZmZmRhYzAgZmxhZ3M9MHgwMDIwXQo+PiDCoMKg
wqAgWzYzMTgzOTkuODYxMzExXSBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCAK
Pj4gZGV2aWNlPTA1OjAwLjAgZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZmZmZmYzFjMCBmbGFn
cz0weDAwMjBdCj4+IMKgwqDCoCBbNjMxODM5OS44NzIwNDRdIEFNRC1WaTogRXZlbnQgbG9nZ2Vk
IFtJT19QQUdFX0ZBVUxUIAo+PiBkZXZpY2U9MDU6MDAuMCBkb21haW49MHgwMDBjIGFkZHJlc3M9
MHhmZmZmZmZjOGMwIGZsYWdzPTB4MDAyMF0KPj4gwqDCoMKgIFs2MzE4Mzk5Ljg4Mjc5N10gQU1E
LVZpOiBFdmVudCBsb2dnZWQgW0lPX1BBR0VfRkFVTFQgCj4+IGRldmljZT0wNTowMC4wIGRvbWFp
bj0weDAwMGMgYWRkcmVzcz0weGZmZmZmZmIwYzAgZmxhZ3M9MHgwMDIwXQo+PiDCoMKgwqAgWzYz
MTgzOTkuODkzNjU1XSBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCAKPj4gZGV2
aWNlPTA1OjAwLjAgZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZmZmZmY2ZjMCBmbGFncz0weDAw
MjBdCj4+IMKgwqDCoCBbNjMxODM5OS45MDQ0NDVdIEFNRC1WaTogRXZlbnQgbG9nZ2VkIFtJT19Q
QUdFX0ZBVUxUIAo+PiBkZXZpY2U9MDU6MDAuMCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZm
ZmZiNmMwIGZsYWdzPTB4MDAyMF0KPj4gwqDCoMKgIFs2MzE4Mzk5LjkxNTIyMl0gQU1ELVZpOiBF
dmVudCBsb2dnZWQgW0lPX1BBR0VfRkFVTFQgCj4+IGRldmljZT0wNTowMC4wIGRvbWFpbj0weDAw
MGMgYWRkcmVzcz0weGZmZmZmZmEwYzAgZmxhZ3M9MHgwMDIwXQo+PiDCoMKgwqAgWzYzMTgzOTku
OTI1OTMxXSBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCAKPj4gZGV2aWNlPTA1
OjAwLjAgZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZmZmZmYmRjMCBmbGFncz0weDAwMjBdCj4+
IMKgwqDCoCBbNjMxODM5OS45MzY2OTFdIEFNRC1WaTogRXZlbnQgbG9nZ2VkIFtJT19QQUdFX0ZB
VUxUIAo+PiBkZXZpY2U9MDU6MDAuMCBkb21haW49MHgwMDBjIGFkZHJlc3M9MHhmZmZmZmZhNGMw
IGZsYWdzPTB4MDAyMF0KPj4gwqDCoMKgIFs2MzE4Mzk5Ljk0NzQ3OV0gQU1ELVZpOiBFdmVudCBs
b2dnZWQgW0lPX1BBR0VfRkFVTFQgCj4+IGRldmljZT0wNTowMC4wIGRvbWFpbj0weDAwMGMgYWRk
cmVzcz0weGZmZmZmZjkwYzAgZmxhZ3M9MHgwMDIwXQo+PiDCoMKgwqAgWzYzMTgzOTkuOTU4Mjcw
XSBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCAKPj4gZGV2aWNlPTA1OjAwLjAg
ZG9tYWluPTB4MDAwYyBhZGRyZXNzPTB4ZmZmZmZmYWJjMCBmbGFncz0weDAwMjBdCj4+Cj4+IEFz
IHRoaXMgaXMgbm90IHJlcHJvZHVjaWJsZSwgaG93IHdvdWxkIGRlYnVnZ2luZyBnbz8gKFRoZSBz
eXN0ZW0gd2FzIAo+PiByZWJvb3RlZCBpbiB0aGUgbWVhbnRpbWUuKSBXaGF0IG9wdGlvbnMgc2hv
dWxkIGJlIGVuYWJsZWQsIHRoYXQgbmV4dCAKPj4gdGltZSB0aGUgcmVxdWlyZWQgaW5mb3JtYXRp
b24gaXMgbG9nZ2VkLCBvciB3aGF0IGNvbW1hbmRzIHNob3VsZCBJIAo+PiBleGVjdXRlIHdoZW4g
dGhlIHN5c3RlbSBpcyBzdGlsbCBpbiB0aGF0IHN0YXRlLCBzbyB0aGUgYnVnIChkcml2ZXIsIAo+
PiB1c2Vyc3BhY2UsIOKApikgY2FuIGJlIHBpbnBvaW50ZWQgYW5kIGZpeGVkPwo+Pgo+Pgo+PiBL
aW5kIHJlZ2FyZHMsCj4+Cj4+IFBhdWwKPj4KPj4KPj4gWzFdOiBodHRwczovL2dpdGxhYi5mcmVl
ZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy8xNzYyCj4+IMKgwqDCoMKgICJPbGFuZCBbUmFk
ZW9uIEhEIDg1NzAgLyBSNyAyNDAvMzQwIE9FTV06IEdQVSBoYW5nIgo+IAo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gaW9tbXUgbWFpbGluZyBsaXN0
Cj4gaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKPiBodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
