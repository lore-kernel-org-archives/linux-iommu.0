Return-Path: <SRS0=gtiV=HF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F4CC433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 12:47:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143ED64F6C
	for <iommu@archiver.kernel.org>; Wed,  3 Feb 2021 12:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143ED64F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BE08B87002;
	Wed,  3 Feb 2021 12:47:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X6FNvniLqXMw; Wed,  3 Feb 2021 12:47:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 689C585A58;
	Wed,  3 Feb 2021 12:47:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 483FCC0FA8;
	Wed,  3 Feb 2021 12:47:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED3A1C0174;
 Wed,  3 Feb 2021 12:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D712785EE9;
 Wed,  3 Feb 2021 12:47:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u-Uypr1CuO2J; Wed,  3 Feb 2021 12:47:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7F3E4851A4;
 Wed,  3 Feb 2021 12:47:04 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id f16so5362254wmq.5;
 Wed, 03 Feb 2021 04:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=IZflTpVi58KCkqF3w6IrG6LAD11tU7+eH6DvsYEmc00=;
 b=maOVwaF4Zcdq/8++iBE3KH8Zuc2Q9i91wVWEQDFMoaB2RVRz7K6FCT1hdcAzFUhl/C
 90S1ZaDC3AkGl34lGCv+dQsUxaz/rtKmVsClZMBGRJgeL+AkTkNoQw4XGFb00SEHc6Ft
 wLSBLucHMNHqS3TTgh3ozNuWJDFDIrfIP/LvfdL0ZJf7OLpa7lw66hyegR+aLCsK/Bwt
 bSkNzxLwWPFRv8vZIyOSG7eQizKxKaTQofCxO69ejuoibCw5YdNxSssbwSdumOR3fnL8
 F3pYt721ePWTv/q6Cbu+cS7QDKkyAqTuFE/PW896V7MJhGXlolZOGUgFQw11LBAsWivr
 rHUA==
X-Gm-Message-State: AOAM532Iyp3OAUbwtESMSb/V6nUOKXDMsLcWRBQNrdugn7yB4/zdsfcC
 j/02WPg4kiZ8WEzifrktFsU=
X-Google-Smtp-Source: ABdhPJyeU3BhuMLmDKNujJgChleD1PVXDcffBTm5NGXAfwDtli6d5lxAPaCCG/yDEk87/4XnfDgBwQ==
X-Received: by 2002:a7b:cb58:: with SMTP id v24mr2696118wmj.182.1612356422842; 
 Wed, 03 Feb 2021 04:47:02 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
 by smtp.gmail.com with ESMTPSA id n4sm3508645wrt.47.2021.02.03.04.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Feb 2021 04:47:02 -0800 (PST)
Date: Wed, 3 Feb 2021 12:47:00 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v5 16/16] iommu/hyperv: setup an IO-APIC IRQ remapping
 domain for root partition
Message-ID: <20210203124700.ugx5vd526455u7lb@liuwe-devbox-debian-v2>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-17-wei.liu@kernel.org>
 <MWHPR21MB15936ED25B56AF897B655B76D7BB9@MWHPR21MB1593.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR21MB15936ED25B56AF897B655B76D7BB9@MWHPR21MB1593.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20180716
Cc: Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
 Will Deacon <will@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Jan 27, 2021 at 05:47:08AM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 AM
