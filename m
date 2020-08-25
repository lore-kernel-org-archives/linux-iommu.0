Return-Path: <SRS0=rFPO=CD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162FCC433E3
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 20:03:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB3A72072D
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 20:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4bpkPmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3A72072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9C3618769E;
	Tue, 25 Aug 2020 20:03:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cYUsyzDsBObu; Tue, 25 Aug 2020 20:03:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 82CD287673;
	Tue, 25 Aug 2020 20:03:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60413C07FF;
	Tue, 25 Aug 2020 20:03:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12C9BC0051
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 20:03:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 06111882A4
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 20:03:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AILuliA9Zcgu for <iommu@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 20:03:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 747868829D
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 20:03:31 +0000 (UTC)
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ADB662072D;
 Tue, 25 Aug 2020 20:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598385811;
 bh=bLQ/6Ns9xbbW32dBksiiwUFLCmw1usZgfNu6wzOIRRA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=l4bpkPmXM7023mZgcud7LiuXiDySo6mIf1kjucmaMFMfdwWuxCgjMXMMeZWTQlTNZ
 S8ccFLX7/o+uLWvZssFvEMAlrztDO4R5uWWMK5/l+J5KEs2v6I2ftwQ6ue1mdzaRhM
 G1nZBjJwkbjF80aF+i2KZjX8PiAMGCDb4+gafrqQ=
Date: Tue, 25 Aug 2020 15:03:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch RFC 13/38] PCI: MSI: Rework pci_msi_domain_calc_hwirq()
Message-ID: <20200825200329.GA1923406@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200821002946.594509001@linutronix.de>
Cc: Dimitri Sivanich <sivanich@hpe.com>, linux-hyperv@vger.kernel.org,
 Steve Wahl <steve.wahl@hpe.com>, linux-pci@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Baolu Lu <baolu.lu@intel.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 Jason Gunthorpe <jgg@mellanox.com>, Megha Dey <megha.dey@intel.com>,
 xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jon Derrick <jonathan.derrick@intel.com>, Juergen Gross <jgross@suse.com>,
 Russ Anderson <rja@hpe.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
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

On Fri, Aug 21, 2020 at 02:24:37AM +0200, Thomas Gleixner wrote:
> Retrieve the PCI device from the msi descriptor instead of doing so at the
> call sites.

I'd like it *better* with "PCI/MSI: " in the subject (to match history
and other patches in this series) and "MSI" here in the commit log,
but nice cleanup and:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Minor comments below.

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-pci@vger.kernel.org
> ---
>  arch/x86/kernel/apic/msi.c |    2 +-
>  drivers/pci/msi.c          |   13 ++++++-------
>  include/linux/msi.h        |    3 +--
>  3 files changed, 8 insertions(+), 10 deletions(-)
> 
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -232,7 +232,7 @@ EXPORT_SYMBOL_GPL(pci_msi_prepare);
>  
>  void pci_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
>  {
> -	arg->msi_hwirq = pci_msi_domain_calc_hwirq(arg->msi_dev, desc);
> +	arg->msi_hwirq = pci_msi_domain_calc_hwirq(desc);

I guess it's safe to assume that "arg->msi_dev ==
msi_desc_to_pci_dev(desc)"?  I didn't try to verify that.

>  }
>  EXPORT_SYMBOL_GPL(pci_msi_set_desc);
>  
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1346,17 +1346,17 @@ void pci_msi_domain_write_msg(struct irq
>  
>  /**
>   * pci_msi_domain_calc_hwirq - Generate a unique ID for an MSI source
> - * @dev:	Pointer to the PCI device
>   * @desc:	Pointer to the MSI descriptor
>   *
>   * The ID number is only used within the irqdomain.
>   */
> -irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
> -					  struct msi_desc *desc)
> +irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc)
>  {
> +	struct pci_dev *pdev = msi_desc_to_pci_dev(desc);

If you named this "struct pci_dev *dev" (not "pdev"), the diff would
be a little smaller and it would match other usage in the file.

>  	return (irq_hw_number_t)desc->msi_attrib.entry_nr |
> -		pci_dev_id(dev) << 11 |
> -		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
> +		pci_dev_id(pdev) << 11 |
> +		(pci_domain_nr(pdev->bus) & 0xFFFFFFFF) << 27;
>  }
>  
>  static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)
> @@ -1406,8 +1406,7 @@ static void pci_msi_domain_set_desc(msi_
>  				    struct msi_desc *desc)
>  {
>  	arg->desc = desc;
> -	arg->hwirq = pci_msi_domain_calc_hwirq(msi_desc_to_pci_dev(desc),
> -					       desc);
> +	arg->hwirq = pci_msi_domain_calc_hwirq(desc);
>  }
>  #else
>  #define pci_msi_domain_set_desc		NULL
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -369,8 +369,7 @@ void pci_msi_domain_write_msg(struct irq
>  struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
>  					     struct msi_domain_info *info,
>  					     struct irq_domain *parent);
> -irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
> -					  struct msi_desc *desc);
> +irq_hw_number_t pci_msi_domain_calc_hwirq(struct msi_desc *desc);
>  int pci_msi_domain_check_cap(struct irq_domain *domain,
>  			     struct msi_domain_info *info, struct device *dev);
>  u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
