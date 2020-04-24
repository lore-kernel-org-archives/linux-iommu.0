Return-Path: <SRS0=k0pT=6I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F07C54FCB
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 17:50:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4716320736
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 17:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4716320736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1B16A86783;
	Fri, 24 Apr 2020 17:50:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id buB9cU6fhnEJ; Fri, 24 Apr 2020 17:50:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 34008863A4;
	Fri, 24 Apr 2020 17:50:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2736AC089E;
	Fri, 24 Apr 2020 17:50:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 590F1C0175
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 17:50:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 47A8187723
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 17:50:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t3uzNezK5Lfg for <iommu@lists.linux-foundation.org>;
 Fri, 24 Apr 2020 17:50:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2B45D86030
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 17:50:15 +0000 (UTC)
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
 by Forcepoint Email with ESMTP id 9DFD478064D71CA4CB50;
 Fri, 24 Apr 2020 18:50:12 +0100 (IST)
Received: from [127.0.0.1] (10.47.6.64) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 24 Apr
 2020 18:50:11 +0100
Subject: Re: iommu_iova slab eats too much memory
To: Robin Murphy <robin.murphy@arm.com>, Bin <anole1949@gmail.com>
References: <CAEbUFv6SHY8z2kuNFwZ4khFwgqLZjxi4-KfDv5kVANeROMU_Vw@mail.gmail.com>
 <CAEbUFv5AybVFe8Wg6ZKLaiUoUj25G_oRk+Xi_HVSvb6pTsgYzQ@mail.gmail.com>
 <CAEbUFv7YZCh5V5btB4npBLg_FcZqB01LOp_QQKM7qURmucPAqQ@mail.gmail.com>
 <562c9033-05b2-2a15-5294-f68e40c02e92@arm.com>
 <CAEbUFv5_bG7-rNFZ0R8f0ndgbc84aM_jyV8pi8wusy6qs9=hVA@mail.gmail.com>
 <CAEbUFv5mxo1TnJ7KyjpcPaefP4=3rB=_vgu8O3EHKcQQiBXo-Q@mail.gmail.com>
 <9157a31a-e6b5-4317-e50c-c69e1af094c5@arm.com>
 <CAEbUFv6yexM3nrNWMDdDV1T9QYcg7CT4nVE=eQt4C7CVYjs+fA@mail.gmail.com>
 <e026d1e2-cf3a-a7c7-3a3d-76571e766813@arm.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <70d663d7-a3c7-44f3-bea6-1c300566ec1f@huawei.com>
Date: Fri, 24 Apr 2020 18:49:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <e026d1e2-cf3a-a7c7-3a3d-76571e766813@arm.com>
Content-Language: en-US
X-Originating-IP: [10.47.6.64]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

