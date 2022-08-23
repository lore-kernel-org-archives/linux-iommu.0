Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3B3A3B
	for <iommu@lists.linux.dev>; Tue, 23 Aug 2022 07:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1661238652; x=1692774652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AHjGqzbn5AEN1DPa4fi7l7adOs/3lxb+lkmMBcf6O7Y=;
  b=EM5szJ4T/D/6Rd96/K4w9Mr+XyPsNAeBs1WHewovviAW6V+6kJjpC7o8
   E5n1c2LuNYzVeUhBZdHtDEzUIhQrbBovR0myGQwTlzQ9B7sC6jYb7d3nR
   Lp1HCGWvf6Mr7Zi/kxB2IApZn3NZ41PbBYXqIJC+2JMLYkDFgWRpP8/eo
   wttFIh4PRO5aBFdhji/FL589DgLsQxI8r3SRNXNvF3lAwMWzwIhSUA4dW
   Vn4JokU+t9873lhkeXQjC2S6K6OD/82iiIVls41ivvFSy1Rj2zIdo69Dr
   2xU1vomzyhxTQ7F0O87bbt2dO4O+DhUJ2fTlJTgb52s7be6s3cCVlYDRz
   w==;
X-IronPort-AV: E=Sophos;i="5.93,256,1654552800"; 
   d="scan'208";a="25745654"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 23 Aug 2022 09:09:39 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 23 Aug 2022 09:09:39 +0200
X-PGP-Universal: processed;
	by tq-pgp-pr1.tq-net.de on Tue, 23 Aug 2022 09:09:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1661238579; x=1692774579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AHjGqzbn5AEN1DPa4fi7l7adOs/3lxb+lkmMBcf6O7Y=;
  b=O89a04YFCt75bvQHupeYZgzQ5IYiSPHRv7/Fxvkika6jAVXwg8pHlMC/
   GfY8tQiL/S9X6oBp+5oFeKnFmY+SmsnOZqAtL5AjTWnHQYxLkMoG6fBxW
   /yF53dSYaqZ5vpsI+MstouunEiA3aSHDSofWZ5HXrtGbWVZpeKSJIK4WF
   iCBr7UnZiFyAjSbnMNkJm/ECGZYEbFLS0pLLvnC5583ULKW0howNfU3PJ
   CSQAgUGBO52Hz0//IRFg1bP4P7+wurLR9WK4hilmyPUK0MfOVsxY+RBKq
   vOuObOQuDaklWU/x43onsnguZ9W+64b4fHdu8OAwR3RpFaKu/zVM4UJVS
   g==;
X-IronPort-AV: E=Sophos;i="5.93,256,1654552800"; 
   d="scan'208";a="25745653"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Aug 2022 09:09:39 +0200
Received: from steina-w.localnet (unknown [10.123.49.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 16CBE280056;
	Tue, 23 Aug 2022 09:09:39 +0200 (CEST)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Saravana Kannan <saravanak@google.com>, Peng Fan <peng.fan@nxp.com>, Luca Weiss <luca.weiss@fairphone.com>, Doug Anderson <dianders@chromium.org>, Colin Foster <colin.foster@in-advantage.com>, Tony Lindgren <tony@atomide.com>, Naresh Kamboju <naresh.kamboju@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Jean-Philippe Brucker <jpb@kernel.org>, kernel-team@android.com, linux-kernel@vger.kernel.org, linux-pm
 @vger.kernel.org, iommu@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Bring back driver_deferred_probe_check_state() for now
Date: Tue, 23 Aug 2022 09:09:38 +0200
Message-ID: <6787064.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20220819221616.2107893-1-saravanak@google.com>
References: <20220819221616.2107893-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hello Saravana,

Am Samstag, 20. August 2022, 00:16:10 CEST schrieb Saravana Kannan:
> A bunch of issues have been reported in the original series[1] that removed
> driver_deferred_probe_check_state(). While most of the issues have been
> fixed in a new series that improved fw_devlink [2], there are still a few
> unresolved issues I need to address.
> 
> So let's bring back driver_deferred_probe_check_state() until the other
> issues are resolved.
> 
> Greg,
> 
> Can we get this into 6.0-rcX please?

On my TQMa8MQ + MBa8Mxon top of 072e51356cd5 ("Merge tag 'nfs-for-5.20-2' of 
git://git.linux-nfs.org/projects/trondmy/linux-nfs"):
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> [1] -
> https://lore.kernel.org/lkml/20220601070707.3946847-1-saravanak@google.com/
> [2] -
> https://lore.kernel.org/lkml/20220810060040.321697-1-saravanak@google.com/
> 
> v1 -> v2:
> - Added a revert of the iommu change too.
> 
> Saravana Kannan (4):
>   Revert "driver core: Delete driver_deferred_probe_check_state()"
>   Revert "net: mdio: Delete usage of
>     driver_deferred_probe_check_state()"
>   Revert "PM: domains: Delete usage of
>     driver_deferred_probe_check_state()"
>   Revert "iommu/of: Delete usage of driver_deferred_probe_check_state()"
> 
>  drivers/base/dd.c              | 30 ++++++++++++++++++++++++++++++
>  drivers/base/power/domain.c    |  2 +-
>  drivers/iommu/of_iommu.c       |  2 +-
>  drivers/net/mdio/fwnode_mdio.c |  4 +++-
>  include/linux/device/driver.h  |  1 +
>  5 files changed, 36 insertions(+), 3 deletions(-)




