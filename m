Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792478310;
	b=JqTPdKCXRqXSA6jtKZFQqoSlAGfb42zXniHpm3F3UtrS3Z3lJLMjHA9muMdv1FXIkpnP
	 io+LFYR3x434dveTWoLJ6dVM4dMzQ6jkoRH+fvtM+biwTpwVqxflnaJkOTD5F4f+iLP1R
	 Swntkx0rZrYtF78nkNlkS520dI1srlCyvCvDHz4ywOzTNtZXq/rpPWmp6XOTdwUurHuHm
	 sZQfKOZ9Nm17SXNgrigIGOlxPXSQUCoiPllt7Tr3WDkSvdaQuLKuqcjPaa3y8ZCl98LBZ
	 +rfWb5Aln8daa4/FmfnLp+Bmiye9JWuCQPx0+ENfpadToXEbloprHWA5zBfMhDge6vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478310;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=u9+toBtEEPVpz6hTN7Pcfhr9T4/drBZovt9bfqsgE5Q=;
	b=QXcsB/ulbP1HuKKg6pdjHSFUyymTnBv4bBphAhWFxyQYf8K/eqtbXC/UqllOzefxDKEs
	 3hELhRcuG0/cotIQrlf0WyrY3ntuRE+S1jCHJyaZ80qwt7vye00tIGcBbrdFq0kSosyxf
	 5zuB65HbwR/+WvlHofVQvjVPaKw4Y3v/+tbvgKOtINQSKWyycMOGSookAytvWyVlSpifO
	 mBq1J17Zgz1eiAUIPaIzMHFVtqKUPgK5fg9w1bdM+hX3QSpi6GyT2Tc66UNbOF9RQXTIa
	 PVHNPiIakXW8M4ox1f8JPS2JizjF2tVVy7LnJn1LK2R6uoOpOGNpm0R0nIPPBGox7mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q4G21wEt;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772B360A2615
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 06:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 772B360A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=q4G21wEt
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso2335790f8f.1
        for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 23:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792478309; x=1793083109; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u9+toBtEEPVpz6hTN7Pcfhr9T4/drBZovt9bfqsgE5Q=;
        b=q4G21wEt5rdxvXskqxsokoH9yS1SP97xEnmGBzLZBlNZeo2N9pRP+3V2eeiwoEFel+
         e1+UUqMZEkY+jAdfylQEvmrNhK5uZkvuqklc7CKue28Kb1CrKDI8nNSEx8yiNhVUuXRa
         dzqw+4f33vMptufinC6oOWv5kuPirh1RCiR7dsk6j5LiJ+FDd1E1BHHWDaxtw4yhBfwS
         YqmpiVNTyJkaV8/nnP7awb9te5gEA+DwUSGuJSGrH/cTzuywzRDTs9jL3MWPTVrcRXas
         ySH3JxbM55lVYOG9LaY2Y1bCeSorYf1aNEUuFUoOM5CiiuB/l4N0o/cJW8USS6N8Ka9u
         2iSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792478309; x=1793083109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u9+toBtEEPVpz6hTN7Pcfhr9T4/drBZovt9bfqsgE5Q=;
        b=S0xbZe4SwX18E37M5dko3CtBW71e0IiyJ0/wBqdhKV8Fzkpb49bxZQCFWRBL+lG8oI
         I8XhmtX+ph9+7JSrlUJkOCSJnrECIT7Owva+oFdty3Z81OwY1YdvmymgOlGmjDPev+J7
         5pYELVrfAoO6LrywXgI6r9xjujfsfk/u2ExTwRmGTtJ4qw9XaEpl5PjGH3edZZtzRJV5
         LH9OlGfa+xFZCBjJFWpetCoLMjkSW9vPRHOJGFlUVtkhkFpmpit/JONdRimBryoluZpO
         x8okcj+DbqKphDoFQznsZiQ4PZGdlUfTZ02jM6bUI7juWvHOajIfH2zX3knwTG/51HU7
         MQUw==
