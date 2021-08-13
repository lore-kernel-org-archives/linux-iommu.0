Return-Path: <SRS0=SLGw=NE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF0DC4338F
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 10:08:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39526103A
	for <iommu@archiver.kernel.org>; Fri, 13 Aug 2021 10:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D39526103A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9367F83ACD;
	Fri, 13 Aug 2021 10:08:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yIg6fLBmf2Au; Fri, 13 Aug 2021 10:08:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8EF2D83AC9;
	Fri, 13 Aug 2021 10:08:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D290C0010;
	Fri, 13 Aug 2021 10:08:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E6EFC000E
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 10:08:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4B60A60BF8
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 10:08:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cqSG94QcX44g for <iommu@lists.linux-foundation.org>;
 Fri, 13 Aug 2021 10:08:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id ECD8460BF6
 for <iommu@lists.linux-foundation.org>; Fri, 13 Aug 2021 10:08:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25477D6E;
 Fri, 13 Aug 2021 03:08:13 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57EFF3F70D;
 Fri, 13 Aug 2021 03:08:11 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOWbnuWkjTog5Zue5aSNOiBbRXh0ZXJuYWxdUmU6IEFuIGNtYSBv?=
 =?UTF-8?Q?ptimization_patch_is_used_for_cma=5f=5balloc=7cfree=5d=2e?=
To: Jichao Zou <zoujc@motorola.com>, David Hildenbrand <david@redhat.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "minchan@kernel.org" <minchan@kernel.org>,
 "song.bao.hua@hisilicon.com" <song.bao.hua@hisilicon.com>,
 "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 JianQi Yang <yangj@motorola.com>, Yanjune Tian <tianyje@motorola.com>
References: <HK0PR03MB4177A44D9DAD3302251B0EC8D5FA9@HK0PR03MB4177.apcprd03.prod.outlook.com>
 <f5cd9fe6-3b62-eab8-1ff1-d3943d4bb85b@redhat.com>
 <HK0PR03MB41775573A48273BF128C7F72D5FA9@HK0PR03MB4177.apcprd03.prod.outlook.com>
 <ca497139-a6e8-cb66-e221-7fe4af2bda14@arm.com>
 <HK0PR03MB4177FDD7160ABAC3C8119984D5FA9@HK0PR03MB4177.apcprd03.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <52c0b1fd-d60f-5d7d-0b47-b3569678ebf6@arm.com>
Date: Fri, 13 Aug 2021 11:08:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <HK0PR03MB4177FDD7160ABAC3C8119984D5FA9@HK0PR03MB4177.apcprd03.prod.outlook.com>
Content-Language: en-GB
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

