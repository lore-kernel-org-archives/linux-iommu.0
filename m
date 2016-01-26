From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] Intel-IOMMU.txt: fix link
Date: Tue, 26 Jan 2016 18:33:04 +0200
Message-ID: <1453825916-16269-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-doc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

Looks like the VT-D spec at intel.com got moved.
Update the link.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/Intel-IOMMU.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/Intel-IOMMU.txt b/Documentation/Intel-IOMMU.txt
index 7b57fc0..49585b6 100644
--- a/Documentation/Intel-IOMMU.txt
+++ b/Documentation/Intel-IOMMU.txt
@@ -3,7 +3,7 @@ Linux IOMMU Support
 
 The architecture spec can be obtained from the below location.
 
-http://www.intel.com/technology/virtualization/
+http://www.intel.com/content/dam/www/public/us/en/documents/product-specifications/vt-directed-io-spec.pdf
 
 This guide gives a quick cheat sheet for some basic understanding.
 
-- 
MST
