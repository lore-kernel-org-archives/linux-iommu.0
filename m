Return-Path: <SRS0=CQae=6W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75D2C38A2A
	for <iommu@archiver.kernel.org>; Fri,  8 May 2020 18:56:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B9D82083B
	for <iommu@archiver.kernel.org>; Fri,  8 May 2020 18:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Ekg/DHTS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9D82083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 57AB989883;
	Fri,  8 May 2020 18:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8RynXQhqyREy; Fri,  8 May 2020 18:56:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 995148987B;
	Fri,  8 May 2020 18:56:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66A06C0889;
	Fri,  8 May 2020 18:56:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 288EEC07FF
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 18:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 139638987B
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 18:56:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3Vm9ds84IU2m for <iommu@lists.linux-foundation.org>;
 Fri,  8 May 2020 18:56:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail26.static.mailgun.info (mail26.static.mailgun.info
 [104.130.122.26])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B17E28987A
 for <iommu@lists.linux-foundation.org>; Fri,  8 May 2020 18:56:06 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1588964170; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=EjH2qkZmqYJcFfcuR5tQQWIMkDzmufLYMlW8fjjJAbk=;
 b=Ekg/DHTSfsXJ93ZngIJYGJohdK8xLdr8YLYZsZMUV6PGmYHGbuowrOepcEO5Zzg4RvQ7cUao
 okQ8B04RlncH23RTBPiDhmxu0NZeMjktKHOV6SPh41jBJTAYfB2Rf18hcEnvhSXM0WfJ8YhT
 lYf9zIaum1Q4II1HeMKOEo1BSwM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb5ab3b.7fda29393998-smtp-out-n03;
 Fri, 08 May 2020 18:55:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 39790C43637; Fri,  8 May 2020 18:55:55 +0000 (UTC)
Received: from [192.168.0.104] (unknown [103.248.210.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: vjitta)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id B97E0C433D2;
 Fri,  8 May 2020 18:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B97E0C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH] iommu/iova: Retry from last rb tree node if iova search
 fails
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <1588795317-20879-1-git-send-email-vjitta@codeaurora.org>
 <d9bfde9f-8f16-bf1b-311b-ea6c2b8ab93d@arm.com>
From: Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <b80fdf37-e635-2d65-c523-8e1d0bd8085b@codeaurora.org>
Date: Sat, 9 May 2020 00:25:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d9bfde9f-8f16-bf1b-311b-ea6c2b8ab93d@arm.com>
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

