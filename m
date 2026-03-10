Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8270B4A3C
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 00:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101221; cv=none; b=Ew3KWkoq+q73vR3spPLaQrWtgcDGsWIgDSDxhTpF0SnUdHNbywLZ7eLmuNJHXp4oDuNv14CNTSNrouJ13x11p6feWZbSrw++NjZ+bHunOlPHtOHUikgRK5Qmkv9JNEa5CGkSYzGYROf1ZuB84CcLA7HJIqjN9CWSXfmuQf5YzRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101221; c=relaxed/simple;
	bh=BmLxd7BlVBvmYtbyhvQwm9a6DoBWBc8qzviTBlCmxg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0iHQ5watjrC9XcZNUoi4rQH7NBshivroM02svw5NngJosUxQzeAOaj4GLYJ8p7PMwceTQFWd464EC+02cnXyI47c+hw3sfJWaGdNmuI9aetZCdUiThc0yyUNl7zEc9tte9TsHTdk5/m1/Ba8Us6Q8DVxnIai5KPEX64XD53vlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GSpHeMi2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GSpHeMi2"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae49120e97so43885ad.0
        for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 17:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773101219; x=1773706019; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aO/aEA03m1jGhaTg+sFhhfUsZa7KeeOwFQwMdzAlldI=;
        b=GSpHeMi29XvndZIty3TNuxiD7yPpny9JKmhyHoWxCqSsuEYdsfi3mn1fNSMgpazMQO
         6GhPXdzbz8BGMX4gxWgCBxHDyUhe2WtaDPg9f1rzpaDygLSy4zjQkxgYjRR6v31cNTfJ
         s7q1K6uoWOLa44PcJOgEhnYySDBEpXx35mrhNxjHHCPRaGo8fyL7yFxlszCac72DVBQz
         /nayjyK5YiUeQLqCFBLW4ec1n0FnwJsllQfwtzS8MVtM9IaGiEjRH23XRd2qCHEQVGil
         WXpVwCi5allv6zgOhlZe3PK8Rr4l/XautlVBkf8vbKpwWV5/+1i0o5OiAID//5dA7aBI
         nOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773101219; x=1773706019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aO/aEA03m1jGhaTg+sFhhfUsZa7KeeOwFQwMdzAlldI=;
        b=M6Z0YdKW/ShNg7jPnCzxVkcZqWD/AsaQRMBjCXnSnVpOpHa17A/UxPZoW6LqRQk9Bl
         qjav14BC+Kk4Lo6VfJPyCxR1tNhGXcJJCcihZU3UmIPjXJIsqAXAfnloIUKFErJ075/O
         5Lk0FNcmCGAyjTJsM5ZOObMTX0DYe7mu0ckwO7LmWE4QRJV63JjEE8Q+OgRDj7zmNqSj
         YsVW1mqfGRz4yahbk3NTr+KRliJsftccFb72mru3Kf74/lIJyuWNU3fSP686F/EWMY2u
         oXtLEz0xs4upukLVJWqm8AuAup7OCLowKcWCfx+ZqVGpGoMOW4q5doZPHMZDeZZxgF6W
         QFvg==
X-Forwarded-Encrypted: i=1; AJvYcCUd5s3lgNuROVwVzYJn1vgVLwVbxQsu/EihJ3PCUBZpPYtVwQSlG5vgAv3FiNVBU6joDo78ig==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyg6wwCD/KxmQrjbvy/dALAVUeWEXqULTr5rW/vHbiGnxEVMa9V
	jHnSbWWqaTKiLQa5gOqQLuGqXA0CXS83BKPdMQnjJ7fRkF5gxZWN5qt7yV113Xo7gw==
X-Gm-Gg: ATEYQzx9SCCRl9UD/RKt/Mndh6Txt22VTUDHtffsjxW8nVsUA+UQj4JNI90P+r0RKby
	kN6EXPn3H5HcIIVRCifRPtjwmf/7Nj6uecs0I0EJ+lRxa7I05832vsdEospx4LxvzLJtlxnwiHn
	vOvvwdKNZhV8slJKgbDszt0dVgKN1maW1ianV7LiDLxSPk6ecI/al5H58t9PLx03OPnMnNSOTcu
	B1KIKe1tZ2gnsWOBP0l4/fbZH7BdHFuDixoDvtwcBgKPAHx6Mdip5R2AEp+xWiUQKluk6tnM2c8
	UxzDcplgbDxjOCqo7zuFkHUArJ4Zfg4XsIve9nUwbOC6jOQHnofhTImhUzYLXesiLABWxSMUGgP
	r1wzkQnfCBLhzSyu3nkumrcvRYM8vrU1Hv8pZCt1Lv/BglFcQlR72NRWOjMQDqdi7E1jpff2uVy
	/kNMpOlu4rZCWEeRhiyfGAGwbVpf1lhPOwHDdfdNq9uZIDccKb9CsZorBDiZLZ1fmBKjNR6BJB
