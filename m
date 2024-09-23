Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96915D528
	for <iommu@lists.linux.dev>; Mon, 23 Sep 2024 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727084115; cv=none; b=lDgyBPjQR28O5abu17w62dntK/ZbkPbqHw3ITu1vEHpRpDo5nxOWUlp4ZEP7SNZYSvm59lS7hhaaPuf97kA8g8GgVprhLVy3CzIpRSKU42Zwq2m/KcABiJ/3L+PvZTxQs9i3BvJKbVbfE3eDZQN0V8jTcDhr68oggHfZai4sog0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727084115; c=relaxed/simple;
	bh=eonJwap+XaW2/gbZIMYuyRKK/oMQubRIxSJoa9Wj3bg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vB4tDt91TQHyrFss+1eZezm0N2bfrAmohcc9dWycrXw3nVsgDwDhLPmgSWE1HSvkRbReVw0Nbv/inpFVQoFDoqn3D3Dm4RShD/68USbJOQoEdcfK0N38WiM/wKXWMYjI5BTOOuzwHzmMqextUVMnHY09NDRRfgkbWY1DPLCr/Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CvOhGAfW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CvOhGAfW"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48MLuHqB025241;
	Mon, 23 Sep 2024 09:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	pgdVWjvb7VmLv1WF02XWYlaHWZUm+oMkDNnFTZL6VRs=; b=CvOhGAfWPsSZnP+Y
	E0hnmcbcOKimaHzRGAlZoLJkcJ/V/RzSEZLeihIkg22Rjf2bcBvK+P2YkUeJHORA
	3Uq2mt9deSwtg96F+cabho5gDH0FLsIlTsgx6bG3lAAD+T8UhbNtvxwR41sMjg4y
	iAHbhVYW3qEyE9kpzj0HUWQr/xscGvW0o3Sv/C9RiefcgGQCDN9kiNw+kDbt1Klg
	1jKGvoElBeKUFclqpe7KsPOPK+n6xXxPZcCTOL7d83bfe4bl3KtGZVfvChEAZpWT
	XrfJxVkpXb6R9EuwJqKlWUGE4eo/5OIm+aGZHcs3sO1lUp4qiZ6s7Lk0BiVq1rgU
	01K9qQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41smjjjp48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 09:34:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48N7kw5q012524;
	Mon, 23 Sep 2024 09:34:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41t9fpnpsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 09:34:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48N9YpBi49873346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 09:34:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B59C20043;
	Mon, 23 Sep 2024 09:34:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0169020040;
	Mon, 23 Sep 2024 09:34:51 +0000 (GMT)
