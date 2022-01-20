Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24C3C433EF
	for <iommu@archiver.kernel.org>; Thu, 20 Jan 2022 03:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F10082423;
	Thu, 20 Jan 2022 03:14:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gAApOimzb3eT; Thu, 20 Jan 2022 03:14:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F3BE781D2D;
	Thu, 20 Jan 2022 03:14:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D69C4C0039;
	Thu, 20 Jan 2022 03:14:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D02DC002F
 for <iommu@lists.linux-foundation.org>; Thu, 20 Jan 2022 03:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 73AB840990
 for <iommu@lists.linux-foundation.org>; Thu, 20 Jan 2022 03:14:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JSwq2mwa096u for <iommu@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 03:14:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DB52C40283
 for <iommu@lists.linux-foundation.org>; Thu, 20 Jan 2022 03:14:06 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R991e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=zelin.deng@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V2JWwbh_1642648442; 
Received: from 30.21.166.20(mailfrom:zelin.deng@linux.alibaba.com
 fp:SMTPD_---0V2JWwbh_1642648442) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 20 Jan 2022 11:14:03 +0800
Message-ID: <2ad9b10f-b7b7-afec-38ed-16176a6c55c9@linux.alibaba.com>
Date: Thu, 20 Jan 2022 11:13:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH] iommu/vt-d: Do not dump pasid table entries in kdump
 kernel
To: Lu Baolu <baolu.lu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>
References: <1642583260-21095-1-git-send-email-zelin.deng@linux.alibaba.com>
 <846c0ff6-32b1-73a4-0510-f1e809684991@linux.intel.com>
From: zelin deng <zelin.deng@linux.alibaba.com>
In-Reply-To: <846c0ff6-32b1-73a4-0510-f1e809684991@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

