Return-Path: <SRS0=sMz+=LM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA0EC2B9F4
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 01:48:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F673613B4
	for <iommu@archiver.kernel.org>; Fri, 18 Jun 2021 01:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F673613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 052C960628;
	Fri, 18 Jun 2021 01:48:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HRMlUYIliGsL; Fri, 18 Jun 2021 01:48:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D46766009C;
	Fri, 18 Jun 2021 01:48:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9103C000D;
	Fri, 18 Jun 2021 01:48:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58AA6C000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 01:47:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4936360612
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 01:47:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qBCzjbnnk7kT for <iommu@lists.linux-foundation.org>;
 Fri, 18 Jun 2021 01:47:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F1C7460611
 for <iommu@lists.linux-foundation.org>; Fri, 18 Jun 2021 01:47:56 +0000 (UTC)
IronPort-SDR: rhYD9MRuRo+tifhfSRJKqlDN5fAyh/jPhDgPMfw3uxul/K8EFIwACSqwZRFV9uDXxlolL9RNRL
 ybt62exifMvQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="203456436"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; d="scan'208";a="203456436"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2021 18:47:55 -0700
IronPort-SDR: kEflpgrQfTrMXjL0qCHu94Hq3SWkwi5YoXUQzL8ZbmBwaRiE6t7/IHjTdU+u+6WcP9Wq8FrGj/
 VS73Oscd56pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; d="scan'208";a="472612100"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2021 18:47:51 -0700
Subject: Re: [PATCH v13 4/6] iommu/vt-d: Add support for IOMMU default DMA
 mode build options
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 dwmw2@infradead.org, robin.murphy@arm.com, corbet@lwn.net
References: <1623841437-211832-1-git-send-email-john.garry@huawei.com>
 <1623841437-211832-5-git-send-email-john.garry@huawei.com>
 <46dbce5c-1c2b-60d4-df56-d2b95a959425@linux.intel.com>
 <f3fe6c4b-f360-ab7b-7ad2-ced63269499d@huawei.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d53a6472-4628-313e-30a5-f76e016c9cb9@linux.intel.com>
Date: Fri, 18 Jun 2021 09:46:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f3fe6c4b-f360-ab7b-7ad2-ced63269499d@huawei.com>
Content-Language: en-US
Cc: linux-doc@vger.kernel.org, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
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

