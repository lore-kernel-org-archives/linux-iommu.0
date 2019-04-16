From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: [REBASE PATCH v5 8/9] xen/gntdev.c: Convert to use vm_map_pages()
Date: Tue, 16 Apr 2019 17:19:49 +0530
Message-ID: <88e56e82d2db98705c2d842e9c9806c00b366d67.1552921225.git.jrdr.linux__1156.66842773265$1555415334$gmane$org@gmail.com>
References: <cover.1552921225.git.jrdr.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1552921225.git.jrdr.linux@gmail.com>
In-Reply-To: <cover.1552921225.git.jrdr.linux@gmail.com>
References: <cover.1552921225.git.jrdr.linux@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com, kirill.shutemov@linux.intel.com, vbabka@suse.cz, riel@surriel.com, sfr@canb.auug.org.au, rppt@linux.vnet.ibm.com, peterz@infradead.org, linux@armlinux.org.uk, robin.murphy@arm.com, iamjoonsoo.kim@lge.com, treding@nvidia.com, keescook@chromium.org, m.szyprowski@samsung.com, stefanr@s5r6.in-berlin.de, hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie, oleksandr_andrushchenko@epam.com, joro@8bytes.org, pawel@osciak.com, kyungmin.park@samsung.com, mchehab@kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, xen-devel@lists.xen.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Souptick Joarder <jrdr.linux@gmail.com>, linux1394-devel@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Convert to use vm_map_pages() to map range of kernel
memory to user vma.

map->count is passed to vm_map_pages() and internal API
verify map->count against count ( count = vma_pages(vma))
for page array boundary overrun condition.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/xen/gntdev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 5efc5ee..5d64262 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -1084,7 +1084,7 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 	int index = vma->vm_pgoff;
 	int count = vma_pages(vma);
 	struct gntdev_grant_map *map;
-	int i, err = -EINVAL;
+	int err = -EINVAL;
 
 	if ((vma->vm_flags & VM_WRITE) && !(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
@@ -1145,12 +1145,9 @@ static int gntdev_mmap(struct file *flip, struct vm_area_struct *vma)
 		goto out_put_map;
 
 	if (!use_ptemod) {
-		for (i = 0; i < count; i++) {
-			err = vm_insert_page(vma, vma->vm_start + i*PAGE_SIZE,
-				map->pages[i]);
-			if (err)
-				goto out_put_map;
-		}
+		err = vm_map_pages(vma, map->pages, map->count);
+		if (err)
+			goto out_put_map;
 	} else {
 #ifdef CONFIG_X86
 		/*
-- 
1.9.1
