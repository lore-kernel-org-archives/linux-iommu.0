Return-Path: <SRS0=+ohw=SU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0E6C10F14
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 23:49:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2061206B6
	for <iommu@archiver.kernel.org>; Thu, 18 Apr 2019 23:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0kIFHrEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2061206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C70102135;
	Thu, 18 Apr 2019 23:49:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1BADF2122
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 23:49:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B22FD828
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Apr 2019 23:49:24 +0000 (UTC)
Received: from localhost (unknown [69.71.4.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 361A3206B6;
	Thu, 18 Apr 2019 23:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555631364;
	bh=RdRuENMt2N8EcFqmuOVsp9lgB312z9UdqMSFIAs3IrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0kIFHrENnmKj3GeqVyaIoay2R1vKfYATSAZLzKR0ppVo0/VxojkAn3vYVQt21g5sF
	k52nBSe4aX+ThkElxPakCGtR+U1n15XomqC9njay/plcUFjJZY+Xn9+4ChSmHwVlU9
	U2MZXTBlq0eWeoWWS8uqQMH7GLqpiHcx2T9mr7Q0=
Date: Thu, 18 Apr 2019 18:49:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: Re: [PATCH v4 1/3] PCI: Add dma_ranges window list
Message-ID: <20190418234922.GH126710@google.com>
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
	<1555038815-31916-2-git-send-email-srinath.mannam@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1555038815-31916-2-git-send-email-srinath.mannam@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: poza@codeaurora.org, Ray Jui <rjui@broadcom.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190418234923.ZvTwevWPYTbdJO7rXf8lTa7Pg0hewj9UtMP6dG_l7EY@z>

On Fri, Apr 12, 2019 at 08:43:33AM +0530, Srinath Mannam wrote:
> Add a dma_ranges field in PCI host bridge structure to hold resource
> entries list of memory regions in sorted order given through dma-ranges
> DT property.
> 
> While initializing IOMMU domain of PCI EPs connected to that host bridge
> This list of resources will be processed and IOVAs for the address holes
> will be reserved.

s/bridge This list/bridge, this list/

> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
> Reviewed-by: Oza Pawandeep <poza@codeaurora.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/probe.c | 3 +++
>  include/linux/pci.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 257b9f6..ce5505f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -544,6 +544,7 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
>  		return NULL;
>  
>  	INIT_LIST_HEAD(&bridge->windows);
> +	INIT_LIST_HEAD(&bridge->dma_ranges);
>  	bridge->dev.release = pci_release_host_bridge_dev;
>  
>  	/*
> @@ -572,6 +573,7 @@ struct pci_host_bridge *devm_pci_alloc_host_bridge(struct device *dev,
>  		return NULL;
>  
>  	INIT_LIST_HEAD(&bridge->windows);
> +	INIT_LIST_HEAD(&bridge->dma_ranges);
>  	bridge->dev.release = devm_pci_release_host_bridge_dev;
>  
>  	return bridge;
> @@ -581,6 +583,7 @@ EXPORT_SYMBOL(devm_pci_alloc_host_bridge);
>  void pci_free_host_bridge(struct pci_host_bridge *bridge)
>  {
>  	pci_free_resource_list(&bridge->windows);
> +	pci_free_resource_list(&bridge->dma_ranges);
>  
>  	kfree(bridge);
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 65f1d8c..016a044 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -487,6 +487,7 @@ struct pci_host_bridge {
>  	void		*sysdata;
>  	int		busnr;
>  	struct list_head windows;	/* resource_entry */
> +	struct list_head dma_ranges;	/* dma ranges resource list */
>  	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>  	int (*map_irq)(const struct pci_dev *, u8, u8);
>  	void (*release_fn)(struct pci_host_bridge *);
> -- 
> 2.7.4
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
