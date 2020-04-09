Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D024C2D0EA
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 09:07:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470D920A8B
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 09:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zx1ITjRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470D920A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C0310874A7;
	Thu,  9 Apr 2020 09:07:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ugRBS0ClDBWG; Thu,  9 Apr 2020 09:07:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EC82D86C02;
	Thu,  9 Apr 2020 09:07:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFEC3C1D7E;
	Thu,  9 Apr 2020 09:07:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20CA6C0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 09:07:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 05AF786DF4
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 09:07:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iGSoNPegcaJI for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 09:07:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4335B86C02
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 09:07:50 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id mn19so1031848pjb.0
 for <iommu@lists.linux-foundation.org>; Thu, 09 Apr 2020 02:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=h74J54nIpWHdgu91QVuvRexI7BsK/jOCn+821SMHg9c=;
 b=zx1ITjRH6p3gwKGp+J+RbI0XmbIz469PrPPB7SxR8yXCWOXetE2kzRk4a3lXxr3/Ti
 rXurpv8d4aAhsnTZzcNomePoW1IiuhFwMVzZ8UWfNfjDDIu8FkPQ+6Dqx6VyGxB1jmhw
 qJ7hV1rqXTcdI7gfnmz5tkZX5+VRm0X3UT+oC8JKW12lR7VGv8vnn48/b4YfUugajAFG
 SlY/Y/3dovdAqGFfNxRh0hsmOyyAruv2t8FU0UUYbVV0AVftqlYFWtYVJfSgTWdXE/Je
 RLzvKxgP1Fc5VYdtOSabNYwtpRfC7kimmSnC8QD6zFhWMOArBl4D6gsFUB+IAoGTzwNR
 2JmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=h74J54nIpWHdgu91QVuvRexI7BsK/jOCn+821SMHg9c=;
 b=Q42ghor8YKAsXeRbY6BhJVERQ3iN6BuHJK9jzYoMOLcTeX+DYLDfVRFLMHpsdZEh7y
 v7QyKUNFXyJVSJkO4wewk/0q+lwug0T5XWsDokwBhTb0C0LjQTlGyjieRtn4pUVzXAvf
 MeRoC8ALLI051DgYOfZOIobtjbiIijoof1wSrRgtRUoTcO0pnaP4m2Ct3ix0o2Kd4dbE
 Y2aYs6O9mh2l00DFFEIxLC1ZSmsmdZbP7p1JjKoU3hSCnRtVQ210pyHxHpWXMBts6WMR
 JjJMWVN3BaMv5MCckZGLHPnyUqFj0OwbSMOlBI19hwKGfj1KB48qswonwOUzaWiZxf2r
 WUoA==
X-Gm-Message-State: AGi0PuYkTiOhD4HOB4XyyMKGxbRnxjP1Pbf78JMki0w2wTiQ70560nCU
 by54SiN7eKll+bmAABNB7xoaeg==
X-Google-Smtp-Source: APiQypKc7ZWGJ3tbjdGwZ+og6c1ed7I6ukW3kRixkj5hvt5RJ2DVzi0VV2uMJ5RyCpvustnNUG4zsg==
X-Received: by 2002:a17:90a:d101:: with SMTP id
 l1mr10285320pju.1.1586423269825; 
 Thu, 09 Apr 2020 02:07:49 -0700 (PDT)
Received: from [10.27.0.138] ([45.135.186.113])
 by smtp.gmail.com with ESMTPSA id n23sm4988770pgb.88.2020.04.09.02.07.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Apr 2020 02:07:49 -0700 (PDT)
Subject: Re: [PATCH 1/2] uacce: Remove mm_exit() op
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, linux-accelerators@lists.ozlabs.org
References: <20200408140427.212807-1-jean-philippe@linaro.org>
 <20200408140427.212807-2-jean-philippe@linaro.org>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <5741a4d9-c3ae-f0d6-27f9-550bbeaa4c4a@linaro.org>
Date: Thu, 9 Apr 2020 17:07:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200408140427.212807-2-jean-philippe@linaro.org>
Content-Language: en-US
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, jgg@ziepe.ca
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

