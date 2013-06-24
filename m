From: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 0/3] iommu/amd: IOMMU Error Reporting/Handling/Filtering
Date: Mon, 24 Jun 2013 09:41:17 +0200
Message-ID: <20130624074117.GA26766@pd.tnic>
References: <1369250155-12226-1-git-send-email-suravee.suthikulpanit@amd.com>
	<20130621151459.GK11309@8bytes.org>
	<20130621155933.GA24385@pd.tnic>
	<20130621162455.GN11309@8bytes.org>
	<20130621173625.GH22006@pd.tnic>
	<20130624072648.GQ11309@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130624072648.GQ11309-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jun 24, 2013 at 09:26:48AM +0200, Joerg Roedel wrote:
> On Fri, Jun 21, 2013 at 07:36:25PM +0200, Borislav Petkov wrote:
> 
> > IOW, what specific functionality in EDAC are you actually thinking of?
> 
> Okay, my believe until yesterday was that EDAC provides a consistent way
> to report hardware errors to userspace. That seems to be wrong. This in
> mind I think having a trace-point for that makes sense.
> 
> But this trace-point must not be specific to a single IOMMU driver, I
> want it generic enough so that it can be used by all common IOMMU
> drivers to report hardware misbehaviors to userspace.

Yep, either that or you define a TRACE_EVENT_CLASS which contains common
error info which all iommu drivers report, and those which want to
report more specific information pertaining only to them, then they need
to define a tracepoint based on the iommu event class.

Check the sources for examples.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
