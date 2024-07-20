Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19991474C8
	for <iommu@lists.linux.dev>; Sat, 20 Jul 2024 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721501812; cv=none; b=DExJorXDr4u4K0Xr4u2KtP3ac4MXdEsBXqIcTv8iluSU4OGhOZl1M//u93WMxhrtgrDT5kA9Wir5rXuY6iZxf6z3ozk1OeCYIFfNHuDOA8+h1cXfeFlhbzOjAdFzENTO0eKl7Et0kmFw/Xq6Wil/8iTklWCQq0hR3SNbQVNWC58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721501812; c=relaxed/simple;
	bh=Qp2+5qLHE1sQYgQI+mgZxwuhy+c5gJQgcxzx57qp3fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fMdDcBnHC21as+QvBLABgrSJlI7dWTddGJrXTZ4XKpXBiuatMMJJ2TmXMYc1m1BN5bloltx82/BdRaSvW2W/sBe4kTIX03Po649CLGztEsnsP1Thji+XurNO1Bu35JDW3jhMIUg6T3nTDTJmQNPLI6UXgRw9cWmMV9/qf2BcViw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BWJNJHfS; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BWJNJHfS"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KIuOmJ006924;
	Sat, 20 Jul 2024 18:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=bEm4lxvfiCnlGjN3ExOhTO+St4Fd6j7G5xopPTfhiOQ=; b=
	BWJNJHfSdbRTMZEE6MqBUKvBQO5Ib4t85iBP7aHTl/2IQl5unVXwhRTz+2HtrRz7
	1BxYsEY7qkFdyz16SOhxrKzzzwBxzLl1o0Jpu33pxT5SiddvTZZlle6K/XxaIYFV
	9hirh8XiQwAoZSIxcsmnDN+WnyokDv8CpgwlGe5yMPZfI3noMhcJ0juEbUffPcOZ
	rUT28OA2BJY25MxKByQKOl/RyA3Rl1amdM7oJIDYLs+FV1Vdk6pzEIvFeUcvQtT+
	w/Zpvnhbz5bUtPxFoOh4ymbctX0Wn3qR5ACA4GHdvWrF3h3YdwNnLl7ntfNAH2na
	t/Xxnxh1/m/LJQMhNccVzA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gjxhg00s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 18:56:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46KHwPn8024469;
	Sat, 20 Jul 2024 18:56:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40g3p5xgbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 18:56:47 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46KIukDD032989;
	Sat, 20 Jul 2024 18:56:47 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40g3p5xgb0-3;
	Sat, 20 Jul 2024 18:56:47 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1] iommufd debug print
Date: Sat, 20 Jul 2024 11:56:42 -0700
Message-Id: <1721501805-86928-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
References: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_16,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200138
X-Proofpoint-GUID: CpdkaLGyWeA0uzEldRTmC57RkOUrPkYu
X-Proofpoint-ORIG-GUID: CpdkaLGyWeA0uzEldRTmC57RkOUrPkYu
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

