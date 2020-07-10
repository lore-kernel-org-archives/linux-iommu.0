Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC032C433E4
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 20:39:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D38A2078B
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 20:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXwmLksh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D38A2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6F9608888A;
	Fri, 10 Jul 2020 20:39:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h38E2S1lbYo6; Fri, 10 Jul 2020 20:39:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6E335889F4;
	Fri, 10 Jul 2020 20:39:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D127C077B;
	Fri, 10 Jul 2020 20:39:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FF51C016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 20:39:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C49698886D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 20:39:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UZpSUJe6OdDh for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 20:39:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1A3108742D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 20:39:10 +0000 (UTC)
Received: from localhost (mobile-166-175-191-139.mycingular.net
 [166.175.191.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5F3322078B;
 Fri, 10 Jul 2020 20:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594413549;
 bh=CnULaI9ELEBbbUKasyXBx7S1yYTMAfrX6S5PK1vzqPc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=gXwmLksh2phrQuh3r16fXH2dSS+qJLkUVFIFOQ7fs+LmrslitdklFssUpLoYz9I8Y
 lUrIIXu5nceiiz6Ng+acnL1PBISNLpHxHzziPuyEXZFF+3BmBvoleu9x8bQfWWOOKM
 aXWIxklG362XQ5JOsbI4ldpWDFcyAHfMCNnrf6sI=
Date: Fri, 10 Jul 2020 15:39:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4 1/4] PCI: Move pci_enable_acs() and its dependencies
 up in pci.c
Message-ID: <20200710203908.GA78277@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200707224604.3737893-1-rajatja@google.com>
Cc: Todd Broch <tbroch@google.com>, linux-pci@vger.kernel.org,
 lalithambika.krishnakumar@intel.com,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Diego Rivas <diegorivas@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, Raj Ashok <ashok.raj@intel.com>,
 Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org,
 Christian Kellner <christian@kellner.me>,
 Mattias Nissler <mnissler@google.com>, Jesse Barnes <jsbarnes@google.com>,
 Len Brown <lenb@kernel.org>, Rajat Jain <rajatxjain@gmail.com>,
 Prashant Malani <pmalani@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Aaron Durbin <adurbin@google.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bernie Keany <bernie.keany@intel.com>, Duncan Laurie <dlaurie@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
 oohall@gmail.com, Benson Leung <bleung@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Alex Levin <levinale@google.com>
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

On Tue, Jul 07, 2020 at 03:46:01PM -0700, Rajat Jain wrote:
> Move pci_enable_acs() and the functions it depends on, further up in the
> source code to avoid having to forward declare it when we make it static
> in near future (next patch).
> 
> No functional changes intended.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

Applied patches 1-3 to pci/enumeration for v5.9, thanks!

I held off on patch 4 (enabling PCI_ACS_TB) until we have a little
more conversation on the impact of it.

> ---
> v4: Same as v3
> v3: Initial version of the patch, created per Bjorn's suggestion
> 
>  drivers/pci/pci.c | 254 +++++++++++++++++++++++-----------------------
>  1 file changed, 127 insertions(+), 127 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ce096272f52b1..eec625f0e594e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -777,6 +777,133 @@ int pci_wait_for_pending(struct pci_dev *dev, int pos, u16 mask)
>  	return 0;
>  }
>  
> +static int pci_acs_enable;
> +
> +/**
> + * pci_request_acs - ask for ACS to be enabled if supported
> + */
> +void pci_request_acs(void)
> +{
> +	pci_acs_enable = 1;
> +}
> +
> +static const char *disable_acs_redir_param;
> +
> +/**
> + * pci_disable_acs_redir - disable ACS redirect capabilities
> + * @dev: the PCI device
> + *
> + * For only devices specified in the disable_acs_redir parameter.
> + */
> +static void pci_disable_acs_redir(struct pci_dev *dev)
> +{
> +	int ret = 0;
> +	const char *p;
> +	int pos;
> +	u16 ctrl;
> +
> +	if (!disable_acs_redir_param)
> +		return;
> +
> +	p = disable_acs_redir_param;
> +	while (*p) {
> +		ret = pci_dev_str_match(dev, p, &p);
> +		if (ret < 0) {
> +			pr_info_once("PCI: Can't parse disable_acs_redir parameter: %s\n",
> +				     disable_acs_redir_param);
> +
> +			break;
> +		} else if (ret == 1) {
> +			/* Found a match */
> +			break;
> +		}
> +
> +		if (*p != ';' && *p != ',') {
> +			/* End of param or invalid format */
> +			break;
> +		}
> +		p++;
> +	}
> +
> +	if (ret != 1)
> +		return;
> +
> +	if (!pci_dev_specific_disable_acs_redir(dev))
> +		return;
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> +	if (!pos) {
> +		pci_warn(dev, "cannot disable ACS redirect for this hardware as it does not have ACS capabilities\n");
> +		return;
> +	}
> +
> +	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
> +
> +	/* P2P Request & Completion Redirect */
> +	ctrl &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC);
> +
> +	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> +
> +	pci_info(dev, "disabled ACS redirect\n");
> +}
> +
> +/**
> + * pci_std_enable_acs - enable ACS on devices using standard ACS capabilities
> + * @dev: the PCI device
> + */
> +static void pci_std_enable_acs(struct pci_dev *dev)
> +{
> +	int pos;
> +	u16 cap;
> +	u16 ctrl;
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> +	if (!pos)
> +		return;
> +
> +	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
> +	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
> +
> +	/* Source Validation */
> +	ctrl |= (cap & PCI_ACS_SV);
> +
> +	/* P2P Request Redirect */
> +	ctrl |= (cap & PCI_ACS_RR);
> +
> +	/* P2P Completion Redirect */
> +	ctrl |= (cap & PCI_ACS_CR);
> +
> +	/* Upstream Forwarding */
> +	ctrl |= (cap & PCI_ACS_UF);
> +
> +	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> +}
> +
> +/**
> + * pci_enable_acs - enable ACS if hardware support it
> + * @dev: the PCI device
> + */
> +void pci_enable_acs(struct pci_dev *dev)
> +{
> +	if (!pci_acs_enable)
> +		goto disable_acs_redir;
> +
> +	if (!pci_dev_specific_enable_acs(dev))
> +		goto disable_acs_redir;
> +
> +	pci_std_enable_acs(dev);
> +
> +disable_acs_redir:
> +	/*
> +	 * Note: pci_disable_acs_redir() must be called even if ACS was not
> +	 * enabled by the kernel because it may have been enabled by
> +	 * platform firmware.  So if we are told to disable it, we should
> +	 * always disable it after setting the kernel's default
> +	 * preferences.
> +	 */
> +	pci_disable_acs_redir(dev);
> +}
> +
>  /**
>   * pci_restore_bars - restore a device's BAR values (e.g. after wake-up)
>   * @dev: PCI device to have its BARs restored
> @@ -3230,133 +3357,6 @@ void pci_configure_ari(struct pci_dev *dev)
>  	}
>  }
>  
> -static int pci_acs_enable;
> -
> -/**
> - * pci_request_acs - ask for ACS to be enabled if supported
> - */
> -void pci_request_acs(void)
> -{
> -	pci_acs_enable = 1;
> -}
> -
> -static const char *disable_acs_redir_param;
> -
> -/**
> - * pci_disable_acs_redir - disable ACS redirect capabilities
> - * @dev: the PCI device
> - *
> - * For only devices specified in the disable_acs_redir parameter.
> - */
> -static void pci_disable_acs_redir(struct pci_dev *dev)
> -{
> -	int ret = 0;
> -	const char *p;
> -	int pos;
> -	u16 ctrl;
> -
> -	if (!disable_acs_redir_param)
> -		return;
> -
> -	p = disable_acs_redir_param;
> -	while (*p) {
> -		ret = pci_dev_str_match(dev, p, &p);
> -		if (ret < 0) {
> -			pr_info_once("PCI: Can't parse disable_acs_redir parameter: %s\n",
> -				     disable_acs_redir_param);
> -
> -			break;
> -		} else if (ret == 1) {
> -			/* Found a match */
> -			break;
> -		}
> -
> -		if (*p != ';' && *p != ',') {
> -			/* End of param or invalid format */
> -			break;
> -		}
> -		p++;
> -	}
> -
> -	if (ret != 1)
> -		return;
> -
> -	if (!pci_dev_specific_disable_acs_redir(dev))
> -		return;
> -
> -	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> -	if (!pos) {
> -		pci_warn(dev, "cannot disable ACS redirect for this hardware as it does not have ACS capabilities\n");
> -		return;
> -	}
> -
> -	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
> -
> -	/* P2P Request & Completion Redirect */
> -	ctrl &= ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC);
> -
> -	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> -
> -	pci_info(dev, "disabled ACS redirect\n");
> -}
> -
> -/**
> - * pci_std_enable_acs - enable ACS on devices using standard ACS capabilities
> - * @dev: the PCI device
> - */
> -static void pci_std_enable_acs(struct pci_dev *dev)
> -{
> -	int pos;
> -	u16 cap;
> -	u16 ctrl;
> -
> -	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
> -	if (!pos)
> -		return;
> -
> -	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
> -	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
> -
> -	/* Source Validation */
> -	ctrl |= (cap & PCI_ACS_SV);
> -
> -	/* P2P Request Redirect */
> -	ctrl |= (cap & PCI_ACS_RR);
> -
> -	/* P2P Completion Redirect */
> -	ctrl |= (cap & PCI_ACS_CR);
> -
> -	/* Upstream Forwarding */
> -	ctrl |= (cap & PCI_ACS_UF);
> -
> -	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> -}
> -
> -/**
> - * pci_enable_acs - enable ACS if hardware support it
> - * @dev: the PCI device
> - */
> -void pci_enable_acs(struct pci_dev *dev)
> -{
> -	if (!pci_acs_enable)
> -		goto disable_acs_redir;
> -
> -	if (!pci_dev_specific_enable_acs(dev))
> -		goto disable_acs_redir;
> -
> -	pci_std_enable_acs(dev);
> -
> -disable_acs_redir:
> -	/*
> -	 * Note: pci_disable_acs_redir() must be called even if ACS was not
> -	 * enabled by the kernel because it may have been enabled by
> -	 * platform firmware.  So if we are told to disable it, we should
> -	 * always disable it after setting the kernel's default
> -	 * preferences.
> -	 */
> -	pci_disable_acs_redir(dev);
> -}
> -
>  static bool pci_acs_flags_enabled(struct pci_dev *pdev, u16 acs_flags)
>  {
>  	int pos;
> -- 
> 2.27.0.212.ge8ba1cc988-goog
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
