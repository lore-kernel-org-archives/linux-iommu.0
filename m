From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Fix for ThunderX erratum #27704
Date: Thu, 19 Jan 2017 16:16:16 +0000
Message-ID: <20170119161615.GH31594@arm.com>
References: <1484550967-6328-1-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1484550967-6328-1-git-send-email-tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, Prasun.Kapoor-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Sunil.Goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, Geethasowjanya.Akula-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linu.Cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 16, 2017 at 08:16:07AM +0100, Tomasz Nowicki wrote:
> The goal of erratum #27704 workaround was to make sure that ASIDs and VMIDs
> are unique across all SMMU instances on affected Cavium systems.
> 
> Currently, the workaround code partitions ASIDs and VMIDs by increasing
> global cavium_smmu_context_count which in turn becomes the base ASID and VMID
> value for the given SMMU instance upon the context bank initialization.
> 
> For systems with multiple SMMU instances this approach implies the risk
> of crossing 8-bit ASID, like for 1-socket CN88xx capable of 4 SMMUv2,
> 128 context banks each:
> SMMU_0 (0-127 ASID RANGE)
> SMMU_1 (127-255 ASID RANGE)
> SMMU_2 (256-383 ASID RANGE) <--- crossing 8-bit ASID
> SMMU_3 (384-511 ASID RANGE) <--- crossing 8-bit ASID
> 
> Since now we use 8-bit ASID (SMMU_CBn_TCR2.AS = 0) we effectively misconfigure
> ASID[15:8] bits of SMMU_CBn_TTBRm register for SMMU_2/3. Moreover, we still
> assume non-zero ASID[15:8] bits upon context invalidation. In the end,
> except SMMU_0/1 devices all other devices under other SMMUs will fail on guest
> power off/on. Since we try to invalidate TLB with 16-bit ASID but we actually
> have 8-bit zero padded 16-bit entry.
> 
> This patch adds 16-bit ASID support for stage-1 AArch64 contexts so that
> we use ASIDs consistently for all SMMU instances.
> 
> Signed-off-by: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
> Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Reviewed-by: Tirumalesh Chalamarla  <Tirumalesh.Chalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 3 +++
>  1 file changed, 3 insertions(+)

Thanks, queued for 4.11.

Will
