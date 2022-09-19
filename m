Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB7C7E9
	for <iommu@lists.linux.dev>; Mon, 19 Sep 2022 00:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663549183; x=1695085183;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fACtfGgyyAf2W0XH08j7nQmIqsGTZANL3supT352vWo=;
  b=CLMU469OP7tV7bboLkibvLknWQ5Wg30cr61GpzrhkmYRrZ46O4tTmfPK
   aAEaI4HIFrQrxoeX5HR3oRDbvUdgeF5jOinvl3xvVg3LHq/O1nLprPFx/
   n1a1JdzpBf9XsVDJc7whEgq0ZrnmGFvdNB7L2kN5dsGIMHUYfG22dyAcD
   nsto3JOdnPFLXJRRE9thYbpUn8HWzc6rIy85C0z2eJ9xetx2aShTSpF6a
   OVSNPEB/Z3RTjYAn4Ai3LrV+OazRt30q1spWsFRLiszpw6bMs0lOJLLB1
   T4g3D0+c+kfDMzXVDaYKLDvwPMypaJEdm0bFkWL+7C0VH9I09KDsPD0+M
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="385569900"
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="385569900"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2022 17:59:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,325,1654585200"; 
   d="scan'208";a="760673154"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 18 Sep 2022 17:59:41 -0700
Message-ID: <4379585e-42e4-53d9-8ca4-bf5b8ff3c95d@linux.intel.com>
Date: Mon, 19 Sep 2022 08:53:48 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux1394-devel@lists.sourceforge.net"
 <linux1394-devel@lists.sourceforge.net>,
 Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: 5.19.9 regression: DMAR error on i7-8650U
Content-Language: en-US
To: George Hilliard <thirtythreeforty@gmail.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
References: <485A6EA5-6D58-42EA-B298-8571E97422DE@getmailspring.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <485A6EA5-6D58-42EA-B298-8571E97422DE@getmailspring.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/22 8:00 AM, George Hilliard wrote:
> I'm experiencing a regression on 5.19.9 from 5.19.8. Not sure if you are
> already aware of this, apologies if it's noise.  My hunch is that this
> is an iommu problem since there were quite a few iommu changes in .9,
> but I have also Cc'd Firewire maintainers on the chance that I'm wrong.
> 
> My Apple Thunderbolt to Firewire adapter has quit working on 5.19.9 on
> my Thinkpad T480s (i7-8650U), with the following log message while
> enumerating the device (reformatted for email):
> 
>      [  318.263546] thunderbolt 0-1: new device found, vendor=0x1 device=0x8004
>      [  318.263559] thunderbolt 0-1: Apple, Inc. Thunderbolt to FireWire Adapter
>      [  318.342416] pcieport 0000:05:01.0: pciehp: Slot(1): Card present
>      [  318.342428] pcieport 0000:05:01.0: pciehp: Slot(1): Link Up
>      (snip)
>      [  318.503177] pcieport 0000:08:00.0: enabling device (0000 -> 0003)
>      [  318.504976] firewire_ohci 0000:09:00.0: enabling device (0000 -> 0002)
>      [  318.562000] firewire_ohci 0000:09:00.0: added OHCI v1.10 device
>                     as card 4, 8 IR + 8 IT contexts, quirks 0x0, physUB
>      [  318.562109] DMAR: DRHD: handling fault status reg 2
>      [  318.562114] DMAR: [INTR-REMAP] Request device [09:00.0] fault
>                     index 0x8080 [fault reason 0x25] Blocked a
>                     compatibility format interrupt request
> 
> The last two lines are the new error.
> 
> Happy to provide more details or experiment; this happens nearly every time.
> 
> George
> 

+ Mika.

Best regards,
baolu
