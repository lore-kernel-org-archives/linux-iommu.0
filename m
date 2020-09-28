Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B0BC2D0A8
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 12:42:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1FFD21D7F
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 12:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="lOwySJC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FFD21D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4538C20428;
	Mon, 28 Sep 2020 12:42:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zum2sARIeeJ5; Mon, 28 Sep 2020 12:42:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 99BD21FE65;
	Mon, 28 Sep 2020 12:42:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AE77C0889;
	Mon, 28 Sep 2020 12:42:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22986C0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 12:42:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1139685701
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 12:42:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 58H-NXIzKoGj for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 12:42:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from z5.mailgun.us (z5.mailgun.us [104.130.96.5])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0968F856E9
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 12:42:10 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1601296931; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=oWltz7hycQksUaxhpl7WV0Rt0J+p0DnC6Q3UxfGwchE=;
 b=lOwySJC/iBahF7YiKIFwBK64pGK/nfJHo8az166WUjNJE0BmziHjrs+SB+EC5WlWRLJDccac
 pgnxo7sC5VFBUPR2wpX+L/DeZF5tHJIY8xt9dKax3UfDDF6rpRfwv64yBlmG5nK7yiBXJ5VO
 K8Syab3VVdbrCtw43G8WgVsVytk=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f71da22809bd3301465e3d0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 28 Sep 2020 12:42:10
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 8516BC433CB; Mon, 28 Sep 2020 12:42:10 +0000 (UTC)
Received: from [192.168.43.216] (unknown [157.44.92.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: vjitta)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A8413C433CA;
 Mon, 28 Sep 2020 12:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8413C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH v2 2/2] iommu/iova: Free global iova rcache on iova alloc
 failure
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1597927761-24441-1-git-send-email-vjitta@codeaurora.org>
 <1597927761-24441-2-git-send-email-vjitta@codeaurora.org>
 <2f20160a-b9da-4fa3-3796-ed90c6175ebe@arm.com>
From: Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <9dac89a4-553a-efe2-08a1-6a3a5fbc97a8@codeaurora.org>
Date: Mon, 28 Sep 2020 18:11:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2f20160a-b9da-4fa3-3796-ed90c6175ebe@arm.com>
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

