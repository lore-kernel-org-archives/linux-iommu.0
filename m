Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEECA2C
	for <iommu@lists.linux.dev>; Mon, 19 Sep 2022 05:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663565225; x=1695101225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pd83EDt90VZuirTBFY78goNfaa3cLEFmNjjMRd8AkT8=;
  b=n12vO2DOeucfdOwR0O4nmYB1C9gPVNRUXGlSzTDjARqo97O84JM/sF/d
   2RbSQuodvUC8qDT5MmsQLz7ew4M5BIKO0VXpNxTTjUFbbptVROT6tRTku
   ZsDTqt7+m8rv4OkMops0gZO8N1bbsyqJkA/f1yPkXo7AukDvj5VAYcobk
   +goUI9sO82lylBTsVjTsH9IQIyH2I9DX31zG8m1WqRlda+ADtAwYoerUH
   lxAec2hONInsdMEE5w9Kwoq9deoTeby1pR22BnwcbQ65W+lAVGkVW4AFh
   dsK+BvPpsQT7+AFE15Z4y6/+QjT4KBAvkglo5H80TstKKtMR7eq0b+BWx
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="279038665"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="279038665"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 22:27:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="863414135"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 18 Sep 2022 22:27:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id B5C7BF7; Mon, 19 Sep 2022 08:27:20 +0300 (EEST)
Date: Mon, 19 Sep 2022 08:27:20 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: George Hilliard <thirtythreeforty@gmail.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux1394-devel@lists.sourceforge.net" <linux1394-devel@lists.sourceforge.net>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: 5.19.9 regression: DMAR error on i7-8650U
Message-ID: <Yyf9uIzwbb6O2E7o@black.fi.intel.com>
References: <485A6EA5-6D58-42EA-B298-8571E97422DE@getmailspring.com>
 <4379585e-42e4-53d9-8ca4-bf5b8ff3c95d@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4379585e-42e4-53d9-8ca4-bf5b8ff3c95d@linux.intel.com>

Hi George,

On Mon, Sep 19, 2022 at 08:53:48AM +0800, Baolu Lu wrote:
> On 9/18/22 8:00 AM, George Hilliard wrote:
> > I'm experiencing a regression on 5.19.9 from 5.19.8. Not sure if you are
> > already aware of this, apologies if it's noise.  My hunch is that this
> > is an iommu problem since there were quite a few iommu changes in .9,
> > but I have also Cc'd Firewire maintainers on the chance that I'm wrong.
> > 
> > My Apple Thunderbolt to Firewire adapter has quit working on 5.19.9 on
> > my Thinkpad T480s (i7-8650U), with the following log message while
> > enumerating the device (reformatted for email):
> > 
> >      [  318.263546] thunderbolt 0-1: new device found, vendor=0x1 device=0x8004
> >      [  318.263559] thunderbolt 0-1: Apple, Inc. Thunderbolt to FireWire Adapter
> >      [  318.342416] pcieport 0000:05:01.0: pciehp: Slot(1): Card present
> >      [  318.342428] pcieport 0000:05:01.0: pciehp: Slot(1): Link Up
> >      (snip)
> >      [  318.503177] pcieport 0000:08:00.0: enabling device (0000 -> 0003)
> >      [  318.504976] firewire_ohci 0000:09:00.0: enabling device (0000 -> 0002)
> >      [  318.562000] firewire_ohci 0000:09:00.0: added OHCI v1.10 device
> >                     as card 4, 8 IR + 8 IT contexts, quirks 0x0, physUB
> >      [  318.562109] DMAR: DRHD: handling fault status reg 2
> >      [  318.562114] DMAR: [INTR-REMAP] Request device [09:00.0] fault
> >                     index 0x8080 [fault reason 0x25] Blocked a
> >                     compatibility format interrupt request
> > 
> > The last two lines are the new error.
> > 
> > Happy to provide more details or experiment; this happens nearly every time.
> > 
> > George
> > 
> 
> + Mika.

Since this is a regression, I wonder if you are able to bisect it to the
commit that caused the issue? As you say there are a couple of IOMMU
related changes between v5.19.8 and v5.19.9 so one option is to revert
them one by one and see if the problem goes away:

f7f13b8d49bf3eff2c98230532e0671195277216 swiotlb: avoid potential left shift overflow
9516acba29e322202674d18f4dc383879f7813a5 iommu/vt-d: Fix possible recursive locking in intel_iommu_init()
420d2045715588ad44cd7d806864a223b4fc05c9 iommu/vt-d: Correctly calculate sagaw value of IOMMU
77a2d61334f715293c20f4fa30df035fd870fba4 iommu/virtio: Fix interaction with VFIO
32e4b8dbc9119c07ea1888e72c8a5681b82e180c iommu: Fix false ownership failure on AMD systems with PASID activated
