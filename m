Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B4A32B117
	for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 23:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782862692; cv=none; b=k6Fl9ETNqBw14ZoFHR37uRjrsLZ+dJvAPcex3AxMihzKwkriu3XQrJTDjp4KLxg+04egM51U47efA2CjEiPdhOEzChVXYU9F5uFwxwF29v0+hE/3f2rCHBOLHILHc2UaxEq28KWkOOtYua/34wrEZrGzp0EFZn6eiv8up9lXMqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782862692; c=relaxed/simple;
	bh=S0eecLIECrW0DLNR33LeZhFNgmlgBsCaspl+gAXvn2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nAmqBgF9cCq1xDdtGPNgrbqAsqigRYf449thgOEiRkIfdTFwiceEBxKbClDUZfy5JXBUpjBRELFVLteq/+cNrR/9GieWct8Fo61djl9936t+vsC9fwDLuJbCiDVFTorYgNHiEswm8ek3Kck6xFYQMZQW+BrlHQILA49HKpdSGgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LTqT0sMD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTqT0sMD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782862689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eV8FxCsvcQQMn46BNl5VjX2wuC3TdKg658kA/dAWs8g=;
	b=LTqT0sMD2l2h3BwphYSF4ZU+bvD64upZePSJhx77CsWIszmriXM5z2O58FmFC7cLd6ogWW
	BChGIHUx1xb+QUJPbXN84hh802/TMIPizmFKNEYypySxSwTPrX3jWAfcbwikZnGwz2fCbE
	OdL6S0NJpLZLHKeUY5Buy+rpSDXxSKQ=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-Ew9eBMCnONqlzMppwzxYkA-1; Tue, 30 Jun 2026 19:38:08 -0400
X-MC-Unique: Ew9eBMCnONqlzMppwzxYkA-1
X-Mimecast-MFC-AGG-ID: Ew9eBMCnONqlzMppwzxYkA_1782862687
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30eec544cc2so67278eec.1
        for <iommu@lists.linux.dev>; Tue, 30 Jun 2026 16:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782862687; x=1783467487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eV8FxCsvcQQMn46BNl5VjX2wuC3TdKg658kA/dAWs8g=;
        b=sHxhZtKADMkNNkRp1EMY25+SX/w41PLtV2NQUJbinlpcybQ386vrqzj7CH6Km0r6eS
         qv0nHowKdlk0YgRReRrn/GwdewS3lcVlrznQRmwbryAyW63YwwfLoX5Isf7TSkfsdbr7
         RcP7DbGcmM32PIJijiibEQWQBaIk7nrKikTnLrl5ls82UxGusZtMqrPJ0SDrDe7T/uE8
         xeXZVayRRczhIIMWfTNlF2EYKsnUN0dLj0zy6EA4XQ4O9RfFhMbI5L0xeKaM2iz32bg5
         kDbXbOEXeUWeR57JHOm2PeHuTbBuPOTBY9mNsOI4TbNwVgRUOvL8qmwGM6W5bBCvzokw
         KIJQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYX7jQsTip03but3Ub7ttv92q+Zro6RWGN4l14uYKtmPlCjUFomQMqav4cG6UOgYHebsRxhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6GDPVNTiXsfxCZCysU1nD6kxavvVsYJimZuWVxZssTGGyI5k2
	l2XWfzwxh0/dclue5oMi/mSSsMMDjWkCD4EDemfZYByDV46Xd18qfZ0vnWBGosTmFurrOc2x4sJ
	XjDC6vbTw+uvUDD+yoQivMBScfEG9XjSnXYPLNugadIgM+wESgDUL2iA+
X-Gm-Gg: AfdE7cmTrjQZs8cCtY1NiaF4aDLD52evOIVFmeKkMecXx6StJ3s/YbQKRe8Ms1QVICN
	lZb/nrherG3CX9zuc0nUKZ7TGnuf/j68rRDxmey8guz0dQiu0bZw7q1fBN8gXrAYRwGiBLvlWRj
	rPbXplGiVjtUolhtM0l5+o0uboNlgDv9lrUCVfS1HX5p2R8jP4udpRptm7bC9LWiOJzm6PQTF/f
	RA84sSVcgaOZd5AqPdAlcuH+elokMFrqyy0Pz7qGA8w+TnxAZLwn7uP73aK1LPg2oveMAyUiADv
	+3UsS4cOb5gELLhG/vn8Oyg8LrByrKVam4ocyuTpSFM4iYu11nFreiyGmAVv3NlOBbQqbe+uind
	9ft3ZScRAnjRL5K8EvbIUhgwA/Pu8V513ccqJqZ3iTRfRCLeNhw==