> > 
> > Just like MSI/MSI-X, IO-APIC interrupts are remapped by Microsoft
> > Hypervisor when Linux runs as the root partition. Implement an IRQ
> > domain to handle mapping and unmapping of IO-APIC interrupts.
> > 
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> >  arch/x86/hyperv/irqdomain.c     |  54 ++++++++++
> >  arch/x86/include/asm/mshyperv.h |   4 +
> >  drivers/iommu/hyperv-iommu.c    | 179 +++++++++++++++++++++++++++++++-
> >  3 files changed, 233 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> > index 19637cd60231..8e2b4e478b70 100644
> > --- a/arch/x86/hyperv/irqdomain.c
> > +++ b/arch/x86/hyperv/irqdomain.c
> > @@ -330,3 +330,57 @@ struct irq_domain * __init hv_create_pci_msi_domain(void)
> >  }
> > 
> >  #endif /* CONFIG_PCI_MSI */
> > +
> > +int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry)
> > +{
> > +	union hv_device_id device_id;
> > +
> > +	device_id.as_uint64 = 0;
> > +	device_id.device_type = HV_DEVICE_TYPE_IOAPIC;
> > +	device_id.ioapic.ioapic_id = (u8)ioapic_id;
> > +
> > +	return hv_unmap_interrupt(device_id.as_uint64, entry) & HV_HYPERCALL_RESULT_MASK;
> 
> The masking is already done in hv_unmap_interrupt.

Fixed.

> 
> > +}
> > +EXPORT_SYMBOL_GPL(hv_unmap_ioapic_interrupt);
> > +
> > +int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
> > +		struct hv_interrupt_entry *entry)
> > +{
> > +	unsigned long flags;
> > +	struct hv_input_map_device_interrupt *input;
> > +	struct hv_output_map_device_interrupt *output;
> > +	union hv_device_id device_id;
> > +	struct hv_device_interrupt_descriptor *intr_desc;
> > +	u16 status;
> > +
> > +	device_id.as_uint64 = 0;
> > +	device_id.device_type = HV_DEVICE_TYPE_IOAPIC;
> > +	device_id.ioapic.ioapic_id = (u8)ioapic_id;
> > +
> > +	local_irq_save(flags);
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> > +	memset(input, 0, sizeof(*input));
> > +	intr_desc = &input->interrupt_descriptor;
> > +	input->partition_id = hv_current_partition_id;
> > +	input->device_id = device_id.as_uint64;
> > +	intr_desc->interrupt_type = HV_X64_INTERRUPT_TYPE_FIXED;
> > +	intr_desc->target.vector = vector;
> > +	intr_desc->vector_count = 1;
> > +
> > +	if (level)
> > +		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_LEVEL;
> > +	else
> > +		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_EDGE;
> > +
> > +	__set_bit(vcpu, (unsigned long *)&intr_desc->target.vp_mask);
> > +
> > +	status = hv_do_rep_hypercall(HVCALL_MAP_DEVICE_INTERRUPT, 0, 0, input, output) &
> > +			 HV_HYPERCALL_RESULT_MASK;
> > +	local_irq_restore(flags);
> > +
> > +	*entry = output->interrupt_entry;
> > +
> > +	return status;
> 
> As a cross-check, I was comparing this code against hv_map_msi_interrupt().  They are
> mostly parallel, though some of the assignments are done in a different order.  It's a nit,
> but making them as parallel as possible would be nice. :-)
> 

Indeed. I will see about factoring out a function.

> Same 64 vCPU comment applies here as well.
> 

This is changed to use vpset instead. Took me a bit of time to get it
working because document is a bit lacking.

