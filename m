Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792478323;
	b=mrmD16qyyO4sh82meyJHBcJOUcIg9thX7pjLvSUqvD2idd0115vnj66De+MVP/nPlohU
	 IElUUHIn7O5n/K7fnej5LzAFSUhn71P2rdRPHEoFz4rFMMgU4FeIfs+7eCLhoVTe4ytZH
	 B5mysmS6ykqSvfAymOlj3AgBbaK6gtqMDMaDROGjUlhjaMsWaJS/XIi9aWHBpx0OYd1aT
	 Ee7q7gOkBvywR96kYhvRBt3ft9uOu/mlnetPE0Ae+neTN3UWCEuEWVPHxven1BUIGx1PJ
	 OJv3uwogfM5pHFjUlbIzZ3sKikXUscCTD/M+JT+lC4SctmaCg7iF8D60hRiMTIkRYMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478323;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lxQS80DRMWPUuTe1dt16GF2tEumPDF9CfvG4Nh6yKLM=;
	b=wgWy4zrCJ9KvlMtAJhlxd5KfRmcs6GI2FTXpLxUpBVdIuBazuEVzGRrBJ0mWGiILAfjl
	 lIu89U/KOae+VrEwrpJuqshQ106HIN9gcDcnGdAo2otwkNwD4Dvd+SGAmSCL9Zz+0l1qq
	 W98qKzJQMV64Q6RdbIXYijb8+t/uzKQp/s3/N1szLUkmJFJ+AvdxB9LUgVyj7UZKlC7c9
	 MNaceZ61OX5kfQQQ11u3HdBSLSP/2mm7F8TryswSav6F8nBs8xgqKQ7Ub8JV/+YE9JNLY
	 XHEaAe16o6boBGmufbBRGH+txX4ewH0iO4oqwjkqg89pkuy+5gJ61Xr4ctzUFd1yoUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ffftlOzv;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13886606A32D
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 06:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13886606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ffftlOzv
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b0584ad71so1986073f8f.0
        for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 23:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792478320; x=1793083120; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lxQS80DRMWPUuTe1dt16GF2tEumPDF9CfvG4Nh6yKLM=;
        b=ffftlOzvhhEouPvq+GTUhUb537srHRdveKiG9KKxfaFhXH9SYg5x7UX64gbqbVkppe
         0ug1CCkzgwQEJnwlQRd4b3E1URjqipOG71UhP6ADTvSDpHzrgBWkg8YdGEj/SFNCVy+r
         RoMFsM3/XlkGjHoUc/n9LiTwxIP2MvDTjxCqYqIY9AmIdNyQkO9+U1OW7wFBgUQGUEiU
         7jT/kcslq05SWTfH1FYu4lCspmXhv0ErRyWgnwgDo4wgx2E4h+F4zshTAKBofLzXGkbC
         rxi2ZmPj9a1Co+Anh+hH0S6/4oXpi6nfW1w9Ed80WLo2WsaOqbQMF9GgyUl1CVvkYaME
         hfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792478320; x=1793083120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lxQS80DRMWPUuTe1dt16GF2tEumPDF9CfvG4Nh6yKLM=;
        b=xWuhaoJplEz40JK7bOuno8IEdfTaUkicwyYqK8nuGGc6ZK0ufgf8wsQg5I5FOtYokD
         9AgMpnwg7Nl+v5vfzqGR/kgwn2pVreozFlKa5E+HC4OiQD8auId4nGuF1nWbRRjbRw0/
         2yc/XzCGhnj645lQgFt5pq0YNE3XD+Y05OHry52tv3cWfXRJCfFohwzZv0+uoYvpwgQn
         RoBY97mGRabdbvbNcwivwkAE49h4afg0ATIqU371Z1CmoOjxSSFaV4kSi+jC5CsfFg8a
         DovB8HOBx55NVOSZ/iyhzg6nPBappCDA5FXqPppj/LjY+R2tLTIuPgRZp0O8DUwazwyS
         IPGw==
X-Forwarded-Encrypted: i=1; AKwUvBzPDDxUMJSb9rq2V4sGs1zocH9SuoBe9WNRUMGrndr245QcKecsanYbj8ifemPMn3JIikobuw==@lists.linux.dev
X-Gm-Message-State: AFq9FYI8GhacBo2+P3M59G1ltQI99M81+6zmmxKSDggM1SnIWXxOT2nK
	aX7eJhhpTV0bWcf5sJ+/Rq5ozUInWJhs+1CH5dwsxxrOayTnXW4VqrWx
