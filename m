Return-Path: <SRS0=p6pp=3K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990BFC2D0CE
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 14:17:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F0482087E
	for <iommu@archiver.kernel.org>; Tue, 21 Jan 2020 14:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c22eyzSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0482087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2C98B86576;
	Tue, 21 Jan 2020 14:17:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BvS4BcO3arQ4; Tue, 21 Jan 2020 14:17:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F055086566;
	Tue, 21 Jan 2020 14:17:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCA71C0176;
	Tue, 21 Jan 2020 14:17:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBDEFC0174
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 14:17:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A9827850E9
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 14:17:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pyQPf2FQebep for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jan 2020 14:17:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BADDB85081
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jan 2020 14:17:14 +0000 (UTC)
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 375D02087E;
 Tue, 21 Jan 2020 14:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579616234;
 bh=eGP8z6dxRF+W8utN64emYHnd98d13UH+DfvCNXZYpbs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=c22eyzSNHY9dnn++zti3b8e+NUbi3X6N4cx3YafkTKPC/QYJR9gCHla3sKAoq8exI
 sD6SQ96r4j2pM9OcN9VGUk9UdefZ+bIwiRM85+79oMDyeopexe8rimq4v9Ac+TLcCE
 u+aSjnd+zRJ320sQUc+MpMiLybHnLjdUhYjnw2zc=
Date: Tue, 21 Jan 2020 08:17:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH 2/4] PCI: Add "pci=iommu_passthrough=" parameter for
 iommu passthrough
Message-ID: <20200121141712.GA94911@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200101052648.14295-3-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kevin.tian@intel.com, ashok.raj@intel.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
 linux-pci@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

[+cc linux-pci, thread at https://lore.kernel.org/r/20200101052648.14295-1-baolu.lu@linux.intel.com]

On Wed, Jan 01, 2020 at 01:26:46PM +0800, Lu Baolu wrote:
> The new parameter takes a list of devices separated by a semicolon.
> Each device specified will have its iommu_passthrough bit in struct
> device set. This is very similar to the existing 'disable_acs_redir'
> parameter.

Almost all of this patchset is in drivers/iommu.  Should the parameter
be "iommu ..." instead of "pci=iommu_passthrough=..."?

There is already an "iommu.passthrough=" argument.  Would this fit
better there?  Since the iommu_passthrough bit is generic, it seems
like you anticipate similar situations for non-PCI devices.

> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  5 +++
>  drivers/pci/pci.c                             | 34 +++++++++++++++++++
>  drivers/pci/pci.h                             |  1 +
>  drivers/pci/probe.c                           |  2 ++
>  4 files changed, 42 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ade4e6ec23e0..d3edc2cb6696 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3583,6 +3583,11 @@
>  				may put more devices in an IOMMU group.
>  		force_floating	[S390] Force usage of floating interrupts.
>  		nomio		[S390] Do not use MIO instructions.
> +		iommu_passthrough=<pci_dev>[; ...]
> +				Specify one or more PCI devices (in the format
> +				specified above) separated by semicolons.
> +				Each device specified will bypass IOMMU DMA
> +				translation.
>  
>  	pcie_aspm=	[PCIE] Forcibly enable or disable PCIe Active State Power
>  			Management.
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 90dbd7c70371..05bf3f4acc36 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6401,6 +6401,37 @@ void __weak pci_fixup_cardbus(struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL(pci_fixup_cardbus);
>  
> +static const char *iommu_passthrough_param;
> +bool pci_iommu_passthrough_match(struct pci_dev *dev)
> +{
> +	int ret = 0;
> +	const char *p = iommu_passthrough_param;
> +
> +	if (!p)
> +		return false;
> +
> +	while (*p) {
> +		ret = pci_dev_str_match(dev, p, &p);
> +		if (ret < 0) {
> +			pr_info_once("PCI: Can't parse iommu_passthrough parameter: %s\n",
> +				     iommu_passthrough_param);
> +
> +			break;
> +		} else if (ret == 1) {
> +			pci_info(dev, "PCI: IOMMU passthrough\n");
> +			return true;
> +		}
> +
> +		if (*p != ';' && *p != ',') {
> +			/* End of param or invalid format */
> +			break;
> +		}
> +		p++;
> +	}
> +
> +	return false;
> +}
> +
>  static int __init pci_setup(char *str)
>  {
>  	while (str) {
> @@ -6462,6 +6493,8 @@ static int __init pci_setup(char *str)
>  				pci_add_flags(PCI_SCAN_ALL_PCIE_DEVS);
>  			} else if (!strncmp(str, "disable_acs_redir=", 18)) {
>  				disable_acs_redir_param = str + 18;
> +			} else if (!strncmp(str, "iommu_passthrough=", 18)) {
> +				iommu_passthrough_param = str + 18;
>  			} else {
>  				pr_err("PCI: Unknown option `%s'\n", str);
>  			}
> @@ -6486,6 +6519,7 @@ static int __init pci_realloc_setup_params(void)
>  	resource_alignment_param = kstrdup(resource_alignment_param,
>  					   GFP_KERNEL);
>  	disable_acs_redir_param = kstrdup(disable_acs_redir_param, GFP_KERNEL);
> +	iommu_passthrough_param = kstrdup(iommu_passthrough_param, GFP_KERNEL);
>  
>  	return 0;
>  }
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index a0a53bd05a0b..95f6af06aba6 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -288,6 +288,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev);
>  void pci_disable_bridge_window(struct pci_dev *dev);
>  struct pci_bus *pci_bus_get(struct pci_bus *bus);
>  void pci_bus_put(struct pci_bus *bus);
> +bool pci_iommu_passthrough_match(struct pci_dev *dev);
>  
>  /* PCIe link information */
>  #define PCIE_SPEED2STR(speed) \
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 512cb4312ddd..4c571ee75621 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2404,6 +2404,8 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  
>  	dev->state_saved = false;
>  
> +	dev->dev.iommu_passthrough = pci_iommu_passthrough_match(dev);
> +
>  	pci_init_capabilities(dev);
>  
>  	/*
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
