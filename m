From: Libo Chen <clbchenlibo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] msm: iommu: fix leak and invalid access
Date: Tue, 28 May 2013 20:37:47 +0800
Message-ID: <51A4A51B.1050206@huawei.com>
References: <51931347.7020600@huawei.com> <519C5E8F.7060006@huawei.com>
	<20130528122754.GD2575@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20130528122754.GD2575-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org, joerg.roedel-5C7GfCeVMHo@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2013/5/28 20:27, Joerg Roedel wrote:
> On Wed, May 22, 2013 at 01:58:39PM +0800, Libo Chen wrote:
>>>
>>> This patch merge two patch that I sended before:
>>> 1. msm: iommu: add missing platform_device_unregister() in err case
>>> 2. msm: iommu: no need kfree before kzalloc successful
>>>
>>> It fixes two obvious problems:
>>> 1. We have registered msm_iommu_driver first, and need unregister it when
>>> registered msm_iommu_ctx_driver fail
>>>
>>> 2. We don`t need to kfree drvdata before kzalloc successful
>>>
>>> Signed-off-by: Libo Chen <libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
>>> ---
>>>  drivers/iommu/msm_iommu_dev.c |   11 +++++------
>>>  1 files changed, 5 insertions(+), 6 deletions(-)
> 
> Has this patch already been handled? If not please resend it to me and I
> will take care of it.
> 
> 

It should be included to -mm tree by Andrew Morton


Regards,

Libo

> 	Joerg
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> .
> 
