Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F42C48BE5
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 19:03:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14346613F2
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 19:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14346613F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0F71841CE;
	Thu, 17 Jun 2021 19:03:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NqXDlvAUxqqd; Thu, 17 Jun 2021 19:03:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9727A84183;
	Thu, 17 Jun 2021 19:03:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63C25C000D;
	Thu, 17 Jun 2021 19:03:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A012C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 19:03:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 51C7B60D74
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 19:03:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GSU5Z7MbXv58 for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 19:03:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6384F60633
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 19:03:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B459313A1;
 Thu, 17 Jun 2021 12:03:35 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A150E3F694;
 Thu, 17 Jun 2021 12:03:33 -0700 (PDT)
Subject: Re: [PATCH v13 4/6] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To: John Garry <john.garry@huawei.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 joro@8bytes.org, will@kernel.org, dwmw2@infradead.org, corbet@lwn.net
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
 <1623841437-211832-5-git-send-email-john.garry@huawei.com>
 <46dbce5c-1c2b-60d4-df56-d2b95a959425@linux.intel.com>
 <f3fe6c4b-f360-ab7b-7ad2-ced63269499d@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <cc22fd7e-2cb6-d33a-33ab-bbca0a389507@arm.com>
Date: Thu, 17 Jun 2021 20:03:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <f3fe6c4b-f360-ab7b-7ad2-ced63269499d@huawei.com>
Content-Language: en-GB
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com, iommu@lists.linux-foundation.org
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

