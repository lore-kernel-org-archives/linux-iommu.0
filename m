Return-Path: <SRS0=AOw0=DX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8CCC43457
	for <iommu@archiver.kernel.org>; Fri, 16 Oct 2020 04:02:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E917D207F7
	for <iommu@archiver.kernel.org>; Fri, 16 Oct 2020 04:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUnr49tv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E917D207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6D8A788839;
	Fri, 16 Oct 2020 04:02:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XoPyp13ZLi3W; Fri, 16 Oct 2020 04:02:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 97E0E88823;
	Fri, 16 Oct 2020 04:02:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BCA8C0052;
	Fri, 16 Oct 2020 04:02:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3799AC0051
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 04:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1CA0088179
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 04:02:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GGPCymXiQT+y for <iommu@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 04:02:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7C86687E8B
 for <iommu@lists.linux-foundation.org>; Fri, 16 Oct 2020 04:02:09 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id a200so694725pfa.10
 for <iommu@lists.linux-foundation.org>; Thu, 15 Oct 2020 21:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=C9/au9NmuAjbAcpNdJ/iNR3JJfxaIrQJHGtDNhivldY=;
 b=fUnr49tvI2n8Bt8NbcB9EuFZXeZSkEm0m3HKZpMJQNWe1MqKl04RBFrb2f1epAFdf+
 la4hswFSfMQ+QyQ3YcImGcU1wpeC3mZh/5Pk7kSDKWmg7hz3aR2Jkj6hXGUr/lvBOolV
 vQCAO05qsArss6AZMqm1OJzYrp2WsasKMfy4DuDRcZxo7KuQAfeLczazVfX0zpyWLtVh
 mhbDAz4bd8OPnx9fQMJ+H7lz+F51UfQZDiE6F5Ry4Ya/clJd8EfIzGRbPa2kgxe5gy8n
 P2LLP/iSGXrLTqUn2MF7rmekQd88zpnFoLmFIYaLcsZuJGzn8AnjDPgP7uC5SgIJC50d
 Jx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=C9/au9NmuAjbAcpNdJ/iNR3JJfxaIrQJHGtDNhivldY=;
 b=PffgmtFmIVGEg158ylLCE7FH0zlZ7BGRsoPZ4gHaU4aTQ/UTVoHE8dfSv1hOloQ2IJ
 DqspuAyHTBk9VRPYxEGNkLHaBFFgaosvTxXHYn6gcSfdOkcWgDfr215eOwizKDMngqrS
 X6up0A7JMgTMXR1VtWtijgGDCYMeTs5eQf/xKr/Gti8Rg+ocAHriCK/sPDkNj+OobZB9
 kahmv5CYkHkDsqplwEgHBpZnygeJj0qkdpSwt+AS8S8C2ZszT7Zd4wBXdmkgzylBaXjY
 TkMGO4v4qeRCaosX4gUvzZwFuC6kRFMBIL0BGJgIwPeOpvtFh4W2lzqK39CeBQfytcxt
 B8cA==
X-Gm-Message-State: AOAM530edaV/TG0ym3HEToFLTmnhPOtzQbpdrYhz3m01bQVwfl1kPa5j
 ageT3W/ZEjzau5CEa472yqQ=
X-Google-Smtp-Source: ABdhPJxi8B6Bs2WRpPkDMeAnj8BXHgnjQ/A9MDIaKhIjybBlGt4xg5ji7MXBKq7c8ilm/fIZeed10w==
X-Received: by 2002:a05:6a00:150a:b029:159:53cd:86db with SMTP id
 q10-20020a056a00150ab029015953cd86dbmr1667035pfu.11.1602820928943; 
 Thu, 15 Oct 2020 21:02:08 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id b6sm943638pjq.42.2020.10.15.21.02.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 15 Oct 2020 21:02:08 -0700 (PDT)
