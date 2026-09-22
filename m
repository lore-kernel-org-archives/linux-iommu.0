Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF61F48AE36
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 05:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055685; cv=none; b=mhaX0xbh0F1ea3CQ5Tl7quN8+Yv1VaAGc7jxxRh/1d0UOd0lzNUojM2r0dgZ7mZJtRu4nXoecPlkue6hYkuLz2BfdSwIkbjByQauCoq4+YxVyZU0GWHW08KraAJ1q8HsH+/L1wm6hHVncVMBtrbUoIcFlWWtP67TpO/Lzmlf9Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055685; c=relaxed/simple;
	bh=iFLkf+rOhLizaAv8+B8/2aNKubqrFbO1iPrtUYCmcBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bAx2kGVRKOsaEUv8tSXqQlIS65peGcofj+rUVf1As+oap6kHvLb8A3nYhduolpKOCjkDSiScOp9NV21qyTL2TErAC26NQ4oyHUp6CEIxR2AjgQErT2BlnHE+dXreNe/DemUW+WrXl9V+OB/C6USKyimH8bj5xzserff2dGKYcdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9gjfbHK; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9gjfbHK"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-52fb766bfd8so33953561cf.3
        for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 22:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790055682; x=1790660482; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OCtKANYoOWihnD2FHnwq5WRM5Q7npRAqL2fydivBlQ4=;
        b=O9gjfbHKunXNO+26PMlfAKsPLB5EJeGUmJL4vOxw/URxVpGzHnmyFITqgUIReRC8eG
         28Z7aOibHki9UlkjtRh1ua+O+bqPkMlraWG0FKsmSlbbKHJ5lhaQMb2ujlreLYQVdJu2
         zFycdUJZP5ALRwCnC+4TXy7CE5o9Jdm3NtSq4J0gmr3DN8a94xR0PAne71qctQpg7nSp
         NaJ0bo/2KT4WuzC3Cf+YVm4S4IKWJBtQJ3V4Bl5KOd9vpuLWPmIXWDTaEh41yRiky/dy
         7sI7p7nDbz1aeSW8wMMeOjlQ8E7roaunlQ5n0vYYDqm5r5U4ifySdLeJNh6FR2xNQtlV
         a61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790055682; x=1790660482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OCtKANYoOWihnD2FHnwq5WRM5Q7npRAqL2fydivBlQ4=;
        b=TM1U4PaXUtS+gh0mWpGTyud8uTOhVtnXU3KbtKARVIQd1Q/TvzdjSOPDg6WUUivIcH
         byAlOgdnYtHEcsSV2IgO0HK+pE91v7eyxz4KGgzejR4qe7O/tD7lkqsWah7JMs/mdD7u
         1B1dLqAf0vKuNOlYTtxiYeNbodTisdnqqfI7jIYLzECXHqXBmJIRLWg6Mgl4g+mIivGg
         9zXJxyPZvZd1+YzidJk4cKmpH0QZwsDWGjCgvGnyOKNnVOtPaljsS4kdwCZqYMH1TiiP
         9mJkQtEeMUAekP+JpP8l21yB3YBhrkRUt6QINDNCyfAsl8ebUj0sFS3pGvuEWnk/NzoW
         cUcQ==
X-Forwarded-Encrypted: i=1; AKwUvBxybLciYkoh9ub9VixgQRtDp5OUPegC1dg5XHBKt5hU+ZIxzlioSS/fPs5OGLpjVgOD0F6X6A==@lists.linux.dev
X-Gm-Message-State: AFuF++le0Pa6ENgwldEj2Jlp0XiwQHBVrEmvVM1U6JJDxipzHoqlBIFr
	aJfyaLL9mSTra246eRtIxeDdAKMkyeRREbdx+RSU4yFeJZ/nN5h2Kett
X-Gm-Gg: AYBFou0/LUeW7nB0s5MNj5croJhFgJ/FODPbF1h8l+NmXj41xXXa+l0J48JbJfpydED
	1gHB/hH/TtPeaAK3I4SXm68EB8RvAYbpDErMkorsQWcWh1BQMCBNDZnMcWH9y9bHcTP9oLKjMng
	GPBrKly7SkRNlo8t6wEcOY/I54nUeq9e64zL8mCPOye65Mob9WSSJzZvduMZq6tz8xrD37uXZIO
	Z5CxFCy38Ie66qLcT42QYtnz2B4oTtvmw6xySg1n1pT5clIC7UQcHQu+wmFbqS8BbkFruBdsV+Y
	pKAik4TQMErNRn2OT8ykS7o//YmrHbI+S7DTpFc1TRcIQG6+zEclmydClreHzcuIhr7EPodP9es
	gXxoPzVi+NYG2pz+bC+z52BathHAGyaTIq1W171z3tr1f1ztWGXSOMxPsfTNpCBG4LVrlZkQcyL
	PkUXNJjCAtFokdlrM5cO6xDjKGeJSw8cZD1eIT34xRUmlD7l8mdk+X5WZY3ywFtVrdngg7SUOcp
	vX5lZIJObrP8tjhUZ9Giw==
X-Received: by 2002:a05:622a:1aaa:b0:532:9adc:639f with SMTP id d75a77b69052e-532d8e70943mr39247461cf.67.1790055681695;
        Mon, 21 Sep 2026 22:41:21 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e192f96dsm4515801cf.23.2026.09.21.22.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 22:41:21 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] iommu/virtio: Reset device before deleting virtqueues on probe failure
Date: Tue, 22 Sep 2026 01:41:16 -0400
Message-ID: <20260922054116.416333-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

viommu_probe() marks the device DRIVER_OK before populating the event
virtqueue and registering the IOMMU device in sysfs.  viommu_fill_evtq()
hands the device a set of device-writable buffers through
virtqueue_add_inbuf(), so from that point on the device may write into
them and into the rings.

If either step fails, the error path deletes the virtqueues without
resetting the device first.  The event buffers are allocated with
devm_kmalloc_array() and are released as probe unwinds, so the device can
go on writing to memory that has been freed.

Reset the device before deleting the virtqueues, the way viommu_remove()
already does.

Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/iommu/virtio-iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 587fc13197f12..fa72ae23b8afa 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1227,12 +1227,12 @@ static int viommu_probe(struct virtio_device *vdev)
 	/* Populate the event queue with buffers */
 	ret = viommu_fill_evtq(viommu);
 	if (ret)
-		goto err_free_vqs;
+		goto err_reset_vdev;
 
 	ret = iommu_device_sysfs_add(&viommu->iommu, dev, NULL, "%s",
 				     virtio_bus_name(vdev));
 	if (ret)
-		goto err_free_vqs;
+		goto err_reset_vdev;
 
 	vdev->priv = viommu;
 
@@ -1244,6 +1244,8 @@ static int viommu_probe(struct virtio_device *vdev)
 
 	return 0;
 
+err_reset_vdev:
+	virtio_reset_device(vdev);
 err_free_vqs:
 	vdev->config->del_vqs(vdev);
 

base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
-- 
2.43.0

