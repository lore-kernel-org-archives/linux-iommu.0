Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B69C56201
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 23:05:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D86E1206D9
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 23:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2hhMGNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D86E1206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 534572045C;
	Tue, 24 Nov 2020 23:05:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nNB84gsEi4qW; Tue, 24 Nov 2020 23:05:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A817E20407;
	Tue, 24 Nov 2020 23:05:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E534C0891;
	Tue, 24 Nov 2020 23:05:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11910C0052
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 23:05:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EE83586FFE
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 23:05:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5V4sbH3hj6Qj for <iommu@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 23:05:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2AA1286A9B
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 23:05:17 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id y7so243556lji.8
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 15:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/KXHKT0QjGfRLZidy5/lA4rIw7B1CrKKa5AQMFx5E+o=;
 b=q2hhMGNsiRjmWE7ShOd1r2snZc9B66vAR/fONn6y58IpmTyCv8+hAiUnLmSKpnSTPd
 L8MAXgH6aNO/aLpS8wUiBCcuwG8jcZLxnsGMva4aUqNDjauM84UrjES/+o2f9MFJCO96
 61TTbyYBeD7KSNW8+0tu9c5FttT4YCwCbGFb94pCA3g4DO21TM14wpXV+v5zYKDhaNY6
 JUhdiElC+at3f7FowROvZZkgBSv5i0ps5FlHl+kTP0wrgPlDwF19qLX6QoCnqQj/ZCJt
 aAd3i9VLuoEADwTg79dLch3n2v26MltCBktsMz0/UapVncQPDTK/b2htk4hQx8DIwZ55
 1IkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/KXHKT0QjGfRLZidy5/lA4rIw7B1CrKKa5AQMFx5E+o=;
 b=jc/jg8majIkzwgG2KxBFSAsLaHlgo4oaTq54YlVbmK9yxM3+TKkwgXnWY8GwHhPhPP
 wuaxXHzpQfcM/H2qzCb07k56QNGEEyE3oujzUkPta3CkRIg04rOgXaI8MWwE5hjDYfvd
 naiYpDMZJYLzu/Sd1cnMCw3/ry+UA2/kuxLzB7hwq2x+oOtkdWvePBQN4h0OkLw/Itjm
 L2a/urrvohhr/iVPB3UpSg0pSjXtu9dWdXPL4fXqfAWHrbxclaIs1EPiA+NfgPCBqOPI
 /OuY+MqD0SbZGFKIRlfxKrn1C7zfeyI1kAsaHVy3nZR7WUBMwe8amuqTSUkGePBWW4T+
 p3aA==
X-Gm-Message-State: AOAM533XraKNG79SXSyb+DpZwGb1+He6G/+MX1nac84WzkJ7IuCna5aD
 wpGt08jb/M1ALocKbWqhM9E=
X-Google-Smtp-Source: ABdhPJxpAqvUllZt+d+tRTNX9DTlqmrNB7dPwsBxupne7kCCr9F7wicJekI5L3d60wRQnhoZ4CbtHw==
X-Received: by 2002:a2e:878c:: with SMTP id n12mr211314lji.319.1606259115126; 
 Tue, 24 Nov 2020 15:05:15 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru.
 [109.252.193.159])
 by smtp.googlemail.com with ESMTPSA id 141sm40313lfi.102.2020.11.24.15.05.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2020 15:05:14 -0800 (PST)
Subject: Re: [PATCH RESEND 0/5] iommu/tegra-smmu: Some pending reviewed changes
To: Nicolin Chen <nicoleotsuka@gmail.com>, joro@8bytes.org
References: <20201111222129.15736-1-nicoleotsuka@gmail.com>
 <20201124212100.GA32108@Asurada-Nvidia>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <68237d7c-12f7-3053-2e79-75b7e95f0af3@gmail.com>
Date: Wed, 25 Nov 2020 02:05:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201124212100.GA32108@Asurada-Nvidia>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org, Will Deacon <will@kernel.org>
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

MjUuMTEuMjAyMCAwMDoyMSwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gSGkgSm9lcmcsCj4g
Cj4gVGhlc2UgZml2ZSBwYXRjaGVzIHdlcmUgYWNrZWQgYnkgVGhpZXJyeSBhbmQgYWNrZWQtbi10
ZXN0ZWQgYnkKPiBEbWl0cnkgYSB3aGlsZSBhZ28uIFdvdWxkIGl0IGJlIHBvc3NpYmxlIGZvciB5
b3UgdG8gYXBwbHkgdGhlbT8KPiAKPiBUaGFua3MhCgpIaSwKCllvdSBwcm9iYWJseSBzaG91bGQg
dHJ5IHRvIHBpbmcgV2lsbCBEZWFjb24uCgpodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC8xMS8x
Ny8yNDMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9t
bXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
