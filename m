Return-Path: <SRS0=ishi=27=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666FCC33C99
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 07:15:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E4442080D
	for <iommu@archiver.kernel.org>; Fri, 10 Jan 2020 07:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AmGIEKHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4442080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 0431320023;
	Fri, 10 Jan 2020 07:15:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wqLgMuAUVC4L; Fri, 10 Jan 2020 07:15:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 156AC20016;
	Fri, 10 Jan 2020 07:15:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 077A3C1D7D;
	Fri, 10 Jan 2020 07:15:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D1DCC0881
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 07:15:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 567C686AAC
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 07:15:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YkPWO68Cnnyt for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jan 2020 07:15:28 +0000 (UTC)
X-Greylist: delayed 00:08:07 by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1D5A686AAA
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jan 2020 07:15:28 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id n59so606355pjb.1
 for <iommu@lists.linux-foundation.org>; Thu, 09 Jan 2020 23:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=M/y3Ml3cM/VSoJud1Dw7FXrO1acMY+sKEerO9outbBk=;
 b=AmGIEKHX7/ltZPW8KBppPh4dfNgAw9BawReONfu20SdOsEMncM7QmHQ/DgfwDnmv8T
 21IGIPGILhSA7JnW3FoEIgT4DYGLgTZWZ1IgT0UNnkSecFHfuf+XkuOKLuTKXUIZpMSW
 oZ/qPcKd9Hnl6huv7035dakRp5WDhXPAbrr8JERWj/eZFYO7UQslkIXRFmZpVlEJcFyg
 lekKzu3LWCNQl4rxLeOawb8CmQTU0MELvaG1Nz7V9uX9L7UXTTXz/37cCAfTZ/CdjQV3
 SoubjbvyPfUl5rmF5IblznHxKkK3UgeseKeDecNWC44R+Qu6A//67AV1VnVdSbZI1CrM
 woAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=M/y3Ml3cM/VSoJud1Dw7FXrO1acMY+sKEerO9outbBk=;
 b=RGkQ210zcgZRAiWqX+CGSMf2pk02tx+JC5dFQhw5RgcMqIA96NCwUdggdNswL/Bit1
 OB3jH1pZSP9gcied/P1I4BThq3Yg81uu0+XQUWjax5fqxcUV3nhTK6fjDLNzTcpR9oTk
 ON//OR7BpIZZzl0vx3EIn49bgCbAhzFEQjG3JpnxOm3UJS0CBQk0Iysfl1aqRZvskyZP
 vEJgxT3QPGB7ZsuNJRBqiMHgNtLiUGe33C10QY5LLYnd4ov+w8GYW1TsZKK+JLLedBqz
 ND+toSRJwXvEuYe8/Tg9UITyMBj6fx5BljdGVzoGwzCJBKo3yxLtMZbhHc4zRHeb76vc
 Txuw==
X-Gm-Message-State: APjAAAWTtl5U5gYhJuZi+ym9SxZ/k6HtTfs6M7F4OdntYRcYN/y714/K
 Y9emB2eeu562EN0Wgd7hkbveRE0ZDZ8=
X-Google-Smtp-Source: APXvYqyQSw6X8cyO2gBQIiXxpRCvLX2QZNn/mPymYICp5ZQha+ZzrZ0O7cBocngIOaOdKKOTZmMvxw==
X-Received: by 2002:a17:902:8601:: with SMTP id
 f1mr2473221plo.289.1578640040800; 
 Thu, 09 Jan 2020 23:07:20 -0800 (PST)
Received: from [10.151.2.174] ([45.135.186.75])
 by smtp.gmail.com with ESMTPSA id l14sm1147746pgt.42.2020.01.09.23.07.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Jan 2020 23:07:20 -0800 (PST)
Subject: Re: [PATCH v10 4/4] crypto: hisilicon - register zip engine to uacce
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <1576465697-27946-1-git-send-email-zhangfei.gao@linaro.org>
 <1576465697-27946-5-git-send-email-zhangfei.gao@linaro.org>
 <20200109174859.00004b7b@Huawei.com>
From: zhangfei <zhangfei.gao@linaro.org>
Message-ID: <8d35168e-ff68-1bb9-20e1-6bbac5afde00@linaro.org>
Date: Fri, 10 Jan 2020 15:07:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200109174859.00004b7b@Huawei.com>
Content-Language: en-US
Cc: jean-philippe <jean-philippe@linaro.org>,
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

CgpPbiAyMDIwLzEvMTAg5LiK5Y2IMTo0OCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToKPiBPbiBN
b24sIDE2IERlYyAyMDE5IDExOjA4OjE3ICswODAwCj4gWmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5n
YW9AbGluYXJvLm9yZz4gd3JvdGU6Cj4KPj4gUmVnaXN0ZXIgcW0gdG8gdWFjY2UgZnJhbWV3b3Jr
IGZvciB1c2VyIGNyeXB0byBkcml2ZXIKPj4KPj4gU2lnbmVkLW9mZi1ieTogWmhhbmdmZWkgR2Fv
IDx6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4KPj4gU2lnbmVkLW9mZi1ieTogWmhvdSBXYW5nIDx3
YW5nemhvdTFAaGlzaWxpY29uLmNvbT4KPiBWZXJ5IG5pY2UgdG8gc2VlIGhvdyBtaW5pbWFsIHRo
ZSBjaGFuZ2VzIGFyZS4KPgo+IFdoaWxzdCB1YWNjZSBpbiBnZW5lcmFsIGlzbid0IGNyeXB0byBz
cGVjaWZpYywgYXMgd2UgYXJlIGxvb2tpbmcKPiBhdCBjaGFuZ2VzIGluIGEgY3J5cHRvIGRyaXZl
ciwgdGhpcyB3aWxsIG5lZWQgYSBjcnlwdG8gQWNrLgo+Cj4gSGVyYmVydCwgdGhpcyBpcyBhYm91
dCBhcyBub24gaW52YXNpdmUgYXMgdGhpbmdzIGNhbiBnZXQgYW5kCj4gcHJvdmlkZSBhIHVzZXIg
c3BhY2Ugc2hhcmVkIHZpcnR1YWwgYWRkcmVzc2luZyBiYXNlZCBpbnRlcmZhY2UuCj4gV2hhdCBk
byB5b3UgdGhpbms/Cj4KPiAgRnJvbSBteSBzaWRlLCBmb3Igd2hhdCBpdCdzIHdvcnRoLi4uCj4K
PiBSZXZpZXdlZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWku
Y29tPgoKVGhhbmtzIEpvbmF0aGFuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