SGkgSm9obiwKCk9uIDYvMTcvMjEgNDowMCBQTSwgSm9obiBHYXJyeSB3cm90ZToKPiBPbiAxNy8w
Ni8yMDIxIDA4OjMyLCBMdSBCYW9sdSB3cm90ZToKPj4gT24gNi8xNi8yMSA3OjAzIFBNLCBKb2hu
IEdhcnJ5IHdyb3RlOgo+Pj4gQEAgLTQzODIsOSArNDM4MCw5IEBAIGludCBfX2luaXQgaW50ZWxf
aW9tbXVfaW5pdCh2b2lkKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBpcyBsaWtlbHkgdG8g
YmUgbXVjaCBsb3dlciB0aGFuIHRoZSBvdmVyaGVhZCBvZiAKPj4+IHN5bmNocm9uaXppbmcKPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgICogdGhlIHZpcnR1YWwgYW5kIHBoeXNpY2FsIElPTU1VIHBh
Z2UtdGFibGVzLgo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPj4+IC3CoMKgwqDCoMKgwqDC
oCBpZiAoIWludGVsX2lvbW11X3N0cmljdCAmJiBjYXBfY2FjaGluZ19tb2RlKGlvbW11LT5jYXAp
KSB7Cj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl93YXJuKCJJT01NVSBiYXRjaGluZyBp
cyBkaXNhYmxlZCBkdWUgdG8gCj4+PiB2aXJ0dWFsaXphdGlvbiIpOwo+Pj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaW50ZWxfaW9tbXVfc3RyaWN0ID0gMTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBp
ZiAoY2FwX2NhY2hpbmdfbW9kZShpb21tdS0+Y2FwKSkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcHJfd2FybigiSU9NTVUgYmF0Y2hpbmcgZGlzYWxsb3dlZCBkdWUgdG8gCj4+PiB2aXJ0
dWFsaXphdGlvblxuIik7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpb21tdV9zZXRfZG1h
X3N0cmljdCh0cnVlKTsKPj4KPj4gV2l0aCB0aGlzIGNoYW5nZSwgVk0gZ3Vlc3Qgd2lsbCBhbHdh
eXMgc2hvdyB0aGlzIHdhcm5pbmcuCj4gCj4gV291bGQgdGhleSBoYXZlIGdvdCBpdCBiZWZvcmUg
YWxzbyBub3JtYWxseT8KPiAKPiBJIG1lYW4sIGRlZmF1bHQgaXMgaW50ZWxfaW9tbXVfc3RyaWN0
PTAsIHNvIGlmIAo+IGNhcF9jYWNoaW5nX21vZGUoaW9tbXUtPmNhcCkgaXMgdHJ1ZSBhbmQgaW50
ZWxfaW9tbXVfc3RyaWN0IG5vdCBzZXQgdG8gMSAKPiBlbHNld2hlcmUgcHJldmlvdXNseSwgdGhl
biB3ZSB3b3VsZCBnZXQgdGhpcyBwcmludC4KClllcy4gWW91IGFyZSByaWdodC4KCj4gCj4+IEhv
dyBhYm91dAo+PiByZW1vdmluZyB0aGlzIG1lc3NhZ2U/IFVzZXJzIGNvdWxkIGdldCB0aGUgc2Ft
ZSBpbmZvcm1hdGlvbiB0aHJvdWdoIHRoZQo+PiBrZXJuZWwgbWVzc2FnZSBhZGRlZCBieSAiW1BB
VENIIHYxMyAyLzZdIGlvbW11OiBQcmludCBzdHJpY3Qgb3IgbGF6eQo+PiBtb2RlIGF0IGluaXQg
dGltZSIuCj4gCj4gSSB0aGluayB0aGF0IHRoZSBwcmludCBmcm9tIDIvNiBzaG91bGQgb2NjdXIg
YmVmb3JlIHRoaXMgcHJpbnQuCj4gCj4gUmVnYXJkbGVzcyBJIHdvdWxkIHRoaW5rIHRoYXQgeW91
IHdvdWxkIHN0aWxsIGxpa2UgdG8gYmUgbm90aWZpZWQgb2YgCj4gdGhpcyBjaGFuZ2UgaW4gcG9s
aWN5LCByaWdodD8KPiAKPiBIb3dldmVyIEkgbm93IHJlYWxpemUgdGhhdCB0aGUgcHJpbnQgaXMg
aW4gYSBsb29wIHBlciBpb21tdSwgc28gd2Ugd291bGQgCj4gZ2V0IGl0IHBlciBpb21tdToKPiAK
PiBmb3JfZWFjaF9hY3RpdmVfaW9tbXUoaW9tbXUsIGRyaGQpIHsKPiAgwqDCoMKgwqAvKgo+ICDC
oMKgwqDCoCAqIFRoZSBmbHVzaCBxdWV1ZSBpbXBsZW1lbnRhdGlvbiBkb2VzIG5vdCBwZXJmb3Jt
Cj4gIMKgwqDCoMKgICogcGFnZS1zZWxlY3RpdmUgaW52YWxpZGF0aW9ucyB0aGF0IGFyZSByZXF1
aXJlZCBmb3IgZWZmaWNpZW50Cj4gIMKgwqDCoMKgICogVExCIGZsdXNoZXMgaW4gdmlydHVhbCBl
bnZpcm9ubWVudHMuwqAgVGhlIGJlbmVmaXQgb2YgYmF0Y2hpbmcKPiAgwqDCoMKgwqAgKiBpcyBs
aWtlbHkgdG8gYmUgbXVjaCBsb3dlciB0aGFuIHRoZSBvdmVyaGVhZCBvZiBzeW5jaHJvbml6aW5n
Cj4gIMKgwqDCoMKgICogdGhlIHZpcnR1YWwgYW5kIHBoeXNpY2FsIElPTU1VIHBhZ2UtdGFibGVz
Lgo+ICDCoMKgwqDCoCAqLwo+ICDCoMKgwqDCoGlmICghaW50ZWxfaW9tbXVfc3RyaWN0ICYmIGNh
cF9jYWNoaW5nX21vZGUoaW9tbXUtPmNhcCkpIHsKPiAgwqDCoMKgwqDCoMKgwqAgcHJfd2Fybigi
SU9NTVUgYmF0Y2hpbmcgaXMgZGlzYWJsZWQgZHVlIHRvIHZpcnR1YWxpemF0aW9uIik7Cj4gIMKg
wqDCoMKgwqDCoMKgIGludGVsX2lvbW11X3N0cmljdCA9IDE7Cj4gIMKgwqDCoMKgfQo+ICDCoMKg
wqDCoC4uLgo+IH0KPiAKPiBJIG5lZWQgdG8gY2hhbmdlIHRoYXQuIEhvdyBhYm91dCB0aGlzOgo+
IAo+IGJvb2wgcHJpbnRfd2FybmluZyA9IGZhbHNlOwo+IAo+IGZvcl9lYWNoX2FjdGl2ZV9pb21t
dShpb21tdSwgZHJoZCkgewo+ICDCoMKgwqDCoC8qCj4gIMKgwqDCoMKgICogVGhlIGZsdXNoIHF1
ZXVlIGltcGxlbWVudGF0aW9uIGRvZXMgbm90IHBlcmZvcm0KPiAgwqDCoMKgwqAgKiBwYWdlLXNl
bGVjdGl2ZSBpbnZhbGlkYXRpb25zIHRoYXQgYXJlIHJlcXVpcmVkIGZvciBlZmZpY2llbnQKPiAg
wqDCoMKgwqAgKiBUTEIgZmx1c2hlcyBpbiB2aXJ0dWFsIGVudmlyb25tZW50cy7CoCBUaGUgYmVu
ZWZpdCBvZiBiYXRjaGluZwo+ICDCoMKgwqDCoCAqIGlzIGxpa2VseSB0byBiZSBtdWNoIGxvd2Vy
IHRoYW4gdGhlIG92ZXJoZWFkIG9mIHN5bmNocm9uaXppbmcKPiAgwqDCoMKgwqAgKiB0aGUgdmly
dHVhbCBhbmQgcGh5c2ljYWwgSU9NTVUgcGFnZS10YWJsZXMuCj4gIMKgwqDCoMKgICovCj4gIMKg
wqDCoMKgaWYgKCFwcmludF93YXJuaW5nICYmIGNhcF9jYWNoaW5nX21vZGUoaW9tbXUtPmNhcCkp
IHsKPiAgwqDCoMKgwqDCoMKgwqAgcHJfd2FybigiSU9NTVUgYmF0Y2hpbmcgZGlzYWxsb3dlZCBk
dWUgdG8gdmlydHVhbGl6YXRpb25cbiIpOwo+ICDCoMKgwqDCoMKgwqDCoCBpb21tdV9zZXRfZG1h
X3N0cmljdCh0cnVlKTsKPiAgwqDCoMKgwqDCoMKgwqAgcHJpbnRfd2FybmluZyA9IHRydWU7Cj4g
IMKgwqDCoMKgfQo+ICDCoMKgwqDCoC4uLgo+IH0KPiAKPiBvciB1c2UgcHJfd2Fybl9vbmNlKCku
CgogRnJvbSBteSBwLm8udiwgcHJfeHh4eF9vbmNlKCkgaXMgYmV0dGVyLgoKSG93IGFib3V0IHVz
aW5nIGEgcHJfaW5mb19vbmNlKCk/IEkgZG9uJ3QgdGhpbmsgaXQncyBhIHdhcm5pbmcsIGl0J3MK
anVzdCBhIHBvbGljeSBjaG9pY2UgaW4gVk0gZW52aXJvbm1lbnQuCgpCZXN0IHJlZ2FyZHMsCmJh
b2x1Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11
IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
