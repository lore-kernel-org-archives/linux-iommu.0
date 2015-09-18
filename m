From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v9 01/18] virt: IRQ bypass manager
Date: Fri, 18 Sep 2015 15:34:39 +0000
Message-ID: <E959C4978C3B6342920538CF579893F00271D0C6@SHSMSX104.ccr.corp.intel.com>
References: <1442586596-5920-1-git-send-email-feng.wu@intel.com>
	<1442586596-5920-2-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1442586596-5920-2-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
> Subject: [PATCH v9 01/18] virt: IRQ bypass manager
> 
> From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> When a physical I/O device is assigned to a virtual machine through
> facilities like VFIO and KVM, the interrupt for the device generally
> bounces through the host system before being injected into the VM.
> However, hardware technologies exist that often allow the host to be
> bypassed for some of these scenarios.  Intel Posted Interrupts allow
> the specified physical edge interrupts to be directly injected into a
> guest when delivered to a physical processor while the vCPU is
> running.  ARM IRQ Forwarding allows forwarded physical interrupts to
> be directly deactivated by the guest.
> 
> The IRQ bypass manager here is meant to provide the shim to connect
> interrupt producers, generally the host physical device driver, with
> interrupt consumers, generally the hypervisor, in order to configure
> these bypass mechanism.  To do this, we base the connection on a
> shared, opaque token.  For KVM-VFIO this is expected to be an
> eventfd_ctx since this is the connection we already use to connect an
> eventfd to an irqfd on the in-kernel path.  When a producer and
> consumer with matching tokens is found, callbacks via both registered
> participants allow the bypass facilities to be automatically enabled.
> 
> Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Reviewed-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Tested-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Tested-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
> v4: All producer callbacks are optional, as with Intel PI, it's
>     possible for the producer to be blissfully unaware of the bypass.
> 
>  MAINTAINERS               |   7 ++
>  include/linux/irqbypass.h |  90 ++++++++++++++++
>  virt/lib/Kconfig          |   2 +
>  virt/lib/Makefile         |   1 +
>  virt/lib/irqbypass.c      | 257
> ++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 357 insertions(+)
>  create mode 100644 include/linux/irqbypass.h
>  create mode 100644 virt/lib/Kconfig
>  create mode 100644 virt/lib/Makefile
>  create mode 100644 virt/lib/irqbypass.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a9ae6c1..10c8b2f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10963,6 +10963,13 @@ L:	netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>  S:	Maintained
>  F:	drivers/net/ethernet/via/via-velocity.*
> 
> +VIRT LIB
> +M:	Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> +M:	Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> +L:	kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> +S:	Supported
> +F:	virt/lib/
> +
>  VIVID VIRTUAL VIDEO DRIVER
>  M:	Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
>  L:	linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> diff --git a/include/linux/irqbypass.h b/include/linux/irqbypass.h
> new file mode 100644
> index 0000000..1551b5b
> --- /dev/null
> +++ b/include/linux/irqbypass.h
> @@ -0,0 +1,90 @@
> +/*
> + * IRQ offload/bypass manager
> + *
> + * Copyright (C) 2015 Red Hat, Inc.
> + * Copyright (c) 2015 Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef IRQBYPASS_H
> +#define IRQBYPASS_H
> +
> +#include <linux/list.h>
> +
> +struct irq_bypass_consumer;
> +
> +/*
> + * Theory of operation
> + *
> + * The IRQ bypass manager is a simple set of lists and callbacks that allows
> + * IRQ producers (ex. physical interrupt sources) to be matched to IRQ
> + * consumers (ex. virtualization hardware that allows IRQ bypass or offload)
> + * via a shared token (ex. eventfd_ctx).  Producers and consumers register
> + * independently.  When a token match is found, the optional @stop callback
> + * will be called for each participant.  The pair will then be connected via
> + * the @add_* callbacks, and finally the optional @start callback will allow
> + * any final coordination.  When either participant is unregistered, the
> + * process is repeated using the @del_* callbacks in place of the @add_*
> + * callbacks.  Match tokens must be unique per producer/consumer, 1:N
> pairings
> + * are not supported.
> + */
> +
> +/**
> + * struct irq_bypass_producer - IRQ bypass producer definition
> + * @node: IRQ bypass manager private list management
> + * @token: opaque token to match between producer and consumer
> + * @irq: Linux IRQ number for the producer device
> + * @add_consumer: Connect the IRQ producer to an IRQ consumer (optional)
> + * @del_consumer: Disconnect the IRQ producer from an IRQ consumer
> (optional)
> + * @stop: Perform any quiesce operations necessary prior to add/del
> (optional)
> + * @start: Perform any startup operations necessary after add/del (optional)
> + *
> + * The IRQ bypass producer structure represents an interrupt source for
> + * participation in possible host bypass, for instance an interrupt vector
> + * for a physical device assigned to a VM.
> + */
> +struct irq_bypass_producer {
> +	struct list_head node;
> +	void *token;
> +	int irq;
> +	int (*add_consumer)(struct irq_bypass_producer *,
> +			    struct irq_bypass_consumer *);
> +	void (*del_consumer)(struct irq_bypass_producer *,
> +			     struct irq_bypass_consumer *);
> +	void (*stop)(struct irq_bypass_producer *);
> +	void (*start)(struct irq_bypass_producer *);
> +};
> +
> +/**
> + * struct irq_bypass_consumer - IRQ bypass consumer definition
> + * @node: IRQ bypass manager private list management
> + * @token: opaque token to match between producer and consumer
> + * @add_producer: Connect the IRQ consumer to an IRQ producer
> + * @del_producer: Disconnect the IRQ consumer from an IRQ producer
> + * @stop: Perform any quiesce operations necessary prior to add/del
> (optional)
> + * @start: Perform any startup operations necessary after add/del (optional)
> + *
> + * The IRQ bypass consumer structure represents an interrupt sink for
> + * participation in possible host bypass, for instance a hypervisor may
> + * support offloads to allow bypassing the host entirely or offload
> + * portions of the interrupt handling to the VM.
> + */
> +struct irq_bypass_consumer {
> +	struct list_head node;
> +	void *token;
> +	int (*add_producer)(struct irq_bypass_consumer *,
> +			    struct irq_bypass_producer *);
> +	void (*del_producer)(struct irq_bypass_consumer *,
> +			     struct irq_bypass_producer *);
> +	void (*stop)(struct irq_bypass_consumer *);
> +	void (*start)(struct irq_bypass_consumer *);
> +};
> +
> +int irq_bypass_register_producer(struct irq_bypass_producer *);
> +void irq_bypass_unregister_producer(struct irq_bypass_producer *);
> +int irq_bypass_register_consumer(struct irq_bypass_consumer *);
> +void irq_bypass_unregister_consumer(struct irq_bypass_consumer *);
> +
> +#endif /* IRQBYPASS_H */
> diff --git a/virt/lib/Kconfig b/virt/lib/Kconfig
> new file mode 100644
> index 0000000..89a414f
> --- /dev/null
> +++ b/virt/lib/Kconfig
> @@ -0,0 +1,2 @@
> +config IRQ_BYPASS_MANAGER
> +	tristate
> diff --git a/virt/lib/Makefile b/virt/lib/Makefile
> new file mode 100644
> index 0000000..901228d
> --- /dev/null
> +++ b/virt/lib/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_IRQ_BYPASS_MANAGER) += irqbypass.o
> diff --git a/virt/lib/irqbypass.c b/virt/lib/irqbypass.c
> new file mode 100644
> index 0000000..09a03b5
> --- /dev/null
> +++ b/virt/lib/irqbypass.c
> @@ -0,0 +1,257 @@
> +/*
> + * IRQ offload/bypass manager
> + *
> + * Copyright (C) 2015 Red Hat, Inc.
> + * Copyright (c) 2015 Linaro Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Various virtualization hardware acceleration techniques allow bypassing or
> + * offloading interrupts received from devices around the host kernel.
> Posted
> + * Interrupts on Intel VT-d systems can allow interrupts to be received
> + * directly by a virtual machine.  ARM IRQ Forwarding allows forwarded
> physical
> + * interrupts to be directly deactivated by the guest.  This manager allows
> + * interrupt producers and consumers to find each other to enable this sort of
> + * bypass.
> + */
> +
> +#include <linux/irqbypass.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("IRQ bypass manager utility module");
> +
> +static LIST_HEAD(producers);
> +static LIST_HEAD(consumers);
> +static DEFINE_MUTEX(lock);
> +
> +/* @lock must be held when calling connect */
> +static int __connect(struct irq_bypass_producer *prod,
> +		     struct irq_bypass_consumer *cons)
> +{
> +	int ret = 0;
> +
> +	if (prod->stop)
> +		prod->stop(prod);
> +	if (cons->stop)
> +		cons->stop(cons);
> +
> +	if (prod->add_consumer)
> +		ret = prod->add_consumer(prod, cons);
> +
> +	if (!ret) {
> +		ret = cons->add_producer(cons, prod);
> +		if (ret && prod->del_consumer)
> +			prod->del_consumer(prod, cons);
> +	}
> +
> +	if (cons->start)
> +		cons->start(cons);
> +	if (prod->start)
> +		prod->start(prod);
> +
> +	return ret;
> +}
> +
> +/* @lock must be held when calling disconnect */
> +static void __disconnect(struct irq_bypass_producer *prod,
> +			 struct irq_bypass_consumer *cons)
> +{
> +	if (prod->stop)
> +		prod->stop(prod);
> +	if (cons->stop)
> +		cons->stop(cons);
> +
> +	cons->del_producer(cons, prod);
> +
> +	if (prod->del_consumer)
> +		prod->del_consumer(prod, cons);
> +
> +	if (cons->start)
> +		cons->start(cons);
> +	if (prod->start)
> +		prod->start(prod);
> +}
> +
> +/**
> + * irq_bypass_register_producer - register IRQ bypass producer
> + * @producer: pointer to producer structure
> + *
> + * Add the provided IRQ producer to the list of producers and connect
> + * with any matching token found on the IRQ consumers list.
> + */
> +int irq_bypass_register_producer(struct irq_bypass_producer *producer)
> +{
> +	struct irq_bypass_producer *tmp;
> +	struct irq_bypass_consumer *consumer;
> +
> +	might_sleep();
> +
> +	if (!try_module_get(THIS_MODULE))
> +		return -ENODEV;
> +
> +	mutex_lock(&lock);
> +
> +	list_for_each_entry(tmp, &producers, node) {
> +		if (tmp->token == producer->token) {
> +			mutex_unlock(&lock);
> +			module_put(THIS_MODULE);
> +			return -EBUSY;
> +		}
> +	}
> +
> +	list_for_each_entry(consumer, &consumers, node) {
> +		if (consumer->token == producer->token) {
> +			int ret = __connect(producer, consumer);
> +			if (ret) {
> +				mutex_unlock(&lock);
> +				module_put(THIS_MODULE);
> +				return ret;
> +			}
> +			break;
> +		}
> +	}
> +
> +	list_add(&producer->node, &producers);
> +
> +	mutex_unlock(&lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(irq_bypass_register_producer);
> +
> +/**
> + * irq_bypass_unregister_producer - unregister IRQ bypass producer
> + * @producer: pointer to producer structure
> + *
> + * Remove a previously registered IRQ producer from the list of producers
> + * and disconnect it from any connected IRQ consumer.
> + */
> +void irq_bypass_unregister_producer(struct irq_bypass_producer *producer)
> +{
> +	struct irq_bypass_producer *tmp;
> +	struct irq_bypass_consumer *consumer;
> +
> +	might_sleep();
> +
> +	if (!try_module_get(THIS_MODULE))
> +		return; /* nothing in the list anyway */
> +
> +	mutex_lock(&lock);
> +
> +	list_for_each_entry(tmp, &producers, node) {
> +		if (tmp->token != producer->token)
> +			continue;
> +
> +		list_for_each_entry(consumer, &consumers, node) {
> +			if (consumer->token == producer->token) {
> +				__disconnect(producer, consumer);
> +				break;
> +			}
> +		}
> +
> +		list_del(&producer->node);
> +		module_put(THIS_MODULE);
> +		break;
> +	}
> +
> +	mutex_unlock(&lock);
> +
> +	module_put(THIS_MODULE);
> +}
> +EXPORT_SYMBOL_GPL(irq_bypass_unregister_producer);
> +
> +/**
> + * irq_bypass_register_consumer - register IRQ bypass consumer
> + * @consumer: pointer to consumer structure
> + *
> + * Add the provided IRQ consumer to the list of consumers and connect
> + * with any matching token found on the IRQ producer list.
> + */
> +int irq_bypass_register_consumer(struct irq_bypass_consumer *consumer)
> +{
> +	struct irq_bypass_consumer *tmp;
> +	struct irq_bypass_producer *producer;
> +
> +	if (!consumer->add_producer || !consumer->del_producer)
> +		return -EINVAL;
> +
> +	might_sleep();
> +
> +	if (!try_module_get(THIS_MODULE))
> +		return -ENODEV;
> +
> +	mutex_lock(&lock);
> +
> +	list_for_each_entry(tmp, &consumers, node) {
> +		if (tmp->token == consumer->token) {
> +			mutex_unlock(&lock);
> +			module_put(THIS_MODULE);
> +			return -EBUSY;
> +		}
> +	}
> +
> +	list_for_each_entry(producer, &producers, node) {
> +		if (producer->token == consumer->token) {
> +			int ret = __connect(producer, consumer);
> +			if (ret) {
> +				mutex_unlock(&lock);
> +				module_put(THIS_MODULE);
> +				return ret;
> +			}
> +			break;
> +		}
> +	}
> +
> +	list_add(&consumer->node, &consumers);
> +
> +	mutex_unlock(&lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(irq_bypass_register_consumer);
> +
> +/**
> + * irq_bypass_unregister_consumer - unregister IRQ bypass consumer
> + * @consumer: pointer to consumer structure
> + *
> + * Remove a previously registered IRQ consumer from the list of consumers
> + * and disconnect it from any connected IRQ producer.
> + */
> +void irq_bypass_unregister_consumer(struct irq_bypass_consumer
> *consumer)
> +{
> +	struct irq_bypass_consumer *tmp;
> +	struct irq_bypass_producer *producer;
> +
> +	might_sleep();
> +
> +	if (!try_module_get(THIS_MODULE))
> +		return; /* nothing in the list anyway */
> +
> +	mutex_lock(&lock);
> +
> +	list_for_each_entry(tmp, &consumers, node) {
> +		if (tmp->token != consumer->token)
> +			continue;
> +
> +		list_for_each_entry(producer, &producers, node) {
> +			if (producer->token == consumer->token) {
> +				__disconnect(producer, consumer);
> +				break;
> +			}
> +		}
> +
> +		list_del(&consumer->node);
> +		module_put(THIS_MODULE);
> +		break;
> +	}
> +
> +	mutex_unlock(&lock);
> +
> +	module_put(THIS_MODULE);
> +}
> +EXPORT_SYMBOL_GPL(irq_bypass_unregister_consumer);
> --
> 2.1.0
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
