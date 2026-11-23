Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795413876;
	b=VrAM9EhzJTmcxPTgHlyM6IWjEC8iEgPpiBJdUSy1BfyUPQNs5QYggRMQ1EvHvcV3WI0j
	 PgAjONeTYx9XA6GlBdfS70X9Pp+hl82PcNjXVW64I8l6bdofj1V9QGaoE7QHCbPWnm9//
	 NIl7YGDYHOA7TZKhoUNPYuGTYrUynktctuNjyTb78a6lCAvYenISOsi7AsAIdnIzwAwPg
	 BEMUXMGBuvQoV1IWwqf+WDfoG/CZ5S1dH93dJM0b5JaK0JjFAoUJVZJVB0KhrzFMC0sqo
	 ERg67jbi2ujq6N1sUdsCGs8tlXBIOtUUWVY5bOWBjDBa+0Sa+KQWEhnjp3iUMsM7bdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795413876;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Nsu4N0Rdllro8+TXtkYDOGeW85lDNvmYXwkzBCpjLp0=;
	b=RGDxr5INMLFVz52QiKbFv+oW8twT/u2eVFOw/WNx/0I3vydADsUiG9fFWnT10DAGBski
	 ilYq7yTvA7HXkWTGheviFY180IigsB4HFCf1bFeSN57NCFIgZQyMpv3b5FgUE5al65vCB
	 YSSTJsMEuLCl5jRr6ikAHYX+jjCfHkw1Z3gqT8s8gOjUv5K/oKyNAQXz+g51cDj4rJ4wY
	 n2wl5OPLDg+Wm1RxfWcC1Gj4BLz6+L28k6ynNvV0Ft9eVhjbP5FhXXgcczQLytW7w+QKY
	 xeqI1YgyrotEqecSAhsDwSo81DikO8x4in9MfqrF9xp0zGduTY02fFWEI8QYJ2eFqwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w4SJjO6H;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399D2606A331
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 06:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 399D2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w4SJjO6H
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-862df509ccbso1522108a34.2
        for <iommu@lists.linux.dev>; Sun, 22 Nov 2026 22:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795413874; x=1796018674; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nsu4N0Rdllro8+TXtkYDOGeW85lDNvmYXwkzBCpjLp0=;
        b=w4SJjO6H1DyBiTmukw4YUiuotz0u0CwUPwGeTMI4ydKFHcW1rOw3SSOx5CV1bH2XRM
         R54It3GYeQOQRwoz7Qr72wRd4A27GKxyVfvUHzVLj8ztoSzxjNdM/TWE6CLpy33cxVcq
         MgZj8of7F3NCfShr1ZtUcYRyQosNghSH7zKth45iT4VAltgPskQ6qQHT3u1xSI3ACoM4
         5yo0DEBNt83iaKktAHF83e3djgJCCMRqVXs2KzuAucG6RKp9KK8eF6+IobLiq+UXkh6c
         JxWTxzJ/xJz8Tq5rBS0HfnxQ9jcUCuwD+AueYgMs3zwl3Rpb4qAf9VJQnpFOkwGyC/do
         a2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795413874; x=1796018674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nsu4N0Rdllro8+TXtkYDOGeW85lDNvmYXwkzBCpjLp0=;
        b=fER263U+MKkb6EnO1F3hUpuUnjHE2+uBZErmfHwop39hb/QWq3A+qnMJl/q6ILES0C
         K1RJ+jeYsIN2yI9zQH0Fg80NCb6e5Ufi0+nxG/IPQ1Wde21TNPwSxgiQG05AvrL+0tq+
         oY22dxxQns86a6Uv6Xk/DuX0rLBV8yUi+FLh3NH48Jv4IDcwG65897Mx24Ku12/EDNTE
         Qam7GTIE96Znz3mFi/UdK3vz9+MtLOLG9jTM/Qw1iVfWPXAof3Hi19vjduphqzqTMAsx
         Kxupn5dUupYdHN+HB5MknmdHT+59o2ORISvRXff9vt3uHjrlAbJDbzk/uKKAvxEf56y5
         V3nw==
X-Forwarded-Encrypted: i=1; AL+hErFhlmH116HJEc7JlSboVD+M0B2RY2zywbgc+X9Zr7RU7FuiWGxDmVUeWWX8lrOJpcVfPALqxg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+pmv4YIfsAxJ9j2IwJEsRAGjW2wlV40uqMqsbZb4bP9ODob6Ee
	71FBkBZulziFHB8RboFRojvoGWB3+/+Zpn9RFEkzvcMq1WkXjA+6U1PmTKsB266r
