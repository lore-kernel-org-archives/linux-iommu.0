From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [RFC] drivers: iommu: Use of add_device()/remove_device()
	outside	of IOMMU groups
Date: Thu, 17 Jan 2013 11:54:55 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D328BBD@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1358244652-12728-1-git-send-email-dhobsong@igel.co.jp>
	<1358372869.11144.21.camel@bling.home> <50F76E12.7020607@igel.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <50F76E12.7020607-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>
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
To: Damian Hobson-Garcia <dhobsong-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "hdk-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org" <hdk-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Damian Hobson-Garcia
> Sent: Thursday, January 17, 2013 8:51 AM
> To: Alex Williamson
> Cc: hdk-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
> dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org; laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org
> Subject: Re: [RFC] drivers: iommu: Use of add_device()/remove_device()
> outside of IOMMU groups
> 
> I mistakenly sent this with the tag [PATCH] when it should have been
> [RFC].  Updated with this reply.
> 
> Hi Alex,
> On 2013/01/17 6:47, Alex Williamson wrote:
> > On Tue, 2013-01-15 at 19:10 +0900, Damian Hobson-Garcia wrote:
> >> We've recently been thinking about the best way to attach platform
> >> devices in an IOMMU in a generic way without having to have every
> >> platform device register itself at probe time.  We've seen that at
> >> least on the tegra IOMMU, using the platform_bus notifier seems like
> >> a viable option
> >> (http://lists.linuxfoundation.org/pipermail/iommu/2012-December/00495
> >> 4.html). We also noticed that the IOMMU ops add_device() function is
> called (indirectly) from a similar bus notifier and we're thinking that
> using the bus notifier in the common code would be better than us rolling
> our own to do basically the same thing.
> >>
> >> The problem, however, is that add_device() seems to be intended for
> >> use with IOMMU groups.  i.e. After calling add_device() on a device
> >> that is should be in a group, dev->iommu_group should have some
> meaningful value.
> >> I think though, that if the IOMMU groups requirement can be removed,
> >> it should be more versatile.
> >>
> >> I believe that removing the IOMMU groups dependency can be achieved
> >> with the patch below. Currently the intel-iommu seems to be the only
> >> implementation using these callbacks.
> >
> > What stops you from creating a single iommu_group and adding all
> > device to it?  Thanks,
>  >
>  > Alex
> Thanks for your comment.
> 
> Nothing stops me, but putting everything in one group doesn't really add
> any benefit over not using groups at all, does it?  It seems like its
> just adding more complexity(i.e code) to the driver without adding any
> additional functionality.
> 
Do you intend to use vfio? That's the specific objective of creating iommu groups.

-Varun
