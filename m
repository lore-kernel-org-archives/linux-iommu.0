Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0192192F4
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707761; cv=none; b=kF2A4nsUbm3bUbUZOvfcymd7r6wn/gwOb+OpeVwLDfHxPm8vJPUx80x8TUAIShbNppy9uckgTCbivM5VhLTP4o3HWSLiFJXIPdaDixFtp86l5pNZq9HSDCYwtjICRc0Fv0CSUIo1oeDA0N9wjdUEfUeEGcFPioMOLBQ4Qi4VrcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707761; c=relaxed/simple;
	bh=couV5zDEG42RyNXAaPwS4vqWYpI24UIK4hrY8aaG9pU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIvFKaNkuzrHWoNeacvJhaPqJFkcMSgTUNZlmJmVB0JRKXxtoorIrTAujMjKQcW4epFJC8ZMrv51neUg2GmRvFqNtlEfXgO604UcahuySPBzEB19c+utLYnfICh9OP5O4DdxZ8kxdflKIaA3cxo3slNzYukT2EHcBDwvEW6m+N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPCHh5Dc; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPCHh5Dc"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-8423f236418so3214963b3a.1
        for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781707758; x=1782312558; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VUJ8FgWhZw0/levarguUOPuDTibJ7vpB8uMe4/pYws=;
        b=sPCHh5DcDXLqIpBQimBZYjtgc4mBnWHnB75tceqkciU4FdBhwNjq/c+Es8hcMMNM5A
         jEVhHm7ulsoNB1/3t5YjvD2vqJkX8TC6X/1dTxIMDOX1QCPTIl/RffdrJERvRd37V+mp
         HoLxPPDptZVQK657bSFConMSpi+RknocQiQCmdCLYA6kuYGDsvXRu75n7TCM9xSyYy38
         AIe17aRLNQj8lAH5BTj+Lo1MM+KdThc30f5lpXw1Rk1a0H8c26lW3wGJGijYFXozQmmX
         g6RnC7tmIIpKoYJU4qN3tWvtTsOY0rIdK5y4+4ouQOFDSZ9gemhNU4nRM3fYGFi5+XIB
         DRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781707758; x=1782312558;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9VUJ8FgWhZw0/levarguUOPuDTibJ7vpB8uMe4/pYws=;
        b=Nj8WX66BKwSGpUa94y+txRuKXZtdN4EzbF6ioZWtLifR0bjzztvIlxqWFPgz1OILSw
         Uem2I7fL8QV+E4hAk7TMjwIl4WJzwkO32bAq7MO5+LJYKEgzGpzDo9xs7ZQLVHW09iZk
         mXVRqJRoP/uphRlLjwCEUjSmnRYrQqp6Hge2oxBJQpw8D4TLrG6MgSNW+Cc7kWCM9Ig2
         KQW1qiTBKld3R1bNqznRBuVdDaz1Lti5UUPFf2SzcdttgqR3hZb1hbNMHFzagPdC5qMn
         vdcTzG7ZZW82lF18Wyn1Srvenh/iU7LbX9qHP0fsHEUloDQcH0550Yr74z/HGySvcC+w
         GmwA==
X-Forwarded-Encrypted: i=1; AFNElJ8+oeNkGXj9YOWt80qQudxzlaRY4sxkt9w4WcBxJs00+noQfurqaoKcyKvoobq8ZxHO9jIAPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQ+z1uVdRvSkbOEM74QL1UvkuR4hTwdO1RwoEYnyjDReaVpOkX
	4a1o0ZD/kwu6UZ1DPaGTvVqkIaKU9lpY0+9D6SFwe3zpYf5tXOlH586k
X-Gm-Gg: Acq92OFOZcitaUMOBLMO7Om7uC93aDG916c78qONvnCi1qTQ2JJA4L/nVgyZaru6wmf
	IWl8XVSxUVkThrL6JKm7MiGcVQAXqfvS61MYwYqaQYyANjbsacQruL5SgSaDEdHRQ9aY4aWjd5x
	tOqinAGIQhokMt1uKrpz5sXJJoRHX5CPwTQgyuzSOymcBvRyydG+1mF3C4bFBsvDBtCatsyzYAT
	1P4px/u/TcnCBcBrX+ZB6hKgXLZpblLcTAxr0Vqw79knIyrUiDVj6osFQ7MROh+7u+YcCvICgd0
	sYMxOWOr0fy7JJTXKzR3UhLUJxSF9g5nNCOF3QrqnA01CO4mH+xzQ9ZefQm0RwQC9rp6+NMaLWq
	TlXIa36wUxPRtijknoMIOm6XUc0si7VW+g4PcI/0qs5oUMzEiJJ5mMs+b/peTjT1g3dbsQQo07/
	oFZRxZ/tVVP2z2mVjNF2EmaWT+tS+NbhD6EDdODeLSkcaR4UDOJDt9BiZbx/NdD4goO9W8