X-Gm-Gg: AZFdTZfPL/pDvbWR0L+57Vmh7jBovQ4wlMDOtH+bsaVhQWfVgT4W2TQGmM8JQ5gciEB
	TddcJciHzAkEIutpNk+S3AdvSj9Vf7l9VWm0GSMQ7gEBfHroqnfcq9qlu3aeN0JTleWWZljL1IE
	KOq+SsrCKVSpyGrh90yq4aI6aecD+187xtgspXf5wpA8jelOR6xEv9C9cPGaKhlODbOyU/EVYSp
	nfMxB8XEF5tz3H6YYW7MW5Kv1Cgfvpm0Zb/9t9DFDPTHxIJdVUotnWJxXuqSPOHKqlt043cxfmy
	dGSjeIGIIptS63ktPENzM5gVLDoXx6koWVUPVVnGWgQhw+MJG+MimDwfwN/GtHFZIsSZgY33/o9
	crtNEFPMRc3LHBBVDnkRAYdHVuOI0sLoib7XIThTjRMqS9b/fRlVNeAN17Aznudg2XXQWgyzr+H
	WG2v6NjavzFvMHubIL/EAuUsaWPMmE8JFP6Y2OBCSv99ygybiCDlwWWOInEVpKS9iB3G5rn+7IV
	7CM4uUmzxjsnGfLtLFoS3cM8EYF5A1iCIoiWwZZ83prmgWAQPwwRnxpncjhJ7khJwbdXrVfyDVA
	KWpDmXxWMB00zFPITmFXWiJqXM56FRUjDXt0A961xNmmmnGocGwAkrdSkPR2mlV1ZtB2OvTGOZB
	s9nvrt5Mhx8bYOVLrWcyVF3GnutRKpjj9q9tOpeg/NdsOCy/5/aLX3HV6h94Bu+jU7Hk=
X-Received: by 2002:a05:6830:4c18:b0:862:ca2e:918e with SMTP id 46e09a7af769-863152d09cdmr12157738a34.1.1795413874172;
        Sun, 22 Nov 2026 22:04:34 -0800 (PST)
Received: from tempest-testimage-cc-centos9-stream-server-1191361818 (chi-dyn-129-114-108-164.tacc.chameleoncloud.org. [129.114.108.164])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631681f30asm7644864a34.1.2026.11.22.22.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:04:33 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Wei Liu <wei.liu@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 2/2] iommu/hyperv: Keep a new domain's page tables if it cannot be deleted
Date: Mon, 23 Nov 2026 06:01:56 +0000
Message-ID: <20261123060419.119078-6-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123060419.119078-4-oss.patchbox@gmail.com>
References: <20261123060419.119078-4-oss.patchbox@gmail.com>
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

When hv_iommu_domain_alloc_paging() fails to configure a new device
domain, hv_create_configure_device_domain() deletes the domain again,
and the caller then frees the page tables with pt_iommu_deinit(). The
page tables are freed even if the delete fails and the hypervisor
still has the domain.

The current Hyper-V implementation does not adopt the page table root
when HVCALL_CONFIGURE_DEVICE_DOMAIN fails, so the page tables are not
referenced in this case today. This change is defensive: it avoids
relying on that while the hypervisor still has the domain.

Create and configure the domain in hv_iommu_domain_alloc_paging()
itself, and leak the page tables and the domain when the delete fails,
as hv_iommu_paging_domain_free() does.

Reported-by: Jacob Pan <jacob.pan@linux.microsoft.com>
Closes: https://lore.kernel.org/all/20261105141427.00005946@linux.microsoft.com/
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/iommu/hyperv/hv-iommu-guest.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv/hv-iommu-guest.c
index aa1db9db1e97..0110a1529a23 100644
--- a/drivers/iommu/hyperv/hv-iommu-guest.c
+++ b/drivers/iommu/hyperv/hv-iommu-guest.c
@@ -540,10 +540,23 @@ static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
 	settings.page_table_root = pt_info.gcr3_pt;
 	settings.flags.first_stage_paging_mode = pt_info.levels == 5;
 
-	ret = hv_create_configure_device_domain(hv_domain, &settings);
+	ret = hv_create_device_domain(hv_domain);
 	if (ret)
 		goto err_pt_deinit;
 
+	ret = hv_configure_device_domain(hv_domain, &settings);
+	if (ret) {
+		/*
+		 * The current hypervisor does not adopt the page table root
+		 * when the configure call fails. Still, keep the page tables
+		 * while it has the domain, as hv_iommu_paging_domain_free()
+		 * does.
+		 */
+		if (hv_delete_device_domain(hv_domain))
+			return ERR_PTR(ret);
+		goto err_pt_deinit;
+	}
+
 	return &hv_domain->domain;
 
 err_pt_deinit:
-- 
2.56.1

