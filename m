Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB5E3C945A;
	Thu,  1 Oct 2026 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873256; cv=none; b=RkAbU1i8ea9Xq5fCjyzHovVlncfICokoBKBb4T9jbYy1sesQ9z32IXY/S/IAqFCZPa2ij/V7kReVNA3N1wXp1BVWXUz275RNZ+qtv7ZIEqOQV2tNSLpbrgr5DBk+3jLn2h/K5wByX4hYPREHkJBbAI9mpaTmWgA/Dtetra1CiN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873256; c=relaxed/simple;
	bh=n9XIO+FCtR5RGP2aVIeOzFhviUjwIvMo6NoXrlUrKFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNmF/6tGa1xaw2ANF9hQ71d09NisGSLHbJAlslSZMb9jHyroGQvGpuN3rjt0PD8jAhC9Dr90MbKlFjr2Ak+93JjGjG0dze7LzVf5OfapaUBZslWp/keOBNBCqsjhX1usSY3oBDBR4ds/XmXsM5/M3fAjcvTHimchEnRkZoV+9Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYBLhdXz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYBLhdXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F731F000FF;
	Thu,  1 Oct 2026 16:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790873254;
	bh=FhZ3viI4a+onznOSZ/GgXONA5mgxVXnZIXHP+HAKRZo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BYBLhdXzWw6hX50PjoCkj4DtY7oVXhLI7ajAsCWzwlAs+9X3eTMkcIiKe1tG3DGwU
	 LFXeQxa6jSPPZuftXGdujfNg8E+UQvgckXKDP7c5SQNG+JrLz2D2zWBRg9/3VBwnGK
	 ZMRHFIoceGupgZBb/PPdMSP9OAW+TTMOE1RAJHIoDvuKRqWA/8iPVF5KBp3QohyP3X
	 KHXuDk1ck8M//MJ4U5mupP+oK12skf+/BNgyJoVrE6O+iYBEUYs0N/61N95e4aHwaq
	 KYLPEI9sZ7B3vF1Ocvru/79l9AgS3Xbfwu4olI/PFBmXnneHz+PTXaDFLVD4mEqTYt
	 4eVbWIK2oNjGQ==
Message-ID: <0221445b-92b1-43b3-99e6-d1c57c6a202e@kernel.org>
Date: Thu, 1 Oct 2026 11:47:33 -0500
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu/amd: Make PerfOpt compulsory
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alex Deucher <alexander.deucher@amd.com>,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20260930162401.273907-1-superm1@kernel.org>
 <179080801733.122959.2048638492948411360.b4-review@b4>
 <01dc5f6c-3131-42b6-9aea-23d8c5f19757@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <01dc5f6c-3131-42b6-9aea-23d8c5f19757@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/26 06:34, Vasant Hegde wrote:
> 
> 
> On 10/1/2026 4:10 AM, Jason Gunthorpe wrote:
>>> [ ... 336 lines skipped ... ]
>>> @@ -2370,7 +2370,7 @@ static int attach_device(struct device *dev,
>>>   	if (ret)
>>>   		goto out;
>>>   
>>> -	if (dev_data->perfopt)
>>> +	if (dev_data->perfopt && pdom_is_in_pt_mode(domain))
>>>   		goto skip_caps;
>>
>> This should also disable PASID support since without a gcr3 table
>> that's broken. Set the max_pasid to zero during probe device.
> 
> I think we can add it inside amd_iommu_probe_device().

OK, I'll rev the patch to do this.

> 
>>
>> The flow is weird like this because the driver still hasn't cleaned up
>> the identity/blocking domain flows. There is no need to track them in
>> lists and things because they never need invalidation..
> 
> Right. attach_device path cleanup is in my list. Now that _probe() path is
> settled (thanks to Pranjal), this is probably next item to pick up.
> 
> 
>>
>> This is much nicer if the above could be written in side
>> amd_iommu_identity_attach().
> 
> I'd say for now its fine to keep it in attach_device() as it gets called anyway.
> When I rework, will make sure its moved under  amd_iommu_identity_attach().
> 

I'll leave these two items to Vasant.

> 
>>
>> Also, I'm a little confused, I thought this had to be toggled on and
>> off so it is only set while in identity, how does the DTE influence
>> what happens when in this special mode? I was sort of expecting it was
>> ignored entirely in HW. This version seems to lock it to always on,
>> but still permits a blocking domain to attach.
>>

Yeah; AFAICT all the skips of features are mostly symbolic and for 
consistency when this is enabled.

I suppose really we should not permit a blocking domain to attach to 
make sure it's a clear message what's going on.

> 
> Mario, Can you check what happens if we move device to BLOCKED domain (DTE[v]=0) ?
> 
> -Vasant


I tested this on an APU that applies this.

Short answer: with PerfOpt enabled, moving the GPU towards a blocked DTE
has no effect -- the device keeps doing DMA as if nothing changed. This
matches Jason's expectation that the DTE is ignored entirely in HW for the
device once it is in the PerfOpt/identity fast path.

Longer answer below (I had an agent help do this check).

Method
------
To keep the normal driver bound and the GPU doing real work, I added a
small debugfs knob that flips the live DTE in place and back, reusing the
existing paths:

   clear_dte_entry()  -> V=1, TV=0, IR=IW=0   (same DTE as blocking domain)
   set_dte_entry()    -> restore passthrough

Note the AMD "blocked" DTE is V=1/TV=0, not V=0 -- make_clear_dte() keeps
V set, and TV=0 is what is supposed to block DMA. I confirmed the change
via /sys/kernel/debug/iommu/amd/devtbl:

   passthrough:  QWORD[0] = 0x6000000000000003  (V=1 TV=1 IR=1 IW=1)
   blocked:      QWORD[0] = 0x0000000000000001  (V=1 TV=0 IR=0 IW=0)

The write goes through update_dte256() + iommu_flush_dte_sync() + a
completion wait, so the IOMMU re-fetched the entry.

For a guaranteed IOMMU-routed DMA source I used amdgpu_benchmark test 1
(SDMA VRAM<->GTT copies). The GTT side is system memory, so for an
identity device it has to traverse the IOMMU DTE.

Result
------
With the DTE blocked (TV=0), SDMA still moved 2GB to and from GTT at full
speed:

   dma 1024 bo moves of 1024 kB from 2 to 4 ...  5890 MB/s  (GTT->VRAM)
   dma 1024 bo moves of 1024 kB from 4 to 2 ... 10922 MB/s  (VRAM->GTT)

(vs ~10-11 GB/s unblocked, i.e. no change). During the blocked window:

   - mem_target_abort (amd_iommu PMU) = 0
   - no IO_PAGE_FAULT in the event log
   - no SDMA error / ring timeout / GPU reset

I also tried to witness the GPU's DMA directly via the amd_iommu PMU
filtered by devid. The filter itself works (NVMe, in a translating
domain, shows ~120M mem_trans_total under load), but the GPU reads zero
on every counter -- mem_trans_total, mem_pass_untrans, mem_target_abort --
even under the 2GB benchmark. The GPU is the only identity device on this
system, so I had no non-PerfOpt passthrough device to validate the
passthrough counters against; hence I am relying on the functional
benchmark result above rather than the zero counts.

Conclusion
----------
Once PerfOpt is enabled and the device is in the identity/pt fast path,
the DTE is effectively ignored by HW: TV=0 does not block DMA. So a
blocking-domain attach would not actually stop the device while it is in
this state.
