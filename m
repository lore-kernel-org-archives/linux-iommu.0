Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EE78287E;
	Wed, 25 Mar 2026 01:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774403766; cv=none; b=AqZ7jFsADRWtfjUl7QWNBZLb5W3HyksHMlDX3dzMoqyi2ghd9T58YxEIzayHf3qbSybz1mMUNMKDYDeKbvZZhSn8qgvZAGI8Gq0TQ3PzoKn2et7gV3yXGo6GxGUHxt6ot+Q3d+sayY/4jb5863WF8uOannimTGLDS4vgiLoMhDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774403766; c=relaxed/simple;
	bh=yNAn9WZ1bkmu8bq86Zq2a7Y4iC8l016X5qbg7I38ngc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=im9f+c3CKEcPjZG17d83jP6lWhwqgJApkJDnRqv18duDDcOp+siujfDU1rkXIoc3/I7x7UXfKsfwJ5FX8i8xsf7dBk2l8WGS2VePDsqsLs9qEMHpfsfhTjf5HctJ1TJJ8BZQU5yGJbWvfScPqZ3a29Jc6tkHj2gnLsHXjpPGPZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iET3QmVW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iET3QmVW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8AEC19424;
	Wed, 25 Mar 2026 01:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774403766;
	bh=yNAn9WZ1bkmu8bq86Zq2a7Y4iC8l016X5qbg7I38ngc=;
	h=From:To:Cc:Subject:Date:From;
	b=iET3QmVWb1ppfJrCgokNcSeBZVhPTqqh+QaFN0iOq6ZuyFx4qC4OWSe0k3uJl7wd1
	 n3EP1GcYK7A40qcjnay+up9SWC8W5W/WZ9moXEUz/bs+VtojSG0FPt06c4a8kBbv2S
	 tQKwB0ao9H0+IrGaAnwGLEzE3aZnGlqT+ruErDppv5+eW9655XRY33l9/JOodhnSdr
	 XWANgjeA2n/mJqsM5wD60rbD1RujbFWdzK+Inl2tkl8cU4yuaCWZuHvOR0r0KDqyVI
	 fv5firBMeTJ3aHo/opdx8WmIBz2XGEADt6YcdFT4gOIqbk3lvgQhAR0Vw3xNjg1YbL
	 0FifGfmoD1Tgw==
From: Miguel Ojeda <ojeda@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org
Subject: [PATCH] dma-mapping: add missing `inline` for `dma_free_attrs`
Date: Wed, 25 Mar 2026 02:55:48 +0100
Message-ID: <20260325015548.70912-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under an UML build for an upcoming series [1], I got `-Wstatic-in-inline`
for `dma_free_attrs`:

      BINDGEN rust/bindings/bindings_generated.rs - due to target missing
    In file included from rust/helpers/helpers.c:59:
    rust/helpers/dma.c:17:2: warning: static function 'dma_free_attrs' is used in an inline function with external linkage [-Wstatic-in-inline]
       17 |         dma_free_attrs(dev, size, cpu_addr, dma_handle, attrs);
          |         ^
    rust/helpers/dma.c:12:1: note: use 'static' to give inline function 'rust_helper_dma_free_attrs' internal linkage
       12 | __rust_helper void rust_helper_dma_free_attrs(struct device *dev, size_t size,
          | ^
          | static

The issue is that `dma_free_attrs` was not marked `inline` when it was
introduced alongside the rest of the stubs.

Thus mark it.

Fixes: ed6ccf10f24b ("dma-mapping: properly stub out the DMA API for !CONFIG_HAS_DMA")
Closes: https://lore.kernel.org/rust-for-linux/20260322194616.89847-1-ojeda@kernel.org/ [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
Not sure if you would consider this a bug (I used "Fixes" and "Closes"
because it was not originally intended) or whether you would want to
backport it -- of course, feel free to edit the tags as you prefer!

 include/linux/dma-mapping.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 29973baa0581..f46a0848cb24 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -248,8 +248,8 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 {
 	return NULL;
 }
-static void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
-		dma_addr_t dma_handle, unsigned long attrs)
+static inline void dma_free_attrs(struct device *dev, size_t size,
+		void *cpu_addr, dma_addr_t dma_handle, unsigned long attrs)
 {
 }
 static inline void *dmam_alloc_attrs(struct device *dev, size_t size,

base-commit: c369299895a591d96745d6492d4888259b004a9e
--
2.53.0
