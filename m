From: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
Subject: Re: amd-iommu: can't boot with amdgpu, AMD-Vi: Completion-Wait loop
	timed out
Date: Mon, 27 Mar 2017 06:23:09 -0600
Message-ID: <CAD8Lp46gi-n0_3ct=dFDUL3hQnUkuOMnLH-CVY3yefQHJ63u5Q@mail.gmail.com>
References: <CAD8Lp457TE1CnJ-DHnB6NB2LWxgA5K5K57Q6L7XcSHeYNpvARQ@mail.gmail.com>
	<CY4PR12MB16533C83151D6FCFC11ED457F7250@CY4PR12MB1653.namprd12.prod.outlook.com>
	<CAD8Lp47zjJvqxY3TMMAhjz3OnLR52CtsQh_PQFPmsEW-xHfDwg@mail.gmail.com>
	<CADnq5_Oyfm-BzU9YV_QLjm6HxtMwnJcFkfYtjmCWpuah35TFvA@mail.gmail.com>
	<20170321155725.GD29659@8bytes.org>
	<BN6PR12MB16526DD4A3B60DB4E20B9907F73D0@BN6PR12MB1652.namprd12.prod.outlook.com>
	<20170321161056.GE29659@8bytes.org>
	<BN6PR12MB16528AF8E5577E9ACB483212F73D0@BN6PR12MB1652.namprd12.prod.outlook.com>
	<20170321162532.GG29659@8bytes.org>
	<BN6PR12MB165268CA4C460215950409D5F73D0@BN6PR12MB1652.namprd12.prod.outlook.com>
	<20170322112242.GK29659@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170322112242.GK29659-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "Bridgman, John" <John.Bridgman-5C7GfCeVMHo@public.gmane.org>, Chris Chiu <chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Nath, Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Linux Upstreaming Team <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Thanks for looking into this. We confirm that this workaround avoids
the iommu log spam and that amdgpu appears to be working fine with it.

Daniel


On Wed, Mar 22, 2017 at 5:22 AM, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Mar 21, 2017 at 04:30:55PM +0000, Deucher, Alexander wrote:
>> > I am preparing a debug-patch that disables ATS for these GPUs so someone
>> > with such a chip can test it.
>>
>> Thanks Joerg.
>
> Here is a debug patch, using the hard hammer of disabling the use of ATS
> completly in the AMD IOMMU driver. If it fixes the issue I am going to
> write a more upstreamable version.
>
> But for now, please test if this fixes the issue.
>
> Thanks,
>
>         Joerg
>
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 98940d1..f019aa6 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -467,7 +467,7 @@ static int iommu_init_device(struct device *dev)
>                 struct amd_iommu *iommu;
>
>                 iommu = amd_iommu_rlookup_table[dev_data->devid];
> -               dev_data->iommu_v2 = iommu->is_iommu_v2;
> +               dev_data->iommu_v2 = false;
>         }
>
>         dev->archdata.iommu = dev_data;
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 6130278..41d0e64 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -171,7 +171,7 @@ int amd_iommus_present;
>
>  /* IOMMUs have a non-present cache? */
>  bool amd_iommu_np_cache __read_mostly;
> -bool amd_iommu_iotlb_sup __read_mostly = true;
> +bool amd_iommu_iotlb_sup __read_mostly = false;
>
>  u32 amd_iommu_max_pasid __read_mostly = ~0;
>
