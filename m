Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFD216DEA2
	for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 19:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732302791; cv=none; b=GZhjrqXqyzAdqsr7BlnAVR5HkRA5CwDheaoRJ1ZLKjGWYnM9wKNcwOZErs8KevUzYfLq5v/QbmTNVzl7ADrFC5idU8bNWxtrNJEgLzZ4WGs+LyPjHVuP3H+tuh70KQ73rVaN0cZTLWx6OIRd2Bwj7FTK+8ThV5Z8YzHKrUsgc3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732302791; c=relaxed/simple;
	bh=FFXzxJCPETFdsXpWIOyOnfVOEgAq+wBEZmb501A+S9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wd3o1cIZT7OvZc+RFHcVzEh5+1r4YqEmRYK6/zorp8K5tIZoA2zUC78R7f0Cpdb2UKLpisjkER1DSma4bYu+vxIevdpRjRwOU8vTZ9WNEGUOlCiF/PL4PAnmY36UszhuMkyWMiZKcNlW5AyDIlm7uSZAKlxFK9mf1QGFDie0r94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kx++Lg1I; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kx++Lg1I"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-382588b7a5cso1645701f8f.3
        for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 11:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732302788; x=1732907588; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pdqLgPrEIWQNDvWMpf12KJA3H6cLevTc4f34wbV+nIo=;
        b=kx++Lg1IQJmPg83lm9ZQ5Z+fn0Ycz4xGiPI+i5ENvfsOx4G8Vj9savTDEH3KWj6Brx
         H6FZewgFHRoByZaWAdSgyflfnVDHYpTvFE3kmRC0T7Yg9didOGwI+LRwqiCrjK31sZEW
         4z0T1liCgNr4VStX7Mnw/WkMcmThT5kFQZsBZRpgAnCdoQDUmxeSRhVnpFvnNu4y77Y4
         CCyAfUJMn66TwRbNQUA473hLVyaMGo+CptG4HZRmHVahmu1OsbkYUHZ6eOGL5neYprFb
         SXCiiXkugyRqV2uoE5q99RYDUUKdRgUNqxPfvf9FVypKbVAZRrEyRspDKiepbJ7S5xkT
         lrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732302788; x=1732907588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pdqLgPrEIWQNDvWMpf12KJA3H6cLevTc4f34wbV+nIo=;
        b=Ky4pOKL/tU1Jd/SoK/2++KQiYZHhCF/YFf6vBmyBGs19ZdcMVIprvibdBFZHLdiXXs
         5WIhv3pwq48mhB/TYIIrrUD/xccYacKdyuwjFW1YZrByX7gUp8UBM71fKfB4PZ8Q9jhp
         3T0aRSSiQqGinCP1l6Dv61Ex0gpTxhS3eS/7VlOvJc9B8X6KjnK4jiT3Bad5cFlkV5ZM
         df1ZoQtuPhxAD5YHfnKhqAqph7JvLXwWhbjYhkPYD996k3pyCjXcE8ywV2GuybxVZ7oj
         2bKUYJ/lcZz8Tm9kFNyLJjt+j3NbHGIow3w34EbIKaYIlW9tuuJOlIeQGUbh/w4ixq5u
         pqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk6CSxs0SfOJTClYgVRNTh4EvVbOlvOLh9/OWpjMDPXX0En6/Apg4aZ7SsOQhRpM13L3bSSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzfy074dh6TPMMBdwDjKHTnv/IXCkOs23/kLuPGerAPVpwi7Xsv
	U94AJR8aaGS1OwlPIY1gReKrhbpT1ciXTqDHTVnyHqGUjjoWDffM
X-Gm-Gg: ASbGncu7ULzcVN9Fiseqvb9XLnxQ5NNmeMAF6n2eyzIpI0iWhRRJuxy8/IHe5NUI3AQ
	0wq2/ZWOkMt6kw7vSnnwgqz8CcZCCt9AgZQXDoACY/miNcL9GM9inZe5e2HOjw+jOGpwbeBd0ug
	NqrtO+DCK0CoooPoSl5aoBRwDWuo8BnqEsdc+5hSDVu4s1+wQzLnmygQ5Sm5V+RQ3+k4LA34ud2
	a79IvW+7fuOE+2Viqy6C7UUPLip8uLU/rovXwm6+UHzd3xZgaz6p2MSsYOagDI/AvVHQpqLb46M
	h1o=
X-Google-Smtp-Source: AGHT+IGIZxV6ElpflFneYyLbkKrb+i5yzmggkxjVYzYLcjY4GLVsFTbZVB3ZGbMkKzd1RKTYOrZIQw==
X-Received: by 2002:a5d:6486:0:b0:382:383e:84d9 with SMTP id ffacd0b85a97d-38260be0ad3mr3289262f8f.48.1732302788076;
        Fri, 22 Nov 2024 11:13:08 -0800 (PST)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d41af2esm1196320a12.84.2024.11.22.11.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 11:13:07 -0800 (PST)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Tianyu Lan <Tianyu.Lan@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	Raphael Isemann <teemperor@gmail.com>,
	Cristiano Giuffrida <giuffrida@cs.vu.nl>,
	Herbert Bos <h.j.bos@vu.nl>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: [RFC 1/1] swiotlb: Replace BUG_ON() with graceful error handling
Date: Fri, 22 Nov 2024 20:13:04 +0100
Message-Id: <20241122191304.4182642-2-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122191304.4182642-1-bjohannesmeyer@gmail.com>
References: <20241122191304.4182642-1-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the BUG_ON() assertion in swiotlb_release_slots() with a
conditional check and return. This change prevents a corrupted tlb_addr
from causing a kernel panic.

Co-developed-by: Raphael Isemann <teemperor@gmail.com>
Signed-off-by: Raphael Isemann <teemperor@gmail.com>
Signed-off-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
---
 kernel/dma/swiotlb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index aa0a4a220719..54b4f9665772 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -834,7 +834,11 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 	 * While returning the entries to the free list, we merge the entries
 	 * with slots below and above the pool being returned.
 	 */
-	BUG_ON(aindex >= mem->nareas);
+	if (unlikely(aindex >= mem->nareas)) {
+		dev_err(dev, "%s: invalid area index (%d >= %d)\n", __func__,
+			aindex, mem->nareas);
+		return;
+	}
 
 	spin_lock_irqsave(&area->lock, flags);
 	if (index + nslots < ALIGN(index + 1, IO_TLB_SEGSIZE))
-- 
2.34.1

