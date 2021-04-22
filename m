Return-Path: <SRS0=TTgE=JT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D08FC433ED
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 05:39:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B9D6144D
	for <iommu@archiver.kernel.org>; Thu, 22 Apr 2021 05:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B9D6144D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E77683C71;
	Thu, 22 Apr 2021 05:39:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dXRP5W7JI3_d; Thu, 22 Apr 2021 05:39:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8430183C30;
	Thu, 22 Apr 2021 05:39:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E6C8C000F;
	Thu, 22 Apr 2021 05:39:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E66EC000B
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 05:39:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 41FAA83C71
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 05:39:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l6vageTkYEkx for <iommu@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 05:39:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC7CB83C30
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 05:39:48 +0000 (UTC)
Received: from mailer.emlix.com (unknown [81.20.119.6])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id 630016049E;
 Thu, 22 Apr 2021 07:39:46 +0200 (CEST)
From: Rolf Eike Beer <eb@emlix.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: [PATCH] iommu/vt-d: Fix sysfs leak in alloc_domain()
Date: Thu, 22 Apr 2021 07:39:44 +0200
Message-ID: <17411490.HIIP88n32C@mobilepool36.emlix.com>
In-Reply-To: <1716403.SmlLz2RZUD@devpool47>
References: <1716403.SmlLz2RZUD@devpool47>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>,
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

aW9tbXVfZGV2aWNlX3N5c2ZzX2FkZCgpIGlzIGNhbGxlZCBiZWZvcmUsIHNvIGlzIGhhcyB0byBi
ZSBjbGVhbmVkIG9uIHN1YnNlcXVlbnQKZXJyb3JzLgoKRml4ZXM6IDM5YWI5NTU1YzI0MTEgKCJp
b21tdTogQWRkIHN5c2ZzIGJpbmRpbmdzIGZvciBzdHJ1Y3QgaW9tbXVfZGV2aWNlIikKQ2M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcgIyA0LjExLngKU2lnbmVkLW9mZi1ieTogUm9sZiBFaWtlIEJl
ZXIgPGViQGVtbGl4LmNvbT4KLS0tCiBkcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYyB8IDQgKysr
LQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvZG1hci5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9k
bWFyLmMKaW5kZXggZDVjNTFiNWMyMGFmLi5jMmJmY2NiMTllMjQgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvaW9tbXUvaW50ZWwvZG1hci5jCisrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvZG1hci5jCkBA
IC0xMTQ0LDcgKzExNDQsNyBAQCBzdGF0aWMgaW50IGFsbG9jX2lvbW11KHN0cnVjdCBkbWFyX2Ry
aGRfdW5pdCAqZHJoZCkKIAogCQllcnIgPSBpb21tdV9kZXZpY2VfcmVnaXN0ZXIoJmlvbW11LT5p
b21tdSk7CiAJCWlmIChlcnIpCi0JCQlnb3RvIGVycl91bm1hcDsKKwkJCWdvdG8gZXJyX3N5c2Zz
OwogCX0KIAogCWRyaGQtPmlvbW11ID0gaW9tbXU7CkBAIC0xMTUyLDYgKzExNTIsOCBAQCBzdGF0
aWMgaW50IGFsbG9jX2lvbW11KHN0cnVjdCBkbWFyX2RyaGRfdW5pdCAqZHJoZCkKIAogCXJldHVy
biAwOwogCitlcnJfc3lzZnM6CisJaW9tbXVfZGV2aWNlX3N5c2ZzX3JlbW92ZSgmaW9tbXUtPmlv
bW11KTsKIGVycl91bm1hcDoKIAl1bm1hcF9pb21tdShpb21tdSk7CiBlcnJvcl9mcmVlX3NlcV9p
ZDoKLS0gCjIuMzEuMQoKLS0gClJvbGYgRWlrZSBCZWVyLCBlbWxpeCBHbWJILCBodHRwczovL3d3
dy5lbWxpeC5jb20KRm9uICs0OSA1NTEgMzA2NjQtMCwgRmF4ICs0OSA1NTEgMzA2NjQtMTEKR290
aGFlciBQbGF0eiAzLCAzNzA4MyBHw7Z0dGluZ2VuLCBHZXJtYW55ClNpdHogZGVyIEdlc2VsbHNj
aGFmdDogR8O2dHRpbmdlbiwgQW10c2dlcmljaHQgR8O2dHRpbmdlbiBIUiBCIDMxNjAKR2VzY2jD
pGZ0c2bDvGhydW5nOiBIZWlrZSBKb3JkYW4sIERyLiBVd2UgS3JhY2tlIOKAkyBVc3QtSWROci46
IERFIDIwNSAxOTggMDU1CgplbWxpeCAtIHNtYXJ0IGVtYmVkZGVkIG9wZW4gc291cmNlCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
