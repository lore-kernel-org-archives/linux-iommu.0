Return-Path: <SRS0=DOhO=I7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C24C433B4
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 14:41:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00EBB6115A
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 14:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00EBB6115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCEE4414F8;
	Fri,  2 Apr 2021 14:41:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dk8DIxaUgOLt; Fri,  2 Apr 2021 14:41:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8057A414EF;
	Fri,  2 Apr 2021 14:41:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61F50C000B;
	Fri,  2 Apr 2021 14:41:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 862DFC000A
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 14:41:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 747D484C86
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 14:41:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kwcyLN4ZUXqC for <iommu@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 14:41:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4D67A84C84
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 14:41:30 +0000 (UTC)
Received: by mail-lf1-x132.google.com with SMTP id v15so7888569lfq.5
 for <iommu@lists.linux-foundation.org>; Fri, 02 Apr 2021 07:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IsX2fSpKSdiwRPQlQlIkNhzwSN2iZpEukx+GE8vH9qg=;
 b=fFDfjIFUquAmZhBi79ZzBpPk8+pSX5NyVymkZyitmoi8HBcBpJOZk6E0VXmiwNT24h
 1I2ySRqqaoLzP96y6aDYdBYayiybVzEmPuYuQWr4UyKWtwzfUTt6q58ekkwqJ6S1Tu54
 FdWi856BHZtiMeNf9djvldoC41p1vhRHr115ksgkBOTI6aW+ade4OTNp10viyhYyyWh6
 gVe57qpwV0m5wEUH8+CsHWXpZZ3pWazL9nmkZ70HMERVlIRFpGyDEXBPmf8dXC5r0wmX
 ixrIMy95017vGsprcoRWBrHgbedvXjdqZHkqdAaA2+rbLd/2obfXgHGouQQDbQnWJwOj
 PZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IsX2fSpKSdiwRPQlQlIkNhzwSN2iZpEukx+GE8vH9qg=;
 b=AUeMn7aHdnHt8tqahxtoxanGyyJfc+YV3MJjAdPIa38wbK8HwMufE++x6BiFrzYPnI
 QBLttqYGfJ3qZkczj0lfd836c5YfcsJH7/ARY9zpAXl4BA+uQb1rD+OkiI6WVnlnFfxQ
 66h5yQY5qesQj7ZrcmGTU7XibYIIggNUH7V/x4Y/vrMt8CEaHmuG6s6lAGFi2V2lFj9G
 3d0u6TOh4D4DJQ7MpMM4FPjQNUvVH+6nwuzekTu5k8Y0JiYrNECTIyW0PmiCdEUUhyj7
 BpDXRT3IdmRcEyEyFdVfQenfah9dGT0Ar/5Sj7Y231vrHzuE/I7xgKLJi4Ok62ZyxOUI
 XVzg==
X-Gm-Message-State: AOAM531top7M6DjEweU5bCRpScXIsMudwilcK6jN/ePxotMaalROqMAB
 Y1aMAXJrPMsCs+dmARasGAE=
X-Google-Smtp-Source: ABdhPJwwoUZvVSq/hePy5G963Ex3XoRDx03nWyTsTGIxWHYwZG/Fs5XTPo/9Yv99F31iN3SgR4Kx/w==
X-Received: by 2002:a19:5008:: with SMTP id e8mr8987591lfb.571.1617374488127; 
 Fri, 02 Apr 2021 07:41:28 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-85.dynamic.spd-mgts.ru.
 [109.252.193.85])
 by smtp.googlemail.com with ESMTPSA id x19sm878929lfr.198.2021.04.02.07.41.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Apr 2021 07:41:27 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] iommu/tegra-smmu: Revert workaround that was
 needed for Nyan Big Chromebook
To: Nicolin Chen <nicoleotsuka@gmail.com>, guillaume.tucker@collabora.com
References: <20210328233256.20494-1-digetx@gmail.com>
 <20210328233256.20494-2-digetx@gmail.com>
 <20210401085549.GA31146@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <50a7e4c7-0e72-534a-a317-366e455213c1@gmail.com>
Date: Fri, 2 Apr 2021 17:40:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210401085549.GA31146@Asurada-Nvidia>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 Will Deacon <will@kernel.org>
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

MDEuMDQuMjAyMSAxMTo1NSwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gT24gTW9uLCBNYXIg
MjksIDIwMjEgYXQgMDI6MzI6NTZBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtvIHdyb3RlOgo+PiBU
aGUgcHJldmlvdXMgY29tbWl0IGZpeGVzIHByb2JsZW0gd2hlcmUgZGlzcGxheSBjbGllbnQgd2Fz
IGF0dGFjaGluZyB0b28KPj4gZWFybHkgdG8gSU9NTVUgZHVyaW5nIGtlcm5lbCBib290IGluIGEg
bXVsdGktcGxhdGZvcm0ga2VybmVsIGNvbmZpZ3VyYXRpb24KPj4gd2hpY2ggZW5hYmxlcyBDT05G
SUdfQVJNX0RNQV9VU0VfSU9NTVU9eS4gVGhlIHdvcmthcm91bmQgdGhhdCBoZWxwZWQgdG8KPj4g
ZGVmZXIgdGhlIElPTU1VIGF0dGFjaG1lbnQgZm9yIE55YW4gQmlnIENocm9tZWJvb2sgaXNuJ3Qg
bmVlZGVkIGFueW1vcmUsCj4+IHJldmVydCBpdC4KPiAKPiBTb3JyeSBmb3IgdGhlIGxhdGUgcmVw
bHkuIEkgaGF2ZSBiZWVuIGJ1c3kgd2l0aCBkb3duc3RyZWFtIHRhc2tzLgo+IAo+IEkgd2lsbCBn
aXZlIHRoZW0gYSB0cnkgYnkgdGhlIGVuZCBvZiB0aGUgd2Vlay4gWWV0LCBwcm9iYWJseSBpdCdk
Cj4gYmUgYmV0dGVyIHRvIGluY2x1ZGUgR3VpbGxhdW1lIGFsc28gYXMgaGUgaGFzIHRoZSBOeWFu
IHBsYXRmb3JtLgo+IAoKSW5kZWVkLCB0aGFua3MuIEFsdGhvdWdoLCBJJ20gcHJldHR5IHN1cmUg
dGhhdCBpdCdzIHRoZSBzYW1lIGlzc3VlIHdoaWNoCkkgcmVwcm9kdWNlZCBvbiBOZXh1cyA3LgoK
R3VpbGxhdW1lLCBjb3VsZCB5b3UgcGxlYXNlIGdpdmUgYSB0ZXN0IHRvIHRoZXNlIHBhdGNoZXMg
b24gTnlhbiBCaWc/ClRoZXJlIHNob3VsZCBiZSBubyBFTUVNIGVycm9ycyBpbiB0aGUga2VybmVs
IGxvZyB3aXRoIHRoaXMgcGF0Y2hlcy4KCmh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJv
amVjdC9saW51eC10ZWdyYS9saXN0Lz9zZXJpZXM9MjM2MjE1Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
