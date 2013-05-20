From: Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/2 V3] perf/x86/amd: IOMMU Performance Counter Support
Date: Mon, 20 May 2013 10:41:29 -0500
Message-ID: <519A4429.30405@amd.com>
References: <1368819813-6481-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1368819813-6481-1-git-send-email-suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.p.zijlstra-/NLkJaSkS4VmR6Xm/wNWPw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Peter,

Please let me know if you have any questions/concerns regarding the PMU 
implementation.

Joerg,
Please let me know if you have any questions/concerns regarding the 
changes in the IOMMU driver.

Thank you,

Suravee

On 5/17/2013 2:43 PM, suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
>
> These patches implement the AMD IOMMU Performance Counter functionality
> via custom perf PMU and implement static counting for various IOMMU
> translations.
>
>      1) Extend the AMD IOMMU initialization to include performance
>         counter enablement.
>
>      2) The perf AMD IOMMU PMU to manage performance counters, which
>         interface with the AMD IOMMU core driver.
>
> Steven L Kinney (1):
>    perf/x86/amd: Adding IOMMU PC resource management
>
> Suravee Suthikulpanit (1):
>    perf/x86/amd: AMD IOMMU PC PERF uncore PMU implementation
>
>   arch/x86/kernel/cpu/Makefile               |    2 +-
>   arch/x86/kernel/cpu/perf_event_amd_iommu.c |  500 ++++++++++++++++++++++++++++
>   arch/x86/kernel/cpu/perf_event_amd_iommu.h |   40 +++
>   drivers/iommu/amd_iommu_init.c             |  121 ++++++-
>   drivers/iommu/amd_iommu_proto.h            |    7 +
>   drivers/iommu/amd_iommu_types.h            |   12 +-
>   6 files changed, 675 insertions(+), 7 deletions(-)
>   create mode 100644 arch/x86/kernel/cpu/perf_event_amd_iommu.c
>   create mode 100644 arch/x86/kernel/cpu/perf_event_amd_iommu.h
>
