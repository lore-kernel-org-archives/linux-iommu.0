From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 00/15] PCI/iommu: Fix DMA alias problems
Date: Sat, 10 May 2014 08:15:09 -0600
Message-ID: <1399731309.17639.167.camel@ul30vt.home>
References: <20140510140814.16061.qmail@ns.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140510140814.16061.qmail-HzZAx2gCgqrSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: George Spelvin <linux-gpGsJRJZ3PBBDgjK7y7TUQ@public.gmane.org>
Cc: bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sat, 2014-05-10 at 10:08 -0400, George Spelvin wrote:
> > What's the device ID of these devices?
> 
> Oops!  It's
> 
> 05:00.0 SATA controller [0106]: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller [1b4b:9172] (rev 11)
> 06:00.0 SATA controller [0106]: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller [1b4b:9172] (rev 11)
> 07:00.0 SATA controller [0106]: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller [1b4b:9172] (rev 11)
> 
> > The dma-alias branch only has the v1 patchset.  There are several more
> > Marvell devices included in the quirks in the v2 set.  Please re-test
> > with this code.  Thanks,
> 
> Oh, okay!  I got the patches from github because it was a lot easier
> to get the whole set that way.  (I don't actually have an SMTP LKML
> subscription, so I have to copy them all from a web archive, then
> manually edit the headers into something RFC822-like enough for "git am"
> to accept.)
> 
> Mea culpa for forgetting to check the version.  And thank you for the response!


Hi George,

I'll post a v3 soon, I think we figured out the problem Andrew was
having, a couple typos on my part.  I'll push out a new branch for that
so you don't need to piece it together yourself.  Thanks,

Alex
