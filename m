From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH 2/2] iommu/tegra-gart: Add support for struct iommu_device
Date: Thu, 17 Aug 2017 20:17:53 +0300
Message-ID: <90e1ca9c-d763-c80a-a9b0-cdd84028620d@gmail.com>
References: <1502317752-8792-1-git-send-email-joro@8bytes.org>
 <1502317752-8792-3-git-send-email-joro@8bytes.org>
 <66711b72-455f-8ec1-e6f7-5946480dde14@gmail.com> <20170817135230.GF6854@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170817135230.GF6854@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Hiroshi Doyu <hdoyu@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

On 17.08.2017 16:52, Thierry Reding wrote:
> On Thu, Aug 17, 2017 at 01:21:52AM +0300, Dmitry Osipenko wrote:
>> Hello Joerg,
>>
>> On 10.08.2017 01:29, Joerg Roedel wrote:
>>> From: Joerg Roedel <jroedel@suse.de>
>>>
>>> Add a struct iommu_device to each tegra-gart and register it
>>> with the iommu-core. Also link devices added to the driver
>>> to their respective hardware iommus.
>>>
>>> Signed-off-by: Joerg Roedel <jroedel@suse.de>
>>> ---
>>>  drivers/iommu/tegra-gart.c | 26 ++++++++++++++++++++++++++
>>>  1 file changed, 26 insertions(+)
>>>
>>
>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>> Tested-by: Dmitry Osipenko <digetx@gmail.com>
>>
>>> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
>>> index 29bafc6..b62f790 100644
>>> --- a/drivers/iommu/tegra-gart.c
>>> +++ b/drivers/iommu/tegra-gart.c
>>
>> [snip]
>>
>>> @@ -449,6 +472,9 @@ static int tegra_gart_remove(struct platform_device *pdev)
>>>  {
>>
>> BTW, GART's driver can't be build as a module, so this function is pretty much a
>> dead code. Probably worth considering its removal.
> 
> Technically you can unbind the driver via sysfs, in which case this
> function would still be called. That said, all sorts of things will
> probably start to crash when you do that. I'd like to think that we
> will eventually be able to deal with this sanely (there's some work
> in progress to establish stronger links between devices, so that we
> can sanely deal with this kind of dependency), so I think it's okay
> to keep this around in case we ever get there.
> 

Good point! I tried to unbind and with this patch kernel crashes immediately:

[  193.968506] kernel BUG at mm/slab.c:2816!
[  193.968912] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
[  193.969466] Modules linked in:
[  193.969822] CPU: 1 PID: 1177 Comm: bash Not tainted
4.13.0-rc5-next-20170816-00067-gd320d19b76f8 #593
[  193.970653] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[  193.971313] task: ee31e380 task.stack: ee394000
[  193.971771] PC is at ___cache_free+0x374/0x47c
[  193.972261] LR is at 0x1
[  193.972539] pc : [<c02776ec>]    lr : [<00000001>]    psr: 200b0093
[  193.973112] sp : ee395dd0  ip : 00000009  fp : 00000000
[  193.973603] r10: 00000480  r9 : 2e844000  r8 : c1814d8c
[  193.974097] r7 : 005e4c40  r6 : c0f91fc0  r5 : ef262480  r4 : ef0003c0
[  193.974694] r3 : ef262400  r2 : ef262000  r1 : 00000400  r0 : 00000004

[snip]

[  193.991288] [<c02776ec>] (___cache_free) from [<c0278230>] (kfree+0xbc/0x260)
[  193.991978] [<c0278230>] (kfree) from [<c058897c>] (device_release+0x2c/0x90)
[  193.992732] [<c058897c>] (device_release) from [<c0ab6f14>]
(kobject_put+0x8c/0xe8)
[  193.993474] [<c0ab6f14>] (kobject_put) from [<c0527868>]
(tegra_gart_remove+0x1c/0x58)
[  193.994320] [<c0527868>] (tegra_gart_remove) from [<c058f770>]
(platform_drv_remove+0x24/0x3c)
[  193.995121] [<c058f770>] (platform_drv_remove) from [<c058db30>]
(device_release_driver_internal+0x15c/0x204)
[  193.996033] [<c058db30>] (device_release_driver_internal) from [<c058c2fc>]
(unbind_store+0x7c/0xfc)
[  193.996890] [<c058c2fc>] (unbind_store) from [<c02f8078>]
(kernfs_fop_write+0x104/0x208)
[  193.997661] [<c02f8078>] (kernfs_fop_write) from [<c027f6ec>]
(__vfs_write+0x1c/0x128)
[  193.998445] [<c027f6ec>] (__vfs_write) from [<c02810b8>] (vfs_write+0xa4/0x168)
[  194.017668] [<c02810b8>] (vfs_write) from [<c0281f0c>] (SyS_write+0x3c/0x90)
[  194.038493] [<c0281f0c>] (SyS_write) from [<c0107ce0>]
(ret_fast_syscall+0x0/0x1c)
[  194.057182] Code: e3a03000 ebfff54e eaffffe2 e7f001f2 (e7f001f2)

Without this patch, it crashes too after unbinding but not immediately. Either
way unbinding isn't useful for this device.

> I don't have any objections to making the driver unloadable if that
> is what everyone else prefers, though. In that case, however, there
> are more steps involved than just removing the ->remove() callback.
> 
Indeed!

-- 
Dmitry
