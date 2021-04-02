Return-Path: <SRS0=DOhO=I7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7710C433ED
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 04:21:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60DFC61056
	for <iommu@archiver.kernel.org>; Fri,  2 Apr 2021 04:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DFC61056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B57D41941;
	Fri,  2 Apr 2021 04:21:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TMUBQwaWol30; Fri,  2 Apr 2021 04:21:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7A0941943;
	Fri,  2 Apr 2021 04:21:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E4F0C000B;
	Fri,  2 Apr 2021 04:21:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4195FC000A
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 04:21:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 22DA660A3A
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 04:21:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q6M3JGSgdM5n for <iommu@lists.linux-foundation.org>;
 Fri,  2 Apr 2021 04:21:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7FC1A60A39
 for <iommu@lists.linux-foundation.org>; Fri,  2 Apr 2021 04:21:55 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id p12so566055pgj.10
 for <iommu@lists.linux-foundation.org>; Thu, 01 Apr 2021 21:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WpaaAD4PmenHHvOL/jyRNYMJvLhUShrEir1c7Nvth/w=;
 b=TiJLbOXPDzTlqOKy5t1e7/FJ7kHujYcoRlmf0TDUDrdD+jIAB9lqtjO4UDN/+Xl9nY
 7d/nJ1e1UlB3HmHXr1mZ0lLpdl3ZjZRHTEr1SoofgI7XmUtSGRI6NJKNfn9tVIFF+u4A
 T5p2fCub/HvLz3VC7QesCriApf1lEOQ/uHcSjaqHFgsTtqD3xUnPvtFQylPiLUspBj/0
 u7hi9LIVl28SO/7ChuAPzlofRIEP99j833FvcqOfI0Vkj1PrEwFxDhReBA0LWRArtSEs
 Xwnk6Qx2nLc35xpHoDJv4xlCXISvv2KmZyvv8PEzF4UT3ZN2ykvHT6RmqJe+TezFcu+2
 9bbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WpaaAD4PmenHHvOL/jyRNYMJvLhUShrEir1c7Nvth/w=;
 b=gljvxP7l0rAgmDbLGgb7Isy4vfp5xNTq2ufcjyi2ix1LLZmrzkQ8xA0hnBPowLaqeP
 YU26lPL+iCdPytMVkD0ydcETpAze/MkAHG0nY1UqyH+LHttTjyOZjgGMZ2wC1gmF3AVy
 yy0lvcRRLD1VYm6LOhydK0Kw5wmDRtWeZnreApn7ciAsOAEvkr0xDc+3F/qFE8yFwvVD
 KTbAuWOrMEgfuvWNJxld4GoHGF+pnPoFhUgsPf2R9bSjcDKhwdsk1jnb+bCxOkofZRcB
 /bGYxbcjD0WVWSTYAuMKZT0Xv6glA/IzofHv0j/IT/WY0AlSWXF5oX/ST1zHaDHdCjOa
 uvxg==
X-Gm-Message-State: AOAM531PufqdG5uPRlDQw2Roy/zwD48kvErqKmJs3/Wp+kWpQbMmtXyi
 Gp/JPI5jaPnxyO6Q5S/3n+w=
X-Google-Smtp-Source: ABdhPJyMgaBfBZCLfajiEHBf2YuYh0t6oFpmY6xtz0Nj9SKi5CRXY7FXqgFjYwPvIDhkjivbml4vhQ==
X-Received: by 2002:a62:1ad5:0:b029:1fa:c667:2776 with SMTP id
 a204-20020a621ad50000b02901fac6672776mr10524988pfa.6.1617337314902; 
 Thu, 01 Apr 2021 21:21:54 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id v13sm6423592pfu.54.2021.04.01.21.21.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 01 Apr 2021 21:21:54 -0700 (PDT)
Date: Thu, 1 Apr 2021 21:19:56 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v5] iommu/tegra-smmu: Add pagetable mappings to debugfs
Message-ID: <20210402041954.GB31146@Asurada-Nvidia>
References: <20210315203631.24990-1-nicoleotsuka@gmail.com>
 <YFCTmwpg9pMQqcSu@orome.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YFCTmwpg9pMQqcSu@orome.fritz.box>
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

On Tue, Mar 16, 2021 at 12:16:43PM +0100, Thierry Reding wrote:

> > +struct tegra_smmu_group_debug {
> > +	const struct tegra_smmu_swgroup *group;
> > +	void *priv;
> 
> This always stores the address space, so why not make this:
> 
> 	struct tegra_smmu_as *as;
> 
> ? While at it, perhaps throw in a const to make sure we don't modify
> this structure in the debugfs code.

OK. I will try to change that.

> > @@ -334,7 +350,7 @@ static void tegra_smmu_domain_free(struct iommu_domain *domain)
> >  }
> >  
> >  static const struct tegra_smmu_swgroup *
> > -tegra_smmu_find_swgroup(struct tegra_smmu *smmu, unsigned int swgroup)
> > +tegra_smmu_find_swgroup(struct tegra_smmu *smmu, unsigned int swgroup, int *index)
> >  {
> >  	const struct tegra_smmu_swgroup *group = NULL;
> >  	unsigned int i;
> > @@ -342,6 +358,8 @@ tegra_smmu_find_swgroup(struct tegra_smmu *smmu, unsigned int swgroup)
> >  	for (i = 0; i < smmu->soc->num_swgroups; i++) {
> >  		if (smmu->soc->swgroups[i].swgroup == swgroup) {
> >  			group = &smmu->soc->swgroups[i];
> > +			if (index)
> > +				*index = i;
> 
> This doesn't look like the right place for this. And this also makes
> things hard to follow because it passes out-of-band data in the index
> parameter.
> 
> I'm thinking that this could benefit from a bit of refactoring where
> we could for example embed struct tegra_smmu_group_debug into struct
> tegra_smmu_group and then reference that when necessary instead of
> carrying all that data in an orthogonal array. That should also make
> it easier to track this.
> 
> Come to think of it, everything that's currently in your new struct
> tegra_smmu_group_debug would be useful in struct tegra_smmu_group,
> irrespective of debugfs support.

Will try to embed it or see what I can do following the suggestion.

> > +static int tegra_smmu_mappings_show(struct seq_file *s, void *data)
> > +{

> > +	seq_printf(s, "\nSWGROUP: %s\nASID: %d\nreg: 0x%x\n",
> > +		   group->name, as->id, group->reg);
> 
> Is group->reg really that useful here?

Can drop it.

> > +
> > +	smmu_writel(smmu, as->id & 0x7f, SMMU_PTB_ASID);
> > +	ptb_reg = smmu_readl(smmu, SMMU_PTB_DATA);
> > +
> > +	seq_printf(s, "PTB_ASID: 0x%x\nas->pd_dma: %pad\n",
> > +		   ptb_reg, &as->pd_dma);
> 
> This looks somewhat redundant because as->pd_dma is already part of the
> PTB_ASID register value. Instead, perhaps decode the upper bits of that
> register and simply output as->pdma so that we don't duplicate the base
> address of the page table?

That's a good idea. Will change that too.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
