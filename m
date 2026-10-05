Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A994457C6
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194166; cv=none; b=jAvIpkocYv11oJImLNSJJuQ/b+AHKGqk+rGuh+AqMGz+AuYNEqgUCbP5kj0WZU7yxGuNUkg2b/amzjSRz1U/ipbA67OvRW4D1Gft2QOwXBejktol8qtb6VCc02VtD9LXVb8eAbDXdV/mH9eyMgvGJAbBc1D+e5fYtPpJZHyUkPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194166; c=relaxed/simple;
	bh=ARYO8oRzysyDjWqkNeWzqMaVQP/6D2sRYtg4hlwDrxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbzOKDvOed6XjsoOjeF6P9SmwlU66WTGfItNqO23IIgAVoANsHcGJFGY/po/XgbfXR3rk5TpFTCrNgYAaDs15MobF01SROvzcV9KB+9WZkhUFeS3fz3CA22ZJwIKEZDT4YVv0cJgP/sTjkrtJxUrcbN0rJwFeYuCe3sSnPnyHl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IC3ERM05; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IC3ERM05"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c29703cb470so266549766b.0
        for <iommu@lists.linux.dev>; Mon, 05 Oct 2026 02:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791194160; x=1791798960; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JwlAWAAy7BYUoB7+a9T937QVUxmXXORCOGD20YZnv/k=;
        b=IC3ERM05EbDjOzW+1J0QQsiE8B0RMBt3ne7K09xmsyaOF7V/rCZncJoPUdsnfeFpNn
         x0SVLCNZTbd+q3sGiSzVrTECqyc//UsyuS3t6a4GxP0Z/lgGRjaFKi1pdjDyz04JBbUQ
         KqhgPYG55wGPY7Fi3QDJTvkq2Evx7zwBqFk0AdOlyY2aHOrn0NhrzHW6U6iebfPYz0qs
         xLQJGXxWpBpHVu+8MS05vuydDylqX2LwTRTc9Zjqv1kVeF/CXIPb0wBzO9YnOziVWIpo
         vLRlBYh35aHwMLMkv1zIGmumXjbsrbClm/opo4+JK2rBA17UmrIQ9RdpqKN/CbzUfc2O
         YvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791194160; x=1791798960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JwlAWAAy7BYUoB7+a9T937QVUxmXXORCOGD20YZnv/k=;
        b=IYz9X0808a/heqNWXVEpYFGjsX06PwXflQ1O5fbEzMwaS3rmDcF9pfY8WW/YsyAk4u
         e7n3clMiCykzRP713Src8acbP3DIC2al9Ivdt3I2wHmx16UpCFQdy09v0qB6ID3yHDe7
         TbtcwlfmE0kmQf7YRRx3z/6cgDywi3tjb/Rh68thZimt/x5GaPT0F+LbXsrhBPSq0peW
         os/lhuerlgaU0nNJ36qnYIKR4jAEPvZQOuSousG8hP8f/C+j/VRFWtx5ZnhVU4WHprzY
         mCjQzYdi/5TjnAp40oJ5LwwWyZ/aY84KWwQiq1E7vEWH7PCLt4tjAfMVcFUqXczpHGue
         GX2A==
X-Forwarded-Encrypted: i=1; AKwUvBzr8TBJyR/zjTxFlmpUT7c5AEBXPUHf+3+Xn+NLxGV8jQ5O2sbHpwjE3Gi/hDr/AsJMq9WoLQ==@lists.linux.dev
X-Gm-Message-State: AFuF++m62AvSzV0M5s3L4cbFucW6JhICU938RfLUmD9Z5Burdh6uCc3Z
	ms3lAtQyGw1Fw9fGUNJbIVmrwPeOYhhB0AWCk0kMSmpfbKlX0HuqhCFY
X-Gm-Gg: AYBFou0OPDch2HdUd5j4HUXViGka2lyK6MNGCbSvpcdgy117HBL3EPvkC5oQ8AkkdKG
	o4sEYRoLCveDApngYt5BlGQSIFbPw9NXzEbbg2Yr+a+OWAEinIcuFnLNIM2JHPZB1dTgLQ0eYiV
	5k23OL77EyU0ZyssIJW1UWnAKDwIi4NlhSBcNjprDWrVmca8HAs8YEM2vn+2Ftjx9iuaW8MD5dQ
	UW5AcFBaNKcECCKewPGcz62sDmjDzY8U/o+serApRuDaXQey7nk2oTxB5vt6WKPIW5slxCvQzmf
	Mi42ssWdHuwPCntQ9j05uC4mZM1qNt+CY7EOy0Nfo+UUOkV3wSQHXPOpc/02olwCvr1+XUvkfGh
	8WoyKTNXyqQQR9MN1vXNnWBHgb7uQmXtr0G3jGSztUFwo7M3A2VArQqXtogfBl08DH3UwHpzUsp
	GQOiNw/ZMZqHRJ9fiDVI8HcYc4By9md5RDkBuUHenMEFBopzXixVW/d3hme6E5z8xHXDirWGHON
	Fpvmgm6LRp3T1+Tp51t4I6yDh7xRO8q4IZWCitQxSd3ZItTk8kvnnsy/G053Fnaa1Kp3G1bX9XS
	JRMbBDp7PRET2Sj8hW07OCfsFNAlkMGjJjOG1MXBWWzCJg==
