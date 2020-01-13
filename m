Return-Path: <SRS0=W82T=3C=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A297C33CAE
	for <iommu@archiver.kernel.org>; Mon, 13 Jan 2020 14:40:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A9E5207FD
	for <iommu@archiver.kernel.org>; Mon, 13 Jan 2020 14:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcqjER0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9E5207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id ECDAF844F1;
	Mon, 13 Jan 2020 14:40:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 32fZF8dASHoc; Mon, 13 Jan 2020 14:40:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2FC9C826AC;
	Mon, 13 Jan 2020 14:40:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 243EAC18DD;
	Mon, 13 Jan 2020 14:40:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56DE1C077D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 14:40:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 529888666D
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 14:40:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6V5pk87GM4pm for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jan 2020 14:40:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8AC3586187
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jan 2020 14:40:22 +0000 (UTC)
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2248420678;
 Mon, 13 Jan 2020 14:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578926422;
 bh=vg49eb33S7fB+YG6QOf85ALdklLUxkNgUhOPmtQJdfU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=dcqjER0pKm/a8hvvJ0IAa/r1keer220JoZ8XO7qQhUppX4J6DNTGGK08+0dEx7EpR
 ILVWUHni397ITRJc1sRPX6I5Y8FyfeZWhEn25v5yvnkqY24yFcy9ktYTfVM6BPjeHK
 rTewfSQ9qrckYfoWqn9IlHWdHz136mMBDX2jSTx4=
Date: Mon, 13 Jan 2020 08:40:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH v3 1/5] x86/pci: Add a to_pci_sysdata helper
Message-ID: <20200113144020.GA71652@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1578676873-6206-2-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
 Keith Busch <kbusch@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
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

On Fri, Jan 10, 2020 at 10:21:09AM -0700, Jon Derrick wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Various helpers need the pci_sysdata just to dereference a single field
> in it.  Add a little helper that returns the properly typed sysdata
> pointer to require a little less boilerplate code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [jonathan.derrick: added un-const cast]
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  arch/x86/include/asm/pci.h | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index 90d0731..cf680c5 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -35,12 +35,15 @@ struct pci_sysdata {
>  
>  #ifdef CONFIG_PCI
>  
> +static inline struct pci_sysdata *to_pci_sysdata(struct pci_bus *bus)
> +{
> +	return bus->sysdata;
> +}
> +
>  #ifdef CONFIG_PCI_DOMAINS
>  static inline int pci_domain_nr(struct pci_bus *bus)
>  {
> -	struct pci_sysdata *sd = bus->sysdata;
> -
> -	return sd->domain;
> +	return to_pci_sysdata(bus)->domain;
>  }
>  
>  static inline int pci_proc_domain(struct pci_bus *bus)
> @@ -52,23 +55,20 @@ static inline int pci_proc_domain(struct pci_bus *bus)
>  #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
>  static inline void *_pci_root_bus_fwnode(struct pci_bus *bus)
>  {
> -	struct pci_sysdata *sd = bus->sysdata;
> -
> -	return sd->fwnode;
> +	return to_pci_sysdata(bus)->fwnode;
>  }
>  
>  #define pci_root_bus_fwnode	_pci_root_bus_fwnode
>  #endif
>  
> +#if IS_ENABLED(CONFIG_VMD)
>  static inline bool is_vmd(struct pci_bus *bus)
>  {
> -#if IS_ENABLED(CONFIG_VMD)
> -	struct pci_sysdata *sd = bus->sysdata;
> -
> -	return sd->vmd_domain;
> +	return to_pci_sysdata(bus)->vmd_domain;
> +}
>  #else
> -	return false;
> -#endif
> +#define is_vmd(bus)		false
> +#endif /* CONFIG_VMD */
>  }

I think this patch leaves this stray close brace here (it's cleaned up
in the next patch, but looks like it will break bisection).

Also, when you fix this, can you update the subject lines?  There's a
mix of "x86/PCI" and "x86/pci" (the convention per "git log --oneline"
is "x86/PCI").

>  /* Can be used to override the logic in pci_scan_bus for skipping
> @@ -124,9 +124,7 @@ static inline void early_quirks(void) { }
>  /* Returns the node based on pci bus */
>  static inline int __pcibus_to_node(const struct pci_bus *bus)
>  {
> -	const struct pci_sysdata *sd = bus->sysdata;
> -
> -	return sd->node;
> +	return to_pci_sysdata((struct pci_bus *) bus)->node;
>  }
>  
>  static inline const struct cpumask *
> -- 
> 1.8.3.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
