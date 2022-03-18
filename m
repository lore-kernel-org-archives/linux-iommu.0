Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0B5C433F5
	for <iommu@archiver.kernel.org>; Fri, 18 Mar 2022 15:25:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F760418D1;
	Fri, 18 Mar 2022 15:25:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lpamVmpAYdkl; Fri, 18 Mar 2022 15:25:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F1B09418B7;
	Fri, 18 Mar 2022 15:25:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC34BC0033;
	Fri, 18 Mar 2022 15:25:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DB60C0012
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 15:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8B6D360A4F
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 15:25:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S7CXGZt4kCKb for <iommu@lists.linux-foundation.org>;
 Fri, 18 Mar 2022 15:25:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DA42B60812
 for <iommu@lists.linux-foundation.org>; Fri, 18 Mar 2022 15:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647617101; x=1679153101;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=LlOEVehLpDxPQcChYnPKlnsRrBtAlMMFuCk3HXvGY80=;
 b=infSTjNUm4FmXdG6QRIoH2SKdqfyp4RqBTY/IAQuZnWd0rW17qVG1004
 xUkAeLOPgqasPXCoKiA3P22/os7E6uyjdFal67R/OTucJ8dsO1zqrs+w7
 hzUCDEr4JjVPx4+djZmuAurHX3XbO4Hd1DLA002xT1Uzazt6tTgcMKp/c
 MvN/NfxwuIrDR11SW09yf2trspe6MO1Wvo4rSqvfLMC/SUvbxPefpnJR7
 ze4JudalDs2xDgLE+9FINMMC/Ds9gg6K2TuwXqv45PBuaq2doZc1F4S6w
 gd/t1GqRWtuxQBGhHm1dKavUIA4JzI7K6jChgIJMy1n6BagGSz5QNX6J/ A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="317871579"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; d="scan'208";a="317871579"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 08:25:01 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; d="scan'208";a="715521623"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2022 08:24:57 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 18 Mar 2022 17:23:45 +0200
Date: Fri, 18 Mar 2022 17:23:45 +0200
From: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] thunderbolt: Make iommu_dma_protection more accurate
Message-ID: <YjSkAcxLDFmVdhEq@lahna>
References: <2d01fa50c2650c730b0244929097737918e302e7.1647533152.git.robin.murphy@arm.com>
 <BL1PR12MB515783C0F998169D49D92A55E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <BL1PR12MB51573F55B3C2B3922BAAA7F1E2129@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjRvMk1kcbMwJvx+@lahna>
 <65207fdf-c4ab-5165-dbda-8ab55b51adb7@arm.com>
 <YjSCWaq7Ej/2iJPp@lahna>
 <78fc0426-c22a-ec62-f92b-0019bea5947e@arm.com>
 <YjSbfScU0Ssuca3y@lahna>
 <73e25ee3-c2f3-0a72-e5cc-04e51f650f2e@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <73e25ee3-c2f3-0a72-e5cc-04e51f650f2e@arm.com>
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

On Fri, Mar 18, 2022 at 03:15:19PM +0000, Robin Murphy wrote:
> > IMHO we should just trust the firmare provided information here
> > (otherwise we are screwed anyway as there is no way to tell if the
> > devices connected prior the OS can still do DMA), and use the external
> > facing port indicator to idenfity the ports that need DMA protection.
> 
> Indeed that's exactly what I want to do, but it begs the question of how we
> *find* the firmware-provided information in the first place!

Oh, right :) Its the combination of ACPI _DSD "ExternalFacingPort"
(which we already set, dev->external_facing, dev->untrusted for the
devices behind these ports IIRC) and the DMAR opt-in bit. All these are
already read by the kernel.

> I seem to have already started writing the dumb version that will walk the
> whole PCI segment and assume the presence of any external-facing port
> implies that we're good. Let me know if I should stop ;)

That sounds good to me, so don't stop just yet ;-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
