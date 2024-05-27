Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722F37D405
	for <iommu@lists.linux.dev>; Mon, 27 May 2024 13:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716815613; cv=none; b=Tc88IslA43Hx8zz6r3shXRvDU2sWs2z/r7vPwmXNu4/eGZoDJfCgWY0TcuNxZyQzWSWvOqGqtGcGoqABvo6at/lfvyhi0FKQpFVgEE4GhU5BThlwRUnBpnLG5U82szBwtJEIGcD9U7mtKS1+a92/LaRB2f5xDe4k3pnKCO+y6sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716815613; c=relaxed/simple;
	bh=3DuU6HAXXUEpFj1/CbH0w2NMI18Jg5p4m14poKJ7EVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DtsqbuoeNQB7L6Hk44+BsSdeAGuupgvoFPupgqNkym7PX/nQ8BCPO0KuTsH1VX0tt2R059GQ6OBPgVdv8NromwMqzcbFKoJaseh6Bp7gFyuHfjuOGL0KwU2uh9bIWLkVfV8BYU0525Y73ArwkXlap4lj45N79pbvqdV81J+0swM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SX3zwY4Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SX3zwY4Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716815610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ug/+QrBJ1fn4jt7nmsB6WVOTnZkvl361r4prquvMN4U=;
	b=SX3zwY4Z545FxwisCT5PKxT314TzJyAXM8pFw3+OX0P4LBsMw3vlwnVDXj1aSKsZXrSSTI
	dr/Umhv2a7u8vyUj4XLvcAHIiKyjCIrMOHqrUWwAEdlPcPdtXcbo6lsGXQYSxAazMPrqjL
	/HfUCRJGfgHBKp8QkhUorrbjSRAJVXs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-R7idYQ7yNG-bfv6QMAUFiQ-1; Mon, 27 May 2024 09:13:29 -0400
X-MC-Unique: R7idYQ7yNG-bfv6QMAUFiQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-43fb0949d28so51785651cf.0
        for <iommu@lists.linux.dev>; Mon, 27 May 2024 06:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716815608; x=1717420408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ug/+QrBJ1fn4jt7nmsB6WVOTnZkvl361r4prquvMN4U=;
        b=EL7dHSeP+fCSupoyXfUzsUKfq78TU0mJ8CaFLBgexuTn+ivQaaGpCFN5iwPqaLE9Sc
         +iASddaeAEbdpMSgizwOtYt+L5FSIXkZagB2uYumK1x4u2uzIqL9bi4jG2PNiehOZTg2
         AJhpmiOKKLcMt796vYbfiwyVUrTzTzd/pi3VFDCDvBpP3aT4W4sjalZyLNz5n1MQgihu
         xfqCoRIJE1xILywLB7qecYeZ8yQK4apN6KFfgYawuGN04WJo/lVFIFz1iA65vylvNMBI
         78o4NCDohh8spESkzdRWntYQx6vzZMDZUpHTmGiZohQHuqMAlpzDe9X1Ts9L3ZWImgQI
         KyVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUZu9KTEnkq2TJjyfkZQVMZ7D8+B6mVzI0wU6O/5Y35J4G/RVpE/WNkjVL5uSNOI8JBh8PnI5nFe8TFwDVHmD9uy/UmPM=
X-Gm-Message-State: AOJu0Yyj4lfDo5L0wGagS9l0RqrHFWybqwfsHNUkvxSFlc1KwoEGXbl8
	DJ3gHJbCAQrIOYGBKnRyW8Y/yzVyBnz1gk/cvqC09imXB/YWRTxsH1W74GRzOOdCIbPDVG8udie
	c+6YcRc5RldiC7hQbcFck2IHQZzofVh5T+iIaQ5IeaeqY2KTKD5tr
X-Received: by 2002:a05:6214:76b:b0:6ab:7ab4:f309 with SMTP id 6a1803df08f44-6ab8f327f9fmr190114746d6.1.1716815608553;
        Mon, 27 May 2024 06:13:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFvp62B55LpZG06oDjDs9C9JeEguHSawvpfFEUQJhPnKmdJaNhFrrUX9ZGDUsNJSeBscO1kA==
X-Received: by 2002:a05:6214:76b:b0:6ab:7ab4:f309 with SMTP id 6a1803df08f44-6ab8f327f9fmr190114306d6.1.1716815608133;
        Mon, 27 May 2024 06:13:28 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:833c:88f3:25a9:d641])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ad742b3663sm19273786d6.60.2024.05.27.06.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 06:13:27 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	Petr Tesarik <petr@tesarici.cz>,
	Michael Kelley <mhklinux@outlook.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] Documentation/core-api: correct reference to SWIOTLB_DYNAMIC
Date: Mon, 27 May 2024 15:13:14 +0200
Message-ID: <20240527131314.22794-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit c93f261dfc39 ("Documentation/core-api: add swiotlb documentation")
accidentally refers to CONFIG_DYNAMIC_SWIOTLB in one place, while the
config is actually called CONFIG_SWIOTLB_DYNAMIC.

Correct the reference to the intended config option.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 Documentation/core-api/swiotlb.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/swiotlb.rst b/Documentation/core-api/swiotlb.rst
index 5ad2c9ca85bc..cf06bae44ff8 100644
--- a/Documentation/core-api/swiotlb.rst
+++ b/Documentation/core-api/swiotlb.rst
@@ -192,7 +192,7 @@ alignment larger than PAGE_SIZE.
 
 Dynamic swiotlb
 ---------------
-When CONFIG_DYNAMIC_SWIOTLB is enabled, swiotlb can do on-demand expansion of
+When CONFIG_SWIOTLB_DYNAMIC is enabled, swiotlb can do on-demand expansion of
 the amount of memory available for allocation as bounce buffers. If a bounce
 buffer request fails due to lack of available space, an asynchronous background
 task is kicked off to allocate memory from general system memory and turn it
-- 
2.45.1

