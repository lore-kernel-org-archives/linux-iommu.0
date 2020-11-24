Return-Path: <SRS0=f5WA=E6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C31C63777
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 21:22:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E7D720857
	for <iommu@archiver.kernel.org>; Tue, 24 Nov 2020 21:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9gGuWbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7D720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D5CB08647E;
	Tue, 24 Nov 2020 21:22:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W1Mplj8gELQN; Tue, 24 Nov 2020 21:22:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6B337863E0;
	Tue, 24 Nov 2020 21:22:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FF48C163C;
	Tue, 24 Nov 2020 21:22:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDD60C0052
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 21:22:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B7A8D87331
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 21:22:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hq8P3T0-CBau for <iommu@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 21:22:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4531B856B8
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 21:22:28 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id 34so323443pgp.10
 for <iommu@lists.linux-foundation.org>; Tue, 24 Nov 2020 13:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=lXcYXoNVYyBl/v8uATa3c6wAjQJYnbcQgq2r1GB/dQM=;
 b=F9gGuWbMPILK+mWrq2XTN2QS2w9vYFb4ZOquS6WbuWvw+LM/7WzzFQtDuLrnoKchjT
 TCBmtpGMnzzEAMJJSs5hVkQeB1FdGyD89m8JYO99K69vGnyEpgwG0yvCnvJqZzqyr6GU
 Mg54/aJGRzJw3p/XabvBfklZ5+09xsJflN99a0vDYxX1E+zWzlQNT0BwON1Wc8M3U0r2
 R72DFVDrPGeYkN750cKrg8R4DHYNKlGJXBiTJGSARmdqgP++p3sv3rywWBoMnT4SeKow
 EMSrXyNEbB/kK5ctZGsqFTm3zXumb94MGdxUWQpwO0dbJc5RdkKDNjXb7VPOzoxIvsk9
 FS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lXcYXoNVYyBl/v8uATa3c6wAjQJYnbcQgq2r1GB/dQM=;
 b=m1MS4H8aWDKcikiFbMwkOkGW78bYacPk6HOP8yPK+HWM0YIMoZ6p8PTmqUtN4SDjid
 V04FF3joHVd8s9kHz/z//DIQFoP/9+l9sLnIVQRm41gO3G7VRbHWn20eJnqVxEJFmfJ9
 ifk0OQGqST19AUG0OXewdBnKpktkBkZ+JYd5sRq2+lCuEy7a7C3tZNhHD7xLeG2sbvM9
 JTnC8JKURCu+kaVBQlNN5e8f/nngLz65p8xv/pCQFboKRRpiouOBoYCfE1Ny0Ap3gMB0
 S0PnmjDUC8ojDWQwk+0/IU8AEWNEHzXPLPyFaXXB7/tgVCJN12UqHv/Eoo+X8KPZ0bWM
 9CyA==
X-Gm-Message-State: AOAM533Ab/Onv2PtqCufy2j2CSZPZtHZYuISAaDarYoRuG378Z9LNzb7
 Ve/hirwCur9vLrb6dna7rEk=
X-Google-Smtp-Source: ABdhPJyTW6/NYxqbtf9PHOWGAMel2/Z3XjCTxBGeVzlqahz5Y9lUVWrEOQ//RTskRi1rN9MfmWv9LQ==
X-Received: by 2002:a62:ddcb:0:b029:197:faf2:e8b4 with SMTP id
 w194-20020a62ddcb0000b0290197faf2e8b4mr250681pff.75.1606252947842; 
 Tue, 24 Nov 2020 13:22:27 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id w15sm143484pjy.47.2020.11.24.13.22.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 24 Nov 2020 13:22:27 -0800 (PST)
Date: Tue, 24 Nov 2020 13:21:01 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: joro@8bytes.org
Subject: Re: [PATCH RESEND 0/5] iommu/tegra-smmu: Some pending reviewed changes
Message-ID: <20201124212100.GA32108@Asurada-Nvidia>
References: <20201111222129.15736-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201111222129.15736-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, jonathanh@nvidia.com
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

Hi Joerg,

These five patches were acked by Thierry and acked-n-tested by
Dmitry a while ago. Would it be possible for you to apply them?

Thanks!

On Wed, Nov 11, 2020 at 02:21:24PM -0800, Nicolin Chen wrote:
> This is a merged set of resend for previously two series of patches
> that were reviewed/acked a month ago yet have not got applied.
> 
> Series-1: https://lkml.org/lkml/2020/9/29/73
> "[PATCH v4 0/2] iommu/tegra-smmu: Two followup changes"
> 
> Series-2: https://lkml.org/lkml/2020/10/9/808
> "[PATCH v7 0/3] iommu/tegra-smmu: Add PCI support"
> 
> Nicolin Chen (5):
>   iommu/tegra-smmu: Unwrap tegra_smmu_group_get
>   iommu/tegra-smmu: Expand mutex protection range
>   iommu/tegra-smmu: Use fwspec in tegra_smmu_(de)attach_dev
>   iommu/tegra-smmu: Rework tegra_smmu_probe_device()
>   iommu/tegra-smmu: Add PCI support
> 
>  drivers/iommu/tegra-smmu.c | 240 ++++++++++++++-----------------------
>  1 file changed, 88 insertions(+), 152 deletions(-)
> 
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
