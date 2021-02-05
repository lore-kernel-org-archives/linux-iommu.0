Return-Path: <SRS0=Vrxx=HH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C4AC433E0
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 16:53:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A39D564F08
	for <iommu@archiver.kernel.org>; Fri,  5 Feb 2021 16:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39D564F08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 39C4A87353;
	Fri,  5 Feb 2021 16:53:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bhkb5FVr47bv; Fri,  5 Feb 2021 16:53:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7B9F08734D;
	Fri,  5 Feb 2021 16:53:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 484A0C0174;
	Fri,  5 Feb 2021 16:53:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 381C0C013A
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 16:53:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1ED1286B67
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 16:53:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GX3VN4nbMmjL for <iommu@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 16:53:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail29.static.mailgun.info (mail29.static.mailgun.info
 [104.130.122.29])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8B79886B6C
 for <iommu@lists.linux-foundation.org>; Fri,  5 Feb 2021 16:52:59 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1612543981; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=k7n9FlyHx6L9wrSrBH2FDZDL4YL+IiOQL9mzFJp6CQc=;
 b=XX3DuV78EQKft1pHxzg4AYJRCHXPJwpqo3p+0OMx3biN/4v98u9UdI0kudhkGCXYqIm0V6XB
 1PUKha4CpX9E6Xi/lfj0zpCl4Miun4A7qYiu4XokM+QI6Vt933w3UdUmxhb7m6wjh/iOkAgC
 RQiOBdotasXNJeXSeNUAwUe1ak8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 601d77dbe3df861f4b6ba0f0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 05 Feb 2021 16:52:43
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id E017DC43465; Fri,  5 Feb 2021 16:52:42 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id DCFBDC433ED;
 Fri,  5 Feb 2021 16:52:41 +0000 (UTC)
MIME-Version: 1.0
Date: Fri, 05 Feb 2021 22:22:41 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: Consult on ARM SMMU debugfs
In-Reply-To: <04eec942-39b9-6bdd-5399-ab23e42c232f@arm.com>
References: <cd9296f1-a3ea-d8d6-0e14-2cd6f19a17da@hisilicon.com>
 <9a23610f-e0b4-92e6-6da6-3182d481db92@arm.com>
 <20210115151403.GZ1551@shell.armlinux.org.uk>
 <04eec942-39b9-6bdd-5399-ab23e42c232f@arm.com>
Message-ID: <b9db84be091286152a654850fdb34b97@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>,
 iommu@lists.linux-foundation.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
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

