From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH] iommu/arm-smmu: Fix bug in ARM_SMMU_FEAT_TRANS_OPS
	condition check
Date: Thu, 25 Jun 2015 12:29:18 +0530
Message-ID: <000601d0af14$78105f50$68311df0$@codeaurora.org>
References: <1435061246-14690-1-git-send-email-sricharan@codeaurora.org>
	<CAN9JPjGw+abvTX9mCb0M1K5AaxCHzVNx+ccf+iyDo34EL8KzRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAN9JPjGw+abvTX9mCb0M1K5AaxCHzVNx+ccf+iyDo34EL8KzRA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Baptiste Reynal' <b.reynal-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Linux IOMMU' <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Will Deacon' <will.deacon-5wv7dgnIgG8@public.gmane.org>, 'open list' <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'moderated list:ARM SMMU DRIVER'" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-
> bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org] On Behalf Of Baptiste Reynal
> Sent: Tuesday, June 23, 2015 5:43 PM
> To: Sricharan R
> Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Linux IOMMU; Will Deacon; open list;
> moderated list:ARM SMMU DRIVER
> Subject: Re: [PATCH] iommu/arm-smmu: Fix bug in
> ARM_SMMU_FEAT_TRANS_OPS condition check
> 
> This issue has already been fixed here :
> http://www.spinics.net/lists/arm-kernel/msg424824.html
> 
 Ok, thanks for pointing.

Regards,
 Sricharan