Date: Thu, 15 Oct 2020 20:53:47 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v7 3/3] iommu/tegra-smmu: Add PCI support
Message-ID: <20201016035347.GA28140@Asurada-Nvidia>
References: <20201009161936.23122-1-nicoleotsuka@gmail.com>
 <20201009161936.23122-4-nicoleotsuka@gmail.com>
 <cbc6e3bf-eedc-195c-c4d6-52d3cd24c257@arm.com>
 <20201015041346.GA13936@Asurada-Nvidia>
 <340afbc0-5513-0742-d2d2-1ab908248af3@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <340afbc0-5513-0742-d2d2-1ab908248af3@arm.com>
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

On Thu, Oct 15, 2020 at 10:55:52AM +0100, Robin Murphy wrote:
> On 2020-10-15 05:13, Nicolin Chen wrote:
> > On Wed, Oct 14, 2020 at 06:42:36PM +0100, Robin Murphy wrote:
> > > On 2020-10-09 17:19, Nicolin Chen wrote:
> > > > This patch simply adds support for PCI devices.
> > > > 
> > > > Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> > > > Tested-by: Dmitry Osipenko <digetx@gmail.com>
> > > > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > > > ---
> > > > 
> > > > Changelog
> > > > v6->v7
> > > >    * Renamed goto labels, suggested by Thierry.
> > > > v5->v6
> > > >    * Added Dmitry's Reviewed-by and Tested-by.
> > > > v4->v5
> > > >    * Added Dmitry's Reviewed-by
> > > > v3->v4
> > > >    * Dropped !iommu_present() check
> > > >    * Added CONFIG_PCI check in the exit path
> > > > v2->v3
> > > >    * Replaced ternary conditional operator with if-else in .device_group()
> > > >    * Dropped change in tegra_smmu_remove()
> > > > v1->v2
> > > >    * Added error-out labels in tegra_smmu_probe()
> > > >    * Dropped pci_request_acs() since IOMMU core would call it.
> > > > 
> > > >    drivers/iommu/tegra-smmu.c | 35 +++++++++++++++++++++++++----------
> > > >    1 file changed, 25 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> > > > index be29f5977145..2941d6459076 100644
> > > > --- a/drivers/iommu/tegra-smmu.c
> > > > +++ b/drivers/iommu/tegra-smmu.c
> > > > @@ -10,6 +10,7 @@
> > > >    #include <linux/kernel.h>
> > > >    #include <linux/of.h>
> > > >    #include <linux/of_device.h>
> > > > +#include <linux/pci.h>
> > > >    #include <linux/platform_device.h>
> > > >    #include <linux/slab.h>
> > > >    #include <linux/spinlock.h>
> > > > @@ -865,7 +866,11 @@ static struct iommu_group *tegra_smmu_device_group(struct device *dev)
> > > >    	group->smmu = smmu;
> > > >    	group->soc = soc;
> > > > -	group->group = iommu_group_alloc();
> > > > +	if (dev_is_pci(dev))
> > > > +		group->group = pci_device_group(dev);
> > > 
> > > Just to check, is it OK to have two or more swgroups "owning" the same
> > > iommu_group if an existing one gets returned here? It looks like that might
> > > not play nice with the use of iommu_group_set_iommudata().
> > 
> > Do you mean by "gets returned here" the "IS_ERR" check below?
> 
> I mean that unlike iommu_group_alloc()/generic_device_group(),
> pci_device_group() may give you back a group that already contains another
> device and has already been set up from that device's perspective. This can
> happen for topological reasons like requester ID aliasing through a PCI-PCIe
> bridge or lack of isolation between functions.

Okay..but we don't really have two swgroups owning the same groups
in case of PCI devices. For Tegra210, all PCI devices inherit the
same swgroup from the PCI controller. And I'd think previous chips
do the same. The only use case currently of 2+ swgroups owning the
same iommu_group is for display controller.

Or do you suggest we need an additional check for pci_device_group?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
