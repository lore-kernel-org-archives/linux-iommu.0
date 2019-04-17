Return-Path: <SRS0=ag5I=ST=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE5DC282DD
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 19:48:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E2A206BA
	for <iommu@archiver.kernel.org>; Wed, 17 Apr 2019 19:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1HiLnkNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E2A206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 4CD6FCA6;
	Wed, 17 Apr 2019 19:48:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 551ABC8B
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 19:48:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0EBD687F
	for <iommu@lists.linux-foundation.org>;
	Wed, 17 Apr 2019 19:48:17 +0000 (UTC)
Received: from localhost (unknown [69.71.4.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 8B636205C9;
	Wed, 17 Apr 2019 19:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555530497;
	bh=eGZIH1j5aHLmXDg/L+dky5LAU15lpR120g+KfFXu1Zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1HiLnkNh0eFB3sALCNyGZ3En7o4R97MLBoKHqM6WapogYTEaRZXExR2tuajTfA6oB
	nV9NapbSYmCuuF6+fkZJVhei9hqnQ2JahFVdSmXNquU+odAWz9MvNuKXPuKqnMou+H
	1N6aYcZqiqjALTei2cNkfqnowwRCVrRBWduA5XA0=
Date: Wed, 17 Apr 2019 14:48:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v3 2/9] PCI: Add a stub for pci_ats_disabled()
Message-ID: <20190417194816.GB18308@google.com>
References: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
	<20190417182448.12382-3-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190417182448.12382-3-jean-philippe.brucker@arm.com>
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
Message-ID: <20190417194816.O3gWzPCc9Yx_syndcdkmw1sb1fZuAfPkp46upLOMg1I@z>

On Wed, Apr 17, 2019 at 07:24:41PM +0100, Jean-Philippe Brucker wrote:
> Currently pci_ats_disabled() is only defined when CONFIG_PCI is enabled.
> Since we're about to use the function in the Arm SMMUv3 driver, which
> could be built with CONFIG_PCI disabled, add a definition of
> pci_ats_disabled() for !CONFIG_PCI.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 169c6a18d0b0..61d7cd888bad 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1713,6 +1713,7 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
>  static inline const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
>  							 struct pci_dev *dev)
>  { return NULL; }
> +static inline bool pci_ats_disabled(void) { return true; }
>  #endif /* CONFIG_PCI */
>  
>  #ifdef CONFIG_PCI_ATS
> -- 
> 2.21.0
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
