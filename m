Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674328;
	b=ZkqJwHQgK/qzRQY7QVKjRxYJZQ3EUxReKJsumTmozP+Uviko+PUQRXvG6m/dl9AXvOs2
	 /BSeB3urHnp6f5ysKVB7joY31HddLzMu5DY21bO9BQ2hdNRUkEjZn+y2hQiecUMzwCXyJ
	 5CYehY7sHCpo+WUp1XMXfh6iKVcQCK5frMiA2Cy6MCPmXRlcz9Tsjx2EzEGA9WrEwHxsR
	 gtdmay1yh/bYCsaE63DhaZV1Cp57pJUpmcrcptweVm83WZTUrJ4Whc6mNWfmqk74yCH/M
	 9867iSaFwwYguMpeknplczwVjIA0b7jN3XYedqrw/y1HQBYgx/4xWdVz9dpNc9aJL1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674328;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=0EHmjzbFR/yNJP1Nxx0dUmYDywoFEpvvyJwEhuOQ678=;
	b=lzXeQQyCFV9nLTzOjJzrfqDqxcmE6mZ/kAn/9cVJhRnIEnFwePg3GZ7yw7GxPgZ20RnW
	 WrgjNWGJ3rftXc9ZFPLGYUJknKODTvjPmAbiTTrG/lV2UDOPGYIC3MqfQaVVHBTjhAGOM
	 ycn6VusgWz88R0ySx6BVse8zvxe367aS6o6+/yZ3OZU/TY+FjYLMGg64jjCH3MIv2+i3h
	 KqUXBQe3xSlbn5cJukR5SYb1yO/VIZKzcz/59PoQvYgXUgkUsyafAg8aRqNaQ5wziTqS5
	 jjQ3k5OiC9vDm9ZZ0mMlu6gCIxAg5D7uENA5hMbHpNygPo5DWN49M1heRpeKAyjyKMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=qPEsfdqc;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6027C606A33C
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 02:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6027C606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=qPEsfdqc
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id DFD7120B7168;
	Mon,  2 Nov 2026 18:51:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DFD7120B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793674312;
	bh=0EHmjzbFR/yNJP1Nxx0dUmYDywoFEpvvyJwEhuOQ678=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qPEsfdqc89khoKnPa9lS4y5OOH+qjchVDl0Dof07bgI4bQNLgME2dKNkAavWTl0UG
	 5cAzJJK8Uw0hYo7QmcEgWWXDxq5b0FntXKfHlMoX2vl7oNkgqQLl2SscD3WIy++k0G
	 a7WS/TGeu8ljnOSLdMFGa8cZYCMvKWilt5AeY4gY=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arch@vger.kernel.org
Cc: jgg@nvidia.com,
	jacob.pan@linux.microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	arnd@arndb.de,
	mrathor@linux.microsoft.com
Subject: [PATCH V3 2/5] PCI: hv: Export hv_build_devid_type_pci() and change return type
Date: Mon,  2 Nov 2026 18:51:47 -0800
Message-ID: <20261103025150.3192119-3-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20261103025150.3192119-1-mrathor@linux.microsoft.com>
References: <20261103025150.3192119-1-mrathor@linux.microsoft.com>
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

On Hyper-V, most hypercalls related to device domain management like
attach device to a device domain, or to map/unmap regions, interrupts,
etc need a device ID as a parameter. So, make hv_build_devid_type_pci()
public and change return type to u64 to enforce its size.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
Reviewed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
---
 arch/x86/hyperv/irqdomain.c     | 9 +++++----
 arch/x86/include/asm/mshyperv.h | 6 ++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index b3ad50a874dc..8780573a4332 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -112,7 +112,7 @@ static int get_rid_cb(struct pci_dev *pdev, u16 alias, void *data)
 	return 0;
 }
 
-static union hv_device_id hv_build_devid_type_pci(struct pci_dev *pdev)
+u64 hv_build_devid_type_pci(struct pci_dev *pdev)
 {
 	int pos;
 	union hv_device_id hv_devid;
@@ -172,8 +172,9 @@ static union hv_device_id hv_build_devid_type_pci(struct pci_dev *pdev)
 	}
 
 out:
-	return hv_devid;
+	return hv_devid.as_uint64;
 }
+EXPORT_SYMBOL_GPL(hv_build_devid_type_pci);
 
 /*
  * hv_map_msi_interrupt() - Map the MSI IRQ in the hypervisor.
@@ -196,7 +197,7 @@ int hv_map_msi_interrupt(struct irq_data *data,
 
 	msidesc = irq_data_get_msi_desc(data);
 	pdev = msi_desc_to_pci_dev(msidesc);
-	hv_devid = hv_build_devid_type_pci(pdev);
+	hv_devid.as_uint64 = hv_build_devid_type_pci(pdev);
 	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
 
 	return hv_map_interrupt(hv_devid, false, cpu, cfg->vector,
@@ -271,7 +272,7 @@ static int hv_unmap_msi_interrupt(struct pci_dev *pdev,
 {
 	union hv_device_id hv_devid;
 
-	hv_devid = hv_build_devid_type_pci(pdev);
+	hv_devid.as_uint64 = hv_build_devid_type_pci(pdev);
 	return hv_unmap_interrupt(hv_devid.as_uint64, irq_entry);
 }
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 20d947c2c758..24b19cd28a05 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -248,6 +248,12 @@ void hv_crash_asm_end(void);
 static inline void hv_root_crash_init(void) {}
 #endif  /* CONFIG_MSHV_ROOT && CONFIG_CRASH_DUMP */
 
+#ifdef CONFIG_PCI_MSI
+u64 hv_build_devid_type_pci(struct pci_dev *pdev);
+#else
+static inline u64 hv_build_devid_type_pci(struct pci_dev *pdev) { return 0; }
+#endif
+
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline void hyperv_setup_mmu_ops(void) {}
-- 
2.51.2.vfs.0.1

