From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH V3 0/5] iommu/arm-smmu: Add runtime pm/sleep support
Date: Tue, 4 Apr 2017 12:39:14 -0700
Message-ID: <20170404193914.GF18246@codeaurora.org>
References: <1489073748-3659-1-git-send-email-sricharan@codeaurora.org>
	<20170331175457.GD4897@arm.com>
	<CAF6AEGv_1pNvhCc-mVP5S28Yt5kTJmTRfe8tKSJpEmxfOKM7Jg@mail.gmail.com>
	<20170403172307.GI5706@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170403172307.GI5706-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mathieu Poirier <mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 04/03, Will Deacon wrote:
> On Fri, Mar 31, 2017 at 10:58:16PM -0400, Rob Clark wrote:
> > On Fri, Mar 31, 2017 at 1:54 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > > On Thu, Mar 09, 2017 at 09:05:43PM +0530, Sricharan R wrote:
> > >> This series provides the support for turning on the arm-smmu's
> > >> clocks/power domains using runtime pm. This is done using the
> > >> recently introduced device links patches, which lets the symmu's
> > >> runtime to follow the master's runtime pm, so the smmu remains
> > >> powered only when the masters use it.
> > >
> > > Do you have any numbers for the power savings you achieve with this?
> > > How often do we actually manage to stop the SMMU clocks on an SoC with
> > > a handful of masters?
> > >
> > > In other words, is this too coarse-grained to be useful, or is it common
> > > that all the devices upstream of the SMMU are suspended?
> > 
> > well, if you think about a phone/tablet with a command mode panel,
> > pretty much all devices will be suspended most of the time ;-)
> 
> Well, that's really what I was asking about. I assumed that periodic
> modem/radio transactions would keep the SMMU clocked, so would like to get a
> rough idea of the power savings achieved with this coarse-grained approach.

Sometimes we distribute SMMUs to each IP block in the system and
let each one of those live in their own clock + power domain. In
these cases, the SMMU can be powered down along with the only IP
block that uses it. Furthermore, sometimes we put the IP block
and the SMMU inside the same power domain to really tie the two
together, so we definitely have cases where all devices (device?)
upstream of the SMMU are suspended. And in the case of
multimedia, it could be very often that something like the camera
app isn't open and thus the SMMU dedicated for the camera can be
powered down.

Other times we have two SMMUs in the system where one is
dedicated to GPU and the other is "everything else". Even in
these cases, we can suspend the GPU one when the GPU is inactive
because it's the only consumer. The other SMMU might not be as
fine grained, but I think we still power it down quite often
because the consumers are mostly multimedia devices that aren't
active when the display is off.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
