From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 09/10] iommu/amd: Clear the iommu pre enabled setting
Date: Sat, 10 Oct 2015 20:30:36 +0800
Message-ID: <20151010123036.GC31787@dhcp-16-116.nay.redhat.com>
References: <1443076656-31776-1-git-send-email-bhe@redhat.com>
	<1443076656-31776-10-git-send-email-bhe@redhat.com>
	<20150929160949.GP3036@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150929160949.GP3036-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 09/29/15 at 06:09pm, Joerg Roedel wrote:
> On Thu, Sep 24, 2015 at 02:37:35PM +0800, Baoquan He wrote:
> > @@ -2469,6 +2469,8 @@ static dma_addr_t __map_single(struct device *dev,
> >  	unsigned long align_mask = 0;
> >  	int i;
> >  
> > +	if (translation_pre_enabled())
> > +		clear_translation_pre_enabled();
> 
> There is probably a better place to do this somewhere in the
> initialization state machine of the AMD IOMMU driver.

Yeah, I put it in state_next().

static int __init state_next(void)
{
        int ret = 0;

        switch (init_state) {
        case IOMMU_START_STATE:
	......

	case IOMMU_DMA_OPS:
                if (translation_pre_enabled())
                        clear_translation_pre_enabled();
                init_state = IOMMU_INITIALIZED;
                break;
	......
}

> 
> 
> 	Joerg
> 
