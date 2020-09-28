Return-Path: <SRS0=rmn6=DF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A300C2D0A8
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 22:23:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3FAE23977
	for <iommu@archiver.kernel.org>; Mon, 28 Sep 2020 22:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIyYvXda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3FAE23977
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 852898517C;
	Mon, 28 Sep 2020 22:23:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZCwl2kCyIK5j; Mon, 28 Sep 2020 22:23:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1231684DFD;
	Mon, 28 Sep 2020 22:23:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE566C0889;
	Mon, 28 Sep 2020 22:23:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5E59C0051
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 22:23:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id C4A908669E
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 22:23:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l3ZOe-241hUq for <iommu@lists.linux-foundation.org>;
 Mon, 28 Sep 2020 22:23:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
 [209.85.215.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0302D84DFD
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 22:23:46 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id 34so2125616pgo.13
 for <iommu@lists.linux-foundation.org>; Mon, 28 Sep 2020 15:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=tSPHkz2Us2cBVrXsw7CUcaG7reiU6MJM3Q+fVPb4/V4=;
 b=DIyYvXda4Y/TU2MXpd1ebaArX3qhiMfcRdRNbSkXa5hQslxaMnK4ic55ZdFZUN44k4
 /AOhYWUIwwQ/S0VOSzS+Q/bn6r/x2jMDXV9nVs7J7Daboi4EcAhQr9/fj61F7BA5+e2o
 030EuPuiUEf3ouHFfk53YFkZQPJ4GH9icqIJ+Cb/20CDZsCcK1bqjpse11G/Ze0PkWNg
 aE1oJG82zuADToC8R71oOO7l8E86eAUD1ZNWU+36AsNbEqzhYJWLYALX8P1DR41ojYT+
 7aBdX76Bmdu2eWuRywwB7khwNBTK2pw7lPcsaqzTH77pkfsceyKLC3b7Qw9iIq4Ns8dv
 LAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tSPHkz2Us2cBVrXsw7CUcaG7reiU6MJM3Q+fVPb4/V4=;
 b=pEV1Tr9cmqL4BvXUpebSA1fZ7lM24L4QWuQFiQiz7XwBg3iG9hw3JpNxivLRAqJksf
 tX+ZtrXjtaQbdhK1ycvYJ0WqExNcGMyd3CyANSftVFv3eyoFsM84yMVAU+UpO7AXcYGt
 5dyy6p35ozaS5dYS41sOjyr2OyvxV6g/HYBnvHJ5dl3qt0/WLArVtp2sGxChPEXwYI2e
 KiMNP/4D2a+5Ow2a5vgGvIrpsMcvq6/rcg5gFMnLKRFYHl6YepCvy3Xk6+o7EOjTRpdN
 LhYrJnufn+o+m2i6AHqcrnzaVJMtO4ECgskYO02XQW53+YTv9p02bFqUCoTeSN3N0+S6
 iO2A==
X-Gm-Message-State: AOAM5311cU14dMhJZc4lyYIig6crXNRlJqTQrgwZA64zpRfIP00yVeok
 qwyv6i7Pg5yEfTAX6jNVVVY=
X-Google-Smtp-Source: ABdhPJxIJMbt3uGyV6MRNLX4bn9gZegg0TMjxu5SzarjjqRjk+cvpxgMfgQd3kyo9zPsMvEoUw6Cmw==
X-Received: by 2002:a63:e61:: with SMTP id 33mr857877pgo.394.1601331826526;
 Mon, 28 Sep 2020 15:23:46 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id n72sm3129174pfd.27.2020.09.28.15.23.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 28 Sep 2020 15:23:46 -0700 (PDT)
Date: Mon, 28 Sep 2020 15:18:29 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 3/5] iommu/tegra-smmu: Use iommu_fwspec in
 .probe_/.attach_device()
Message-ID: <20200928221829.GB15720@Asurada-Nvidia>
References: <20200926080719.6822-1-nicoleotsuka@gmail.com>
 <20200926080719.6822-4-nicoleotsuka@gmail.com>
 <20200928075212.GF2837573@ulmo>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200928075212.GF2837573@ulmo>
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

On Mon, Sep 28, 2020 at 09:52:12AM +0200, Thierry Reding wrote:
> On Sat, Sep 26, 2020 at 01:07:17AM -0700, Nicolin Chen wrote:
> > @@ -13,6 +13,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/dma-iommu.h>
> 
> Why is this needed? I don't see any of the symbols declared in that file
> used here.

Hmm..I think I mixed with some other change that needs this header
file. Removing it....

> >  #include <linux/dma-mapping.h>
> >  
> >  #include <soc/tegra/ahb.h>
> > @@ -61,6 +62,8 @@ struct tegra_smmu_as {
> >  	u32 attr;
> >  };
> >  
> > +static const struct iommu_ops tegra_smmu_ops;
> > +
> >  static struct tegra_smmu_as *to_smmu_as(struct iommu_domain *dom)
> >  {
> >  	return container_of(dom, struct tegra_smmu_as, domain);
> > @@ -484,60 +487,49 @@ static void tegra_smmu_as_unprepare(struct tegra_smmu *smmu,
> >  static int tegra_smmu_attach_dev(struct iommu_domain *domain,
> >  				 struct device *dev)
> >  {
> > +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> >  	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
> >  	struct tegra_smmu_as *as = to_smmu_as(domain);
> > -	struct device_node *np = dev->of_node;
> > -	struct of_phandle_args args;
> > -	unsigned int index = 0;
> > -	int err = 0;
> > -
> > -	while (!of_parse_phandle_with_args(np, "iommus", "#iommu-cells", index,
> > -					   &args)) {
> > -		unsigned int swgroup = args.args[0];
> > -
> > -		if (args.np != smmu->dev->of_node) {
> > -			of_node_put(args.np);
> > -			continue;
> > -		}
> > +	int index, err = 0;
> >  
> > -		of_node_put(args.np);
> > +	if (!fwspec || fwspec->ops != &tegra_smmu_ops)
> > +		return -ENOENT;
> >  
> > +	for (index = 0; index < fwspec->num_ids; index++) {
> >  		err = tegra_smmu_as_prepare(smmu, as);
> > -		if (err < 0)
> > -			return err;
> > +		if (err)
> > +			goto err_disable;
> 
> I'd personally drop the err_ prefix here because it's pretty obvious
> that we're going to do this as a result of an error happening.

Changing to "goto disable".

> > @@ -845,10 +837,25 @@ static int tegra_smmu_configure(struct tegra_smmu *smmu, struct device *dev,
> >  	return 0;
> >  }
> >  
> > +static struct tegra_smmu *tegra_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
> > +{
> > +	struct device *dev = driver_find_device_by_fwnode(&tegra_mc_driver.driver, fwnode);
> > +	struct tegra_mc *mc;
> > +
> > +	if (!dev)
> > +		return NULL;
> > +
> > +	put_device(dev);
> > +	mc = dev_get_drvdata(dev);
> > +
> > +	return mc->smmu;
> > +}
> > +
> 
> As I mentioned in another reply, I think tegra_smmu_find() should be all
> you need in this case.

This function is used by .probe_device() where its dev pointer is
an SMMU client. IIUC, tegra_smmu_find() needs np pointer of "mc".
For a PCI device that doesn't have a DT node with iommus property,
not sure how we can use tegra_smmu_find().
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