X-Gm-Gg: AYBFou3TYzcXkcgQAKschO2LEvx5sGznFOgU6pjO6g5CZHNHxNEdxI//eR51tQDvgVO
	4wwdGRaNnMLjOen4WNfZaQMSwke09FelOVBIr8Pzg+CT3L5psPYGUMAZ9s8s4e8k/ZGipWdjoDd
	auTz1/XerBLYTf/YP+LuBvs9SxjI82DSFj7rYTP+T8XoHgxkHpcUdMEpl73aYTuhCrN2SJu27CA
	m2Bq5KTubh6KCDpCGNo8Qc2rSkrWiGKM18U6HR4dIuKUBaea64bDe0mrVbtluG9zgTrjGRJ3RuK
	6iF2E7FA015eQ6nruDZ4ykMtekDivnlDA9s3nQRpcAg0R4nFRsNwFXp5OB6F4cd/XwuMW47xNjg
	KEZtM7blutKqhVJWEs6U2ZaQRfjYqx786AX9pOgH4oy21bJ0ciXGU30xYxysNakwi5kXsVvdjZ3
	nqXha+59TT+pqEWkxbTrWEpZvDKmyi6eITpCS6IpSqSTwMdnydTzk8IsQSmquTExQjsU1qAuAWE
	OQo8SSJk37s62vpewXiFkB1QVKdmCtFxSqRg5EK+oYlDFIzZOe56pkDFg3SL45VaqkEoioXpJPl
	szXAsFNlf3DcXZ8h/rAo2vOq2d26ikIDCbi1JnpnQ8V8g/7SD9yT4U4kSd4S95fyJ3IogKlFWw8
	CZQ==
