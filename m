Return-Path: <SRS0=xT8t=45=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50B0C5ACC0
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 20:45:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C5B42071B
	for <iommu@archiver.kernel.org>; Thu, 12 Mar 2020 20:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nx7m7zJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C5B42071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6899285FDE;
	Thu, 12 Mar 2020 20:45:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RprBIdZRRA8P; Thu, 12 Mar 2020 20:45:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C5D0285FA4;
	Thu, 12 Mar 2020 20:45:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91E7AC089F;
	Thu, 12 Mar 2020 20:45:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D975C0177
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 20:45:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1C3C58840E
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 20:45:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0umXHZ1DIq0M for <iommu@lists.linux-foundation.org>;
 Thu, 12 Mar 2020 20:45:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A8F758840C
 for <iommu@lists.linux-foundation.org>; Thu, 12 Mar 2020 20:45:16 +0000 (UTC)
Received: from localhost (mobile-166-175-186-165.mycingular.net
 [166.175.186.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 067F0205F4;
 Thu, 12 Mar 2020 20:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584045916;
 bh=zZzSYd+OhEGo8pmui4OqaDSuxP1H2anQxWw6SpQUHb8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=nx7m7zJcnrAvX1RV8llWgsCoe4zJIRYbu9W2a5EFju1bjHduukyyrr861uJ2A38+c
 SD4yPMh1iEsi3jWdLg+wFDm11H4Mn213zXfKWrpetsfmbPZmH4P3EnuIJMFcVRAlzQ
 GHFsnrLuzMfgwFRn6465StIBaqkEOazOtFgUBYDc=
Date: Thu, 12 Mar 2020 15:45:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 03/11] PCI: OF: Check whether the host bridge supports
 ATS
Message-ID: <20200312204514.GA178416@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200311124506.208376-4-jean-philippe@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: mark.rutland@arm.com, linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 liviu.dudau@arm.com, guohanjun@huawei.com, frowand.list@gmail.com,
 corbet@lwn.net, will@kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, dwmw2@infradead.org, rjw@rjwysocki.net,
 iommu@lists.linux-foundation.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 amurray@thegoodpenguin.co.uk
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

On Wed, Mar 11, 2020 at 01:44:58PM +0100, Jean-Philippe Brucker wrote:
> When setting up a generic host on a device-tree based system, copy the
> ats-supported flag into the pci_host_bridge structure.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v1->v2: keep the helper in pci-host-common.c
> ---
>  drivers/pci/controller/pci-host-common.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index 250a3fc80ec6..2e800bc6ae7a 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c
> @@ -54,6 +54,16 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
>  	return ERR_PTR(err);
>  }
>  
> +static void of_pci_host_check_ats(struct pci_host_bridge *bridge)
> +{
> +	struct device_node *np = bridge->bus->dev.of_node;
> +
> +	if (!np)
> +		return;
> +
> +	bridge->ats_supported = of_property_read_bool(np, "ats-supported");
> +}
> +
>  int pci_host_common_probe(struct platform_device *pdev,
>  			  struct pci_ecam_ops *ops)
>  {
> @@ -92,6 +102,7 @@ int pci_host_common_probe(struct platform_device *pdev,
>  		return ret;
>  	}
>  
> +	of_pci_host_check_ats(bridge);

I would prefer to write this as a predicate instead of having the
assignment be a side-effect, e.g.,

  bridge->ats_supported = of_pci_host_ats_supported(bridge);

If that works for you,

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

>  	platform_set_drvdata(pdev, bridge->bus);
>  	return 0;
>  }
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
