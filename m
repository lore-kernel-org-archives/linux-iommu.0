Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96451C4346E
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 04:51:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04DB238A1
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 04:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="QBWjxKz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04DB238A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 452F386FBE;
	Thu, 24 Sep 2020 04:51:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bPAvbY2e0ZiC; Thu, 24 Sep 2020 04:51:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 372DE86F74;
	Thu, 24 Sep 2020 04:51:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C12DC0859;
	Thu, 24 Sep 2020 04:51:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46520C0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 04:51:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 19CBF27261
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 04:51:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jdq+ZzM1Npt0 for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 04:51:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from z5.mailgun.us (z5.mailgun.us [104.130.96.5])
 by silver.osuosl.org (Postfix) with ESMTPS id D64E8228E7
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 04:51:45 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1600923105; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=OcuRehvXWjquPfAiTK+K+IF0XIj5WnIhvodV0AT8ZIE=;
 b=QBWjxKz/ky4K6MtY3wvVdEHi7HLa4MTYEwrsOUL8Qrld/ldlGX0vm1PEjWtSPDyVIXOzbfFH
 3+JpcqwMKcKye8KAm7B8GrxIKwj8ZcllRS6h0yOMUxgAKLDMfLaOA2Xxz7BbRNfJ5y+tquw/
 WjtXsLtjqYPnPjf4JD2Da1h2lhA=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f6c25e15476485453c1bd5b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Sep 2020 04:51:45
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 47C6EC433CB; Thu, 24 Sep 2020 04:51:44 +0000 (UTC)
Received: from [192.168.29.110] (unknown [49.37.203.218])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: charante)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 27279C433CA;
 Thu, 24 Sep 2020 04:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27279C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH] iommu: of: skip iommu_device_list traversal in
 of_iommu_xlate()
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
 iommu@lists.linux-foundation.org
References: <1600872826-2254-1-git-send-email-charante@codeaurora.org>
 <8722e4bc-efe0-27c4-2b7d-626188da5bfb@arm.com>
From: Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <352d1518-8191-19e0-b9f3-29dfe91a2ad4@codeaurora.org>
Date: Thu, 24 Sep 2020 10:21:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8722e4bc-efe0-27c4-2b7d-626188da5bfb@arm.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org
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

