Return-Path: <SRS0=OBKs=IG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C9EC433E0
	for <iommu@archiver.kernel.org>; Mon,  8 Mar 2021 15:16:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6A26521D
	for <iommu@archiver.kernel.org>; Mon,  8 Mar 2021 15:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6A26521D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E89C1836F1;
	Mon,  8 Mar 2021 15:16:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6kL8y2vjAUMY; Mon,  8 Mar 2021 15:16:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30C2883613;
	Mon,  8 Mar 2021 15:16:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DFCAC000A;
	Mon,  8 Mar 2021 15:16:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59F75C0001
 for <iommu@lists.linux-foundation.org>; Mon,  8 Mar 2021 15:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3AE176E753
 for <iommu@lists.linux-foundation.org>; Mon,  8 Mar 2021 15:16:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3re3PDS5wtyy for <iommu@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 15:16:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E98A605B3
 for <iommu@lists.linux-foundation.org>; Mon,  8 Mar 2021 15:16:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 138F631B;
 Mon,  8 Mar 2021 07:16:06 -0800 (PST)
Received: from [10.57.55.135] (unknown [10.57.55.135])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 647B63F73C;
 Mon,  8 Mar 2021 07:16:04 -0800 (PST)
Subject: Re: [PATCH 1/1] Revert "iommu/iova: Retry from last rb tree node if
 iova search fails"
To: John Garry <john.garry@huawei.com>,
 "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 iommu <iommu@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20210129092120.1482-1-thunder.leizhen@huawei.com>
 <5505b1e5-2450-d5c4-6d77-5bb21fd0b6a1@huawei.com>
 <e8ff095f-7b7c-da38-3675-cd3c1ee84b1a@arm.com>
 <7e18829a-3e7e-cc82-9d33-366cf2025624@huawei.com>
 <4c634a22-7168-b51c-a012-2009fc03e6c3@arm.com>
 <d090b869-b3ac-fecc-9efd-d870e43e0d99@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <eacd5ccd-ab5a-27fe-6542-deaefd597d11@arm.com>
Date: Mon, 8 Mar 2021 15:15:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <d090b869-b3ac-fecc-9efd-d870e43e0d99@huawei.com>
Content-Language: en-GB
Cc: Vijayanand Jitta <vjitta@codeaurora.org>, Linuxarm <linuxarm@huawei.com>
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

