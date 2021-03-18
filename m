Return-Path: <SRS0=56b4=IQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0267BC433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 19:43:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7271664F1D
	for <iommu@archiver.kernel.org>; Thu, 18 Mar 2021 19:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7271664F1D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16D8A8429E;
	Thu, 18 Mar 2021 19:43:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EZfVvlSW2IPh; Thu, 18 Mar 2021 19:43:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id E23F8842A0;
	Thu, 18 Mar 2021 19:43:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF8A8C000B;
	Thu, 18 Mar 2021 19:43:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3004C0001
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 19:43:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB5314EE09
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 19:43:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M5kj3SKoGqQh for <iommu@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 19:43:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 66BD94EDF5
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 19:43:23 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 f2-20020a17090a4a82b02900c67bf8dc69so5552413pjh.1
 for <iommu@lists.linux-foundation.org>; Thu, 18 Mar 2021 12:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=CXffwwYrcucz6PkLWpGV6NoHESkAqtw1CcNDZMWpdBQ=;
 b=jNduKqJSMUt5WOZPCi3HQPsGOMYzo1qxNn0d+yLtF8QzHmxYn0MVxo7w12d1iPqQVu
 lvV1OiEOTwUp2o4S66sZfnfNbFJAXalm65NDQLl5JFIpsz2/PxhHDEO5fUST3hzhU+mH
 QV0redUgqcnqebnNyc9hcJiAsUnwxbefH1YOrrPEcbzenRZZoFdQFvXYulMAb3FTk1CU
 C1PYz88MNF/+3hNqyhITzujGZhpofOKCKiQ+9SWg6Xvzo2IDCHreg4+/JEpmFrTgIJUH
 /PZOX1aPLFEPHOqy7a1rTPBzFhbKjm7PPxroYyHK2xEU66pnZGpHDpuWZn6ouI3cCnh9
 mwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CXffwwYrcucz6PkLWpGV6NoHESkAqtw1CcNDZMWpdBQ=;
 b=eJQiBnVJbsm0mTOcgc60JF6tFn4T74ENUW+TSNbbTN5r9Lo+GwYvEanU/H7iAcnFhI
 QMBxXPLCARCICSa9oVUiec6Hlvz07iIUr6uVO3hHdfBsFk5eQiNtSuJ9JO4E4KY084Fy
 ZRxsxnY97/MTqyFdrKj8cCPdKSt/lqF2up1CImR3orvrRKY4GTu3bfji9/+v5ftPQ8Y+
 N7Of6YJK3KMDNBkkm7bVOLpqRlxzg1KSeX7x/zNj/wMvVgTbSRn5WU1v9ii74Wy21t70
 3KOA0GtNbe/gMlvY1Gd2aGo8FeRpm7TSRAViMvY4vveDG4XDdKtM5XPVOqIvCcs7e9ef
 6aaw==
X-Gm-Message-State: AOAM5335mHf6Ztd+auGa0moBhufQBdDOQIWTNG8iwefSFu/yvERy3nMe
 P38PvCXW0nLDXdk1vL+4S9GM+9Rl9FI=
X-Google-Smtp-Source: ABdhPJx6whDMKDzC33BODdtY7U0RVIN3SJu2/2BSqs7xQbfPQVncsAi7MXbvsiinVYE9JAwpBX4ArA==
X-Received: by 2002:a17:90a:d507:: with SMTP id
 t7mr6128138pju.54.1616096602323; 
 Thu, 18 Mar 2021 12:43:22 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id e190sm3109763pfe.3.2021.03.18.12.43.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Mar 2021 12:43:21 -0700 (PDT)
Subject: Re: [PATCH] swiotlb: Add swiotlb=off to disable SWIOTLB
To: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <20210318191816.4185226-1-f.fainelli@gmail.com>
 <bbd44c42-cedc-7bd6-a443-c991fd080298@gmail.com>
 <e7850feb-b7cd-e279-e3fc-a9bdba162423@arm.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f0940ea7-79f6-af57-aa7d-d121abb99012@gmail.com>
Date: Thu, 18 Mar 2021 12:43:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e7850feb-b7cd-e279-e3fc-a9bdba162423@arm.com>
Content-Language: en-US
Cc: Jonathan Corbet <corbet@lwn.net>, opendmb@gmail.com,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Randy Dunlap <rdunlap@infradead.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Kravetz <mike.kravetz@oracle.com>, Thomas Gleixner <tglx@linutronix.de>
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

