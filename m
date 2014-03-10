From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv3 0/6] Crashdump Accepting Active IOMMU
Date: Mon, 10 Mar 2014 17:43:18 -0400
Message-ID: <20140310214318.GJ4352@redhat.com>
References: <1389391652-52422-1-git-send-email-bill.sumner@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389391652-52422-1-git-send-email-bill.sumner-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bill Sumner <bill.sumner-VXdhtT5mjnY@public.gmane.org>
Cc: bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, zhenhua-VXdhtT5mjnY@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 10, 2014 at 03:07:26PM -0700, Bill Sumner wrote:

[..]
> This patch set modifies the behavior of the iommu in the (new) crashdump kernel: 
> 1. to accept the iommu hardware in an active state, 
> 2. to leave the current translations in-place so that legacy DMA will continue
>    using its current buffers until the device drivers in the crashdump kernel
>    initialize and initialize their devices,
> 3. to use different portions of the iova address ranges for the device drivers
>    in the crashdump kernel than the iova ranges that were in-use at the time
>    of the panic.  

Conceptually, above makes sense to me. I have few queries.

- Do we need to pass any kind of data from first kernel to second kernel, 
  like table size etc? Calgary IOMMU was using first kernel's tables
  also and it was determining previous kernel's table size using saved_max_pfn.

- I don't know how IOMMU translation tables look like, but are new DMA
  zones setup by drivers in second kernel part of same table? How do we
  make sure that sufficient space is available. I am not sure if possible
  table corruption from crashed kernel is an issue here or not.

In general, I think changelogs of these patches need to be little better.
There seem to be lot of text and still I can't quickly wrap my head around
what a particular patch is supposed to be doing.

But we definitely need to fix this issue. IOMMU issues with kdump have
been troubling us for a very long time.

Thanks
Vivek
