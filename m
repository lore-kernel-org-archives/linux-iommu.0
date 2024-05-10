Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B79712D776
	for <iommu@lists.linux.dev>; Fri, 10 May 2024 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299808; cv=none; b=kixrrzkba7Ac04NcHSIIWE71I7j4g22tIJ9Nd0rsthN2Adb2rS5+E3/dZQd057XzYY6h9fveo/TAm8wQGKXwDXUZKmoJgOIPHOxGNibqJJIArd4A9I/ZiEPEoxE/UESz67mWDHGhau/tlY9/q5YWZ4rtutcSreLVAWMzoUMLNIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299808; c=relaxed/simple;
	bh=lWLGmZvaxA9RBlByfmCfZky8EH90Zb+6S+z65rzDbew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eLlTACoGaPBIKA72YirHoT1cr3rJ+DfF/S3PS/YqhLtxjIGaj8NTNLCt9BQFo4Sz8ZjzTmO99m8LwiEgpw3WkwvS39fanO14ni9dOuJLseA81upsYOuQdTRVX76LgrQxGrhEeZfS6SEcAXMsSpRtRgMe2t4zvWJY/iBz31hOZuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HFsPYf2K; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HFsPYf2K"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b40ef83453so1281626a91.2
        for <iommu@lists.linux.dev>; Thu, 09 May 2024 17:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299806; x=1715904606; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7hWPJomGop1o1vSO/WNR00I+KyAYhO7ZfPBKMyVYJ3k=;
        b=HFsPYf2KcKkqAPnRDhznRfw8YWBDGVpN8L8pJPtstW0Eg3muuJjraBjVz31DxDWYKO
         aWxD2RDc/uKGAxUuS09q1LOsHLB2ynN8XyFBp+mKOnqcFYUlq5BAIUW0ViraUUWwx7ng
         RqP2H1duXB5V5FbBv84u+JcjXilzDSJUy6rAazP+vAhVmo83MkXohVXeJYlGGwOmlI9k
         9hQBsda7mXHEZlMehcwgxVQ0c30yR80pCxqGNuBfGJsungRD84pjwfzoloMsVGo1r28r
         CZGfxFnn1sSbesVCI0vbZcYzTGwtBK3GPnl7FXJBX8Ok0EB6aSrLk7IoZnH6AfVQpYW8
         fPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299806; x=1715904606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hWPJomGop1o1vSO/WNR00I+KyAYhO7ZfPBKMyVYJ3k=;
        b=WuUKaE8nLhdj67RYIZt4ECMSY6V9u1AuHXB54+iQIgIHGZCwDfq6TBCKUwAJUPOj6H
         PfXVytPgqiR+TuQ7kfD7phCgI+oyERzSY1FhM9tYxUONg5UQw0DV2tfkMuI6Ob4NoSdt
         2KFJ8kRMc32ETkiRzdiPpqCwuB1PwAw8kMc4AT2H1se/ThlqtPfno7eedZADTUXhtaef
         gKQhFvPKxWLh2vfOFHyfiU5GLkgr6shYwvJo2/gaOzKTY9M21cymNGOGIuSNN/R8n8LG
         UQlLi9RxCt1pVPThqvBBY4WsWCcAKZVLxutb2NJShyBlvwWkuG4r8za0M3vgbsWtRsuE
         DXpg==
X-Forwarded-Encrypted: i=1; AJvYcCVQrHSIXnmtPQFbqmvRpjfwiUTn/+3K/wpQEtfbjJ113VhMO24+SsOYBCNV/CsxvZy4xCKQoZ9GZ8vkSjKaFvqD50AIyZk=
X-Gm-Message-State: AOJu0YwchmktuotcL1THQ2WXz3EIBM6CXKIgM9iYRbOQBc9xE+9CCcwq
	2hoRDS+9o5rP1WM39ChY9bE0ZwLP38ZxJL66tqSjPtMxFR8jP/pMVY3hUdMI55lNZv12doQS79V
	rwQ==
X-Google-Smtp-Source: AGHT+IEKFRA+4ILvLn3PhPjtR9sP6AseSfyhxdQaYvOqTgra5Rvh/8biTFwGx5IN/9sytyswqGFZAsbivEY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:b112:b0:2b2:7c77:ec7e with SMTP id
 98e67ed59e1d1-2b6ccedd5b5mr2880a91.7.1715299805622; Thu, 09 May 2024 17:10:05
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:39 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-23-edliaw@google.com>
Subject: [PATCH v4 22/66] selftests/iommu: Drop duplicate -D_GNU_SOURCE
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

