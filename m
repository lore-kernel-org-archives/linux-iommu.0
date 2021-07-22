Return-Path: <SRS0=8SnF=MO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0009BC4338F
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 21:59:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 464B260EB5
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 21:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 464B260EB5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wantstofly.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11F88608F8;
	Thu, 22 Jul 2021 21:59:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mB9mVKjdPyIU; Thu, 22 Jul 2021 21:59:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B93A66070A;
	Thu, 22 Jul 2021 21:59:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85132C0010;
	Thu, 22 Jul 2021 21:59:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7596C000E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 21:59:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE5FE82C7D
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 21:59:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fFwDXkk6F1Pk for <iommu@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 21:59:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 632D982835
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 21:59:16 +0000 (UTC)
Received: by mail.wantstofly.org (Postfix, from userid 1000)
 id 4001F7F46A; Fri, 23 Jul 2021 00:59:12 +0300 (EEST)
Date: Fri, 23 Jul 2021 00:59:12 +0300
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH,RFC] iommu/amd: Use report_iommu_fault()
Message-ID: <YPnqMFAbUFPD9Tfc@wantstofly.org>
References: <YPVL41ZO8Ih8WrKa@wantstofly.org>
 <b6550702-3926-c12b-bbbe-8d96cd677dcc@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b6550702-3926-c12b-bbbe-8d96cd677dcc@amd.com>
Cc: iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Jul 22, 2021 at 02:26:08PM -0500, Suthikulpanit, Suravee wrote:

> Lennert,

Hi Suravee,


> > This patch makes iommu/amd call report_iommu_fault() when an I/O page
> > fault occurs, which has two effects:
> > 
> > 1) It allows device drivers to register a callback to be notified of
> >     I/O page faults, via the iommu_set_fault_handler() API.
> > 
> > 2) It triggers the io_page_fault tracepoint in report_iommu_fault()
> >     when an I/O page fault occurs.
> > 
> > I'm mainly interested in (2).  We have a daemon with some rasdaemon-like
> > functionality for handling platform errors, and being able to be notified
> > of I/O page faults for initiating corrective action is very useful -- and
> > receiving such events via event tracing is a lot nicer than having to
> > scrape them from kmsg.
> 
> Interesting. Just curious what types of error handling are done here?

For example, this daemon annotates PCI errors with the symbolic name of
the PCI device (including line card and ASIC number) that caused the
fault, which is useful when there are dozens of identical ASICs in a
system, and when hotplug makes it so that the offending PCI device might
not be in the system anymore by the time someone gets around to looking
at the fault, or a different line card may have been inserted in its place.


