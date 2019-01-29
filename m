From: jglisse@redhat.com
Subject: [RFC PATCH 1/5] pci/p2p: add a function to test peer to peer capability
Date: Tue, 29 Jan 2019 12:47:24 -0500
Message-ID: <20190129174728.6430-2-jglisse@redhat.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129174728.6430-1-jglisse@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Logan Gunthorpe <logang@deltatee.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Jason Gunthorpe <jgg@mellanox.com>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

From: Jérôme Glisse <jglisse@redhat.com>

device_test_p2p() return true if two devices can peer to peer to
each other. We add a generic function as different inter-connect
can support peer to peer and we want to genericaly test this no
matter what the inter-connect might be. However this version only
support PCIE for now.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux-foundation.org
---
 drivers/pci/p2pdma.c       | 27 +++++++++++++++++++++++++++
 include/linux/pci-p2pdma.h |  6 ++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index c52298d76e64..620ac60babb5 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -797,3 +797,30 @@ ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
 	return sprintf(page, "%s\n", pci_name(p2p_dev));
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_enable_show);
+
+bool pci_test_p2p(struct device *devA, struct device *devB)
+{
+	struct pci_dev *pciA, *pciB;
+	bool ret;
+	int tmp;
+
+	/*
+	 * For now we only support PCIE peer to peer but other inter-connect
+	 * can be added.
+	 */
+	pciA = find_parent_pci_dev(devA);
+	pciB = find_parent_pci_dev(devB);
+	if (pciA == NULL || pciB == NULL) {
+		ret = false;
+		goto out;
+	}
+
+	tmp = upstream_bridge_distance(pciA, pciB, NULL);
+	ret = tmp < 0 ? false : true;
+
+out:
+	pci_dev_put(pciB);
+	pci_dev_put(pciA);
+	return false;
+}
+EXPORT_SYMBOL_GPL(pci_test_p2p);
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index bca9bc3e5be7..7671cc499a08 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -36,6 +36,7 @@ int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
 			    bool *use_p2pdma);
 ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
 			       bool use_p2pdma);
+bool pci_test_p2p(struct device *devA, struct device *devB);
 #else /* CONFIG_PCI_P2PDMA */
 static inline int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar,
 		size_t size, u64 offset)
@@ -97,6 +98,11 @@ static inline ssize_t pci_p2pdma_enable_show(char *page,
 {
 	return sprintf(page, "none\n");
 }
+
+static inline bool pci_test_p2p(struct device *devA, struct device *devB)
+{
+	return false;
+}
 #endif /* CONFIG_PCI_P2PDMA */
 
 
-- 
2.17.2
