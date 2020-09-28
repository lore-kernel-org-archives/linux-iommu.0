Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C643C4727F
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 19:38:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958DF22204
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 19:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJNKn7JT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958DF22204
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2619E86F95;
	Mon, 28 Sep 2020 19:38:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MqQ-RkW186oA; Mon, 28 Sep 2020 19:38:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id F208386F6D;
	Mon, 28 Sep 2020 19:38:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB10AC016F;
	Mon, 28 Sep 2020 19:38:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9AD9C0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 19:38:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 92B7A86F79
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 19:38:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id drCHIdKwvEdj for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 19:38:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
 [209.85.216.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0CB4D86F6D
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 19:38:47 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id a9so1284044pjg.1
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=PvTQsN4lpGwG4bNurmMUhGfYEfi6y08HRQbRjBGRPr4=;
 b=AJNKn7JTkfaZWtYcKjnLpI83Sh4ohhpITVcw5SKfptBltLlJ8F1Q7Rxw1/Ch3Nmklr
 4ItvKqn/0VTCFRoP9m8+jQHchDQdnY4n1HvUnaqxq/zKFtHq2CMlziEGwZ3E8yaDfXsu
 vgiQE6l0m6TLpXKl4vqzfTG0UETd0OiQHvbGlbUcaBwFc1AL9gpVvCEa9LH2dMstyrZB
 lPxD294GyKHV0gpy1lx0gulhZMLcN1tn8skrdpIYb7jrhbafFj1qvalvpsZGBfP7omAv
 j3K7yxyM3Bb/4ZupYNrWTUITOjHh10ON5WDvlerBpRtJ57lcEVoURlcNLoSCCXQZ0QKL
 t7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=PvTQsN4lpGwG4bNurmMUhGfYEfi6y08HRQbRjBGRPr4=;
 b=jNywri81cfVx3ndJtl27KMv5KNN2IU8EJncD+tgNISn74K3ZeKTT1GbPG4bp2nXDDe
 /hBXTuiArbZXhhYnw5FDVtUkoCtN4TI2xPN+Ezyb3Eq5S+/75hpO4Z+5vZcx/KQpYS2H
 vm5rudoqHljFJxTyRqzlakDlcXEMb7cEPqzYAwc4NrWOP4C5VTxojO9BDyLxJ4NPGCq/
 6EdH9iDnbo3vjB4w6KGq7H/c7+GGAeFDt9nfiGwSIWI6m03/9vqEchkwp4Q7fADtWG1S
 UOEN1/jxzNkHBkxsZ9AfXy2+jkf42X1a8wGSjhRtNO7s1RIrMrz6ji3ok0m7VYc8EqxP
 GrdA==
X-Gm-Message-State: AOAM5311xcil2Nwq0M9lb0wuWNHJtGJdUksrc56dIoeDWZU6PU1IvXvQ
 Lh2Jw7w6Rq+5wF9toNZ6Eys=
X-Google-Smtp-Source: ABdhPJyF7ovAy2Q8BmAUiZrG9WO75KHcCu3kDg52GYU/f+Na8ljFsJelKts82PPVgVv3EihaUWaHaA==
X-Received: by 2002:a17:90a:1188:: with SMTP id
 e8mr691936pja.185.1601321926605; 
 Mon, 28 Sep 2020 12:38:46 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id gb19sm2111133pjb.38.2020.09.28.12.38.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Sep 2020 12:38:46 -0700 (PDT)
Date: Mon, 28 Sep 2020 12:33:28 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 1/5] iommu/tegra-smmu: Unwrap tegra_smmu_group_get
Message-ID: <20200928193328.GA15720@Asurada-Nvidia>
References: <20200926080719.6822-1-nicoleotsuka@gmail.com>
 <20200926080719.6822-2-nicoleotsuka@gmail.com>
 <20200928071356.GD2837573@ulmo>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200928071356.GD2837573@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, krzk@kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org
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

Hi Thierry,

Thanks for the review.

On Mon, Sep 28, 2020 at 09:13:56AM +0200, Thierry Reding wrote:
> > -static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
> > -						unsigned int swgroup)
> > +static struct iommu_group *tegra_smmu_device_group(struct device *dev)
> >  {
> > +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
> >  	const struct tegra_smmu_group_soc *soc;
> >  	struct tegra_smmu_group *group;
> > +	int swgroup = fwspec->ids[0];
> 
> This should be unsigned int to match the type of swgroup elsewhere.
> Also, it might not be worth having an extra local variable for this
> since it's only used once.

Will change to unsigned int. There are actually a few places using
it in this function, previously tegra_smmu_group_get().
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
