Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B750AC48BE5
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 17:49:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6713D613CE
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 17:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6713D613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 32E1140149;
	Thu, 17 Jun 2021 17:49:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1NWuwfwY268y; Thu, 17 Jun 2021 17:49:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 12771400AF;
	Thu, 17 Jun 2021 17:49:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8204C000E;
	Thu, 17 Jun 2021 17:49:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88B54C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 17:49:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8432C6065D
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 17:49:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QKjNLYNsxBsd for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 17:49:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F20460640
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 17:49:05 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E782C613CB;
 Thu, 17 Jun 2021 17:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623952145;
 bh=PEswRSOUEybmrluFbTBGtoEux41ybWZrhm0/5ADHUig=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SRgVQddYQNsX/0bSReJIMePYroJG5R758EyKUDaj8Yz83/tvT+yuc4bWIU/ujjZkt
 Wv55bqQNR+hlU1Aa1D7IEWIsDpPiiwYdRd4YifEV78OcGVjqb6ftUvgL1xW4Xst4rE
 lt2+XMMUhQW9cMW7acVtOTW1j4Yt0ClW/MyxIzGi6FBPEB9mR+UUzq8SVbxABPYO9/
 LUxHiW+DrPi1FzOA5zInVb9Mf3e9kDZJ7jlt2Y+w/4VfLWqptN5V/w5pe7W1kNejYa
 efDZ4y9uRMklWBPAjOsYVNLPhdqc4sDj13XfdBDfn6V+BLJqMZixAQM14wU2KTbha6
 /SmYiHn8JO0fA==
Date: Thu, 17 Jun 2021 18:49:00 +0100
From: Will Deacon <will@kernel.org>
To: Ashish Mhetre <amhetre@nvidia.com>
Subject: Re: [PATCH 1/2] iommu: Fix race condition during default domain
 allocation
Message-ID: <20210617174859.GD24813@willie-the-truck>
References: <1623298614-31755-1-git-send-email-amhetre@nvidia.com>
 <1623298614-31755-2-git-send-email-amhetre@nvidia.com>
 <20210611104524.GD15274@willie-the-truck>
 <faf4504c-43f2-f68e-9a00-5e450dd7f352@arm.com>
 <315fe1c5-2685-6ee3-2aa4-35a27233127b@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <315fe1c5-2685-6ee3-2aa4-35a27233127b@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Thu, Jun 17, 2021 at 11:21:39AM +0530, Ashish Mhetre wrote:
> 
> 
> On 6/11/2021 6:19 PM, Robin Murphy wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On 2021-06-11 11:45, Will Deacon wrote:
> > > On Thu, Jun 10, 2021 at 09:46:53AM +0530, Ashish Mhetre wrote:
> > > > Domain is getting created more than once during asynchronous multiple
> > > > display heads(devices) probe. All the display heads share same SID and
> > > > are expected to be in same domain. As iommu_alloc_default_domain() call
> > > > is not protected, the group->default_domain and group->domain are ending
> > > > up with different domains and leading to subsequent IOMMU faults.
> > > > Fix this by protecting iommu_alloc_default_domain() call with
> > > > group->mutex.
> > > 
> > > Can you provide some more information about exactly what the h/w
> > > configuration is, and the callstack which exhibits the race, please?
> > 
> > It'll be basically the same as the issue reported long ago with PCI
> > groups in the absence of ACS not being constructed correctly. Triggering
> > the iommu_probe_device() replay in of_iommu_configure() off the back of
> > driver probe is way too late and allows calls to happen in the wrong
> > order, or indeed race in parallel as here. Fixing that is still on my
> > radar, but will not be simple, and will probably go hand-in-hand with
> > phasing out the bus ops (for the multiple-driver-coexistence problem).
> > 
> For iommu group creation, the stack flow during race is like:
> Display device 1:
> iommu_probe_device -> iommu_group_get_for_dev -> arm_smmu_device_group
> Display device 2:
> iommu_probe_device -> iommu_group_get_for_dev -> arm_smmu_device_group
> 
> And this way it ends up in creating 2 groups for 2 display devices sharing
> same SID.
> Ideally for 2nd display device, iommu_group_get call from
> iommu_group_get_for_dev should return same group as 1st display device. But
> due to the race, it ends up with 2 groups.
> 
> For default domain, the stack flow during race is like:
> Display device 1:
> iommu_probe_device -> iommu_alloc_default_domain -> arm_smmu_domain_alloc
> Display device 2:
> iommu_probe_device -> iommu_alloc_default_domain -> arm_smmu_domain_alloc
> 
> Here also 2nd device should already have domain allocated and
> 'if(group->default_domain)' condition from iommu_alloc_default_domain should
> be true for 2nd device.
> 
> Issue with this is IOVA accesses from 2nd device results in context faults.

Thanks for the explanation (also Robin and Krishna). Please put some of this
in the commit message for the next version.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
