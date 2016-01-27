From: Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: RE: [PATCH 1/4] iommu/arm-smmu: Treat all device transactions as
	unprivileged
Date: Wed, 27 Jan 2016 06:00:11 +0000
Message-ID: <39063E8F96E11742B35A201CC5D095B7BAE0C0@SJEXCHMB10.corp.ad.broadcom.com>
References: <cover.1453830752.git.robin.murphy@arm.com>
	<6c5730256333b8d941f2c0371c1ab709a454938c.1453830752.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6c5730256333b8d941f2c0371c1ab709a454938c.1453830752.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

> -----Original Message-----
> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Robin Murphy
> Sent: 26 January 2016 23:37
> To: will.deacon-5wv7dgnIgG8@public.gmane.org
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org
> Subject: [PATCH 1/4] iommu/arm-smmu: Treat all device transactions as
> unprivileged
> 
> The IOMMU API has no concept of privilege so assumes all devices and
> mappings are equal, and indeed most non-CPU master devices on an AMBA
> interconnect make little use of the attribute bits on the bus thus by default
> perform unprivileged data accesses.
> 
> Some devices, however, believe themselves more equal than others, such as
> programmable DMA controllers whose 'master' thread issues bus transactions
> marked as privileged instruction fetches, while the data accesses of its channel
> threads (under the control of Linux, at least) are marked as unprivileged. This
> poses a problem for implementing the DMA API on an IOMMU conforming to
> ARM VMSAv8, under which a page that is unprivileged-writeable is also implicitly
> privileged-execute-never.
> Given that, there is no one set of attributes with which iommu_map() can
> implement, say, dma_alloc_coherent() that will allow every possible type of
> access without something running into unexecepted permission faults.
> 
> Fortunately the SMMU architecture provides a means to mitigate such issues by
> overriding the incoming attributes of a transaction; make use of that to strip the
> privileged/unprivileged status off incoming transactions, leaving just the
> instruction/data dichotomy which the IOMMU API does at least understand;
> Four states good, two states better.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c index
> 59ee4b8..1f9093d 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -167,6 +167,9 @@
>  #define S2CR_TYPE_BYPASS		(1 << S2CR_TYPE_SHIFT)
>  #define S2CR_TYPE_FAULT			(2 << S2CR_TYPE_SHIFT)
> 
> +#define S2CR_PRIVCFG_SHIFT		24
> +#define S2CR_PRIVCFG_UNPRIV		(2 << S2CR_PRIVCFG_SHIFT)
> +
>  /* Context bank attribute registers */
>  #define ARM_SMMU_GR1_CBAR(n)		(0x0 + ((n) << 2))
>  #define CBAR_VMID_SHIFT			0
> @@ -1083,7 +1086,7 @@ static int arm_smmu_domain_add_master(struct
> arm_smmu_domain *smmu_domain,
>  		u32 idx, s2cr;
> 
>  		idx = cfg->smrs ? cfg->smrs[i].idx : cfg->streamids[i];
> -		s2cr = S2CR_TYPE_TRANS |
> +		s2cr = S2CR_TYPE_TRANS | S2CR_PRIVCFG_UNPRIV |
>  		       (smmu_domain->cfg.cbndx << S2CR_CBNDX_SHIFT);

Treating all MMU master access as unprivileged sounds more
conservative. Alternate approach would be to treat instruction
fetches as data reads.

Regards,
Anup
