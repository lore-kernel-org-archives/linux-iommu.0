Return-Path: <SRS0=VyMr=O3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EFDC433EF
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 20:37:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ECC160F51
	for <iommu@archiver.kernel.org>; Thu,  7 Oct 2021 20:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7ECC160F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18BEE60754;
	Thu,  7 Oct 2021 20:37:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JHoyNlAJIpjv; Thu,  7 Oct 2021 20:37:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F417F605C1;
	Thu,  7 Oct 2021 20:37:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB06BC0011;
	Thu,  7 Oct 2021 20:37:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 739D4C000D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 20:37:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6F0BE401AD
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 20:37:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0_fR8KrX1Q3x for <iommu@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 20:37:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 946BE400F7
 for <iommu@lists.linux-foundation.org>; Thu,  7 Oct 2021 20:37:19 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id 75so944444pga.3
 for <iommu@lists.linux-foundation.org>; Thu, 07 Oct 2021 13:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=/R6h2Xb41+ZaL3s6zRGcSwU7ER8EXS0p7pKvPqDNMfk=;
 b=L6g7yBOFXxdPb9Sw7whNFWQtYTIW8g0VqYh6a43KbeHiW0W3tdpWnLy//caAJsFdas
 gZTblvWzCyBXOcFPMAY2u030GV2zbAWPtwLPC52ofNnui+8Ta9oaGW9G9oZUDgBJYM4r
 /zH3pDcHHiWAtFNfxQKjdueMGJsVVhrW7vh8oqYbmUgVqUmMzjSVG651It3EP4LCP8RI
 3kJDljtbgyH+v+X4TNh7HlA394H9uFMMHOz8l8Z3ammocv/8Nj6LdZpXVh74TdTdargp
 CMgAHS9h1W0TNprmb16TRkVstAYWmuqEv5MIUc4AXzJyOiR3+GBcn5wb5HUtJ9vrzAM+
 C4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=/R6h2Xb41+ZaL3s6zRGcSwU7ER8EXS0p7pKvPqDNMfk=;
 b=bsTkMMZXMR9pvB20i1Yq6lFm+FUL+9wuiP3/Hakbk+8Mv97FDe09hFFlcCd7+Z8vAe
 Ps7ZpcWNaaQw5tDlEWAMFZtGQkcDoR01Cx+6GjOY1VO6Bqn3UBkX2hGF9Geu8feDhbdk
 52hyFLQSafdzoelqwP/lfL5zjumn2RPfZRXC9pL2lObG8ruYtwUtvXSxrYWhEIG+rQTA
 SfhYGj3Rzv22Lhap+dy5Ypw12Hvlz2k3ikVK5TDfGC9X9sjYpOx5GmhaGWXb7CCebCdV
 +nheTrGZE7suG6pBe2WsiigLC6MWU5COknUe7H9H5utei5rWv296ITeMOxoxlVc6XGLG
 VR6Q==
X-Gm-Message-State: AOAM533fS6XHBgUXXqspOMRtA3nvcNeIC3NvkmjNjjcVxhATEwTPU0zb
 cZroHpcBvWviJs5DEB989wI=
X-Google-Smtp-Source: ABdhPJyxnnukeMgGct7B/INdlC+uTL5TVWEre3A7xHinHV428Lh7zSEjFjOwZvXHlHGRTg3XVZj8FA==
X-Received: by 2002:a63:4b63:: with SMTP id k35mr1394325pgl.206.1633639038818; 
 Thu, 07 Oct 2021 13:37:18 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id p2sm129926pja.51.2021.10.07.13.37.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Oct 2021 13:37:18 -0700 (PDT)
Date: Thu, 7 Oct 2021 13:29:45 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v6 3/6] iommu/tegra-smmu: Rename struct
 tegra_smmu_swgroup *group to *swgrp
Message-ID: <20211007202945.GB20821@Asurada-Nvidia>
References: <20210914013858.31192-1-nicoleotsuka@gmail.com>
 <20210914013858.31192-4-nicoleotsuka@gmail.com>
 <YV8m+0qP2ibQBvNs@orome.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YV8m+0qP2ibQBvNs@orome.fritz.box>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org, digetx@gmail.com,
 will@kernel.org
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

On Thu, Oct 07, 2021 at 06:57:31PM +0200, Thierry Reding wrote:
> On Mon, Sep 13, 2021 at 06:38:55PM -0700, Nicolin Chen wrote:
> > There are both tegra_smmu_swgroup and tegra_smmu_group structs
> > using "group" for their pointer instances. This gets confusing
> > to read the driver sometimes.
> > 
> > So this patch renames "group" of struct tegra_smmu_swgroup to
> > "swgrp" as a cleanup. Also renames its "find" function.
> > 
> > Note that we already have "swgroup" being used for an unsigned
> > int type variable that is inside struct tegra_smmu_swgroup, so
> > it's not able to use "swgroup" but only something like "swgrp".
> > 
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> >  drivers/iommu/tegra-smmu.c | 34 +++++++++++++++++-----------------
> >  1 file changed, 17 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> > index a32ed347e25d..0f3883045ffa 100644
> > --- a/drivers/iommu/tegra-smmu.c
> > +++ b/drivers/iommu/tegra-smmu.c
> > @@ -334,35 +334,35 @@ static void tegra_smmu_domain_free(struct iommu_domain *domain)
> >  }
> >  
> >  static const struct tegra_smmu_swgroup *
> > -tegra_smmu_find_swgroup(struct tegra_smmu *smmu, unsigned int swgroup)
> > +tegra_smmu_find_swgrp(struct tegra_smmu *smmu, unsigned int swgroup)
> 
> This makes things inconsistent now. The tegra_smmu_find_swgroup() name
> indicates that we're looking for some "swgroup" entity within an "smmu"
> object. The entity that we're looking for is a struct tegra_smmu_swgroup
> so I think it makes sense to use that full name in the function name.

This is more like an indirect change to keep consistency between
function name and pointer name.

> >  {
> > -	const struct tegra_smmu_swgroup *group = NULL;
> > +	const struct tegra_smmu_swgroup *swgrp = NULL;
> 
> I don't think the existing naming is confusing. The variable name
> "group" is consistently used for tegra_smmu_swgroup structures and there
> are no cases where we would confuse them with struct tegra_smmu_group
> instances.

If we don't rename it, then PATCH-4 adds to struct tegra_smmu_group
a "struct tegra_smmu_swgroup *group", which results in a confusing
group->group...

> However, I don't feel strongly about it, so I'm fine with changing the
> variable names to "swgrp" if you think that makes things less confusing.

Yea, I'd like to keep this change. I will respin it in next version
after fixing other comments.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
