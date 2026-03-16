Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8500D3A1A41
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678931; cv=none; b=qDs4hn8m6EyyUI2DDPGfWHvPLkLrdPBD7poAdrYqUiy5yO4hIror/Y1nOoS0YVQFSu1wUM8eVlIVo+xADykDgPVGncUP3/UONMla2bnWerMc4ZIZgtSc61LUXFHyhF+shr3i5QP3w6fr2xfUmsxBd0rWuOiHZSFOpQzZNasLAqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678931; c=relaxed/simple;
	bh=ISn5ON6w+5GwQqhvcbrCofpyJg4YA6sq++2rCfc6MT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptb+Rb84kHT+XBlu4tUI/13KUzC5aqsV7zNiqHiPrbpNqYLR8/fq4l9ROvAuIzl1Avy/Nno6DloWdNN7BsFcSHXJZRtGB+nDwGL+UQwUBl1a5/A3QTsZcClkMyMWv+3GwT3s16IolDTI3wMb8z06iuSZPEO3t8ySLwiAQmSDbrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CBsrC53y; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CBsrC53y"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aeab6ff148so165315ad.1
        for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 09:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773678929; x=1774283729; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1M2iLhUSRNjEtCxR11HMJcm+MrXVoBCuLKPvN78yF7o=;
        b=CBsrC53yTaB8gilhOwKPygbBYID+3POaapG9M2yIRGXx/1vw+KIzfVT2i/syfp/02j
         BUArckPU0GuULz7TpQ0IuAvGO78v6P51q5txn5Nt0xqknFeCL8J2B5hB5Q5BhLALu45Y
         25td5ZrjpKxY3Fdu0KelWpNGr4SB++86ZgHv7VXFxjwzTrjplSZv1AjoMQB0MDtaaEAO
         pZ7vUoNN+Q8/rbZeQTBOS1mlGNNVe62QjJnLgLHT3c0WDie2G5OeqjZ2D+Nb327FLSlK
         8/C8EugWuV8aEyKaoiv3Y45JQbI7j9jlAGzoh6x0fvp9DoIZ6jnZTed+o/dYUYBBO2Vt
         AaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773678929; x=1774283729;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1M2iLhUSRNjEtCxR11HMJcm+MrXVoBCuLKPvN78yF7o=;
        b=gGVVHCdm34D0TZsRkdXMiPwF5E2FIBkP29vkzA/0NeBI/ZwJhImn0kCba+0vcWtUfH
         w1KR8pp3hS2cvtpWQci3VIhJGNJvhceEbqVIbIil0R0GkfLkO6lPE/DfJq0M6ccWNzX9
         mSuEXJ98WDUitO5zJm70VQpi1d27yQh1cGQIHJDH55RnJP4aW6VTf21s6BlL/7ptugzK
         LRUgUgaSmhSpMRIDj1wSBatfzuJk+sZHjrq90+2chpOEGvg7tglUkOzLa0x9ChcgZ7DU
         Tu1nIoGwNwiigMgUEIZWQ8zfE3EFKbYHySJpciCClWHR500nzZ3M+3dP3JN6rrNrxdf/
         FjMw==
X-Forwarded-Encrypted: i=1; AJvYcCWr+N/V9Y5DFrhpf4/ywbsowZFrnumXywXWA/zweC/0DISBGHCuV9APBikzhMABaQbVFuGJoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwH5Agf0yDxz+dbROsL5tYO8yP+t3SKMnCVOMTV4Bn9GlSjJyAg
	qRtwDQKN0Ha7sajYdwvJqSp5TCgqWEI6uaBmoCzcPMDEBzwsJj+F3gY2CiXnagPEu3nTOwBonfg
	xFy10nw==
