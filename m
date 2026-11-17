Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943959;
	b=DNO8k+2zZSza0cEdT+twe5SnoWHujkzaJ9DrhEhHWZaUVL7SC3bhy/7qSnwLoWFdfHhN
	 Cscfshx005wh0A+Rf7A7H7LcSiy2cPA4HrrU9SN53pwiAkztCtNfVoab6O5KibkX+TNoo
	 3cOMsjh1VXnZGJh1t5X+7pCv47e2w4l9PYn9AvXkIPcyI+yUwYrVXxGrYxaaZky6azS3t
	 CE+1D14SOnGw/EdtVlxJ+BeQjf+tY27g+F46F9RO7duRJfl7p02OdeDoVFJEv+LOoGTgB
	 WL/uTRF/GIYr0+20nRJcj2tj8idJ6zj9hKTVYRsMw5GGH8UkqvN/U1AHQ3dY1i/qE3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943959;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Developer-Key:X-Developer-Signature:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=H4pN2M9wOQsksT8v2A6luJsQGTApmzqSYccD0MaszVk=;
	b=C+WgEA4rNdlNjdZISoNK7GGkTJWQGsrlzhSiqtReN0snWGjf+V6dGM8VG2tTYqqLP6iw
	 xAzc+z1umxPXk3sYGoIhhAqOa1JVJWItCWsU9WoMUYhpMG1tMyNULLaUVrne3HTkwEcja
	 YHjnAGrrNy6g5xmMUsrg2elbeZkH3y4+hpwWukN31u80WE2j5NB13c4ZqAgqKgq0hMql1
	 zVJ4PbWSFOGeqr67Scco6G7GkWWVtjJx7jUa7fLWgWhejCyp/QH1OOE2nvimDLdCAU4of
	 j3m0eaIPQnSqMvHAErL6EjnAzCQ7TA5yeiUZYdVA0dKhU4bNqLhyN38H6f6uOwBThsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l5gOkWJj;
	arc=none smtp.remote-ip=209.85.221.71
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321C9606A8AE
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 19:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 321C9606A8AE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=l5gOkWJj
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4915ba023d4so73625f8f.0
        for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 11:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794943957; x=1795548757; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H4pN2M9wOQsksT8v2A6luJsQGTApmzqSYccD0MaszVk=;
        b=l5gOkWJjBjqeV/ksgPI2ILcT8SsMDRauu3cTN7RE8jyLVboWypriEUDSn4/DkQe7PM
         kBaE9ux282RCouZ7ywNTm28BX4OOnNrHjCEWfEK5CQi4Xjs8VCJPTFsnQiX9aFhJGuXJ
         c85V3QrcFKIHldtZ5Ebw4R2d6EPYlnrCCzOhls9MSTrDND8WOvsuD1La8VugJ4fubGlP
         Rm1xkPnClgegpvfDHM/vnjsmH+0r4Sl0FJHVn7x0k7IAQfp3c4ahCanqf7myaa1rmAyE
         Eo8WfLM56z5iXHvNxWaR7TZGIiAagoJ/4w+xdsB/VpvJU//4B+i8tFZLCANgJyLT7cLG
         E5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794943957; x=1795548757;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H4pN2M9wOQsksT8v2A6luJsQGTApmzqSYccD0MaszVk=;
        b=VnLRbrVydhAEfSSkM0ysLGQHwadeakdKT3jJDNZBqitmtIvOrRq4xgv2/zBk8wPzXv
         tyRYyegRIEFd3gEC7TmU2bGhYw9hqs08bR13UYg2XdVuEveQPk1fhr3CrpIC30n7axK0
         p9ewBuTahXTV95W+IhhXhUH9nVqq8xJkQXzHsA4smkisupsqevy2PP6DM0ECa3yE+nan
         KiPaa6SYRlDZyKx2CQbJ6fcEVNhADAMQ30JnKBv1AnycNbJbHmt1lD7KyPRtunkNuV8K
         5HwZHCAa4lbboBv1qCbnhax/UpRjZXJzarzY3uVw1EMlvLKRlB+QxsFrHKNnmtV8Nvmi
         fHZA==
X-Forwarded-Encrypted: i=1; AL+hErFR+AP5QW87hJO/56f/qgRbdEyM+QAvkKgK0sK/xrzWkVbynJxk1ynY/IZFtl+y8lh4EmkmnQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9ELr/4Xah5/I6kKtsMTLz0i8+WDLFcXftdaYJc66mBrK/opGCN
	H5TACIcPaNkXFHKywRxcE0E7fE/3zGSiwQfc7PL60hXiL9s5goJHuRxZCa43kZFOclj5v2B7983
	bRQcyYZ419roOE/hfTQ==