X-Received: by 2002:a05:6a00:760a:b0:845:286d:4675 with SMTP id d2e1a72fcca58-845286d4993mr2795911b3a.10.1781707758148;
        Wed, 17 Jun 2026 07:49:18 -0700 (PDT)
Received: from ?IPV6:2408:8409:2530:189a:8d96:17b2:2d12:8437? ([2408:8409:2530:189a:8d96:17b2:2d12:8437])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b046911sm16331176b3a.53.2026.06.17.07.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 07:49:17 -0700 (PDT)
Message-ID: <0c596ea4-8c29-4e5f-8238-cb8f8c5015fc@gmail.com>
Date: Wed, 17 Jun 2026 22:49:10 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] iommu/riscv: Add page request queue and IOPF support
To: "bingyu.xian" <shanbeeyoo@gmail.com>,
 Tomasz Jeznach <tomasz.jeznach@linux.dev>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Quan Zhou <zhouquan@iscas.ac.cn>
References: <20260617090116.3254505-1-shanbeeyoo@gmail.com>
From: Gong Shuai <gsh517025@gmail.com>
In-Reply-To: <20260617090116.3254505-1-shanbeeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/2026 5:01 PM, bingyu.xian wrote:
> The RISC-V IOMMU Architecture Specification, Version 1.0, Chapter 3.3
> defines a Page-request Queue (PQ) for handling PCIe Page Request
> Interface (PRI) messages. The current driver implements only the
> Command Queue (CQ) and Fault Queue (FQ); the PQ is left
> unimplemented, which is the biggest functional gap compared with the
> ARM SMMUv3 driver.
> 
> Add PQ and IOPF support:
> 
> - Initialize and enable the PQ when the hardware advertises ATS
>    capability (RISCV_IOMMU_CAPABILITIES_ATS), and add an IOMMU_IOPF
>    Kconfig dependency.
> - Implement the PQ interrupt handler riscv_iommu_priq_process(),
>    which consumes PQ records from the hardware ring buffer.
> - Translate PQ records into the kernel's generic iopf_fault format
>    and pass them to the IOPF framework via
>    iommu_report_device_fault().
> - Implement the .page_response callback, which builds an ATS.PRGR
>    (Page Request Group Response) command and sends it through the
>    command queue to notify the requesting device.
> 


Hi, bingyu

Thanks for your work.

Tomasz already has a complete ATS/PRI/SVA support series on GitHub [1],
which hasn't been posted to the mailing list yet.

[1] https://github.com/tjeznach/linux/commits/riscv_iommu.next


> Tested on QEMU 10.0 with '-M virt,iommu-sys=on' and
> CONFIG_IOMMU_IOPF=y; the PQ comes up cleanly:
> 
>    riscv,iommu 3010000.iommu: page request queue enabled
>    
> Test patch
> ==========


It would be better to separate the test helper into its own patch rather
than mixing it with the core implementation, which makes it hard to
apply directly.

Regards,
Shuai


> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index b1c2d3e4f5a6..3af3f19de94f 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -16,6 +16,7 @@
>   #include <linux/acpi_rimt.h>
>   #include <linux/compiler.h>
>   #include <linux/crash_dump.h>
> +#include <linux/debugfs.h>
>   #include <linux/init.h>
>   #include <linux/iommu.h>
>   #include <linux/iopoll.h>
> @@ -1608,9 +1609,62 @@ static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
>   	return 0;
>   }
> 
> +#ifdef CONFIG_DEBUG_FS
> +/*
> + * debugfs interface to inject a fake PQ record without real PRI hardware.
> + *
> + * Writing a PCI BDF-encoded device id to the 'inject_pq' file constructs a
> + * synthetic riscv_iommu_pq_record and feeds it directly to
> + * riscv_iommu_handle_pq(), exercising the IOPF report path and, via the
> + * IOPF framework, the .page_response -> ATS.PRGR command path.
> + *
> + * The IRQ-driven priq_process() consumer loop is not exercised here, but it
> + * reuses the same queue infrastructure as the existing fltq_process().
> + */
> +static struct dentry *riscv_iommu_debugfs_dir;
> +
> +static int riscv_iommu_inject_pq_set(void *data, u64 val)
> +{
> +	struct riscv_iommu_device *iommu = data;
> +	struct riscv_iommu_pq_record fake_req;
> +	unsigned int devid = (unsigned int)val;
> +
> +	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_ATS)) {
> +		dev_err(iommu->dev, "inject_pq: ATS not supported\n");
> +		return -ENODEV;
> +	}
> +
> +	memset(&fake_req, 0, sizeof(fake_req));
> +	fake_req.hdr = FIELD_PREP(RISCV_IOMMU_PQ_HDR_DID, devid);
> +	fake_req.payload = FIELD_PREP(RISCV_IOMMU_PQ_PAYLOAD_ADDR, 0xdead0) |
> +			   FIELD_PREP(RISCV_IOMMU_PQ_PAYLOAD_PRGI, 1) |
> +			   RISCV_IOMMU_PQ_PAYLOAD_L |
> +			   RISCV_IOMMU_PQ_PAYLOAD_R;
> +
> +	dev_info(iommu->dev,
> +		 "inject_pq: injecting fake PQ record for devid 0x%x\n", devid);
> +	riscv_iommu_handle_pq(iommu, &fake_req);
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(riscv_iommu_inject_pq_fops, NULL,
> +			 riscv_iommu_inject_pq_set, "%llu\n");
> +
> +static void riscv_iommu_debugfs_init(struct riscv_iommu_device *iommu)
> +{
> +	riscv_iommu_debugfs_dir = debugfs_create_dir("riscv-iommu", NULL);
> +	debugfs_create_file("inject_pq", 0200, riscv_iommu_debugfs_dir,
> +			    iommu, &riscv_iommu_inject_pq_fops);
> +}
> +
> +static void riscv_iommu_debugfs_remove(void)
> +{
> +	debugfs_remove_recursive(riscv_iommu_debugfs_dir);
> +	riscv_iommu_debugfs_dir = NULL;
> +}
> +#else
> +static inline void riscv_iommu_debugfs_init(struct riscv_iommu_device *iommu) { }
> +static inline void riscv_iommu_debugfs_remove(void) { }
> +#endif /* CONFIG_DEBUG_FS */
> +
>   void riscv_iommu_remove(struct riscv_iommu_device *iommu)
>   {
> +	riscv_iommu_debugfs_remove();
>   	iommu_device_unregister(&iommu->iommu);
>   	iommu_device_sysfs_remove(&iommu->iommu);
>   	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF);
> @@ -1754,6 +1808,8 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
>   		goto err_remove_sysfs;
>   	}
> 
> +	riscv_iommu_debugfs_init(iommu);
> +
>   	return 0;
> 
>   err_remove_sysfs:
> ---
> 
> Test logs:
>    root@Ubuntu-riscv64:~# dmesg | grep "iommu"
>    [    0.590293] iommu: Default domain type: Translated
>    [    0.590379] iommu: DMA domain TLB invalidation policy: lazy mode
>    [    1.374106] riscv,iommu 3010000.iommu: failed to find an MSI domain
>    [    1.374429] riscv,iommu 3010000.iommu: using wire-signaled interrupts
>    [    1.384786] riscv,iommu 3010000.iommu: page request queue enabled
>    [    1.391279] pci 0000:00:00.0: Adding to iommu group 0
>    [    1.391798] pci 0000:00:01.0: Adding to iommu group 1
>    [    1.392023] pci 0000:00:02.0: Adding to iommu group 2
>    [    1.392252] pci 0000:00:03.0: Adding to iommu group 3
> 
>    root@Ubuntu-riscv64:~# echo 8 > /sys/kernel/debug/riscv-iommu/inject_pq
> 
>    root@Ubuntu-riscv64:~# dmesg | grep "iommu"
>    [    0.590293] iommu: Default domain type: Translated
>    [    0.590379] iommu: DMA domain TLB invalidation policy: lazy mode
>    [    1.374106] riscv,iommu 3010000.iommu: failed to find an MSI domain
>    [    1.374429] riscv,iommu 3010000.iommu: using wire-signaled interrupts
>    [    1.384786] riscv,iommu 3010000.iommu: page request queue enabled
>    [    1.391279] pci 0000:00:00.0: Adding to iommu group 0
>    [    1.391798] pci 0000:00:01.0: Adding to iommu group 1
>    [    1.392023] pci 0000:00:02.0: Adding to iommu group 2
>    [    1.392252] pci 0000:00:03.0: Adding to iommu group 3
>    [ 1308.301611] riscv,iommu 3010000.iommu: inject_pq: injecting fake PQ record for devid 0x8
>    [ 1308.303467] riscv,iommu 3010000.iommu: page request fault report failed: -22
> 
> Assisted-by: YuanSheng: deepseek-v4-pro
> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> Signed-off-by: bingyu.xian <shanbeeyoo@gmail.com>
> ---
>   drivers/iommu/riscv/Kconfig |   1 +
>   drivers/iommu/riscv/iommu.c | 178 +++++++++++++++++++++++++++++++++++-
>   drivers/iommu/riscv/iommu.h |   3 +
>   3 files changed, 181 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
> index b86e5ab94183..c5abb7b4ba8f 100644
> --- a/drivers/iommu/riscv/Kconfig
> +++ b/drivers/iommu/riscv/Kconfig
> @@ -7,6 +7,7 @@ config RISCV_IOMMU
>   	depends on GENERIC_MSI_IRQ
>   	depends on (RISCV || COMPILE_TEST) && 64BIT
>   	select IOMMU_API
> +	select IOMMU_IOPF
>   	select GENERIC_PT
>   	select IOMMU_PT
>   	select IOMMU_PT_RISCV64
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index a31f50bbad35..b1c2d3e4f5a6 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -33,9 +33,10 @@
>   #define RISCV_IOMMU_DDTP_TIMEOUT	10000000
>   #define RISCV_IOMMU_IOTINVAL_TIMEOUT	90000000
> 
> -/* Number of entries per CMD/FLT queue, should be <= INT_MAX */
> +/* Number of entries per CMD/FLT/PRI queue, should be <= INT_MAX */
>   #define RISCV_IOMMU_DEF_CQ_COUNT	8192
>   #define RISCV_IOMMU_DEF_FQ_COUNT	4096
> +#define RISCV_IOMMU_DEF_PQ_COUNT	4096
> 
>   /* RISC-V IOMMU PPN <> PHYS address conversions, PHYS <=> PPN[53:10] */
>   #define phys_to_ppn(pa)  (((pa) >> 2) & (((1ULL << 44) - 1) << 10))
> @@ -565,6 +566,151 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
>   	return IRQ_HANDLED;
>   }
> 
> 
> +static struct device *riscv_iommu_find_dev(struct riscv_iommu_device *iommu,
> +					   unsigned int devid)
> +{
> +	struct pci_bus *bus;
> +	struct pci_dev *pdev;
> +
> +	bus = pci_find_bus(0, devid >> 8);
> +	if (!bus)
> +		return NULL;
> +
> +	pdev = pci_get_slot(bus, devid & 0xff);
> +	if (!pdev)
> +		return NULL;
> +
> +	return &pdev->dev;
> +}
> +
> +static void riscv_iommu_handle_pq(struct riscv_iommu_device *iommu,
> +				  struct riscv_iommu_pq_record *req)
> +{
> +	struct iopf_fault fault;
> +	struct device *dev;
> +	unsigned int devid;
> +	int ret;
> +
> +	devid = FIELD_GET(RISCV_IOMMU_PQ_HDR_DID, req->hdr);
> +	dev = riscv_iommu_find_dev(iommu, devid);
> +	if (!dev) {
> +		dev_warn_ratelimited(iommu->dev,
> +				     "page request for unknown devid 0x%x\n", devid);
> +		return;
> +	}
> +
> +	memset(&fault, 0, sizeof(fault));
> +	fault.fault.type = IOMMU_FAULT_PAGE_REQ;
> +	fault.fault.prm.addr = FIELD_GET(RISCV_IOMMU_PQ_PAYLOAD_ADDR, req->payload) << 12;
> +	fault.fault.prm.grpid = FIELD_GET(RISCV_IOMMU_PQ_PAYLOAD_PRGI, req->payload);
> +
> +	if (req->payload & RISCV_IOMMU_PQ_PAYLOAD_R)
> +		fault.fault.prm.perm |= IOMMU_FAULT_PERM_READ;
> +	if (req->payload & RISCV_IOMMU_PQ_PAYLOAD_W)
> +		fault.fault.prm.perm |= IOMMU_FAULT_PERM_WRITE;
> +	if (req->hdr & RISCV_IOMMU_PQ_HDR_EXEC)
> +		fault.fault.prm.perm |= IOMMU_FAULT_PERM_EXEC;
> +	if (req->hdr & RISCV_IOMMU_PQ_HDR_PRIV)
> +		fault.fault.prm.perm |= IOMMU_FAULT_PERM_PRIV;
> +
> +	if (req->hdr & RISCV_IOMMU_PQ_HDR_PV) {
> +		fault.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID |
> +					 IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
> +		fault.fault.prm.pasid = FIELD_GET(RISCV_IOMMU_PQ_HDR_PID, req->hdr);
> +	}
> +
> +	if (req->payload & RISCV_IOMMU_PQ_PAYLOAD_L)
> +		fault.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
> +
> +	/* Store DID in private_data for page_response to send ATS.PRGR */
> +	fault.fault.prm.private_data[0] = devid;
> +
> +	ret = iommu_report_device_fault(dev, &fault);
> +	if (ret) {
> +		dev_warn_ratelimited(iommu->dev,
> +				     "page request fault report failed: %d\n", ret);
> +	}
> +}
> +
> +/* Page request queue interrupt handler thread function */
> +static irqreturn_t riscv_iommu_priq_process(int irq, void *data)
> +{
> +	struct riscv_iommu_queue *queue = (struct riscv_iommu_queue *)data;
> +	struct riscv_iommu_device *iommu = queue->iommu;
> +	struct riscv_iommu_pq_record *requests;
> +	unsigned int ctrl, idx;
> +	int cnt, len;
> +
> +	requests = (struct riscv_iommu_pq_record *)queue->base;
> +
> +	/* Clear page request interrupt pending and process all records. */
> +	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, Q_IPSR(queue));
> +
> +	do {
> +		cnt = riscv_iommu_queue_consume(queue, &idx);
> +		for (len = 0; len < cnt; idx++, len++)
> +			riscv_iommu_handle_pq(iommu, &requests[Q_ITEM(queue, idx)]);
> +		riscv_iommu_queue_release(queue, cnt);
> +	} while (cnt > 0);
> +
> +	/* Clear MF/OF errors */
> +	ctrl = riscv_iommu_readl(iommu, queue->qcr);
> +	if (ctrl & (RISCV_IOMMU_PQCSR_PQMF | RISCV_IOMMU_PQCSR_PQOF)) {
> +		riscv_iommu_writel(iommu, queue->qcr, ctrl);
> +		dev_warn(iommu->dev,
> +			 "Queue #%u error; memory fault:%d overflow:%d\n",
> +			 queue->qid,
> +			 !!(ctrl & RISCV_IOMMU_PQCSR_PQMF),
> +			 !!(ctrl & RISCV_IOMMU_PQCSR_PQOF));
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* Send ATS.PRGR page response through the command queue */
> +static void riscv_iommu_page_response(struct device *dev,
> +				      struct iopf_fault *evt,
> +				      struct iommu_page_response *msg)
> +{
> +	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> +	struct riscv_iommu_command cmd;
> +	unsigned int devid;
> +	u8 resp_code;
> +
> +	/* Recover DID from private_data stored during PQ processing */
> +	devid = evt->fault.prm.private_data[0];
> +
> +	switch (msg->code) {
> +	case IOMMU_PAGE_RESP_SUCCESS:
> +		resp_code = 0; /* Success */
> +		break;
> +	case IOMMU_PAGE_RESP_INVALID:
> +		resp_code = 1; /* Invalid Request */
> +		break;
> +	case IOMMU_PAGE_RESP_FAILURE:
> +	default:
> +		resp_code = 0xF; /* Response Failure */
> +		break;
> +	}
> +
> +	/* Build ATS.PRGR command */
> +	cmd.dword0 = FIELD_PREP(RISCV_IOMMU_CMD_OPCODE, RISCV_IOMMU_CMD_ATS_OPCODE) |
> +		     FIELD_PREP(RISCV_IOMMU_CMD_FUNC, RISCV_IOMMU_CMD_ATS_FUNC_PRGR) |
> +		     FIELD_PREP(RISCV_IOMMU_CMD_ATS_RID, devid);
> +
> +	if (evt->fault.prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID)
> +		cmd.dword0 |= FIELD_PREP(RISCV_IOMMU_CMD_ATS_PID, evt->fault.prm.pasid) |
> +			      RISCV_IOMMU_CMD_ATS_PV;
> +
> +	cmd.dword1 = FIELD_PREP(RISCV_IOMMU_CMD_ATS_PRGR_PRG_INDEX, msg->grpid) |
> +		     FIELD_PREP(RISCV_IOMMU_CMD_ATS_PRGR_RESP_CODE, resp_code) |
> +		     FIELD_PREP(RISCV_IOMMU_CMD_ATS_PRGR_DST_ID, devid);
> +
> +	riscv_iommu_cmd_send(iommu, &cmd);
> +}
> +
>   /* Lookup and initialize device context info structure. */
>   static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
>   						 unsigned int devid)
> @@ -1404,6 +1550,7 @@ static const struct iommu_ops riscv_iommu_ops = {
>   	.device_group = riscv_iommu_device_group,
>   	.probe_device = riscv_iommu_probe_device,
>   	.release_device	= riscv_iommu_release_device,
> +	.page_response = riscv_iommu_page_response,
>   };
> 
>   static int riscv_iommu_init_check(struct riscv_iommu_device *iommu)
> @@ -1466,6 +1613,8 @@ void riscv_iommu_remove(struct riscv_iommu_device *iommu)
>   	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF);
>   	riscv_iommu_queue_disable(&iommu->cmdq);
>   	riscv_iommu_queue_disable(&iommu->fltq);
> +	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_ATS)
> +		riscv_iommu_queue_disable(&iommu->priq);
>   }
> 
>   int riscv_iommu_init(struct riscv_iommu_device *iommu)
> @@ -1494,6 +1643,15 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
>   	if (rc)
>   		return rc;
> 
> +	/* Allocate page request queue if ATS is supported */
> +	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_ATS) {
> +		RISCV_IOMMU_QUEUE_INIT(&iommu->priq, PQ);
> +		rc = riscv_iommu_queue_alloc(iommu, &iommu->priq,
> +					     sizeof(struct riscv_iommu_pq_record));
> +		if (rc)
> +			return rc;
> +	}
> +
>   	rc = riscv_iommu_queue_enable(iommu, &iommu->cmdq, riscv_iommu_cmdq_process);
>   	if (rc)
>   		return rc;
> @@ -1502,6 +1660,15 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
>   	if (rc)
>   		goto err_queue_disable;
> 
> +	/* Enable page request queue if ATS is supported */
> +	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_ATS) {
> +		rc = riscv_iommu_queue_enable(iommu, &iommu->priq,
> +					      riscv_iommu_priq_process);
> +		if (rc)
> +			goto err_queue_disable;
> +		dev_info(iommu->dev, "page request queue enabled\n");
> +	}
> +
>   	rc = riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_MAX);
>   	if (rc)
>   		goto err_queue_disable;
> @@ -1534,6 +1701,8 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
>   err_iodir_off:
>   	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF);
>   err_queue_disable:
> +	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_ATS)
> +		riscv_iommu_queue_disable(&iommu->priq);
>   	riscv_iommu_queue_disable(&iommu->fltq);
>   	riscv_iommu_queue_disable(&iommu->cmdq);
>   	return rc;
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index 46df79dd5495..5c5ab24539f2 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -14,6 +14,8 @@
>   #include <linux/iommu.h>
>   #include <linux/types.h>
>   #include <linux/iopoll.h>
> +#include <linux/pci.h>
> +#include <linux/pci-ats.h>
> 
>   #include "iommu-bits.h"
> 
> @@ -55,6 +57,7 @@ struct riscv_iommu_device {
>   	/* hardware queues */
>   	struct riscv_iommu_queue cmdq;
>   	struct riscv_iommu_queue fltq;
> +	struct riscv_iommu_queue priq;
> 
>   	/* device directory */
>   	unsigned int ddt_mode;
> --
> 2.53.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

