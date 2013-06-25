From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 3/9] ARM: dma-mapping: convert DMA direction into IOMMU
	protection attributes
Date: Tue, 25 Jun 2013 13:34:14 +0100
Message-ID: <20130625123414.GG31838@mudshark.cambridge.arm.com>
References: <1370889285-22799-4-git-send-email-will.deacon@arm.com>
	<20130625131215.d3cea2a5668a3d41dbbeb064@nvidia.com>
	<20130625113714.GF31838@mudshark.cambridge.arm.com>
	<20130625.145226.1632119404634300971.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130625.145226.1632119404634300971.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 25, 2013 at 12:52:26PM +0100, Hiroshi Doyu wrote:
> Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote @ Tue, 25 Jun 2013 13:37:14 +0200:
> ...
> > > Do we need similar changes for map_sg case as well? They still passes '0' as prot.
> > 
> > Yes, we could use the same trick there (probably worth moving the logic into
> > a helper function for translating dma_data_direction into IOMMU_* values).
> > 
> > There are also iommu_map calls when allocating DMA buffers, but I think 0 is
> > the right thing to pass there (i.e. no permission until pages have been
> > explicitly mapped). Although, to be honest, I don't see why we need to map
> > the buffer at all when we allocate it.
> 
> Yes, I thought too. I have a patch for that as below. If you like,
> I'll rebase and send for merge with the one which changes
> dma-mapping.c.

Yes, please send the series and I'll take a look. Marek's already picked up
my original patch, so it's better if you can base against a stable branch
from him.

Will