X-Received: from wrri7.prod.google.com ([2002:adf:fc07:0:b0:48e:a88:307b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:4b41:0:b0:4a3:8b21:51bf with SMTP id ffacd0b85a97d-4a63f182f83mr740599f8f.48.1794943957287;
 Tue, 17 Nov 2026 11:32:37 -0800 (PST)
Date: Tue, 17 Nov 2026 19:32:19 +0000
In-Reply-To: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2309; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=+WyZnWDfy306Ajq1PPGtwj5xtYYAYr61kK3N/Swr1tU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq/KvQsa1UM5WU2G5oJXUq4SO8VXyaXylfiF4lZ
 iZXO7H889uJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCavyr0AAKCRAEWL7uWMY5
 RmOED/9SPEc5SVbIFzMOA6exlWVkV17LrOPMbmZ73sFVMoW6dCfBjoLKmng6Ja/pJd0w8Dv3LzD
 CpvEactijAk0jM504Lfmq0eO3Hlu7DpONrjHI+6FRM3pEY7wItYzrkKlhaCp1UmneTU301YlJhe
 xWOV1nOW9Jxt2tBUlTG1mL9eeUiXB/cyfGesZFlTg1OGvyIA+zscZIf6qyf36NL6/rYp6tog4CJ
 ObGH201LRf/gJx3W4Wwfma+Fmu6adSlZf3I/4dXwqf5TLtSYuSt9mIxZEVYsmaWgSepSLsPwriF
 b8KsXKB3oR6FD5nRgJEWoiQSvbXaQ4h/yDq0CX5ohQ1nTSlSAtrzKAiuKTmP2XYpaBvFQOQNLzQ
 QKK9NGzbeulrMV/+dc2l2GhzgbbKUvHYQ85IdcxdCY6vWRs4+EkOp32kW/iDpaQfotRqxItDSdb
 a/SN3nsMgQPLc9NgV5Zmakgr9HdXrOxFeF8N1xFRgaB2Rggd0LyV0mpKM7WLFRl4hmGVctueN9G
 aXQuMEtmhaFiEGToBlacYoxZxAL0Qf5zQ8GJYGLqXY3LEI8ICybR3mYK9Zxd7jxIubVUUp9E+l2
 yiHoYfcfmW884QNrI2NgtfgooFHlOA3QbRPK9rVtt5JhMOaIgBEXuPA3Whj24i04wGYc1Sa2XCQ YjvraWdGlh012KQ==
X-Mailer: b4 0.14.3
Message-ID: <20261117-tyr-remap-2mb-v1-2-2a8efd4c8180@google.com>
Subject: [PATCH 2/4] rust: iommu: pgtable: add iova_to_phys
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
	Deborah Brouwer <deborah.brouwer@collabora.com>, Sami Tolvanen <samitolvanen@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	"=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sami Tolvanen <samitolvanen@google.com>

Tyr's VM_BIND remap path rebuilds the page-table mappings that a partial
unmap sweeps away, recovering their backing from the still-present
entries. Add IoPageTable::iova_to_phys(), which returns the physical
address that an iova maps to.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
[aliceryhl: split into separate gpuvm and iommu commits]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/iommu/pgtable.rs | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/rust/kernel/iommu/pgtable.rs b/rust/kernel/iommu/pgtable.rs
index 5f9b42ca92c2..306c03862a72 100644
--- a/rust/kernel/iommu/pgtable.rs
+++ b/rust/kernel/iommu/pgtable.rs
@@ -199,6 +199,29 @@ pub unsafe fn unmap_pages(&self, iova: usize, pgsize: usize, pgcount: usize) ->
         // SAFETY: The safety requirements of this method are sufficient to call `unmap_pages`.
         unsafe { (unmap_pages)(self.raw_ops(), iova, pgsize, pgcount, core::ptr::null_mut()) }
     }
+
+    /// Translate an `iova` to the physical address it maps to.
+    ///
+    /// Returns [`None`] if `iova` is not mapped. As in the underlying C op, a mapping to physical
+    /// address 0 is indistinguishable from unmapped and also reports [`None`]. The returned address
+    /// includes the offset of `iova` within the mapping block, so it is exact for any `iova`, not
+    /// just block-aligned ones. This walk is lock-free and does not allocate.
+    ///
+    /// # Safety
+    ///
+    /// No other io-pgtable operation may modify the entry covering `iova` while this walk
+    /// executes.
+    #[inline]
+    pub unsafe fn iova_to_phys(&self, iova: usize) -> Option<PhysAddr> {
+        // SAFETY: The `iova_to_phys` function in `io_pgtable_ops` is never null.
+        let iova_to_phys = unsafe { (*self.raw_ops()).iova_to_phys.unwrap_unchecked() };
+
+        // SAFETY: The safety requirements of this method are sufficient to call `iova_to_phys`.
+        let paddr = unsafe { (iova_to_phys)(self.raw_ops(), iova) };
+
+        // A zero return means `iova` is not mapped.
+        (paddr != 0).then_some(paddr)
+    }
 }
 
 // For the initial users of these rust bindings, the GPU FW is managing the IOTLB and performs all

-- 
2.56.1.703.gf848ed807c-goog

