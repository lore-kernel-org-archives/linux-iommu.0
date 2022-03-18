Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60995C433EF
	for <iommu@archiver.kernel.org>; Fri, 18 Mar 2022 13:25:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EE3776134E;
	Fri, 18 Mar 2022 13:25:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cXrXJPtuRYwS; Fri, 18 Mar 2022 13:25:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C091B60BAF;
	Fri, 18 Mar 2022 13:25:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E9E0C0033;
	Fri, 18 Mar 2022 13:25:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2E29C0012
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 13:25:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BAB248436D
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 13:25:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jBu37h5Zee3p for <iommu@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 13:25:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 286F184196
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 13:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647609911; x=1679145911;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=InZ4gM0n9VmGhsbv3r77oTtxNorS/SN0pEblK/FfVAI=;
 b=D085NSbgwbWvnI3HulNI9plqFWquapucQyEkSNR+n+FBM4I5QPg5Brqe
 5dp3Tml6FQHSSZNv2tONQdbUVvKB0Bf2JIsEuEAFBO0ELC/1ammxO113D
 c/D1o4SQionK0vw8YDNbgJk4foVF+NZjiJpKhg3SZJQlKgPi/L9OALraV
 MoHCmyX0oh4iTWoNc9nQ5HUn7Du5pN9dJnGOkbH3/KcHp+cOELp1ciJeQ
 9xPhz+6bdRCAEMAvNIrSoLzgrpupBQqlmj8CIlEbuNR1LaLl02b4rKksy
 O+oa11n2pVnBC1Owh6Dpwh1FhjBJKicRt8LCsQxR3DARzG5g2om1qkBNv g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="256860943"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; d="scan'208";a="256860943"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 06:25:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; d="scan'208";a="558438415"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 06:25:07 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 18 Mar 2022 15:25:04 +0200
Date: Fri, 18 Mar 2022 15:25:04 +0200
From: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
Message-ID: <YjSCWaq7Ej/2iJPp@lahna>
References: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
 <BL1PR12MB515783C0F998169D49D92A55E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <BL1PR12MB51573F55B3C2B3922BAAA7F1E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjRvMk1kcbMwJvx+@lahna>
 <65207fdf-c4ab-5165-dbda-8ab55b51adb7@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <65207fdf-c4ab-5165-dbda-8ab55b51adb7@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: "michael.jamet@intel.com" <michael.jamet@intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "andreas.noever@gmail.com" <andreas.noever@gmail.com>
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

Hi Robin,

On Fri, Mar 18, 2022 at 12:01:42PM +0000, Robin Murphy wrote:
> > This adds quite a lot code and complexity, and honestly I would like to
> > keep it as simple as possible (and this is not enough because we need to
> > make sure the DMAR bit is there so that none of the possible connected
> > devices were able to overwrite our memory already).
> 
> Shall we forget the standalone sibling check and just make the
> pdev->untrusted check directly in tb_acpi_add_link() then?

I think we should leave tb_acpi_add_link() untouched if possible ;-)
This is because it is used to add the device links from firmware
description that we need for proper power management of the tunneled
devices. It has little to do with the identification of the external
facing DMA-capable PCIe ports.

Furthermore these links only exists in USB4 software connection manager
systems so we do not have those in the existing Thunderbolt 3/4 systems
that use firmware based connection manager (pretty much all out there).

> On reflection I guess the DMAR bit makes iommu_dma_protection
> functionally dependent on ACPI already, so we don't actually lose
> anything (and anyone can come back and revisit firmware-agnostic
> methods later if a need appears).

I agree.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
