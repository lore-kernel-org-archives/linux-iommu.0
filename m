Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FCB27F4F5
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 00:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789951721; cv=none; b=McHQwhKGYAEWeOydcCj0z0CB9lJSqSg8ZfhqetD3LSwsdJmQg4A2TSrfWHjVtHzXJ/Ea5cvxHfecvStOJYDN3+u0q4VKCFdpU/EKILyKubSbSdJm23K96MAKHJBrbvvQbsc/WZpnN7Eq8rsbWNkRjPlaYWXA+1im1SvlsdqmrLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789951721; c=relaxed/simple;
	bh=smolpSPLyRzt3C+D1JHi3AqucD1pUoZl1tQGGaZ45JA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uUG0KGTegbFH65k9wo3KpcK2SENh6a/Y0NA20gkDHycck2C33irjBcyIB9rvrZGtMrgJMLWV7Obes6s/bxfpVNUAgKVOOK9tk9Bm8xgEhNhVtbZ5EfdqUXMAb96IwnGxK0SCCN2GjfU+pY7r4fy1eevQtT0HCWhgAjEWVgolA5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IUj88nQZ; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IUj88nQZ"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2db8e9fe9c7so35495365ad.0
        for <iommu@lists.linux.dev>; Sun, 20 Sep 2026 17:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789951720; x=1790556520; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5rIYSaUxr2dmbQ4fWz0MikFLRE1YKdMT0WLnLm0z0eI=;
        b=IUj88nQZxCKdhU0QtnbtkkaI21CYSB7+p+i0mcsePF9hiZyjG77NHttq9A8LVEJIUD
         JQ6FBnAIGUkowM2XMmIt2RC/RSLKCYH9uTjHBSILbfP37pLvmiUDCmT4f+wRWjqN83mp
         Xk8IT9rhSPs5aNisRCKlwLxHotoY4MUEVwPizdieobTk1yHA8AyhZr8Wo9Wg6LCAws97
         JeYXSjGkZj4VBn1N4xAKj7X54WXKQz4W4hlw2qQSiPMOLy2lozzNVIIMefqH1wz+gqsC
         OPFzqgHUVAxUGhwqx2UjyEPrlASWMuho89seCMfYQrhvVLOJv/1mHtBnt4lyg/n6VY3G
         Kukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789951720; x=1790556520;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5rIYSaUxr2dmbQ4fWz0MikFLRE1YKdMT0WLnLm0z0eI=;
        b=mgi6kK0JgRWK8gB3HNBPAATUYZcDtf3fOCOPhjCika1Gi5gP3PE3XTLP0JrdOS3fCr
         T8ib0MIyfAresVOyJMR/U2zpAyAccZyo4UMA9k/XSlNblKyn7R7uYceF/tX/rLQojy/i
         VkzAN0xmGTmMt5ofkG7eO5BJZxfPMs+fjjiLMSoZe3PMWaKCsncuCIdhVJEk0YLT8qtW
         QGbisJ2IOrFspx4H4O45BKFzz+mD+02pThyD2ubTSGlsBV0Z6zw7I7dyyW/B0ou8VCSn
         hyV6J/5aH6FdLfOHENVUUjmAoEU0nLxmixoMIzThqZdjp+WXc4TdvOEPEUpQJuBKUY18
         ibTw==
X-Forwarded-Encrypted: i=1; AKwUvBz5W2o4yGesQWfQpdifqnDMTkEQrDv1V/8NWgxzWs8rl5TXes7fdzZUbOKVIAsv+W26jyvriw==@lists.linux.dev
X-Gm-Message-State: AFuF++npuWxUkgOFs371JwD4EDHbFihWR22fxi3NHJzecomRZMeXTeRY
	Wt3iDGEcfovV8F5xVFQ+dwaf/pHbq3Uf4GbclypkEwzQy7Zx2OA1D9fYoxahm8jOrZC0yzWZV7W
	X40d7mtbsI1wv2A==
X-Received: from plld8.prod.google.com ([2002:a17:902:7288:b0:2dd:1e7c:bcec])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3c6b:b0:2dd:c100:9433 with SMTP id d9443c01a7336-2ddc1009c3cmr88814875ad.49.1789951719834;
 Sun, 20 Sep 2026 17:48:39 -0700 (PDT)
Date: Mon, 21 Sep 2026 00:48:17 +0000
In-Reply-To: <20260921004834.2601285-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260921004834.2601285-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260921004834.2601285-2-skhawaja@google.com>
Subject: [PATCH v5 01/18] memfd: export memfd_get_seals()
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, "Pratyush Yadav (Google)" <pratyush@kernel.org>, Ankit Soni <Ankit.Soni@amd.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

memfd_get_seals() is used by iommufd during preservation to make sure
that he preserved memfd was sealed when it was mapped into iommufd.
Since iommufd can be built as a module, export memfd_get_seals() to
avoid linker error.

Cc: Hugh Dickins <hughd@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org

Acked-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 mm/memfd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index c708d92533f4..888ccf3778c7 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -6,6 +6,7 @@
  * use by hugetlbfs as well as tmpfs.
  */
 
+#include <linux/export.h>
 #include <linux/fs.h>
 #include <linux/vfs.h>
 #include <linux/pagemap.h>
@@ -310,12 +311,19 @@ int memfd_add_seals(struct file *file, unsigned int seals)
 	return error;
 }
 
+/**
+ * memfd_get_seals - Gets current seals on a memfd
+ * @file: struct file representing the memfd
+ *
+ * Returns seals if file is a memfd, otherwise returns -EINVAL
+ */
 int memfd_get_seals(struct file *file)
 {
 	unsigned int *seals = memfd_file_seals_ptr(file);
 
 	return seals ? *seals : -EINVAL;
 }
+EXPORT_SYMBOL_GPL(memfd_get_seals);
 
 long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 {
-- 
2.55.0.1082.g2b9226bbc0-goog

