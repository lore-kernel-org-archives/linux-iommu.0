From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC][PATCHv3+ 1/2] driver/core: Add of_iommu_attach()
Date: Fri, 8 Nov 2013 14:14:49 +0100
Message-ID: <20131108.151449.1092512147495774962.hdoyu@nvidia.com>
References: <52729912.9050800@wwwdotorg.org><20131101084909.5ed79987aa3aeb13b14e3f08@nvidia.com><20131106160623.2cb72f91cd071e555d0d4b9a@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131106160623.2cb72f91cd071e555d0d4b9a-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Stephen,

Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote @ Wed, 6 Nov 2013 15:06:23 +0100:

> Experimentally I have implemented "of_iommu_attach()" called from
> drvier/core to control the order of device instanciation.
> 
> In the Tegra SMMU PATCHv3, we've discussed how to control the order of
> device instanciation. Thierry/Stephen proposed to insert a hook in
> driver/core to control this order, depending on whether an iommu
> device is ready or not."of_iommu_attach()" is implement for that
> purpose now. Along with this patch, I attached DT part of modication
> to this mail. I used the same iommu bindings which arm,smmu uses.
> 
> [RFC][PATCHv3+ 2/2] ARM: DT: tegra30: iommu: Add "stream-id-cells"/"mmu-masters"
> 
> "#stream-id-cells" is used to identify whether a device is IOMMU'able
> or not. If a device is IOMMU'able, we'll defer to instanciate that
> device till an iommu device is instanciated/ready. Once an iommu device
> is instanciated, "dev->bus->iommu_ops" is set in the bus. After an
> iommu device is instanciated, those defered devices are instanciated
> as IOMMU'able with help of the iommu driver via iommu_ops->add_device().
> 
> We don't call bus_set_iommu() until an iommu device is instanciated
> because we need to support 2 kind of IOMMU drivers, SMMU and GART so
> that this bus_set_iommu() needs to be defered till an iommu device is
> instanciated. So the single image can support 2 iommu drivers at once.
> 
> With this patch, the following HACK patches in v3[1] are not needed
> anymore.
> 
>   patch 1: [HACK] of: dev_node has struct device pointer
>   patch 2: [HACK] ARM: tegra: Populate AHB/IOMMU earlier than others
>   patch 3: [HACK] amba: Move AHB to core_initcall
>   patch 4: [HACK] iommu/tegra: smmu: Move IOMMU to core_initcall
> 
> Any comment would be really appreciated.

Have you had any chance to take a look at this one?

I plan to send version 4 of this series with the above design next
week. In v4, I use "mmu-masters" binding stolen from "arm,smmu" DT.
