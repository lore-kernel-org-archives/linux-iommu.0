Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BC73DA7F8;
	Wed, 21 Jan 2026 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769021042; cv=none; b=iEJDAgPZWFt5CTjw5sn99cZ0OqQG5x2wdwk0RNci8QjWhI8D7ZQ3gSUceENtSCaMRvIsJk43FdIg5KM5SKziZV92iooDH0Qd/C9hZ/fvpnTQ6675IlUmmxVOMXNVLgtSEXdjKwaWcPDPamh+rqR/WxfgFNheBpiRpDdiUx6K59o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769021042; c=relaxed/simple;
	bh=mj+MkfqBfysd5WN6fyCylhbGOzwUmTZAk8Fa7FFP2JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cAlp3azwKOX9qCsA1LLjfEMH/2UhHFrp+gR6J0Zz2HIwFWKLAmYJRWjlm+XboPQUvNb3wuH5t/xEeIo8YsUTI8OBabWAOEqgBoTdPDvlHLp81R0iP4j6CskwjjriUfXfMfZSQfTOY7KKEnWr5jI+1lp9sRwPwZNxrhfy3O32VNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TE+eIPVA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TE+eIPVA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABA9C4CEF1;
	Wed, 21 Jan 2026 18:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769021041;
	bh=mj+MkfqBfysd5WN6fyCylhbGOzwUmTZAk8Fa7FFP2JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TE+eIPVAAj3xpBcRmTjAh2N+Q31fvxwhK2jBp1y3D+BV/3L6TSagfJsZAEB2+3Dkr
	 QeY9GXonI+X/7iWsXfYWsaj03V7/eWrU+CszMKsYz/LUrZQJczmZCUQQhFUCF7JmIu
	 +kYKO3ktlRigkEmgf50c2sy6uuZLMNo2fDK7D9ESbzivomBExRuFuHN43MnpjjQnFR
	 qseyzeOMaGMtJC78j7+MYWMQUcGvmM+nMK7e40qth6ajLxsDnhMF+5iDTzFk56Od7x
	 iGg/QJ21UPi/RKvUSJWLjG+f5Tn+irUIQYjO4TT0tbeTaQqKW8QH03saHZycoRLb+l
	 y6p8JfPqO21GA==
From: Miguel Ojeda <ojeda@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
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
	rust-for-linux@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/2] rust: iommu: fix `srctree` link warning
Date: Wed, 21 Jan 2026 19:43:39 +0100
Message-ID: <20260121184339.74256-2-ojeda@kernel.org>
In-Reply-To: <20260121184339.74256-1-ojeda@kernel.org>
References: <20260121184339.74256-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rust kernel code should be kept `rustdoc`-clean [1].

Our custom `srctree` link checker in the `rustdoc` target reports:

    warning: srctree/ link to include/io-pgtable.h does not exist

Thus fix it.

Link: https://rust-for-linux.com/contributing#submit-checklist-addendum [1]
Fixes: 2e2f6b0ef855 ("rust: iommu: add io_pgtable abstraction")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
It would be nice to clean this up, so that Mark may start enforcing it
in linux-next -- thanks!

Please feel free to rebase if needed instead.

Cc: Mark Brown <broonie@kernel.org>

 rust/kernel/iommu/pgtable.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/iommu/pgtable.rs b/rust/kernel/iommu/pgtable.rs
index 916e1f509e62..c88e38fd938a 100644
--- a/rust/kernel/iommu/pgtable.rs
+++ b/rust/kernel/iommu/pgtable.rs
@@ -2,7 +2,7 @@

 //! IOMMU page table management.
 //!
-//! C header: [`include/io-pgtable.h`](srctree/include/io-pgtable.h)
+//! C header: [`include/linux/io-pgtable.h`](srctree/include/linux/io-pgtable.h)

 use core::{
     marker::PhantomData,
--
2.52.0
