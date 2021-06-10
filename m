Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5107C48BCD
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 09:36:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9241161426
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 09:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9241161426
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51D1F83D10;
	Thu, 10 Jun 2021 09:36:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NeSTmCPkmiEz; Thu, 10 Jun 2021 09:36:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E476883CF2;
	Thu, 10 Jun 2021 09:36:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C45EDC000D;
	Thu, 10 Jun 2021 09:36:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41824C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 09:36:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with UTF8SMTP id 283E540214
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 09:36:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id bjjZO1l524n3 for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 09:36:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp2.osuosl.org (Postfix) with UTF8SMTPS id 1B08E401DF
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 09:36:44 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1623317807; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=3Nr5XeD9lkZbSovGodMNy9bg536mnJtqaK+uPHyUp30=;
 b=tBYmu4LSRH6PicFLhT75KRQvo4ruf9F4UkQmeNw1rnaDjoGe2IkROO2I+wC5TPpIdC9mM8IE
 o2bE3RLneD86FMkGYYXjcFPbc312B/A7rrHXfZxYki4GhhsDs1V/KNsE2x2S/pxIZk6fSOGN
 Y1NUb5/fkqhurd7qGiylOjXbOng=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60c1dd19b6ccaab7530e5689 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 10 Jun 2021 09:36:25
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 2D0BEC43460; Thu, 10 Jun 2021 09:36:25 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: saiprakash.ranjan)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id E64D4C433F1;
 Thu, 10 Jun 2021 09:36:23 +0000 (UTC)
MIME-Version: 1.0
Date: Thu, 10 Jun 2021 15:06:23 +0530
From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Optimize partial walk flush for
 large scatter-gather list
In-Reply-To: <35bfd245-45e2-8083-b620-330d6dbd7bd7@arm.com>
References: <20210609145315.25750-1-saiprakash.ranjan@codeaurora.org>
 <dbcd394a-4d85-316c-5dd0-033546a66132@arm.com>
 <c600e9b2534d54082a5272b508a7985f@codeaurora.org>
 <35bfd245-45e2-8083-b620-330d6dbd7bd7@arm.com>
Message-ID: <12067ffb8243b220cf03e83aaac3e823@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
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

