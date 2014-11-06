From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/vt-d: Only remove domain when device is removed
Date: Thu, 6 Nov 2014 13:54:05 +0100
Message-ID: <20141106125405.GI8354@suse.de>
References: <1412074923-6342-1-git-send-email-joro@8bytes.org>
	<1412074923-6342-3-git-send-email-joro@8bytes.org>
	<1415117537.27420.428.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415117537.27420.428.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Myron Stowe <mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Alex,

On Tue, Nov 04, 2014 at 09:12:17AM -0700, Alex Williamson wrote:
> I haven't tested it, but I'm concerned whether this has introduced a
> domain leak.  If we think about the case of unbinding a device from a
> host driver and attaching it to a domain through the IOMMU API, I think
> we used to count on this path to call domain_exit(), which made the
> domain_context_mapped() in intel_iommu_attach_device() "unlikely".  With
> this change, isn't the test in intel_iommu_attach_device() now neither
> likely nor unlikely and we're only removing the dev_info from the domain
> and not destroying the domain itself?  Thanks,

As I see it, there is no leak. The DMA-API domains are kept in the
device_domain_list and re-used when the device driver re-attaches. But
your are right that the unlikely in intel_iommu_attach_device() isn't
true anymore. We could probably remove it.


	Joerg
