From: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: amd-iommu: can't boot with amdgpu, AMD-Vi: Completion-Wait loop
	timed out
Date: Tue, 21 Mar 2017 16:57:25 +0100
Message-ID: <20170321155725.GD29659@8bytes.org>
References: <CAD8Lp457TE1CnJ-DHnB6NB2LWxgA5K5K57Q6L7XcSHeYNpvARQ@mail.gmail.com>
	<CY4PR12MB16533C83151D6FCFC11ED457F7250@CY4PR12MB1653.namprd12.prod.outlook.com>
	<CAD8Lp47zjJvqxY3TMMAhjz3OnLR52CtsQh_PQFPmsEW-xHfDwg@mail.gmail.com>
	<CADnq5_Oyfm-BzU9YV_QLjm6HxtMwnJcFkfYtjmCWpuah35TFvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CADnq5_Oyfm-BzU9YV_QLjm6HxtMwnJcFkfYtjmCWpuah35TFvA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Chris Chiu <chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, "Nath, Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Linux Upstreaming Team <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 17, 2017 at 11:53:09AM -0400, Alex Deucher wrote:
> On Fri, Mar 17, 2017 at 8:15 AM, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org> wrote:
> > Hi,
> >
> > On Mon, Mar 13, 2017 at 2:01 PM, Deucher, Alexander
> > <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org> wrote:
> >> > We are unable to boot Acer Aspire E5-553G (AMD FX-9800P RADEON R7) nor
> >> > Acer Aspire E5-523 with standard configurations because during boot
> >> > the screen is flooded with the following error message over and over:
> >> >
> >> >   AMD-Vi: Completion-Wait loop timed out
> >>
> >> We ran into similar issues and bisected it to commit b1516a14657acf81a587e9a6e733a881625eee53.  I'm not too familiar with the IOMMU hardware to know if this is an iommu or display driver issue yet.
> >
> > We can confirm that reverting this commit solves the issue.
> >
> > Given that that commit is an optimization, but it has introduced a
> > regression on multiple platforms, and has been like this for 8 months,
> > it would be common practice to now revert this patch upstream until
> > the regression is fixed. Could you please send a new patch to do this?
> >
> > Also, we would be happy to test any real solutions to this issue while
> > we still have the affected units in hand.
> 
> No objections to a revert here.

Big objection here. Since this only happens with amdgpu so far we
shouldn't rule out a display-driver issue.

Reverting that patch basically destroys iommu-performance on AMD
systems. Doing this for all devices just to make amdgpu working is
overkill at this stage of the debugging.



	Joerg
