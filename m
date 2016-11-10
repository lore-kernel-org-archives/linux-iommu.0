From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC v2 8/8] iommu/arm-smmu: implement add_reserved_regions
	callback
Date: Thu, 10 Nov 2016 17:16:19 +0100
Message-ID: <20161110161619.GK2078@8bytes.org>
References: <1478258646-3117-1-git-send-email-eric.auger@redhat.com>
	<1478258646-3117-9-git-send-email-eric.auger@redhat.com>
	<20161110154606.GH2078@8bytes.org>
	<b347ddbc-5066-641c-8101-289fb28624a3@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b347ddbc-5066-641c-8101-289fb28624a3-5wv7dgnIgG8@public.gmane.org>
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
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Nov 10, 2016 at 04:07:08PM +0000, Robin Murphy wrote:
> On 10/11/16 15:46, Joerg Roedel wrote:
> > On Fri, Nov 04, 2016 at 11:24:06AM +0000, Eric Auger wrote:
> >> +	resource_list_for_each_entry(window, &bridge->windows) {
> >> +		if (resource_type(window->res) != IORESOURCE_MEM &&
> >> +		    resource_type(window->res) != IORESOURCE_IO)
> >> +			continue;
> > 
> > Why do you care about IO resources?
> 
> [since this is essentially code I wrote]
> 
> Because they occupy some area of the PCI address space, therefore I
> assumed that, like memory windows, they would be treated as P2P. Is that
> not the case?

No, not at all. The IO-space is completly seperate from the MEM-space.
They are two different address-spaces, addressing different things. And
the IO-space is also not translated by any IOMMU I am aware of.


	Joerg
