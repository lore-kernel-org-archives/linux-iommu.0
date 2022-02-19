Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B8CC433EF
	for <iommu@archiver.kernel.org>; Sat, 19 Feb 2022 18:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1D656072A;
	Sat, 19 Feb 2022 18:35:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GeXcYXMt8m0q; Sat, 19 Feb 2022 18:35:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B7FE160640;
	Sat, 19 Feb 2022 18:35:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D2BAC0011;
	Sat, 19 Feb 2022 18:35:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D45BC000B
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 18:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7B5AA408F1
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 18:35:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pRG3gej2iNk3 for <iommu@lists.linux-foundation.org>;
 Sat, 19 Feb 2022 18:35:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CB8B5408F0
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 18:35:22 +0000 (UTC)
Received: by mail-lj1-x231.google.com with SMTP id o6so8865151ljp.3
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 10:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=ihAhYAdeg+5mNGGybXtL07Go2hn89yUQuHza/hGj/wQ=;
 b=CKbEo/EfSh655da36ya0jrhiGmnzQqTJlKVP0gefuCExsV+Ab7Ta4cauO8X8eA3OWK
 TEZrfeFlxRC+gQEgaRmPQeXwLBjjzfgOYxrodtJQGs+efxIkqMPTUKC4v9B7eVm7qKYl
 YGUfTC6sdtKsKCnDAFUKWJTjZ9s2Zr79iREHv35eU1e/w4U8VDM29SYxf88A+zdYNJs0
 9hAbRMheWeo4Hmth/m1GzpzOmPFDZ5rP+lCPG8lUufpRM2Alh00ttY9Ml9cgAXiicfP6
 HYkiHJhRMbJTXV+hdEPibOskEipA8014nW1jPmS00i/Qqz9eCUw8Pc36FwSTGZ0Y0L6F
 xTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=ihAhYAdeg+5mNGGybXtL07Go2hn89yUQuHza/hGj/wQ=;
 b=SHnRgNiLW2pGZhzHlUK8QMrOFh9YBJ4ZDovfyBQOpFI5Ry+bbUKcY1ItsXgfx7OHPm
 qycgziaRBdPbo4MSNxp3dg/zzIRhF0ICybOBHacEAD1Ol0tK39JPu1zB3QLeT2v5aDVD
 r4FV226vdQs6yykcpTTdeUGxA6qasVxTI+1WEhdxdsUopqbCZUuifj3Ky3CLsr5Ibm7C
 HLKsFl8rs+AYYUBHd/9w588dwW9vGQMkQ7zdozFc6lIK7TFAISjMhVoOW/zqNBJSg4SP
 Fg+XIr5v8e6/dCsPSXBuCfsPyPkFh5nTHsf31CeS9tviXB/mwzn86Fq+NbMw3h6ZgtU/
 UbOg==
X-Gm-Message-State: AOAM53161osBNuNpcu8ExkNWrzUrKE3ANAkNhMHZ3wrJQNpnigQyoPug
 PopUufrRqUj1i2ojwszRzoc=
X-Google-Smtp-Source: ABdhPJyUuey/Cp/BTWCj1MjuWX+PNTm6NcAPr+wmv4r6uS40/QsJrxTXnPwEO8K6bkDeKyB/mQeKDw==
X-Received: by 2002:a05:651c:201b:b0:246:34b5:155e with SMTP id
 s27-20020a05651c201b00b0024634b5155emr1600949ljo.273.1645295720866; 
 Sat, 19 Feb 2022 10:35:20 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru.
 [109.252.138.165])
 by smtp.googlemail.com with ESMTPSA id j11sm642315lfm.40.2022.02.19.10.35.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Feb 2022 10:35:20 -0800 (PST)
