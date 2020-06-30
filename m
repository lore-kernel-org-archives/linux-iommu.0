Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F057C433DF
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 08:01:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3065620768
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 08:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyXAxBvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3065620768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 25E6588168;
	Tue, 30 Jun 2020 08:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dKr0kAyxbuDq; Tue, 30 Jun 2020 08:01:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6931387B40;
	Tue, 30 Jun 2020 08:01:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54ACBC0865;
	Tue, 30 Jun 2020 08:01:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 349BBC016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 08:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2E17520349
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 08:01:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QrUfmg8JXwpM for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 08:01:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 7DA282155D
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 08:01:33 +0000 (UTC)
Received: from localhost (unknown [84.241.197.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 602DC2067D;
 Tue, 30 Jun 2020 08:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593504093;
 bh=/K95gsIeDFvq/cfNbSHemowJV1GCgFyuiQ9gKwSv3Dg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KyXAxBvS92Smno1SNYEhOgU+4s003HTesBM/Wqpyq2ZMXsxbMLjq6PKv3IHl+bKLg
 yvpRpOc1IBZOBgNBFqef2xTUkXeHKaN2Bo9O041B7uAENgdVe0QtinHAU+wrTwGP21
 Huxdlg6gNi+hL+Q/paKVdRwLAfPx39Vg77dI1sKs=
Date: Tue, 30 Jun 2020 10:01:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v2 5/7] driver core: Add device location to "struct
 device" and expose it in sysfs
Message-ID: <20200630080130.GB619174@kroah.com>
References: <20200630044943.3425049-1-rajatja@google.com>
 <20200630044943.3425049-6-rajatja@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200630044943.3425049-6-rajatja@google.com>
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

On Mon, Jun 29, 2020 at 09:49:41PM -0700, Rajat Jain wrote:
> Add a new (optional) field to denote the physical location of a device
> in the system, and expose it in sysfs. This was discussed here:
> https://lore.kernel.org/linux-acpi/20200618184621.GA446639@kroah.com/
> 
> (The primary choice for attribute name i.e. "location" is already
> exposed as an ABI elsewhere, so settled for "site").

Where is "location" exported?  I see one USB port sysfs attribute, is
that what you are worried about here?

> Individual buses
> that want to support this new attribute can opt-in by setting a flag in
> bus_type, and then populating the location of device while enumerating
> it.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v2: (Initial version)
> 
>  drivers/base/core.c        | 35 +++++++++++++++++++++++++++++++
>  include/linux/device.h     | 42 ++++++++++++++++++++++++++++++++++++++
>  include/linux/device/bus.h |  8 ++++++++
>  3 files changed, 85 insertions(+)


No Documentation/ABI/ update for this new attribute?  Why not?

> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 67d39a90b45c7..14c815526b7fa 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1778,6 +1778,32 @@ static ssize_t online_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(online);
>  
> +static ssize_t site_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	const char *site;
> +
> +	device_lock(dev);
> +	switch (dev->site) {
> +	case SITE_INTERNAL:
> +		site = "INTERNAL";
> +		break;
> +	case SITE_EXTENDED:
> +		site = "EXTENDED";
> +		break;
> +	case SITE_EXTERNAL:
> +		site = "EXTERNAL";
> +		break;
> +	case SITE_UNKNOWN:
> +	default:
> +		site = "UNKNOWN";
> +		break;
> +	}
> +	device_unlock(dev);

Why are you locking/unlocking a device here?

You have a reference count on the structure, are you worried about
something else changing here on it?  If so, what?  You aren't locking it
when the state is set (which is fine, really, you shouldn't need to.)


> +	return sprintf(buf, "%s\n", site);
> +}
> +static DEVICE_ATTR_RO(site);
> +
>  int device_add_groups(struct device *dev, const struct attribute_group **groups)
>  {
>  	return sysfs_create_groups(&dev->kobj, groups);
> @@ -1949,8 +1975,16 @@ static int device_add_attrs(struct device *dev)
>  			goto err_remove_dev_groups;
>  	}
>  
> +	if (bus_supports_site(dev->bus)) {
> +		error = device_create_file(dev, &dev_attr_site);
> +		if (error)
> +			goto err_remove_dev_attr_online;
> +	}
> +
>  	return 0;
>  
> + err_remove_dev_attr_online:
> +	device_remove_file(dev, &dev_attr_online);
>   err_remove_dev_groups:
>  	device_remove_groups(dev, dev->groups);
>   err_remove_type_groups:
> @@ -1968,6 +2002,7 @@ static void device_remove_attrs(struct device *dev)
>  	struct class *class = dev->class;
>  	const struct device_type *type = dev->type;
>  
> +	device_remove_file(dev, &dev_attr_site);
>  	device_remove_file(dev, &dev_attr_online);
>  	device_remove_groups(dev, dev->groups);
>  
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 15460a5ac024a..a4143735ae712 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -428,6 +428,31 @@ enum dl_dev_state {
>  	DL_DEV_UNBINDING,
>  };
>  
> +/**
> + * enum device_site - Physical location of the device in the system.
> + * The semantics of values depend on subsystem / bus:
> + *
> + * @SITE_UNKNOWN:  Location is Unknown (default)
> + *
> + * @SITE_INTERNAL: Device is internal to the system, and cannot be (easily)
> + *                 removed. E.g. SoC internal devices, onboard soldered
> + *                 devices, internal M.2 cards (that cannot be removed
> + *                 without opening the chassis).
> + * @SITE_EXTENDED: Device sits an extension of the system. E.g. devices
> + *                 on external PCIe trays, docking stations etc. These
> + *                 devices may be removable, but are generally housed
> + *                 internally on an extension board, so they are removed
> + *                 only when that whole extension board is removed.
> + * @SITE_EXTERNAL: Devices truly external to the system (i.e. plugged on
> + *                 an external port) that may be removed or added frequently.
> + */
> +enum device_site {
> +	SITE_UNKNOWN = 0,
> +	SITE_INTERNAL,
> +	SITE_EXTENDED,
> +	SITE_EXTERNAL,
> +};
> +
>  /**
>   * struct dev_links_info - Device data related to device links.
>   * @suppliers: List of links to supplier devices.
> @@ -513,6 +538,7 @@ struct dev_links_info {
>   * 		device (i.e. the bus driver that discovered the device).
>   * @iommu_group: IOMMU group the device belongs to.
>   * @iommu:	Per device generic IOMMU runtime data
> + * @site:	Physical location of the device w.r.t. the system
>   *
>   * @offline_disabled: If set, the device is permanently online.
>   * @offline:	Set after successful invocation of bus type's .offline().
> @@ -613,6 +639,8 @@ struct device {
>  	struct iommu_group	*iommu_group;
>  	struct dev_iommu	*iommu;
>  
> +	enum device_site	site;	/* Device physical location */
> +
>  	bool			offline_disabled:1;
>  	bool			offline:1;
>  	bool			of_node_reused:1;
> @@ -806,6 +834,20 @@ static inline bool dev_has_sync_state(struct device *dev)
>  	return false;
>  }
>  
> +static inline int dev_set_site(struct device *dev, enum device_site site)
> +{
> +	if (site < SITE_UNKNOWN || site > SITE_EXTERNAL)
> +		return -EINVAL;

It's an enum, why check the range?

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
