From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 1/4] iommu/shmobile: Add iommu driver for Renesas
	IPMMU modules
Date: Thu, 10 Jan 2013 19:32:37 +0100
Message-ID: <20130110183236.GG25591@8bytes.org>
References: <1356434355-3279-1-git-send-email-hdk@igel.co.jp>
	<1356434355-3279-2-git-send-email-hdk@igel.co.jp>
	<1586668.MmWlG9A4gq@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1586668.MmWlG9A4gq@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Katsuya MATSUBARA <matsu-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>, Hideki EIRAKU <hdk-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Damian Hobson-Garcia <dhobsong-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On Mon, Jan 07, 2013 at 07:11:58PM +0100, Laurent Pinchart wrote:
> > +		l2index = (iova >> 12) & 0xff;
> > +		spin_lock(&sh_domain->map_lock);
> > +		ret = l2alloc(sh_domain, l1index);
> 
> l2alloc calls dma_pool_alloc(GFP_KERNEL), that not safe in a non-sleepable 
> context. Do we need a spinlock here, or could a mutex do ?

iommu_map should work in any context, so a mutex will not work. Also the
memory allocations in that path should be GFP_ATOMIC instead of
GFP_KERNEL.

Other than that this driver looks good from an IOMMU-API perspective.
Please Cc me on future versions of this patch-set directly.

Thanks,

	Joerg
