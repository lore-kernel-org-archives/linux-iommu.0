From: Shaik Ameer Basha <shaik.samsung-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v12 00/31] iommu/exynos: Fixes and Enhancements of System
	MMU driver with DT
Date: Wed, 30 Apr 2014 10:20:05 +0530
Message-ID: <CAOD6ATrKumCcFFWFp7i7XLMssG23QV0FZ=3KqGCnnJt17Xmr1A@mail.gmail.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
	<26065037.GxQQuIURPg@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <26065037.GxQQuIURPg@wuerfel>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, sunil joshi <joshi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dave.Martin-5wv7dgnIgG8@public.gmane.org, Linux DeviceTree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Shaik Ameer Basha <shaik.ameer-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, supash.ramaswamy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 28, 2014 at 2:04 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Sunday 27 April 2014 13:07:32 Shaik Ameer Basha wrote:
>> The current exynos-iommu(System MMU) driver does not work autonomously
>> since it is lack of support for power management of peripheral blocks.
>> For example, MFC device driver must ensure that its System MMU is disabled
>> before MFC block is power-down not to invalidate IOTLB in the System MMU
>> when I/O memory mapping is changed. Because a System MMU resides in the
>> same H/W block, access to control registers of System MMU while the H/W
>> block is turned off must be prohibited.
>>
>> This set of changes solves the above problem with setting each System MMUs
>> as the parent of the device which owns the System MMU to receive the
>> information when the device is turned off or turned on.
>>
>> Another big change to the driver is the support for devicetree.
>> The bindings for System MMU is described in
>> Documentation/devicetree/bindings/arm/samsung/system-mmu.txt
>
> Sorry I've been absent from the review so far. Most of the patches
> seem entirely reasonable to me, but I'm worried about the DT binding
> aspect. We are going to see more systems shipping with IOMMUs now,
> and we are seeing an increasing number of submissions for 64-bit
> systems. We really have to work out what the DT representation for
> IOMMUs should look like in general before adding another ad-hod
> implementation that is private to one driver.

Hi Arnd,

No issues. Its good that finally you are here :)

I am going through the possibilities for new bindings that you
mentioned in the other thread.
    -- [PATCH v12 11/31] documentation: iommu: add binding document of
Exynos System MMU

Exynos IOMMU driver is pretty simple with only one exception, "some
devices are using multiple IOMMUs".

>From starting (of this patch set), we were trying to fix three major issues.
[1] How to control the probing order of required IOMMU(s) for a given
device and a device itself.
[2] Handling multiple IOMMUs for one device.
[3] Generic DT bindings to link Device and IOMMUs.

I have gone through the implementation of Tegra SMMU driver by "Hiroshi Doyu"
    -- [PATCHv7 00/12] Unifying SMMU driver among Tegra SoCs
[https://lkml.org/lkml/2013/12/12/74]

For the first point [1],
------------------------------
Tegra implementation tries to fix this issue with these two patches
    -- iommu/of: check if dependee iommu is ready or not
[http://patchwork.ozlabs.org/patch/300560/]
    -- driver/core: populate devices in order for IOMMUs
[http://patchwork.ozlabs.org/patch/300558/]
I can follow this driver if this approach is acceptable.

For the second point [2]
----------------------------------
Currently we are handling this issue by providing same mapping for all
IOMMUs linked to the same device.
And current Exynos drivers doesn't have any special implementation to
handle this case differently.

I thought of understanding how Tegra SMMU driver is handling this case.
Frankly speaking, I didn't understand how its done there.

For the third point [3]
-------------------------------
As Tegra SMMU driver is inline with the discussion in other thread, we
can follow the same bindings, unless
the discussion takes us in the other direction.

"KyongHo Cho" is the author for this driver and hope he has more inputs.

Regards,
Shaik



>
>         Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
