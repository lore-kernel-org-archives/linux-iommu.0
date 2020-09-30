Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABB6C4741F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:40:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43722074A
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pb5O4ATP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43722074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5B217871BF;
	Wed, 30 Sep 2020 05:40:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GL7TQ2LhDw-7; Wed, 30 Sep 2020 05:40:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 04248871B7;
	Wed, 30 Sep 2020 05:40:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E58EFC0889;
	Wed, 30 Sep 2020 05:39:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2273FC0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1208C871B8
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:39:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8vUzM9KfW9rm for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 05:39:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 79360871B7
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:39:57 +0000 (UTC)
Received: by mail-lf1-f68.google.com with SMTP id x69so637327lff.3
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 22:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sO7Z6Ebp01z2sW5Kfe6IDDgdgco/uSCVRH76uI5YHC0=;
 b=Pb5O4ATP4Nrcn7RwitJpHiIkFKleHhVyVqhRyCu5njAH7ln3zA+KGp9q594NfHP2e6
 Kj7htrUZvLTx85NHXXlpBlvoS/zD7tKGmpeq8JIBvCA/CS5CyfgYkwbRyZuRM76CllvX
 RXECp0Q8GrUJwLRIUgDO81HuzKKxV/MHQYCbs33OAzHIvv27euBGjo1nKLm6rvh8kibz
 H3Ki+ZE5D1MHSuANdSKJwntj9SaPgjDQHzBe/kbUFmhIk8Lj0zB+0TDOQpHYKGKOMRrR
 M9ZNPlvHWgkbcMcapSIcLRf5MQFIGwV3LUVI25f+URnYw4lHRb0RHPMAc7HZfup4t+xq
 78kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sO7Z6Ebp01z2sW5Kfe6IDDgdgco/uSCVRH76uI5YHC0=;
 b=ph43FnZK9lMOy49NrsESgwm898W4hccS9bXQmeIleF3w3N+fUul22c48dYNrjvMKX4
 6kyywoLVAWR4WXzTV9DfooK11bZi/IDGtfqbbIL1ZCSO/f/qSi4rEU1Kuleq3eMQ845C
 ZPCCJtFt9NZXKRoIlNdidRCgZUL+G2bfUM1MGefxnTYUd+H80ky29VEEP8+Rotw1TkTB
 hufM41QL4FtBVVdUwbw82oVwJZJPXv3y5JLad7g/3+AxRuvsNmKRxvBhcZiqRZyu6oJF
 QZTW8sU9OWJaNTgAd0tUDTecgTM4mpX8jtq9GQrVK6ignzPD0RUmUAVMNlMkaf2j5967
 Lk6g==
X-Gm-Message-State: AOAM531vCcz93egnAmfDz/Xj+IsjQK3/GyU3wLZfCYuSGsL6rl939VO5
 X/1Lg28ZJFvyvPGTZeH+9cY=
X-Google-Smtp-Source: ABdhPJx8X6I4Cwc+xBI4BDjcDu14RLHDatsF/H3cqbI/6oc/O9NxV5GSdAK1Cwy9h4z0cKK6PHHBxQ==
X-Received: by 2002:a19:4bc8:: with SMTP id y191mr289347lfa.491.1601444395768; 
 Tue, 29 Sep 2020 22:39:55 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id z7sm62625lfc.59.2020.09.29.22.39.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 22:39:55 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org, krzk@kernel.org
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-3-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e557a09b-bcc3-11cb-9529-096aafb42051@gmail.com>
Date: Wed, 30 Sep 2020 08:39:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930003013.31289-3-nicoleotsuka@gmail.com>
Content-Language: en-US
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com
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

MzAuMDkuMjAyMCAwMzozMCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gIHN0YXRpYyBpbnQg
dGVncmFfc21tdV9hdHRhY2hfZGV2KHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwKPiAgCQkJ
CSBzdHJ1Y3QgZGV2aWNlICpkZXYpCj4gIHsKPiArCXN0cnVjdCBpb21tdV9md3NwZWMgKmZ3c3Bl
YyA9IGRldl9pb21tdV9md3NwZWNfZ2V0KGRldik7Cj4gIAlzdHJ1Y3QgdGVncmFfc21tdSAqc21t
dSA9IGRldl9pb21tdV9wcml2X2dldChkZXYpOwo+ICAJc3RydWN0IHRlZ3JhX3NtbXVfYXMgKmFz
ID0gdG9fc21tdV9hcyhkb21haW4pOwo+IC0Jc3RydWN0IGRldmljZV9ub2RlICpucCA9IGRldi0+
b2Zfbm9kZTsKPiAtCXN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgYXJnczsKPiAgCXVuc2lnbmVkIGlu
dCBpbmRleCA9IDA7Cj4gIAlpbnQgZXJyID0gMDsKPiAgCj4gLQl3aGlsZSAoIW9mX3BhcnNlX3Bo
YW5kbGVfd2l0aF9hcmdzKG5wLCAiaW9tbXVzIiwgIiNpb21tdS1jZWxscyIsIGluZGV4LAo+IC0J
CQkJCSAgICZhcmdzKSkgewo+IC0JCXVuc2lnbmVkIGludCBzd2dyb3VwID0gYXJncy5hcmdzWzBd
Owo+IC0KPiAtCQlpZiAoYXJncy5ucCAhPSBzbW11LT5kZXYtPm9mX25vZGUpIHsKPiAtCQkJb2Zf
bm9kZV9wdXQoYXJncy5ucCk7Cj4gLQkJCWNvbnRpbnVlOwo+IC0JCX0KPiAtCj4gLQkJb2Zfbm9k
ZV9wdXQoYXJncy5ucCk7Cj4gKwlpZiAoIWZ3c3BlYyB8fCBmd3NwZWMtPm9wcyAhPSAmdGVncmFf
c21tdV9vcHMpCj4gKwkJcmV0dXJuIC1FTk9FTlQ7CgpzLyZ0ZWdyYV9zbW11X29wcy9zbW11LT5p
b21tdS5vcHMvCgpTZWNvbmRseSwgaXMgaXQgZXZlbiBwb3NzaWJsZSB0aGF0IGZ3c3BlYyBjb3Vs
ZCBiZSBOVUxMIGhlcmUgb3IgdGhhdApmd3NwZWMtPm9wcyAhPSBzbW11LT5vcHM/Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
