Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33303358DA
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775860177; cv=pass; b=F5wmKxeG2boFEQOE1stkeM4c7emCB5jr8e2GaTOXSzt2cfdXaBobYvxwGNpk+D5VBE58Fz+lsxYZegEcvMy5bAol9AvyyY8WwngIEToP+cfH10FgahnD4Al5N6fARdsymKcwMAB+pUnamX+CvnneQB8ZGTYQcPpJ6T3i58P/QOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775860177; c=relaxed/simple;
	bh=P3xAMyNg59off9ek6FrdUi52ihgUQ0WPky+vT1B/pDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HmnrA9USIbxlhCgh/Jn/QJ2HYxRz6LjQ2eaXteT6awvLLyWTsvAgKWfG6bngvKuKuDebKc1F80DSe6w5+WHHPUwC6O8nr5wmiXwjR7pg6kDTZjN4Pgi1r1NxEg4htrTmpEgay1ppswcR30g9zGa2SYJvrGQBOggmyzbCsF1aZm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=x/EPNUr3; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="x/EPNUr3"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7982c3b7da9so23748957b3.1
        for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 15:29:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775860175; cv=none;
        d=google.com; s=arc-20240605;
        b=Tm2n15cXckYS1D28K2stO+w2+ALmZFefNXZRsCnP40aaUqjz9mvgAJN5Mc/DOjVt7P
         Ptf2gWQDQSLN/Jipk0yr/CvYB2UPbVVv9IppcpqgnRVnpxsGOejSHcs3LZKWBXctGbPi
         fTpujbNeZV146cE/WB9ysXx3x8ysjrXuNZUDxocbHP84X5MFlqpB5kW+WTpS3hn4ENA7
         YcGOt5lAcnPxjhtAYECF8z7SDNiotkf6gxNQUpJ2t6qZ2y6YCa8CawbnBEpNcEXyopmf
         mVff7R3zgzALoAWCLQazWVvFqCCJaAPFaUZUm2MPxfN9nPb5RwBIF9MtxUF1lhvWeQEO
         xHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RLxY3RUXio63RMFVV2S/82uTKGXRqhW5FspTC735xUQ=;
        fh=EF6jHUqn4QGM7Hz4tfRTbk/qTbXCBSA114DCej7+9AA=;
        b=JiPdioSHcc4lpjDKdkkH1IXDAHIkshjEVYcKzhEm/Qewe33Bxgl1ZFgpuvtIoeRp6n
         6QfrovGmj/8vKyFWEDvMqE0RIOC9ihB1AZtZWC9TkMoimRXpBy7NY8FU7eYObiufcXK0
         NP0S3mCs4ed4dHuBVVPvFWkkfV22NeaQrkxJVeGwgwTDiDiSD8ZAJpQDngnHoCpz12Z/
         6rysm6Dbq7RiyHlsMbG4ye/4/qc6tiJE70CcL8NIK/6pH3jTDGaeg4i50Tp26JvRATce
         E1FM92N+QZEohfsjR0IvSaubUSIUlJ0o+8HEmbVSAz69BZ9xY+j4MmagpuQKAIdLb5Xi
         bahw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1775860175; x=1776464975; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RLxY3RUXio63RMFVV2S/82uTKGXRqhW5FspTC735xUQ=;
        b=x/EPNUr3dcyXkm9El8CozlbTylPUtCREPuHyeoYdwQ7RtMYU4VuXvI4tsV0/v3OXfC
         woMfh/OZ4VYcs7lrlmTpcuM7zq2bpotFPVkScwRI0CCEBwgdetBZg0LwBSoy4IV1vzVu
         ndPzKFf2Sn1KRXyK2jn44HWuKkw1pdi59QpVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775860175; x=1776464975;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLxY3RUXio63RMFVV2S/82uTKGXRqhW5FspTC735xUQ=;
        b=ExC9E2ZDBmfNVvcbU9JsRplj5Bpf1kLcbAVfI7poq8FrE4QsNc1kiR1nxm2rp/fX5K
         CCjjnWLuE0TomjMxF81sD1kwt1Nv882BA6SiU6ctTj9nk0C/SmA5E8kMDFjIGPymh9Xm
         nlO2FGnW2N9TnVrOGEkYK+PBNdJ73vBD9bclEqEAZSz+u6gAM8G0sJpycj6orVAKSuME
         p96CZG2PIyebDNFjmss9BlpBFMsyVp5IrCzi93lgcEHljiafTjfRDbZ/NDPrR8rwy4Aw
         sXz0SPTt/rIDOFYDyvDrrxKf3Y/iTzcHZU5uSQtxO400gQTQXoc7leavCJ4m7H90nZej
         v9JA==
