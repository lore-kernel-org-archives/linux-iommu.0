Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591864FC335
	for <iommu@lists.linux.dev>; Thu,  8 Oct 2026 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791491353; cv=none; b=gJ43qSMUzNgeFkfpLqSPDEXD2ByKMWsficOfVojVN8OCf6BPOJoeW46RdZpK0vkjWhyZXgtwjAhwQDv+qEGPnV72dSP+RS0JCxXn13ZZPIJkn+kj2823lECXwPQ0YkY4kP8ZtsHKhSZirtoXvhNnF9hebDDOWve5UVpDRpKvHHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791491353; c=relaxed/simple;
	bh=GqNZFFS4eTIb708Eoy/tXQ66KdSn0Lvhue0RwL47s4A=;
	h=From:To:Cc:Subject:Date:Message-ID; b=BUxigvw4KckI94sxgLyP2ZqYJY00BZq2PXw/bicg562GqpOoxkiFmYAqkeeUhHsyEegToPNK6WJ42dKZIa/6tGVJD7QRCSN64MjR680M8b+8M++/dAoVz1ZobhCEGHtOpEfWxDHfPYoHtrYKchuZhuTpadb+C4nUNr1nU4p81do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=ESbe4Ntt; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ESbe4Ntt"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-381b831d535so5714786a91.0
        for <iommu@lists.linux.dev>; Thu, 08 Oct 2026 13:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791491348; x=1792096148;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u0ZTgl3gzHMxU8rZBcoHFObnSv/9xICBYZH4gzmLfRc=;
        b=ONgS3UWKyP7p6JXjpShpmaqS2N6IuE7z8GnEz4ALo3qnmf0YdcVRhDTnVBfi2+7Dmg
         6M/0COQgJurdPuq7TbXsWaIxMD1nEhEGsofDKNFrpNl7pvM1Jmfxr9KLQwAS7UuaZVtq
         kvDWbf0r872oPjEJi+aGfA1nFcdHMJzhAJQyc0UrHFQ1eCskD8/UR0dvOWNApOHv3vCG
         eY8W5elUpipan8EYldDP6vUrpVUJewXR6O+REonfOs2cINgI4uGQm4EATDiNhfmPCK1l
         x8qxYO2jHfOk+VJ5SDTQJFGAMLRflT0VpqXoyMD2PXWZ2VweHMtHTc3xKurCu6uXXCbP
         J+ig==
X-Forwarded-Encrypted: i=1; AKwUvBzQhQdUJIvcisMqCZAfEUWcO2Wo8BucKzL2Nm30yG5JNwzWV+iHkijZOl0tIc1PKnbZjwEzrg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJvdv77bp+i5jtMilJaF0kCQrFWjLFqQcEKo7Et7rr68fiDL0uF
	DjBwg8AaB+rqOGB5O/H/2PAewYsfcEy1mAKlrzZfzpqNT9j6BE8oawezcU6TydT2XSWCzcS/IfU
	mY2tZy/pBkoCKSAGdGIzY/niNLP5qahfOLw==
X-Gm-Gg: AYBFou0bJ0VpMuSzuhm2PE33OVKkJSEY529EpnVophvTkvoNonO0tDRliir6esJNAPh
	I+HZ8aKep8X2R0RQKXmLr8wFQk33DFO83V/4Lazo6dljwBNU361SLRh3bow1uRr8kNzWK189gCu
	yZvc0P+J/30YHyj/W6ZN5OW3njnhPC1QEJ22kwBALoldJaAVXZQnl0+OebDI0RD5uov306eK2Lh
	36bgoWf6vKFLAgxnj/OUoJqCpLLl1FoIrh/CUTDr7Smoov5pZm0PUWPGmKrJ6P7X44odxyDXk8B
	hmKThSVqY3OHwMC3a97FqnLg7mMPfhpY+AJ7BzeBsqAGvvmFhkQfNZbeXQ8nDeThX3AHikMIWzv
	U6qpPbFLyvepeD5eUQFKO+Xo3ywZbpMTd2folYYI3rALgr3ygjBrLBL+vgpg=
X-Received: by 2002:a17:90b:5483:b0:3a8:6424:b1b1 with SMTP id 98e67ed59e1d1-3a8a1ab7705mr5561957a91.33.1791491348558;
        Thu, 08 Oct 2026 13:29:08 -0700 (PDT)
Received: from smtp.aristanetworks.com (ec2-54-84-120-176.compute-1.amazonaws.com. [54.84.120.176])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab36e34040sm101802a91.7.2026.10.08.13.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 13:29:08 -0700 (PDT)
X-Relaying-Domain: arista.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1791491347;
	bh=u0ZTgl3gzHMxU8rZBcoHFObnSv/9xICBYZH4gzmLfRc=;
	h=From:To:Cc:Subject:Date:From;
	b=ESbe4NttCxfd+SKabiUWx7Vhpj+uqDMw5OweWOHbqvc+Sfy0zTNfkCmrMF39g5xxp
	 7dbDDMbZhV9cpyECp1X03fk/DimWsomsi54QolxKMZuk0wYS1M8QRVcTLbgfc1QuW1
	 AxYQ0wA2VffZKLWtunS8kn+UbY1NYO6xkv9nZI6q5WJvyohmJqIC3YMqY4TPf4/j3l
	 4/++rYGL+HVLTUZPkq5obVPGtXPf9iqTd8RVWgQMYajQBkzVcxdUpMdvAhaAIUBX09
	 TFk1vo2TZ0/sgquwYniiYxGORbMp1ITjnQ/wMMnDtpSX9S9U5i1vpdnndUWKK681nx
	 wR8EYL7s3uZVg==
