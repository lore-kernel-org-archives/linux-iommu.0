From: "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v4 0/6] normalize IOMMU dma mode boot options
Date: Mon, 8 Apr 2019 11:16:19 +0800
Message-ID: <5CAABD03.9000301@huawei.com>
References: <20190407124147.13576-1-thunder.leizhen@huawei.com>
	<b20fd8a6-88ce-7d26-8eb0-ed9f095988a6@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <b20fd8a6-88ce-7d26-8eb0-ed9f095988a6-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Robin
	Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg
	Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sebastian Ott <sebott-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Gerald
	Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Heiko Carstens <heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, "H . Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm+QpoMPSDrYp@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 2019/4/8 9:14, Hanjun Guo wrote:
> Hi Zhen,
> 
> On 2019/4/7 20:41, Zhen Lei wrote:
>> As Robin Murphy's suggestion:
>> "It's also not necessarily obvious to the user how this interacts with
>> IOMMU_DEFAULT_PASSTHROUGH, so if we really do go down this route, maybe it
>> would be better to refactor the whole lot into a single selection of something
>> like IOMMU_DEFAULT_MODE anyway."
>>
>> In this version, I tried to normalize the IOMMU dma mode boot options for all
>> ARCHs. When IOMMU is enabled, there are 3 dma modes: paasthrough(bypass),
>> lazy(mapping but defer the IOTLB invalidation), strict. But currently each
>> ARCHs defined their private boot options, different with each other. For
>> example, to enable/disable "passthrough", ARM64 use iommu.passthrough=1/0,
>> X86 use iommu=pt/nopt, PPC/POWERNV use iommu=nobypass.
>>
>>
>> Zhen Lei (6):
>>   iommu: use iommu.dma_mode to replace iommu.passthrough and
>>     iommu.strict
>>   iommu: keep dma mode build options consistent with cmdline options
>>   iommu: add iommu_default_dma_mode_get() helper
>>   s390/pci: use common boot option iommu.dma_mode
>>   powernv/iommu: use common boot option iommu.dma_mode
>>   x86/iommu: use common boot option iommu.dma_mode
> 
> This will break systems using boot options as now, and I think
> this is unacceptable. If you want to do so, just introduce iommu.dma_mode
> on top of those iommu boot options with dma mode boot options unchanged,
> and iommu.dma_mode is for all archs but compatible with them.

I just changed the boot options name, but keep the function no change. I added
all related maintainers/supporters in the "to=" list, maybe we can disuss this.
Should I add some "obsoleted" warnings for old options and keep them for a while?
But I think this kind of thing is best done in one go.

> 
> Thanks
> Hanjun
> 
> 
> .
> 

-- 
Thanks!
BestRegards
