Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE01C4727E
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 20:09:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178D32074B
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 20:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMfd5xc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178D32074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9C35887139;
	Wed, 30 Sep 2020 20:09:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M0kKwq4-Qlir; Wed, 30 Sep 2020 20:09:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6CEA686F63;
	Wed, 30 Sep 2020 20:09:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C985C016F;
	Wed, 30 Sep 2020 20:09:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73FF1C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 20:09:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 619B986F66
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 20:09:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MZ+g0UyHKzrT for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 20:09:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com
 [209.85.216.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 113BE86F63
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 20:09:09 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id l18so427830pjz.1
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 13:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=mF6OBaV2Z1T8RbNcXXxjuhHlV5z+chFjrK3EuAVe1S8=;
 b=WMfd5xc6Ph1nthN0qdG7EhSNrzY9LYw5S+OUHOHhgFtZJNGp2pQCw8EmtS8P9yvkBw
 CpzKZQo9nwNWp5AGk0iByMUP5px/NhZ6r6c6nnk8GI+ndf/ieAHdqBvloSKRa3Bv7AZk
 gBhlPdnnUskp/hUCnpCHIASdSeY81XNcOgOLzmhBIbHtcaKZeqMzuTaFVafxC/e6T8d4
 bxpc0xnq1gDAwmw93cNgUpDOrCDE7AKyy9wcEvB6srPfBeB7erDn64vEUIjn3bzCwd+1
 o0YMsAlAFnM17TxLmwu2rC30iWU/tlaUQEm+GEbKqXM3/kO3NHh/VD8ysH8NKniHMdOY
 cbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=mF6OBaV2Z1T8RbNcXXxjuhHlV5z+chFjrK3EuAVe1S8=;
 b=naQ0Ixd1mDcAVmaPt78pVHuelP5qz/2d7W6uxyJh1BglLqe08GVt0l7m8yqTrIKViz
 q7KVN2mUsO0W23Ou/sj2ndKxuSR5SVnddW1jRzhWervCG+/Ouv8jVt5Dx/x8YbMXZzbF
 NhehxumFibGXAyZ0xOG4O5ZHtzb0n49GEXwSmVM/qSJPiqq7AhIR6rI59R+e0ENRZn9h
 Lp9Nc/VyUX7dPshC5mLo4PSC23/n9beDUVHw7i/OuXgwMm1wXYMx5+yNWaeMNuffkSP8
 9zw8PMWnaD6Cb+nSkfB2ed/3P52TbZdAGGU96hc5aUWlh313/fLCnbygdZTNCfKYTJqa
 IyYA==
X-Gm-Message-State: AOAM532rCBn4uM3qkHLyJvFyIBXz+sYkTIL2+Lo2VsuJua9iU5WbOrRp
 sUn6hYXitwivoJDUXwwK1gg=
X-Google-Smtp-Source: ABdhPJzgWRMrpNTOiKpQZHAAZjzyGRR1vepTsaY3MKRWSEnOwicW3KYudNirETxFSWRE5W3Gctye9Q==
X-Received: by 2002:a17:90a:dc13:: with SMTP id
 i19mr4078281pjv.18.1601496548639; 
 Wed, 30 Sep 2020 13:09:08 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id v21sm3171041pjn.4.2020.09.30.13.09.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Sep 2020 13:09:08 -0700 (PDT)
Date: Wed, 30 Sep 2020 13:03:31 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3 3/3] iommu/tegra-smmu: Add PCI support
Message-ID: <20200930200331.GB2110@Asurada-Nvidia>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-4-nicoleotsuka@gmail.com>
 <0a308ee8-abf7-97e4-9814-2156ee56fe8b@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0a308ee8-abf7-97e4-9814-2156ee56fe8b@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
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

On Wed, Sep 30, 2020 at 05:53:20PM +0300, Dmitry Osipenko wrote:
> ...
> > +#ifdef CONFIG_PCI
> > +	if (!iommu_present(&pci_bus_type)) {
> 
> 
> In the previous reply you said that you're borrowing this check from the
> arm-smmu driver, but arm-smmu also has a similar check for
> platform_bus_type, while Tegra SMMU driver doesn't have it. Hence I'm
> objecting the necessity of having this check.
> 
> Please give a rationale for having this check in the code. And please
> note that cargo cult isn't a rationale to me.

Okay, okay....I will remove it upon testing.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
