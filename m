From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC v2 2/4] iommu/arm-smmu-v3: Add tlbi_on_map option
Date: Fri, 18 Aug 2017 08:50:18 +0200
Message-ID: <703a5dec-d1e6-f9cb-eab2-e4fcf8d20665@redhat.com>
References: <1502459130-6234-1-git-send-email-eric.auger@redhat.com>
	<1502459130-6234-3-git-send-email-eric.auger@redhat.com>
	<20170817163424.GC30719@arm.com>
	<d502e172-5e98-cbbb-6a72-db32c71006fc@redhat.com>
	<20170818055031-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170818055031-mutt-send-email-mst-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Michael S. Tsirkin" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc.Zyngier-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Michael,
On 18/08/2017 04:54, Michael S. Tsirkin wrote:
> On Thu, Aug 17, 2017 at 07:47:04PM +0200, Auger Eric wrote:
>> I will see with Peter and other potential users in the community whether
>> it is worth to pursue the efforts on upstreaming the QEMU vSMMUv3
>> device, considering the VFIO/VHOST integration is made impossible.
> 
> I posted more ideas on finding a way to support it after all separately.
> Even without this:
> 	1. VHOST does not need to be notified on map.
My mistake. I will split the QEMU series accordingly.
> 	2. VFIO might be possible for hardware that supports nested page tables.
> 
> IMHO 2 is worth looking into.
OK That's my next step.

Thank you for your suggestions.

Eric

> 
