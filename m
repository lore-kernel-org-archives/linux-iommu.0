Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1C2C433F5
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 08:33:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E10A241B2D;
	Thu, 21 Apr 2022 08:33:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1CkaDL84P7az; Thu, 21 Apr 2022 08:33:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8FF1041996;
	Thu, 21 Apr 2022 08:33:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AAB2C002F;
	Thu, 21 Apr 2022 08:33:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A274DC002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:33:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 893DE610E7
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:33:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JauHKzGwDfdt for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 08:33:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A978D60A75
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 08:33:53 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C9A0961BDC;
 Thu, 21 Apr 2022 08:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71689C385A1;
 Thu, 21 Apr 2022 08:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650530032;
 bh=p6bgQ7Z9qqrV3XSCYlYFJ6UsMOIanchbxmGz7bNMIOc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KjZV1eFzBSUr3Vu8AH+Km5fn5LKTLHbTAvPAkvFETrl8aUafFNgofCy+nn6Oa+Y7z
 MnpovExZj+Ez7OOZUbUBVShphPsWnxoHCF9F53/WfTFeXqCP/sc+pLb0zAxuv+xhSk
 PfVgh+6DweF7ldJAn2KsMG/iCj5TVX14H56FqR8TX38Fmy7jDiTOmmkTRJUznqOOpu
 Q8WYLA7lACCNlSEK8wbDHE4PZzUbWMZIItAybWjunGgCpboMyN/ctvHIy33MnCRpN3
 rbe2fhpY0FtQQj6xO3hnjxzUy2HEXfF/q/SvD0LMaBpCb4nTF8+XWJ93KhOoCiV4Rd
 hV+IWiSNlneKg==
Date: Thu, 21 Apr 2022 09:33:45 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 04/13] iommu/arm-smmu: Clean up bus_set_iommu()
Message-ID: <20220421083345.GA8303@willie-the-truck>
References: <cover.1649935679.git.robin.murphy@arm.com>
 <2e59602d982fd4941ec923571940fa3c628b2188.1649935679.git.robin.murphy@arm.com>
 <20220419144042.GA6186@willie-the-truck>
 <5ae51610-5027-777e-36e3-7bdb92e00752@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5ae51610-5027-777e-36e3-7bdb92e00752@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jean-philippe@linaro.org, zhang.lyra@gmail.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
 gerald.schaefer@linux.ibm.com
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

On Wed, Apr 20, 2022 at 05:05:03PM +0100, Robin Murphy wrote:
> On 2022-04-19 15:40, Will Deacon wrote:
> > On Thu, Apr 14, 2022 at 01:42:33PM +0100, Robin Murphy wrote:
> > > Stop calling bus_set_iommu() since it's now unnecessary. With device
> > > probes now replayed for every IOMMU instance registration, the whole
> > > sorry ordering workaround for legacy DT bindings goes too, hooray!
> > 
> > Ha, I hope you tested this!
> 
> Oh alright then, since it's you... :)
> 
> I've hacked up a Juno DT with the old bindings, and (after needing a while
> to remember that they're fundamentally incompatible with disable_bypass),
> can confirm that with my whole dev branch including this series applied, it
> boots and creates IOMMU groups as expected. I then made the mistake of
> trying without the branch to check whether the squawks from
> iommu_setup_dma_ops() were new or not, and... well... plain rc3 doesn't even
> boot on the same setup - it's somehow blowing up in the failure cleanup path
> of iommu_bus_init(), apparently calling iommu_release_device() on something
> where dev->iommu->iommu_dev is NULL, for reasons that are far from clear and
> I'm not sure I can really be bothered to debug further... :/

Great, so your series is a fix!

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
