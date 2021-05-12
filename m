Return-Path: <SRS0=CJHf=KH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D51C433B4
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 17:29:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF6E561417
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 17:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6E561417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 442E860A8E;
	Wed, 12 May 2021 17:29:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yRlqPdpwxVRU; Wed, 12 May 2021 17:29:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A6436088E;
	Wed, 12 May 2021 17:29:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D273EC000E;
	Wed, 12 May 2021 17:29:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EAEDC0001
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 17:29:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4CA9940209
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 17:29:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PBpR6dFo72kI for <iommu@lists.linux-foundation.org>;
 Wed, 12 May 2021 17:29:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 17D7940157
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 17:29:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F2BB31B;
 Wed, 12 May 2021 10:29:40 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37C463F719;
 Wed, 12 May 2021 10:29:35 -0700 (PDT)
Subject: Re: [Resend RFC PATCH V2 10/12] HV/IOMMU: Add Hyper-V dma ops support
To: Tianyu Lan <ltykernel@gmail.com>, Christoph Hellwig <hch@lst.de>,
 konrad.wilk@oracle.com
References: <20210414144945.3460554-1-ltykernel@gmail.com>
 <20210414144945.3460554-11-ltykernel@gmail.com>
 <20210414154729.GD32045@lst.de>
 <a316af73-2c96-f307-6285-593597e05123@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <4793ae97-5e29-4a45-d2b6-61c151322065@arm.com>
Date: Wed, 12 May 2021 18:29:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <a316af73-2c96-f307-6285-593597e05123@gmail.com>
Content-Language: en-GB
Cc: linux-hyperv@vger.kernel.org, brijesh.singh@amd.com, linux-mm@kvack.org,
 hpa@zytor.com, kys@microsoft.com, will@kernel.org, sunilmut@microsoft.com,
 linux-arch@vger.kernel.org, wei.liu@kernel.org, sthemmin@microsoft.com,
 linux-scsi@vger.kernel.org, x86@kernel.org, mingo@redhat.com, kuba@kernel.org,
 haiyangz@microsoft.com, thomas.lendacky@amd.com,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, arnd@arndb.de, jejb@linux.ibm.com,
 bp@alien8.de, tglx@linutronix.de, vkuznets@redhat.com,
 martin.petersen@oracle.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, akpm@linux-foundation.org, davem@davemloft.net
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

