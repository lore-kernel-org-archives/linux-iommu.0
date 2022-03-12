Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B487C433EF
	for <iommu@archiver.kernel.org>; Sat, 12 Mar 2022 18:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9BF8E60ACD;
	Sat, 12 Mar 2022 18:12:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wDdnZWxH-ZvT; Sat, 12 Mar 2022 18:12:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8AFFF607DE;
	Sat, 12 Mar 2022 18:12:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57355C0012;
	Sat, 12 Mar 2022 18:12:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6ACD0C000B
 for <iommu@lists.linux-foundation.org>; Sat, 12 Mar 2022 18:12:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 614C1410C4
 for <iommu@lists.linux-foundation.org>; Sat, 12 Mar 2022 18:12:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BPi3RxbJebKf for <iommu@lists.linux-foundation.org>;
 Sat, 12 Mar 2022 18:12:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 19EBA410C3
 for <iommu@lists.linux-foundation.org>; Sat, 12 Mar 2022 18:12:35 +0000 (UTC)
Received: by mail-lj1-x234.google.com with SMTP id q10so16333054ljc.7
 for <iommu@lists.linux-foundation.org>; Sat, 12 Mar 2022 10:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=k2rzdAvd062YWQZphahXNpHBoTUA0G/kUu5FJsmYidI=;
 b=cLIch6UNGEWBwpXkAfGnrMnkGP8hmmnuf7HiuH+uAu625SU0QmoGlc2SVrOSwdtHHB
 Ow2OyVUaeaCPY96YSOm8M/19K6KTez6AWn/3d/zmgIar9rkof3FPKnm87lO8kwKM2+1b
 3dX/gghLidF9HFV9HA0dXTkHfSUl/emasVYkGBa1cGvsdyxcncX44/2QpeLKqMLtYM/n
 XVvI3R378Ml+kG+Udza0rBX+dQPpqIuyderqiQEZniZbeF54vps152YPilKfdRClGtCi
 +cDeXVjFwu8Q7m3gLbXHxzTrBZXLNfwWgOyNtQU1Fpf00ssSL7uReonjyQonkmPSXM34
 Y7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=k2rzdAvd062YWQZphahXNpHBoTUA0G/kUu5FJsmYidI=;
 b=HHMplSwYcRnOydJ6d/Yrd6/dzmImu/nBuH2MGxeJPLs3lDua+i9gzM9LX2NdFXfFnZ
 M74S0sn8f31PXOBOnWW6BhFPSMKTboALYxB8k/5+x7k2S9a1sZDL1Widx3FoB9YPXX+I
 VcQ0thsAOvK4f9954KP6VfAl0bbtdD0jh7zxhXWofzN+VtFmUIdCMiGhlaFXuiOzSkAp
 gRl592YYbNLnfmhSMM3NPpctDiM9gPHAkZoEDYXalrT8xTQJHhBv9D7Y/7NoPhNm5UJx
 ZWs9eTakZmOSRk1FPjLqNWzl/P6i+GlBqB+VNF9dvJvodDtwIZ+mA86iFkGzT+EYhVlV
 F3Qg==
X-Gm-Message-State: AOAM532nb4VqUvCbJSqiB+NotO3PPa+KwFEG0rbZSHMKyUJ+r4JdyFxa
 i04kRhDxbLLbRI50fw4hViY=
X-Google-Smtp-Source: ABdhPJxKzGvN1o8WcEOhsd6BTrlU/Lny5O/iTIWdGCHtEoNj9ujCnMKIsvOKhUi0uhP9YsrKpfM9og==
X-Received: by 2002:a2e:2d0a:0:b0:248:7c35:28b4 with SMTP id
 t10-20020a2e2d0a000000b002487c3528b4mr8155470ljt.175.1647108753844; 
 Sat, 12 Mar 2022 10:12:33 -0800 (PST)
Received: from [192.168.2.145] (109-252-136-171.dynamic.spd-mgts.ru.
 [109.252.136.171]) by smtp.googlemail.com with ESMTPSA id
 g19-20020a2e3913000000b00247dea5b468sm2571838lja.115.2022.03.12.10.12.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Mar 2022 10:12:33 -0800 (PST)
Message-ID: <45e5f833-b492-30df-a1ed-108e05a2b465@gmail.com>
Date: Sat, 12 Mar 2022 21:12:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 3/9] gpu: host1x: Add context device management code
Content-Language: en-US
To: cyndis@kapsi.fi, thierry.reding@gmail.com, jonathanh@nvidia.com,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
 krzysztof.kozlowski@canonical.com
References: <20220301161455.4037062-1-cyndis@kapsi.fi>
 <20220301161455.4037062-4-cyndis@kapsi.fi>
From: Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220301161455.4037062-4-cyndis@kapsi.fi>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Mikko Perttunen <mperttunen@nvidia.com>,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

MDEuMDMuMjAyMiAxOToxNCwgY3luZGlzQGthcHNpLmZpINC/0LjRiNC10YI6Cj4gKy8qIGhvc3Qx
eCBjb250ZXh0IGRldmljZXMgKi8KPiArCj4gK3N0cnVjdCBob3N0MXhfY29udGV4dCB7Cj4gKwlz
dHJ1Y3QgaG9zdDF4ICpob3N0Owo+ICsKPiArCXJlZmNvdW50X3QgcmVmOwo+ICsJc3RydWN0IHBp
ZCAqb3duZXI7Cj4gKwo+ICsJc3RydWN0IGRldmljZSBkZXY7Cj4gKwl1NjQgZG1hX21hc2s7Cj4g
Kwl1MzIgc3RyZWFtX2lkOwo+ICt9OwoKSSdtIHN0aWxsIG5vdCB2ZXJ5IGhhcHB5IGFib3V0IHRo
ZSAiY29udGV4dCIgbmFtZXMuIEZvciBleGFtcGxlIGhlcmUKaXQncyBvbmx5IGFib3V0IHRoZSAi
bWVtb3J5IGNvbnRleHQiLCB0aGVuIHdoeSBub3QgdG8gbmFtZSBzdHJ1Y3QgYXMKaG9zdDF4X21l
bW9yeV9jb250ZXh0IG9yIGhvc3QxeF9tZW1jdHg/CgpJdCdzIG5vdCBnb29kIHRvIHVzZSBnZW5l
cmljIG5hbWVzIGZvciBhIHNwZWNpYWwgdGhpbmdzLCBpdCBodXJ0cwpyZWFkYWJpbGl0eSBvZiB0
aGUgY29kZS4gSXQncyBpbXBvcnRhbnQgdG8gY2hvb3NlIGdvb2QgbmFtZXMuCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdApp
b21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
