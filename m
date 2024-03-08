Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E79535CA
	for <iommu@lists.linux.dev>; Fri,  8 Mar 2024 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709891656; cv=none; b=jYaXUOZzbVdmUImH0m2SHJdgnlEI4ViljU8s3YwQ09RBy7bOzYTZ2PLgRdh2R+8dnhyx3z+Gmf946iRnxgvUFW+wW2Bev2XWOw2Jiq8bOfh06j5j7o/pIP0LVqXZgZZKrtQV3JoMBruR7yD3NQ9EQEdlEolSjQYu5DREKH90XcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709891656; c=relaxed/simple;
	bh=PSSmdFEKXbQoDoLCkYh9gWPYZ30jQDOHJ1WglWyUdcI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Gz7FyUZJ+Ek+r/kno5tqMwJLWfm5uh52/B7LyqC3qdc7EfxWXoGjL6GZg28t0sbifXN07sm+TZDhTeQSMwpBcuJRYO8JBXunXvyRv15pe4bAQ1YUkVQILtLW0Yv3wuhbRqUp8R3/Qku0MmuBa4k/bi6rd0kSiq3vX6AUQ+jMV00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PmYSayBU; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PmYSayBU"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1dcb30afc63so19726465ad.1
        for <iommu@lists.linux.dev>; Fri, 08 Mar 2024 01:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709891654; x=1710496454; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kd9b+xnVrsV0VnvP5BBobh+7armz3SPZmewGeAELg2w=;
        b=PmYSayBUAJYFPkvap9vXPZYTRG6hWWVZFJS1NxJysxDeu5hJJb8fZZQhwk+Y4E7kkD
         Hw4c+BE182euEoipCrgoDpHsNNodDXeG117ysR/jxtRCuOqfNCKQ5KU2gW1Ej0PEHDvz
         BS189EpJJSripSj4M8L7LgZL2aC8GHWry5wWeXAHHjtK+knnv6OxnpOKg02KDmaJU9la
         JrVG42cOtalufYP71Qdm/y+EabNSwhL1vrMWi537hJrZRNODNeDtN3VMPabr7LnrFzT1
         3g/IbBjgVve6tKk4n4hu1Jrp1k83mKOgIVJdlAdfqQjlGTgh96pxbQb9pOIj6o1YJ0ak
         eQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709891654; x=1710496454;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kd9b+xnVrsV0VnvP5BBobh+7armz3SPZmewGeAELg2w=;
        b=SUr2/vBXFVjx9LcBWNBPQp76U/6YWOoaDATSFysWAG72NA1e6SefFKEv3Xqq08GYVg
         IIHMr2qCyFgOruOd3uiopPVuI7ir2M6W+ykSDT6OOgKNgj+qJUAhTOMhZoCH1nsXrBKH
         QtcxJxT5+t3WpN7xttrKVpc7/+qFZrwaUHPHhxtjVMTs8LsfWzOGiqtq6T5x+wVPEi5I
         q+AA4Z6lxu+0iogMVoYt+ap6paAVu6qc5GCSZAmuBJjoStlWiw135o7RODkJQP+diA1C
         Xr4PlF+3DfOn5HGI0V2VQGHKdvtGrbBAEpldyiEeUKI2uDjppCdWc3QnVsVFQGNt8cY/
         Gj6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAvO22VAmby2nznLkl1WGadciS3J6xv+20RMyhsGzrHjSn8ok2Z8ypou2MDFrRv3rwAaFlq+/g+hF9TWjOfNlYwCHsUXo=
X-Gm-Message-State: AOJu0YweQLdHdslNSBkQxKUM5jng5dT/N/MR+X+YEW85qbAvmkDCuXCi
	SDgd48BKmg3N+WFDwv+kWcduWUpIjhPOHSrpcptx31y9qFuRmgyk6VqZRHB2z7sl+H7+tmZNVgr
	0E14LdgPNyBrT/g==
X-Google-Smtp-Source: AGHT+IG7o+dh/76ogl6dMQx3yfx+ZlS2Tc2RH7CYeArGIpPrqv+Lt8uzvSvNDTz8wBfiHvp5wM9In7J0dxXtBnY=
X-Received: from howardyen2.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:16f7])
 (user=howardyen job=sendgmr) by 2002:a17:903:22ce:b0:1db:f7e5:afd2 with SMTP
 id y14-20020a17090322ce00b001dbf7e5afd2mr717431plg.12.1709891654099; Fri, 08
 Mar 2024 01:54:14 -0800 (PST)
Date: Fri,  8 Mar 2024 09:53:18 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240308095320.1961469-1-howardyen@google.com>
Subject: [PATCH v4 0/2] Add support for multiple coherent memory regions
From: Howard Yen <howardyen@google.com>
To: gregkh@linuxfoundation.org, rafael@kernel.org, mathias.nyman@intel.com, 
	hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	andriy.shevchenko@linux.intel.com, petr.tesarik.ext@huawei.com, 
	broonie@kernel.org, james@equiv.tech, james.clark@arm.com, 
	masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	iommu@lists.linux.dev, Howard Yen <howardyen@google.com>
Content-Type: text/plain; charset="UTF-8"

In the system I'm working on, there is an always-on subsystem which
includes a small size memory, and several functions need to run and
occupy the memory from the small memory if they need to run on the
always-on subsystem. These functions must allocate the memory from the
small memory region, so that they can get benefit from the always-on
subsystem. So the small memory is split for multiple functions which are
satisfied with their generic use cases. But in specific use cases, like
USB3 devices which support the stream trasnsfer or multiple devices
connect to the host, they required more memory than their pre-allocated
memory region. I tried to implement it in a generic way and propose this
patch to give it the ability to get the memory from the other larger
memory to solve the issue.


Changelog
--------------------------------------------
Changes in v4:
- Add the driver where uses the multiple coherent memory regions

Changes in v3:
- Re-org the members of struct dma_coherent_mem to avoid additional
  pointer arithmetics and the holes inside the structure.
- Use consistent naming of return value.
- Re-write the dev checking statement to be more clear.

Changes in v2:
- Replace the pointer(dma_mem) to a list_head(dma_mems) in the device
  structure and initialize the list_head in device_initialize().
- Modify the required changes in coherent.c.


Howard Yen (2):
  dma-coherent: add support for multi coherent rmems per dev
  usb: host: xhci-plat: add support for multi memory regions

 drivers/base/core.c          |  3 ++
 drivers/usb/host/xhci-plat.c | 19 +++++++-
 include/linux/device.h       |  5 +-
 kernel/dma/coherent.c        | 92 +++++++++++++++++++++++-------------
 4 files changed, 82 insertions(+), 37 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog

