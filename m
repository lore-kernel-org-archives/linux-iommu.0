Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A977CC433E6
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 13:20:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F3764F1B
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 13:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F3764F1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C0525400AC;
	Thu, 18 Mar 2021 13:20:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mwxjOsAtzu4q; Thu, 18 Mar 2021 13:20:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id A1ECF400A8;
	Thu, 18 Mar 2021 13:20:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78F34C000B;
	Thu, 18 Mar 2021 13:20:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92D2CC0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 13:20:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A9C8400A9
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 13:20:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1LXo6na-DHzI for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 13:20:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 44B87400A8
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 13:20:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 068B0ED1;
 Thu, 18 Mar 2021 06:20:12 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F32643F718;
 Thu, 18 Mar 2021 06:20:10 -0700 (PDT)
Subject: Re: [PATCH 2/2] iommu/iova: Improve restart logic
To: John Garry <john.garry@huawei.com>, joro@8bytes.org
References: <03931d86c0ad71f44b29394e3a8d38bfc32349cd.1614962123.git.robin.murphy@arm.com>
 <076b3484d1e5057b95d8c387c894bd6ad2514043.1614962123.git.robin.murphy@arm.com>
 <c1181e3b-cdf3-c658-1c57-8ec86d034f4b@huawei.com>
 <d8e80756-a628-3a0d-77ac-1e9df734f1c5@huawei.com>
 <6cea11f9-e98d-98cb-6789-93abd8833fa0@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <878f4f77-97ee-898d-eb05-4548cf00ec27@arm.com>
Date: Thu, 18 Mar 2021 13:20:03 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6cea11f9-e98d-98cb-6789-93abd8833fa0@huawei.com>
Content-Language: en-GB
Cc: vjitta@codeaurora.org, iommu@lists.linux-foundation.org,
 Linuxarm <linuxarm@huawei.com>, linux-kernel@vger.kernel.org
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

T24gMjAyMS0wMy0xOCAxMTozOCwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAxMC8wMy8yMDIxIDE3
OjQ3LCBKb2huIEdhcnJ5IHdyb3RlOgo+PiBPbiAwOS8wMy8yMDIxIDE1OjU1LCBKb2huIEdhcnJ5
IHdyb3RlOgo+Pj4gT24gMDUvMDMvMjAyMSAxNjozNSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4K
Pj4+IEhpIFJvYmluLAo+Pj4KPj4+PiBXaGVuIHJlc3RhcnRpbmcgYWZ0ZXIgc2VhcmNoaW5nIGJl
bG93IHRoZSBjYWNoZWQgbm9kZSBmYWlscywgcmVzZXR0aW5nCj4+Pj4gdGhlIHN0YXJ0IHBvaW50
IHRvIHRoZSBhbmNob3Igbm9kZSBpcyBvZnRlbiBvdmVybHkgcGVzc2ltaXN0aWMuIElmCj4+Pj4g
YWxsb2NhdGlvbnMgYXJlIG1hZGUgd2l0aCBtaXhlZCBsaW1pdHMgLSBwYXJ0aWN1bGFybHkgaW4g
dGhlIGNhc2Ugb2YgCj4+Pj4gdGhlCj4+Pj4gb3Bwb3J0dW5pc3RpYyAzMi1iaXQgYWxsb2NhdGlv
biBmb3IgUENJIGRldmljZXMgLSB0aGlzIGNvdWxkIG1lYW4KPj4+PiBzaWduaWZpY2FudCB0aW1l
IHdhc3RlZCB3YWxraW5nIHRocm91Z2ggdGhlIHdob2xlIHBvcHVsYXRlZCB1cHBlciByYW5nZQo+
Pj4+IGp1c3QgdG8gcmVhY2ggdGhlIGluaXRpYWwgbGltaXQuIAo+Pj4KPj4+IFJpZ2h0Cj4+Pgo+
Pj4+IFdlIGNhbiBpbXByb3ZlIG9uIHRoYXQgYnkgaW1wbGVtZW50aW5nCj4+Pj4gYSBwcm9wZXIg
dHJlZSB0cmF2ZXJzYWwgdG8gZmluZCB0aGUgZmlyc3Qgbm9kZSBhYm92ZSB0aGUgcmVsZXZhbnQg
Cj4+Pj4gbGltaXQsCj4+Pj4gYW5kIHNldCB0aGUgZXhhY3Qgc3RhcnQgcG9pbnQuCj4+Pgo+Pj4g
VGhhbmtzIGZvciB0aGlzLiBIb3dldmVyLCBhcyBtZW50aW9uZWQgaW4gdGhlIG90aGVyIHRocmVh
ZCwgdGhpcyBkb2VzIAo+Pj4gbm90IGhlbHAgb3VyIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24gUmU6
IGNvbW1pdCA0ZTg5ZGNlNzI1MjEuCj4+Pgo+Pj4gQW5kIG1lbnRpb25pbmcgdGhpcyAicmV0cnki
IGFwcHJvYWNoIGFnYWluLCBpbiBjYXNlIGl0IHdhcyBtaXNzZWQsIAo+Pj4gZnJvbSBteSBleHBl
cmltZW50IG9uIHRoZSBhZmZlY3RlZCBIVywgaXQgYWxzbyBoYXMgZ2VuZXJhbGx5IGEgCj4+PiBk
cmVhZGZ1bGx5IGxvdyBzdWNjZXNzIHJhdGUgLSBsZXNzIHRoYW4gMSUgZm9yIHRoZSAzMmIgcmFu
Z2UgcmV0cnkuIAo+Pj4gUmV0cnkgcmF0ZSBpcyBhYm91dCAyMCUuIFNvIEkgYW0gc2F5aW5nIGZy
b20gdGhpcyAyMCUsIGxlc3MgdGhhbiAxJSAKPj4+IG9mIHRob3NlIHN1Y2NlZWQuCgpXZWxsIHll
YWgsIGluIHlvdXIgcGFydGljdWxhciBjYXNlIHlvdSdyZSBhbGxvY2F0aW5nIGZyb20gYSBoZWF2
aWx5IApvdmVyLWNvbnRlbmRlZCBhZGRyZXNzIHNwYWNlLCBzbyBtdWNoIG9mIHRoZSB0aW1lIGl0
IGlzIGdlbnVpbmVseSBmdWxsLiAKUGx1cyB5b3UncmUgcHJpbWFyaWx5IGNodXJuaW5nIG9uZSBv
ciB0d28gc2l6ZXMgb2YgSU9WQSwgc28gdGhlcmUncyBhIApoaWdoIGNoYW5jZSB0aGF0IHlvdSB3
aWxsIGVpdGhlciBhbGxvY2F0ZSBpbW1lZGlhdGVseSBmcm9tIHRoZSBjYWNoZWQgCm5vZGUgKGFm
dGVyIGEgcHJldmlvdXMgZnJlZSksIG9yIHNlYXJjaCB0aGUgd2hvbGUgc3BhY2UgYW5kIGZhaWwu
IEluIApjYXNlIGl0IHdhcyBtaXNzZWQsIHNlYXJjaGluZyBvbmx5IHNvbWUgYXJiaXRyYXJ5IHN1
YnNldCBvZiB0aGUgc3BhY2UgCmJlZm9yZSBnaXZpbmcgdXAgaXMgbm90IGEgZ29vZCBiZWhhdmlv
dXIgZm9yIGFuIGFsbG9jYXRvciB0byBoYXZlIGluIApnZW5lcmFsLgoKPj4gU28gc2luY2UgdGhl
IHJldHJ5IG1lYW5zIHRoYXQgd2Ugc2VhcmNoIHRocm91Z2ggdGhlIGNvbXBsZXRlIHBmbiByYW5n
ZSAKPj4gbW9zdCBvZiB0aGUgdGltZSAoZHVlIHRvIHBvb3Igc3VjY2VzcyByYXRlKSwgd2Ugc2hv
dWxkIGJlIGFibGUgdG8gZG8gYSAKPj4gYmV0dGVyIGpvYiBhdCBtYWludGFpbmluZyBhbiBhY2N1
cmF0ZSBtYXggYWxsb2Mgc2l6ZSwgYnkgY2FsY3VsYXRpbmcgCj4+IGl0IGZyb20gdGhlIHJhbmdl
IHNlYXJjaCwgYW5kIG5vdCByZWx5aW5nIG9uIG1heCBhbGxvYyBmYWlsZWQgb3IgCj4+IHJlc2V0
dGluZyBpdCBmcmVxdWVudGx5LiBIb3BlZnVsbHkgdGhhdCB3b3VsZCBtZWFuIHRoYXQgd2UncmUg
c21hcnRlciAKPj4gYWJvdXQgbm90IHRyeWluZyB0aGUgYWxsb2NhdGlvbi4KPiAKPiBTbyBJIHRy
aWVkIHRoYXQgb3V0IGFuZCB3ZSBzZWVtIHRvIGJlIGFibGUgdG8gc2NyYXAgYmFjayBhbiBhcHBy
ZWNpYWJsZSAKPiBhbW91bnQgb2YgcGVyZm9ybWFuY2UuIE1heWJlIDgwJSBvZiBvcmlnaW5hbCwg
d2l0aCB3aXRoIGFub3RoZXIgY2hhbmdlLCAKPiBiZWxvdy4KClRCSCBpZiB5b3UgcmVhbGx5IHdh
bnQgdG8gbWFrZSBhbGxvY2F0aW9uIG1vcmUgZWZmaWNpZW50IEkgdGhpbmsgdGhlcmUgCmFyZSBt
b3JlIHJhZGljYWwgY2hhbmdlcyB0aGF0IHdvdWxkIGJlIHdvcnRoIGV4cGVyaW1lbnRpbmcgd2l0
aCwgbGlrZSAKdXNpbmcgc29tZSBmb3JtIG9mIGF1Z21lbnRlZCByYnRyZWUgdG8gYWxzbyBlbmNv
ZGUgdGhlIGFtb3VudCBvZiBmcmVlIApzcGFjZSB1bmRlciBlYWNoIGJyYW5jaCwgb3IgcmVwcmVz
ZW50aW5nIHRoZSBmcmVlIHNwYWNlIGluIGl0cyBvd24gCnBhcmFsbGVsIHRyZWUsIG9yIHdoZXRo
ZXIgc29tZSBvdGhlciBzdHJ1Y3R1cmUgZW50aXJlbHkgbWlnaHQgYmUgYSAKYmV0dGVyIGJldCB0
aGVzZSBkYXlzLgoKQW5kIGlmIHlvdSBqdXN0IHdhbnQgdG8gbWFrZSB5b3VyIHRoaW5nIGFjY2Vw
dGFibHkgZmFzdCwgbm93IEknbSBnb2luZyAKdG8gc2F5IHN0aWNrIGEgcXVpcmsgc29tZXdoZXJl
IHRvIGZvcmNlIHRoZSAiZm9yY2VkYWMiIG9wdGlvbiBvbiB5b3VyIApwbGF0Zm9ybSA7KQoKWy4u
Ll0KPj4+PiBAQCAtMjE5LDcgKzI1Niw3IEBAIHN0YXRpYyBpbnQgX19hbGxvY19hbmRfaW5zZXJ0
X2lvdmFfcmFuZ2Uoc3RydWN0IAo+Pj4+IGlvdmFfZG9tYWluICppb3ZhZCwKPj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKGxvd19wZm4gPT0gaW92YWQtPnN0YXJ0X3BmbiAmJiByZXRyeV9wZm4g
PCBsaW1pdF9wZm4pIHsKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBoaWdoX3BmbiA9
IGxpbWl0X3BmbjsKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsb3dfcGZuID0gcmV0
cnlfcGZuOwo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN1cnIgPSAmaW92YWQtPmFuY2hv
ci5ub2RlOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN1cnIgPSBpb3ZhX2ZpbmRfbGlt
aXQoaW92YWQsIGxpbWl0X3Bmbik7Cj4gCj4gCj4gSSBzZWUgdGhhdCBpdCBpcyBub3cgYXBwbGll
ZC4gSG93ZXZlciwgYWx0ZXJuYXRpdmVseSBjb3VsZCB3ZSBqdXN0IGFkZCBhIAo+IHplcm8tbGVu
Z3RoIDMyYiBib3VuZGFyeSBtYXJrZXIgbm9kZSBmb3IgdGhlIDMyYiBwZm4gcmVzdGFydCBwb2lu
dD8KClRoYXQgd291bGQgbmVlZCBzcGVjaWFsIGNhc2VzIGFsbCBvdmVyIHRoZSBwbGFjZSB0byBw
cmV2ZW50IHRoZSBtYXJrZXIgCmdldHRpbmcgbWVyZ2VkIGludG8gcmVzZXJ2YXRpb25zIG9yIGhp
dCBieSBsb29rdXBzLCBhbmQgYXQgd29yc3QgYnJlYWsgCnRoZSBvcmRlcmluZyBvZiB0aGUgdHJl
ZSBpZiBhIGxlZ2l0aW1hdGUgbm9kZSBzdHJhZGRsZXMgdGhlIGJvdW5kYXJ5LiBJIApkaWQgY29u
c2lkZXIgaGF2aW5nIHRoZSBpbnNlcnQvZGVsZXRlIHJvdXRpbmVzIGtlZXAgdHJhY2sgb2YgeWV0
IGFub3RoZXIgCmNhY2hlZCBub2RlIGZvciB3aGF0ZXZlcidzIGN1cnJlbnRseSB0aGUgZmlyc3Qg
dGhpbmcgYWJvdmUgdGhlIDMyLWJpdCAKYm91bmRhcnksIGJ1dCBJIHdhcyB3b3JyaWVkIHRoYXQg
bWlnaHQgYmUgYSBiaXQgdG9vIGludmFzaXZlLgoKRldJVyBJJ20gY3VycmVudGx5IHBsYW5uaW5n
IHRvIGNvbWUgYmFjayB0byB0aGlzIGFnYWluIHdoZW4gSSBoYXZlIGEgYml0IAptb3JlIHRpbWUs
IHNpbmNlIHRoZSBvcHRpbXVtIHRoaW5nIHRvIGRvIChtb2R1bG8gcmVwbGFjaW5nIHRoZSBlbnRp
cmUgCmFsZ29yaXRobS4uLikgaXMgYWN0dWFsbHkgdG8gbWFrZSB0aGUgc2Vjb25kIHBhcnQgb2Yg
dGhlIHNlYXJjaCAKKnVwd2FyZHMqIGZyb20gdGhlIGNhY2hlZCBub2RlIHRvIHRoZSBsaW1pdC4g
RnVydGhlcm1vcmUsIHRvIHJldml2ZSBteSAKYXJjaC9hcm0gY29udmVyc2lvbiBJIHRoaW5rIHdl
J3JlIHJlYWxpc3RpY2FsbHkgZ29pbmcgdG8gbmVlZCBhIApjb21wYXRpYmlsaXR5IG9wdGlvbiBm
b3IgYm90dG9tLXVwIGFsbG9jYXRpb24gdG8gYXZvaWQgdG9vIG1hbnkgbmFzdHkgCnN1cnByaXNl
cywgc28gSSdkIGxpa2UgdG8gZ2VuZXJhbGlzZSB0aGluZ3MgdG8gdGFja2xlIGJvdGggY29uY2Vy
bnMgYXQgb25jZS4KClRoYW5rcywKUm9iaW4uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
