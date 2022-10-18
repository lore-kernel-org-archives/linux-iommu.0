Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E497F
	for <iommu@lists.linux.dev>; Tue, 18 Oct 2022 05:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666071737; x=1697607737;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pai0zlE8ZFGzP5EjtgAERqJxrf7I76YYwc2N19se+qA=;
  b=SKksQp9uXoHlUiQXr+0YkKf1+AcN6maTJxZi/gYjobxF9yhn0gvXe/oV
   iqQbOWV0XuAiZZRCpvllVmeD/irz8Bw/IhvSUISWyYIjQ/1rZEFZ/q1UQ
   5xINW9/OZvJYl8+C56Loko5fciysx46TegxOGoO9sg+9yk44rqtmVCJXv
   XRCmSYI3F6npEgyd0yhcozmPG3zyWWvMj0OFDF299fIDGg4uY+Eip2o3P
   vkwAjVgwejWuGU3zTCGsMCpLsDc2nym+TyN0EeJTNfuMbv2WmuGc95pLq
   guM32Fxqp/NoyCdcDsPpKFvDhjqex3QTCOyjMhbaYLXbRVuH4v2MhzGYh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="285724042"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="285724042"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 22:42:01 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="717773805"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="717773805"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.49]) ([10.254.211.49])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 22:41:59 -0700
Message-ID: <c816c409-0a7a-81f6-adbe-087f0f7dd0c3@linux.intel.com>
Date: Tue, 18 Oct 2022 13:41:57 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Cc: baolu.lu@linux.intel.com, "Coelho, Luciano" <luciano.coelho@intel.com>,
 "Saarinen, Jani" <jani.saarinen@intel.com>,
 "Mistat, Tomasz" <tomasz.mistat@intel.com>,
 "Furquim, Ulisses" <ulisses.furquim@intel.com>,
 "Dutt, Sudeep" <sudeep.dutt@intel.com>, "Nikula, Jani"
 <jani.nikula@intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: Regression with 6.1-rc1
Content-Language: en-US
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 "Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>
References: <SJ1PR11MB6129788F0FE9CF4BD02E3A1DB9299@SJ1PR11MB6129.namprd11.prod.outlook.com>
 <DM5PR11MB1627D4E151F38CEC4496B6F7CD299@DM5PR11MB1627.namprd11.prod.outlook.com>
 <DM4PR11MB614148B80837830E33CD9F4FB9289@DM4PR11MB6141.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <DM4PR11MB614148B80837830E33CD9F4FB9289@DM4PR11MB6141.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2022/10/18 11:26, Borah, Chaitanya Kumar wrote:
> ++ML
> 
>   -----Original Message-----
>   From: Kurmi, Suresh Kumar <suresh.kumar.kurmi@intel.com>
>   Sent: Monday, October 17, 2022 8:30 PM
>   To: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>;
>   joro@8bytes.org
>   Cc: Coelho, Luciano <luciano.coelho@intel.com>; Saarinen, Jani
> <jani.saarinen@intel.com>; Mistat, Tomasz <tomasz.mistat@intel.com>;
>   Furquim, Ulisses <ulisses.furquim@intel.com>; Dutt, Sudeep
>   <sudeep.dutt@intel.com>; Nikula, Jani <jani.nikula@intel.com>
>   Subject: RE: Regression with 6.1-rc1
>   
>   ++
>   
>   -Suresh
>   
>   -----Original Message-----
>   From: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>
>   Sent: Monday, October 17, 2022 8:28 PM
>   To: joro@8bytes.org
>   Cc: Coelho, Luciano <luciano.coelho@intel.com>; Kurmi, Suresh Kumar
>   <suresh.kumar.kurmi@intel.com>; Saarinen, Jani <jani.saarinen@intel.com>
>   Subject: Regression with 6.1-rc1
>   
>   Hello Joerg,
>   
>   Hope you are doing well. I am Chaitanya from the linux graphics team in
>   Intel.
>   
>   This mail is regarding a regression we are seeing with mainline 6.1.0-rc1 in
>   our intel platforms.
>   
>   [   12.435594] ============================================
>   [   12.435596] WARNING: possible recursive locking detected
>   [   12.435598] 6.1.0-rc1 #1 Not tainted
>   [   12.435600] --------------------------------------------
>   [   12.435601] swapper/0/1 is trying to acquire lock:
>   [   12.435603] ffffffff827bd890 (dmar_global_lock){++++}-{3:3}, at:
>   intel_iommu_get_resv_regions+0x1c/0x260
>   [   12.435612]
>                  but task is already holding lock:
>   [   12.435614] ffffffff827bd890 (dmar_global_lock){++++}-{3:3}, at:
>   intel_iommu_init+0xd98/0x1039
>   [   12.435620]
>                  other info that might help us debug this:
>   [   12.435622]  Possible unsafe locking scenario:
>   [   12.435624]        CPU0
>   [   12.435625]        ----
>   [   12.435626]   lock(dmar_global_lock);
>   [   12.435628]   lock(dmar_global_lock);
>   [   12.435630]
>                   *** DEADLOCK ***
>   [   12.435632]  May be due to missing lock nesting notation
>   [   12.435638] 2 locks held by swapper/0/1:
>   [   12.435641]  #0: ffffffff827bd890 (dmar_global_lock){++++}-{3:3}, at:
>   intel_iommu_init+0xd98/0x1039
>   [   12.435646]  #1: ffff888102b7a6c0 (&group->mutex){+.+.}-{3:3}, at:
>   bus_iommu_probe+0xb5/0x2c0
>   [   12.435651]
>                  stack backtrace:
>   [   12.435659] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc1 #1
>   
>   
>   The issue is seen across multiple intel platforms in our CI runs as well after
>   6.1.0-rc1 was integrated into drm-tip
>   
>   Details logs can be found here: https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_12251/bat-dg2-11/boot0.txt
>   
>   We can also see the issue in linux-next. (https://intel-gfx-ci.01.org/tree/linux-next/next-20221017/fi-adl-ddr5/boot0.txt)
> 
> Are you already aware of this issue? Any idea or hint on this?

I have proposed below fix:

https://lore.kernel.org/all/20220927053109.4053662-1-baolu.lu@linux.intel.com/

Does it work for you?

Best regards,
baolu
