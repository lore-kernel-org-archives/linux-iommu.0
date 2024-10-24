Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734391F9ECC
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787145; cv=none; b=DJ7u/9NiUorNyv0o/rhzxWGrxZqjPLI3ehkyThBv1EIOWl14spXy173KxSm0FWG00f+NbBIIzbjkDIuERgyWitHj5m41z9VsWQKsZC1xHnSPma6f4yg6AfbNFS4iU+AvsLth7jUqiwrUQinNNFdMRNQ3McgbxpRC72HyGymYQik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787145; c=relaxed/simple;
	bh=LEBgTUnCCavk4XESlWe8Ym/R2LORUkbfBaXuaMM0wrw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OqxCRK6cfFTveN/dk9qf0Xh5UU8lSWNcvB43dawUsoynI4PuDTtPCM/JSDJfvkz9a9X18Xt0odRJt5h/NNev055S9Z+X8n7FbLJfeNa3IpHqLXOJolQA/InYvmnwQzePxoOIlNYO7l75yQ5wLqAGKfkQlrdO0Sumap3P2v3nqNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yt45ZiQH; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yt45ZiQH"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4316e2dde9eso11131155e9.2
        for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729787142; x=1730391942; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UsCpK9EL3WBrTQl/LxYwj8dMuww/QQmOZNLTkcqzgvw=;
        b=yt45ZiQHkRp6C+TAKT/8hkVgW4KVIMw1o4mYn/tXAAgc/FS/Ke4jXJDozpnK/hbhgV
         zFCpPOlQ3ZkMY41IOKry+iRqC+qpX0j/RHVGBg7lCnDXD3S63UucweHHbKWHJ4xQxX0+
         CyymWuDLwi4j6jzlkajwXp8BEUiWJ7rj8N8PFyFTxnG9CONNrcFA9hdJwX8y8vs5BOGX
         udWFm7607OQu3RUpv2k1+EESovm5Y8D+ed7tIkTRvL1LioefjOJ8zfmRp3VqyvUOOUHR
         UnNyv033rDIbep45Y7/jH/Maec8YhrTw7KUU7PFFJnm7yGDN/K1iIb8CVlZrXQh3xJ5+
         2w/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729787142; x=1730391942;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UsCpK9EL3WBrTQl/LxYwj8dMuww/QQmOZNLTkcqzgvw=;
        b=M7vobLX1vVArIEoTFyXi6VOHQ8icRVbqPmBxHIJcLoS4t5rZiY/X8nd2w+xU8zY4Ro
         p7eGA7UZhVnNsNhWjTF4267rxjK7sRdcCSrwL7GSCBomQdUpUOE4VL8dplASLyBHmZRK
         aVBNv+lMh9eC519KEduQVAuY6pi2kK10AI2eVEMPT4beOwLc01q34sRTh7G/rg25aCqd
         Vqy/6uLj/9pjkJrCjW5KRCjMeHud3tqxXSyVvpptamkV3rHJhYwm9nSjHzvmfEiJXcXR
         d6tDzGT2Yq0019+xyVYgfXxLYlf4KMk1fE+b5Bt35r4FzPn5GXyFoFScqyTFBvPoukC3
         cYzw==
X-Forwarded-Encrypted: i=1; AJvYcCWycZpIlUBVQXKrjx3mKONOCv7GaSWw4XhElnNfXO0D+eqbSyjNsYUyVFQgjdtyZ9z2cQ9lvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6Tg8IGl+lhbQeulXZqrz0IhgNKe0HUMDVuZy6uru25+72fxib
	xw+SS0eynqB7dwxwq6T3/mz+NGlLbmzGR2AJ6RejRGApnWF0S7dRVEZjjkqJMStZgRC8tcNh4w3
	syyV2qjU49A==
X-Google-Smtp-Source: AGHT+IG9pePnfv6Q2uIrCeDhwlQCCiK/QZZKTazhUEbVv0rozU2r0vhyS6+O/NBsXh3MroRlMS7z8qAoBEUUYg==
X-Received: from mostafa.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a05:600c:6b6c:b0:42c:a585:5ec3 with SMTP
 id 5b1f17b1804b1-4318c72bd26mr65625e9.4.1729787141740; Thu, 24 Oct 2024
 09:25:41 -0700 (PDT)
Date: Thu, 24 Oct 2024 16:25:16 +0000
In-Reply-To: <20241024162516.2005652-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241024162516.2005652-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241024162516.2005652-3-smostafa@google.com>
Subject: [PATCH 2/2] iommu/io-pgtable-arm: Add self test for the last page in
 the IAS
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a case in the selftests that can detect some bugs with concatenated
page tables, where it maps the biggest supported page size at the end of
the IAS, this test would fail without the previous fix.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 3ecbc024e440..71e8046671a4 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -1393,6 +1393,23 @@ static int __init arm_lpae_run_tests(struct io_pgtable_cfg *cfg)
 			iova += SZ_1G;
 		}
 
+		/*
+		 * Map/unmap the last largest supported page of the IAS, this can
+		 * trigger corner cases in the concatednated page tables.
+		 */
+		mapped = 0;
+		size = 1UL << __fls(cfg->pgsize_bitmap);
+		iova = (1UL << cfg->ias) - size;
+		if (ops->map_pages(ops, iova, iova, size, 1,
+				   IOMMU_READ | IOMMU_WRITE |
+				   IOMMU_NOEXEC | IOMMU_CACHE,
+				   GFP_KERNEL, &mapped))
+			return __FAIL(ops, i);
+		if (mapped != size)
+			return __FAIL(ops, i);
+		if (ops->unmap_pages(ops, iova, size, 1, NULL) != size)
+			return __FAIL(ops, i);
+
 		free_io_pgtable_ops(ops);
 	}
 
-- 
2.47.0.105.g07ac214952-goog

