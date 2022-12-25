Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CAA8819
	for <iommu@lists.linux.dev>; Sun, 25 Dec 2022 13:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671976342; x=1703512342;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=JyNYrhW3xrk1MYtAGk4Rpa4YWpB4Xi5dFKV1k8qSM0g=;
  b=PlC1lCtJXAmtEyaf3B9wSp8sdOigvWbsZv5UlGiDrX+1g879X0uBI4hv
   4olEnBK0daXGIeUeuRY41j+cIn3HXYwPnpd8bRhg44TVXPFNMJjZM9AV1
   X8VAV81ULL42D0by7QVGoL2IZfqN/E6dAuYpmYGo1/68LgG4mvCyVZqTr
   zqEHctNE560iaNuRN+uTqQCwJvdKsD7uvzftcdVDim8OLCKYkLMUY0wji
   rZtb/FNStEK+KOGP98ME6sC1sY6tuUTaFhzI0yXnUCKLo0cqSRSQAgVqf
   81SNo6LriXFghVAQqEWgc7icJkRW2ebcmD8WSbKdQole1fYzveLzF94ED
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="406740620"
X-IronPort-AV: E=Sophos;i="5.96,273,1665471600"; 
   d="scan'208";a="406740620"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2022 05:52:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="741268664"
X-IronPort-AV: E=Sophos;i="5.96,273,1665471600"; 
   d="scan'208";a="741268664"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.120]) ([10.254.211.120])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2022 05:52:19 -0800
Message-ID: <1c3be2ab-43af-cac7-fa0b-f3118b4e714e@linux.intel.com>
Date: Sun, 25 Dec 2022 21:52:17 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, wangxiongfeng2@huawei.com, dwmw2@infradead.org,
 iommu@lists.linux.dev, joro@8bytes.org, jroedel@suse.de,
 robin.murphy@arm.com, will@kernel.org, yangyingliang@huawei.com
Content-Language: en-US
To: Zeno Davatz <zdavatz@gmail.com>
References: <D41A3A42-2412-4722-9090-01565058E525@gmail.com>
 <6531c0eb-5ca7-9026-a8b7-eb4442629d0d@linux.intel.com>
 <CAOkhzLWJzYoE-1b02ZLra=1FF7WjLYznf_PwMEAQWB0NGJsJhw@mail.gmail.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix PCI device reference count leak in
 has_external pci()
In-Reply-To: <CAOkhzLWJzYoE-1b02ZLra=1FF7WjLYznf_PwMEAQWB0NGJsJhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/12/25 21:37, Zeno Davatz wrote:
> On Sun, Dec 25, 2022 at 2:16 PM Baolu Lu<baolu.lu@linux.intel.com>  wrote:
>> On 2022/12/25 20:11, Zeno Davatz wrote:
>>> Hi
>>>
>>> I am getting this hang with kernel 6.1. See attachment.
>>>
>>> Is this related to your patch?
>>>
>>> Kernel 6.1 does not boot for me. Kernel 6.0 was fine.
>> It seems unlikely.
>>
>> Have you located the patch through the bisect tool? Or does it boot well
>> if you revert this patch?
> I did not bisect the patch. All I currently know is that version 5.5
> and version 6.0 of the Kernel booted fine for me.
> 
> I test every Kernel release and normally the boot process goes flawless.
> 
> The patch I am referring to is also mentioned by Linus in the Kernel
> log, AFAICT tell the only PCI patch.
> 
> https://lkml.org/lkml/2022/12/11/206

I didn't find any reference to this patch in above thread. Can you
please elaborate a bit more?

By the way, from the video you shared, the hang happens in the PCI
enumeration process. This patch touched the code that only executes
after that.

Can you please simply revert this patch and check the boot again?

--
Best regards,
baolu
