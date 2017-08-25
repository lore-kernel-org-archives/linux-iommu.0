From: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 0/3] SMMUv3 CMD_SYNC optimisation
Date: Fri, 25 Aug 2017 00:44:48 -0400
Message-ID: <16bf571e-4582-21af-c633-900bed400d2d@codeaurora.org>
References: <cover.1503075486.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1503075486.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 8/18/2017 1:33 PM, Robin Murphy wrote:
> Hi all,
> 
> Waiting for the command queue to drain for CMD_SYNC completion is likely
> a contention hotspot on high-core-count systems. If the SMMU is coherent
> and supports MSIs, though, we can use this cool feature (as suggested by
> the architecture, no less) to make syncs effectively non-blocking for
> anyone other than the caller.
> 
> I don't have any hardware that supports MSIs, but this has at least
> passed muster on the Fast Model with cache modelling enabled - I'm hoping
> the Qualcomm machines have the appropriate configuration to actually test
> how well it works in reality. If it is worthwhile, I do have most of a
> plan for how we can do something similar in the non-MSI polling case (it's
> mostly a problem of handling the queue-wrapping edge cases correctly).

I tested this on QDF2400 hardware which supports MSI as a CMD_SYNC
completion signal. As with Thunder's "performance optimization" series,
I evaluated the patches using FIO with 4 NVME drives connected to a
single SMMU. Here's how they compared:

FIO - 512k blocksize / io-depth 32 / 1 thread per drive
  Baseline 4.13-rc1 w/SMMU enabled: 25% of SMMU bypass performance
  Baseline + Thunder Patch 1      : 28%
  Baseline + CMD_SYNC Optimization: 36%
  Baseline + Thunder Patches 2-5  : 86%
  Baseline + Thunder Patches 1-5  : 100% [!!]

Seems like it would probably be worthwhile to implement this for the
non-MSI case also. Let me know if there are other workloads you're
particularly interested in, and I'll try to get those tested too.

-Nate
> 
> Robin.
> 
> 
> Robin Murphy (3):
>    iommu/arm-smmu-v3: Specialise CMD_SYNC handling
>    iommu/arm-smmu-v3: Forget about cmdq-sync interrupt
>    iommu/arm-smmu-v3: Utilise CMD_SYNC MSI feature
> 
>   drivers/iommu/arm-smmu-v3.c | 117 +++++++++++++++++++++++++++++---------------
>   1 file changed, 77 insertions(+), 40 deletions(-)
> 

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
