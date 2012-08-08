From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] debugfs: Allow debugfs_create_dir() to take data
Date: Wed, 8 Aug 2012 09:24:32 +0300
Message-ID: <1344407073-12030-2-git-send-email-hdoyu@nvidia.com>
References: <1344407073-12030-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1344407073-12030-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add __debugfs_create_dir(), which takes data passed from caller.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 fs/debugfs/inode.c      |    7 ++++---
 include/linux/debugfs.h |    9 ++++++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 4733eab..423df9f 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -387,7 +387,7 @@ struct dentry *debugfs_create_file(const char *name, umode_t mode,
 EXPORT_SYMBOL_GPL(debugfs_create_file);
 
 /**
- * debugfs_create_dir - create a directory in the debugfs filesystem
+ * __debugfs_create_dir - create a directory in the debugfs filesystem
  * @name: a pointer to a string containing the name of the directory to
  *        create.
  * @parent: a pointer to the parent dentry for this file.  This should be a
@@ -404,10 +404,11 @@ EXPORT_SYMBOL_GPL(debugfs_create_file);
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
  */
-struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
+struct dentry *__debugfs_create_dir(const char *name, struct dentry *parent,
+				    void *data)
 {
 	return __create_file(name, S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO,
-				   parent, NULL, NULL);
+				   parent, data, NULL);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_dir);
 
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 66c434f..4ba9f0a 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -50,7 +50,14 @@ struct dentry *debugfs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
 
-struct dentry *debugfs_create_dir(const char *name, struct dentry *parent);
+struct dentry *__debugfs_create_dir(const char *name, struct dentry *parent,
+				    void *data);
+
+static inline struct dentry *debugfs_create_dir(const char *name,
+						struct dentry *parent)
+{
+	return __debugfs_create_dir(name, parent, NULL);
+}
 
 struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 				      const char *dest);
-- 
1.7.5.4
