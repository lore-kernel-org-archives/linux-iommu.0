Return-Path: <SRS0=0/ZC=DY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8ED2C433E7
	for <iommu@archiver.kernel.org>; Sat, 17 Oct 2020 02:04:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B47D206ED
	for <iommu@archiver.kernel.org>; Sat, 17 Oct 2020 02:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JF3BQ+8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B47D206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DE144885CD;
	Sat, 17 Oct 2020 02:04:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lW0hRgO6abiB; Sat, 17 Oct 2020 02:04:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 386D9885C7;
	Sat, 17 Oct 2020 02:04:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B674C0052;
	Sat, 17 Oct 2020 02:04:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33C18C0051
 for <iommu@lists.linux-foundation.org>; Sat, 17 Oct 2020 02:04:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 33F1288F35
 for <iommu@lists.linux-foundation.org>; Sat, 17 Oct 2020 02:04:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lx0BrH+CPIa7 for <iommu@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 02:04:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6EB4988F48
 for <iommu@lists.linux-foundation.org>; Sat, 17 Oct 2020 02:04:38 +0000 (UTC)
Received: by mail-pl1-f193.google.com with SMTP id b19so2212791pld.0
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 19:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=swJTOo0+OeDIPNlZmpUNpCccwzVAN8JMX1PnG4lkV8M=;
 b=JF3BQ+8ZwhdmCyhHsc4k56aEf2TRI4JW3HNtDvCsDa3bvLNAFOMP/UrvvlhqEMIHpI
 Z6Yr+OeHrXAvlRZzgke5PASmG4xm0uPRrdasNvWaVRmJWe/7IhoRvToWL9yO9H+muIvY
 nVLTKNMWL/GBSv9IDq1uEcZ7GAolCNiUX+v7lML4Emr7EXDncHSwBu0FOdkkZRbgZiSs
 CJCfVNOeDWn0trXRMmQPmJXPVh2nXITBr60MB+wX1K6y4zaW8abBuM/9iNVY0V+DD2Ba
 ygCRHZKgRrH6B2uT17MnJvCFSgAD52yHR7ZxGRpgVhLXPlhwvosMWsSZf+vXp86lpsEP
 bypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=swJTOo0+OeDIPNlZmpUNpCccwzVAN8JMX1PnG4lkV8M=;
 b=EdLk4Ly42b+qo4le7y1CGLU+qihkk1z7OrdbKxjoqafNaNyLnXjX3cYCEbFd7zJjH5
 b1ncKNwit1qZ/9fXuE+Yg12m4t92K9INC4MakPT937LoaI75NlFgFB0gByZT+hiepodG
 X0Z+K+ov9DQGsDRShZd5U7ixYpbuRqDNJ2+bMAvpH0YmBCmpJdkEL5Neq0w3zs5ZwL1+
 AF8g4eaJJ3Xvnf0kT2W58AuqYJtThg6hWxVsL+cGbP6foOQnag6eKfk3eXX/6ksvHfgm
 AxV3Iv0cYmgoWepAmPrZKftjIP/aqNiF/vl8VHFug4/pJBXR0dTmGwX957k2b/Psv+Ct
 IHDQ==
X-Gm-Message-State: AOAM531RX3V+X3fIgqvtkfTD/VBQeb/8j/YoLXtEH2x+j69K0vo6IXKB
 5QLC/ozO6/7DAmWcoydjZjc=
X-Google-Smtp-Source: ABdhPJwEY0kB/NGLxD9ci0NbxaFi/YJtDjtuugODqnZm3qeuLt8C1eqt/2mdtsrRfEyU68ls+csv8Q==
X-Received: by 2002:a17:90b:d91:: with SMTP id
 bg17mr7030547pjb.66.1602900277826; 
 Fri, 16 Oct 2020 19:04:37 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id bj17sm4168738pjb.15.2020.10.16.19.04.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 16 Oct 2020 19:04:37 -0700 (PDT)
Date: Fri, 16 Oct 2020 18:56:08 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v7 3/3] iommu/tegra-smmu: Add PCI support
Message-ID: <20201017015607.GC7203@Asurada-Nvidia>
References: <20201009161936.23122-1-nicoleotsuka@gmail.com>
 <20201009161936.23122-4-nicoleotsuka@gmail.com>
 <cbc6e3bf-eedc-195c-c4d6-52d3cd24c257@arm.com>
 <20201015041346.GA13936@Asurada-Nvidia>
 <340afbc0-5513-0742-d2d2-1ab908248af3@arm.com>
 <20201016035347.GA28140@Asurada-Nvidia>
 <1431eba3-d0b3-8460-2c12-573dc148e0df@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1431eba3-d0b3-8460-2c12-573dc148e0df@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org, digetx@gmail.com
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

