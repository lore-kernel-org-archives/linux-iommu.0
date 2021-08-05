Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C8DC4320A
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 14:42:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CCA461154
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 14:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9CCA461154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56F56607E4;
	Thu,  5 Aug 2021 14:42:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dZz_qFLiqfiD; Thu,  5 Aug 2021 14:42:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8E91E608A5;
	Thu,  5 Aug 2021 14:42:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 474CCC0010;
	Thu,  5 Aug 2021 14:42:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 843CAC000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 14:42:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C67583A72
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 14:42:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QRRpFY8Dvw-l for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 14:42:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7997283A43
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 14:42:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C9A531B;
 Thu,  5 Aug 2021 07:42:04 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59A733F66F;
 Thu,  5 Aug 2021 07:42:03 -0700 (PDT)
Subject: Re: [PATCH] iommu/arm-smmu-v3: Remove some unneeded init in
 arm_smmu_cmdq_issue_cmdlist()
To: John Garry <john.garry@huawei.com>, will@kernel.org
References: <1624293394-202509-1-git-send-email-john.garry@huawei.com>
 <ee1f3ab5-3acc-f442-f2d2-898cf88bc447@arm.com>
 <45a8af4f-4202-ecd8-0882-507acf9b2eb2@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <577a625a-4fc5-7402-8e4f-4e0e5be93144@arm.com>
Date: Thu, 5 Aug 2021 15:41:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <45a8af4f-4202-ecd8-0882-507acf9b2eb2@huawei.com>
Content-Language: en-GB
Cc: linuxarm@huawei.com, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

