From: laurentiu.tudor@nxp.com
Subject: [PATCH 08/13] fsl/fman: add API to get the device behind a fman port
Date: Fri, 29 Mar 2019 16:00:09 +0200
Message-ID: <20190329140014.8126-9-laurentiu.tudor@nxp.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com, camelia.groza@nxp.com, leoyang.li@nxp.com
Cc: davem@davemloft.net, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Laurentiu Tudor <laurentiu.tudor@nxp.com>
List-Id: iommu@lists.linux-foundation.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Add an API that retrieves the 'struct device' that the specified fman
port probed against. The new API will be used in a subsequent iommu
enablement related patch.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Acked-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/fman/fman_port.c | 14 ++++++++++++++
 drivers/net/ethernet/freescale/fman/fman_port.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fman/fman_port.c b/drivers/net/ethernet/freescale/fman/fman_port.c
index ee82ee1384eb..bd76c9730692 100644
--- a/drivers/net/ethernet/freescale/fman/fman_port.c
+++ b/drivers/net/ethernet/freescale/fman/fman_port.c
@@ -1728,6 +1728,20 @@ u32 fman_port_get_qman_channel_id(struct fman_port *port)
 }
 EXPORT_SYMBOL(fman_port_get_qman_channel_id);
 
+/**
+ * fman_port_get_device
+ * port:	Pointer to the FMan port device
+ *
+ * Get the 'struct device' associated to the specified FMan port device
+ *
+ * Return: pointer to associated 'struct device'
+ */
+struct device *fman_port_get_device(struct fman_port *port)
+{
+	return port->dev;
+}
+EXPORT_SYMBOL(fman_port_get_device);
+
 int fman_port_get_hash_result_offset(struct fman_port *port, u32 *offset)
 {
 	if (port->buffer_offsets.hash_result_offset == ILLEGAL_BASE)
diff --git a/drivers/net/ethernet/freescale/fman/fman_port.h b/drivers/net/ethernet/freescale/fman/fman_port.h
index 9dbb69f40121..82f12661a46d 100644
--- a/drivers/net/ethernet/freescale/fman/fman_port.h
+++ b/drivers/net/ethernet/freescale/fman/fman_port.h
@@ -157,4 +157,6 @@ int fman_port_get_tstamp(struct fman_port *port, const void *data, u64 *tstamp);
 
 struct fman_port *fman_port_bind(struct device *dev);
 
+struct device *fman_port_get_device(struct fman_port *port);
+
 #endif /* __FMAN_PORT_H */
-- 
2.17.1
