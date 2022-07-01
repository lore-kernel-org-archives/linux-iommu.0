Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F701CCA479
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 08:18:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 177E7405C5;
	Fri,  1 Jul 2022 08:18:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 177E7405C5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nGMfXAPOboWq; Fri,  1 Jul 2022 08:18:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A1318404B2;
	Fri,  1 Jul 2022 08:18:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A1318404B2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79935C0032;
	Fri,  1 Jul 2022 08:18:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50EF9C002D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 08:18:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1DA73405C5
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 08:18:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1DA73405C5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mDWZMqhJcri5 for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 08:18:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A1AA3404B2
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id A1AA3404B2
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 08:18:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54B26106F;
 Fri,  1 Jul 2022 01:18:15 -0700 (PDT)
Received: from [10.57.85.162] (unknown [10.57.85.162])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63EE33F792;
 Fri,  1 Jul 2022 01:18:13 -0700 (PDT)
Message-ID: <1cf01e76-88d2-c65f-0b54-b85e6da0d720@arm.com>
Date: Fri, 1 Jul 2022 09:18:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 5/7] iommu/vt-d: Fix suspicious RCU usage in
 probe_acpi_namespace_devices()
Content-Language: en-GB
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
References: <20190612002851.17103-1-baolu.lu@linux.intel.com>
 <20190612002851.17103-6-baolu.lu@linux.intel.com>
 <f3619c80-14d3-d934-755a-4c3734bfde20@arm.com>
 <ffca1789-1e96-ae01-74a0-942fecb9caac@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ffca1789-1e96-ae01-74a0-942fecb9caac@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, cai@lca.pw, jacob.jun.pan@intel.com
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