T24gMjAyMS0wOC0xMyAxMDo0NiwgSmljaGFvIFpvdSB3cm90ZToKPiBJIGdvdCBpdCwgYnV0IGlu
IGtlcm5lbCB0aGF0IHdlIHVzZWQgdmVyc2lvbiwgbWFueSBoZWFwIGRyaXZlcnMgdGhhdCBpbiBk
cml2ZXJzL2RtYS1idWYvIGFyZSBiYXNlZCBvbiBDTUEsIG5vdCBETUEgY2FydmVvdXQhCj4gSWYg
dGhpcyBwYXRjaCBpcyBub3QgYWNjZXB0ZWQsIHdlIGNhbmNlbCBpdCEhIQoKSWYgeW91IGp1c3Qg
d2FudCBkbWFfYWxsb2NfY29oZXJlbnQoKSB0byB3b3JrIGF1dG9tYXRpY2FsbHkgZnJvbSBhIApj
YXJ2ZW91dCBpbiB0aGUgc2FtZSBtYW5uZXIgYXMgQ01BLCB3aXRob3V0IGhhdmluZyB0byBzdGlj
ayAKb2ZfcmVzZXJ2ZWRfbWVtX2RldmljZV9pbml0KCkgY2FsbHMgZXZlcnl3aGVyZSB0byBtYWtl
IGRyaXZlcnMgYXdhcmUgb2YgCnBlci1kZXZpY2UgY2FydmVvdXRzLCB0aGVuIFsxXSBpcyBwcm9i
YWJseSB3aGF0IHlvdSB3YW50LgoKSWYgaXQncyBzcGVjaWZpY2FsbHkgZG1hLWJ1ZiBoZWFwcyB0
aGF0IHlvdSdyZSBpbnRlcmVzdGVkIGluLCB0aGVuIApoYWNraW5nIHRoZSBjb21tb24gQ01BIGNv
ZGUgdG8gbWFrZSB0aGUgQ01BIGhlYXAgYmVoYXZlIGxpa2UgYSBjYXJ2ZW91dCAKaGVhcCBpcyBk
ZWZpbml0ZWx5IHRoZSB3cm9uZyBhcHByb2FjaCAtIGp1c3QgaW1wbGVtZW50IGEgY2FydmVvdXQg
aGVhcCAKcHJvcGVybHkuIEl0IHNlZW1zIHRoZSBvbmx5IHJlYXNvbiB0aGF0IGhhc24ndCBwb3J0
ZWQgb3ZlciBmcm9tIElPTiBpcyAKdGhhdCBub2JvZHkncyBuZWVkZWQgaXQgeWV0WzJdLgoKUm9i
aW4uCgpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMjAyMTA3MTIwNjE3
MDQuNDE2MjQ2NC0xLWhjaEBsc3QuZGUvClsyXSBodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvODAx
MjMwLwoKPiAKPiBUaGFuayB5b3UgYWxsLgo+IAo+IEJlc3QgUmVnYXJkcywKPiAKPiAtLS0tLemC
ruS7tuWOn+S7ti0tLS0tCj4g5Y+R5Lu25Lq6OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBh
cm0uY29tPgo+IOWPkemAgeaXtumXtDogMjAyMeW5tDjmnIgxM+aXpSAxNzoxNgo+IOaUtuS7tuS6
ujogSmljaGFvIFpvdSA8em91amNAbW90b3JvbGEuY29tPjsgRGF2aWQgSGlsZGVuYnJhbmQgPGRh
dmlkQHJlZGhhdC5jb20+OyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IG1pbmNoYW5Aa2VybmVsLm9yZzsg
c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb207IGhjaEBsc3QuZGU7IG0uc3p5cHJvd3NraUBzYW1z
dW5nLmNvbTsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IEppYW5RaSBZYW5nIDx5
YW5nakBtb3Rvcm9sYS5jb20+OyBZYW5qdW5lIFRpYW4gPHRpYW55amVAbW90b3JvbGEuY29tPgo+
IOS4u+mimDogUmU6IOWbnuWkjTogW0V4dGVybmFsXVJlOiBBbiBjbWEgb3B0aW1pemF0aW9uIHBh
dGNoIGlzIHVzZWQgZm9yIGNtYV9bYWxsb2N8ZnJlZV0uCj4gCj4gT24gMjAyMS0wOC0xMyAwOToy
NywgSmljaGFvIFpvdSB3cm90ZToKPj4gSGkgRGF2aWQsCj4+IAlJJ2xsIGdpdC1zZW5kLWVtYWls
IHBhdGNoIGFnYWluLgo+PiAJWW91ciB1bmRlcnN0YW5kaW5nIGlzIGV4YWN0bHkgcmlnaHQuCj4+
IAlMZXQgbWUgZXhwbGFpbiB0aGUgYmFja2dyb3VuZCBvZiBQYXRjaCwgd2UgYXJlIGRldmVsb3Bp
bmcgQW5kcm9pZCBwaG9uZSwga2VybmVsIGlzIDUuMTAuNDMgTFRTLCB3ZSBlbmNvdW50ZXIgY21h
X2FsbG9jIGZhaWxlZCBkdXJpbmcga2VybmVsIHN0YXJ0dXAsIGJ1ZGR5IHN5c3RlbSBpcyByZWFk
eSwKPj4gMDEtMTEgMTQ6MjI6MDguNjUwICAgMjE2ICAgMjE2IEUgY21hICAgICA6IGNtYV9hbGxv
YyhbMjE2XVtpbml0XTpjbWEoZmZmZmZmZmYwMGI1MDAwMDp0b3RhbCA4MTkyKSBsaW51eCxjbWEo
ZmZmZmZmZTg5ZDA4NGNmMCksIGNvdW50IDIsIGFsaWduIDEgZ2ZwX21hc2sgMHhjYzApCj4+IDAx
LTExIDE0OjIyOjA4LjY1MCAgIDIxNiAgIDIxNiBFIGNtYSAgICAgOiBjbWFfYWxsb2MoKTogbWVt
b3J5IHJhbmdlIGF0IGZmZmZmZmZmMDBiNjI4ODAgaXMgYnVzeSwgcmV0cnlpbmcKPj4gICAgCj4+
IAljbWEgYml0bWFwIHNob3cgbWVtb3J5IGlzIGZyZWUsIGJ1dCBhbGxvY19jb250aWdfcmFuZ2Ug
ZmFpbGVkLCB3ZSBjaGVja2VkIGl0IG91dCB0aGF0IHNvbWUgZHJpdmVycyBjbWFfYWxsb2MgYXJl
Cj4+IAkic3RydWN0IHBhZ2UgKmNtYV9hbGxvYyhzdHJ1Y3QgY21hICpjbWEsIHNpemVfdCBjb3Vu
dCwgdW5zaWduZWQgaW50IGFsaWduLCBib29sIG5vX3dhcm4pIgo+PiAJSW4gNS4xMC40MywgY21h
X2FsbG9jIGlzCj4+IAkic3RydWN0IHBhZ2UgKmNtYV9hbGxvYyhzdHJ1Y3QgY21hICpjbWEsIHNp
emVfdCBjb3VudCwgdW5zaWduZWQgaW50IGFsaWduLCBnZnBfdCBnZnBfbWFzaykiCj4+ICAgIAlB
ZnRlciBjaGFuZ2UgY21hX2FsbG9jIHBhcmFtZXRlciB3aXRoIEdGUF9LRVJORUwsIGlzc3VlIGlz
IGZpeGVkLCBhdCB0aGUgc2FtZSB0aW1lLCB3ZSBmb3VuZCB0aGF0IHByZWFsbG9jYXRlIGEgcG9y
dGlvbiBvZiBjbWEgbWVtb3J5IGZvciBhdWRpbyZ2aWRlbyByZXN1bHRlZCBpbiBiZXR0ZXIgcGVy
Zm9ybWFuY2UgYW5kIGd1YXJhbnRlZSBBViBmdW5jdGlvbiBldmVuIHVuZGVyIG1lbW9yeSBwcmVz
c3VyZSwgc28gd2UgdHJ5IHRvIHN1Ym1pdCB0aGlzIHBhdGNoLgo+IAo+IFRoZSB3aG9sZSBwb2lu
dCBvZiBDTUEgaXMgdGhhdCB0aGUgbWVtb3J5IGNhbiBiZSBzaGFyZWQgYnkgbW92ZWFibGUgcGFn
ZXMgd2hpbGUgaXQncyBub3QgYmVpbmcgdXNlZCBmb3IgRE1BLiBJZiB5b3Ugd2FudCBhIGRlZGlj
YXRlZCBETUEgY2FydmVvdXQsIHRoZXJlIGFyZSBhbHJlYWR5IG1lY2hhbmlzbXMgZm9yIHRoYXQu
Cj4gCj4gUm9iaW4uCj4gCj4+Cj4+IFRoYW5rcy4KPj4KPj4gQmVzdCBSZWdhcmRzLAo+Pgo+PiBa
b3UgSmljaGFvIOmCuee6qui2hQo+PiBBZHZpc29yeSBFbmdpbmVlciwgU1cgQlNQCj4+IE1CRyBS
T1cgU1cgQkogUEYgQlNQIChDTikKPj4gTW90b3JvbGEgTW9iaWxpdHksIEEgTGVub3ZvIENvbXBh
bnkKPj4gbW90b3JvbGEuY29tCj4+IE0gKzg2IDE4OTEwODYwMjEyCj4+IEUgem91amNAbGVub3Zv
LmNvbQo+PiB0d2l0dGVyIHwgZmFjZWJvb2sgfCBpbnN0YWdyYW0gfCBibG9nIHwgZm9ydW1zCj4+
Cj4+Cj4+Cj4+Cj4+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0KPj4g5Y+R5Lu25Lq6OiBEYXZpZCBI
aWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4KPj4g5Y+R6YCB5pe26Ze0OiAyMDIx5bm0OOac
iDEz5pelIDE1OjQ1Cj4+IOaUtuS7tuS6ujogSmljaGFvIFpvdSA8em91amNAbW90b3JvbGEuY29t
PjsgYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsKPj4gbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBtaW5jaGFuQGtlcm5lbC5vcmc7Cj4+IHNvbmcuYmFv
Lmh1YUBoaXNpbGljb24uY29tOyBoY2hAbHN0LmRlOyBtLnN6eXByb3dza2lAc2Ftc3VuZy5jb207
Cj4+IHJvYmluLm11cnBoeUBhcm0uY29tOyBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZzsgSmlhblFpIFlhbmcKPj4gPHlhbmdqQG1vdG9yb2xhLmNvbT47IFlhbmp1bmUgVGlhbiA8dGlh
bnlqZUBtb3Rvcm9sYS5jb20+Cj4+IOS4u+mimDogW0V4dGVybmFsXVJlOiBBbiBjbWEgb3B0aW1p
emF0aW9uIHBhdGNoIGlzIHVzZWQgZm9yIGNtYV9bYWxsb2N8ZnJlZV0uCj4+Cj4+IE9uIDEzLjA4
LjIxIDA5OjAwLCBKaWNoYW8gWm91IHdyb3RlOgo+Pj4gUHJlLWFsbG9jYXRlwqBDTUHCoG1lbW9y
ecKgdGhhdMKgY29uZmlndXJlZMKgaW7CoGRldmljZSB0cmVlLMKgdGhpc8KgZ3JlYXRseQo+Pj4g
aW1wcm92ZXPCoHRoZcKgQ01BwqBtZW1vcnkgYWxsb2NhdGlvbsKgZWZmaWNpZW5jeSzCoGNtYV9b
YWxsb2N8ZnJlZV3CoGlzCj4+PiBsZXNzIHRoYW7CoDFtcyzCoG9sZMKgd2F5wqBpc8KgdG9va8Kg
YcKgZmV3wqBtc8KgdG/CoHRlbnPCoG9yIGh1bmRyZWRzwqBtcy4KPj4+Cj4+Cj4+IFBsZWFzZSBz
ZW5kIHBhdGNoZXMgYXMgcHJvcGVyIGVtYWlscyAobWFuIGdpdC1mb3JtYXQtcGF0Y2g7IG1hbiBn
aXQtc2VuZC1lbWFpbCkuCj4+Cj4+IFdoYXQgeW91IHByb3Bvc2UgaXMgdHVybmluZyBjbWEgcmVz
ZXJ2YXRpb25zIGludG8gc29tZXRoaW5nIGNvbXBhcmFibGUgdG8gcGVybWFuZW50IGJvb3R0aW1l
IGFsbG9jYXRpb25zLiBGcm9tIHRoZSBQT1Ygb2YgdGhlIGJ1ZGR5LCB0aGUgcGFnZXMgYXJlIGFs
d2F5cyBhbGxvY2F0ZWQgYW5kIGNhbm5vdCBiZSByZXB1cnBvc2VkIGZvciBlLmcuLCBtb3ZhYmxl
IGFsbG9jYXRpb25zIHVudGlsICphY3R1YWxseSogYWxsb2NhdGVkIHZpYSBDTUEuCj4+Cj4+IEkg
ZG9uJ3QgdGhpbmsgd2Ugd2FudCB0aGlzIGJlaGF2aW9yIHVwc3RyZWFtLgo+Pgo+PiAtLQo+PiBU
aGFua3MsCj4+Cj4+IERhdmlkIC8gZGhpbGRlbmIKPj4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
