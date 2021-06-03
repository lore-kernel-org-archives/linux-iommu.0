Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34465C47092
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 02:29:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C36BE613EB
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 02:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36BE613EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86B0440529;
	Thu,  3 Jun 2021 02:29:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RYGkb5bQNsWo; Thu,  3 Jun 2021 02:29:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 136C1404DE;
	Thu,  3 Jun 2021 02:29:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEC48C000E;
	Thu,  3 Jun 2021 02:29:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16546C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 02:29:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBDED404D7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 02:29:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id juOo7beSPU8B for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 02:29:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7BA7A400D8
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 02:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622687360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z8pfT0MZqL2Z8bkqcby4E+RJ01PN1727vqn0BLJ23M4=;
 b=YrsblBJxGFPGmWEp9uk++ymjnAe+NFQdCH6ZGidXLDczA9Ynferz1MIOXG0FXcoSsKyozG
 mFX008wBHU5+3cnMKrDBGTGsM1N69tz9JVTFAnb5+tb75VMt/4gcDkrQmnkYlIK8hc0hxF
 1JbHlRNrxueVa7Db4DjUlzug1zvWGg4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-3GUx_6TgMsKhg6rZ8QkKcw-1; Wed, 02 Jun 2021 22:29:18 -0400
X-MC-Unique: 3GUx_6TgMsKhg6rZ8QkKcw-1
Received: by mail-pf1-f199.google.com with SMTP id
 q3-20020aa784230000b02902ea311f25e2so1417324pfn.1
 for <iommu@lists.linux-foundation.org>; Wed, 02 Jun 2021 19:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Z8pfT0MZqL2Z8bkqcby4E+RJ01PN1727vqn0BLJ23M4=;
 b=ieA33kxShUgErLJ69kKPTA0md/VvDYFIS+wu8AhSzbcatn1xMdMFVuZ+k+absaZapb
 N6mwauHZgCRycKtSYhH3ZXft8/667Uf+nzcuFlARn/O60u6TIyPlZOsQPGSd21HCIKbk
 tn85s3coZQM2UzeCWagHNH9mqX+SqM2eUMdRyRXyCZCWn815dVjrg6Yid6xxKTYUcdkq
 zlYRYdHb74PYntBJpVPlZMfsslS2Q/LhmMDZen+t6Iuc7hSNzuQ8lXhzGWxYPpiJgf48
 sD4KNWpFwGda78MY95Nz8BNlT5ga0RI47J/DyVMzjc8mEEKhoGHdN70kQp+UBfxPsZdd
 GVMw==
X-Gm-Message-State: AOAM5312mS9+yuBk5pgm/nemUvOO92JgiN50xEvOxtL0P2G2di7dFwIk
 MmJXf09md7BdIhjr6kSMPBIsHIF95zZvN7BU4XsIMF2JFfa2mndjr8FP/g0ba9Cgw6pue5thqyg
 l7vheqUFH2Ls+ho9QbtV4jr3NLdCfTg==
X-Received: by 2002:a17:90a:af8b:: with SMTP id
 w11mr33994994pjq.228.1622687357782; 
 Wed, 02 Jun 2021 19:29:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcAOh1B5HwVx/1uLe5ueMMD2TZKV165kULJvA56z6ifNMCkU6WkR/FyKpm6p4cpf8KJgEpBw==
X-Received: by 2002:a17:90a:af8b:: with SMTP id
 w11mr33994974pjq.228.1622687357476; 
 Wed, 02 Jun 2021 19:29:17 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f2sm895145pgl.67.2021.06.02.19.29.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 19:29:17 -0700 (PDT)
Subject: Re: [PATCH v1 3/8] virtio: Harden split buffer detachment
To: Andi Kleen <ak@linux.intel.com>, mst@redhat.com
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-4-ak@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <284ca65d-d8b4-a671-4dba-df478a3610f1@redhat.com>
Date: Thu, 3 Jun 2021 10:29:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603004133.4079390-4-ak@linux.intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 jpoimboe@redhat.com, robin.murphy@arm.com, hch@lst.de
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