Received: from [9.152.224.39] (unknown [9.152.224.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Sep 2024 09:34:50 +0000 (GMT)
Message-ID: <31152f4714c644584db1e7e2506d0b434dff3fbc.camel@linux.ibm.com>
Subject: Re: [PATCH v2] dma-mapping: report unlimited DMA addressing in
 IOMMU DMA path
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Robin
 Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Marek
 Szyprowski <m.szyprowski@samsung.com>,
        Xi Ruoyao <xry111@xry111.site>
Date: Mon, 23 Sep 2024 11:34:49 +0200
In-Reply-To: <c2671009f217bfc3c9f7fbda2eefb0c44768fc3b.1727028402.git.leon@kernel.org>
References: 
	<c2671009f217bfc3c9f7fbda2eefb0c44768fc3b.1727028402.git.leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xSk0BksnI-Xz-bzPNuDY7_HlgYK0VCgu
X-Proofpoint-GUID: xSk0BksnI-Xz-bzPNuDY7_HlgYK0VCgu
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_05,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230070

On Sun, 2024-09-22 at 21:09 +0300, Leon Romanovsky wrote:
> While using the IOMMU DMA path, the dma_addressing_limited() function
> checks ops struct which doesn't exist in the IOMMU case. This causes
> to the kernel panic while loading ADMGPU driver.
>=20
> BUG: kernel NULL pointer dereference, address: 00000000000000a0
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 10 UID: 0 PID: 611 Comm: (udev-worker) Tainted: G=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> T=C2=A0 6.11.0-clang-07154-g726e2d0cf2bb #257
> Tainted: [T]=3DRANDSTRUCT
> Hardware name: ASUS System Product Name/ROG STRIX Z690-G GAMING WIFI,
> BIOS 3701 07/03/2024
> RIP: 0010:dma_addressing_limited+0x53/0xa0
> Code: 8b 93 48 02 00 00 48 39 d1 49 89 d6 4c 0f 42 f1 48 85 d2 4c 0f
> 44 f1 f6 83 fc 02 00 00 40 75 0a 48 89 df e8 1f 09 00 00 eb 24 <4c>
> 8b 1c 25 a0 00 00 00 4d 85 db 74 17 48 89 df 41 ba 8b 84 2d 55
> RSP: 0018:ffffa8d2c12cf740 EFLAGS: 00010202
> RAX: 00000000ffffffff RBX: ffff8948820220c8 RCX: 000000ffffffffff
> RDX: 0000000000000000 RSI: ffffffffc124dc6d RDI: ffff8948820220c8
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff894883c3f040
> R13: ffff89488dac8828 R14: 000000ffffffffff R15: ffff8948820220c8
> FS:=C2=A0 00007fe6ba881900(0000) GS:ffff894fdf700000(0000)
> knlGS:0000000000000000
> CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000000a0 CR3: 0000000111984000 CR4: 0000000000f50ef0
> PKRU: 55555554
> Call Trace:
> =C2=A0<TASK>
> =C2=A0? __die_body+0x65/0xc0
> =C2=A0? page_fault_oops+0x3b9/0x450
> =C2=A0? _prb_read_valid+0x212/0x390
> =C2=A0? do_user_addr_fault+0x608/0x680
> =C2=A0? exc_page_fault+0x4e/0xa0
> =C2=A0? asm_exc_page_fault+0x26/0x30
> =C2=A0? dma_addressing_limited+0x53/0xa0
> =C2=A0amdgpu_ttm_init+0x56/0x4b0 [amdgpu]
> =C2=A0gmc_v8_0_sw_init+0x561/0x670 [amdgpu]
> =C2=A0amdgpu_device_ip_init+0xf5/0x570 [amdgpu]
> =C2=A0amdgpu_device_init+0x1a57/0x1ea0 [amdgpu]
> =C2=A0? _raw_spin_unlock_irqrestore+0x1a/0x40
> =C2=A0? pci_conf1_read+0xc0/0xe0
> =C2=A0? pci_bus_read_config_word+0x52/0xa0
> =C2=A0amdgpu_driver_load_kms+0x15/0xa0 [amdgpu]
> =C2=A0amdgpu_pci_probe+0x1b7/0x4c0 [amdgpu]
> =C2=A0pci_device_probe+0x1c5/0x260
> =C2=A0really_probe+0x130/0x470
> =C2=A0__driver_probe_device+0x77/0x150
> =C2=A0driver_probe_device+0x19/0x120
> =C2=A0__driver_attach+0xb1/0x1e0
> =C2=A0? __cfi___driver_attach+0x10/0x10
> =C2=A0bus_for_each_dev+0x115/0x170
> =C2=A0bus_add_driver+0x192/0x2d0
> =C2=A0driver_register+0x5c/0xf0
> =C2=A0? __cfi_init_module+0x10/0x10 [amdgpu]
> =C2=A0do_one_initcall+0x128/0x380
> =C2=A0? idr_alloc_cyclic+0x139/0x1d0
> =C2=A0? security_kernfs_init_security+0x42/0x140
> =C2=A0? __kernfs_new_node+0x1be/0x250
> =C2=A0? sysvec_apic_timer_interrupt+0xb6/0xc0
> =C2=A0? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> =C2=A0? _raw_spin_unlock+0x11/0x30
> =C2=A0? free_unref_page+0x283/0x650
> =C2=A0? kfree+0x274/0x3a0
> =C2=A0? kfree+0x274/0x3a0
> =C2=A0? kfree+0x274/0x3a0
> =C2=A0? load_module+0xf2e/0x1130
> =C2=A0? __kmalloc_cache_noprof+0x12a/0x2e0
> =C2=A0do_init_module+0x7d/0x240
> =C2=A0__se_sys_init_module+0x19e/0x220
> =C2=A0do_syscall_64+0x8a/0x150
> =C2=A0? __irq_exit_rcu+0x5e/0x100
> =C2=A0entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7fe6bb5980ee
> Code: 48 8b 0d 3d ed 12 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
> 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48>
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0a ed 12 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffd462219d8 EFLAGS: 00000206 ORIG_RAX:
> 00000000000000af
> RAX: ffffffffffffffda RBX: 0000556caf0d0670 RCX: 00007fe6bb5980ee
> RDX: 0000556caf0d3080 RSI: 0000000002893458 RDI: 00007fe6b3400010
> RBP: 0000000000020000 R08: 0000000000020010 R09: 0000000000000080
> R10: c26073c166186e00 R11: 0000000000000206 R12: 0000556caf0d3430
> R13: 0000556caf0d0670 R14: 0000556caf0d3080 R15: 0000556caf0ce700
> =C2=A0</TASK>
> Modules linked in: amdgpu(+) i915(+) drm_suballoc_helper intel_gtt
> drm_exec drm_buddy iTCO_wdt i2c_algo_bit intel_pmc_bxt
> drm_display_helper iTCO_vendor_support gpu_sched drm_ttm_helper cec
> ttm amdxcp video backlight pinctrl_alderlake nct6775 hwmon_vid
> nct6775_core coretemp
> CR2: 00000000000000a0
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:dma_addressing_limited+0x53/0xa0
> Code: 8b 93 48 02 00 00 48 39 d1 49 89 d6 4c 0f 42 f1 48 85 d2 4c 0f
> 44 f1 f6 83 fc 02 00 00 40 75 0a 48 89 df e8 1f 09 00 00 eb 24 <4c>
> 8b 1c 25 a0 00 00 00 4d 85 db 74 17 48 89 df 41 ba 8b 84 2d 55
> RSP: 0018:ffffa8d2c12cf740 EFLAGS: 00010202
> RAX: 00000000ffffffff RBX: ffff8948820220c8 RCX: 000000ffffffffff
> RDX: 0000000000000000 RSI: ffffffffc124dc6d RDI: ffff8948820220c8
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff894883c3f040
> R13: ffff89488dac8828 R14: 000000ffffffffff R15: ffff8948820220c8
> FS:=C2=A0 00007fe6ba881900(0000) GS:ffff894fdf700000(0000)
> knlGS:0000000000000000
> CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000000000a0 CR3: 0000000111984000 CR4: 0000000000f50ef0
> PKRU: 55555554
>=20
> Fixes: b5c58b2fdc42 ("dma-mapping: direct calls for dma-iommu")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219292
> Signed-off-by: Leon Romanovsky <leon@kernel.org>
> ---
> Changelog:
> v2: Added missed bracket.
> ---
> =C2=A0kernel/dma/mapping.c | 6 +++++-
> =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index b839683da0ba..bcb7a4aa8fa4 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -569,6 +569,10 @@ u64 dma_get_required_mask(struct device *dev)
> =C2=A0
> =C2=A0	if (dma_alloc_direct(dev, ops))
> =C2=A0		return dma_direct_get_required_mask(dev);
> +
> +	if (use_dma_iommu(dev))
> +		return DMA_BIT_MASK(32);
> +
> =C2=A0	if (ops->get_required_mask)
> =C2=A0		return ops->get_required_mask(dev);
> =C2=A0
> @@ -926,7 +930,7 @@ bool dma_addressing_limited(struct device *dev)
> =C2=A0			 dma_get_required_mask(dev))
> =C2=A0		return true;
> =C2=A0
> -	if (unlikely(ops))
> +	if (unlikely(ops) || use_dma_iommu(dev))
> =C2=A0		return false;
> =C2=A0	return !dma_direct_all_ram_mapped(dev);
> =C2=A0}

Hi,

sorry for being nosy on this one - and I have to applogize for not
following the original discussion.

I'm just wondering, if it would not suffice to move the presence check
for "ops" before the call to dma_get_required_mask() and make an early
return in dma_addressing_limited()?

Like this:


diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index b1c18058d55f..e825b0a6db9e 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -848,12 +848,13 @@ bool dma_addressing_limited(struct device *dev)
 {
        const struct dma_map_ops *ops =3D get_dma_ops(dev);
=20
+       if (unlikely(ops))
+               return false;
+
        if (min_not_zero(dma_get_mask(dev), dev->bus_dma_limit) <
                         dma_get_required_mask(dev))
                return true;
=20
-       if (unlikely(ops))
-               return false;
        return !dma_direct_all_ram_mapped(dev);
 }
 EXPORT_SYMBOL_GPL(dma_addressing_limited);


Thanks,
Gerd

