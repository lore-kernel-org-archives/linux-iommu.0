Return-Path: <SRS0=VKv6=TW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8475DC282CE
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 21:00:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E5D2173C
	for <iommu@archiver.kernel.org>; Wed, 22 May 2019 21:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMu4b6BJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E5D2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 12213AC8;
	Wed, 22 May 2019 21:00:41 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 39668AC7
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 21:00:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DCC325D0
	for <iommu@lists.linux-foundation.org>;
	Wed, 22 May 2019 21:00:39 +0000 (UTC)
Received: from localhost (unknown [69.71.4.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 3FF2121019;
	Wed, 22 May 2019 21:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558558839;
	bh=DAAiD6IH0KlDghAVNPmVbeERdOtKivo01YxuNAw7Lv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NMu4b6BJ6eGOg5zZMYjFoMJPEjwWgJzXYlUFNL/cVGdMfzr6eLQQV4fTw0oerv/D+
	RP2brANDVsvcMxhzfOECmHSJFZ8Ghm4KstXuGdGVc+DEa3jtgRa2btaLFFe575w+TH
	4i9jAAXLgNkFwSgCIMEOX1dAXlJtDolPRrkjQVhw=
Date: Wed, 22 May 2019 16:00:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>
Subject: Re: [RFC/PATCH 2/4] PCI: Export PCI ACS and DMA searching functions
	to modules
Message-ID: <20190522210038.GE79339@google.com>
References: <1558118857-16912-1-git-send-email-isaacm@codeaurora.org>
	<1558118857-16912-3-git-send-email-isaacm@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1558118857-16912-3-git-send-email-isaacm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, kernel-team@android.com,
	linux-pci@vger.kernel.org, will.deacon@arm.com,
	linux-kernel@vger.kernel.org, pratikp@codeaurora.org,
	iommu@lists.linux-foundation.org, robh+dt@kernel.org,
	lmark@codeaurora.org, frowand.list@gmail.com,
	linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, May 17, 2019 at 11:47:35AM -0700, Isaac J. Manjarres wrote:
> IOMMU drivers that can be compiled as modules may
> want to use pci_for_each_dma_alias() and pci_request_acs(),
> so export those functions.
> 
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.c    | 1 +
>  drivers/pci/search.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 766f577..3f354c1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3124,6 +3124,7 @@ void pci_request_acs(void)
>  {
>  	pci_acs_enable = 1;
>  }
> +EXPORT_SYMBOL_GPL(pci_request_acs);
>  
>  static const char *disable_acs_redir_param;
>  
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index 2b5f720..cf9ede9 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -111,6 +111,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(pci_for_each_dma_alias);
>  
>  static struct pci_bus *pci_do_find_bus(struct pci_bus *bus, unsigned char busnr)
>  {
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
