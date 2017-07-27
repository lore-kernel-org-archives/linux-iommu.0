From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH v8 10/13] iommu/amd: Allocate memory below 4G for dev
	table if translation pre-enabled
Date: Thu, 27 Jul 2017 17:55:50 +0200
Message-ID: <20170727155550.GO3610@suse.de>
References: <1500627551-12930-1-git-send-email-bhe@redhat.com>
	<1500627551-12930-11-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1500627551-12930-11-git-send-email-bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 21, 2017 at 04:59:08PM +0800, Baoquan He wrote:
> AMD pointed out it's unsafe to update the device-table while iommu
> is enabled. It turns out that device-table pointer update is split
> up into two 32bit writes in the IOMMU hardware. So updating it while
> the IOMMU is enabled could have some nasty side effects.
> 
> The only way to work around this is to allocate the device-table below
> 4GB if translation is pre-enabled in kdump kernel. If allocation failed,
> still use the old one.

Not only for the kdump kernel. The old device table must also be below
4GB so that its pointer can be updated with a 32bit write.

If the old table is above 4GB you still need the second write to zero
the upper parts of the pointer in hardware.
