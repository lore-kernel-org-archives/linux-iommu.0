From: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv3 0/6] Crashdump Accepting Active IOMMU
Date: Tue, 08 Apr 2014 14:42:56 -0400
Message-ID: <53444330.2030606@redhat.com>
References: <1389391652-52422-1-git-send-email-bill.sumner@hp.com>
	<53430DE9.9080303@redhat.com>
	<1396973686.25235.36.camel@i7.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1396973686.25235.36.camel-W2I5cNIroUsVm/YvaOjsyQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, doug.hatch-VXdhtT5mjnY@public.gmane.org, ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, zhenhua-VXdhtT5mjnY@public.gmane.org, Bill Sumner <bill.sumner-VXdhtT5mjnY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 04/08/2014 12:14 PM, David Woodhouse wrote:
> On Mon, 2014-04-07 at 16:43 -0400, Don Dutile wrote:
>>
>> Additionally, a tidbit of information like "some servers force NMI's
>> on DMAR faults,
>> and cause a system reset, thereby, preventing a kdump to occur"
>> should have been included as one reason to stop DMAR faults from
>> occurring on kexec-boot,
>> in addition to the fact that a flood of them can lock up a system.
>
> How about allocating a physical scratch page, and setting up a mapping
> for each device such that *every* virtual address (apart from those
> listed in RMRRs, perhaps) is mapped to that same scratch page?
>
> That way you avoid the faults, but you also avoid stray DMA to parts of
> the system that you don't want to get corrupted.
>
+1... more isolation as second kernel booting sounds good.
