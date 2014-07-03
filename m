From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 0/3] iommu: Expose IOMMU information in sysfs
Date: Thu, 3 Jul 2014 17:43:26 +0000
Message-ID: <092459cf6aa04425bae1bd19b746f0fc@BL2PR03MB468.namprd03.prod.outlook.com>
References: <20140612215954.2754.30263.stgit@bling.home>
	<20140616151619.GA31771@8bytes.org>
	<1402932269.3707.35.camel@ul30vt.home>
	<1404403726.1862.78.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1404403726.1862.78.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Alex,
This is on my todo list. I have a requirement for adding sysfs support for PAMU.

Regards
Varun
> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> Sent: Thursday, July 03, 2014 9:39 PM
> To: Joerg Roedel
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Sethi Varun-B16395
> Subject: Re: [PATCH 0/3] iommu: Expose IOMMU information in sysfs
> 
> On Mon, 2014-06-16 at 09:24 -0600, Alex Williamson wrote:
> > On Mon, 2014-06-16 at 17:16 +0200, Joerg Roedel wrote:
> > > On Thu, Jun 12, 2014 at 04:12:18PM -0600, Alex Williamson wrote:
> > > > Alex Williamson (3):
> > > >       iommu: Add sysfs support for IOMMUs
> > > >       iommu/intel: Make use of IOMMU sysfs support
> > > >       iommu/amd: Add sysfs support
> > >
> > > I like the general approach. But why do you only enable the x86
> iommus?
> > > Some ARM IOMMUs and PAMU would certainly also benefit from a sysfs
> > > representation of which device is translated by which IOMMU.
> >
> > Only because I have no ability to test the others platforms.  I'd be
> > thrilled if someone working on those IOMMUs could validate this on
> > non-x86.  Thanks,
> 
> Should I re-send this series or are you hoping I'll attempt to piece
> together a non-x86 user for which I have no hardware and can't test?
> Varun, do you have any interest in this for the fsl iommu to try a proof
> of concept?  Thanks,
> 
> Alex
