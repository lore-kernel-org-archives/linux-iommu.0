Return-Path: <SRS0=b4g5=KF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22E9C433B4
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 19:04:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AD1361492
	for <iommu@archiver.kernel.org>; Mon, 10 May 2021 19:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AD1361492
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C61A4404CD;
	Mon, 10 May 2021 19:04:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V6jo6eGWKjAt; Mon, 10 May 2021 19:04:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9DBED40192;
	Mon, 10 May 2021 19:04:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66923C000D;
	Mon, 10 May 2021 19:04:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E23DC0001
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 19:04:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 64D8C40556
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 19:04:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id faVEJT2uhymt for <iommu@lists.linux-foundation.org>;
 Mon, 10 May 2021 19:04:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8DC1F40535
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 19:04:04 +0000 (UTC)
Received: by mail-pf1-x42a.google.com with SMTP id a5so7240673pfa.11
 for <iommu@lists.linux-foundation.org>; Mon, 10 May 2021 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WQ3UlPMi8iO1JweMxxShHAfYCCuhz0sN8zAS6TXgeZ8=;
 b=vd4BMadKXX2VYgCwHP2rz/WhOyv8UV+3Nk1yGWi1MWwBuhF4Mb4GRq5sxXn4AEuYdL
 dLlUqxkd1lWXDByZ2We6cegOkUUHrhOH5WFhT/RnRyS9O9Ma2v674hwJ2hbrWTiO0Mjw
 ny/SeUMfYOLdb3OSL9sDDLLyfsgNEU2inDnK2LmM6HmtSLKhrxmST9EVM8PtIP57ze7e
 0gFip1GIGoXL9gpDsnDbeyh7x8uqVeW4m8YXy3Pjh79KTVGWJRDitG6EjQXkm0j3vOGN
 UUGKo2g7dnwrzaPC8gzO4YFIBXKvsREJrkxf0gSESM3qCHywcPiSFYG34qYlPYQbZ+T3
 Gb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WQ3UlPMi8iO1JweMxxShHAfYCCuhz0sN8zAS6TXgeZ8=;
 b=J1qcs6GCexqK7Onf/Dga8JKK6/+PBVacJ1JL6Z5ajoqH9DasB6cLt1PeIJFvNOKubD
 gbQBIyGFw1bwn4GsFlnZeyB9llL9jJs4i7FTHLDYuOtC72ESh2G14bDilwK6Ha5uFNGi
 QuJ2McLj93s2szxZnG7z8P+CeiUwo99dwQOC44xk0WOgZYbRR40aLdIauALAtOku0Qow
 zB6KGd1f2o/Jqemu2dJqeJDDrDptjAfwOn5MJlOno3x9lttXQY/YzCdgJwz4BtOsS5KF
 ncmpR4d42mGatiHp6OmX8BXl7F384MvqeYs3nHl4JCc2LuXDkHNwH2Lzm3LPSXpHqgF6
 1J4w==
X-Gm-Message-State: AOAM533Ky7MR4pkDC9jmRM759YYC/DhuTGUbxWc5B2bA+enkdV6Ij5Gs
 fqIusrE5aBsfCZbhgk1pIUSYs3UaYDI=
X-Google-Smtp-Source: ABdhPJyfcWJULySA3pD+719piBeBcWvrLBFc8WnyM7QHhcOIc5yXuHy57rzrSbcSkDQFpBH4yBwBvw==
X-Received: by 2002:a63:e30d:: with SMTP id f13mr22059947pgh.201.1620673443541; 
 Mon, 10 May 2021 12:04:03 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id p19sm11552318pff.206.2021.05.10.12.04.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 May 2021 12:04:03 -0700 (PDT)
Subject: Re: Regression when booting 5.15 as dom0 on arm64 (WAS: Re:
 [linux-linus test] 161829: regressions - FAIL)
To: Julien Grall <julien@xen.org>, Christoph Hellwig <hch@lst.de>
References: <osstest-161829-mainreport@xen.org>
 <4ea1e89f-a7a0-7664-470c-b3cf773a1031@xen.org> <20210510084057.GA933@lst.de>
 <8b851596-acf7-9d3b-b08a-848cae5adada@xen.org>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2c19af0b-e4c1-4f57-19cd-a86b4dc18c35@gmail.com>
Date: Mon, 10 May 2021 12:04:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <8b851596-acf7-9d3b-b08a-848cae5adada@xen.org>
Content-Language: en-US
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org,
 osstest service owner <osstest-admin@xenproject.org>,
 iommu@lists.linux-foundation.org,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
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

