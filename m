Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D1E81C;
	Tue, 27 Dec 2022 07:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672125639; x=1703661639;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vL3kDJluuTz22SaHSZYVG+uhDRIIgCtwq4Thd5iw28U=;
  b=AVe6Mv689F7EsdnUBXzROuNnFGuJTd/zzc2xhMpSVSbZftZUDcF4DVOl
   Dovhbygof5ycuBXxSD0LUzUjQmBWN4ZlcHjihl8lrfFJSfFpYrY331Lcr
   94SBHD7B7cV5DEG5bsOe2wFVaDJ27RqGMwn9B0esj1VpTMJ20+wqmrS31
   J6UBHOrMlqz5XGiDJcFlf/DQMbJmTqwUMQ4dnossiDsP0k2Kpik9OIokH
   EX0cSMLoVgI62mADfbKi5Py5xzGvmfndL9FA9LHgUMPdkZoF8l2fCpbUJ
   zwIE8TTOSizu6crKUP/RxL96roYYutyUj445p+VLvC2oNCnWbYsaXJSXl
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="321893807"
X-IronPort-AV: E=Sophos;i="5.96,277,1665471600"; 
   d="scan'208";a="321893807"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 23:20:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10572"; a="795264357"
X-IronPort-AV: E=Sophos;i="5.96,277,1665471600"; 
   d="scan'208";a="795264357"
Received: from haozhan3-mobl.ccr.corp.intel.com (HELO [10.254.212.104]) ([10.254.212.104])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2022 23:20:29 -0800
Message-ID: <77905fdc-ca91-75ef-4d79-378c108ee4b2@linux.intel.com>
Date: Tue, 27 Dec 2022 15:20:27 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix PCI device reference count leak in
 has_external pci() #forregzbot
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <D41A3A42-2412-4722-9090-01565058E525@gmail.com>
 <4eac7a29-fed2-6493-a604-17fcba2a13ba@leemhuis.info>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <4eac7a29-fed2-6493-a604-17fcba2a13ba@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/12/26 21:29, Thorsten Leemhuis wrote:
> [Note: this mail contains only information for Linux kernel regression
> tracking. Mails like these contain '#forregzbot' in the subject to make
> then easy to spot and filter out. The author also tried to remove most
> or all individuals from the list of recipients to spare them the hassle.]
> 
> On 25.12.22 13:11, Zeno Davatz wrote:
>> Hi
>>
>> I am getting this hang with kernel 6.1. See attachment.
>>
>> Is this related to your patch?
>>
>> Kernel 6.1 does not boot for me. Kernel 6.0 was fine.
>>
>> Thank you for your reply.
> 
> Thanks for the report. To be sure below issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
> tracking bot:
> 
> #regzbot ^introduced v6.0..v6.1-rc1
> #regzbot title pci(?)/iommu(?): hang with kernel 6.1
> #regzbot ignore-activity
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> P.S.: As the Linux kernel's regression tracker I deal with a lot of
> reports and sometimes miss something important when writing mails like
> this. If that's the case here, don't hesitate to tell me in a public
> reply, it's in everyone's interest to set the public record straight.
> 

The reporter said that "The problem happens somewhere between Kernel
Version 6.0 and 6.1-rc1." This patch only shows up since v6.1-rc8. This
patch cannot generate any kernel regression on v6.1-rc1.

--
Best regards,
baolu
