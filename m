From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH V3 6/8] arm: dma-mapping: Reset the device's dma_ops
Date: Thu, 27 Oct 2016 09:07:23 +0530
Message-ID: <004c01d23003$7230ed90$5692c8b0$@codeaurora.org>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
	<1475600632-21289-7-git-send-email-sricharan@codeaurora.org>
	<a3d4533f-165d-f444-7681-141479617a18@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <a3d4533f-165d-f444-7681-141479617a18-5wv7dgnIgG8@public.gmane.org>
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
To: 'Robin Murphy' <robin.murphy-5wv7dgnIgG8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

>-----Original Message-----
>From: Robin Murphy [mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org]
>Sent: Wednesday, October 26, 2016 8:37 PM
>To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>; will.deacon-5wv7dgnIgG8@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-arm-
>kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org; m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org;
>tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org; srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
>Subject: Re: [PATCH V3 6/8] arm: dma-mapping: Reset the device's dma_ops
>
>On 04/10/16 18:03, Sricharan R wrote:
>> The dma_ops for the device is not getting set to NULL in
>> arch_tear_down_dma_ops and this causes an issue when the
>> device's probe gets deferred and retried. So reset the
>> dma_ops to NULL.
>
>Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>

 Thanks.

>This seems like it could stand independently from the rest of the series
>- might be worth rewording the commit message to more general terms,
>i.e. arch_teardown_dma_ops() being the inverse of arch_setup_dma_ops()
>thus clearing the ops set by the latter, and sending it to Russell as a
>fix in its own right.

  Ok, will reword the commit log and push this separately.

Regards,
 Sricharan
