From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: source-id verification failures
Date: Fri, 5 Oct 2018 11:43:38 -0700
Message-ID: <20181005114338.234e39ee@jacob-builder>
References: <20181002172529.fjapu46h5y57m3f7@cantor>
	<20181004090753.GC3630@8bytes.org>
	<20181004205724.4kqntecb6m7gcgu6@cantor>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181004205724.4kqntecb6m7gcgu6@cantor>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jerry Snitselaar <jsnitsel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 4 Oct 2018 13:57:24 -0700
Jerry Snitselaar <jsnitsel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> >
> >On Tue, Oct 02, 2018 at 10:25:29AM -0700, Jerry Snitselaar wrote:  
> >> I've been trying to track down a problem where an hp dl380 gen8
> >> with a Cavium QLogic BR-1860 Fabric Adapter is getting source-id
> >> verification failures when running dhclient against that
> >> interface. This started showing up when I backported the iova
> >> deferred flushing patches. So far this has only been seen on this
> >> one system, but I'm trying to understand why it appears with the
> >> new deferred flushing code. I also see it with both 4.18.10, and
> >> 4.19.0-rc6 kernels.
> >>
Hi Jerry,
Could you confirm that you see this failure in v4.19-rc6 kernel only
without "strict" mode? I don't see a connection between deferred
flushing and IR here, AFAIK deferred flush only affects DMA remapping.

Also, does the SID failure occur on other devices under the same IOMMU?


Thanks,

Jacob
