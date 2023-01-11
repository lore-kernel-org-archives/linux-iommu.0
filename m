Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A1E17C8;
	Wed, 11 Jan 2023 03:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673407000; x=1704943000;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eiUGacdelBh6i4MLgLO5PEcQ0q58R3cpUTNNPuRjubk=;
  b=PYfV8lnAtVk31KaE982I012NC0pBA8A1J+piu+P7sApX9aVJj69j1OGD
   Bscm2a5krrKaR1EmHvn/OmFb7R+BTcRoqpRDqdJf20OOGfuiQ6IWYyGiq
   3P7Fm+qkNcM7O/6l25okQaLRiiZ5oTxDKs7821Hp5BmLbTT99mgm5nCE7
   qZ9n9TMvHGPpbiPKb95At2eSsR5kn0Xz/5g6Et2jHeIsyFmHPXNSnhYO2
   G0Wie2Ku+nybyjta2tkkVM03/AhFNZPG2HWE46iY8Z70d8GSau33RJJkN
   SMQkGsYdEZOzswElCncAS2MQLNrHm+EUXo2dDcCsgvrMD0T0lbohLKQei
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303688160"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="303688160"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 19:16:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607206515"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="607206515"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.252.188.177]) ([10.252.188.177])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 19:16:35 -0800
Message-ID: <7c2af186-5868-d962-f810-ef810fbd074c@linux.intel.com>
Date: Wed, 11 Jan 2023 11:16:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, Vasant Hegde <vasant.hegde@amd.com>,
 Matt Fagnani <matt.fagnani@bell.net>,
 Thorsten Leemhuis <regressions@leemhuis.info>, Joerg Roedel
 <jroedel@suse.de>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 amd-gfx@lists.freedesktop.org
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com> <Y7gs0zYKp/VXACBi@nvidia.com>
 <f96b1cf3-6865-663d-f1cd-466a71519b08@linux.intel.com>
 <Y71nZuF5wQp3eqmn@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Y71nZuF5wQp3eqmn@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/1/10 21:25, Jason Gunthorpe wrote:
>> +       } else {
>> +               if (!pdev->bus->self ||
>> +                   !pci_acs_path_enabled(pdev->bus->self, NULL,
>> +                                         PCI_ACS_RR | PCI_ACS_UF))
>> +                       return -EINVAL;
>> +       }
> Why would these be exclusive? Both the path and endpoint needs to be
> checked

If the device is not an MFD, do we still need to check the ACS on it?
Perhaps I didn't get your point correctly.

--
Best regards,
baolu
