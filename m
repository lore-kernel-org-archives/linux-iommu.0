Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A099C43217
	for <iommu@archiver.kernel.org>; Tue, 22 Feb 2022 10:46:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E9C160B75;
	Tue, 22 Feb 2022 10:46:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iFiitiUFXJxE; Tue, 22 Feb 2022 10:46:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 13B4260EAC;
	Tue, 22 Feb 2022 10:46:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8C85C001A;
	Tue, 22 Feb 2022 10:46:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B8E3C0011
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 10:46:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 39DFE81A5C
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 10:46:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id edo9sZFL0IdL for <iommu@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 10:46:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 71E1781A58
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 10:46:32 +0000 (UTC)
Received: by mail-lj1-x22d.google.com with SMTP id v22so16934311ljh.7
 for <iommu@lists.linux-foundation.org>; Tue, 22 Feb 2022 02:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=iabqwLRHm/0Z6nOkM33Y0js7aZKJwfXcVsR9drxTBpI=;
 b=Wvvk4dYJGf5Y8/8AlZicv/dhMGLGNFdMJpU3wenpSJZw/ybyjG3nx9inX0NopTAr9b
 hki9SqFotR4DokiJbsxi3yGsFbnL/zXxiDg/fRjfzRxiszEbWkFKpYheubiSHqOaxP34
 rjOvLBDn9kWi79ogs4Zh8W6upcZAtRRWT4N5DEvXeccq1jr0fRCdDH4AhV3jc6YMVzYY
 6IEqUC1xQpeJJXazlibsxRAUbsunJcLJ+Q8OZRSlkEt2s3SOTVvGTqVfVXppSIfJi21t
 hGpypFfvt3zGUuu9KQLV5peGeZ7tki5MqV+SxDeCYQ79bdLGMFynXY4YZv5rFu2cevD6
 iV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=iabqwLRHm/0Z6nOkM33Y0js7aZKJwfXcVsR9drxTBpI=;
 b=42TP5JuV1dNHYdOPUIk+7kO3HqohZpUZrL0u/qhJDjoXnl/r4JNTQRJgC604yv2Vfm
 nkhfCB8PnJgjPaOsMLRZ6uoECNt6VVo6ew+ymBUN7Z05V2hWhb1zeja/1c1dlOfSWTbA
 tsaQEbB7r9MDc5prRLJ6FkPSo+vRLAHULjB53wfc7ljmvBjoFsoG2RI8ji/8RXDBwgUS
 fLZk6QYORtIBQKp4aB4k0ieayRbde98KNhQFlcbe7REd/VbWszCsEWIDK8X71Asc5bYd
 gpxEM+UirtGAmtYWMshQXCVn8cxSJxmo+gB+220c8r5T9jBk+oYtRrTFb6JvqJJyoU1s
 Hfsg==
X-Gm-Message-State: AOAM532ho8y6DO+kqyfPuooSvag8GkKkOEzIMhXeOBtVfTyxNHeZsDHh
 NdY3/JTYKvR0m/oZmvGXrAY=
X-Google-Smtp-Source: ABdhPJwZ1McSWpt8xE8JSzJ7PFSX/UI6DWDglB8xl7blNXCItqUCMFWL3e68OUp80Bgn508refVPUw==
X-Received: by 2002:a2e:980f:0:b0:246:3fb6:816b with SMTP id
 a15-20020a2e980f000000b002463fb6816bmr6085199ljj.242.1645526790359; 
 Tue, 22 Feb 2022 02:46:30 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru.
 [109.252.138.165])
 by smtp.googlemail.com with ESMTPSA id w10sm1599556ljd.101.2022.02.22.02.46.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Feb 2022 02:46:29 -0800 (PST)
Message-ID: <4352fda7-ecb6-4a5e-7d6c-a50537d8eaff@gmail.com>
Date: Tue, 22 Feb 2022 13:46:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 8/9] drm/tegra: vic: Implement get_streamid_offset
Content-Language: en-US
To: Mikko Perttunen <cyndis@kapsi.fi>, Mikko Perttunen
 <mperttunen@nvidia.com>, thierry.reding@gmail.com, jonathanh@nvidia.com,
 joro@8bytes.org, will@kernel.org, robh+dt@kernel.org, robin.murphy@arm.com
References: <20220218113952.3077606-1-mperttunen@nvidia.com>
 <20220218113952.3077606-9-mperttunen@nvidia.com>
 <b1df816b-6838-c435-1a23-5029144e4cfe@gmail.com>
 <7f4e4c47-59f1-1def-36bf-a2ded912f76d@gmail.com>
 <5d1b6e82-2c9d-8388-697f-0d7305a1206f@kapsi.fi>
 <ee648994-b296-2ac4-a676-ddcac463a428@gmail.com>
 <30033f5b-3fd1-22c7-896b-af034a4041df@kapsi.fi>
