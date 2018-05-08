From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v5 1/2] iommu - Enable debugfs exposure of IOMMU driver
 internals
Date: Tue, 08 May 2018 11:48:03 -0700
Message-ID: <e671945494d54cdcf65c6d2af9f9f69d65fb2583.camel@perches.com>
References: <152572332370.3235.16541462864315443906.stgit@sosxen2.amd.com>
         <201805080700.Jm8moLQz%fengguang.wu@intel.com>
         <a9600652-f087-5d8f-ff0b-80200d570591@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a9600652-f087-5d8f-ff0b-80200d570591@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Hook, Gary" <ghook@amd.com>, kbuild test robot <lkp@intel.com>, Gary R Hook <gary.hook@amd.com>
Cc: kbuild-all@01.org, iommu@lists.linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 2018-05-08 at 12:08 -0500, Hook, Gary wrote:
> On 5/7/2018 6:47 PM, kbuild test robot wrote:
> > Hi Gary,
> > 
> 
> I imagine these questions have been asked before, so I'll ask for
> forgiveness up front.
> 
> 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on iommu/next]
> > [also build test ERROR on v4.17-rc4 next-20180507]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Gary-R-Hook/iommu-Enable-debugfs-exposure-of-IOMMU-driver-internals/20180508-062918
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
> > config: x86_64-randconfig-x016-201818 (attached as .config)
> > compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> > reproduce:
> >          # save the attached .config to linux build tree
> >          make ARCH=x86_64
> 
> Is the gcc 7 compiler now a requirement to build the kernel? Or only to 
> run krobot tests?
> 
> Is this the earliest version of the compiler that can be used? I'm still 
> using 4.8 and 5.4, which seems to suffice for the kernel.
> 
> Googling about this has been fruitless.
> 
> > 
> > All error/warnings (new ones prefixed by >>):
> > 
> >     In file included from include/linux/intel-iommu.h:32:0,
> >                      from drivers/gpu/drm/i915/i915_drv.h:41,
> >                      from drivers/gpu/drm/i915/i915_oa_bxt.c:31:
> >     include/linux/iommu.h: In function 'iommu_debugfs_new_driver_dir':
> > > > include/linux/iommu.h:706:8: error: parameter name omitted
> > 
> >      struct dentry *iommu_debugfs_new_driver_dir(char *) {};
> >             ^~~~~~
> >     In file included from include/linux/intel-iommu.h:32:0,
> >                      from drivers/gpu/drm/i915/i915_drv.h:41,
> >                      from drivers/gpu/drm/i915/i915_oa_bxt.c:31:
> > > > include/linux/iommu.h:706:8: warning: control reaches end of non-void function [-Wreturn-type]
> > 
> >      struct dentry *iommu_debugfs_new_driver_dir(char *) {};
> >             ^~~~~~
> > 
> > vim +706 include/linux/iommu.h
> > 
> >     700	
> >     701	#ifdef CONFIG_IOMMU_DEBUGFS
> >     702	void iommu_debugfs_setup(void);
> >     703	struct dentry *iommu_debugfs_new_driver_dir(char *);
> >     704	#else
> >     705	static inline void iommu_debugfs_setup(void) {}
> >   > 706	struct dentry *iommu_debugfs_new_driver_dir(char *) {};
> >     707	#endif
> >     708	
> 
> I have no problems with adding parameter names. But 
> scripts/checkpatch.pl doesn't seem to check for this, nor require it. 
> Should checkpatch be updated?

I'm pretty sure that's not feasible.

And when the compiler tells you you've stuffed up some
syntactical bit, why should checkpatch duplicate the
output error message too?

btw:  That's an unnecessary ; at the end of that non-void
function and it should probably be something like:

static inline struct dentry *iommu_debugfs_new_driver_dir(char *dir)
{
	return NULL;
}
