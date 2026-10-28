Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793178317;
	b=ILNk3EDincOWxo6xTM7C6rKwdKpNRKMrCzVhDOm4rq9Y6/f1/AQQSkit+5nWiL8NKNAf
	 qEpq6yLsInz2ZrZOXZEbyIobkai2j/InauXN51fBw0rIqmwrRieVJut16CDZ/Y+2LL4F5
	 vXHTgjFOy7ldt0Ei9kXuURD3YrHn8wb7YMtptsfsoMgN7s9Ur+zvjykF3tgA0WIkyvaWs
	 GuAMSxDV/XC4MxHid38mn5aDUpzxBhBwftDhkjScLyz9cy5pAdnEf5evvuXpidNput9CD
	 uSHySD8vt99RxgAz8YFKXoMH/UlBXUwgv1aIxsMwVVsITLYtd+0QUk0fyJxkUUxc12A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178317;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A3Q3JYcJRza5XIGn/OA+MqPP5Jy1mnzgW0Ucr2pQP+o=;
	b=Xzbdjcy+/ylFDo7V26Y84LJdhaz6DfpQbiSl+detASOEt5mExuNwK7ZPq+d+FKjdSsKY
	 0PJUzgZQSEW1YsVYXYAAeRzAOMS+T/h6LV0YPhDzWe5101z6zb46AbGqQ1OylqPq7Zwnb
	 HywgzZ7iOiprQwR3tTREQ7Ho/mtBpiUFFtDXel1+9uXUrZIwJeP8HRgJPrmz0ueVwaP47
	 pum0Nkyz/unAkEdadfik8jw0sRmKvCj2EvXbWoA/W/zErV3MBKKVub2z/6CseVrsRGl1a
	 FFyf+jwUnm0GrdRFblrzWtckNry/BZZ2lMAwScqbJ/re9ctQsbzdWb3vwpEmZnOZRcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HkU6rdPC;
	arc=none smtp.remote-ip=115.124.30.100
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9799D606A325
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 09:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9799D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HkU6rdPC
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793178308; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=A3Q3JYcJRza5XIGn/OA+MqPP5Jy1mnzgW0Ucr2pQP+o=;
	b=HkU6rdPCzKGnDAk2F4Vy2PmbqdZNwUx+uEXOuriFx2FGzBQCnrmP/XX21yF1PT/Ju8Q8b0WOUvTvsNtLHfAsYyTrfQavsubULeaW7bLx8JqN7Re5GVw87Q61z5nxISS5224VvnnrfZQsxLkGCrWgdvpmJMu6MG38ym26OfOTuVQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XDgOuFZ_1793178307;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XDgOuFZ_1793178307 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 28 Oct 2026 17:05:07 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: jgg@ziepe.ca
Cc: alex@shazbot.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	kevin.tian@intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robin.murphy@arm.com,
	will@kernel.org
Subject: [PATCH v6 3/3] iommufd: Add IOMMU_IOAS_RESERVE_IOVAS ioctl
Date: Wed, 28 Oct 2026 17:04:53 +0800
Message-ID: <20261028090453.2392991-4-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261028090453.2392991-1-guanghuifeng@linux.alibaba.com>
References: <20261028071906.2325378-1-guanghuifeng@linux.alibaba.com>
 <20261028090453.2392991-1-guanghuifeng@linux.alibaba.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an ioctl allowing userspace to reserve IOVA ranges in an IOAS,
creating a restriction on the address space: reserved ranges are
excluded from IOMMU_IOAS_IOVA_RANGES and rejected by mapping
operations.

This completes the opt-in flow for the kernel's reservation
recommendations: userspace queries IOMMU_GET_RECOMMENDED_RESERVATIONS
for a device, decides which ranges to honour, and feeds them back
through this ioctl so the kernel enforces them on its behalf.  Both
steps are optional; nothing changes for userspace that does not use
them.

The semantics mirror the existing internal users of
iopt_reserve_iova(): ranges conflicting with existing mappings or
allowed IOVAs fail with -EADDRINUSE, and overlapping reservations are
permitted so that recommendations queried for several devices behind
the same host bridge can each be reserved independently.  User
reservations carry a NULL owner and live until the IOAS is destroyed;
accordingly the NULL-owner cleanup in iopt_destroy_table() is no
longer conditional on CONFIG_IOMMUFD_TEST, since production userspace
can now create such reservations.