X-Gm-Gg: ATEYQzy15KOCVGtz2nSJUBVB2eEYBKly1hbMk5FyM1cd+XJ3DfOhyW5JT2xjX5BqnJi
	yfCtojnuNYOHpLIaY4NtFeAJ4aUW6Qa2Q/7hgyxYedZ0sICA9kIxPs7AhpCquUnHLUsToZrbJu5
	Z74y1iBWwZsjX9fFRt/i8h6yGJYAOamDQm/WcOoRyrp232JeBnYtfFjzYyDUlCMMJcx0o2t+jti
	tIkKauLOwqiTXdvA86lNKa8KFH1yXeT8pFHhPVnSYZkmV9aXfZ+/YsyU3PbYkUQZZ2lEyOrKynF
	L9KRPk2iwQsCHS0xL0wA1g2qGSPB12SFAv07/ITKC2ssCy3cPyYMYP/UCu+lUCZU6FAIDlLTggP
	ze8Ze4E9P2W3/hQ2/Dpfxkc9qaD80iuFb3wkoslyNF+MhcBhCQi2ejcxzjPJ0cqAiPmAJhNfmX/
	WSYk2PD2Fc3uKfflzb+MJSvT8OPB2YLzO0cPsnPBXkB3FvQ5aiDpotxoECl1wG4AcLaySBV9EU
X-Received: by 2002:a17:902:f708:b0:2a9:5ef5:399b with SMTP id d9443c01a7336-2b042d7c248mr4648985ad.19.1773678928161;
        Mon, 16 Mar 2026 09:35:28 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece839dffsm115265145ad.78.2026.03.16.09.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:35:27 -0700 (PDT)
Date: Mon, 16 Mar 2026 16:35:23 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Dmytro Maluka <dmaluka@chromium.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] iommu: Lift and generalize the STE/CD update code
 from SMMUv3
Message-ID: <abgscpN59bvXBeS8@google.com>
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-2-baolu.lu@linux.intel.com>
 <aa9W4ZKYWHr9-UNy@google.com>
 <aa9fQchZJER8QvY0@google.com>
 <61267acf-e42e-4d1e-9942-e241ccffa606@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61267acf-e42e-4d1e-9942-e241ccffa606@linux.intel.com>

