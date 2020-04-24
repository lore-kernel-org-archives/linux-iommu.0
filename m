Return-Path: <SRS0=k0pT=6I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E704C54FCB
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 16:30:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1592063A
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 16:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1592063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C754788691;
	Fri, 24 Apr 2020 16:30:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N7DMJdws9HOs; Fri, 24 Apr 2020 16:30:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7649787D7C;
	Fri, 24 Apr 2020 16:30:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6912AC1AE2;
	Fri, 24 Apr 2020 16:30:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08E62C0175
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 16:30:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E615588516
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 16:30:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pKfC5bteOP3J for <iommu@lists.linux-foundation.org>;
 Fri, 24 Apr 2020 16:30:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id AA75A87D7C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 16:30:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA06131B;
 Fri, 24 Apr 2020 09:30:52 -0700 (PDT)
Received: from [10.57.33.170] (unknown [10.57.33.170])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A28E3F68F;
 Fri, 24 Apr 2020 09:30:52 -0700 (PDT)
Subject: Re: iommu_iova slab eats too much memory
To: Bin <anole1949@gmail.com>
References: <CAEbUFv6SHY8z2kuNFwZ4khFwgqLZjxi4-KfDv5kVANeROMU_Vw@mail.gmail.com>
 <CAEbUFv5AybVFe8Wg6ZKLaiUoUj25G_oRk+Xi_HVSvb6pTsgYzQ@mail.gmail.com>
 <CAEbUFv7YZCh5V5btB4npBLg_FcZqB01LOp_QQKM7qURmucPAqQ@mail.gmail.com>
 <562c9033-05b2-2a15-5294-f68e40c02e92@arm.com>
 <CAEbUFv5_bG7-rNFZ0R8f0ndgbc84aM_jyV8pi8wusy6qs9=hVA@mail.gmail.com>
 <CAEbUFv5mxo1TnJ7KyjpcPaefP4=3rB=_vgu8O3EHKcQQiBXo-Q@mail.gmail.com>
 <9157a31a-e6b5-4317-e50c-c69e1af094c5@arm.com>
 <CAEbUFv6yexM3nrNWMDdDV1T9QYcg7CT4nVE=eQt4C7CVYjs+fA@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e026d1e2-cf3a-a7c7-3a3d-76571e766813@arm.com>
Date: Fri, 24 Apr 2020 17:30:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAEbUFv6yexM3nrNWMDdDV1T9QYcg7CT4nVE=eQt4C7CVYjs+fA@mail.gmail.com>
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