On failure the leading ranges already inserted stay reserved; because
overlaps are permitted, retrying the whole call is idempotent.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 drivers/iommu/iommufd/io_pagetable.c    |  7 +++-
 drivers/iommu/iommufd/ioas.c            | 51 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            |  3 ++
 include/uapi/linux/iommufd.h            | 35 +++++++++++++++++
 5 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 5ac736cf5bb5..9a10daf6491e 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1036,8 +1036,11 @@ void iopt_destroy_table(struct io_pagetable *iopt)
 {
 	struct interval_tree_node *node;
 
-	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
-		iopt_remove_reserved_iova(iopt, NULL);
+	/*
+	 * Reservations made by userspace through IOMMU_IOAS_RESERVE_IOVAS
+	 * carry a NULL owner and live until the IOAS is destroyed.
+	 */
+	iopt_remove_reserved_iova(iopt, NULL);
 
 	while ((node = interval_tree_iter_first(&iopt->allowed_itree, 0,
 						ULONG_MAX))) {
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 8fb5271a9506..1a2361850bd2 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -183,6 +183,57 @@ int iommufd_ioas_allow_iovas(struct iommufd_ucmd *ucmd)
 	return rc;
 }
 
+int iommufd_ioas_reserve_iovas(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_ioas_reserve_iovas *cmd = ucmd->cmd;
+	struct iommu_iova_range __user *ranges;
+	struct iommufd_ioas *ioas;
+	u32 i;
+	int rc;
+
+	if (cmd->flags)
+		return -EOPNOTSUPP;
+
+	ioas = iommufd_get_ioas(ucmd->ictx, cmd->ioas_id);
+	if (IS_ERR(ioas))
+		return PTR_ERR(ioas);
+
+	ranges = u64_to_user_ptr(cmd->ranges);
+
+	down_write(&ioas->iopt.iova_rwsem);
+	for (i = 0; i < cmd->num_ranges; i++) {
+		struct iommu_iova_range range;
+
+		rc = copy_from_user(&range, &ranges[i], sizeof(range));
+		if (rc) {
+			rc = -EFAULT;
+			goto out_unlock;
+		}
+		if (range.last < range.start) {
+			rc = -EINVAL;
+			goto out_unlock;
+		}
+		if (range.start >= ULONG_MAX || range.last >= ULONG_MAX) {
+			rc = -EOVERFLOW;
+			goto out_unlock;
+		}
+
+		rc = iopt_reserve_iova(&ioas->iopt, range.start, range.last,
+				       NULL);
+		if (rc)
+			goto out_unlock;
+	}
+	up_write(&ioas->iopt.iova_rwsem);
+
+	iommufd_put_object(ucmd->ictx, &ioas->obj);
+	return 0;
+
+out_unlock:
+	up_write(&ioas->iopt.iova_rwsem);
+	iommufd_put_object(ucmd->ictx, &ioas->obj);
+	return rc;
+}
+
 static int conv_iommu_prot(u32 map_flags)
 {
 	/*
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 8016c3efca78..361223372cf3 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -356,6 +356,7 @@ int iommufd_ioas_map(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_copy(struct iommufd_ucmd *ucmd);
+int iommufd_ioas_reserve_iovas(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd);
 #ifdef CONFIG_IOMMUFD_NOIOMMU
 int iommufd_ioas_noiommu_get_pa(struct iommufd_ucmd *ucmd);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 85f8ea154218..ea03a2078a37 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -447,6 +447,7 @@ union ucmd_buffer {
 	struct iommu_ioas_noiommu_get_pa noiommu_get_pa;
 	struct iommu_ioas_iova_ranges iova_ranges;
 	struct iommu_ioas_map map;
+	struct iommu_ioas_reserve_iovas ioas_reserve_iovas;
 	struct iommu_ioas_unmap unmap;
 	struct iommu_option option;
 	struct iommu_recommended_reservations recommended_reservations;
@@ -509,6 +510,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 struct iommu_ioas_map_file, iova),
 	IOCTL_OP(IOMMU_IOAS_NOIOMMU_GET_PA, iommufd_ioas_noiommu_get_pa, struct iommu_ioas_noiommu_get_pa,
 		 out_phys),
+	IOCTL_OP(IOMMU_IOAS_RESERVE_IOVAS, iommufd_ioas_reserve_iovas,
+		 struct iommu_ioas_reserve_iovas, ranges),
 	IOCTL_OP(IOMMU_IOAS_UNMAP, iommufd_ioas_unmap, struct iommu_ioas_unmap,
 		 length),
 	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option, val64),
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 45ba7bd7abd5..f6591c42ad5c 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -59,6 +59,7 @@ enum {
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
 	IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA = 0x95,
 	IOMMUFD_CMD_GET_RECOMMENDED_RESERVATIONS = 0x96,
+	IOMMUFD_CMD_IOAS_RESERVE_IOVAS = 0x97,
 };
 
 /**
@@ -1436,4 +1437,38 @@ struct iommu_recommended_reservations {
 };
 #define IOMMU_GET_RECOMMENDED_RESERVATIONS \
 	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_GET_RECOMMENDED_RESERVATIONS)
+
+/**
+ * struct iommu_ioas_reserve_iovas - ioctl(IOMMU_IOAS_RESERVE_IOVAS)
+ * @size: sizeof(struct iommu_ioas_reserve_iovas)
+ * @flags: Must be 0
+ * @ioas_id: IOAS ID to reserve ranges in
+ * @num_ranges: Number of ranges in the input array
+ * @ranges: Pointer to the input array of struct iommu_iova_range
+ *
+ * Reserve IOVA ranges in an IOAS, excluding them from mapping and from
+ * IOMMU_IOAS_IOVA_RANGES.  Intended for opting into the ranges
+ * reported by IOMMU_GET_RECOMMENDED_RESERVATIONS.
+ *
+ * Reserve before mapping: a range overlapping an existing mapping or
+ * an allowed IOVA range fails with -EADDRINUSE.  Overlapping
+ * reservations are permitted, so ranges recommended for multiple
+ * devices (e.g. behind the same host bridge) can each be reserved.
+ * A range with last < start fails with -EINVAL.  On 32-bit kernels
+ * a range exceeding the native address width fails with -EOVERFLOW.
+ * Ranges are processed in order and earlier ranges stay reserved on
+ * failure; retrying the whole call is safe.  Reservations live until
+ * the IOAS is destroyed.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+struct iommu_ioas_reserve_iovas {
+	__u32 size;
+	__u32 flags;
+	__u32 ioas_id;
+	__u32 num_ranges;
+	__aligned_u64 ranges;
+};
+#define IOMMU_IOAS_RESERVE_IOVAS \
+	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_RESERVE_IOVAS)
 #endif
-- 
2.43.7

