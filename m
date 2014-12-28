From: Oded Gabbay <oded.gabbay-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/2] Change order of linkage in kernel makefiles for amdkfd
Date: Sun, 28 Dec 2014 13:36:50 +0200
Message-ID: <549FEB52.4020103@amd.com>
References: <1419246435-7050-1-git-send-email-oded.gabbay@amd.com>
	<20141225132058.GA32005@mithrandir> <1621810.aTt9O4Ghzs@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1621810.aTt9O4Ghzs@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Dana Elifaz <Dana.Elifaz-5C7GfCeVMHo@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Alexander Deucher <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, =?windows-1252?Q?Christian_K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 12/26/2014 11:19 AM, Laurent Pinchart wrote:
> Hi Thierry,
>
> On Thursday 25 December 2014 14:20:59 Thierry Reding wrote:
>> On Mon, Dec 22, 2014 at 01:07:13PM +0200, Oded Gabbay wrote:
>>> This small patch-set, was created to solve the bug described at
>>> https://bugzilla.kernel.org/show_bug.cgi?id=89661 (Kernel panic when
>>> trying use amdkfd driver on Kaveri). It replaces the previous patch-set
>>> called [PATCH 0/3] Use workqueue for device init in amdkfd
>>> (http://lists.freedesktop.org/archives/dri-devel/2014-December/074401.html
>>> )
>>>
>>> That bug appears only when radeon, amdkfd and amd_iommu_v2 are compiled
>>> inside the kernel (not as modules). In that case, the correct loading
>>> order, as determined by the exported symbol used by each driver, is
>>> not enforced anymore and the kernel loads them based on who was linked
>>> first. That makes radeon load first, amdkfd second and amd_iommu_v2
>>> third.
>>>
>>> Because the initialization of a device in amdkfd is initiated by radeon,
>>> and can only be completed if amdkfd and amd_iommu_v2 were loaded and
>>> initialized, then in the case mentioned above, this initalization fails
>>> and there is a kernel panic as some pointers are not initialized but
>>> used nontheless.
>>>
>>> To solve this bug, this patch-set moves iommu/ before gpu/ in
>>> drivers/Makefile and also moves amdkfd/ before radeon/ in
>>> drivers/gpu/drm/Makefile.
>>>
>>> The rationale is that in general, AMD GPU devices are dependent on AMD
>>> IOMMU controller functionality to allow the GPU to access a process's
>>> virtual memory address space, without the need for pinning the memory.
>>> That's why it makes sense to initialize the iommu/ subsystem ahead of the
>>> gpu/ subsystem.
>>
>> I strongly object to this patch set. This makes assumptions about how
>> the build system influences probe order. That's bad because seemingly
>> unrelated changes could easily break this in the future.
>>
>> We already have ways to solve this kind of dependency (driver probe
>> deferral), and I think you should be using it to solve this particular
>> problem rather than some linking order hack.
>
> While I agree with you that probe deferral is the way to go, I believe linkage
> ordering can still be used as an optimization to avoid deferring probe in the
> most common cases. I'm thus not opposed to moving iommu/ earlier in link order
> (provided we can properly test for side effects, as the jump is pretty large),
> but not as a replacement for probe deferral.

My thoughts exactly. If this was some extreme use case, than it would be 
justified to solve it with probe deferral. But I think that for most common 
cases, GPU are dependent on IOMMU and *not* vice-versa.

BTW, my first try at solving this was to use probe deferral (using workqueue), 
but the feedback I got from Christian and Dave was that moving iommu/ linkage 
before gpu/ was a much more simpler solution.

In addition, Linus said he doesn't object to this "band-aid". See: 
https://lkml.org/lkml/2014/12/25/152

	Oded
>
>> Coincidentally there's a separate thread currently going on that deals
>> with IOMMUs and probe order. The solution being worked on is currently
>> somewhat ARM-specific, so adding a couple of folks for visibility. It
>> looks like we're going to need something more generic since this is a
>> problem that even the "big" architectures need to solve.
>
