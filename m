Return-Path: <SRS0=k0pT=6I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05719C54FCB
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 12:15:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29C620700
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 12:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29C620700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 98E138880C;
	Fri, 24 Apr 2020 12:15:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zFSspx-8fqTW; Fri, 24 Apr 2020 12:15:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9576088809;
	Fri, 24 Apr 2020 12:15:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73CEAC089E;
	Fri, 24 Apr 2020 12:15:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FC5FC0175
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 12:15:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 242D724C2A
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 12:15:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MfyOdr6J-71D for <iommu@lists.linux-foundation.org>;
 Fri, 24 Apr 2020 12:15:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 62AEB24BEF
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 12:15:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2D141FB;
 Fri, 24 Apr 2020 05:15:22 -0700 (PDT)
Received: from [10.57.33.170] (unknown [10.57.33.170])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4520F3F6CF;
 Fri, 24 Apr 2020 05:15:22 -0700 (PDT)
Subject: Re: iommu_iova slab eats too much memory
To: Bin <anole1949@gmail.com>
References: <CAEbUFv6SHY8z2kuNFwZ4khFwgqLZjxi4-KfDv5kVANeROMU_Vw@mail.gmail.com>
 <CAEbUFv5AybVFe8Wg6ZKLaiUoUj25G_oRk+Xi_HVSvb6pTsgYzQ@mail.gmail.com>
 <CAEbUFv7YZCh5V5btB4npBLg_FcZqB01LOp_QQKM7qURmucPAqQ@mail.gmail.com>
 <562c9033-05b2-2a15-5294-f68e40c02e92@arm.com>
 <CAEbUFv5_bG7-rNFZ0R8f0ndgbc84aM_jyV8pi8wusy6qs9=hVA@mail.gmail.com>
 <CAEbUFv5mxo1TnJ7KyjpcPaefP4=3rB=_vgu8O3EHKcQQiBXo-Q@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9157a31a-e6b5-4317-e50c-c69e1af094c5@arm.com>
Date: Fri, 24 Apr 2020 13:15:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAEbUFv5mxo1TnJ7KyjpcPaefP4=3rB=_vgu8O3EHKcQQiBXo-Q@mail.gmail.com>
Content-Language: en-GB
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

