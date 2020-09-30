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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A45C2D0A8
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:10:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 779CF206D4
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDDAYamC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779CF206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E07C285F75;
	Wed, 30 Sep 2020 05:10:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6LZRPSF7WwF7; Wed, 30 Sep 2020 05:10:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 891278506B;
	Wed, 30 Sep 2020 05:10:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75D9CC016F;
	Wed, 30 Sep 2020 05:10:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85F3FC0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 74DD0871B4
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:10:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YiB+IT12vwww for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 05:10:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B2167871B0
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:10:29 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id a15so464729ljk.2
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 22:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sWOUEivvyjwmKnS+1gQtbQM1CGBMZHxOAZcgTC+sr0k=;
 b=qDDAYamCSLuu5G9Imm4M9PhE04cyV1A351HM9B+dCti2usr49Ra4TOrG+Hw8inwJGv
 i9B3ExDnbNRWAJgSVmcZ6/F/CmkhrY4OkdhtmBBahSJsO9Sd20hggoJsbUCPUrhN73Ai
 wo+aSXQObBcNLAQVAJ0VtWifWREYxwIn5uHU5fGRYQNXYrqgFI6bDnyxe8LjoUbhQQKf
 X825089DwAyPy880m3K+dbNpRt+qtI2QHN7IgEPJ3Gv3Us/fKTPO35lQ722CYuxaTMv+
 LOjHPy1fWERCrDWIWTz+V8yA9Zi0Dr0NMwV54KJo2Gjg+gRnzapkEiqM54LzAQX2uHoe
 VKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sWOUEivvyjwmKnS+1gQtbQM1CGBMZHxOAZcgTC+sr0k=;
 b=A1zGozgs6XM0EbmAcPoviBXN5BL8vQRSbuGWo3xNndkeizPB70DJr8b4K8qLdeI8uq
 kn46GxrF/pnfXUWbuaboDGec9bIVK1RlB/dshM/s83zt+MO5ONkGi9y6QTrqAZKJXfDn
 Uz+nehqWk5L+dg3Qjw+BbGTOz3JavReKmiZsc4wJ+GupmkPNe0teBqk8Pl/UwGKMTqD+
 S2bIbu6eYz7ejj+xXgVpHVyulaJFlDv8XiArP9cIya/w+5Nsax97M0vFcLknU85xhIyt
 EcLYqtWs1v2iRLU4m3Q2DyvJLzYbUVrLZgERXBpd1CthfRyg37aUHJxQGW7GoR6PREG5
 0j4g==
X-Gm-Message-State: AOAM530iNM1avFWjoslGvC0h1pLcDmlEwBYquXw67zusPki7XJrlaUb+
 N/yzIb1syU8kPeFKVZCUP1I=
X-Google-Smtp-Source: ABdhPJwZLrAmlZX8sHApt+XwfMXLnDrPg53KHCMKCT1/t5az43Q3OJoEbDBwOJT9bOfGmFxvJNRG2g==
X-Received: by 2002:a2e:9755:: with SMTP id f21mr345885ljj.50.1601442627611;
 Tue, 29 Sep 2020 22:10:27 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru.
 [109.252.170.211])
 by smtp.googlemail.com with ESMTPSA id u1sm55367lfu.24.2020.09.29.22.10.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 22:10:26 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
To: Nicolin Chen <nicoleotsuka@gmail.com>, thierry.reding@gmail.com,
 joro@8bytes.org, krzk@kernel.org
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-3-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <db183fdf-d566-599a-94ff-cfab0e08aa7a@gmail.com>
Date: Wed, 30 Sep 2020 08:10:26 +0300
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

MzAuMDkuMjAyMCAwMzozMCwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gIHN0YXRpYyB2b2lk
IHRlZ3JhX3NtbXVfcmVsZWFzZV9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KQoKVGhlIHRlZ3Jh
X2dldF9tZW1vcnlfY29udHJvbGxlcigpIHVzZXMgb2ZfZmluZF9kZXZpY2VfYnlfbm9kZSgpLCBo
ZW5jZQp0ZWdyYV9zbW11X3JlbGVhc2VfZGV2aWNlKCkgc2hvdWxkIHB1dF9kZXZpY2UobWMpIGlu
IG9yZGVyIHRvIGJhbGFuY2UKYmFjayB0aGUgcmVmY291bnRpbmcuCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
