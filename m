Return-Path: <SRS0=hyWy=5E=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0262C4332D
	for <iommu@archiver.kernel.org>; Thu, 19 Mar 2020 13:51:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9062080C
	for <iommu@archiver.kernel.org>; Thu, 19 Mar 2020 13:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9062080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 789D9883F8;
	Thu, 19 Mar 2020 13:51:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vy7-2PfKz73f; Thu, 19 Mar 2020 13:51:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D32DC883DC;
	Thu, 19 Mar 2020 13:51:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAE23C18DA;
	Thu, 19 Mar 2020 13:51:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73C8BC18DA
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 13:51:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5EB89883E1
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 13:51:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GmYMnLLcO8US for <iommu@lists.linux-foundation.org>;
 Thu, 19 Mar 2020 13:50:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 750EB87C7D
 for <iommu@lists.linux-foundation.org>; Thu, 19 Mar 2020 13:50:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5937101E;
 Thu, 19 Mar 2020 06:50:57 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 971113F52E;
 Thu, 19 Mar 2020 06:50:56 -0700 (PDT)
Subject: Re: [PATCH] dma: Fix max PFN arithmetic overflow on 32 bit systems
To: Alexander Dahl <post@lespocky.de>, x86@kernel.org
References: <20200302181612.20597-1-post@lespocky.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <b6f6c1de-13bc-79b4-ad0a-fdfb5cb33cec@arm.com>
Date: Thu, 19 Mar 2020 13:50:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200302181612.20597-1-post@lespocky.de>
Content-Language: en-GB
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Alan Jenkins <alan.christopher.jenkins@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H . Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
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

