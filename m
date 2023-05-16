Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEC41FA8
	for <iommu@lists.linux.dev>; Tue, 16 May 2023 01:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684199655; x=1715735655;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0Ks1ErhukRIy2tFk1Evvzwq0aGC2K3IP4dobecIrI9A=;
  b=Q/oYGLc25OrmY3rZ5OYBZrxtfIXTSu/8Fb01xqcs81sPfr/A4dNFtU2j
   qylc5zYzq6Qg2V3l0IR4Vr8DKUtiwr9mX7c3xi7SfnRuI7TWX5EJsQRbC
   jTZc0QbfafhdwzGhgOOnUnhnrkA71axa6d4DQ1vBelM/ce7O3ZWuv5HHb
   VI+6gKAXoP3IUatkqlG3RHNQKcZojhBMrSD1PTJwpdcyv7Cf277ml4pYa
   zAbFwjn7FJIKQ8RQAeWOFJs2ckrju/0ZAFuwcjU0h8tlTl30n7KPEarDf
   Hj0uSb5gfhqkHopEZGifQZSPn857xAIqAh2kBPLfCdUsTLpz0Fvr34R7I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="379523792"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="379523792"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 18:14:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="651625923"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="651625923"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 15 May 2023 18:14:12 -0700
Message-ID: <302501af-05a3-9757-d923-602ad9a6d9c9@linux.intel.com>
Date: Tue, 16 May 2023 09:13:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: baolu.lu@linux.intel.com
Subject: Re: Relaxable RMRR kernel parameter for broken platforms
Content-Language: en-US
To: bugtracker@fischbytes.de, iommu@lists.linux.dev
References: <2282218.ElGaqSPkdT@helios-lx>
 <4ab4966b-48bd-56fc-5078-d5fdddc1613a@linux.intel.com>
 <1877598.tdWV9SEqCh@helios-lx>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <1877598.tdWV9SEqCh@helios-lx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/23 9:11 PM, bugtracker@fischbytes.de wrote:
> On Saturday, May 13, 2023 8:20:40 AM CEST you wrote:
> 
>  > On 5/13/23 2:52 AM, bugtracker@fischbytes.de wrote:
> 
>  > > Hi there,
> 
>  > >
> 
>  > > I came here today to ask if there are any plans regarding the
> 
>  > > implementation of a "relaxed RMRR" kernel parameter to aid using 
> IOMMU on
> 
>  > > broken platforms such as the ProLiant Series by Hewlett Packard
> 
>  > > Enterprise. To everyone not aware of the issue;
> 
>  > >
> 
>  > > Certain vendors that are under the assumption that standards are 
> for jerks
> 
>  > > and Intel's specifications are a loose optional guideline have
> 
>  > > implemented RMRR in such a way that every PCI device is marked as
> 
>  > > reserved and therefore cannot be passed through to a virtual machine.
> 
>  > > This issue has been very well documented by some people that have a lot
> 
>  > > more experience than I do at the below linked resource. I was 
> hoping that
> 
>  > > the kernel devs could implement the Relaxed RMRR option as an optional
> 
>  > > kernel parameter to use on these bugged platforms as that would 
> re-enable
> 
>  > > or rather enable a lot of broken servers for the first time ever to use
> 
>  > > PCIe Passthrough. I can verify the issue exists on a HPE DL360e 
> Gen8 with
> 
>  > > trying to passthrough a GPU to a KVM/QEMU machine.
> 
>  > >
> 
>  > > Link to fix: https://github.com/Aterfax/relax-intel-rmrr
> 
>  > >
> 
>  > > Furthermore, since I am not a developer and wouldn't claim that I am
> 
>  > > competent enough to decide whether or not implementing this patch would
> 
>  > > present an issue in terms of stability or security, I was hoping 
> that you
> 
>  > > could evaluate the situation. I can verify the pre-built packages 
> for the
> 
>  > > Proxmox Linux environment fix the issue and behave identical in 
> function
> 
>  > > to other systems that ignore RMRR completely, such as VMWare ESXi.
> 
>  > >
> 
>  > > Thanks alot in advance, you implementing this patch would really mean a
> 
>  > > lot, since the hardware manufacturers just don't seem to care for 
> fixing
> 
>  > > up this, erm, mess.
> 
>  >
> 
>  > The relaxed RMRRs are used for legacy purpose, but it requires the full
> 
>  > range of memory addresses are available after the OS device driver takes
> 
>  > over the control of the device.
> 
>  >
> 
>  > Not all RMRRs are of this type and typically the VT-d driver only allows
> 
>  > those RMRRs for USB and graphic devices as relaxed ones.
> 
>  >
> 
>  > Are you proposing to add a kernel parameter to allow any RMRR for an
> 
>  > arbitrary device to be relaxed, or I didn't get the idea here?
> 
>  >
> 
>  > Best regards,
> 
>  > baolu
> 
> 
> Correct, the idea here is that, while this observation can only be made 
> on specific hardware, it more often than not occurs that devices that 
> definitely shouldn't be (like e.g. GPUs attached to the PCIe Interface) 
> are marked as reserved by offending firmware. A perfect solution would 
> of course be to force the hardware vendors to push a firmware update 
> that resolves the violation of Intel's specifications, but such a thing 
> doesn't appear to have happened in the past and it's very unlikely that, 
> let's say Hewlett Packard Enterprise, will ever release a firmware 
> update for those thousands of broken servers.
> 
> 
> (Quoted from here; 
> https://github.com/Aterfax/relax-intel-rmrr/blob/master/deep-dive.md#rmrr---the-monster-in-a-closet ;
> 
> 
> /Intel anticipated the some will be tempted to misuse the feature as 
> they warned in the VT-d specification: "RMRR regions are expected to be 
> used for legacy usages (...). Platform designers should avoid or limit 
> use of reserved memory regions"./
> 
> 
> /HP (and probably others) decided to mark every freaking PCI device 
> memory space as RMRR! Like that, just in case... just that their tools 
> could potentially maybe monitor these devices while OS agent is not 
> installed. But wait, there's more! They marked ALL devices as such, even 
> third party ones physically installed in motherboard's PCI/PCIe slots!/)
> 
> 
> Hope this could clarify my inquiry a bit more.

Thanks for the information.

This Red Hat white paper explains why RMRR is not supported for device
pass-through.

https://access.redhat.com/sites/default/files/attachments/rmrr-wp1.pdf

I am concerned that adding a kernel option to release all RMRRs blindly
could be harmful to users. Some users may not be aware of how RMRR
impacts device passthrough and may only use the option because they
find it will help them in some use cases where it's impossible without
it.

Beset regards,
baolu
