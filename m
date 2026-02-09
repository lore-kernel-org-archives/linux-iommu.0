Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094E037FF49
	for <iommu@lists.linux.dev>; Mon,  9 Feb 2026 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770651493; cv=none; b=YIph7bHKcvv4eY8+Wx9L2T13zUxeMLNHp9eeveNe3VY1lmU9wxpeW+lJUw1C7zqEX6TvVacWOxVd5Rhd5PND1ZQ2MHWql/tuZbdOw1ewFGB0VDrMorputQIXChRxWcxTHwvKMTJV2Yu2vFtHDT51re3svj+7OsNjBZpVqU+mbjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770651493; c=relaxed/simple;
	bh=iaj2yH89Vn8424NatbEPy5zTcXkE8fBUuo+9v66/cM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L07C0vhZw7+yZ36kj15uxjXPQje8meUpXRiOnJVCl/jtD5BazzHQNz2Se3J4IYw86PoOFmHHPmfxGk1x790iR4Y19aXBIr1ViJWqVd7xLf3jtvzGgYBdP5h2Nkq/Q2vXNCzdfUhX4JPSo//a6o415C1qlG7trlClwB05vvGIcB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qE61MjCh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qE61MjCh"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483487335c2so5393315e9.2
        for <iommu@lists.linux.dev>; Mon, 09 Feb 2026 07:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770651491; x=1771256291; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jk99TzIHNfOaBko9b1E43IwPHNs+vzenJUms8qd4tnM=;
        b=qE61MjChsFynqI5Ok+1DMBxnCL8AsHH+C9E8XBPhySW8y+K0A3cvyzmQymDxlTRD1z
         J7ORQWpbT02aotPpUBa0oxbcdIpaNqr8xb9PoR70I2RuVKEx7biMWeQdnBeKeQMmaqjp
         O9rQ3IIrPQTvrMQJW4JA07nbdAD2KkyVAIsoGFEOx1wYyRUHDmbqlpDXkeyCLEgYQO5Z
         poBuB1jn7hV4IcIEXCAev6hRVwI299+qNDm1XKKAXfM54CMo97OFnJZZrNZS9rw4wJ6x
         xuV+pYESAp4z+17p8IVn8qfeNvvnkZUjrSEl8qGGQFyXpauxMjlsIYVK4WNANSVU3YyQ
         kufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770651491; x=1771256291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jk99TzIHNfOaBko9b1E43IwPHNs+vzenJUms8qd4tnM=;
        b=lGEykwcqJXuPtEtXHOY3DP2zmfIO4wVTvaI4mvnzYk1q9A6mKPJeca3iAQXL0XYczF
         fwM3BftOABsoBHmqfATPVf+aTQ8h1l+tdCfbpbxQT4yBRTh0SvaeN/MgM4lNzArwBGhK
         M48zyGalP2N1YKTCEvyuOmaIZWs0wZowH7FaBegqNR58z/rn0d5w6vZTA6g870UuceDZ
         /gDVxFLz15hQSHc8mzYDzfaHEwCg+a0ea1N6SUAmN/bogxQhlMTaV8e10CrHKeYYaKQe
         qVrnCi0+Wy6KBt+UvAtrcO7BA1D2zw/R7g6jfhbOqGLbMYxXVI+wa1gtaqgEMyICRSVS
         mh9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNs+lKA2pwJlrpYiP+RJF2UUzUZ1UkSgtCbWxR/Lvp5xOv88Y7m9PwAitEvTaNmstUadUKIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqGd7K8vy6rPwsBw71FedujpEUpHixdJlspVNmzvaTrndgT4FU
	nOpicdxc4x3mw7G3WBwbqXhV4tgxdwEjXMp6tOaeEupU+BVHIT3TIIX6iTkzfh7SGhw=
X-Gm-Gg: AZuq6aIuYEct5n3amO6DHKkhOFkg23dojX7RatBWq9Ryw/XL54tc1KETlG790p7ex7m
	YGS19uqAe9qzrRzQ+aONCwKdEbHZMhlKf/6tVedP8I+/NIx6uuPc42T9wL4PBRvUlDjQtUDEVcz
	klf6rnteAt6vA9hxjGakajRdlYzyVM1rdEhmgZwGnvZVPb6DhiN2pyjll4sb/KWfPJjmkaNMNjJ
	q72XNN/G/avXM1ur80jzFmQq7yZBQ7u5WCg5BfyMjPyvdMbfvTA45aj5aYAnYjATodjw9V/772G
	4CeFw8xuenbGXJxEBvLlK3RqQjUXlYbXd7ajFM3t2UDr6E7nwlvKE7x1064Gy/IvOTd/2n+a73g
	cBwDXXUKkTKERzTZfNO01umRHqAI9E89nE/7Jx7QX+ZD21Qx/VjvWHCfNI6nLZivRIlyk5mRI5W
	cB1g==
X-Received: by 2002:a05:600c:6592:b0:47e:e7e5:ff32 with SMTP id 5b1f17b1804b1-483209c6dd4mr181313355e9.34.1770651491431;
        Mon, 09 Feb 2026 07:38:11 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376a78d796sm11560760f8f.20.2026.02.09.07.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 07:38:11 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	iommu@lists.linux.dev,
	linux-media@vger.kernel.org
Cc: sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com,
	Brian.Starkey@arm.com,
	jstultz@google.com,
	tjmercier@google.com,
	christian.koenig@amd.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	sean.anderson@linux.dev,
	ptesarik@suse.com,
	catalin.marinas@arm.com,
	aneesh.kumar@kernel.org,
	suzuki.poulose@arm.com,
	steven.price@arm.com,
	thomas.lendacky@amd.com,
	john.allen@amd.com,
	ashish.kalra@amd.com,
	suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev
Subject: [PATCH 1/5] dma-mapping: avoid random addr value print out on error path
Date: Mon,  9 Feb 2026 16:38:05 +0100
Message-ID: <20260209153809.250835-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260209153809.250835-1-jiri@resnulli.us>
References: <20260209153809.250835-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

dma_addr is unitialized in dma_direct_map_phys() when swiotlb is forced
and DMA_ATTR_MMIO is set which leads to random value print out in
warning. Fix that by just returning DMA_MAPPING_ERROR.

Fixes: e53d29f957b3 ("dma-mapping: convert dma_direct_*map_page to be phys_addr_t based")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 kernel/dma/direct.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index da2fadf45bcd..62f0d9d0ba02 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -88,7 +88,7 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 
 	if (is_swiotlb_force_bounce(dev)) {
 		if (attrs & DMA_ATTR_MMIO)
-			goto err_overflow;
+			return DMA_MAPPING_ERROR;
 
 		return swiotlb_map(dev, phys, size, dir, attrs);
 	}
-- 
2.51.1