T24gMjAyMC0wMy0wMiA2OjE2IHBtLCBBbGV4YW5kZXIgRGFobCB3cm90ZToKPiBGb3IgQVJDSD14
ODYgKDMyIGJpdCkgd2hlbiB5b3Ugc2V0IENPTkZJR19JT01NVV9JTlRFTCBzaW5jZSBjNWE1ZGM0
Y2JiZjQKPiAoImlvbW11L3Z0LWQ6IERvbid0IHN3aXRjaCBvZmYgc3dpb3RsYiBpZiBib3VuY2Ug
cGFnZSBpcyB1c2VkIikgdGhlcmUncwo+IGEgZGVwZW5kZW5jeSBvbiBDT05GSUdfU1dJT1RMQiwg
d2hpY2ggd2FzIG5vdCBuZWNlc3NhcmlseSBhY3RpdmUgYmVmb3JlLgo+IAo+IFRoZSBpbml0IGNv
ZGUgZm9yIHN3aW90bGIgaW4gJ3BjaV9zd2lvdGxiX2RldGVjdF80Z2IoKScgY29tcGFyZXMKPiBz
b21ldGhpbmcgYWdhaW5zdCBNQVhfRE1BMzJfUEZOIHRvIGRlY2lkZSBpZiBpdCBzaG91bGQgYmUg
YWN0aXZlLgo+IEhvd2V2ZXIgdGhhdCBkZWZpbmUgc3VmZmVycyBmcm9tIGFuIGFyaXRobWV0aWMg
b3ZlcmZsb3cgc2luY2UKPiAxYjdlMDNlZjc1NzAgKCJ4ODYsIE5VTUE6IEVuYWJsZSBlbXVsYXRp
b24gb24gMzJiaXQgdG9vIikgd2hlbiBpdCB3YXMKPiBmaXJzdCBtYWRlIHZpc2libGUgdG8geDg2
XzMyLgo+IAo+IFRoZSBlZmZlY3QgaXMgYXQgYm9vdCB0aW1lIDY0IE1pQiAoZGVmYXVsdCBzaXpl
KSB3ZXJlIGFsbG9jYXRlZCBmb3IKPiBib3VuY2UgYnVmZmVycyBub3csIHdoaWNoIGlzIGEgbm90
aWNlYWJsZSBhbW91bnQgb2YgbWVtb3J5IG9uIHNtYWxsCj4gc3lzdGVtcy4gV2Ugbm90aWNlZCB0
aGlzIGVmZmVjdCBvbiB0aGUgZmxpNGwgTGludXggZGlzdHJpYnV0aW9uIHdoZW4KPiBtaWdyYXRp
bmcgZnJvbSBrZXJuZWwgdjQuMTkgKExUUykgdG8gdjUuNCAoTFRTKSBvbiBib2FyZHMgbGlrZSBw
Y2VuZ2luZXMKPiBBTElYIDJEMyB3aXRoIDI1NiBNaUIgbWVtb3J5IGZvciBleGFtcGxlOgo+IAo+
ICAgIExpbnV4IHZlcnNpb24gNS40LjIyIChidWlsZHJvb3RAYnVpbGRyb290KSAoZ2NjIHZlcnNp
b24gNy4zLjAgKEJ1aWxkcm9vdCAyMDE4LjAyLjgpKSAjMSBTTVAgTW9uIE5vdiAyNiAyMzo0MDow
MCBDRVQgMjAxOAo+ICAgIOKApgo+ICAgIE1lbW9yeTogMTgzNDg0Sy8yNjE3NTZLIGF2YWlsYWJs
ZSAoNDU5NEsga2VybmVsIGNvZGUsIDM5M0sgcndkYXRhLCAxNjYwSyByb2RhdGEsIDUzNksgaW5p
dCwgNDU2SyBic3MgLCA3ODI3MksgcmVzZXJ2ZWQsIDBLIGNtYS1yZXNlcnZlZCwgMEsgaGlnaG1l
bSkKPiAgICDigKYKPiAgICBQQ0ktRE1BOiBVc2luZyBzb2Z0d2FyZSBib3VuY2UgYnVmZmVyaW5n
IGZvciBJTyAoU1dJT1RMQikKPiAgICBzb2Z0d2FyZSBJTyBUTEI6IG1hcHBlZCBbbWVtIDB4MGJi
NzgwMDAtMHgwZmI3ODAwMF0gKDY0TUIpCj4gCj4gVGhlIGluaXRpYWwgYW5hbHlzaXMgYW5kIHRo
ZSBzdWdnZXN0ZWQgZml4IHdhcyBkb25lIGJ5IHVzZXIgJ3NvdXJjZWplZGknCj4gYXQgc3RhY2tv
dmVyZmxvdyBhbmQgZXhwbGljaXRseSBtYXJrZWQgYXMgR1BMdjIgZm9yIGluY2x1c2lvbiBpbiB0
aGUKPiBMaW51eCBrZXJuZWw6Cj4gCj4gICAgaHR0cHM6Ly91bml4LnN0YWNrZXhjaGFuZ2UuY29t
L2EvNTIwNTI1LzUwMDA3Cj4gCj4gRml4ZXM6IGh0dHBzOi8vd2ViLm5ldHR3b3Jrcy5vcmcvYnVn
cy9icm93c2UvRkZMLTI1NjAKPiBGaXhlczogaHR0cHM6Ly91bml4LnN0YWNrZXhjaGFuZ2UuY29t
L3EvNTIwMDY1LzUwMDA3Cj4gU3VnZ2VzdGVkLWJ5OiBBbGFuIEplbmtpbnMgPGFsYW4uY2hyaXN0
b3BoZXIuamVua2luc0BnbWFpbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIERhaGwg
PHBvc3RAbGVzcG9ja3kuZGU+Cj4gLS0tCj4gV2UgdGVzdGVkIHRoaXMgaW4gcWVtdSBhbmQgb24g
cmVhbCBoYXJkd2FyZSB3aXRoIGZsaTRsIG9uIHRvcCBvZiB2NS40LAo+IHY1LjUsIGFuZCB2NS42
LXJjIGtlcm5lbHMsIGJ1dCBvbmx5IGFzIGZhciBhcyB0aGUgcmVzZXJ2ZWQgbWVtb3J5IGdvZXMu
Cj4gVGhlIHBhdGNoIGl0c2VsZiBpcyBiYXNlZCBvbiB2NS42LXJjMyAoSUlSQykuCj4gCj4gQSBx
dWljayBncmVwIG92ZXIgdGhlIGtlcm5lbCBjb2RlIHNob3dlZCBtZSB0aGlzIGRlZmluZSBNQVhf
RE1BMzJfUEZOIGlzCj4gdXNlZCBpbiBvdGhlciBwbGFjZXMgYXMgd2VsbC4gSSB3b3VsZCBhcHBy
ZWNpYXRlIGZlZWRiYWNrIG9uIHRoaXMsCj4gYmVjYXVzZSBJIGNhbiBub3Qgb3ZlcnNlZSBhbGwg
c2lkZSBlZmZlY3RzIHRoaXMgbWlnaHQgaGF2ZT8hCj4gCj4gVGhhbmtzIGFnYWluIHRvIEFsYW4g
d2hvIHByb3Bvc2VkIHRoZSBmaXgsIGFuZCBmb3IgaGlzIHBlcm1pc3Npb24gdG8KPiBzZW5kIGl0
IHVwc3RyZWFtLgo+IAo+IEdyZWV0cwo+IEFsZXgKPiAtLS0KPiAgIGFyY2gveDg2L2luY2x1ZGUv
YXNtL2RtYS5oIHwgMiArLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2RtYS5oIGIv
YXJjaC94ODYvaW5jbHVkZS9hc20vZG1hLmgKPiBpbmRleCAwMGY3Y2Y0NWU2OTkuLmUyNTUxNGVj
YThkNiAxMDA2NDQKPiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9kbWEuaAo+ICsrKyBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2RtYS5oCj4gQEAgLTc0LDcgKzc0LDcgQEAKPiAgICNkZWZpbmUg
TUFYX0RNQV9QRk4gICAoKDE2VUwgKiAxMDI0ICogMTAyNCkgPj4gUEFHRV9TSElGVCkKPiAgIAo+
ICAgLyogNEdCIGJyb2tlbiBQQ0kvQUdQIGhhcmR3YXJlIGJ1cyBtYXN0ZXIgem9uZSAqLwo+IC0j
ZGVmaW5lIE1BWF9ETUEzMl9QRk4gKCg0VUwgKiAxMDI0ICogMTAyNCAqIDEwMjQpID4+IFBBR0Vf
U0hJRlQpCj4gKyNkZWZpbmUgTUFYX0RNQTMyX1BGTiAoNFVMICogKCgxMDI0ICogMTAyNCAqIDEw
MjQpID4+IFBBR0VfU0hJRlQpKQoKRldJVywgd291bGRuJ3Qgcy9VTC9VTEwvIGluIHRoZSBvcmln
aW5hbCBleHByZXNzaW9uIHN1ZmZpY2U/IEZhaWxpbmcgCnRoYXQsIHJhdGhlciB0aGFuIGF3a3dh
cmQgcGFyZW50aGVzaXMgdHJpY2tlcnkgaXQgbWlnaHQgYmUgY2xlYXJlciB0byAKanVzdCBjb3B5
IHRoZSBvbmUgZnJvbSBhcmNoL21pcHMvaW5jbHVkZS9hc20vZG1hLmguCgpSb2Jpbi4KCj4gICAK
PiAgICNpZmRlZiBDT05GSUdfWDg2XzMyCj4gICAvKiBUaGUgbWF4aW11bSBhZGRyZXNzIHRoYXQg
d2UgY2FuIHBlcmZvcm0gYSBETUEgdHJhbnNmZXIgdG8gb24gdGhpcyBwbGF0Zm9ybSAqLwo+IApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
