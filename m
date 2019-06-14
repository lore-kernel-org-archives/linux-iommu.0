Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F845C31E4C
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 06:28:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 225B921473
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 06:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JozXoOb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225B921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ED5F3E63;
	Fri, 14 Jun 2019 06:28:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 55D97E37
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 06:28:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8E049E5
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 06:28:55 +0000 (UTC)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
	[209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 0B98D21773
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 06:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560493735;
	bh=o6p9lVc+DYilRKtF9pajKsHYMRF8rkewSFkOlAnBRH8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JozXoOb8Ksc6M/jxRWxNQoCuZPK/5IvFkxh+M4O9zoywYnsSjvXltT2rFIopAZGVa
	8ZxAp9Gd4x/1rIddNzEm4o7sHNxGxeZPGt16LcX6QGhYmPS2av/K81y5kESJTLL6Kb
	6WEfM0zrV0/lz+O9Drbq/GrlfjzYye/Smlmr/ypM=
Received: by mail-lf1-f51.google.com with SMTP id j29so880674lfk.10
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 23:28:54 -0700 (PDT)
X-Gm-Message-State: APjAAAXk/iAUg83ZNFM7GzCbdRkFc7T4VYsnzLfrHarweWE6pvKXqwan
	OLEf5m1paPAZF9BtZQZG3toeKFwHHOUk1Y4560A=
X-Google-Smtp-Source: APXvYqzRXJBwqzBDJLXSnR6wciv/RpnSmt3qlpvlkhRIjxzRerMzGffvz309DswL+/k+vyTpR7UVS0Do0UtSVtBB5qM=
X-Received: by 2002:ac2:4d1c:: with SMTP id r28mr8998948lfi.159.1560493733233; 
	Thu, 13 Jun 2019 23:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190613162703.986-1-tiny.windzz@gmail.com>
In-Reply-To: <20190613162703.986-1-tiny.windzz@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 14 Jun 2019 08:28:42 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfU+nB-_K3ZP9XBFp5bfk-ZvbfSEW96LD4MbtkyWfQZHg@mail.gmail.com>
Message-ID: <CAJKOXPfU+nB-_K3ZP9XBFp5bfk-ZvbfSEW96LD4MbtkyWfQZHg@mail.gmail.com>
Subject: Re: [PATCH 01/10] iommu/exynos: convert to SPDX license tags
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
	heiko@sntech.de, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org, will.deacon@arm.com,
	agross@kernel.org, iommu@lists.linux-foundation.org,
	jonathanh@nvidia.com, david.brown@linaro.org, kgene@kernel.org,
	thierry.reding@gmail.com, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, 13 Jun 2019 at 18:27, Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> Updates license to use SPDX-License-Identifier.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/iommu/exynos-iommu.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Splitting this per driver is too much... it is not necessary. Such
changes should be done in one patch per subsystem.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
