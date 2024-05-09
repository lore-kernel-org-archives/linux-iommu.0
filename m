Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77E41384B0
	for <iommu@lists.linux.dev>; Thu,  9 May 2024 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284917; cv=none; b=VHtzF9WR9nlYFf93SFHN6Zggm0vaNEZYFOzerUy12QYoWlGY4eiqLrpLLeVHjieNtm6CeriPQyOFQJaDiTcyHNemDCV+8PdaZlgxPBOeSGkZCAffqniF+yzFvL6afmyLtUlpNgQinK2hgMSOI1GtTb4fBiji/7WY0iECEIcu95w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284917; c=relaxed/simple;
	bh=lWLGmZvaxA9RBlByfmCfZky8EH90Zb+6S+z65rzDbew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NcQo8RI6hBEsJ8Q1uKq27Z1b02oYbav/wYfi25EDH4eH4Ezdm3kEH7tYgtl9kG0QMDH881qqaOj27oRNJOJq347CLI1HF0nZcp4thzTnj5PLndWiUdLlkOZdlwgGYtlNm9DtXrwh1n1rSxdjEOF0Oiq7f1aSGmssg/K1qtFkrvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kywmix0y; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kywmix0y"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be5d44307so19671727b3.0
        for <iommu@lists.linux.dev>; Thu, 09 May 2024 13:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284915; x=1715889715; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7hWPJomGop1o1vSO/WNR00I+KyAYhO7ZfPBKMyVYJ3k=;
        b=Kywmix0yhT+uIDMV2PvPwp1mhQT1lLOkJ7okAX1d1WwdYZU2gk7tUJZ5YeiSgr+8OU
         0eoeMmq0CLw2zqRxLHplxkOo55HjT0xOCHG0KhdLjic8/stfcxcmzV+bP3Kg/srvIUdC
         UREP0t1kP/aVoQBw32sXb8Utf+Dcz2oYFiCDH8KsJ5RP7cGeIgeuwWijwW9Muxtcn3VW
         JXrbpqDhYQBt7WYGXTiydSd592q2QCpdrWNPca7gCfa5kFa6wgt5chCIH0l9fNYmwVhJ
         Fh6K3QK36EWbmU58M4owg/FJvxUnjbOFgC8p/oVxuJ6wcs5GfCzR06a3qB1zyU9qDKpF
         5Ryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284915; x=1715889715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hWPJomGop1o1vSO/WNR00I+KyAYhO7ZfPBKMyVYJ3k=;
        b=DlOmfAnPGaGXAXYmuqAi+HvXRYS9gY6PX5puuIyR6dVqID5eiBBMwrmlquR1ojhDNG
         P8ncMVmvGl5RFvnUiEnMzR6QOHBSxM+5qdqRYa0gFFQOMsYMZZYfTq/QhToAnnzsqFN9
         fbUMDKbizMJpwzvE1hWIGsxIUFqsD4YXO6HbwAouNHO+XwulEKAp4AH5S0DrZhmOwivs
         pzJKslyIL9N+cKc/i4K9/kSBfEdm0YwQHrXUP4zfN7ZE0RWnI7hE4QlmisdTjtDa+n0W
         ZHpcPmtlr3v6GtBliMN4BHnJdTw5+kZwrbF/OImSzqEXj02nTxMVGES9Av2GyyKYRoKH
         F02w==
X-Forwarded-Encrypted: i=1; AJvYcCWvBmgokIiWB0fNIIa9+EueMTdjFGNJyJI74QIOtn5zBqWsmxzP/pFHORgm9HTfyf/fbAVj66Gph854lnzkbv+ubm74YVE=
X-Gm-Message-State: AOJu0YyeuJscXasltCEYgFt7TrGrHTpouuwtZq4x9U5gOkOBzhZG2CAA
	z8HEpPCTFaAinsNYU6xZDD/UUR7pubbLdUHDozO0qKVRjtv4tAg8E1HXyDcb9PsNF3dZnoITT+V
	vDA==
X-Google-Smtp-Source: AGHT+IHpbKZq4QkjTflQ8ArARtMBvh0PZ9C9VKKW9QcnoVDxM8W2W8fLFQ/oTQAQRdxFasvDcO10UKeRsB8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:490d:b0:611:2c40:e8d0 with SMTP id
 00721157ae682-622affa3fadmr1378917b3.3.1715284914803; Thu, 09 May 2024
 13:01:54 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:16 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-25-edliaw@google.com>
Subject: [PATCH v3 24/68] selftests/iommu: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/iommu/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
index 32c5fdfd0eef..fd6477911f24 100644
--- a/tools/testing/selftests/iommu/Makefile
+++ b/tools/testing/selftests/iommu/Makefile
@@ -2,8 +2,6 @@
 CFLAGS += -Wall -O2 -Wno-unused-function
 CFLAGS += $(KHDR_INCLUDES)
 
-CFLAGS += -D_GNU_SOURCE
-
 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += iommufd
 TEST_GEN_PROGS += iommufd_fail_nth
-- 
2.45.0.118.g7fe29c98d7-goog