CuWcqCAyMDIyLzEvMjAg5LiK5Y2IMTA6NTgsIEx1IEJhb2x1IOWGmemBkzoKPiBPbiAxLzE5LzIy
IDU6MDcgUE0sIFplbGluIERlbmcgd3JvdGU6Cj4+IEluIGtkdW1wIGtlcm5lbCBQQVNJRCB0cmFu
c2xhdGlvbnMgd29uJ3QgYmUgY29waWVkIGZyb20gcHJldmlvdXMga2VybmVsCj4+IGV2ZW4gaWYg
c2NhbGFibGUtbW9kZSBpcyBlbmFibGVkLCBzbyBwYWdlcyBvZiBQQVNJRCB0cmFuc2xhdGlvbnMg
YXJlCj4KPiBZZXMuIFRoZSBjb3B5IHRhYmxlIHN1cHBvcnQgZm9yIHNjYWxhYmxlIG1vZGUgaXMg
c3RpbGwgaW4gbXkgdGFzayBsaXN0Lgo+Cj4+IG5vbi1wcmVzZW50IGluIGtkdW1wIGtlcm5lbC4g
QXR0ZW1wdCB0byBhY2Nlc3MgdGhvc2UgYWRkcmVzcyB3aWxsIGNhdXNlCj4+IFBGIGZhdWx0Ogo+
Pgo+PiBbwqDCoCAxMy4zOTY0NzZdIERNQVI6IERSSEQ6IGhhbmRsaW5nIGZhdWx0IHN0YXR1cyBy
ZWcgMwo+PiBbwqDCoCAxMy4zOTY0NzhdIERNQVI6IFtETUEgUmVhZCBOT19QQVNJRF0gUmVxdWVz
dCBkZXZpY2UgWzgxOjAwLjBdIAo+PiBmYXVsdCBhZGRyIDB4ZmZmZmQwMDAgW2ZhdWx0IHJlYXNv
biAweDU5XSBTTTogUHJlc2VudCBiaXQgaW4gUEEkCj4+IFvCoMKgIDEzLjM5NjQ4MF0gRE1BUjog
RHVtcCBkbWFyNSB0YWJsZSBlbnRyaWVzIGZvciBJT1ZBIDB4ZmZmZmQwMDAKPj4gW8KgwqAgMTMu
Mzk2NDgxXSBETUFSOiBzY2FsYWJsZSBtb2RlIHJvb3QgZW50cnk6IGhpIDB4MDAwMDAwMDAwMDAw
MDAwMCwgCj4+IGxvdyAweDAwMDAwMDAwNDYwZDEwMDEKPj4gW8KgwqAgMTMuMzk2NDgyXSBETUFS
OiBjb250ZXh0IGVudHJ5OiBoaSAweDAwMDAwMDAwMDAwMDAwMDgsIGxvdyAKPj4gMHgwMDAwMDAx
MGM0MjM3NDAxCj4+IFvCoMKgIDEzLjM5NjQ4NV0gQlVHOiB1bmFibGUgdG8gaGFuZGxlIHBhZ2Ug
ZmF1bHQgZm9yIGFkZHJlc3M6IAo+PiBmZjExMDAxMGM0MjM3MDAwCj4+IFvCoMKgIDEzLjM5NjQ4
Nl0gI1BGOiBzdXBlcnZpc29yIHJlYWQgYWNjZXNzIGluIGtlcm5lbCBtb2RlCj4+IFvCoMKgIDEz
LjM5NjQ4N10gI1BGOiBlcnJvcl9jb2RlKDB4MDAwMCkgLSBub3QtcHJlc2VudCBwYWdlCj4+IFvC
oMKgIDEzLjM5NjQ4OF0gUEdEIDVkMjAxMDY3IFA0RCA1ZDIwMjA2NyBQVUQgMAo+PiBbwqDCoCAx
My4zOTY0OTBdIE9vcHM6IDAwMDAgWyMxXSBQUkVFTVBUIFNNUCBOT1BUSQo+PiBbwqDCoCAxMy4z
OTY0OTFdIENQVTogMCBQSUQ6IDEgQ29tbTogc3dhcHBlci8wIE5vdCB0YWludGVkIAo+PiA1LjE2
LjAtcmM2LW5leHQtMjAyMTEyMjQrICM2Cj4+IFvCoMKgIDEzLjM5NjQ5M10gSGFyZHdhcmUgbmFt
ZTogSW50ZWwgQ29ycG9yYXRpb24gCj4+IEVBR0xFU1RSRUFNL0VBR0xFU1RSRUFNLCBCSU9TIEVH
U0RDUkIxLjg2Qi4wMDY3LkQxMi4yMTEwMTkwOTUwIAo+PiAxMC8xOS8yMDIxCj4+IFvCoMKgIDEz
LjM5NjQ5NF0gUklQOiAwMDEwOmRtYXJfZmF1bHRfZHVtcF9wdGVzKzB4MTNiLzB4Mjk1Cj4+Cj4+
IEhlbmNlIHNraXAgZHVtcGluZyBwYXNpZCB0YWJsZSBlbnRyaWVzIGlmIGluIGtkdW1wIGtlcm5l
bC4KPgo+IFRoaXMganVzdCBhc2tzIGRtYXJfZmF1bHRfZHVtcF9wdGVzKCkgdG8ga2VlcCBzaWxl
bnQuIFRoZSBwcm9ibGVtIGlzCj4gdGhhdCB0aGUgY29udGV4dCBlbnRyeSBpcyBtaXMtY29uZmln
dXJlZC4gUGVyaGFwcyB3ZSBzaG91bGQgZGlzYWJsZQo+IGNvcHkgdGFibGUgZm9yIHNjYWxhYmxl
IG1vZGUgZm9yIG5vdy4gSG93IGFib3V0IGJlbG93IGNoYW5nZT8KClllcC7CoCBUaGUgY2hhbmdl
IGxvb2tzIGdvb2QgdG8gbWUuCgpBY3R1YWxseSBJIGhhZCBlbmNvdW50ZXJlZCBhbm90aGVyIGlz
c3VlIHdoaWNoIGhhZCBibG9ja2VkIHZpcnRpby1uZXQgCmRldmljZSB3aGVuIHNjYWxhYmxlIG1v
ZGUgaXMgZW5hYmxlZCBpbiBrZHVtcCBrZXJuZWwgc28gdGhhdCBJIGhhZCBtYWRlIAp0aGUgc2Ft
ZSBjaGFuZ2UgYXMgeW91cnMgLS0gJ3RvIGRpc2FibGUgdHJhbnNsYXRpb24gaWYgc21fb24gaW4g
a2R1bXAgCmtlcm5lbCcgaW4gb3VyIGludGVybmFsIHRyZWUuCgpJIG9ubHkgb2JzZXJ2ZSB0aGlz
IGlzc3VlIG9uIG91ciBkcmFnb25mbHkgYmFyZW1ldGFsIHNlcnZlciB3aXRoIAp2aXJ0aW8tbmV0
IGRldmljZSBpbnNpZGUsIEkgZGlkJ3Qgc2VuZCB0aGUgZml4IHRvIHVwc3RyZWFtIGFzIEkgYW0g
bm90IApzdXJlIGlmIGl0IGlzIHJlYXNvbmFibGUgdG8gZGlzYWJsZSB0cmFuc2xhdGlvbiBpbiBr
ZHVtcCBrZXJuZWwuCgoKPgo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+ICsr
KyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+IEBAIC0zMzM3LDEwICszMzM3LDExIEBA
IHN0YXRpYyBpbnQgX19pbml0IGluaXRfZG1hcnModm9pZCkKPgo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpbml0X3RyYW5zbGF0aW9uX3N0YXR1cyhpb21tdSk7Cj4KPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAodHJhbnNsYXRpb25fcHJlX2VuYWJsZWQoaW9tbXUp
ICYmIAo+ICFpc19rZHVtcF9rZXJuZWwoKSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGlmICh0cmFuc2xhdGlvbl9wcmVfZW5hYmxlZChpb21tdSkgJiYKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICghaXNfa2R1bXBfa2VybmVsKCkgfHwgc21fc3VwcG9y
dGVkKGlvbW11KSkpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlvbW11X2Rpc2FibGVfdHJhbnNsYXRpb24oaW9tbXUpOwo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2xlYXJfdHJhbnNsYXRpb25fcHJlX2Vu
YWJsZWQoaW9tbXUpOwo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBwcl93YXJuKCJUcmFuc2xhdGlvbiB3YXMgZW5hYmxlZCBmb3IgJXMgYnV0IHdlIAo+IGFy
ZSBub3QgaW4ga2R1bXAgbW9kZVxuIiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcHJfd2FybigiVHJhbnNsYXRpb24gd2FzIGVuYWJsZWQgZm9yICVzIGJ1
dCB3ZSAKPiBhcmUgbm90IGluIGtkdW1wIG1vZGUgb3IgY29weSB0YWJsZSBub3Qgc3VwcG9ydGVk
XG4iLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGlvbW11LT5uYW1lKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfQo+Cj4+Cj4+IEZpeGVzOiA5MTRmZjc3MTllOGEgKOKAnGlvbW11L3Z0LWQ6IER1bXAgRE1B
UiB0cmFuc2xhdGlvbiBzdHJ1Y3R1cmUgCj4+IHdoZW4gRE1BIGZhdWx0IG9jY3Vyc+KAnSkKPj4g
U2lnbmVkLW9mZi1ieTogWmVsaW4gRGVuZyA8emVsaW4uZGVuZ0BsaW51eC5hbGliYWJhLmNvbT4K
Pj4gLS0tCj4+IMKgIGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyB8IDYgKysrKysrCj4+IMKg
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW9tbXUvaW50ZWwvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+PiBp
bmRleCA5MmZlYTNmYi4uZjAxMzRjZiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRl
bC9pb21tdS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwo+PiBAQCAtMTA3
NCw2ICsxMDc0LDEyIEBAIHZvaWQgZG1hcl9mYXVsdF9kdW1wX3B0ZXMoc3RydWN0IGludGVsX2lv
bW11IAo+PiAqaW9tbXUsIHUxNiBzb3VyY2VfaWQsCj4+IMKgwqDCoMKgwqAgaWYgKCFzbV9zdXBw
b3J0ZWQoaW9tbXUpKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBwZ3RhYmxlX3dhbGs7Cj4+
IMKgICvCoMKgwqAgLyogUEFTSUQgdHJhbnNsYXRpb25zIGlzIG5vdCBjb3BpZWQsIHNraXAgZHVt
cGluZyBwYXNpZCB0YWJsZSAKPj4gZW50cmllcwo+PiArwqDCoMKgwqAgKiBvdGhlcndpc2Ugbm9u
LXByZXNlbnQgcGFnZSB3aWxsIGJlIGFjY2Vzc2VkLgo+PiArwqDCoMKgwqAgKi8KPj4gK8KgwqDC
oCBpZiAoaXNfa2R1bXBfa2VybmVsKCkpCj4+ICvCoMKgwqDCoMKgwqDCoCBnb3RvIHBndGFibGVf
d2FsazsKPj4gKwo+PiDCoMKgwqDCoMKgIC8qIGdldCB0aGUgcG9pbnRlciB0byBwYXNpZCBkaXJl
Y3RvcnkgZW50cnkgKi8KPj4gwqDCoMKgwqDCoCBkaXIgPSBwaHlzX3RvX3ZpcnQoY3R4X2VudHJ5
LT5sbyAmIFZURF9QQUdFX01BU0spOwo+PiDCoMKgwqDCoMKgIGlmICghZGlyKSB7Cj4+Cj4KPiBC
ZXN0IHJlZ2FyZHMsCj4gYmFvbHUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
