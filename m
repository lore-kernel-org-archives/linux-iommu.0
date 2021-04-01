Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751BDC433ED
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 08:57:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD27B610A5
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 08:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD27B610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DF7060A97;
	Thu,  1 Apr 2021 08:57:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rrMmqtDaxIsx; Thu,  1 Apr 2021 08:57:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A53D60A93;
	Thu,  1 Apr 2021 08:57:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 149D8C000B;
	Thu,  1 Apr 2021 08:57:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EEACC000A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 08:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8023440296
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 08:57:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BwtAdqnKx2Vk for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 08:57:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F30F1400C2
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 08:57:50 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 x21-20020a17090a5315b029012c4a622e4aso671485pjh.2
 for <iommu@lists.linux-foundation.org>; Thu, 01 Apr 2021 01:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=oXtJ821yB9S8peS7jwk7jXIhvNxqy4kwSPnw73VGxuY=;
 b=aA5+PCF5ZjUkVztXBPOOYY2ElzvNGYpU+nmwQbZeikkytPRSBL3KM0UIJYvlGV43eZ
 jMCLFVWtv0tNz/qNiQPUDKTbOuAKOXQT4Go8yTJZx6BLJP5iiPI7E2pbfp6ObQK7cNGo
 NGpuNX7kaEnW/v3sJsAQnq1p21TchRmAm8ofsDXDzn786S0o+0sTpP7zb49tQ5mZ0BE6
 WwyMNvXZVwqy6nMZ0SfONJmIxRNDW885ZzzFzjySanxNQrl3E1un6u8Zl9S8DZjXTpCm
 eCqk0n3W/gKZkEH/ySIRus1BQ6SeM9T/sv16mkNcKIok3heNI6DMJdfbjqaElZfyHiZs
 CyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=oXtJ821yB9S8peS7jwk7jXIhvNxqy4kwSPnw73VGxuY=;
 b=TVggU4OM7jiGla/06lNiP+QlvpHVrbK1JaxczIh3CShSnDM/TmIiMLhqhNyrA4Gtjg
 XG/sM1zh/TU1Oz2DCNXkIFDDsFXKPz+aHUE6oaGgkhPz/wjGkuuNWvZ5MxS0KIpCjow5
 W4W0xEcxEOD2fv7H9O1LyX3WpGg05em5ZOPNjxhqVYaF8tmbDR79IAppzBEM+ENcu3ab
 8rVU+LAYT2CgwAgz7pU9ayyry7U06ebXNXfwtLhhlISykTJ1L7xWHUDk2f7ybACstesN
 nJWA6ThZTlVsyRf/HpsvlT9NMj6v91exo3mlT+lPT+ubWHKuUMMP2IvHIg2TyGLq3bkh
 G4FA==
X-Gm-Message-State: AOAM532VOQIchJokDUB0zDF9GblxQ0uM0kBVulbxknDLtCSfbxNouiX4
 XQFb7lvWTvk5wjyVnYFoFg4=
X-Google-Smtp-Source: ABdhPJzvGu1N/wS8TdEjPhRmZPGQtvMqhoK8l4yaacUdBjiNF8CVAyTyrCf93DCUjT3hj2p3hpmsTg==
X-Received: by 2002:a17:902:a502:b029:e8:3a40:bc6d with SMTP id
 s2-20020a170902a502b02900e83a40bc6dmr4974818plq.14.1617267470411; 
 Thu, 01 Apr 2021 01:57:50 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id y7sm4824167pja.25.2021.04.01.01.57.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 01 Apr 2021 01:57:50 -0700 (PDT)
Date: Thu, 1 Apr 2021 01:55:49 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v1 2/2] iommu/tegra-smmu: Revert workaround that was
 needed for Nyan Big Chromebook
Message-ID: <20210401085549.GA31146@Asurada-Nvidia>
References: <20210328233256.20494-1-digetx@gmail.com>
 <20210328233256.20494-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210328233256.20494-2-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, guillaume.tucker@collabora.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Mar 29, 2021 at 02:32:56AM +0300, Dmitry Osipenko wrote:
> The previous commit fixes problem where display client was attaching too
> early to IOMMU during kernel boot in a multi-platform kernel configuration
> which enables CONFIG_ARM_DMA_USE_IOMMU=y. The workaround that helped to
> defer the IOMMU attachment for Nyan Big Chromebook isn't needed anymore,
> revert it.

Sorry for the late reply. I have been busy with downstream tasks.

I will give them a try by the end of the week. Yet, probably it'd
be better to include Guillaume also as he has the Nyan platform.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
