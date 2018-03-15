From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 04/10] iommu/amd: split irq_lookup_table out of the
	amd_iommu_devtable_lock
Date: Thu, 15 Mar 2018 13:54:58 +0100
Message-ID: <20180315125458.7omh75bzkfyjwjla@8bytes.org>
References: <20180223222736.18542-1-bigeasy@linutronix.de>
	<20180223222736.18542-5-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180223222736.18542-5-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
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

On Fri, Feb 23, 2018 at 11:27:30PM +0100, Sebastian Andrzej Siewior wrote:
> The function get_irq_table() reads/writes irq_lookup_table while holding
> the amd_iommu_devtable_lock. It also modifies
> amd_iommu_dev_table[].data[2].
> set_dte_entry() is using amd_iommu_dev_table[].data[0|1] (under the
> domain->lock) so it should be okay. The access to the iommu is
> serialized with its own (iommu's) lock.
> 
> So split out get_irq_table() out of amd_iommu_devtable_lock's lock. The
> new lock is a raw_spin_lock because modify_irte_ga() is called while
> desc->lock is held (which is raw).
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

This patch likely conflicts with changes already in the iommu-tree, as
it contains a patch splitting the get_irq_table() function. Can
you rebase your series against the x86/amd branch?


Thanks,

	Joerg
