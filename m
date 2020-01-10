Return-Path: <SRS0=ishi=27=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F55CC33C99
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 07:03:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 673742082E
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 07:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGSmQqRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673742082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 13CB986F92;
	Fri, 10 Jan 2020 07:03:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gpD10dt5NEF8; Fri, 10 Jan 2020 07:03:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 772F986E71;
	Fri, 10 Jan 2020 07:03:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C7B9C1796;
	Fri, 10 Jan 2020 07:03:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B4ECC0881
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 07:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7A69586F87
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 07:03:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qSrKHqFHxfAO for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jan 2020 07:03:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 04E2C86E71
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 07:03:39 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id x185so674483pfc.5
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jan 2020 23:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=524ZzQ+ni88Rws2LlNdcnlFyEqdyrbvKeKi49yA8YY4=;
 b=NGSmQqRU5+ICclxQRqDent1NDnfEm2OIeeFdX0tw/ZmF5Ynj0sVDkrXYgo859Seh0M
 J0l0h0MbScEDs2sJRmYMl/Q2HJ9vAiX6odyo6YxZy9mw/XioiCJwEKZ+I1Zo30NGV+ia
 ziky5DZJR/qtVDQrwkd8pjID8fi+W+813nC/nUw8w3rYyGArUeP/iw1vslz/rh0whBTv
 9YIXRZhMWidQzylg7ngeozNKcbUj3M0hEuYMICamx+mNMsw8N5QhTqrpS4gEVk8nz+xx
 PfRK9qHUjXd+VzpCcn5R5QxZgBsCKm7vqH7aWgLY8rvlvHSfalm+nWpsY1TfA2IKaUXg
 yYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=524ZzQ+ni88Rws2LlNdcnlFyEqdyrbvKeKi49yA8YY4=;
 b=WMPHIrw9ms/XJmV4K+YPvs3Sy1PBRAMdh0eDQApuEVVhp42NM9ZAL/hSKbXT/R/NSn
 KtiLdS3XPSd9cFucBUjzEJMvMRkRIspA9mzT7u/j4Sbpb8sZCC/awsAnxhUAiIniEyJX
 4nKCglVTs13qwJitQD1SixUt2ysWZctbGAgg8rsCo2gjq2GbBOklu7pT064SCVROPaRV
 6NJfDr5IXhcdcRSWJOeDfzTHCcSCgyTuK3WjMYBE4+63mK7iGHQsgzQ4210ip30KoRSB
 UPwNwL0+CDe4JbuLFkp4HJZFPacwMG22ejqiIOAWGW5fzh+n32ABGX4isqIRsATKLzh7
 PvUg==
X-Gm-Message-State: APjAAAUtUwsbYvaqSg2qejESe2Gvw7zyCGCRZdvT/lGu/T+xrrnNiC+o
 qE8i/odef+X3drk03r3mQvkwhA==
X-Google-Smtp-Source: APXvYqxRXSHQMAAqNEXryi+da46roEIsUSSy9JeYNiaSYgUd7HGxHp5FztsZ6Vvs+qp/1RXmy6fNQg==
X-Received: by 2002:a62:53c3:: with SMTP id h186mr2378854pfb.118.1578639818515; 
 Thu, 09 Jan 2020 23:03:38 -0800 (PST)
Received: from [10.151.2.174] ([45.135.186.75])
 by smtp.gmail.com with ESMTPSA id a26sm1382558pfo.27.2020.01.09.23.03.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Jan 2020 23:03:37 -0800 (PST)
Subject: Re: [PATCH v10 0/4] Add uacce module for Accelerator
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>
References: <1576465697-27946-1-git-send-email-zhangfei.gao@linaro.org>
 <20200109174952.000051e1@Huawei.com>
From: zhangfei <zhangfei.gao@linaro.org>
Message-ID: <9b87edca-dd4e-3fe2-5acd-11f7381593ed@linaro.org>
Date: Fri, 10 Jan 2020 15:03:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200109174952.000051e1@Huawei.com>
Content-Language: en-US
Cc: jean-philippe <jean-philippe@linaro.org>, Dave Jiang <dave.jiang@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 francois.ozog@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 ilias.apalodimas@linaro.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
 grant.likely@arm.com, "haojian . zhuang" <haojian.zhuang@linaro.org>,
 linux-accelerators@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 guodong.xu@linaro.org, kenneth-lee-2012@foxmail.com
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

