Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DC0C2BA83
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 09:43:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE052173E
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 09:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PZPAygbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE052173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2EA4587E90;
	Thu, 13 Feb 2020 09:43:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AKVzN-TuMtmU; Thu, 13 Feb 2020 09:43:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0BF0587E72;
	Thu, 13 Feb 2020 09:43:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E60C6C08A4;
	Thu, 13 Feb 2020 09:43:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D10D3C0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 09:43:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BE824203E2
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 09:43:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PCcU+93Fc5OO for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 09:43:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by silver.osuosl.org (Postfix) with ESMTPS id E2D3C203D3
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 09:43:03 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id d9so2806323pgu.3
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 01:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=NoGUqRpq1F77wcdshkLX1E0mBsPP95pWUoHQOnOvrik=;
 b=PZPAygbXf35pGVvey68bGizPw7g3pQJ2BxVMk8RCqukzpbiRkFrrEVDHzhPxDT1v8O
 BmdBCCzhGg1mqmMXi233FUZVYwx7iFvzRSfs3KvjJkoS7U1SBzHT7vIBlPC3i5J5+ne+
 JiexY8XFovWpYjZ1D8yF82T6x6H31LpdWePek5DStlFYOG7dtaXmaDYn+oti8Z75dzVo
 tP/y8TNe4vsT1EN5KQFVqs27BVb2oz/8eX22GDnEDLKbVkNRZL6/iYRMKvPKK0afSH1O
 rZnTueO7A+YCp2knuxwjglDR342/ujy4FQgTDLNvyio/xY+hKV7giUM+IjTnEb9z+h0z
 ozXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=NoGUqRpq1F77wcdshkLX1E0mBsPP95pWUoHQOnOvrik=;
 b=FhendW4Qr+AsceseJLmBicCE1ZYGumIiSgmNX0wI1otxikzZOFUo0q14mr+H5cKvG0
 G8HsX88iQf1eiuTJscbwGAxCZIlQUzH6rJZLEhqtR44ICddtNIEot5j9Ku94weIMmEGr
 kjNsqmOsthY4S2i/I/k1+4tfB2iZ3CNW5L6JwsrlZAKbM+l8TZ0OHIbRT28SCoba16Bs
 ZPky8fsB9MRlt+Z91C6KfSPWH+gk3955i1OgDmsGv0U/RJN/0A0kVuLG6Ly/MMEnL2tM
 08tjO8rgvn1p4+fTZ2cxyyma1z5EoSC4nMnqC4XE2bn8XohGOe1cMyqgNB4mlohpRb9h
 40Ow==
X-Gm-Message-State: APjAAAWrtdffTClXq1gQiuXOByK5v4/rmdbgzb+V4yyE8d4vOLg5HyIL
 CaDgCGy8Ntn4WWFjtdCGIbxiFw==
X-Google-Smtp-Source: APXvYqyb/1C2ZIIlDPuaXok56IVD4v4T9EnKvkkqKbl8eWGafz0TN3Sk1x1XXOZucUcEJGpMrGaO5A==
X-Received: by 2002:a62:52d0:: with SMTP id
 g199mr12680304pfb.241.1581586983496; 
 Thu, 13 Feb 2020 01:43:03 -0800 (PST)
Received: from [10.149.0.118] ([45.135.186.75])
 by smtp.gmail.com with ESMTPSA id w26sm2421887pfj.119.2020.02.13.01.42.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Feb 2020 01:43:02 -0800 (PST)
Subject: Re: [PATCH v12 2/4] uacce: add uacce driver
To: Herbert Xu <herbert@gondor.apana.org.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1579097568-17542-1-git-send-email-zhangfei.gao@linaro.org>
 <1579097568-17542-3-git-send-email-zhangfei.gao@linaro.org>
 <20200210233711.GA1787983@kroah.com>
 <20200213091509.v7ebvtot6rvlpfjt@gondor.apana.org.au>
From: zhangfei <zhangfei.gao@linaro.org>
Message-ID: <19f2e7b7-d3fc-681e-270c-2e8650df1ac8@linaro.org>
Date: Thu, 13 Feb 2020 17:42:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200213091509.v7ebvtot6rvlpfjt@gondor.apana.org.au>
Content-Language: en-US
Cc: jean-philippe <jean-philippe@linaro.org>, dave.jiang@intel.com,
 kenneth-lee-2012@foxmail.com, Arnd Bergmann <arnd@arndb.de>,
 francois.ozog@linaro.org, linux-accelerators@lists.ozlabs.org,
 ilias.apalodimas@linaro.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 grant.likely@arm.com, "haojian . zhuang" <haojian.zhuang@linaro.org>,
 Kenneth Lee <liguozhu@hisilicon.com>, guodong.xu@linaro.org,
 linux-crypto@vger.kernel.org
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

CgpPbiAyMDIwLzIvMTMg5LiL5Y2INToxNSwgSGVyYmVydCBYdSB3cm90ZToKPiBPbiBNb24sIEZl
YiAxMCwgMjAyMCBhdCAwMzozNzoxMVBNIC0wODAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6
Cj4+IExvb2tzIG11Y2ggc2FuZXIgbm93LCB0aGFua3MgZm9yIGFsbCBvZiB0aGUgd29yayBvbiB0
aGlzOgo+Pgo+PiBSZXZpZXdlZC1ieTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZz4KPj4KPj4gT3IgYW0gSSBzdXBwb3NlZCB0byB0YWtlIHRoaXMgaW4gbXkg
dHJlZT8gIElmIHNvLCBJIGNhbiwgYnV0IEkgbmVlZCBhbgo+PiBhY2sgZm9yIHRoZSBjcnlwdG8g
cGFydHMuCj4gSSBjYW4gdGFrZSB0aGlzIHNlcmllcyB0aHJvdWdoIHRoZSBjcnlwdG8gdHJlZSBp
ZiB0aGF0J3MgZmluZSB3aXRoCj4geW91LgoKVGhhbmtzIEhlcmJlcnQKVGhhdCdzIGEgZ29vZCBp
ZGVhLCBvdGhlcndpc2UgdGhlcmUgbWF5IGJlIGJ1aWxkIGlzc3VlIGlmIHRha2VuIHNlcGFyYXRl
bHkuCgpCeSB0aGUgd2F5LCB0aGUgbGF0ZXN0IHYxMyBpcyBvbiB2NS42LXJjMQpodHRwczovL2xr
bWwub3JnL2xrbWwvMjAyMC8yLzExLzU0CgpUaGFua3MKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2lvbW11
