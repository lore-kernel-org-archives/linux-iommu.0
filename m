Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0EF3B47D0
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420655; cv=none; b=UVeEby7TS9Pem1KhabUpn+EAugvoJ3JiYiQGowrDnHcIOXUh6uhnk+cycf4863RkVMXLgJZslRs4V4WaG31I74MXIZsBmYPXivObbOBp59jfiGtIyJ6NPgsmotizj0wrjcPztdiFq0K1C7edR+iaWLe7CC8bK73vLwS8UUGQB5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420655; c=relaxed/simple;
	bh=mkVG0y7nrRTuMjjOmOlD8Yb6CF/PM0k2yhy6xYjy9vc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=g+eezC8h4CdFOFV5sS85S+Pi4TeLLtTrVrXi0itR/Nk+x6+ooO9CBrXXEYpXsVDkmiubDjVP7EvFZnInTcURVGEMgg0uzjlGiKjHVU0w68coOZrn/rl7d14INdLckLKO+GbwIuaG5fR+s9S+yM8nakgFO7qb91X8ToAvv24DIT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=HfAXtW2L; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="HfAXtW2L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1783420609;
	bh=fPdC5PV+PuRXItVok8N0EXj30Y77igLvtAJNXqF0e/o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=HfAXtW2LHiE0RIISWEFc6fl007gURZItY1hECy1z+KlswRpV/qzk17rntnf7uo5F8
	 hdw5pvzsazV7yEishaF+HAGd7QCJ/f4p6ord6qjWtFQpKUZ0Jtrv5D9+shtgywmCyW
	 uuuiPVsyzDm2Dr+SpEL9SoxR17o3D/0W1P91cwDs=
X-QQ-mid: esmtpgz15t1783420603t836706f9
X-QQ-Originating-IP: n+VphMwNPrCYEyoe+OFymGBQwjgGDZ0VU/NY9ff2S5Q=
Received: from [127.0.0.1] ( [36.152.24.164])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 Jul 2026 18:36:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13391982158505295696
Message-ID: <29F8ABC41A81139D+fc011ccd-cc15-4f64-bcc7-88e5d16184d5@smail.nju.edu.cn>
Date: Tue, 7 Jul 2026 18:36:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] iommu: KASAN slab-use-after-free in
 iommufd_auto_response_faults
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: jgg@ziepe.ca, kevin.tian@intel.com, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
 baolu.lu@linux.intel.com, nicolinc@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, dwmw2@infradead.org,
 suravee.suthikulpanit@amd.com, vasant.hegde@amd.com, yi.l.liu@intel.com,
 jpb@kernel.org