> > A number of other IOMMU drivers already use report_iommu_fault(), and
> > I/O page faults on those IOMMUs therefore already seem to trigger this
> > tracepoint -- but this isn't (yet) the case for AMD-Vi and Intel DMAR.
> > 
> > I copied the logic from the other callers of report_iommu_fault(), where
> > if that function returns zero, the driver will have handled the fault,
> > in which case we avoid logging information about the fault to the printk
> > buffer from the IOMMU driver.
> > 
> > With this patch I see io_page_fault event tracing entries as expected:
> > 
> >     irq/24-AMD-Vi-48    [002] ....   978.554289: io_page_fault: IOMMU:[drvname] 0000:05:00.0 iova=0x0000000091482640 flags=0x0000
> >     irq/24-AMD-Vi-48    [002] ....   978.554294: io_page_fault: IOMMU:[drvname] 0000:05:00.0 iova=0x0000000091482650 flags=0x0000
> >     irq/24-AMD-Vi-48    [002] ....   978.554299: io_page_fault: IOMMU:[drvname] 0000:05:00.0 iova=0x0000000091482660 flags=0x0000
> >     irq/24-AMD-Vi-48    [002] ....   978.554305: io_page_fault: IOMMU:[drvname] 0000:05:00.0 iova=0x0000000091482670 flags=0x0000
> >     irq/24-AMD-Vi-48    [002] ....   978.554310: io_page_fault: IOMMU:[drvname] 0000:05:00.0 iova=0x0000000091482680 flags=0x0000
> >     irq/24-AMD-Vi-48    [002] ....   978.554315: io_page_fault: IOMMU:[drvname] 0000:05:00.0 iova=0x00000000914826a0 flags=0x0000
> > 
> > For determining IOMMU_FAULT_{READ,WRITE}, I followed the AMD IOMMU
> > spec, but I haven't tested that bit of the code, as the page faults I
> > encounter are all to non-present (!EVENT_FLAG_PR) mappings, in which
> > case EVENT_FLAG_RW doesn't make sense.
> 
> Since, IO_PAGE_FAULT event is used to communicate various types of
> fault events, why don't we just pass the flags as-is? This way, it can
> be used to report/trace various types of IO_PAGE_FAULT events (e.g.
> for I/O page table, interrupt remapping, and etc).
> 
> Interested parties can register domain fault handler, and it can takes
> care of parsing information of the flag as needed.
> 
> > Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
> > ---
> >   drivers/iommu/amd/amd_iommu_types.h |    4 ++++
> >   drivers/iommu/amd/iommu.c           |   25 +++++++++++++++++++++++++
> >   2 files changed, 29 insertions(+)
> > 
> > diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> > index 94c1a7a9876d..2f2c6630c24c 100644
> > --- a/drivers/iommu/amd/amd_iommu_types.h
> > +++ b/drivers/iommu/amd/amd_iommu_types.h
> > @@ -138,6 +138,10 @@
> >   #define EVENT_DOMID_MASK_HI	0xf0000
> >   #define EVENT_FLAGS_MASK	0xfff
> >   #define EVENT_FLAGS_SHIFT	0x10
> > +#define EVENT_FLAG_TR		0x100
> > +#define EVENT_FLAG_RW		0x020
> > +#define EVENT_FLAG_PR		0x010
> > +#define EVENT_FLAG_I		0x008
> >   /* feature control bits */
> >   #define CONTROL_IOMMU_EN        0x00ULL
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index 811a49a95d04..a02ace7ee794 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -480,6 +480,30 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
> >   	if (pdev)
> >   		dev_data = dev_iommu_priv_get(&pdev->dev);
> > +	if (dev_data) {
> > +		int report_flags;
> > +
> > +		/*
> > +		 * AMD I/O Virtualization Technology (IOMMU) Specification,
> > +		 * revision 3.00, section 2.5.3 ("IO_PAGE_FAULT Event") says
> > +		 * that the RW ("read-write") bit is only valid if the I/O
> > +		 * page fault was caused by a memory transaction request
> > +		 * referencing a page that was marked present.
> > +		 */
> > +		report_flags = 0;
> > +		if ((flags & (EVENT_FLAG_TR | EVENT_FLAG_PR | EVENT_FLAG_I)) ==
> > +								EVENT_FLAG_PR) {
> 
> Let's not do this check ....
> 
> > +			if (flags & EVENT_FLAG_RW)
> > +				report_flags |= IOMMU_FAULT_WRITE;
> > +			else
> > +				report_flags |= IOMMU_FAULT_READ;
> 
> ... and then we don't need to translate the EVENT_FLAG_XX to IOMMU_FAULT_XXX flags.
> 
> > +		}
> > +
> > +		if (!report_iommu_fault(&dev_data->domain->domain,
> > +					&pdev->dev, address, report_flags))
> 
> Let's just pass the "flags" here.

report_iommu_fault() is used by ten or so different IOMMU drivers, and
they all pass in either IOMMU_FAULT_READ or IOMMU_FAULT_WRITE for the
'flags' argument.  If we're going to pass platform-specific information
in this field, then in-kernel users of the domain fault handler would
have to make their interpretation of 'flags' conditional on the currently
running platform.

Also, since report_iommu_fault() invokes the (platform-independent)
trace_io_page_fault() tracepoint, this is more or less kernel ABI.

(We also have Intel-based platforms, and I also have a patch for
iommu/vt-d to wire up report_iommu_fault(), also using
IOMMU_FAULT_{READ,WRITE}, but that patch is a bit more involved, since
report_iommu_fault() wants a struct device * and dmar uses unthreaded
IRQs which precludes the use of pci_get_domain_bus_and_slot() from the
fault handler.)

If we want to report AMD-specific fault information, perhaps we need
an AMD-specific tracepoint here (in addition to the platform-independent
one?)?  Or extend the report_iommu_fault() flags field with some
platform-independent flags, and then map some of the AMD-specific
fault flags of interest to those platform-independent flags.


Thanks,
Lennert
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
