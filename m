From: Logan Gunthorpe <logang@deltatee.com>
Subject: [PATCH v3 10/10] NTB: Describe the ntb_msi_test client in the documentation.
Date: Thu, 21 Mar 2019 18:06:45 -0600
Message-ID: <20190322000645.15580-11-logang@deltatee.com>
References: <20190322000645.15580-1-logang@deltatee.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322000645.15580-1-logang@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Joerg Roedel <joro@8bytes.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>, Logan Gunthorpe <logang@deltatee.com>
List-Id: iommu@lists.linux-foundation.org

Add a blurb in Documentation/ntb.txt to describe the ntb_msi_test tool's
debugfs interface. Similar to the (out of date) ntb_tool description.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 Documentation/ntb.txt | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/ntb.txt b/Documentation/ntb.txt
index a043854d28df..802a539f1592 100644
--- a/Documentation/ntb.txt
+++ b/Documentation/ntb.txt
@@ -194,6 +194,33 @@ Debugfs Files:
 	This file is used to read and write peer scratchpads.  See
 	*spad* for details.
 
+NTB MSI Test Client (ntb\_msi\_test)
+------------------------------------
+
+The MSI test client serves to test and debug the MSI library which
+allows for passing MSI interrupts across NTB memory windows. The
+test client is interacted with through the debugfs filesystem:
+
+* *debugfs*/ntb\_tool/*hw*/
+	A directory in debugfs will be created for each
+	NTB device probed by the tool.  This directory is shortened to *hw*
+	below.
+* *hw*/port
+	This file describes the local port number
+* *hw*/irq*_occurrences
+	One occurrences file exists for each interrupt and, when read,
+	returns the number of times the interrupt has been triggered.
+* *hw*/peer*/port
+	This file describes the port number for each peer
+* *hw*/peer*/count
+	This file describes the number of interrupts that can be
+	triggered on each peer
+* *hw*/peer*/trigger
+	Writing an interrupt number (any number less than the value
+	specified in count) will trigger the interrupt on the
+	specified peer. That peer's interrupt's occurrence file
+	should be incremented.
+
 NTB Hardware Drivers
 ====================
 
-- 
2.20.1