On Sat, Mar 14, 2026 at 04:13:27PM +0800, Baolu Lu wrote:
>On 3/10/26 08:06, Samiullah Khawaja wrote:
>>On Mon, Mar 09, 2026 at 11:33:23PM +0000, Samiullah Khawaja wrote:
>>>On Mon, Mar 09, 2026 at 02:06:41PM +0800, Lu Baolu wrote:
>>>>From: Jason Gunthorpe <jgg@nvidia.com>
>>>>
>>>>Many IOMMU implementations store data structures in host memory that can
>>>>be quite big. The iommu is able to DMA read the host memory using an
>>>>atomic quanta, usually 64 or 128 bits, and will read an entry using
>>>>multiple quanta reads.
>>>>
>>>>Updating the host memory datastructure entry while the HW is 
>>>>concurrently
>>>>DMA'ing it is a little bit involved, but if you want to do this 
>>>>hitlessly,
>>>>while never making the entry non-valid, then it becomes quite 
>>>>complicated.
>>>>
>>>>entry_sync is a library to handle this task. It works on the notion of
>>>>"used bits" which reflect which bits the HW is actually sensitive to and
>>>>which bits are ignored by hardware. Many hardware specifications say
>>>>things like 'if mode is X then bits ABC are ignored'.
>>>>
>>>>Using the ignored bits entry_sync can often compute a series of ordered
>>>>writes and flushes that will allow the entry to be updated while keeping
>>>>it valid. If such an update is not possible then entry will be made
>>>>temporarily non-valid.
>>>>
>>>>A 64 and 128 bit quanta version is provided to support existing iommus.
>>>>
>>>>Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>>Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>>>>---
>>>>drivers/iommu/Kconfig               |  14 +++
>>>>drivers/iommu/Makefile              |   1 +
>>>>drivers/iommu/entry_sync.h          |  66 +++++++++++++
>>>>drivers/iommu/entry_sync_template.h | 143 ++++++++++++++++++++++++++++
>>>>drivers/iommu/entry_sync.c          |  68 +++++++++++++
>>>>5 files changed, 292 insertions(+)
>>>>create mode 100644 drivers/iommu/entry_sync.h
>>>>create mode 100644 drivers/iommu/entry_sync_template.h
>>>>create mode 100644 drivers/iommu/entry_sync.c
>>>>
>>>>diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>>>index f86262b11416..2650c9fa125b 100644
>>>>--- a/drivers/iommu/Kconfig
>>>>+++ b/drivers/iommu/Kconfig
>>>>@@ -145,6 +145,20 @@ config IOMMU_DEFAULT_PASSTHROUGH
>>>>
>>>>endchoice
>>>>
>>>>+config IOMMU_ENTRY_SYNC
>>>>+    bool
>>>>+    default n
>>>>+
>>>>+config IOMMU_ENTRY_SYNC64
>>>>+    bool
>>>>+    select IOMMU_ENTRY_SYNC
>>>>+    default n
>>>>+
>>>>+config IOMMU_ENTRY_SYNC128
>>>>+    bool
>>>>+    select IOMMU_ENTRY_SYNC
>>>>+    default n
>>>>+
>>>>config OF_IOMMU
>>>>    def_bool y
>>>>    depends on OF && IOMMU_API
>>>>diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
>>>>index 0275821f4ef9..bd923995497a 100644
>>>>--- a/drivers/iommu/Makefile
>>>>+++ b/drivers/iommu/Makefile
>>>>@@ -10,6 +10,7 @@ obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>>>>obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
>>>>obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
>>>>obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
>>>>+obj-$(CONFIG_IOMMU_ENTRY_SYNC) += entry_sync.o
>>>>obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>>>>obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
>>>>obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
>>>>diff --git a/drivers/iommu/entry_sync.h b/drivers/iommu/entry_sync.h
>>>>new file mode 100644
>>>>index 000000000000..004d421c71c0
>>>>--- /dev/null
>>>>+++ b/drivers/iommu/entry_sync.h
>>>>@@ -0,0 +1,66 @@
>>>>+/* SPDX-License-Identifier: GPL-2.0-only */
>>>>+/*
>>>>+ * Many IOMMU implementations store data structures in host 
>>>>memory that can be
>>>>+ * quite big. The iommu is able to DMA read the host memory 
>>>>using an atomic
>>>>+ * quanta, usually 64 or 128 bits, and will read an entry using 
>>>>multiple quanta
>>>>+ * reads.
>>>>+ *
>>>>+ * Updating the host memory datastructure entry while the HW is 
>>>>concurrently
>>>>+ * DMA'ing it is a little bit involved, but if you want to do 
>>>>this hitlessly,
>>>>+ * while never making the entry non-valid, then it becomes 
>>>>quite complicated.
>>>>+ *
>>>>+ * entry_sync is a library to handle this task. It works on the 
>>>>notion of "used
>>>>+ * bits" which reflect which bits the HW is actually sensitive 
>>>>to and which bits
>>>>+ * are ignored by hardware. Many hardware specifications say 
>>>>things like 'if
>>>>+ * mode is X then bits ABC are ignored'.
>>>>+ *
>>>>+ * Using the ignored bits entry_sync can often compute a series 
>>>>of ordered
>>>>+ * writes and flushes that will allow the entry to be updated 
>>>>while keeping it
>>>>+ * valid. If such an update is not possible then entry will be 
>>>>made temporarily
>>>>+ * non-valid.
>>>>+ *
>>>>+ * A 64 and 128 bit quanta version is provided to support 
>>>>existing iommus.
>>>>+ */
>>>>+#ifndef IOMMU_ENTRY_SYNC_H
>>>>+#define IOMMU_ENTRY_SYNC_H
>>>>+
>>>>+#include <linux/types.h>
>>>>+#include <linux/compiler.h>
>>>>+#include <linux/bug.h>
>>>>+
>>>>+/* Caller allocates a stack array of this length to call 
>>>>entry_sync_write() */
>>>>+#define ENTRY_SYNC_MEMORY_LEN(writer) ((writer)->num_quantas * 3)
>>>>+
>>>>+struct entry_sync_writer_ops64;
>>>>+struct entry_sync_writer64 {
>>>>+    const struct entry_sync_writer_ops64 *ops;
>>>>+    size_t num_quantas;
>>>>+    size_t vbit_quanta;
>>>>+};
>>>>+
>>>>+struct entry_sync_writer_ops64 {
>>>>+    void (*get_used)(const __le64 *entry, __le64 *used);
>>>>+    void (*sync)(struct entry_sync_writer64 *writer);
>>>>+};
>>>>+
>>>>+void entry_sync_write64(struct entry_sync_writer64 *writer, 
>>>>__le64 *entry,
>>>>+            const __le64 *target, __le64 *memory,
>>>>+            size_t memory_len);
>>>>+
>>>>+struct entry_sync_writer_ops128;
>>>>+struct entry_sync_writer128 {
>>>>+    const struct entry_sync_writer_ops128 *ops;
>>>>+    size_t num_quantas;
>>>>+    size_t vbit_quanta;
>>>>+};
>>>>+
>>>>+struct entry_sync_writer_ops128 {
>>>>+    void (*get_used)(const u128 *entry, u128 *used);
>>>>+    void (*sync)(struct entry_sync_writer128 *writer);
>>>>+};
>>>>+
>>>>+void entry_sync_write128(struct entry_sync_writer128 *writer, 
>>>>u128 *entry,
>>>>+             const u128 *target, u128 *memory,
>>>>+             size_t memory_len);
>>>>+
>>>>+#endif
>>>>diff --git a/drivers/iommu/entry_sync_template.h 
>>>>b/drivers/iommu/ entry_sync_template.h
>>>>new file mode 100644
>>>>index 000000000000..646f518b098e
>>>>--- /dev/null
>>>>+++ b/drivers/iommu/entry_sync_template.h
>>>>@@ -0,0 +1,143 @@
>>>>+/* SPDX-License-Identifier: GPL-2.0-only */
>>>>+#include "entry_sync.h"
>>>>+#include <linux/args.h>
>>>>+#include <linux/bitops.h>
>>>>+
>>>>+#ifndef entry_sync_writer
>>>>+#define entry_sync_writer entry_sync_writer64
>>>>+#define quanta_t __le64
>>>>+#define NS(name) CONCATENATE(name, 64)
>>>>+#endif
>>>>+
>>>>+/*
>>>>+ * Figure out if we can do a hitless update of entry to become 
>>>>target. Returns a
>>>>+ * bit mask where 1 indicates that a quanta word needs to be 
>>>>set disruptively.
>>>>+ * unused_update is an intermediate value of entry that has 
>>>>unused bits set to
>>>>+ * their new values.
>>>>+ */
>>>>+static u8 NS(entry_quanta_diff)(struct entry_sync_writer *writer,
>>>>+                const quanta_t *entry, const quanta_t *target,
>>>>+                quanta_t *unused_update, quanta_t *memory)
>>>>+{
>>>>+    quanta_t *target_used = memory + writer->num_quantas * 1;
>>>>+    quanta_t *cur_used = memory + writer->num_quantas * 2;
>>>>+    u8 used_qword_diff = 0;
>>>>+    unsigned int i;
>>>>+
>>>>+    writer->ops->get_used(entry, cur_used);
>>>>+    writer->ops->get_used(target, target_used);
>>>>+
>>>>+    for (i = 0; i != writer->num_quantas; i++) {
>>>>+        /*
>>>>+         * Check that masks are up to date, the make functions are not
>>>
>>>nit: "the make functions" looks like a typo.
>
>That seems to be a typo. Will clear it in v2.
>
>>>>+         * allowed to set a bit to 1 if the used function 
>>>>doesn't say it
>>>>+         * is used.
>>>>+         */
>>>>+        WARN_ON_ONCE(target[i] & ~target_used[i]);
>>>>+
>>>>+        /* Bits can change because they are not currently being used */
>>>>+        unused_update[i] = (entry[i] & cur_used[i]) |
>>>>+                   (target[i] & ~cur_used[i]);
>>>>+        /*
>>>>+         * Each bit indicates that a used bit in a qword needs to be
>>>>+         * changed after unused_update is applied.
>>>>+         */
>>>>+        if ((unused_update[i] & target_used[i]) != target[i])
>>>>+            used_qword_diff |= 1 << i;
>>>>+    }
>>>>+    return used_qword_diff;
>>>>+}
>>>>+
>>>>+/*
>>>>+ * Update the entry to the target configuration. The transition 
>>>>from the current
>>>>+ * entry to the target entry takes place over multiple steps 
>>>>that attempts to
>>>>+ * make the transition hitless if possible. This function takes 
>>>>care not to
>>>>+ * create a situation where the HW can perceive a corrupted 
>>>>entry. HW is only
>>>>+ * required to have a quanta-bit atomicity with stores from the 
>>>>CPU, while
>>>>+ * entries are many quanta bit values big.
>>>>+ *
>>>>+ * The difference between the current value and the target 
>>>>value is analyzed to
>>>>+ * determine which of three updates are required - disruptive, 
>>>>hitless or no
>>>>+ * change.
>>>>+ *
>>>>+ * In the most general disruptive case we can make any update 
>>>>in three steps:
>>>>+ *  - Disrupting the entry (V=0)
>>>>+ *  - Fill now unused quanta words, except qword 0 which contains V
>>>>+ *  - Make qword 0 have the final value and valid (V=1) with a 
>>>>single 64
>>>>+ *    bit store
>>>>+ *
>>>>+ * However this disrupts the HW while it is happening. There 
>>>>are several
>>>>+ * interesting cases where a STE/CD can be updated without 
>>>>disturbing the HW
>>>>+ * because only a small number of bits are changing (S1DSS, 
>>>>CONFIG, etc) or
>>>>+ * because the used bits don't intersect. We can detect this by 
>>>>calculating how
>>>>+ * many 64 bit values need update after adjusting the unused 
>>>>bits and skip the
>>>>+ * V=0 process. This relies on the IGNORED behavior described in the
>>>>+ * specification.
>>>>+ */
>>>>+void NS(entry_sync_write)(struct entry_sync_writer *writer, 
>>>>quanta_t *entry,
>>>>+              const quanta_t *target, quanta_t *memory,
>>>>+              size_t memory_len)
>>>>+{
>>>>+    quanta_t *unused_update = memory + writer->num_quantas * 0;
>>>>+    u8 used_qword_diff;
>>>>+
>>>>+    if (WARN_ON(memory_len !=
>>>>+            ENTRY_SYNC_MEMORY_LEN(writer) * sizeof(*memory)))
>>>>+        return;
>>>>+
>>>>+    used_qword_diff = NS(entry_quanta_diff)(writer, entry, target,
>>>>+                        unused_update, memory);
>>>>+    if (hweight8(used_qword_diff) == 1) {
>>>>+        /*
>>>>+         * Only one quanta needs its used bits to be changed. This is a
>>>>+         * hitless update, update all bits the current entry is 
>>>>ignoring
>>>>+         * to their new values, then update a single "critical quanta"
>>>>+         * to change the entry and finally 0 out any bits that are now
>>>>+         * unused in the target configuration.
>>>>+         */
>>>>+        unsigned int critical_qword_index = ffs(used_qword_diff) - 1;
>>>>+
>>>>+        /*
>>>>+         * Skip writing unused bits in the critical quanta since we'll
>>>>+         * be writing it in the next step anyways. This can save a sync
>>>>+         * when the only change is in that quanta.
>>>>+         */
>>>>+        unused_update[critical_qword_index] =
>>>>+            entry[critical_qword_index];
>>>>+        NS(entry_set)(writer, entry, unused_update, 0,
>>>>+                  writer->num_quantas);
>>>>+        NS(entry_set)(writer, entry, target, critical_qword_index, 1);
>>>>+        NS(entry_set)(writer, entry, target, 0, writer->num_quantas);
>>>>+    } else if (used_qword_diff) {
>>>>+        /*
>>>>+         * At least two quantas need their inuse bits to be changed.
>>>>+         * This requires a breaking update, zero the V bit, write all
>>>>+         * qwords but 0, then set qword 0
>>>>+         */
>>>>+        unused_update[writer->vbit_quanta] = 0;
>>>>+        NS(entry_set)(writer, entry, unused_update, writer- 
>>>>>vbit_quanta, 1);
>>>>+
>>>>+        if (writer->vbit_quanta != 0)
>>>>+            NS(entry_set)(writer, entry, target, 0,
>>>>+                      writer->vbit_quanta - 1);
>>>
>>>Looking at the definition of the entry_set below, the last argument is
>>>length. So if vbit_quanta 1 then it would write zero len. Shouldn't it
>>>be writing quantas before the vbit_quanta?
>>>>+        if (writer->vbit_quanta != writer->num_quantas)
>>
>>Looking at this again, I think vbit_quanta can never be equal to
>>num_quanta as num_quantas is length and vbit_quanta is index?
>>>>+            NS(entry_set)(writer, entry, target,
>>>>+                      writer->vbit_quanta,
>>
>>Staring from vbit_quanta will set the present bit if it is set in the
>>target?
>>>>+                      writer->num_quantas - 1);
>>>
>>>Sami here, the last argument should not have "- 1".
>>
>>I meant "Same here".
>
>This branch is the disruptive update path. The process is:
>
>1. Clear the Valid bit. The hardware now ignores this entry.
>2. Write all the new data for the words before the Valid bit.
>3. Write all the new data for the words after the Valid bit.
>4. Write the word containing the Valid bit. The entry is now live again
>   with all the new data.
>
>Yes. The last argument for entry_set is length, not index. So perhaps I
>could update it like this?
>
>diff --git a/drivers/iommu/entry_sync_template.h 
>b/drivers/iommu/entry_sync_template.h
>index 646f518b098e..423cbb874919 100644
>--- a/drivers/iommu/entry_sync_template.h
>+++ b/drivers/iommu/entry_sync_template.h
>@@ -118,12 +118,11 @@ void NS(entry_sync_write)(struct 
>entry_sync_writer *writer, quanta_t *entry,
>                NS(entry_set)(writer, entry, unused_update, 
>writer->vbit_quanta, 1);
>
>                if (writer->vbit_quanta != 0)
>-                       NS(entry_set)(writer, entry, target, 0,
>-                                     writer->vbit_quanta - 1);
>-               if (writer->vbit_quanta != writer->num_quantas)
>+                       NS(entry_set)(writer, entry, target, 0, 
>writer->vbit_quanta);
>+               if (writer->vbit_quanta + 1 < writer->num_quantas)
>                        NS(entry_set)(writer, entry, target,
>-                                     writer->vbit_quanta,
>-                                     writer->num_quantas - 1);
>+                                     writer->vbit_quanta + 1,
>+                                     writer->num_quantas - 
>writer->vbit_quanta - 1);

This looks good.

nit: I am wondering whether we can change the arguments to the function,
by modifying the loop in entry_set, to be start and end quanta instead?
That way the caller doesn't have to do these bound checks? What do you
think?
>
>
>                NS(entry_set)(writer, entry, target, 
>writer->vbit_quanta, 1);
>        } else {
>
>Thanks,
>baolu

Thanks,
Sami
