From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v5 1/2] iommu - Enable debugfs exposure of IOMMU driver
	internals
Date: Tue, 8 May 2018 15:48:40 -0500
Message-ID: <58f88d92-ae97-6bdf-822a-625e47e4d0d0@amd.com>
References: <152572332370.3235.16541462864315443906.stgit@sosxen2.amd.com>
	<201805080700.Jm8moLQz%fengguang.wu@intel.com>
	<a9600652-f087-5d8f-ff0b-80200d570591@amd.com>
	<e671945494d54cdcf65c6d2af9f9f69d65fb2583.camel@perches.com>
	<239fdd0c-9497-7275-4e74-d6ccd028e823@amd.com>
	<eeb51d36cd50f892630e0424cded20ad6bc47501.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <eeb51d36cd50f892630e0424cded20ad6bc47501.camel-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, "Hook, Gary" <ghook-5C7GfCeVMHo@public.gmane.org>, kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kbuild-all-JC7UmRfGjtg@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 05/08/2018 03:42 PM, Joe Perches wrote:
> On Tue, 2018-05-08 at 15:07 -0500, Gary R Hook wrote:
>> On 05/08/2018 01:48 PM, Joe Perches wrote:
>>> On Tue, 2018-05-08 at 12:08 -0500, Hook, Gary wrote:
>>>> On 5/7/2018 6:47 PM, kbuild test robot wrote:
>>>>>
>>>>> All error/warnings (new ones prefixed by >>):
>>>>>
>>>>>       In file included from include/linux/intel-iommu.h:32:0,
>>>>>                        from drivers/gpu/drm/i915/i915_drv.h:41,
>>>>>                        from drivers/gpu/drm/i915/i915_oa_bxt.c:31:
>>>>>       include/linux/iommu.h: In function 'iommu_debugfs_new_driver_dir':
>>>>>>> include/linux/iommu.h:706:8: error: parameter name omitted
>>>>>
>>>>>        struct dentry *iommu_debugfs_new_driver_dir(char *) {};
>>>>>               ^~~~~~
>>>>>       In file included from include/linux/intel-iommu.h:32:0,
>>>>>                        from drivers/gpu/drm/i915/i915_drv.h:41,
>>>>>                        from drivers/gpu/drm/i915/i915_oa_bxt.c:31:
>>>>>>> include/linux/iommu.h:706:8: warning: control reaches end of non-void function [-Wreturn-type]
>>>>>
>>>>>        struct dentry *iommu_debugfs_new_driver_dir(char *) {};
>>>>>               ^~~~~~
>>>>>
>>>>> vim +706 include/linux/iommu.h
>>>>>
>>>>>       700	
>>>>>       701	#ifdef CONFIG_IOMMU_DEBUGFS
>>>>>       702	void iommu_debugfs_setup(void);
>>>>>       703	struct dentry *iommu_debugfs_new_driver_dir(char *);
>>>>>       704	#else
>>>>>       705	static inline void iommu_debugfs_setup(void) {}
>>>>>     > 706	struct dentry *iommu_debugfs_new_driver_dir(char *) {};
>>>>>       707	#endif
>>>>>       708	
>>>>
>>>> I have no problems with adding parameter names. But
>>>> scripts/checkpatch.pl doesn't seem to check for this, nor require it.
>>>> Should checkpatch be updated?
>>>
>>> I'm pretty sure that's not feasible.
>>
>> Ugh. This is a definition, not a declaration. My bad. Which is likely
>> why I decided to apologize up front.
>>
>>> And when the compiler tells you you've stuffed up some
>>> syntactical bit, why should checkpatch duplicate the
>>> output error message too?
>>
>> Well, that's the point: neither the 4.8 nor 5.4 compiler complained
>> about this.
> 
> Perhaps because CONFIG_IOMMU_DEBUGFS was set in the .config
> for all the compilation previously performed?

Well, you'd think maybe so, but I forced a recompilation of that one 
file (i915_oa_bxt.c) and no complaint with 5.4. Weird.

Ah, well. Onward to patch version 6.

Thanks again.
