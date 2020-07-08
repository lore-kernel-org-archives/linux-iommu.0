Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4738AC433E0
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 20:37:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E74F2063A
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 20:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSgUQGtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E74F2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CBA8224A2C;
	Wed,  8 Jul 2020 20:37:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IM6Ww37cO0R9; Wed,  8 Jul 2020 20:37:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6C83122098;
	Wed,  8 Jul 2020 20:37:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59788C077B;
	Wed,  8 Jul 2020 20:37:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07B96C016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 20:37:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EA8B6887B0
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 20:37:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p0OgjQ2vs44A for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 20:37:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A571488748
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 20:37:03 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id ls15so74070pjb.1
 for <iommu@lists.linux-foundation.org>; Wed, 08 Jul 2020 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=52LwTTDHL52CPmera1ICXK0GwQWLs0yw6h+bAZf5d58=;
 b=eSgUQGtcqxtuwNGKTm8IGyagExgEIIsl3RfoodxZdaHUHC779bDDYtygQeDVaBgOKU
 +Zpcea+zd9LvHitAfpecn5O71GBpZMCuiVTDsQv3EPBjLObqKOMKhUr6Kz8LpWm/KyZr
 uhATACY3Nz19pWQsFnE/7JRpsTISoWkS+lwMbaLjnhCTl/dvfQV7mk9jj1nwVnXn3rUK
 zyDn7cJej0CAY4HDcymwpULukYtRh54U0mtg+/b+HSDP7cgyY79TTcOcumVyMdzN2ELD
 ccP4c4sSKJ+Kc/kPW/rFESldew00EQJHYwk7Mw1BYwVfwBN8nuNNf4EXf45qFTYfYzIp
 DZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=52LwTTDHL52CPmera1ICXK0GwQWLs0yw6h+bAZf5d58=;
 b=Z/x9JFYAXL2LHQrZBHMg9g0F9uArv5qr5vbyxeeRiGKa8ADRl8P8hfG/xnPKGVHes3
 +6gWqGVSVATAU25csYphS34RP8TDRKeB0h7j7NqObXYQ+z3PFMbcbAVQhebN/RFe3fAv
 3SGYZfKU+xDXNBrgH+/FPHqXx5xISaTiY1zFCP6VzFN3dq5WJd31NIz3i6uZyfh7Hw2s
 nQyeRfBwzRcgjLsCscdwjp0omtTrD7t1YFo3vf3Slf6NMLvvOYc5C703DKsTG2yWhWOE
 R5yzj364Ksxw19FgC2JnLYNmYdHagk8zZI/JkAOAOa5peQCLwnl4YIEUj3iK0FaLO+UA
 2bEw==
X-Gm-Message-State: AOAM532udpTL7BawWjZ6mLE/V1+6ToO3nJPFLiddaWb2T696bsPcy3AS
 yjZ0GPXM6QCq/7KDWfPFt3Q=
X-Google-Smtp-Source: ABdhPJwpGTiYJO8gpyu5euUywT+qnBK5iXzDI6Lx7kwvqto2YeAirm6kvWXwpcqnXfnmyFf0w2RclA==
X-Received: by 2002:a17:902:9a4b:: with SMTP id
 x11mr44361319plv.150.1594240623210; 
 Wed, 08 Jul 2020 13:37:03 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id y17sm577996pfe.30.2020.07.08.13.37.02
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 08 Jul 2020 13:37:02 -0700 (PDT)
Date: Wed, 8 Jul 2020 13:36:50 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Krishna Reddy <vdumpa@nvidia.com>
Subject: Re: [PATCH v10 3/5] iommu/arm-smmu: add NVIDIA implementation for
 ARM MMU-500 usage
Message-ID: <20200708203648.GB28080@Asurada-Nvidia>
References: <20200708050017.31563-1-vdumpa@nvidia.com>
 <20200708050017.31563-4-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200708050017.31563-4-vdumpa@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: snikam@nvidia.com, devicetree@vger.kernel.org, mperttunen@nvidia.com,
 praithatha@nvidia.com, bhuntsman@nvidia.com, will@kernel.org,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com, talho@nvidia.com,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, nicolinc@nvidia.com,
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

On Tue, Jul 07, 2020 at 10:00:15PM -0700, Krishna Reddy wrote:
> NVIDIA's Tegra194 SoC has three ARM MMU-500 instances.
> It uses two of the ARM MMU-500s together to interleave IOVA
> accesses across them and must be programmed identically.
> This implementation supports programming the two ARM MMU-500s
> that must be programmed identically.
> 
> The third ARM MMU-500 instance is supported by standard
> arm-smmu.c driver itself.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
