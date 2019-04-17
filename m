Return-Path: <SRS0=ag5I=ST=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D6BC282DC
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 19:47:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CBA621773
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 19:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="POWFFCG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBA621773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 15530CC1;
	Wed, 17 Apr 2019 19:47:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 442A9C8B
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 19:47:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D91F8886
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 19:47:49 +0000 (UTC)
Received: from localhost (unknown [69.71.4.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 61F83205C9;
	Wed, 17 Apr 2019 19:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555530469;
	bh=d8gKCuw8mxLdXW711uuIWJMqzQlgj1Z+FJteTwebKrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=POWFFCG4Gh0+ASda6B5d1ZcY25xjayK0cI8+3hVO5LhNFFNQSkpO4DoKiFlYK0bHP
	xDy8CgNNAcflM1fbAHjtZKshkG4yyligOflFqkIEGFP5Dfj6zobbfOoy77NJf2cz31
	ci1xGoEyh/DsL8ViNusv88PJmh138nZUMhLK181I=
Date: Wed, 17 Apr 2019 14:47:47 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 1/9] PCI: Move ATS declarations outside of CONFIG_PCI
Message-ID: <20190417194747.GA18308@google.com>
References: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
	<20190417182448.12382-2-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190417182448.12382-2-jean-philippe.brucker@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: zhongmiao@hisilicon.com, rjw@rjwysocki.net, will.deacon@arm.com,
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux-foundation.org, sudeep.holla@arm.com,
	okaya@kernel.org, robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org, lenb@kernel.org
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
Message-ID: <20190417194747.Nf5__BlEG-KVfnO8HBlwFgM9wiV-m1dBDJV8GFB-iPQ@z>

On Wed, Apr 17, 2019 at 07:24:40PM +0100, Jean-Philippe Brucker wrote:
> At the moment, the ATS functions are only defined when CONFIG_PCI is
> enabled. Since we're about to use them in the Arm SMMUv3 driver, which
> could be built with CONFIG_PCI disabled, and they are already guarded by
> CONFIG_PCI_ATS which depends on CONFIG_PCI, move the definitions outside
> of CONFIG_PCI.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

I guess this is OK with me, although AFAICS they're only used in
arm_smmu_enable_ats() and arm_smmu_disable_ats() and I personally
wouldn't find it objectionable to wrap the bodies of those functions
in "#ifdef CONFIG_PCI".  That might even be a useful hint to the
reader, as opposed to relying on all these stub functions
(dev_is_pci(), pci_ats_disabled(), pci_enable_ats(),
pci_disable_ats(), as well as the complete struct pci_dev declaration)
that depend on config settings that aren't obvious in the caller.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci.h | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 77448215ef5b..169c6a18d0b0 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1521,21 +1521,6 @@ static inline void pcie_ecrc_get_policy(char *str) { }
>  
>  bool pci_ats_disabled(void);
>  
> -#ifdef CONFIG_PCI_ATS
> -/* Address Translation Service */
> -void pci_ats_init(struct pci_dev *dev);
> -int pci_enable_ats(struct pci_dev *dev, int ps);
> -void pci_disable_ats(struct pci_dev *dev);
> -int pci_ats_queue_depth(struct pci_dev *dev);
> -int pci_ats_page_aligned(struct pci_dev *dev);
> -#else
> -static inline void pci_ats_init(struct pci_dev *d) { }
> -static inline int pci_enable_ats(struct pci_dev *d, int ps) { return -ENODEV; }
> -static inline void pci_disable_ats(struct pci_dev *d) { }
> -static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
> -static inline int pci_ats_page_aligned(struct pci_dev *dev) { return 0; }
> -#endif
> -
>  #ifdef CONFIG_PCIE_PTM
>  int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
>  #else
> @@ -1730,6 +1715,21 @@ static inline const struct pci_device_id *pci_match_id(const struct pci_device_i
>  { return NULL; }
>  #endif /* CONFIG_PCI */
>  
> +#ifdef CONFIG_PCI_ATS
> +/* Address Translation Service */
> +void pci_ats_init(struct pci_dev *dev);
> +int pci_enable_ats(struct pci_dev *dev, int ps);
> +void pci_disable_ats(struct pci_dev *dev);
> +int pci_ats_queue_depth(struct pci_dev *dev);
> +int pci_ats_page_aligned(struct pci_dev *dev);
> +#else
> +static inline void pci_ats_init(struct pci_dev *d) { }
> +static inline int pci_enable_ats(struct pci_dev *d, int ps) { return -ENODEV; }
> +static inline void pci_disable_ats(struct pci_dev *d) { }
> +static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
> +static inline int pci_ats_page_aligned(struct pci_dev *dev) { return 0; }
> +#endif
> +
>  /* Include architecture-dependent settings and functions */
>  
>  #include <asm/pci.h>
> -- 
> 2.21.0
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
