Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B43299927;
	Tue,  3 Feb 2026 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135854; cv=none; b=igKL1bu2HUOo+V/i2/D73j0B81PsDfqbt3qu5Ix2WCmnhULrFh+2cJTgpijdR94+RNk28fknfRZ5DSBKojgi41rFuF1Qpam870kbFRBZtYgWZuokmzveTzJkfGZBquKl9do4ptTkItL9v6kteeh1v7uB8F0bFmuV13PSxkj4P9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135854; c=relaxed/simple;
	bh=3aWB9czdX77ko627FLVQ27Wjd4hw35wKPWJ59FT1Nc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fw+2b7l67OLCasC/u6HtgZKa6MwjsoElDgO94BqNjN/Mx9+bQsKUPhi/uN6XqfwzGr+WiaIU0LbE0brPacGJSc2Ya4AjNPqADbzZ2m3giKVJyZV/ZhAb2yggUs9SFPJnkNAsvTcUZR0Ld0/qB8yIZvU2CPW8M1wuE271jUFFSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEoKDQcS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEoKDQcS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38322C116D0;
	Tue,  3 Feb 2026 16:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770135854;
	bh=3aWB9czdX77ko627FLVQ27Wjd4hw35wKPWJ59FT1Nc8=;
	h=From:To:Cc:Subject:Date:From;
	b=VEoKDQcSOZMiRh7FM1iEhhRu5QbWSUeI7ZduuVBt7+h6MKTUV1peDI5N7SUYtjOve
	 5sKwd/aFYFzW9gHn5KtTmYOHBWo2FabQdNkrvF9HIo3FbARyx+7G0mWZ9kvjrdhNLj
	 vm0icwyb1WptXgOTyZtI8grYrK0iaffW6tPoF/X0CPCzmmm6cR3ax8ge+hcQy7CzRg
	 4KyDqET42t87Ufjq01zYu6QDyLP7xu6u9tEfyckoh0c5uTf7nwe3zni4O8sVIC1k85
	 GqnGpWs9wTmgX8egAXDRdZbWmRzuuVc9Gbbn4m152LHuq7dur6RXPO070iOliwNX0e
	 sRdYOZHhplnew==
From: Arnd Bergmann <arnd@kernel.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] [RFC] debugobjects: avoid gcc-16.0.1 section mismatch
Date: Tue,  3 Feb 2026 17:23:59 +0100
Message-Id: <20260203162406.2215716-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc-16 has gained some more advanced inlining techniques that enable
it to inline the is_static_object() function pointer into a specialized
version of lookup_object_or_alloc:

WARNING: modpost: vmlinux: section mismatch in reference: lookup_object_or_alloc.part.0+0x1ac (section: .text) -> is_static_object (section: .init.text)

From what I can tell, the transformation is correct, as this
is only called when lookup_object_or_alloc() is called from
debug_objects_selftest(), which is also __init.

I have not come up with a good workaround, so this simply marks
is_static_object() as not __init. Since there are currently only two
files where this happens, that may be an easy way out.

If anyone has a better idea for how to deal with that, let me know!

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/debugobjects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 89a1d6745dc2..056957c4e52f 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1195,7 +1195,7 @@ struct self_test {
 
 static __initconst const struct debug_obj_descr descr_type_test;
 
-static bool __init is_static_object(void *addr)
+static bool is_static_object(void *addr)
 {
 	struct self_test *obj = addr;
 
-- 
2.39.5

