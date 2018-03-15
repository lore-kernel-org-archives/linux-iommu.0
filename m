From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 08/10] iommu/amd: drop the lock while allocating new irq
	remap table
Date: Thu, 15 Mar 2018 13:58:32 +0100
Message-ID: <20180315125832.kfxoqfnxdajeg2yl@8bytes.org>
References: <20180223222736.18542-1-bigeasy@linutronix.de>
	<20180223222736.18542-9-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180223222736.18542-9-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
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

On Fri, Feb 23, 2018 at 11:27:34PM +0100, Sebastian Andrzej Siewior wrote:
> The irq_remap_table is allocated while the iommu_table_lock is held with
> interrupts disabled. While this works it makes RT scream very loudly.
> >From looking at the call sites, all callers are in the early device
> initialisation (apic_bsp_setup(), pci_enable_device(),
> pci_enable_msi()) so make sense to drop the lock which also enables
> interrupts and try to allocate that memory with GFP_KERNEL instead
> GFP_ATOMIC.
> 
> Since during the allocation the iommu_table_lock is dropped, we need to
> recheck if table exists after the lock has been reacquired. I *think*
> that it is impossible that the "devid" entry appears in irq_lookup_table
> while the lock is dropped since the same device can only be probed once.
> It is more likely that another device added an `alias' entry. However I
> check for both cases, just to be sure.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

This looks like it conflicts with the x86/amd branch as well.
