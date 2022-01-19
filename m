Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D55FC433F5
	for <iommu@archiver.kernel.org>; Wed, 19 Jan 2022 16:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 446F3414D1;
	Wed, 19 Jan 2022 16:12:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7-daq2QD-8ry; Wed, 19 Jan 2022 16:12:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 89E33410DE;
	Wed, 19 Jan 2022 16:12:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07F9CC002F;
	Wed, 19 Jan 2022 16:12:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 357C6C002F
 for <iommu@lists.linux-foundation.org>; Wed, 19 Jan 2022 09:07:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C07F410AC
 for <iommu@lists.linux-foundation.org>; Wed, 19 Jan 2022 09:07:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fyxCGrC4yRRE for <iommu@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 09:07:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 926C840333
 for <iommu@lists.linux-foundation.org>; Wed, 19 Jan 2022 09:07:44 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R371e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=zelin.deng@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V2GH.UM_1642583260; 
Received: from localhost(mailfrom:zelin.deng@linux.alibaba.com
 fp:SMTPD_---0V2GH.UM_1642583260) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 19 Jan 2022 17:07:40 +0800
From: Zelin Deng <zelin.deng@linux.alibaba.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH] iommu/vt-d: Do not dump pasid table entries in kdump kernel
Date: Wed, 19 Jan 2022 17:07:40 +0800
Message-Id: <1642583260-21095-1-git-send-email-zelin.deng@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 19 Jan 2022 16:12:49 +0000
Cc: iommu@lists.linux-foundation.org, Kyung Min Park <kyung.min.park@intel.com>,
 linux-kernel@vger.kernel.org
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

