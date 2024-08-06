Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA6C29A1
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 00:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902974; cv=none; b=TvMf9CV2TMKpW6OQmO7+ZnRDYW5mjXJupmsj34WX51HvgM4l5cwDQJlzroCoXO2bdLXjq/g7TcagYTA8eCZ5QrqZrQ7yR9NZJB+Rr1jc7kSPXZ49tF94RSSexSsqO0GSdnhnccwONyPAxjb9K2M2jMYF090YEzEDsLk6ck/LzAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902974; c=relaxed/simple;
	bh=QGYJ7DgsY5F9LBDwcmkATvyG2daQNLbHe+euRgQ464k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cet81b6NXus+omRpn7Rl2EFL9Szrbu7+MNuZYy8cgLzGeoLLwLzN8qSfUGIFX6ASb92urYJrdnqGfcHaSMfgpYsBX6cJC5atzSvUUOrN2WAzZyilv7jg6SKZ4/ANUqFICiALTfSF1Fh0fwLPzSQYPsmC1PTuRwN4AcLPvR7jTfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lsxeTx6X; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lsxeTx6X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722902973; x=1754438973;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QGYJ7DgsY5F9LBDwcmkATvyG2daQNLbHe+euRgQ464k=;
  b=lsxeTx6XRRE3EQ4oj3zRcg842TCVCGbRSmB8wUenbdtels6K7o4iiA4Z
   G/wSGZKOpjUww4+6++bSzpyRldo5HOrM70LSlBVvMIajLNkDUCeBBATY8
   lIrzDH5x+PoG6kD1wdrq/W4Dju/cQqkZFNOtr1HjZ8h+hAiHzbXVoocZK
   /dpwp2QH2ELGckeY4DIuXJ22jsDQF+G4Q2lvb3Oayiw/zkdnpGpQKIex6
   NCi7dPEFkTtVbzmf2ojyIVesPJBUMRVxFfaHWpvOdeWXQj8rIz8uxlWk/
   zTzSRUDJNR2vAFhK2QYv0pSaeTdivN6h+lC/gHJLhCTlU5eimtjP/1xI+
   w==;
X-CSE-ConnectionGUID: M+Wgut8/Qqe/mA19DyLHmQ==
X-CSE-MsgGUID: Zac8Ku84S0CsCE320hWi7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="38348389"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="38348389"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 17:09:33 -0700
X-CSE-ConnectionGUID: gXo9lAvsTK6FFdmTeNzY5w==
X-CSE-MsgGUID: VAFTA9alSLicwxlBfg3oMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="56260351"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 17:09:28 -0700
Message-ID: <bc992d69-da3a-41c7-bee9-81c469fb592d@linux.intel.com>
Date: Tue, 6 Aug 2024 08:09:26 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kunkun Jiang <jiangkunkun@huawei.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
 Michael Shavit <mshavit@google.com>, Mostafa Saleh <smostafa@google.com>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 wanghaibin.wang@huawei.com, yuzenghui@huawei.com, tangnianyao@huawei.com
Subject: Re: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
To: Pranjal Shrivastava <praan@google.com>, Will Deacon <will@kernel.org>
References: <6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com>
 <7d5a8b86-6f0d-50ef-1b2f-9907e447c9fc@huawei.com>
 <20240724102417.GA27376@willie-the-truck>
 <c2f6163e-47f0-4dce-b077-7751816be62f@linux.intel.com>
 <CAN6iL-QvE29-t4B+Ucg+AYMPhr9cqDa8xGj9oz_MAO5uyZyX2g@mail.gmail.com>
 <5e8e6857-44c9-40a1-f86a-b8b5aae65bfb@huawei.com>
 <20240805123001.GB9326@willie-the-truck> <ZrDwolC6oXN44coq@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZrDwolC6oXN44coq@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/8/5 23:32, Pranjal Shrivastava wrote:
