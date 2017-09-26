From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 2/4] iommu/tegra: gart: Check whether page is already
 mapped
Date: Tue, 26 Sep 2017 19:57:30 +0300
Message-ID: <c479f9fb-9510-3c6c-ed94-e6b5415f2ee0@gmail.com>
References: <cover.1499270277.git.digetx@gmail.com>
 <a19ba1ca835aa2526d2c0492e6b0d0b35889596a.1499270277.git.digetx@gmail.com>
 <20170926110636.GA23108@ulmo>
 <e59eb818-4edf-f3a2-947a-bc21507b0b85@gmail.com>
 <20170926160727.GB12426@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170926160727.GB12426@ulmo>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 26.09.2017 19:07, Thierry Reding wrote:
> On Tue, Sep 26, 2017 at 04:49:52PM +0300, Dmitry Osipenko wrote:
>> On 26.09.2017 14:06, Thierry Reding wrote:
>>> On Wed, Jul 05, 2017 at 07:29:46PM +0300, Dmitry Osipenko wrote:
>>>> Due to a bug, multiple devices may try to map the same IOVA region. We can
>>>> catch that case by checking that 'VALID' bit of the GART's page entry is
>>>> unset prior to mapping of the page.
>>>
>>> Due to what bug? Sounds to me like access to the GART should be
>>> exclusive, so that only a single driver can ever access it.
>>>
>>
>> Actually, there are a lot of peripherals behind the GART. But yes, probably we
>> would use it exclusively for the GPU allocations.
>>
>> In a case of the GPU allocations there could be a bug in the allocation code
>> (drm_mm_scan) that would cause re-mapping of the already mapped pages, we would
>> be able to catch such a bug.
> 
> Sounds to me like something that should be opt-in. Given that we could
> potentially map a lot of memory, the additional read seems like it could
> incur a significant performance penalty.
> 
> How about protecting this by some Kconfig symbol (or debug module
> parameter) and adding a WARN instead of failing the mapping operation?
> 
> The reason is that we really should be using the GART from a single
> driver because it is a shared memory region. To avoid drivers from
> treading on each others' feet the allocations must be managed by some
> central entity. So either something like DMA API should manage it, or
> we hardwire it to Tegra DRM explicitly.
> 
> And if a central allocator is responsible for all mappings through the
> GART, then we should assume that it isn't buggy, and therefore the extra
> check of the PTEs should not be needed in most cases, hence we can get a
> performance boost by disabling the check by default.
> 
> Of course if there is not much performance impact, maybe it is okay to
> keep it always enabled.
> 

I had a similar thought about making this checking and the "proper" unmapping
optional, but decided that it is not very worthy to implement it now because
caching of mappings helps to get rid of all IOVA expenses. The "checking" is
nearly "free" in terms of performance, it's the unmapping that causes measurable
performance impact. Maybe the improper unmapping was made intentionally for
better performance.

Given that you've made suggestion to make the checking optional, I'm going to
update this patchset, adding a new "debug" Kconfig option.

-- 
Dmitry
