Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927EAC433EF
	for <iommu@archiver.kernel.org>; Sat, 19 Feb 2022 17:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C3C681378;
	Sat, 19 Feb 2022 17:52:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uaL5AJL5nv2q; Sat, 19 Feb 2022 17:52:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 06FF380AD5;
	Sat, 19 Feb 2022 17:52:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B19AC0011;
	Sat, 19 Feb 2022 17:52:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D87BC000B
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 17:52:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 09C794018A
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 17:52:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sIrogbLtXZoY for <iommu@lists.linux-foundation.org>;
 Sat, 19 Feb 2022 17:52:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 102DE400B8
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 17:52:03 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id o2so11222174lfd.1
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 09:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=7yVrvBYHyY3QdyCCeyIxr1lH8/vkZhQdSt3EyEVyKOQ=;
 b=Z+Y2PwCGESLzwlh6ekus16SE6okHck1S/aJ/1TVFDFmmxlRMudavC5ID4rfQx3gFCz
 W1MZSPN/4+Fx/RCfC6kTNhwpni007xOVyRHw+z+nuasbJKry9LbwPKoZ2gAhc3KeCFAi
 Qt17+bumSz0PxMvDV537wcEhoN84QExYE8Kopw5GoLiXcISR15yJ//wSPJDa1/Pt+7Z6
 mFGFRf31DM/bSCDE9UYVRiAoXFf8vD7kuzRGxKnCrAWvtERB1NodQvBApniBlxN+wj9k
 a7M/mJpr/nIOUZ5lB98CqvzBtpbpT+fABKX62mm4c+IPyP91fbflRUuDtCxqjSaRiNQ/
 Lm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=7yVrvBYHyY3QdyCCeyIxr1lH8/vkZhQdSt3EyEVyKOQ=;
 b=mkN+59EVuaZqK40+STODG6YBLOI+Jl8alge5BFRNYHAY+XQuhHNwIEiVHNzg1GdsYq
 94L7pYHtvYrBmNNxLf0wfY0eCEKToSW5Qv+y595xgpBnCWo0FlDU77T1enrrO52TqgbE
 2fqGOyhCCI0OK80NvRvc1R7UXlrNabUK9EJrbnl4tmqvPw+EeqsvPTjx95gVMORkRFvu
 Q3VvRAyK3oxBLpt7Z+VLpUahu0mDn8gpsPmnpAzyfOpu0vH2IxsmGeSHjueBMZP9IdhT
 YFlmdelNXt27t3B96aDHpXozVQSSZBa2NTulcW9baNq+FlGEEYVi1wINL5rbGt4C3vw6
 /05Q==
X-Gm-Message-State: AOAM531bh2937pzBwYyuxdvrFNC9UU6pwnJk0Le3EbzczjBsqrazziyh
 09NXN3MfuJcsSeuaUxrh4uQ=
X-Google-Smtp-Source: ABdhPJztgefYS2BdI3meZgbmQg2nNYbVEhFCxZeyVrUB8mQqvT+0gHoAIgPTRqIv1H4Rufh/EzXWng==
X-Received: by 2002:ac2:5b4b:0:b0:43c:795a:25a6 with SMTP id
 i11-20020ac25b4b000000b0043c795a25a6mr9172627lfp.268.1645293121966; 
 Sat, 19 Feb 2022 09:52:01 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru.
 [109.252.138.165])
 by smtp.googlemail.com with ESMTPSA id q8sm630091lfr.181.2022.02.19.09.52.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Feb 2022 09:52:01 -0800 (PST)
Message-ID: <2605a614-0a2c-85ac-576a-048f38f9d366@gmail.com>
Date: Sat, 19 Feb 2022 20:52:00 +0300
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

MTguMDIuMjAyMiAxNDozOSwgTWlra28gUGVydHR1bmVuINC/0LjRiNC10YI6Cj4gKwlmb3IgKGlu
ZGV4ID0gMDsgaW5kZXggPCBjZGwtPmxlbjsgaW5kZXgrKykgewo+ICsJCXN0cnVjdCBpb21tdV9m
d3NwZWMgKmZ3c3BlYzsKPiArCj4gKwkJY3R4ID0gJmNkbC0+ZGV2c1tpbmRleF07Cj4gKwo+ICsJ
CWN0eC0+aG9zdCA9IGhvc3QxeDsKPiArCj4gKwkJZGV2aWNlX2luaXRpYWxpemUoJmN0eC0+ZGV2
KTsKPiArCj4gKwkJY3R4LT5kZXYuZG1hX21hc2sgPSAmY29udGV4dF9kZXZpY2VfZG1hX21hc2s7
Cj4gKwkJY3R4LT5kZXYuY29oZXJlbnRfZG1hX21hc2sgPSBjb250ZXh0X2RldmljZV9kbWFfbWFz
azsKPiArCQlkZXZfc2V0X25hbWUoJmN0eC0+ZGV2LCAiaG9zdDF4LWN0eC4lZCIsIGluZGV4KTsK
PiArCQljdHgtPmRldi5idXMgPSAmaG9zdDF4X2NvbnRleHRfZGV2aWNlX2J1c190eXBlOwoKaG9z
dDF4X2NvbnRleHRfZGV2aWNlX2J1c190eXBlIHdpbGwgYmUgYW4gdW5kZWZpbmVkIHN5bWJvbCBp
ZgpDT05GSUdfVEVHUkFfSE9TVDFYX0NPTlRFWFRfQlVTPW4/IFBsZWFzZSBjb21waWxlIGFuZCB0
ZXN0IGFsbCBjb21iaW5hdGlvbnMuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by9pb21tdQ==