X-Forwarded-Encrypted: i=1; AJvYcCX/G+KuRILjIEXcO3lQ1jyPdoCp29Jk3fKZ4om6wOFgSnPrgJ2Eo/15qE3TWNBfwlpR0iCRGw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkuDC40feuiR7tt3sGIJcDi14ycSXLHntYfYvvu8U1Ugy6eUdN
	z3LmnXDXaQDCgr4OWBMqR5YXZUfL0unvL0HfVusQWVtQTqvt4rADousYbXM0d42Rsc7+3yJih6/
	qGEppfWLYzNmsKcgdJMUox+2nOv4gNVmJH1k41SAAfg==
X-Gm-Gg: AeBDieuRcV0+LbpmgWRWzaTiBUnFF7uNNQot03KhpAGbQov7i4aHx/bQcPHXfiJKqLg
	iVJezwm1zO1GJ9/cLj+Q23hV47VTGFz+cD+ubn4N3cEzZUAyg+x+vK8lTRM8dZP8lRhq8ygfvZq
	BOmYyNTtX0D0eGs4ReqieMJaxaVr0Szn3st4ZIXLvGANAdqIj4GpUkXwIKFTo0j+8iTGlsJSdGY
	A/zybFX3NnhNLP7F22KkPxN2oZmCOWHszKmjmVOLMX4MpH167EChulLOBnDY9ZLZ02xKqG/ClHI
	IXQqynys
X-Received: by 2002:a05:690c:6d84:b0:79a:4fe4:ff4b with SMTP id
 00721157ae682-7af71b567a3mr57702457b3.37.1775860174404; Fri, 10 Apr 2026
 15:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CA+w=M=SEUeGvXaK6OqdDVjYrbagnzDgAMgCRHbRqoYvS+OgW=w@mail.gmail.com>
 <c773c37c-b4ce-4f3f-927f-0be8a9b2d7a5@arm.com> <CA+w=M=SmUFUCfS6kGvRh3A4Vq++gSwhuPK7gn-ebWnM6BkpiZQ@mail.gmail.com>
In-Reply-To: <CA+w=M=SmUFUCfS6kGvRh3A4Vq++gSwhuPK7gn-ebWnM6BkpiZQ@mail.gmail.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Fri, 10 Apr 2026 15:29:18 -0700
X-Gm-Features: AQROBzDIB9oFAIunzApXxKG1DD_NAHg0n4-3ye3q9P7oRIP4fQdJ0M1mHx2g3pg
Message-ID: <CA+w=M=THPjp9JwDPe_XpLcEpLTLakCf8OiybSbLwOPxjmAHy0w@mail.gmail.com>
Subject: [PATCH] nvme-pci: fix swapped arguments in SGL DMA unmap path
To: linux-nvme@lists.infradead.org
Cc: linux-iommu@vger.kernel.org, iommu@lists.linux.dev, jroedel@suse.de, 
	Robin Murphy <robin.murphy@arm.com>, will@kernel.org, Nagi Parimi <nparimi@uber.com>, 
	Kshitij Doshi <kshitijd@uber.com>, Jeff Bean <bean@uber.com>, Vikrant Soman <vsoman@uber.com>, kbusch@kernel.org, 
	xboe@kernel.dk, hch@lst.de, sagi@grimberg.me, leon@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The arguments to nvme_free_sgls() in nvme_unmap_data() are swapped for
the multi-entry SGL case. The first argument (sge) should be the
segment descriptor from the NVMe command's data pointer (type
NVME_SGL_FMT_LAST_SEG_DESC), and the second argument (sg_list) should
be the pool-allocated array of data descriptors.

With the arguments swapped, sge points to the first data descriptor
(type NVME_SGL_FMT_DATA_DESC). nvme_free_sgls() sees a data descriptor,
unmaps only that single entry, and returns -- leaking the DMA mappings
for all subsequent segments.

This manifests as unbounded iommu_iova slab growth on ARM64 systems
with 64K pages and IOMMU DMA translation, where IOVA coalescing is
disabled due to the NVMe 4K page / IOMMU 64K page granularity
mismatch. On x86 and ARM64 with 4K pages, IOVA coalescing handles
the unmap via dma_iova_destroy() and the buggy path is never reached.

Fixes: 7ce3c1dd78fc ("nvme-pci: convert the data mapping to blk_rq_dma_map")
Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 28f638413e122..728999e4247d8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -761,8 +761,8 @@ static void nvme_unmap_data(struct request *req)

        if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len)) {
                if (nvme_pci_cmd_use_sgl(&iod->cmd))
-                       nvme_free_sgls(req, iod->descriptors[0],
-                                      &iod->cmd.common.dptr.sgl);
+                       nvme_free_sgls(req, &iod->cmd.common.dptr.sgl,
+                                      iod->descriptors[0]);
                else
                        nvme_free_prps(req);
        }
-- 
2.39.5