CuWcqCAyMDIxLzYvMyDkuIrljYg4OjQxLCBBbmRpIEtsZWVuIOWGmemBkzoKPiBIYXJkZW4gdGhl
IHNwbGl0IGJ1ZmZlciBkZXRhY2htZW50IHBhdGggYnkgYWRkaW5nIGJvdW5kYXJ5IGNoZWNraW5n
LiBOb3RlCj4gdGhhdCB3aGVuIHRoaXMgZmFpbHMgd2UgbWF5IGZhaWwgdG8gdW5tYXAgc29tZSBz
d2lvdGxiIG1hcHBpbmcsIHdoaWNoIGNvdWxkCj4gcmVzdWx0IGluIGEgbGVhayBhbmQgYSBET1Mu
IEJ1dCB0aGF0J3MgYWNjZXB0YWJsZSBiZWNhdXNlIGFuIG1hbGljaW91cyBob3N0Cj4gY2FuIERP
UyB1cyBhbnl3YXlzLgo+Cj4gU2lnbmVkLW9mZi1ieTogQW5kaSBLbGVlbiA8YWtAbGludXguaW50
ZWwuY29tPgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDI1ICsrKysr
KysrKysrKysrKysrKysrKy0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCsp
LCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19y
aW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggZDM3ZmY1YTBmZjU4
Li4xZTlhYTFlOTVlMWIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtNjUxLDEyICs2NTEs
MTkgQEAgc3RhdGljIGJvb2wgdmlydHF1ZXVlX2tpY2tfcHJlcGFyZV9zcGxpdChzdHJ1Y3Qgdmly
dHF1ZXVlICpfdnEpCj4gICAJcmV0dXJuIG5lZWRzX2tpY2s7Cj4gICB9Cj4gICAKPiAtc3RhdGlj
IHZvaWQgZGV0YWNoX2J1Zl9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwgdW5zaWdu
ZWQgaW50IGhlYWQsCj4gLQkJCSAgICAgdm9pZCAqKmN0eCkKPiArc3RhdGljIGludCBkZXRhY2hf
YnVmX3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLCB1bnNpZ25lZCBpbnQgaGVhZCwK
PiArCQkJICAgIHZvaWQgKipjdHgpCj4gICB7Cj4gICAJdW5zaWduZWQgaW50IGksIGo7Cj4gICAJ
X192aXJ0aW8xNiBuZXh0ZmxhZyA9IGNwdV90b192aXJ0aW8xNih2cS0+dnEudmRldiwgVlJJTkdf
REVTQ19GX05FWFQpOwo+ICAgCj4gKwkvKiBXZSdsbCBsZWFrIERNQSBtYXBwaW5ncyB3aGVuIHRo
aXMgaGFwcGVucywgYnV0IG5vdGhpbmcKPiArCSAqIGNhbiBiZSBkb25lIGFib3V0IHRoYXQuIElu
IHRoZSB3b3JzdCBjYXNlIHRoZSBob3N0Cj4gKwkgKiBjb3VsZCBET1MgdXMsIGJ1dCBpdCBjYW4g
b2YgY291cnNlIGRvIHRoYXQgYW55d2F5cy4KPiArCSAqLwo+ICsJaWYgKCFpbnNpZGVfc3BsaXRf
cmluZyh2cSwgaGVhZCkpCj4gKwkJcmV0dXJuIC1FSU87CgoKSSB0aGluayB0aGUgY2FsbGVyIGhh
dmUgYWxyZWFkeSBkaWQgdGhpcyBmb3IgdXMgd2l0aCBldmVuIG1vcmUgY2hlY2sgb24gCnRoZSB0
b2tlbiAodmlydHF1ZXVlX2dldF9idWZfY3R4X3NwbGl0KCkpOgoKIMKgwqDCoMKgwqDCoMKgIGlm
ICh1bmxpa2VseShpID49IHZxLT5zcGxpdC52cmluZy5udW0pKSB7CiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgQkFEX1JJTkcodnEsICJpZCAldSBvdXQgb2YgcmFuZ2VcbiIsIGkpOwog
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBOVUxMOwogwqDCoMKgwqDCoMKg
wqAgfQogwqDCoMKgwqDCoMKgwqAgaWYgKHVubGlrZWx5KCF2cS0+c3BsaXQuZGVzY19zdGF0ZVtp
XS5kYXRhKSkgewogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJBRF9SSU5HKHZxLCAi
aWQgJXUgaXMgbm90IGEgaGVhZCFcbiIsIGkpOwogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiBOVUxMOwogwqDCoMKgwqDCoMKgwqAgfQoKCj4gKwo+ICAgCS8qIENsZWFyIGRh
dGEgcHRyLiAqLwo+ICAgCXZxLT5zcGxpdC5kZXNjX3N0YXRlW2hlYWRdLmRhdGEgPSBOVUxMOwo+
ICAgCj4gQEAgLTY2Niw2ICs2NzMsOCBAQCBzdGF0aWMgdm9pZCBkZXRhY2hfYnVmX3NwbGl0KHN0
cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLCB1bnNpZ25lZCBpbnQgaGVhZCwKPiAgIAl3aGlsZSAo
dnEtPnNwbGl0LnZyaW5nLmRlc2NbaV0uZmxhZ3MgJiBuZXh0ZmxhZykgewo+ICAgCQl2cmluZ191
bm1hcF9vbmVfc3BsaXQodnEsICZ2cS0+c3BsaXQudnJpbmcuZGVzY1tpXSk7Cj4gICAJCWkgPSB2
aXJ0aW8xNl90b19jcHUodnEtPnZxLnZkZXYsIHZxLT5zcGxpdC52cmluZy5kZXNjW2ldLm5leHQp
Owo+ICsJCWlmICghaW5zaWRlX3NwbGl0X3JpbmcodnEsIGkpKQo+ICsJCQlyZXR1cm4gLUVJTzsK
CgpTaW1pbGFybHksIGlmIHdlIGRvbid0IGRlcGVuZCBvbiB0aGUgbWV0YWRhdGEgc3RvcmVkIGlu
IHRoZSBkZXNjcmlwdG9yLCAKd2UgZG9uJ3QgbmVlZCB0aGlzIGNoZWNrLgoKCj4gICAJCXZxLT52
cS5udW1fZnJlZSsrOwo+ICAgCX0KPiAgIAo+IEBAIC02ODQsNyArNjkzLDcgQEAgc3RhdGljIHZv
aWQgZGV0YWNoX2J1Zl9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwgdW5zaWduZWQg
aW50IGhlYWQsCj4gICAKPiAgIAkJLyogRnJlZSB0aGUgaW5kaXJlY3QgdGFibGUsIGlmIGFueSwg
bm93IHRoYXQgaXQncyB1bm1hcHBlZC4gKi8KPiAgIAkJaWYgKCFpbmRpcl9kZXNjKQo+IC0JCQly
ZXR1cm47Cj4gKwkJCXJldHVybiAwOwo+ICAgCj4gICAJCWxlbiA9IHZpcnRpbzMyX3RvX2NwdSh2
cS0+dnEudmRldiwKPiAgIAkJCQl2cS0+c3BsaXQudnJpbmcuZGVzY1toZWFkXS5sZW4pOwo+IEBA
IC03MDEsNiArNzEwLDcgQEAgc3RhdGljIHZvaWQgZGV0YWNoX2J1Zl9zcGxpdChzdHJ1Y3QgdnJp
bmdfdmlydHF1ZXVlICp2cSwgdW5zaWduZWQgaW50IGhlYWQsCj4gICAJfSBlbHNlIGlmIChjdHgp
IHsKPiAgIAkJKmN0eCA9IHZxLT5zcGxpdC5kZXNjX3N0YXRlW2hlYWRdLmluZGlyX2Rlc2M7Cj4g
ICAJfQo+ICsJcmV0dXJuIDA7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyBpbmxpbmUgYm9vbCBtb3Jl
X3VzZWRfc3BsaXQoY29uc3Qgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEpCj4gQEAgLTcxNyw2
ICs3MjcsNyBAQCBzdGF0aWMgdm9pZCAqdmlydHF1ZXVlX2dldF9idWZfY3R4X3NwbGl0KHN0cnVj
dCB2aXJ0cXVldWUgKl92cSwKPiAgIAl2b2lkICpyZXQ7Cj4gICAJdW5zaWduZWQgaW50IGk7Cj4g
ICAJdTE2IGxhc3RfdXNlZDsKPiArCWludCBlcnI7Cj4gICAKPiAgIAlTVEFSVF9VU0UodnEpOwo+
ICAgCj4gQEAgLTc1MSw3ICs3NjIsMTIgQEAgc3RhdGljIHZvaWQgKnZpcnRxdWV1ZV9nZXRfYnVm
X2N0eF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gICAKPiAgIAkvKiBkZXRhY2hfYnVm
X3NwbGl0IGNsZWFycyBkYXRhLCBzbyBncmFiIGl0IG5vdy4gKi8KPiAgIAlyZXQgPSB2cS0+c3Bs
aXQuZGVzY19zdGF0ZVtpXS5kYXRhOwo+IC0JZGV0YWNoX2J1Zl9zcGxpdCh2cSwgaSwgY3R4KTsK
PiArCWVyciA9IGRldGFjaF9idWZfc3BsaXQodnEsIGksIGN0eCk7Cj4gKwlpZiAoZXJyKSB7Cj4g
KwkJRU5EX1VTRSh2cSk7CgoKVGhpcyByZW1pbmRzIG1lIHRoYXQgd2UgZG9uJ3QgdXNlIEVORF9V
U0UoKSBhZnRlciBCQURfUklORygpIHdoaWNoIApzaG91bGQgYmUgZml4ZWQuCgpUaGFua3MKCgo+
ICsJCXJldHVybiBOVUxMOwo+ICsJfQo+ICsKPiAgIAl2cS0+bGFzdF91c2VkX2lkeCsrOwo+ICAg
CS8qIElmIHdlIGV4cGVjdCBhbiBpbnRlcnJ1cHQgZm9yIHRoZSBuZXh0IGVudHJ5LCB0ZWxsIGhv
c3QKPiAgIAkgKiBieSB3cml0aW5nIGV2ZW50IGluZGV4IGFuZCBmbHVzaCBvdXQgdGhlIHdyaXRl
IGJlZm9yZQo+IEBAIC04NjMsNiArODc5LDcgQEAgc3RhdGljIHZvaWQgKnZpcnRxdWV1ZV9kZXRh
Y2hfdW51c2VkX2J1Zl9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4gICAJCS8qIGRldGFj
aF9idWZfc3BsaXQgY2xlYXJzIGRhdGEsIHNvIGdyYWIgaXQgbm93LiAqLwo+ICAgCQlidWYgPSB2
cS0+c3BsaXQuZGVzY19zdGF0ZVtpXS5kYXRhOwo+ICAgCQlkZXRhY2hfYnVmX3NwbGl0KHZxLCBp
LCBOVUxMKTsKPiArCQkvKiBEb24ndCBuZWVkIHRvIGNoZWNrIGZvciBlcnJvciBiZWNhdXNlIG5v
dGhpbmcgaXMgcmV0dXJuZWQgKi8KPiAgIAkJdnEtPnNwbGl0LmF2YWlsX2lkeF9zaGFkb3ctLTsK
PiAgIAkJdnEtPnNwbGl0LnZyaW5nLmF2YWlsLT5pZHggPSBjcHVfdG9fdmlydGlvMTYoX3ZxLT52
ZGV2LAo+ICAgCQkJCXZxLT5zcGxpdC5hdmFpbF9pZHhfc2hhZG93KTsKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21t
dUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