CgpPbiAzLzE4LzIwMjEgMTI6MzQgUE0sIFJvYmluIE11cnBoeSB3cm90ZToKPiBPbiAyMDIxLTAz
LTE4IDE5OjIyLCBGbG9yaWFuIEZhaW5lbGxpIHdyb3RlOgo+Pgo+Pgo+PiBPbiAzLzE4LzIwMjEg
MTI6MTggUE0sIEZsb3JpYW4gRmFpbmVsbGkgd3JvdGU6Cj4+PiBJdCBtYXkgYmUgdXNlZnVsIHRv
IGRpc2FibGUgdGhlIFNXSU9UTEIgY29tcGxldGVseSBmb3IgdGVzdGluZyBvciB3aGVuIGEKPj4+
IHBsYXRmb3JtIGlzIGtub3duIG5vdCB0byBoYXZlIGFueSBEUkFNIGFkZHJlc3NpbmcgbGltaXRh
dGlvbnMgd2hhdCBzbwo+Pj4gZXZlci4KPiAKPiBJc24ndCB0aGF0IHdoYXQgInN3aW90bGI9bm9m
b3JjZSIgaXMgZm9yPyBJZiB5b3UncmUgY29uZmlkZW50IHRoYXQgd2UndmUKPiByZWFsbHkgaXJv
bmVkIG91dCAqYWxsKiB0aGUgYXdrd2FyZCBjb3JuZXJzIHRoYXQgdXNlZCB0byBibG93IHVwIGlm
Cj4gdmFyaW91cyBpbnRlcm5hbCBiaXRzIHdlcmUgbGVmdCB1bmluaXRpYWxpc2VkLCB0aGVuIGl0
IHdvdWxkIG1ha2Ugc2Vuc2UKPiB0byBqdXN0IHR3ZWFrIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB3
aGF0IHdlIGFscmVhZHkgaGF2ZS4KCnN3aW90bGI9bm9mb3JjZSBkb2VzIHByZXZlbnQgZG1hX2Rp
cmVjdF9tYXBfcGFnZSgpIGZyb20gcmVzb3J0aW5nIHRvIHRoZQpzd2lvdGxiLCBob3dldmVyIHdo
YXQgSSBhbSBhbHNvIGFmdGVyIGlzIHJlY2xhaW1pbmcgdGhlc2UgNjRNQiBvZgpkZWZhdWx0IFNX
SU9UTEIgYm91bmNlIGJ1ZmZlcmluZyBtZW1vcnkgYmVjYXVzZSBteSBzeXN0ZW1zIHJ1biB3aXRo
CmxhcmdlIGFtb3VudHMgb2YgcmVzZXJ2ZWQgbWVtb3J5IGludG8gWk9ORV9NT1ZBQkxFIGFuZCBl
dmVyeXRoaW5nIGluClpPTkVfTk9STUFMIGlzIHByZWNpb3VzIGF0IHRoYXQgcG9pbnQuCgo+IAo+
IEkgd291bGRuJ3QgbmVjZXNzYXJpbHkgZGlzYWdyZWUgd2l0aCBhZGRpbmcgIm9mZiIgYXMgYW4g
YWRkaXRpb25hbCBhbGlhcwo+IGZvciAibm9mb3JjZSIsIHRob3VnaCwgc2luY2UgaXQgZG9lcyBj
b21lIGFjcm9zcyBhcyBhIGJpdCB3YWNreSBmb3IKPiBnZW5lcmFsIHVzZS4KPiAKPj4+IFNpZ25l
ZC1vZmYtYnk6IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPgo+Pgo+PiBD
aHJpc3RvcGgsIGluIGFkZGl0aW9uIHRvIHRoaXMgY2hhbmdlLCBob3cgd291bGQgeW91IGZlZWwg
aWYgd2UKPj4gcXVhbGlmaWVkIHRoZSBzd2lvdGxiX2luaXQoKSBpbiBhcmNoL2FybS9tbS9pbml0
LmMgd2l0aCBhOgo+Pgo+Pgo+PiBpZiAobWVtYmxvY2tfZW5kX29mX0RSQU0oKSA+PSBTWl80RykK
Pj4gwqDCoMKgwqBzd2lvdGxiX2luaXQoMSkKPiAKPiBNb2R1bG8gInN3aW90bGI9Zm9yY2UiLCBv
ZiBjb3Vyc2UgOykKCkluZGVlZCwgd2Ugd291bGQgbmVlZCB0byBoYW5kbGUgdGhhdCBjYXNlIGFz
IHdlbGwuIERvZXMgaXQgc291bmQKcmVhc29uYWJsZSB0byBkbyB0aGF0IHRvIHlvdSBhcyB3ZWxs
PwotLSAKRmxvcmlhbgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
