From: Suravee Suthikulpanit <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH V4 0/6] perf/amd/iommu: Enable multi-IOMMU support
Date: Tue, 23 Feb 2016 18:27:42 +0700
Message-ID: <56CC422E.7050905@amd.com>
References: <1455182127-17551-1-git-send-email-Suravee.Suthikulpanit@amd.com>
	<20160223110406.GA22747@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160223110406.GA22747-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acme-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andihartmann-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 02/23/2016 06:04 PM, Joerg Roedel wrote:
> Hi Suravee,
>
> On Thu, Feb 11, 2016 at 04:15:21PM +0700, Suthikulpanit, Suravee wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
>>
>> This patch series modifies the existing perf_event_amd_iommu driver
>> to support systems with multiple IOMMUs. It introduces new AMD IOMMU APIs,
>> which are used by the AMD IOMMU Perf driver to access performance
>> counters in multiple IOMMUs.
>>
>> In addition, this series should also fix current AMD IOMMU PMU driver
>> initialization issue in some existing KV and CZ platform, where it fails
>> to write to IOMMU perf counter as reported by Andreas Hartmann here
>> (http://comments.gmane.org/gmane.linux.kernel.pci/49147).
>
> Since that problem also affects older kernels, we need a stand-alone
> fix for this initialization issue. We can't backport new features to fix
> bugs in old kernels.
>
>
> 	Joerg
>

OK, I am spliting V5 into two part. First would be just to fix the 
issue. Then the second part would be to add the multiple IOMMU support.

Suravee
