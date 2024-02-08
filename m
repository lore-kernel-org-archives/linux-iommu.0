Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DA91D55F;
	Thu,  8 Feb 2024 01:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707355374; cv=none; b=Uv7jGco7pASDEVU3mYdeD7mBvXfXDm8QB3q6+tqG4bC/cY5Y4yQvr5Zffz0D24tglyBt+R0+W1LayaEWcvv249+5Naw7I5rmznm8pAAkL7//N+uyOVrPbFSbg7pNHGc/n7WeGwZ33QFQtceMOf+muKBfPdkvDW6xBL7TESRjqS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707355374; c=relaxed/simple;
	bh=uJkl8rQIIVzke3d5r1OPVklBSLEAlrL8ULekb9pG0xc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kMFzGScfb13wNSvp8BYh8dzWYAdi5WGl3ckgQBxck5Y6P8TshvMSXoaHLVjENGO4EIvJUaUwITrFL+K9Gna8TK6zoks3wIHz5lQ15Yjtuax9514BSSIkyfIakdPoSDRY72lp8iZJwDyDpJ/nX/kl3hDhGk0uJi08JB0xNUDY6As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F17871FB;
	Wed,  7 Feb 2024 17:23:32 -0800 (PST)
Received: from [10.57.49.110] (unknown [10.57.49.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E628A3F762;
	Wed,  7 Feb 2024 17:22:48 -0800 (PST)
Message-ID: <d5074c11-b03a-4a24-9e3a-dfa5743d80bb@arm.com>
Date: Thu, 8 Feb 2024 01:22:47 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [REGRESSION] Failed buffer allocation in Tegra fbdev
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>, thierry.reding@gmail.com,
 vdumpa@nvidia.com, joro@8bytes.org, will@kernel.org, jonathanh@nvidia.com,
 baolu.lu@linux.intel.com, jsnitsel@redhat.com, jroedel@suse.de,
 linux-tegra@vger.kernel.org, iommu@lists.linux.dev,
 regressions@lists.linux.dev
References: <bbmhcoghrprmbdibnjum6lefix2eoquxrde7wyqeulm4xabmlm@b6jy32saugqh>
 <20240123151508.GR50608@ziepe.ca>
 <pgund4coabp5pdlmwze5o2d7ogrdncktqz267yzukjcvmikudc@7svrwdci7ujl>
 <55cab5e0-0abf-47d0-becc-05cdf1d22fac@arm.com>
 <20240124170300.GU50608@ziepe.ca>
Content-Language: en-GB
In-Reply-To: <20240124170300.GU50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/01/2024 5:03 pm, Jason Gunthorpe wrote:
> On Wed, Jan 24, 2024 at 11:46:59AM +0000, Robin Murphy wrote:
>>>>> This may be connected with an error in of_iommu_configure() that
>>>>> became visible after commit 6ff6e184f1f4d:
>>>>>
>>>>> [    1.200004] host1x drm: iommu configuration for device failed with -ENOENT
>>>>
>>>> Hmmm
>>>>
>>>> This is a new logging, so it doesn't necessarily mean something has
>>>> changed in the code flow.
>>>>
>>>> It seems the issue is something in there is returning ENOENT when it
>>>> probably should be ENODEV, but I haven't been able to guess where it
>>>> comes from.
>>>>
>>>> Can you do some tracing and figure out where under
>>>> of_iommu_configure() this ENOENT return code is from?
>>>
>>> I did the tracing and found that the ENOENT is coming from
>>> sysfs_do_create_link_sd() in the following function call chain:
>>>
>>> of_iommu_configure() -> iommu_probe_device() -> __iommu_probe_device() ->
>>
>> What's the call path leading up to that? If it's the one from
>> host1x_device_add() then it's expected and benign - for fiddly reasons,
>> iommu_probe_device() ends up being called too early, but will soon be run
>> again in the correct circumstances once we proceed into
>> host1x_subdev_register()->device_add(). That will have been happening for
>> years, we just never reported errors in that spot before (and frankly I'm
>> not convinced it's valuable to have added it now).
> 
> Hmm. Prior to
> 
> commit 14891af3799e ("iommu: Move the iommu driver sysfs setup into
> iommu_init/deinit_device()")
> 
> The error from iommu_device_link() was ignored. It seems like for most
> of the years the probe actually succeeded, just with a mangled sysfs?

Hmm, yeah, I suppose the iommu_group/<n>/devices/ dir just didn't get 
populated and nobody noticed or cared (which TBH doesn't really surprise 
me for a case where a kernel driver is expected to manage the IOMMU 
anyway such that it's pretty much irrelevant to userspace).

> Though that host1x_device_add() ignored the return code does make me
> wonder..
> 
> This is the only clue I see:
> 
> commit c95469aa5a188384ccf8ac520ece931c66caf8aa
> Author: Alexandre Courbot <acourbot@nvidia.com>
> Date:   Fri Feb 26 18:06:53 2016 +0900
> 
>      gpu: host1x: Set DMA ops on device creation
>      
>      Currently host1x-instanciated devices have their dma_ops left to NULL,
>      which makes any DMA operation (like buffer import) on ARM64 fallback
>      to the dummy_dma_ops and fail with an error.
>      
>      This patch calls of_dma_configure() with the host1x node when creating
>      such a device, so the proper DMA operations are set.
>      
>      Suggested-by: Thierry Reding <thierry.reding@gmail.com>
>      Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>      Signed-off-by: Thierry Reding <treding@nvidia.com>
> 
> Which is no longer happening anymore as failure of
> iommu_probe_device() will not cause the dma ops to be setup.
> 
> So, if everything still works and something else is calling
> of_dma_configure() prior to using the struct device for any DMA
> operations (eg because a driver is always probed?) then we should just
> delete this call.

I've considered that before - arguably it could have been removed when 
Mikko implemented the full bus model, but now I kind of don't want to 
since it's one of the remaining few that *is* still in the right place 
where it's always meant to be. The correct fix to meet the original 
expectations *should* be simply:

----->8-----
diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 84d042796d2e..6cab950690a0 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -455,11 +455,11 @@ static int host1x_device_add(struct host1x *host1x,
  	device->dev.dma_mask = &device->dev.coherent_dma_mask;
  	dev_set_name(&device->dev, "%s", driver->driver.name);
  	device->dev.release = host1x_device_release;
-	device->dev.bus = &host1x_bus_type;
  	device->dev.parent = host1x->dev;

  	of_dma_configure(&device->dev, host1x->dev->of_node, true);

+	device->dev.bus = &host1x_bus_type;
  	device->dev.dma_parms = &device->dma_parms;
  	dma_set_max_seg_size(&device->dev, UINT_MAX);

-----8<-----

...except you've now also broken that at the same time by removing the 
dev->bus check from of_iommu_configure() :(

> Robin do you know more? Specifically where is the "soon be run again"?

I can't say why it's done in quite such a roundabout manner by 
host1x_subdev_register(), but as I called out, we quickly get to the 
actual device_add() call, wherein things proceed as normal. The only 
thing going wrong here is that we "replay" the iommu_probe_device() call 
*before* it ever could have happened normally.

Frankly, for all you protest whenever I call you out for demonstrating a 
lack of understanding of this tangled mess, I sure do seem to spend a 
lot of time explaining it to you... :/

I've never claimed it's *not* a horrible mess, but at the risk of 
repeating myself, it *is* fragile, and the consequences of mucking about 
with it are tricky to reason about even when one does understand all the 
history of how it's intended to work vs. what actually happens. To coin 
a phrase I find enjoyable, this is definitely "F around and find out" 
code; as this and other threads show, now you're well into the finding 
out part.

> Was the above issue fixed in commit 07397df29e57 ("dma-mapping: move
> dma configuration to bus infrastructure") ?

Um, no. That commit was no more than code movement essentially 
separating PCI from non-PCI configuration; merely host1x didn't need to 
share the full path which ended up as platform_dma_configure() since 
host1x doesn't support ACPI. Once again the fact that I've had to 
explain that drives me to utter despair...

Robin.