T24gMjAyMS0wMS0xNSAyMjo0NywgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjEtMDEtMTUg
MTU6MTQsIFJ1c3NlbGwgS2luZyAtIEFSTSBMaW51eCBhZG1pbiB3cm90ZToKPj4gT24gTW9uLCBK
YW4gMTEsIDIwMjEgYXQgMDg6MDE6NDhQTSArMDAwMCwgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4g
T24gMjAyMS0wMS0wNyAwMjo0NSwgY2hlbnhpYW5nIChNKSB3cm90ZToKPj4+PiBIaSBXaWxsLMOv
wr/CvSBSb2JpbiBvciBvdGhlciBndXlzLAo+Pj4+IAo+Pj4+IFdoZW4gZGVidWdnaW5nIFNNTVUv
U1ZBIGlzc3VlIG9uIGh1YXdlaSBBUk02NCBib2FyZCwgd2UgZmluZCB0aGF0IGl0Cj4+Pj4gbGFj
a3Mgb2YgZW5vdWdoIGRlYnVnZnMgZm9yIEFSTSBTTU1VIGRyaXZlciAoc3VjaCBhcwo+Pj4+IAo+
Pj4+IHRoZSB2YWx1ZSBvZiBTVEUvQ0Qgd2hpY2ggd2UgbmVlZCB0byBjaGVjayBzb21ldGltZXMp
LiBDdXJyZW50bHkgaXQKPj4+PiBjcmVhdGVzIHRvcC1sZXZlbCBpb21tdSBkaXJlY3RvcnkgaW4g
ZGVidWdmcywgYnV0IHRoZXJlIGlzIG5vIAo+Pj4+IGRlYnVnZnMKPj4+PiAKPj4+PiBmb3IgQVJN
IFNNTVUgZHJpdmVyIHNwZWNpYWxseS4gRG8geW91IGtub3cgd2hldGhlciBBUk0gaGF2ZSB0aGUg
cGxhbiAKPj4+PiB0bwo+Pj4+IGRvIHRoYXQgcmVjZW50bHk/Cj4+PiAKPj4+IEZXSVcgSSBkb24n
dCB0aGluayBJJ3ZlIGV2ZXIgZmVsdCB0aGUgbmVlZCB0byBuZWVkIHRvIGluc3BlY3QgdGhlIAo+
Pj4gU3RyZWFtCj4+PiBUYWJsZSBvbiBhIGxpdmUgc3lzdGVtLiBTbyBmYXIgdGhlIG5hdHVyZSBv
ZiB0aGUgU1RFIGNvZGUgaGFzIGJlZW4gCj4+PiBzaW1wbGUKPj4+IGVub3VnaCB0aGF0IGl0J3Mg
dmVyeSBoYXJkIGZvciBhbnkgZ2l2ZW4gU1RFIHRvIGJlICp3cm9uZyogLSBlaXRoZXIgCj4+PiBp
dCdzIHNldAo+Pj4gdXAgYXMgZXhwZWN0ZWQgYW5kIHRodXMgd29ya3MgZmluZSwgb3IgaXQncyBu
b3QgaW5pdGlhbGlzZWQgYXQgYWxsIAo+Pj4gYW5kIHlvdQo+Pj4gZ2V0IENfQkFEX1NURSwgd2hl
cmUgOTklIG9mIHRoZSB0aW1lIHlvdSB0aGVuIGp1c3QgY3Jvc3MtcmVmZXJlbmNlIAo+Pj4gdGhl
Cj4+PiBTdHJlYW0gSUQgYWdhaW5zdCB0aGUgZmlybXdhcmUgYW5kIGZpbmQgdGhhdCB0aGUgRFQv
SU9SVCBpcyB3cm9uZy4KPj4+IAo+Pj4gU2ltaWxhcmx5IEkgZG9uJ3QgdGhpbmsgSSd2ZSBldmVu
IGV2ZW4gKnNlZW4qIGFuIGlzc3VlIHRoYXQgY291bGQgYmUKPj4+IGF0dHJpYnV0ZWQgdG8gYSBj
b250ZXh0IGRlc2NyaXB0b3IsIGFsdGhvdWdoIEkgYXBwcmVjaWF0ZSB0aGF0IGFzIHdlIAo+Pj4g
c3RhcnQKPj4+IGxhbmRpbmcgbW9yZSBQQVNJRCBhbmQgU1ZBIHN1cHBvcnQgdGhlIHNjb3BlIGZv
ciB0aGF0IHN0YXJ0cyB0byB3aWRlbgo+Pj4gY29uc2lkZXJhYmx5Lgo+Pj4gCj4+PiBGZWVsIGZy
ZWUgdG8gcHJvcG9zZSBhIHBhdGNoIGlmIHlvdSBiZWxpZXZlIGl0IHdvdWxkIGJlIGdlbnVpbmVs
eSAKPj4+IHVzZWZ1bCBhbmQKPj4+IHdvbid0IGp1c3QgYml0LXJvdCBpbnRvIGEgbWFpbnRlbmFu
Y2UgYnVyZGVuLCBidXQgaXQncyBub3Qgc29tZXRoaW5nIAo+Pj4gdGhhdCdzCj4+PiBvbiBvdXIg
cm9hZG1hcCBoZXJlLgo+PiAKPj4gSSBkbyB0aGluayB0aGF0IHRoZSBJT01NVSBzdHVmZiBuZWVk
cyBiZXR0ZXIgZGVidWdnaW5nLiBJJ3ZlIGhpdCB0aGUKPj4gV0FSTl9PTigpIGluIF9fYXJtX2xw
YWVfbWFwKCksIGFuZCBpdCdzIGJlZW4gcHJldHR5IG11Y2ggdW5kZWJ1Z2dhYmxlLAo+PiBzbyBJ
J3ZlIHJlc29ydGVkIHRvIHB1dHRpbmcgdGhlIElPTU1VIGludG8gYnlwYXNzIG1vZGUgcGVybWFu
ZW50bHkgdG8KPj4gd29yayBhcm91bmQgdGhlIGlzc3VlLgo+PiAKPj4gVGhlIHJlYXNvbiB0aGF0
IGl0J3MgdW5kZWJ1Z2dhYmxlIGlzIGlmIG9uZSBwdXRzIHByaW50aygpIG9yIHRyYWNlCj4+IHN0
YXRlbWVudHMgaW4gdGhlIGNvZGUsIGJvb3RzIHRoZSBwbGF0Zm9ybSwgeW91IGdldCBmbG9vZGVk
IHdpdGggdGhvc2UKPj4gZGVidWdnaW5nIG1lc3NhZ2VzLCBiZWNhdXNlIGV2ZXJ5IGFjY2VzcyB0
byB0aGUgcm9vdGZzIGdlbmVyYXRlcyBhbmQKPj4gdGVhcnMgZG93biBhIG1hcHBpbmcuCj4+IAo+
PiBJdCB3b3VsZCBiZSBuaWNlIHRvIGJlIGFibGUgdG8gaW5zcGVjdCB0aGUgSU9NTVUgcGFnZSB0
YWJsZXMgYW5kIHN0YXRlCj4+IG9mIHRoZSBJT01NVSwgcmF0aGVyIHRoYW4gaGF2aW5nIHRvIHJl
c29ydCB0byBlZmZlY3RpdmVseSBkaXNhYmxpbmcKPj4gdGhlIElPTU1VLgo+IAo+IENlcnRhaW5s
eSBvbmNlIHdlIGdldCB0byBzdHVmZiBsaWtlIHVucGlubmVkIFZGSU8sIGhhdmluZyB0aGUgYWJp
bGl0eQo+IHRvIGluc3BlY3QgcGFnZXRhYmxlcyBmb3IgYXJiaXRyYXJ5IElPTU1VIEFQSSB1c2Fn
ZSB3aWxsIGluZGVlZCBiZQo+IHVzZWZ1bC4gRnJvbSB0aGUgRE1BIG1hcHBpbmcgcGVyc3BlY3Rp
dmUsIHRob3VnaCwgdW5sZXNzIHlvdSdyZQo+IHdvcmtpbmcgb24gdGhlIGlvLXBndGFibGUgY29k
ZSBpdHNlbGYgaXQncyBub3QgcmVhbGx5IGdvaW5nIHRvIHRlbGwKPiB5b3UgbXVjaCB0aGF0IGR1
bXBpbmcgdGhlIG1hcHBpbmdzIGZyb20gZG1hLWRlYnVnIGNhbid0IGFscmVhZHkuCj4gCj4gRldJ
VyB3aGVuZXZlciBJIGVuY291bnRlciB0aGF0IHBhcnRpY3VsYXIgd2FybmluZyBpbiBpb21tdS1k
bWEKPiBjb250ZXh0LCBJIGRvbid0IGNhcmUgd2hlcmUgdGhlIGV4aXN0aW5nIG1hcHBpbmcgaXMg
cG9pbnRpbmcsIHNpbmNlCj4gaXQncyBtZXJlbHkgYSBzeW1wdG9tIG9mIHRoZSBkYW1hZ2UgYWxy
ZWFkeSBoYXZpbmcgYmVlbiBkb25lLiBBdCB0aGF0Cj4gcG9pbnQgSSdkIHVzdWFsbHkgZ28gb2Zm
IGFuZCBhdWRpdCBhbGwgdGhlIERNQSBBUEkgY2FsbHMgaW4gdGhlCj4gb2ZmZW5kaW5nIGRyaXZl
ciwgc2luY2UgaXQncyB0eXBpY2FsbHkgY2F1c2VkIGJ5IGNvcnJ1cHRpb24gaW4gdGhlCj4gSU9W
QSBhbGxvY2F0b3IgZnJvbSBwYXNzaW5nIHRoZSB3cm9uZyBzaXplIGluIGEgZG1hX3VubWFwXyoo
KSBjYWxsLAo+IGFuZCB0aG9zZSBjYW4gb2Z0ZW4gYmUgc3BvdHRlZCBieSBpbnNwZWN0aW9uLiBG
b3IgYWN0aXZlIGRlYnVnZ2luZywKPiB3aGF0IHlvdSByZWFsbHkgd2FudCB0byBrbm93IGlzIHRo
ZSAqaGlzdG9yeSogb2Ygb3BlcmF0aW9ucyBhcm91bmQKPiB0aGF0IElPVkEsIHNpbmNlIHlvdSdy
ZSBwcmltYXJpbHkgaW50ZXJlc3RlZCBpbiB0aGUgcmVxdWVzdCB0aGF0IGxhc3QKPiBtYXBwZWQg
aXQsIHRoZW4gdGhlIGNvcnJlc3BvbmRpbmcgdW5tYXAgcmVxdWVzdCBmb3Igbm9taW5hbGx5IHRo
ZSBzYW1lCj4gYnVmZmVyICh3aGljaCBhbGxvd2VkIHRoZSBJT1ZBIHJlZ2lvbiB0byBiZSBmcmVl
ZCBmb3IgcmV1c2UpIHRoYXQgZm9yCj4gc29tZSByZWFzb24gZGlkbid0IGNvdmVyIG9uZSBvciBt
b3JlIHBhZ2VzIHRoYXQgaXQgc2hvdWxkIGhhdmUuIFRoZQo+IElPTU1VIEFQSSB0cmFjZXBvaW50
cyBjYW4gYmUgYSBoYW5keSB0b29sIHRoZXJlLgo+IAoKQ3VycmVudGx5IElPTU1VIHRyYWNlIGV2
ZW50cyBhcmUgbm90IHN0cmFpZ2h0IGZvcndhcmQgdG8gZGVjb2RlIGlmCnRoZXJlIGFyZSBtdWx0
aXBsZSBkZXZpY2VzIGF0dGFjaGVkLiBGb3IgZXg6IGNvbnNpZGVyIGJlbG93OgoKbWFwOiBJT01N
VTogaW92YT0weDAwMDAwMDBmZmZmMzUwMDAgcGFkZHI9MHgwMDAwMDAwMTEzYmUyMDAwIHNpemU9
NDA5Ngp1bm1hcDogSU9NTVU6IGlvdmE9MHgwMDAwMDAwZmZmZjM0MDAwIHNpemU9NDA5NiB1bm1h
cHBlZF9zaXplPTQwOTYKdW5tYXA6IElPTU1VOiBpb3ZhPTB4MDAwMDAwMGZmZmYzNTAwMCBzaXpl
PTQwOTYgdW5tYXBwZWRfc2l6ZT00MDk2Cm1hcDogSU9NTVU6IGlvdmE9MHgwMDAwMDAwZmZmZjM2
MDAwIHBhZGRyPTB4MDAwMDAwMDExNjRkODAwMCBzaXplPTQwOTYKbWFwOiBJT01NVTogaW92YT0w
eDAwMDAwMDBmZmZmMzcwMDAgcGFkZHI9MHgwMDAwMDAwMTE2NGRhMDAwIHNpemU9NDA5Ngp1bm1h
cDogSU9NTVU6IGlvdmE9MHgwMDAwMDAwZmZmZjM2MDAwIHNpemU9NDA5NiB1bm1hcHBlZF9zaXpl
PTQwOTYKdW5tYXA6IElPTU1VOiBpb3ZhPTB4MDAwMDAwMGZmZmYzNzAwMCBzaXplPTQwOTYgdW5t
YXBwZWRfc2l6ZT00MDk2CgpIb3cgYWJvdXQgbWFraW5nIGl0IG1vcmUgdXNlZnVsIGFkZGluZyB0
aGUgZGV2aWNlIG5hbWUgYXMgd2VsbD8gRXg6CgptYXA6IElPTU1VOmFlMDAwMDAubWRzcyBpb3Zh
PTB4MDAwMDAwMDAwMDAyYjAwMCBwYWRkcj0weDAwMDAwMDAxMGE5ZTYwMDAgCnNpemU9ODE5Mgpt
YXA6IElPTU1VOmFlMDAwMDAubWRzcyBpb3ZhPTB4MDAwMDAwMDAwMDAyZDAwMCBwYWRkcj0weDAw
MDAwMDAxMGE5ZWMwMDAgCnNpemU9MjE3OTAKbWFwOiBJT01NVTphZTAwMDAwLm1kc3MgaW92YT0w
eDAwMDAwMDAwMDAyNDEwMDAgcGFkZHI9MHgwMDAwMDAwMTBjNDAwMDAwIApzaXplPTU5MzkyCm1h
cDogSU9NTVU6YTYwMDAwMC5kd2MzIGlvdmE9MHgwMDAwMDAwZmZmZjRhMDAwIHBhZGRyPTB4MDAw
MDAwMDEwYTgyMTAwMCAKc2l6ZT00MDk2Cm1hcDogSU9NTVU6YTYwMDAwMC5kd2MzIGlvdmE9MHgw
MDAwMDAwZmZmZjQ5MDAwIHBhZGRyPTB4MDAwMDAwMDEwYTgyMDAwMCAKc2l6ZT00MDk2CnVubWFw
OiBJT01NVTphNjAwMDAwLmR3YzMgaW92YT0weDAwMDAwMDBmZmZmNGEwMDAgc2l6ZT00MDk2IAp1
bm1hcHBlZF9zaXplPTQwOTYKdW5tYXA6IElPTU1VOmE2MDAwMDAuZHdjMyBpb3ZhPTB4MDAwMDAw
MGZmZmY0OTAwMCBzaXplPTQwOTYgCnVubWFwcGVkX3NpemU9NDA5NgoKV2UgaGF2ZSBiZWVuIGNh
cnJ5aW5nIGEgbG9jYWwgcGF0Y2ggZG93bnN0cmVhbSBsaWtlIGZvcmV2ZXIsIEkgY2FuIHBvc3Qg
CmEKcGF0Y2ggaWYgeW91IGd1eXMgdGhpbmsgaXQgaXMgdXNlZnVsIGluIGdlbmVyYWwuCgpUaGFu
a3MKU2FpCgotLSAKUVVBTENPTU0gSU5ESUEsIG9uIGJlaGFsZiBvZiBRdWFsY29tbSBJbm5vdmF0
aW9uIENlbnRlciwgSW5jLiBpcyBhIAptZW1iZXIKb2YgQ29kZSBBdXJvcmEgRm9ydW0sIGhvc3Rl
ZCBieSBUaGUgTGludXggRm91bmRhdGlvbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
