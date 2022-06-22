Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E377BC433EF
	for <iommu@archiver.kernel.org>; Wed, 22 Jun 2022 08:14:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8585A845F2;
	Wed, 22 Jun 2022 08:14:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8585A845F2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kwtFYGvf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rZrshlG9W9Dr; Wed, 22 Jun 2022 08:14:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 39D69845F0;
	Wed, 22 Jun 2022 08:14:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 39D69845F0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAC62C0032;
	Wed, 22 Jun 2022 08:14:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66D4FC002D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 08:14:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3BA3160BBA
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 08:14:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3BA3160BBA
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=kwtFYGvf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iPOXOcTAXghm for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jun 2022 08:14:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B9AA60A79
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B9AA60A79
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 08:14:52 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 g16-20020a17090a7d1000b001ea9f820449so16029264pjl.5
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jun 2022 01:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=kZTnS3VTllrLoaJqF/w8mR2VHKq3Lk7ph/8GKtgAs1s=;
 b=kwtFYGvf5kooG2LYNIEXgMNdUgRE2PTCmzJmp4fCELFGTNJ3ZyNNa8TjWnqpWfaXVD
 7G9kCTpUy/GYrDCymhpu1QZDUkcd7WmQbLPGaXPr4inPEshWm0TwY/F9Plr8F1Wi+jt2
 eRTtLt6grfJNlBaWbpMas44jwiDdBxXFI+G28HDXly5Tr8il7cx2B4Qe6rwShYKN/TSr
 hMT2nfAAICylX/8y3nSv7y9FINJEM78JgXndoTziueNznyT6SCLfbsqPqGTYOXiEZ1xT
 oOrMwZQpq2c14O60h2LwA7+WnU1zEYQtRHzCeBymb+wsiW0fMOCnrMnslpt4rSjVMF8d
 TDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=kZTnS3VTllrLoaJqF/w8mR2VHKq3Lk7ph/8GKtgAs1s=;
 b=uvr9GXo72YVXLTyMy/mVy9/Mzvo5CCPFm9xUd859zZDeuYoxAISjdVzacqXQzqnMOU
 J+EMataiQjmE8Ebd731Kv77SI2xW5EIt19eAA+ay4mZnGHCN6H9AHa27S8dbbqfIVEft
 KrLomwrGVEB6ChU6c0uXm4qfg87f/siQf44jXb6ZMnPSIrTbtWkUrEKRPwSo/5twsIOe
 3NPwrugjRR68RYPG9xnqxudu6QRPEg3xwnkqFwoUmCleSdMp6KBWFFGWCdGrG8Tx+T3I
 cJW16dEiWNurXOd9IK+zLscDDNvnLgab0qsAIFQXmOf/OtL7pvjT/3EZAVSZlF1EQio5
 Ttgw==
X-Gm-Message-State: AJIora/fEmHHUCkB1ggBqJxpwq7a+YO7FtLEQQSSTQ262Ohumwvp3vsX
 ypcOE8RVVX5Rp4XkYTWcQvMfxQ==
X-Google-Smtp-Source: AGRyM1vbNjUQdcM5L8IS2ZvOJX1TwTUio7KEYjbj54a3TQmeH7w7l0VX34LQDWIEY7SIyt+4Vt0fcw==
X-Received: by 2002:a17:903:11c6:b0:167:90e5:59c2 with SMTP id
 q6-20020a17090311c600b0016790e559c2mr32466748plh.50.1655885691654; 
 Wed, 22 Jun 2022 01:14:51 -0700 (PDT)
Received: from [10.166.0.6] ([199.101.192.137])
 by smtp.gmail.com with ESMTPSA id
 cp1-20020a170902e78100b00168f329b282sm12053860plb.155.2022.06.22.01.14.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jun 2022 01:14:51 -0700 (PDT)