> 
> > +}
> > +EXPORT_SYMBOL_GPL(hv_map_ioapic_interrupt);
> > diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> > index ccc849e25d5e..345d7c6f8c37 100644
> > --- a/arch/x86/include/asm/mshyperv.h
> > +++ b/arch/x86/include/asm/mshyperv.h
> > @@ -263,6 +263,10 @@ static inline void hv_set_msi_entry_from_desc(union
> > hv_msi_entry *msi_entry,
> > 
> >  struct irq_domain *hv_create_pci_msi_domain(void);
> > 
> > +int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
> > +		struct hv_interrupt_entry *entry);
> > +int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
> > +
> >  #else /* CONFIG_HYPERV */
> >  static inline void hyperv_init(void) {}
> >  static inline void hyperv_setup_mmu_ops(void) {}
> > diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> > index b7db6024e65c..6d35e4c303c6 100644
> > --- a/drivers/iommu/hyperv-iommu.c
> > +++ b/drivers/iommu/hyperv-iommu.c
> > @@ -116,30 +116,43 @@ static const struct irq_domain_ops hyperv_ir_domain_ops = {
> >  	.free = hyperv_irq_remapping_free,
> >  };
> > 
> > +static const struct irq_domain_ops hyperv_root_ir_domain_ops;
> >  static int __init hyperv_prepare_irq_remapping(void)
> >  {
> >  	struct fwnode_handle *fn;
> >  	int i;
> > +	const char *name;
> > +	const struct irq_domain_ops *ops;
> > 
> >  	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
> >  	    x86_init.hyper.msi_ext_dest_id() ||
> > -	    !x2apic_supported() || hv_root_partition)
> > +	    !x2apic_supported())
> 
> Any reason that the check for hv_root_partition was added
> in patch #4  of this series, and then removed here?  Could
> patch #4 just be dropped?
> 

Before v5 (or v4?) IO-APIC was not handled via Hyper-V IOMMU. Now it is.

Patch 4 has become redundant with that change. I already dropped patch 4
in the v6 branch I have locally.

> >  		return -ENODEV;
> > 
> > -	fn = irq_domain_alloc_named_id_fwnode("HYPERV-IR", 0);
> > +	if (hv_root_partition) {
> > +		name = "HYPERV-ROOT-IR";
> > +		ops = &hyperv_root_ir_domain_ops;
> > +	} else {
> > +		name = "HYPERV-IR";
> > +		ops = &hyperv_ir_domain_ops;
> > +	}
> > +
[...]
> > +static void
> > +hyperv_root_ir_compose_msi_msg(struct irq_data *irq_data, struct msi_msg *msg)
> > +{
> > +	u16 status;
> > +	u32 vector;
> > +	struct irq_cfg *cfg;
> > +	int ioapic_id;
> > +	struct cpumask *affinity;
> > +	int cpu, vcpu;
> > +	struct hv_interrupt_entry entry;
> > +	struct hyperv_root_ir_data *data = irq_data->chip_data;
> > +	struct IO_APIC_route_entry e;
> > +
> > +	cfg = irqd_cfg(irq_data);
> > +	affinity = irq_data_get_effective_affinity_mask(irq_data);
> > +	cpu = cpumask_first_and(affinity, cpu_online_mask);
> > +	vcpu = hv_cpu_number_to_vp_number(cpu);
> > +
> > +	vector = cfg->vector;
> > +	ioapic_id = data->ioapic_id;
> > +
> > +	if (data->entry.source == HV_DEVICE_TYPE_IOAPIC
> 
> Does 'data' need to be checked to be non-NULL?  The parallel code in
> hv_irq_compose_msi_msg() makes such a check.

The usage of irq_data->chip_data is different in these two functions.

In this function, we're sure it is correctly allocated by
hyperv_root_ir_remapping_alloc at some point before.

In hv_irq_compose_msi_msg, irq_data->chip_data is instead used as a
temporary place to stash some state that is controlled solely by the
said function.

Once we get to the point of introducing a paravirtualized IOMMU for the
root partition, we can then unify these two paths.

> 
> > +	    && data->entry.ioapic_rte.as_uint64) {
> > +		entry = data->entry;
> > +
> > +		status = hv_unmap_ioapic_interrupt(ioapic_id, &entry);
> > +
> > +		if (status != HV_STATUS_SUCCESS)
> > +			pr_debug("%s: unexpected unmap status %d\n", __func__, status);
> > +
> > +		data->entry.ioapic_rte.as_uint64 = 0;
> > +		data->entry.source = 0; /* Invalid source */
> 
> Again comparing, hv_irq_compose_msi_msg() frees the old
> entry, and then allocates a new one.   This code reuses the old entry. 
> Any reason for the difference?
> 

See above.

I can perhaps tweak the logic a bit to reuse the same entry, but the
overall design won't change. I opted to always reallocate because that
looked more straight-forward to me.

Let me know if you feel strongly about reusing.

> > +	}
> > +
> > +
> > +	status = hv_map_ioapic_interrupt(ioapic_id, data->is_level, vcpu,
> > +					vector, &entry);
> > +
> > +	if (status != HV_STATUS_SUCCESS) {
> > +		pr_err("%s: map hypercall failed, status %d\n", __func__, status);
> > +		return;
> > +	}
> > +
> > +	data->entry = entry;
> > +
> > +	/* Turn it into an IO_APIC_route_entry, and generate MSI MSG. */
> > +	e.w1 = entry.ioapic_rte.low_uint32;
> > +	e.w2 = entry.ioapic_rte.high_uint32;
> > +
> > +	memset(msg, 0, sizeof(*msg));
> > +	msg->arch_data.vector = e.vector;
> > +	msg->arch_data.delivery_mode = e.delivery_mode;
> > +	msg->arch_addr_lo.dest_mode_logical = e.dest_mode_logical;
> > +	msg->arch_addr_lo.dmar_format = e.ir_format;
> > +	msg->arch_addr_lo.dmar_index_0_14 = e.ir_index_0_14;
> > +}
> 
> Having this whole function be more parallel to hv_irq_compose_msi_msg()
> would be nice. :-)
> 

