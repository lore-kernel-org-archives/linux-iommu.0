Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A9124290D
	for <iommu@lists.linux.dev>; Tue,  8 Apr 2025 21:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744148069; cv=none; b=WvU8gEZ3TzUQBD+KZeXUP77c6h0Sml1YGBD2x3rh0oBylUwrGYkDhj0hXLUhaaypIOE3/ngboywW/UVP9tD9ILhBTMwmgvgAuDEWEvALPnBx/l0aaewXWL54LyMMq6QAE/Al+H1UdVfvt3iPaIXifLfYglI4AOuQMkHJS6o6StE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744148069; c=relaxed/simple;
	bh=5y+jYg4tFLii2fhDXKuV70GCZYiXZr2+wmGH9PNJeas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MRlsDlnLiKu/wfRRkcP5k+Zip1PrpXGPrueQBHsWe3PBabpJUzOeGIsFWYfdV2R2fIWd9FIv0G/BCsh4IMGcNJB2YNUAj36+vGQnyBHOCIWahetd7ToG+kGfnldIIyBiUQ4IvdFoGASISR+TNXrKIdTf60S8dJihfaMtZCiS8fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=S7obbZgk; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="S7obbZgk"
Received: from fedora.intra.ispras.ru (unknown [10.10.165.6])
	by mail.ispras.ru (Postfix) with ESMTPSA id EA32B448787D;
	Tue,  8 Apr 2025 21:34:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru EA32B448787D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1744148062;
	bh=N4Tgywr8Fw9WMBSdeYcYar/HdOFlbUR5lSCeLjJ1bfI=;
	h=From:To:Cc:Subject:Date:From;
	b=S7obbZgkV6jYoLfjlL/M4N/YTI1c824HzIw6nELFmc/PghNyXdL3IHonvhBcwXrw8
	 vJ/7kRbFH9TkfbZlj6ALLYrJCCkUIHLUwPHtAmRYPxRXD0IaATfEHKDLCp1mQcfLzH
	 KPO+ELugplkE+qWSv3dzE1upgXz4/ZUbW9PstazI=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Will Deacon <will@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] iommu: fix crash in report_iommu_fault()
Date: Wed,  9 Apr 2025 00:33:41 +0300
Message-ID: <20250408213342.285955-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following crash is observed while handling an IOMMU fault with a
recent kernel:

kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
BUG: unable to handle page fault for address: ffff8c708299f700
PGD 19ee01067 P4D 19ee01067 PUD 101c10063 PMD 80000001028001e3
Oops: Oops: 0011 [#1] SMP NOPTI
CPU: 4 UID: 0 PID: 139 Comm: irq/25-AMD-Vi Not tainted 6.15.0-rc1+ #20 PREEMPT(lazy)
Hardware name: LENOVO 21D0/LNVNB161216, BIOS J6CN50WW 09/27/2024
RIP: 0010:0xffff8c708299f700
Call Trace:
 <TASK>
 ? report_iommu_fault+0x78/0xd3
 ? amd_iommu_report_page_fault+0x91/0x150
 ? amd_iommu_int_thread+0x77/0x180
 ? __pfx_irq_thread_fn+0x10/0x10
 ? irq_thread_fn+0x23/0x60
 ? irq_thread+0xf9/0x1e0
 ? __pfx_irq_thread_dtor+0x10/0x10
 ? __pfx_irq_thread+0x10/0x10
 ? kthread+0xfc/0x240
 ? __pfx_kthread+0x10/0x10
 ? ret_from_fork+0x34/0x50
 ? __pfx_kthread+0x10/0x10
 ? ret_from_fork_asm+0x1a/0x30
 </TASK>

report_iommu_fault() checks for an installed handler comparing the
corresponding field to NULL. It can (and could before) be called for a
domain with a different cookie type - IOMMU_COOKIE_DMA_IOVA, specifically.
Cookie is represented as a union so we may end up with a garbage value
treated there if this happens for a domain with another cookie type.

Formerly there were two exclusive cookie types in the union.
IOMMU_DOMAIN_SVA has a dedicated iommu_report_device_fault().

Call the fault handler only if the passed domain has a required cookie
type.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 6aa63a4ec947 ("iommu: Sort out domain user data")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

I've seen the discussion [1] on 6aa63a4ec947 ("iommu: Sort out domain user
data") and got a bit confused by the fragment:

> iommu-dma itself isn't ever going to use a fault 
> handler because it expects the DMA API to be used correctly and thus no 
> faults to occur.

My first thought about this is that iommu-dma is not interested in
installing a fault handler ever, okay. But why does it suppose that no
faults would occur? It is a matter of "chance", firmware bugs, abovesaid
DMA API abusing, etc... isn't it?

[1]: https://lore.kernel.org/linux-iommu/d9a6c611-2a19-4830-964d-44b711fffb08@arm.com/


BTW, the device in question is Realtek RTL8852BE PCIe Wireless Network
controller. It had occasionally dumped IO fault messages before the 6.15
changes but I didn't pay attention to them since there was no connectivity
problems observed or similar.

IOMMU group 16 03:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd. RTL8852BE PCIe 802.11ax Wireless Network Controller [10ec:b852]


[ 2628.582070] rtw89_8852be 0000:03:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0012 address=0x0 flags=0x0000]

Turns out it started with a recent firmware upgrade so will report that
certain issue to rtw maintainers.

 drivers/iommu/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c8033ca66377..5729e8ecdda3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2717,7 +2717,8 @@ int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
 	 * if upper layers showed interest and installed a fault handler,
 	 * invoke it.
 	 */
-	if (domain->handler)
+	if (domain->cookie_type == IOMMU_COOKIE_FAULT_HANDLER &&
+	    domain->handler)
 		ret = domain->handler(domain, dev, iova, flags,
 						domain->handler_token);
 
-- 
2.49.0

