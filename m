Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1548625B08B
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685309; cv=none; b=HY57bCZIs/fyH0JztiXXGbx51Ppk7oNJxQm+fAFvCcwFIoI60B5yUzZzV2S4mZTc4xoN0nwW39VwxSyqVNTr6HtgVq++6YaKrHqS7VYEm3XqkZbvRzDtbfQHjNoiZkCxz2QEzzw/ufhpBqtS95bql3czRSYZIUKqpYCZ6ZuY0d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685309; c=relaxed/simple;
	bh=xWKmF8C9Zr+2Awq1AjBEcXK0D8HkqoeM+qa2zovwfPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZK0sUUoxPc3WKbIzbmXvVFuMWMicU0ZWdMaCYQ6RIuZ98tABOk/7A9BHGDMv70zpON3xRh+onjO/AxqBW80vkC+PXbInJMKSQUbgUQ0kzGmvDiT3IBqf2NCzVWWAynHShoj/9+XVHikgZoRyqTZAV31IyVNOoOVIcT0Oi2fKZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KqXlholt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KqXlholt"
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 106D320B7166; Wed, 13 May 2026 08:15:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 106D320B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778685305;
	bh=MFzcAiEh3uWgAwCfdi7HKcYLCmY6ieQbVEhiMUIaIF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KqXlholtq8cHJ/V/NSJSNieCbm+pEaro8D1wnajk+w65mSvYHW2wnONN403e8rHSD
	 q1ViQozRv4AlAF8kb3CG6Uev2H0nr/RjANU60U5q8WFu2R/nfeVaiZvIh7OLgep8ym
	 npbTpUrUvUtKT2O2KW1QDyRG1XBQp+u44p3i8yec=
Date: Wed, 13 May 2026 08:15:05 -0700
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH V1 3/3] mshv: Implement guest irq migration for passthru
 devices
Message-ID: <agSVedE/vs4ADJY/@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260512021242.1679786-1-mrathor@linux.microsoft.com>
 <20260512021242.1679786-4-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512021242.1679786-4-mrathor@linux.microsoft.com>

On Mon, May 11, 2026 at 07:12:42PM -0700, Mukesh R wrote:
> Ask the hypervisor to retarget interrupts to new guest cpu or vector
> upon guest irq migration. This happens in the irqfd update path.
> 
Reviewed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  drivers/hv/mshv_eventfd.c | 78 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 76 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
> index 1f5c1e9ee9b7..c05201d857fd 100644
> --- a/drivers/hv/mshv_eventfd.c
> +++ b/drivers/hv/mshv_eventfd.c
> @@ -192,6 +192,77 @@ static int mshv_map_device_interrupt(u64 ptid, union hv_device_id hv_devid,
>  
>  }
>  
> +/* NOTE: caller does spin_lock_irq on pt_irqfds_lock, hence no disable here */
> +static void mshv_do_guest_irq_retarget(u64 partid, struct mshv_irqfd *irqfd)
> +{
> +	int rc, var_size;
> +	u64 status;
> +	union hv_device_id hv_devid;
> +	struct hv_input_get_vp_set_from_mda *mda_input;
> +	union hv_output_get_vp_set_from_mda *mda_output;
> +	struct hv_retarget_device_interrupt *remap_inp;
> +	struct pci_dev *pdev;
> +	struct irq_data *irqdata;
> +	struct mshv_lapic_irq *lapic_irq = &irqfd->irqfd_lapic_irq;
> +	struct hv_interrupt_entry *inte = NULL;
> +
> +	if (!irqfd->irqfd_girq_ent.girq_entry_valid ||
> +	    irqfd->irqfd_bypass_prod == NULL)
> +		return;
> +
> +	rc = mshv_parse_mshv_irqfd(irqfd, &pdev, &irqdata);
> +	if (rc)
> +		return;
> +
> +	inte = irqdata->chip_data;
> +	if (inte == NULL)
> +		return;
> +
> +	hv_devid.as_uint64 = hv_devid_from_pdev(pdev);
> +
> +
> +	mda_input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	mda_output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	rc = hv_vpset_from_hyp_disabled(mda_input, mda_output, lapic_irq,
> +					partid);
> +	if (rc)
> +		return;
> +
> +	remap_inp = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	memset(remap_inp, 0, sizeof(*remap_inp));
> +
> +	rc = hv_copy_vpset(&remap_inp->int_target.vp_set,
> +			   &mda_output->target_vpset);
> +	if (rc <= 0) {
> +		pr_err("Hyper-V: ptid %lld - vpset copy failed (%d)\n",
> +		       partid, rc);
> +		return;
> +	}
> +
> +	/*
> +	 * var-sized hcall: var-size starts after vp_mask (thus vp_set.format
> +	 * does not count, but vp_set.valid_bank_mask does).
> +	 */
> +	var_size = rc + 1;
> +
> +	remap_inp->partition_id = partid;
> +	remap_inp->device_id = hv_devid.as_uint64;
> +	remap_inp->int_target.vector = lapic_irq->lapic_vector;
> +	remap_inp->int_target.flags = HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
> +
> +	remap_inp->int_entry.source = inte->source;
> +	remap_inp->int_entry.msi_entry.as_uint64 = inte->msi_entry.as_uint64;
> +
> +	status = hv_do_rep_hypercall(HVCALL_RETARGET_INTERRUPT, 0, var_size,
> +				     remap_inp, NULL);
> +
> +	if (!hv_result_success(status))
> +		hv_status_err(status, "pt:%lld vec:%d lapic-id:%lld\n",
> +			      partid, lapic_irq->lapic_vector,
> +			      lapic_irq->lapic_apic_id);
> +}
> +
>  static int mshv_unmap_device_interrupt(union hv_device_id hv_devid,
>  				       struct hv_interrupt_entry *irq_entry)
>  {
> @@ -729,9 +800,12 @@ static void mshv_irqfd_update(struct mshv_partition *pt,
>  			      struct mshv_irqfd *irqfd)
>  {
>  	write_seqcount_begin(&irqfd->irqfd_irqe_sc);
> -	irqfd->irqfd_girq_ent = mshv_ret_girq_entry(pt,
> -						    irqfd->irqfd_irqnum);
> +	irqfd->irqfd_girq_ent = mshv_ret_girq_entry(pt, irqfd->irqfd_irqnum);
>  	mshv_copy_girq_info(&irqfd->irqfd_girq_ent, &irqfd->irqfd_lapic_irq);
> +
> +#if IS_ENABLED(CONFIG_X86_64)
> +	mshv_do_guest_irq_retarget(pt->pt_id, irqfd);
> +#endif
>  	write_seqcount_end(&irqfd->irqfd_irqe_sc);
>  }
>  
> -- 
> 2.51.2.vfs.0.1
> 
