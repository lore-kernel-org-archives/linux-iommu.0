From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH 2/3] memory: tegra: add TLB cache line size
Date: Tue, 29 Sep 2015 21:11:50 +0900
Message-ID: <CAAFQd5BJq9EH_ojFosrVmn-PsV6mWu5-MCOOc6rAtQ07XPTdjw@mail.gmail.com>
References: <1443504379-31841-1-git-send-email-tfiga@chromium.org>
 <1443504379-31841-3-git-send-email-tfiga@chromium.org> <20150929094348.GF9460@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150929094348.GF9460-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Vince Hsu <vince.h-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Nicolas Iooss <nicolas.iooss_linux-oWGTIYur0i8@public.gmane.org>, Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 29, 2015 at 6:43 PM, Thierry Reding
<thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Tue, Sep 29, 2015 at 02:25:25PM +0900, Tomasz Figa wrote:
>> From: Vince Hsu <vince.h-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>
>> This patch adds SMMU line size to Tegra SoC data struct to enable SMMU
>> driver to use this knowledge in code added by further patch.
>
> I think the line size should either be added in the same patch that adds
> the feature which uses it, or the commit message should describe what
> purpose it will be used for. As it is this commit message leaves too
> many questions unanswered.

100% agreed. Anyway I just put this patch in this RFC quickly so that
the whole series can be applied and tested in somebody wants to do so.
I'll update commit message in next version.

>
>> Also add the missing TLB line number for Tegra124.
>>
>> Signed-off-by: Vince Hsu <vince.h-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> [tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org: Rebased, revised commit message.]
>> Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>
>> diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
>> index 21e7255..ff12487 100644
>> --- a/drivers/memory/tegra/tegra124.c
>> +++ b/drivers/memory/tegra/tegra124.c
>> @@ -1007,6 +1007,8 @@ static const struct tegra_smmu_soc tegra124_smmu_soc = {
>>       .num_swgroups = ARRAY_SIZE(tegra124_swgroups),
>>       .supports_round_robin_arbitration = true,
>>       .supports_request_limit = true,
>> +     .num_tlb_lines = 32,
>> +     .tlb_line_size = 32,
>>       .num_asids = 128,
>>  };
>
> Oh my... try to fix one platform and break another. Fortunately it seems
> like Tegra124 copes much better without TLB because I'm not seeing any
> buffer underruns or similar on Tegra124 without this fix.
>
> Anyway, this change is completely unrelated and fixes a regression (even
> though it might not be noticeable in many use-cases), so can you please
> split it out into a separate patch and add a
>
>         Fixes: 11cec15bf3fb ("iommu/tegra-smmu: Parameterize number of TLB lines")
>
> line to it? That patch went into v4.3-rc1 and it'd be nice to get this
> fix in before the final v4.3. Feel free to add my Acked-by/Reviewed-by
> as well.

Sounds good to me. We also have a patch adding locking around page
table get/put in map/unmap, which fixes a race between concurrent maps
and unmaps within the same page table. I'll send both soon.

Best regards,
Tomasz
