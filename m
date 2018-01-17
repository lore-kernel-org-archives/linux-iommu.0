From: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2 05/13] iommu/rockchip: Fix error handling in init
Date: Wed, 17 Jan 2018 20:44:56 +0800
Message-ID: <5A5F4548.9090309@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com>
	<20180116132540.18939-6-jeffy.chen@rock-chips.com>
	<CAAFQd5AFHheE+5Dx=0=BeL2W1EYd=Kmcb8fKcCBFRgP8ViuxgQ@mail.gmail.com>
	<e227cf1e-f00a-5cdb-487c-bf0046f3acbb@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <e227cf1e-f00a-5cdb-487c-bf0046f3acbb-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, list-Y9sIeH5OGRo@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ricky Liang <jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, IOMMU DRIVERS <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, open-Y9sIeH5OGRo@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

Thanks for your reply.

On 01/17/2018 07:36 PM, Robin Murphy wrote:
> On 17/01/18 05:26, Tomasz Figa wrote:
>> On Tue, Jan 16, 2018 at 10:25 PM, Jeffy Chen
>> <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>>> It's hard to undo bus_set_iommu() in the error path, so move it to the
>>> end of rk_iommu_probe().
>>
>> Does this work fine now? I remember we used to need this called in an
>> early initcall for all the ARM/ARM64 DMA stuff to work.
>
> It will do once we get to patch #11 (where the IOMMU_OF_DECLARE ensures
> that masters defer until iommu_register() has set ops with a non-NULL
> .of_xlate callback); in the meantime you might end up depending on DT
> probe order as to whether the master uses the IOMMU or not. I'd say it's
> up to you guys whether you consider that a bisection-breaker or not.
>
hmmm, maybe i can just place this patch after the patch #11 ;)
> Robin.
>
>
>