Message-ID: <2b4dd244-f918-4d26-2322-00a0bb226ccf@gmail.com>
Date: Sat, 19 Feb 2022 21:35:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 9/9] drm/tegra: Support context isolation
Content-Language: en-US
To: Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
 jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
 robin.murphy@arm.com
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-10-mperttunen@nvidia.com>
From: Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220218113952.3077606-10-mperttunen@nvidia.com>
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

MTguMDIuMjAyMiAxNDozOSwgTWlra28gUGVydHR1bmVuINC/0LjRiNC10YI6Cj4gKwlpZiAoY29u
dGV4dC0+bWVtb3J5X2NvbnRleHQgJiYgY29udGV4dC0+Y2xpZW50LT5vcHMtPmdldF9zdHJlYW1p
ZF9vZmZzZXQpIHsKICAgICAgICAgICAgXl5eCj4gKwkJaW50IG9mZnNldCA9IGNvbnRleHQtPmNs
aWVudC0+b3BzLT5nZXRfc3RyZWFtaWRfb2Zmc2V0KGNvbnRleHQtPmNsaWVudCk7Cj4gKwo+ICsJ
CWlmIChvZmZzZXQgPj0gMCkgewo+ICsJCQlqb2ItPmNvbnRleHQgPSBjb250ZXh0LT5tZW1vcnlf
Y29udGV4dDsKPiArCQkJam9iLT5lbmdpbmVfc3RyZWFtaWRfb2Zmc2V0ID0gb2Zmc2V0Owo+ICsJ
CQlob3N0MXhfY29udGV4dF9nZXQoam9iLT5jb250ZXh0KTsKPiArCQl9CgpZb3Ugc2hvdWxkIGJ1
bXAgcmVmY291bnQgdW5jb25kaXRpb25hbGx5IG9yIHlvdSdsbCBnZXQgcmVmY250IHVuZGVyZmxv
dwpvbiBwdXQsIHdoZW4gb2Zmc2V0IDwgMC4KCj4gKwl9Cj4gKwo+ICAJLyoKPiAgCSAqIGpvYl9k
YXRhIGlzIG5vdyBwYXJ0IG9mIGpvYiByZWZlcmVuY2UgY291bnRpbmcsIHNvIGRvbid0IHJlbGVh
c2UKPiAgCSAqIGl0IGZyb20gaGVyZS4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3Rl
Z3JhL3VhcGkuYyBiL2RyaXZlcnMvZ3B1L2RybS90ZWdyYS91YXBpLmMKPiBpbmRleCA5YWI5MTc5
ZDIwMjYuLmJlMzNkYTU0ZDEyYyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vdGVncmEv
dWFwaS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3RlZ3JhL3VhcGkuYwo+IEBAIC0zMyw2ICsz
Myw5IEBAIHN0YXRpYyB2b2lkIHRlZ3JhX2RybV9jaGFubmVsX2NvbnRleHRfY2xvc2Uoc3RydWN0
IHRlZ3JhX2RybV9jb250ZXh0ICpjb250ZXh0KQo+ICAJc3RydWN0IHRlZ3JhX2RybV9tYXBwaW5n
ICptYXBwaW5nOwo+ICAJdW5zaWduZWQgbG9uZyBpZDsKPiAgCj4gKwlpZiAoY29udGV4dC0+bWVt
b3J5X2NvbnRleHQpCj4gKwkJaG9zdDF4X2NvbnRleHRfcHV0KGNvbnRleHQtPm1lbW9yeV9jb250
ZXh0KTsKClRoZSAiaWYgKGNvbnRleHQtPm1lbW9yeV9jb250ZXh0ICYmCmNvbnRleHQtPmNsaWVu
dC0+b3BzLT5nZXRfc3RyZWFtaWRfb2Zmc2V0KSIgYWJvdmUgZG9lc24ndCBtYXRjaCB0aGUgImlm
Cihjb250ZXh0LT5tZW1vcnlfY29udGV4dCkiLiBZb3UnbGwgZ2V0IHJlZmNvdW50IHVuZGVyZmxv
dy4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUg
bWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
