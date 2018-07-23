From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: sync the OVACKFLG to PRIQ consumer
	register
Date: Mon, 23 Jul 2018 15:08:18 +0100
Message-ID: <07622bf1-161e-3cd2-eda5-334601d077d8@arm.com>
References: <1532350618-16486-1-git-send-email-zhangshaokun@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1532350618-16486-1-git-send-email-zhangshaokun-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
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
To: Shaokun Zhang <zhangshaokun-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Miao Zhong <zhongmiao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 23/07/18 13:56, Shaokun Zhang wrote:
> From: Miao Zhong <zhongmiao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
> 
> When PRI queue occurs overflow, driver should update the OVACKFLG to
> the PRIQ consumer register, otherwise subsequent PRI requests will not
> be processed.

Since the upstream driver doesn't enable PRI in endpoints, I'm not sure
this patch makes sense on its own, but it seems correct anyway. I had a
similar patch in my initial SVA RFC, but for some reason dropped it in
later versions (https://patchwork.kernel.org/patch/9594021/)

It's worth noting that the event queue doesn't have the same problem,
because the SMMU can record new events even if the overflow hasn't been
acknowledged.

Thanks,
Jean
