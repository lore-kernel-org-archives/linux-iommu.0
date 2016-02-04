From: Andreas Hartmann <andihartmann-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org>
Subject: Re: AMD-Vi: Unable to write to IOMMU perf counter.
Date: Thu, 4 Feb 2016 18:53:13 +0100
Message-ID: <56B39009.90401@maya.org>
References: <56B365E0.4020100@01019freenet.de> <56B37292.1000201@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <56B37292.1000201-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 02/04/2016 at 04:47 PM, Suravee Suthikulanit wrote:
> Hi Andreas,
> 
> On 2/4/2016 8:53 AM, Andreas Hartmann wrote:
>> Hello!
>>
>> The following happens with Linux 4.4.1 during boot on an MSI A78M-E35
>> board. Additionally, I attached the complete dmesg.
> 
> I was working on upstreaming changes to the AMD IOMMU Perf to fix some
> of the similar issue I saw on a different platform.  Would you please
> check to see if this patch series would fix this?
> 
> https://lkml.org/lkml/2016/1/1/141


This patchset seems to fix the problem.

[    1.264639] AMD-Vi: IOMMU performance counters supported

But there seems to be a problem with the location of
perf_event_amd_iommu.h in the patch - I had to fix the complete
perf_event_amd_iommu.h related patches to get them applied to 4.4. and
finally compiled.


Thanks,
Andreas