From: Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <30033f5b-3fd1-22c7-896b-af034a4041df@kapsi.fi>
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

MjIuMDIuMjAyMiAxMToyNywgTWlra28gUGVydHR1bmVuINC/0LjRiNC10YI6Cj4gT24gMi8yMS8y
MiAyMjoxMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiAyMS4wMi4yMDIyIDE0OjQ0LCBNaWtr
byBQZXJ0dHVuZW4g0L/QuNGI0LXRgjoKPj4+IE9uIDIvMTkvMjIgMjA6NTQsIERtaXRyeSBPc2lw
ZW5rbyB3cm90ZToKPj4+PiAxOS4wMi4yMDIyIDIxOjQ5LCBEbWl0cnkgT3NpcGVua28g0L/QuNGI
0LXRgjoKPj4+Pj4gMTguMDIuMjAyMiAxNDozOSwgTWlra28gUGVydHR1bmVuINC/0LjRiNC10YI6
Cj4+Pj4+PiArc3RhdGljIGludCB2aWNfZ2V0X3N0cmVhbWlkX29mZnNldChzdHJ1Y3QgdGVncmFf
ZHJtX2NsaWVudCAqY2xpZW50KQo+Pj4+Pj4gK3sKPj4+Pj4+ICvCoMKgwqAgc3RydWN0IHZpYyAq
dmljID0gdG9fdmljKGNsaWVudCk7Cj4+Pj4+PiArwqDCoMKgIGludCBlcnI7Cj4+Pj4+PiArCj4+
Pj4+PiArwqDCoMKgIGVyciA9IHZpY19sb2FkX2Zpcm13YXJlKHZpYyk7Cj4+Pj4+Cj4+Pj4+IFlv
dSBjYW4ndCBpbnZva2UgdmljX2xvYWRfZmlybXdhcmUoKSB3aGlsZSBSUE0gaXMgc3VzcGVuZGVk
LiBFaXRoZXIKPj4+Pj4gcmVwbGFjZSB0aGlzIHdpdGggUlBNIGdldC9wdXQgb3IgZG8gc29tZXRo
aW5nIGVsc2UuCj4+Pgo+Pj4gV2h5IG5vdCwgSSdtIG5vdCBzZWVpbmcgYW55IEhXIGFjY2Vzc2Vz
IGluIHZpY19sb2FkX2Zpcm13YXJlPyBBbHRob3VnaAo+Pj4gaXQgbG9va3MgbGlrZSBpdCBtaWdo
dCByYWNlIHdpdGggdGhlIHZpY19sb2FkX2Zpcm13YXJlIGNhbGwgaW4KPj4+IHZpY19ydW50aW1l
X3Jlc3VtZSB3aGljaCBwcm9iYWJseSBuZWVkcyB0byBiZSBmaXhlZC4KPj4KPj4gSXQgd2FzIG5v
dCBjbGVhciBmcm9tIHRoZSBmdW5jdGlvbidzIG5hbWUgdGhhdCBoL3cgaXMgdW50b3VjaGVkLCBJ
IHJlYWQKPj4gImxvYWQiIGFzICJ1cGxvYWQiIGFuZCB0aGVuIGxvb2tlZCBhdCB2aWNfcnVudGlt
ZV9yZXN1bWUoKS4gSSdkIHJlbmFtZQo+PiB2aWNfbG9hZF9maXJtd2FyZSgpIHRvIHZpY19wcmVw
YXJlX2Zpcm13YXJlX2ltYWdlKCkuCj4+Cj4+IEFuZCB5ZXMsIHRlY2huaWNhbGx5IGxvY2sgaXMg
bmVlZGVkLgo+IAo+IFllcCwgSSdsbCBjb25zaWRlciByZW5hbWluZyBpdC4KCkxvb2tpbmcgYXQg
dGhpcyBhbGwgYWdhaW4sIEknZCBzdWdnZXN0IHRvIGNoYW5nZToKCmludCBnZXRfc3RyZWFtaWRf
b2Zmc2V0KGNsaWVudCkKCnRvOgoKaW50IGdldF9zdHJlYW1pZF9vZmZzZXQoY2xpZW50LCAqb2Zm
c2V0KQoKYW5kIGJhaWwgb3V0IGlmIGdldF9zdHJlYW1pZF9vZmZzZXQoKSByZXR1cm5zIGVycm9y
LiBJdCdzIG5ldmVyIG9rYXkgdG8KaWdub3JlIGVycm9ycy4KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2lvbW11
