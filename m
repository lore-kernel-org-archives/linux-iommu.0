Return-Path: <SRS0=11OQ=YX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0066C47E49
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 20:30:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 979482080F
	for <iommu@archiver.kernel.org>; Wed, 30 Oct 2019 20:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yi+gyYU/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979482080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 70940D80;
	Wed, 30 Oct 2019 20:30:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 81B54D7D
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 20:30:44 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3A90C87B
	for <iommu@lists.linux-foundation.org>;
	Wed, 30 Oct 2019 20:30:44 +0000 (UTC)
Received: from localhost (unknown [69.71.4.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id C6211205C9;
	Wed, 30 Oct 2019 20:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572467444;
	bh=7S030207/lOki5T8aX6j2Aiz+5BYaIpHjY2GGLIav+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Yi+gyYU/5+OuyQVMs6E8lOV+CkSwzRgsP4mvwaCNJoZfb0QocOhj7h6TvcML8FYsw
	SSf+N2W9/3cddKdGX9mj5qd7PfPBspOF60E2FFbLYdF5xxgHId4OekX9YLgjts9eGB
	WYRjcUBQWtOieOlw/l/y4/t65AeB97w45y5gHncM=
Date: Wed, 30 Oct 2019 15:30:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 3/7] PCI: Export pci_ats_disabled() as a GPL symbol to
	modules
Message-ID: <20191030203041.GA247194@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191030145112.19738-4-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org
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

On Wed, Oct 30, 2019 at 02:51:08PM +0000, Will Deacon wrote:
> Building drivers for ATS-aware IOMMUs as modules requires access to
> pci_ats_disabled(). Export it as a GPL symbol to get things working.
> 
> Signed-off-by: Will Deacon <will@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a97e2571a527..4fbe5b576dd8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -123,6 +123,7 @@ bool pci_ats_disabled(void)
>  {
>  	return pcie_ats_disabled;
>  }
> +EXPORT_SYMBOL_GPL(pci_ats_disabled);
>  
>  /* Disable bridge_d3 for all PCIe ports */
>  static bool pci_bridge_d3_disable;
> -- 
> 2.24.0.rc0.303.g954a862665-goog
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
