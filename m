Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1033B14A82
	for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743123616; cv=none; b=WK0PI/NeVMqSvZ7QEAtshmQyRmiApIEeGEjz+KUYQsu7htbw2fUOPw/RDK+N1/jo0IJnXevghn2lJ4ai2Mbvx7ki3BHBV/JeJeqhaWpS2QqC47tDrUgGg3lMLuD2Tsa9ve5gevtBJGGHjwEMxPyMpAr+dO3JJRifpnKTy/EPlOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743123616; c=relaxed/simple;
	bh=hqVJWdQbaTe+mN4EM4vMbKP4HNLV+BlHaOjan4RZOPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOMZpV8u6cBZCJOgW/mjoB8suXDEulRsEfAM7ZMt88pxK4nKVmNHkgY3tyeyOQQt5bWvQnNFMySZE7T2YxsimHItXFDQ4WpSRRUwRs4dcP2rWZ/pMpElDrIGsX5LPxOX2LRL48v2wNyQ7D10VQDRjpdYWU9ZA45Dk26yGueMT7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bw4kg/8V; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bw4kg/8V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743123614; x=1774659614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hqVJWdQbaTe+mN4EM4vMbKP4HNLV+BlHaOjan4RZOPI=;
  b=Bw4kg/8V7kpYfsnq5sDpvBEbvbhHoixMDSlsS1bBeGAEghscRx9zNwwW
   agSS8n5zDJWbN3+BjEz/Ayet3oH2QUj2uuvF2UoIMMhQQ2jd8Bye/+S/9
   SdY7NJ+oZj6QlL+GEt9SFEF+2bfZSrgoKNQWJW+V1mCtBi3u6O6en9Urt
   RdvMUS905InmMkGMIGJSa4mTwakEGYGfS7gWCaTfEs7/p1wGAi8KuxobT
   jy3gv5yfcaKL+M04Wtv9zBWcqAmg316rIxrmHv+513h6TRS+ubqrqDgm1
   0k1XquS+roV5qmZ6ynCSjvPRSyC0HxK1olZFnF0pGlCNxmOnF+PwTncoE
   A==;
X-CSE-ConnectionGUID: knkj2WmrTAqq0sKKG+BYtQ==
X-CSE-MsgGUID: 7v8OPnsySQqOHLCEMwaYhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44200972"
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="44200972"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 18:00:13 -0700
X-CSE-ConnectionGUID: yQSozlcoTVumPgFPZk8MAw==
X-CSE-MsgGUID: ERhkjiTsT7OJa04HERtDQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="125758276"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 18:00:11 -0700
Date: Fri, 28 Mar 2025 09:00:39 +0800
From: "Lai, Yi" <yi1.lai@linux.intel.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, jgg@nvidia.com, joro@8bytes.org,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	nicolinc@nvidia.com, yi1.lai@intel.com
Subject: Re: [PATCH v11 17/18] iommufd/selftest: Add test ops to test pasid
 attach/detach
Message-ID: <Z+X0tzxhiaupJT7b@ly-workstation>
References: <20250321171940.7213-1-yi.l.liu@intel.com>
 <20250321171940.7213-18-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321171940.7213-18-yi.l.liu@intel.com>

