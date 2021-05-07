Return-Path: <SRS0=Qw1r=KC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6E8C433B4
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 21:15:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8641E6145D
	for <iommu@archiver.kernel.org>; Fri,  7 May 2021 21:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8641E6145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E76B418E6;
	Fri,  7 May 2021 21:15:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qcle527zCB8p; Fri,  7 May 2021 21:14:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFAAD40597;
	Fri,  7 May 2021 21:14:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D42CC000D;
	Fri,  7 May 2021 21:14:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DB8FC0001
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 21:14:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F0AF61628
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 21:14:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ui40cQCCBcIW for <iommu@lists.linux-foundation.org>;
 Fri,  7 May 2021 21:14:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81F9861626
 for <iommu@lists.linux-foundation.org>; Fri,  7 May 2021 21:14:56 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9A00611ED;
 Fri,  7 May 2021 21:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620422096;
 bh=EJHAtYwT3QjDp7/8mwWtXV3pJ7lbc25j/slwrHC70yk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=HfkllBZTxO/p9w6l+754P3bQ2nJ+J32Wywu5CnnDoVc7nEp+pRxZXSgE9CnOgSuY7
 dqFwM+GwC5mYWXBiYYr97o4Z+VUVuPsQtV4xR8YcBmK505Evm4lGL50/cwQr//e1+k
 94hrtuKk6W4UyVW/J02QTS+ZURwQcHo1g29Vg05b3ptiqXH3F9ZCPQmSC8bdm2wdat
 F+MfVQ2lsbfy+qEwcoYDHVlmJiKIOfvc8hGMRQ+PNldu57RR+6yt1u23V0Qt/zwFGk
 f2Jw4AG64Gx4YHufgQLZslSuKKKETXq1CKV+wEXV5KgS2Lmq8WYuHOIf25b9WUVgJO
 Q5Ey852xJ6KJw==
Date: Fri, 7 May 2021 16:14:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wang Xingang <wangxingang5@huawei.com>
Subject: Re: [PATCH 1/1] iommu/of: Fix request and enable ACS for
 of_iommu_configure
Message-ID: <20210507211454.GA1518899@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1620391793-18744-2-git-send-email-wangxingang5@huawei.com>
Cc: xieyingtai@huawei.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-pci@vger.kernel.org, bhelgaas@google.com, will@kernel.org
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

On Fri, May 07, 2021 at 12:49:53PM +0000, Wang Xingang wrote:
> From: Xingang Wang <wangxingang5@huawei.com>
> 
> When request ACS for PCI device in of_iommu_configure, the pci device
> has already been scanned and added with 'pci_acs_enable=0'. So the
> pci_request_acs() in current procedure does not work for enabling ACS.
> Besides, the ACS should be enabled only if there's an IOMMU in system.
> So this fix the call of pci_request_acs() and call pci_enable_acs() to
> make sure ACS is enabled for the pci_device.

For consistency:

  s/of_iommu_configure/of_iommu_configure()/
  s/pci device/PCI device/
  s/pci_device/PCI device/

But I'm confused about what problem this fixes.  On x86, I think we
*do* set pci_acs_enable=1 in this path:

  start_kernel
    mm_init
      mem_init
        pci_iommu_alloc
          p->detect()
            detect_intel_iommu       # IOMMU_INIT_POST(detect_intel_iommu)
              pci_request_acs
                pci_acs_enable = 1

before enumerating any PCI devices.

But you mentioned pci_host_common_probe(), which I think is mostly
used on non-x86 architectures, and I'm guessing those arches detect
the IOMMU differently.

So my question is, can we figure out how to detect IOMMUs the same way
across all arches?

> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
> configuring IOMMU linkage")
> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
> ---
>  drivers/iommu/of_iommu.c | 10 +++++++++-
>  drivers/pci/pci.c        |  2 +-
>  include/linux/pci.h      |  1 +
>  3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index a9d2df001149..dc621861ae72 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>  			.np = master_np,
>  		};
>  
> -		pci_request_acs();
>  		err = pci_for_each_dma_alias(to_pci_dev(dev),
>  					     of_pci_iommu_init, &info);
>  	} else {
> @@ -222,6 +221,15 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>  		/* The fwspec pointer changed, read it again */
>  		fwspec = dev_iommu_fwspec_get(dev);
>  		ops    = fwspec->ops;
> +
> +		/*
> +		 * If we found an IOMMU and the device is pci,
> +		 * make sure we enable ACS.

s/pci/PCI/ for consistency.

> +		 */
> +		if (dev_is_pci(dev)) {
> +			pci_request_acs();
> +			pci_enable_acs(to_pci_dev(dev));
> +		}
>  	}
>  	/*
>  	 * If we have reason to believe the IOMMU driver missed the initial
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b717680377a9..4e4f98ee2870 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -926,7 +926,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
>   * pci_enable_acs - enable ACS if hardware support it
>   * @dev: the PCI device
>   */
> -static void pci_enable_acs(struct pci_dev *dev)
> +void pci_enable_acs(struct pci_dev *dev)
>  {
>  	if (!pci_acs_enable)
>  		goto disable_acs_redir;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c20211e59a57..e6a8bfbc9c98 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2223,6 +2223,7 @@ static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
>  }
>  
>  void pci_request_acs(void);
> +void pci_enable_acs(struct pci_dev *dev);
>  bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags);
>  bool pci_acs_path_enabled(struct pci_dev *start,
>  			  struct pci_dev *end, u16 acs_flags);
> -- 
> 2.19.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
