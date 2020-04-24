Return-Path: <SRS0=k0pT=6I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55417C2BA19
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 01:05:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15DB320736
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 01:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YgwZoKxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15DB320736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B6D868869D;
	Fri, 24 Apr 2020 01:05:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3P9X7xqdG+GL; Fri, 24 Apr 2020 01:05:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 191DB88235;
	Fri, 24 Apr 2020 01:05:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD72AC1AE2;
	Fri, 24 Apr 2020 01:05:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16D75C0175
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 01:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 102DE87FDD
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 01:05:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FT91y7cBMLdv for <iommu@lists.linux-foundation.org>;
 Fri, 24 Apr 2020 01:05:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5D8A887FD6
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 01:05:31 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id f8so3129547plt.2
 for <iommu@lists.linux-foundation.org>; Thu, 23 Apr 2020 18:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Rs6XzdVycXZMJAPEZo3YTCEs4EhUkPZAkCoBo6xiYMg=;
 b=YgwZoKxS8G27L4RjO46JkxDCH203d1FNhSIm2uevkHpwM8c3UZJOzvzyHihdDlIDyN
 Sn2CeiyhEqYXa0eGcR4csejRpsQNmD4uOzow5LtwVY4FM4CxcH0P5/aLZNENN3R8DEQS
 v8hAPzsVjk8YIz6wNM0D4kwmw+VTsDyRRIf5vE+FCWY0GKaKe4lbro/oD1nQniEjnr6m
 Cfz/J8YvZJnljHEyqp0KOC3xKAKZ2VpfzBl9FkHX0arqvmzy58ysltrHhEBrCTpDU7cr
 GQpD9DZPvRdmhSROPKw/yqoypEEtQYNYWkuwtHS6OwrRyyIBVcuvk7kW63pBVZuSl+s2
 ilZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Rs6XzdVycXZMJAPEZo3YTCEs4EhUkPZAkCoBo6xiYMg=;
 b=PzWMD3dc8rb69xYJrHsMo8k7BOo8ExVCMNib9OKVnFFgqMj1Ucp9EwnP51WGcSC4y1
 WQsZ4JbazRMDiBOEE9jrf4aNSe/vLZ5TJXJgX2wRxVRph4I+J1NacBH4TZDtJc8od7oQ
 1dHWbLiKnVKwZWpN235FRJ/BFK47b75XgL3nZjBXwnIXNYaymseOJQ71YcWjh//ijE66
 rJqT7+/CQ8D9xG/GhC4eXMOM3uryNQ31RKgcCytyqdxJRARgG5D2pMknrLnsgRbh+bXC
 1u/0KLBE9quGlxK4mZskQTH1uoahZZbrGD3JUi53sbEQlmuBG+GK3PBculzW5uv7ENOu
 XMqg==
X-Gm-Message-State: AGi0PuZUiMGwns7wZQIQtJnJkwD9oOMPzZGyXAJKaOUX1BgqnCSXtawc
 7dwy/dXahx/lMVPOwh/McaOSxw==
X-Google-Smtp-Source: APiQypKgxrpHpazhWERMcePubJjQJuRSz/D7DXz3GvfTQ/P3RYD2VBPLI607a1j+J30OjT9a6GdRjA==
X-Received: by 2002:a17:90a:a50c:: with SMTP id
 a12mr3685127pjq.36.1587690330810; 
 Thu, 23 Apr 2020 18:05:30 -0700 (PDT)
Received: from [10.176.0.202] ([45.135.186.132])
 by smtp.gmail.com with ESMTPSA id g22sm3381547pju.21.2020.04.23.18.05.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Apr 2020 18:05:29 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] uacce: Remove mm_exit() op
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, linux-accelerators@lists.ozlabs.org
References: <20200423125329.782066-1-jean-philippe@linaro.org>
 <20200423125329.782066-2-jean-philippe@linaro.org>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <efb275c8-6005-a661-6387-f2e48dcc2880@linaro.org>
Date: Fri, 24 Apr 2020 09:05:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200423125329.782066-2-jean-philippe@linaro.org>
Content-Language: en-US
Cc: Herbert Xu <herbert@gondor.apana.org.au>, arnd@arndb.de,
 gregkh@linuxfoundation.org, jgg@ziepe.ca
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

CgpPbiAyMDIwLzQvMjMg5LiL5Y2IODo1MywgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOgo+
IFRoZSBtbV9leGl0KCkgb3Agd2lsbCBiZSByZW1vdmVkIGZyb20gdGhlIFNWQSBBUEkuIFdoZW4g
YSBwcm9jZXNzIGRpZXMKPiBhbmQgaXRzIG1tIGdvZXMgYXdheSwgdGhlIElPTU1VIGRyaXZlciB3
b24ndCBub3RpZnkgZGV2aWNlIGRyaXZlcnMKPiBhbnltb3JlLiBEcml2ZXJzIHNob3VsZCBleHBl
Y3QgdG8gaGFuZGxlIGEgbG90IG1vcmUgYWJvcnRlZCBETUEuIE9uIHRoZQo+IHVwc2lkZSwgaXQg
ZG9lcyBncmVhdGx5IHNpbXBsaWZ5IHRoZSBxdWV1ZSBtYW5hZ2VtZW50Lgo+Cj4gVGhlIHVhY2Nl
X21tIHN0cnVjdCwgdGhhdCB0cmFja3MgYWxsIHF1ZXVlcyBib3VuZCB0byBhbiBtbSwgd2FzIG9u
bHkKPiB1c2VkIGJ5IHRoZSBtbV9leGl0KCkgY2FsbGJhY2suIFJlbW92ZSBpdC4KPgo+IFNpZ25l
ZC1vZmYtYnk6IEplYW4tUGhpbGlwcGUgQnJ1Y2tlciA8amVhbi1waGlsaXBwZUBsaW5hcm8ub3Jn
PgpUaGFua3MgSmVhbgpBY2tlZC1ieTogWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbGluYXJv
Lm9yZz4KCj4gLS0tCj4gdjEtPnYyOiBjbGVhciBxLT5oYW5kbGUgYWZ0ZXIgdW5iaW5kCgpUaGFu
a3MKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