X-Forwarded-Encrypted: i=1; AKwUvBw5kXvnPujjvcgW3dWvSfsFdZrKo4Waomk/mbTOUAgWFSqxdnD0PgmdDLWf/0A1KmX7DL3TUQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKuT153YXZ49OGyTAQFJ48NQcbvU54bwdGany88cofXC5f7auVW
	VzxVOWKbGZk9EnzqYSmqBlo2tGK4rJCRcwIxIo8doQ2Z1gvXgE7LN7Ay
X-Gm-Gg: AYBFou1lj1ikfztzLSJc3r+vXu5/lOTd5OnaygIcggYva2MP0EBGCFcleSCIn+jGR0X
	9MjsRn5cNiu4Q7i14qsDHILw9F1N8q1bztBmxytt5zuPp68S+TAZ2DeYVVMQmlZYcikcKZr20g2
	jmUvYc/NBR6Ew9k9uam8NIOUTy3FoWrYXEeSTYYqYe3iqJHU8JGZGIYcy+S9bTq8UeoscO7g806
	kDOY1fL96O6wY7TrkFMR3NQ5V7RN/fpa7fqhxZRS3KIYQliDwOH1Mb/qo5GxcQxiwgrH6pQoaki
	dKQORRcG11S816Ri7x//Cz6TszNFNJp6q5X1arkv3WdJ187AasoEpeZdxu0uf/GsLdmFdVL+35K
	s4iXZVRsajxdcYCMMxNcn/bxeRLI+Z7A3AXrQIF37KwQoIbD/gBdLJncCgzsSaSBHMw2F7j5Cg8
	ARY2EeppCgKbbO7qf+jDVbmsDPM1vG/7WOoOzsTos9XZXEl7ZodMSsr1I/L32S0H7GNtcAwGcsA
	88tPQsVFMf+AoPfztNwtc3x8fK/UtlWlXHytkttXC9cR0na4RAmPdcGwb+0thqvab3abFIUUKkT
	/ZiSQX+IFztF5Cz/NpB6lDjS66k4022cI/Hlu08BdHmImjEPGkl1RRG8CWnUMsnu8lHuVhtrJ/T
	88Q==
X-Received: by 2002:a05:6000:400f:b0:48e:d88:55e5 with SMTP id ffacd0b85a97d-48e0d885ae8mr18682745f8f.6.1792478308630;
        Mon, 19 Oct 2026 23:38:28 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9c92-6501-2169-eb9c-7ad3-f5db.310.pool.telefonica.de. [2a02:3100:9c92:6501:2169:eb9c:7ad3:f5db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d820714sm3916393f8f.35.2026.10.19.23.38.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 23:38:28 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org
Subject: [RFC PATCH 3/6] iommufd: Clear the PAL list before dropping resv
Date: Tue, 20 Oct 2026 08:37:42 +0200
Message-Id: <65a7be483aa5e374e0afd4d72cbafab0fd07a4a3.1792477872.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1792477872.git.kmehltretter@gmail.com>
References: <cover.1792477872.git.kmehltretter@gmail.com>
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

iopt_release_pages() frees the PAL physical list while holding resv but
leaves exp_phys pointing to it. Between the reservation unlock and
dma_buf_detach(), an invalidation can see that pointer and unmap the same
list again.

Clear exp_phys before dropping resv so a later invalidation sees that
there is no live PAL mapping.

Link: https://lore.kernel.org/r/20261016194022.62065-1-kmehltretter@gmail.com/
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/iommu/iommufd/pages.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 9e9bc6a1c..76d8803d6 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1674,9 +1674,11 @@ void iopt_release_pages(struct kref *kref)
 		struct dma_buf *dmabuf = pages->dmabuf.attach->dmabuf;
 
 		dma_resv_lock(dmabuf->resv, NULL);
-		if (pages->dmabuf.exp_phys)
+		if (pages->dmabuf.exp_phys) {
 			dma_buf_pal_unmap_phys(pages->dmabuf.attach,
 					       pages->dmabuf.exp_phys);
+			pages->dmabuf.exp_phys = NULL;
+		}
 		dma_resv_unlock(dmabuf->resv);
 
 		dma_buf_unpin(pages->dmabuf.attach);
-- 
2.39.5 (Apple Git-154)