T24gMjAyMS0wMy0wMSAxNTo0OCwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAwMS8wMy8yMDIxIDEz
OjIwLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+Pj4gRldJVywgSSdtIDk5JSBzdXJlIHRoYXQgd2hh
dCB5b3UgcmVhbGx5IHdhbnQgaXMgWzFdLCBidXQgdGhlbiB5b3UgZ2V0Cj4+Pj4gdG8gYmF0dGxl
IGFnYWluc3QgYW4gdW5rbm93biBxdWFudGl0eSBvZiBkb2RneSBmaXJtd2FyZSBpbnN0ZWFkLgo+
Pj4+Cj4+PiBTb21ldGhpbmcgd2hpY2ggaGFzIG5vdCBiZWVuIHNhaWQgYmVmb3JlIGlzIHRoYXQg
dGhpcyBvbmx5IGhhcHBlbnMgZm9yCj4+PiBzdHJpY3QgbW9kZS4KPj4gSSB0aGluayB0aGF0IG1h
a2VzIHNlbnNlIC0gb25jZSB5b3UqaGF2ZSrCoCBhY3R1YWxseSBmYWlsZWQgdG8gYWxsb2NhdGUK
Pj4gZnJvbSB0aGUgMzItYml0IHNwYWNlLCBtYXgzMl9hbGxvY19zaXplIHdpbGwgbWFrZSBzdWJz
ZXF1ZW50IGF0dGVtcHRzCj4+IGZhaWwgaW1tZWRpYXRlbHkuIEluIG5vbi1zdHJpY3QgbW9kZSB5
b3UncmUgbW9zdCBsaWtlbHkgZnJlZWluZyAzMi1iaXQKPj4gSU9WQXMgYmFjayB0byB0aGUgdHJl
ZSAtIGFuZCB0aHVzIHJlc2V0IG1heDMyX2FsbG9jX3NpemUgLSBtdWNoIGxlc3MKPj4gb2Z0ZW4s
IGFuZCB5b3UnbGwgbWFrZSBtb3JlIHRvdGFsIHNwYWNlIGF2YWlsYWJsZSBlYWNoIHRpbWUsIGJv
dGggb2YKPj4gd2hpY2ggd2lsbCBhbW9ydGlzZSB0aGUgY29zdCBvZiBnZXR0aW5nIGJhY2sgaW50
byB0aGF0IGZhaWxlZCBzdGF0ZQo+PiBhZ2Fpbi4gQ29udmVyc2VseSwgdGhlIHdvcnN0IGNhc2Ug
aW4gc3RyaWN0IG1vZGUgaXMgdG8gaGF2ZSBtdWx0aXBsZQo+PiB0aHJlYWRzIGdldHRpbmcgaW50
byB0aGlzIHBhdGhvbG9naWNhbCBjeWNsZToKPj4KPj4gMTogYWxsb2NhdGUsIGdldCBsYXN0IGF2
YWlsYWJsZSBJT1ZBCj4+IDI6IGFsbG9jYXRlLCBmYWlsIGFuZCBzZXQgbWF4MzJfYWxsb2Nfc2l6
ZQo+PiAzOiBmcmVlIG9uZSBJT1ZBLCByZXNldCBtYXgzMl9hbGxvY19zaXplLCBnb3RvIDEKPj4K
Pj4gTm93LCBnaXZlbiB0aGUgYnJva2VuIGJlaGF2aW91ciB3aGVyZSB0aGUgY2FjaGVkIFBGTiBj
YW4gZ2V0IHN0dWNrIG5lYXIKPj4gdGhlIGJvdHRvbSBvZiB0aGUgYWRkcmVzcyBzcGFjZSwgc3Rl
cCAyIG1pZ2h0IHdlbGwgaGF2ZSBiZWVuIGZhc3RlciBhbmQKPj4gbW9yZSBwcmVtYXR1cmUgdGhh
biBpdCBzaG91bGQgaGF2ZSwgYnV0IEkgaG9wZSB5b3UgY2FuIGFwcHJlY2lhdGUgdGhhdAo+PiBy
ZWx5aW5nIG9uIGFuIGFsbG9jYXRvciBiZWluZyBicm9rZW4gYXQgaXRzIGZ1bmRhbWVudGFsIHB1
cnBvc2Ugb2YKPj4gYWxsb2NhdGluZyBpcyBub3QgYSBnb29kIG9yIHN1c3RhaW5hYmxlIHRoaW5n
IHRvIGRvLgo+IAo+IEkgZmlndXJlIHRoYXQgeW91J3JlIHRhbGtpbmcgYWJvdXQgNGU4OWRjZTcy
NTIxIG5vdy4gSSB3b3VsZCBoYXZlIGxpa2VkIAo+IHRvIGtub3cgd2hpY2ggcmVhbC1saWZlIHBy
b2JsZW0gaXQgc29sdmVkIGluIHByYWN0aWNlLgoKIEZyb20gd2hhdCBJIHJlbWVtYmVyLCB0aGUg
cHJvYmxlbSByZXBvcnRlZCB3YXMgYmFzaWNhbGx5IHRoZSBvbmUgCmlsbHVzdHJhdGVkIGluIHRo
YXQgY29tbWl0IGFuZCB0aGUgb25lIEkgYWxsdWRlZCB0byBhYm92ZSAtIG5hbWVseSB0aGF0IApj
ZXJ0YWluIGFsbG9jYXRpb24gcGF0dGVybnMgd2l0aCBhIGJyb2FkIG1peCBvZiBzaXplcyBhbmQg
cmVsYXRpdmUgCmxpZmV0aW1lcyBlbmQgdXAgcHVzaGluZyB0aGUgY2FjaGVkIFBGTiBkb3duIHRv
IHRoZSBib3R0b20gb2YgdGhlIAphZGRyZXNzIHNwYWNlIHN1Y2ggdGhhdCBhbGxvY2F0aW9ucyBz
dGFydCBmYWlsaW5nIGRlc3BpdGUgdGhlcmUgc3RpbGwgCmJlaW5nIHN1ZmZpY2llbnQgZnJlZSBz
cGFjZSBvdmVyYWxsLCB3aGljaCB3YXMgYnJlYWtpbmcgc29tZSBtZWRpYSAKd29ya2xvYWQuIFdo
YXQgd2FzIG9yaWdpbmFsbHkgcHJvcG9zZWQgd2FzIGFuIG92ZXJjb21wbGljYXRlZCBwYWxhdmVy
IAp3aXRoIERNQSBhdHRyaWJ1dGVzIGFuZCBhIHdob2xlIGV4dHJhIGFsbG9jYXRpb24gYWxnb3Jp
dGhtIHJhdGhlciB0aGFuIApqdXN0IGZpeGluZyB0aGUgY2xlYXJseSB1bmludGVuZGVkIGFuZCBi
cm9rZW4gYmVoYXZpb3VyLgoKPj4gV2hpbGUgbWF4MzJfYWxsb2Nfc2l6ZSBpbmRpcmVjdGx5IHRy
YWNrcyB0aGUgbGFyZ2VzdCpjb250aWd1b3VzKiAKPj4gYXZhaWxhYmxlIHNwYWNlLCBvbmUgb2Yg
dGhlIGlkZWFzIGZyb20gd2hpY2ggaXQgZ3JldyB3YXMgdG8gc2ltcGx5IGtlZXAKPj4gY291bnQg
b2YgdGhlIHRvdGFsIG51bWJlciBvZiBmcmVlIFBGTnMuIElmIHlvdSdyZSByZWFsbHkgc3BlbmRp
bmcKPj4gc2lnbmlmaWNhbnQgdGltZSBkZXRlcm1pbmluZyB0aGF0IHRoZSB0cmVlIGlzIGZ1bGws
IGFzIG9wcG9zZWQgdG8ganVzdAo+PiB0YWtpbmcgbG9uZ2VyIHRvIGV2ZW50dWFsbHkgc3VjY2Vl
ZCwgdGhlbiBpdCBtaWdodCBiZSByZWxhdGl2ZWx5Cj4+IGlubm9jdW91cyB0byB0YWNrIG9uIHRo
YXQgc2VtaS1yZWR1bmRhbnQgZXh0cmEgYWNjb3VudGluZyBhcyBhCj4+IHNlbGYtY29udGFpbmVk
IHF1aWNrIGZpeCBmb3IgdGhhdCB3b3JzdCBjYXNlLgo+Pgo+Pj4gQW55d2F5LCB3ZSBzZWUgfjUw
JSB0aHJvdWdocHV0IHJlZ3Jlc3Npb24sIHdoaWNoIGlzIGludG9sZXJhYmxlLiBBcyBzZWVuCj4+
PiBpbiBbMF0sIEkgcHV0IHRoaXMgZG93biB0byB0aGUgZmFjdCB0aGF0IHdlIGhhdmUgc28gbWFu
eSBJT1ZBIHJlcXVlc3RzCj4+PiB3aGljaCBleGNlZWQgdGhlIHJjYWNoZSBzaXplIGxpbWl0LCB3
aGljaCBtZWFucyBtYW55IFJCIHRyZWUgYWNjZXNzZXMKPj4+IGZvciBub24tY2FjaGVibGUgSU9W
QXMsIHdoaWNoIGFyZSBub3cgc2xvd2VyLgo+IAo+IEkgd2lsbCBhdHRlbXB0IHRvIHByb3ZlIHRo
aXMgYnkgaW5jcmVhc2luZyBSQ0FDSEUgUkFOR0UsIHN1Y2ggdGhhdCBhbGwgCj4gSU9WQSBzaXpl
cyBtYXkgYmUgY2FjaGVkLgo+IAo+Pj4KPj4+IE9uIGFub3RoZXIgcG9pbnQsIGFzIGZvciBsb25n
dGVybSBJT1ZBIGFnaW5nIGlzc3VlLCBpdCBzZWVtcyB0aGF0IHRoZXJlCj4+PiBpcyBubyBjb25j
bHVzaW9uIHRoZXJlLiBIb3dldmVyIEkgZGlkIG1lbnRpb24gdGhlIGlzc3VlIG9mIElPVkEgc2l6
ZXMKPj4+IGV4Y2VlZGluZyByY2FjaGUgc2l6ZSBmb3IgdGhhdCBpc3N1ZSwgc28gbWF5YmUgd2Ug
Y2FuIGZpbmQgYSBjb21tb24KPj4+IHNvbHV0aW9uLiBTaW1pbGFyIHRvIGEgZml4ZWQgcmNhY2hl
IGRlcG90IHNpemUsIGl0IHNlZW1zIHRoYXQgaGF2aW5nIGEKPj4+IGZpeGVkIHJjYWNoZSBtYXgg
c2l6ZSByYW5nZSB2YWx1ZSAoYXQgNikgZG9lc24ndCBzY2FsZSBlaXRoZXIuCj4+IFdlbGwsIEkn
ZCBzYXkgdGhhdCdzIG1vcmUgb2YgYSB3b3JrbG9hZCB0dW5pbmcgdGhpbmcgdGhhbiBhIHNjYWxh
YmlsaXR5Cj4+IG9uZSAtCj4gCj4gb2sKPiAKPj4gYSBtYXNzaXZlIHN5c3RlbSB3aXRoIGh1bmRy
ZWRzIG9mIENQVXMgdGhhdCBzcGVuZHMgYWxsIGRheQo+PiBmbGluZ2luZyAxNTAwLWJ5dGUgbmV0
d29yayBwYWNrZXRzIGFyb3VuZCBhcyBmYXN0IGFzIGl0IGNhbiBtaWdodCBiZQo+PiBoYXBweSB3
aXRoIGFuIGV2ZW4gc21hbGxlciB2YWx1ZSBhbmQgdXNpbmcgdGhlIHNhdmVkIG1lbW9yeSBmb3IK
Pj4gc29tZXRoaW5nIGVsc2UuIElJUkMgdGhlIHZhbHVlIG9mIDYgaXMgYSBmYWlybHkgYXJiaXRy
YXJ5IGNob2ljZSBmb3IgYQo+PiB0cmFkZW9mZiBiZXR3ZWVuIGV4cGVjdGVkIHV0aWxpdHkgYW5k
IG1lbW9yeSBjb25zdW1wdGlvbiwgc28gbWFraW5nIGl0IGEKPj4gS2NvbmZpZyBvciBjb21tYW5k
LWxpbmUgdHVuZWFibGUgZG9lcyBzZWVtIGxpa2UgYSBzZW5zaWJsZSB0aGluZyB0byAKPj4gZXhw
bG9yZS4KPiAKPiBFdmVuIGlmIGl0IGlzIHdlcmUgY29uZmlndXJhYmxlLCB3b3VsZG4ndCBpdCBt
YWtlIHNlbnNlIHRvIGhhdmUgaXQgCj4gY29uZmlndXJhYmxlIHBlciBJT1ZBIGRvbWFpbj8KClBl
cmhhcHMsIGJ1dCBJIGRvbid0IHNlZSB0aGF0IGJlaW5nIGF0IGFsbCBlYXN5IHRvIGltcGxlbWVu
dC4gV2UgY2FuJ3QgCmFyYml0cmFyaWx5ICppbmNyZWFzZSogdGhlIHNjb3BlIG9mIGNhY2hpbmcg
b25jZSBhIGRvbWFpbiBpcyBhY3RpdmUgZHVlIAp0byB0aGUgc2l6ZS1yb3VuZGluZy11cCByZXF1
aXJlbWVudCwgd2hpY2ggd291bGQgYmUgcHJvaGliaXRpdmUgdG8gCmxhcmdlciBhbGxvY2F0aW9u
cyBpZiBhcHBsaWVkIHVuaXZlcnNhbGx5LgoKPiBGdXJ0aGVybW9yZSwgYXMgbWVudGlvbmVkIGFi
b3ZlLCBJIHN0aWxsIHdhbnQgdG8gc29sdmUgdGhpcyBJT1ZBIGFnaW5nIAo+IGlzc3VlLCBhbmQg
dGhpcyBmaXhlZCBSQ0FDSEUgUkFOR0Ugc2l6ZSBzZWVtcyB0byBiZSB0aGUgYXQgdGhlIGNlbnRl
ciBvZiAKPiB0aGF0IHByb2JsZW0uCj4gCj4+Cj4+PiBBcyBmb3IgNGU4OWRjZTcyNTIxLCBzbyBl
dmVuIGlmIGl0J3MgcHJvcGVyIHRvIHJldHJ5IGZvciBhIGZhaWxlZCBhbGxvYywKPj4+IGl0IGlz
IG5vdCBhbHdheXMgbmVjZXNzYXJ5LiBJIG1lYW4sIGlmIHdlJ3JlIGxpbWl0aW5nIG91cnNlbHZl
cyB0byAzMmIKPj4+IHN1YnNwYWNlIGZvciB0aGlzIFNBQyB0cmljayBhbmQgd2UgZmFpbCB0aGUg
YWxsb2MsIHRoZW4gd2UgY2FuIHRyeSB0aGUKPj4+IHNwYWNlIGFib3ZlIDMyYiBmaXJzdCAoaWYg
dXNhYmxlKS4gSWYgdGhhdCBmYWlscywgdGhlbiByZXRyeSB0aGVyZS4gSQo+Pj4gZG9uJ3Qgc2Vl
IGEgbmVlZCB0byByZXRyeSB0aGUgMzJiIHN1YnNwYWNlIGlmIHdlJ3JlIG5vdCBsaW1pdGVkIHRv
IGl0Lgo+Pj4gSG93IGFib3V0IGl0PyBXZSB0cmllZCB0aGF0IGlkZWEgYW5kIGl0IGxvb2tzIHRv
IGp1c3QgYWJvdXQgcmVzdG9yZQo+Pj4gcGVyZm9ybWFuY2UuCj4+IFRoZSB0aGluZyBpcywgaWYg
eW91IGRvIGhhdmUgYW4gYWN0dWFsIFBDSSBkZXZpY2Ugd2hlcmUgREFDIG1pZ2h0IG1lYW4gYQo+
PiAzMyUgdGhyb3VnaHB1dCBsb3NzIGFuZCB5b3UncmUgbWFwcGluZyBhIGxvbmctbGl2ZWQgYnVm
ZmVyLCBvciB5b3UncmUgb24KPj4gb25lIG9mIHRoZXNlIHN5c3RlbXMgd2hlcmUgZmlybXdhcmUg
ZmFpbHMgdG8gZG9jdW1lbnQgYWRkcmVzcyBsaW1pdHMgYW5kCj4+IHVzaW5nIHRoZSBmdWxsIElP
TU1VIGFkZHJlc3Mgd2lkdGggcXVpZXRseSBicmVha3MgdGhpbmdzLCB0aGVuIHlvdQo+PiBhbG1v
c3QgY2VydGFpbmx5KmRvKsKgIHdhbnQgdGhlIGFsbG9jYXRvciB0byBhY3R1YWxseSBkbyBhIHBy
b3BlciBqb2Igb2YKPj4gdHJ5aW5nIHRvIHNhdGlzZnkgdGhlIGdpdmVuIHJlcXVlc3QuCj4gCj4g
SWYgdGhvc2UgY29uZGl0aW9ucyB3ZXJlIHRydWUsIHRoZW4gaXQgc2VlbXMgcXVpdGUgYSB0ZW51
b3VzIHBvc2l0aW9uLCAKPiBzbyB0cnlpbmcgdG8gaGVscCB0aGF0IHNjZW5hcmlvIGluIGdlbmVy
YWwgdGVybXMgd2lsbCBoYXZlIGxpbWl0ZWQgCj4gZWZmaWNhY3kuCgpTdGlsbCwgSSdkIGJlIGN1
cmlvdXMgdG8gc2VlIGlmIG1ha2luZyB0aGUgcmVzdGFydCBhIGJpdCBjbGV2ZXJlciBvZmZlcnMg
CmEgbm90aWNlYWJsZSBpbXByb3ZlbWVudC4gSUlSQyBJIHN1Z2dlc3RlZCBpdCBhdCB0aGUgdGlt
ZSwgYnV0IGluIHRoZSAKZW5kIHRoZSBwdXNoIHdhcyBqdXN0IHRvIGdldCAqc29tZXRoaW5nKiBt
ZXJnZWQuCgpSb2Jpbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