SGkgUm9iaW4sCgpPbiAyMDIxLTA2LTEwIDE0OjM4LCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24g
MjAyMS0wNi0xMCAwNjoyNCwgU2FpIFByYWthc2ggUmFuamFuIHdyb3RlOgo+PiBIaSBSb2JpbiwK
Pj4gCj4+IE9uIDIwMjEtMDYtMTAgMDA6MTQsIFJvYmluIE11cnBoeSB3cm90ZToKPj4+IE9uIDIw
MjEtMDYtMDkgMTU6NTMsIFNhaSBQcmFrYXNoIFJhbmphbiB3cm90ZToKPj4+PiBDdXJyZW50bHkg
Zm9yIGlvbW11X3VubWFwKCkgb2YgbGFyZ2Ugc2NhdHRlci1nYXRoZXIgbGlzdCB3aXRoIHBhZ2Ug
Cj4+Pj4gc2l6ZQo+Pj4+IGVsZW1lbnRzLCB0aGUgbWFqb3JpdHkgb2YgdGltZSBpcyBzcGVudCBp
biBmbHVzaGluZyBvZiBwYXJ0aWFsIHdhbGtzIAo+Pj4+IGluCj4+Pj4gX19hcm1fbHBhZV91bm1h
cCgpIHdoaWNoIGlzIGEgVkEgYmFzZWQgVExCIGludmFsaWRhdGlvbiAoVExCSVZBIGZvcgo+Pj4+
IGFybS1zbW11KS4KPj4+PiAKPj4+PiBGb3IgZXhhbXBsZTogdG8gdW5tYXAgYSAzMk1CIHNjYXR0
ZXItZ2F0aGVyIGxpc3Qgd2l0aCBwYWdlIHNpemUgCj4+Pj4gZWxlbWVudHMKPj4+PiAoODE5MiBl
bnRyaWVzKSwgdGhlcmUgYXJlIDE2LT4yTUIgYnVmZmVyIHVubWFwcyBiYXNlZCBvbiB0aGUgcGdz
aXplIAo+Pj4+ICgyTUIKPj4+PiBmb3IgNEsgZ3JhbnVsZSkgYW5kIGVhY2ggb2YgMk1CIHdpbGwg
ZnVydGhlciByZXN1bHQgaW4gNTEyIFRMQklWQXMgCj4+Pj4gKDJNQi80SykKPj4+PiByZXN1bHRp
bmcgaW4gYSB0b3RhbCBvZiA4MTkyIFRMQklWQXMgKDUxMioxNikgZm9yIDE2LT4yTUIgY2F1c2lu
ZyBhIAo+Pj4+IGh1Z2UKPj4+PiBvdmVyaGVhZC4KPj4+PiAKPj4+PiBTbyBpbnN0ZWFkIHVzZSBp
b19wZ3RhYmxlX3RsYl9mbHVzaF9hbGwoKSB0byBpbnZhbGlkYXRlIHRoZSBlbnRpcmUgCj4+Pj4g
Y29udGV4dAo+Pj4+IGlmIHNpemUgKHBnc2l6ZSkgaXMgZ3JlYXRlciB0aGFuIHRoZSBncmFudWxl
IHNpemUgKDRLLCAxNkssIDY0SykuIAo+Pj4+IEZvciB0aGlzCj4+Pj4gZXhhbXBsZSBvZiAzMk1C
IHNjYXR0ZXItZ2F0aGVyIGxpc3QgdW5tYXAsIHRoaXMgcmVzdWx0cyBpbiBqdXN0IDE2IAo+Pj4+
IEFTSUQKPj4+PiBiYXNlZCBUTEIgaW52YWxpZGF0aW9ucyBvciB0bGJfZmx1c2hfYWxsKCkgY2Fs
bGJhY2sgKFRMQklBU0lEIGluIAo+Pj4+IGNhc2Ugb2YKPj4+PiBhcm0tc21tdSkgYXMgb3Bwb3Nl
ZCB0byA4MTkyIFRMQklWQXMgdGhlcmVieSBpbmNyZWFzaW5nIHRoZSAKPj4+PiBwZXJmb3JtYW5j
ZSBvZgo+Pj4+IHVubWFwcyBkcmFzdGljYWxseS4KPj4+PiAKPj4+PiBDb25kaXRpb24gKHNpemUg
PiBncmFudWxlIHNpemUpIGlzIGNob3NlbiBmb3IgCj4+Pj4gaW9fcGd0YWJsZV90bGJfZmx1c2hf
YWxsKCkKPj4+PiBiZWNhdXNlIGZvciBhbnkgZ3JhbnVsZSB3aXRoIHN1cHBvcnRlZCBwZ3NpemVz
LCB3ZSB3aWxsIGhhdmUgYXQgCj4+Pj4gbGVhc3QgNTEyCj4+Pj4gVExCIGludmFsaWRhdGlvbnMg
Zm9yIHdoaWNoIHRsYl9mbHVzaF9hbGwoKSBpcyBhbHJlYWR5IHJlY29tbWVuZGVkLiAKPj4+PiBG
b3IKPj4+PiBleGFtcGxlLCB0YWtlIDRLIGdyYW51bGUgd2l0aCAyTUIgcGdzaXplLCB0aGlzIHdp
bGwgcmVzdWx0IGluIDUxMiAKPj4+PiBUTEJJVkEKPj4+PiBpbiBwYXJ0aWFsIHdhbGsgZmx1c2gu
Cj4+Pj4gCj4+Pj4gVGVzdCBvbiBRVEkgU004MTUwIFNvQyBmb3IgMTAgaXRlcmF0aW9ucyBvZiBp
b21tdV97bWFwX3NnfS91bm1hcDoKPj4+PiAoYXZlcmFnZSBvdmVyIDEwIGl0ZXJhdGlvbnMpCj4+
Pj4gCj4+Pj4gQmVmb3JlIHRoaXMgb3B0aW1pemF0aW9uOgo+Pj4+IAo+Pj4+IMKgwqDCoMKgIHNp
emXCoMKgwqDCoMKgwqDCoCBpb21tdV9tYXBfc2fCoMKgwqDCoMKgIGlvbW11X3VubWFwCj4+Pj4g
wqDCoMKgwqDCoMKgIDRLwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAyLjA2NyB1c8KgwqDCoMKgwqDC
oMKgwqAgMS44NTQgdXMKPj4+PiDCoMKgwqDCoMKgIDY0S8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
OS41OTggdXPCoMKgwqDCoMKgwqDCoMKgIDguODAyIHVzCj4+Pj4gwqDCoMKgwqDCoMKgIDFNwqDC
oMKgwqDCoMKgwqDCoMKgIDE0OC44OTAgdXPCoMKgwqDCoMKgwqAgMTMwLjcxOCB1cwo+Pj4+IMKg
wqDCoMKgwqDCoCAyTcKgwqDCoMKgwqDCoMKgwqDCoCAzMDUuODY0IHVzwqDCoMKgwqDCoMKgwqAg
NjcuMjkxIHVzCj4+Pj4gwqDCoMKgwqDCoCAxMk3CoMKgwqDCoMKgwqDCoMKgIDE3OTMuNjA0IHVz
wqDCoMKgwqDCoMKgIDM5MC44MzggdXMKPj4+PiDCoMKgwqDCoMKgIDE2TcKgwqDCoMKgwqDCoMKg
wqAgMjM4Ni44NDggdXPCoMKgwqDCoMKgwqAgNTE4LjE4NyB1cwo+Pj4+IMKgwqDCoMKgwqAgMjRN
wqDCoMKgwqDCoMKgwqDCoCAzNTYzLjI5NiB1c8KgwqDCoMKgwqDCoCA3NzUuOTg5IHVzCj4+Pj4g
wqDCoMKgwqDCoCAzMk3CoMKgwqDCoMKgwqDCoMKgIDQ3NDcuMTcxIHVzwqDCoMKgwqDCoCAxMDMz
LjM2NCB1cwo+Pj4+IAo+Pj4+IEFmdGVyIHRoaXMgb3B0aW1pemF0aW9uOgo+Pj4+IAo+Pj4+IMKg
wqDCoMKgIHNpemXCoMKgwqDCoMKgwqDCoCBpb21tdV9tYXBfc2fCoMKgwqDCoMKgIGlvbW11X3Vu
bWFwCj4+Pj4gwqDCoMKgwqDCoMKgIDRLwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxLjcyMyB1c8Kg
wqDCoMKgwqDCoMKgwqAgMS43NjUgdXMKPj4+PiDCoMKgwqDCoMKgIDY0S8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgOS44ODAgdXPCoMKgwqDCoMKgwqDCoMKgIDguODY5IHVzCj4+Pj4gwqDCoMKgwqDC
oMKgIDFNwqDCoMKgwqDCoMKgwqDCoMKgIDE1NS4zNjQgdXPCoMKgwqDCoMKgwqAgMTM1LjIyMyB1
cwo+Pj4+IMKgwqDCoMKgwqDCoCAyTcKgwqDCoMKgwqDCoMKgwqDCoCAzMDMuOTA2IHVzwqDCoMKg
wqDCoMKgwqDCoCA1LjM4NSB1cwo+Pj4+IMKgwqDCoMKgwqAgMTJNwqDCoMKgwqDCoMKgwqDCoCAx
Nzg2LjU1NyB1c8KgwqDCoMKgwqDCoMKgIDIxLjI1MCB1cwo+Pj4+IMKgwqDCoMKgwqAgMTZNwqDC
oMKgwqDCoMKgwqDCoCAyMzkxLjg5MCB1c8KgwqDCoMKgwqDCoMKgIDI3LjQzNyB1cwo+Pj4+IMKg
wqDCoMKgwqAgMjRNwqDCoMKgwqDCoMKgwqDCoCAzNTcwLjg5NSB1c8KgwqDCoMKgwqDCoMKgIDM5
LjkzNyB1cwo+Pj4+IMKgwqDCoMKgwqAgMzJNwqDCoMKgwqDCoMKgwqDCoCA0NzU1LjIzNCB1c8Kg
wqDCoMKgwqDCoMKgIDUxLjc5NyB1cwo+Pj4+IAo+Pj4+IFRoaXMgaXMgZnVydGhlciByZWR1Y2Vk
IG9uY2UgdGhlIG1hcC91bm1hcF9wYWdlcygpIHN1cHBvcnQgZ2V0cyBpbiAKPj4+PiB3aGljaAo+
Pj4+IHdpbGwgcmVzdWx0IGluIGp1c3QgMSB0bGJfZmx1c2hfYWxsKCkgYXMgb3Bwb3NlZCB0byAx
NiAKPj4+PiB0bGJfZmx1c2hfYWxsKCkuCj4+Pj4gCj4+Pj4gU2lnbmVkLW9mZi1ieTogU2FpIFBy
YWthc2ggUmFuamFuIDxzYWlwcmFrYXNoLnJhbmphbkBjb2RlYXVyb3JhLm9yZz4KPj4+PiAtLS0K
Pj4+PiDCoCBkcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLmMgfCA3ICsrKysrLS0KPj4+PiDC
oCAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4+IAo+
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLmMgCj4+Pj4gYi9k
cml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLmMKPj4+PiBpbmRleCA4N2RlZjU4ZTc5YjUuLmMz
Y2I5YWRkMzE3OSAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJt
LmMKPj4+PiArKysgYi9kcml2ZXJzL2lvbW11L2lvLXBndGFibGUtYXJtLmMKPj4+PiBAQCAtNTg5
LDggKzU4OSwxMSBAQCBzdGF0aWMgc2l6ZV90IF9fYXJtX2xwYWVfdW5tYXAoc3RydWN0IAo+Pj4+
IGFybV9scGFlX2lvX3BndGFibGUgKmRhdGEsCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBp
ZiAoIWlvcHRlX2xlYWYocHRlLCBsdmwsIGlvcC0+Zm10KSkgewo+Pj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIC8qIEFsc28gZmx1c2ggYW55IHBhcnRpYWwgd2Fsa3MgKi8KPj4+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpb19wZ3RhYmxlX3RsYl9mbHVzaF93YWxrKGlvcCwgaW92YSwg
c2l6ZSwKPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgQVJNX0xQQUVfR1JBTlVMRShkYXRhKSk7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgaWYgKHNpemUgPiBBUk1fTFBBRV9HUkFOVUxFKGRhdGEpKQo+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaW9fcGd0YWJsZV90bGJfZmx1c2hfYWxsKGlvcCk7Cj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxzZQo+Pj4gCj4+PiBFcm0sIHdoZW4gd2lsbCB0aGUgYWJv
dmUgY29uZGl0aW9uIGV2ZXIgbm90IGJlIHRydWU/IDspCj4+PiAKPj4gCj4+IEFoIHJpZ2h0LCBz
aWxseSBtZSA6KQo+PiAKPj4+IFRha2luZyBhIHN0ZXAgYmFjaywgdGhvdWdoLCB3aGF0IGFib3V0
IHRoZSBpbXBhY3QgdG8gZHJpdmVycyBvdGhlcgo+Pj4gdGhhbiBTTU1VdjI/Cj4+IAo+PiBPdGhl
ciBkcml2ZXJzIHdvdWxkIGJlIG1zbV9pb21tdS5jLCBxY29tX2lvbW11LmMgd2hpY2ggZG9lcyB0
aGUgc2FtZQo+PiB0aGluZyBhcyBhcm0tc21tdS12MiAocGFnZSBiYXNlZCBpbnZhbGlkYXRpb25z
KSwgdGhlbiB0aGVyZSBpcyAKPj4gaXBtbXUtdm1zYS5jCj4+IHdoaWNoIGRvZXMgdGxiX2ZsdXNo
X2FsbCgpIGZvciBmbHVzaCB3YWxrLgo+PiAKPj4+IEluIHBhcnRpY3VsYXIgSSdtIHRoaW5raW5n
IG9mIFNNTVV2My4yIHdoZXJlIHRoZSB3aG9sZQo+Pj4gcmFuZ2UgY2FuIGJlIGludmFsaWRhdGVk
IGJ5IFZBIGluIGEgc2luZ2xlIGNvbW1hbmQgYW55d2F5LCBzbyB0aGUKPj4+IGFkZGl0aW9uYWwg
cGVuYWx0aWVzIG9mIFRMQklBTEwgYXJlIHVuZGVzaXJhYmxlLgo+Pj4gCj4+IAo+PiBSaWdodCwg
c28gSSBhbSB0aGlua2luZyB3ZSBjYW4gaGF2ZSBhIG5ldyBnZW5lcmljIHF1aXJrIAo+PiBJT19Q
R1RBQkxFX1FVSVJLX1JBTkdFX0lOVgo+PiB0byBjaG9vc2UgYmV0d2VlbiByYW5nZSBiYXNlZCBp
bnZhbGlkYXRpb25zKHRsYl9mbHVzaF93YWxrKSBhbmQgCj4+IHRsYl9mbHVzaF9hbGwoKS4KPj4g
SW4gdGhpcyBjYXNlIG9mIGFybS1zbW11LXYzLjIsIHdlIGNhbiB0aWUgdXAgQVJNX1NNTVVfRkVB
VF9SQU5HRV9JTlYgCj4+IHdpdGggdGhpcyBxdWlyawo+PiBhbmQgaGF2ZSBzb21ldGhpbmcgbGlr
ZSBiZWxvdywgdGhvdWdodHM/Cj4+IAo+PiBpZiAoaW9wLT5jZmcucXVpcmtzICYgSU9fUEdUQUJM
RV9RVUlSS19SQU5HRV9JTlYpCj4+ICDCoMKgwqDCoMKgwqDCoCBpb19wZ3RhYmxlX3RsYl9mbHVz
aF93YWxrKGlvcCwgaW92YSwgc2l6ZSwKPj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBUk1fTFBBRV9HUkFOVUxFKGRh
dGEpKTsKPj4gZWxzZQo+PiAgwqDCoMKgwqDCoMKgwqAgaW9fcGd0YWJsZV90bGJfZmx1c2hfYWxs
KGlvcCk7Cj4gCj4gVGhlIGRlc2lnbiBoZXJlIGhhcyBhbHdheXMgYmVlbiB0aGF0IGlvLXBndGFi
bGUgc2F5cyAqd2hhdCogbmVlZHMKPiBpbnZhbGlkYXRpbmcsIGFuZCB3ZSBsZWZ0IGl0IHVwIHRv
IHRoZSBkcml2ZXJzIHRvIGRlY2lkZSBleGFjdGx5Cj4gKmhvdyouIEV2ZW4gdGhvdWdoIHRoaW5n
cyBoYXZlIGV2b2x2ZWQgYSBiaXQgSSBkb24ndCB0aGluayB0aGF0IGhhcwo+IGZ1bmRhbWVudGFs
bHkgY2hhbmdlZCAtIHRsYl9mbHVzaF93YWxrIGlzIG5vdyBvbmx5IHVzZWQgaW4gdGhpcyBvbmUK
PiBwbGFjZSAodGVjaG5pY2FsbHkgSSBzdXBwb3NlIGl0IGNvdWxkIGJlIHJlbmFtZWQgdGxiX2Zs
dXNoX3RhYmxlIGJ1dAo+IGl0J3Mgbm90IHdvcnRoIHRoZSBjaHVybiksIHNvIGRyaXZlcnMgY2Fu
IGltcGxlbWVudCB0aGVpciBvd24KPiBwcmVmZXJyZWQgdGFibGUtaW52YWxpZGF0aW5nIGJlaGF2
aW91ciBldmVuIG1vcmUgZWFzaWx5IHRoYW4gY2hvb3NpbmcKPiB3aGV0aGVyIHRvIGJvdW5jZSBh
IHF1aXJrIHRocm91Z2ggdGhlIGNvbW1vbiBjb2RlIG9yIG5vdC4gQ29uc2lkZXIKPiB3aGF0IHlv
dSd2ZSBhbHJlYWR5IHNlZW4gZm9yIHRoZSBSZW5lc2FzIElQTU1VLCBvciBTTU1VdjEgc3RhZ2Ug
Mi4uLgo+IAoKVGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24sIG1ha2VzIHNlbnNlLiBJZiBJIGFt
IG5vdCBtaXN0YWtlbiwgSSBzZWUgCnRoYXQKeW91IGFyZSBzdWdnZXN0aW5nIHRvIG1vdmUgdGhp
cyBsb2dpYyBiYXNlZCBvbiBzaXplIGFuZCBncmFudWxlLXNpemUgdG8KYXJtLXNtbXUtdjIgZHJp
dmVyIGFuZCBvbmUgbW9yZSB0aGluZyBiZWxvdy4uCgoKPiBJJ20gaW5zdGluY3RpdmVseSBhIGxp
dHRsZSB0d2l0Y2h5IGFib3V0IG1ha2luZyB0aGlzIGEgYmxhbmtldAo+IG9wdGltaXNhdGlvbiBm
b3IgU01NVXYyIHNpbmNlIEkgc3RpbGwgcmVtZW1iZXIgdGhlIHBhbGF2ZXIgd2l0aCBvdXIKPiBk
aXNwbGF5IGFuZCBNTVUtNTAwIGludGVncmF0aW9ucywgd2hlcmUgaXQgaGFkIHRvIGltcGxlbWVu
dCB0aGUgZG9kZ3kKPiAicHJlZmV0Y2giIHJlZ2lzdGVyIHRvIHRyaWdnZXIgdHJhbnNsYXRpb25z
IGJlZm9yZSBzY2FubmluZyBvdXQgYQo+IGZyYW1lIHNpbmNlIGl0IGNvdWxkbid0IGV2ZXIgYWZm
b3JkIGEgVExCIG1pc3MsIHRodXMgVExCSUFMTCB3aGVuCj4gZnJlZWluZyBhbiBvbGQgYnVmZmVy
IHdvdWxkIGJlIGEgZGFuZ2Vyb3VzIGhhbW1lciB0byBzd2luZy4gSG93ZXZlcgo+IElJUkMgaXQg
YWxzbyBoYWQgdG8gZW5zdXJlIGV2ZXJ5dGhpbmcgd2FzIG1hcHBlZCBhcyAyTUIgYmxvY2tzIHRv
Cj4gZ3VhcmFudGVlIGZpdHRpbmcgZXZlcnl0aGluZyBpbiB0aGUgVExCcyBpbiB0aGUgZmlyc3Qg
cGxhY2UsIHNvIEkKPiBndWVzcyBpdCB3b3VsZCBzdGlsbCB3b3JrIG91dCBPSyBkdWUgdG8gbmV2
ZXIgcmVhbGlzdGljYWxseSB1bm1hcHBpbmcKPiBhIHdob2xlIHRhYmxlIGF0IG9uY2UgYW55d2F5
Lgo+IAoKWW91IGFyZSBhbHNvIGhpbnRpbmcgdG8gbm90IGRvIHRoaXMgZm9yIGFsbCBTTU1VdjIg
aW1wbGVtZW50YXRpb25zIGFuZCAKbWFrZQppdCBRQ09NIHNwZWNpZmljPwoKSWYgSSBhbSB3cm9u
ZyBpbiBteSBhc3N1bXB0aW9ucyBoZXJlLCBwbGVhc2UgbGV0IG1lIGtub3cgb3RoZXJ3aXNlIEkg
CndpbGwKcHJlcGFyZSB0aGUgcGF0Y2ggOikKClRoYW5rcywKU2FpCgotLSAKUVVBTENPTU0gSU5E
SUEsIG9uIGJlaGFsZiBvZiBRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBpcyBhIApt
ZW1iZXIKb2YgQ29kZSBBdXJvcmEgRm9ydW0sIGhvc3RlZCBieSBUaGUgTGludXggRm91bmRhdGlv
bgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