On Fri, Oct 16, 2020 at 03:10:26PM +0100, Robin Murphy wrote:
> On 2020-10-16 04:53, Nicolin Chen wrote:
> > On Thu, Oct 15, 2020 at 10:55:52AM +0100, Robin Murphy wrote:
> > > On 2020-10-15 05:13, Nicolin Chen wrote:
> > > > On Wed, Oct 14, 2020 at 06:42:36PM +0100, Robin Murphy wrote:
> > > > > On 2020-10-09 17:19, Nicolin Chen wrote:
> > > > > > This patch simply adds support for PCI devices.
> > > > > > 
> > > > > > Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> > > > > > Tested-by: Dmitry Osipenko <digetx@gmail.com>
> > > > > > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > > > > > ---
> > > > > > 
> > > > > > Changelog
> > > > > > v6->v7
> > > > > >     * Renamed goto labels, suggested by Thierry.
> > > > > > v5->v6
> > > > > >     * Added Dmitry's Reviewed-by and Tested-by.
> > > > > > v4->v5
> > > > > >     * Added Dmitry's Reviewed-by
> > > > > > v3->v4
> > > > > >     * Dropped !iommu_present() check
> > > > > >     * Added CONFIG_PCI check in the exit path
> > > > > > v2->v3
> > > > > >     * Replaced ternary conditional operator with if-else in .device_group()
> > > > > >     * Dropped change in tegra_smmu_remove()
> > > > > > v1->v2
> > > > > >     * Added error-out labels in tegra_smmu_probe()
> > > > > >     * Dropped pci_request_acs() since IOMMU core would call it.
> > > > > > 
> > > > > >     drivers/iommu/tegra-smmu.c | 35 +++++++++++++++++++++++++----------
> > > > > >     1 file changed, 25 insertions(+), 10 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> > > > > > index be29f5977145..2941d6459076 100644
> > > > > > --- a/drivers/iommu/tegra-smmu.c
> > > > > > +++ b/drivers/iommu/tegra-smmu.c
> > > > > > @@ -10,6 +10,7 @@
> > > > > >     #include <linux/kernel.h>
> > > > > >     #include <linux/of.h>
> > > > > >     #include <linux/of_device.h>
> > > > > > +#include <linux/pci.h>
> > > > > >     #include <linux/platform_device.h>
> > > > > >     #include <linux/slab.h>
> > > > > >     #include <linux/spinlock.h>
> > > > > > @@ -865,7 +866,11 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
> > > > > >     	group->smmu = smmu;
> > > > > >     	group->soc = soc;
> > > > > > -	group->group = iommu_group_alloc();
> > > > > > +	if (dev_is_pci(dev))
> > > > > > +		group->group = pci_device_group(dev);
> > > > > 
> > > > > Just to check, is it OK to have two or more swgroups "owning" the same
> > > > > iommu_group if an existing one gets returned here? It looks like that might
> > > > > not play nice with the use of iommu_group_set_iommudata().
> > > > 
> > > > Do you mean by "gets returned here" the "IS_ERR" check below?
> > > 
> > > I mean that unlike iommu_group_alloc()/generic_device_group(),
> > > pci_device_group() may give you back a group that already contains another
> > > device and has already been set up from that device's perspective. This can
> > > happen for topological reasons like requester ID aliasing through a PCI-PCIe
> > > bridge or lack of isolation between functions.
> > 
> > Okay..but we don't really have two swgroups owning the same groups
> > in case of PCI devices. For Tegra210, all PCI devices inherit the
> > same swgroup from the PCI controller. And I'd think previous chips
> > do the same. The only use case currently of 2+ swgroups owning the
> > same iommu_group is for display controller.
> > 
> > Or do you suggest we need an additional check for pci_device_group?
> 
> Ah, OK - I still don't have the best comprehension of what exactly swgroups

The "swgroup" stands for "software group", which associates with
an ASID (Address Space Identifier) for SMMU to determine whether
this client is going through SMMU translation or not.

> are, and the path through .of_xlate looked like you might be using the PCI
> requester ID as the swgroup identifier, but I guess that ultimately depends
> on what your "iommu-map" is supposed to look like. If pci_device_group()

This is copied from pcie node in our downstream dtsi file:

		iommus = <&mc TEGRA_SWGROUP_AFI>;
		iommu-map = <0x0 &mc TEGRA_SWGROUP_AFI 0x1000>;
		iommu-map-mask = <0x0>;

> will effectively only ever get called once regardless of how many endpoints
> exist, then indeed this won't be a concern (although if that's *guaranteed*
> to be the case then you may as well just stick with calling
> iommu_group_alloc() directly). Thanks for clarifying.

All PCI devices are supposed to get this swgroup of the pcie node
above. So the function will return the existing group of the pcie
controller, before giving a chance to call iommu_group_alloc().

Thanks for the review and input.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
