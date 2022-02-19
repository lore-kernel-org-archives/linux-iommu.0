Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DA0C433F5
	for <iommu@archiver.kernel.org>; Sat, 19 Feb 2022 18:15:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EB6E607A8;
	Sat, 19 Feb 2022 18:15:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1FImqCnsRXES; Sat, 19 Feb 2022 18:15:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6FEEE605C9;
	Sat, 19 Feb 2022 18:15:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B1CBC0011;
	Sat, 19 Feb 2022 18:15:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45279C000B
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 18:15:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3299181B9D
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 18:15:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yKW0HxciUIYm for <iommu@lists.linux-foundation.org>;
 Sat, 19 Feb 2022 18:15:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B0B781AAD
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 18:15:45 +0000 (UTC)
Received: by mail-lf1-x132.google.com with SMTP id g39so11200450lfv.10
 for <iommu@lists.linux-foundation.org>; Sat, 19 Feb 2022 10:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language
 :from:to:cc:references:in-reply-to:content-transfer-encoding;
 bh=ZCklAq/Hx2JD+s8iRJLRBAzKBHd1Vzm6GJgE7/9rJMc=;
 b=UYwoW4i1T7TbzJAmNBBE/HsET4YSXMQnecavrbyKf7inSJeH4v/AfLKQ8XpquPHPFX
 iHWiMhWE8hnIwE5wwQ3x0sdr0DvGHneRSwv0U2sPFqcr7o2DoUyEq7lJM/bZLipvNcMC
 FGPUSRotuOyEZfkkLmM8T8ov0xh8zYlkKpiKNlY/bpuf2avLCS8tbvakdIc8fZiIcZAl
 uXtLVd8pJH3TJ8H9fpqUO8MzYZDNfYOJ12TTEqjdLsIjHcXOCObWpLBMGuA3JGPAAkIy
 B9O/fZAgXJHykF3mbMeYmOwvr5MNeDygsQx+NDu5kT8ZAWAalmLWUf9u70TYiNCsahas
 38ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=ZCklAq/Hx2JD+s8iRJLRBAzKBHd1Vzm6GJgE7/9rJMc=;
 b=AXYPYh/lOO/a+l+4/frSpVEvm0f6bhOb2Yd9yHgGYo5vMQguBWDrxouGPiSMNgIczg
 g3+Er58b7fRQI10J0tt+qfZjGLS2aNe1Ca0zRQkIAGlcNER8g8oa9/JnY3tgaG64tnDA
 gsC9hieZ8Vo4twhscmUbpJreBhrL2m2/UGHPRRV+O3v+g9d6xgnPod4T0MSnbHWGo4Lt
 SOrD/tz29sCcdmRw3ONZUke0RWNdA5PH0wMCWb/UUJvHopOyPT1DA8hEQ9itUgqA1BkE
 xgrkCHkzB3krN/57duJkzjFxG7LHjyMShFliSYS6UYkcGrX1lV5DUxR8BrkqLec06ltu
 bcHA==
X-Gm-Message-State: AOAM532SnYP4ZjI1Zo7oP9lNJlaQEhlMY2MgXt/LYxS4kHscGg6hUxd9
 XUBQn8BFSIYKyX/4dU7T+YU=
X-Google-Smtp-Source: ABdhPJwJdZ0Gd/bbMF0s0unbw8e1WaovO3J5g4uv+x1CAXGO8sdtzQ4dLL+prgBxwbaaJyAXR9g9RQ==
X-Received: by 2002:a05:6512:548:b0:438:a549:d499 with SMTP id
 h8-20020a056512054800b00438a549d499mr9082717lfl.326.1645294543281; 
 Sat, 19 Feb 2022 10:15:43 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru.
 [109.252.138.165])
 by smtp.googlemail.com with ESMTPSA id v18sm729633ljn.78.2022.02.19.10.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Feb 2022 10:15:42 -0800 (PST)
Message-ID: <50838e8c-8121-d6fb-d693-031739829157@gmail.com>
Date: Sat, 19 Feb 2022 21:15:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/9] gpu: host1x: Add context bus
Content-Language: en-US
From: Dmitry Osipenko <digetx@gmail.com>
To: Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com,
 jonathanh@nvidia.com, joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
 robin.murphy@arm.com
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-3-mperttunen@nvidia.com>
 <1c97bbb5-ba0b-742c-2a21-8abf195b9e6d@gmail.com>
In-Reply-To: <1c97bbb5-ba0b-742c-2a21-8abf195b9e6d@gmail.com>
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

MTkuMDIuMjAyMiAyMDo1NCwgRG1pdHJ5IE9zaXBlbmtvINC/0LjRiNC10YI6Cj4gMTguMDIuMjAy
MiAxNDozOSwgTWlra28gUGVydHR1bmVuINC/0LjRiNC10YI6Cj4+ICtjb25maWcgVEVHUkFfSE9T
VDFYX0NPTlRFWFRfQlVTCj4+ICsJYm9vbAo+PiArCj4+ICBjb25maWcgVEVHUkFfSE9TVDFYCj4+
ICAJdHJpc3RhdGUgIk5WSURJQSBUZWdyYSBob3N0MXggZHJpdmVyIgo+PiAgCWRlcGVuZHMgb24g
QVJDSF9URUdSQSB8fCAoQVJNICYmIENPTVBJTEVfVEVTVCkKPj4gIAlzZWxlY3QgRE1BX1NIQVJF
RF9CVUZGRVIKPj4gKwlzZWxlY3QgVEVHUkFfSE9TVDFYX0NPTlRFWFRfQlVTCj4gCj4gV2hhdCBp
cyB0aGUgcG9pbnQgb2YgVEVHUkFfSE9TVDFYX0NPTlRFWFRfQlVTIGlmIGl0J3Mgc2VsZWN0ZWQK
PiB1bmNvbmRpdGlvbmFsbHk/CgpJIHNlZSBub3cgdGhhdCBpdCdzIHVzZWQgYnkgYXJtLXNtbXUu
Yywgc2hvdWxkIGJlIG9rYXkgdGhlbi4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11
