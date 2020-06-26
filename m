Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21D0C433E1
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 15:39:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67FBA20836
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 15:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+vts0eF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FBA20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 45D4486D2E;
	Fri, 26 Jun 2020 15:39:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UWs2FpPX6a_w; Fri, 26 Jun 2020 15:39:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C498986A90;
	Fri, 26 Jun 2020 15:39:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DAA4C088C;
	Fri, 26 Jun 2020 15:39:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4190FC016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 15:39:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2F52588541
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 15:39:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZxCyFxStcMBT for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 15:39:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C44E688378
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 15:39:08 +0000 (UTC)
Received: from localhost (mobile-166-170-222-206.mycingular.net
 [166.170.222.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 301B720773;
 Fri, 26 Jun 2020 15:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593185948;
 bh=wZ7OWTnSecrf7D07hrerdFH+pIDkkrkHI6TyZ43C4OY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=g+vts0eFjefmiqi5onoMJ/9l7FfnI3aXem80MtyFtg3iWBMJ9Pxzbs+jX51NtgM1d
 lDmnxfa0+90uxMSnkCRI7WY1RQX10VnnsNMFX772+BALvhnuJ/QUoHrzS/1jK+ejmS
 zW9ol5x3OCMJmeDo2ax7nCIXEZUKlV8kq98qK4u0=
Date: Fri, 26 Jun 2020 10:39:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH 1/2] pci: Add pci device even if the driver failed to
 attach
Message-ID: <20200626153906.GA2897118@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200626002710.110200-1-rajatja@google.com>
Cc: Todd Broch <tbroch@google.com>, linux-pci@vger.kernel.org,
 lalithambika.krishnakumar@intel.com, Diego Rivas <diegorivas@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, Raj Ashok <ashok.raj@intel.com>,
 linux-acpi@vger.kernel.org, Christian Kellner <christian@kellner.me>,
 Mattias Nissler <mnissler@google.com>, Jesse Barnes <jsbarnes@google.com>,
 Len Brown <lenb@kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
 Prashant Malani <pmalani@google.com>, Aaron Durbin <adurbin@google.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bernie Keany <bernie.keany@intel.com>, Duncan Laurie <dlaurie@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, oohall@gmail.com,
 Benson Leung <bleung@google.com>, David Woodhouse <dwmw2@infradead.org>,
 Alex Levin <levinale@google.com>
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

Nit: when you update these patches, can you run "git log --oneline
drivers/pci/bus.c" and make your subject lines match the convention?
E.g.,

  PCI: Add device even if driver attach failed

On Thu, Jun 25, 2020 at 05:27:09PM -0700, Rajat Jain wrote:
> device_attach() returning failure indicates a driver error
> while trying to probe the device. In such a scenario, the PCI
> device should still be added in the system and be visible to
> the user.

Nit: please wrap logs to fill 75 characters.  "git log" adds 4 spaces
at the beginning, so 75+4 still fits nicely in 80 columns without
wrapping.

> This patch partially reverts:
> commit ab1a187bba5c ("PCI: Check device_attach() return value always")
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/pci/bus.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 8e40b3e6da77d..3cef835b375fd 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -322,12 +322,8 @@ void pci_bus_add_device(struct pci_dev *dev)
>  
>  	dev->match_driver = true;
>  	retval = device_attach(&dev->dev);
> -	if (retval < 0 && retval != -EPROBE_DEFER) {
> +	if (retval < 0 && retval != -EPROBE_DEFER)
>  		pci_warn(dev, "device attach failed (%d)\n", retval);
> -		pci_proc_detach_device(dev);
> -		pci_remove_sysfs_dev_files(dev);

Thanks for catching my bug!

> -		return;
> -	}
>  
>  	pci_dev_assign_added(dev, true);
>  }
> -- 
> 2.27.0.212.ge8ba1cc988-goog
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
