Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF22929CFA
	for <iommu@lists.linux.dev>; Mon, 29 Apr 2024 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390990; cv=none; b=V2A33IFtomvt0gEjQ46lqRAq+8YUFeVVShtUJEDhPMw596x04ygVxmCjDaS9QRvdSKqtsmz+RD2pO7M2gMv7WNlp2HSTwo3WEWNBJWZJ5PC30IsxTXs/5+grrOAGIKZ4/lDTbPK7a0MZHDHvdtEaPqPdP//XJW2Dq5klqaL1iLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390990; c=relaxed/simple;
	bh=8aoPVLJ489On5ztbsvpmdxCALVbdDUa/I32RFYBdJCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=biINHnIQ4/+zhF3yllNPnVoEQFPZ2vL7ySSEBUW5sOrOglHKJ9NZ1S7T08t8rJPkCShFu/ou1GFveP+EI/BjEJizh5De8buD03ju1y1+YDH2i6tYKXtVnF7ernGDvYyzq8BWbZJ3ceXO8Lof/AKBWLUImiA/K6omqzcwsnHhWbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QyOWa4BO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyOWa4BO"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41adf3580dbso24812155e9.0
        for <iommu@lists.linux.dev>; Mon, 29 Apr 2024 04:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714390987; x=1714995787; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eSPLQ0aSiWlUkLotmQUKbdSZn8q1v5DF9gInw6B0dXM=;
        b=QyOWa4BOYtv1xhDgm+0Ar1YdM9BFcEBoPIzNx62D/H1cv794S24EjsZho2j1fcA8d3
         2cNA2NHIDyzSn7eDOej0zG+czgna+vEtSTsLEmvIZXEGWN9f6iKdaRgsR3V8agufBW99
         1wkoYA+ZoeCdR4/YBBiiV5+Mr8a0cm40eGNKuVu2H7+oM2kj131ph2XUsoZLTV96mb+w
         1iczOc0bzXTCI5LE6zE9b5o5lobIpvde+16Gsft4zgwFxcCfqRQ2NbyvBwigN+cICzVm
         S6fbV+JjP7ekhSJFF+m/MYF/m7Wwll9Coy+wXQ/Ip+AK8EJLLMV5ZwhzTrCrM4D1TMo1
         Pwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714390987; x=1714995787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eSPLQ0aSiWlUkLotmQUKbdSZn8q1v5DF9gInw6B0dXM=;
        b=nobfLRlIh4Aoc9IKRnrwV8Oe6zadWig4blOYSB74xDDh+4Ae1nsIv/NNCVTzWlhxFA
         vmFe53LDLXmMgD4Ffwtj5nr6xvUJmGkth6leOmRqdTkPXERWd/+1GvWYjsd1OZd3Sk8n
         JfycpmsR8GAiagvXQwPRkr+aJYzTRX+TlX5/+TU2H2aTZ+eiU4vHdo8JYi4MzGBsJDOq
         Cyzmq72SigEsSCTh8s6nzXUf/7WvOoEvSzPcGNEdqKpW+zicloosfsc/2/X1Vbhxt0m+
         ZWX2eJlyZMko/tIR5hHESdn6gJuTqSSCQzVy5uHQm23b27+4ECnaQlSbJ8yXpwK2ZB60
         jpQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFujXo6WtwhfMAfzJRXf1cn/VtZZFzKbbI9Jn85iBic10Ll5MRU11yJz8v22spDXs6TIP4LFGGaThJ4YWSyfOhuKUPMB8=
X-Gm-Message-State: AOJu0YwrYgJ/CgXJ2N8wRTvUeq2ICk+1q1h6dMcmicQtRVTZNmRWfKEf
	pB8CYRqkgeiFb2HSOIGYRIsZVNrjiMfLr6CGTwHBTjtxRRLpPkXaB6tem78G2jM=
X-Google-Smtp-Source: AGHT+IELIaH77G+cqO9Ae4tGmjB9R1iygWxsWgrPpSX+Zo6NaBJo82SewNNgw3IJ4qO6Jw9lSBHdQQ==
X-Received: by 2002:a05:600c:1d16:b0:418:5ef3:4a04 with SMTP id l22-20020a05600c1d1600b004185ef34a04mr9650703wms.18.1714390987239;
        Mon, 29 Apr 2024 04:43:07 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id j28-20020a05600c1c1c00b0041bfb176a87sm7006611wms.27.2024.04.29.04.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 04:43:06 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	liviu.dudau@arm.com,
	sudeep.holla@arm.com,
	joro@8bytes.org
Cc: robin.murphy@arm.com,
	nicolinc@nvidia.com,
	ketanp@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 0/3] Enable PCIe ATS for devicetree boot
Date: Mon, 29 Apr 2024 12:39:36 +0100
Message-ID: <20240429113938.192706-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before enabling Address Translation Support (ATS) in endpoints, the OS
needs to confirm that the Root Complex supports it. Obtain this
information from the firmware description since there is no architected
method. ACPI provides a bit via IORT tables, so add the devicetree
equivalent.

It was discussed a while ago [1], but at the time only a software model
supported it. Respin it now that hardware is available [2].

To test this with the Arm RevC model, enable ATS in the endpoint and
note that ATS is enabled. Address translation is transparent to the OS.

	-C pci.pcie_rc.ahci0.endpoint.ats_supported=1

    $ lspci -s 00:1f.0 -vv
    	Capabilities: [100 v1] Address Translation Service (ATS)
		ATSCap: Invalidate Queue Depth: 00
    		ATSCtl: Enable+, Smallest Translation Unit: 00


[1] https://lore.kernel.org/linux-iommu/20200213165049.508908-1-jean-philippe@linaro.org/
[2] https://lore.kernel.org/linux-arm-kernel/ZeJP6CwrZ2FSbTYm@Asurada-Nvidia/

Jean-Philippe Brucker (3):
  dt-bindings: PCI: generic: Add ats-supported property
  iommu/of: Support ats-supported device-tree property
  arm64: dts: fvp: Enable PCIe ATS for Base RevC FVP

 .../devicetree/bindings/pci/host-generic-pci.yaml        | 6 ++++++
 drivers/iommu/of_iommu.c                                 | 9 +++++++++
 arch/arm64/boot/dts/arm/fvp-base-revc.dts                | 1 +
 3 files changed, 16 insertions(+)

-- 
2.44.0