T24gMjAyMi0wNy0wMSAwODoxOSwgQmFvbHUgTHUgd3JvdGU6Cj4gT24gMjAyMi82LzI5IDIxOjAz
LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IE9uIDIwMTktMDYtMTIgMDE6MjgsIEx1IEJhb2x1IHdy
b3RlOgo+Pj4gVGhlIGRyaGQgYW5kIGRldmljZSBzY29wZSBsaXN0IHNob3VsZCBiZSBpdGVyYXRl
ZCB3aXRoIHRoZQo+Pj4gaW9tbXUgZ2xvYmFsIGxvY2sgaGVsZC4gT3RoZXJ3aXNlLCBhIHN1c3Bp
Y2lvdXMgUkNVIHVzYWdlCj4+PiBtZXNzYWdlIHdpbGwgYmUgZGlzcGxheWVkLgo+Pj4KPj4+IFvC
oMKgwqAgMy42OTU4ODZdID09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4+PiBbwqDCoMKg
IDMuNjk1OTE3XSBXQVJOSU5HOiBzdXNwaWNpb3VzIFJDVSB1c2FnZQo+Pj4gW8KgwqDCoCAzLjY5
NTk1MF0gNS4yLjAtcmMyKyAjMjQ2NyBOb3QgdGFpbnRlZAo+Pj4gW8KgwqDCoCAzLjY5NTk4MV0g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPj4+IFvCoMKgwqAgMy42OTYwMTRdIGRyaXZl
cnMvaW9tbXUvaW50ZWwtaW9tbXUuYzo0NTY5IHN1c3BpY2lvdXMgCj4+PiByY3VfZGVyZWZlcmVu
Y2VfY2hlY2soKSB1c2FnZSEKPj4+IFvCoMKgwqAgMy42OTYwNjldCj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgb3RoZXIgaW5mbyB0aGF0IG1pZ2h0IGhlbHAgdXMgZGVidWcgdGhp
czoKPj4+Cj4+PiBbwqDCoMKgIDMuNjk2MTI2XQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJjdV9zY2hlZHVsZXJfYWN0aXZlID0gMiwgZGVidWdfbG9ja3MgPSAxCj4+PiBbwqDC
oMKgIDMuNjk2MTczXSBubyBsb2NrcyBoZWxkIGJ5IHN3YXBwZXIvMC8xLgo+Pj4gW8KgwqDCoCAz
LjY5NjIwNF0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdGFjayBiYWNrdHJh
Y2U6Cj4+PiBbwqDCoMKgIDMuNjk2MjQxXSBDUFU6IDAgUElEOiAxIENvbW06IHN3YXBwZXIvMCBO
b3QgdGFpbnRlZCA1LjIuMC1yYzIrIAo+Pj4gIzI0NjcKPj4+IFvCoMKgwqAgMy42OTYzNzBdIENh
bGwgVHJhY2U6Cj4+PiBbwqDCoMKgIDMuNjk2NDA0XcKgIGR1bXBfc3RhY2srMHg4NS8weGNiCj4+
PiBbwqDCoMKgIDMuNjk2NDQxXcKgIGludGVsX2lvbW11X2luaXQrMHgxMjhjLzB4MTNjZQo+Pj4g
W8KgwqDCoCAzLjY5NjQ3OF3CoCA/IGttZW1fY2FjaGVfZnJlZSsweDE2Yi8weDJjMAo+Pj4gW8Kg
wqDCoCAzLjY5NjUxNl3CoCA/IF9fZnB1dCsweDE0Yi8weDI3MAo+Pj4gW8KgwqDCoCAzLjY5NjU1
MF3CoCA/IF9fY2FsbF9yY3UrMHhiNy8weDMwMAo+Pj4gW8KgwqDCoCAzLjY5NjU4M13CoCA/IGdl
dF9tYXhfZmlsZXMrMHgxMC8weDEwCj4+PiBbwqDCoMKgIDMuNjk2NjMxXcKgID8gc2V0X2RlYnVn
X3JvZGF0YSsweDExLzB4MTEKPj4+IFvCoMKgwqAgMy42OTY2NjhdwqAgPyBlODIwX19tZW1ibG9j
a19zZXR1cCsweDYwLzB4NjAKPj4+IFvCoMKgwqAgMy42OTY3MDRdwqAgPyBwY2lfaW9tbXVfaW5p
dCsweDE2LzB4M2YKPj4+IFvCoMKgwqAgMy42OTY3MzddwqAgPyBzZXRfZGVidWdfcm9kYXRhKzB4
MTEvMHgxMQo+Pj4gW8KgwqDCoCAzLjY5Njc3MF3CoCBwY2lfaW9tbXVfaW5pdCsweDE2LzB4M2YK
Pj4+IFvCoMKgwqAgMy42OTY4MDVdwqAgZG9fb25lX2luaXRjYWxsKzB4NWQvMHgyZTQKPj4+IFvC
oMKgwqAgMy42OTY4NDRdwqAgPyBzZXRfZGVidWdfcm9kYXRhKzB4MTEvMHgxMQo+Pj4gW8KgwqDC
oCAzLjY5Njg4MF3CoCA/IHJjdV9yZWFkX2xvY2tfc2NoZWRfaGVsZCsweDZiLzB4ODAKPj4+IFvC
oMKgwqAgMy42OTY5MjRdwqAga2VybmVsX2luaXRfZnJlZWFibGUrMHgxZjAvMHgyN2MKPj4+IFvC
oMKgwqAgMy42OTY5NjFdwqAgPyByZXN0X2luaXQrMHgyNjAvMHgyNjAKPj4+IFvCoMKgwqAgMy42
OTY5OTddwqAga2VybmVsX2luaXQrMHhhLzB4MTEwCj4+PiBbwqDCoMKgIDMuNjk3MDI4XcKgIHJl
dF9mcm9tX2ZvcmsrMHgzYS8weDUwCj4+Pgo+Pj4gRml4ZXM6IGZhMjEyYTk3ZjNhMzYgKCJpb21t
dS92dC1kOiBQcm9iZSBETUEtY2FwYWJsZSBBQ1BJIG5hbWUgc3BhY2UgCj4+PiBkZXZpY2VzIikK
Pj4+IFNpZ25lZC1vZmYtYnk6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+Cj4+
PiAtLS0KPj4+IMKgIGRyaXZlcnMvaW9tbXUvaW50ZWwtaW9tbXUuYyB8IDIgKysKPj4+IMKgIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pb21tdS9pbnRlbC1pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jCj4+PiBp
bmRleCAxOWM0YzM4N2EzZjYuLjg0ZTY1MGM2YTQ2ZCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMv
aW9tbXUvaW50ZWwtaW9tbXUuYwo+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5j
Cj4+PiBAQCAtNDc5Myw4ICs0NzkzLDEwIEBAIGludCBfX2luaXQgaW50ZWxfaW9tbXVfaW5pdCh2
b2lkKQo+Pj4gwqDCoMKgwqDCoCBjcHVocF9zZXR1cF9zdGF0ZShDUFVIUF9JT01NVV9JTlRFTF9E
RUFELCAiaW9tbXUvaW50ZWw6ZGVhZCIsIAo+Pj4gTlVMTCwKPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpbnRlbF9pb21tdV9jcHVfZGVhZCk7Cj4+PiArwqDCoMKgIGRvd25fcmVh
ZCgmZG1hcl9nbG9iYWxfbG9jayk7Cj4+PiDCoMKgwqDCoMKgIGlmIChwcm9iZV9hY3BpX25hbWVz
cGFjZV9kZXZpY2VzKCkpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfd2FybigiQUNQSSBuYW1l
IHNwYWNlIGRldmljZXMgZGlkbid0IHByb2JlIGNvcnJlY3RseVxuIik7Cj4+PiArwqDCoMKgIHVw
X3JlYWQoJmRtYXJfZ2xvYmFsX2xvY2spOwo+Pgo+PiBEb2luZyBhIGJpdCBvZiBhcmNoYWVvbG9n
eSBoZXJlLCBpcyB0aGlzIGFjdHVhbGx5IGJyb2tlbj8gSWYgYW55IEFOREQgCj4+IGVudHJpZXMg
ZXhpc3QsIHdlJ2QgZW5kIHVwIGRvaW5nOgo+Pgo+PiDCoMKgIGRvd25fcmVhZCgmZG1hcl9nbG9i
YWxfbG9jaykKPj4gwqDCoCBwcm9iZV9hY3BpX25hbWVzcGFjZV9kZXZpY2VzKCkKPj4gwqDCoCAt
PiBpb21tdV9wcm9iZV9kZXZpY2UoKQo+PiDCoMKgwqDCoMKgIC0+IGlvbW11X2NyZWF0ZV9kZXZp
Y2VfZGlyZWN0X21hcHBpbmdzKCkKPj4gwqDCoMKgwqDCoMKgwqDCoCAtPiBpb21tdV9nZXRfcmVz
dl9yZWdpb25zKCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtPiBpbnRlbF9pb21tdV9nZXRf
cmVzdl9yZWdpb25zKCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtPiBkb3duX3Jl
YWQoJmRtYXJfZ2xvYmFsX2xvY2spCj4+Cj4+IEknbSB3b25kZXJpbmcgd2hldGhlciB0aGlzIG1p
Z2h0IGV4cGxhaW4gd2h5IG15IGJ1c19zZXRfaW9tbXUgc2VyaWVzIAo+PiBwcmV2ZW50ZWQgQmFv
bHUncyBtYWNoaW5lIGZyb20gYm9vdGluZywgc2luY2UgImlvbW11OiBNb3ZlIGJ1cyBzZXR1cCAK
Pj4gdG8gSU9NTVUgZGV2aWNlIHJlZ2lzdHJhdGlvbiIgY3JlYXRlcyB0aGUgc2FtZSBjb25kaXRp
b24gd2hlcmUgd2UgZW5kIAo+PiB1cCBpbiBnZXRfcmVzdl9yZWdpb25zICh2aWEgYnVzX2lvbW11
X3Byb2JlKCkgdGhpcyB0aW1lKSBmcm9tIHRoZSBzYW1lIAo+PiB0YXNrIHRoYXQgYWxyZWFkeSBo
b2xkcyBkbWFyX2dsb2JhbF9sb2NrLiBPZiBjb3Vyc2UgdGhhdCBsZWF2ZXMgbWUgCj4+IHdvbmRl
cmluZyBob3cgaXQgKmRpZCogbWFuYWdlIHRvIGJvb3QgT0sgb24gbXkgWGVvbiBib3gsIGJ1dCBt
YXliZSAKPj4gdGhlcmUncyBhIGNvbmZpZyBkaWZmZXJlbmNlIG9yIGR1bWIgbHVjayBhdCBwbGF5
Pwo+IAo+IFRoaXMgaXMgcmVhbGx5IHByb2JsZW1hdGljLiBXaGVyZSBkb2VzIHRoZSBsYXRlc3Qg
YnVzX3NldF9pb21tdSBzZXJpZXMKPiBsb2NhdGU/IEknZCBsaWtlIHRvIHRha2UgYSBjbG9zZXIg
bG9vayBhdCB3aGF0IGhhcHBlbmVkIGhlcmUuIFBlcmhhcHMKPiB0d28gd2Vla3MgbGF0ZXI/IEkn
bSBidXN5IHdpdGggcHJlcGFyaW5nIEludGVsIElPTU1VIHBhdGNoZXMgZm9yIHY1LjIwCj4gdGhl
c2UgZGF5cy4KCkkndmUgcHJlcGFyZWQgYW4gdXAtdG8tZGF0ZSBzZXJpZXMgaGVyZToKCmh0dHBz
Oi8vZ2l0bGFiLmFybS5jb20vbGludXgtYXJtL2xpbnV4LXJtLy0vdHJlZS9idXMtc2V0LWlvbW11
LXYzCgpidXQgSSd2ZSBiZWVuIGhlc2l0YW50IHRvIHBvc3QgaXQgd2l0aG91dCB0cnlpbmcgdG8g
bWFrZSAqc29tZSogcHJvZ3Jlc3MgCm9uIHlvdXIgYnJlYWthZ2UuIEkgdGhpbmsgbGFzdCB0aW1l
IEkgd2FzIGp1c3QgdGVzdGluZyB3aXRoIAp4ODZfNjRfZGVmY29uZmlnLCBzbyBJJ2xsIGRvdWJs
ZS1jaGVjayBpdCB3aXRoIGxvY2tkZXAgdGhpcyBhZnRlcm5vb24uCgpUaGFua3MsClJvYmluLgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWls
aW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
