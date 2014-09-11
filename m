From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 0/2] iommu/arm-smmu: hard iova_to_phys
Date: Thu, 11 Sep 2014 11:53:01 -0700
Message-ID: <vnkwmwa6vvjm.fsf@mitchelh-linux.qualcomm.com>
References: <1410460244-18943-1-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1410460244-18943-1-git-send-email-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
	(Mitchel Humpherys's message of "Thu, 11 Sep 2014 11:30:42 -0700")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 11 2014 at 11:30:42 AM, Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> This series introduces support for performing iova-to-phys translations via
> the ARM SMMU hardware on supported implementations. We also make use of
> some new generic macros for polling hardware registers.
>
> The iopoll macros were previously discussed here:
> http://marc.info/?l=linux-arm-kernel&m=140414727509158

Forgot to reference the previous disussion on the iova_to_phys
patch. Here it is:

    http://marc.info/?m=140789123928103

>
>
> Matt Wagantall (1):
>   iopoll: Introduce memory-mapped IO polling macros
>
> Mitchel Humpherys (1):
>   iommu/arm-smmu: add support for iova_to_phys through ATS1PR
>
>  drivers/iommu/arm-smmu.c |  73 +++++++++++++++++++++++++++++-
>  include/linux/iopoll.h   | 114 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 186 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/iopoll.h



-Mitch

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