Unlike hv_map_ioapic_interrupt and hv_map_msi_interrupt, which can
benefit from unifying now, this and hv_irq_compose_msi_msg will need to
wait till we have an IOMMU for the reason I stated above.

> > +
> > +static int hyperv_root_ir_set_affinity(struct irq_data *data,
> > +		const struct cpumask *mask, bool force)
> > +{
> > +	struct irq_data *parent = data->parent_data;
> > +	struct irq_cfg *cfg = irqd_cfg(data);
> > +	int ret;
> > +
> > +	ret = parent->chip->irq_set_affinity(parent, mask, force);
> > +	if (ret < 0 || ret == IRQ_SET_MASK_OK_DONE)
> > +		return ret;
> > +
> > +	send_cleanup_vector(cfg);
> > +
> > +	return 0;
> > +}
> > +
[...]
> > +
> > +static void hyperv_root_irq_remapping_free(struct irq_domain *domain,
> > +				 unsigned int virq, unsigned int nr_irqs)
> > +{
> > +	struct irq_data *irq_data;
> > +	struct hyperv_root_ir_data *data;
> > +	struct hv_interrupt_entry *e;
> > +	int i;
> > +
> > +	for (i = 0; i < nr_irqs; i++) {
> > +		irq_data = irq_domain_get_irq_data(domain, virq + i);
> > +
> > +		if (irq_data && irq_data->chip_data) {
> > +			data = irq_data->chip_data;
> 
> Set irq_data->chip_data to NULL?  That seems to be done in other
> similar places in your code.

There is no need to do that. By the time this function returns, irq_data
will be gone too -- freed by irq_domain_free_irqs_common.

> 
> > +			e = &data->entry;
> > +
> > +			if (e->source == HV_DEVICE_TYPE_IOAPIC
> > +			      && e->ioapic_rte.as_uint64)
> > +				hv_unmap_ioapic_interrupt(data->ioapic_id,
> > +							&data->entry);
> > +
> > +			kfree(data);
> > +		}
> > +	}
> > +
> > +	irq_domain_free_irqs_common(domain, virq, nr_irqs);
> > +}
> > +
> > +static const struct irq_domain_ops hyperv_root_ir_domain_ops = {
> > +	.select = hyperv_irq_remapping_select,
> > +	.alloc = hyperv_root_irq_remapping_alloc,
> > +	.free = hyperv_root_irq_remapping_free,
> > +};
> > +
> >  #endif
> > --
> > 2.20.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
