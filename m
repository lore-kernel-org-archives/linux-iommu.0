From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: Device address specific mapping of arm,mmu-500
Date: Tue, 30 May 2017 16:14:37 +0100
Message-ID: <20170530151437.GC23067@arm.com>
References: <1b79efe2-6835-7a7a-f5ad-361391a7b967@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1b79efe2-6835-7a7a-f5ad-361391a7b967-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ray Jui <ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, May 29, 2017 at 06:18:45PM -0700, Ray Jui wrote:
> I'm writing to check with you to see if the latest arm-smmu.c driver in
> v4.12-rc Linux for smmu-500 can support mapping that is only specific to
> a particular physical address range while leave the rest still to be
> handled by the client device. I believe this can already be supported by
> the device tree binding of the generic IOMMU framework; however, it is
> not clear to me whether or not the arm-smmu.c driver can support it.
> 
> To give you some background information:
> 
> We have a SoC that has PCIe root complex that has a build-in logic block
> to forward MSI writes to ARM GICv3 ITS. Unfortunately, this logic block
> has a HW bug that causes the MSI writes not parsed properly and can
> potentially corrupt data in the internal FIFO. A workaround is to have
> ARM MMU-500 takes care of all inbound transactions. I found that is
> working after hooking up our PCIe root complex to MMU-500; however, even
> with this optimized arm-smmu driver in v4.12, I'm still seeing a
> significant Ethernet throughput drop in both the TX and RX directions.
> The throughput drop is very significant at around 50% (but is already
> much improved compared to other prior kernel versions at 70~90%).

Did Robin's experiments help at all with this?

http://www.linux-arm.org/git?p=linux-rm.git;a=shortlog;h=refs/heads/iommu/perf

> One alternative is to only use MMU-500 for MSI writes towards
> GITS_TRANSLATER register in the GICv3, i.e., if I can define a specific
> region of physical address that I want MMU-500 to act on and leave the
> rest of inbound transactions to be handled directly by our PCIe
> controller, it can potentially work around the HW bug we have and at the
> same time achieve optimal throughput.

I don't think you can bypass the SMMU for MSIs unless you give them their
own StreamIDs, which is likely to break things horribly in the kernel. You
could try to create an identity mapping, but you'll still have the
translation overhead and you'd probably end up having to supply your own DMA
ops to manage the address space. I'm assuming that you need to prevent the
physical address of the ITS from being allocated as an IOVA?

> Any feedback from you is greatly appreciated!

Fix the hardware ;)

Will
