From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 3/9] ARM: dma-mapping: convert DMA direction into IOMMU
	protection attributes
Date: Wed, 19 Jun 2013 10:57:48 +0200
Message-ID: <51C1728C.9090205@samsung.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
	<1370889285-22799-4-git-send-email-will.deacon@arm.com>
	<51C16DAF.1090205@samsung.com>
	<20130619085202.GC20351@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20130619085202.GC20351-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello,

On 6/19/2013 10:52 AM, Will Deacon wrote:
> On Wed, Jun 19, 2013 at 09:37:03AM +0100, Marek Szyprowski wrote:
> > Hello,
>
> Hi Marek,
>
> > On 6/10/2013 8:34 PM, Will Deacon wrote:
> > > IOMMU mappings take a prot parameter, identifying the protection bits
> > > to enforce on the newly created mapping (READ or WRITE). The ARM
> > > dma-mapping framework currently just passes 0 as the prot argument,
> > > resulting in faulting mappings.
> > >
> > > This patch infers the protection attributes based on the direction of
> > > the DMA transfer.
> > >
> > > Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > > Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> >
> > Thanks for fixing this issue. Could I take this patch to my dma-mapping tree
> > with other dma-mapping changes I've collected recently or do you want my ack
> > and push it via other tree?
>
> Please, feel free to take it via the dma-mapping tree! That's probably the
> best route for it and there's nothing that really depends on it anyway.

Ok, thank I will put it on my tree. Thanks for your patches!

Best regards
-- 
Marek Szyprowski
Samsung R&D Institute Poland
