Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83ABC433EF
	for <iommu@archiver.kernel.org>; Wed, 16 Mar 2022 17:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6146640239;
	Wed, 16 Mar 2022 17:19:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SzqO3NQL60UL; Wed, 16 Mar 2022 17:19:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 259C5401F8;
	Wed, 16 Mar 2022 17:19:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EAA7DC0012;
	Wed, 16 Mar 2022 17:19:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96F09C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 17:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 789764021E
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 17:19:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mA5_At7SPSdf for <iommu@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 17:18:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 96C60401F8
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 17:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647451139; x=1678987139;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=VaMyY87ToqjB9wkrkICrM9Cibhn7xEkgoFrLOxNQfiE=;
 b=PhP3gqSNyni3OAe5KStY9t1J9KQl3f4f48gnZ+6PljioyN5YPfFrL640
 v1vxOKppgcPo4jZmABylIB1XS+h0aL/zxVkOGrN2Sp8vztfMzbkJ6wxm/
 zyV/NLwtKNgl0YMxaBPOv38PftuNg3O5zMYVrAzPy4aoDdSeRix+OlJmc
 KtjQPutKQ92KmdxL3MNePmpYlsdkk45g7RgB+pJV/0SBxyJWIlLGRNZlV
 jrZzsz0YaeVK1s/o+s6X9dgRf6kMEGJ2y4BIo1Tb3QVL5FwdYvPbwp4Sm
 cixg4eqgYS4IUoQuPpKMEbeayntzIQTEoVDuPWT+yRyMoFBZBcti/dAFZ A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="244122725"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; d="scan'208";a="244122725"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 10:18:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; d="scan'208";a="581003689"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 10:18:53 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 16 Mar 2022 19:18:49 +0200
Date: Wed, 16 Mar 2022 19:18:49 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
Message-ID: <YjIb+XOGZbWKpQDa@lahna>
References: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
 <YjHb1xCx4UAmUjrR@lahna>
 <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: michael.jamet@intel.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, YehezkelShB@gmail.com,
 iommu@lists.linux-foundation.org, mario.limonciello@amd.com,
 andreas.noever@gmail.com, hch@lst.de
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

Hi,

On Wed, Mar 16, 2022 at 02:49:09PM +0000, Robin Murphy wrote:
> > What we want is to make sure the Tunneled PCIe ports get the full IOMMU
> > protection. In case of the discrete above it is also fine if all the
> > devices behind the PCIe root port get the full IOMMU protection. Note in
> > the integrated all the devices are "siblings".
> 
> Ah, OK, I wasn't aware that the NHI isn't even the right thing in the first
> place :(
> 
> Is there an easy way to get from the struct tb to a PCI device representing
> the end of its relevant tunnel, or do we have a circular dependency problem
> where the latter won't appear until we've authorised it (and thus the IOMMU
> layer won't know about it yet either)?

The PCIe root ports (and the PCIe downstream ports) are there already
even without "authorization".

There is a way to figure out the "tunneled" PCIe ports by looking at
certain properties and we do that already actually. The BIOS has the
following under these ports:

https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports

and the ports will have dev->external_facing set to 1. Perhaps looking
at that field helps here?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
