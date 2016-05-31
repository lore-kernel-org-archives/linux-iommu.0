From: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFT v3] drm: use late_initcall() for amdkfd and radeon
Date: Tue, 31 May 2016 19:15:55 +0200
Message-ID: <20160531171555.GH11948@wotan.suse.de>
References: <20160527004642.GQ11948@wotan.suse.de>
	<1464311916-10065-1-git-send-email-mcgrof@kernel.org>
	<CAFCwf12kzUharmGfLch1OgdngLk6=YoaTb9rJ65hG+y9p5Nvjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAFCwf12kzUharmGfLch1OgdngLk6=YoaTb9rJ65hG+y9p5Nvjg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, May 29, 2016 at 05:49:17PM +0300, Oded Gabbay wrote:
> On Fri, May 27, 2016 at 4:18 AM, Luis R. Rodriguez <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> > diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> > index b55aa740171f..1fa1b7f3a89c 100644
> > --- a/drivers/gpu/drm/radeon/radeon_drv.c
> > +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> > @@ -609,7 +609,7 @@ static void __exit radeon_exit(void)
> >         radeon_unregister_atpx_handler();
> >  }
> >
> > -module_init(radeon_init);
> > +late_initcall(radeon_init);
> >  module_exit(radeon_exit);
> 
> Need to modify also amdgpu module_init

Thanks, so other than considering the first two hunks are only for testing purposes
(a proper [PATCH] will drop these hunks on the Makefile), you're suggestng this
then, is that right?:

---
 drivers/Makefile                        | 6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_module.c | 2 +-
 drivers/gpu/drm/radeon/radeon_drv.c     | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 0b6f3d60193d..0fbe3982041f 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -50,10 +50,7 @@ obj-$(CONFIG_RESET_CONTROLLER)	+= reset/
 obj-y				+= tty/
 obj-y				+= char/
 
-# iommu/ comes before gpu as gpu are using iommu controllers
-obj-$(CONFIG_IOMMU_SUPPORT)	+= iommu/
-
-# gpu/ comes after char for AGP vs DRM startup and after iommu
+# gpu/ comes after char for AGP vs DRM startup
 obj-y				+= gpu/
 
 obj-$(CONFIG_CONNECTOR)		+= connector/
@@ -147,6 +144,7 @@ obj-y				+= clk/
 
 obj-$(CONFIG_MAILBOX)		+= mailbox/
 obj-$(CONFIG_HWSPINLOCK)	+= hwspinlock/
+obj-$(CONFIG_IOMMU_SUPPORT)	+= iommu/
 obj-$(CONFIG_REMOTEPROC)	+= remoteproc/
 obj-$(CONFIG_RPMSG)		+= rpmsg/
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1dab5f2b725b..1ca448f2b4d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -589,7 +589,7 @@ static void __exit amdgpu_exit(void)
 	amdgpu_sync_fini();
 }
 
-module_init(amdgpu_init);
+late_initcall(amdgpu_init);
 module_exit(amdgpu_exit);
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
index 850a5623661f..3d1dab8a31c7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
@@ -141,7 +141,7 @@ static void __exit kfd_module_exit(void)
 	dev_info(kfd_device, "Removed module\n");
 }
 
-module_init(kfd_module_init);
+late_initcall(kfd_module_init);
 module_exit(kfd_module_exit);
 
 MODULE_AUTHOR(KFD_DRIVER_AUTHOR);
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index b55aa740171f..1fa1b7f3a89c 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -609,7 +609,7 @@ static void __exit radeon_exit(void)
 	radeon_unregister_atpx_handler();
 }
 
-module_init(radeon_init);
+late_initcall(radeon_init);
 module_exit(radeon_exit);
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
-- 
2.8.2


> I tested this on Kaveri, and amdkfd is working. For amdkfd that's
> fine, but IMO that's not enough testing for radeon/amdgpu. I would
> like to hear AMD's developers take on this.

Sure. Hopefully the above extensions suffice. In the future we should be able
to also replace the radeon amdkfd -EPROBE_DEFER kludge and the implicit
sensitivity in Makefiles over GPU drivers and IOMMUs, but a bit more work is
needed before that happens.

  Luis
