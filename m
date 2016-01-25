From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: iommu/arm-smmu-v2 ASID/VMID calculation
Date: Mon, 25 Jan 2016 17:03:13 +0000
Message-ID: <20160125170312.GJ22927@arm.com>
References: <198F501C-8D30-4EB5-BC40-4F40BB75D40B@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <198F501C-8D30-4EB5-BC40-4F40BB75D40B-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Chalamarla, Tirumalesh" <Tirumalesh.Chalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 21, 2016 at 06:52:34PM +0000, Chalamarla, Tirumalesh wrote:
> Hi Will,

Hello,

> Current ASID/VMID calculation logic makes lot of assumption about internal TLB
> implementation of SMMU,

Not really. It makes assumptions that the hardware follows the architecture,
which is hardly unreasonable as a starting point.

> Systems like ThunderX have more than one smmu in the system and it can use same
> TLBs with more than one of them and expects ASID to be unique 

... but that's broken. If you built a system where the CPUs shared a TLB,
you would run into issues as well.

How does this work with things like arm_smmu_tlb_sync and the TLBGSTATUS
register?

> Current logic
> 
> #define ARM_SMMU_CB_ASID(cfg)           ((cfg)->cbndx)
> #define ARM_SMMU_CB_VMID(cfg)           ((cfg)->cbndx + 1)
> 
> 
> Can this be replaced by something like
> 
> 
> #define ARM_SMMU_CB_ASID(cfg, smmu)             (((smmu)->idx << (smmu)->asid_shift) | (cfg)->cbndx)
> #define ARM_SMMU_CB_VMID(cfg, smmu)             (((smmu)->idx << (smmu)->vmid_shift) | (cfg)->cbndx + 1)
> 
> 
> Idx and shift can be passed from device-tree.
> 
> 
> Please let me know if this is acceptable, I will prepare a proper patch
> and send to list.
> 
> 
> If this is not acceptable through an alternative suggestion.

If we're going to put something into the device-tree, then it should be
an erratum property describing the offset to be applied to ASID/VMIDs.
You also need to take care not to describe overlapping numberspaces.

How many context banks do you implement in each SMMU?

Will