CgpPbiA1LzcvMjAyMCA2OjU0IFBNLCBSb2JpbiBNdXJwaHkgd3JvdGU6Cj4gT24gMjAyMC0wNS0w
NiA5OjAxIHBtLCB2aml0dGFAY29kZWF1cm9yYS5vcmcgd3JvdGU6Cj4+IEZyb206IFZpamF5YW5h
bmQgSml0dGEgPHZqaXR0YUBjb2RlYXVyb3JhLm9yZz4KPj4KPj4gV2hlbiBldmVyIGEgbmV3IGlv
dmEgYWxsb2MgcmVxdWVzdCBjb21lcyBpb3ZhIGlzIGFsd2F5cyBzZWFyY2hlZAo+PiBmcm9tIHRo
ZSBjYWNoZWQgbm9kZSBhbmQgdGhlIG5vZGVzIHdoaWNoIGFyZSBwcmV2aW91cyB0byBjYWNoZWQK
Pj4gbm9kZS4gU28sIGV2ZW4gaWYgdGhlcmUgaXMgZnJlZSBpb3ZhIHNwYWNlIGF2YWlsYWJsZSBp
biB0aGUgbm9kZXMKPj4gd2hpY2ggYXJlIG5leHQgdG8gdGhlIGNhY2hlZCBub2RlIGlvdmEgYWxs
b2NhdGlvbiBjYW4gc3RpbGwgZmFpbAo+PiBiZWNhdXNlIG9mIHRoaXMgYXBwcm9hY2guCj4+Cj4+
IENvbnNpZGVyIHRoZSBmb2xsb3dpbmcgc2VxdWVuY2Ugb2YgaW92YSBhbGxvYyBhbmQgZnJlZXMg
b24KPj4gMUdCIG9mIGlvdmEgc3BhY2UKPj4KPj4gMSkgYWxsb2MgLSA1MDBNQgo+PiAyKSBhbGxv
YyAtIDEyTUIKPj4gMykgYWxsb2MgLSA0OTlNQgo+PiA0KSBmcmVlIC3CoCAxMk1CIHdoaWNoIHdh
cyBhbGxvY2F0ZWQgaW4gc3RlcCAyCj4+IDUpIGFsbG9jIC0gMTNNQgo+Pgo+PiBBZnRlciB0aGUg
YWJvdmUgc2VxdWVuY2Ugd2Ugd2lsbCBoYXZlIDEyTUIgb2YgZnJlZSBpb3ZhIHNwYWNlIGFuZAo+
PiBjYWNoZWQgbm9kZSB3aWxsIGJlIHBvaW50aW5nIHRvIHRoZSBpb3ZhIHBmbiBvZiBsYXN0IGFs
bG9jIG9mIDEzTUIKPj4gd2hpY2ggd2lsbCBiZSB0aGUgbG93ZXN0IGlvdmEgcGZuIG9mIHRoYXQg
aW92YSBzcGFjZS4gTm93IGlmIHdlIGdldCBhbgo+PiBhbGxvYyByZXF1ZXN0IG9mIDJNQiB3ZSBq
dXN0IHNlYXJjaCBmcm9tIGNhY2hlZCBub2RlIGFuZCB0aGVuIGxvb2sKPj4gZm9yIGxvd2VyIGlv
dmEgcGZuJ3MgZm9yIGZyZWUgaW92YSBhbmQgYXMgdGhleSBhcmVuJ3QgYW55LCBpb3ZhIGFsbG9j
Cj4+IGZhaWxzIHRob3VnaCB0aGVyZSBpcyAxMk1CIG9mIGZyZWUgaW92YSBzcGFjZS4KPiAKPiBZ
dXAsIHRoaXMgY291bGQgZGVmaW5pdGVseSBkbyB3aXRoIGltcHJvdmluZy4gVW5mb3J0dW5hdGVs
eSBJIHRoaW5rIHRoaXMKPiBwYXJ0aWN1bGFyIGltcGxlbWVudGF0aW9uIGlzIHNsaWdodGx5IGZs
YXdlZC4uLgo+IAo+PiBUbyBhdm9pZCBzdWNoIGlvdmEgc2VhcmNoIGZhaWx1cmVzIGRvIGEgcmV0
cnkgZnJvbSB0aGUgbGFzdCByYiB0cmVlIG5vZGUKPj4gd2hlbiBpb3ZhIHNlYXJjaCBmYWlscywg
dGhpcyB3aWxsIHNlYXJjaCB0aGUgZW50aXJlIHRyZWUgYW5kIGdldCBhbiBpb3ZhCj4+IGlmIGl0
cyBhdmFpbGFibGUKPj4KPj4gU2lnbmVkLW9mZi1ieTogVmlqYXlhbmFuZCBKaXR0YSA8dmppdHRh
QGNvZGVhdXJvcmEub3JnPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9pb21tdS9pb3ZhLmMgfCAxMSAr
KysrKysrKysrKwo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQo+Pgo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pb3ZhLmMgYi9kcml2ZXJzL2lvbW11L2lvdmEuYwo+
PiBpbmRleCAwZTZhOTUzLi4yOTg1MjIyIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2lv
dmEuYwo+PiArKysgYi9kcml2ZXJzL2lvbW11L2lvdmEuYwo+PiBAQCAtMTg2LDYgKzE4Niw3IEBA
IHN0YXRpYyBpbnQgX19hbGxvY19hbmRfaW5zZXJ0X2lvdmFfcmFuZ2Uoc3RydWN0Cj4+IGlvdmFf
ZG9tYWluICppb3ZhZCwKPj4gwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGZsYWdzOwo+PiDCoMKg
wqDCoMKgIHVuc2lnbmVkIGxvbmcgbmV3X3BmbjsKPj4gwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25n
IGFsaWduX21hc2sgPSB+MFVMOwo+PiArwqDCoMKgIGJvb2wgcmV0cnkgPSBmYWxzZTsKPj4gwqAg
wqDCoMKgwqDCoCBpZiAoc2l6ZV9hbGlnbmVkKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYWxpZ25f
bWFzayA8PD0gZmxzX2xvbmcoc2l6ZSAtIDEpOwo+PiBAQCAtMTk4LDYgKzE5OSw4IEBAIHN0YXRp
YyBpbnQgX19hbGxvY19hbmRfaW5zZXJ0X2lvdmFfcmFuZ2Uoc3RydWN0Cj4+IGlvdmFfZG9tYWlu
ICppb3ZhZCwKPj4gwqAgwqDCoMKgwqDCoCBjdXJyID0gX19nZXRfY2FjaGVkX3Jibm9kZShpb3Zh
ZCwgbGltaXRfcGZuKTsKPj4gwqDCoMKgwqDCoCBjdXJyX2lvdmEgPSByYl9lbnRyeShjdXJyLCBz
dHJ1Y3QgaW92YSwgbm9kZSk7Cj4+ICsKPj4gK3JldHJ5X3NlYXJjaDoKPj4gwqDCoMKgwqDCoCBk
byB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBsaW1pdF9wZm4gPSBtaW4obGltaXRfcGZuLCBjdXJy
X2lvdmEtPnBmbl9sbyk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBuZXdfcGZuID0gKGxpbWl0X3Bm
biAtIHNpemUpICYgYWxpZ25fbWFzazsKPj4gQEAgLTIwNyw2ICsyMTAsMTQgQEAgc3RhdGljIGlu
dCBfX2FsbG9jX2FuZF9pbnNlcnRfaW92YV9yYW5nZShzdHJ1Y3QKPj4gaW92YV9kb21haW4gKmlv
dmFkLAo+PiDCoMKgwqDCoMKgIH0gd2hpbGUgKGN1cnIgJiYgbmV3X3BmbiA8PSBjdXJyX2lvdmEt
PnBmbl9oaSk7Cj4+IMKgIMKgwqDCoMKgwqAgaWYgKGxpbWl0X3BmbiA8IHNpemUgfHwgbmV3X3Bm
biA8IGlvdmFkLT5zdGFydF9wZm4pIHsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmICghcmV0cnkpIHsK
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY3VyciA9IHJiX2xhc3QoJmlvdmFkLT5yYnJvb3Qp
Owo+IAo+IFdoeSB3YWxrIHdoZW4gdGhlcmUncyBhbiBhbmNob3Igbm9kZSB0aGVyZSBhbHJlYWR5
PyBIb3dldmVyLi4uCj4gCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN1cnJfaW92YSA9IHJi
X2VudHJ5KGN1cnIsIHN0cnVjdCBpb3ZhLCBub2RlKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgbGltaXRfcGZuID0gY3Vycl9pb3ZhLT5wZm5fbG87Cj4gCj4gLi4udGhpcyBkb2Vzbid0IGxv
b2sgcmlnaHQsIGFzIGJ5IG5vdyB3ZSd2ZSBsb3N0IHRoZSBvcmlnaW5hbCBsaW1pdF9wZm4KPiBz
dXBwbGllZCBieSB0aGUgY2FsbGVyLCBzbyBhcmUgaGlnaGx5IGxpa2VseSB0byBhbGxvY2F0ZSBi
ZXlvbmQgdGhlCj4gcmFuZ2Ugb3VyIGNhbGxlciBhc2tlZCBmb3IuIEluIGZhY3QgQUZBSUNTIHdl
J2Qgc3RhcnQgYWxsb2NhdGluZyBmcm9tCj4gZGlyZWN0bHkgZGlyZWN0bHkgYmVsb3cgdGhlIGFu
Y2hvciBub2RlLCBiZXlvbmQgdGhlIGVuZCBvZiB0aGUgZW50aXJlCj4gYWRkcmVzcyBzcGFjZS4K
PiAKPiBUaGUgbG9naWMgSSB3YXMgaW1hZ2luaW5nIHdlIHdhbnQgaGVyZSB3YXMgc29tZXRoaW5n
IGxpa2UgdGhlIHJhcGlkbHkKPiBoYWNrZWQgdXAgKGFuZCB1bnRlc3RlZCkgZGlmZiBiZWxvdy4K
PiAKPiBUaGFua3MsCj4gUm9iaW4uCj4gCgpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMgLEkgaGF2
ZSBnb25lIHRocm91Z2ggYmVsb3cgbG9naWMgYW5kIEkgc2VlIHNvbWUKaXNzdWUgd2l0aCByZXRy
eSBjaGVjayBhcyB0aGVyZSBjb3VsZCBiZSBjYXNlIHdoZXJlIGFsbG9jX2xvIGlzIHNldCB0bwpz
b21lIHBmbiBvdGhlciB0aGFuIHN0YXJ0X3BmbiBpbiB0aGF0IGNhc2Ugd2UgZG9uJ3QgcmV0cnkg
YW5kIHRoZXJlIGNhbgpzdGlsbCBiZSBpb3ZhIGF2YWlsYWJsZS4gSSB1bmRlcnN0YW5kIGl0cyBh
IGhhY2tlZCB1cCB2ZXJzaW9uLCBJIGNhbgp3b3JrIG9uIHRoaXMuCgpCdXQgaG93IGFib3V0IHdl
IGp1c3Qgc3RvcmUgbGltaXRfcGZuIGFuZCBnZXQgdGhlIG5vZGUgdXNpbmcgdGhhdCBhbmQKcmV0
cnkgZm9yIG9uY2UgZnJvbSB0aGF0IG5vZGUsIGl0IHdvdWxkIGJlIHNpbWlsYXIgdG8gbXkgcGF0
Y2gganVzdApjb3JyZWN0aW5nIHRoZSBjdXJyIG5vZGUgYW5kIGxpbWl0X3BmbiB1cGRhdGUgaW4g
cmV0cnkgY2hlY2suIGRvIHlvdSBzZWUKYW55IGlzc3VlIHdpdGggdGhpcyBhcHByb2FjaCA/CgoK
VGhhbmtzLApWaWpheS4KPiAtLS0tLT44LS0tLS0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21t
dS9pb3ZhLmMgYi9kcml2ZXJzL2lvbW11L2lvdmEuYwo+IGluZGV4IDBlNmE5NTM2ZWNhNi4uMzU3
NGMxOTI3MmQ2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW92YS5jCj4gKysrIGIvZHJp
dmVycy9pb21tdS9pb3ZhLmMKPiBAQCAtMTg2LDYgKzE4Niw3IEBAIHN0YXRpYyBpbnQgX19hbGxv
Y19hbmRfaW5zZXJ0X2lvdmFfcmFuZ2Uoc3RydWN0Cj4gaW92YV9kb21haW4gKmlvdmFkLAo+IMKg
wqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4gwqDCoMKgwqDCoMKgwqAgdW5zaWdu
ZWQgbG9uZyBuZXdfcGZuOwo+IMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgYWxpZ25fbWFz
ayA9IH4wVUw7Cj4gK8KgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIGFsbG9jX2hpLCBhbGxvY19s
bzsKPiAKPiDCoMKgwqDCoMKgwqDCoCBpZiAoc2l6ZV9hbGlnbmVkKQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBhbGlnbl9tYXNrIDw8PSBmbHNfbG9uZyhzaXplIC0gMSk7Cj4gQEAg
LTE5NiwxNyArMTk3LDI3IEBAIHN0YXRpYyBpbnQgX19hbGxvY19hbmRfaW5zZXJ0X2lvdmFfcmFu
Z2Uoc3RydWN0Cj4gaW92YV9kb21haW4gKmlvdmFkLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2l6ZSA+PSBpb3ZhZC0+bWF4MzJfYWxsb2Nfc2l6ZSkK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBpb3ZhMzJfZnVsbDsKPiAKPiAr
wqDCoMKgwqDCoMKgIGFsbG9jX2hpID0gSU9WQV9BTkNIT1I7Cj4gK8KgwqDCoMKgwqDCoCBhbGxv
Y19sbyA9IGlvdmFkLT5zdGFydF9wZm47Cj4gK3JldHJ5Ogo+IMKgwqDCoMKgwqDCoMKgIGN1cnIg
PSBfX2dldF9jYWNoZWRfcmJub2RlKGlvdmFkLCBsaW1pdF9wZm4pOwo+IMKgwqDCoMKgwqDCoMKg
IGN1cnJfaW92YSA9IHJiX2VudHJ5KGN1cnIsIHN0cnVjdCBpb3ZhLCBub2RlKTsKPiArwqDCoMKg
wqDCoMKgIGlmIChhbGxvY19oaSA8IGN1cnJfaW92YS0+cGZuX2hpKSB7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYWxsb2NfbG8gPSBjdXJyX2lvdmEtPnBmbl9oaTsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbGxvY19oaSA9IGxpbWl0X3BmbjsKPiArwqDCoMKgwqDC
oMKgIH0KPiArCj4gwqDCoMKgwqDCoMKgwqAgZG8gewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGxpbWl0X3BmbiA9IG1pbihsaW1pdF9wZm4sIGN1cnJfaW92YS0+cGZuX2xvKTsKPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBuZXdfcGZuID0gKGxpbWl0X3BmbiAtIHNpemUp
ICYgYWxpZ25fbWFzazsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbGxvY19oaSA9
IG1pbihhbGxvY19oaSwgY3Vycl9pb3ZhLT5wZm5fbG8pOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIG5ld19wZm4gPSAoYWxsb2NfaGkgLSBzaXplKSAmIGFsaWduX21hc2s7Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByZXYgPSBjdXJyOwo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBjdXJyID0gcmJfcHJldihjdXJyKTsKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgY3Vycl9pb3ZhID0gcmJfZW50cnkoY3Vyciwgc3RydWN0IGlvdmEsIG5v
ZGUpOwo+IMKgwqDCoMKgwqDCoMKgIH0gd2hpbGUgKGN1cnIgJiYgbmV3X3BmbiA8PSBjdXJyX2lv
dmEtPnBmbl9oaSk7Cj4gCj4gLcKgwqDCoMKgwqDCoCBpZiAobGltaXRfcGZuIDwgc2l6ZSB8fCBu
ZXdfcGZuIDwgaW92YWQtPnN0YXJ0X3Bmbikgewo+ICvCoMKgwqDCoMKgwqAgaWYgKGxpbWl0X3Bm
biA8IHNpemUgfHwgbmV3X3BmbiA8IGFsbG9jX2xvKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgaWYgKGFsbG9jX2xvID09IGlvdmFkLT5zdGFydF9wZm4pCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gcmV0cnk7Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlvdmFkLT5tYXgzMl9hbGxvY19zaXplID0gc2l6ZTsKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBpb3ZhMzJfZnVsbDsKPiDCoMKgwqDC
oMKgwqDCoCB9Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
