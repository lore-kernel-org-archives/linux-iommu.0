Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D580FC433DB
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 15:11:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B00A207A4
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 15:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B00A207A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BE2B0871A5;
	Wed, 23 Dec 2020 15:11:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id or2L61hyUeKb; Wed, 23 Dec 2020 15:11:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 292298712C;
	Wed, 23 Dec 2020 15:11:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D535C1787;
	Wed, 23 Dec 2020 15:11:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEBAFC0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 15:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BE867203E2
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 15:11:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AWdA2Y7DjEHe for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 15:11:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from so254-31.mailgun.net (so254-31.mailgun.net [198.61.254.31])
 by silver.osuosl.org (Postfix) with ESMTPS id ABCF02010D
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 15:11:06 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1608736268; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0aAZ/bMuIrvzWM9gWlmih4RGaEX1HT300DY+Q/rbUMw=;
 b=rSQX6Abgh5oJTovbCgFzYuCQ1Pbvzf9r/d9CPIJeqLjtsQyXQaKcTjoGcOLoz+INeUL7gBzU
 hHhl78MO4hS+GpvObB9hDG1t7w2H68R1AgsWbLpnd4AI/1y1fwCPVWnVSh1SG68EfDYxhkOh
 0TYaNwsp42Z+4RuFjtJXFX+4ask=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5fe35e02e61d77c971ecc61a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 23 Dec 2020 15:10:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 75585C43463; Wed, 23 Dec 2020 15:10:57 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E4CBC433C6;
 Wed, 23 Dec 2020 15:10:56 +0000 (UTC)
MIME-Version: 1.0
Date: Wed, 23 Dec 2020 07:10:56 -0800
From: isaacm@codeaurora.org
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 3/7] iommu/arm-smmu: Add dependency on io-pgtable
 format modules
In-Reply-To: <b86f5972-2e9c-20bd-eee3-ee3ea53d5fe6@arm.com>
References: <1608597876-32367-1-git-send-email-isaacm@codeaurora.org>
 <1608597876-32367-4-git-send-email-isaacm@codeaurora.org>
 <3b0c191d-3fd0-73db-c1e3-4a80aa7953d7@arm.com>
 <e47f14b81d90772346ef28c9a7fd3365@codeaurora.org>
 <b86f5972-2e9c-20bd-eee3-ee3ea53d5fe6@arm.com>
Message-ID: <d2af5f0b1543ad374bc419507455a3cf@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: kernel-team@android.com, will@kernel.org, pdaly@codeaurora.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 pratikp@codeaurora.org
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

