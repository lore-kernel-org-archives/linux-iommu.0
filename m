Return-Path: <SRS0=DOhO=I7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D03C433B4
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 17:25:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B9A61163
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 17:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B9A61163
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0B7741892;
	Fri,  2 Apr 2021 17:25:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1N8a4S-uPorr; Fri,  2 Apr 2021 17:25:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 643A3418AA;
	Fri,  2 Apr 2021 17:25:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30376C000C;
	Fri,  2 Apr 2021 17:25:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5ED49C000A
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 17:25:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with UTF8SMTP id 381DC84D4B
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 17:25:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id tRuSrXC9FP7K for <iommu@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 17:25:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp1.osuosl.org (Postfix) with UTF8SMTPS id 9709F84D4A
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 17:25:44 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1617384345; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=RYBdzrSRW8CS8BHVXCW80gkbUBK56CsbMaOZq6Mvpos=;
 b=dSDwDmTD8mmI30hdwOUnPLopIm9kISplYs9Jen5XUnbstqb8AscjEq1tj/Jw5dvvlnL8hwY+
 XZuKs2ZN2vsg2H9QFrSWPksdjGivXRq+qMWd69NqOwfccVSKqlgVf7+PfOzb3T980HvTbeVk
 +LsnQClLGgNXCGe+2+on/X9KZNA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 606753958166b7eff736280d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 02 Apr 2021 17:25:40
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 34297C43462; Fri,  2 Apr 2021 17:25:40 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 3F65CC433CA;
 Fri,  2 Apr 2021 17:25:39 +0000 (UTC)
MIME-Version: 1.0
Date: Fri, 02 Apr 2021 10:25:39 -0700
From: isaacm@codeaurora.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH 2/5] iommu: Add an unmap_pages() op for IOMMU drivers
In-Reply-To: <3a931043-71bc-88a2-ee57-be9c139e7c9f@linux.intel.com>
References: <20210331030042.13348-1-isaacm@codeaurora.org>
 <20210331030042.13348-3-isaacm@codeaurora.org>
 <e1cadb9e-2ffa-8506-6790-2dab4733af25@linux.intel.com>
 <4c396e68a076f321ed3f406c2c875006@codeaurora.org>
 <3a931043-71bc-88a2-ee57-be9c139e7c9f@linux.intel.com>
Message-ID: <b9bbc82b3e405e5bc1d28ed073f6d5b4@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: robin.murphy@arm.com, iommu@lists.linux-foundation.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, pratikp@codeaurora.org
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