CgpPbiA1LzEwLzIwMjEgMTE6MTUgQU0sIEp1bGllbiBHcmFsbCB3cm90ZToKPiBIaSBDaHJpc3Rv
cGgsCj4gCj4gT24gMTAvMDUvMjAyMSAwOTo0MCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4+
IE9uIFNhdCwgTWF5IDA4LCAyMDIxIGF0IDEyOjMyOjM3QU0gKzAxMDAsIEp1bGllbiBHcmFsbCB3
cm90ZToKPj4+IFRoZSBwb2ludGVyIGRlcmVmZXJlbmNlZCBzZWVtcyB0byBzdWdnZXN0IHRoYXQg
dGhlIHN3aW90bGIgaGFzbid0IGJlZW4KPj4+IGFsbG9jYXRlZC4gRnJvbSB3aGF0IEkgY2FuIHRl
bGwsIHRoaXMgbWF5IGJlIGJlY2F1c2Ugc3dpb3RsYl9mb3JjZSBpcwo+Pj4gc2V0Cj4+PiB0byBT
V0lPVExCX05PX0ZPUkNFLCB3ZSB3aWxsIHN0aWxsIGVuYWJsZSB0aGUgc3dpb3RsYiB3aGVuIHJ1
bm5pbmcgb24KPj4+IHRvcAo+Pj4gb2YgWGVuLgo+Pj4KPj4+IEkgYW0gbm90IGVudGlyZWx5IHN1
cmUgd2hhdCB3b3VsZCBiZSB0aGUgY29ycmVjdCBmaXguIEFueSBvcGluaW9ucz8KPj4KPj4gQ2Fu
IHlvdSB0cnkgc29tZXRoaW5nIGxpa2UgdGhlIHBhdGNoIGJlbG93IChub3QgZXZlbiBjb21waWxl
IHRlc3RlZCwgYnV0Cj4+IHRoZSBpbnRlbnQgc2hvdWxkIGJlIG9idmlvdXM/Cj4+Cj4+Cj4+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L21tL2luaXQuYyBiL2FyY2gvYXJtNjQvbW0vaW5pdC5jCj4+
IGluZGV4IDE2YTJiMmIxYzU0ZC4uNzY3MWJjMTUzZmIxIDEwMDY0NAo+PiAtLS0gYS9hcmNoL2Fy
bTY0L21tL2luaXQuYwo+PiArKysgYi9hcmNoL2FybTY0L21tL2luaXQuYwo+PiBAQCAtNDQsNiAr
NDQsOCBAQAo+PiDCoCAjaW5jbHVkZSA8YXNtL3RsYi5oPgo+PiDCoCAjaW5jbHVkZSA8YXNtL2Fs
dGVybmF0aXZlLmg+Cj4+IMKgICsjaW5jbHVkZSA8eGVuL2FybS9zd2lvdGxiLXhlbi5oPgo+PiAr
Cj4+IMKgIC8qCj4+IMKgwqAgKiBXZSBuZWVkIHRvIGJlIGFibGUgdG8gY2F0Y2ggaW5hZHZlcnRl
bnQgcmVmZXJlbmNlcyB0byBtZW1zdGFydF9hZGRyCj4+IMKgwqAgKiB0aGF0IG9jY3VyIChwb3Rl
bnRpYWxseSBpbiBnZW5lcmljIGNvZGUpIGJlZm9yZQo+PiBhcm02NF9tZW1ibG9ja19pbml0KCkK
Pj4gQEAgLTQ4Miw3ICs0ODQsNyBAQCB2b2lkIF9faW5pdCBtZW1faW5pdCh2b2lkKQo+PiDCoMKg
wqDCoMKgIGlmIChzd2lvdGxiX2ZvcmNlID09IFNXSU9UTEJfRk9SQ0UgfHwKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgIG1heF9wZm4gPiBQRk5fRE9XTihhcm02NF9kbWFfcGh5c19saW1pdCkpCj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBzd2lvdGxiX2luaXQoMSk7Cj4+IC3CoMKgwqAgZWxzZQo+PiArwqDC
oMKgIGVsc2UgaWYgKCFJU19FTkFCTEVEKENPTkZJR19YRU4pIHx8ICF4ZW5fc3dpb3RsYl9kZXRl
Y3QoKSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHN3aW90bGJfZm9yY2UgPSBTV0lPVExCX05PX0ZP
UkNFOwo+PiDCoCDCoMKgwqDCoMKgIHNldF9tYXhfbWFwbnIobWF4X3BmbiAtIFBIWVNfUEZOX09G
RlNFVCk7Cj4gCj4gSSBoYXZlIGFwcGxpZWQgdGhlIHBhdGNoIG9uIHRvcCBvZiA1LjEzLXJjMSBh
bmQgY2FuIGNvbmZpcm0gSSBhbSBhYmxlIHRvCj4gYm9vdCBkb20wLiBBcmUgeW91IGdvaW5nIHRv
IHN1Ym1pdCB0aGUgcGF0Y2g/CgpTb3JyeSBhYm91dCB0aGF0IEp1bGllbiBhbmQgdGhhbmtzIENo
cmlzdG9waCEKLS0gCkZsb3JpYW4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
