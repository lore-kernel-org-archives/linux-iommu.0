From: "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 1/6] iommu: add generic boot option iommu.dma_mode
Date: Tue, 23 Apr 2019 10:45:37 +0800
Message-ID: <5CBE7C51.8070002@huawei.com>
References: <20190409125308.18304-1-thunder.leizhen@huawei.com>
	<20190409125308.18304-2-thunder.leizhen@huawei.com>
	<20190412111649.GK4518@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190412111649.GK4518-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-ia64 <linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sebastian Ott <sebott-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, linux-doc <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Heiko Carstens <heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, "H . Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, linux-s390 <linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, x86 <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linuxppc-dev <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel <linux-kernel-fy+rA21nqHI@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 2019/4/12 19:16, Joerg Roedel wrote:
> On Tue, Apr 09, 2019 at 08:53:03PM +0800, Zhen Lei wrote:
>> +static int __init iommu_dma_mode_setup(char *str)
>> +{
>> +	if (!str)
>> +		goto fail;
>> +
>> +	if (!strncmp(str, "passthrough", 11))
>> +		iommu_default_dma_mode = IOMMU_DMA_MODE_PASSTHROUGH;
>> +	else if (!strncmp(str, "lazy", 4))
>> +		iommu_default_dma_mode = IOMMU_DMA_MODE_LAZY;
>> +	else if (!strncmp(str, "strict", 6))
>> +		iommu_default_dma_mode = IOMMU_DMA_MODE_STRICT;
>> +	else
>> +		goto fail;
>> +
>> +	pr_info("Force dma mode to be %d\n", iommu_default_dma_mode);
> 
> Printing a number is not very desriptive or helpful to the user. Please
> print the name of the mode instead.

OK, thanks. I have given up adding iommu.dma_mode boot option according
to Robin and Will's suggestion. So these codes will be removed in v6.

> 
> 
> Regards,
> 
> 	Joerg
> 
> .
> 

-- 
Thanks!
BestRegards
