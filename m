From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: Can't boot new 4.4 kernel with IOMMU enabled
Date: Mon, 29 Feb 2016 18:42:52 +0100
Message-ID: <20160229174252.GN22747@8bytes.org>
References: <569FCFC8.2000606@compro.net> <20160120182602.GJ18805@8bytes.org>
	<56A0F03C.8010109@compro.net> <56A0F221.10502@compro.net>
	<20160121223958.GL18805@8bytes.org> <56B0CFF7.80907@compro.net>
	<20160216162455.GX18805@8bytes.org> <56C35D1A.9080307@compro.net>
	<20160226162319.GH22747@8bytes.org> <56D0A565.8080406@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56D0A565.8080406-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mark Hounschell <markh-n2QNKt385d+sTnJN9+BGXg@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Mark,

On Fri, Feb 26, 2016 at 02:20:05PM -0500, Mark Hounschell wrote:
> On 02/26/2016 11:23 AM, Joerg Roedel wrote:
> > Can you please boot a v4.5-rc5 kernel with iommu enabled and
> > 'amd_iommu_dump' on the kernel command line and send me dmesg after
> > boot again?
> > 
> > 
> 
> Here ya go Joerg,
>  
> See ata7 and ata8 failure messages. These are the 2 disks that don't come up. They are hanging off one of these two Marvell chips.
> 
> 07:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller (rev 12)
> 13:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller (rev 12)

Thanks for the dmesg. It does not contain IO_PAGE_FAULTs anymore, did it
in the past? If yes, which device-ids were the faults reported against?

I can't really say yet why it does not work on your system. The IOMMU
core groups the devices 00:15.0-2 and 11-13:00.0 together. This means
that they all end up in the same iommu group.

But according to the IVRS ACPI table on your system none of these
devices has an alias defined. So this doesn't explain why the commit
you bisected it down to causes the problem, because the commit is about
alias handling (which the devices in question don't need).

Maybe I send you some debug patches to try out, but I stare at the code
a little bit more first.



	Joerg
