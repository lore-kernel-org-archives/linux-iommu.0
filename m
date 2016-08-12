From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH 4/8] of: dma: Split of_configure_dma() into mask and ops
	configuration
Date: Fri, 12 Aug 2016 21:15:32 +0530
Message-ID: <000d01d1f4b0$929cdc30$b7d69490$@codeaurora.org>
References: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
	<1470696550-3416-5-git-send-email-sricharan@codeaurora.org>
	<CAAFQd5BkpHrF=2=UXFA2mPKe0VQAD3J_XSNrZYHP0br5hw=Gsw@mail.gmail.com>
	<1651151.fes0RShRSW@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1651151.fes0RShRSW@avalon>
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
To: 'Laurent Pinchart' <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, 'Tomasz Figa' <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: 'Will Deacon' <will.deacon-5wv7dgnIgG8@public.gmane.org>, "'open list:IOMMU DRIVERS'" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

>> > The of_configure_dma() function configures both the DMA masks and ops.
>> > Moving DMA ops configuration to probe time would thus also delay
>> > configuration of the DMA masks, which might not be safe. To avoid issues
>>
>> Do we know any example cases when it might be unsafe? I think we kind
>> of rely on the fact that DMA mapping (and so DMA masks as well) is not
>> used before probing the device anyway, because we let the IOMMU
>> attachment happen at probe time, which essentially makes any earlier
>> attempts to use DMA mapping on such device incorrect.
>
>I don't know of any such situation, but (if I remember correctly) when I
>discussed the IOMMU rework with Arnd Bergman and Will Deacon there was a
>concern that someone, somewhere was relying on the mask being set early.
>
>I personally would like to drop this patch, but it might be difficult to
>ensure this wouldn't cause a regression. There should certainly be no DMA
>mapping created before IOMMU attachment, but the DMA mask could possibly be
>used somewhere else.
>
   Infact i also wanted this to be dropped and to have masks also done along with ops,
   but thought of getting some feedback if its really needed before probe anywhere.

Regards,
 Sricharan