CgpPbiAyMDIwLzQvOCDkuIvljYgxMDowNCwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOgo+
IFRoZSBtbV9leGl0KCkgb3Agd2lsbCBiZSByZW1vdmVkIGZyb20gdGhlIFNWQSBBUEkuIFdoZW4g
YSBwcm9jZXNzIGRpZXMKPiBhbmQgaXRzIG1tIGdvZXMgYXdheSwgdGhlIElPTU1VIGRyaXZlciB3
b24ndCBub3RpZnkgZGV2aWNlIGRyaXZlcnMKPiBhbnltb3JlLiBEcml2ZXJzIHNob3VsZCBleHBl
Y3QgdG8gaGFuZGxlIGEgbG90IG1vcmUgYWJvcnRlZCBETUEuIE9uIHRoZQo+IHVwc2lkZSwgaXQg
ZG9lcyBncmVhdGx5IHNpbXBsaWZ5IHRoZSBxdWV1ZSBtYW5hZ2VtZW50Lgo+Cj4gVGhlIHVhY2Nl
X21tIHN0cnVjdCwgdGhhdCB0cmFja3MgYWxsIHF1ZXVlcyBib3VuZCB0byBhbiBtbSwgd2FzIG9u
bHkKPiB1c2VkIGJ5IHRoZSBtbV9leGl0KCkgY2FsbGJhY2suIFJlbW92ZSBpdC4KPgo+IFNpZ25l
ZC1vZmYtYnk6IEplYW4tUGhpbGlwcGUgQnJ1Y2tlciA8amVhbi1waGlsaXBwZUBsaW5hcm8ub3Jn
PgpUaGFua3MgSmVhbiBmb3IgZG9pbmcgdGhpcy4KClRlc3RlZC1ieTogWmhhbmdmZWkgR2FvIDx6
aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4KCkV4Y2VwdCBvbmUgbGluZS4KPiAtc3RhdGljIHZvaWQg
dWFjY2VfbW1fcHV0KHN0cnVjdCB1YWNjZV9xdWV1ZSAqcSkKPiArc3RhdGljIHZvaWQgdWFjY2Vf
dW5iaW5kX3F1ZXVlKHN0cnVjdCB1YWNjZV9xdWV1ZSAqcSkKPiAgIHsKPiAtCXN0cnVjdCB1YWNj
ZV9tbSAqdWFjY2VfbW0gPSBxLT51YWNjZV9tbTsKPiAtCj4gLQlsb2NrZGVwX2Fzc2VydF9oZWxk
KCZxLT51YWNjZS0+bW1fbG9jayk7Cj4gLQo+IC0JbXV0ZXhfbG9jaygmdWFjY2VfbW0tPmxvY2sp
Owo+IC0JbGlzdF9kZWwoJnEtPmxpc3QpOwo+IC0JbXV0ZXhfdW5sb2NrKCZ1YWNjZV9tbS0+bG9j
ayk7Cj4gLQo+IC0JaWYgKGxpc3RfZW1wdHkoJnVhY2NlX21tLT5xdWV1ZXMpKSB7Cj4gLQkJaWYg
KHVhY2NlX21tLT5oYW5kbGUpCj4gLQkJCWlvbW11X3N2YV91bmJpbmRfZGV2aWNlKHVhY2NlX21t
LT5oYW5kbGUpOwo+IC0JCWxpc3RfZGVsKCZ1YWNjZV9tbS0+bGlzdCk7Cj4gLQkJa2ZyZWUodWFj
Y2VfbW0pOwo+IC0JfQo+ICsJaWYgKCFxLT5oYW5kbGUpCj4gKwkJcmV0dXJuOwo+ICsJaW9tbXVf
c3ZhX3VuYmluZF9kZXZpY2UocS0+aGFuZGxlKTsKKyBxLT5oYW5kbGUgPSAwOwoKT3RoZXJ3aXNl
IGlvbW11X3N2YV91bmJpbmRfZGV2aWNlIG1heWJlIGNhbGxlZCB0d2ljZS4KU2luY2UgdWFjY2Vf
dW5iaW5kX3F1ZXVlIGNhbiBiZSBjYWxsZWQgYnkgdWFjY2VfcmVtb3ZlIGFuZCB1YWNjZV9mb3Bz
X3JlbGVhc2UuCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
