From: srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Subject: [PATCH 1/3] rpmsg: core: export rpmsg bus type
Date: Fri,  2 Mar 2018 14:55:29 +0000
Message-ID: <20180302145531.20463-2-srinivas.kandagatla@linaro.org>
References: <20180302145531.20463-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180302145531.20463-1-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org, linux-remoteproc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Export rpmsg bus type so that iommu drivers iommu ops to
rpmsg bus type.

On Qualcomm SoCs ADSP exposes functions like audio and
other which need iommu access, as these drivers are part
of rpmsg bus, able to allocate memory from iommus is basic
requirement. So expose this bus so that iommu drivers can
add ops to this.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/rpmsg/rpmsg_core.c | 3 ++-
 include/linux/rpmsg.h      | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 5a081762afcc..e84c71f8d6ab 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -465,7 +465,7 @@ static int rpmsg_dev_remove(struct device *dev)
 	return err;
 }
 
-static struct bus_type rpmsg_bus = {
+struct bus_type rpmsg_bus = {
 	.name		= "rpmsg",
 	.match		= rpmsg_dev_match,
 	.dev_groups	= rpmsg_dev_groups,
@@ -473,6 +473,7 @@ static struct bus_type rpmsg_bus = {
 	.probe		= rpmsg_dev_probe,
 	.remove		= rpmsg_dev_remove,
 };
+EXPORT_SYMBOL(rpmsg_bus);
 
 int rpmsg_register_device(struct rpmsg_device *rpdev)
 {
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index ca07366c4c33..869e5946b7df 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -49,7 +49,7 @@ struct rpmsg_device;
 struct rpmsg_endpoint;
 struct rpmsg_device_ops;
 struct rpmsg_endpoint_ops;
-
+extern struct bus_type rpmsg_bus;
 /**
  * struct rpmsg_channel_info - channel info representation
  * @name: name of service
-- 
2.15.1
