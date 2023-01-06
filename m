Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7D97B;
	Fri,  6 Jan 2023 05:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672984563; x=1704520563;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5FYmc733b78fRd3B3tStq5rzw45ZjZPIs3hLf607W+U=;
  b=gmbIJdMVD4n3JHNJWK4MWGHxq3Y2msb78GiTMWh74xcV5DA6Wk6wnufu
   rzNItmB8nv8tBOOCTGaVBYolTmKThMZ5f6ZglhtVKZ4mPEEGMIpRGv43s
   aHDsruxTIEGlPXc+nxv1Q+nwsPpfhaQQxUZHWYzee2u3gplAucBGtwvP2
   rUQvKloKZm2u+2w3iU/JGXPwvmxPXdXHebj0P8V+Wlsa5pRQR7aic8iea
   oQ6PV0v7WHSPY3LX5g85DqpEryc77WrYMdzbyBID4uHiAOh6UQ5/R75DP
   3QgE0K24/m0brJEMm4pFDptPN8W7I9z4eE6WnsJKJO4ojTBHDiFEq1Eci
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="323663147"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="323663147"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 21:56:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="724333183"
X-IronPort-AV: E=Sophos;i="5.96,304,1665471600"; 
   d="scan'208";a="724333183"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2023 21:55:58 -0800
Message-ID: <7bbc0f65-e1c6-f388-29a8-390b8c9c92c8@linux.intel.com>
Date: Fri, 6 Jan 2023 13:48:11 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Hegde, Vasant" <Vasant.Hegde@amd.com>, Matt Fagnani
 <matt.fagnani@bell.net>, Thorsten Leemhuis <regressions@leemhuis.info>,
 Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@nvidia.com>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com>
 <6b5baa30-c218-0845-d6c2-32ac21ed6a6d@linux.intel.com>
 <86099ef0-5a8d-bd1e-4e38-a3b361a68f10@amd.com>
 <BL1PR12MB51448996E36254ADC80B5BF6F7FA9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <12db77f6-736d-a423-4cc0-e536eb7bb712@amd.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <12db77f6-736d-a423-4cc0-e536eb7bb712@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+Jason

On 1/5/23 11:27 PM, Felix Kuehling wrote:
> Am 2023-01-05 um 09:46 schrieb Deucher, Alexander:
>> [AMD Official Use Only - General]
>>
>>> -----Original Message-----
>>> From: Hegde, Vasant <Vasant.Hegde@amd.com>
>>> Sent: Thursday, January 5, 2023 5:46 AM
>>> To: Baolu Lu <baolu.lu@linux.intel.com>; Matt Fagnani
>>> <matt.fagnani@bell.net>; Thorsten Leemhuis <regressions@leemhuis.info>;
>>> Deucher, Alexander <Alexander.Deucher@amd.com>; Joerg Roedel
>>> <jroedel@suse.de>
>>> Cc: iommu@lists.linux.dev; LKML <linux-kernel@vger.kernel.org>;
>>> regressions@lists.linux.dev; Linux PCI <linux-pci@vger.kernel.org>; 
>>> Bjorn
>>> Helgaas <bhelgaas@google.com>
>>> Subject: Re: [regression, bisected, pci/iommu] Bug 216865 - Black screen
>>> when amdgpu started during 6.2-rc1 boot with AMD IOMMU enabled
>>>
>>> Baolu,
>>>
>>>
>>> On 1/5/2023 4:07 PM, Baolu Lu wrote:
>>>> On 2023/1/5 18:27, Vasant Hegde wrote:
>>>>> On 1/5/2023 6:39 AM, Matt Fagnani wrote:
>>>>>> I built 6.2-rc2 with the patch applied. The same black screen
>>>>>> problem happened with 6.2-rc2 with the patch. I tried to use early
>>>>>> kdump with 6.2-rc2 with the patch twice by panicking the kernel with
>>>>>> sysrq+alt+c after the black screen happened. The system rebooted
>>>>>> after about 10-20 seconds both times, but no kdump and dmesg files
>>>>>> were saved in /var/crash. I'm attaching the lspci -vvv output as
>>> requested.
>>>>> Thanks for testing. As mentioned earlier I was not expecting this
>>>>> patch to fix the black screen issue. It should fix kernel warnings
>>>>> and IOMMU page fault related call traces. By any chance do you have 
>>>>> the
>>> kernel boot logs?
>>>>> @Baolu,
>>>>>     Looking into lspci output, it doesn't list ACS feature for
>>>>> Graphics card. So with your fix it didn't enable PASID and hence it 
>>>>> failed to
>>> boot.
>>>> So do you mind telling why does the PASID need to be enabled for the
>>>> graphic device? Or in another word, what does the graphic driver use
>>>> the PASID for?
>>> Honestly I don't know the complete details of how PASID works with 
>>> graphics
>>> card. May be Alex or Joerg can explain it better.
>> + Felix
>>
>> The GPU driver uses the pasid for shared virtual memory between the 
>> CPU and GPU.  I.e., so that the user apps can use the same virtual 
>> address space on the GPU and the CPU.  It also uses pasid to take 
>> advantage of recoverable device page faults using PRS.
> 
> Agreed. This applies to GPU computing on some older AMD APUs that take 
> advantage of memory coherence and IOMMUv2 address translation to create 
> a shared virtual address space between the CPU and GPU. In this case it 
> seems to be a Carrizo APU. It is also true for Raven APUs.

Thanks for the explanation.

This is actually the problem that commit 201007ef707a was trying to fix.
The PCIe fabric routes Memory Requests based on the TLP address,
ignoring any PASID (PCIe r6.0, sec 2.2.10.4), so a TLP with PASID that
should go upstream to the IOMMU may instead be routed as a P2P
Request if its address falls in a bridge window.

In SVA case, the IOMMU shares the address space of a user application.
The user application side has no knowledge about the PCI bridge window.
It is entirely possible that the device is programed with a P2P address
and results in a disaster.

--
Best regards,
baolu