CgpPbiA5LzE4LzIwMjAgODoxMSBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOgo+IE9uIDIwMjAtMDgt
MjAgMTM6NDksIHZqaXR0YUBjb2RlYXVyb3JhLm9yZyB3cm90ZToKPj4gRnJvbTogVmlqYXlhbmFu
ZCBKaXR0YSA8dmppdHRhQGNvZGVhdXJvcmEub3JnPgo+Pgo+PiBXaGVuIGV2ZXIgYW4gaW92YSBh
bGxvYyByZXF1ZXN0IGZhaWxzIHdlIGZyZWUgdGhlIGlvdmEKPj4gcmFuZ2VzIHByZXNlbnQgaW4g
dGhlIHBlcmNwdSBpb3ZhIHJjYWNoZXMgYW5kIHRoZW4gcmV0cnkKPj4gYnV0IHRoZSBnbG9iYWwg
aW92YSByY2FjaGUgaXMgbm90IGZyZWVkIGFzIGEgcmVzdWx0IHdlIGNvdWxkCj4+IHN0aWxsIHNl
ZSBpb3ZhIGFsbG9jIGZhaWx1cmUgZXZlbiBhZnRlciByZXRyeSBhcyBnbG9iYWwKPj4gcmNhY2hl
IGlzIGhvbGRpbmcgdGhlIGlvdmEncyB3aGljaCBjYW4gY2F1c2UgZnJhZ21lbnRhdGlvbi4KPj4g
U28sIGZyZWUgdGhlIGdsb2JhbCBpb3ZhIHJjYWNoZSBhcyB3ZWxsIGFuZCB0aGVuIGdvIGZvciB0
aGUKPj4gcmV0cnkuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFZpamF5YW5hbmQgSml0dGEgPHZqaXR0
YUBjb2RlYXVyb3JhLm9yZz4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvaW9tbXUvaW92YS5jIHwgMjMg
KysrKysrKysrKysrKysrKysrKysrKysKPj4gwqAgaW5jbHVkZS9saW51eC9pb3ZhLmggfMKgIDYg
KysrKysrCj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb3ZhLmMgYi9kcml2ZXJzL2lvbW11L2lvdmEuYwo+PiBp
bmRleCA0ZTc3MTE2Li41ODM2Yzg3IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2lvdmEu
Ywo+PiArKysgYi9kcml2ZXJzL2lvbW11L2lvdmEuYwo+PiBAQCAtNDQyLDYgKzQ0Miw3IEBAIHN0
cnVjdCBpb3ZhICpmaW5kX2lvdmEoc3RydWN0IGlvdmFfZG9tYWluICppb3ZhZCwKPj4gdW5zaWdu
ZWQgbG9uZyBwZm4pCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBmbHVzaF9yY2FjaGUgPSBmYWxzZTsK
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGZvcl9lYWNoX29ubGluZV9jcHUoY3B1KQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBmcmVlX2NwdV9jYWNoZWRfaW92YXMoY3B1LCBpb3ZhZCk7Cj4+
ICvCoMKgwqDCoMKgwqDCoCBmcmVlX2dsb2JhbF9jYWNoZWRfaW92YXMoaW92YWQpOwo+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgZ290byByZXRyeTsKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgIEBAIC0xMDU1
LDUgKzEwNTYsMjcgQEAgdm9pZCBmcmVlX2NwdV9jYWNoZWRfaW92YXModW5zaWduZWQgaW50IGNw
dSwKPj4gc3RydWN0IGlvdmFfZG9tYWluICppb3ZhZCkKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgIH0K
Pj4gwqAgKy8qCj4+ICsgKiBmcmVlIGFsbCB0aGUgSU9WQSByYW5nZXMgb2YgZ2xvYmFsIGNhY2hl
Cj4+ICsgKi8KPj4gK3ZvaWQgZnJlZV9nbG9iYWxfY2FjaGVkX2lvdmFzKHN0cnVjdCBpb3ZhX2Rv
bWFpbiAqaW92YWQpCj4gCj4gQXMgSm9obiBwb2ludGVkIG91dCBsYXN0IHRpbWUsIHRoaXMgc2hv
dWxkIGJlIHN0YXRpYyBhbmQgdGhlIGhlYWRlcgo+IGNoYW5nZXMgZHJvcHBlZC4KPiAKPiAoVEJI
IHdlIHNob3VsZCBwcm9iYWJseSByZWdpc3RlciBvdXIgb3duIGhvdHBsdWcgbm90aWZpZXIgaW5z
dGFuY2UgZm9yIGEKPiBmbHVzaCBxdWV1ZSwgc28gdGhhdCBleHRlcm5hbCBjb2RlIGhhcyBubyBu
ZWVkIHRvIHBva2UgYXQgdGhlIHBlci1DUFUKPiBjYWNoZXMgZWl0aGVyKQo+IAo+IFJvYmluLgo+
IAoKUmlnaHQsIEkgaGF2ZSBtYWRlIGl0IHN0YXRpYyBhbmQgZHJvcHBlZCBoZWFkZXIgY2hhbmdl
cyBpbiB2My4KY2FuIHlvdSBwbGVhc2UgcmV2aWV3IHRoYXQuCgpUaGFua3MsClZpamF5Cj4+ICt7
Cj4+ICvCoMKgwqAgc3RydWN0IGlvdmFfcmNhY2hlICpyY2FjaGU7Cj4+ICvCoMKgwqAgdW5zaWdu
ZWQgbG9uZyBmbGFnczsKPj4gK8KgwqDCoCBpbnQgaSwgajsKPj4gKwo+PiArwqDCoMKgIGZvciAo
aSA9IDA7IGkgPCBJT1ZBX1JBTkdFX0NBQ0hFX01BWF9TSVpFOyArK2kpIHsKPj4gK8KgwqDCoMKg
wqDCoMKgIHJjYWNoZSA9ICZpb3ZhZC0+cmNhY2hlc1tpXTsKPj4gK8KgwqDCoMKgwqDCoMKgIHNw
aW5fbG9ja19pcnFzYXZlKCZyY2FjaGUtPmxvY2ssIGZsYWdzKTsKPj4gK8KgwqDCoMKgwqDCoMKg
IGZvciAoaiA9IDA7IGogPCByY2FjaGUtPmRlcG90X3NpemU7ICsraikgewo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpb3ZhX21hZ2F6aW5lX2ZyZWVfcGZucyhyY2FjaGUtPmRlcG90W2pdLCBp
b3ZhZCk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlvdmFfbWFnYXppbmVfZnJlZShyY2Fj
aGUtPmRlcG90W2pdKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmNhY2hlLT5kZXBvdFtq
XSA9IE5VTEw7Cj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+ICvCoMKgwqDCoMKgwqDCoCByY2FjaGUt
PmRlcG90X3NpemUgPSAwOwo+PiArwqDCoMKgwqDCoMKgwqAgc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmcmNhY2hlLT5sb2NrLCBmbGFncyk7Cj4+ICvCoMKgwqAgfQo+PiArfQo+PiArCj4+IMKgIE1P
RFVMRV9BVVRIT1IoIkFuaWwgUyBLZXNoYXZhbXVydGh5IDxhbmlsLnMua2VzaGF2YW11cnRoeUBp
bnRlbC5jb20+Iik7Cj4+IMKgIE1PRFVMRV9MSUNFTlNFKCJHUEwiKTsKPj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvaW92YS5oIGIvaW5jbHVkZS9saW51eC9pb3ZhLmgKPj4gaW5kZXggYTA2
MzdhYi4uYTkwNTcyNiAxMDA2NDQKPj4gLS0tIGEvaW5jbHVkZS9saW51eC9pb3ZhLmgKPj4gKysr
IGIvaW5jbHVkZS9saW51eC9pb3ZhLmgKPj4gQEAgLTE2Myw2ICsxNjMsNyBAQCBpbnQgaW5pdF9p
b3ZhX2ZsdXNoX3F1ZXVlKHN0cnVjdCBpb3ZhX2RvbWFpbiAqaW92YWQsCj4+IMKgIHN0cnVjdCBp
b3ZhICpzcGxpdF9hbmRfcmVtb3ZlX2lvdmEoc3RydWN0IGlvdmFfZG9tYWluICppb3ZhZCwKPj4g
wqDCoMKgwqDCoCBzdHJ1Y3QgaW92YSAqaW92YSwgdW5zaWduZWQgbG9uZyBwZm5fbG8sIHVuc2ln
bmVkIGxvbmcgcGZuX2hpKTsKPj4gwqAgdm9pZCBmcmVlX2NwdV9jYWNoZWRfaW92YXModW5zaWdu
ZWQgaW50IGNwdSwgc3RydWN0IGlvdmFfZG9tYWluCj4+ICppb3ZhZCk7Cj4+ICt2b2lkIGZyZWVf
Z2xvYmFsX2NhY2hlZF9pb3ZhcyhzdHJ1Y3QgaW92YV9kb21haW4gKmlvdmFkKTsKPj4gwqAgI2Vs
c2UKPj4gwqAgc3RhdGljIGlubGluZSBpbnQgaW92YV9jYWNoZV9nZXQodm9pZCkKPj4gwqAgewo+
PiBAQCAtMjcwLDYgKzI3MSwxMSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZnJlZV9jcHVfY2FjaGVk
X2lvdmFzKHVuc2lnbmVkCj4+IGludCBjcHUsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBpb3ZhX2RvbWFpbiAqaW92YWQpCj4+IMKgIHsKPj4g
wqAgfQo+PiArCj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgZnJlZV9nbG9iYWxfY2FjaGVkX2lvdmFz
KHN0cnVjdCBpb3ZhX2RvbWFpbiAqaW92YWQpCj4+ICt7Cj4+ICt9Cj4+ICsKPj4gwqAgI2VuZGlm
Cj4+IMKgIMKgICNlbmRpZgo+PgoKLS0gClFVQUxDT01NIElORElBLCBvbiBiZWhhbGYgb2YgUXVh
bGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gaXMgYQptZW1iZXIgb2YgQ29kZSBBdXJvcmEg
Rm9ydW0sIGhvc3RlZCBieSBUaGUgTGludXggRm91bmRhdGlvbgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vaW9tbXU=
