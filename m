Received: from mail-qk2-f38.google.com (mail-qk2-f38.google.com [74.125.230.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA7C3CB56B
	for <iommu@lists.linux.dev>; Sun,  4 Oct 2026 18:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791138149; cv=none; b=LlKg7ldNn/onyJkUNC+6O3Q3jz71wrzHCb/pgp6wzuR2wY8KR4jhoYALoscKC47/ZGzWhv/70oa1w44towNH+KD3qkKTmdr81OusbDvZ2Y8dkedH8EPaVcMyjDtQKRwqiBidtoWtApzXem/k2Ft7V5vRA7YBl+YUGeJbMPVvUEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791138149; c=relaxed/simple;
	bh=oWV1x6C2ME/T5Yb2MZ7o3ypqhTuzYDHLFIWMHTAMo24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S7huBDpx2v2zFpBAqsGcH7w/tHtMQPfoGnVvz7kXfjaRJZ79LI0la2KbqYppmZHv5rQD9oK762HQZ04+VhKVhIkO8ysJM4DFYmjcDbyEbFlGPUDek49JCmnx0sW60nzsCcWWLP/i5Ya7Xkp6COKBRuBaWQbUOlSX2EDibQzlJmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgfM+iDu; arc=none smtp.client-ip=74.125.230.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgfM+iDu"
Received: by mail-qk2-f38.google.com with SMTP id d75a77b69052e-533984bfe2bso9584681cf.3
        for <iommu@lists.linux.dev>; Sun, 04 Oct 2026 11:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791138146; x=1791742946; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CF4IOObCfjFDOCjh2XXYxYv4lcIPIAWQIMOn46YsfNw=;
        b=bgfM+iDu1SHwDsVAyt4v2fvqfPeJ+KTb9XDBK4MR8KVDj7tPRhs4VwVfdhROkevpOU
         /N7tjA3ZQqXWyfddyQVwsfdC9uBjIqLTaPZZPQxVPet3xBo1bdJngnyveNTmS3vG1DLx
         RR9joGWUl2oS7HB4PskBf2iNFxSZ8mwT1SCullx4q0OSydIKzqQ/Oc270kqz4X8187hn
         Nw5xAxGXIe+Gx8JphG0cEygx1GkfT/n6kURr28xbKi9H4Ps/nJkl5hne/+QsMUUXSCsL
         +jgt19IBfWxt6aKBr8O4DPGIul/kQIa8gRCldVsH1btiA3n2BvsjJfH2Ny8q4hW0ucNe
         7MfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791138146; x=1791742946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CF4IOObCfjFDOCjh2XXYxYv4lcIPIAWQIMOn46YsfNw=;
        b=GwqrdZHPHRysIiRwp+5KL/y7pX8UP24KpNPiQpdnrbvOgdbhicbFpB+bcYqp/D0hS/
         bde3Tli50770fzz3tPcJgFRiA1MOTNVk2JKv/nmykplAyDJN1aJSC6/2AprbU+h4WcmN
         SQZwYLxOSarQcUdc1pXGegxU37jnJdFZwbfw2ZJCFCTy7/o9SDOSwroImeTcPRuXmT0A
         c/dkIRYEZMGk7eVIwzHvvtmXUqWgg/diU9GzbgZpwqtGtWLAZpybYWsDmCSQhakGs0wm
         RAcjdiMCtG1Z7TNAWOq8N7NLTOe2cTSfdHtzJbiJDpRrKKMpXKtiqDpCiBoCTROqcix2
         QQuA==
X-Forwarded-Encrypted: i=1; AKwUvBwhjOD2ps3cviWMFk8hDodtj/acKPeZ9XrA507v0L5Q+spPw/Yojr5y/aEAqgAybZcbd8GbNQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kPkCXQtLUVVD3UY+/WY7YkcpKdmZZG3fF9wdfN9vBUvUwHR/w0
	yB1e9lUAgQCaXiVY4CAD/7utXlUKsYGyAtIMwuLtSQ4N+s4Wft52Fcsf
X-Gm-Gg: AYBFou1VA9xrH1ssgGhA7tgE5rQ07rZ1RI2HGE5EU5aDMJtKRhahlP/q4yiBQCbFXvR
	shhtlrUiPHv3j+Wr6tCbcFcehOE8/ZTFJ3fh61R5CDFDPZqOGRpNrnNdya2gcpg8utGCraOvArJ
	qP7gTjCiz1qKaUbD4ETDGmif/9eiDfX1+bNjfezmsg8LSqX26rqASYGOw0Ahj+/Z0OjSw67qr92
	nMGfCoA7gd7NlRuzOmBbajL2iweQdi/8VgPBAnkicwtnZPX+rgtG9Q60J2CUv0tjC9lKT2OMSHX
	Uo8SNCbywhGY3oT7vAPgV9QA4KOQPKP4XuloS9zcJP0tAAp203ttSI1VFDNhNLvu4ODBgrYp8Sk
	zu7ARPaUuXRBWEOipf1bg8A66gQ5Tz/+thwDjhwpFXB4BwxmAT51gwGM5uuZl4dEb6Wmux2WD0s
	lPsbccCUyoolwtjQkLHJ18icbOuQRtYE9/UX8qRehHbjNEhSyQIMXVPYHWUkmKlM7ewRqxt1dKR
	H2VQ+JHpk7kFs+egFigNpb0ZGe3KdC8
X-Received: by 2002:a05:622a:618c:b0:531:ab4:c604 with SMTP id d75a77b69052e-533bc652ea4mr174969861cf.1.1791138145927;
        Sun, 04 Oct 2026 11:22:25 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5351fd92b58sm27430061cf.21.2026.10.04.11.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 11:22:25 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Eric Auger <eric.auger@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] iommu/virtio: Reset device before deleting virtqueues on probe failure
Date: Sun,  4 Oct 2026 14:21:10 -0400
Message-ID: <20261004182218.177343-1-oss.patchbox@gmail.com>
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
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Changes in v2:
- No code change.
- Reword the commit message to explain how the device can write to the
  freed event buffers.
- Add Cc: stable.
- v1 was mistakenly posted twice; this version supersedes both postings.

v1: https://lore.kernel.org/all/20260911011249.1498825-1-oss.patchbox@gmail.com/

Compile-tested only (x86_64 allmodconfig, W=1).

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
 

base-commit: 7704c4c5bb127673b4f0ead839919db573559e38
-- 
2.43.0