T24gMjAyMC0wNC0yNCAxOjA2IHBtLCBCaW4gd3JvdGU6Cj4gSSdtIG5vdCBmYW1pbGlhciB3aXRo
IHRoZSBtbXUgc3R1ZmYsIHNvIHdoYXQgeW91IG1lYW4gYnkgInNvbWUgZHJpdmVyCj4gbGVha2lu
ZyBETUEgbWFwcGluZ3MiLCBpcyBpdCBwb3NzaWJsZSB0aGF0IHNvbWUgb3RoZXIga2VybmVsIG1v
ZHVsZSBsaWtlCj4gS1ZNIG9yIE5JQyBkcml2ZXIgbGVhZHMgdG8gdGhlIGxlYWtpbmcgcHJvYmxl
bSBpbnN0ZWFkIG9mIHRoZSBpb21tdSBtb2R1bGUKPiBpdHNlbGY/CgpZZXMgLSBJIGRvdWJ0IHRo
YXQgaW50ZWwtaW9tbXUgaXRzZWxmIGlzIGZhaWxpbmcgdG8gZnJlZSBJT1ZBcyB3aGVuIGl0IApz
aG91bGQsIHNpbmNlIEknZCBleHBlY3QgYSBsb3Qgb2YgcGVvcGxlIHRvIGhhdmUgbm90aWNlZCB0
aGF0LiBJdCdzIGZhciAKbW9yZSBsaWtlbHkgdGhhdCBzb21lIGRyaXZlciBpcyBmYWlsaW5nIHRv
IGNhbGwgZG1hX3VubWFwXyogd2hlbiBpdCdzIApmaW5pc2hlZCB3aXRoIGEgYnVmZmVyIC0gd2l0
aCB0aGUgSU9NTVUgZGlzYWJsZWQgdGhhdCB3b3VsZCBiZSBhIG5vLW9wIApvbiB4ODYgd2l0aCBh
IG1vZGVybiA2NC1iaXQtY2FwYWJsZSBkZXZpY2UsIHNvIHN1Y2ggYSBsYXRlbnQgYnVnIGNvdWxk
IApoYXZlIGJlZW4gZWFzaWx5IG92ZXJsb29rZWQuCgpSb2Jpbi4KCj4gQmluIDxhbm9sZTE5NDlA
Z21haWwuY29tPiDkuo4gMjAyMOW5tDTmnIgyNOaXpeWRqOS6lCAyMDowMOWGmemBk++8mgo+IAo+
PiBXZWxsLCB0aGF0J3MgdGhlIHByb2JsZW0hIEknbSBhc3N1bWluZyB0aGUgaW9tbXUga2VybmVs
IG1vZHVsZSBpcyBsZWFraW5nCj4+IG1lbW9yeS4gQnV0IEkgZG9uJ3Qga25vdyB3aHkgYW5kIGhv
dy4KPj4KPj4gRG8geW91IGhhdmUgYW55IGlkZWEgYWJvdXQgaXQ/IE9yIGFueSBmdXJ0aGVyIGlu
Zm9ybWF0aW9uIGlzIG5lZWRlZD8KPj4KPj4gUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJt
LmNvbT4g5LqOIDIwMjDlubQ05pyIMjTml6XlkajkupQgMTk6MjDlhpnpgZPvvJoKPj4KPj4+IE9u
IDIwMjAtMDQtMjQgMTo0MCBhbSwgQmluIHdyb3RlOgo+Pj4+IEhlbGxvPyBhbnlvbmUgdGhlcmU/
Cj4+Pj4KPj4+PiBCaW4gPGFub2xlMTk0OUBnbWFpbC5jb20+IOS6jjIwMjDlubQ05pyIMjPml6Xl
kajlm5sg5LiL5Y2INToxNOWGmemBk++8mgo+Pj4+Cj4+Pj4+IEZvcmdldCB0byBtZW50aW9uLCBJ
J3ZlIGFscmVhZHkgZGlzYWJsZWQgdGhlIHNsYWIgbWVyZ2UsIHNvIHRoaXMgaXMKPj4+IHdoYXQK
Pj4+Pj4gaXQgaXMuCj4+Pj4+Cj4+Pj4+IEJpbiA8YW5vbGUxOTQ5QGdtYWlsLmNvbT4g5LqOMjAy
MOW5tDTmnIgyM+aXpeWRqOWbmyDkuIvljYg1OjEx5YaZ6YGT77yaCj4+Pj4+Cj4+Pj4+PiBIZXks
IGd1eXM6Cj4+Pj4+Pgo+Pj4+Pj4gSSdtIHJ1bm5pbmcgYSBiYXRjaCBvZiBDb3JlT1MgYm94ZXMs
IHRoZSBsc2JfcmVsZWFzZSBpczoKPj4+Pj4+Cj4+Pj4+PiBgYGAKPj4+Pj4+ICMgY2F0IC9ldGMv
bHNiLXJlbGVhc2UKPj4+Pj4+IERJU1RSSUJfSUQ9IkNvbnRhaW5lciBMaW51eCBieSBDb3JlT1Mi
Cj4+Pj4+PiBESVNUUklCX1JFTEVBU0U9MjMwMy4zLjAKPj4+Pj4+IERJU1RSSUJfQ09ERU5BTUU9
IlJoeW9saXRlIgo+Pj4+Pj4gRElTVFJJQl9ERVNDUklQVElPTj0iQ29udGFpbmVyIExpbnV4IGJ5
IENvcmVPUyAyMzAzLjMuMCAoUmh5b2xpdGUpIgo+Pj4+Pj4gYGBgCj4+Pj4+Pgo+Pj4+Pj4gYGBg
Cj4+Pj4+PiAjIHVuYW1lIC1hCj4+Pj4+PiBMaW51eCBjbG91ZC13b3JrZXItMjUgNC4xOS44Ni1j
b3Jlb3MgIzEgU01QIE1vbiBEZWMgMiAyMDoxMzozOCAtMDAKPj4+IDIwMTkKPj4+Pj4+IHg4Nl82
NCBJbnRlbChSKSBYZW9uKFIpIENQVSBFNS0yNjQwIHYyIEAgMi4wMEdIeiBHZW51aW5lSW50ZWwK
Pj4+IEdOVS9MaW51eAo+Pj4+Pj4gYGBgCj4+Pj4+PiBSZWNlbnRseSwgSSBmb3VuZCBteSB2bXMg
Y29uc3RlbnRseSBiZWluZyBraWxsZWQgZHVlIHRvIE9PTSwgYW5kIGFmdGVyCj4+Pj4+PiBkaWdn
aW5nIGludG8gdGhlIHByb2JsZW0sIEkgZmluYWxseSByZWFsaXplZCB0aGF0IHRoZSBrZXJuZWwg
aXMKPj4+IGxlYWtpbmcKPj4+Pj4+IG1lbW9yeS4KPj4+Pj4+Cj4+Pj4+PiBIZXJlJ3MgbXkgc2xh
YmluZm86Cj4+Pj4+Pgo+Pj4+Pj4gICAgQWN0aXZlIC8gVG90YWwgT2JqZWN0cyAoJSB1c2VkKSAg
ICA6IDgzODE4MzA2IC8gODQxOTE2MDcgKDk5LjYlKQo+Pj4+Pj4gICAgQWN0aXZlIC8gVG90YWwg
U2xhYnMgKCUgdXNlZCkgICAgICA6IDEzMzYyOTMgLyAxMzM2MjkzICgxMDAuMCUpCj4+Pj4+PiAg
ICBBY3RpdmUgLyBUb3RhbCBDYWNoZXMgKCUgdXNlZCkgICAgIDogMTUyIC8gMjE3ICg3MC4wJSkK
Pj4+Pj4+ICAgIEFjdGl2ZSAvIFRvdGFsIFNpemUgKCUgdXNlZCkgICAgICAgOiA1ODI4NzY4LjA4
SyAvIDU5OTY4NDguNzJLCj4+PiAoOTcuMiUpCj4+Pj4+PiAgICBNaW5pbXVtIC8gQXZlcmFnZSAv
IE1heGltdW0gT2JqZWN0IDogMC4wMUsgLyAwLjA3SyAvIDIzLjI1Swo+Pj4+Pj4KPj4+Pj4+ICAg
ICBPQkpTIEFDVElWRSAgVVNFIE9CSiBTSVpFICBTTEFCUyBPQkovU0xBQiBDQUNIRSBTSVpFIE5B
TUUKPj4+Pj4+Cj4+Pj4+PiA4MDI1Mzg4OCA4MDI1Mzg4OCAxMDAlICAgIDAuMDZLIDEyNTM5Njcg
ICAgICAgNjQgICA1MDE1ODY4SyBpb21tdV9pb3ZhCj4+Pgo+Pj4gRG8geW91IHJlYWxseSBoYXZl
IGEgcGVhayBkZW1hbmQgb2YgfjgwIG1pbGxpb24gc2ltdWx0YW5lb3VzIERNQQo+Pj4gYnVmZmVy
cywgb3IgaXMgc29tZSBkcml2ZXIgbGVha2luZyBETUEgbWFwcGluZ3M/Cj4+Pgo+Pj4gUm9iaW4u
Cj4+Pgo+Pj4+Pj4gNDg5NDcyIDQ4OTEyMyAgOTklICAgIDAuMDNLICAgMzgyNCAgICAgIDEyOCAg
ICAgMTUyOTZLIGttYWxsb2MtMzIKPj4+Pj4+Cj4+Pj4+PiAyOTc0NDQgMjcxMTEyICA5MSUgICAg
MC4xOUsgICA3MDgyICAgICAgIDQyICAgICA1NjY1NksgZGVudHJ5Cj4+Pj4+Pgo+Pj4+Pj4gMjU0
NDAwIDI1Mjc4NCAgOTklICAgIDAuMDZLICAgMzk3NSAgICAgICA2NCAgICAgMTU5MDBLIGFub25f
dm1hX2NoYWluCj4+Pj4+Pgo+Pj4+Pj4gMjIyNTI4ICAzOTI1NSAgMTclICAgIDAuNTBLICAgNjk1
NCAgICAgICAzMiAgICAxMTEyNjRLIGttYWxsb2MtNTEyCj4+Pj4+Pgo+Pj4+Pj4gMjAyNDgyIDIw
MTgxNCAgOTklICAgIDAuMTlLICAgNDgyMSAgICAgICA0MiAgICAgMzg1NjhLIHZtX2FyZWFfc3Ry
dWN0Cj4+Pj4+Pgo+Pj4+Pj4gMjAwMTkyIDIwMDE5MiAxMDAlICAgIDAuMDFLICAgIDM5MSAgICAg
IDUxMiAgICAgIDE1NjRLIGttYWxsb2MtOAo+Pj4+Pj4KPj4+Pj4+IDE3MDUyOCAxNjkzNTkgIDk5
JSAgICAwLjI1SyAgIDUzMjkgICAgICAgMzIgICAgIDQyNjMySyBmaWxwCj4+Pj4+Pgo+Pj4+Pj4g
MTU4MTQ0IDE1MzUwOCAgOTclICAgIDAuMDZLICAgMjQ3MSAgICAgICA2NCAgICAgIDk4ODRLIGtt
YWxsb2MtNjQKPj4+Pj4+Cj4+Pj4+PiAxNDk5MTQgMTQ5MzY1ICA5OSUgICAgMC4wOUsgICAzMjU5
ICAgICAgIDQ2ICAgICAxMzAzNksgYW5vbl92bWEKPj4+Pj4+Cj4+Pj4+PiAxNDY2NDAgMTQzMTIz
ICA5NyUgICAgMC4xMEsgICAzNzYwICAgICAgIDM5ICAgICAxNTA0MEsgYnVmZmVyX2hlYWQKPj4+
Pj4+Cj4+Pj4+PiAxMzAzNjggIDMyNzkxICAyNSUgICAgMC4wOUsgICAzMTA0ICAgICAgIDQyICAg
ICAxMjQxNksga21hbGxvYy05Ngo+Pj4+Pj4KPj4+Pj4+IDEyOTc1MiAxMjk3NTIgMTAwJSAgICAw
LjA3SyAgIDIzMTcgICAgICAgNTYgICAgICA5MjY4SyBBY3BpLU9wZXJhbmQKPj4+Pj4+Cj4+Pj4+
PiAxMDU0NjggMTA1MTA2ICA5OSUgICAgMC4wNEsgICAxMDM0ICAgICAgMTAyICAgICAgNDEzNksK
Pj4+Pj4+IHNlbGludXhfaW5vZGVfc2VjdXJpdHkKPj4+Pj4+ICAgIDczMDgwICA3MzA4MCAxMDAl
ICAgIDAuMTNLICAgMjQzNiAgICAgICAzMCAgICAgIDk3NDRLCj4+PiBrZXJuZnNfbm9kZV9jYWNo
ZQo+Pj4+Pj4KPj4+Pj4+ICAgIDcyMzYwICA3MDI2MSAgOTclICAgIDAuNTlLICAgMTM0MCAgICAg
ICA1NCAgICAgNDI4ODBLIGlub2RlX2NhY2hlCj4+Pj4+Pgo+Pj4+Pj4gICAgNzEwNDAgIDcxMDQw
IDEwMCUgICAgMC4xMksgICAyMjIwICAgICAgIDMyICAgICAgODg4MEsgZXZlbnRwb2xsX2VwaQo+
Pj4+Pj4KPj4+Pj4+ICAgIDY4MDk2ICA1OTI2MiAgODclICAgIDAuMDJLICAgIDI2NiAgICAgIDI1
NiAgICAgIDEwNjRLIGttYWxsb2MtMTYKPj4+Pj4+Cj4+Pj4+PiAgICA1MzY1MiAgNTM2NTIgMTAw
JSAgICAwLjA0SyAgICA1MjYgICAgICAxMDIgICAgICAyMTA0SyBwZGVfb3BlbmVyCj4+Pj4+Pgo+
Pj4+Pj4gICAgNTA0OTYgIDMxNjU0ICA2MiUgICAgMi4wMEsgICAzMTU2ICAgICAgIDE2ICAgIDEw
MDk5Mksga21hbGxvYy0yMDQ4Cj4+Pj4+Pgo+Pj4+Pj4gICAgNDYyNDIgIDQ2MjQyIDEwMCUgICAg
MC4xOUsgICAxMTAxICAgICAgIDQyICAgICAgODgwOEsgY3JlZF9qYXIKPj4+Pj4+Cj4+Pj4+PiAg
ICA0NDQ5NiAgNDMwMTMgIDk2JSAgICAwLjY2SyAgICA5MjcgICAgICAgNDggICAgIDI5NjY0Swo+
Pj4gcHJvY19pbm9kZV9jYWNoZQo+Pj4+Pj4KPj4+Pj4+ICAgIDQ0MzUyICA0NDM1MiAxMDAlICAg
IDAuMDZLICAgIDY5MyAgICAgICA2NCAgICAgIDI3NzJLCj4+PiB0YXNrX2RlbGF5X2luZm8KPj4+
Pj4+Cj4+Pj4+PiAgICA0MzUxNiAgNDM0NzEgIDk5JSAgICAwLjY5SyAgICA5NDYgICAgICAgNDYg
ICAgIDMwMjcySwo+Pj4gc29ja19pbm9kZV9jYWNoZQo+Pj4+Pj4KPj4+Pj4+ICAgIDM3ODU2ICAy
NzYyNiAgNzIlICAgIDEuMDBLICAgMTE4MyAgICAgICAzMiAgICAgMzc4NTZLIGttYWxsb2MtMTAy
NAo+Pj4+Pj4KPj4+Pj4+ICAgIDM2NzM2ICAzNjczNiAxMDAlICAgIDAuMDdLICAgIDY1NiAgICAg
ICA1NiAgICAgIDI2MjRLIGV2ZW50cG9sbF9wd3EKPj4+Pj4+Cj4+Pj4+PiAgICAzNDA3NiAgMzEy
ODIgIDkxJSAgICAwLjU3SyAgIDEyMTcgICAgICAgMjggICAgIDE5NDcySwo+Pj4gcmFkaXhfdHJl
ZV9ub2RlCj4+Pj4+Pgo+Pj4+Pj4gICAgMzM2NjAgIDMwNTI4ICA5MCUgICAgMS4wNUsgICAxMTIy
ICAgICAgIDMwICAgICAzNTkwNEsKPj4+IGV4dDRfaW5vZGVfY2FjaGUKPj4+Pj4+Cj4+Pj4+PiAg
ICAzMjc2MCAgMzA5NTkgIDk0JSAgICAwLjE5SyAgICA3ODAgICAgICAgNDIgICAgICA2MjQwSyBr
bWFsbG9jLTE5Mgo+Pj4+Pj4KPj4+Pj4+ICAgIDMyMDI4ICAzMjAyOCAxMDAlICAgIDAuMDRLICAg
IDMxNCAgICAgIDEwMiAgICAgIDEyNTZLCj4+PiBleHQ0X2V4dGVudF9zdGF0dXMKPj4+Pj4+Cj4+
Pj4+PiAgICAzMDA0OCAgMzAwNDggMTAwJSAgICAwLjI1SyAgICA5MzkgICAgICAgMzIgICAgICA3
NTEySwo+Pj4gc2tidWZmX2hlYWRfY2FjaGUKPj4+Pj4+Cj4+Pj4+PiAgICAyODczNiAgMjg3MzYg
MTAwJSAgICAwLjA2SyAgICA0NDkgICAgICAgNjQgICAgICAxNzk2SyBmc19jYWNoZQo+Pj4+Pj4K
Pj4+Pj4+ICAgIDI0NzAyICAyNDcwMiAxMDAlICAgIDAuNjlLICAgIDUzNyAgICAgICA0NiAgICAg
MTcxODRLIGZpbGVzX2NhY2hlCj4+Pj4+Pgo+Pj4+Pj4gICAgMjM4MDggIDIzODA4IDEwMCUgICAg
MC42NksgICAgNDk2ICAgICAgIDQ4ICAgICAxNTg3Mksgb3ZsX2lub2RlCj4+Pj4+Pgo+Pj4+Pj4g
ICAgMjMxMDQgIDIyOTQ1ICA5OSUgICAgMC4xMksgICAgNzIyICAgICAgIDMyICAgICAgMjg4OEsg
a21hbGxvYy0xMjgKPj4+Pj4+Cj4+Pj4+PiAgICAyMjcyNCAgMjEzMDcgIDkzJSAgICAwLjY5SyAg
ICA0OTQgICAgICAgNDYgICAgIDE1ODA4Swo+Pj4gc2htZW1faW5vZGVfY2FjaGUKPj4+Pj4+Cj4+
Pj4+PiAgICAyMTQ3MiAgMjE0NzIgMTAwJSAgICAwLjEySyAgICA2NzEgICAgICAgMzIgICAgICAy
Njg0SyBzZXFfZmlsZQo+Pj4+Pj4KPj4+Pj4+ICAgIDE5OTA0ICAxOTkwNCAxMDAlICAgIDEuMDBL
ICAgIDYyMiAgICAgICAzMiAgICAgMTk5MDRLIFVOSVgKPj4+Pj4+Cj4+Pj4+PiAgICAxNzM0MCAg
MTczNDAgMTAwJSAgICAxLjA2SyAgICA1NzggICAgICAgMzAgICAgIDE4NDk2SyBtbV9zdHJ1Y3QK
Pj4+Pj4+Cj4+Pj4+PiAgICAxNTk4MCAgMTU5ODAgMTAwJSAgICAwLjAySyAgICAgOTQgICAgICAx
NzAgICAgICAgMzc2SyBhdnRhYl9ub2RlCj4+Pj4+Pgo+Pj4+Pj4gICAgMTQwNzAgIDE0MDcwIDEw
MCUgICAgMS4wNksgICAgNDY5ICAgICAgIDMwICAgICAxNTAwOEsgc2lnbmFsX2NhY2hlCj4+Pj4+
Pgo+Pj4+Pj4gICAgMTMyNDggIDEzMjQ4IDEwMCUgICAgMC4xMksgICAgNDE0ICAgICAgIDMyICAg
ICAgMTY1NksgcGlkCj4+Pj4+Pgo+Pj4+Pj4gICAgMTIxMjggIDExNzc3ICA5NyUgICAgMC4yNUsg
ICAgMzc5ICAgICAgIDMyICAgICAgMzAzMksga21hbGxvYy0yNTYKPj4+Pj4+Cj4+Pj4+PiAgICAx
MTAwOCAgMTEwMDggMTAwJSAgICAwLjAySyAgICAgNDMgICAgICAyNTYgICAgICAgMTcySwo+Pj4+
Pj4gc2VsaW51eF9maWxlX3NlY3VyaXR5Cj4+Pj4+PiAgICAxMDgxMiAgMTA4MTIgMTAwJSAgICAw
LjA0SyAgICAxMDYgICAgICAxMDIgICAgICAgNDI0SyBBY3BpLU5hbWVzcGFjZQo+Pj4+Pj4KPj4+
Pj4+IFRoZXNlIGluZm9ybWF0aW9uIHNob3dzIHRoYXQgdGhlICdpb21tdV9pb3ZhJyBpcyB0aGUg
dG9wIG1lbW9yeQo+Pj4gY29uc3VtZXIuCj4+Pj4+PiBJbiBvcmRlciB0byBvcHRpbWl6ZSB0aGUg
bmV0d29yayBwZXJmb3JtZW5jZSBvZiBPcGVuc3RhY2sgdmlydHVhbAo+Pj4gbWFjaGluZXMsCj4+
Pj4+PiBJIGVuYWJsZWQgdGhlIHZ0LWQgZmVhdHVyZSBpbiBiaW9zIGFuZCBzcmlvdiBmZWF0dXJl
IG9mIEludGVsIDgyNTk5Cj4+PiAxMEcKPj4+Pj4+IE5JQy4gSSdtIGFzc3VtaW5nIHRoaXMgaXMg
dGhlIHJvb3QgY2F1c2Ugb2YgdGhpcyBpc3N1ZS4KPj4+Pj4+Cj4+Pj4+PiBJcyB0aGVyZSBhbnl0
aGluZyBJIGNhbiBkbyB0byBmaXggaXQ/Cj4+Pj4+Pgo+Pj4+Pgo+Pj4+Cj4+Pj4KPj4+PiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4+IGlvbW11IG1h
aWxpbmcgbGlzdAo+Pj4+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCj4+Pj4gaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXUKPj4+
Pgo+Pj4KPj4KPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
