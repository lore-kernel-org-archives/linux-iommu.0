From: Archit Taneja <architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [RESEND PATCH 0/4] iommu: add qcom_iommu for early "B" family
	devices
Date: Fri, 14 Jul 2017 14:08:43 +0530
Message-ID: <45ec13f3-12c9-ea61-ece5-0bdc64ffd8a5@codeaurora.org>
References: <20170713120747.20490-1-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170713120747.20490-1-robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 07/13/2017 05:37 PM, Rob Clark wrote:
> An iommu driver for Qualcomm "B" family devices which do implement the
> ARM SMMU spec, but not in a way that arm-smmu can support.
> 
> (I initially added support to arm-smmu, but it was decided that approach
> was too intrusive and it would be cleaner to have a separate driver.)
> 
> I should note that all the dependencies for this driver have been merged
> since 4.12, and it is the last thing needed for having another fully-
> enabled (gpu/display/video codec/etc) ARM device that is fully upstream.

fwiw:

Tested-by: Archit Taneja <architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

> 
> Rob Clark (3):
>    Docs: dt: document qcom iommu bindings
>    iommu: arm-smmu: split out register defines
>    iommu: add qcom_iommu
> 
> Stanimir Varbanov (1):
>    iommu: qcom: initialize secure page table
> 
>   .../devicetree/bindings/iommu/qcom,iommu.txt       | 121 +++
>   drivers/iommu/Kconfig                              |  10 +
>   drivers/iommu/Makefile                             |   1 +
>   drivers/iommu/arm-smmu-regs.h                      | 227 +++++
>   drivers/iommu/arm-smmu.c                           | 203 +----
>   drivers/iommu/qcom_iommu.c                         | 932 +++++++++++++++++++++
>   6 files changed, 1292 insertions(+), 202 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu.txt
>   create mode 100644 drivers/iommu/arm-smmu-regs.h
>   create mode 100644 drivers/iommu/qcom_iommu.c
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
