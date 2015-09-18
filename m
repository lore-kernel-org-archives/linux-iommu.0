From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v9 04/18] KVM: create kvm_irqfd.h
Date: Fri, 18 Sep 2015 15:35:30 +0000
Message-ID: <E959C4978C3B6342920538CF579893F00271D0FA@SHSMSX104.ccr.corp.intel.com>
References: <1442586596-5920-1-git-send-email-feng.wu@intel.com>
	<1442586596-5920-5-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1442586596-5920-5-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
To: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

> -----Original Message-----
> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> [mailto:iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Feng Wu
> Sent: Friday, September 18, 2015 10:30 PM
> To: pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org;
> mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
> Subject: [PATCH v9 04/18] KVM: create kvm_irqfd.h
> 
> From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> Move _irqfd_resampler and _irqfd struct declarations in a new
> public header: kvm_irqfd.h. They are respectively renamed into
> kvm_kernel_irqfd_resampler and kvm_kernel_irqfd. Those datatypes
> will be used by architecture specific code, in the context of
> IRQ bypass manager integration.
> 
> Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  include/linux/kvm_irqfd.h | 69 ++++++++++++++++++++++++++++++++++
>  virt/kvm/eventfd.c        | 95 ++++++++++++-----------------------------------
>  2 files changed, 92 insertions(+), 72 deletions(-)
>  create mode 100644 include/linux/kvm_irqfd.h
> 
> diff --git a/include/linux/kvm_irqfd.h b/include/linux/kvm_irqfd.h
> new file mode 100644
> index 0000000..f926b39
> --- /dev/null
> +++ b/include/linux/kvm_irqfd.h
> @@ -0,0 +1,69 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * irqfd: Allows an fd to be used to inject an interrupt to the guest
> + * Credit goes to Avi Kivity for the original idea.
> + */
> +
> +#ifndef __LINUX_KVM_IRQFD_H
> +#define __LINUX_KVM_IRQFD_H
> +
> +#include <linux/kvm_host.h>
> +#include <linux/poll.h>
> +
> +/*
> + * Resampling irqfds are a special variety of irqfds used to emulate
> + * level triggered interrupts.  The interrupt is asserted on eventfd
> + * trigger.  On acknowledgment through the irq ack notifier, the
> + * interrupt is de-asserted and userspace is notified through the
> + * resamplefd.  All resamplers on the same gsi are de-asserted
> + * together, so we don't need to track the state of each individual
> + * user.  We can also therefore share the same irq source ID.
> + */
> +struct kvm_kernel_irqfd_resampler {
> +	struct kvm *kvm;
> +	/*
> +	 * List of resampling struct _irqfd objects sharing this gsi.
> +	 * RCU list modified under kvm->irqfds.resampler_lock
> +	 */
> +	struct list_head list;
> +	struct kvm_irq_ack_notifier notifier;
> +	/*
> +	 * Entry in list of kvm->irqfd.resampler_list.  Use for sharing
> +	 * resamplers among irqfds on the same gsi.
> +	 * Accessed and modified under kvm->irqfds.resampler_lock
> +	 */
> +	struct list_head link;
> +};
> +
> +struct kvm_kernel_irqfd {
> +	/* Used for MSI fast-path */
> +	struct kvm *kvm;
> +	wait_queue_t wait;
> +	/* Update side is protected by irqfds.lock */
> +	struct kvm_kernel_irq_routing_entry irq_entry;
> +	seqcount_t irq_entry_sc;
> +	/* Used for level IRQ fast-path */
> +	int gsi;
> +	struct work_struct inject;
> +	/* The resampler used by this irqfd (resampler-only) */
> +	struct kvm_kernel_irqfd_resampler *resampler;
> +	/* Eventfd notified on resample (resampler-only) */
> +	struct eventfd_ctx *resamplefd;
> +	/* Entry in list of irqfds for a resampler (resampler-only) */
> +	struct list_head resampler_link;
> +	/* Used for setup/shutdown */
> +	struct eventfd_ctx *eventfd;
> +	struct list_head list;
> +	poll_table pt;
> +	struct work_struct shutdown;
> +};
> +
> +#endif /* __LINUX_KVM_IRQFD_H */
> diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
> index 9ff4193..647ffb8 100644
> --- a/virt/kvm/eventfd.c
> +++ b/virt/kvm/eventfd.c
> @@ -23,6 +23,7 @@
> 
>  #include <linux/kvm_host.h>
>  #include <linux/kvm.h>
> +#include <linux/kvm_irqfd.h>
>  #include <linux/workqueue.h>
>  #include <linux/syscalls.h>
>  #include <linux/wait.h>
> @@ -39,68 +40,14 @@
>  #include <kvm/iodev.h>
> 
>  #ifdef CONFIG_HAVE_KVM_IRQFD
> -/*
> - * --------------------------------------------------------------------
> - * irqfd: Allows an fd to be used to inject an interrupt to the guest
> - *
> - * Credit goes to Avi Kivity for the original idea.
> - * --------------------------------------------------------------------
> - */
> -
> -/*
> - * Resampling irqfds are a special variety of irqfds used to emulate
> - * level triggered interrupts.  The interrupt is asserted on eventfd
> - * trigger.  On acknowledgement through the irq ack notifier, the
> - * interrupt is de-asserted and userspace is notified through the
> - * resamplefd.  All resamplers on the same gsi are de-asserted
> - * together, so we don't need to track the state of each individual
> - * user.  We can also therefore share the same irq source ID.
> - */
> -struct _irqfd_resampler {
> -	struct kvm *kvm;
> -	/*
> -	 * List of resampling struct _irqfd objects sharing this gsi.
> -	 * RCU list modified under kvm->irqfds.resampler_lock
> -	 */
> -	struct list_head list;
> -	struct kvm_irq_ack_notifier notifier;
> -	/*
> -	 * Entry in list of kvm->irqfd.resampler_list.  Use for sharing
> -	 * resamplers among irqfds on the same gsi.
> -	 * Accessed and modified under kvm->irqfds.resampler_lock
> -	 */
> -	struct list_head link;
> -};
> -
> -struct _irqfd {
> -	/* Used for MSI fast-path */
> -	struct kvm *kvm;
> -	wait_queue_t wait;
> -	/* Update side is protected by irqfds.lock */
> -	struct kvm_kernel_irq_routing_entry irq_entry;
> -	seqcount_t irq_entry_sc;
> -	/* Used for level IRQ fast-path */
> -	int gsi;
> -	struct work_struct inject;
> -	/* The resampler used by this irqfd (resampler-only) */
> -	struct _irqfd_resampler *resampler;
> -	/* Eventfd notified on resample (resampler-only) */
> -	struct eventfd_ctx *resamplefd;
> -	/* Entry in list of irqfds for a resampler (resampler-only) */
> -	struct list_head resampler_link;
> -	/* Used for setup/shutdown */
> -	struct eventfd_ctx *eventfd;
> -	struct list_head list;
> -	poll_table pt;
> -	struct work_struct shutdown;
> -};
> 
>  static struct workqueue_struct *irqfd_cleanup_wq;
> 
>  static void
>  irqfd_inject(struct work_struct *work)
>  {
> -	struct _irqfd *irqfd = container_of(work, struct _irqfd, inject);
> +	struct kvm_kernel_irqfd *irqfd =
> +		container_of(work, struct kvm_kernel_irqfd, inject);
>  	struct kvm *kvm = irqfd->kvm;
> 
>  	if (!irqfd->resampler) {
> @@ -121,12 +68,13 @@ irqfd_inject(struct work_struct *work)
>  static void
>  irqfd_resampler_ack(struct kvm_irq_ack_notifier *kian)
>  {
> -	struct _irqfd_resampler *resampler;
> +	struct kvm_kernel_irqfd_resampler *resampler;
>  	struct kvm *kvm;
> -	struct _irqfd *irqfd;
> +	struct kvm_kernel_irqfd *irqfd;
>  	int idx;
> 
> -	resampler = container_of(kian, struct _irqfd_resampler, notifier);
> +	resampler = container_of(kian,
> +			struct kvm_kernel_irqfd_resampler, notifier);
>  	kvm = resampler->kvm;
> 
>  	kvm_set_irq(kvm, KVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID,
> @@ -141,9 +89,9 @@ irqfd_resampler_ack(struct kvm_irq_ack_notifier *kian)
>  }
> 
>  static void
> -irqfd_resampler_shutdown(struct _irqfd *irqfd)
> +irqfd_resampler_shutdown(struct kvm_kernel_irqfd *irqfd)
>  {
> -	struct _irqfd_resampler *resampler = irqfd->resampler;
> +	struct kvm_kernel_irqfd_resampler *resampler = irqfd->resampler;
>  	struct kvm *kvm = resampler->kvm;
> 
>  	mutex_lock(&kvm->irqfds.resampler_lock);
> @@ -168,7 +116,8 @@ irqfd_resampler_shutdown(struct _irqfd *irqfd)
>  static void
>  irqfd_shutdown(struct work_struct *work)
>  {
> -	struct _irqfd *irqfd = container_of(work, struct _irqfd, shutdown);
> +	struct kvm_kernel_irqfd *irqfd =
> +		container_of(work, struct kvm_kernel_irqfd, shutdown);
>  	u64 cnt;
> 
>  	/*
> @@ -198,7 +147,7 @@ irqfd_shutdown(struct work_struct *work)
> 
>  /* assumes kvm->irqfds.lock is held */
>  static bool
> -irqfd_is_active(struct _irqfd *irqfd)
> +irqfd_is_active(struct kvm_kernel_irqfd *irqfd)
>  {
>  	return list_empty(&irqfd->list) ? false : true;
>  }
> @@ -209,7 +158,7 @@ irqfd_is_active(struct _irqfd *irqfd)
>   * assumes kvm->irqfds.lock is held
>   */
>  static void
> -irqfd_deactivate(struct _irqfd *irqfd)
> +irqfd_deactivate(struct kvm_kernel_irqfd *irqfd)
>  {
>  	BUG_ON(!irqfd_is_active(irqfd));
> 
> @@ -224,7 +173,8 @@ irqfd_deactivate(struct _irqfd *irqfd)
>  static int
>  irqfd_wakeup(wait_queue_t *wait, unsigned mode, int sync, void *key)
>  {
> -	struct _irqfd *irqfd = container_of(wait, struct _irqfd, wait);
> +	struct kvm_kernel_irqfd *irqfd =
> +		container_of(wait, struct kvm_kernel_irqfd, wait);
>  	unsigned long flags = (unsigned long)key;
>  	struct kvm_kernel_irq_routing_entry irq;
>  	struct kvm *kvm = irqfd->kvm;
> @@ -274,12 +224,13 @@ static void
>  irqfd_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh,
>  			poll_table *pt)
>  {
> -	struct _irqfd *irqfd = container_of(pt, struct _irqfd, pt);
> +	struct kvm_kernel_irqfd *irqfd =
> +		container_of(pt, struct kvm_kernel_irqfd, pt);
>  	add_wait_queue(wqh, &irqfd->wait);
>  }
> 
>  /* Must be called under irqfds.lock */
> -static void irqfd_update(struct kvm *kvm, struct _irqfd *irqfd)
> +static void irqfd_update(struct kvm *kvm, struct kvm_kernel_irqfd *irqfd)
>  {
>  	struct kvm_kernel_irq_routing_entry *e;
>  	struct kvm_kernel_irq_routing_entry entries[KVM_NR_IRQCHIPS];
> @@ -304,7 +255,7 @@ static void irqfd_update(struct kvm *kvm, struct _irqfd
> *irqfd)
>  static int
>  kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd *args)
>  {
> -	struct _irqfd *irqfd, *tmp;
> +	struct kvm_kernel_irqfd *irqfd, *tmp;
>  	struct fd f;
>  	struct eventfd_ctx *eventfd = NULL, *resamplefd = NULL;
>  	int ret;
> @@ -340,7 +291,7 @@ kvm_irqfd_assign(struct kvm *kvm, struct kvm_irqfd
> *args)
>  	irqfd->eventfd = eventfd;
> 
>  	if (args->flags & KVM_IRQFD_FLAG_RESAMPLE) {
> -		struct _irqfd_resampler *resampler;
> +		struct kvm_kernel_irqfd_resampler *resampler;
> 
>  		resamplefd = eventfd_ctx_fdget(args->resamplefd);
>  		if (IS_ERR(resamplefd)) {
> @@ -525,7 +476,7 @@ kvm_eventfd_init(struct kvm *kvm)
>  static int
>  kvm_irqfd_deassign(struct kvm *kvm, struct kvm_irqfd *args)
>  {
> -	struct _irqfd *irqfd, *tmp;
> +	struct kvm_kernel_irqfd *irqfd, *tmp;
>  	struct eventfd_ctx *eventfd;
> 
>  	eventfd = eventfd_ctx_fdget(args->fd);
> @@ -581,7 +532,7 @@ kvm_irqfd(struct kvm *kvm, struct kvm_irqfd *args)
>  void
>  kvm_irqfd_release(struct kvm *kvm)
>  {
> -	struct _irqfd *irqfd, *tmp;
> +	struct kvm_kernel_irqfd *irqfd, *tmp;
> 
>  	spin_lock_irq(&kvm->irqfds.lock);
> 
> @@ -604,7 +555,7 @@ kvm_irqfd_release(struct kvm *kvm)
>   */
>  void kvm_irq_routing_update(struct kvm *kvm)
>  {
> -	struct _irqfd *irqfd;
> +	struct kvm_kernel_irqfd *irqfd;
> 
>  	spin_lock_irq(&kvm->irqfds.lock);
> 
> --
> 2.1.0
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