T24gMjAyMS0wMy0zMCAyMjozOSwgTHUgQmFvbHUgd3JvdGU6Cj4gT24gMy8zMS8yMSAxOjM2IFBN
LCBpc2FhY21AY29kZWF1cm9yYS5vcmcgd3JvdGU6Cj4+IE9uIDIwMjEtMDMtMzAgMjE6NDcsIEx1
IEJhb2x1IHdyb3RlOgo+Pj4gT24gMy8zMS8yMSAxMTowMCBBTSwgSXNhYWMgSi4gTWFuamFycmVz
IHdyb3RlOgo+Pj4+IEFkZCBhIGNhbGxiYWNrIGZvciBJT01NVSBkcml2ZXJzIHRvIHByb3ZpZGUg
YSBwYXRoIGZvciB0aGUKPj4+PiBJT01NVSBmcmFtZXdvcmsgdG8gY2FsbCBpbnRvIGFuIElPTU1V
IGRyaXZlciwgd2hpY2ggY2FuIGNhbGwKPj4+PiBpbnRvIHRoZSBpby1wZ3RhYmxlIGNvZGUsIHRv
IHVubWFwIGEgdmlydHVhbGx5IGNvbnRpZ3VvdXMKPj4+PiByYW5nZSBvZiBwYWdlcyBvZiB0aGUg
c2FtZSBzaXplLgo+Pj4+IAo+Pj4+IEZvciBJT01NVSBkcml2ZXJzIHRoYXQgZG8gbm90IHNwZWNp
ZnkgYW4gdW5tYXBfcGFnZXMoKSBjYWxsYmFjaywKPj4+PiB0aGUgZXhpc3RpbmcgbG9naWMgb2Yg
dW5tYXBwaW5nIG1lbW9yeSBvbmUgcGFnZSBibG9jayBhdCBhIHRpbWUKPj4+PiB3aWxsIGJlIHVz
ZWQuCj4+Pj4gCj4+Pj4gU2lnbmVkLW9mZi1ieTogSXNhYWMgSi4gTWFuamFycmVzIDxpc2FhY21A
Y29kZWF1cm9yYS5vcmc+Cj4+Pj4gU3VnZ2VzdGVkLWJ5OiBXaWxsIERlYWNvbiA8d2lsbEBrZXJu
ZWwub3JnPgo+Pj4+IC0tLQo+Pj4+IMKgIGluY2x1ZGUvbGludXgvaW9tbXUuaCB8IDQgKysrKwo+
Pj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKPj4+PiAKPj4+PiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9pb21tdS5oIGIvaW5jbHVkZS9saW51eC9pb21tdS5oCj4+Pj4g
aW5kZXggNWU3ZmU1MTk0MzBhLi45Y2Y4MTI0MjU4MWEgMTAwNjQ0Cj4+Pj4gLS0tIGEvaW5jbHVk
ZS9saW51eC9pb21tdS5oCj4+Pj4gKysrIGIvaW5jbHVkZS9saW51eC9pb21tdS5oCj4+Pj4gQEAg
LTE5Myw2ICsxOTMsNyBAQCBzdHJ1Y3QgaW9tbXVfaW90bGJfZ2F0aGVyIHsKPj4+PiDCoMKgICog
QGRldGFjaF9kZXY6IGRldGFjaCBkZXZpY2UgZnJvbSBhbiBpb21tdSBkb21haW4KPj4+PiDCoMKg
ICogQG1hcDogbWFwIGEgcGh5c2ljYWxseSBjb250aWd1b3VzIG1lbW9yeSByZWdpb24gdG8gYW4g
aW9tbXUgCj4+Pj4gZG9tYWluCj4+Pj4gwqDCoCAqIEB1bm1hcDogdW5tYXAgYSBwaHlzaWNhbGx5
IGNvbnRpZ3VvdXMgbWVtb3J5IHJlZ2lvbiBmcm9tIGFuIAo+Pj4+IGlvbW11IGRvbWFpbgo+Pj4+
ICsgKiBAdW5tYXBfcGFnZXM6IHVubWFwIGEgbnVtYmVyIG9mIHBhZ2VzIG9mIHRoZSBzYW1lIHNp
emUgZnJvbSBhbiAKPj4+PiBpb21tdSBkb21haW4KPj4+PiDCoMKgICogQGZsdXNoX2lvdGxiX2Fs
bDogU3luY2hyb25vdXNseSBmbHVzaCBhbGwgaGFyZHdhcmUgVExCcyBmb3IgCj4+Pj4gdGhpcyBk
b21haW4KPj4+PiDCoMKgICogQGlvdGxiX3N5bmNfbWFwOiBTeW5jIG1hcHBpbmdzIGNyZWF0ZWQg
cmVjZW50bHkgdXNpbmcgQG1hcCB0byAKPj4+PiB0aGUgaGFyZHdhcmUKPj4+PiDCoMKgICogQGlv
dGxiX3N5bmM6IEZsdXNoIGFsbCBxdWV1ZWQgcmFuZ2VzIGZyb20gdGhlIGhhcmR3YXJlIFRMQnMg
YW5kIAo+Pj4+IGVtcHR5IGZsdXNoCj4+Pj4gQEAgLTI0NSw2ICsyNDYsOSBAQCBzdHJ1Y3QgaW9t
bXVfb3BzIHsKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGh5c19hZGRyX3QgcGFkZHIs
IHNpemVfdCBzaXplLCBpbnQgcHJvdCwgZ2ZwX3QgZ2ZwKTsKPj4+PiDCoMKgwqDCoMKgIHNpemVf
dCAoKnVubWFwKShzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sIHVuc2lnbmVkIGxvbmcgCj4+
Pj4gaW92YSwKPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVfdCBzaXplLCBz
dHJ1Y3QgaW9tbXVfaW90bGJfZ2F0aGVyIAo+Pj4+ICppb3RsYl9nYXRoZXIpOwo+Pj4+ICvCoMKg
wqAgc2l6ZV90ICgqdW5tYXBfcGFnZXMpKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwgdW5z
aWduZWQgCj4+Pj4gbG9uZyBpb3ZhLAo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHNpemVfdCBwZ3NpemUsIHNpemVfdCBwZ2NvdW50LAo+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBpb21tdV9pb3RsYl9nYXRoZXIgKmlvdGxiX2dh
dGhlcik7Cj4+PiAKPj4+IElzIGl0IHBvc3NpYmxlIHRvIGFkZCBhbiBlcXVpdmFsZW50IG1hcF9w
YWdlcygpIGNhbGxiYWNrPwo+PiBZZXMsIG1hcF9wYWdlcygpIGNhbiBiZSBpbXBsZW1lbnRlZCBh
bmQgY2FuIGxldmVyYWdlIGEgbG90IG9mIHRoZSAKPj4gaW1wbGVtZW50YXRpb24KPj4gb2YgdW5t
YXBfcGFnZXMoKS4gVGhlIHByb2JsZW0gaXMgdGhhdCBpZiB5b3UgbWFwIHNldmVyYWwgcGFnZXMg
aW4gb25lIAo+PiBjYWxsLCBhbmQgdGhlbgo+PiBlbmNvdW50ZXIgYW4gZXJyb3IgYW5kIGhhdmUg
dG8gcm9sbGJhY2ssIHlvdSBzaG91bGQgZG8gVExCIAo+PiBtYWludGVuYW5jZSwgYXMgaW9tbXVf
bWFwCj4+IGRvZXMgd2hlbiBpdCBlbmNvdW50ZXJzIGFuIGVycm9yLiBIb3dldmVyLCB3ZSBjYW4n
dCBjYWxsIGlvbW11X3VubWFwIAo+PiBmcm9tIGlvLXBndGFibGUtYXJtCj4+IGZvciBleGFtcGxl
LiBXZSBjYW4gY2FsbCBhcm1fbHBhZV91bm1hcF9wYWdlcygpIGZyb20gdGhlIGxhdGVyIAo+PiBw
YXRjaGVzLCBidXQgdGhhdCBkb2Vzbid0Cj4+IHNvbHZlIHRoZSBUTEIgbWFpbnRlbmFuY2UgaXNz
dWUuIERvIHlvdSBoYXZlIGFueSB0aG91Z2h0cyBvbiBob3cgdG8gCj4+IGFkZHJlc3MgdGhpcz8K
PiAKPiBDYWxsIHVubWFwX3BhZ2VzKCkgd2l0aCB0aGUgc2FtZSBwYWdlcyBhbmQgc2l6ZSB0byBy
b2xsIGJhY2suIERvZXMgaXQKPiB3b3JrPwo+IAo+IEJlc3QgcmVnYXJkcywKPiBiYW9sdQpIaSBM
dSwKCkkndmUgZ2l2ZW4gbWFwX3BhZ2VzKCkgYSBzaG90LiBIZXJlJ3MgdGhlIHNlY29uZCB2ZXJz
aW9uIG9mIHRoZSBSRkMgCnNlcmllczogCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlv
bW11LzIwMjEwNDAyMDEzNDUyLjQwMTMtMS1pc2FhY21AY29kZWF1cm9yYS5vcmcvVC8jdC4KClRo
YW5rcywKSXNhYWMKPiAKPj4+IAo+Pj4+IMKgwqDCoMKgwqAgdm9pZCAoKmZsdXNoX2lvdGxiX2Fs
bCkoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluKTsKPj4+PiDCoMKgwqDCoMKgIHZvaWQgKCpp
b3RsYl9zeW5jX21hcCkoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLCB1bnNpZ25lZCAKPj4+
PiBsb25nIGlvdmEsCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzaXplX3Qgc2l6ZSk7Cj4+Pj4gCj4+PiAKPj4+IEJlc3QgcmVnYXJkcywKPj4+IGJhb2x1Cj4g
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
