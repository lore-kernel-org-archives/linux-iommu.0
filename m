Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2766BC433E1
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 17:44:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB4B520775
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 17:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="AIvFwiVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB4B520775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C2D7187EF9;
	Tue, 30 Jun 2020 17:44:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lEyDa20BRJy1; Tue, 30 Jun 2020 17:44:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C6B5B87EB5;
	Tue, 30 Jun 2020 17:44:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3A42C0865;
	Tue, 30 Jun 2020 17:44:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAF83C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 17:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C256B22849
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 17:44:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GR57Kq6As34C for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 17:44:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 71D4D2281E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 17:44:14 +0000 (UTC)
Received: by mail-ot1-f65.google.com with SMTP id t18so6292369otq.5
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 10:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pvrPSyad64a06y3emmBaHBraeMnCfgt6QtYJn+H41Ho=;
 b=AIvFwiVmHfWa0dr/Zj/nl3/Gf+Dd7lJR5y4sPWVHQ6irUWAzRxeWoOb/p2Glgrk5x7
 TDEjkGmBqHJFS3FeMsKSUuM+D3gUcPWXfX8izqzDYuu0i5RlpD4ZYEGNnt5HD5TFGK/4
 +VZg7MDSEIbgEZSrQtROVsWPTIRaGegwbqGtn6aYm7ZDVsTuiNa6Vz1uvzRXOMzrKN6M
 vrZA71ayaPMxJ7T9dyamhd8XLmDYQA3mCTowCoZLR+iNzAZTh88X+FxrewQAkskd6ncd
 EOt1xr66NGeLzGOPzxdLzf+Wr/iHl7eww9QdEkZ4ZlS5fCywYXwwCJ9aTWMyMziBOyS6
 r9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pvrPSyad64a06y3emmBaHBraeMnCfgt6QtYJn+H41Ho=;
 b=AGDo/KAChaG/V1aG7G+GCpUmfXOIqPXTVCKEEZPwHnKAaUbMQDFTv8vsrfB3HocsGG
 bsTNQ++tWolHhWIjM8qHUWM4KYNF2WvICUZY96zCJ0e8NFhfZh/a093CZKzKJOEKqpGR
 5wWCUVMkYzumkGE9JWooJQ1OjT+ozDQbKoR7Zdwp1PRaO1jKIAbOGNDtyBfKZTTpaZ+a
 09xSocOW7PHNERAyGtVosqOK2JDuP+Mvw4rlgrIc/nYe53Vz5XJ27A6CuksY3iYX9ahB
 RGsDzaX7cyXLZn+PlszpNfQZaz6LxP+qwknTrDSO2sEiYVyq/dAugDLyKSPBr/M4G7ur
 c88g==
X-Gm-Message-State: AOAM533pKvTKKIPcjNFAMlBfSOHqoJbm930cphm4LshWWU40s8+K7HIE
 b9vtF7e8wsg7vrg5MBJbECH7SIOVIjl9R9Ln3sJZjA==
X-Google-Smtp-Source: ABdhPJxvmOdBgLv+Am0qzfX+NxBE+/4lC8/0GP2QXouYO+Xni8icBayVXFLmI+l2lGzBS6ZBGHtQIVdLNxB8n7tHCR8=
X-Received: by 2002:a9d:8ea:: with SMTP id 97mr11889961otf.231.1593539053111; 
 Tue, 30 Jun 2020 10:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200630044943.3425049-1-rajatja@google.com>
 <20200630044943.3425049-6-rajatja@google.com>
In-Reply-To: <20200630044943.3425049-6-rajatja@google.com>
Date: Tue, 30 Jun 2020 10:43:37 -0700
Message-ID: <CAGETcx9hgV70DVdbOvCF+tO4b-6+1JzN1_OmPmnWjj9qJhB_dw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] driver core: Add device location to "struct
 device" and expose it in sysfs
To: Rajat Jain <rajatja@google.com>
Cc: Todd Broch <tbroch@google.com>, Linux PCI <linux-pci@vger.kernel.org>,
 lalithambika.krishnakumar@intel.com,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Diego Rivas <diegorivas@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Furquan Shaikh <furquan@google.com>, Raj Ashok <ashok.raj@intel.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>,
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
From: Saravana Kannan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Jun 29, 2020 at 9:49 PM Rajat Jain <rajatja@google.com> wrote:
>
> Add a new (optional) field to denote the physical location of a device
> in the system, and expose it in sysfs. This was discussed here:
> https://lore.kernel.org/linux-acpi/20200618184621.GA446639@kroah.com/
>
> (The primary choice for attribute name i.e. "location" is already
> exposed as an ABI elsewhere, so settled for "site"). Individual buses
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
>

<snip> I'm not CC'ed in 4/7, so just replying

> diff --git a/include/linux/device.h b/include/linux/device.h
> index 15460a5ac024a..a4143735ae712 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -428,6 +428,31 @@ enum dl_dev_state {
>         DL_DEV_UNBINDING,
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
> +       SITE_UNKNOWN = 0,
> +       SITE_INTERNAL,
> +       SITE_EXTENDED,
> +       SITE_EXTERNAL,
> +};
> +
>  /**
>   * struct dev_links_info - Device data related to device links.
>   * @suppliers: List of links to supplier devices.
> @@ -513,6 +538,7 @@ struct dev_links_info {
>   *             device (i.e. the bus driver that discovered the device).
>   * @iommu_group: IOMMU group the device belongs to.
>   * @iommu:     Per device generic IOMMU runtime data
> + * @site:      Physical location of the device w.r.t. the system
>   *
>   * @offline_disabled: If set, the device is permanently online.
>   * @offline:   Set after successful invocation of bus type's .offline().
> @@ -613,6 +639,8 @@ struct device {
>         struct iommu_group      *iommu_group;
>         struct dev_iommu        *iommu;
>
> +       enum device_site        site;   /* Device physical location */
> +
>         bool                    offline_disabled:1;
>         bool                    offline:1;
>         bool                    of_node_reused:1;
> @@ -806,6 +834,20 @@ static inline bool dev_has_sync_state(struct device *dev)
>         return false;
>  }
>
> +static inline int dev_set_site(struct device *dev, enum device_site site)
> +{
> +       if (site < SITE_UNKNOWN || site > SITE_EXTERNAL)
> +               return -EINVAL;
> +
> +       dev->site = site;
> +       return 0;
> +}
> +
> +static inline bool dev_is_external(struct device *dev)
> +{
> +       return dev->site == SITE_EXTERNAL;
> +}

I'm not CC'ed in the rest of the patches in this series, so just
responding here. I see you use this function in patch 6/7 to decide if
the PCI device is trusted. Anything other than EXTERNAL is being
treated as trusted. I'd argue that anything that's not internal should
be distrusted. For example, I can have a hacked up laptop dock that I
can share with you when you visit my home/office and now you are
trusting it when you shouldn't be.

Also, "UNKNOWN" is treated as trusted in patch 6/7. I'm guessing this
is because some of the devices might not have the info in their
firmware? At which point, this feature isn't even protecting all the
PCI ports properly? This adds to Greg point that this should be a
userspace policy so that it can override whatever is wrong/missing in
the firmware.

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
