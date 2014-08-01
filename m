From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] iommu: Always define struct iommu_ops
Date: Fri,  1 Aug 2014 14:45:12 +0200
Message-ID: <1406897113-20099-1-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

With this structure always defined, drivers can be always compiled,
irrespective of whether or not IOMMU_API is enabled. This helps to
increase compile coverage without having to build with two separate
configurations.

Unused code can still be discarded by the compiler if the IS_ENABLED()
macro is properly used in an if condition, such as shown below:

	static const struct iommu_ops iommu_ops = {
		...
	};

	static int iommu_setup(...)
	{
		...

		bus_set_iommu(..., &iommu_ops);

		...
	}

	...

	static int iommu_probe(...)
	{
		...

		if (IS_ENABLED(CONFIG_IOMMU_API)) {
			err = iommu_setup(...);
			...
		}

		...
	}

That pattern will allow the compiler to notice that setup_iommu() is
never called if IOMMU_API is not selected, which will allow it to
discard its code and all data referenced from it.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 include/linux/iommu.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 20f9a527922a..0b5222c7ff97 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -83,8 +83,6 @@ enum iommu_attr {
 	DOMAIN_ATTR_MAX,
 };
 
-#ifdef CONFIG_IOMMU_API
-
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @domain_init: init iommu domain
@@ -140,6 +138,8 @@ struct iommu_ops {
 #define IOMMU_GROUP_NOTIFY_UNBIND_DRIVER	5 /* Pre Driver unbind */
 #define IOMMU_GROUP_NOTIFY_UNBOUND_DRIVER	6 /* Post Driver unbind */
 
+#ifdef CONFIG_IOMMU_API
+
 extern int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops);
 extern bool iommu_present(struct bus_type *bus);
 extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
@@ -242,9 +242,6 @@ static inline int report_iommu_fault(struct iommu_domain *domain,
 
 #else /* CONFIG_IOMMU_API */
 
-struct iommu_ops {};
-struct iommu_group {};
-
 static inline bool iommu_present(struct bus_type *bus)
 {
 	return false;
-- 
2.0.3
