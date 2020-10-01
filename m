Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C14C47420
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 10:33:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BEBA2176B
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 10:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIlhuTNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BEBA2176B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4BD1685A84;
	Thu,  1 Oct 2020 10:33:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pBW04ZZK5OpG; Thu,  1 Oct 2020 10:33:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A823084E97;
	Thu,  1 Oct 2020 10:33:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93C8CC0889;
	Thu,  1 Oct 2020 10:33:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 471BBC0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 10:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2F654230F3
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 10:33:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jXVn617KnczY for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 10:33:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 3325923115
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 10:33:25 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id jw11so1663575pjb.0
 for <iommu@lists.linux-foundation.org>; Thu, 01 Oct 2020 03:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=rGjo8l+NdpUXZUZilL4Q0g6fe7v4+HYilXIVrlEcVns=;
 b=kIlhuTNqwSTNhpHOrcs3e9r8cZPB4BQivq2B++Zm7J3/CHW/Q1TguGqKMZqeU9Etek
 rXcQE2DBMTI02L3/D7/2zw2SBASLVn7JPYyGbwvmCKZM6OOhy4ewV1MSEDCFAhJfZQto
 QoQE7DyXm+g8YWoG01UrHPNSjm6PV2+cNF/IQUanhW5bL0nJkaBH7oNnPZ7FCHECkU2E
 ERneJFOPz70xBd676Ns1f/VFEL0QcI4yxFSV5F9p8mbwe7lARibAQ7IuedFD9jtrJoai
 SThkqUcd9rE/QVJQ2RNjR8DrPFR7FOzdhfeOXK3F6s+7LflIhKxFx+DmyZrtEFN+51AP
 XstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=rGjo8l+NdpUXZUZilL4Q0g6fe7v4+HYilXIVrlEcVns=;
 b=EPPtvgrq4iHUjwReA1gJE1DcqlSWzd8oI7qAIjP1R/8McysEYiAgMp6oSEEvVOyGNe
 hWS2aTJgt/OZBFVGZkEfkhJ2jH7s3LaY2dG09WMb4yjG1HUvcp1/4CJpY5l0TcfZC2y4
 Lfrkb9TyIKbbSYqiLh9sluSn1mmYH38qH0AQcxPJ1MHeeZA82kfBnmH6OL6Ea1lWwVtU
 dCk2F0y8slao00YJP+NhuBrtRk+pv3CVD1F3y4dMUj7DXvkAIHg2z/qHAWdwFTyfgqiW
 un+ZifRb7TnWIsXTS+4eAAZLd27x6FDRbYprZsC81ZOVc54zUOfIf1mwnfiYmXagmpZ2
 S3AA==
X-Gm-Message-State: AOAM530TurnWuB5SRoqC+t7cJea31Hmhdc6mdoZ60T6Aa6CCu4Ht0pCE
 QCsuQg4cKiTaE5dsgGciAVU=
X-Google-Smtp-Source: ABdhPJzDPpJPeWaB0a9XY6UYJikyluOcFnxBCnGqwbuZq2h+kV9PGioTgzS16S8Vp0+7n2WHSE0rVg==
X-Received: by 2002:a17:90b:a44:: with SMTP id
 gw4mr6137841pjb.26.1601548404519; 
 Thu, 01 Oct 2020 03:33:24 -0700 (PDT)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
 by smtp.gmail.com with ESMTPSA id
 h5sm5432799pja.55.2020.10.01.03.33.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Oct 2020 03:33:24 -0700 (PDT)
Date: Thu, 1 Oct 2020 03:33:19 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20201001103318.GA1272@Asurada>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <20200930153131.GB3833404@ulmo>
 <20200930203618.GC2110@Asurada-Nvidia>
 <13746922-0253-cda7-e9ac-2bd20bf1a17f@gmail.com>
 <20200930213244.GA10573@Asurada-Nvidia>
 <5945a63e-79d8-e3ae-ab53-cee8c220ac7d@gmail.com>
 <20201001012630.GA28240@Asurada-Nvidia>
 <20201001095152.GD3919720@ulmo>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201001095152.GD3919720@ulmo>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>
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

On Thu, Oct 01, 2020 at 11:51:52AM +0200, Thierry Reding wrote:
> > > >> ...
> > > >>>> It looks to me like the only reason why you need this new global API is
> > > >>>> because PCI devices may not have a device tree node with a phandle to
> > > >>>> the IOMMU. However, SMMU support for PCI will only be enabled if the
> > > >>>> root complex has an iommus property, right? In that case, can't we
> > > >>>> simply do something like this:
> > > >>>>
> > > >>>> 	if (dev_is_pci(dev))
> > > >>>> 		np = find_host_bridge(dev)->of_node;
> > > >>>> 	else
> > > >>>> 		np = dev->of_node;
> > > >>>>
> > > >>>> ? I'm not sure exactly what find_host_bridge() is called, but I'm pretty
> > > >>>> sure that exists.

> > @@ -814,12 +815,15 @@ static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
> >  }
> >  
> >  static int tegra_smmu_configure(struct tegra_smmu *smmu, struct device *dev,
> > -				struct of_phandle_args *args)
> > +				struct of_phandle_args *args, struct fwnode_handle *fwnode)
> >  {
> >  	const struct iommu_ops *ops = smmu->iommu.ops;
> >  	int err;
> >  
> > -	err = iommu_fwspec_init(dev, &dev->of_node->fwnode, ops);
> > +	if (!fwnode)
> > +		return -ENOENT;
> > +
> > +	err = iommu_fwspec_init(dev, fwnode, ops);
> >  	if (err < 0) {
> >  		dev_err(dev, "failed to initialize fwspec: %d\n", err);
> >  		return err;
> > @@ -835,6 +839,19 @@ static int tegra_smmu_configure(struct tegra_smmu *smmu, struct device *dev,
> >  	return 0;
> >  }
> >  
> > +static struct device_node *tegra_smmu_find_pci_np(struct pci_dev *pci_dev)
> > +{
> > +	struct pci_bus *bus = pci_dev->bus;
> > +	struct device *dev = &bus->dev;
> > +
> > +	while (!of_property_read_bool(dev->of_node, "iommus") && bus->parent) {
> > +		dev = &bus->parent->dev;
> > +		bus = bus->parent;
> > +	}
> > +
> > +	return dev->of_node;
> > +}
> 
> This seems like it's the equivalent of pci_get_host_bridge_device(). Can
> you use that instead? I think you might use the parent of the host
> bridge that's returned from that function, though.

I noticed that one when looking up one of the of_ functions, yet
also found that this pci_get_host_bridge_device() is privated by
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/pci/pci.h?id=975e1ac173058b8710e5979e97fc1397233301f3

Would PCI folks be that willing to (allow to) revert it?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
