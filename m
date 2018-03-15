From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: iommu/amd: lock splitting & GFP_KERNEL allocation
Date: Thu, 15 Mar 2018 14:01:45 +0100
Message-ID: <20180315130144.v25fugc2kfglptby@8bytes.org>
References: <20180223222736.18542-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180223222736.18542-1-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Sebastian,

On Fri, Feb 23, 2018 at 11:27:26PM +0100, Sebastian Andrzej Siewior wrote:
> I have no idea why but suddenly my A10 box complained loudly about
> locking and memory allocations within the iommu code under RT. Looking
> at the code it has been like this for a longer time so the iommu must
> have appeared recently (well there was a bios upgrade due to other
> issues so it might have enabled it).
> 
> The goal here is to make the memory allocation in get_irq_table() not
> with disabled interrupts and having as little raw_spin_lock as possible
> while having them if the caller is also holding one (like desc->lock
> during IRQ-affinity changes).
> 
> The patches were boot tested on an AMD EPYC 7601.

Thanks for these patches, I really like the cleanups and the improved
locking. Please rebase against x86/amd in the iommu branch and address
the other comment I have, then I put them into my tree.


Thanks,

	Joerg
