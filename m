Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565E7C433EF
	for <iommu@archiver.kernel.org>; Thu,  6 Jan 2022 18:32:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1EF8428A5;
	Thu,  6 Jan 2022 18:32:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0QqefSWBFV8J; Thu,  6 Jan 2022 18:32:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DBD1842965;
	Thu,  6 Jan 2022 18:32:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C85EC0030;
	Thu,  6 Jan 2022 18:32:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CA84C001E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 18:32:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EC5D681410
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 18:32:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J3mU_lN7QQ-h for <iommu@lists.linux-foundation.org>;
 Thu,  6 Jan 2022 18:32:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 36D6F8140C
 for <iommu@lists.linux-foundation.org>; Thu,  6 Jan 2022 18:32:29 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2757FB822B4;
 Thu,  6 Jan 2022 18:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DE9C36AE3;
 Thu,  6 Jan 2022 18:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641493946;
 bh=5lY+HI8ihg/c9/B+VNUfvaxm/xosjyotG49pQ10u82w=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=XirhBewNwMlp7K0TCeGeOUGw2hgP2JEu1cZv3AQV10PBvw4ZYBsmz1pS++baJq9Jo
 Ww61H9RCyVHw3Jrl2sXCb1ZpBTdnroTskdtVAeNshmtbcDd7nlb/0XYkyhoR5QrKVJ
 ZwBCnVA7Kpd/0ysferdN+9JZ9Q1XD6YGR43u+rzEXz6f+yzhZDs5aMEwxyE7Uobcf/
 N/UZzPr5bseDS1LN3Kzfaebpd8kC2ZQ3iw5nipIQOwDwjWO1el3C8Y4IX+ur6mWwCM
 s8UxZTMQAIYCBcEiAOVMEn7Hz32j1uXUqSo0YisNm9Ieomh0FRj7R7dgkX6s231e08
 Y/edU4bUVxa2w==
Date: Thu, 6 Jan 2022 12:32:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 09/14] PCI: portdrv: Suppress kernel DMA ownership
 auto-claiming
Message-ID: <20220106183224.GA298861@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <039bbcf3-ccc6-f3b0-172e-9caa0866bb9e@linux.intel.com>
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Thu, Jan 06, 2022 at 12:12:35PM +0800, Lu Baolu wrote:
> On 1/5/22 1:06 AM, Bjorn Helgaas wrote:
> > On Tue, Jan 04, 2022 at 09:56:39AM +0800, Lu Baolu wrote:
> > > If a switch lacks ACS P2P Request Redirect, a device below the switch can
> > > bypass the IOMMU and DMA directly to other devices below the switch, so
> > > all the downstream devices must be in the same IOMMU group as the switch
> > > itself.
> > Help me think through what's going on here.  IIUC, we put devices in
> > the same IOMMU group when they can interfere with each other in any
> > way (DMA, config access, etc).
> > 
> > (We said "DMA" above, but I guess this would also apply to config
> > requests, right?)
> 
> I am not sure whether devices could interfere each other through config
> space access. The IOMMU hardware only protects and isolates DMA
> accesses, so that userspace could control DMA directly. The config
> accesses will always be intercepted by VFIO. Hence, I don't see a
> problem.

I was wondering about config accesses generated by an endpoint, e.g.,
an endpoint doing config writes to a peer or the upstream bridge.

But I think that is prohibited by spec - PCIe r5.0, sec 7.3.3, says
"Propagation of Configuration Requests from Downstream to Upstream as
well as peer-to-peer are not supported" and "Configuration Requests
are initiated only by the Host Bridge, including those passed through
the SFI CAM mechanism."

Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
