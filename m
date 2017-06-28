From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] iommu/iova: don't disable preempt around
	this_cpu_ptr()
Date: Wed, 28 Jun 2017 11:22:05 +0200
Message-ID: <20170628092205.GB30388@8bytes.org>
References: <20170627161648.30302-1-bigeasy@linutronix.de>
	<20170627161648.30302-2-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170627161648.30302-2-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
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
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 27, 2017 at 06:16:47PM +0200, Sebastian Andrzej Siewior wrote:
> Commit 583248e6620a ("iommu/iova: Disable preemption around use of
> this_cpu_ptr()") disables preemption while accessing a per-CPU variable.
> This does keep lockdep quiet. However I don't see the point why it is
> bad if we get migrated after its access to another CPU.
> __iova_rcache_insert() and __iova_rcache_get() immediately locks the
> variable after obtaining it - before accessing its members.
> _If_ we get migrated away after retrieving the address of cpu_rcache
> before taking the lock then the *other* task on the same CPU will
> retrieve the same address of cpu_rcache and will spin on the lock.
> 
> alloc_iova_fast() disables preemption while invoking
> free_cpu_cached_iovas() on each CPU. The function itself uses
> per_cpu_ptr() which does not trigger a warning (like this_cpu_ptr()
> does). It _could_ make sense to use get_online_cpus() instead but the we
> have a hotplug notifier for CPU down (and none for up) so we are good.

Does that really matter? The spin_lock disables irqs and thus avoids
preemption too. We also can't get rid of the irqsave lock here because
these locks are taken in the dma-api path which is used from interrupt
context.



	Joerg