T24gMjAyMS0wNi0xNyAwOTowMCwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAxNy8wNi8yMDIxIDA4
OjMyLCBMdSBCYW9sdSB3cm90ZToKPj4gT24gNi8xNi8yMSA3OjAzIFBNLCBKb2huIEdhcnJ5IHdy
b3RlOgo+Pj4gQEAgLTQzODIsOSArNDM4MCw5IEBAIGludCBfX2luaXQgaW50ZWxfaW9tbXVfaW5p
dCh2b2lkKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBpcyBsaWtlbHkgdG8gYmUgbXVjaCBs
b3dlciB0aGFuIHRoZSBvdmVyaGVhZCBvZiAKPj4+IHN5bmNocm9uaXppbmcKPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgICogdGhlIHZpcnR1YWwgYW5kIHBoeXNpY2FsIElPTU1VIHBhZ2UtdGFibGVz
Lgo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAoIWlu
dGVsX2lvbW11X3N0cmljdCAmJiBjYXBfY2FjaGluZ19tb2RlKGlvbW11LT5jYXApKSB7Cj4+PiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl93YXJuKCJJT01NVSBiYXRjaGluZyBpcyBkaXNhYmxl
ZCBkdWUgdG8gCj4+PiB2aXJ0dWFsaXphdGlvbiIpOwo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaW50ZWxfaW9tbXVfc3RyaWN0ID0gMTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoY2FwX2Nh
Y2hpbmdfbW9kZShpb21tdS0+Y2FwKSkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJf
d2FybigiSU9NTVUgYmF0Y2hpbmcgZGlzYWxsb3dlZCBkdWUgdG8gCj4+PiB2aXJ0dWFsaXphdGlv
blxuIik7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb21tdV9zZXRfZG1hX3N0cmljdCh0
cnVlKTsKPj4KPj4gV2l0aCB0aGlzIGNoYW5nZSwgVk0gZ3Vlc3Qgd2lsbCBhbHdheXMgc2hvdyB0
aGlzIHdhcm5pbmcuCj4gCj4gV291bGQgdGhleSBoYXZlIGdvdCBpdCBiZWZvcmUgYWxzbyBub3Jt
YWxseT8KPiAKPiBJIG1lYW4sIGRlZmF1bHQgaXMgaW50ZWxfaW9tbXVfc3RyaWN0PTAsIHNvIGlm
IAo+IGNhcF9jYWNoaW5nX21vZGUoaW9tbXUtPmNhcCkgaXMgdHJ1ZSBhbmQgaW50ZWxfaW9tbXVf
c3RyaWN0IG5vdCBzZXQgdG8gMSAKPiBlbHNld2hlcmUgcHJldmlvdXNseSwgdGhlbiB3ZSB3b3Vs
ZCBnZXQgdGhpcyBwcmludC4KPiAKPj4gSG93IGFib3V0Cj4+IHJlbW92aW5nIHRoaXMgbWVzc2Fn
ZT8gVXNlcnMgY291bGQgZ2V0IHRoZSBzYW1lIGluZm9ybWF0aW9uIHRocm91Z2ggdGhlCj4+IGtl
cm5lbCBtZXNzYWdlIGFkZGVkIGJ5ICJbUEFUQ0ggdjEzIDIvNl0gaW9tbXU6IFByaW50IHN0cmlj
dCBvciBsYXp5Cj4+IG1vZGUgYXQgaW5pdCB0aW1lIi4KPiAKPiBJIHRoaW5rIHRoYXQgdGhlIHBy
aW50IGZyb20gMi82IHNob3VsZCBvY2N1ciBiZWZvcmUgdGhpcyBwcmludC4KPiAKPiBSZWdhcmRs
ZXNzIEkgd291bGQgdGhpbmsgdGhhdCB5b3Ugd291bGQgc3RpbGwgbGlrZSB0byBiZSBub3RpZmll
ZCBvZiAKPiB0aGlzIGNoYW5nZSBpbiBwb2xpY3ksIHJpZ2h0Pwo+IAo+IEhvd2V2ZXIgSSBub3cg
cmVhbGl6ZSB0aGF0IHRoZSBwcmludCBpcyBpbiBhIGxvb3AgcGVyIGlvbW11LCBzbyB3ZSB3b3Vs
ZCAKPiBnZXQgaXQgcGVyIGlvbW11Ogo+IAo+IGZvcl9lYWNoX2FjdGl2ZV9pb21tdShpb21tdSwg
ZHJoZCkgewo+ICDCoMKgwqDCoC8qCj4gIMKgwqDCoMKgICogVGhlIGZsdXNoIHF1ZXVlIGltcGxl
bWVudGF0aW9uIGRvZXMgbm90IHBlcmZvcm0KPiAgwqDCoMKgwqAgKiBwYWdlLXNlbGVjdGl2ZSBp
bnZhbGlkYXRpb25zIHRoYXQgYXJlIHJlcXVpcmVkIGZvciBlZmZpY2llbnQKPiAgwqDCoMKgwqAg
KiBUTEIgZmx1c2hlcyBpbiB2aXJ0dWFsIGVudmlyb25tZW50cy7CoCBUaGUgYmVuZWZpdCBvZiBi
YXRjaGluZwo+ICDCoMKgwqDCoCAqIGlzIGxpa2VseSB0byBiZSBtdWNoIGxvd2VyIHRoYW4gdGhl
IG92ZXJoZWFkIG9mIHN5bmNocm9uaXppbmcKPiAgwqDCoMKgwqAgKiB0aGUgdmlydHVhbCBhbmQg
cGh5c2ljYWwgSU9NTVUgcGFnZS10YWJsZXMuCj4gIMKgwqDCoMKgICovCj4gIMKgwqDCoMKgaWYg
KCFpbnRlbF9pb21tdV9zdHJpY3QgJiYgY2FwX2NhY2hpbmdfbW9kZShpb21tdS0+Y2FwKSkgewo+
ICDCoMKgwqDCoMKgwqDCoCBwcl93YXJuKCJJT01NVSBiYXRjaGluZyBpcyBkaXNhYmxlZCBkdWUg
dG8gdmlydHVhbGl6YXRpb24iKTsKPiAgwqDCoMKgwqDCoMKgwqAgaW50ZWxfaW9tbXVfc3RyaWN0
ID0gMTsKPiAgwqDCoMKgwqB9Cj4gIMKgwqDCoMKgLi4uCj4gfQo+IAo+IEkgbmVlZCB0byBjaGFu
Z2UgdGhhdC4gSG93IGFib3V0IHRoaXM6Cj4gCj4gYm9vbCBwcmludF93YXJuaW5nID0gZmFsc2U7
Cj4gCj4gZm9yX2VhY2hfYWN0aXZlX2lvbW11KGlvbW11LCBkcmhkKSB7Cj4gIMKgwqDCoMKgLyoK
PiAgwqDCoMKgwqAgKiBUaGUgZmx1c2ggcXVldWUgaW1wbGVtZW50YXRpb24gZG9lcyBub3QgcGVy
Zm9ybQo+ICDCoMKgwqDCoCAqIHBhZ2Utc2VsZWN0aXZlIGludmFsaWRhdGlvbnMgdGhhdCBhcmUg
cmVxdWlyZWQgZm9yIGVmZmljaWVudAo+ICDCoMKgwqDCoCAqIFRMQiBmbHVzaGVzIGluIHZpcnR1
YWwgZW52aXJvbm1lbnRzLsKgIFRoZSBiZW5lZml0IG9mIGJhdGNoaW5nCj4gIMKgwqDCoMKgICog
aXMgbGlrZWx5IHRvIGJlIG11Y2ggbG93ZXIgdGhhbiB0aGUgb3ZlcmhlYWQgb2Ygc3luY2hyb25p
emluZwo+ICDCoMKgwqDCoCAqIHRoZSB2aXJ0dWFsIGFuZCBwaHlzaWNhbCBJT01NVSBwYWdlLXRh
Ymxlcy4KPiAgwqDCoMKgwqAgKi8KPiAgwqDCoMKgwqBpZiAoIXByaW50X3dhcm5pbmcgJiYgY2Fw
X2NhY2hpbmdfbW9kZShpb21tdS0+Y2FwKSkgewo+ICDCoMKgwqDCoMKgwqDCoCBwcl93YXJuKCJJ
T01NVSBiYXRjaGluZyBkaXNhbGxvd2VkIGR1ZSB0byB2aXJ0dWFsaXphdGlvblxuIik7Cj4gIMKg
wqDCoMKgwqDCoMKgIGlvbW11X3NldF9kbWFfc3RyaWN0KHRydWUpOwo+ICDCoMKgwqDCoMKgwqDC
oCBwcmludF93YXJuaW5nID0gdHJ1ZTsKPiAgwqDCoMKgwqB9Cj4gIMKgwqDCoMKgLi4uCj4gfQo+
IAo+IG9yIHVzZSBwcl93YXJuX29uY2UoKS4KCk1heWJlIGV2ZW4gZG93bmdyYWRlIGl0IHRvIHBy
X2luZm9fb25jZSgpLCBzaW5jZSBBSVVJIGl0J3Mgbm90IHJlYWxseSAKYW55dGhpbmcgc2Nhcnk/
CgpJIHN1cHBvc2UgeW91IGNvdWxkIHRlY2huaWNhbGx5IGZha2UgdXAgYSBkb21haW4gb24gdGhl
IHN0YWNrIHRvIGdldCB0aGUgCmdsb2JhbCBzZXR0aW5nIG91dCBvZiBpb21tdV9nZXRfZG1hX3N0
cmljdCgpLCBvciBwZXJoYXBzIGdpdmUgCmlvbW11X3NldF9kbWFfc3RyaWN0KCkgYSBjaGVla3kg
cmV0dXJuIHZhbHVlIHRvIGluZGljYXRlIHdoYXQgdGhlIApwcmV2aW91cyBzZXR0aW5nIHdhcywg
aW4gb3JkZXIgdG8gc3VwcHJlc3MgdGhlIG1lc3NhZ2UgZW50aXJlbHkgaWYgCnN0cmljdCBpcyBh
bHJlYWR5IHNldCwgYnV0IEknbSBub3QgYXQgYWxsIGNvbnZpbmNlZCBpdCdzIHdvcnRoIHRoZSBi
b3RoZXIuCgpSb2Jpbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
