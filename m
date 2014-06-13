From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RESEND PATCH] iommu/intel: Exclude devices using RMRRs from
	IOMMU API domains
Date: Fri, 13 Jun 2014 10:35:17 -0600
Message-ID: <1402677317.3707.26.camel@ul30vt.home>
References: <20140612163402.9108.50209.stgit@bling.home>
	<1402670048.7595.90.camel@i7.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1402670048.7595.90.camel-W2I5cNIroUsVm/YvaOjsyQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, chegu_vinod-VXdhtT5mjnY@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 2014-06-13 at 15:34 +0100, David Woodhouse wrote:
> On Thu, 2014-06-12 at 10:35 -0600, Alex Williamson wrote:
> > The user of the IOMMU API domain expects to have full control of
> > the IOVA space for the domain.  RMRRs are fundamentally incompatible
> > with that idea.  We can neither map the RMRR into the IOMMU API
> > domain, nor can we guarantee that the device won't continue DMA with
> > the area described by the RMRR as part of the new domain.  Therefore
> > we must prevent such devices from being used by the IOMMU API.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > ---
> > 
> > I didn't see any actionable items from the last posting of this, so
> > re-posting unchanged.
> 
> That also wants a Cc:stable, I suppose.
> 
> I note we now have two copies of the 'device has RMRR and we actually
> care' logic, where the latter clause is really just "is it USB".
> 
> Is it worth consolidating that into a macro that's used in both places,
> in case the check does get more complicated? Are other devices going to
> start getting added to the class of "we don't need the RMRRs to persist
> and we *do* want to be able to assign them"... or is that just
> needlessly overcomplicating it at this stage?

v2 sent with a single function used in both places.  I suppose time will
tell if we need to start whitelisting other devices, I'm actually a bit
nervous what vendors will start hiding in USB RMRRs if they know we
handle them differently.  We can always add platform or device specific
quirks when we find out about vendors finding new ways to be creative.
Thanks,

Alex
