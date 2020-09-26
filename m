Return-Path: <SRS0=cnVx=DD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03D2C4727D
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 22:18:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 384CF238E6
	for <iommu@archiver.kernel.org>; Sat, 26 Sep 2020 22:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMVMy8XA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384CF238E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D991185F9B;
	Sat, 26 Sep 2020 22:18:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0kG6XN9WluBs; Sat, 26 Sep 2020 22:18:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6783A84E97;
	Sat, 26 Sep 2020 22:18:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 582BCC0859;
	Sat, 26 Sep 2020 22:18:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 349E9C0051
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 22:18:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2EDB185CC7
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 22:18:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xQOtWyzqGsyi for <iommu@lists.linux-foundation.org>;
 Sat, 26 Sep 2020 22:18:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4CB9384E97
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 22:18:18 +0000 (UTC)
Received: by mail-lf1-f65.google.com with SMTP id y2so6782809lfy.10
 for <iommu@lists.linux-foundation.org>; Sat, 26 Sep 2020 15:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lE/AC9bxBW83uM+HIDXwlkhKItngXZopMBpfvrstmyk=;
 b=MMVMy8XAeJuOZHcFkqxvLQrgmKcUV63chHs3W25SNnFr9148jM6nHY2ovh4oF0QE6c
 jhtvG31t4Mq9+5jaOidpFB09HeFHYzofMbmBI+E/drIZvB3BbwWbf9t+h6xD2DYEItku
 IhWp2VWmb4Kbmx2X/EWnRolQfJW9H4MqjUyo8lo6XDA2//YxLu+cZhK//Yc0twvuebqo
 bYIOE+4Cfbs4EX1Y0b3/l6TGfO8SpuUKrSvNsuxr7WRBmQNOUWNfKJ3cZMvM4x9DEX8m
 wfoZX8D896K3NqdLZmRRO7kUqQS/PrqhVOk3D9TWot62/raq+FmXBB8+ef68CtMGChtu
 kHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lE/AC9bxBW83uM+HIDXwlkhKItngXZopMBpfvrstmyk=;
 b=Ddq+X93xCFTeVItMzA8TMd8qQMDsQaq2tfXMbMBK+AwTu6mfhANG0Po4XURCO5p1j4
 8ACTfxbmPV8wIygBLn+7E+oxh9orHJbnBhRhUE11KqfNeVwdUl7N03DKrUh2+mJgWiNn
 K027yBJK4sP55hvDDdTiTLCcfLzNRjj0k7ogfLqGawVNPmmy7AB5a2ezUo1BYrDON/8u
 RqvnWNpxWLEli9j/jj120lXRInmltQ224IFQ7gp97oorqVShi2XcYWyqt/nbE4OprWE5
 925go2FOx0B26KxJaOpAgkcbtj5vWhPCiHSM9za2eBGOxgZyt/XC6I0fZspwX0TF+WzG
 l60Q==
X-Gm-Message-State: AOAM533sLgYNSG/6wGvBWZv90HRtcokQSurlw4dkYrIuZdmUNUyOmXTb
 rIIHHYVBf5lBr8Jjtbmxjfs=
X-Google-Smtp-Source: ABdhPJwPPewtePgrxJeTjV075852NV+KAjHbpk+ELT2P0eGddHeapSuRqXwoj/vq73zaQITGyV5qsA==
X-Received: by 2002:a05:6512:2101:: with SMTP id
 q1mr1782412lfr.157.1601158696395; 
 Sat, 26 Sep 2020 15:18:16 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id n3sm2138553lfq.274.2020.09.26.15.18.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Sep 2020 15:18:15 -0700 (PDT)
Subject: Re: [PATCH 4/5] iommu/tegra-smmu: Add PCI support
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org, krzk@kernel.org
References: <20200926080719.6822-1-nicoleotsuka@gmail.com>
 <20200926080719.6822-5-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b95b69fb-8570-f5dc-c486-b94958f2a791@gmail.com>
Date: Sun, 27 Sep 2020 01:18:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200926080719.6822-5-nicoleotsuka@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com
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

MjYuMDkuMjAyMCAxMTowNywgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Ci4uLgo+ICsjaWZkZWYg
Q09ORklHX1BDSQo+ICsJaWYgKCFpb21tdV9wcmVzZW50KCZwY2lfYnVzX3R5cGUpKSB7CgpJcyB0
aGlzIGlvbW11X3ByZXNlbnQoKSBjaGVjayByZWFsbHkgbmVlZGVkPwoKPiArCQlwY2lfcmVxdWVz
dF9hY3MoKTsKClNob3VsZG4ndCBwY2lfcmVxdWVzdF9hY3MoKSBiZSBpbnZva2VkICphZnRlciog
YnVzX3NldF9pb21tdSgpIHN1Y2NlZWRzPwoKPiArCQllcnIgPSBidXNfc2V0X2lvbW11KCZwY2lf
YnVzX3R5cGUsICZ0ZWdyYV9zbW11X29wcyk7Cj4gKwkJaWYgKGVyciA8IDApIHsKPiArCQkJYnVz
X3NldF9pb21tdSgmcGxhdGZvcm1fYnVzX3R5cGUsIE5VTEwpOwo+ICsJCQlpb21tdV9kZXZpY2Vf
dW5yZWdpc3Rlcigmc21tdS0+aW9tbXUpOwo+ICsJCQlpb21tdV9kZXZpY2Vfc3lzZnNfcmVtb3Zl
KCZzbW11LT5pb21tdSk7Cj4gKwkJCXJldHVybiBFUlJfUFRSKGVycik7Cj4gKwkJfQo+ICsJfQo+
ICsjZW5kaWYKPiArCj4gIAlpZiAoSVNfRU5BQkxFRChDT05GSUdfREVCVUdfRlMpKQo+ICAJCXRl
Z3JhX3NtbXVfZGVidWdmc19pbml0KHNtbXUpOwo+ICAKPiAKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby9pb21tdQ==
