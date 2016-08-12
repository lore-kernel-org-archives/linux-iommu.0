From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH 6/8] drivers: platform: Remove call to
	of_dma_(con/decon)figure_ops
Date: Fri, 12 Aug 2016 21:12:07 +0530
Message-ID: <000b01d1f4b0$180b7300$48225900$@codeaurora.org>
References: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
	<1470696550-3416-7-git-send-email-sricharan@codeaurora.org>
	<CAAFQd5DZ0ZpW2eEm8Bvh8=di6kOgUG4bGY_iTNbVBHsj0KPmeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAFQd5DZ0ZpW2eEm8Bvh8=di6kOgUG4bGY_iTNbVBHsj0KPmeg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: 'Tomasz Figa' <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: 'Will Deacon' <will.deacon-5wv7dgnIgG8@public.gmane.org>, "'open list:IOMMU DRIVERS'" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Laurent Pinchart' <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Tomaz,

>> The dma_ops gets configured for the device generically during
>> the device_attach call. So remove it from the platform bus probe.
>> Similarly remove the deconfigure calls as well, since it is
>> now called form the device_detach path.
>
>Doesn't this patch need to be squashed with previous one to avoid
>breaking things in between by having the of_dma_configure_ops() called
>two times?
>
  okay, i did it this way, for the sake of review. But ya will squash
  it for the next post.

Regards,
 Sricharan
