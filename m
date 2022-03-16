Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACEEC433F5
	for <iommu@archiver.kernel.org>; Wed, 16 Mar 2022 17:37:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A7F1540AAD;
	Wed, 16 Mar 2022 17:37:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 110jW3Bi55lr; Wed, 16 Mar 2022 17:37:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 20A40405E9;
	Wed, 16 Mar 2022 17:37:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFD10C0012;
	Wed, 16 Mar 2022 17:37:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BD27C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 17:37:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 533CB611D4
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 17:37:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fx5BLxbTE_Wb for <iommu@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 17:37:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3A81160A8B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 17:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647452236; x=1678988236;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=O35iNXQlRH+OS+APj1svNRdnOY4rt7s7kW6OPFwzhnA=;
 b=ZksoHOuZbtQveLpTDrDx+Be9YZtpoAXvnRJDgYJTs/NvCMumw6bUm74B
 liPrAnQX5F8u0xLBH8Xo3ni4OYHkBdGJrW2hGXt1bglmzWVzUFBChzpll
 j46irh3S8tf0DGW9PmG6DZ8cpqcN3smQrv/4mLdLidoRTo1dLxxz51UYB
 dumiu0cGhFePSBamUr5oGp1fXDKfK8xI6/vjX2/d6lNyGe5ynzvaQSrQj
 bXf6GXbnhtn7tfv58Bq9G6FqNb9RY0YkRuS3qt8Z82IfbXyqRzhUu0+fH
 2Q17peCIG8g6XoriaRo+OPtg976KCwO4dh7ZKs2acrIj9KJpYTkE0hVC3 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256399658"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; d="scan'208";a="256399658"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 10:37:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; d="scan'208";a="516437363"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 10:37:08 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 16 Mar 2022 19:37:05 +0200
Date: Wed, 16 Mar 2022 19:37:05 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
Message-ID: <YjIgQfmcw6fydkXd@lahna>
References: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
 <YjHb1xCx4UAmUjrR@lahna>
 <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com>
 <YjIb+XOGZbWKpQDa@lahna>
 <BL1PR12MB515762E68F3A48A97EB2DC89E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BL1PR12MB515762E68F3A48A97EB2DC89E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: "michael.jamet@intel.com" <michael.jamet@intel.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>
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

Hi Mario,

On Wed, Mar 16, 2022 at 05:24:38PM +0000, Limonciello, Mario wrote:
> [Public]
> 
> > On Wed, Mar 16, 2022 at 02:49:09PM +0000, Robin Murphy wrote:
> > > > What we want is to make sure the Tunneled PCIe ports get the full
> > IOMMU
> > > > protection. In case of the discrete above it is also fine if all the
> > > > devices behind the PCIe root port get the full IOMMU protection. Note in
> > > > the integrated all the devices are "siblings".
> > >
> > > Ah, OK, I wasn't aware that the NHI isn't even the right thing in the first
> > > place :(
> > >
> > > Is there an easy way to get from the struct tb to a PCI device representing
> > > the end of its relevant tunnel, or do we have a circular dependency
> > problem
> > > where the latter won't appear until we've authorised it (and thus the
> > IOMMU
> > > layer won't know about it yet either)?
> > 
> > The PCIe root ports (and the PCIe downstream ports) are there already
> > even without "authorization".
> > 
> > There is a way to figure out the "tunneled" PCIe ports by looking at
> > certain properties and we do that already actually. The BIOS has the
> > following under these ports:
> > 
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs
> > .microsoft.com%2Fen-us%2Fwindows-hardware%2Fdrivers%2Fpci%2Fdsd-
> > for-pcie-root-ports%23identifying-externally-exposed-pcie-root-
> > ports&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7C0465d319a
> > 6684335d9c208da07710e7c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> > C0%7C637830479402895833%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> > LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&am
> > p;sdata=z6hpYGpj%2B%2BVvz9d6MXiO4N66PUm4zwhOdI%2Br6l3PjhQ%3D
> > &amp;reserved=0
> > 
> > and the ports will have dev->external_facing set to 1. Perhaps looking
> > at that field helps here?
> 
> External facing isn't a guarantee from the firmware though.  It's something we
> all expect in practice, but I think it's better to look at the ones that are from
> the _DSD usb4-host-interface to be safer.

Right but then we have the discrete ones with the DVSEC that exposes the
tunneled ports :(

> Mika, you might not have seen it yet, but I sent a follow up diff in this thread
> to Robin's patch.  If that looks good Robin can submit a v2 (or I'm happy to do
> so as well as I confirmed it helps my original intent too).

I saw it now and I'm thinking are we making this unnecessary complex? I
mean Microsoft solely depends on the DMAR platform opt-in flag:

  https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt

We also do turn on full IOMMU mappings in that case for devices that are
marked as external facing by the same firmware that provided the DMAR
bit. If the user decides to disable IOMMU from command line for instance
then we expect she knows what she is doing.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
