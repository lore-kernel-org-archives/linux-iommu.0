Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1148029A0;
	Thu,  5 Jan 2023 10:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672915077; x=1704451077;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gjl8ZM8i09/OJywBgKdXkKMYg3xJWeKujz7bT+uBzmg=;
  b=nA3MBqPJR2KgvXc0iaDXAq4Liv6rlNXiI/HQvThNopVIUGjk6VDIhRpU
   rRC+2iQZjl5EjcAjCZrLz4JI/OOZHJhN4DduJ0c4swVP8AwrpLv+WnN7r
   3/otBE/eONna2V94jEiBFsmDDwF88vIvFQtMXsdQLJJ5Ug4wXWMoSxBmW
   MWWFbA/xXdNBGJlPtcMpS+rF5ukqc4/F3l+cNJKfbgeEmT7pVGx7/b1Fs
   LwucrSuCv/XYYHp1e+sTQLB768n/NdaoBUwz03GaXmL48K6w+og6pacM/
   DZvB+WZJRJT2NdgjcFhFnLyVc9onqy+yx/obo+TIfEtFqhRqQa8y67ldu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="323403227"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="323403227"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 02:37:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="686069531"
X-IronPort-AV: E=Sophos;i="5.96,302,1665471600"; 
   d="scan'208";a="686069531"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.114]) ([10.254.211.114])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 02:37:53 -0800
Message-ID: <6b5baa30-c218-0845-d6c2-32ac21ed6a6d@linux.intel.com>
Date: Thu, 5 Jan 2023 18:37:51 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, Joerg Roedel <jroedel@suse.de>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
To: Vasant Hegde <vasant.hegde@amd.com>, Matt Fagnani
 <matt.fagnani@bell.net>, Thorsten Leemhuis <regressions@leemhuis.info>
References: <15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info>
 <5aa0e698-f715-0481-36e5-46505024ebc1@bell.net>
 <aea57c5f-2d20-c589-ad44-a63f1133a3db@linux.intel.com>
 <157c4ca4-370a-5d7e-fe32-c64d934f6979@amd.com>
 <223ee6d6-70ea-1d53-8bc2-2d22201d8dde@bell.net>
 <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <6fff9d10-f77f-e55a-9020-8a1bd34cf508@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/1/5 18:27, Vasant Hegde wrote:
> On 1/5/2023 6:39 AM, Matt Fagnani wrote:
>> I built 6.2-rc2 with the patch applied. The same black screen problem happened
>> with 6.2-rc2 with the patch. I tried to use early kdump with 6.2-rc2 with the
>> patch twice by panicking the kernel with sysrq+alt+c after the black screen
>> happened. The system rebooted after about 10-20 seconds both times, but no kdump
>> and dmesg files were saved in /var/crash. I'm attaching the lspci -vvv output as
>> requested.
>>
> Thanks for testing. As mentioned earlier I was not expecting this patch to fix
> the black screen issue. It should fix kernel warnings and IOMMU page fault
> related call traces. By any chance do you have the kernel boot logs?
> 
> 
> @Baolu,
>    Looking into lspci output, it doesn't list ACS feature for Graphics card. So
> with your fix it didn't enable PASID and hence it failed to boot.

So do you mind telling why does the PASID need to be enabled for the
graphic device? Or in another word, what does the graphic driver use the
PASID for?

--
Best regards,
baolu
