Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD42C4363D
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 20:57:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1AE20759
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 20:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5rPcvt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1AE20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 95B8D84A7E;
	Wed, 30 Sep 2020 20:57:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FJSLTFv06YEn; Wed, 30 Sep 2020 20:57:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2AD7B8496B;
	Wed, 30 Sep 2020 20:57:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17EE0C016F;
	Wed, 30 Sep 2020 20:57:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EFB01C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 20:57:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E3F6E84A0B
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 20:57:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ut8Cp-t3yUG1 for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 20:57:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5D92C8496B
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 20:57:29 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id t14so1888268pgl.10
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 13:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=c6iynEWbtPNgxX3PlHoKiO0+Xrwds8fLYpzSvmRXVyM=;
 b=L5rPcvt2OqP+yHB8xDFS98LZTl35P80/EINvhHFaOaeoyLVwfsmVSw/AHZg0y41WUE
 SLAG+8TpUnHX+PyjfH9ILfr/VZJeP2mI5OZLstCi8Lw3sccMI5xvU0kTUWwUsd5hmZ4V
 vCuIeXJrxhMeDjxkIMW70Lhop45CKJxnQffBe4IKP1pHMdyF72WulI+760PuzRTzJSu6
 OQU+kHvCK5ibdngNTDhIYAzzJAHn2trtIStRz23mym5o89OaZ90JaBDMmpjLU6+xTk4+
 C9hMoz4WsPEnhVuTm2hgnVxQVSOgKX00CSlTxyyO53MNPZUs1zVgPgQ+H3Dr2Q3cdQJZ
 HY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=c6iynEWbtPNgxX3PlHoKiO0+Xrwds8fLYpzSvmRXVyM=;
 b=ovkX2SLKzYMoS/rMp22ZjQdwSyvNK7LkNmpgpz4UrnTS0BYSpEJxqa2SbTGbHN/zN6
 Y4GYfmYdkOOdNP71LBw58Q4gRxZqNx8pqQdHiYAZwfbRjk5qUBjq/xSNullhOLviDYw6
 SDgzbEtF7D8CWKsFbuNRuYGMNnrZfjs8MmgbectElTsO90wptXP60gGhPXZTic3G+nhK
 bqEhiqIarWsmF1DBsYjLp15ml+9Zoxv/2tEbUsN87p/xoTHN5V6ZaDrcbRMQSWMVw6Sc
 Uvjo7ZECyw+Ol9VXx1GufItQ4t21QBSJyzw1yBYARuTP5JxahdE3X2MUPQkf8DeODyFU
 RHJA==
X-Gm-Message-State: AOAM530B1IsHGOJt+c/Lrav+ON9g+e5/lLCtwgqcYq6OF8uwUTY9HnMs
 oOGP1SISgh0G8suRJrHYUkk=
X-Google-Smtp-Source: ABdhPJxWXSa4OAju42zuPPsUhvDRG1I3TfFRLgs82lOiyea7Er1AvZ8pxSUdIu2X58JM0E588GiVJA==
X-Received: by 2002:a63:e40b:: with SMTP id a11mr3596331pgi.450.1601499448869; 
 Wed, 30 Sep 2020 13:57:28 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id v21sm3224143pjn.4.2020.09.30.13.57.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Sep 2020 13:57:28 -0700 (PDT)
Date: Wed, 30 Sep 2020 13:51:49 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20200930205149.GA3052@Asurada-Nvidia>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <30808bd3-a546-e981-00ff-34c07ee1a678@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <30808bd3-a546-e981-00ff-34c07ee1a678@gmail.com>
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

On Wed, Sep 30, 2020 at 06:09:43PM +0300, Dmitry Osipenko wrote:
> ...
> >  static int tegra_smmu_attach_dev(struct iommu_domain *domain,
> >  				 struct device *dev)
> >  {
> > +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> >  	struct tegra_smmu *smmu = dev_iommu_priv_get(dev);
> >  	struct tegra_smmu_as *as = to_smmu_as(domain);
> > -	struct device_node *np = dev->of_node;
> > -	struct of_phandle_args args;
> >  	unsigned int index = 0;
> >  	int err = 0;
> >  
> > -	while (!of_parse_phandle_with_args(np, "iommus", "#iommu-cells", index,
> > -					   &args)) {
> > -		unsigned int swgroup = args.args[0];
> > -
> > -		if (args.np != smmu->dev->of_node) {
> > -			of_node_put(args.np);
> > -			continue;
> > -		}
> > -
> > -		of_node_put(args.np);
> > +	if (!fwspec || fwspec->ops != &tegra_smmu_ops)
> > +		return -ENOENT;
> 
> In previous reply you said that these fwspec checks are borrowed from
> the arm-smmu driver, but I'm now looking at what other drivers do and I
> don't see them having this check.
> 
> Hence I'm objecting the need to have this check here. You either should
> give a rational to having the check or it should be removed.
> 
> Please never blindly copy foreign code, you should always double-check it.

I will give a test and remove it upon positive result.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
