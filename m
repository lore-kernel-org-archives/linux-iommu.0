From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFCv2 PATCH 00/36] Process management for IOMMU + SVM for SMMUv3
Date: Mon, 5 Feb 2018 18:43:58 +0000
Message-ID: <3896a835-7178-2aa3-44dd-80dd98f41b46@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
	<0c6778d8-741f-0db7-fe3c-df88a75ebbb2@huawei.com>
	<0fecd29e-eaf7-9503-b087-7bfbc251da88@arm.com>
	<c6b7fb4b-4f2b-0d81-8bb5-8fa6b62aca3a@huawei.com>
	<8a1e090d-22e8-0295-a53f-bc3b5b7d7971@arm.com>
	<20171012152803.GA3027@jcrouse-lnx.qualcomm.com>
	<8539601d-ef7a-8dd0-2fc7-51240c292678@arm.com>
	<20171025202015.GA6159@jcrouse-lnx.qualcomm.com>
	<20180205181513.GB878@jcrouse-lnx.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180205181513.GB878-9PYrDHPZ2Orvke4nUoYGnHL1okKdlPRT@public.gmane.org>
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
To: "jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: "gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jordan,

On 05/02/18 18:15, Jordan Crouse wrote:
[...]
> Just a gentle nudge to see if there is any progress on this front. I know the
> last 6 months have been busy with other far more serious panics but I wanted to
> offer any help I could provide including testing on various qcom targets.

If everything goes well I should be able to send v1 of this series next
week, and I believe the patches implementing sva_map()/sva_unmap() will
soon follow.

Thanks,
Jean