X-Received: by 2002:a17:903:40d1:b0:2ae:44db:570c with SMTP id d9443c01a7336-2aea3053fbcmr1415335ad.12.1773101218308;
        Mon, 09 Mar 2026 17:06:58 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e78d48sm135916135ad.22.2026.03.09.17.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:06:57 -0700 (PDT)
Date: Tue, 10 Mar 2026 00:06:54 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Dmytro Maluka <dmaluka@chromium.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] iommu: Lift and generalize the STE/CD update code
 from SMMUv3
Message-ID: <aa9fQchZJER8QvY0@google.com>
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-2-baolu.lu@linux.intel.com>
 <aa9W4ZKYWHr9-UNy@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aa9W4ZKYWHr9-UNy@google.com>

On Mon, Mar 09, 2026 at 11:33:23PM +0000, Samiullah Khawaja wrote:
>On Mon, Mar 09, 2026 at 02:06:41PM +0800, Lu Baolu wrote:
>>From: Jason Gunthorpe <jgg@nvidia.com>
>>
>>Many IOMMU implementations store data structures in host memory that can
>>be quite big. The iommu is able to DMA read the host memory using an
>>atomic quanta, usually 64 or 128 bits, and will read an entry using
>>multiple quanta reads.
>>
>>Updating the host memory datastructure entry while the HW is concurrently
>>DMA'ing it is a little bit involved, but if you want to do this hitlessly,
>>while never making the entry non-valid, then it becomes quite complicated.
>>
>>entry_sync is a library to handle this task. It works on the notion of
>>"used bits" which reflect which bits the HW is actually sensitive to and
>>which bits are ignored by hardware. Many hardware specifications say
>>things like 'if mode is X then bits ABC are ignored'.
>>
>>Using the ignored bits entry_sync can often compute a series of ordered
>>writes and flushes that will allow the entry to be updated while keeping
>>it valid. If such an update is not possible then entry will be made
>>temporarily non-valid.
>>
>>A 64 and 128 bit quanta version is provided to support existing iommus.
>>
>>Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
>>Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>>---
>>drivers/iommu/Kconfig               |  14 +++
>>drivers/iommu/Makefile              |   1 +
>>drivers/iommu/entry_sync.h          |  66 +++++++++++++
>>drivers/iommu/entry_sync_template.h | 143 ++++++++++++++++++++++++++++
>>drivers/iommu/entry_sync.c          |  68 +++++++++++++
>>5 files changed, 292 insertions(+)
>>create mode 100644 drivers/iommu/entry_sync.h
>>create mode 100644 drivers/iommu/entry_sync_template.h
>>create mode 100644 drivers/iommu/entry_sync.c
>>
>>diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>index f86262b11416..2650c9fa125b 100644
>>--- a/drivers/iommu/Kconfig
>>+++ b/drivers/iommu/Kconfig
>>@@ -145,6 +145,20 @@ config IOMMU_DEFAULT_PASSTHROUGH
>>
>>endchoice
>>
>>+config IOMMU_ENTRY_SYNC
>>+	bool
>>+	default n
>>+
>>+config IOMMU_ENTRY_SYNC64
>>+	bool
>>+	select IOMMU_ENTRY_SYNC
>>+	default n
>>+
>>+config IOMMU_ENTRY_SYNC128
>>+	bool
>>+	select IOMMU_ENTRY_SYNC
>>+	default n
>>+
>>config OF_IOMMU
>>	def_bool y
>>	depends on OF && IOMMU_API
>>diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>>index 0275821f4ef9..bd923995497a 100644
>>--- a/drivers/iommu/Makefile
>>+++ b/drivers/iommu/Makefile
>>@@ -10,6 +10,7 @@ obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>>obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
>>obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
>>obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
>>+obj-$(CONFIG_IOMMU_ENTRY_SYNC) += entry_sync.o
>>obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>>obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
>>obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
>>diff --git a/drivers/iommu/entry_sync.h b/drivers/iommu/entry_sync.h
>>new file mode 100644
>>index 000000000000..004d421c71c0
>>--- /dev/null
>>+++ b/drivers/iommu/entry_sync.h
>>@@ -0,0 +1,66 @@
>>+/* SPDX-License-Identifier: GPL-2.0-only */
>>+/*
>>+ * Many IOMMU implementations store data structures in host memory that can be
>>+ * quite big. The iommu is able to DMA read the host memory using an atomic
>>+ * quanta, usually 64 or 128 bits, and will read an entry using multiple quanta
>>+ * reads.
>>+ *
>>+ * Updating the host memory datastructure entry while the HW is concurrently
>>+ * DMA'ing it is a little bit involved, but if you want to do this hitlessly,
>>+ * while never making the entry non-valid, then it becomes quite complicated.
>>+ *
>>+ * entry_sync is a library to handle this task. It works on the notion of "used
>>+ * bits" which reflect which bits the HW is actually sensitive to and which bits
>>+ * are ignored by hardware. Many hardware specifications say things like 'if
>>+ * mode is X then bits ABC are ignored'.
>>+ *
>>+ * Using the ignored bits entry_sync can often compute a series of ordered
>>+ * writes and flushes that will allow the entry to be updated while keeping it
>>+ * valid. If such an update is not possible then entry will be made temporarily
>>+ * non-valid.
>>+ *
>>+ * A 64 and 128 bit quanta version is provided to support existing iommus.
>>+ */
>>+#ifndef IOMMU_ENTRY_SYNC_H
>>+#define IOMMU_ENTRY_SYNC_H
>>+
>>+#include <linux/types.h>
>>+#include <linux/compiler.h>
>>+#include <linux/bug.h>
>>+
>>+/* Caller allocates a stack array of this length to call entry_sync_write() */
>>+#define ENTRY_SYNC_MEMORY_LEN(writer) ((writer)->num_quantas * 3)
>>+
>>+struct entry_sync_writer_ops64;
>>+struct entry_sync_writer64 {
>>+	const struct entry_sync_writer_ops64 *ops;
>>+	size_t num_quantas;
>>+	size_t vbit_quanta;
>>+};
>>+
>>+struct entry_sync_writer_ops64 {
>>+	void (*get_used)(const __le64 *entry, __le64 *used);
>>+	void (*sync)(struct entry_sync_writer64 *writer);
>>+};
>>+
>>+void entry_sync_write64(struct entry_sync_writer64 *writer, __le64 *entry,
>>+			const __le64 *target, __le64 *memory,
>>+			size_t memory_len);
>>+
>>+struct entry_sync_writer_ops128;
>>+struct entry_sync_writer128 {
>>+	const struct entry_sync_writer_ops128 *ops;
>>+	size_t num_quantas;
>>+	size_t vbit_quanta;
>>+};
>>+
>>+struct entry_sync_writer_ops128 {
>>+	void (*get_used)(const u128 *entry, u128 *used);
>>+	void (*sync)(struct entry_sync_writer128 *writer);
>>+};
>>+
>>+void entry_sync_write128(struct entry_sync_writer128 *writer, u128 *entry,
>>+			 const u128 *target, u128 *memory,
>>+			 size_t memory_len);
>>+
>>+#endif
>>diff --git a/drivers/iommu/entry_sync_template.h b/drivers/iommu/entry_sync_template.h
>>new file mode 100644
>>index 000000000000..646f518b098e
>>--- /dev/null
>>+++ b/drivers/iommu/entry_sync_template.h
>>@@ -0,0 +1,143 @@
>>+/* SPDX-License-Identifier: GPL-2.0-only */
>>+#include "entry_sync.h"
>>+#include <linux/args.h>
>>+#include <linux/bitops.h>
>>+
>>+#ifndef entry_sync_writer
>>+#define entry_sync_writer entry_sync_writer64
>>+#define quanta_t __le64
>>+#define NS(name) CONCATENATE(name, 64)
>>+#endif
>>+
>>+/*
>>+ * Figure out if we can do a hitless update of entry to become target. Returns a
>>+ * bit mask where 1 indicates that a quanta word needs to be set disruptively.
>>+ * unused_update is an intermediate value of entry that has unused bits set to
>>+ * their new values.
>>+ */
>>+static u8 NS(entry_quanta_diff)(struct entry_sync_writer *writer,
>>+				const quanta_t *entry, const quanta_t *target,
>>+				quanta_t *unused_update, quanta_t *memory)
>>+{
>>+	quanta_t *target_used = memory + writer->num_quantas * 1;
>>+	quanta_t *cur_used = memory + writer->num_quantas * 2;
>>+	u8 used_qword_diff = 0;
>>+	unsigned int i;
>>+
>>+	writer->ops->get_used(entry, cur_used);
>>+	writer->ops->get_used(target, target_used);
>>+
>>+	for (i = 0; i != writer->num_quantas; i++) {
>>+		/*
>>+		 * Check that masks are up to date, the make functions are not
>
>nit: "the make functions" looks like a typo.
>>+		 * allowed to set a bit to 1 if the used function doesn't say it
>>+		 * is used.
>>+		 */
>>+		WARN_ON_ONCE(target[i] & ~target_used[i]);
>>+
>>+		/* Bits can change because they are not currently being used */
>>+		unused_update[i] = (entry[i] & cur_used[i]) |
>>+				   (target[i] & ~cur_used[i]);
>>+		/*
>>+		 * Each bit indicates that a used bit in a qword needs to be
>>+		 * changed after unused_update is applied.
>>+		 */
>>+		if ((unused_update[i] & target_used[i]) != target[i])
>>+			used_qword_diff |= 1 << i;
>>+	}
>>+	return used_qword_diff;
>>+}
>>+
>>+/*
>>+ * Update the entry to the target configuration. The transition from the current
>>+ * entry to the target entry takes place over multiple steps that attempts to
>>+ * make the transition hitless if possible. This function takes care not to
>>+ * create a situation where the HW can perceive a corrupted entry. HW is only
>>+ * required to have a quanta-bit atomicity with stores from the CPU, while
>>+ * entries are many quanta bit values big.
>>+ *
>>+ * The difference between the current value and the target value is analyzed to
>>+ * determine which of three updates are required - disruptive, hitless or no
>>+ * change.
>>+ *
>>+ * In the most general disruptive case we can make any update in three steps:
>>+ *  - Disrupting the entry (V=0)
>>+ *  - Fill now unused quanta words, except qword 0 which contains V
>>+ *  - Make qword 0 have the final value and valid (V=1) with a single 64
>>+ *    bit store
>>+ *
>>+ * However this disrupts the HW while it is happening. There are several
>>+ * interesting cases where a STE/CD can be updated without disturbing the HW
>>+ * because only a small number of bits are changing (S1DSS, CONFIG, etc) or
>>+ * because the used bits don't intersect. We can detect this by calculating how
>>+ * many 64 bit values need update after adjusting the unused bits and skip the
>>+ * V=0 process. This relies on the IGNORED behavior described in the
>>+ * specification.
>>+ */
>>+void NS(entry_sync_write)(struct entry_sync_writer *writer, quanta_t *entry,
>>+			  const quanta_t *target, quanta_t *memory,
>>+			  size_t memory_len)
>>+{
>>+	quanta_t *unused_update = memory + writer->num_quantas * 0;
>>+	u8 used_qword_diff;
>>+
>>+	if (WARN_ON(memory_len !=
>>+		    ENTRY_SYNC_MEMORY_LEN(writer) * sizeof(*memory)))
>>+		return;
>>+
>>+	used_qword_diff = NS(entry_quanta_diff)(writer, entry, target,
>>+						unused_update, memory);
>>+	if (hweight8(used_qword_diff) == 1) {
>>+		/*
>>+		 * Only one quanta needs its used bits to be changed. This is a
>>+		 * hitless update, update all bits the current entry is ignoring
>>+		 * to their new values, then update a single "critical quanta"
>>+		 * to change the entry and finally 0 out any bits that are now
>>+		 * unused in the target configuration.
>>+		 */
>>+		unsigned int critical_qword_index = ffs(used_qword_diff) - 1;
>>+
>>+		/*
>>+		 * Skip writing unused bits in the critical quanta since we'll
>>+		 * be writing it in the next step anyways. This can save a sync
>>+		 * when the only change is in that quanta.
>>+		 */
>>+		unused_update[critical_qword_index] =
>>+			entry[critical_qword_index];
>>+		NS(entry_set)(writer, entry, unused_update, 0,
>>+			      writer->num_quantas);
>>+		NS(entry_set)(writer, entry, target, critical_qword_index, 1);
>>+		NS(entry_set)(writer, entry, target, 0, writer->num_quantas);
>>+	} else if (used_qword_diff) {
>>+		/*
>>+		 * At least two quantas need their inuse bits to be changed.
>>+		 * This requires a breaking update, zero the V bit, write all
>>+		 * qwords but 0, then set qword 0
>>+		 */
>>+		unused_update[writer->vbit_quanta] = 0;
>>+		NS(entry_set)(writer, entry, unused_update, writer->vbit_quanta, 1);
>>+
>>+		if (writer->vbit_quanta != 0)
>>+			NS(entry_set)(writer, entry, target, 0,
>>+				      writer->vbit_quanta - 1);
>
>Looking at the definition of the entry_set below, the last argument is
>length. So if vbit_quanta 1 then it would write zero len. Shouldn't it
>be writing quantas before the vbit_quanta?
>>+		if (writer->vbit_quanta != writer->num_quantas)

Looking at this again, I think vbit_quanta can never be equal to
num_quanta as num_quantas is length and vbit_quanta is index?
>>+			NS(entry_set)(writer, entry, target,
>>+				      writer->vbit_quanta,

Staring from vbit_quanta will set the present bit if it is set in the
target?
>>+				      writer->num_quantas - 1);
>
>Sami here, the last argument should not have "- 1".

I meant "Same here".
>>+
>>+		NS(entry_set)(writer, entry, target, writer->vbit_quanta, 1);
>>+	} else {
>>+		/*
>>+		 * No inuse bit changed. Sanity check that all unused bits are 0
>>+		 * in the entry. The target was already sanity checked by
>>+		 * entry_quanta_diff().
>>+		 */
>>+		WARN_ON_ONCE(NS(entry_set)(writer, entry, target, 0,
>>+					   writer->num_quantas));
>>+	}
>>+}
>>+EXPORT_SYMBOL(NS(entry_sync_write));
>>+
>>+#undef entry_sync_writer
>>+#undef quanta_t
>>+#undef NS
>>diff --git a/drivers/iommu/entry_sync.c b/drivers/iommu/entry_sync.c
>>new file mode 100644
>>index 000000000000..48d31270dbba
>>--- /dev/null
>>+++ b/drivers/iommu/entry_sync.c
>>@@ -0,0 +1,68 @@
>>+// SPDX-License-Identifier: GPL-2.0-only
>>+/*
>>+ * Helpers for drivers to update multi-quanta entries shared with HW without
>>+ * races to minimize breaking changes.
>>+ */
>>+#include "entry_sync.h"
>>+#include <linux/kconfig.h>
>>+#include <linux/atomic.h>
>>+
>>+#if IS_ENABLED(CONFIG_IOMMU_ENTRY_SYNC64)
>>+static bool entry_set64(struct entry_sync_writer64 *writer, __le64 *entry,
>>+			const __le64 *target, unsigned int start,
>>+			unsigned int len)
>>+{
>>+	bool changed = false;
>>+	unsigned int i;
>>+
>>+	for (i = start; len != 0; len--, i++) {
>>+		if (entry[i] != target[i]) {
>>+			WRITE_ONCE(entry[i], target[i]);
>>+			changed = true;
>>+		}
>>+	}
>>+
>>+	if (changed)
>>+		writer->ops->sync(writer);
>>+	return changed;
>>+}
>>+
>>+#define entry_sync_writer entry_sync_writer64
>>+#define quanta_t __le64
>>+#define NS(name) CONCATENATE(name, 64)
>>+#include "entry_sync_template.h"
>>+#endif
>>+
>>+#if IS_ENABLED(CONFIG_IOMMU_ENTRY_SYNC128)
>>+static bool entry_set128(struct entry_sync_writer128 *writer, u128 *entry,
>>+			 const u128 *target, unsigned int start,
>>+			 unsigned int len)
>>+{
>>+	bool changed = false;
>>+	unsigned int i;
>>+
>>+	for (i = start; len != 0; len--, i++) {
>>+		if (entry[i] != target[i]) {
>>+			/*
>>+			 * Use cmpxchg128 to generate an indivisible write from
>>+			 * the CPU to DMA'able memory. This must ensure that HW
>>+			 * sees either the new or old 128 bit value and not
>>+			 * something torn. As updates are serialized by a
>>+			 * spinlock, we use the local (unlocked) variant to
>>+			 * avoid unnecessary bus locking overhead.
>>+			 */
>>+			cmpxchg128_local(&entry[i], entry[i], target[i]);
>>+			changed = true;
>>+		}
>>+	}
>>+
>>+	if (changed)
>>+		writer->ops->sync(writer);
>>+	return changed;
>>+}
>>+
>>+#define entry_sync_writer entry_sync_writer128
>>+#define quanta_t u128
>>+#define NS(name) CONCATENATE(name, 128)
>>+#include "entry_sync_template.h"
>>+#endif
>>-- 
>>2.43.0
>>