CgpPbiA5LzIzLzIwMjAgOTo1NCBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjAtMDkt
MjMgMTU6NTMsIENoYXJhbiBUZWphIFJlZGR5IHdyb3RlOgo+PiBJbiBvZl9pb21tdV94bGF0ZSgp
LCBjaGVjayBpZiBpb21tdSBkZXZpY2UgaXMgZW5hYmxlZCBiZWZvcmUgdHJhdmVyc2luZwo+PiB0
aGUgaW9tbXVfZGV2aWNlX2xpc3QgdGhyb3VnaCBpb21tdV9vcHNfZnJvbV9md25vZGUoKS4gSXQg
aXMgb2Ygbm8gdXNlCj4+IGluIHRyYXZlcnNpbmcgdGhlIGlvbW11X2RldmljZV9saXN0IG9ubHkg
dG8gcmV0dXJuIE5PX0lPTU1VIGJlY2F1c2Ugb2YKPj4gaW9tbXUgZGV2aWNlIG5vZGUgaXMgZGlz
YWJsZWQuCj4gCj4gV2VsbCwgdGhlICJ1c2UiIGlzIHRoYXQgaXQga2VlcHMgdGhlIGNvZGUgdGhh
dCBtdWNoIHNtYWxsZXIgYW5kIHNpbXBsZXIKPiB0byBoYXZlIGEgc2luZ2xlIHBhdGggZm9yIHJl
dHVybmluZyB0aGlzIGNvbmRpdGlvbi4gVGhpcyB3aG9sZSBjYWxsc3RhY2sKPiBpc24ndCBleGFj
dGx5IGEgaGlnaC1wZXJmb3JtYW5jZSBjb2RlIHBhdGggdG8gYmVnaW4gd2l0aCwgYW5kIHdlJ3Zl
Cj4gYWx3YXlzIGFzc3VtZWQgdGhhdCBJT01NVXMgcHJlc2VudCBidXQgZGlzYWJsZWQgaW4gRFQg
d291bGQgYmUgYSBwcmV0dHkKPiByYXJlIGV4Y2VwdGlvbi4gCgpGaW5lLi5JIHRob3VnaHQgdGhh
dCBpdCBpcyBsb2dpY2FsIHRvIHJldHVybiB3aGVuIElPTU1VIERUIG5vZGUgaXMKZGlzYWJsZWQg
b3ZlciBjb2RlIHNpbXBsaWNpdHkuIEFuZCBhZ3JlZSB0aGF0IGl0IGlzIG5vdCBoaWdoLXBlcmZv
cm1hbmNlCnBhdGguCgo+IERvIHlvdSBoYXZlIGEgc3lzdGVtIHRoYXQgY2hhbGxlbmdlcyB0aG9z
ZSBhc3N1bXB0aW9ucwo+IGFuZCBzaG93cyBhbnkgYmVuZWZpdCBmcm9tIHRoaXMgY2hhbmdlPwoK
Tm8sIEkgZG9uJ3QgaGF2ZSBhIHN5c3RlbSB0aGF0IGNoYWxsZW5nZXMgdGhlc2UgYXNzdW1wdGlv
bnMuCgo+IAo+IFJvYmluLgo+IAo+PiBTaWduZWQtb2ZmLWJ5OiBDaGFyYW4gVGVqYSBSZWRkeSA8
Y2hhcmFudGVAY29kZWF1cm9yYS5vcmc+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2lvbW11L29mX2lv
bW11LmMgfCA1ICsrKy0tCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L29mX2lvbW11LmMg
Yi9kcml2ZXJzL2lvbW11L29mX2lvbW11LmMKPj4gaW5kZXggZTUwNWI5MS4uMjI1NTk4YyAxMDA2
NDQKPj4gLS0tIGEvZHJpdmVycy9pb21tdS9vZl9pb21tdS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9t
bXUvb2ZfaW9tbXUuYwo+PiBAQCAtOTQsOSArOTQsMTAgQEAgc3RhdGljIGludCBvZl9pb21tdV94
bGF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYsCj4+IMKgwqDCoMKgwqAgc3RydWN0IGZ3bm9kZV9oYW5k
bGUgKmZ3bm9kZSA9ICZpb21tdV9zcGVjLT5ucC0+Zndub2RlOwo+PiDCoMKgwqDCoMKgIGludCBy
ZXQ7Cj4+IMKgICvCoMKgwqAgaWYgKCFvZl9kZXZpY2VfaXNfYXZhaWxhYmxlKGlvbW11X3NwZWMt
Pm5wKSkKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBOT19JT01NVTsKPj4gwqDCoMKgwqDCoCBv
cHMgPSBpb21tdV9vcHNfZnJvbV9md25vZGUoZndub2RlKTsKPj4gLcKgwqDCoCBpZiAoKG9wcyAm
JiAhb3BzLT5vZl94bGF0ZSkgfHwKPj4gLcKgwqDCoMKgwqDCoMKgICFvZl9kZXZpY2VfaXNfYXZh
aWxhYmxlKGlvbW11X3NwZWMtPm5wKSkKPj4gK8KgwqDCoCBpZiAob3BzICYmICFvcHMtPm9mX3hs
YXRlKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIE5PX0lPTU1VOwo+PiDCoCDCoMKgwqDC
oMKgIHJldCA9IGlvbW11X2Z3c3BlY19pbml0KGRldiwgJmlvbW11X3NwZWMtPm5wLT5md25vZGUs
IG9wcyk7Cj4+CgotLSAKVGhlIFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIGlzIGEg
bWVtYmVyIG9mIHRoZSBDb2RlIEF1cm9yYQpGb3J1bSwgYSBMaW51eCBGb3VuZGF0aW9uIENvbGxh
Ym9yYXRpdmUgUHJvamVjdApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9t
bXU=
