Return-Path: <SRS0=cE/7=NY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FEFC432BE
	for <iommu@archiver.kernel.org>; Thu,  2 Sep 2021 14:46:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98DC160F92
	for <iommu@archiver.kernel.org>; Thu,  2 Sep 2021 14:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 98DC160F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70A48425C5;
	Thu,  2 Sep 2021 14:46:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ePKkw8OPAli1; Thu,  2 Sep 2021 14:46:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3A6F1425C3;
	Thu,  2 Sep 2021 14:46:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18329C001A;
	Thu,  2 Sep 2021 14:46:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09007C000E
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 14:46:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 062D4425C5
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 14:46:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rh41q4OHv-Hg for <iommu@lists.linux-foundation.org>;
 Thu,  2 Sep 2021 14:46:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 83076425C3
 for <iommu@lists.linux-foundation.org>; Thu,  2 Sep 2021 14:46:27 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A548860F56;
 Thu,  2 Sep 2021 14:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630593987;
 bh=LAjLVOuLv0GADfr79P6bjh2CHXkMV2kcfrQceNgLgGA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=qTaPzl2UzDiWc3uDLRhjDiwlZDv7imOhLc0wCpTT3WmFykB2Xsx8hv8cS6bfUofXM
 0v/Mx1uahiNtoPMKy5az+unICvEMtyfSO1ENK+wBqynePZIL1O0jaKUoJlkLfji4gB
 1E/CsVVdwJtfy/pY6V3C4Yh5R1LAoEJvc9/FcqwODusnGLX1/Uwba7XM0EI5fD0zCB
 02gSxCl0FJAEBRvqRCS0qYjP816HfRHW3jt0MDop/SOnCZXBGqZMsWoKr+xtlry5LT
 liN0eCRD4zunH1KENg2wBEtdJ1D/gEbzsy4xlaLn7ZqPeDyG9iL0uSfBRVS+rUjBac
 Zm78O8uqoJILg==
Date: Thu, 2 Sep 2021 09:46:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wang Xingang <wangxingang5@huawei.com>
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating
 PCI devices
Message-ID: <20210902144625.GA328403@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210820195712.GA3342877@bjorn-Precision-5520>
Cc: xieyingtai@huawei.com, robh@kernel.org,
 Anders Roxell <anders.roxell@linaro.org>, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-pci@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, will@kernel.org
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

[+cc Marek, Anders, Robin]

On Fri, Aug 20, 2021 at 02:57:12PM -0500, Bjorn Helgaas wrote:
> On Fri, May 21, 2021 at 03:03:24AM +0000, Wang Xingang wrote:
> > From: Xingang Wang <wangxingang5@huawei.com>
> > 
> > When booting with devicetree, the pci_request_acs() is called after the
> > enumeration and initialization of PCI devices, thus the ACS is not
> > enabled. And ACS should be enabled when IOMMU is detected for the
> > PCI host bridge, so add check for IOMMU before probe of PCI host and call
> > pci_request_acs() to make sure ACS will be enabled when enumerating PCI
> > devices.
> > 
> > Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
> > configuring IOMMU linkage")
> > Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
> 
> Applied to pci/virtualization for v5.15, thanks!

I dropped this for now, until the problems reported by Marek and
Anders get sorted out.

> > ---
> >  drivers/iommu/of_iommu.c | 1 -
> >  drivers/pci/of.c         | 8 +++++++-
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > index a9d2df001149..54a14da242cc 100644
> > --- a/drivers/iommu/of_iommu.c
> > +++ b/drivers/iommu/of_iommu.c
> > @@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
> >  			.np = master_np,
> >  		};
> >  
> > -		pci_request_acs();
> >  		err = pci_for_each_dma_alias(to_pci_dev(dev),
> >  					     of_pci_iommu_init, &info);
> >  	} else {
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index da5b414d585a..2313c3f848b0 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -581,9 +581,15 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
> >  
> >  int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
> >  {
> > -	if (!dev->of_node)
> > +	struct device_node *node = dev->of_node;
> > +
> > +	if (!node)
> >  		return 0;
> >  
> > +	/* Detect IOMMU and make sure ACS will be enabled */
> > +	if (of_property_read_bool(node, "iommu-map"))
> > +		pci_request_acs();
> > +
> >  	bridge->swizzle_irq = pci_common_swizzle;
> >  	bridge->map_irq = of_irq_parse_and_map_pci;
> >  
> > -- 
> > 2.19.1
> > 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
