From: "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH char-misc-next v2 04/22] iommu: Allow iova to be used
	without requiring IOMMU_SUPPORT
Date: Tue, 6 Oct 2015 06:12:40 +0100
Message-ID: <20151006051240.GA23487@kroah.com>
References: <cover.1443573394.git.ashutosh.dixit@intel.com>
	<bff58cca8a0f5591e0a39680ff73e8ee34269668.1443573394.git.ashutosh.dixit@intel.com>
	<1444042224.4674.149.camel@intel.com>
	<1444066723.93285.146.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444066723.93285.146.camel@localhost>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sudeep Dutt <sudeep.dutt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Woodhouse, David" <david.woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Dixit, Ashutosh" <ashutosh.dixit-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Rao, Nikhil" <nikhil.rao-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 05, 2015 at 10:38:43AM -0700, Sudeep Dutt wrote:
> On Mon, 2015-10-05 at 03:50 -0700, Woodhouse, David wrote:
> > On Tue, 2015-09-29 at 18:09 -0700, Ashutosh Dixit wrote:
> > > From: Sudeep Dutt <sudeep.dutt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > > 
> > > iova is a library which can be built without IOMMU_SUPPORT
> > > 
> > > Signed-off-by: Sudeep Dutt <sudeep.dutt-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > 
> > The first three of these patches are in 4.3-rc4 already. Apologies for
> > the delay in pushing them out.
> > 
> > This one looks sane enough too, but perhaps in that case we should move
> > the code *out* of drivers/iommu/ and into lib/iova/ ?
> > 
> 
> Yes, moving the code into lib/iova is the correct long term solution. I
> have sent Greg a patch which reverts this commit since it is no longer
> required and will create a merge conflict for him unnecessarily as well
> with 4.3-rc4.

I can handle merge issues, that's trivial.  Reverting the patch
shoulnd't really be needed, right?  Let me see what happens when I merge
to see if your patch is necessary...
