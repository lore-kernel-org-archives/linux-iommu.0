Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DB1C47082
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 07:50:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4B060C40
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 07:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4B060C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B12260791;
	Tue,  8 Jun 2021 07:50:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jGJaqhizMFan; Tue,  8 Jun 2021 07:50:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id E694060781;
	Tue,  8 Jun 2021 07:50:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A91B5C000B;
	Tue,  8 Jun 2021 07:50:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E888C0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 07:50:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 75A9760791
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 07:50:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kq4q44JAQn65 for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 07:50:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B966660781
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 07:50:44 +0000 (UTC)
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fzj312cDGz1BK6c;
 Tue,  8 Jun 2021 15:45:49 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by dggeme756-chm.china.huawei.com
 (10.3.19.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 8 Jun
 2021 15:50:39 +0800
Subject: Re: [Linuxarm] Re: [PATCH 0/4] Free cached iovas when rmmod the
 driver of the last device in group
To: Robin Murphy <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>
References: <1623033782-57907-1-git-send-email-chenxiang66@hisilicon.com>
 <75178f05-7831-f6c1-ad2d-5671a65a69bb@arm.com>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <9a4764fc-28bc-e4cb-10f5-e4934d24b9b5@hisilicon.com>
Date: Tue, 8 Jun 2021 15:50:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <75178f05-7831-f6c1-ad2d-5671a65a69bb@arm.com>
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linuxarm@openeuler.org,
 linuxarm@huawei.com
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

SGkgUm9iaW4sCgoK5ZyoIDIwMjEvNi83IDE5OjIzLCBSb2JpbiBNdXJwaHkg5YaZ6YGTOgo+IE9u
IDIwMjEtMDYtMDcgMDM6NDIsIGNoZW54aWFuZyB3cm90ZToKPj4gRnJvbTogWGlhbmcgQ2hlbiA8
Y2hlbnhpYW5nNjZAaGlzaWxpY29uLmNvbT4KPj4KPj4gV2hlbiBybW1vZCB0aGUgZHJpdmVyIG9m
IHRoZSBsYXN0IGRldmljZSBpbiB0aGUgZ3JvdXAsIGNhY2hlZCBpb3ZhcyAKPj4gYXJlIG5vdAo+
PiB1c2VkLCBhbmQgaXQgaXMgYmV0dGVyIHRvIGZyZWUgdGhlbSB0byBzYXZlIG1lbW9yaWVzLiBB
bmQgYWxzbyBleHBvcnQKPj4gZnVuY3Rpb24gZnJlZV9yY2FjaGVfY2FjaGVkX2lvdmFzKCkgYW5k
IGlvbW11X2RvbWFpbl90b19pb3ZhKCkuCj4KPiBIb3cgY29tbW9uIGlzIGl0IHRvIHVzZSBhIGRl
dmljZSBhIHNpZ25pZmljYW50IGFtb3VudCwgdGhlbiB1bmJpbmQgaXRzIAo+IGRyaXZlciBhbmQg
bm90IHVzZSBpdCBmb3IgbG9uZyBlbm91Z2ggdG8gY2FyZSBhYm91dD8gT2ZmLWhhbmQgSSBjYW4n
dCAKPiB0aGluayBvZiBhIHBhcnRpY3VsYXJseSByZWFsaXN0aWMgdXNlLWNhc2Ugd2hpY2ggbG9v
a3MgbGlrZSB0aGF0IC0gdGhlIAo+IGNsb3Nlc3QgSSBjYW4gaW1hZ2luZSBpcyB1bmJpbmRpbmcg
YSBkZWZhdWx0IGtlcm5lbCBkcml2ZXIgdG8gcmVwbGFjZSAKPiBpdCB3aXRoIFZGSU8sIGJ1dCBJ
IHdvdWxkIGV4cGVjdCB0aGUgc2V0IG9mIGRldmljZXMgaW50ZW5kZWQgZm9yIAo+IGFzc2lnbm1l
bnQgdG8gYmUgZGlzdGluY3QgZnJvbSB0aGUgc2V0IG9mIGRldmljZXMgdXNlZCBieSB0aGUgaG9z
dCAKPiBpdHNlbGYsIGFuZCB0aHVzIHRoZSBob3N0IGRyaXZlciB3b3VsZG4ndCBoYXZlIGFjdHVh
bGx5IGRvbmUgbXVjaCB0byAKPiBnZW5lcmF0ZSBhIGxvdCBvZiBETUEgbWFwcGluZ3MgaW4gdGhh
dCBpbml0aWFsIHBlcmlvZC4gSXMgbXkgCj4gZXhwZWN0YXRpb24gdGhlcmUgd3Jvbmc/CgpJdCBp
cyBwb3NzaWJsZSB0aGF0IHVzZXIgdXNlcyB0aGUgZHJpdmVyIGZvciBhIHdoaWxlIGFuZCB0aGVu
IHJtbW9kIGl0IAooZm9yIGV4YW1wbGUsIFNBUyBjYXJkIGlzIHRoZSBkcml2ZXIgd2UgdXNlIGFs
d2F5cywgYnV0IHNvbWV0aW1lcyB3ZSAKbmVlZCB0byBjb21wYXJlIHRoZSBwZXJmb3JtYW5jZSB3
aXRoIHJhaWQgY2FyZCwgc28gd2Ugd2lsbCBpbnNtb2QgdGhlIApyYWlkIGRyaXZlciwgYW5kIHJt
bW9kCnRoZSBkcml2ZXIgYWZ0ZXIgdGhlIHRlc3QpLiBBdCB0aGlzIHNpdHVhdGlvbiwgdGhlIHJj
YWNoZSBpb3ZhcyBvZiByYWlkIApjYXJkIGFyZSBhbHdheXMgc3RpbGwgZXZlbiBpZiBybW1vZCB0
aGUgZHJpdmVyICh1c2VyIGFsd2F5cyBybW1vZCB0aGUgCmRyaXZlciByYXRoZXIgdGhhbiByZW1v
dmluZyB0aGUgZGV2aWNlIHdoaWNoIHdpbGwgcmVsZWFzZSB0aGUgZ3JvdXAgYW5kIApyZWxlYXNl
IGFsbCByZXNvdXJjZXMpLgoKPgo+IElmIHRoZXJlIGlzIHN1Y2ggYSBjYXNlLCBob3cgbXVjaCBt
ZW1vcnkgZG9lcyB0aGlzIGFjdHVhbGx5IHNhdmUgaW4gCj4gcHJhY3RpY2U/IFRoZSB0aGVvcmV0
aWNhbCB3b3JzdC1jYXNlIHNob3VsZCBiZSByb3VnaGx5IDQgKiAxMjggKiA2ICogCj4gc2l6ZW9m
KHN0cnVjdCBpb3ZhKSBieXRlcyBwZXIgQ1BVLCB3aGljaCBpcyBhcm91bmQgMTkyS0IgYXNzdW1p
bmcgCj4gNjQtYnl0ZSBrbWVtIGNhY2hlIGFsaWdubWVudC4gCgpUaGVyZSBhcmUgMTI4IENQVXMg
aW4gb3VyIEFSTTY0IGt1bnBlbmc5MjAgYm9hcmQsIGFuZCBpIGFkZCBhIGRlYnVnZnMgCmludGVy
ZmFjZSBkcm9wX3JjYWNoZSBvZiBldmVyeSBncm91cCBpbiBsb2NhbCBjb2RlIHdoaWNoIGNhbGxz
IGZ1bmN0aW9uIApmcmVlX3JjYWNoZV9jYWNoZWRfaW92YXMoKSwgYW5kIHdlIGNhbiBzZWUgdGhh
dCBpdCBzYXZlcyAxfjJNIG1lbW9yeSAKYWZ0ZXIgZnJlZWluZyBjYWNoZWQgaW92YXMuCgplc3R1
YXJ5Oi8kIGZyZWUKICAgICAgICAgICAgICB0b3RhbCAgICAgICB1c2VkICAgICAgIGZyZWUgICAg
IHNoYXJlZCAgICBidWZmZXJzIGNhY2hlZApNZW06ICAgICA1MjY3NzY3MjAgICAgMTMzNjIxNiAg
NTI1NDQwNTA0ICAgICAxNzc2NjQgICAgICAgICAgMCAxNzc2NjQKLS8rIGJ1ZmZlcnMvY2FjaGU6
ICAgIDExNTg1NTIgIDUyNTYxODE2OApTd2FwOiAgICAgICAgICAgIDAgICAgICAgICAgMCAgICAg
ICAgICAwCmVzdHVhcnk6L3N5cy9rZXJuZWwvZGVidWcvaW9tbXUvaW92YWQvaW9tbXVfZG9tYWlu
MjkkIGVjaG8gMSA+IGRyb3BfcmNhY2hlCmVzdHVhcnk6L3N5cy9rZXJuZWwvZGVidWcvaW9tbXUv
aW92YWQvaW9tbXVfZG9tYWluMjkkIGZyZWUKICAgICAgICAgICAgICB0b3RhbCAgICAgICB1c2Vk
ICAgICAgIGZyZWUgICAgIHNoYXJlZCAgICBidWZmZXJzIGNhY2hlZApNZW06ICAgICA1MjY3NzY3
MjAgICAgMTMzNDY3MiAgNTI1NDQyMDQ4ICAgICAxNzc2NjQgICAgICAgICAgMCAxNzc2NjQKLS8r
IGJ1ZmZlcnMvY2FjaGU6ICAgIDExNTcwMDggIDUyNTYxOTcxMgpTd2FwOiAgICAgICAgICAgIDAg
ICAgICAgICAgMCAgICAgICAgICAwCgpUaGUgb3RoZXIgcmVhc29uIGkgd2FudCB0byBmcmVlIHJj
YWNoZSBpb3ZhcyBpbiBzdWl0YWJsZSBwbGFjZSBpcyB0aGUgCklPVkEgbG9uZ3Rlcm0gaXNzdWVb
MF0gKHdoaWNoIGlzIHVucmVjb3ZlcmFibGUpLCBpZiBmcmVlaW5nIGNhY2hlZCBpb3ZhcyAKd2hl
biBybW1vZCB0aGUgZHJpdmVyIG9yCmFkZGluZyBhIGRlYnVnZnMgdG8gZG8gdGhhdCwgaSB0aGlu
ayB3ZSBjYW4gcmVjb3ZlciBpdCBieSBybW1vZCB0aGUgCmRyaXZlciBhbmQgdGhlbiBpbnNtb2Qg
aXQgb3IgY2FsbGluZyB0aGUgZGVidWdmcyBkcm9wX3JjYWNoZSB0aG91Z2ggaXQgCmRvZXNuJ3Qg
c29sdmUgdGhlIGlzc3VlLgoKWzBdIApodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1pb21t
dS8xNjA3NTM4MTg5LTIzNzk0NC00LWdpdC1zZW5kLWVtYWlsLWpvaG4uZ2FycnlAaHVhd2VpLmNv
bS8KCj4gSG93ZXZlciBpdCBzZWVtcyByYXRoZXIgdW5saWtlbHkgaW4gcHJhY3RpY2UgdG8gaGF2
ZSBldmVyeSBwb3NzaWJsZSAKPiBjYWNoZSBlbnRyeSBvZiBldmVyeSBzaXplIHVzZWQsIHNvIGlm
IHNhdmluZyBzbWFsbGVyIGFtb3VudHMgb2YgbWVtb3J5IAo+IGlzIGEgY29uY2VybiB3b3VsZG4n
dCB5b3UgYWxzbyB3YW50IHRvIGV4cGxpY2l0bHkgZHJhaW4gdGhlIGZsdXNoIAo+IHF1ZXVlcyAo
MTZLQiBwZXIgQ1BVKSBhbmQgbWF5YmUgbG9vayBhdCB0cnlpbmcgdG8gcmVjbGFpbSB0aGUgdW51
c2VkIAo+IHBhZ2V0YWJsZSBwYWdlcyBmcm9tIHRoZSBkb21haW4gaXRzZWxmIC0gdGhhdCB+MTky
S0Igd29ydGggb2YgY2FjaGVkIAo+IElPVkFzIHJlcHJlc2VudHMgfjMySyBwYWdlcyB3b3J0aCBv
ZiBJT1ZBIHNwYWNlLCB3aGljaCBmb3IgYW4gCj4gaW1wbGVtZW50YXRpb24gbGlrZSBpby1wZ3Rh
YmxlLWFybSB3aXRoIHRoZSA0S0IgZ3JhbnVsZSBtZWFucyB+MjU2S0IgCj4gd29ydGggb2Ygbm9u
LWxlYWYgcGFnZXRhYmxlcyBsZWZ0IGJlaGluZC4KCk9rLCB3ZSBtYXkgY29uc2lkZXIgYWJvdXQg
dGhvc2UuCgo+Cj4gSSdtIG5vdCBhZ2FpbnN0IHRoZSBpZGVhIG9mIGhhdmluZyBhIG1lY2hhbmlz
bSB0byAiY29tcGFjdCIgYW4gaWRsZSAKPiBETUEgZG9tYWluIGlmIHRoZXJlIGFyZSBjb252aW5j
aW5nIG51bWJlcnMgdG8gYmFjayBpdCB1cCwgYnV0IHRoZSAKPiBhY3R1YWwgaW1wbGVtZW50YXRp
b24gd291bGQgbmVlZCB0byBiZSBiZXR0ZXIgdGhhbiB0aGlzIGFzIHdlbGwgLSAKPiBoYXZpbmcg
dGhlIElPTU1VIGNvcmUgY29kZSBwb2tpbmcgZGlyZWN0bHkgaW50byB0aGUgaW50ZXJuYWxzIG9m
IHRoZSAKPiBpb21tdS1kbWEgYWJzdHJhY3Rpb24gaXMgbm90IHRoZSB3YXkgdG8gZ28sIGFuZCBl
eHBvcnRpbmcgYW55dGhpbmcgdG8gCj4gbW9kdWxlcywgd2hpY2ggdGhlIElPTVUgY29yZSBpcyBu
b3QsIHNtZWxscyBzdXNwaWNpb3VzLgo+Cj4gUm9iaW4uCj4KPj4gWGlhbmcgQ2hlbiAoNCk6Cj4+
ICAgIGlvbW11L2lvdmE6IGFkZCBhIGZ1bmN0aW9uIHRvIGZyZWUgYWxsIHJjYWNoZWQgaW92YXMg
YW5kIGV4cG9ydCBpdAo+PiAgICBpb21tdS9pb3ZhOiB1c2UgZnVuY3Rpb24gZnJlZV9yY2FjaGVf
Y2FjaGVkX2lvdmFzKCkgdG8gZnJlZSBhbGwKPj4gICAgICByY2FjaGVkIGlvdmFzCj4+ICAgIGRt
YS1pb21tdTogYWRkIGEgaW50ZXJmYWNlIHRvIGdldCBpb3ZhX2RvbWFpbiBmcm9tIGlvbW11IGRv
bWFpbgo+PiAgICBpb21tdTogZnJlZSBjYWNoZWQgaW92YXMgd2hlbiBybW1vZCB0aGUgZHJpdmVy
IG9mIHRoZSBsYXN0IGRldmljZSBpbgo+PiAgICAgIHRoZSBncm91cAo+Pgo+PiAgIGRyaXZlcnMv
aW9tbXUvZG1hLWlvbW11LmMgfCAgNyArKysrKysrCj4+ICAgZHJpdmVycy9pb21tdS9pb21tdS5j
ICAgICB8ICA3ICsrKysrKysKPj4gICBkcml2ZXJzL2lvbW11L2lvdmEuYyAgICAgIHwgMTcgKysr
KysrKysrKysrLS0tLS0KPj4gICBpbmNsdWRlL2xpbnV4L2RtYS1pb21tdS5oIHwgIDYgKysrKysr
Cj4+ICAgaW5jbHVkZS9saW51eC9pb3ZhLmggICAgICB8ICA1ICsrKysrCj4+ICAgNSBmaWxlcyBj
aGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+Pgo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gTGludXhhcm0gbWFpbGluZyBs
aXN0IC0tIGxpbnV4YXJtQG9wZW5ldWxlci5vcmcKPiBUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVt
YWlsIHRvIGxpbnV4YXJtLWxlYXZlQG9wZW5ldWxlci5vcmcKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
