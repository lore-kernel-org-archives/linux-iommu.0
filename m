Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4BDC47420
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 09:21:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D32C2075F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 09:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7bKfqTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D32C2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 900D386151;
	Wed, 30 Sep 2020 09:21:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AGBPp5ndCSaW; Wed, 30 Sep 2020 09:21:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2398F86160;
	Wed, 30 Sep 2020 09:21:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F160AC0889;
	Wed, 30 Sep 2020 09:21:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8179C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:21:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C6A9D86852
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:21:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C0aAGAU+ykrc for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 09:21:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4A29485B36
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:21:29 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6BC882076B
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601457688;
 bh=WW8CAJWhJonVz80Z15S+f0UfVSWGlcSR9+MnjppwNVE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=D7bKfqTk7NZn7bGGx6g9rjABSHMAKQj8oaGfnwaAOaVdGURo/0X//nj2bfySKoahv
 kph+bbsNd6Ye+z9WtfBlwFUsWND1paKZ8FSYVDWv3xww1riXcp1E24Cqbn7nHQSkXL
 1wKpyifb4znNf9O6wr+4d81oz24PuWbz//k+ptlQ=
Received: by mail-ej1-f43.google.com with SMTP id nw23so1766697ejb.4
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 02:21:28 -0700 (PDT)
X-Gm-Message-State: AOAM530f7hqoPsAvWAg9qOKMEWFSIOz8uTILIS09YdQHWUzQtocj+C93
 YcsYlAYZMrtn87mnm5dgJWn2BSMouJULXZzpCxg=
X-Google-Smtp-Source: ABdhPJwdsZCPxNB8K7fSYTzc0yeFM/DWRSchSPzmJTZ1As6HEIyDEhVNDE4TT6Npkvzia8J28AdVSPLx8On9VyKD0u8=
X-Received: by 2002:a17:906:1984:: with SMTP id
 g4mr1789347ejd.119.1601457686869; 
 Wed, 30 Sep 2020 02:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
In-Reply-To: <20200930084258.25493-3-nicoleotsuka@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 30 Sep 2020 11:21:14 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeF8D0A6PGVbi_7RedO-DFd70sjGcJOjx-gCJ7Cd8k0YQ@mail.gmail.com>
Message-ID: <CAJKOXPeF8D0A6PGVbi_7RedO-DFd70sjGcJOjx-gCJ7Cd8k0YQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, digetx@gmail.com
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

On Wed, 30 Sep 2020 at 10:48, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> Previously the driver relies on bus_set_iommu() in .probe() to call
> in .probe_device() function so each client can poll iommus property
> in DTB to configure fwspec via tegra_smmu_configure(). According to
> the comments in .probe(), this is a bit of a hack. And this doesn't
> work for a client that doesn't exist in DTB, PCI device for example.
>
> Actually when a device/client gets probed, the of_iommu_configure()
> will call in .probe_device() function again, with a prepared fwspec
> from of_iommu_configure() that reads the SWGROUP id in DTB as we do
> in tegra-smmu driver.
>
> Additionally, as a new helper devm_tegra_get_memory_controller() is
> introduced, there's no need to poll the iommus property in order to
> get mc->smmu pointers or SWGROUP id.
>
> This patch reworks .probe_device() and .attach_dev() by doing:
> 1) Using fwspec to get swgroup id in .attach_dev/.dettach_dev()
> 2) Removing DT polling code, tegra_smmu_find/tegra_smmu_configure()
> 3) Calling devm_tegra_get_memory_controller() in .probe_device()
> 4) Also dropping the hack in .probe() that's no longer needed.
>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>
> Changelog
> v2->v3
>  * Used devm_tegra_get_memory_controller() to get mc pointer
>  * Replaced IS_ERR_OR_NULL with IS_ERR in .probe_device()
> v1->v2
>  * Replaced in .probe_device() tegra_smmu_find/tegra_smmu_configure()
>    with tegra_get_memory_controller call.
>  * Dropped the hack in tegra_smmu_probe().
>
>  drivers/iommu/tegra-smmu.c | 144 ++++++++++---------------------------
>  1 file changed, 36 insertions(+), 108 deletions(-)
>
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index 6a3ecc334481..636dc3b89545 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -61,6 +61,8 @@ struct tegra_smmu_as {
>         u32 attr;
>  };
>
> +static const struct iommu_ops tegra_smmu_ops;

I cannot find in this patch where this is assigned.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
