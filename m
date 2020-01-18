Return-Path: <SRS0=Kz9i=3H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84424C33C9E
	for <iommu@archiver.kernel.org>; Sat, 18 Jan 2020 00:18:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC1F22464
	for <iommu@archiver.kernel.org>; Sat, 18 Jan 2020 00:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8Exl2Nr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC1F22464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1D5E98821D;
	Sat, 18 Jan 2020 00:18:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3DI3+shxf8DT; Sat, 18 Jan 2020 00:18:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EF299881B7;
	Sat, 18 Jan 2020 00:18:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2D44C18DC;
	Sat, 18 Jan 2020 00:18:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1B7AC077D
 for <iommu@lists.linux-foundation.org>; Sat, 18 Jan 2020 00:18:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BC7C422115
 for <iommu@lists.linux-foundation.org>; Sat, 18 Jan 2020 00:18:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1SqR0B+E6Kua for <iommu@lists.linux-foundation.org>;
 Sat, 18 Jan 2020 00:18:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 95D7520377
 for <iommu@lists.linux-foundation.org>; Sat, 18 Jan 2020 00:18:50 +0000 (UTC)
Received: from localhost (187.sub-174-234-133.myvzw.com [174.234.133.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1BC9C22464;
 Sat, 18 Jan 2020 00:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579306730;
 bh=gSDrQaOdpG8so50JR4QbBrnND0Qmuf7RzbL8om1tDgI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=I8Exl2NrIfZJx/X2Mt2KL0FoOsXTjdC21eetR92F+Y9kZLZbLE23+TCDiAiKJhTg5
 pCrNxmdwgJum+wwghrjSuZFGYcU4J+H8o/KM119A/wm8fFlDtvQB6Nfa7GOXgMneWP
 LLjtiZuvzf4qg0B9hR2l9Cqvoq8emb1A+LwDS67k=
Date: Fri, 17 Jan 2020 18:18:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH 2/4] PCI: Add "pci=iommu_passthrough=" parameter for
 iommu passthrough
Message-ID: <20200117232403.GA142078@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200101052648.14295-3-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kevin.tian@intel.com, ashok.raj@intel.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Wed, Jan 01, 2020 at 01:26:46PM +0800, Lu Baolu wrote:
> The new parameter takes a list of devices separated by a semicolon.
> Each device specified will have its iommu_passthrough bit in struct
> device set. This is very similar to the existing 'disable_acs_redir'
> parameter.
> 
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

This duplicates a lot of the code in pci_disable_acs_redir().  That
needs to be factored out somehow so we don't duplicate it.

Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
