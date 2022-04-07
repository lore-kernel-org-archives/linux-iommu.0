Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C92C433EF
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 17:51:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8830740CE8;
	Thu,  7 Apr 2022 17:51:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tDKLk3Qz-AV7; Thu,  7 Apr 2022 17:51:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 483D640CCD;
	Thu,  7 Apr 2022 17:51:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14430C002C;
	Thu,  7 Apr 2022 17:51:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40710C0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 17:51:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2833C41A62
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 17:51:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m7lgHgpiB741 for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 17:51:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1232241A5C
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 17:51:13 +0000 (UTC)
Received: from [IPV6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1] (unknown
 [IPv6:2a00:5f00:102:0:10b3:10ff:fe5d:4ec1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id A72D61F45BED;
 Thu,  7 Apr 2022 18:51:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1649353871;
 bh=BM8w1p30B0kfQHenmrawFgD3CQMDeil5XCYiCXhxmj0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZkLc9cMqzHTOxOGUTmrKf6vegatQR09XbK2itRSvnEyM2PLisAHaf91EjRvUxfpw5
 RyBMCJC2kH/xgVJpC2EHUvIq9O9gx4evaixair/ggQ1t++qR4qQuMOUnJbNoI5YQIl
 fFtvGdFAp5mOV4poUmnwETAVMu6dvqZCmShRL2dJsFXDrqUBpxxgWUDPpm0b5PuXnd
 NUCGXX/k9v5vd81tQtBm3H7DkoPC8+CHjO15t2AA2UdCDa2FcSsEl7NQQnndZFqpfd
 TtueGYKsUCrWPzc2f5scziU0i70NjH5/UceR57b6BQeoXRit6sbkKwGJ65rxegJ/67
 HSYeEPtuvp3dg==
Message-ID: <4cbc5418-b92b-1eed-44cc-82030616cb02@collabora.com>
Date: Thu, 7 Apr 2022 20:51:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/tegra: Stop using iommu_present()
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, thierry.reding@gmail.com
References: <25247f43672df0aa58c1952bf3df2bf948e9f8ae.1649168393.git.robin.murphy@arm.com>
 <49165024-5f33-b6e6-7ec9-1ede6f562748@collabora.com>
 <0f7bf1c2-7a21-13a0-8734-c53f624e1edd@arm.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <0f7bf1c2-7a21-13a0-8734-c53f624e1edd@arm.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 dri-devel@lists.freedesktop.org, jonathanh@nvidia.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gNC82LzIyIDIxOjA2LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMi0wNC0wNiAxNToz
MiwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiBPbiA0LzUvMjIgMTc6MTksIFJvYmluIE11cnBo
eSB3cm90ZToKPj4+IFJlbW92ZSB0aGUgcG9pbnRsZXNzIGNoZWNrLiBob3N0MXhfZHJtX3dhbnRz
X2lvbW11KCkgY2Fubm90IHJldHVybiB0cnVlCj4+PiB1bmxlc3MgYW4gSU9NTVUgZXhpc3RzIGZv
ciB0aGUgaG9zdDF4IHBsYXRmb3JtIGRldmljZSwgd2hpY2ggYXQgdGhlCj4+PiBtb21lbnQKPj4+
IG1lYW5zIHRoZSBpb21tdV9wcmVzZW50KCkgdGVzdCBjb3VsZCBuZXZlciBmYWlsLgo+Pj4KPj4+
IFNpZ25lZC1vZmYtYnk6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+Cj4+PiAt
LS0KPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS90ZWdyYS9kcm0uYyB8IDIgKy0KPj4+IMKgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pj4KPj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vdGVncmEvZHJtLmMgYi9kcml2ZXJzL2dwdS9kcm0vdGVncmEv
ZHJtLmMKPj4+IGluZGV4IDk0NjRmNTIyZTI1Ny4uYmM0MzIxNTYxNDAwIDEwMDY0NAo+Pj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL3RlZ3JhL2RybS5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
dGVncmEvZHJtLmMKPj4+IEBAIC0xMTQ5LDcgKzExNDksNyBAQCBzdGF0aWMgaW50IGhvc3QxeF9k
cm1fcHJvYmUoc3RydWN0Cj4+PiBob3N0MXhfZGV2aWNlICpkZXYpCj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgZ290byBwdXQ7Cj4+PiDCoMKgwqDCoMKgIH0KPj4+IMKgIC3CoMKgwqAgaWYgKGhvc3Qx
eF9kcm1fd2FudHNfaW9tbXUoZGV2KSAmJgo+Pj4gaW9tbXVfcHJlc2VudCgmcGxhdGZvcm1fYnVz
X3R5cGUpKSB7Cj4+PiArwqDCoMKgIGlmIChob3N0MXhfZHJtX3dhbnRzX2lvbW11KGRldikpIHsK
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB0ZWdyYS0+ZG9tYWluID0gaW9tbXVfZG9tYWluX2FsbG9j
KCZwbGF0Zm9ybV9idXNfdHlwZSk7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCF0ZWdyYS0+
ZG9tYWluKSB7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnIgPSAtRU5PTUVNOwo+
Pgo+PiBob3N0MXhfZHJtX3dhbnRzX2lvbW11KCkgcmV0dXJucyB0cnVlIGlmIHRoZXJlIGlzIG5v
IElPTU1VIGZvciB0aGUKPj4gaG9zdDF4IHBsYXRmb3JtIGRldmljZSBvZiBUZWdyYTIwLzMwIFNv
Q3MuCj4gCj4gQWgsIGFwcGFyZW50bHkgdGhpcyBpcyBhbm90aGVyIGV4YW1wbGUgb2Ygd2hhdCBo
YXBwZW5zIHdoZW4gSSB3cml0ZQo+IHBhdGNoZXMgbGF0ZSBvbiBhIEZyaWRheSBuaWdodC4uLgo+
IAo+IFNvIG9uIHNlY29uZCBsb29rLCB3aGF0IHdlIHdhbnQgdG8gYXNjZXJ0YWluIGhlcmUgaXMg
d2hldGhlciBkZXYgaGFzIGFuCj4gSU9NTVUsIGJ1dCBvbmx5IGlmIHRoZSBob3N0MXggcGFyZW50
IGlzIG5vdCBhZGRyZXNzaW5nLWxpbWl0ZWQsIGVpdGhlcgo+IGJlY2F1c2UgaXQgY2FuIGFsc28g
dXNlIHRoZSBJT01NVSwgb3IgYmVjYXVzZSBhbGwgcG9zc2libGUgYWRkcmVzc2VzIGFyZQo+IHNt
YWxsIGVub3VnaCBhbnl3YXksIHJpZ2h0PyAKClllcwoKPiBBcmUgd2Ugc3BlY2lmaWNhbGx5IGxv
b2tpbmcgZm9yIHRoZSBob3N0MXgKPiBoYXZpbmcgYSBETUEtQVBJLW1hbmFnZWQgZG9tYWluLCBv
ciBjYW4gdGhhdCBhbHNvIGVuZCB1cCB1c2luZyB0aGUKPiB0ZWdyYS0+ZG9tYWluIG9yIGFub3Ro
ZXIgdW5tYW5hZ2VkIGRvbWFpbiB0b28/CgpXZSBoYXZlIGhvc3QxeCBETUEgdGhhdCBjb3VsZCBo
YXZlOgoKMS4gTm8gSU9NTVUgZG9tYWluLCBkZXBlbmRpbmcgb24ga2VybmVsL0RUIGNvbmZpZwoy
LiBNYW5hZ2VkIGRvbWFpbiwgb24gbmV3ZXIgU29DcwozLiBVbm1hbmFnZWQgZG9tYWluLCBvbiBv
bGRlciBTb0NzCgpXZSBoYXZlIFRlZ3JhIERSTSBkZXZpY2VzIHdoaWNoIGNhbjoKCjEuIEJlIGF0
dGFjaGVkIHRvIGEgc2hhcmVkIHVubWFuYWdlZCB0ZWdyYS0+ZG9tYWluLCBvbiBvbGRlciBTb0Nz
CjIuIEhhdmUgb3duIG1hbmFnZWQgZG9tYWlucywgb24gbmV3ZXIgU29DcwoKPiBJIGNhbid0IHF1
aXRlIGZpZ3VyZSBvdXQKPiBmcm9tIHRoZSBjb21tZW50cyB3aGV0aGVyIGl0J3MgcGh5c2ljYWwg
YWRkcmVzc2VzLCBJT1ZBcywgb3IgYm90aCB0aGF0Cj4gd2UncmUgY29uY2VybmVkIHdpdGggaGVy
ZS4KClRlZ3JhIERSTSBhbGxvY2F0ZXMgYnVmZmVycyBhbmQgc3VibWl0cyBqb2JzIHRvIGgvdyB1
c2luZyBob3N0MXgncwpjaGFubmVsIERNQS4gRFJNIGZyYW1lYnVmZmVycycgYWRkcmVzc2VzIGFy
ZSBpbnNlcnRlZCBpbnRvIGhvc3QxeApjb21tYW5kIGJ1ZmZlcnMgYnkga2VybmVsIGRyaXZlciBh
bmQgYWRkcmVzc2VzIGJleW9uZCAzMmJpdCBzcGFjZSBuZWVkCnRvIGJlIHRyZWF0ZWQgc3BlY2lh
bGx5LCB3ZSBkb24ndCBzdXBwb3J0IHN1Y2ggYWRkcmVzc2VzIGluIHVwc3RyZWFtLgoKSU9NTVUg
QVMgaXMgbGltaXRlZCB0byAzMmJpdHMgb24gVGVncmEgaW4gdXBzdHJlYW0ga2VybmVsIGZvciBw
cmUtVDE4NgpTb0NzLCBpdCBoaWRlcyA2NGJpdCBhZGRyZXNzZXMgZnJvbSBob3N0MXguIFBvc3Qt
VDE4NiBTb0NzIGhhdmUgZXh0cmEKZmVhdHVyZXMgdGhhdCBhbGxvdyBrZXJuZWwgZHJpdmVyIG5v
dCB0byBib3RoZXIgYWJvdXQgYWRkcmVzc2VzLgoKRm9yIG5ld2VyIEFSTTY0IFNvQ3MgdGhlcmUg
aXMgYXNzdW1wdGlvbiBpbiB0aGUgVGVncmEgZHJpdmVycyB0aGF0IElPTU1VCmFsd2F5cyBwcmVz
ZW50cywgdG8gc2ltcGxpZnkgdGhpbmdzLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
