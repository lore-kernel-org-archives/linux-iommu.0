Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05549C433EF
	for <iommu@archiver.kernel.org>; Tue, 22 Mar 2022 11:41:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97130611E8;
	Tue, 22 Mar 2022 11:41:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eNWAdNBKsff2; Tue, 22 Mar 2022 11:41:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5F3AF611E6;
	Tue, 22 Mar 2022 11:41:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 324A0C0012;
	Tue, 22 Mar 2022 11:41:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10322C000B
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 11:41:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE2D8611E7
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 11:41:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JAzRs7zpkd6T for <iommu@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 11:41:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E524B611E6
 for <iommu@lists.linux-foundation.org>; Tue, 22 Mar 2022 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647949294; x=1679485294;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HvgOL6YZgSy7nSW+sywrpP3lBboqncbKKW+arHb8epo=;
 b=k7nuf0NjCH3ynlm2385jDtNxxR03r0xnx3djkafRp/Zk2VNkBnRVjt59
 Sjes4ewHPoKWDnRqezh0dYc08YO25zBOHw/hZ3xsLa3Kkcp+axDSNgmWJ
 UU1tZr0c3dWPnCmjFuuIGNoB771ZihdGzNkFCEJlNbjF4ReMM9N6seFOG
 rdmQPJETY9qKNL5aCQilFFnVRj+bQ4jayyKeEfuH1BThdse9rVPzluq/F
 gS0RTcNpe6X1dX/tjmpFCK4OQcWhObNlZ+IXLzZKTv0LeRJrsPh1lqTWO
 muJfUA+K7I3TWDzIodV5pGd4fcG9gReiWOsWHfIEig249e+rEXqKaUtsW w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="257745183"
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; d="scan'208";a="257745183"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2022 04:41:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; d="scan'208";a="646992054"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2022 04:41:30 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 22 Mar 2022 13:41:27 +0200
Date: Tue, 22 Mar 2022 13:41:27 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 2/2] thunderbolt: Make iommu_dma_protection more
 accurate
Message-ID: <Yjm150r3KPKp/2O4@lahna>
References: <cover.1647624084.git.robin.murphy@arm.com>
 <0dd14883930c9f55ace22162e23765a37d91a057.1647624084.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0dd14883930c9f55ace22162e23765a37d91a057.1647624084.git.robin.murphy@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: michael.jamet@intel.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, YehezkelShB@gmail.com,
 iommu@lists.linux-foundation.org, mario.limonciello@amd.com,
 andreas.noever@gmail.com, hch@lst.de
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

Hi Robin,

I tried this now on two Intel systems. One with integrated Thunderbolt
and one with discrete. There was a small issue, see below but once fixed
it worked as expected :)