T24gMjQvMDQvMjAyMCAxNzozMCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjAtMDQtMjQg
MjoyMCBwbSwgQmluIHdyb3RlOgo+PiBEZWFyIFJvYmluOgo+PiAgICAgICBUaGFuayB5b3UgZm9y
IHlvdXIgZXhwbGFuYXRpb24uIE5vdywgSSB1bmRlcnN0YW5kIHRoYXQgdGhpcyBjb3VsZCBiZQo+
PiBOSUMgZHJpdmVyJ3MgZmF1bHQsIGJ1dCBob3cgY291bGQgSSBjb25maXJtIGl0PyBEbyBJIGhh
dmUgdG8gZGVidWcgdGhlCj4+IGRyaXZlciBteXNlbGY/Cj4gCj4gSSdkIHN0YXJ0IHdpdGggQ09O
RklHX0RNQV9BUElfREVCVUcgLSBvZiBjb3Vyc2UgaXQgd2lsbCBjaGV3IHRocm91Z2gKPiBtZW1v
cnkgYWJvdXQgYW4gb3JkZXIgb2YgbWFnbml0dWRlIGZhc3RlciB0aGFuIHRoZSBJT1ZBcyBhbG9u
ZSwgYnV0IGl0Cj4gc2hvdWxkIHNoZWQgc29tZSBsaWdodCBvbiB3aGV0aGVyIERNQSBBUEkgdXNh
Z2UgbG9va3Mgc3VzcGljaW91cywgYW5kCj4gZHVtcGluZyB0aGUgbWFwcGluZ3Mgc2hvdWxkIGhl
bHAgdHJhY2sgZG93biB0aGUgcmVzcG9uc2libGUgZHJpdmVyKHMpLgo+IEFsdGhvdWdoIHRoZSBk
ZWJ1Z2ZzIGNvZGUgZG9lc24ndCBzaG93IHRoZSBzdGFja3RyYWNlIG9mIHdoZXJlIGVhY2gKPiBt
YXBwaW5nIHdhcyBtYWRlLCBJIGd1ZXNzIGl0IHdvdWxkIGJlIGZhaXJseSBzaW1wbGUgdG8gdHdl
YWsgdGhhdCBmb3IgYQo+IHF1aWNrIHdheSB0byBuYXJyb3cgZG93biB3aGVyZSB0byBzdGFydCBs
b29raW5nIGluIGFuIG9mZmVuZGluZyBkcml2ZXIuCj4gCj4gUm9iaW4uCgpKdXN0IG1lbnRpb25p
bmcgdGhpcyBpbiBjYXNlIGl0J3MgcmVsZXZhbnQgLSB3ZSBmb3VuZCBsb25nIHRlcm0gYWdpbmcg
CnRocm91Z2hwdXQgdGVzdCBjYXVzZXMgUkIgdHJlZSB0byBncm93IHZlcnkgbGFyZ2UgKGFuZCB3
b3VsZCBJIGFzc3VtZSAKZWF0IGxvdHMgb2YgbWVtb3J5KToKCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LWlvbW11LzIwMTkwODE1MTIxMTA0LjI5MTQwLTMtdGh1bmRlci5sZWl6aGVuQGh1
YXdlaS5jb20vCgpKb2huCgo+IAo+PiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29t
PiDkuo4yMDIw5bm0NOaciDI05pel5ZGo5LqUIOS4i+WNiDg6MTXlhpnpgZPvvJoKPj4KPj4+IE9u
IDIwMjAtMDQtMjQgMTowNiBwbSwgQmluIHdyb3RlOgo+Pj4+IEknbSBub3QgZmFtaWxpYXIgd2l0
aCB0aGUgbW11IHN0dWZmLCBzbyB3aGF0IHlvdSBtZWFuIGJ5ICJzb21lIGRyaXZlcgo+Pj4+IGxl
YWtpbmcgRE1BIG1hcHBpbmdzIiwgaXMgaXQgcG9zc2libGUgdGhhdCBzb21lIG90aGVyIGtlcm5l
bCBtb2R1bGUgbGlrZQo+Pj4+IEtWTSBvciBOSUMgZHJpdmVyIGxlYWRzIHRvIHRoZSBsZWFraW5n
IHByb2JsZW0gaW5zdGVhZCBvZiB0aGUgaW9tbXUKPj4+IG1vZHVsZQo+Pj4+IGl0c2VsZj8KPj4+
Cj4+PiBZZXMgLSBJIGRvdWJ0IHRoYXQgaW50ZWwtaW9tbXUgaXRzZWxmIGlzIGZhaWxpbmcgdG8g
ZnJlZSBJT1ZBcyB3aGVuIGl0Cj4+PiBzaG91bGQsIHNpbmNlIEknZCBleHBlY3QgYSBsb3Qgb2Yg
cGVvcGxlIHRvIGhhdmUgbm90aWNlZCB0aGF0LiBJdCdzIGZhcgo+Pj4gbW9yZSBsaWtlbHkgdGhh
dCBzb21lIGRyaXZlciBpcyBmYWlsaW5nIHRvIGNhbGwgZG1hX3VubWFwXyogd2hlbiBpdCdzCj4+
PiBmaW5pc2hlZCB3aXRoIGEgYnVmZmVyIC0gd2l0aCB0aGUgSU9NTVUgZGlzYWJsZWQgdGhhdCB3
b3VsZCBiZSBhIG5vLW9wCj4+PiBvbiB4ODYgd2l0aCBhIG1vZGVybiA2NC1iaXQtY2FwYWJsZSBk
ZXZpY2UsIHNvIHN1Y2ggYSBsYXRlbnQgYnVnIGNvdWxkCj4+PiBoYXZlIGJlZW4gZWFzaWx5IG92
ZXJsb29rZWQuCj4+Pgo+Pj4gUm9iaW4uCj4+Pgo+Pj4+IEJpbiA8YW5vbGUxOTQ5QGdtYWlsLmNv
bT4g5LqOIDIwMjDlubQ05pyIMjTml6XlkajkupQgMjA6MDDlhpnpgZPvvJoKPj4+Pgo+Pj4+PiBX
ZWxsLCB0aGF0J3MgdGhlIHByb2JsZW0hIEknbSBhc3N1bWluZyB0aGUgaW9tbXUga2VybmVsIG1v
ZHVsZSBpcwo+Pj4gbGVha2luZwo+Pj4+PiBtZW1vcnkuIEJ1dCBJIGRvbid0IGtub3cgd2h5IGFu
ZCBob3cuCj4+Pj4+Cj4+Pj4+IERvIHlvdSBoYXZlIGFueSBpZGVhIGFib3V0IGl0PyBPciBhbnkg
ZnVydGhlciBpbmZvcm1hdGlvbiBpcyBuZWVkZWQ/Cj4+Pj4+Cj4+Pj4+IFJvYmluIE11cnBoeSA8
cm9iaW4ubXVycGh5QGFybS5jb20+IOS6jiAyMDIw5bm0NOaciDI05pel5ZGo5LqUIDE5OjIw5YaZ
6YGT77yaCj4+Pj4+Cj4+Pj4+PiBPbiAyMDIwLTA0LTI0IDE6NDAgYW0sIEJpbiB3cm90ZToKPj4+
Pj4+PiBIZWxsbz8gYW55b25lIHRoZXJlPwo+Pj4+Pj4+Cj4+Pj4+Pj4gQmluIDxhbm9sZTE5NDlA
Z21haWwuY29tPiDkuo4yMDIw5bm0NOaciDIz5pel5ZGo5ZubIOS4i+WNiDU6MTTlhpnpgZPvvJoK
Pj4+Pj4+Pgo+Pj4+Pj4+PiBGb3JnZXQgdG8gbWVudGlvbiwgSSd2ZSBhbHJlYWR5IGRpc2FibGVk
IHRoZSBzbGFiIG1lcmdlLCBzbyB0aGlzIGlzCj4+Pj4+PiB3aGF0Cj4+Pj4+Pj4+IGl0IGlzLgo+
Pj4+Pj4+Pgo+Pj4+Pj4+PiBCaW4gPGFub2xlMTk0OUBnbWFpbC5jb20+IOS6jjIwMjDlubQ05pyI
MjPml6Xlkajlm5sg5LiL5Y2INToxMeWGmemBk++8mgo+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gSGV5LCBn
dXlzOgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IEknbSBydW5uaW5nIGEgYmF0Y2ggb2YgQ29yZU9TIGJv
eGVzLCB0aGUgbHNiX3JlbGVhc2UgaXM6Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gYGBgCj4+Pj4+Pj4+
PiAjIGNhdCAvZXRjL2xzYi1yZWxlYXNlCj4+Pj4+Pj4+PiBESVNUUklCX0lEPSJDb250YWluZXIg
TGludXggYnkgQ29yZU9TIgo+Pj4+Pj4+Pj4gRElTVFJJQl9SRUxFQVNFPTIzMDMuMy4wCj4+Pj4+
Pj4+PiBESVNUUklCX0NPREVOQU1FPSJSaHlvbGl0ZSIKPj4+Pj4+Pj4+IERJU1RSSUJfREVTQ1JJ
UFRJT049IkNvbnRhaW5lciBMaW51eCBieSBDb3JlT1MgMjMwMy4zLjAgKFJoeW9saXRlKSIKPj4+
Pj4+Pj4+IGBgYAo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IGBgYAo+Pj4+Pj4+Pj4gIyB1bmFtZSAtYQo+
Pj4+Pj4+Pj4gTGludXggY2xvdWQtd29ya2VyLTI1IDQuMTkuODYtY29yZW9zICMxIFNNUCBNb24g
RGVjIDIgMjA6MTM6MzggLTAwCj4+Pj4+PiAyMDE5Cj4+Pj4+Pj4+PiB4ODZfNjQgSW50ZWwoUikg
WGVvbihSKSBDUFUgRTUtMjY0MCB2MiBAIDIuMDBHSHogR2VudWluZUludGVsCj4+Pj4+PiBHTlUv
TGludXgKPj4+Pj4+Pj4+IGBgYAo+Pj4+Pj4+Pj4gUmVjZW50bHksIEkgZm91bmQgbXkgdm1zIGNv
bnN0ZW50bHkgYmVpbmcga2lsbGVkIGR1ZSB0byBPT00sIGFuZAo+Pj4gYWZ0ZXIKPj4+Pj4+Pj4+
IGRpZ2dpbmcgaW50byB0aGUgcHJvYmxlbSwgSSBmaW5hbGx5IHJlYWxpemVkIHRoYXQgdGhlIGtl
cm5lbCBpcwo+Pj4+Pj4gbGVha2luZwo+Pj4+Pj4+Pj4gbWVtb3J5Lgo+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+IEhlcmUncyBteSBzbGFiaW5mbzoKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiAgICAgIEFjdGl2ZSAv
IFRvdGFsIE9iamVjdHMgKCUgdXNlZCkgICAgOiA4MzgxODMwNiAvIDg0MTkxNjA3ICg5OS42JSkK
Pj4+Pj4+Pj4+ICAgICAgQWN0aXZlIC8gVG90YWwgU2xhYnMgKCUgdXNlZCkgICAgICA6IDEzMzYy
OTMgLyAxMzM2MjkzICgxMDAuMCUpCj4+Pj4+Pj4+PiAgICAgIEFjdGl2ZSAvIFRvdGFsIENhY2hl
cyAoJSB1c2VkKSAgICAgOiAxNTIgLyAyMTcgKDcwLjAlKQo+Pj4+Pj4+Pj4gICAgICBBY3RpdmUg
LyBUb3RhbCBTaXplICglIHVzZWQpICAgICAgIDogNTgyODc2OC4wOEsgLyA1OTk2ODQ4LjcySwo+
Pj4+Pj4gKDk3LjIlKQo+Pj4+Pj4+Pj4gICAgICBNaW5pbXVtIC8gQXZlcmFnZSAvIE1heGltdW0g
T2JqZWN0IDogMC4wMUsgLyAwLjA3SyAvIDIzLjI1Swo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+ICAgICAg
IE9CSlMgQUNUSVZFICBVU0UgT0JKIFNJWkUgIFNMQUJTIE9CSi9TTEFCIENBQ0hFIFNJWkUgTkFN
RQo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IDgwMjUzODg4IDgwMjUzODg4IDEwMCUgICAgMC4wNksgMTI1
Mzk2NyAgICAgICA2NCAgIDUwMTU4NjhLCj4+PiBpb21tdV9pb3ZhCj4+Pj4+Pgo+Pj4+Pj4gRG8g
eW91IHJlYWxseSBoYXZlIGEgcGVhayBkZW1hbmQgb2YgfjgwIG1pbGxpb24gc2ltdWx0YW5lb3Vz
IERNQQo+Pj4+Pj4gYnVmZmVycywgb3IgaXMgc29tZSBkcml2ZXIgbGVha2luZyBETUEgbWFwcGlu
Z3M/Cj4+Pj4+Pgo+Pj4+Pj4gUm9iaW4uCj4+Pj4+Pgo+Pj4+Pj4+Pj4gNDg5NDcyIDQ4OTEyMyAg
OTklICAgIDAuMDNLICAgMzgyNCAgICAgIDEyOCAgICAgMTUyOTZLIGttYWxsb2MtMzIKPj4+Pj4+
Pj4+Cj4+Pj4+Pj4+PiAyOTc0NDQgMjcxMTEyICA5MSUgICAgMC4xOUsgICA3MDgyICAgICAgIDQy
ICAgICA1NjY1NksgZGVudHJ5Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gMjU0NDAwIDI1Mjc4NCAgOTkl
ICAgIDAuMDZLICAgMzk3NSAgICAgICA2NCAgICAgMTU5MDBLCj4+PiBhbm9uX3ZtYV9jaGFpbgo+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IDIyMjUyOCAgMzkyNTUgIDE3JSAgICAwLjUwSyAgIDY5NTQgICAg
ICAgMzIgICAgMTExMjY0SyBrbWFsbG9jLTUxMgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IDIwMjQ4MiAy
MDE4MTQgIDk5JSAgICAwLjE5SyAgIDQ4MjEgICAgICAgNDIgICAgIDM4NTY4Swo+Pj4gdm1fYXJl
YV9zdHJ1Y3QKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiAyMDAxOTIgMjAwMTkyIDEwMCUgICAgMC4wMUsg
ICAgMzkxICAgICAgNTEyICAgICAgMTU2NEsga21hbGxvYy04Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4g
MTcwNTI4IDE2OTM1OSAgOTklICAgIDAuMjVLICAgNTMyOSAgICAgICAzMiAgICAgNDI2MzJLIGZp
bHAKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiAxNTgxNDQgMTUzNTA4ICA5NyUgICAgMC4wNksgICAyNDcx
ICAgICAgIDY0ICAgICAgOTg4NEsga21hbGxvYy02NAo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IDE0OTkx
NCAxNDkzNjUgIDk5JSAgICAwLjA5SyAgIDMyNTkgICAgICAgNDYgICAgIDEzMDM2SyBhbm9uX3Zt
YQo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IDE0NjY0MCAxNDMxMjMgIDk3JSAgICAwLjEwSyAgIDM3NjAg
ICAgICAgMzkgICAgIDE1MDQwSyBidWZmZXJfaGVhZAo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IDEzMDM2
OCAgMzI3OTEgIDI1JSAgICAwLjA5SyAgIDMxMDQgICAgICAgNDIgICAgIDEyNDE2SyBrbWFsbG9j
LTk2Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gMTI5NzUyIDEyOTc1MiAxMDAlICAgIDAuMDdLICAgMjMx
NyAgICAgICA1NiAgICAgIDkyNjhLIEFjcGktT3BlcmFuZAo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IDEw
NTQ2OCAxMDUxMDYgIDk5JSAgICAwLjA0SyAgIDEwMzQgICAgICAxMDIgICAgICA0MTM2Swo+Pj4+
Pj4+Pj4gc2VsaW51eF9pbm9kZV9zZWN1cml0eQo+Pj4+Pj4+Pj4gICAgICA3MzA4MCAgNzMwODAg
MTAwJSAgICAwLjEzSyAgIDI0MzYgICAgICAgMzAgICAgICA5NzQ0Swo+Pj4+Pj4ga2VybmZzX25v
ZGVfY2FjaGUKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiAgICAgIDcyMzYwICA3MDI2MSAgOTclICAgIDAu
NTlLICAgMTM0MCAgICAgICA1NCAgICAgNDI4ODBLIGlub2RlX2NhY2hlCj4+Pj4+Pj4+Pgo+Pj4+
Pj4+Pj4gICAgICA3MTA0MCAgNzEwNDAgMTAwJSAgICAwLjEySyAgIDIyMjAgICAgICAgMzIgICAg
ICA4ODgwSwo+Pj4gZXZlbnRwb2xsX2VwaQo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+ICAgICAgNjgwOTYg
IDU5MjYyICA4NyUgICAgMC4wMksgICAgMjY2ICAgICAgMjU2ICAgICAgMTA2NEsga21hbGxvYy0x
Ngo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+ICAgICAgNTM2NTIgIDUzNjUyIDEwMCUgICAgMC4wNEsgICAg
NTI2ICAgICAgMTAyICAgICAgMjEwNEsgcGRlX29wZW5lcgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+ICAg
ICAgNTA0OTYgIDMxNjU0ICA2MiUgICAgMi4wMEsgICAzMTU2ICAgICAgIDE2ICAgIDEwMDk5MksK
Pj4+IGttYWxsb2MtMjA0OAo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+ICAgICAgNDYyNDIgIDQ2MjQyIDEw
MCUgICAgMC4xOUsgICAxMTAxICAgICAgIDQyICAgICAgODgwOEsgY3JlZF9qYXIKPj4+Pj4+Pj4+
Cj4+Pj4+Pj4+PiAgICAgIDQ0NDk2ICA0MzAxMyAgOTYlICAgIDAuNjZLICAgIDkyNyAgICAgICA0
OCAgICAgMjk2NjRLCj4+Pj4+PiBwcm9jX2lub2RlX2NhY2hlCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4g
ICAgICA0NDM1MiAgNDQzNTIgMTAwJSAgICAwLjA2SyAgICA2OTMgICAgICAgNjQgICAgICAyNzcy
Swo+Pj4+Pj4gdGFza19kZWxheV9pbmZvCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gICAgICA0MzUxNiAg
NDM0NzEgIDk5JSAgICAwLjY5SyAgICA5NDYgICAgICAgNDYgICAgIDMwMjcySwo+Pj4+Pj4gc29j
a19pbm9kZV9jYWNoZQo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+ICAgICAgMzc4NTYgIDI3NjI2ICA3MiUg
ICAgMS4wMEsgICAxMTgzICAgICAgIDMyICAgICAzNzg1NksKPj4+IGttYWxsb2MtMTAyNAo+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+ICAgICAgMzY3MzYgIDM2NzM2IDEwMCUgICAgMC4wN0sgICAgNjU2ICAg
ICAgIDU2ICAgICAgMjYyNEsKPj4+IGV2ZW50cG9sbF9wd3EKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiAg
ICAgIDM0MDc2ICAzMTI4MiAgOTElICAgIDAuNTdLICAgMTIxNyAgICAgICAyOCAgICAgMTk0NzJL
Cj4+Pj4+PiByYWRpeF90cmVlX25vZGUKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiAgICAgIDMzNjYwICAz
MDUyOCAgOTAlICAgIDEuMDVLICAgMTEyMiAgICAgICAzMCAgICAgMzU5MDRLCj4+Pj4+PiBleHQ0
X2lub2RlX2NhY2hlCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gICAgICAzMjc2MCAgMzA5NTkgIDk0JSAg
ICAwLjE5SyAgICA3ODAgICAgICAgNDIgICAgICA2MjQwSyBrbWFsbG9jLTE5Mgo+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+ICAgICAgMzIwMjggIDMyMDI4IDEwMCUgICAgMC4wNEsgICAgMzE0ICAgICAgMTAy
ICAgICAgMTI1NksKPj4+Pj4+IGV4dDRfZXh0ZW50X3N0YXR1cwo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
ICAgICAgMzAwNDggIDMwMDQ4IDEwMCUgICAgMC4yNUsgICAgOTM5ICAgICAgIDMyICAgICAgNzUx
MksKPj4+Pj4+IHNrYnVmZl9oZWFkX2NhY2hlCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gICAgICAyODcz
NiAgMjg3MzYgMTAwJSAgICAwLjA2SyAgICA0NDkgICAgICAgNjQgICAgICAxNzk2SyBmc19jYWNo
ZQo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+ICAgICAgMjQ3MDIgIDI0NzAyIDEwMCUgICAgMC42OUsgICAg
NTM3ICAgICAgIDQ2ICAgICAxNzE4NEsgZmlsZXNfY2FjaGUKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiAg
ICAgIDIzODA4ICAyMzgwOCAxMDAlICAgIDAuNjZLICAgIDQ5NiAgICAgICA0OCAgICAgMTU4NzJL
IG92bF9pbm9kZQo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+ICAgICAgMjMxMDQgIDIyOTQ1ICA5OSUgICAg
MC4xMksgICAgNzIyICAgICAgIDMyICAgICAgMjg4OEsga21hbGxvYy0xMjgKPj4+Pj4+Pj4+Cj4+
Pj4+Pj4+PiAgICAgIDIyNzI0ICAyMTMwNyAgOTMlICAgIDAuNjlLICAgIDQ5NCAgICAgICA0NiAg
ICAgMTU4MDhLCj4+Pj4+PiBzaG1lbV9pbm9kZV9jYWNoZQo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+ICAg
ICAgMjE0NzIgIDIxNDcyIDEwMCUgICAgMC4xMksgICAgNjcxICAgICAgIDMyICAgICAgMjY4NEsg
c2VxX2ZpbGUKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiAgICAgIDE5OTA0ICAxOTkwNCAxMDAlICAgIDEu
MDBLICAgIDYyMiAgICAgICAzMiAgICAgMTk5MDRLIFVOSVgKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiAg
ICAgIDE3MzQwICAxNzM0MCAxMDAlICAgIDEuMDZLICAgIDU3OCAgICAgICAzMCAgICAgMTg0OTZL
IG1tX3N0cnVjdAo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+ICAgICAgMTU5ODAgIDE1OTgwIDEwMCUgICAg
MC4wMksgICAgIDk0ICAgICAgMTcwICAgICAgIDM3NksgYXZ0YWJfbm9kZQo+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+ICAgICAgMTQwNzAgIDE0MDcwIDEwMCUgICAgMS4wNksgICAgNDY5ICAgICAgIDMwICAg
ICAxNTAwOEsKPj4+IHNpZ25hbF9jYWNoZQo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+ICAgICAgMTMyNDgg
IDEzMjQ4IDEwMCUgICAgMC4xMksgICAgNDE0ICAgICAgIDMyICAgICAgMTY1NksgcGlkCj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4gICAgICAxMjEyOCAgMTE3NzcgIDk3JSAgICAwLjI1SyAgICAzNzkgICAg
ICAgMzIgICAgICAzMDMySyBrbWFsbG9jLTI1Ngo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+ICAgICAgMTEw
MDggIDExMDA4IDEwMCUgICAgMC4wMksgICAgIDQzICAgICAgMjU2ICAgICAgIDE3MksKPj4+Pj4+
Pj4+IHNlbGludXhfZmlsZV9zZWN1cml0eQo+Pj4+Pj4+Pj4gICAgICAxMDgxMiAgMTA4MTIgMTAw
JSAgICAwLjA0SyAgICAxMDYgICAgICAxMDIgICAgICAgNDI0Swo+Pj4gQWNwaS1OYW1lc3BhY2UK
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBUaGVzZSBpbmZvcm1hdGlvbiBzaG93cyB0aGF0IHRoZSAnaW9t
bXVfaW92YScgaXMgdGhlIHRvcCBtZW1vcnkKPj4+Pj4+IGNvbnN1bWVyLgo+Pj4+Pj4+Pj4gSW4g
b3JkZXIgdG8gb3B0aW1pemUgdGhlIG5ldHdvcmsgcGVyZm9ybWVuY2Ugb2YgT3BlbnN0YWNrIHZp
cnR1YWwKPj4+Pj4+IG1hY2hpbmVzLAo+Pj4+Pj4+Pj4gSSBlbmFibGVkIHRoZSB2dC1kIGZlYXR1
cmUgaW4gYmlvcyBhbmQgc3Jpb3YgZmVhdHVyZSBvZiBJbnRlbCA4MjU5OQo+Pj4+Pj4gMTBHCj4+
Pj4+Pj4+PiBOSUMuIEknbSBhc3N1bWluZyB0aGlzIGlzIHRoZSByb290IGNhdXNlIG9mIHRoaXMg
aXNzdWUuCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gSXMgdGhlcmUgYW55dGhpbmcgSSBjYW4gZG8gdG8g
Zml4IGl0Pwo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4KPj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4+Pj4+PiBpb21tdSBt
YWlsaW5nIGxpc3QKPj4+Pj4+PiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+Pj4+
Pj4+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11Cj4+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+Cj4+Pj4KPj4+Cj4+Cj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBpb21tdSBtYWlsaW5nIGxpc3QKPiBpb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11Cj4gCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vaW9tbXU=
