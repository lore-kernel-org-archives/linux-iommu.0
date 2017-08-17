From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 06/13] drm/etnaviv: Use sychronized interface of the
 IOMMU-API
Date: Thu, 17 Aug 2017 16:35:09 +0200
Message-ID: <20170817143509.GH16908@8bytes.org>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
 <1502974596-23835-7-git-send-email-joro@8bytes.org>
 <1502976758.19806.25.camel@pengutronix.de>
 <20170817134539.GJ2853@suse.de>
 <1502978634.19806.27.camel@pengutronix.de>
 <20170817141858.GG16908@8bytes.org>
 <1502980248.19806.29.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502980248.19806.29.camel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Russell King <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner <christian.gmeiner@gmail.com>, David Airlie <airlied@linux.ie>, etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 17, 2017 at 04:30:48PM +0200, Lucas Stach wrote:
> Yeah, the IOMMU API being used internally is a historical accident, that
> we didn't get around to rectify yet. It's on my things-we-need-to-do
> list to prune the usage of the IOMMU API in etnaviv.

Okay, so for the time being, I drop the etnaviv patch from this series.


Thanks,

	Joerg