X-Received: by 2002:a17:907:6d11:b0:c25:2688:8212 with SMTP id a640c23a62f3a-c2e4a6a273emr858285166b.0.1791194159542;
        Mon, 05 Oct 2026 02:55:59 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31562aba16sm50753266b.23.2026.10.05.02.55.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2026 02:55:59 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [RFC PATCH 4/6] dma-buf: Allow dynamic attach without a device
Date: Mon,  5 Oct 2026 09:55:50 +0000
Message-ID: <20261005095552.52748-5-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005095552.52748-1-griffoul@gmail.com>
References: <20260720111259.122911-1-dwmw2@infradead.org>
 <20261005095552.52748-1-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

dma_buf_dynamic_attach() requires a struct device: the device for which
the buffer is mapped for DMA. Exporters may also check it before they
accept the attachment. An importer that does not perform DMA has no
such device. iommufd already attaches with a global placeholder device
for this reason. KVM would need one too, although it only needs to know
where the memory is so that it can map it into a guest.

Allow @dev to be NULL for a dynamic importer. Such an importer learns
where the memory is from get_phys() and builds its own mappings. It
must not map the attachment for DMA, and dma_buf_map_attachment()
refuses an attachment without a device. An exporter that needs a device
to answer can refuse the attachment in its attach op, as it can for any
other reason.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 drivers/dma-buf/dma-buf.c      | 15 +++++++++++++--
 include/trace/events/dma_buf.h |  2 +-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index e7010163eb2f..3d43b529a523 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1007,6 +1007,13 @@ dma_buf_pin_on_map(struct dma_buf_attachment *attach)
  * Note that this can fail if the backing storage of @dmabuf is in a place not
  * accessible to @dev, and cannot be moved to a more suitable place. This is
  * indicated with the error code -EBUSY.
+ *
+ * @dev may be NULL for a dynamic importer that is not a DMA master: one that
+ * only asks the exporter where the memory is, through &dma_buf_ops.get_phys,
+ * and builds its own mappings from the answer.  Such an importer must never
+ * call dma_buf_map_attachment(), and an exporter that needs a device to
+ * answer (a peer-to-peer check, say) refuses the attachment in its
+ * &dma_buf_ops.attach.
  */
 struct dma_buf_attachment *
 dma_buf_dynamic_attach(struct dma_buf *dmabuf, struct device *dev,
@@ -1016,7 +1023,7 @@ dma_buf_dynamic_attach(struct dma_buf *dmabuf, struct device *dev,
 	struct dma_buf_attachment *attach;
 	int ret;
 
-	if (WARN_ON(!dmabuf || !dev))
+	if (WARN_ON(!dmabuf || (!dev && !importer_ops)))
 		return ERR_PTR(-EINVAL);
 
 	attach = kzalloc_obj(*attach);
@@ -1175,6 +1182,9 @@ struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *attach,
 
 	if (WARN_ON(!attach || !attach->dmabuf))
 		return ERR_PTR(-EINVAL);
+	/* An importer without a device cannot be a DMA master. */
+	if (WARN_ON(!attach->dev))
+		return ERR_PTR(-EINVAL);
 
 	dma_resv_assert_held(attach->dmabuf->resv);
 
@@ -1847,7 +1857,8 @@ static int dma_buf_debug_show(struct seq_file *s, void *unused)
 		attach_count = 0;
 
 		list_for_each_entry(attach_obj, &buf_obj->attachments, node) {
-			seq_printf(s, "\t%s\n", dev_name(attach_obj->dev));
+			seq_printf(s, "\t%s\n", attach_obj->dev ?
+				   dev_name(attach_obj->dev) : "none");
 			attach_count++;
 		}
 		dma_resv_unlock(buf_obj->resv);
diff --git a/include/trace/events/dma_buf.h b/include/trace/events/dma_buf.h
index 3bb88d05bcc8..7cabca53b798 100644
--- a/include/trace/events/dma_buf.h
+++ b/include/trace/events/dma_buf.h
@@ -40,7 +40,7 @@ DECLARE_EVENT_CLASS(dma_buf_attach_dev,
 	TP_ARGS(dmabuf, attach, is_dynamic, dev),
 
 	TP_STRUCT__entry(
-		__string(	dev_name,			dev_name(dev))
+		__string(dev_name, dev ? dev_name(dev) : "none")
 		__string(	exp_name,			dmabuf->exp_name)
 		__field(	size_t,				size)
 		__field(	ino_t,				ino)
-- 
2.47.3