X-Received: by 2002:a05:7300:547:b0:30c:ab4f:46c7 with SMTP id 5a478bee46e88-30ef0a3bb58mr2418751eec.45.1782862687111;
        Tue, 30 Jun 2026 16:38:07 -0700 (PDT)
X-Received: by 2002:a05:7300:547:b0:30c:ab4f:46c7 with SMTP id 5a478bee46e88-30ef0a3bb58mr2418706eec.45.1782862686439;
        Tue, 30 Jun 2026 16:38:06 -0700 (PDT)
Received: from localhost.localdomain (122-63-73-73.mobile.spark.co.nz. [122.63.73.73])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee31cfcaesm12341209eec.20.2026.06.30.16.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 16:38:05 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:37:58 +1200
From: Tao Liu <ltao@redhat.com>
To: Desnes Nunes <desnesn@redhat.com>, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	stable@vger.kernel.org, baolu.lu@linux.intel.com,
	dwmw2@infradead.org
Subject: Re: [PATCH v2] iommu/vt-d: Fix UCTP context table slot when copying
 root entries
Message-ID: <akRTVinqeeZnVARD@localhost.localdomain>
References: <20260629144837.3244851-1-desnesn@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260629144837.3244851-1-desnesn@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2MN33UdBl1ONTOZnsga9GHInbo75zZGAPKiOJc_SQzk_1782862687
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

CC to kexec ML.

On Mon, Jun 29, 2026 at 11:48:37AM -0300, Desnes Nunes wrote:
> When translation is already enabled at boot (e.g. kdump), the vt-d driver
> copies context tables from the previous kernel's root table. In scalable
> mode, buses that only populate the upper root half (UCTP, devfn >= 0x80)
> should be written to ctxt_tbls[tbl_idx + 1] through copy_context_table().
> However, the current copy path always uses tbl[tbl_idx + 0] in this situa-
> tion. Since idx wraps to 0 at devfn 0x80 due to a zeroed LCTP, new_ce for
> LCTP will be NULL and keep pos equals to 0. Thus, UCTP entries will be co-
> pied into tbl[tbl_idx + 0] instead of tbl[tbl_idx + 1], and written after-
> wards to root_entry[bus].lo instead of .hi in copy_translation_tables().
> 
> In short, devices on bus 0x80 with devfn >= 0x80 fail DMA with fault 0x39,
> which will break drivers running in kernels with translation pre-enabled.
> This fixes NO_PASID DMAR faults for UCTP-only buses such as:
> 
> DMAR: [DMA Read NO_PASID] Request device [80:14.0] fault addr 0xe81759000 [fault reason 0x39] SM: Present bit in Root Entry is clear
> 
> For instance, this fault yielded to locking issues between systemd and
> xHCI, blocking a system's reboot after a vmcore was captured with kdump:
> 
> [   72.987601] systemd-udevd[246]: usb3: Worker [255] processing SEQNUM=2193 is taking a long time
> [  132.237566] dracut-initqueue[277]: Timed out while waiting for udev queue to empty.
> [  202.988014] systemd-udevd[246]: usb3: Worker [255] processing SEQNUM=2193 killed
> [  202.998059] systemd-udevd[246]: usb3: Worker [255] terminated by signal 9 (KILL).
> ...
> [  206.288378] kdump[569]: saving vmcore complete
> ...
> [  206.821258] systemd-shutdown[1]: Rebooting.
> [  246.858495] INFO: task kworker/0:1:11 blocked for more than 122 seconds.
> [  246.865319]       Not tainted 7.0.0-clean #1
> [  246.869663] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  246.877623] task:kworker/0:1     state:D stack:0     pid:11 tgid:11    ppid:2      task_flags:0x4208160 flags:0x00080000
> [  246.888942] Workqueue: usb_hub_wq hub_event
> [  246.893202] Call Trace:
> [  246.895690]  <TASK>
> [  246.897828]  __schedule+0x299/0x5c0
> [  246.901378]  schedule+0x27/0x80
> [  246.904572]  schedule_timeout+0xbd/0x100
> [  246.908565]  __wait_for_common+0x97/0x1b0
> [  246.912644]  ? __pfx_schedule_timeout+0x10/0x10
> [  246.917252]  xhci_alloc_dev+0x9e/0x2b0
> [  246.921068]  usb_alloc_dev+0x7a/0x3b0
> [  246.924795]  hub_port_connect+0x285/0x960
> [  246.928873]  hub_port_connect_change+0x94/0x290
> [  246.933482]  port_event+0x4bb/0x840
> [  246.937030]  hub_event+0x141/0x460
> [  246.940489]  process_one_work+0x196/0x390
> [  246.944569]  worker_thread+0x1af/0x320
> [  246.948383]  ? __pfx_worker_thread+0x10/0x10
> [  246.952724]  kthread+0xe3/0x120
> [  246.955921]  ? __pfx_kthread+0x10/0x10
> [  246.959736]  ret_from_fork+0x199/0x260
> [  246.963550]  ? __pfx_kthread+0x10/0x10
> [  246.967362]  ret_from_fork_asm+0x1a/0x30
> [  246.971355]  </TASK>
> [  369.738508] INFO: task systemd-shutdow:1 blocked for more than 122 seconds.
> [  369.745593]       Not tainted 7.0.0-clean #1
> [  369.749935] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  369.757897] task:systemd-shutdow state:D stack:0     pid:1 tgid:1   ppid:0      task_flags:0x400100 flags:0x00080000
> [  369.769128] Call Trace:
> [  369.771616]  <TASK>
> [  369.773752]  __schedule+0x299/0x5c0
> [  369.777299]  schedule+0x27/0x80
> [  369.780493]  schedule_preempt_disabled+0x15/0x30
> [  369.785188]  __mutex_lock.constprop.0+0x547/0xac0
> [  369.789974]  device_shutdown+0xac/0x1b0
> [  369.793877]  kernel_restart+0x3a/0x70
> [  369.797603]  __do_sys_reboot+0x147/0x240
> [  369.801595]  do_syscall_64+0x11b/0x6a0
> [  369.805407]  ? handle_mm_fault+0x110/0x350
> [  369.809574]  ? do_user_addr_fault+0x206/0x680
> [  369.814006]  ? irqentry_exit+0x7a/0x4d0
> [  369.817907]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  369.823046] RIP: 0033:0x7fe2958da917
> [  369.826684] RSP: 002b:00007ffc5c458618 EFLAGS: 00000206 ORIG_RAX: 00000000000000a9
> [  369.834383] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe2958da917
> [  369.841639] RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
> [  369.848893] RBP: 00007ffc5c458790 R08: 0000000000000069 R09: 00000000ffffffff
> [  369.856148] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
> [  369.863402] R13: 0000000000000000 R14: 00007ffc5c4588b8 R15: 0000000000000000
> [  369.870659]  </TASK>
> [  369.872888] INFO: task systemd-shutdow:1 is blocked on a mutex likely owned by task kworker/0:1:11.
>