Subject: Re: [PATCH] uacce: fix concurrency of fops_open and uacce_remove
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220610123423.27496-1-zhangfei.gao@linaro.org>
 <Yqn3spLZHpAkQ9Us@myrica> <fdc8d8b0-4e04-78f5-1e8a-4cf44c89a37f@linaro.org>
 <YqrmdKNrYTCiS/MC@myrica> <d90e8ea5-2f18-2eda-b4b2-711083aa7ecd@linaro.org>
 <YrB1D9rv9G4h/BYU@myrica> <YrB30M9yAbUbPFrG@kroah.com>
 <b5011dd2-e8ec-a307-1b43-5aff6cbb6891@linaro.org>
 <YrF2yypHZfiNVRBh@kroah.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <6fb8bed5-8d40-fd63-4537-44e9eb6aa053@linaro.org>
Date: Wed, 22 Jun 2022 16:14:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YrF2yypHZfiNVRBh@kroah.com>
Content-Language: en-US
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yang Shen <shenyang39@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-crypto@vger.kernel.org,
 linux-accelerators@lists.ozlabs.org
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

SGksIEdyZWcKCk9uIDIwMjIvNi8yMSDkuIvljYgzOjQ0LCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6Cj4gT24gVHVlLCBKdW4gMjEsIDIwMjIgYXQgMDM6Mzc6MzFQTSArMDgwMCwgWmhhbmdmZWkg
R2FvIHdyb3RlOgo+Pgo+PiBPbiAyMDIyLzYvMjAg5LiL5Y2IOTozNiwgR3JlZyBLcm9haC1IYXJ0
bWFuIHdyb3RlOgo+Pj4gT24gTW9uLCBKdW4gMjAsIDIwMjIgYXQgMDI6MjQ6MzFQTSArMDEwMCwg
SmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOgo+Pj4+IE9uIEZyaSwgSnVuIDE3LCAyMDIyIGF0
IDAyOjA1OjIxUE0gKzA4MDAsIFpoYW5nZmVpIEdhbyB3cm90ZToKPj4+Pj4+IFRoZSByZWZjb3Vu
dCBvbmx5IGVuc3VyZXMgdGhhdCB0aGUgdWFjY2VfZGV2aWNlIG9iamVjdCBpcyBub3QgZnJlZWQg
YXMKPj4+Pj4+IGxvbmcgYXMgdGhlcmUgYXJlIG9wZW4gZmRzLiBCdXQgdWFjY2VfcmVtb3ZlKCkg
Y2FuIHJ1biB3aGlsZSB0aGVyZSBhcmUKPj4+Pj4+IG9wZW4gZmRzLCBvciBmZHMgaW4gdGhlIHBy
b2Nlc3Mgb2YgYmVpbmcgb3BlbmVkLiBBbmQgYXRmZXIgdWFjY2VfcmVtb3ZlKCkKPj4+Pj4+IHJ1
bnMsIHRoZSB1YWNjZV9kZXZpY2Ugb2JqZWN0IHN0aWxsIGV4aXN0cyBidXQgaXMgbW9zdGx5IHVu
dXNhYmxlLiBGb3IKPj4+Pj4+IGV4YW1wbGUgb25jZSB0aGUgbW9kdWxlIGlzIGZyZWVkLCB1YWNj
ZS0+b3BzIGlzIG5vdCB2YWxpZCBhbnltb3JlLiBCdXQKPj4+Pj4+IGN1cnJlbnRseSB1YWNjZV9m
b3BzX29wZW4oKSBtYXkgZGVyZWZlcmVuY2UgdGhlIG9wcyBpbiB0aGlzIGNhc2U6Cj4+Pj4+Pgo+
Pj4+Pj4gCXVhY2NlX2ZvcHNfb3BlbigpCj4+Pj4+PiAJIGlmICghdWFjY2UtPnBhcmVudC0+ZHJp
dmVyKQo+Pj4+Pj4gCSAvKiBTdGlsbCB2YWxpZCwga2VlcCBnb2luZyAqLwkJCj4+Pj4+PiAJIC4u
LgkJCQkJcm1tb2QKPj4+Pj4+IAkJCQkJCSB1YWNjZV9yZW1vdmUoKQo+Pj4+Pj4gCSAuLi4JCQkJ
CSBmcmVlX21vZHVsZSgpCj4+Pj4+PiAJIHVhY2NlLT5vcHMtPmdldF9xdWV1ZSgpIC8qIEJVRyAq
Lwo+Pj4+PiB1YWNjZV9yZW1vdmUgc2hvdWxkIHdhaXQgZm9yIHVhY2NlLT5xdWV1ZXNfbG9jaywg
dW50aWwgZm9wc19vcGVuIHJlbGVhc2UgdGhlCj4+Pj4+IGxvY2suCj4+Pj4+IElmIG9wZW4gaGFw
cGVuIGp1c3QgYWZ0ZXIgdGhlIHVhY2NlX3JlbW92ZTogdW5sb2NrLCB1YWNjZV9iaW5kX3F1ZXVl
IGluIG9wZW4KPj4+Pj4gc2hvdWxkIGZhaWwuCj4+Pj4gQWggeWVzIHNvcnJ5LCBJIGxvc3Qgc2ln
aHQgb2Ygd2hhdCB0aGlzIHBhdGNoIHdhcyBhZGRpbmcuIEJ1dCB3ZSBjb3VsZAo+Pj4+IGhhdmUg
dGhlIHNhbWUgaXNzdWUgd2l0aCB0aGUgcGF0Y2gsIGp1c3QgaW4gYSBkaWZmZXJlbnQgb3JkZXIs
IG5vPwo+Pj4+Cj4+Pj4gCXVhY2NlX2ZvcHNfb3BlbigpCj4+Pj4gCSB1YWNjZSA9IHhhX2xvYWQo
KQo+Pj4+IAkgLi4uCQkJCQlybW1vZAo+Pj4gVW0sIGhvdyBpcyBybW1vZCBjYWxsZWQgaWYgdGhl
IGZpbGUgZGVzY3JpcHRvciBpcyBvcGVuPwo+Pj4KPj4+IFRoYXQgc2hvdWxkIG5vdCBiZSBwb3Nz
aWJsZSBpZiB0aGUgb3duZXIgb2YgdGhlIGZpbGUgZGVzY3JpcHRvciBpcwo+Pj4gcHJvcGVybHkg
c2V0LiAgUGxlYXNlIGZpeCB0aGF0IHVwLgo+PiBUaGFua3MgR3JlZwo+Pgo+PiBTZXQgY2RldiBv
d25lciBvciB1c2UgbW9kdWxlX2dldC9wdXQgY2FuIGJsb2NrIHJtbW9kIG9uY2UgZm9wc19vcGVu
Lgo+PiAtwqDCoMKgwqDCoMKgIHVhY2NlLT5jZGV2LT5vd25lciA9IFRISVNfTU9EVUxFOwo+PiAr
wqDCoMKgwqDCoMKgIHVhY2NlLT5jZGV2LT5vd25lciA9IHVhY2NlLT5wYXJlbnQtPmRyaXZlci0+
b3duZXI7Cj4+Cj4+IEhvd2V2ZXIsIHN0aWxsIG5vdCBmaW5kIGdvb2QgbWV0aG9kIHRvIGJsb2Nr
IHJlbW92aW5nIHBhcmVudCBwY2kgZGV2aWNlLgo+Pgo+PiAkIGVjaG8gMSA+IC9zeXMvYnVzL3Bj
aS9kZXZpY2VzLzAwMDA6MDA6MDIuMC9yZW1vdmUgJgo+Pgo+PiBbwqDCoCAzMi41NjMzNTBdwqAg
dWFjY2VfcmVtb3ZlKzB4NmMvMHgxNDgKPj4gW8KgwqAgMzIuNTYzMzUzXcKgIGhpc2lfcW1fdW5p
bml0KzB4MTJjLzB4MTc4Cj4+IFvCoMKgIDMyLjU2MzM1Nl3CoCBoaXNpX3ppcF9yZW1vdmUrMHhh
MC8weGQwIFtoaXNpX3ppcF0KPj4gW8KgwqAgMzIuNTYzMzYxXcKgIHBjaV9kZXZpY2VfcmVtb3Zl
KzB4NDQvMHhkOAo+PiBbwqDCoCAzMi41NjMzNjRdwqAgZGV2aWNlX3JlbW92ZSsweDU0LzB4ODgK
Pj4gW8KgwqAgMzIuNTYzMzY3XcKgIGRldmljZV9yZWxlYXNlX2RyaXZlcl9pbnRlcm5hbCsweGVj
LzB4MWEwCj4+IFvCoMKgIDMyLjU2MzM3MF3CoCBkZXZpY2VfcmVsZWFzZV9kcml2ZXIrMHgyMC8w
eDMwCj4+IFvCoMKgIDMyLjU2MzM3Ml3CoCBwY2lfc3RvcF9idXNfZGV2aWNlKzB4OGMvMHhlMAo+
PiBbwqDCoCAzMi41NjMzNzVdwqAgcGNpX3N0b3BfYW5kX3JlbW92ZV9idXNfZGV2aWNlX2xvY2tl
ZCsweDI4LzB4NjAKPj4gW8KgwqAgMzIuNTYzMzc4XcKgIHJlbW92ZV9zdG9yZSsweDljLzB4YjAK
Pj4gW8KgwqAgMzIuNTYzMzc5XcKgIGRldl9hdHRyX3N0b3JlKzB4MjAvMHgzOAo+IFJlbW92aW5n
IHRoZSBwYXJlbnQgcGNpIGRldmljZSBkb2VzIG5vdCByZW1vdmUgdGhlIG1vZHVsZSBjb2RlLCBp
dAo+IHJlbW92ZXMgdGhlIGRldmljZSBpdHNlbGYuICBEb24ndCBjb25mdXNlIGNvZGUgdnMuIGRh
dGEgaGVyZS4KCkRvIHlvdSBtZWFuIGV2ZW4gcGFyZW50IHBjaSBkZXZpY2UgaXMgcmVtb3ZlZCBp
bW1lZGlhdGVseSwgdGhlIGNvZGUgaGFzIAp0byB3YWl0LCBsaWtlIGRtYSBldGM/CgpDdXJyZW50
bHkgcGFyZW50IGRyaXZlciBoYXMgdG8gZW5zdXJlIGFsbCBkbWEgc3RvcHBlZCB0aGVuIGNhbGwg
CnVhY2NlX3JlbW92ZSwKaWUsIGFmdGVyIHVhY2NlX2ZvcHNfb3BlbiBzdWNjZWVkLCBwYXJlbnQg
ZHJpdmVyIG5lZWQgd2FpdCBmb3BzX3JlbGVhc2UsIAp0aGVuIHVhY2NlX3JlbW92ZSBjYW4gYmUg
Y2FsbGVkLgpGb3IgZXhhbXBsZToKZHJpdmVycy9jcnlwdG8vaGlzaWxpY29uL3ppcC96aXBfbWFp
bi5jOgpoaXNpX3FtX3dhaXRfdGFza19maW5pc2gKCklmIHJlbW92ZSB0aGlzIHdhaXQgLCB0aGVy
ZSBtYXkgb3RoZXIgaXNzdWUsClVuYWJsZSB0byBoYW5kbGUga2VybmVsIHBhZ2luZyByZXF1ZXN0
IGF0IHZpcnR1YWwgYWRkcmVzcyBmZmZmODAwMDBiNzAwMjA0CnBjIDogaGlzaV9xbV9jYWNoZV93
Yi5wYXJ0LjArMHgyYy8weGEwCgpTbyB1YWNjZSBvbmx5IG5lZWQgc2VyaWFsaXplIHVhY2NlX2Zv
cHNfb3BlbiBhbmQgdWFjY2VfcmVtb3ZlLgpBZnRlciB1YWNjZV9mb3BzX29wZW4sIHdlIGNhbiBh
c3N1bWUgdWFjY2VfcmVtb3ZlIG9ubHkgaGFwcGVuIGFmdGVyIAp1YWNjZV9mb3BzX3JlbGVhc2U/
ClRoZW4gaXQgd291bGQgYmUgbXVjaCBzaW1wbGVyLgoKVGhhbmtzCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
