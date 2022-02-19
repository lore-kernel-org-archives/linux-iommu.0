Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADC2C4332F
	for <iommu@archiver.kernel.org>; Sat, 19 Feb 2022 17:48:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75BC840293;
	Sat, 19 Feb 2022 17:48:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wfCD5WlqhhgJ; Sat, 19 Feb 2022 17:48:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 56D2D40201;
	Sat, 19 Feb 2022 17:48:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0A68C0011;
	Sat, 19 Feb 2022 17:48:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 41374C000B
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 17:48:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D0DF81ADE
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 17:48:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0P8-1VntgIce for <iommu@lists.linux-foundation.org>;
 Sat, 19 Feb 2022 17:48:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6691881AC1
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 17:48:05 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id t14so8736510ljh.8
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 09:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=WRNvBC6o9UGsbku3xFPijsy2+ZDFIPtWNh5a7I/Btf8=;
 b=TGbo6yCdYGD93/pxAGhyvvLgjH8XJVMuefXHswz4bP1zr+75mmibPV0fnY76r5UpNU
 y0muNB1nQVsn/u7CtcDcB6RX/RJ3c+ZtiNjOyLJbmyuqCq36ediJN4rJr0WglLPwfD3u
 xEDJnMgsUsVL3uy/LXM2l1UIEPzsVKUFv6g7mSj0EaUYUJnUJe4nGbrQpoT4CFjuAFuq
 Q06Y3/xx9wCBw5cmlkzdvR2NUyZph6PXeR4PQsmrZ8DY/0p3bYXb+rs6HwTFPuLAhmUy
 pGMReD+zLCz2keV7tSi3Vu4OZPeZnPvBevY2uOSjVOjm9Vw/wP9KdGBrxBocI8+4jF0y
 ANXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=WRNvBC6o9UGsbku3xFPijsy2+ZDFIPtWNh5a7I/Btf8=;
 b=YqihXeX/dKrvtn02tZ5BZ3dC0cJqrdqbo2LfKybICJPQ3qd5Ozwnla8E8ixyAn2lp7
 WnxrVum19oN2BIoZCkO8+W9hhZ+eGC8+wTTvobiAt863FeKCr6IdLxOdUIDG31i7qUyv
 QsCfNhYgNGhKfIA5IGNNyAug9k56HtGjfijz213aUExKX8h3TIQPkMdI0yghPTow2ENJ
 BvVKDlx+Uhfetn8K2x5AQHbuMiBUyZQnlY6L+UhjAV7y5I7AJVplmL3FOJwbLY7LY2gA
 i6cCA1eLJZYTR0nz5AYYJT1rbsJGDfI1IkE+WEDArMRZ+vIpxdtIFJVI5PnE/BnJskVA
 7G/A==
X-Gm-Message-State: AOAM533elzb0B0XD2eVlpt9fnuXKdeNZTWI2EoWT5tfRkRF3xi4o3zXB
 FE/PFcZIZftX5acNxCNNc4k=
X-Google-Smtp-Source: ABdhPJz/BRt4yZ6Y5LNb+KZh4UnLJk9a9nacbUYT258c5HxaK4pyq7Kl19rqtEU4LLu69ggLTlSMMQ==
X-Received: by 2002:a2e:8682:0:b0:246:2c86:8d19 with SMTP id
 l2-20020a2e8682000000b002462c868d19mr3745142lji.329.1645292883313; 
 Sat, 19 Feb 2022 09:48:03 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru.
 [109.252.138.165])
 by smtp.googlemail.com with ESMTPSA id q8sm624249lfo.220.2022.02.19.09.48.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Feb 2022 09:48:02 -0800 (PST)
Message-ID: <149d4794-90fd-cde3-9d59-39e6488db679@gmail.com>
Date: Sat, 19 Feb 2022 20:48:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 3/9] gpu: host1x: Add context device management code
Content-Language: en-US
To: Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
 jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
 robin.murphy@arm.com
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-4-mperttunen@nvidia.com>
From: Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220218113952.3077606-4-mperttunen@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

MTguMDIuMjAyMiAxNDozOSwgTWlra28gUGVydHR1bmVuINC/0LjRiNC10YI6Ci4uLgo+ICsvKgo+
ICsgKiBEdWUgdG8gYW4gaXNzdWUgd2l0aCBUMTk0IE5WRU5DLCBvbmx5IDM4IGJpdHMgY2FuIGJl
IHVzZWQuCj4gKyAqIEFueXdheSwgMjU2R2lCIG9mIElPVkEgb3VnaHQgdG8gYmUgZW5vdWdoIGZv
ciBhbnlvbmUuCj4gKyAqLwo+ICtzdGF0aWMgZG1hX2FkZHJfdCBjb250ZXh0X2RldmljZV9kbWFf
bWFzayA9IERNQV9CSVRfTUFTSygzOCk7CgpzL2RtYV9hZGRyX3QvdTY0LyA/IEFwcGFyZW50bHkg
eW91IHNob3VsZCBnZXQgY29tcGlsYXRpb24gd2FybmluZyBvbiBBUk0zMi4KCmh0dHBzOi8vZWxp
eGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjE3LXJjNC9zb3VyY2UvaW5jbHVkZS9saW51eC9kZXZp
Y2UuaCNMNTI0Cgo+ICtpbnQgaG9zdDF4X2NvbnRleHRfbGlzdF9pbml0KHN0cnVjdCBob3N0MXgg
Kmhvc3QxeCkKPiArewo+ICsJc3RydWN0IGhvc3QxeF9jb250ZXh0X2xpc3QgKmNkbCA9ICZob3N0
MXgtPmNvbnRleHRfbGlzdDsKPiArCXN0cnVjdCBob3N0MXhfY29udGV4dCAqY3R4Owo+ICsJc3Ry
dWN0IGRldmljZV9ub2RlICpub2RlOwo+ICsJaW50IGluZGV4OwoKTml0cGljazogdW5zaWduZWQg
aW50CgouLi4KPiArZGVsX2RldmljZXM6Cj4gKwl3aGlsZSAoLS1pbmRleCA+PSAwKQoKTml0cGlj
azogd2hpbGUgKGluZGV4LS0pCgouLi4KPiArdm9pZCBob3N0MXhfY29udGV4dF9saXN0X2ZyZWUo
c3RydWN0IGhvc3QxeF9jb250ZXh0X2xpc3QgKmNkbCkKPiArewo+ICsJaW50IGk7CgpOaXRwaWNr
OiB1bnNpZ25lZCBpbnQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21t
dQ==
