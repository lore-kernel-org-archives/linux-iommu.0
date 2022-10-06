Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6477C33CF
	for <iommu@lists.linux.dev>; Thu,  6 Oct 2022 18:43:21 +0000 (UTC)
Received: from [192.168.2.145] (unknown [109.252.119.114])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id E2FF36602317;
	Thu,  6 Oct 2022 19:43:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1665081793;
	bh=oVnRbcXpeCezNiePIdjs0ptusalb1mzn0j7o+NCDyqY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lqyvy3UuuLu7WMAVOwGNM1acmShffdbrckjT2Q+W5W++cJqN3JOCQMTZyX7EcMX0E
	 LXVniCHb/O0SA/c5bjQH5bPcfLYhHV0TXb5F0MbJsnGooEdRWL8nEw2vVqssZRF3Ju
	 jxZZPFHR2IgFqUXD2KVN4UKOydowEmVjUlnMWV52yYNpEKIMe0bbfnHYdoUalwzFnz
	 xhQ5YsirPRUE6k8b0rHX9XSyq18dJcElxej8+WQO2NWPOYBs5VxndBK05ISadJrWc+
	 XrVN4lmPmrCH9Z2koaA5/X0EetwSx/lKsk2jm7Pgh4OujOcuZkm1UnVyXJ4B3bBqAn
	 74JEqF855DhyQ==
Message-ID: <eeeb8199-e315-422b-4567-6139b9b27fde@collabora.com>
Date: Thu, 6 Oct 2022 21:43:09 +0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v4 05/16] iommu: Move bus setup to IOMMU device
 registration
To: Thierry Reding <treding@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Dmitry Osipenko <digetx@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 baolu.lu@linux.intel.com, kevin.tian@intel.com,
 suravee.suthikulpanit@amd.com, vasant.hegde@amd.com, mjrosato@linux.ibm.com,
 schnelle@linux.ibm.com, linux-kernel@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1660572783.git.robin.murphy@arm.com>
 <d342b6f27efb5ef3e93aacaa3012d25386d74866.1660572783.git.robin.murphy@arm.com>
 <89d873fc-9f0a-156e-dcf2-48a2b9f93dcc@nvidia.com>
 <583c4689-844d-2ae2-79fb-4750b21c4304@arm.com> <Yz8Mabz/SL7gG9VA@orome>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <Yz8Mabz/SL7gG9VA@orome>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/6/22 20:12, Thierry Reding wrote:
> On Thu, Oct 06, 2022 at 04:27:39PM +0100, Robin Murphy wrote:
>> On 2022-10-06 15:01, Jon Hunter wrote:
>>> Hi Robin,
>>>
>>> On 15/08/2022 17:20, Robin Murphy wrote:
>>>> Move the bus setup to iommu_device_register(). This should allow
>>>> bus_iommu_probe() to be correctly replayed for multiple IOMMU instances,
>>>> and leaves bus_set_iommu() as a glorified no-op to be cleaned up next.
>>>>
>>>> At this point we can also handle cleanup better than just rolling back
>>>> the most-recently-touched bus upon failure - which may release devices
>>>> owned by other already-registered instances, and still leave devices on
>>>> other buses with dangling pointers to the failed instance. Now it's easy
>>>> to clean up the exact footprint of a given instance, no more, no less.
>>>
>>>
>>> Since this change, I have noticed that the DRM driver on Tegra20 is
>>> failing to probe and I am seeing ...
>>>
>>>   tegra-gr2d 54140000.gr2d: failed to attach to domain: -19
>>>   drm drm: failed to initialize 54140000.gr2d: -19

The upstream Tegra20 device-tree doesn't have IOMMU phandle for
54140000.gr2d. In this case IOMMU domain shouldn't be available for the
DRM driver [1]. Sounds like IOMMU core has a bug.

[1]
https://elixir.bootlin.com/linux/latest/source/drivers/iommu/tegra-gart.c#L243

>>> Bisect points to this change and reverting it fixes it. Let me know if
>>> you have any thoughts.
>>
>> Oh, apparently what's happened is that I've inadvertently enabled the
>> tegra-gart driver, since it seems that *wasn't* calling bus_set_iommu()
>> before. Looking at the history, it appears to have been that way since
>> c7e3ca515e78 ("iommu/tegra: gart: Do not register with bus"), so essentially
>> that driver has been broken and useless for close to 8 years now :(
>>
>> Given that, I'd be inclined to "fix" it as below, or just give up and delete
>> the whole thing.
> 
> I'm inclined to agree. GART is severely limited: it provides a single
> IOMMU domain with an aperture of 32 MiB. It's close to useless for
> anything we would want to do and my understanding is that people have
> been falling back to CMA for any graphics/display stuff that the GART
> would've been useful for.
> 
> Given that nobody's felt the urge to fix this for the past 8 years, I
> don't think there's enough interest in this to keep it going.
> 
> Dmitry, any thoughts?

This GART driver is used by a community kernel fork that has alternative
DRM driver supporting IOMMU/GART on Tegra20. The fork is periodically
synced with the latest upstream, it's used by postmarketOS. Hence it
wasn't a completely dead driver.

The 32M aperture works well for 2d/3d engines because it fits multiple
textures at once. Tegra DRM driver needs to remap buffers dynamically,
but this is easy to implement because DRM core has nice helpers for
that. We haven't got to the point where upstream DRM driver is ready to
support this feature.

CMA is hard to use for anything other than display framebuffers. It's
slow and fails to allocate memory if CMA area is "shared" due to
fragmentation and pinned pages. Reserved CMA isn't an option for GPU
because then there is no memory for the rest of system.

I don't see any problems with removing GART driver. It's not going to be
used soon in upstream and only adds maintenance burden. We can always
re-add it in the future.

-- 
Best regards,
Dmitry