> On Mon, Aug 05, 2024 at 01:30:01PM +0100, Will Deacon wrote:
>> On Mon, Aug 05, 2024 at 08:13:09PM +0800, Kunkun Jiang wrote:
>>> On 2024/8/2 22:38, Pranjal Shrivastava wrote:
>>>> Hey,
>>>> On Mon, Jul 29, 2024 at 11:02 AM Baolu Lu<baolu.lu@linux.intel.com>  wrote:
>>>>> On 2024/7/24 18:24, Will Deacon wrote:
>>>>>> On Wed, Jul 24, 2024 at 05:22:59PM +0800, Kunkun Jiang wrote:
>>>>>>> On 2024/7/24 9:42, Kunkun Jiang wrote:
>>>>>>>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>>>>> 1797                 while (!queue_remove_raw(q, evt)) {
>>>>>>>> 1798                         u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
>>>>>>>> 1799
>>>>>>>> 1800                         ret = arm_smmu_handle_evt(smmu, evt);
>>>>>>>> 1801                         if (!ret || !__ratelimit(&rs))
>>>>>>>> 1802                                 continue;
>>>>>>>> 1803
>>>>>>>> 1804                         dev_info(smmu->dev, "event 0x%02x
>>>>>>>> received:\n", id);
>>>>>>>> 1805                         for (i = 0; i < ARRAY_SIZE(evt); ++i)
>>>>>>>> 1806                                 dev_info(smmu->dev, "\t0x%016llx\n",
>>>>>>>> 1807                                          (unsigned long
>>>>>>>> long)evt[i]);
>>>>>>>> 1808
>>>>>>>> 1809                         cond_resched();
>>>>>>>> 1810                 }
>>>>>>>>
>>>>>>>> The smmu-v3 driver cannot print event information when "ret" is 0.
>>>>>>>> Unfortunately due to commit 3dfa64aecbaf
>>>>>>>> ("iommu: Make iommu_report_device_fault() return void"), the default
>>>>>>>> return value in arm_smmu_handle_evt() is 0. Maybe a trace should
>>>>>>>> be added here?
>>>>>>> Additional explanation. Background introduction:
>>>>>>> 1.A device(VF) is passthrough(VFIO-PCI) to a VM.
>>>>>>> 2.The SMMU has the stall feature.
>>>>>>> 3.Modified guest device driver to generate an event.
>>>>>>>
>>>>>>> This event handling process is as follows:
>>>>>>> arm_smmu_evtq_thread
>>>>>>>        ret = arm_smmu_handle_evt
>>>>>>>            iommu_report_device_fault
>>>>>>>                iopf_param = iopf_get_dev_fault_param(dev);
>>>>>>>                // iopf is not enabled.
>>>>>>> // No RESUME will be sent!
>>>>>>>                if (WARN_ON(!iopf_param))
>>>>>>>                    return;
>>>>>>>        if (!ret || !__ratelimit(&rs))
>>>>>>>            continue;
>>>>>>>
>>>>>>> In this scenario, the io page-fault capability is not enabled.
>>>>>>> There are two problems here:
>>>>>>> 1. The event information is not printed.
>>>>>>> 2. The entire device(PF level) is stalled,not just the current
>>>>>>> VF. This affects other normal VFs.
>>>>>> Oh, so that stall is probably also due to b554e396e51c ("iommu: Make
>>>>>> iopf_group_response() return void"). I agree that we need a way to
>>>>>> propagate error handling back to the driver in the case that
>>>>>> 'iopf_param' is NULL, otherwise we're making the unexpected fault
>>>>>> considerably more problematic than it needs to be.
>>>>>>
>>>>>> Lu -- can we add the -ENODEV return back in the case that
>>>>>> iommu_report_device_fault() doesn't even find a 'iommu_fault_param' for
>>>>>> the device?
>>>>> Yes, of course. The commit b554e396e51c was added to consolidate the
>>>>> drivers' auto response code in the core with the assumption that driver
>>>>> only needs to call iommu_report_device_fault() for reporting an iopf.
>>>>>
>>>> I had a go at taking Jason's diff and implementing the suggestions in
>>>> this thread.
>>>> Kunkun -- please can you see if this fixes the problem for you?
>>> Okay, I'll test it as soon as I can.
>> It looks like the diff sent by Pranjal has whitespace mangling, so I
>> don't think you'll be able to apply it.
>>
>> Pranjal -- please can you send an unmangled version? If you want to test
>> out your mail setup, I'm happy to be a guinea pig so you don't spam the
>> mailing lists!
> Ugh, apologies for that, something went wrong with my client.
> Kunkun -- Please let me know if this fixes the problem.
> Lu -- It looks like the intel->page_response callback doesn't expect a
> NULL event, so, for now, I immediately return in that case. LMK what you
> think?

That's okay. We had such check there before the refactoring.

Thanks,
baolu