On Fri, Mar 21, 2025 at 10:19:39AM -0700, Yi Liu wrote:
> This adds 4 test ops for pasid attach/replace/detach testing. There are
> ops to attach/detach pasid, and also op to check the attached hwpt of a
> pasid.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
> v10 -> v11: Various tweaks. Detail refer to discussion in v10 of this patch
> ---
>  drivers/iommu/iommufd/iommufd_test.h |  26 +++++
>  drivers/iommu/iommufd/selftest.c     | 162 +++++++++++++++++++++++++++
>  2 files changed, 188 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
> index 1a066feb8697..1cd7e8394129 100644
> --- a/drivers/iommu/iommufd/iommufd_test.h
> +++ b/drivers/iommu/iommufd/iommufd_test.h
> @@ -25,6 +25,10 @@ enum {
>  	IOMMU_TEST_OP_TRIGGER_IOPF,
>  	IOMMU_TEST_OP_DEV_CHECK_CACHE,
>  	IOMMU_TEST_OP_TRIGGER_VEVENT,
> +	IOMMU_TEST_OP_PASID_ATTACH,
> +	IOMMU_TEST_OP_PASID_REPLACE,
> +	IOMMU_TEST_OP_PASID_DETACH,
> +	IOMMU_TEST_OP_PASID_CHECK_HWPT,
>  };
>  
>  enum {
> @@ -62,6 +66,9 @@ enum {
>  	MOCK_DEV_CACHE_NUM = 4,
>  };
>  
> +/* Reserved for special pasid replace test */
> +#define IOMMU_TEST_PASID_RESERVED 1024
> +
>  struct iommu_test_cmd {
>  	__u32 size;
>  	__u32 op;
> @@ -150,6 +157,25 @@ struct iommu_test_cmd {
>  		struct {
>  			__u32 dev_id;
>  		} trigger_vevent;
> +		struct {
> +			__u32 pasid;
> +			__u32 pt_id;
> +			/* @id is stdev_id */
> +		} pasid_attach;
> +		struct {
> +			__u32 pasid;
> +			__u32 pt_id;
> +			/* @id is stdev_id */
> +		} pasid_replace;
> +		struct {
> +			__u32 pasid;
> +			/* @id is stdev_id */
> +		} pasid_detach;
> +		struct {
> +			__u32 pasid;
> +			__u32 hwpt_id;
> +			/* @id is stdev_id */
> +		} pasid_check;
>  	};
>  	__u32 last;
>  };
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> index 04a4b84f5fa1..18d9a216eb30 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -167,6 +167,7 @@ struct mock_dev {
>  	unsigned long vdev_id;
>  	int id;
>  	u32 cache[MOCK_DEV_CACHE_NUM];
> +	atomic_t pasid_1024_fake_error;
>  };
>  
>  static inline struct mock_dev *to_mock_dev(struct device *dev)
> @@ -227,6 +228,34 @@ static int mock_domain_set_dev_pasid_nop(struct iommu_domain *domain,
>  					 struct device *dev, ioasid_t pasid,
>  					 struct iommu_domain *old)
>  {
> +	struct mock_dev *mdev = to_mock_dev(dev);
> +
> +	/*
> +	 * Per the first attach with pasid 1024, set the
> +	 * mdev->pasid_1024_fake_error. Hence the second call of this op
> +	 * can fake an error to validate the error path of the core. This
> +	 * is helpful to test the case in which the iommu core needs to
> +	 * rollback to the old domain due to driver failure. e.g. replace.
> +	 * User should be careful about the third call of this op, it shall
> +	 * succeed since the mdev->pasid_1024_fake_error is cleared in the
> +	 * second call.
> +	 */
> +	if (pasid == 1024) {
> +		if (domain->type == IOMMU_DOMAIN_BLOCKED) {
> +			atomic_set(&mdev->pasid_1024_fake_error, 0);
> +		} else if (atomic_read(&mdev->pasid_1024_fake_error)) {
> +			/*
> +			 * Clear the flag, and fake an error to fail the
> +			 * replacement.
> +			 */
> +			atomic_set(&mdev->pasid_1024_fake_error, 0);
> +			return -ENOMEM;
> +		} else {
> +			/* Set the flag to fake an error in next call */
> +			atomic_set(&mdev->pasid_1024_fake_error, 1);
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1685,6 +1714,131 @@ static int iommufd_test_trigger_vevent(struct iommufd_ucmd *ucmd,
>  	return rc;
>  }
>  
> +static inline struct iommufd_hw_pagetable *
> +iommufd_get_hwpt(struct iommufd_ucmd *ucmd, u32 id)
> +{
> +	struct iommufd_object *pt_obj;
> +
> +	pt_obj = iommufd_get_object(ucmd->ictx, id, IOMMUFD_OBJ_ANY);
> +	if (IS_ERR(pt_obj))
> +		return ERR_CAST(pt_obj);
> +
> +	if (pt_obj->type != IOMMUFD_OBJ_HWPT_NESTED &&
> +	    pt_obj->type != IOMMUFD_OBJ_HWPT_PAGING) {
> +		iommufd_put_object(ucmd->ictx, pt_obj);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return container_of(pt_obj, struct iommufd_hw_pagetable, obj);
> +}
> +
> +static int iommufd_test_pasid_check_hwpt(struct iommufd_ucmd *ucmd,
> +					 struct iommu_test_cmd *cmd)
> +{
> +	u32 hwpt_id = cmd->pasid_check.hwpt_id;
> +	struct iommu_domain *attached_domain;
> +	struct iommu_attach_handle *handle;
> +	struct iommufd_hw_pagetable *hwpt;
> +	struct selftest_obj *sobj;
> +	struct mock_dev *mdev;
> +	int rc = 0;
> +
> +	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
> +	if (IS_ERR(sobj))
> +		return PTR_ERR(sobj);
> +
> +	mdev = sobj->idev.mock_dev;
> +
> +	handle = iommu_attach_handle_get(mdev->dev.iommu_group,
> +					 cmd->pasid_check.pasid, 0);
> +	if (IS_ERR(handle))
> +		attached_domain = NULL;
> +	else
> +		attached_domain = handle->domain;
> +
> +	/* hwpt_id == 0 means to check if pasid is detached */
> +	if (!hwpt_id) {
> +		if (attached_domain)
> +			rc = -EINVAL;
> +		goto out_sobj;
> +	}
> +
> +	hwpt = iommufd_get_hwpt(ucmd, hwpt_id);
> +	if (IS_ERR(hwpt)) {
> +		rc = PTR_ERR(hwpt);
> +		goto out_sobj;
> +	}
> +
> +	if (attached_domain != hwpt->domain)
> +		rc = -EINVAL;
> +
> +	iommufd_put_object(ucmd->ictx, &hwpt->obj);
> +out_sobj:
> +	iommufd_put_object(ucmd->ictx, &sobj->obj);
> +	return rc;
> +}
> +
> +static int iommufd_test_pasid_attach(struct iommufd_ucmd *ucmd,
> +				     struct iommu_test_cmd *cmd)
> +{
> +	struct selftest_obj *sobj;
> +	int rc;
> +
> +	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
> +	if (IS_ERR(sobj))
> +		return PTR_ERR(sobj);
> +
> +	rc = iommufd_device_attach(sobj->idev.idev, cmd->pasid_attach.pasid,
> +				   &cmd->pasid_attach.pt_id);
> +	if (rc)
> +		goto out_sobj;
> +
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +	if (rc)
> +		iommufd_device_detach(sobj->idev.idev,
> +				      cmd->pasid_attach.pasid);
> +
> +out_sobj:
> +	iommufd_put_object(ucmd->ictx, &sobj->obj);
> +	return rc;
> +}
> +
> +static int iommufd_test_pasid_replace(struct iommufd_ucmd *ucmd,
> +				      struct iommu_test_cmd *cmd)
> +{
> +	struct selftest_obj *sobj;
> +	int rc;
> +
> +	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
> +	if (IS_ERR(sobj))
> +		return PTR_ERR(sobj);
> +
> +	rc = iommufd_device_replace(sobj->idev.idev, cmd->pasid_attach.pasid,
> +				    &cmd->pasid_attach.pt_id);
> +	if (rc)
> +		goto out_sobj;
> +
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +
> +out_sobj:
> +	iommufd_put_object(ucmd->ictx, &sobj->obj);
> +	return rc;
> +}
> +
> +static int iommufd_test_pasid_detach(struct iommufd_ucmd *ucmd,
> +				     struct iommu_test_cmd *cmd)
> +{
> +	struct selftest_obj *sobj;
> +
> +	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
> +	if (IS_ERR(sobj))
> +		return PTR_ERR(sobj);
> +
> +	iommufd_device_detach(sobj->idev.idev, cmd->pasid_detach.pasid);
> +	iommufd_put_object(ucmd->ictx, &sobj->obj);
> +	return 0;
> +}
> +
>  void iommufd_selftest_destroy(struct iommufd_object *obj)
>  {
>  	struct selftest_obj *sobj = to_selftest_obj(obj);
> @@ -1768,6 +1922,14 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
>  		return iommufd_test_trigger_iopf(ucmd, cmd);
>  	case IOMMU_TEST_OP_TRIGGER_VEVENT:
>  		return iommufd_test_trigger_vevent(ucmd, cmd);
> +	case IOMMU_TEST_OP_PASID_ATTACH:
> +		return iommufd_test_pasid_attach(ucmd, cmd);
> +	case IOMMU_TEST_OP_PASID_REPLACE:
> +		return iommufd_test_pasid_replace(ucmd, cmd);
> +	case IOMMU_TEST_OP_PASID_DETACH:
> +		return iommufd_test_pasid_detach(ucmd, cmd);
> +	case IOMMU_TEST_OP_PASID_CHECK_HWPT:
> +		return iommufd_test_pasid_check_hwpt(ucmd, cmd);
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> -- 
> 2.34.1
>
Hi Yi Liu,

Greetings!

I used Syzkaller and found that there is general protection fault in iommufd_hw_pagetable_detach in linux-next tag - next-20250325.

After bisection and the first bad commit is:
"
3d183bab95ea iommufd/selftest: Add test ops to test pasid attach/detach
"

The deadlock can still be reproduced. You could try following reproduction binary.

All detailed into can be found at:
https://github.com/laifryiee/syzkaller_logs/tree/main/250327_190630_iommufd_hw_pagetable_detach
Syzkaller repro code:
https://github.com/laifryiee/syzkaller_logs/tree/main/250327_190630_iommufd_hw_pagetable_detach/repro.c
Syzkaller repro syscall steps:
https://github.com/laifryiee/syzkaller_logs/tree/main/250327_190630_iommufd_hw_pagetable_detach/repro.prog
Syzkaller report:
https://github.com/laifryiee/syzkaller_logs/tree/main/250327_190630_iommufd_hw_pagetable_detach/repro.report
Kconfig(make olddefconfig):
https://github.com/laifryiee/syzkaller_logs/tree/main/250327_190630_iommufd_hw_pagetable_detach/kconfig_origin
Bisect info:
https://github.com/laifryiee/syzkaller_logs/tree/main/250327_190630_iommufd_hw_pagetable_detach/bisect_info.log
bzImage:
https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/250327_190630_iommufd_hw_pagetable_detach/bzImage_eb4bc4b07f66f01618d9cb1aa4eaef59b1188415
Issue dmesg:
https://github.com/laifryiee/syzkaller_logs/blob/main/250327_190630_iommufd_hw_pagetable_detach/eb4bc4b07f66f01618d9cb1aa4eaef59b1188415_dmesg.log

"
[   37.609031] iommufd_mock iommufd_mock0: Adding to iommu group 0
[   37.611696] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASI
[   37.613179] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[   37.614126] CPU: 1 UID: 0 PID: 668 Comm: repro Not tainted 6.14.0-next-20250325-eb4bc4b07f66 #1 PREEMPT(voluntary)
[   37.615361] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org4
[   37.616706] RIP: 0010:iommufd_hw_pagetable_detach+0x8a/0x4d0
[   37.617468] Code: 00 00 00 44 89 ee 48 89 c7 48 89 75 c8 48 89 45 c0 e8 ca 55 17 02 48 89 c2 49 89 c4 48 b8 00 00 00b
[   37.619613] RSP: 0018:ffff888021b17b78 EFLAGS: 00010246
[   37.620256] RAX: dffffc0000000000 RBX: ffff888014b5a000 RCX: ffff888021b17a64
[   37.621360] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88801dad07fc
[   37.623597] RBP: ffff888021b17bc8 R08: 0000000000000001 R09: 0000000000000001
[   37.625915] R10: 0000000000000001 R11: ffff88801dad0e58 R12: 0000000000000000
[   37.627802] R13: 0000000000000001 R14: ffff888021b17e18 R15: ffff8880132d3008
[   37.629383] FS:  00007fca52013600(0000) GS:ffff8880e3684000(0000) knlGS:0000000000000000
[   37.630955] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.631860] CR2: 00000000200006c0 CR3: 00000000112d0005 CR4: 0000000000770ef0
[   37.632941] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   37.633869] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   37.634740] PKRU: 55555554
[   37.635093] Call Trace:
[   37.635417]  <TASK>
[   37.635717]  ? show_regs+0x6d/0x80
[   37.636205]  ? die_addr+0x45/0xb0
[   37.636652]  ? exc_general_protection+0x1ad/0x340
[   37.637305]  ? asm_exc_general_protection+0x2b/0x30
[   37.637939]  ? iommufd_hw_pagetable_detach+0x8a/0x4d0
[   37.638589]  ? iommufd_hw_pagetable_detach+0x76/0x4d0
[   37.639256]  iommufd_device_detach+0x2a/0x2e0
[   37.639832]  iommufd_test+0x2f99/0x5cd0
[   37.640353]  ? __pfx_iommufd_test+0x10/0x10
[   37.640899]  ? __might_fault+0x14a/0x1b0
[   37.641443]  ? __this_cpu_preempt_check+0x21/0x30
[   37.642062]  ? lock_release+0x14f/0x2c0
[   37.642590]  ? __might_fault+0xf1/0x1b0
[   37.643104]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   37.643826]  iommufd_fops_ioctl+0x38e/0x520
[   37.644386]  ? __pfx_iommufd_fops_ioctl+0x10/0x10
[   37.644995]  ? __this_cpu_preempt_check+0x21/0x30
[   37.645598]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
[   37.646387]  ? lockdep_hardirqs_on+0x89/0x110
[   37.646954]  ? ktime_get_coarse_real_ts64+0xb6/0x100
[   37.647586]  ? __pfx_iommufd_fops_ioctl+0x10/0x10
[   37.648188]  __x64_sys_ioctl+0x1ba/0x220
[   37.648725]  x64_sys_call+0x122e/0x2150
[   37.649220]  do_syscall_64+0x6d/0x150
[   37.649703]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   37.650343] RIP: 0033:0x7fca51e3ee5d
[   37.650823] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d8
[   37.653042] RSP: 002b:00007ffc6ea0e9f8 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
[   37.653973] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fca51e3ee5d
[   37.654849] RDX: 0000000020000300 RSI: 0000000000003ba0 RDI: 0000000000000003
[   37.655725] RBP: 00007ffc6ea0ea10 R08: 0000000000000800 R09: 0000000000000800
[   37.656605] R10: 0000000000000800 R11: 0000000000000213 R12: 00007ffc6ea0eb28
[   37.657479] R13: 0000000000401136 R14: 0000000000403e08 R15: 00007fca5205c000
[   37.658381]  </TASK>
[   37.658683] Modules linked in:
[   37.659218] ---[ end trace 0000000000000000 ]---
[   37.659818] RIP: 0010:iommufd_hw_pagetable_detach+0x8a/0x4d0
[   37.660556] Code: 00 00 00 44 89 ee 48 89 c7 48 89 75 c8 48 89 45 c0 e8 ca 55 17 02 48 89 c2 49 89 c4 48 b8 00 00 00b
[   37.662822] RSP: 0018:ffff888021b17b78 EFLAGS: 00010246
[   37.663481] RAX: dffffc0000000000 RBX: ffff888014b5a000 RCX: ffff888021b17a64
[   37.664360] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88801dad07fc
[   37.665236] RBP: ffff888021b17bc8 R08: 0000000000000001 R09: 0000000000000001
[   37.666123] R10: 0000000000000001 R11: ffff88801dad0e58 R12: 0000000000000000
[   37.666997] R13: 0000000000000001 R14: ffff888021b17e18 R15: ffff8880132d3008
[   37.667866] FS:  00007fca52013600(0000) GS:ffff8880e3684000(0000) knlGS:0000000000000000
[   37.668857] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.669601] CR2: 00000000200006c0 CR3: 00000000112d0005 CR4: 0000000000770ef0
[   37.670482] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   37.671356] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   37.672228] PKRU: 55555554
[   37.673445] ------------[ cut here ]------------
[   37.674088] WARNING: CPU: 1 PID: 668 at drivers/iommu/iommufd/main.c:265 iommufd_fops_release+0x386/0x420
[   37.675253] Modules linked in:
[   37.675658] CPU: 1 UID: 0 PID: 668 Comm: repro Tainted: G      D             6.14.0-next-20250325-eb4bc4b07f66 #1 PR
[   37.677106] Tainted: [D]=DIE
[   37.677944] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org4
[   37.679312] RIP: 0010:iommufd_fops_release+0x386/0x420
[   37.679982] Code: 8b 45 d0 65 48 2b 05 f1 59 3a 05 75 76 48 81 c4 88 00 00 00 31 c0 5b 41 5c 41 5d 41 5e 41 5f 5d c3f
[   37.682261] RSP: 0018:ffff888021b17c08 EFLAGS: 00010293
[   37.682913] RAX: 0000000000000000 RBX: ffff88801b347808 RCX: ffffffff83afe4ca
[   37.683777] RDX: ffff88801dad0000 RSI: ffffffff83afe636 RDI: 0000000000000005
[   37.684644] RBP: ffff888021b17cb8 R08: 0000000000000000 R09: 0000000000000000
[   37.685213] R10: 0000000000000000 R11: ffff888017ef2130 R12: 0000000000000000
[   37.685802] R13: 0000000000000000 R14: ffff888021b17c50 R15: 0000000000000000
[   37.686378] FS:  0000000000000000(0000) GS:ffff8880e3684000(0000) knlGS:0000000000000000
[   37.686923] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.687320] CR2: 00000000200006c0 CR3: 0000000007086006 CR4: 0000000000770ef0
[   37.687812] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   37.688294] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   37.688849] PKRU: 55555554
[   37.689075] Call Trace:
[   37.689255]  <TASK>
[   37.689427]  ? show_regs+0x6d/0x80
[   37.689738]  ? __warn+0xf3/0x380
[   37.690011]  ? report_bug+0x25e/0x4b0
[   37.690311]  ? iommufd_fops_release+0x386/0x420
[   37.690672]  ? report_bug+0x2cb/0x4b0
[   37.690971]  ? iommufd_fops_release+0x386/0x420
[   37.691316]  ? iommufd_fops_release+0x386/0x420
[   37.691664]  ? handle_bug+0x2cd/0x510
[   37.691964]  ? iommufd_fops_release+0x388/0x420
[   37.692323]  ? exc_invalid_op+0x3c/0x80
[   37.692661]  ? asm_exc_invalid_op+0x1f/0x30
[   37.693007]  ? iommufd_fops_release+0x21a/0x420
[   37.693420]  ? iommufd_fops_release+0x386/0x420
[   37.693845]  ? iommufd_fops_release+0x386/0x420
[   37.694230]  ? iommufd_fops_release+0x386/0x420
[   37.694609]  ? locks_remove_file+0x3b4/0x5d0
[   37.694987]  ? __pfx_iommufd_fops_release+0x10/0x10
[   37.695372]  ? __memcg_slab_free_hook+0xc1/0x540
[   37.695758]  ? __sanitizer_cov_trace_const_cmp2+0x1c/0x30
[   37.696170]  ? evm_file_release+0x141/0x220
[   37.696526]  ? __pfx_iommufd_fops_release+0x10/0x10
[   37.696914]  __fput+0x41c/0xb70
[   37.697172]  ____fput+0x22/0x30
[   37.697423]  task_work_run+0x19b/0x2b0
[   37.697758]  ? __pfx_task_work_run+0x10/0x10
[   37.698115]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   37.698589]  ? switch_task_namespaces+0xc6/0x110
[   37.699065]  do_exit+0xb0e/0x29d0
[   37.699350]  ? ktime_get_coarse_real_ts64+0xb6/0x100
[   37.699743]  ? __pfx_do_exit+0x10/0x10
[   37.700072]  ? __pfx_iommufd_fops_ioctl+0x10/0x10
[   37.700454]  ? __x64_sys_ioctl+0x1ba/0x220
[   37.700795]  make_task_dead+0x181/0x3c0
[   37.701118]  rewind_stack_and_make_dead+0x16/0x20
[   37.701560] RIP: 0033:0x7fca51e3ee5d
[   37.701886] Code: Unable to access opcode bytes at 0x7fca51e3ee33.
[   37.702389] RSP: 002b:00007ffc6ea0e9f8 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
[   37.703008] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fca51e3ee5d
[   37.703594] RDX: 0000000020000300 RSI: 0000000000003ba0 RDI: 0000000000000003
[   37.704188] RBP: 00007ffc6ea0ea10 R08: 0000000000000800 R09: 0000000000000800
[   37.704787] R10: 0000000000000800 R11: 0000000000000213 R12: 00007ffc6ea0eb28
[   37.705380] R13: 0000000000401136 R14: 0000000000403e08 R15: 00007fca5205c000
[   37.705993]  </TASK>
[   37.706205] irq event stamp: 3011
[   37.706495] hardirqs last  enabled at (3011): [<ffffffff812e194b>] cond_local_irq_enable.isra.0+0x3b/0x50
[   37.707270] hardirqs last disabled at (3010): [<ffffffff85c6ecc6>] exc_general_protection+0x36/0x340
[   37.708008] softirqs last  enabled at (2704): [<ffffffff8149141e>] __irq_exit_rcu+0x10e/0x170
[   37.708728] softirqs last disabled at (2685): [<ffffffff8149141e>] __irq_exit_rcu+0x10e/0x170
[   37.709420] ---[ end trace 0000000000000000 ]---
[   37.709935] ------------[ cut here ]------------
[   37.710326] WARNING: CPU: 1 PID: 668 at drivers/iommu/iommufd/main.c:268 iommufd_fops_release+0x392/0x420
[   37.711053] Modules linked in:
[   37.711300] CPU: 1 UID: 0 PID: 668 Comm: repro Tainted: G      D W           6.14.0-next-20250325-eb4bc4b07f66 #1 PR
[   37.712216] Tainted: [D]=DIE, [W]=WARN
[   37.712560] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org4
[   37.713475] RIP: 0010:iommufd_fops_release+0x392/0x420
[   37.713926] Code: 76 48 81 c4 88 00 00 00 31 c0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 2a d6 d7 fd 0f 0b e9f
[   37.715439] RSP: 0018:ffff888021b17c08 EFLAGS: 00010293
[   37.715864] RAX: 0000000000000000 RBX: ffff88801b347808 RCX: ffffffff83afe4ca
[   37.716455] RDX: ffff88801dad0000 RSI: ffffffff83afe642 RDI: ffff88801b3478a0
[   37.717024] RBP: ffff888021b17cb8 R08: 0000000000000000 R09: 0000000000000000
[   37.717622] R10: 0000000000000000 R11: ffff888017ef2130 R12: 0000000000000000
[   37.718191] R13: 0000000000000000 R14: ffff888021b17c50 R15: 0000000000000000
[   37.718752] FS:  0000000000000000(0000) GS:ffff8880e3684000(0000) knlGS:0000000000000000
[   37.719393] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   37.719849] CR2: 00000000200006c0 CR3: 0000000007086006 CR4: 0000000000770ef0
[   37.720409] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   37.721007] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
[   37.721600] PKRU: 55555554
[   37.721847] Call Trace:
[   37.722061]  <TASK>
[   37.722260]  ? show_regs+0x6d/0x80
[   37.722568]  ? __warn+0xf3/0x380
[   37.722851]  ? report_bug+0x25e/0x4b0
[   37.723151]  ? iommufd_fops_release+0x392/0x420
[   37.723525]  ? report_bug+0x2cb/0x4b0
[   37.723835]  ? iommufd_fops_release+0x392/0x420
[   37.724203]  ? iommufd_fops_release+0x392/0x420
[   37.724586]  ? handle_bug+0x2cd/0x510
[   37.724880]  ? iommufd_fops_release+0x394/0x420
[   37.725253]  ? exc_invalid_op+0x3c/0x80
[   37.725576]  ? asm_exc_invalid_op+0x1f/0x30
[   37.725904]  ? iommufd_fops_release+0x21a/0x420
[   37.726249]  ? iommufd_fops_release+0x392/0x420
[   37.726607]  ? iommufd_fops_release+0x392/0x420
[   37.726969]  ? iommufd_fops_release+0x392/0x420
[   37.727392]  ? locks_remove_file+0x3b4/0x5d0
[   37.727736]  ? __pfx_iommufd_fops_release+0x10/0x10
[   37.728113]  ? __memcg_slab_free_hook+0xc1/0x540
[   37.728521]  ? __sanitizer_cov_trace_const_cmp2+0x1c/0x30
[   37.728974]  ? evm_file_release+0x141/0x220
[   37.729313]  ? __pfx_iommufd_fops_release+0x10/0x10
[   37.729708]  __fput+0x41c/0xb70
[   37.729991]  ____fput+0x22/0x30
[   37.730240]  task_work_run+0x19b/0x2b0
[   37.730579]  ? __pfx_task_work_run+0x10/0x10
[   37.730960]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   37.731415]  ? switch_task_namespaces+0xc6/0x110
[   37.731800]  do_exit+0xb0e/0x29d0
[   37.732100]  ? ktime_get_coarse_real_ts64+0xb6/0x100
[   37.732521]  ? __pfx_do_exit+0x10/0x10
[   37.732831]  ? __pfx_iommufd_fops_ioctl+0x10/0x10
[   37.733222]  ? __x64_sys_ioctl+0x1ba/0x220
[   37.733598]  make_task_dead+0x181/0x3c0
[   37.733917]  rewind_stack_and_make_dead+0x16/0x20
[   37.734306] RIP: 0033:0x7fca51e3ee5d
[   37.734605] Code: Unable to access opcode bytes at 0x7fca51e3ee33.
[   37.735106] RSP: 002b:00007ffc6ea0e9f8 EFLAGS: 00000213 ORIG_RAX: 0000000000000010
[   37.735694] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fca51e3ee5d
[   37.736276] RDX: 0000000020000300 RSI: 0000000000003ba0 RDI: 0000000000000003
[   37.736848] RBP: 00007ffc6ea0ea10 R08: 0000000000000800 R09: 0000000000000800
[   37.737425] R10: 0000000000000800 R11: 0000000000000213 R12: 00007ffc6ea0eb28
[   37.738025] R13: 0000000000401136 R14: 0000000000403e08 R15: 00007fca5205c000
[   37.738624]  </TASK>
[   37.738815] irq event stamp: 3011
[   37.739103] hardirqs last  enabled at (3011): [<ffffffff812e194b>] cond_local_irq_enable.isra.0+0x3b/0x50
[   37.739855] hardirqs last disabled at (3010): [<ffffffff85c6ecc6>] exc_general_protection+0x36/0x340
[   37.740563] softirqs last  enabled at (2704): [<ffffffff8149141e>] __irq_exit_rcu+0x10e/0x170
[   37.741219] softirqs last disabled at (2685): [<ffffffff8149141e>] __irq_exit_rcu+0x10e/0x170
[   37.741868] ---[ end trace 0000000000000000 ]---
"

Hope this cound be insightful to you.

Regards,
Yi Lai

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install 
