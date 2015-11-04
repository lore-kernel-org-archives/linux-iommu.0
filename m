From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: Question about arm smmu
Date: Wed, 4 Nov 2015 14:43:08 +0000
Message-ID: <20151104144308.GQ5405@arm.com>
References: <20151104134439.GA4022@linux-4gyl.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151104134439.GA4022-12w76u+6CWdQVMFFLWfSwA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Peng Fan <van.freenix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 04, 2015 at 09:44:40PM +0800, Peng Fan wrote:
> Hi Will,

Hello,

> I am trying to enable SMMU(mmu500) on an platform.
> My platform support only 32 SIDs, but it have more than 100 masters.
> So I need to let different masters share one SID. I read current
> arm-smmu.c, but it needs each master has unique SID. Do you have
> some suggestions about how to let different masters sharing one
> SID?

We can achieve that using iommu_groups, but then we need a way to
describe those groups in the device-tree, as opposed to putting
each device into its own group like we do at present. Robin (CC'd) had
some work-in-progress for this, iirc.

> On my platform, SID can be dynamically programmed. So I can program
> DMA0 and DMA1 using one SID, saying 0x5. But I do not have a good
> idea how to support this use case in arm-smmu.c driver.

I think we've have the firmware allocating the SIDs, then describing
the grouping to Linux in the device-tree.

Will
