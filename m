From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 4/9] ARM: dma-mapping: NULLify dev->archdata.mapping
	pointer on detach
Date: Wed, 19 Jun 2013 10:59:33 +0200
Message-ID: <51C172F5.8040500@samsung.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
	<1370889285-22799-5-git-send-email-will.deacon@arm.com>
	<20130611.083455.1500863288897785600.hdoyu@nvidia.com>
	<20130611085015.GC24729@mudshark.cambridge.arm.com>
	<20130611123933.4d278ff4e056f395788ad060@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20130611123933.4d278ff4e056f395788ad060-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello,

On 6/11/2013 11:39 AM, Hiroshi Doyu wrote:
> On Tue, 11 Jun 2013 10:50:15 +0200
> Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>
> > On Tue, Jun 11, 2013 at 06:34:55AM +0100, Hiroshi Doyu wrote:
> > > Hi Will,
> > >
> > > Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote @ Mon, 10 Jun 2013 20:34:40 +0200:
> > >
> > > > The current code only clobbers a local variable, so the device is left
> > > > with a stale mapping pointer.
> > >
> > > True. This's my bad. Thanks.
> >
> > That's alright, it's easy to fix. Mind if I add your ack please?
>
> Feel free to add: Acked-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Thanks for spotting the bug. I've taked the patch to my dma-mapping tree.

Best regards
-- 
Marek Szyprowski
Samsung R&D Institute Poland