Received: from kevmitch-g-eos-trunk-kernel7-2026-09-06.sjc.aristanetworks.com (unknown [10.242.71.193])
	by smtp.aristanetworks.com (Postfix) with ESMTP id D8BACC047B;
	Thu,  8 Oct 2026 20:29:06 +0000 (UTC)
X-SMTP-Authentication: Allow-List-permitted
X-SMTP-Authentication: Allow-List-permitted
From: Kevin Mitchell <kevmitch@arista.com>
To: Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Kevin Mitchell <kevmitch@arista.com>,
	stable@vger.kernel.org,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joerg.roedel@amd.com>,
	iommu@lists.linux.dev (open list:AMD IOMMU (AMD-VI)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iommu/amd: allow identity domain during device release
Date: Thu,  8 Oct 2026 13:25:27 -0700
Message-ID: <20261008202530.14501-2-kevmitch@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

A warning is triggered in amd_iommu_release_device() on removal of a
device with an IOMMU_RESV_DIRECT region. The warning is based on the
false assumption that correct attachment to the release_domain will
always result in a NULL dev_data->domain pointer. For devices with
IOMMU_RESV_DIRECT (and consequently dev->iommu->require_direct), the
release domain is the permanent identity_domain which sets
itself to dev_data->domain on attach.

This behaviour was added in commit e94160488e65 ("iommu: Generic support
for RMRs during device release"). Commit c21b34762e2f ("iommu/amd: Set
release_domain to blocked_domain") caused it to take effect for AMD
IOMMU.

Explicitly allow the identity domain pointer to be set. Keep the warning
for any other non-NULL domain.

The warning was observed for a device with direct mapped region:

/sys/bus/pci/devices/0000:04:00.0/iommu_group/reserved_regions:

  0x00000000fee00000 0x00000000feefffff msi
  0x000000fd00000000 0x000000ffffffffff reserved
  0x0000fffd00000000 0x0000ffffffffffff direct

Upon hotunplug:

[   28.715475] pcieport 0000:00:03.1: pciehp: Slot(0-3): Link Down
[   28.715482] pcieport 0000:00:03.1: pciehp: Slot(0-3): Card not present
[   28.715601] ------------[ cut here ]------------
[   28.715603] WARNING: drivers/iommu/amd/iommu.c:2521 at amd_iommu_release_device+0x5d/0x70, CPU#4: irq/29-pciehp/99
[   28.715657] RIP: 0010:amd_iommu_release_device+0x5d/0x70
[   28.715687] Call Trace:
[   28.715689]  <TASK>
[   28.715694]  iommu_deinit_device+0x84/0x110
[   28.715699]  __iommu_group_remove_device+0xa8/0xd0
[   28.715703]  iommu_bus_notifier+0x48/0x70
[   28.715707]  notifier_call_chain+0x48/0xe0
[   28.715712]  blocking_notifier_call_chain+0x45/0x60
[   28.715716]  bus_notify+0x3b/0x60
[   28.715720]  device_del+0x259/0x3b0
[   28.715730]  pci_remove_bus_device+0x85/0x100
[   28.715735]  pciehp_unconfigure_device+0x9d/0x180
[   28.715743]  __pciehp_disable_slot+0x47/0xe0
[   28.715747]  pciehp_handle_presence_or_link_change+0x80/0x5e0
[   28.715753]  pciehp_ist+0x162/0x290

Fixes: c21b34762e2f ("iommu/amd: Set release_domain to blocked_domain")
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
---
 drivers/iommu/amd/iommu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 56262f6b1f70..770717e36333 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2548,11 +2548,17 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	return iommu_dev;
 }
 
+static struct protection_domain identity_domain;
+
 static void amd_iommu_release_device(struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 
-	WARN_ON(dev_data->domain);
+	/*
+	 * Devices with direct mapped regions are attached to the
+	 * identity_domain as their release_domain.
+	 */
+	WARN_ON(dev_data->domain && dev_data->domain != &identity_domain);
 
 	/*
 	 * We keep dev_data around for unplugged devices and reuse it when the
@@ -2953,8 +2959,6 @@ static struct iommu_domain blocked_domain = {
 	}
 };
 
-static struct protection_domain identity_domain;
-
 static int amd_iommu_identity_attach(struct iommu_domain *dom, struct device *dev,
 				     struct iommu_domain *old)
 {
-- 
2.51.0

