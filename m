Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48E8C433F5
	for <iommu@archiver.kernel.org>; Wed, 23 Mar 2022 06:17:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67721419B1;
	Wed, 23 Mar 2022 06:17:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MsfeSUS6aVZB; Wed, 23 Mar 2022 06:17:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 24028418F5;
	Wed, 23 Mar 2022 06:17:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7010C001A;
	Wed, 23 Mar 2022 06:17:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F3F87C000B
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 06:17:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CA9F2404F3
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 06:17:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DO2ZqAVx7SwJ for <iommu@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 06:17:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 85EF5401D2
 for <iommu@lists.linux-foundation.org>; Wed, 23 Mar 2022 06:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1648016248; x=1679552248;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8vzD92UhHfMzrQ/OOVyGmFmDcRcFc7OySsWTT7LpWT4=;
 b=NPKSS7DoayzTvRCnMWnIdrtpnWUgWstqMFR+IwGnt4P0wNlkkgAEJUI1
 mJGE3rXxuYk/W8RoHw63BD9scav+gkWNrHN/gos0pUyfp/07R33QsijS8
 3IU8nS0vKFfp8dWYPTzA4AJDHzVs8MxVRLXW19GJ5RKqAADpcU3RJ2CnH
 frlyEl/VdMrYHOVEiN6MKWYzSoP6EMyDqQZEznBGJNu7Gl/2k3dNuAIJy
 /Wn3223S9+gKfdTMEWG4nDcJ/kiPQvUp7nFjw0jnk4mC4wjhwCQHI6Yd9
 xzzjouvBD3s3iF1ZT82/5dUcebdlUFXQKq1PLHw4KNnjFXe72lv/YSDuu Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="237974275"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; d="scan'208";a="237974275"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2022 23:17:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; d="scan'208";a="692833797"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2022 23:17:22 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 23 Mar 2022 08:16:15 +0200
Date: Wed, 23 Mar 2022 08:16:15 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4 1/2] PCI: Rename "pci_dev->untrusted" to
 "pci_dev->poses_dma_risk"
Message-ID: <Yjq7LzdQDIhtxSJM@lahna>
References: <20220320062907.3272903-1-rajatja@google.com>
 <YjmQq1DvWnJwUh6R@infradead.org>
 <CAJZ5v0h9TnUELahzkO59Vqoio1QRHfixk58Yxgffa72rmEBgOA@mail.gmail.com>
 <CACK8Z6Fz-TPW1fMpQB09fw11neq8eyn89XB8vy0ioB5zB0Hb9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACK8Z6Fz-TPW1fMpQB09fw11neq8eyn89XB8vy0ioB5zB0Hb9Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Rajat Jain <rajatxjain@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Pavel Machek <pavel@denx.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Oliver O'Halloran <oohall@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>, Will Deacon <will@kernel.org>,
 Jesse Barnes <jsbarnes@google.com>, Dmitry Torokhov <dtor@google.com>,
 Len Brown <lenb@kernel.org>
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

On Tue, Mar 22, 2022 at 01:09:55PM -0700, Rajat Jain wrote:
> On Tue, Mar 22, 2022 at 4:12 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Mar 22, 2022 at 10:02 AM Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Sat, Mar 19, 2022 at 11:29:05PM -0700, Rajat Jain wrote:
> > > > Rename the field to make it more clear, that the device can execute DMA
> > > > attacks on the system, and thus the system may need protection from
> > > > such attacks from this device.
> > > >
> > > > No functional change intended.
> > > >
> > > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > > ---
> > > > v4: Initial version, created based on comments on other patch
> > >
> > > What a horrible name.  Why not untrusted_dma which captures the
> > > intent much better?
> >
> > FWIW, I like this one much better too.
> 
> Sure, no problems. I can change the name to "untrusted_dma".
> 
> Mika, can I carry forward your "Reviewed-by" tag with this name change too?

Sure :)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
