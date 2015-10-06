From: Sudeep Dutt <sudeep.dutt@intel.com>
Subject: Re: [PATCH char-misc-next v2 04/22] iommu: Allow iova to be used
 without requiring IOMMU_SUPPORT
Date: Tue, 06 Oct 2015 05:04:53 -0700
Message-ID: <1444133093.93285.190.camel@localhost>
References: <cover.1443573394.git.ashutosh.dixit@intel.com>
	 <bff58cca8a0f5591e0a39680ff73e8ee34269668.1443573394.git.ashutosh.dixit@intel.com>
	 <1444042224.4674.149.camel@intel.com>
	 <1444066723.93285.146.camel@localhost> <20151006051240.GA23487@kroah.com>
	 <20151006052029.GA7959@kroah.com> <1444109018.93285.176.camel@localhost>
	 <20151006075610.GB18449@kroah.com> <1444118727.93285.187.camel@localhost>
	 <20151006083300.GA21156@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151006083300.GA21156@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: Sudeep Dutt <sudeep.dutt@intel.com>, "Woodhouse, David" <david.woodhouse@intel.com>, "Dixit, Ashutosh" <ashutosh.dixit@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rao, Nikhil" <nikhil.rao@intel.com>, "joro@8bytes.org" <joro@8bytes.org>, "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2015-10-06 at 09:33 +0100, gregkh@linuxfoundation.org wrote:
> On Tue, Oct 06, 2015 at 01:05:27AM -0700, Sudeep Dutt wrote:
> > On Tue, 2015-10-06 at 08:56 +0100, gregkh@linuxfoundation.org wrote:
> > > On Mon, Oct 05, 2015 at 10:23:38PM -0700, Sudeep Dutt wrote:
> > > > On Tue, 2015-10-06 at 06:20 +0100, gregkh@linuxfoundation.org wrote:
> > > > > On Tue, Oct 06, 2015 at 06:12:40AM +0100, gregkh@linuxfoundation.org wrote:
> > > > > > On Mon, Oct 05, 2015 at 10:38:43AM -0700, Sudeep Dutt wrote:
> > > > > > > On Mon, 2015-10-05 at 03:50 -0700, Woodhouse, David wrote:
> > > > > > > > On Tue, 2015-09-29 at 18:09 -0700, Ashutosh Dixit wrote:
> > > > > > > > > From: Sudeep Dutt <sudeep.dutt@intel.com>
> > > > > > > > > 
> > > > > > > > > iova is a library which can be built without IOMMU_SUPPORT
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Sudeep Dutt <sudeep.dutt@intel.com>
> > > > > > > > 
> > > > > > > > The first three of these patches are in 4.3-rc4 already. Apologies for
> > > > > > > > the delay in pushing them out.
> > > > > > > > 
> > > > > > > > This one looks sane enough too, but perhaps in that case we should move
> > > > > > > > the code *out* of drivers/iommu/ and into lib/iova/ ?
> > > > > > > > 
> > > > > > > 
> > > > > > > Yes, moving the code into lib/iova is the correct long term solution. I
> > > > > > > have sent Greg a patch which reverts this commit since it is no longer
> > > > > > > required and will create a merge conflict for him unnecessarily as well
> > > > > > > 0000d3bd-0010
> > > > > > 
> > > > > > I can handle merge issues, that's trivial.  Reverting the patch
> > > > > > shoulnd't really be needed, right?  Let me see what happens when I merge
> > > > > > to see if your patch is necessary...
> > > > > 
> > > > > Ok, I don't think it is needed, the merge was pretty trivial.
> > > > > 
> > > > > Can you test out my char-misc-testing branch right now to see if it's
> > > > > all ok with the merge?  If so, I'll move it all over to the "real" place
> > > > > for it to start showing up in linux-next, i.e. my char-misc-next branch.
> > > > > 
> > > > 
> > > > Hi Greg,
> > > > 
> > > > I think it is best to revert this patch as it is incorrect. The iommu
> > > > folder gets compiled only if IOMMU_SUPPORT is enabled so IOMMU_IOVA
> > > > should indeed be included only when IOMMU_SUPPORT is enabled.
> > > > 
> > > > Sincere apologies for the mess here but I believe it will all get fixed
> > > > up if you accept the revert of 353649e5da I sent across earlier today.
> > > 
> > > Again, look at the merge, I think I already handled this in that manner.
> > > If not, let me know.
> > > 
> > 
> > Hi Greg,
> > 
> > I took a look at your latest char-misc-testing tree and it needs to be
> > fixed up. IOMMU_IOVA should be inside the "if IOMMU_SUPPORT" block
> > instead of above it.
> > 
> > git revert 353649e5da in the char-misc-testing tree will fix everything
> > up or you could also apply the patch I sent earlier today which has the
> > same revert.
> 
> Ok, I've applied your patch, rolled back the merge, and that should be
> good, right?  If so, I'll push this branch out to char-misc-next and
> then merge in 4.3-rc4 just to keep everything up to date.

Yes, it looks good now.

Thanks,
Sudeep Dutt
