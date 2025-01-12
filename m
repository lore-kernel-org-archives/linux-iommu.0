Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672721B2191
	for <iommu@lists.linux.dev>; Sun, 12 Jan 2025 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736685643; cv=none; b=e9wr9AqzGA3Dtu5qDkVBc9LMJLUQAMVZx7e0ocaOypYMK0DpnFqm2gcBfboj5S15o9tVAU6sxxg88zNsr55+bU490NVgQDJHjwU6nK897jNYa1AogZZFmIQSpS5SM84m7DIA03zi4QJTZiBVy6q6Q515DBA4Kkr2KyzNXsoh9xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736685643; c=relaxed/simple;
	bh=KIdw/TWwj/6QgkBKt5hfcBPLu+LDU5RSwQCKere/JF0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aMQVK2qAiZ3tx5mc59Cn974cY8KcWZhWBSGWPnFVxZAt2HXoGcFxeqyqTzUUeW8zY/d2/6EDlOiISdEJiLUIltqS0w4bXoif2z28n9iK3pbyGTxdQ3TEAOjqYBqONou/gVegkumu2uBsnIMawusCt2nfTJoer3H38zIP8XAX7aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEabzEsm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEabzEsm"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3863703258fso2823263f8f.1
        for <iommu@lists.linux.dev>; Sun, 12 Jan 2025 04:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736685640; x=1737290440; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JbaiZjfjmkoAvOH/8vPgWea4VcV4OpYLBCWHnfBUIaI=;
        b=QEabzEsmk0/M0vRHyNe1lDM1WZwNpPkzwc9cdTKQezue5THr3WPvnIgwawpu/UqV4h
         LWb3y/BqgbO27uncSwl4fR+WTSjP4Ky9PV16E6VoTLCxoLlwdZZJzr1HocVrKb+w4F4V
         TDYm3fHyMvqrcUSZsyGqGdjYpcwQ2c5ykB2/nP3hzJxXMFtMjPKEzRovK9BxPbYPni/P
         idBNxI5/tc0vfyQtB9aki4LdZROkYsRYEilOBLICC1ViRlUPv6A+4lpk+JJ7gKt+uMqm
         1+Sd59jH/2jYakHdts3WEF84j7BTg0BRsZ0jSc6uOWjqsm2Q7pEoeZG7izfbGsAw35nl
         7zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736685640; x=1737290440;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JbaiZjfjmkoAvOH/8vPgWea4VcV4OpYLBCWHnfBUIaI=;
        b=ng48+vB20bUcJZszuIz1BMICauScld9rmYS9O6MP/GLV/wlmOVUuDFWXAbMmvED9wm
         AvOMQ5vRw5hCukNE8I+7BPgoSsUk2foqXSq7FwoBu78vOyPy+zS03HzeDNcSx8+6wsb/
         QoglNpIKNtYq2LsqLvWbwBN0u0imLeO9q3eJTwSyA/RdMkzmX67Fk0CgytUdOfeqKNdL
         AG3VWinkFZzgml+I1y6nk/dQ7YLvj4haOdsnIcEng1ItE8z44x+caowXk8RHZjnjpm4W
         zV68sTTp5ZJd4i1sLHw4ntzRFqlnIsjPqikRGNHtdpZ0YHtz17Fg7O48vjz1v8c4+UB9
         ET3g==
X-Gm-Message-State: AOJu0YxnE+Jmqak9fWncGIS+twtUqzfuYkEbDY1ApQ7f7pUCsNTXro98
	wiXTfVeJs5bC/+KpGGItVkezzu1QBT1C4PSTWZZP66+Ua+hkap5l
X-Gm-Gg: ASbGnctb4Mza3sxT4Z/AJ4SqrWxGnyal8wx+tgmMb5gpJg7jhT0nUttK9rQglaYkuUs
	3uib8qesYkegCt0YdDAW9Z+kTI6qy9hWVangcLT+DTkBcgMpEg2S+WYrsrthbxo83GHFF5eOfn4
	HUVbEnU1lxRT42FAYZLUUT+oRxJFy6dmAQYGHQzrc0vaBns7QGczN7zCvk95uY72hYhqJ487sQM
	skQnLO81FJppPrBVYfbuGbZ7iaMmCSdM36GrqNpCTUF7h5+CtlatCcTKb0=
X-Google-Smtp-Source: AGHT+IGuvQctO/7DwrvEVnU8Ya73WBjvQrYXc1Io1Uc5/tSlcokPNHvGYQ5wKmF/gCMpUB7cThjUuw==
X-Received: by 2002:a5d:47cd:0:b0:38a:88d0:1c9c with SMTP id ffacd0b85a97d-38a8b0e764emr13532902f8f.17.1736685639568;
        Sun, 12 Jan 2025 04:40:39 -0800 (PST)
Received: from qasdev.system ([2a02:c7c:6696:8300:f79a:c247:3ba6:f48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e383654sm9731193f8f.30.2025.01.12.04.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 04:40:39 -0800 (PST)
Date: Sun, 12 Jan 2025 12:39:42 +0000
From: Qasim Ijaz <qasdev00@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: Fix shift-out-of-bounds in
 iova_bitmap_offset_to_index()
Message-ID: <Z4O4Du0WN95aP5Qs@qasdev.system>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch resolves a UBSAN shift-out-of-bounds issue in 
iova_bitmap_offset_to_index() where shifting the constant "1" (of type int) 
by bitmap->mapped.pgshift (an unsigned long value) could result in undefined behavior. 

The constant "1" defaults to a 32-bit "int", and when "pgshift" exceeds 31 (e.g., pgshift = 63)
the shift operation overflows, as the result cannot be represented in a 32-bit type.

To resolve this, the constant is updated to "1UL", promoting it to an unsigned long type 
to match the operand's type.

Reported-by: syzbot <syzbot+85992ace37d5b7b51635@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=85992ace37d5b7b51635
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/iommu/iommufd/iova_bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index ab665cf38ef4..39a86a4a1d3a 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -130,7 +130,7 @@ struct iova_bitmap {
 static unsigned long iova_bitmap_offset_to_index(struct iova_bitmap *bitmap,
 						 unsigned long iova)
 {
-	unsigned long pgsize = 1 << bitmap->mapped.pgshift;
+	unsigned long pgsize = 1UL << bitmap->mapped.pgshift;
 
 	return iova / (BITS_PER_TYPE(*bitmap->bitmap) * pgsize);
 }
-- 
2.39.5
