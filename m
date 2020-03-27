Return-Path: <SRS0=HkIk=5M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CFFC2D0E5
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 19:03:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCAD52071B
	for <iommu@archiver.kernel.org>; Fri, 27 Mar 2020 19:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCAD52071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9DBF2877DD;
	Fri, 27 Mar 2020 19:03:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NLlEXnI9M6MZ; Fri, 27 Mar 2020 19:03:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E062B877D6;
	Fri, 27 Mar 2020 19:03:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6068C18DA;
	Fri, 27 Mar 2020 19:03:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E905C0177
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 19:03:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 26863886F7
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 19:03:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5WXnpFneFVdw for <iommu@lists.linux-foundation.org>;
 Fri, 27 Mar 2020 19:03:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 766B3886EF
 for <iommu@lists.linux-foundation.org>; Fri, 27 Mar 2020 19:03:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF59E30E;
 Fri, 27 Mar 2020 12:03:00 -0700 (PDT)
Received: from [10.57.60.204] (unknown [10.57.60.204])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6527F3F71E;
 Fri, 27 Mar 2020 12:02:59 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu: Demote error messages to debug in
 shutdown callback
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
References: <20200327132852.10352-1-saiprakash.ranjan@codeaurora.org>
 <0023bc68-45fb-4e80-00c8-01fd0369243f@arm.com>
 <37db9a4d524aa4d7529ae47a8065c9e0@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5858bdac-b7f9-ac26-0c0d-c9653cef841d@arm.com>
Date: Fri, 27 Mar 2020 19:02:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <37db9a4d524aa4d7529ae47a8065c9e0@codeaurora.org>
Content-Language: en-GB
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Douglas Anderson <dianders@chromium.org>, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>
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