On Fri, Mar 18, 2022 at 05:42:58PM +0000, Robin Murphy wrote:
> Between me trying to get rid of iommu_present() and Mario wanting to
> support the AMD equivalent of DMAR_PLATFORM_OPT_IN, scrutiny has shown
> that the iommu_dma_protection attribute is being far too optimistic.
> Even if an IOMMU might be present for some PCI segment in the system,
> that doesn't necessarily mean it provides translation for the device(s)
> we care about. Furthermore, all that DMAR_PLATFORM_OPT_IN really does
> is tell us that memory was protected before the kernel was loaded, and
> prevent the user from disabling the intel-iommu driver entirely. While
> that lets us assume kernel integrity, what matters for actual runtime
> DMA protection is whether we trust individual devices, based on the
> "external facing" property that we expect firmware to describe for
> Thunderbolt ports.
> 
> It's proven challenging to determine the appropriate ports accurately
> given the variety of possible topologies, so while still not getting a
> perfect answer, by putting enough faith in firmware we can at least get
> a good bit closer. If we can see that any device near a Thunderbolt NHI
> has all the requisites for Kernel DMA Protection, chances are that it
> *is* a relevant port, but moreover that implies that firmware is playing
> the game overall, so we'll use that to assume that all Thunderbolt ports
> should be correctly marked and thus will end up fully protected.
> 
> CC: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: Give up trying to look for specific devices, just look for evidence
>     that firmware cares at all.
> 
>  drivers/thunderbolt/domain.c | 12 +++--------
>  drivers/thunderbolt/nhi.c    | 41 ++++++++++++++++++++++++++++++++++++
>  include/linux/thunderbolt.h  |  2 ++
>  3 files changed, 46 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
> index 7018d959f775..2889a214dadc 100644
> --- a/drivers/thunderbolt/domain.c
> +++ b/drivers/thunderbolt/domain.c
> @@ -7,9 +7,7 @@
>   */
>  
>  #include <linux/device.h>
> -#include <linux/dmar.h>
>  #include <linux/idr.h>
> -#include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> @@ -257,13 +255,9 @@ static ssize_t iommu_dma_protection_show(struct device *dev,
>  					 struct device_attribute *attr,
>  					 char *buf)
>  {
> -	/*
> -	 * Kernel DMA protection is a feature where Thunderbolt security is
> -	 * handled natively using IOMMU. It is enabled when IOMMU is
> -	 * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT_IN set.
> -	 */
> -	return sprintf(buf, "%d\n",
> -		       iommu_present(&pci_bus_type) && dmar_platform_optin());
> +	struct tb *tb = container_of(dev, struct tb, dev);
> +
> +	return sysfs_emit(buf, "%d\n", tb->nhi->iommu_dma_protection);
>  }
>  static DEVICE_ATTR_RO(iommu_dma_protection);
>  
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index c73da0532be4..9e396e283792 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -14,6 +14,7 @@
>  #include <linux/errno.h>
>  #include <linux/pci.h>
>  #include <linux/interrupt.h>
> +#include <linux/iommu.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/property.h>
> @@ -1102,6 +1103,45 @@ static void nhi_check_quirks(struct tb_nhi *nhi)
>  		nhi->quirks |= QUIRK_AUTO_CLEAR_INT;
>  }
>  
> +static int nhi_check_iommu_pdev(struct pci_dev *pdev, void *data)
> +{
> +	if (!pdev->untrusted ||
> +	    !dev_iommu_capable(&pdev->dev, IOMMU_CAP_PRE_BOOT_PROTECTION))

This one needs to take the pdev->external_facing into account too
because most of the time there are no existing tunnels when the driver
is loaded so we only see the PCIe root/downstream port. I think this is
enough actually:

	if (!pdev->external_facing ||
	    !dev_iommu_capable(&pdev->dev, IOMMU_CAP_PRE_BOOT_PROTECTION))

> +		return 0;
> +	*(bool *)data = true;
> +	return 1; /* Stop walking */
> +}
> +
> +static void nhi_check_iommu(struct tb_nhi *nhi)
> +{
> +	struct pci_bus *bus = nhi->pdev->bus;
> +	bool port_ok = false;
> +
> +	/*
> +	 * Ideally what we'd do here is grab every PCI device that
> +	 * represents a tunnelling adapter for this NHI and check their
> +	 * status directly, but unfortunately USB4 seems to make it
> +	 * obnoxiously difficult to reliably make any correlation.
> +	 *
> +	 * So for now we'll have to bodge it... Hoping that the system
> +	 * is at least sane enough that an adapter is in the same PCI
> +	 * segment as its NHI, if we can find *something* on that segment
> +	 * which meets the requirements for Kernel DMA Protection, we'll
> +	 * take that to imply that firmware is aware and has (hopefully)
> +	 * done the right thing in general. We need to know that the PCI
> +	 * layer has seen the ExternalFacingPort property and propagated
> +	 * it to the "untrusted" flag that the IOMMU layer will then
> +	 * enforce, but also that the IOMMU driver itself can be trusted
> +	 * not to have been subverted by a pre-boot DMA attack.
> +	 */
> +	while (bus->parent)
> +		bus = bus->parent;
> +
> +	pci_walk_bus(bus, nhi_check_iommu_pdev, &port_ok);
> +
> +	nhi->iommu_dma_protection = port_ok;

I would put here a log debug, something like this:

dev_dbg(&nhi->pdev->dev, "IOMMU DMA protection is %sabled\n",
	port_ok ? "en" : "dis");
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
