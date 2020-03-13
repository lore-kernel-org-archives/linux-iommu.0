Return-Path: <SRS0=vGJT=46=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5D4C10DCE
	for <iommu@archiver.kernel.org>; Fri, 13 Mar 2020 13:36:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA0D206B7
	for <iommu@archiver.kernel.org>; Fri, 13 Mar 2020 13:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA0D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0FD5E88710;
	Fri, 13 Mar 2020 13:36:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T0bQvK9sBvNz; Fri, 13 Mar 2020 13:36:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 594958870D;
	Fri, 13 Mar 2020 13:36:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C1E3C089F;
	Fri, 13 Mar 2020 13:36:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1FE7C0177
 for <iommu@lists.linux-foundation.org>; Fri, 13 Mar 2020 13:36:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D00A2231AB
 for <iommu@lists.linux-foundation.org>; Fri, 13 Mar 2020 13:36:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ib0I2UZpROyG for <iommu@lists.linux-foundation.org>;
 Fri, 13 Mar 2020 13:36:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 1ADE32075B
 for <iommu@lists.linux-foundation.org>; Fri, 13 Mar 2020 13:36:49 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 1700A269; Fri, 13 Mar 2020 14:36:46 +0100 (CET)
Date: Fri, 13 Mar 2020 14:36:44 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 0/6] Replace private domain with per-group default
Message-ID: <20200313133644.GO3794@8bytes.org>
References: <20200307062014.3288-1-baolu.lu@linux.intel.com>
 <20200310111503.GF3794@8bytes.org>
 <cd0f526c-da68-ef59-580f-665ad08a395f@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cd0f526c-da68-ef59-580f-665ad08a395f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 Daniel Drake <drake@endlessm.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Derrick Jonathan <jonathan.derrick@intel.com>
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

On Wed, Mar 11, 2020 at 02:50:39PM +0800, Lu Baolu wrote:
> On 2020/3/10 19:15, Joerg Roedel wrote:
> > Hi Baolu,
> > 
> > On Sat, Mar 07, 2020 at 02:20:08PM +0800, Lu Baolu wrote:
> > > Lu Baolu (5):
> > >    iommu: Configure default domain with dev_def_domain_type
> > >    iommu/vt-d: Don't force 32bit devices to uses DMA domain
> > >    iommu/vt-d: Don't force PCI sub-hierarchy to use DMA domain
> > >    iommu/vt-d: Add dev_def_domain_type callback
> > >    iommu/vt-d: Apply per-device dma_ops
> > > 
> > > Sai Praneeth Prakhya (1):
> > >    iommu: Add dev_def_domain_type() callback in iommu_ops
> > 
> > I like this patch-set, but I fear some regressions from patch
> > "iommu/vt-d: Don't force 32bit devices to uses DMA domain". Have you
> > tested this series on a couple of machines, ideally even older ones from
> > the first generation of VT-d hardware?
> 
> The oldest hardware I have is Ivy Bridge. :-) Actually, The effect of
> using identity domain for 32-bit devices is the same as that of adding
> intel_iommu=off in the kernel parameter. Hence, if there is any
> regression, people should also find it with intel_iommu=off.
> intel_iommu=off support is added at the very beginning of VT-d driver.

Okay, I will also do some testing on it, one of my VT-d machines is a
Haswell. Please send a new version with the recent comments addressed.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
