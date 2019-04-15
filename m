From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 0/7] Add PCI ATS support to Arm SMMUv3
Date: Mon, 15 Apr 2019 14:20:54 +0100
Message-ID: <20190415132054.GA15023@fuggles.cambridge.arm.com>
References: <20190409165245.26500-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190409165245.26500-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: zhongmiao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, okaya-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Jean-Philippe,

On Tue, Apr 09, 2019 at 05:52:38PM +0100, Jean-Philippe Brucker wrote:
> This series enables PCI ATS in SMMUv3. Changes since v1 [1]:
> 
> * Simplify the SMMU structures (patches 2-4 are new).
> 
> * Don't enable ATS for devices that are attached to a bypass domain,
>   because in that case a translation request would cause F_BAD_ATS_TREQ.
>   Translation requests in that case cause F_BAD_ATS_TREQ. Enable ATS in
>   attach_dev() rather than add_device().
> 
> * Enable ATS for stage-1 and stage-2 STEs alike. There is no benefit to
>   disabling ATS for stage-2 domains.
> 
> [1] https://www.spinics.net/lists/arm-kernel/msg714628.html
> 
> Jean-Philippe Brucker (7):
>   ACPI/IORT: Check ATS capability in root complex nodes
>   iommu/arm-smmu-v3: Rename arm_smmu_master_data to arm_smmu_master
>   iommu/arm-smmu-v3: Store SteamIDs in master
>   iommu/arm-smmu-v3: Add a master->domain pointer
>   iommu/arm-smmu-v3: Link domains and devices
>   iommu/arm-smmu-v3: Add support for PCI ATS
>   iommu/arm-smmu-v3: Disable tagged pointers

Patches 2, 3, 4, 5 and 7 look fine to me. I've left some comments on the
other two.

Cheers,

Will