References: <B4F28798E2E784CA+d29f723c-b2b5-4b67-8d1c-4f7b9b0b27cb@smail.nju.edu.cn>
Content-Language: en-US
In-Reply-To: <B4F28798E2E784CA+d29f723c-b2b5-4b67-8d1c-4f7b9b0b27cb@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: Ni68Q0J6fxe2gbf5wR1kMsUsY65Iea/rmWVZU7v4I1pchc8wc/7ux30S
	yML9ctzqSSqiZY4D8azOjueVSsZIbMh8dd/t20ara/Kwz9ZvWmVMdTwYJWxlrdVkgHzdTDn
	1Qw4slkvOA6F02Gn4Ig5A3IA7iEtebmgv3dX6f+Z9zPeNSJDoRmFrfkv52cmJqaUz3qDXe9
	sYjnP3SKx9MdCzg5M2GQelt/OsfQZH5llwWdtkztz0NhyupyQMuAgzt8PFdKWufAYZA3mXN
	XdGkKhEsLNpIyzD6wVtursTLoGdpxo7wsIQz5qdzjw7P5+9gwolEmdWun8zLawPXNSZzIfJ
	yFU/0v+SD4IW5ZkRyVsgVWJrJeJgyMO7Gebx/z3mjk1qPPSev7oPSVad1v24mao0nCGb/Q1
	uCPga7xOZU68Kxb/hN6INV07wHCm0663MkI5uIfge/VkpCUfCCK+jGVvG9KUY+fJnfYOJ1S
	srskL5UF9oTW2ZZQqPtLUGBMK0l5SINUQRjh+HdYzJ7su2gj59VTRB06lsqzsqfANE32eD5
	LR2Wcl0jsPKuM/kYUAA961fS1/sixMZYo4A23eqX9lehJRzAuONXqZIrCb9XXX1KOOxRbnf
	31JHa2znqstmryy/mZLPnNpVmQoWll7A1jf5gS9ImGpENFmrJfWT8LikqgJ0Ab9kJQvxHq3
	5v0+AOTMzckZxqdDsYKL18nSOVxhEBHGYUrtkXWRbVjdR+LKdVeQpDgRDPG97MyfBqZyMcg
	yAyzWr7C0mhcHPsYDrKIonJWI8d7BVdE15MMeVGXaLKtBLzZFVddDEKNlgs+3Il5Ek6Frcm
	4JALUZub8shdthPP/BQBPqCId/ZQ1g0v47m4EyqJRUNb8opAxaFuCkW1moSc0ulZDmq5L0r
	2qlTMUsz5/4bAEvH54qQjc+gUyunjQ8cPwOSLz9qSwLL8hkls25Eys4vkbZEcm8l8l9dgCA
	+dQWBcsJJTZHfod7irD+/aX0yt4uLWWWvNZA31Pig9MpQNKGe7k8Zv6GtSPjUXV3hD53rQO
	jQbEPXIHG2I68Fm3gWYkZrSdoG+mz1/QQgvrAcyA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

> The analysis above goes through the iommufd selftest mock device (M). We
> have not reproduced this on real Intel/AMD hardware, but the same lifetime
> issue is not specific to the mock driver: Intel and AMD both have real detach
> paths that can reach the very same iopf_queue_remove_device(). This is exactly
> what iommufd_hwpt_detach_device() triggers, via iommu_detach_group_handle() /
> iommu_detach_device_pasid(), right before it calls iommufd_auto_response_faults().
> 
> The following is a static code-path analysis.
> 
> iommu_detach_group_handle() (RID-level detach) dispatches through the
> blocking domain's attach_dev op, like mock_domain_nop_attach() in the
> above analysis. iommu_detach_device_pasid() (PASID-level detach) is different:
> it dispatches through the blocking domain's set_dev_pasid op instead
> (drivers/iommu/iommu.c:3815 -> drivers/iommu/iommu.c:3553).
> 
> Intel (drivers/iommu/intel/) reaches iopf_queue_remove_device() on both paths:
>   blocking_domain_attach_dev()       [attach_dev, RID]       iommu.c:2755
>   blocking_domain_set_dev_pasid()    [set_dev_pasid, PASID]  iommu.c:3557
>   --> iopf_for_domain_remove()                               iommu.h:1263
>   --> intel_iommu_disable_iopf()                             iommu.c:3471
>   --> iopf_queue_remove_device()                             iommu.c:3483
> 
> AMD (drivers/iommu/amd/): the evidence here only covers the RID/group-detach
> path.
>   blocked_domain_attach_device()     [attach_dev, RID]       iommu.c:2883
>   --> detach_device()                                        iommu.c:2398
>   --> amd_iommu_iopf_remove_device()                         ppr.c:270
>   --> iopf_queue_remove_device()                             ppr.c:273
> AMD's PASID path, blocked_domain_set_dev_pasid() (iommu.c:2900), only calls
> amd_iommu_remove_dev_pasid() and does not reach iopf_queue_remove_device().

Hello Linux kernel developers and maintainers,

After further analysis of the code, we think that this UAF should not be feasible on AMD devices,
but still feasible on Intel devices.

