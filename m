From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3 0/6] Crashdump Accepting Active IOMMU
Date: Tue, 4 Mar 2014 16:06:17 +0100
Message-ID: <20140304150611.GE2799@8bytes.org>
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
Cc: bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, zhenhua-VXdhtT5mjnY@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Bill,

On Fri, Jan 10, 2014 at 03:07:26PM -0700, Bill Sumner wrote:
> Bill Sumner (6):
>   Crashdump-Accepting-Active-IOMMU-Flags-and-Prototype
>   Crashdump-Accepting-Active-IOMMU-Utility-functions
>   Crashdump-Accepting-Active-IOMMU-Domain-Interfaces
>   Crashdump-Accepting-Active-IOMMU-Copy-Translations
>   Crashdump-Accepting-Active-IOMMU-Debug-Print-IOMMU
>   Crashdump-Accepting-Active-IOMMU-Call-From-Mainline
> 
>  drivers/iommu/intel-iommu.c | 1293 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 1225 insertions(+), 68 deletions(-)

This is a pretty big change, before merging I would like to get more
eyes on it. Please make sure you get more reviews on the code and the
general concept. A few things I noticed while looking at it:

* You put a lot of code into #define CONFIG_CRASH_DUMP. Isn't the same
  approach necessary to for KEXEC?

* Please get rid of all the pr_debug stuff.

* I think it makes sense to put the functions to access the IOMMU
  configuration values of the old kernel into a new file. This is better
  than adding over 1000 new lines to intel-iommu.c

* I have seen your new single-patch for this change. A single patch with
  more than 1200 changed lines is not something anyone is willing to
  review. Please split the patches again in a meaningful and bisectable
  way.


Thanks,

	Joerg
