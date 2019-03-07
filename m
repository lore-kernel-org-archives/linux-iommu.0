From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH/RFC] driver core: Postpone DMA tear-down until after
	devres release
Date: Thu, 7 Mar 2019 16:12:57 +0100
Message-ID: <20190307151257.GA25053@kroah.com>
References: <20190207193653.18221-1-geert+renesas@glider.be>
	<20190208164019.GY32526@8bytes.org>
	<fa781547-7fa8-cb1a-50bd-d18351c02afd@arm.com>
	<CAMuHMdV6T8EsLZaiM-=M=fRPuDXt05aXg6egmMBr6Sc9V39iKA@mail.gmail.com>
	<6e64e564-aa6c-4193-1f57-ebf88d6932d5@arm.com>
	<1b24a2dc-e9a3-f293-8dd1-360896a554e6@huawei.com>
	<ebc665cc-31c5-4ecd-6c48-6d14962b1f0c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ebc665cc-31c5-4ecd-6c48-6d14962b1f0c-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, "Rafael J . Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 07, 2019 at 02:52:55PM +0000, Robin Murphy wrote:
> Hi John,
> 
> On 07/03/2019 14:45, John Garry wrote:
> [...]
> > Hi guys,
> > 
> > Any idea what happened to this fix?
> 
> It's been in -next for a while (commit 376991db4b64) - I assume it will land
> shortly and hit stable thereafter, at which point somebody gets to sort out
> the manual backport past 4.20.

It's already in Linus's tree, I'll go try to do the stable backporting
now...

greg k-h
