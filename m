Return-Path: <SRS0=0/W0=IO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C118C433DB
	for <iommu@archiver.kernel.org>; Tue, 16 Mar 2021 23:33:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C99C764EF6
	for <iommu@archiver.kernel.org>; Tue, 16 Mar 2021 23:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99C764EF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 61CDF4304B;
	Tue, 16 Mar 2021 23:33:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6hLM3Ddx-2mm; Tue, 16 Mar 2021 23:33:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 58FEA43062;
	Tue, 16 Mar 2021 23:33:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39EC2C000B;
	Tue, 16 Mar 2021 23:33:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBB97C000A
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 23:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C577B4304B
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 23:33:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XqoqiLK97Oci for <iommu@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 23:33:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 606504307B
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 23:33:44 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id q25so161346lfc.8
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 16:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oaA9aMSbFmvtLvb2TvRiLzy5d0VE78dtkAU/7hwZdZE=;
 b=DL3J3Sn0vCyNg6eH5/0Dv4LknSut5bq7vbVeMZq59Uk2TYiGHaJY7Ys+dKqEtErXrj
 3QyMiBAdf37NjnOlgxoy2p/sUeYmI30APuT08xhSVOM7kbpMT9lCUfOdKAMrpT+bSHSY
 m12YV9AxKyBZTJ7ZfHLXvnjv/Ty5IMmYdo510SqS2ODsN7tQQ2ep2sdNUk9kI4jRv+CW
 GsuZ4y1tJrXl/Q0zSAUV98V2ZqEsCq9/t2p6HXGrpl5av4rlGG8hH35CatGmn0mrvLyS
 Jgv3BPZ3OAxP7swnT1QqGkD0nXOD6Ewuf16GndpMwK1D2/LSfkReySpVaRjpCTUiIFGo
 8Meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oaA9aMSbFmvtLvb2TvRiLzy5d0VE78dtkAU/7hwZdZE=;
 b=OP6qMy3s0miqlHCICFhHOScGuhAZKGDqaAKrx0xzOgzk1dN4FdNcfIrnRDrfON9muC
 3S9GHAvTGj5QY/8gyzTejYgIpQ1eWodRbiPyPhO4n/EVcinN1Hx9MDYnNAZptHOHErYA
 dGmRM9hqb7GQcUlUbKaM+1lcqbsPgy5F8qf1vNLimziMTx5YOnCV4LTUINbZ1cSoVZTq
 jM4pQ0sXIWGFkDRL4mrFzjFw0piUE0zfG8OfhgjpE1hQMgNPuQdMIl1L1OmkFBkiWJR9
 3UncZhIuMAkkYhxuA370cfZpT8h+R2rnZPL5UpKNVVFX/V9M9uirDJrtAAsiT5q1yNTB
 qimQ==
X-Gm-Message-State: AOAM532ZSQDKLSLVs2oKW+yUp+teV5wm/O+DuLYnUAJ9LreYsZ2spA/x
 aIG32Z0GEIu3phRs0a85r/4=
X-Google-Smtp-Source: ABdhPJzvYBL68SGctS5ttbA+a6ftGWGtijNx5S78m8tgSBk/V8Ex98dn8GUgmTKHaNuU45wX8YyjvA==
X-Received: by 2002:ac2:47e5:: with SMTP id b5mr640818lfp.476.1615937622918;
 Tue, 16 Mar 2021 16:33:42 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru.
 [109.252.193.52])
 by smtp.googlemail.com with ESMTPSA id m19sm828337ljb.10.2021.03.16.16.33.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Mar 2021 16:33:42 -0700 (PDT)
Subject: Re: [PATCH v5] iommu/tegra-smmu: Add pagetable mappings to debugfs
To: Nicolin Chen <nicoleotsuka@gmail.com>, joro@8bytes.org,
 thierry.reding@gmail.com, will@kernel.org
References: <20210315203631.24990-1-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <432fa6a4-23d3-7572-276b-0ee31ff22762@gmail.com>
Date: Wed, 17 Mar 2021 02:33:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210315203631.24990-1-nicoleotsuka@gmail.com>
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

MTUuMDMuMjAyMSAyMzozNiwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gK3N0YXRpYyB1bnNp
Z25lZCBsb25nIHBkX3B0X2luZGV4X2lvdmEodW5zaWduZWQgaW50IHBkX2luZGV4LCB1bnNpZ25l
ZCBpbnQgcHRfaW5kZXgpCj4gK3sKPiArCXJldHVybiAoKGRtYV9hZGRyX3QpcGRfaW5kZXggJiAo
U01NVV9OVU1fUERFIC0gMSkpIDw8IFNNTVVfUERFX1NISUZUIHwKPiArCSAgICAgICAoKGRtYV9h
ZGRyX3QpcHRfaW5kZXggJiAoU01NVV9OVU1fUFRFIC0gMSkpIDw8IFNNTVVfUFRFX1NISUZUOwo+
ICt9CgpMb29raW5nIGF0IHRoaXMgYWdhaW4sIEknbSBub3cgd29uZGVyaW5nIHdoZXRoZXIgd2ls
bCBiZSBiZXR0ZXIgdG8KcmVwbGFjZSBkbWFfYWRkcl90IHdpdGggdTMyIGV2ZXJ5d2hlcmUgc2lu
Y2UgU01NVSBvbmx5IHN1cHBvcnRzIDMyYml0cwpmb3IgSU9WQS4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
