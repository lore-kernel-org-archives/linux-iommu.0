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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AEEC433E1
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 00:20:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0135F2076C
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 00:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oI50TMe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0135F2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9A431204E9;
	Tue, 30 Jun 2020 00:20:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QjzGDrqSG+3h; Tue, 30 Jun 2020 00:20:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E46FA2046B;
	Tue, 30 Jun 2020 00:20:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4041C0892;
	Tue, 30 Jun 2020 00:20:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59EB4C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 00:20:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 489E8875A5
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 00:20:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HQr7F_1f-zRq for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 00:20:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D262E874FB
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 00:20:20 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id q17so8606101pfu.8
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 17:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=FWK3DfhYfO3UHL4cxXA6Y0Ld3ensf1xyhgg8G+yWtcI=;
 b=oI50TMe2xBfOzc2M0pHo5fT0QTa2wegSrqG3zYGoEyAkDSI0e0QE3MM6rwT3oiC709
 KrTrfPNNGZ5nITh7cbqTtW85whu6QeWHc3gX8l98IdxZQhOW6wzJUBsgNmf0J48kpl8L
 tTj8OqyPkLrGUsQUgfISUR83GbUHSS0oFu5YR/fSjo+A4LXKB/2HHeVUiI/nULf1E96S
 WWgsa3VDgw7Ko90vklLUbSaRp1QF8WBu1BRlNhwivnLNMKEAPNcDOUwO6jeG2HfnVcLP
 0C3Ltb80596GA9SZ4GCLK6KqC7n7baElPDg3rbev7jwqZ4FhHF1EEB+0oo28YlL5LyEr
 Ya1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=FWK3DfhYfO3UHL4cxXA6Y0Ld3ensf1xyhgg8G+yWtcI=;
 b=X1XY1JWZdfnFRIDiNylbvi2bZNl+x+qDMRbkzbKRpwiX4iZe7Q0uELTDLgeWytA/8r
 q3i4/xT1Kf6HV6m9djUU6Os74AOVi3Y9ekNvfsUOL0yXvmbVL3GedaqsA1S7lW8Ak8JW
 qThRtBHL2X/R/uuNAVFpPhWBMhQJA+gEtSZVYf/Ao4F+g973ZU/jgjqhUs9geyynBASa
 fwjcHPuu5Q891cOjGnR/wlgXsTX8UHJTK0zikqOmC2S8Lz8e9FrrRA191UKg+qZnEmR/
 OpHW2f8Ya5+DRT8lEn3yP18EsBKRb/JVRiPHMikD5gu9DFVslRQ711b6lwHu8R63WgYQ
 dpyw==
X-Gm-Message-State: AOAM532otTCvCD7Hu5VscF1wcSH6bfoSQpoBgKMUZxQVkl+MJifOZ4Y5
 Oe93Uvctl/25H6dq737aivw=
X-Google-Smtp-Source: ABdhPJyAivB5SKR3ucS3Ljurs/kgEQoxUcVTCRr2JfoIE5sQKZeOxCi0wuNgvi31rmjNjG3nBWmmoQ==
X-Received: by 2002:a63:525a:: with SMTP id s26mr12250066pgl.155.1593476420411; 
 Mon, 29 Jun 2020 17:20:20 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id f6sm715556pfe.174.2020.06.29.17.20.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 29 Jun 2020 17:20:20 -0700 (PDT)
Date: Mon, 29 Jun 2020 17:19:47 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Krishna Reddy <vdumpa@nvidia.com>
Subject: Re: [PATCH v8 3/3] iommu/arm-smmu: Add global/context fault
 implementation hooks
Message-ID: <20200630001947.GB7427@Asurada-Nvidia>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-4-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200630001051.12350-4-vdumpa@nvidia.com>
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

On Mon, Jun 29, 2020 at 05:10:51PM -0700, Krishna Reddy wrote:
> Add global/context fault hooks to allow NVIDIA SMMU implementation
> handle faults across multiple SMMUs.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
