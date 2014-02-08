From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: [RFC PATCH v4 01/10] driver core: export driver_probe_device()
Date: Sat,  8 Feb 2014 18:29:31 +0100
Message-ID: <1391880580-471-2-git-send-email-a.motakis@virtualopensystems.com>
References: <1391880580-471-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1391880580-471-1-git-send-email-a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Dmitry Kasatkin <d.kasatkin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Toshi Kani <toshi.kani-VXdhtT5mjnY@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, R65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Michal Hocko <mhocko-AlSwsSmVLrQ@public.gmane.org>, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Kim Phillips <kim.phillips-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Needed by drivers, such as the vfio platform driver [1], seeking to
bypass bind_store()'s driver_match_device(), and bind to any device
via a private sysfs bind file.

[1] https://lkml.org/lkml/2013/12/11/522

note: the EXPORT_SYMBOL is needed because vfio-platform can be built
as a module.

Signed-off-by: Kim Phillips <kim.phillips-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/base/base.h    | 1 -
 drivers/base/dd.c      | 1 +
 include/linux/device.h | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 24f4242..fe25ad87 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -112,7 +112,6 @@ extern int bus_add_driver(struct device_driver *drv);
 extern void bus_remove_driver(struct device_driver *drv);
 
 extern void driver_detach(struct device_driver *drv);
-extern int driver_probe_device(struct device_driver *drv, struct device *dev);
 extern void driver_deferred_probe_del(struct device *dev);
 static inline int driver_match_device(struct device_driver *drv,
 				      struct device *dev)
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 0605176..44f6184 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -384,6 +384,7 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(driver_probe_device);
 
 static int __device_attach(struct device_driver *drv, void *data)
 {
diff --git a/include/linux/device.h b/include/linux/device.h
index 952b010..ad80dd2 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -257,6 +257,7 @@ extern struct device_driver *driver_find(const char *name,
 					 struct bus_type *bus);
 extern int driver_probe_done(void);
 extern void wait_for_device_probe(void);
+extern int driver_probe_device(struct device_driver *drv, struct device *dev);
 
 
 /* sysfs interface for exporting driver attributes */
-- 
1.8.3.2