T24gMjAyMC0wNC0yNCAyOjIwIHBtLCBCaW4gd3JvdGU6Cj4gRGVhciBSb2JpbjoKPiAgICAgIFRo
YW5rIHlvdSBmb3IgeW91ciBleHBsYW5hdGlvbi4gTm93LCBJIHVuZGVyc3RhbmQgdGhhdCB0aGlz
IGNvdWxkIGJlCj4gTklDIGRyaXZlcidzIGZhdWx0LCBidXQgaG93IGNvdWxkIEkgY29uZmlybSBp
dD8gRG8gSSBoYXZlIHRvIGRlYnVnIHRoZQo+IGRyaXZlciBteXNlbGY/CgpJJ2Qgc3RhcnQgd2l0
aCBDT05GSUdfRE1BX0FQSV9ERUJVRyAtIG9mIGNvdXJzZSBpdCB3aWxsIGNoZXcgdGhyb3VnaCAK
bWVtb3J5IGFib3V0IGFuIG9yZGVyIG9mIG1hZ25pdHVkZSBmYXN0ZXIgdGhhbiB0aGUgSU9WQXMg
YWxvbmUsIGJ1dCBpdCAKc2hvdWxkIHNoZWQgc29tZSBsaWdodCBvbiB3aGV0aGVyIERNQSBBUEkg
dXNhZ2UgbG9va3Mgc3VzcGljaW91cywgYW5kIApkdW1waW5nIHRoZSBtYXBwaW5ncyBzaG91bGQg
aGVscCB0cmFjayBkb3duIHRoZSByZXNwb25zaWJsZSBkcml2ZXIocykuIApBbHRob3VnaCB0aGUg
ZGVidWdmcyBjb2RlIGRvZXNuJ3Qgc2hvdyB0aGUgc3RhY2t0cmFjZSBvZiB3aGVyZSBlYWNoIApt
YXBwaW5nIHdhcyBtYWRlLCBJIGd1ZXNzIGl0IHdvdWxkIGJlIGZhaXJseSBzaW1wbGUgdG8gdHdl
YWsgdGhhdCBmb3IgYSAKcXVpY2sgd2F5IHRvIG5hcnJvdyBkb3duIHdoZXJlIHRvIHN0YXJ0IGxv
b2tpbmcgaW4gYW4gb2ZmZW5kaW5nIGRyaXZlci4KClJvYmluLgoKPiBSb2JpbiBNdXJwaHkgPHJv
YmluLm11cnBoeUBhcm0uY29tPiDkuo4yMDIw5bm0NOaciDI05pel5ZGo5LqUIOS4i+WNiDg6MTXl
hpnpgZPvvJoKPiAKPj4gT24gMjAyMC0wNC0yNCAxOjA2IHBtLCBCaW4gd3JvdGU6Cj4+PiBJJ20g
bm90IGZhbWlsaWFyIHdpdGggdGhlIG1tdSBzdHVmZiwgc28gd2hhdCB5b3UgbWVhbiBieSAic29t
ZSBkcml2ZXIKPj4+IGxlYWtpbmcgRE1BIG1hcHBpbmdzIiwgaXMgaXQgcG9zc2libGUgdGhhdCBz
b21lIG90aGVyIGtlcm5lbCBtb2R1bGUgbGlrZQo+Pj4gS1ZNIG9yIE5JQyBkcml2ZXIgbGVhZHMg
dG8gdGhlIGxlYWtpbmcgcHJvYmxlbSBpbnN0ZWFkIG9mIHRoZSBpb21tdQo+PiBtb2R1bGUKPj4+
IGl0c2VsZj8KPj4KPj4gWWVzIC0gSSBkb3VidCB0aGF0IGludGVsLWlvbW11IGl0c2VsZiBpcyBm
YWlsaW5nIHRvIGZyZWUgSU9WQXMgd2hlbiBpdAo+PiBzaG91bGQsIHNpbmNlIEknZCBleHBlY3Qg
YSBsb3Qgb2YgcGVvcGxlIHRvIGhhdmUgbm90aWNlZCB0aGF0LiBJdCdzIGZhcgo+PiBtb3JlIGxp
a2VseSB0aGF0IHNvbWUgZHJpdmVyIGlzIGZhaWxpbmcgdG8gY2FsbCBkbWFfdW5tYXBfKiB3aGVu
IGl0J3MKPj4gZmluaXNoZWQgd2l0aCBhIGJ1ZmZlciAtIHdpdGggdGhlIElPTU1VIGRpc2FibGVk
IHRoYXQgd291bGQgYmUgYSBuby1vcAo+PiBvbiB4ODYgd2l0aCBhIG1vZGVybiA2NC1iaXQtY2Fw
YWJsZSBkZXZpY2UsIHNvIHN1Y2ggYSBsYXRlbnQgYnVnIGNvdWxkCj4+IGhhdmUgYmVlbiBlYXNp
bHkgb3Zlcmxvb2tlZC4KPj4KPj4gUm9iaW4uCj4+Cj4+PiBCaW4gPGFub2xlMTk0OUBnbWFpbC5j
b20+IOS6jiAyMDIw5bm0NOaciDI05pel5ZGo5LqUIDIwOjAw5YaZ6YGT77yaCj4+Pgo+Pj4+IFdl
bGwsIHRoYXQncyB0aGUgcHJvYmxlbSEgSSdtIGFzc3VtaW5nIHRoZSBpb21tdSBrZXJuZWwgbW9k
dWxlIGlzCj4+IGxlYWtpbmcKPj4+PiBtZW1vcnkuIEJ1dCBJIGRvbid0IGtub3cgd2h5IGFuZCBo
b3cuCj4+Pj4KPj4+PiBEbyB5b3UgaGF2ZSBhbnkgaWRlYSBhYm91dCBpdD8gT3IgYW55IGZ1cnRo
ZXIgaW5mb3JtYXRpb24gaXMgbmVlZGVkPwo+Pj4+Cj4+Pj4gUm9iaW4gTXVycGh5IDxyb2Jpbi5t
dXJwaHlAYXJtLmNvbT4g5LqOIDIwMjDlubQ05pyIMjTml6XlkajkupQgMTk6MjDlhpnpgZPvvJoK
Pj4+Pgo+Pj4+PiBPbiAyMDIwLTA0LTI0IDE6NDAgYW0sIEJpbiB3cm90ZToKPj4+Pj4+IEhlbGxv
PyBhbnlvbmUgdGhlcmU/Cj4+Pj4+Pgo+Pj4+Pj4gQmluIDxhbm9sZTE5NDlAZ21haWwuY29tPiDk
uo4yMDIw5bm0NOaciDIz5pel5ZGo5ZubIOS4i+WNiDU6MTTlhpnpgZPvvJoKPj4+Pj4+Cj4+Pj4+
Pj4gRm9yZ2V0IHRvIG1lbnRpb24sIEkndmUgYWxyZWFkeSBkaXNhYmxlZCB0aGUgc2xhYiBtZXJn
ZSwgc28gdGhpcyBpcwo+Pj4+PiB3aGF0Cj4+Pj4+Pj4gaXQgaXMuCj4+Pj4+Pj4KPj4+Pj4+PiBC
aW4gPGFub2xlMTk0OUBnbWFpbC5jb20+IOS6jjIwMjDlubQ05pyIMjPml6Xlkajlm5sg5LiL5Y2I
NToxMeWGmemBk++8mgo+Pj4+Pj4+Cj4+Pj4+Pj4+IEhleSwgZ3V5czoKPj4+Pj4+Pj4KPj4+Pj4+
Pj4gSSdtIHJ1bm5pbmcgYSBiYXRjaCBvZiBDb3JlT1MgYm94ZXMsIHRoZSBsc2JfcmVsZWFzZSBp
czoKPj4+Pj4+Pj4KPj4+Pj4+Pj4gYGBgCj4+Pj4+Pj4+ICMgY2F0IC9ldGMvbHNiLXJlbGVhc2UK
Pj4+Pj4+Pj4gRElTVFJJQl9JRD0iQ29udGFpbmVyIExpbnV4IGJ5IENvcmVPUyIKPj4+Pj4+Pj4g
RElTVFJJQl9SRUxFQVNFPTIzMDMuMy4wCj4+Pj4+Pj4+IERJU1RSSUJfQ09ERU5BTUU9IlJoeW9s
aXRlIgo+Pj4+Pj4+PiBESVNUUklCX0RFU0NSSVBUSU9OPSJDb250YWluZXIgTGludXggYnkgQ29y
ZU9TIDIzMDMuMy4wIChSaHlvbGl0ZSkiCj4+Pj4+Pj4+IGBgYAo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBg
YGAKPj4+Pj4+Pj4gIyB1bmFtZSAtYQo+Pj4+Pj4+PiBMaW51eCBjbG91ZC13b3JrZXItMjUgNC4x
OS44Ni1jb3Jlb3MgIzEgU01QIE1vbiBEZWMgMiAyMDoxMzozOCAtMDAKPj4+Pj4gMjAxOQo+Pj4+
Pj4+PiB4ODZfNjQgSW50ZWwoUikgWGVvbihSKSBDUFUgRTUtMjY0MCB2MiBAIDIuMDBHSHogR2Vu
dWluZUludGVsCj4+Pj4+IEdOVS9MaW51eAo+Pj4+Pj4+PiBgYGAKPj4+Pj4+Pj4gUmVjZW50bHks
IEkgZm91bmQgbXkgdm1zIGNvbnN0ZW50bHkgYmVpbmcga2lsbGVkIGR1ZSB0byBPT00sIGFuZAo+
PiBhZnRlcgo+Pj4+Pj4+PiBkaWdnaW5nIGludG8gdGhlIHByb2JsZW0sIEkgZmluYWxseSByZWFs
aXplZCB0aGF0IHRoZSBrZXJuZWwgaXMKPj4+Pj4gbGVha2luZwo+Pj4+Pj4+PiBtZW1vcnkuCj4+
Pj4+Pj4+Cj4+Pj4+Pj4+IEhlcmUncyBteSBzbGFiaW5mbzoKPj4+Pj4+Pj4KPj4+Pj4+Pj4gICAg
IEFjdGl2ZSAvIFRvdGFsIE9iamVjdHMgKCUgdXNlZCkgICAgOiA4MzgxODMwNiAvIDg0MTkxNjA3
ICg5OS42JSkKPj4+Pj4+Pj4gICAgIEFjdGl2ZSAvIFRvdGFsIFNsYWJzICglIHVzZWQpICAgICAg
OiAxMzM2MjkzIC8gMTMzNjI5MyAoMTAwLjAlKQo+Pj4+Pj4+PiAgICAgQWN0aXZlIC8gVG90YWwg
Q2FjaGVzICglIHVzZWQpICAgICA6IDE1MiAvIDIxNyAoNzAuMCUpCj4+Pj4+Pj4+ICAgICBBY3Rp
dmUgLyBUb3RhbCBTaXplICglIHVzZWQpICAgICAgIDogNTgyODc2OC4wOEsgLyA1OTk2ODQ4Ljcy
Swo+Pj4+PiAoOTcuMiUpCj4+Pj4+Pj4+ICAgICBNaW5pbXVtIC8gQXZlcmFnZSAvIE1heGltdW0g
T2JqZWN0IDogMC4wMUsgLyAwLjA3SyAvIDIzLjI1Swo+Pj4+Pj4+Pgo+Pj4+Pj4+PiAgICAgIE9C
SlMgQUNUSVZFICBVU0UgT0JKIFNJWkUgIFNMQUJTIE9CSi9TTEFCIENBQ0hFIFNJWkUgTkFNRQo+
Pj4+Pj4+Pgo+Pj4+Pj4+PiA4MDI1Mzg4OCA4MDI1Mzg4OCAxMDAlICAgIDAuMDZLIDEyNTM5Njcg
ICAgICAgNjQgICA1MDE1ODY4Swo+PiBpb21tdV9pb3ZhCj4+Pj4+Cj4+Pj4+IERvIHlvdSByZWFs
bHkgaGF2ZSBhIHBlYWsgZGVtYW5kIG9mIH44MCBtaWxsaW9uIHNpbXVsdGFuZW91cyBETUEKPj4+
Pj4gYnVmZmVycywgb3IgaXMgc29tZSBkcml2ZXIgbGVha2luZyBETUEgbWFwcGluZ3M/Cj4+Pj4+
Cj4+Pj4+IFJvYmluLgo+Pj4+Pgo+Pj4+Pj4+PiA0ODk0NzIgNDg5MTIzICA5OSUgICAgMC4wM0sg
ICAzODI0ICAgICAgMTI4ICAgICAxNTI5Nksga21hbGxvYy0zMgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiAy
OTc0NDQgMjcxMTEyICA5MSUgICAgMC4xOUsgICA3MDgyICAgICAgIDQyICAgICA1NjY1NksgZGVu
dHJ5Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IDI1NDQwMCAyNTI3ODQgIDk5JSAgICAwLjA2SyAgIDM5NzUg
ICAgICAgNjQgICAgIDE1OTAwSwo+PiBhbm9uX3ZtYV9jaGFpbgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiAy
MjI1MjggIDM5MjU1ICAxNyUgICAgMC41MEsgICA2OTU0ICAgICAgIDMyICAgIDExMTI2NEsga21h
bGxvYy01MTIKPj4+Pj4+Pj4KPj4+Pj4+Pj4gMjAyNDgyIDIwMTgxNCAgOTklICAgIDAuMTlLICAg
NDgyMSAgICAgICA0MiAgICAgMzg1NjhLCj4+IHZtX2FyZWFfc3RydWN0Cj4+Pj4+Pj4+Cj4+Pj4+
Pj4+IDIwMDE5MiAyMDAxOTIgMTAwJSAgICAwLjAxSyAgICAzOTEgICAgICA1MTIgICAgICAxNTY0
SyBrbWFsbG9jLTgKPj4+Pj4+Pj4KPj4+Pj4+Pj4gMTcwNTI4IDE2OTM1OSAgOTklICAgIDAuMjVL
ICAgNTMyOSAgICAgICAzMiAgICAgNDI2MzJLIGZpbHAKPj4+Pj4+Pj4KPj4+Pj4+Pj4gMTU4MTQ0
IDE1MzUwOCAgOTclICAgIDAuMDZLICAgMjQ3MSAgICAgICA2NCAgICAgIDk4ODRLIGttYWxsb2Mt
NjQKPj4+Pj4+Pj4KPj4+Pj4+Pj4gMTQ5OTE0IDE0OTM2NSAgOTklICAgIDAuMDlLICAgMzI1OSAg
ICAgICA0NiAgICAgMTMwMzZLIGFub25fdm1hCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IDE0NjY0MCAxNDMx
MjMgIDk3JSAgICAwLjEwSyAgIDM3NjAgICAgICAgMzkgICAgIDE1MDQwSyBidWZmZXJfaGVhZAo+
Pj4+Pj4+Pgo+Pj4+Pj4+PiAxMzAzNjggIDMyNzkxICAyNSUgICAgMC4wOUsgICAzMTA0ICAgICAg
IDQyICAgICAxMjQxNksga21hbGxvYy05Ngo+Pj4+Pj4+Pgo+Pj4+Pj4+PiAxMjk3NTIgMTI5NzUy
IDEwMCUgICAgMC4wN0sgICAyMzE3ICAgICAgIDU2ICAgICAgOTI2OEsgQWNwaS1PcGVyYW5kCj4+
Pj4+Pj4+Cj4+Pj4+Pj4+IDEwNTQ2OCAxMDUxMDYgIDk5JSAgICAwLjA0SyAgIDEwMzQgICAgICAx
MDIgICAgICA0MTM2Swo+Pj4+Pj4+PiBzZWxpbnV4X2lub2RlX3NlY3VyaXR5Cj4+Pj4+Pj4+ICAg
ICA3MzA4MCAgNzMwODAgMTAwJSAgICAwLjEzSyAgIDI0MzYgICAgICAgMzAgICAgICA5NzQ0Swo+
Pj4+PiBrZXJuZnNfbm9kZV9jYWNoZQo+Pj4+Pj4+Pgo+Pj4+Pj4+PiAgICAgNzIzNjAgIDcwMjYx
ICA5NyUgICAgMC41OUsgICAxMzQwICAgICAgIDU0ICAgICA0Mjg4MEsgaW5vZGVfY2FjaGUKPj4+
Pj4+Pj4KPj4+Pj4+Pj4gICAgIDcxMDQwICA3MTA0MCAxMDAlICAgIDAuMTJLICAgMjIyMCAgICAg
ICAzMiAgICAgIDg4ODBLCj4+IGV2ZW50cG9sbF9lcGkKPj4+Pj4+Pj4KPj4+Pj4+Pj4gICAgIDY4
MDk2ICA1OTI2MiAgODclICAgIDAuMDJLICAgIDI2NiAgICAgIDI1NiAgICAgIDEwNjRLIGttYWxs
b2MtMTYKPj4+Pj4+Pj4KPj4+Pj4+Pj4gICAgIDUzNjUyICA1MzY1MiAxMDAlICAgIDAuMDRLICAg
IDUyNiAgICAgIDEwMiAgICAgIDIxMDRLIHBkZV9vcGVuZXIKPj4+Pj4+Pj4KPj4+Pj4+Pj4gICAg
IDUwNDk2ICAzMTY1NCAgNjIlICAgIDIuMDBLICAgMzE1NiAgICAgICAxNiAgICAxMDA5OTJLCj4+
IGttYWxsb2MtMjA0OAo+Pj4+Pj4+Pgo+Pj4+Pj4+PiAgICAgNDYyNDIgIDQ2MjQyIDEwMCUgICAg
MC4xOUsgICAxMTAxICAgICAgIDQyICAgICAgODgwOEsgY3JlZF9qYXIKPj4+Pj4+Pj4KPj4+Pj4+
Pj4gICAgIDQ0NDk2ICA0MzAxMyAgOTYlICAgIDAuNjZLICAgIDkyNyAgICAgICA0OCAgICAgMjk2
NjRLCj4+Pj4+IHByb2NfaW5vZGVfY2FjaGUKPj4+Pj4+Pj4KPj4+Pj4+Pj4gICAgIDQ0MzUyICA0
NDM1MiAxMDAlICAgIDAuMDZLICAgIDY5MyAgICAgICA2NCAgICAgIDI3NzJLCj4+Pj4+IHRhc2tf
ZGVsYXlfaW5mbwo+Pj4+Pj4+Pgo+Pj4+Pj4+PiAgICAgNDM1MTYgIDQzNDcxICA5OSUgICAgMC42
OUsgICAgOTQ2ICAgICAgIDQ2ICAgICAzMDI3MksKPj4+Pj4gc29ja19pbm9kZV9jYWNoZQo+Pj4+
Pj4+Pgo+Pj4+Pj4+PiAgICAgMzc4NTYgIDI3NjI2ICA3MiUgICAgMS4wMEsgICAxMTgzICAgICAg
IDMyICAgICAzNzg1NksKPj4ga21hbGxvYy0xMDI0Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+ICAgICAzNjcz
NiAgMzY3MzYgMTAwJSAgICAwLjA3SyAgICA2NTYgICAgICAgNTYgICAgICAyNjI0Swo+PiBldmVu
dHBvbGxfcHdxCj4+Pj4+Pj4+Cj4+Pj4+Pj4+ICAgICAzNDA3NiAgMzEyODIgIDkxJSAgICAwLjU3
SyAgIDEyMTcgICAgICAgMjggICAgIDE5NDcySwo+Pj4+PiByYWRpeF90cmVlX25vZGUKPj4+Pj4+
Pj4KPj4+Pj4+Pj4gICAgIDMzNjYwICAzMDUyOCAgOTAlICAgIDEuMDVLICAgMTEyMiAgICAgICAz
MCAgICAgMzU5MDRLCj4+Pj4+IGV4dDRfaW5vZGVfY2FjaGUKPj4+Pj4+Pj4KPj4+Pj4+Pj4gICAg
IDMyNzYwICAzMDk1OSAgOTQlICAgIDAuMTlLICAgIDc4MCAgICAgICA0MiAgICAgIDYyNDBLIGtt
YWxsb2MtMTkyCj4+Pj4+Pj4+Cj4+Pj4+Pj4+ICAgICAzMjAyOCAgMzIwMjggMTAwJSAgICAwLjA0
SyAgICAzMTQgICAgICAxMDIgICAgICAxMjU2Swo+Pj4+PiBleHQ0X2V4dGVudF9zdGF0dXMKPj4+
Pj4+Pj4KPj4+Pj4+Pj4gICAgIDMwMDQ4ICAzMDA0OCAxMDAlICAgIDAuMjVLICAgIDkzOSAgICAg
ICAzMiAgICAgIDc1MTJLCj4+Pj4+IHNrYnVmZl9oZWFkX2NhY2hlCj4+Pj4+Pj4+Cj4+Pj4+Pj4+
ICAgICAyODczNiAgMjg3MzYgMTAwJSAgICAwLjA2SyAgICA0NDkgICAgICAgNjQgICAgICAxNzk2
SyBmc19jYWNoZQo+Pj4+Pj4+Pgo+Pj4+Pj4+PiAgICAgMjQ3MDIgIDI0NzAyIDEwMCUgICAgMC42
OUsgICAgNTM3ICAgICAgIDQ2ICAgICAxNzE4NEsgZmlsZXNfY2FjaGUKPj4+Pj4+Pj4KPj4+Pj4+
Pj4gICAgIDIzODA4ICAyMzgwOCAxMDAlICAgIDAuNjZLICAgIDQ5NiAgICAgICA0OCAgICAgMTU4
NzJLIG92bF9pbm9kZQo+Pj4+Pj4+Pgo+Pj4+Pj4+PiAgICAgMjMxMDQgIDIyOTQ1ICA5OSUgICAg
MC4xMksgICAgNzIyICAgICAgIDMyICAgICAgMjg4OEsga21hbGxvYy0xMjgKPj4+Pj4+Pj4KPj4+
Pj4+Pj4gICAgIDIyNzI0ICAyMTMwNyAgOTMlICAgIDAuNjlLICAgIDQ5NCAgICAgICA0NiAgICAg
MTU4MDhLCj4+Pj4+IHNobWVtX2lub2RlX2NhY2hlCj4+Pj4+Pj4+Cj4+Pj4+Pj4+ICAgICAyMTQ3
MiAgMjE0NzIgMTAwJSAgICAwLjEySyAgICA2NzEgICAgICAgMzIgICAgICAyNjg0SyBzZXFfZmls
ZQo+Pj4+Pj4+Pgo+Pj4+Pj4+PiAgICAgMTk5MDQgIDE5OTA0IDEwMCUgICAgMS4wMEsgICAgNjIy
ICAgICAgIDMyICAgICAxOTkwNEsgVU5JWAo+Pj4+Pj4+Pgo+Pj4+Pj4+PiAgICAgMTczNDAgIDE3
MzQwIDEwMCUgICAgMS4wNksgICAgNTc4ICAgICAgIDMwICAgICAxODQ5NksgbW1fc3RydWN0Cj4+
Pj4+Pj4+Cj4+Pj4+Pj4+ICAgICAxNTk4MCAgMTU5ODAgMTAwJSAgICAwLjAySyAgICAgOTQgICAg
ICAxNzAgICAgICAgMzc2SyBhdnRhYl9ub2RlCj4+Pj4+Pj4+Cj4+Pj4+Pj4+ICAgICAxNDA3MCAg
MTQwNzAgMTAwJSAgICAxLjA2SyAgICA0NjkgICAgICAgMzAgICAgIDE1MDA4Swo+PiBzaWduYWxf
Y2FjaGUKPj4+Pj4+Pj4KPj4+Pj4+Pj4gICAgIDEzMjQ4ICAxMzI0OCAxMDAlICAgIDAuMTJLICAg
IDQxNCAgICAgICAzMiAgICAgIDE2NTZLIHBpZAo+Pj4+Pj4+Pgo+Pj4+Pj4+PiAgICAgMTIxMjgg
IDExNzc3ICA5NyUgICAgMC4yNUsgICAgMzc5ICAgICAgIDMyICAgICAgMzAzMksga21hbGxvYy0y
NTYKPj4+Pj4+Pj4KPj4+Pj4+Pj4gICAgIDExMDA4ICAxMTAwOCAxMDAlICAgIDAuMDJLICAgICA0
MyAgICAgIDI1NiAgICAgICAxNzJLCj4+Pj4+Pj4+IHNlbGludXhfZmlsZV9zZWN1cml0eQo+Pj4+
Pj4+PiAgICAgMTA4MTIgIDEwODEyIDEwMCUgICAgMC4wNEsgICAgMTA2ICAgICAgMTAyICAgICAg
IDQyNEsKPj4gQWNwaS1OYW1lc3BhY2UKPj4+Pj4+Pj4KPj4+Pj4+Pj4gVGhlc2UgaW5mb3JtYXRp
b24gc2hvd3MgdGhhdCB0aGUgJ2lvbW11X2lvdmEnIGlzIHRoZSB0b3AgbWVtb3J5Cj4+Pj4+IGNv
bnN1bWVyLgo+Pj4+Pj4+PiBJbiBvcmRlciB0byBvcHRpbWl6ZSB0aGUgbmV0d29yayBwZXJmb3Jt
ZW5jZSBvZiBPcGVuc3RhY2sgdmlydHVhbAo+Pj4+PiBtYWNoaW5lcywKPj4+Pj4+Pj4gSSBlbmFi
bGVkIHRoZSB2dC1kIGZlYXR1cmUgaW4gYmlvcyBhbmQgc3Jpb3YgZmVhdHVyZSBvZiBJbnRlbCA4
MjU5OQo+Pj4+PiAxMEcKPj4+Pj4+Pj4gTklDLiBJJ20gYXNzdW1pbmcgdGhpcyBpcyB0aGUgcm9v
dCBjYXVzZSBvZiB0aGlzIGlzc3VlLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBJcyB0aGVyZSBhbnl0aGlu
ZyBJIGNhbiBkbyB0byBmaXggaXQ/Cj4+Pj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+Pgo+Pj4+
Pj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+Pj4+
IGlvbW11IG1haWxpbmcgbGlzdAo+Pj4+Pj4gaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKPj4+Pj4+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11Cj4+Pj4+Pgo+Pj4+Pgo+Pj4+Cj4+Pgo+Pgo+IApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