===
AMD
===

We found no path by which a real AMD PPR fault can land in an IOMMUFD hw_pagetable's
fault->common.deliver or fault->response.

A real AMD PPR fault is always PASID-valid: iommu_call_iopf_notifier(), the only
iommu_report_device_fault() call site under drivers/iommu/amd/, rejects PASID 0 and always sets
IOMMU_FAULT_PAGE_REQUEST_PASID_VALID (drivers/iommu/amd/ppr.c:107,140-148).

find_fault_handler() (drivers/iommu/io-pgfault.c:118) resolves a PASID-valid fault only via a
per-PASID attach_handle, or a fallback to a RID-level NESTED domain gated by ops->user_pasid_table.
AMD does not set that flag (only arm-smmu-v3.c:4389 and the iommufd selftest mock, selftest.c:861,
do), so a failed per-PASID lookup is simply aborted on AMD, never delivered to any RID-level domain.

The per-PASID lookup cannot succeed toward an IOMMUFD HWPT on AMD, because the
AMD domains that IOMMUFD can allocate as HWPTs do not implement .set_dev_pasid:
amdv1_ops (iommu.c:2663), amdv2_ops (iommu.c:2741), and nested_domain_ops
(drivers/iommu/amd/nested.c:291) all lack it. Therefore, if userspace tries to
attach one of those IOMMUFD HWPT domains to a PASID, iommu_attach_device_pasid()
rejects it with -EOPNOTSUPP at the !domain->ops->set_dev_pasid check
(drivers/iommu/iommu.c:3625,3641-3644). The AMD nested RID attach path is not a
substitute here either: nested_attach_device() refuses attachment when PASID is
enabled (WARN_ON(dev_data->pasid_enabled), nested.c:244).

AMD does have a domain with .set_dev_pasid, amd_sva_domain_ops
(drivers/iommu/amd/pasid.c:177), but that is the kernel SVA domain path, not an
IOMMUFD HWPT. The SVA allocation path installs iommu_sva_iopf_handler()
(drivers/iommu/iommu-sva.c:298,327), not iommufd_fault_iopf_handler(), so faults
delivered there are not linked into an iommufd_fault object's deliver/response
queues.

=====
Intel
=====

Intel's PRQ descriptor carries a real, hardware-set pasid_present bit: intel_prq_report()
(drivers/iommu/intel/prq.c:175) only sets IOMMU_FAULT_PAGE_REQUEST_PASID_VALID when
desc->pasid_present is true, so a non-PASID PRI request reaches find_fault_handler()'s RID
(IOMMU_NO_PASID) lookup directly -- a RID-attached fault-capable HWPT can receive it.

Unlike AMD, Intel's IOMMUFD-attachable domains do implement .set_dev_pasid: intel_fs_paging_domain_ops
and intel_ss_paging_domain_ops (drivers/iommu/intel/iommu.c:3894,3905) and intel_nested_domain_ops
(drivers/iommu/intel/nested.c:190) all set it to intel_iommu_set_dev_pasid /
intel_nested_set_dev_pasid, so a PASID-tagged fault can also resolve to an IOMMUFD attach_handle.

Both RID and PASID detach reach iopf_queue_remove_device() the same way as the mock device:
blocking_domain_attach_dev() / blocking_domain_set_dev_pasid() (drivers/iommu/intel/iommu.c:2755,3557)
-> iopf_for_domain_remove() (drivers/iommu/intel/iommu.h:1263) -> intel_iommu_disable_iopf()
(iommu.c:3471) -> iopf_queue_remove_device() (iommu.c:3483), but only once info->iopf_refcount
drops to zero. This refcount is shared per device across every attach path, so the bug may only fire
when the detached domain is the last fault-capable attachment on that device.


Again, the above analysis is based solely on the code.
For now we do not have suitable hardware to test the behavior of the AMD and Intel drivers.

Thanks,
Peiyang


