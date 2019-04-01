From: Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/3] drm: Add a drm_gem_objects_lookup helper
Date: Mon,  1 Apr 2019 02:47:29 -0500
Message-ID: <20190401074730.12241-3-robh@kernel.org>
References: <20190401074730.12241-1-robh@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401074730.12241-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>, Neil Armstrong <narmstrong@baylibre.com>
List-Id: iommu@lists.linux-foundation.org

Similar to the single handle drm_gem_object_lookup(),
drm_gem_objects_lookup() takes an array of handles and returns an array
of GEM objects.

Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/gpu/drm/drm_gem.c | 46 +++++++++++++++++++++++++++++++--------
 include/drm/drm_gem.h     |  2 ++
 2 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 388b3742e562..5c9bff45e5e1 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -663,6 +663,42 @@ void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
 }
 EXPORT_SYMBOL(drm_gem_put_pages);
 
+/**
+ * drm_gem_objects_lookup - look up GEM objects from an array of handles
+ * @filp: DRM file private date
+ * @handle: pointer to array of userspace handle
+ * @count: size of handle array
+ * @objs: pointer to array of drm_gem_object pointers
+ *
+ * Returns:
+ *
+ * @objs filled in with GEM object pointers. -ENOENT is returned on a lookup
+ * failure. 0 is returned on success.
+ */
+int drm_gem_objects_lookup(struct drm_file *filp, u32 *handle, int count,
+			   struct drm_gem_object **objs)
+{
+	int i, ret = 0;
+	struct drm_gem_object *obj;
+
+	spin_lock(&filp->table_lock);
+
+	for (i = 0; i < count; i++) {
+		/* Check if we currently have a reference on the object */
+		obj = idr_find(&filp->object_idr, handle[i]);
+		if (!obj) {
+			ret = -ENOENT;
+			break;
+		}
+		drm_gem_object_get(obj);
+		objs[i] = obj;
+	}
+	spin_unlock(&filp->table_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(drm_gem_objects_lookup);
+
 /**
  * drm_gem_object_lookup - look up a GEM object from its handle
  * @filp: DRM file private date
@@ -678,15 +714,7 @@ drm_gem_object_lookup(struct drm_file *filp, u32 handle)
 {
 	struct drm_gem_object *obj;
 
-	spin_lock(&filp->table_lock);
-
-	/* Check if we currently have a reference on the object */
-	obj = idr_find(&filp->object_idr, handle);
-	if (obj)
-		drm_gem_object_get(obj);
-
-	spin_unlock(&filp->table_lock);
-
+	drm_gem_objects_lookup(filp, &handle, 1, &obj);
 	return obj;
 }
 EXPORT_SYMBOL(drm_gem_object_lookup);
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index 2955aaab3dca..5404225e0194 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -381,6 +381,8 @@ struct page **drm_gem_get_pages(struct drm_gem_object *obj);
 void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
 		bool dirty, bool accessed);
 
+int drm_gem_objects_lookup(struct drm_file *filp, u32 *handle, int count,
+			   struct drm_gem_object **objs);
 struct drm_gem_object *drm_gem_object_lookup(struct drm_file *filp, u32 handle);
 long drm_gem_reservation_object_wait(struct drm_file *filep, u32 handle,
 				    bool wait_all, unsigned long timeout);
-- 
2.19.1
