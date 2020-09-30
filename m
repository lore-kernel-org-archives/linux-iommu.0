Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF09C4727F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:48:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E60206DB
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="fYmgx/Yn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E60206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8EDB7871B7;
	Wed, 30 Sep 2020 05:48:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sn4HGtg2WctA; Wed, 30 Sep 2020 05:48:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DA7528708F;
	Wed, 30 Sep 2020 05:48:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2E73C0889;
	Wed, 30 Sep 2020 05:48:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4418C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8BD9E2001C
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:48:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X9CZJwdKOO1p for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 05:48:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m42-4.mailgun.net (m42-4.mailgun.net [69.72.42.4])
 by silver.osuosl.org (Postfix) with ESMTPS id 71C511FF11
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:48:32 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1601444912; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=ICRz9bRTsq/bDpqKNT04D4ibLj+YBqbEAedTTF1vnRM=;
 b=fYmgx/YnCVNbJ7PBLrwnK6f8ATJ0rXssqkYngYyNMuoQkjOLNhiCt79lhjZX9v4+bmFUHZ9J
 dnbPy9exzQyeUHxfVwotnC0Ep02i8Q0EykHv9HxXei2gsAg4JK3rdoNXaauCbM9cNDWk4VVK
 H27XfhPwXUHyOSb++TSUk0tdrUM=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f741c30809bd3301448563e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Sep 2020 05:48:32
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 226B2C433F1; Wed, 30 Sep 2020 05:48:32 +0000 (UTC)
Received: from [192.168.0.101] (unknown [103.248.210.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: vjitta)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 47B5CC433CB;
 Wed, 30 Sep 2020 05:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47B5CC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH v2 1/2] iommu/iova: Retry from last rb tree node if iova
 search fails
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1597927761-24441-1-git-send-email-vjitta@codeaurora.org>
 <07270e29-c9d4-ae8c-a236-eb6fefccbf6c@arm.com>
From: Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <8efbdd09-8f0f-e6fe-ab82-db08f6d5b5b5@codeaurora.org>
Date: Wed, 30 Sep 2020 11:18:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <07270e29-c9d4-ae8c-a236-eb6fefccbf6c@arm.com>
Content-Language: en-GB
Cc: vinmenon@codeaurora.org, kernel-team@android.com
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