T24gMjAyMS0wNS0xMiAxNzowMSwgVGlhbnl1IExhbiB3cm90ZToKPiBIaSBDaHJpc3RvcGggYW5k
IEtvbnJhZDoKPiAgwqDCoMKgwqAgQ3VycmVudCBTd2lvdGxiIGJvdW5jZSBidWZmZXIgdXNlcyBh
IHBvb2wgZm9yIGFsbCBkZXZpY2VzLiBUaGVyZQo+IGlzIGEgaGlnaCBvdmVyaGVhZCB0byBnZXQg
b3IgZnJlZSBib3VuY2UgYnVmZmVyIGR1cmluZyBwZXJmb3JtYW5jZSB0ZXN0Lgo+IFN3aW90bGIg
Y29kZSBub3cgdXNlIGEgZ2xvYmFsIHNwaW4gbG9jayB0byBwcm90ZWN0IGJvdW5jZSBidWZmZXIg
ZGF0YS4KPiBTZXZlcmFsIGRldmljZSBxdWV1ZXMgdHJ5IHRvIGFjcXVpcmUgdGhlIHNwaW4gbG9j
ayBhbmQgdGhpcyBpbnRyb2R1Y2UKPiBhZGRpdGlvbmFsIG92ZXJoZWFkLgo+IAo+IEZvciBwZXJm
b3JtYW5jZSBhbmQgc2VjdXJpdHkgcGVyc3BlY3RpdmUsIGVhY2ggZGV2aWNlcyBzaG91bGQgaGF2
ZSBhCj4gc2VwYXJhdGUgc3dpb3RsYiBib3VuY2UgYnVmZmVyIHBvb2wgYW5kIHNvIHRoaXMgcGFy
dCBuZWVkcyB0byByZXdvcmsuCj4gSSB3YW50IHRvIGNoZWNrIHRoaXMgaXMgcmlnaHQgd2F5IHRv
IHJlc29sdmUgcGVyZm9ybWFuY2UgaXNzdWVzIHdpdGggCj4gc3dpb3RsYiBib3VuY2UgYnVmZmVy
LiBJZiB5b3UgaGF2ZSBzb21lIG90aGVyIHN1Z2dlc3Rpb25zLHdlbGNvbWUuCgpXZSdyZSBhbHJl
YWR5IHdlbGwgb24gdGhlIHdheSB0byBmYWN0b3Jpbmcgb3V0IFNXSU9UTEIgdG8gYWxsb3cgZm9y
IGp1c3QgCnRoaXMgc29ydCBvZiBtb3JlIGZsZXhpYmxlIHVzYWdlIGxpa2UgcGVyLWRldmljZSBi
b3VuY2UgcG9vbHMgLSBzZWUgaGVyZToKCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlv
bW11LzIwMjEwNTEwMDk1MDI2LjM0Nzc0OTYtMS10aWVudHp1QGNocm9taXVtLm9yZy9ULyN0CgpG
V0lXIHRoaXMgbG9va3MgdG8gaGF2ZSBhbiBhd2Z1bCBsb3QgaW4gY29tbW9uIHdpdGggd2hhdCdz
IGdvaW5nIHRvIGJlIApuZWVkZWQgZm9yIEFuZHJvaWQncyBwcm90ZWN0ZWQgS1ZNIGFuZCBBcm0n
cyBDb25maWRlbnRpYWwgQ29tcHV0ZSAKQXJjaGl0ZWN0dXJlLCBzbyB3ZSdsbCBhbGwgYmUgYmV0
dGVyIG9mZiBieSBkb2luZyBpdCByaWdodC4gSSdtIGdldHRpbmcgCnRoZSBmZWVsaW5nIHRoYXQg
c2V0X21lbW9yeV9kZWNyeXB0ZWQoKSB3YW50cyB0byBncm93IGludG8gYSBtb3JlIApnZW5lcmFs
IGFic3RyYWN0aW9uIHRoYXQgY2FuIHJldHVybiBhbiBhbGlhcyBhdCBhIGRpZmZlcmVudCBHUEEg
aWYgCm5lY2Vzc2FyeS4KClJvYmluLgoKPiAKPiBUaGFua3MuCj4gCj4gT24gNC8xNC8yMDIxIDEx
OjQ3IFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4+ICtzdGF0aWMgZG1hX2FkZHJfdCBo
eXBlcnZfbWFwX3BhZ2Uoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgcGFnZSAKPj4+ICpwYWdl
LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBv
ZmZzZXQsIHNpemVfdCBzaXplLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZW51bSBkbWFfZGF0YV9kaXJlY3Rpb24gZGlyLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBhdHRycykKPj4+ICt7Cj4+PiArwqDCoMKgIHBo
eXNfYWRkcl90IG1hcCwgcGh5cyA9IChwYWdlX3RvX3BmbihwYWdlKSA8PCBQQUdFX1NISUZUKSAr
IG9mZnNldDsKPj4+ICsKPj4+ICvCoMKgwqAgaWYgKCFodl9pc19pc29sYXRpb25fc3VwcG9ydGVk
KCkpCj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHBoeXM7Cj4+PiArCj4+PiArwqDCoMKgIG1h
cCA9IHN3aW90bGJfdGJsX21hcF9zaW5nbGUoZGV2LCBwaHlzLCBzaXplLCBIVl9IWVBfUEFHRV9T
SVpFLCAKPj4+IGRpciwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGF0dHJzKTsKPj4+ICvCoMKgwqAgaWYgKG1hcCA9PSAocGh5c19hZGRyX3QpRE1BX01BUFBJ
TkdfRVJST1IpCj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIERNQV9NQVBQSU5HX0VSUk9SOwo+
Pj4gKwo+Pj4gK8KgwqDCoCByZXR1cm4gbWFwOwo+Pj4gK30KPj4KPj4gVGhpcyBsYXJnZXJseSBk
dXBsaWNhdGVzIHdoYXQgZG1hLWRpcmVjdCArIHN3aW90bGIgZG9lcy7CoCBQbGVhc2UgdXNlCj4+
IGZvcmNlX2RtYV91bmVuY3J5cHRlZCB0byBmb3JjZSBib3VuY2UgYnVmZmVyaW5nIGFuZCBqdXN0
IHVzZSB0aGUgZ2VuZXJpYwo+PiBjb2RlLgo+Pgo+Pj4gK8KgwqDCoCBpZiAoaHZfaXNvbGF0aW9u
X3R5cGVfc25wKCkpIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCByZXQgPSBodl9zZXRfbWVtX2hvc3Rf
dmlzaWJpbGl0eSgKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGh5c190b192
aXJ0KGh5cGVydl9pb190bGJfc3RhcnQpLAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBoeXBlcnZfaW9fdGxiX3NpemUsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFZNQlVTX1BBR0VfVklTSUJMRV9SRUFEX1dSSVRFKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBp
ZiAocmV0KQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGFuaWMoIiVzOiBGYWlsIHRvIG1h
cmsgSHlwZXItdiBzd2lvdGxiIGJ1ZmZlciB2aXNpYmxlIAo+Pj4gdG8gaG9zdC4gZXJyPSVkXG4i
LAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19mdW5jX18sIHJldCk7
Cj4+PiArCj4+PiArwqDCoMKgwqDCoMKgwqAgaHlwZXJ2X2lvX3RsYl9yZW1hcCA9IGlvcmVtYXBf
Y2FjaGUoaHlwZXJ2X2lvX3RsYl9zdGFydAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKyBtc19oeXBlcnYuc2hhcmVkX2dwYV9ib3VuZGFyeSwKPj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aHlwZXJ2X2lvX3RsYl9zaXplKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIWh5cGVydl9pb190
bGJfcmVtYXApCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwYW5pYygiJXM6IEZhaWwgdG8g
cmVtYXAgaW8gdGxiLlxuIiwgX19mdW5jX18pOwo+Pj4gKwo+Pj4gK8KgwqDCoMKgwqDCoMKgIG1l
bXNldChoeXBlcnZfaW9fdGxiX3JlbWFwLCAweDAwLCBoeXBlcnZfaW9fdGxiX3NpemUpOwo+Pj4g
K8KgwqDCoMKgwqDCoMKgIHN3aW90bGJfc2V0X2JvdW5jZV9yZW1hcChoeXBlcnZfaW9fdGxiX3Jl
bWFwKTsKPj4KPj4gQW5kIHRoaXMgcmVhbGx5IG5lZWRzIHRvIGdvIGludG8gYSBjb21tb24gaG9v
ayB3aGVyZSB3ZSBjdXJyZW50bHkganVzdAo+PiBjYWxsIHNldF9tZW1vcnlfZGVjcnlwdGVkIHNv
IHRoYXQgYWxsIHRoZSBkaWZmZXJlbnQgc2NoZW1lcyBmb3IgdGhlc2UKPj4gdHJ1c3RlZCBWTXMg
KHdlIGhhdmUgYWJvdXQgaGFsZiBhIGRvemVuIG5vdykgY2FuIHNoYXJlIGNvZGUgcmF0aGVyIHRo
YW4KPj4gcmVpbnZlbnRpbmcgaXQuCj4+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby9pb21tdQ==
