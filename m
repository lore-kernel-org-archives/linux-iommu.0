Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A179C4727E
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 09:46:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AA6F2075F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 09:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2mQDBcC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA6F2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7369F8650F;
	Wed, 30 Sep 2020 09:46:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UGe8WHSu73Th; Wed, 30 Sep 2020 09:46:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D9E3785AB9;
	Wed, 30 Sep 2020 09:46:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD6BCC0889;
	Wed, 30 Sep 2020 09:46:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 832BBC0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:46:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7933485EC6
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:46:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6taL0Xs_foO7 for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 09:46:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E5ECE85AB5
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:46:07 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id c3so704486plz.5
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 02:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=w6x76gtOHsFZbRIC64IzxvoZiSxuFZiWjvjCw4IeBQg=;
 b=p2mQDBcCc34wHPCS1PNzUjlkF5oBkaoVSc4y0UTqBTEU0wukBKhr3l7IugLFhsWwPk
 sBCNpg2XDBk2OENMWkcxe87s5sTNnAguKCXJ6TDg0ls1rcGx0XE7jUu5FlJ7zDFPzzEX
 2HzpcJjkCPTBS1Ppm4WKw0azG0UEKk1tjgWweFP0qty95Bj5RJ2laAt37HL+UhYr84ET
 5e6ww1KK+tiIzJtD09T1/N6lgRK8YaMCWpGRjgcyGZ7ci/KArqSTfDL0wvfQ+6yfCzRr
 NpL977c4gkkhKnv3cQBQGpUIUkJiFUDixoD5gzENfM+OELC4byQ2AvKrHFt8FeG0C9OR
 xXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=w6x76gtOHsFZbRIC64IzxvoZiSxuFZiWjvjCw4IeBQg=;
 b=NygCqchq9oSPaYuvUEqHOFKMEszB7WeM3UF7iDBP5tmVbTSe5UGwJynqV9rRfP8dgQ
 t93QVUzwyZoInb+PFuCP9l8SOq/Y22Nk2tAdg1UcL/hLTn43Ml50dirg8TLVXMM+aAcF
 wOGjXUcgLMZ9q/RMOaT5mFoTD4BX8oo/JDqmMQK9JXIUppZvzsUj3XE3ttaTmIhS2gxS
 nvZ1pCAsgsPNfmIcNBJwZRSLTBsZajbc8Y4s5GVVBT/BbQalwaFeLCE7oLerhwY/yAvK
 lCaz27YulpF2NoW0vksS8T43SW0GKz1k6gTtjxRNUFXfnCKJMOoLaGIMvEUHArS63xdJ
 4BYA==
X-Gm-Message-State: AOAM532zKlMjkwPF4axJzz2Kcf9taIoUaXEnYYYo38qGDhHnoS2jIBMR
 ne9v4YArquEoN8zrBtlvlFQ=
X-Google-Smtp-Source: ABdhPJzm6vd4n3L4meRW311HnXuqF9jAY2zYIatqFAbTkPoW7zP6m1SSm9AGlDm9UQ7WkSMcF9YWjQ==
X-Received: by 2002:a17:90b:33cb:: with SMTP id
 lk11mr1797687pjb.98.1601459167352; 
 Wed, 30 Sep 2020 02:46:07 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id j26sm1890991pfa.160.2020.09.30.02.46.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Sep 2020 02:46:07 -0700 (PDT)
Date: Wed, 30 Sep 2020 02:40:32 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20200930094032.GA6686@Asurada-Nvidia>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <CAJKOXPeF8D0A6PGVbi_7RedO-DFd70sjGcJOjx-gCJ7Cd8k0YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJKOXPeF8D0A6PGVbi_7RedO-DFd70sjGcJOjx-gCJ7Cd8k0YQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

On Wed, Sep 30, 2020 at 11:21:14AM +0200, Krzysztof Kozlowski wrote:
> On Wed, 30 Sep 2020 at 10:48, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > Previously the driver relies on bus_set_iommu() in .probe() to call
> > in .probe_device() function so each client can poll iommus property
> > in DTB to configure fwspec via tegra_smmu_configure(). According to
> > the comments in .probe(), this is a bit of a hack. And this doesn't
> > work for a client that doesn't exist in DTB, PCI device for example.
> >
> > Actually when a device/client gets probed, the of_iommu_configure()
> > will call in .probe_device() function again, with a prepared fwspec
> > from of_iommu_configure() that reads the SWGROUP id in DTB as we do
> > in tegra-smmu driver.
> >
> > Additionally, as a new helper devm_tegra_get_memory_controller() is
> > introduced, there's no need to poll the iommus property in order to
> > get mc->smmu pointers or SWGROUP id.
> >
> > This patch reworks .probe_device() and .attach_dev() by doing:
> > 1) Using fwspec to get swgroup id in .attach_dev/.dettach_dev()
> > 2) Removing DT polling code, tegra_smmu_find/tegra_smmu_configure()
> > 3) Calling devm_tegra_get_memory_controller() in .probe_device()
> > 4) Also dropping the hack in .probe() that's no longer needed.
> >
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> >
> > Changelog
> > v2->v3
> >  * Used devm_tegra_get_memory_controller() to get mc pointer
> >  * Replaced IS_ERR_OR_NULL with IS_ERR in .probe_device()
> > v1->v2
> >  * Replaced in .probe_device() tegra_smmu_find/tegra_smmu_configure()
> >    with tegra_get_memory_controller call.
> >  * Dropped the hack in tegra_smmu_probe().
> >
> >  drivers/iommu/tegra-smmu.c | 144 ++++++++++---------------------------
> >  1 file changed, 36 insertions(+), 108 deletions(-)
> >
> > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> > index 6a3ecc334481..636dc3b89545 100644
> > --- a/drivers/iommu/tegra-smmu.c
> > +++ b/drivers/iommu/tegra-smmu.c
> > @@ -61,6 +61,8 @@ struct tegra_smmu_as {
> >         u32 attr;
> >  };
> >
> > +static const struct iommu_ops tegra_smmu_ops;
> 
> I cannot find in this patch where this is assigned.

Because it's already set in probe():
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/iommu/tegra-smmu.c#n1162

And my PATCH-3 sets it for PCI bus also.

Thanks
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