T24gMjAyMC0xMi0yMyAwNTowNSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjAtMTItMjIg
MTk6NDksIGlzYWFjbUBjb2RlYXVyb3JhLm9yZyB3cm90ZToKPj4gT24gMjAyMC0xMi0yMiAxMToy
NywgUm9iaW4gTXVycGh5IHdyb3RlOgo+Pj4gT24gMjAyMC0xMi0yMiAwMDo0NCwgSXNhYWMgSi4g
TWFuamFycmVzIHdyb3RlOgo+Pj4+IFRoZSBTTU1VIGRyaXZlciBkZXBlbmRzIG9uIHRoZSBhdmFp
bGFiaWxpdHkgb2YgdGhlIEFSTSBMUEFFIGFuZAo+Pj4+IEFSTSBWN1MgaW8tcGd0YWJsZSBmb3Jt
YXQgY29kZSB0byB3b3JrIHByb3Blcmx5LiBJbiBwcmVwYXJhdGlvbgo+Pj4gCj4+PiBOaXQ6IHdl
IGRvbid0IHJlYWxseSBkZXBlbmQgb24gdjdzIC0gd2UgKmNhbiogdXNlIGl0IGlmIGl0J3MKPj4+
IGF2YWlsYWJsZSwgYWRkcmVzcyBjb25zdHJhaW50cyBhcmUgc3VpdGFibGUsIGFuZCB0aGUgU01N
VQo+Pj4gaW1wbGVtZW50YXRpb24gYWN0dWFsbHkgc3VwcG9ydHMgaXQgKG1hbnkgZG9uJ3QpLCBi
dXQgd2UgY2FuIHN0aWxsCj4+PiBxdWl0ZSBoYXBwaWx5IG5vdCB1c2UgaXQgZXZlbiBzby4gTFBB
RSBpcyBtYW5kYXRvcnkgaW4gdGhlCj4+PiBhcmNoaXRlY3R1cmUgc28gdGhhdCdzIG91ciBvbmx5
IGhhcmQgcmVxdWlyZW1lbnQsIGVtYm9kaWVkIGluIHRoZQo+Pj4ga2NvbmZpZyBzZWxlY3QuCj4+
PiAKPj4+IFRoaXMgZG9lcyBtZWFuIHRoZXJlIG1heSB0ZWNobmljYWxseSBzdGlsbCBiZSBhIGNv
cm5lciBjYXNlIGludm9sdmluZwo+Pj4gQVJNX1NNTVU9eSBhbmQgSU9fUEdUQUJMRV9BUk1fVjdT
PW0sIGJ1dCBhdCB3b3JzdCBpdCdzIG5vdyBhIHJ1bnRpbWUKPj4+IGZhaWx1cmUgcmF0aGVyIHRo
YW4gYSBidWlsZCBlcnJvciwgc28gdW5sZXNzIGFuZCB1bnRpbCBhbnlvbmUKPj4+IGRlbW9uc3Ry
YXRlcyB0aGF0IGl0IGFjdHVhbGx5IG1hdHRlcnMgSSBkb24ndCBmZWVsIHBhcnRpY3VsYXJseQo+
Pj4gaW5jbGluZWQgdG8gZ2l2ZSBpdCBtdWNoIHRob3VnaHQuCj4+PiAKPj4+IFJvYmluLgo+Pj4g
Cj4+IE9rYXksIEknbGwgZml4IHVwIHRoZSBjb21taXQgbWVzc2FnZSwgYXMgd2VsbCBhcyB0aGUg
Y29kZSwgc28gdGhhdCBpdAo+PiBvbmx5IGRlcGVuZHMgb24gaW8tcGd0YWJsZS1hcm0uCj4gCj4g
V2VsbCwgSUlVQyBpdCB3b3VsZCBtYWtlIHNlbnNlIHRvIGtlZXAgdGhlIHNvZnRkZXAgZm9yIHdo
ZW4gdGhlIHY3cwo+IG1vZHVsZSAqaXMqIHByZXNlbnQ7IEkganVzdCB3YW50ZWQgdG8gY2xhcmlm
eSB0aGF0IGl0J3MgbW9yZSBvZiBhCj4gbmljZS10by1oYXZlIHJhdGhlciB0aGFuIGEgbmVjZXNz
aXR5Lgo+IAo+IFJvYmluLgo+IApVbmRlcnN0b29kLCBJIHdpbGwga2VlcCBpdCB0aGVyZSBhbmQg
cmV3b3JkIHRoZSBjb21taXQgbXNnLiBJIGp1c3QgdHJpZWQgCml0IG91dCBpbiBhbiBlbnZpcm9u
bWVudAp3aGVyZSB0aGUgaW8tcGd0YWJsZS1hcm0tdjdzIG1vZHVsZSBpc24ndCBwcmVzZW50LCBh
bmQgSSBkaWRuJ3Qgc2VlIGFueQp3YXJuaW5ncyBvciBlcnJvciBtZXNzYWdlcywgYW5kIHRoZSBT
TU1VIGRyaXZlciBtb2R1bGUgd2FzIGxvYWRlZCAKcHJvcGVybHksCnNvIHllcywgaXQncyBnb29k
IHRvIGhhdmUgaXQuCgpUaGFua3MsCklzYWFjCj4+IFRoYW5rcywKPj4gSXNhYWMKPj4+PiBmb3Ig
aGF2aW5nIHRoZSBpby1wZ3RhYmxlIGZvcm1hdHMgYXMgbW9kdWxlcywgYWRkIGEgInByZSIKPj4+
PiBkZXBlbmRlbmN5IHdpdGggTU9EVUxFX1NPRlRERVAoKSB0byBlbnN1cmUgdGhhdCB0aGUgaW8t
cGd0YWJsZQo+Pj4+IGZvcm1hdCBtb2R1bGVzIGFyZSBsb2FkZWQgYmVmb3JlIGxvYWRpbmcgdGhl
IEFSTSBTTU1VIGRyaXZlciBtb2R1bGUuCj4+Pj4gCj4+Pj4gU2lnbmVkLW9mZi1ieTogSXNhYWMg
Si4gTWFuamFycmVzIDxpc2FhY21AY29kZWF1cm9yYS5vcmc+Cj4+Pj4gLS0tCj4+Pj4gwqAgZHJp
dmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuYyB8IDEgKwo+Pj4+IMKgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Pj4+IAo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lv
bW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jIAo+Pj4+IGIvZHJpdmVycy9pb21tdS9hcm0vYXJt
LXNtbXUvYXJtLXNtbXUuYwo+Pj4+IGluZGV4IGQ4YzZiZmQuLmE3MjY0OWYgMTAwNjQ0Cj4+Pj4g
LS0tIGEvZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUvYXJtLXNtbXUuYwo+Pj4+ICsrKyBiL2Ry
aXZlcnMvaW9tbXUvYXJtL2FybS1zbW11L2FybS1zbW11LmMKPj4+PiBAQCAtMjM1MSwzICsyMzUx
LDQgQEAgTU9EVUxFX0RFU0NSSVBUSU9OKCJJT01NVSBBUEkgZm9yIEFSTSAKPj4+PiBhcmNoaXRl
Y3RlZCBTTU1VIGltcGxlbWVudGF0aW9ucyIpOwo+Pj4+IMKgIE1PRFVMRV9BVVRIT1IoIldpbGwg
RGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+Iik7Cj4+Pj4gwqAgTU9EVUxFX0FMSUFTKCJwbGF0Zm9y
bTphcm0tc21tdSIpOwo+Pj4+IMKgIE1PRFVMRV9MSUNFTlNFKCJHUEwgdjIiKTsKPj4+PiArTU9E
VUxFX1NPRlRERVAoInByZTogaW8tcGd0YWJsZS1hcm0gaW8tcGd0YWJsZS1hcm0tdjdzIik7Cj4+
Pj4gCj4+PiAKPj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4+PiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAo+Pj4gbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCj4+PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2lvbW11
