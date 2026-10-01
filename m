Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9AB49C4B7
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 22:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894808; cv=none; b=kAkCVXTo/wXThu9nq94Zp8FR2gm4rNT+x4AgjnNaxLJ4K0FOxmKenrEi3HEdCdaQXRPiU4YMn2M7ocHBRNQReoF8FxusjDravOBRJCUf3e2wWS7LDZoVkf7hY+Iwo9oC4HjMc3pYAl1pkbXD3Pk4zKDv0exCsEp6psuFx7rOXj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894808; c=relaxed/simple;
	bh=I4Eb0TQXvIje7w417a5e7xobqbWORtKJ3XI4af3ycUQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q1f8T43MSmrV7t+J5ORLuPIZZ6DCl2XBkp1AtS26h7qCy8XT1sNtoVRzlR4G96aqgi4hTBFDDGFSBz1E1udAU/qx+0Yk+eawL/PL8dYipuK+rumwkt5y2W/lLahTsQNoodhAyBP3Q/HoWUv8SrthJoqR8qnhNM2fOiYrxnv73Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fzSDn/cF; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fzSDn/cF"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-88b59692e0dso1220b3a.3
        for <iommu@lists.linux.dev>; Thu, 01 Oct 2026 15:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790894806; x=1791499606; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x0wc41/LqtlI4rj0/ni4k6LG5KAkWTAQw55eEd0Lzvs=;
        b=fzSDn/cFjutRy6gHw1+6/LNXPD5qYCHeagXYISKq7BbyaE9eeiJB0oclPd65IRQj7+
         qDXzS77OyQzEeUeZ7rtF/KwYtlz/mz1Cszj0n1SBVARLHB27QT5+cb8rcoytbCxzwLdk
         9eyqex1rDAb9gSE/d0ZVWc9LH9zOC5x3JbKMRKHZjkN+7Hvp8/nN470Nh+LG9WWaOO+W
         lbgF1vAbd8o0JcytuXxil6drsn59tiOPN94rvd8lYqrzu0qcjxrUVDwBPdfLf+OrSdS+
         fdmaDGxuaA7Q4LZmhcHceEZa6pbpVUJ6roPj4B//REzeeXs3sAiXC0H98HgLtTmuklBe
         08Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790894806; x=1791499606;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x0wc41/LqtlI4rj0/ni4k6LG5KAkWTAQw55eEd0Lzvs=;
        b=JGb6c4g8MC19Otqg/jbrcNBYSpQaOowk6gJo+GhADXsAzQbKUo4NYEucYMU2GE0rK6
         hOgfVKR6gpQVUbbLWaOHVoBCm/puX+WcFt4EQ+yYAegzlazxuZhidhPZqzJKG/e/pH48
         /Z3v0Q9Opf7OSUmVI23fwwBn/o9s3gjiu1v4D+i0VBHvCv/5xB9KzCG0eB5HjAUDEKVa
         fLTSDEJkUkRIWTGsCuawWAe3PcBlCPYYR39yiwIEeuSgM7HlKQCXvbDSor4R66bx5vjL
         fX+hH9GQ96OAfljvGNFf6fjf1HSSnbL9ZH1DyedhcHVz/CcpYDQzQzMsgmJCuAY7SfuA
         pF8A==
X-Forwarded-Encrypted: i=1; AKwUvByVvJROj7xrQ0w6trDIbktC0HZxrCvyivfTlgto4tLoWWLnRx2M1l5KYv4xSKX1NlAX9XWuZw==@lists.linux.dev
X-Gm-Message-State: AFuF++mBB0H81mgnDGv+w8fZr27HPJ4x21EGmQZKHNhL/T7jrWIpEiHe
	MuRB+/WLC7XuE3DTW4TeyOjlC4o/eMQmQZd7Mhi/XY5TVUJUfF4p8JUmeVL46a8xjrjkUFRjYSn
	V7g==
X-Received: from pgbcs6.prod.google.com ([2002:a05:6a02:4186:b0:cc7:d1fb:4ccd])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a10:b0:3de:8ee8:8306
 with SMTP id adf61e73a8af0-3e0bcfdd8ecmr751775637.31.1790894806215; Thu, 01
 Oct 2026 15:46:46 -0700 (PDT)
Date: Thu,  1 Oct 2026 22:45:30 +0000
In-Reply-To: <20261001224531.765278-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261001224531.765278-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261001224531.765278-7-praan@google.com>
Subject: [RFC PATCH 6/7] iommufd/selftest: Add observability test for iommu-nr-pages
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Cc: Mostafa Saleh <smostafa@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Logan Odell <loganodell@google.com>, Pranjal Shrivastava <praan@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a test case to validate the iommu-nr-pages fdinfo metric. The test
maps sparse IOVAs to force page table directory allocations, verifies
that the metric increments accordingly, and asserts that the count
remains stranded after unmapping, verifying the current behaviour
required for future automated reclamation logic.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 tools/testing/selftests/iommu/iommufd.c | 48 +++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index d44b34b05757..f5f4ef01ea4f 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -3613,4 +3613,52 @@ TEST_F(iommufd_device_pasid, pasid_attach)
 	test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
 }
 
+TEST_F(iommufd_ioas, iommufd_nr_pages)
+{
+	char path[256];
+	char line[128];
+	FILE *f;
+	long nr_pages_initial = -1;
+	long nr_pages_mapped = -1;
+	long nr_pages_final = -1;
+
+	if (!self->stdev_id)
+		SKIP(return, "Needs a device attached for HWPT");
+
+	snprintf(path, sizeof(path), "/proc/self/fdinfo/%d", self->fd);
+	f = fopen(path, "r");
+	ASSERT_NE(NULL, f);
+	while (fgets(line, sizeof(line), f)) {
+		if (sscanf(line, "iommu-nr-pages:\t%ld", &nr_pages_initial) == 1)
+			break;
+	}
+	fclose(f);
+	ASSERT_GE(nr_pages_initial, 0);
+
+	/* Map a page at start and one far away */
+	test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE, self->base_iova);
+	test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE, self->base_iova + (1UL << 30));
+
+	f = fopen(path, "r");
+	ASSERT_NE(NULL, f);
+	while (fgets(line, sizeof(line), f)) {
+		if (sscanf(line, "iommu-nr-pages:\t%ld", &nr_pages_mapped) == 1)
+			break;
+	}
+	fclose(f);
+	ASSERT_GT(nr_pages_mapped, nr_pages_initial);
+
+	test_ioctl_ioas_unmap(self->base_iova, PAGE_SIZE);
+	test_ioctl_ioas_unmap(self->base_iova + (1UL << 30), PAGE_SIZE);
+
+	f = fopen(path, "r");
+	ASSERT_NE(NULL, f);
+	while (fgets(line, sizeof(line), f)) {
+		if (sscanf(line, "iommu-nr-pages:\t%ld", &nr_pages_final) == 1)
+			break;
+	}
+	fclose(f);
+	ASSERT_EQ(nr_pages_final, nr_pages_mapped);
+}
+
 TEST_HARNESS_MAIN
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

