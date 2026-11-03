Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721303;
	b=amdKtiIVZtLQyYWpTi9HfBtOcgBBAnrlnvNxJMTRvavUG8wPoxBsy4StmsNpLA5TizdH
	 FxDt6bAdwtfI/tGViR/ezxlKXK9+tcQv2RE+WCPWpE/c1q59C1ks1vlWH7/XdystPT9Ts
	 3/k8u7AxII48i7qa8XqEEIdwXWWurNHzoY5+h6JnaBavGh6eG1mkneuHv/MQU2VQnSGyZ
	 I5v9z49w7KA9BvRFmAEiZHkHia1QdS1cNXixDn1Wm4LJEv+US3l49OLVwyyNRLCqaXsxz
	 1Kq7oIX8mCu1Wz+yCBQOdakw48tjwwXr2UeggaEPpHxVbs0GUClnkNseGWa0tPHx3cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721303;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fGhp2O/N0uN4OUEkdVSlSLYttb9l0vrzXnpdE47eUqI=;
	b=05V7FEoJQOPXUZQUsOHyYHbftQ6xvVWXc6osBMuqgwVPBix3PnYTsoVoE/kKx28AHanM
	 LmfanRSIJZW2G3gcw2iiJLSL7jpZoHcmuJVLEh0xLZxKswn8Z6UqeLqhI8dIoERIdNNU6
	 a99CZmgYeOs8hVMC8G6dpx/S6KAnEwxgAjxyrY1QBvb6LrGYLjrt6F2+x1UoYClcrMjNL
	 dyNo+oeJ/UyweLOsHdvlx4WBJ78MjrN79IxFzKR1AiVc67CAjQhNIx19uHNqQXyPSVUgn
	 cEbcJtmoITVTmd1xQCuNJhCRtjLTdfCSQ/K2nOVduZRQG+kAtOasDUgNwVxsO+EGzNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lpS+OpaD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF79606EE86;
	Tue,  3 Nov 2026 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lpS+OpaD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1711F00A1A;
	Tue,  3 Nov 2026 15:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793721303;
	bh=fGhp2O/N0uN4OUEkdVSlSLYttb9l0vrzXnpdE47eUqI=;
	h=From:To:Cc:Subject:Date;
	b=lpS+OpaDg/8PKdYML7pzVsZdHWVLpkwBjZlbrjiDf1Gb0RkcwUT1Clbt867Wozq9h
	 S0DpCtaPzXFRzxvweaovKqaYaCUru/IOoSjrjUSWAXDKfK0NtjhVkKtiSUncJxEfJg
	 Gnw73qWCD93M4YaI/bBd8CXpSA/pt2rLcGfTT8Ux8gM2YgNjhjQymI6Jy7ipHbQUNB
	 zWLVrYMrdSvakoAV3kfKTp96oMvr62RtFOTVZeiMYmmKrR5wsKdFmS9Jef2EGoI/yj
	 9fOndBMzOEcb+kuOYXURJ3cCNeFaLkDco/f45fwmaJ2yr7jz4az3eEubU3EQNaCpq9
	 GpERD1uAUjX/A==
From: Sasha Levin <sashal@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommufd/selftest: print size_t with %zu
Date: Tue,  3 Nov 2026 10:55:01 -0500
Message-ID: <20261103155501.534820-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 32-bit architectures size_t is an unsigned int, and printing it with
%lu warns:

  iommufd.c:2157:30: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]

Use %zu.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Found with a 32-bit build of the selftests with a 64-bit time_t (gcc 16
and clang 21 with -m32 -D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64);
KernelCI's 32-bit arm builds show the same warnings. The changed files
build without format warnings there now, and the x86_64 builds don't
change. The other selftests get the same kind of fix in separate
patches.

 tools/testing/selftests/iommu/iommufd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index ca2b35e9d443a..c4d4f3659626e 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -2154,7 +2154,7 @@ FIXTURE_SETUP(iommufd_dirty_tracking)
 
 	rc = posix_memalign(&self->buffer, HUGEPAGE_SIZE, mmap_buffer_size);
 	if (rc || !self->buffer) {
-		SKIP(return, "Skipping buffer_size=%lu due to errno=%d",
+		SKIP(return, "Skipping buffer_size=%zu due to errno=%d",
 			   mmap_buffer_size, rc);
 	}
 	assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
-- 
2.53.0

