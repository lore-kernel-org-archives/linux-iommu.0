From: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [RFC/PATCH 4/7] iommu: msm: Add MSM IOMMUv1 driver
Date: Wed, 02 Jul 2014 15:32:39 -0700
Message-ID: <53B48887.2010405@codeaurora.org>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
	<1404147116-4598-5-git-send-email-ohaugan@codeaurora.org>
	<20140630170221.GA30740@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140630170221.GA30740-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "vgandhi-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <vgandhi-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 6/30/2014 10:02 AM, Will Deacon wrote:
> Hi Olav,
> 
> On Mon, Jun 30, 2014 at 05:51:53PM +0100, Olav Haugan wrote:
>> MSM IOMMUv1 driver supports Qualcomm SoC MSM8974 and
>> MSM8084.
>>
>> The IOMMU driver supports the following features:
>>
>>     - ARM V7S page table format independent of ARM CPU page table format
>>     - 4K/64K/1M/16M mappings (V7S)
>>     - ATOS used for unit testing of driver
>>     - Sharing of page tables among SMMUs
>>     - Verbose context bank fault reporting
>>     - Verbose global fault reporting
>>     - Support for clocks and GDSC
>>     - map/unmap range
>>     - Domain specific enabling of coherent Hardware Table Walk (HTW)
>>
>> Signed-off-by: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> ---
>>  .../devicetree/bindings/iommu/msm,iommu_v1.txt     |   56 +
>>  drivers/iommu/Kconfig                              |   36 +
>>  drivers/iommu/Makefile                             |    2 +
>>  drivers/iommu/msm_iommu-v1.c                       | 1448 +++++++++++++
>>  drivers/iommu/msm_iommu.c                          |  149 ++
>>  drivers/iommu/msm_iommu_dev-v1.c                   |  340 +++
>>  drivers/iommu/msm_iommu_hw-v1.h                    | 2236 ++++++++++++++++++++
>>  drivers/iommu/msm_iommu_pagetable.c                |  600 ++++++
>>  drivers/iommu/msm_iommu_pagetable.h                |   33 +
>>  drivers/iommu/msm_iommu_priv.h                     |   55 +
>>  include/linux/qcom_iommu.h                         |  221 ++
>>  11 files changed, 5176 insertions(+)
> 
> This patch is *huge*! It may get bounced from some lists (I think the
> linux-arm-kernel lists has a ~100k limit), so it might be worth trying to do
> this incrementally.

Yes, I noticed. Sorry about that.

> That said, a quick glance at your code indicates that this IOMMU is
> compliant with the ARM SMMU architecture, and we already have a driver for
> that. Please can you rework this series to build on top of the code in
> mainline already, rather than simply duplicating it? We need fewer IOMMU
> drivers, not more!

Ok, I will rework.

Thanks,

Olav Haugan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