X-Received: by 2002:adf:e196:0:b0:48e:1d81:5b86 with SMTP id ffacd0b85a97d-48e1d815babmr3213729f8f.52.1792478320234;
        Mon, 19 Oct 2026 23:38:40 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9c92-6501-2169-eb9c-7ad3-f5db.310.pool.telefonica.de. [2a02:3100:9c92:6501:2169:eb9c:7ad3:f5db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d820714sm3916393f8f.35.2026.10.19.23.38.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 23:38:39 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org
Subject: [RFC PATCH 6/6] iommufd/selftest: Check DMA-buf pin and map failure cleanup
Date: Tue, 20 Oct 2026 08:37:45 +0200
Message-Id: <6f4c8996cb3849e7c6586f0908903e52a38dd02f.1792477872.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1792477872.git.kmehltretter@gmail.com>
References: <cover.1792477872.git.kmehltretter@gmail.com>
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

The PAL selftest exporter has no pin callback, so it cannot exercise the
importer's dma_buf_pin() error path. An error there must reach userspace
without mapping the buffer or unpinning an unsuccessful pin.

Add per-buffer error injection and reservation-protected lifecycle
counters. Check pin and map failure cleanup, then clear each fault and
retry the same buffer to verify balanced successful cleanup.

Also reject unknown control flags, nonzero reserved fields, invalid errno
values and configuration changes while an attachment exists.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  24 ++++
 drivers/iommu/iommufd/selftest.c              | 111 ++++++++++++++++
 tools/testing/selftests/iommu/iommufd.c       | 121 ++++++++++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h |  30 +++++
 4 files changed, 286 insertions(+)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index dae7d808b..d516a5aad 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -32,6 +32,7 @@ enum {
 	IOMMU_TEST_OP_DMABUF_GET,
 	IOMMU_TEST_OP_DMABUF_REVOKE,
 	IOMMU_TEST_OP_MD_CHECK_DMABUF,
+	IOMMU_TEST_OP_DMABUF_CONTROL,
 };
 
 enum {
@@ -80,6 +81,21 @@ enum {
 /* Reserved for special pasid replace test */
 #define IOMMU_TEST_PASID_RESERVED 1024
 
+enum {
+	IOMMU_TEST_DMABUF_SET_ERRORS = 1 << 0,
+};
+
+struct iommu_test_dmabuf_stats {
+	__u32 attach_calls;
+	__u32 detach_calls;
+	__u32 pin_calls;
+	__u32 pin_successes;
+	__u32 unpin_calls;
+	__u32 map_calls;
+	__u32 map_successes;
+	__u32 unmap_calls;
+};
+
 struct iommu_test_cmd {
 	__u32 size;
 	__u32 op;
@@ -201,6 +217,14 @@ struct iommu_test_cmd {
 			__aligned_u64 length;
 			__aligned_u64 offset;
 		} check_dmabuf;
+		struct {
+			__s32 dmabuf_fd;
+			__u32 flags;
+			/* Positive errno, or zero to disable injection. */
+			__s32 pin_errno;
+			__s32 map_errno;
+			struct iommu_test_dmabuf_stats out_stats;
+		} dmabuf_control;
 	};
 	__u32 last;
 };
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index df1e7d125..ffa26d6e9 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1960,6 +1960,10 @@ struct iommufd_test_dma_buf {
 	size_t length;
 	unsigned int npages;
 	bool revoked;
+	int pin_errno;
+	int map_errno;
+	unsigned int attach_count;
+	struct iommu_test_dmabuf_stats stats;
 	struct page *pages[] __counted_by(npages);
 };
 
@@ -1973,6 +1977,49 @@ static void iommufd_test_dma_buf_release(struct dma_buf *dmabuf)
 	kfree(priv);
 }
 
+static int iommufd_test_dma_buf_attach(struct dma_buf *dmabuf,
+				       struct dma_buf_attachment *attach)
+{
+	struct iommufd_test_dma_buf *priv = dmabuf->priv;
+
+	dma_resv_lock(dmabuf->resv, NULL);
+	priv->attach_count++;
+	priv->stats.attach_calls++;
+	dma_resv_unlock(dmabuf->resv);
+	return 0;
+}
+
+static void iommufd_test_dma_buf_detach(struct dma_buf *dmabuf,
+					struct dma_buf_attachment *attach)
+{
+	struct iommufd_test_dma_buf *priv = dmabuf->priv;
+
+	dma_resv_lock(dmabuf->resv, NULL);
+	priv->attach_count--;
+	priv->stats.detach_calls++;
+	dma_resv_unlock(dmabuf->resv);
+}
+
+static int iommufd_test_dma_buf_pin(struct dma_buf_attachment *attach)
+{
+	struct iommufd_test_dma_buf *priv = attach->dmabuf->priv;
+
+	dma_resv_assert_held(attach->dmabuf->resv);
+	priv->stats.pin_calls++;
+	if (priv->pin_errno)
+		return -priv->pin_errno;
+	priv->stats.pin_successes++;
+	return 0;
+}
+
+static void iommufd_test_dma_buf_unpin(struct dma_buf_attachment *attach)
+{
+	struct iommufd_test_dma_buf *priv = attach->dmabuf->priv;
+
+	dma_resv_assert_held(attach->dmabuf->resv);
+	priv->stats.unpin_calls++;
+}
+
 static struct dma_buf_phys_list *
 iommufd_dma_pal_map_phys(struct dma_buf_attachment *attachment)
 {
@@ -1981,6 +2028,9 @@ iommufd_dma_pal_map_phys(struct dma_buf_attachment *attachment)
 
 	dma_resv_assert_held(attachment->dmabuf->resv);
 
+	priv->stats.map_calls++;
+	if (priv->map_errno)
+		return ERR_PTR(-priv->map_errno);
 	if (priv->revoked)
 		return ERR_PTR(-ENODEV);
 
@@ -1993,12 +2043,17 @@ iommufd_dma_pal_map_phys(struct dma_buf_attachment *attachment)
 		phys->phys[i].paddr = page_to_phys(priv->pages[i]);
 		phys->phys[i].len = PAGE_SIZE;
 	}
+	priv->stats.map_successes++;
 	return phys;
 }
 
 static void iommufd_dma_pal_unmap_phys(struct dma_buf_attachment *attach,
 				       struct dma_buf_phys_list *phys)
 {
+	struct iommufd_test_dma_buf *priv = attach->dmabuf->priv;
+
+	dma_resv_assert_held(attach->dmabuf->resv);
+	priv->stats.unmap_calls++;
 	kfree(phys);
 }
 