---
 drivers/iommu/iommufd/ioas.c  | 71 ++++++++++++++++++++++++++++++++++++++++---
 drivers/iommu/iommufd/main.c  |  6 +++-
 drivers/iommu/iommufd/pages.c | 10 ++++--
 drivers/vfio/group.c          |  1 +
 4 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 5d23bdd..7b6a73b 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -329,9 +329,14 @@ static void iommufd_release_all_iova_rwsem(struct iommufd_ctx *ictx,
 	struct iommufd_ioas *ioas;
 	unsigned long index;
 
+	printk("iommufd: %s\n", __func__);
 	xa_for_each(ioas_list, index, ioas) {
+		printk("up_write for ioas %px index %ld rwsem %px\n",
+			ioas, index, &ioas->iopt.iova_rwsem);
 		up_write(&ioas->iopt.iova_rwsem);
 		refcount_dec(&ioas->obj.users);
+		printk("obj->users refcount after is %d\n",
+			refcount_read(&ioas->obj.users));
 	}
 	up_write(&ictx->ioas_creation_lock);
 	xa_destroy(ioas_list);
@@ -344,6 +349,7 @@ static int iommufd_take_all_iova_rwsem(struct iommufd_ctx *ictx,
 	unsigned long index;
 	int rc;
 
+	printk("iommufd: %s\n", __func__);
 	/*
 	 * This is very ugly, it is done instead of adding a lock around
 	 * pages->source_mm, which is a performance path for mdev, we just
@@ -362,19 +368,30 @@ static int iommufd_take_all_iova_rwsem(struct iommufd_ctx *ictx,
 	xa_for_each(&ictx->objects, index, obj) {
 		struct iommufd_ioas *ioas;
 
-		if (!obj || obj->type != IOMMUFD_OBJ_IOAS)
+		printk("obj %px type %d index %ld\n",
+			obj, obj ? obj->type : -1, index);
+		if (!obj || obj->type != IOMMUFD_OBJ_IOAS) {
+			printk("skip wrong type\n");
 			continue;
+		}
 
-		if (!refcount_inc_not_zero(&obj->users))
+		printk("obj->users refcount before is %d\n",
+			refcount_read(&obj->users));
+		if (!refcount_inc_not_zero(&obj->users)) {
+			printk("skip !refcount_inc_not_zero\n");
 			continue;
+		}
 
 		xa_unlock(&ictx->objects);
 
 		ioas = container_of(obj, struct iommufd_ioas, obj);
 		down_write(&ioas->iopt.iova_rwsem);
+		printk("down_write for ioas %px index %ld rwsem %px\n",
+			ioas, index, &ioas->iopt.iova_rwsem);
 
 		rc = xa_err(xa_store(ioas_list, index, ioas, GFP_KERNEL));
 		if (rc) {
+			printk("xa_store failed!!\n");
 			lockdep_on();
 			iommufd_release_all_iova_rwsem(ictx, ioas_list);
 			return rc;
@@ -389,23 +406,38 @@ static int iommufd_take_all_iova_rwsem(struct iommufd_ctx *ictx,
 
 static bool need_charge_update(struct iopt_pages *pages)
 {
+	printk("iommufd: %s mode %u: %sgroup_leader, src pid %d cur pid %d,"
+		"src mm %px cur mm %px, src user %px cur user %px\n",
+		__func__, pages->account_mode,
+		pages->source_task == current->group_leader ? "is " : "not ",
+		pages->source_task->pid, current->group_leader->pid,
+		pages->source_mm, current->mm,
+		pages->source_user, current_user());
+
 	if (pages->source_task == current->group_leader &&
 	    pages->source_mm == current->mm &&
 	    pages->source_user == current_user()) {
+		printk("same mm and user, return false\n");
 		return false;
 	}
 
 	switch (pages->account_mode) {
 	case IOPT_PAGES_ACCOUNT_NONE:
+		printk("accounting disabled, return false\n");
 		return false;
 	case IOPT_PAGES_ACCOUNT_USER:
-		if (pages->source_user == current_user())
+		if (pages->source_user == current_user()) {
+			printk("same user, return false\n");
 			return false;
+		}
 		break;
 	case IOPT_PAGES_ACCOUNT_MM:
-		if (pages->source_mm == current->mm)
+		if (pages->source_mm == current->mm) {
+			printk("same mm, return false\n");
 			return false;
+		}
 	}
+	printk("iommufd: %s mode %u returns true\n", __func__, pages->account_mode);
 	return true;
 }
 
@@ -425,6 +457,8 @@ static int charge_current(unsigned long *npinned)
 			continue;
 
 		tmp.account_mode = account_mode;
+		printk("iommufd: call update_pinned mode %u %lu inc=true\n",
+			account_mode, npinned[account_mode]);
 		rc = iopt_update_pinned(&tmp, npinned[account_mode], true,
 					NULL);
 		if (rc)
@@ -436,6 +470,8 @@ static int charge_current(unsigned long *npinned)
 	while (account_mode != 0) {
 		account_mode--;
 		tmp.account_mode = account_mode;
+		printk("iommufd: call do_update_pinned mode %u %lu inc=false\n",
+			account_mode, npinned[account_mode]);
 		iopt_update_pinned(&tmp, npinned[account_mode], false, NULL);
 	}
 	return rc;
@@ -447,6 +483,12 @@ static void change_mm(struct iopt_pages *pages)
 	struct user_struct *old_user = pages->source_user;
 	struct mm_struct *old_mm = pages->source_mm;
 
+	printk("iommufd: %s from pid %d user %px mm %px "
+		"to pid %d user %px mm %px\n",
+		__func__,
+		old_task->pid, old_user, old_mm,
+		current->group_leader->pid, current_user(), current->mm);
+
 	pages->source_mm = current->mm;
 	mmgrab(pages->source_mm);
 	mmdrop(old_mm);
@@ -468,6 +510,7 @@ static int iommufd_get_umap(struct iommu_ioas_change_process *cmd,
 	int len = cmd->n_umap * sizeof(**p_umap);
 	struct iommu_ioas_userspace_map *umap = kzalloc(len, GFP_KERNEL);
 
+	printk("iommufd: %s\n", __func__);
 	if (!umap)
 		return -ENOMEM;
 
@@ -486,6 +529,7 @@ static int iommufd_get_umap(struct iommu_ioas_change_process *cmd,
 		}
 	}
 	*p_umap = umap;
+	printk("iommufd: %s returns\n", __func__);
 	return 0;
 }
 
@@ -509,9 +553,18 @@ static int pages_validate_userspace(struct iopt_pages *pages,
 	struct iommu_ioas_userspace_map *newaddr;
 	size_t pages_size = pages->npages * PAGE_SIZE;
 
+	printk("iommufd: %s: uptr = %px, size = %ld\n",
+		__func__, pages->uptr, pages_size);
+
 	if (!n_umap)
 		return 0;
 	newaddr = bsearch(pages->uptr, umap, n_umap, sizeof(*umap), cmp_addr);
+	if (!newaddr || pages_size > newaddr->size) {
+		if (newaddr)
+			printk("umap invalid: new size %llx\n", newaddr->size);
+		else
+			printk("umap invalid: newaddr not found\n");
+	}
 	if (!newaddr || pages_size > newaddr->size)
 		return -EINVAL;
 	return 0;
@@ -522,11 +575,15 @@ static void pages_update_userspace(struct iopt_pages *pages,
 				   int n_umap)
 {
 	struct iommu_ioas_userspace_map *newaddr;
+	size_t pages_size = pages->npages * PAGE_SIZE;
+	void *uptr = pages->uptr;
 
 	if (!n_umap)
 		return;
 	newaddr = bsearch(pages->uptr, umap, n_umap, sizeof(*umap), cmp_addr);
 	pages->uptr += newaddr->addr_new - newaddr->addr_old;
+	printk("iommufd: %s: uptr = %px, size = %ld -> new uptr %px\n",
+		__func__, uptr, pages_size, pages->uptr);
 }
 
 #define for_each_ioas_area(_xa, _index, _ioas, _area) \
@@ -548,6 +605,8 @@ int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd)
 	unsigned long index;
 	int rc;
 
+	printk("iommufd: %s\n", __func__);
+
 	if (cmd->flags || cmd->__reserved)
 		return -EOPNOTSUPP;
 
@@ -582,6 +641,9 @@ int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd)
 		}
 	}
 
+	printk("iommufd: all_npinned = %ld, %ld, %ld\n",
+		all_npinned[0], all_npinned[1], all_npinned[2]);
+
 	rc = charge_current(all_npinned);
 
 	if (rc) {
@@ -607,6 +669,7 @@ int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd)
 
 out_no_release:
 	kfree(umap);
+	printk("iommufd: %s returns\n", __func__);
 	return rc;
 }
 
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index f8a2736..9a777b2 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -165,6 +165,7 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
 			 * defer cleaning this object until close.
 			 */
 			refcount_dec(&to_destroy->users);
+			printk("iommufd_object_remove bug? ret %d\n", ret);
 			return ret;
 		}
 		zerod_shortterm = true;
@@ -204,8 +205,10 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
 	 */
 	if (!zerod_shortterm) {
 		ret = iommufd_object_dec_wait_shortterm(ictx, obj);
-		if (WARN_ON(ret))
+		if (WARN_ON(ret)) {
+			printk("iommufd_object_remove bug 2? ret %d\n", ret);
 			return ret;
+		}
 	}
 
 	iommufd_object_ops[obj->type].destroy(obj);
@@ -213,6 +216,7 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
 	return 0;
 
 err_xa:
+	printk("iommufd_object_remove err_xa ret %d\n", ret);
 	if (zerod_shortterm) {
 		/* Restore the xarray owned reference */
 		refcount_set(&obj->shortterm_users, 1);
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 2366c15..d17178e4 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -812,8 +812,11 @@ static int incr_user_locked_vm(struct iopt_pages *pages, unsigned long npages)
 	do {
 		cur_pages = atomic_long_read(&pages->source_user->locked_vm);
 		new_pages = cur_pages + npages;
-		if (new_pages > lock_limit)
+		if (new_pages > lock_limit) {
+			pr_info("%s new_pages=%ld limit=%ld src pid=%d\n",
+				__func__, new_pages, lock_limit, pages->source_task->pid);
 			return -ENOMEM;
+		}
 	} while (atomic_long_cmpxchg(&pages->source_user->locked_vm, cur_pages,
 				     new_pages) != cur_pages);
 	return 0;
@@ -821,8 +824,11 @@ static int incr_user_locked_vm(struct iopt_pages *pages, unsigned long npages)
 
 static void decr_user_locked_vm(struct iopt_pages *pages, unsigned long npages)
 {
-	if (WARN_ON(atomic_long_read(&pages->source_user->locked_vm) < npages))
+	if (WARN_ON(atomic_long_read(&pages->source_user->locked_vm) < npages)){
+		pr_info("%s locked_vm=%ld < npages=%ld\n",
+			__func__, atomic_long_read(&pages->source_user->locked_vm), npages);
 		return;
+	}
 	atomic_long_sub(npages, &pages->source_user->locked_vm);
 }
 
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 610a429..8197695 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -147,6 +147,7 @@ static int vfio_group_ioctl_set_container(struct vfio_group *group,
 		group->iommufd = iommufd;
 		goto out_unlock;
 	}
+    pr_info("container %px has iommufd %px\n", container, iommufd);
 
 	/* The FD passed is not recognized. */
 	ret = -EBADFD;
-- 
1.8.3.1

