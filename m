Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF62C433DF
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 23:52:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42B5120776
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 23:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xh/Vue0q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B5120776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0CAF78890E;
	Mon, 29 Jun 2020 23:52:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HC231-qkMwNe; Mon, 29 Jun 2020 23:52:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2539A88498;
	Mon, 29 Jun 2020 23:52:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CF42C07FF;
	Mon, 29 Jun 2020 23:52:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDF2AC016E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 23:52:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id DCD11884AD
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 23:52:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZW1jKbd+iodp for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 23:52:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3956A88498
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 23:52:56 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id b16so8563683pfi.13
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 16:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=ZGfMUVHQlxfLiTJM1WLol0nRk5sgJRj1wqf4MkKus5s=;
 b=Xh/Vue0q76LlXZ1IVtyp0plcHCg+yS3sou6eCNEplyeHb1RBascLD5jXemJu3z6ioE
 PEQnSUC8EAaBfx1BtSvvbgAwQNJJ2ucrQrroIdlGPAQQv/7jpS25OnRr1gUi9wsK/b8D
 RXvb9lS0v+ikbVT8ubeL0uwKOXgpuTQlKgq3cZGlJyHIg97a4iDob4bDoRx23oRNdD4r
 xS4iFrH3Nj5YbxJ5wrinYNGmgIzT/kcoFq6Q4gZt8F4LDM8PTotHdQ34JLVbDkoMMSoG
 EZmJRILAhOY7EzQ4a7o/NpFeYhXMbTo5ogcOKUxCV0/o/kqWxbIp7d4kZl3BvTlhgcMg
 2qdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZGfMUVHQlxfLiTJM1WLol0nRk5sgJRj1wqf4MkKus5s=;
 b=Xe7nXXRr/j6GRnBJTZXka8d8pPZZRjIpgmf8bvbagdM+rDMDMFPPVLpMgzyfb2olFi
 tp9GOpcLu9g6NH4tApju0GfuAqwir7udJLWXUj2rQApsxkTFsclhVa6D/a+KEJaYGhVh
 KRHgbQtYKgxO1t4c2eb7iPWqTizqayngdYU6sKtON73XBx9mAdyr5tGt/xyRWbb1yQ70
 uvUCBDAqtSE0dOz3gIHR5YSnRGTwQGUuldvDg8rBC7vUpElDfj63BkPPXykq1/B6QQjJ
 1+XxNhwhfbJdvTl9dp37Nje40aeWQyRLWCjMkzebJueHmOCFSVaLNebEYl47+FSsOsp8
 xqUg==
X-Gm-Message-State: AOAM5310XiOTjPOm9O5OsytoNF1sp8YM+n6RpMhWDlB0HQf1ZxX9FWtv
 ES5CEt9Ur9eTeUR1g2UK3Ng=
X-Google-Smtp-Source: ABdhPJyHRiIXYw7M7C5K2woDsZLaiq4jmATiThuvEjJzM6tygMJ9vTs50c26tg/Ye6SHSxXi2HFHdA==
X-Received: by 2002:aa7:988f:: with SMTP id r15mr7658817pfl.2.1593474775473;
 Mon, 29 Jun 2020 16:52:55 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id y18sm662361pff.10.2020.06.29.16.52.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 29 Jun 2020 16:52:55 -0700 (PDT)
Date: Mon, 29 Jun 2020 16:52:20 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Krishna Reddy <vdumpa@nvidia.com>
Subject: Re: [PATCH v7 1/3] iommu/arm-smmu: add NVIDIA implementation for
 dual ARM MMU-500 usage
Message-ID: <20200629235219.GA14616@Asurada-Nvidia>
References: <20200629022838.29628-1-vdumpa@nvidia.com>
 <20200629022838.29628-2-vdumpa@nvidia.com>
 <20200629215124.GD27967@Asurada-Nvidia>
 <BYAPR12MB2822B08564C7BD7212DCCEFEB36E0@BYAPR12MB2822.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR12MB2822B08564C7BD7212DCCEFEB36E0@BYAPR12MB2822.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Sachin Nikam <Snikam@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 Bryan Huntsman <bhuntsman@nvidia.com>, "will@kernel.org" <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Pritesh Raithatha <praithatha@nvidia.com>, Timo Alho <talho@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Nicolin Chen <nicolinc@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Yu-Huan Hsu <YHsu@nvidia.com>, Thierry Reding <treding@nvidia.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Bitan Biswas <bbiswas@nvidia.com>
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

On Mon, Jun 29, 2020 at 10:49:31PM +0000, Krishna Reddy wrote:
> >> +     if (!nvidia_smmu->bases[0])
> >> +             nvidia_smmu->bases[0] = smmu->base;
> >> +
> >> +     return nvidia_smmu->bases[inst] + (page << smmu->pgshift); }
> 
> >Not critical -- just a nit: why not put the bases[0] in init()?
> 
> smmu->base is not available during nvidia_smmu_impl_init() call. It is set afterwards in arm-smmu.c.
> It can't be avoided without changing the devm_ioremap() and impl_init() call order in arm-smmu.c. 

I see...just checked arm_ssmu_impl_init().
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
