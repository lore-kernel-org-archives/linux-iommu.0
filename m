From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 6/6] documentation/iommu: Update description of ARM
	System MMU binding
Date: Thu, 31 Oct 2013 16:02:36 +0000
Message-ID: <20131031160236.GB30623@mudshark.cambridge.arm.com>
References: <1382127195-15261-1-git-send-email-andreas.herrmann@calxeda.com>
	<1382127195-15261-7-git-send-email-andreas.herrmann@calxeda.com>
	<20131031011715.GF28613@mudshark.cambridge.arm.com>
	<CAL_JsqKV4r9eYMT4NazmGJTEGtwg+XuvTE3rH3pEL_h7nyvb-w@mail.gmail.com>
	<20131031091657.GT10330@alberich>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131031091657.GT10330@alberich>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andreas Herrmann <andreas.herrmann-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 31, 2013 at 09:16:57AM +0000, Andreas Herrmann wrote:
> On Thu, Oct 31, 2013 at 02:45:55AM -0400, Rob Herring wrote:
> > On Wed, Oct 30, 2013 at 8:17 PM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > > Why are you using the "arm" vendor prefix for the secure config access
> > > stuff? Wouldn't it make more sense to use "calxeda", just in case somebody
> > > else finds a different way to wire things up in this regard?
> 
> I think in an early version I've used calxeda prefix but later thought
> it has to match the arm prefix. I'm also fine with
> calxeda,smmu-secure-config-access. But in case someone else screws
> this up in a similar way and needs the same driver behaviour it's odd
> if XYZ has to use the calxeda prefix instead of the arm prefix for
> this option.
> 
> > I think that the property prefix should match the compatible vendor
> > prefix. You could then argue that the compatible string itself should
> > be prefixed with "calxeda". In that case, this property would not be
> > needed at all as you could just key off the compatible string to
> > determine this characteristic. Of the options, my preference would be
> > just to leave things as is.
> 
> I think Will's main point is that Calxeda has a bug in the wiring and
> that this is not ARM's fault. Renaming the prefix will kind of
> emphasize this. In case we keep the arm prefix, how about modifying
> the description for the option to state that currently only Calxeda
> ECX-2000 screwed up the wiring?

There's also the potential for another SoC vendor to screw up the wiring in
a different way,so having the soc vendor as a prefix makes it easy to
distinguish the different cases (as opposed to a list of
arm,random-screw-up-N properties).

Will