T24gMjAyMS0wOC0wNSAxNDo0MCwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAwNS8wOC8yMDIxIDEy
OjI0LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4+IE9uIDIwMjEtMDYtMjEgMTc6MzYsIEpvaG4gR2Fy
cnkgd3JvdGU6Cj4+PiBNZW1iZXJzIG9mIHN0cnVjdCAibGxxIiB3aWxsIGJlIHplcm8taW5pdGVk
LCBhcGFydCBmcm9tIG1lbWJlciAKPj4+IG1heF9uX3NoaWZ0Lgo+Pj4gQnV0IHdlIHdyaXRlIGxs
cS52YWwgc3RyYWlnaHQgYWZ0ZXIgdGhlIGluaXQsIHNvIGl0IHdhcyBwb2ludGxlc3MgdG8gCj4+
PiB6ZXJvCj4+PiBpbml0IHRob3NlIG90aGVyIG1lbWJlcnMuIEFzIHN1Y2gsIHNlcGFyYXRlbHkg
aW5pdCBtZW1iZXIgbWF4X25fc2hpZnQKPj4+IG9ubHkuCj4+Pgo+Pj4gSW4gYWRkaXRpb24sIHN0
cnVjdCAiaGVhZCIgaXMgaW5pdGlhbGlzZWQgdG8gImxscSIgb25seSBzbyB0aGF0IG1lbWJlcgo+
Pj4gbWF4X25fc2hpZnQgaXMgc2V0LiBCdXQgdGhhdCBtZW1iZXIgaXMgbmV2ZXIgcmVmZXJlbmNl
ZCBmb3IgImhlYWQiLCBzbwo+Pj4gcmVtb3ZlIGFueSBpbml0IHRoZXJlLgo+Pj4KPj4+IFJlbW92
aW5nIHRoZXNlIGluaXRpYWxpemF0aW9ucyBpcyBzZWVuIGFzIGEgc21hbGwgcGVyZm9ybWFuY2Ug
Cj4+PiBvcHRpbWlzYXRpb24sCj4+PiBhcyB0aGlzIGNvZGUgaXMgKHZlcnkpIGhvdCBwYXRoLgo+
Pgo+PiBJIGxvb2tlZCBhdCB0aGlzIGFuZCBpbW1lZGlhdGVseSB0aG91Z2h0ICJzdXJlbHkgdGhl
IGNvbXBpbGVyIGNhbiBzZWUgCj4+IHRoYXQgYWxsIHRoZSBwcm9kL2NvbnMvdmFsIGZpZWxkcyBh
cmUgd3JpdHRlbiBhbnl3YXkgYW5kIGVsaWRlIHRoZSAKPj4gaW5pdGlhbGlzYXRpb24/Iiwgc28g
SSBkdW1wZWQgdGhlIGJlZm9yZSBhbmQgYWZ0ZXIgZGlzYXNzZW1ibHksIGFuZC4uLiAKPj4gb2gu
Cj4+Cj4+IFlvdSBzaG91bGQgcHJvYmFibHkgY2xhcmlmeSB0aGF0IGl0J3MgemVyby1pbml0aWFs
aXNpbmcgYWxsIHRoZSAKPj4gY2FjaGVsaW5lIHBhZGRpbmcgd2hpY2ggaXMgYm90aCBwb2ludGxl
c3MgYW5kIHBhaW5mdWwuIFdpdGggdGhhdCwKPj4KPj4gUmV2aWV3ZWQtYnk6IFJvYmluIE11cnBo
eSA8cm9iaW4ubXVycGh5QGFybS5jb20+Cj4+Cj4+IEhvd2V2ZXIsIGhhdmluZyBsb29rZWQgdGhp
cyBjbG9zZWx5IEknbSBub3cgdGFuZ2VudGlhbGx5IHdvbmRlcmluZyB3aHkgCj4+IG1heF9uX3No
aWZ0IGlzbid0IGluc2lkZSB0aGUgcGFkZGVkIHVuaW9uPyBJdCdzIHJlYWQgYXQgdGhlIHNhbWUg
dGltZSAKPj4gYXMgYm90aCBwcm9kIGFuZCBjb25zIGJ5IHF1ZXVlX2hhc19zcGFjZSgpLCBhbmQg
bmV2ZXIgdXBkYXRlZCwgc28gCj4+IHRoZXJlIGRvZXNuJ3QgYXBwZWFyIHRvIGJlIGFueSBiZW5l
Zml0IHRvIGl0IGJlaW5nIGluIGEgc2VwYXJhdGUgCj4+IGNhY2hlbGluZSBhbGwgYnkgaXRzZWxm
LCBhbmQgbGxxIGlzIGFscmVhZHkgdHdpY2UgYXMgYmlnIGFzIGl0IG5lZWRzIAo+PiB0byBiZS4K
PiAKPiBJIHRoaW5rIHRoYXQgdGhlIHByb2JsZW0gaXMgaWYgdGhlIHByb2QrY29ucyA2NGIgdmFs
dWUgYW5kIHRoZSBzaGlmdCBhcmUgCj4gb24gdGhlIHNhbWUgY2FjaGVsaW5lLCB0aGVuIHdlIGhh
dmUgYSBjaGFuY2Ugb2YgYWNjZXNzaW5nIGEgc3RhbGUgCj4gY2FjaGVsaW5lIHR3aWNlOgo+IAo+
IHN0YXRpYyBpbnQgYXJtX3NtbXVfY21kcV9pc3N1ZV9jbWRsaXN0KHN0cnVjdCBhcm1fc21tdV9k
ZXZpY2UgKnNtbXUsCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHU2NCAqY21kcywgaW50IG4sIGJvb2wgc3luYykKPiB7Cj4gIMKgwqDCoMKgdTY0IGNtZF9z
eW5jW0NNRFFfRU5UX0RXT1JEU107Cj4gIMKgwqDCoMKgdTMyIHByb2Q7Cj4gIMKgwqDCoMKgdW5z
aWduZWQgbG9uZyBmbGFnczsKPiAgwqDCoMKgwqBib29sIG93bmVyOwo+ICDCoMKgwqDCoHN0cnVj
dCBhcm1fc21tdV9jbWRxICpjbWRxID0gJnNtbXUtPmNtZHE7Cj4gIMKgwqDCoMKgc3RydWN0IGFy
bV9zbW11X2xsX3F1ZXVlIGxscSA9IHsKPiAgwqDCoMKgwqDCoMKgwqAgLm1heF9uX3NoaWZ0ID0g
Y21kcS0+cS5sbHEubWF4X25fc2hpZnQswqDCoMKgIC8vIGhlcmUKPiAgwqDCoMKgwqB9LCBoZWFk
ID0gbGxxOwo+ICDCoMKgwqDCoGludCByZXQgPSAwOwo+IAo+ICDCoMKgwqDCoC8qIDEuIEFsbG9j
YXRlIHNvbWUgc3BhY2UgaW4gdGhlIHF1ZXVlICovCj4gIMKgwqDCoMKgbG9jYWxfaXJxX3NhdmUo
ZmxhZ3MpOwo+ICDCoMKgwqDCoGxscS52YWwgPSBSRUFEX09OQ0UoY21kcS0+cS5sbHEudmFsKTvC
oMKgwqAgLy8gYW5kIGFnYWluIGhlcmUKPiAKPiAKPiBzaW5jZSBjbWRxLT5xLmxscSBpcyBwZXIt
U01NVS4gSWYgbWF4X25fc2hpZnQgaXMgb24gYSBzZXBhcmF0ZSAKPiBjYWNoZWxpbmUsIHRoZW4g
aXQgc2hvdWxkIG5ldmVyIGJlIHN0YWxlLgoKQWgsIHJpZ2h0LCBldmVuIHRob3VnaCB0aGUgYWNj
ZXNzZXMgYXJlIGFsd2F5cyBnb2luZyB0byBiZSBjbG9zZSAKdG9nZXRoZXIsIEkgc3VwcG9zZSBp
dCBjb3VsZCBzdGlsbCB0ZWNobmljYWxseSBjYXVzZSBzb21lIGZhbHNlIHNoYXJpbmcgCmlmIHNv
bWVvbmUgZWxzZSBpcyB0cnlpbmcgdG8gdXBkYXRlIHByb2QgYXQgZXhhY3RseSB0aGUgcmlnaHQg
dGltZS4gSSAKZ3Vlc3MgdGhhdCBtaWdodCBiZSB3aHkgd2UgbmVlZCB0aGUgZXhwbGljaXQgcGFk
ZGluZyB0aGVyZSBpbiB0aGUgZmlyc3QgCnBsYWNlLCBpdCdzIGp1c3QgYSBzaGFtZSB0aGF0IGl0
IGVuZHMgdXAgd2FzdGluZyBldmVuIG1vcmUgc3BhY2Ugd2l0aCAKaW1wbGljaXQgcGFkZGluZyBh
dCB0aGUgZW5kIHRvbyAoYW5kIEkgaGF2ZSBhIHZhZ3VlIG1lbW9yeSB0aGF0IHRyeWluZyAKdG8g
Zm9yY2UgbWVtYmVyIGFsaWdubWVudCBhbmQgc3RydWN0dXJlIHBhY2tpbmcgYXQgdGhlIHNhbWUg
dGltZSBkb2Vzbid0IAp3b3JrIHdlbGwpLiBPaCB3ZWxsLgoKPiBJIHN1cHBvc2UgdGhleSBjb3Vs
ZCBiZSBjb21iaW5lZCBpbnRvIGEgc21hbGxlciBzdWItc3RydWN0IGFuZCBsb2FkZWQgaW4gCj4g
YSBzaW5nbGUgb3BlcmF0aW9uLCBidXQgaXQgbG9va3MgbWVzc3ksIGFuZCBwcm9iIHdpdGhvdXQg
bXVjaCBnYWluLgoKSW5kZWVkIEkgd291bGRuJ3Qgc2F5IHRoYXQgc2F2aW5nIG1lbW9yeSBpcyB0
aGUgcHJpbWFyeSBjb25jZXJuIGhlcmUsIAphbmQgYW55IG1vcmUgY29udm9sdXRlZCBjb2RlIGlz
IGhhcmRseSBnb2luZyB0byBoZWxwIHBlcmZvcm1hbmNlLiBQbHVzIAppdCBzdGlsbCB3b3VsZG4n
dCBoZWxwIHRoZSBvdGhlciBjYXNlcyB3aGVyZSB3ZSdyZSBqdXN0IGNvcHlpbmcgdGhlIHNpemUg
CmludG8gYSBmYWtlIHF1ZXVlIHRvIGRvIHNvbWUgcHJvZCBhcml0aG1ldGljIC0gSSBoYWRuJ3Qg
ZnVsbHkgY2xvY2tlZCAKd2hhdCB3YXMgZ29pbmcgb24gdGhlcmUgd2hlbiBJIHNraW1tZWQgdGhy
b3VnaCB0aGluZ3MgZWFybGllci4KCkRpc3JlZ2FyZGluZyB0aGUgYm9ndXMgbGF5b3V0IGNoYW5n
ZSwgdGhvdWdoLCBkbyB5b3UgcmVja29uIHRoZSByZXN0IG9mIApteSBpZGVhIG1ha2VzIHNlbnNl
PwoKQ2hlZXJzLApSb2Jpbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lv
bW11