Thanks for attaching the kernel stack trace, which is similar to the one I have
encountered recently. And I have applied & tested the patch, works good for me.

Tested-by: Tao Liu <ltao@redhat.com> 
 
> Fixes: 091d42e43d21 ("iommu/vt-d: Copy translation tables from old kernel")
> Signed-off-by: Desnes Nunes <desnesn@redhat.com>
> ---
> V1 -> V2: Updated commit message and added xHCI stack trace as requested
> 
> v1: https://lore.kernel.org/linux-iommu/ajnlKDglN6wEBBrS@google.com/T/#t
> 
>  drivers/iommu/intel/iommu.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 4d0e65bc131d..737936f942a0 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1443,7 +1443,7 @@ static int copy_context_table(struct intel_iommu *iommu,
>  			      struct context_entry **tbl,
>  			      int bus, bool ext)
>  {
> -	int tbl_idx, pos = 0, idx, devfn, ret = 0, did;
> +	int tbl_idx, tbl_slot = 0, idx, devfn, ret = 0, did;
>  	struct context_entry *new_ce = NULL, ce;
>  	struct context_entry *old_ce = NULL;
>  	struct root_entry re;
> @@ -1459,10 +1459,9 @@ static int copy_context_table(struct intel_iommu *iommu,
>  		if (idx == 0) {
>  			/* First save what we may have and clean up */
>  			if (new_ce) {
> -				tbl[tbl_idx] = new_ce;
> +				tbl[tbl_idx + tbl_slot] = new_ce;
>  				__iommu_flush_cache(iommu, new_ce,
>  						    VTD_PAGE_SIZE);
> -				pos = 1;
>  			}
>  
>  			if (old_ce)
> @@ -1484,6 +1483,9 @@ static int copy_context_table(struct intel_iommu *iommu,
>  				}
>  			}
>  
> +			/* Track if saving UCTP or LCTP entries in scalable mode */
> +			tbl_slot = ext && devfn >= 0x80 ? 1 : 0;
> +
>  			ret = -ENOMEM;
>  			old_ce = memremap(old_ce_phys, PAGE_SIZE,
>  					MEMREMAP_WB);
> @@ -1512,7 +1514,7 @@ static int copy_context_table(struct intel_iommu *iommu,
>  		new_ce[idx] = ce;
>  	}
>  
> -	tbl[tbl_idx + pos] = new_ce;
> +	tbl[tbl_idx + tbl_slot] = new_ce;
>  
>  	__iommu_flush_cache(iommu, new_ce, VTD_PAGE_SIZE);
>  
> -- 
> 2.54.0
> 

