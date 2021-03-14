Return-Path: <SRS0=2lDQ=IM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC151C433E0
	for <iommu@archiver.kernel.org>; Sun, 14 Mar 2021 15:08:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3514864EB7
	for <iommu@archiver.kernel.org>; Sun, 14 Mar 2021 15:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3514864EB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D4D0F40155;
	Sun, 14 Mar 2021 15:08:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ELuZUBAZfDa6; Sun, 14 Mar 2021 15:08:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id E5D584014C;
	Sun, 14 Mar 2021 15:08:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9D54C000A;
	Sun, 14 Mar 2021 15:08:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14305C0001
 for <iommu@lists.linux-foundation.org>; Sun, 14 Mar 2021 15:08:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E13AA4B1F9
 for <iommu@lists.linux-foundation.org>; Sun, 14 Mar 2021 15:08:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 90wEDhJRUEFn for <iommu@lists.linux-foundation.org>;
 Sun, 14 Mar 2021 15:08:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7D35B475AA
 for <iommu@lists.linux-foundation.org>; Sun, 14 Mar 2021 15:08:03 +0000 (UTC)
Received: by mail-lj1-x22b.google.com with SMTP id 15so13222489ljj.0
 for <iommu@lists.linux-foundation.org>; Sun, 14 Mar 2021 08:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YjwVPGG1TuIQpkOeAPKMAg0iJbl4yQQEvHJkwwGm/zs=;
 b=oOUoZZ/Ftj5AKYuSEuFtvp2R7V9haC6Q6AApMAJ7kT+Ka0WnH+RHT4XBENNPkQACfC
 jQWfSyfSROMGt0hqgDIDlBASdgjvXkJi6xtcn81/7+11aF19fAwsBgWdXFDKC4T+hHW1
 +HLuYw3AG+38L61qb1gvUNT/dInOrD36+oBeIizrJU66Iw2wwJEapodKxmK0vxjAR7yj
 VcD6k1Pgp+Qurp96EWEsZwa269R5Mb4XJ27GYPC4Ix9RVcVXpzRUBTAKN/CbQYfzBLiT
 57w9L51cbBifCKcaVGqxmbFiT8P9wY1ns+UY9y7ZVlKu+iWmnAg59M3MECIfCiTJrZd4
 ndsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YjwVPGG1TuIQpkOeAPKMAg0iJbl4yQQEvHJkwwGm/zs=;
 b=o1FyDZluXLDriLr3bl6Lcsj5tH5uxFxrH+FludS1+EAx8fnuHCnLcY8V3D5PY+r5ZT
 GKj5xG38/UEk3tMnKsKNmQcQaWjAm/diDj6ZMfFIoq0/90Wntoov0F25mFb9uSTVbkQO
 d0/LvL2vPFgjW621M/1DonfgMctcYrZVXXXHj0zIIu5M0t7q1sX2U9jcHUWiA87nGyLO
 GRdQOevQoNl/SS72hNYjs5pE1SP1wUypbNln1mC5LmTQlo6ua8BD9uyHGoTzgAJQX588
 ri3VAs2UWyBsmVGOq+1aJ20m1/LV8ovbzyvyhk0N/HDyHhUhU4h8c+wpWsoDH9/+lQca
 0Ygw==
X-Gm-Message-State: AOAM533al5eqJiYk/BwXF6A62ulXHFPOwkN/kq2NRAZnjc8ERRWVdwI5
 dJHClqhS2JvLnjdcpFDAZnI=
X-Google-Smtp-Source: ABdhPJzKmUYhZwRbEOYZqjIAuBLd/RAfVxfAYGihj1XoiEQDNo3KThVc2Ppt+njIF0Wld4sCJNcszQ==
X-Received: by 2002:a2e:9bcd:: with SMTP id w13mr8003309ljj.43.1615734481520; 
 Sun, 14 Mar 2021 08:08:01 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru.
 [109.252.193.52])
 by smtp.googlemail.com with ESMTPSA id m20sm2635562ljj.93.2021.03.14.08.08.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Mar 2021 08:08:01 -0700 (PDT)
Subject: Re: [PATCH v3] iommu/tegra-smmu: Add pagetable mappings to debugfs
To: Nicolin Chen <nicoleotsuka@gmail.com>, joro@8bytes.org,
 thierry.reding@gmail.com, will@kernel.org
References: <20210314080653.29374-1-nicoleotsuka@gmail.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e1d3eef7-3d7e-b26d-79d2-f87969ac11f8@gmail.com>
Date: Sun, 14 Mar 2021 18:08:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210314080653.29374-1-nicoleotsuka@gmail.com>
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

MTQuMDMuMjAyMSAxMTowNiwgTmljb2xpbiBDaGVuINC/0LjRiNC10YI6Cj4gKwlmb3IgKHBkX2lu
ZGV4ID0gMDsgcGRfaW5kZXggPCBTTU1VX05VTV9QREU7IHBkX2luZGV4KyspIHsKPiArCQlzdHJ1
Y3QgcGFnZSAqcHRfcGFnZTsKPiArCQl1MzIgKmFkZHI7Cj4gKwkJaW50IGk7Cgp1bnNpZ25lZCBp
bnQKCmFuZCB0aGVuIHByaW50ZiBzcGVjaWZpZXJzIGFsc28gc2hvdWxkIGJlICV1Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