CgpPbiAyMDIwLzEvMTAg5LiK5Y2IMTo0OSwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToKPiBPbiBN
b24sIDE2IERlYyAyMDE5IDExOjA4OjEzICswODAwCj4gWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5n
YW9AbGluYXJvLm9yZz4gd3JvdGU6Cj4KPj4gVWFjY2UgKFVuaWZpZWQvVXNlci1zcGFjZS1hY2Nl
c3MtaW50ZW5kZWQgQWNjZWxlcmF0b3IgRnJhbWV3b3JrKSB0YXJnZXRzIHRvCj4+IHByb3ZpZGUg
U2hhcmVkIFZpcnR1YWwgQWRkcmVzc2luZyAoU1ZBKSBiZXR3ZWVuIGFjY2VsZXJhdG9ycyBhbmQg
cHJvY2Vzc2VzLgo+PiBTbyBhY2NlbGVyYXRvciBjYW4gYWNjZXNzIGFueSBkYXRhIHN0cnVjdHVy
ZSBvZiB0aGUgbWFpbiBjcHUuCj4+IFRoaXMgZGlmZmVycyBmcm9tIHRoZSBkYXRhIHNoYXJpbmcg
YmV0d2VlbiBjcHUgYW5kIGlvIGRldmljZSwgd2hpY2ggc2hhcmUKPj4gZGF0YSBjb250ZW50IHJh
dGhlciB0aGFuIGFkZHJlc3MuCj4+IEJlY2F1c2Ugb2YgdW5pZmllZCBhZGRyZXNzLCBoYXJkd2Fy
ZSBhbmQgdXNlciBzcGFjZSBvZiBwcm9jZXNzIGNhbiBzaGFyZQo+PiB0aGUgc2FtZSB2aXJ0dWFs
IGFkZHJlc3MgaW4gdGhlIGNvbW11bmljYXRpb24uCj4+Cj4+IFVhY2NlIGlzIGludGVuZGVkIHRv
IGJlIHVzZWQgd2l0aCBKZWFuIFBoaWxpcHBlIEJydWNrZXIncyBTVkEKPj4gcGF0Y2hzZXRbMV0s
IHdoaWNoIGVuYWJsZXMgSU8gc2lkZSBwYWdlIGZhdWx0IGFuZCBQQVNJRCBzdXBwb3J0Lgo+PiBX
ZSBoYXZlIGtlZXAgdmVyaWZ5aW5nIHdpdGggSmVhbidzIHN2YSBwYXRjaHNldCBbMl0KPj4gV2Ug
YWxzbyBrZWVwIHZlcmlmeWluZyB3aXRoIEVyaWMncyBTTU1VdjMgTmVzdGVkIFN0YWdlIHBhdGNo
ZXMgWzNdCj4gSGkgWmhhbmdmZWkgR2FvLAo+Cj4gSnVzdCB0byBjaGVjayBteSB1bmRlcnN0YW5k
aW5nLi4uCj4KPiBUaGlzIHBhdGNoIHNldCBpcyBub3QgZGVwZW5kZW50IG9uIGVpdGhlciAyIG9y
IDM/Cj4KPiBUbyB1c2UgaXQgb24gb3VyIGhhcmR3YXJlLCB3ZSBuZWVkIDIsIGJ1dCB0aGUgaW50
ZXJmYWNlcyB1c2VkIGFyZSBhbHJlYWR5Cj4gdXBzdHJlYW0sIHNvIHRoaXMgY291bGQgbW92ZSBm
b3J3YXJkcyBpbiBwYXJhbGxlbC4KPgo+ClllcywKcGF0Y2ggMSwgMiBpcyBmb3IgdWFjY2UuCnBh
dGNoIDMsIDQgaXMgYW4gZXhhbXBsZSB1c2luZyB1YWNjZSwgd2hpY2ggaGFwcGVuIHRvIGJlIGNy
eXB0by4KClRoYW5rcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
