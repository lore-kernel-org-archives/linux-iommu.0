From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] dma-debug: Check for drivers mapping vmalloc addresses
Date: Fri, 21 Sep 2018 10:39:53 -0700
Message-ID: <153755159334.119890.13825040401066852769@swboyd.mtv.corp.google.com>
References: <20180920223559.136915-1-swboyd@chromium.org>
 <ef22f1b4-a2c5-25a4-451e-9191b3579a26@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ef22f1b4-a2c5-25a4-451e-9191b3579a26@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Quoting Robin Murphy (2018-09-21 04:09:50)
> Hi Stephen,
> =

> On 20/09/18 23:35, Stephen Boyd wrote:
> > I recently debugged a DMA mapping oops where a driver was trying to map
> > a buffer returned from request_firmware() with dma_map_single(). Memory
> > returned from request_firmware() is mapped into the vmalloc region and
> > this isn't a valid region to map with dma_map_single() per the DMA
> > documentation's "What memory is DMA'able?" section.
> > =

> > Unfortunately, we don't really check that in the DMA debugging code, so
> > enabling DMA debugging doesn't help catch this problem. Let's add a new
> > DMA debug function to check for a vmalloc address and print a warning if
> > this happens. This makes it a little easier to debug these sorts of
> > problems, instead of seeing odd behavior or crashes when drivers attempt
> > to map the vmalloc space for DMA.
> =

> Good idea!
> =

> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >   include/linux/dma-debug.h   |  8 ++++++++
> >   include/linux/dma-mapping.h |  1 +
> >   kernel/dma/debug.c          | 12 ++++++++++++
> >   3 files changed, 21 insertions(+)
> =

> However I can't help thinking this looks a little heavyweight for a =

> single specific check. It seems like it would be enough to simply pass =

> the VA as an extra argument to debug_dma_map_page(), since we already =

> have the map_single argument which would indicate when it's valid. What =

> do you reckon?

I thought about augmenting debug_dma_map_page() but that has another
problem where those checks are done after the page has been mapped. The
kernel can oops when it's operating on the incorrect page so we need to
check things before calling the dma ops.

So I split that check up into pre_map and post_map parts but then that
seemed like overkill just to check for this vmalloc problem. Here's the
patch if you're interested. I can make it a little nicer if you think
it's also worthwhile.

---8<----
 include/linux/dma-debug.h   |  8 ++++++++
 include/linux/dma-mapping.h |  3 +++
 kernel/dma/debug.c          | 24 ++++++++++++++++--------
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/include/linux/dma-debug.h b/include/linux/dma-debug.h
index 5aec2ca8a426..3287240a474c 100644
--- a/include/linux/dma-debug.h
+++ b/include/linux/dma-debug.h
@@ -35,6 +35,9 @@ extern int dma_debug_resize_entries(u32 num_entries);
 extern void debug_dma_check_vmalloc(struct device *dev, const void *addr,
 				    unsigned long len);
 =

+extern void debug_dma_pre_map_page(struct device *dev, struct page *page,
+				   size_t offset, size_t size);
+
 extern void debug_dma_map_page(struct device *dev, struct page *page,
 			       size_t offset, size_t size,
 			       int direction, dma_addr_t dma_addr,
@@ -111,6 +114,11 @@ static inline void debug_dma_check_vmalloc(struct devi=
ce *dev, const void *addr,
 {
 }
 =

+static inline void debug_dma_pre_map_page(struct device *dev, struct page =
*page,
+					  size_t offset, size_t size)
+{
+}
+
 static inline void debug_dma_map_page(struct device *dev, struct page *pag=
e,
 				      size_t offset, size_t size,
 				      int direction, dma_addr_t dma_addr,
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index a0e67fd5433c..4839bbb4fdc7 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -233,6 +233,8 @@ static inline dma_addr_t dma_map_single_attrs(struct de=
vice *dev, void *ptr,
 =

 	BUG_ON(!valid_dma_direction(dir));
 	debug_dma_check_vmalloc(dev, ptr, size);
+	debug_dma_pre_map_page(dev, virt_to_page(ptr),
+			       offset_in_page(ptr), size);
 	addr =3D ops->map_page(dev, virt_to_page(ptr),
 			     offset_in_page(ptr), size,
 			     dir, attrs);
@@ -296,6 +298,7 @@ static inline dma_addr_t dma_map_page_attrs(struct devi=
ce *dev,
 	dma_addr_t addr;
 =

 	BUG_ON(!valid_dma_direction(dir));
+	debug_dma_pre_map_page(dev, page, offset, size);
 	addr =3D ops->map_page(dev, page, offset, size, dir, attrs);
 	debug_dma_map_page(dev, page, offset, size, dir, addr, false);
 =

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 7ee7978868d4..dd1ff9f7d783 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1324,6 +1324,22 @@ void debug_dma_check_vmalloc(struct device *dev, con=
st void *addr,
 }
 EXPORT_SYMBOL(debug_dma_check_vmalloc);
 =

+void debug_dma_pre_map_page(struct device *dev, struct page *page, size_t =
offset,
+			    size_t size)
+{
+	if (unlikely(dma_debug_disabled()))
+		return;
+
+	check_for_stack(dev, page, offset);
+
+	if (!PageHighMem(page)) {
+		void *addr =3D page_address(page) + offset;
+
+		check_for_illegal_area(dev, addr, size);
+	}
+}
+EXPORT_SYMBOL(debug_dma_pre_map_page);
+
 void debug_dma_map_page(struct device *dev, struct page *page, size_t offs=
et,
 			size_t size, int direction, dma_addr_t dma_addr,
 			bool map_single)
@@ -1352,14 +1368,6 @@ void debug_dma_map_page(struct device *dev, struct p=
age *page, size_t offset,
 	if (map_single)
 		entry->type =3D dma_debug_single;
 =

-	check_for_stack(dev, page, offset);
-
-	if (!PageHighMem(page)) {
-		void *addr =3D page_address(page) + offset;
-
-		check_for_illegal_area(dev, addr, size);
-	}
-
 	add_dma_entry(entry);
 }
 EXPORT_SYMBOL(debug_dma_map_page);
-- =

Sent by a computer through tubes