@@ -2017,6 +2072,10 @@ static int iommufd_dma_buf_match_mapping(struct dma_buf_match_args *args)
 }
 
 static const struct dma_buf_ops iommufd_test_dmabuf_ops = {
+	.attach = iommufd_test_dma_buf_attach,
+	.detach = iommufd_test_dma_buf_detach,
+	.pin = iommufd_test_dma_buf_pin,
+	.unpin = iommufd_test_dma_buf_unpin,
 	.release = iommufd_test_dma_buf_release,
 	.match_mapping = iommufd_dma_buf_match_mapping,
 };
@@ -2101,6 +2160,56 @@ static int iommufd_test_dmabuf_revoke(struct iommufd_ucmd *ucmd, int fd,
 	return rc;
 }
 
+static int iommufd_test_dmabuf_control(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_test_cmd *cmd = ucmd->cmd;
+	struct iommufd_test_dma_buf *priv;
+	struct dma_buf *dmabuf;
+	int rc = 0;
+
+	if (cmd->id || cmd->__reserved || cmd->last ||
+	    cmd->dmabuf_control.flags & ~IOMMU_TEST_DMABUF_SET_ERRORS)
+		return -EOPNOTSUPP;
+	if (cmd->dmabuf_control.pin_errno < 0 ||
+	    cmd->dmabuf_control.pin_errno > MAX_ERRNO ||
+	    cmd->dmabuf_control.map_errno < 0 ||
+	    cmd->dmabuf_control.map_errno > MAX_ERRNO)
+		return -EINVAL;
+	if (!(cmd->dmabuf_control.flags & IOMMU_TEST_DMABUF_SET_ERRORS) &&
+	    (cmd->dmabuf_control.pin_errno || cmd->dmabuf_control.map_errno))
+		return -EINVAL;
+
+	dmabuf = dma_buf_get(cmd->dmabuf_control.dmabuf_fd);
+	if (IS_ERR(dmabuf))
+		return PTR_ERR(dmabuf);
+	if (dmabuf->ops != &iommufd_test_dmabuf_ops) {
+		rc = -EOPNOTSUPP;
+		goto out_put;
+	}
+
+	priv = dmabuf->priv;
+	dma_resv_lock(dmabuf->resv, NULL);
+	if (cmd->dmabuf_control.flags & IOMMU_TEST_DMABUF_SET_ERRORS) {
+		/* Do not change the outcome of an attachment already in use. */
+		if (priv->attach_count) {
+			rc = -EBUSY;
+			goto out_unlock;
+		}
+		priv->pin_errno = cmd->dmabuf_control.pin_errno;
+		priv->map_errno = cmd->dmabuf_control.map_errno;
+	}
+	cmd->dmabuf_control.pin_errno = priv->pin_errno;
+	cmd->dmabuf_control.map_errno = priv->map_errno;
+	cmd->dmabuf_control.out_stats = priv->stats;
+out_unlock:
+	dma_resv_unlock(dmabuf->resv);
+	if (!rc)
+		rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+out_put:
+	dma_buf_put(dmabuf);
+	return rc;
+}
+
 static int iommufd_test_md_check_dmabuf(struct iommufd_ucmd *ucmd,
 					unsigned int mockpt_id, int dmabuf_fd,
 					unsigned long iova, size_t length,
@@ -2244,6 +2353,8 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 		return iommufd_test_dmabuf_revoke(ucmd,
 						  cmd->dmabuf_revoke.dmabuf_fd,
 						  cmd->dmabuf_revoke.revoked);
+	case IOMMU_TEST_OP_DMABUF_CONTROL:
+		return iommufd_test_dmabuf_control(ucmd);
 	case IOMMU_TEST_OP_MD_CHECK_DMABUF:
 		return iommufd_test_md_check_dmabuf(
 			ucmd, cmd->id, cmd->check_dmabuf.dmabuf_fd,
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 2673f9f15..771cdf958 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1586,6 +1586,127 @@ TEST_F(iommufd_ioas, dmabuf_simple)
 	close(dfd);
 }
 
+TEST_F(iommufd_ioas, dmabuf_pin_failure)
+{
+	struct iommu_test_dmabuf_stats stats;
+	__u64 iova;
+	int dfd;
+
+	test_cmd_get_dmabuf(PAGE_SIZE, &dfd);
+	test_cmd_dmabuf_errors(dfd, EBUSY, 0);
+	test_err_ioctl_ioas_map_file(EBUSY, dfd, 0, PAGE_SIZE, &iova);
+	test_cmd_dmabuf_stats(dfd, &stats);
+	EXPECT_EQ(1, stats.attach_calls);
+	EXPECT_EQ(1, stats.detach_calls);
+	EXPECT_EQ(1, stats.pin_calls);
+	EXPECT_EQ(0, stats.pin_successes);
+	EXPECT_EQ(0, stats.unpin_calls);
+	EXPECT_EQ(0, stats.map_calls);
+	EXPECT_EQ(0, stats.map_successes);
+	EXPECT_EQ(0, stats.unmap_calls);
+
+	/* Retry the same buffer after clearing the injected error. */
+	test_cmd_dmabuf_errors(dfd, 0, 0);
+	test_ioctl_ioas_map_file(dfd, 0, PAGE_SIZE, &iova);
+	if (variant->mock_domains)
+		test_cmd_check_dmabuf(self->hwpt_id, dfd, iova, PAGE_SIZE, 0);
+	EXPECT_ERRNO(EBUSY,
+		     _test_cmd_dmabuf_control(self->fd, dfd,
+					      IOMMU_TEST_DMABUF_SET_ERRORS,
+					      EBUSY, 0, NULL));
+	test_ioctl_ioas_unmap(iova, PAGE_SIZE);
+	test_cmd_dmabuf_stats(dfd, &stats);
+	EXPECT_EQ(2, stats.attach_calls);
+	EXPECT_EQ(2, stats.detach_calls);
+	EXPECT_EQ(2, stats.pin_calls);
+	EXPECT_EQ(1, stats.pin_successes);
+	EXPECT_EQ(1, stats.unpin_calls);
+	EXPECT_EQ(1, stats.map_calls);
+	EXPECT_EQ(1, stats.map_successes);
+	EXPECT_EQ(1, stats.unmap_calls);
+	close(dfd);
+}
+
+TEST_F(iommufd_ioas, dmabuf_map_failure)
+{
+	struct iommu_test_dmabuf_stats stats;
+	__u64 iova;
+	int dfd;
+
+	test_cmd_get_dmabuf(PAGE_SIZE, &dfd);
+	test_cmd_dmabuf_errors(dfd, 0, ENOMEM);
+	test_err_ioctl_ioas_map_file(ENOMEM, dfd, 0, PAGE_SIZE, &iova);
+	test_cmd_dmabuf_stats(dfd, &stats);
+	EXPECT_EQ(1, stats.attach_calls);
+	EXPECT_EQ(1, stats.detach_calls);
+	EXPECT_EQ(1, stats.pin_calls);
+	EXPECT_EQ(1, stats.pin_successes);
+	EXPECT_EQ(1, stats.unpin_calls);
+	EXPECT_EQ(1, stats.map_calls);
+	EXPECT_EQ(0, stats.map_successes);
+	EXPECT_EQ(0, stats.unmap_calls);
+
+	test_cmd_dmabuf_errors(dfd, 0, 0);
+	test_ioctl_ioas_map_file(dfd, 0, PAGE_SIZE, &iova);
+	if (variant->mock_domains)
+		test_cmd_check_dmabuf(self->hwpt_id, dfd, iova, PAGE_SIZE, 0);
+	test_ioctl_ioas_unmap(iova, PAGE_SIZE);
+	test_cmd_dmabuf_stats(dfd, &stats);
+	EXPECT_EQ(2, stats.attach_calls);
+	EXPECT_EQ(2, stats.detach_calls);
+	EXPECT_EQ(2, stats.pin_calls);
+	EXPECT_EQ(2, stats.pin_successes);
+	EXPECT_EQ(2, stats.unpin_calls);
+	EXPECT_EQ(2, stats.map_calls);
+	EXPECT_EQ(1, stats.map_successes);
+	EXPECT_EQ(1, stats.unmap_calls);
+	close(dfd);
+}
+
+TEST_F(iommufd_ioas, dmabuf_control_validation)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_TEST_OP_DMABUF_CONTROL,
+	};
+	int dfd;
+
+	test_cmd_get_dmabuf(PAGE_SIZE, &dfd);
+	cmd.dmabuf_control.dmabuf_fd = dfd;
+	cmd.__reserved = 1;
+	EXPECT_ERRNO(EOPNOTSUPP, ioctl(self->fd, IOMMU_TEST_CMD, &cmd));
+	cmd.__reserved = 0;
+	cmd.last = 1;
+	EXPECT_ERRNO(EOPNOTSUPP, ioctl(self->fd, IOMMU_TEST_CMD, &cmd));
+	cmd.last = 0;
+	cmd.id = 1;
+	EXPECT_ERRNO(EOPNOTSUPP, ioctl(self->fd, IOMMU_TEST_CMD, &cmd));
+	cmd.id = 0;
+	EXPECT_ERRNO(EOPNOTSUPP,
+		     _test_cmd_dmabuf_control(self->fd, dfd, 2, 0, 0, NULL));
+	EXPECT_ERRNO(EINVAL,
+		     _test_cmd_dmabuf_control(self->fd, dfd,
+					      IOMMU_TEST_DMABUF_SET_ERRORS,
+					      -EBUSY, 0, NULL));
+	EXPECT_ERRNO(EINVAL,
+		     _test_cmd_dmabuf_control(self->fd, dfd,
+					      IOMMU_TEST_DMABUF_SET_ERRORS,
+					      4096, 0, NULL));
+	EXPECT_ERRNO(EINVAL,
+		     _test_cmd_dmabuf_control(self->fd, dfd,
+					      IOMMU_TEST_DMABUF_SET_ERRORS,
+					      0, -ENOMEM, NULL));
+	EXPECT_ERRNO(EINVAL,
+		     _test_cmd_dmabuf_control(self->fd, dfd,
+					      IOMMU_TEST_DMABUF_SET_ERRORS,
+					      0, 4096, NULL));
+	EXPECT_ERRNO(EINVAL,
+		     _test_cmd_dmabuf_control(self->fd, dfd, 0, EBUSY, 0, NULL));
+	EXPECT_ERRNO(EINVAL,
+		     _test_cmd_dmabuf_control(self->fd, dfd, 0, 0, ENOMEM, NULL));
+	close(dfd);
+}
+
 TEST_F(iommufd_ioas, dmabuf_multi_page)
 {
 	__u64 iova;
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 35fd91d35..177a67f0e 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -593,6 +593,36 @@ static int _test_cmd_revoke_dmabuf(int fd, int dmabuf_fd, bool revoked)
 #define test_cmd_revoke_dmabuf(dmabuf_fd, revoke) \
 	ASSERT_EQ(0, _test_cmd_revoke_dmabuf(self->fd, dmabuf_fd, revoke))
 
+static int _test_cmd_dmabuf_control(int fd, int dmabuf_fd, unsigned int flags,
+				    int pin_errno, int map_errno,
+				    struct iommu_test_dmabuf_stats *stats)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_TEST_OP_DMABUF_CONTROL,
+		.dmabuf_control = {
+			.dmabuf_fd = dmabuf_fd,
+			.flags = flags,
+			.pin_errno = pin_errno,
+			.map_errno = map_errno,
+		},
+	};
+	int rc;
+
+	rc = ioctl(fd, IOMMU_TEST_CMD, &cmd);
+	if (!rc && stats)
+		*stats = cmd.dmabuf_control.out_stats;
+	return rc;
+}
+
+#define test_cmd_dmabuf_errors(dfd, pin_error, map_error)                    \
+	ASSERT_EQ(0, _test_cmd_dmabuf_control(                             \
+		self->fd, dfd, IOMMU_TEST_DMABUF_SET_ERRORS, pin_error,     \
+		map_error, NULL))
+
+#define test_cmd_dmabuf_stats(dfd, stats) \
+	ASSERT_EQ(0, _test_cmd_dmabuf_control(self->fd, dfd, 0, 0, 0, stats))
+
 #define test_cmd_check_dmabuf(_hwpt_id, _dmabuf_fd, _iova, _length, _offset) \
 	({                                                                   \
 		struct iommu_test_cmd check_cmd = {                          \
-- 
2.39.5 (Apple Git-154)

