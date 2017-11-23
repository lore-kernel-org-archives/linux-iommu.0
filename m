From: Eric Yang <yu.yang_3-3arQi8VN3Tc@public.gmane.org>
Subject: RE: No check of the size passed to unmap_single in swiotlb
Date: Thu, 23 Nov 2017 07:47:40 +0000
Message-ID: <VI1PR04MB30718EF84BD5305E67A5582A8C210@VI1PR04MB3071.eurprd04.prod.outlook.com>
References: <VI1PR04MB30715EA7212DC661481041438C220@VI1PR04MB3071.eurprd04.prod.outlook.com>
	<20171120162652.GR24312@char.us.oracle.com>
	<VI1PR04MB3071FBA364C78317F3C3A25D8C200@VI1PR04MB3071.eurprd04.prod.outlook.com>
	<c678cf02-700d-48c0-4160-8ee248a26da5@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <c678cf02-700d-48c0-4160-8ee248a26da5-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: Daniel Borkmann <daniel-FeC+5ew28dpmcu3hnIyYJQ@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Andrey Ryabinin <aryabinin-5HdwGun5lf+gSpxsJD1C4w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org]
> Sent: Wednesday, November 22, 2017 9:15 PM
> To: Eric Yang <yu.yang_3-3arQi8VN3Tc@public.gmane.org>; Konrad Rzeszutek Wilk
> <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> Cc: Daniel Borkmann <daniel-FeC+5ew28dpmcu3hnIyYJQ@public.gmane.org>; Kees Cook
> <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>; Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>;
> Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>; Al Viro
> <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>; Andrey Ryabinin <aryabinin-5HdwGun5lf+gSpxsJD1C4w@public.gmane.org>;
> Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>; Ingo Molnar
> <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Subject: Re: No check of the size passed to unmap_single in swiotlb
> 
> On 22/11/17 03:23, Eric Yang wrote:
> >
> >
> >> -----Original Message-----
> >> From: Konrad Rzeszutek Wilk [mailto:konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org]
> >> Sent: Tuesday, November 21, 2017 12:27 AM
> >> To: Eric Yang <yu.yang_3-3arQi8VN3Tc@public.gmane.org>; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> >> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Greg Kroah-Hartman
> >> <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>; Andrew Morton
> >> <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>; Andrey Ryabinin
> >> <aryabinin-5HdwGun5lf+gSpxsJD1C4w@public.gmane.org>; David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>; Ingo
> >> Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>; Geert Uytterhoeven
> >> <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>; Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>; Kees
> >> Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>; Daniel Borkmann <daniel-FeC+5ew28dpmcu3hnIyYJQ@public.gmane.org>
> >> Subject: Re: No check of the size passed to unmap_single in swiotlb
> >>
> >> On Mon, Nov 20, 2017 at 08:17:14AM +0000, Eric Yang wrote:
> >>> Hi all,
> >>
> >> Hi!
> >
> > Hi  Konrad,
> >>>
> >>> During debug a  device only support 32bits DMA(Qualcomm Atheros AP)
> >>> in our
> >> LS1043A 64bits ARM  SOC, we found that the invoke of dma_unmap_single
> >> --> swiotlb_tbl_unmap_single  will unmap the passed "size" anyway
> >> even when the "size" is incorrect.
> >>>
> >>> If the size is larger than it should, the extra entries in
> >>> io_tlb_orig_addr array
> >> will be refilled by INVALID_PHYS_ADDR, and it will cause the bounce
> >> buffer copy not happen when the one who really used the mis-freed
> >> entries doing  DMA data transfers, and this will cause further unknow
> behaviors.
> >>>
> >>> Here we just fix it temporarily by adding a judge of the "size" in
> >>> the
> >> swiotlb_tbl_unmap_single, if it is larger than it deserves, just
> >> unmap the right size only. Like the code:
> >>
> >> Did the DMA debug API (CONFIG_DMA_API_DEBUG) help in figuring this
> >> issue as well?
> >>
> >
> > I have just enabled this config and move off the kernel fix and test,
> > there seems the debug API has no output for this size incorrect issue.
> > For I only enable the config and no other operations and my kernel is 4.9, do I
> missed something?
> >
> > I confirm that the debug API is working, for there are other drivers
> > triggered its warning output
> > like:
> >
> > caam_jr 1710000.jr: DMA-API: device driver tries to free DMA memory it
> > has not allocated [device address=0x6800458400000000]
> 
> By default, dma-debug will only log the first error it sees - you can adjust this
> with the "num_errors" or "all_errors" sysfs controls, and use the driver filter to
> hide errors from other drivers if necessary.
> 
> Robin.
> 
Hi Robin,

I've caught the size mismatch warning with the debug API, thanks a lot for the help.

Regards,
Eric

> >>>
> >>> [yangyu@titan dash-lts]$ git diff ./lib/swiotlb.c diff --git
> >>> a/lib/swiotlb.c b/lib/swiotlb.c index ad1d2962d129..58c97ede9d78
> >>> 100644
> >>> --- a/lib/swiotlb.c
> >>> +++ b/lib/swiotlb.c
> >>> @@ -591,7 +591,10 @@ void swiotlb_tbl_unmap_single(struct device
> >>> *hwdev,
> >> phys_addr_t tlb_addr,
> >>>                   */
> >>>                  for (i = index + nslots - 1; i >= index; i--) {
> >>>                          io_tlb_list[i] = ++count;
> >>> -                       io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
> >>> +                      if(io_tlb_orig_addr[i]  != orig_addr)
> >>> +                          printk("======size wrong, ally down ally down!===\n");
> >>> +                      else
> >>> +                         io_tlb_orig_addr[i] = INVALID_PHYS_ADDR;
> >>>                  }
> >>>                  /*
> >>>                   * Step 2: merge the returned slots with the
> >>> preceding slots,
> >>>
> >>> Although pass a right size of DMA buffer is the responsibility of
> >>> the drivers, but
> >> Is it useful to add some size check code to prevent  real damage happen?
> >>>
> >>> Regards,
> >>> Eric
> > _______________________________________________
> > iommu mailing list
> > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flis
> >
> ts.linuxfoundation.org%2Fmailman%2Flistinfo%2Fiommu&data=02%7C01%7Cyu.
> >
> yang_3%40nxp.com%7Cf3851e3c8ae24f341b3608d531ab1165%7C686ea1d3bc
> 2b4c6f
> >
> a92cd99c5c301635%7C0%7C0%7C636469533155971955&sdata=7PnqUlgRlJq2H
> sXmTf
> > CmEUuWaBfUhzSd33UoK4li1Ro%3D&reserved=0
> >
