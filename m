Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3331B25744D;
	Wed, 21 Jan 2026 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769021038; cv=none; b=o683k01ds3dKjPqFPqjaR7WI/+HjUbtCrOrWpvLbP02iV3Ykd3yH9gjCFuEyR4tBtm3kBsU86Jmgkzbapcwd04XDvlwVYCn3CHWZviIuteCkQbducjfR4f06tcOFW/E1asQRKvHs9RpYaOFdtK5yCAZAFSl8ngTMpx9vaaB8p10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769021038; c=relaxed/simple;
	bh=NIsmmpLGKbWhPgew24tZd6Itt6nMHVhnQNdKYu+CduM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Giq7/20uEDHwWAHfRBp5PL/MftexTQh1QullzwLKLD+lf7UxOXL96OC7c5qn4J7x+ZwSmgvAra1tm2PQlH+rfwJRY9AKaqmFPuIvpIKEIW0qiOjM/tsP+GZe3XM1OP743wIL11dAODphYt2yepLDkUE4JW214oqFTNp2QHl5l/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6QXdMF+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6QXdMF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E864C4CEF1;
	Wed, 21 Jan 2026 18:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769021038;
	bh=NIsmmpLGKbWhPgew24tZd6Itt6nMHVhnQNdKYu+CduM=;
	h=From:To:Cc:Subject:Date:From;
	b=n6QXdMF+AkyZsmWsB5Kvfi+uVgnUz7vd6n26ICpoWR+t97+hJlZhiOYyVvY59wmQc
	 MlDMWVFJhfZ59t5CXX32glMb9bSFSXV84ins247ZaA7RrteF/Sxv/VxwhBTN9Jk6zX
	 Let4ClRljARefhTZDRSs40Q+GN9L3f8bSo4Bem/xhlI1lDA+PpIRUxKVFHiLccfnKn
	 yz0cPkF7DX+1WcsDXUhT1hyl8iJhpls8qjDBjtx0Z4aoafTet8sdfsvPp2m8kH9H74
	 9kRLKsYKiIc8gj1hTpN5UH8+96Z9sYgnOWu2AHFct8+a+0+3ie1Ol6aYMxsCTbqEyx
	 RtM3UsEl4HGSg==
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
Subject: [PATCH 1/2] rust: iommu: fix Rust formatting
Date: Wed, 21 Jan 2026 19:43:38 +0100
Message-ID: <20260121184339.74256-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Rust kernel code should be kept `rustfmt`-clean [1].

Thus run the `rustfmt` target to fix the formatting issue.

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
index 6135ba141e48..916e1f509e62 100644
--- a/rust/kernel/iommu/pgtable.rs
+++ b/rust/kernel/iommu/pgtable.rs
@@ -14,7 +14,7 @@
     bindings,
     device::{
         Bound,
-        Device //
+        Device, //
     },
     devres::Devres,
     error::to_result,
--
2.52.0
