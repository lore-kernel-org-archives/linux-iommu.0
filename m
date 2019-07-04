Return-Path: <SRS0=qghM=VB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E99C0650E
	for <iommu@archiver.kernel.org>; Thu,  4 Jul 2019 08:20:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830CA218A6
	for <iommu@archiver.kernel.org>; Thu,  4 Jul 2019 08:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830CA218A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6B444C6D;
	Thu,  4 Jul 2019 08:20:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4BF2EB6C
	for <iommu@lists.linux-foundation.org>;
	Thu,  4 Jul 2019 08:20:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1C60C87E
	for <iommu@lists.linux-foundation.org>;
	Thu,  4 Jul 2019 08:20:05 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 49E032FB; Thu,  4 Jul 2019 10:20:03 +0200 (CEST)
Date: Thu, 4 Jul 2019 10:20:01 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 1/2] iommu: add support for drivers that manage iommu
	explicitly
Message-ID: <20190704082001.GD6546@8bytes.org>
References: <20190702202631.32148-1-robdclark@gmail.com>
	<20190702202631.32148-2-robdclark@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190702202631.32148-2-robdclark@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Rob Clark <robdclark@chromium.org>, aarch64-laptops@lists.linaro.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, Sudeep Holla <sudeep.holla@arm.com>,
	Joe Perches <joe@perches.com>
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

Hi Rob,

On Tue, Jul 02, 2019 at 01:26:18PM -0700, Rob Clark wrote:
> 1) In some cases the bootloader takes the iommu out of bypass and
>    enables the display.  This is in particular a problem on the aarch64
>    laptops that exist these days, and modern snapdragon android devices.
>    (Older devices also enabled the display in bootloader but did not
>    take the iommu out of bypass.)  Attaching a DMA or IDENTITY domain
>    while scanout is active, before the driver has a chance to intervene,
>    makes things go *boom*

Just to make sure I get this right: The bootloader inializes the SMMU
and creates non-identity mappings for the GPU? And when the SMMU driver
in Linux takes over this breaks display output.

> +	/*
> +	 * If driver is going to manage iommu directly, then avoid
> +	 * attaching any non driver managed domain.  There could
> +	 * be already active dma underway (ie. scanout in case of
> +	 * bootloader enabled display), and interfering with that
> +	 * will make things go *boom*
> +	 */
> +	if ((domain->type != IOMMU_DOMAIN_UNMANAGED) &&
> +	    dev->driver && dev->driver->driver_manages_iommu)
> +		return 0;
> +

When the default domain is attached, there is usually no driver attached
yet. I think this needs to be communicated by the firmware to Linux and
the code should check against that.

> -	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
> +	bool suppress_bind_attrs:1;	/* disables bind/unbind via sysfs */
> +	bool driver_manages_iommu:1;	/* driver manages IOMMU explicitly */

How does this field get set?



	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
