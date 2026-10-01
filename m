Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992753B71DB
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894797; cv=none; b=Hud8Z5/DXBIMY4nv2Dq2rJ6CSAq5O+1RlOVe1uqwdv/NxM8a/JX+TF3n07YkyDqy7wYIU2MwZelI8xLE84+6QePxx/s/W6jDaUR2UnFy9hyJIp8HRNE+7mCgLjPJXELKD7UtKluZ/bOxdW9TViK9nOtm3PqEGyuOwv032msYPwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894797; c=relaxed/simple;
	bh=86j92cbC3iIQ8k+p6+INK1oIddVu6Aw92n3P5/8hIIs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z9MUUOtpRO9ORK/FO0f3cJnAVilugdoQE2fMvFExgESV7Kf1JrOXy1pf21d7OcBKITDBc4SAukm0Zdx0mCOlWmVn2/8ns8svmdXL8yXEsCY0+ik6eyJXQzUVL+Zy+JlvRcMK2EkOnv5CP4VbxOuM/oYQ2KfOcYKa+YNHuXGsRcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zgrwan3W; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zgrwan3W"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-880babf652aso1146049b3a.1
        for <iommu@lists.linux.dev>; Thu, 01 Oct 2026 15:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790894795; x=1791499595; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t2x7W5ngZlu/3nFvkA6yuMRWlRxfxLLOhPqXvdVf5w0=;
        b=Zgrwan3WyPE8/Zjk/sJQB/Ed7ML2T0yyJ9uODi5q3BmiEIRF7KZo4vfCpoK2dwzYBJ
         m2e1uyZHDswDbPBfqfAk9mmSsEbW5V1NnBGHSwNIcdfV0oCqpckVUBORNJh+4/+zqM7u
         AGIQnx9RIzba1VBiXnmNvijRyhvkp+WF/U/yGhMOiCmt8WkzQRPeJtT/ez6vW96CX1ox
         TpwqKvPCoWX+skUUGSexwbaFYBR41zIpr+Ah8L9eUG8fYdqCZpK6xmIHdRAhSlmMXfR0
         qceWDLQ8uu/TtxomIx7TNpAPui78+TOZxClNifNOyu/so6Uqcd4MeQGja/xLycZHLWDp
         DEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790894795; x=1791499595;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t2x7W5ngZlu/3nFvkA6yuMRWlRxfxLLOhPqXvdVf5w0=;
        b=x8vK48MZJMroTTsIUzY+q4iT0aJxucmjKRwJiKsChUgZDxMjtWPwOP6Ine7hkYHjdk
         AJASAmyiLENqhQazEvvAxYatp9edKaqmHydYXUHY8+Be7YhZ5QeEX1VLjzs/gPEgUYw4
         OxmFL18gHgnKB0BWDoXhS5B56PoYDyPI9vuMaf90hR/auhXnZF4D2Gs6OVRMvX5o8ulK
         zpMl/P3SwsZJ+FvHfcxVQiRRii6lSdpTIokjHNhScI7Nf5cIlwnmuFo6DOgaLUHq57iS
         oBVmz8V6Y5GEIXT5Bn1l8DG/Y814eD0ypzKt///BIPuzhMJKJxKo2ShilYXk43kCVCiV
         vqvw==
X-Forwarded-Encrypted: i=1; AKwUvBwlX+nu4mgXlXkzwgl41vsiVVjUAgBRtAHuFSfDz7qqhAgk/W0SD8L1nzYbPMT3CEbkmbHVfA==@lists.linux.dev
X-Gm-Message-State: AFuF++l9xT0z/PcSppFJbkeZC6eNZorHf/pMR2h0kF8AF+H4/xcnldgq
	Cmv+6IrXrCZP15UUPtWf1F9rrpMNinokA6fv4iS+28Ul+JyIwj++uS6ic3UzTY1hbM56QcjQWVG
	YdA==
X-Received: from pfiu5.prod.google.com ([2002:a05:6a00:1245:b0:880:ddbf:45a4])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1903:b0:886:af7d:f0ef
 with SMTP id d2e1a72fcca58-88af476b157mr613518b3a.6.1790894794627; Thu, 01
 Oct 2026 15:46:34 -0700 (PDT)
Date: Thu,  1 Oct 2026 22:45:28 +0000
In-Reply-To: <20261001224531.765278-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261001224531.765278-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001224531.765278-5-praan@google.com>
Subject: [RFC PATCH 4/7] vfio/type1: Expose IO page table usage via fdinfo
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Logan Odell <loganodell@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Logan Odell <loganodell@google.com>

Collect the IO page table usage statistics from each IOMMU domain
attached to a legacy VFIO container and expose that data to userspace via
the new iommu-nr-pages field in fdinfo.

Introduce and implement the get_nr_pages callback for vfio-iommu-type1,
that iterates over all attached domains and aggregates their nr_pages
counters.