T24gMjAyMC0wMy0yNyAzOjA5IHBtLCBTYWkgUHJha2FzaCBSYW5qYW4gd3JvdGU6Cj4gSGkgUm9i
aW4sCj4gCj4gVGhhbmtzIGZvciB0YWtpbmcgYSBsb29rIGF0IHRoaXMuCj4gCj4gT24gMjAyMC0w
My0yNyAxOTo0MiwgUm9iaW4gTXVycGh5IHdyb3RlOgo+PiBPbiAyMDIwLTAzLTI3IDE6MjggcG0s
IFNhaSBQcmFrYXNoIFJhbmphbiB3cm90ZToKPj4+IEN1cnJlbnRseSBvbiByZWJvb3Qvc2h1dGRv
d24sIHRoZSBmb2xsb3dpbmcgbWVzc2FnZXMgYXJlCj4+PiBkaXNwbGF5ZWQgb24gdGhlIGNvbnNv
bGUgYXMgZXJyb3IgbWVzc2FnZXMgYmVmb3JlIHRoZQo+Pj4gc3lzdGVtIHJlYm9vdHMvc2h1dGRv
d24uCj4+Pgo+Pj4gT24gU0M3MTgwOgo+Pj4KPj4+IMKgwqAgYXJtLXNtbXUgMTUwMDAwMDAuaW9t
bXU6IHJlbW92aW5nIGRldmljZSB3aXRoIGFjdGl2ZSBkb21haW5zIQo+Pj4gwqDCoCBhcm0tc21t
dSA1MDQwMDAwLmlvbW11OiByZW1vdmluZyBkZXZpY2Ugd2l0aCBhY3RpdmUgZG9tYWlucyEKPj4+
Cj4+PiBEZW1vdGUgdGhlIGxvZyBsZXZlbCB0byBkZWJ1ZyBzaW5jZSBpdCBkb2VzIG5vdCBvZmZl
ciBtdWNoCj4+PiBoZWxwIGluIGlkZW50aWZ5aW5nL2ZpeGluZyBhbnkgaXNzdWUgYXMgdGhlIHN5
c3RlbSBpcyBhbnl3YXlzCj4+PiBnb2luZyBkb3duIGFuZCByZWR1Y2Ugc3BhbW1pbmcgdGhlIGtl
cm5lbCBsb2cuCj4+Cj4+IEkndmUgZ29uZSBiYWNrIGFuZCBmb3J0aCBvbiB0aGlzIHByZXR0eSBt
dWNoIGV2ZXIgc2luY2Ugd2UgYWRkZWQgdGhlCj4+IHNodXRkb3duIGhvb2sgLSBvbiB0aGUgb3Ro
ZXIgaGFuZCwgaWYgYW55IGRldmljZXMgKmFyZSogc3RpbGwgcnVubmluZwo+PiBpbiB0aG9zZSBk
b21haW5zIGF0IHRoaXMgcG9pbnQsIHRoZW4gb25jZSB3ZSB0dXJuIG9mZiB0aGUgU01NVSBhbmQg
bGV0Cj4+IHRob3NlIElPVkFzIGdvIG91dCBvbiB0aGUgYnVzIGFzIHBoeXNpY2FsIGFkZHJlc3Nl
cywgYWxsIG1hbm5lciBvZgo+PiB3ZWlyZG5lc3MgbWF5IGVuc3VlLiBUaHVzIHRoZXJlIGlzIGFu
IGFyZ3VtZW50IGZvciAqc29tZSogaW5kaWNhdGlvbgo+PiB0aGF0IHRoaXMgbWF5IGhhcHBlbiwg
YWx0aG91Z2ggSU1PIGl0IGNvdWxkIGJlIGRvd25ncmFkZWQgdG8gYXQgbGVhc3QKPj4gZGV2X3dh
cm4oKS4KPj4KPiAKPiBBbnkgcG9pbnRlcnMgdG8gdGhlIHdlaXJkbmVzcyBoZXJlIGFmdGVyIFNN
TVUgaXMgdHVybmVkIG9mZj8KPiBCZWNhdXNlIGlmIHdlIGxvb2sgYXQgdGhlIGNhbGwgc2l0ZXMs
IGRldmljZV9zaHV0ZG93biBpcyBjYWxsZWQKPiBmcm9tIGtlcm5lbF9yZXN0YXJ0X3ByZXBhcmUg
b3Iga2VybmVsX3NodXRkb3duX3ByZXBhcmUgd2hpY2ggd291bGQKPiBtZWFuIHN5c3RlbSBpcyBn
b2luZyBkb3duIGFueXdheXMsIHNvIGRvIHdlIHJlYWxseSBjYXJlIGFib3V0IHRoZXNlCj4gZXJy
b3IgbWVzc2FnZXMgb3Igd2FybmluZ3MgZnJvbSBTTU1VPwo+IAo+ICDCoGFybV9zbW11X2Rldmlj
ZV9zaHV0ZG93bgo+ICDCoCBwbGF0Zm9ybV9kcnZfc2h1dGRvd24KPiAgwqDCoCBkZXZpY2Vfc2h1
dGRvd24KPiAgwqDCoMKgIGtlcm5lbF9yZXN0YXJ0X3ByZXBhcmUKPiAgwqDCoMKgwqAga2VybmVs
X3Jlc3RhcnQKCkltYWdpbmUgeW91ciBuZXR3b3JrIGRyaXZlciBkb2Vzbid0IGltcGxlbWVudCBh
IC5zaHV0ZG93biBtZXRob2QgKHNvIHRoZSAKaGFyZHdhcmUgaXMgc3RpbGwgYWN0aXZlIHJlZ2Fy
ZGxlc3Mgb2YgZGV2aWNlIGxpbmtzKSwgaGFwcGVucyB0byBoYXZlIGFuIApSeCBidWZmZXIgb3Ig
ZGVzY3JpcHRvciByaW5nIERNQS1tYXBwZWQgYXQgYW4gSU9WQSB0aGF0IGxvb2tzIGxpa2UgdGhl
IApwaHlzaWNhbCBhZGRyZXNzIG9mIHRoZSBtZW1vcnkgY29udGFpbmluZyBzb21lIHBhcnQgb2Yg
dGhlIGtlcm5lbCB0ZXh0IApsb3dlciBkb3duIHRoYXQgY2FsbCBzdGFjaywgYW5kIHRoZSBNQUMg
cmVjZWl2ZXMgYSBicm9hZGNhc3QgSVAgcGFja2V0IAphdCBhYm91dCB0aGUgcG9pbnQgYXJtX3Nt
bXVfZGV2aWNlX3NodXRkb3duKCkgaXMgcmV0dXJuaW5nLiBFbmpveSAKZGVidWdnaW5nIHRoYXQg
OykKCkFuZCBpZiBjb2luY2lkZW50YWwgbWVtb3J5IGNvcnJ1cHRpb24gc2VlbXMgdG9vIGZhci1m
ZXRjaGVkIGZvciB5b3VyIApsaWtpbmcsIG90aGVyIGZ1biBhbHRlcm5hdGl2ZXMgbWlnaHQgaW5j
bHVkZSAiZGlzcGxheSB0cmllcyB0byBzY2FuIG91dCAKZnJvbSBwb3dlcmVkLW9mZiBkZXZpY2Us
IGRlYWRsb2NrcyBpbnRlcmNvbm5lY3QgYW5kIHByZXZlbnRzIGFueXRoaW5nIAplbHNlIG1ha2lu
ZyBwcm9ncmVzcyIsIG9yICJhY2Nlc3MgdG8gVFpDLXByb3RlY3RlZCBwaHlzaWNhbCBhZGRyZXNz
IAp0cmlnZ2VycyBpbnRlcnJ1cHQgYW5kIG92ZXItZWFnZXIgU2VjdXJlIGZpcm13YXJlIHJlc2V0
cyBzeXN0ZW0gYmVmb3JlIApvcmRlcmx5IHBvd2Vyb2ZmIGhhcyBhIGNoYW5jZSB0byBmaW5pc2gi
LgoKT2YgY291cnNlIHRoZSBmYWN0IHRoYXQgaW4gcHJhY3RpY2Ugd2UnbGwgKmFsd2F5cyogc2Vl
IHRoZSB3YXJuaW5nIApiZWNhdXNlIHRoZXJlJ3Mgbm8gd2F5IHRvIHRlYXIgZG93biB0aGUgZGVm
YXVsdCBETUEgZG9tYWlucywgYW5kIGV2ZW4gaWYgCmFsbCBkZXZpY2VzICpoYXZlKiBiZWVuIG5p
Y2VseSBxdWllc2NlZCB0aGVyZSdzIG5vIHdheSB0byB0ZWxsLCBpcyAKY2VydGFpbmx5IGxlc3Mg
dGhhbiBpZGVhbC4gTGlrZSBJIHNheSwgaXQncyBub3QgZW50aXJlbHkgY2xlYXItY3V0IAplaXRo
ZXIgd2F5Li4uCgpSb2Jpbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
