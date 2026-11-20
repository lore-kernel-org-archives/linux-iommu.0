Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795134195;
	b=h7dN4QGTSE5tMW7lEymxx+vvlJtxTqVN4FETRjLKy9Bt1q4xU9okk7HS+Ufm1xfdbILL
	 4C9tdmy9k6GOF20CVbqOIu7ozFverZnADEVJ19ZP5lXRbkYf36e0VMRcCXGm3j6GldWza
	 80Zal8tArcRkKHh12HYDRqt7P9OEULgP/HCWkmhzF4/IALdWQ6jxl1bBvHeHK5G8Dmo3T
	 mF47etVV4UyYabofkXpLmqF/fyW4i3Wm7yxTw9ozWMle3uIs/HuMyBZ+SUSmD/hHONttm
	 RDS/PGFxea3L6mbh67sUFQazjwZoOwZtG2mDKSv65t/rZgc+Ym+WVMraZqJQ33NTCTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795134195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=nXm7V+55JTESgfbXuII0g/LeSG6H/Z2OSofXDdA1V+w=;
	b=ajR/97CHZ+onTe4/I6RC0bJNQAPZkU+QrafsVI+LXkhsN8wv+Jdp0a63wRq07tPWagvd
	 S75suXPYUv3x5+/Ha4ztQ6P/IU3Cvx7KSBNDVQUhiqmmvDhpDWxuiY0ml3qGMlnQu3hC3
	 baNkFeeJcHejyssWlV6MIOqQ9MeUM/s1y7LzXZfC7D2g058QWrnboKFGW4pQhDvaTONmD
	 Bh62RfXHY3q9jJH5O4w2NkpXjcX6T1+IGkiBht1E+axj09XGj7qji2xo32J5q3YzgMBvs
	 cf7jmY5DlObKAhCzNEQ51Mt80Rc1SyyqBRYGZLQYfGI8+RngHYrS/rjIhcYKEIWEaBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--digonzal.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HjxDWsPI;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6750B606A337
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 00:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6750B606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--digonzal.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HjxDWsPI
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1a2af4c8cbaso291117c88.0
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 16:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795134193; x=1795738993; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nXm7V+55JTESgfbXuII0g/LeSG6H/Z2OSofXDdA1V+w=;
        b=HjxDWsPI3OWGduFcz7E+HY9cO9xDatFd9tJktBuJNif2Mm+Gmxpan2ofG93CRGQIqb
         bgr/Z+Qbz5y8p5BHw2mbsv8WZ3RpS9lH/lCZ/0fDoMX+ZorfkENSEQNYzBATi1i/Mn1n
         eM2o3012xCkpSzBMrBgNrDuRXkz0xp5SnFwwOLmoA6wPtx0UnoLQ1RW5ZgCYG8BuXaX9
         c3VlPbS6yrqlFqkrJScxzm4IwCV5wO+5rTHU/b2ZDlBV6KwgTU3znoxneYE9Js2TZfCd
         2Rg9JzOn5gdERxFthuIxhvTzkfggivzrDZsm1avAD0IKhyRtarUMf0O+QlCrJRnF977m
         Ia1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795134193; x=1795738993;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nXm7V+55JTESgfbXuII0g/LeSG6H/Z2OSofXDdA1V+w=;
        b=nPC+Ein9T38c0YZbTmYmE5KAHdcPVI45HTW9K9O0ZrVP7HzDKZgktF7WMCMEdNjjyt
         Vpy5jjUDTPyMG1T18LReIErKpUn0s938WtphxWLa75fd6umgM0rFOQdXdjS/CHUN9/8Y
         8ExeP/IvWaC6BlcZ/echVGwo+KAbx8guiG8n+ss/t3FlRchCZePOyVH8ggE9uWfNvLFh
         Zs7zAWFxudbzjKX1RHrmuaSLV0uKd//1utUAaeJwifxr601efzYWDHWiFQrUl7Q8P662
         FZKtpQoxy/U5zK/CQ9FSoERSZQP0Q0Oea5Fe7ukwYcRvB7ilMZQgr6DblA/Ik3tKqoUv
         Qerw==
X-Forwarded-Encrypted: i=1; AL+hErF0YKeH4xJ/Pe5RJxpgJxYKzCAFoQaGudoxpSdGqUWBaxtA9Ymk8n9KBefV+z0qsvO3zfMdeg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+zgzVeKR9L+BF+ReV2VebhMucfDktCHwW2t9MjQ1PTdKorzua1
	rYad1qyYFVcWWH1t0IZr9KgYojg3RVU1/F1ziwJX0EnbFfX+eCWuZXvEUxzusz+y75pstiN29dC
	cXQz3nYLmM9HhHA==
X-Received: from dlep8-n1.prod.google.com ([2002:a05:701b:4588:10b0:1b2:5589:f43a])
 (user=digonzal job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:204f:10b0:1b3:a05f:892d with SMTP id a92af1059eb24-1b556903388mr1192470c88.40.1795134193081;
 Thu, 19 Nov 2026 16:23:13 -0800 (PST)
Date: Fri, 20 Nov 2026 00:23:09 +0000
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120002311.394649-1-digonzal@google.com>
Subject: [PATCH v3 0/2] PCI/ATS: Disable ATS when ACS TB is set upstream
From: Danny Gonzalez <digonzal@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Kevin Tian <kevin.tian@intel.com>, decot@google.com, praan@google.com, 
	sheenamo@google.com, linux-pci@vger.kernel.org, iommu@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Danny Gonzalez <digonzal@google.com>
Content-Type: text/plain; charset="UTF-8"

This series disables ATS on endpoints when an upstream bridge has ACS
Translation Blocking (PCI_ACS_TB) enabled, preventing ACS Violations on
translated DMA requests.

Patch 1/2 stops pci_dev_reset_iommu_done() from re-evaluating
pci_ats_supported() and dev_has_iommu() independently from
pci_dev_reset_iommu_prepare(), tracking whether state needs to be
restored via a @restore output flag instead. It can be merged
independently.

Patch 2/2 updates pci_ats_supported() to walk upstream bridges and
return false if any bridge has PCI_ACS_TB set in PCI_ACS_CTRL.

Changes since v2:
 - Add patch 1/2 to track IOMMU reset restore state between
   pci_dev_reset_iommu_prepare() and pci_dev_reset_iommu_done()
 - Move the upstream ACS TB check back into pci_ats_supported(),
   dropping pci_ats_check_acs() and changes to pci-driver.c and pci.h
 - Read PCI_ACS_CTRL directly and check the return value and
   PCI_POSSIBLE_ERROR() so inaccessible bridges are not treated as
   having PCI_ACS_TB set
 - Remove the pci_warn_once() logging and helper function

Changes since v1 (v2, based on Sashiko review):
 - Move the upstream ACS TB check from pci_ats_supported() into
   pci_ats_check_acs() called after pci_enable_acs()
 - Use pci_acs_enabled() instead of reading PCI_ACS_CTRL directly

Danny Gonzalez (2):
  iommu: Track whether pci_dev_reset_iommu_done() needs to restore state
  PCI/ATS: Disable ATS when ACS TB is set upstream

 drivers/iommu/iommu.c  | 14 ++++++++++----
 drivers/pci/ats.c      | 19 +++++++++++++++++++
 drivers/pci/pci-acpi.c |  5 +++--
 drivers/pci/pci.c      | 25 +++++++++++++++----------
 drivers/pci/quirks.c   |  5 +++--
 include/linux/iommu.h  |  9 +++++----
 6 files changed, 55 insertions(+), 22 deletions(-)

-- 
2.56.1.708.g77570a6a1d-goog

