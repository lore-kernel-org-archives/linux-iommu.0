Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5729C433F5
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 11:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4940581B04;
	Tue,  8 Feb 2022 11:35:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WZeIk_MURoC7; Tue,  8 Feb 2022 11:35:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F195981A33;
	Tue,  8 Feb 2022 11:35:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCEF4C0011;
	Tue,  8 Feb 2022 11:35:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 945CEC000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 11:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 90B4B4024D
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 11:35:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HIfnqhy4GLMa for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 11:35:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AAD8840233
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 11:35:48 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 39EAA6164D;
 Tue,  8 Feb 2022 11:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177FAC004E1;
 Tue,  8 Feb 2022 11:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1644320146;
 bh=oqAwa4TvaCnMLZq3Jlv14O8K41LAi+3ZANEnne9fz0M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=siGXsPr/vwToRWq39wEjRkdcljn1K5to7skGnrPV2dBflTsJ4s04w+5MYNHH2MLgU
 exW8whDq9BB9MMZ9ZIuzeY4a4eV6YdYNMOUqiMg/11sTiO20Zd6MjjU3BQbvTdVQFl
 OjZmXIupAGk46BOjC51jeLuv05KctkrjlzLJdQTE=
Date: Tue, 8 Feb 2022 12:35:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 02/14] driver core: Add dma_cleanup callback in bus_type
Message-ID: <YgJVj/EmzjtR2SKk@kroah.com>
References: <20220104015644.2294354-1-baolu.lu@linux.intel.com>
 <20220104015644.2294354-3-baolu.lu@linux.intel.com>
 <YdQcpHrV7NwUv+qc@infradead.org>
 <20220104123911.GE2328285@nvidia.com> <YdRFyXWay/bdSSem@kroah.com>
 <608192e0-136a-57fc-cb2c-3ebb42874788@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <608192e0-136a-57fc-cb2c-3ebb42874788@linux.intel.com>
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On Tue, Feb 08, 2022 at 01:55:29PM +0800, Lu Baolu wrote:
> Hi Greg,
> 
> On 1/4/22 9:04 PM, Greg Kroah-Hartman wrote:
> > On Tue, Jan 04, 2022 at 08:39:11AM -0400, Jason Gunthorpe wrote:
> > > On Tue, Jan 04, 2022 at 02:08:36AM -0800, Christoph Hellwig wrote:
> > > > All these bus callouts still looks horrible and just create tons of
> > > > boilerplate code.
> > > 
> > > Yes, Lu - Greg asked questions then didn't respond to their answers
> > > meaning he accepts them, you should stick with the v4 version.
> > 
> > Trying to catch up on emails from the break, that was way down my list
> > of things to get back to as it's messy and non-obvious.  I'll revisit it
> > again after 5.17-rc1 is out, this is too late for that merge window
> > anyway.
> 
> In this series we want to add calls into the iommu subsystem during
> device driver binding/unbinding, so that the device DMA ownership
> conflict (kernel driver vs. user-space) could be detected and avoided
> before calling into device driver's .probe().
> 
> In this v5 series, we implemented this in the affected buses (amba/
> platform/fsl-mc/pci) which are known to support assigning devices to
> user space through the vfio framework currently. And more buses are
> possible to be affected in the future if they also want to support
> device assignment. Christoph commented that this will create boilerplate
> code in various bus drivers.
> 
> Back to v4 of this series (please refer to below link [1]), we added
> this call in the driver core if buses have provided the dma_configure()
> callback (please refer to below link [2]).
> 
> Which would you prefer, or any other suggestions? We need your guide to
> move this series ahead. Please help to suggest.
> 
> [1] https://lore.kernel.org/linux-iommu/20211217063708.1740334-1-baolu.lu@linux.intel.com/
> [2] https://lore.kernel.org/linux-iommu/20211217063708.1740334-3-baolu.lu@linux.intel.com/

Let me look over the series again this afternooon.

thanks,

greg k-h
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
