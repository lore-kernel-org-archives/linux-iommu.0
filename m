Return-Path: <SRS0=zhz4=4N=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FE8C35DF9
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 08:34:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23438218AC
	for <iommu@archiver.kernel.org>; Tue, 25 Feb 2020 08:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QszlcDQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23438218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B6B7787695;
	Tue, 25 Feb 2020 08:34:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Shue2DiSfls; Tue, 25 Feb 2020 08:34:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5AC6F85061;
	Tue, 25 Feb 2020 08:34:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4208BC089F;
	Tue, 25 Feb 2020 08:34:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16A55C0177
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 08:34:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1111784BE7
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 08:34:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NP8LXqg44-+a for <iommu@lists.linux-foundation.org>;
 Tue, 25 Feb 2020 08:34:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B2E51847D9
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 08:34:11 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id b22so5176941pls.12
 for <iommu@lists.linux-foundation.org>; Tue, 25 Feb 2020 00:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=EIG5peTBvtZ2crp8lRotOHODI8wwfFW0u8sMOW/L1sk=;
 b=QszlcDQTF2Q2LkffTbIRI3lryFDMXd0PvmTxvgXjQgWVs4b+u9xfRQUq/q2qapPqNX
 6fOPzA5/MBsQgoclTc8R1RazJoG0IS7T8sos5KrxMx5nBAW3g4033Z3oFaDO0Eyvi8m3
 zKy6Qi4OpF8r2sA/VDjAV9GgFmLoehFxHt654aIZejm36g9ICrWPyQKq0Lu15SjcQ4RO
 NPGZbO9dCZs/ib/WPLdzP7z8+gzQOA9Pv/qeO4Gi8PGifICutSTCGxHk0vCYhwwtfgIw
 hrVeyJ9wDt3tGfUHHyS4FZgjozzQzt4g4KuNlUS6KvgJqNGeWsBMVWSXZ+QrBZT3VSJk
 s1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=EIG5peTBvtZ2crp8lRotOHODI8wwfFW0u8sMOW/L1sk=;
 b=g6JL/QoQyij+TXAFtTqZzP/avYIBEAazCcCTsfV6rxCDIQe0co9GdlnCsgA37h6uKE
 hCIYMWBHyiIY3FDeIcoaHdPJ9CDez6as+nycAaE9gw1QQJw5oFVd7vmP4dEQZX6QIhbS
 3dC9zNRpalB7cwC0zl4HZ0XtmnwMcu8mAPqIx5nQWT/7Ku3JavW+Ow4eaQa5lNWypyXW
 lssgCaeqsCDjrJYJsT2K8zklJzpz9wnvXehAhZ1FWXftS6rLYFs+2BZXbwSMr1FYt6UP
 7QApGPl+YhlH0manyLLrA4lAtC23jtEd6Jlodmh4+V2m4HgWfF61sGr4SYerg1BMbw1W
 LP7g==
X-Gm-Message-State: APjAAAWA09ft0kGT03t37Xvr4GeFn+pY7QteMWyzOC61gjANFFg7wUFs
 wXemgs2aD91sym9dxB/lRv6ERw==
X-Google-Smtp-Source: APXvYqzAbMNZB07THyLuieZ3+XL0SoHji7KzYKVpxSVKAYezqzD3vcQYoYbTfpEkMi2a8G49muU0DA==
X-Received: by 2002:a17:90a:c084:: with SMTP id
 o4mr3747200pjs.35.1582619651238; 
 Tue, 25 Feb 2020 00:34:11 -0800 (PST)
Received: from ?IPv6:240e:362:421:7f00:524:e1bd:8061:a346?
 ([240e:362:421:7f00:524:e1bd:8061:a346])
 by smtp.gmail.com with ESMTPSA id f1sm2106681pjq.31.2020.02.25.00.33.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 00:34:10 -0800 (PST)
Subject: Re: [PATCH] uacce: unmap remaining mmapping from user space
To: Xu Zaibo <xuzaibo@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Herbert Xu <herbert@gondor.apana.org.au>,
 jonathan.cameron@huawei.com, dave.jiang@intel.com, grant.likely@arm.com,
 jean-philippe <jean-philippe@linaro.org>, Jerome Glisse
 <jglisse@redhat.com>, ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
 kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
 "haojian . zhuang" <haojian.zhuang@linaro.org>, guodong.xu@linaro.org
References: <1582528016-2873-1-git-send-email-zhangfei.gao@linaro.org>
 <a4716453-0607-d613-e632-173d1ebc424e@huawei.com>
From: zhangfei <zhangfei.gao@linaro.org>
Message-ID: <cf1f7ec2-7181-63fd-598d-b74d5a3efa15@linaro.org>
Date: Tue, 25 Feb 2020 16:33:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <a4716453-0607-d613-e632-173d1ebc424e@huawei.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-accelerators@lists.ozlabs.org, linux-crypto@vger.kernel.org
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

SGksIFphaWJvCgpPbiAyMDIwLzIvMjQg5LiL5Y2IMzoxNywgWHUgWmFpYm8gd3JvdGU6Cj4+IMKg
IEBAIC01ODUsNiArNTk1LDEzIEBAIHZvaWQgdWFjY2VfcmVtb3ZlKHN0cnVjdCB1YWNjZV9kZXZp
Y2UgKnVhY2NlKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgY2Rldl9kZXZpY2VfZGVsKHVhY2NlLT5j
ZGV2LCAmdWFjY2UtPmRldik7Cj4+IMKgwqDCoMKgwqAgeGFfZXJhc2UoJnVhY2NlX3hhLCB1YWNj
ZS0+ZGV2X2lkKTsKPj4gwqDCoMKgwqDCoCBwdXRfZGV2aWNlKCZ1YWNjZS0+ZGV2KTsKPj4gKwo+
PiArwqDCoMKgIC8qCj4+ICvCoMKgwqDCoCAqIHVubWFwIHJlbWFpbm5pbmcgbWFwcGluZyBmcm9t
IHVzZXIgc3BhY2UsIHByZXZlbnRpbmcgdXNlciBzdGlsbAo+PiArwqDCoMKgwqAgKiBhY2Nlc3Mg
dGhlIG1tYXBlZCBhcmVhIHdoaWxlIHBhcmVudCBkZXZpY2UgaXMgYWxyZWFkeSByZW1vdmVkCj4+
ICvCoMKgwqDCoCAqLwo+PiArwqDCoMKgIGlmICh1YWNjZS0+aW5vZGUpCj4+ICvCoMKgwqDCoMKg
wqDCoCB1bm1hcF9tYXBwaW5nX3JhbmdlKHVhY2NlLT5pbm9kZS0+aV9tYXBwaW5nLCAwLCAwLCAx
KTsKPiBTaG91bGQgd2UgdW5tYXAgdGhlbSBhdCB0aGUgZmlyc3Qgb2YgJ3VhY2NlX3JlbW92ZScs
wqAgYW5kIGJlZm9yZSAKPiAndWFjY2VfcHV0X3F1ZXVlJz8KPgpXZSBjYW4gZG8gdGhpcywKVGhv
dWdoIGl0IGRvZXMgbm90IG1hdHRlciwgc2luY2UgdXNlciBzcGFjZSBjYW4gbm90IGludGVycnVw
dCBrZXJuZWwgCmZ1bmN0aW9uIHVhY2NlX3JlbW92ZS4KClRoYW5rcwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