SW4ga2R1bXAga2VybmVsIFBBU0lEIHRyYW5zbGF0aW9ucyB3b24ndCBiZSBjb3BpZWQgZnJvbSBw
cmV2aW91cyBrZXJuZWwKZXZlbiBpZiBzY2FsYWJsZS1tb2RlIGlzIGVuYWJsZWQsIHNvIHBhZ2Vz
IG9mIFBBU0lEIHRyYW5zbGF0aW9ucyBhcmUKbm9uLXByZXNlbnQgaW4ga2R1bXAga2VybmVsLiBB
dHRlbXB0IHRvIGFjY2VzcyB0aG9zZSBhZGRyZXNzIHdpbGwgY2F1c2UKUEYgZmF1bHQ6CgpbICAg
MTMuMzk2NDc2XSBETUFSOiBEUkhEOiBoYW5kbGluZyBmYXVsdCBzdGF0dXMgcmVnIDMKWyAgIDEz
LjM5NjQ3OF0gRE1BUjogW0RNQSBSZWFkIE5PX1BBU0lEXSBSZXF1ZXN0IGRldmljZSBbODE6MDAu
MF0gZmF1bHQgYWRkciAweGZmZmZkMDAwIFtmYXVsdCByZWFzb24gMHg1OV0gU006IFByZXNlbnQg
Yml0IGluIFBBJApbICAgMTMuMzk2NDgwXSBETUFSOiBEdW1wIGRtYXI1IHRhYmxlIGVudHJpZXMg
Zm9yIElPVkEgMHhmZmZmZDAwMApbICAgMTMuMzk2NDgxXSBETUFSOiBzY2FsYWJsZSBtb2RlIHJv
b3QgZW50cnk6IGhpIDB4MDAwMDAwMDAwMDAwMDAwMCwgbG93IDB4MDAwMDAwMDA0NjBkMTAwMQpb
ICAgMTMuMzk2NDgyXSBETUFSOiBjb250ZXh0IGVudHJ5OiBoaSAweDAwMDAwMDAwMDAwMDAwMDgs
IGxvdyAweDAwMDAwMDEwYzQyMzc0MDEKWyAgIDEzLjM5NjQ4NV0gQlVHOiB1bmFibGUgdG8gaGFu
ZGxlIHBhZ2UgZmF1bHQgZm9yIGFkZHJlc3M6IGZmMTEwMDEwYzQyMzcwMDAKWyAgIDEzLjM5NjQ4
Nl0gI1BGOiBzdXBlcnZpc29yIHJlYWQgYWNjZXNzIGluIGtlcm5lbCBtb2RlClsgICAxMy4zOTY0
ODddICNQRjogZXJyb3JfY29kZSgweDAwMDApIC0gbm90LXByZXNlbnQgcGFnZQpbICAgMTMuMzk2
NDg4XSBQR0QgNWQyMDEwNjcgUDREIDVkMjAyMDY3IFBVRCAwClsgICAxMy4zOTY0OTBdIE9vcHM6
IDAwMDAgWyMxXSBQUkVFTVBUIFNNUCBOT1BUSQpbICAgMTMuMzk2NDkxXSBDUFU6IDAgUElEOiAx
IENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCA1LjE2LjAtcmM2LW5leHQtMjAyMTEyMjQrICM2
ClsgICAxMy4zOTY0OTNdIEhhcmR3YXJlIG5hbWU6IEludGVsIENvcnBvcmF0aW9uIEVBR0xFU1RS
RUFNL0VBR0xFU1RSRUFNLCBCSU9TIEVHU0RDUkIxLjg2Qi4wMDY3LkQxMi4yMTEwMTkwOTUwIDEw
LzE5LzIwMjEKWyAgIDEzLjM5NjQ5NF0gUklQOiAwMDEwOmRtYXJfZmF1bHRfZHVtcF9wdGVzKzB4
MTNiLzB4Mjk1CgpIZW5jZSBza2lwIGR1bXBpbmcgcGFzaWQgdGFibGUgZW50cmllcyBpZiBpbiBr
ZHVtcCBrZXJuZWwuCgpGaXhlczogOTE0ZmY3NzE5ZThhICjigJxpb21tdS92dC1kOiBEdW1wIERN
QVIgdHJhbnNsYXRpb24gc3RydWN0dXJlIHdoZW4gRE1BIGZhdWx0IG9jY3Vyc+KAnSkKU2lnbmVk
LW9mZi1ieTogWmVsaW4gRGVuZyA8emVsaW4uZGVuZ0BsaW51eC5hbGliYWJhLmNvbT4KLS0tCiBk
cml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgfCA2ICsrKysrKwogMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyBi
L2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYwppbmRleCA5MmZlYTNmYi4uZjAxMzRjZiAxMDA2
NDQKLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jCisrKyBiL2RyaXZlcnMvaW9tbXUv
aW50ZWwvaW9tbXUuYwpAQCAtMTA3NCw2ICsxMDc0LDEyIEBAIHZvaWQgZG1hcl9mYXVsdF9kdW1w
X3B0ZXMoc3RydWN0IGludGVsX2lvbW11ICppb21tdSwgdTE2IHNvdXJjZV9pZCwKIAlpZiAoIXNt
X3N1cHBvcnRlZChpb21tdSkpCiAJCWdvdG8gcGd0YWJsZV93YWxrOwogCisJLyogUEFTSUQgdHJh
bnNsYXRpb25zIGlzIG5vdCBjb3BpZWQsIHNraXAgZHVtcGluZyBwYXNpZCB0YWJsZSBlbnRyaWVz
CisJICogb3RoZXJ3aXNlIG5vbi1wcmVzZW50IHBhZ2Ugd2lsbCBiZSBhY2Nlc3NlZC4KKwkgKi8K
KwlpZiAoaXNfa2R1bXBfa2VybmVsKCkpCisJCWdvdG8gcGd0YWJsZV93YWxrOworCiAJLyogZ2V0
IHRoZSBwb2ludGVyIHRvIHBhc2lkIGRpcmVjdG9yeSBlbnRyeSAqLwogCWRpciA9IHBoeXNfdG9f
dmlydChjdHhfZW50cnktPmxvICYgVlREX1BBR0VfTUFTSyk7CiAJaWYgKCFkaXIpIHsKLS0gCjEu
OC4zLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlv
bW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