CgpPbiA5LzE4LzIwMjAgNzo0OCBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjAtMDgt
MjAgMTM6NDksIHZqaXR0YUBjb2RlYXVyb3JhLm9yZyB3cm90ZToKPj4gRnJvbTogVmlqYXlhbmFu
ZCBKaXR0YSA8dmppdHRhQGNvZGVhdXJvcmEub3JnPgo+Pgo+PiBXaGVuIGV2ZXIgYSBuZXcgaW92
YSBhbGxvYyByZXF1ZXN0IGNvbWVzIGlvdmEgaXMgYWx3YXlzIHNlYXJjaGVkCj4+IGZyb20gdGhl
IGNhY2hlZCBub2RlIGFuZCB0aGUgbm9kZXMgd2hpY2ggYXJlIHByZXZpb3VzIHRvIGNhY2hlZAo+
PiBub2RlLiBTbywgZXZlbiBpZiB0aGVyZSBpcyBmcmVlIGlvdmEgc3BhY2UgYXZhaWxhYmxlIGlu
IHRoZSBub2Rlcwo+PiB3aGljaCBhcmUgbmV4dCB0byB0aGUgY2FjaGVkIG5vZGUgaW92YSBhbGxv
Y2F0aW9uIGNhbiBzdGlsbCBmYWlsCj4+IGJlY2F1c2Ugb2YgdGhpcyBhcHByb2FjaC4KPj4KPj4g
Q29uc2lkZXIgdGhlIGZvbGxvd2luZyBzZXF1ZW5jZSBvZiBpb3ZhIGFsbG9jIGFuZCBmcmVlcyBv
bgo+PiAxR0Igb2YgaW92YSBzcGFjZQo+Pgo+PiAxKSBhbGxvYyAtIDUwME1CCj4+IDIpIGFsbG9j
IC0gMTJNQgo+PiAzKSBhbGxvYyAtIDQ5OU1CCj4+IDQpIGZyZWUgLcKgIDEyTUIgd2hpY2ggd2Fz
IGFsbG9jYXRlZCBpbiBzdGVwIDIKPj4gNSkgYWxsb2MgLSAxM01CCj4+Cj4+IEFmdGVyIHRoZSBh
Ym92ZSBzZXF1ZW5jZSB3ZSB3aWxsIGhhdmUgMTJNQiBvZiBmcmVlIGlvdmEgc3BhY2UgYW5kCj4+
IGNhY2hlZCBub2RlIHdpbGwgYmUgcG9pbnRpbmcgdG8gdGhlIGlvdmEgcGZuIG9mIGxhc3QgYWxs
b2Mgb2YgMTNNQgo+PiB3aGljaCB3aWxsIGJlIHRoZSBsb3dlc3QgaW92YSBwZm4gb2YgdGhhdCBp
b3ZhIHNwYWNlLiBOb3cgaWYgd2UgZ2V0IGFuCj4+IGFsbG9jIHJlcXVlc3Qgb2YgMk1CIHdlIGp1
c3Qgc2VhcmNoIGZyb20gY2FjaGVkIG5vZGUgYW5kIHRoZW4gbG9vawo+PiBmb3IgbG93ZXIgaW92
YSBwZm4ncyBmb3IgZnJlZSBpb3ZhIGFuZCBhcyB0aGV5IGFyZW4ndCBhbnksIGlvdmEgYWxsb2MK
Pj4gZmFpbHMgdGhvdWdoIHRoZXJlIGlzIDEyTUIgb2YgZnJlZSBpb3ZhIHNwYWNlLgo+Pgo+PiBU
byBhdm9pZCBzdWNoIGlvdmEgc2VhcmNoIGZhaWx1cmVzIGRvIGEgcmV0cnkgZnJvbSB0aGUgbGFz
dCByYiB0cmVlIG5vZGUKPj4gd2hlbiBpb3ZhIHNlYXJjaCBmYWlscywgdGhpcyB3aWxsIHNlYXJj
aCB0aGUgZW50aXJlIHRyZWUgYW5kIGdldCBhbiBpb3ZhCj4+IGlmIGl0cyBhdmFpbGFibGUuCj4+
Cj4+IFNpZ25lZC1vZmYtYnk6IFZpamF5YW5hbmQgSml0dGEgPHZqaXR0YUBjb2RlYXVyb3JhLm9y
Zz4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvaW9tbXUvaW92YS5jIHwgMjMgKysrKysrKysrKysrKysr
KystLS0tLS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDYgZGVsZXRp
b25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2lvdmEuYyBiL2RyaXZlcnMv
aW9tbXUvaW92YS5jCj4+IGluZGV4IDQ5ZmMwMWYuLjRlNzcxMTYgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvaW9tbXUvaW92YS5jCj4+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW92YS5jCj4+IEBAIC0x
ODQsOCArMTg0LDkgQEAgc3RhdGljIGludCBfX2FsbG9jX2FuZF9pbnNlcnRfaW92YV9yYW5nZShz
dHJ1Y3QKPj4gaW92YV9kb21haW4gKmlvdmFkLAo+PiDCoMKgwqDCoMKgIHN0cnVjdCByYl9ub2Rl
ICpjdXJyLCAqcHJldjsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgaW92YSAqY3Vycl9pb3ZhOwo+PiDC
oMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4+IC3CoMKgwqAgdW5zaWduZWQgbG9uZyBu
ZXdfcGZuOwo+PiArwqDCoMKgIHVuc2lnbmVkIGxvbmcgbmV3X3BmbiwgbG93X3Bmbl9uZXc7Cj4+
IMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBhbGlnbl9tYXNrID0gfjBVTDsKPj4gK8KgwqDCoCB1
bnNpZ25lZCBsb25nIGhpZ2hfcGZuID0gbGltaXRfcGZuLCBsb3dfcGZuID0gaW92YWQtPnN0YXJ0
X3BmbjsKPj4gwqAgwqDCoMKgwqDCoCBpZiAoc2l6ZV9hbGlnbmVkKQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgYWxpZ25fbWFzayA8PD0gZmxzX2xvbmcoc2l6ZSAtIDEpOwo+PiBAQCAtMTk4LDE1ICsx
OTksMjUgQEAgc3RhdGljIGludCBfX2FsbG9jX2FuZF9pbnNlcnRfaW92YV9yYW5nZShzdHJ1Y3QK
Pj4gaW92YV9kb21haW4gKmlvdmFkLAo+PiDCoCDCoMKgwqDCoMKgIGN1cnIgPSBfX2dldF9jYWNo
ZWRfcmJub2RlKGlvdmFkLCBsaW1pdF9wZm4pOwo+PiDCoMKgwqDCoMKgIGN1cnJfaW92YSA9IHJi
X2VudHJ5KGN1cnIsIHN0cnVjdCBpb3ZhLCBub2RlKTsKPj4gK8KgwqDCoCBsb3dfcGZuX25ldyA9
IGN1cnJfaW92YS0+cGZuX2hpICsgMTsKPiAKPiBDb3VsZCB3ZSBjYWxsICJsb3dfcGZuX25ldyIg
c29tZXRoaW5nIGxpa2UgInJldHJ5X3BmbiIgaW5zdGVhZD8gVGhpcwo+IGNvZGUgYWxyZWFkeSBo
YXMgdW5hdm9pZGFibGUgcmVhZGFiaWxpdHkgc3RydWdnbGVzIHdpdGggc28gbWFueQo+IGRpZmZl
cmVudCAicGZuInMgaW4gcGxheSwgc28gaGF2aW5nIHR3byBkaWZmZXJlbnQgbWVhbmluZ3Mgb2Yg
Im5ldyIKPiByZWFsbHkgZG9lc24ndCBoZWxwLgo+IAo+IE90aGVyIHRoYW4gdGhhdCwgSSB0aGlu
ayB0aGlzIGxvb2tzIE9LIChJSVJDIGl0J3MgYmFzaWNhbGx5IHdoYXQgSQo+IG9yaWdpbmFsbHkg
c3VnZ2VzdGVkKSwgc28gd2l0aCB0aGUgbmFtaW5nIHR3ZWFrZWQsCj4gCj4gUmV2aWV3ZWQtYnk6
IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFybS5jb20+Cj4gCgpUaGFua3MgZm9yIHJldmll
dywgSSBoYXZlIHJlbmFtZWQgaXQgdG8gcmV0cnlfcGZuIGluIHY0LgoKVGhhbmtzLApWaWpheQo+
PiArCj4+ICtyZXRyeToKPj4gwqDCoMKgwqDCoCBkbyB7Cj4+IC3CoMKgwqDCoMKgwqDCoCBsaW1p
dF9wZm4gPSBtaW4obGltaXRfcGZuLCBjdXJyX2lvdmEtPnBmbl9sbyk7Cj4+IC3CoMKgwqDCoMKg
wqDCoCBuZXdfcGZuID0gKGxpbWl0X3BmbiAtIHNpemUpICYgYWxpZ25fbWFzazsKPj4gK8KgwqDC
oMKgwqDCoMKgIGhpZ2hfcGZuID0gbWluKGhpZ2hfcGZuLCBjdXJyX2lvdmEtPnBmbl9sbyk7Cj4+
ICvCoMKgwqDCoMKgwqDCoCBuZXdfcGZuID0gKGhpZ2hfcGZuIC0gc2l6ZSkgJiBhbGlnbl9tYXNr
Owo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcHJldiA9IGN1cnI7Cj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBjdXJyID0gcmJfcHJldihjdXJyKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGN1cnJfaW92YSA9
IHJiX2VudHJ5KGN1cnIsIHN0cnVjdCBpb3ZhLCBub2RlKTsKPj4gLcKgwqDCoCB9IHdoaWxlIChj
dXJyICYmIG5ld19wZm4gPD0gY3Vycl9pb3ZhLT5wZm5faGkpOwo+PiAtCj4+IC3CoMKgwqAgaWYg
KGxpbWl0X3BmbiA8IHNpemUgfHwgbmV3X3BmbiA8IGlvdmFkLT5zdGFydF9wZm4pIHsKPj4gK8Kg
wqDCoCB9IHdoaWxlIChjdXJyICYmIG5ld19wZm4gPD0gY3Vycl9pb3ZhLT5wZm5faGkgJiYgbmV3
X3BmbiA+PQo+PiBsb3dfcGZuKTsKPj4gKwo+PiArwqDCoMKgIGlmIChoaWdoX3BmbiA8IHNpemUg
fHwgbmV3X3BmbiA8IGxvd19wZm4pIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChsb3dfcGZuID09
IGlvdmFkLT5zdGFydF9wZm4gJiYgbG93X3Bmbl9uZXcgPCBsaW1pdF9wZm4pIHsKPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaGlnaF9wZm4gPSBsaW1pdF9wZm47Cj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGxvd19wZm4gPSBsb3dfcGZuX25ldzsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgY3VyciA9ICZpb3ZhZC0+YW5jaG9yLm5vZGU7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGN1cnJfaW92YSA9IHJiX2VudHJ5KGN1cnIsIHN0cnVjdCBpb3ZhLCBub2RlKTsKPj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZ290byByZXRyeTsKPj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4gwqDC
oMKgwqDCoMKgwqDCoMKgIGlvdmFkLT5tYXgzMl9hbGxvY19zaXplID0gc2l6ZTsKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGdvdG8gaW92YTMyX2Z1bGw7Cj4+IMKgwqDCoMKgwqAgfQo+PgoKLS0gClFV
QUxDT01NIElORElBLCBvbiBiZWhhbGYgb2YgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIElu
Yy4gaXMgYQptZW1iZXIgb2YgQ29kZSBBdXJvcmEgRm9ydW0sIGhvc3RlZCBieSBUaGUgTGludXgg
Rm91bmRhdGlvbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
