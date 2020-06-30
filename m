Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0435AC433E0
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 00:17:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C36F92078A
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 00:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGMguE63"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36F92078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A6D39869C0;
	Tue, 30 Jun 2020 00:17:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DjUVysFGEFy3; Tue, 30 Jun 2020 00:17:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 36C2F869B8;
	Tue, 30 Jun 2020 00:17:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F88BC0865;
	Tue, 30 Jun 2020 00:17:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 284D2C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 00:17:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1E4EB8833F
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 00:17:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TAAxoYo+xtGg for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 00:17:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 96E81882AF
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 00:17:29 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id bj10so2513155plb.11
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 17:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=r1HqfD/T3DXsPo/ucZfIExKmt+62jYYO7GR0w6MGnrg=;
 b=VGMguE63P+6tyLQphqof7eKCF+lWUxjAISwvkTNF2WydMdZCobJ4u7yG98h7BCbg2R
 9P3b+Vweraar11ot4d9paM+T6u1jN/naTc+NhqG0Qak9E0lq6Mf0LHumd/R4b/hJBp6z
 co34Fk2QfFcPIzQcYE0T4qbFVL+RnUYWf6ELHdhR0Dh1bG7ey5oaxlcm+Y/JZTKYAw6o
 MQ93MiOChqz43N5JkM4Ttoe9tz77mfhF+2uVo6/WYVwA/vYPvXzHyBQ0imN5F7Pgl9cx
 ZG9QxKSBpdc68xOImv76r4YpM4ltXdPGzLznPuj4tqjOnQ4lp/jWsExizaQQm0iZdB0p
 mhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=r1HqfD/T3DXsPo/ucZfIExKmt+62jYYO7GR0w6MGnrg=;
 b=OiSNVOHHt5ZST6J2rMI7xIYQIj8pZFPV5iESwVc+Kqisp9CCe4w+2ENxU0t6zof65f
 ryTaaub8g0MWm14UZ2x9F/KqlZBR2fbFgVvmzL1ZrlZS9rpNMbmZ60Tz2BDR/Zqi8yrO
 AR+sTRXAAfc0eFBaxH/bV/88fVBwwXwfJLALhEJl9R4JUJMLO5ND0ndBHHbbydtjURFP
 nA0A4RVm3Jw6DffJAYatBZg7sPmQ5ez3a2xcbLOO2TxtlDEv0wAbx9Q9ZcWr2PTjkKH+
 nMg/8SN07fHXByQDPKvnjzYCkTQoXQaR8hMvTQ7NbqcXw9u3bhzaakt+u0L5VM0ijD5T
 /XLQ==
X-Gm-Message-State: AOAM530KO1oeBzCJC7IlAXKYn8UlPeDcpNYMHiKsBC2UWwNQMRPvLti5
 r087XzjZ7yuJfCCrEigvq7Y=
X-Google-Smtp-Source: ABdhPJyHaDJnlJiCoOdivw7ePpICgj7y00rh35CZ6z0jFTTfgqoZujwp/mFfMrLvO7rOd6cL+KWRCg==
X-Received: by 2002:a17:90a:a109:: with SMTP id
 s9mr21152590pjp.156.1593476249136; 
 Mon, 29 Jun 2020 17:17:29 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id 83sm703309pfu.60.2020.06.29.17.17.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 29 Jun 2020 17:17:28 -0700 (PDT)
Date: Mon, 29 Jun 2020 17:16:53 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Krishna Reddy <vdumpa@nvidia.com>
Subject: Re: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for
 dual ARM MMU-500 usage
Message-ID: <20200630001652.GA7427@Asurada-Nvidia>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-2-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200630001051.12350-2-vdumpa@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: snikam@nvidia.com, mperttunen@nvidia.com, bhuntsman@nvidia.com,
 will@kernel.org, linux-kernel@vger.kernel.org, praithatha@nvidia.com,
 talho@nvidia.com, iommu@lists.linux-foundation.org, nicolinc@nvidia.com,
 linux-tegra@vger.kernel.org, yhsu@nvidia.com, treding@nvidia.com,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, bbiswas@nvidia.com
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

On Mon, Jun 29, 2020 at 05:10:49PM -0700, Krishna Reddy wrote:
> NVIDIA's Tegra194 SoC uses two ARM MMU-500s together to interleave
> IOVA accesses across them.
> Add NVIDIA implementation for dual ARM MMU-500s and add new compatible
> string for Tegra194 SoC SMMU topology.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