Only domains whose page table is implemented by the generic_pt library
account their page table memory. If any domain attached to the container
does not, get_nr_pages() returns -EOPNOTSUPP and the field is omitted
instead of reporting a partial count.

Document the new field in Documentation/filesystems/proc.rst.

Signed-off-by: Logan Odell <loganodell@google.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 Documentation/filesystems/proc.rst | 17 +++++++++++++++++
 drivers/vfio/container.c           | 21 +++++++++++++++++++++
 drivers/vfio/vfio.h                |  2 ++
 drivers/vfio/vfio_iommu_type1.c    | 21 +++++++++++++++++++++
 4 files changed, 61 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index c102b62023cd..2d06c9930fcf 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -2200,6 +2200,23 @@ VFIO Device files
 where 'vfio-device-syspath' is the sysfs path corresponding to the VFIO device
 file.
 
+VFIO Container files
+~~~~~~~~~~~~~~~~~~~~
+
+::
+
+	pos:	0
+	flags:	02000002
+	mnt_id:	17
+	ino:	1103
+	iommu-nr-pages:	11
+
+where 'iommu-nr-pages' is the number of pages of memory used by the IO page
+tables of all IOMMU domains attached to the container. It is omitted when no
+IOMMU backend is set, or when any attached domain does not account its IO page
+table memory. Currently only domains using the generic_pt page table library
+account their IO page table memory.
+
 3.9	/proc/<pid>/map_files - Information about memory mapped files
 ---------------------------------------------------------------------
 This directory contains symbolic links which represent memory mapped files
diff --git a/drivers/vfio/container.c b/drivers/vfio/container.c
index 003281dbf8bc..2cb6c5373626 100644
--- a/drivers/vfio/container.c
+++ b/drivers/vfio/container.c
@@ -7,6 +7,7 @@
 #include <linux/file.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
+#include <linux/seq_file.h>
 #include <linux/capability.h>
 #include <linux/iommu.h>
 #include <linux/miscdevice.h>
@@ -384,12 +385,32 @@ static int vfio_fops_release(struct inode *inode, struct file *filep)
 	return 0;
 }
 
+#ifdef CONFIG_PROC_FS
+static void vfio_fops_show_fdinfo(struct seq_file *m, struct file *filep)
+{
+	struct vfio_container *container = filep->private_data;
+	long nr_pages = -EOPNOTSUPP;
+
+	down_read(&container->group_lock);
+	if (container->iommu_driver && container->iommu_driver->ops->get_nr_pages)
+		nr_pages = container->iommu_driver->ops->get_nr_pages(container->iommu_data);
+	up_read(&container->group_lock);
+
+	/* Only report a count that covers every domain in the container */
+	if (nr_pages >= 0)
+		seq_printf(m, "iommu-nr-pages:\t%ld\n", nr_pages);
+}
+#endif
+
 static const struct file_operations vfio_fops = {
 	.owner		= THIS_MODULE,
 	.open		= vfio_fops_open,
 	.release	= vfio_fops_release,
 	.unlocked_ioctl	= vfio_fops_unl_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo	= vfio_fops_show_fdinfo,
+#endif
 };
 
 struct vfio_container *vfio_container_from_file(struct file *file)
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 7728bc99b63d..37e8841ad0e9 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -226,6 +226,8 @@ struct vfio_iommu_driver_ops {
 				  void *data, size_t count, bool write);
 	struct iommu_domain *(*group_iommu_domain)(void *iommu_data,
 						   struct iommu_group *group);
+	/* Returns IO page table pages used, or -EOPNOTSUPP if not accounted */
+	long		(*get_nr_pages)(void *iommu_data);
 };
 
 struct vfio_iommu_driver {
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index c8151ba54de3..fc7c1553d574 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -3249,6 +3249,26 @@ vfio_iommu_type1_group_iommu_domain(void *iommu_data,
 	return domain;
 }
 
+static long vfio_iommu_type1_get_nr_pages(void *iommu_data)
+{
+	struct vfio_iommu *iommu = iommu_data;
+	struct vfio_domain *d;
+	long total = 0;
+
+	mutex_lock(&iommu->lock);
+	list_for_each_entry(d, &iommu->domain_list, next) {
+		/* Only generic_pt page tables account their pages */
+		if (!d->domain->is_iommupt) {
+			total = -EOPNOTSUPP;
+			break;
+		}
+		total += atomic_long_read(&d->domain->nr_pages);
+	}
+	mutex_unlock(&iommu->lock);
+
+	return total;
+}
+
 static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 	.name			= "vfio-iommu-type1",
 	.owner			= THIS_MODULE,
@@ -3263,6 +3283,7 @@ static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
 	.unregister_device	= vfio_iommu_type1_unregister_device,
 	.dma_rw			= vfio_iommu_type1_dma_rw,
 	.group_iommu_domain	= vfio_iommu_type1_group_iommu_domain,
+	.get_nr_pages		= vfio_iommu_type1_get_nr_pages,
 };
 
 static int __init vfio_iommu_type1_init(void)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

