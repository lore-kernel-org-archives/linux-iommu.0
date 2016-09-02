From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 7/8] iommu: of: Handle IOMMU lookup failure with deferred
	probing or error
Date: Fri, 02 Sep 2016 10:09:55 +0200
Message-ID: <1c5dde1d-1ffb-d045-c090-032b9f1c7de2@samsung.com>
References: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
	<1470696550-3416-8-git-send-email-sricharan@codeaurora.org>
	<CAAFQd5C8BuOCc5ySw_3tVELDG4S+r_5VyDvOPnBBuVr-6CBfxg@mail.gmail.com>
	<000901d1f4af$e26b6c00$a7424400$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <000901d1f4af$e26b6c00$a7424400$@codeaurora.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, 'Tomasz Figa' <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: "'open list:IOMMU DRIVERS'" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, 'Will Deacon' <will.deacon-5wv7dgnIgG8@public.gmane.org>, 'Laurent Pinchart' <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Sricharan,


On 2016-08-12 17:40, Sricharan wrote:
> Hi Tomaz,
>
>>> +               if (ops->add_device)
>>> +                       ops = ops->add_device(dev) ? ops : NULL;
>> Patch description fails to mention anything about this change. Also it
>> looks slightly incorrect to lose the error condition here. I think we
>> should at least print some error message here and tell the user that
>> we are falling back to non-IOMMU setup.
>      Ok, will have to improve the patch description to add this and will
>      fix the error value as well. Will also add the remove_device during
>       deconfigure as well.
>
>>
>>>                  of_node_put(np);
>>>                  idx++;
>>> @@ -200,7 +213,7 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>>>
>>>   err_put_node:
>>>          of_node_put(np);
>>> -       return NULL;
>>> +       return ops;
>>>   }
>>>
>>>   void __init of_iommu_init(void)
>>> @@ -211,7 +224,7 @@ void __init of_iommu_init(void)
>>>          for_each_matching_node_and_match(np, matches, &match) {
>>>                  const of_iommu_init_fn init_fn = match->data;
>>>
>>> -               if (init_fn(np))
>>> +               if (init_fn && init_fn(np))
>> When is it possible to have NULL init_fn?
>     ya wrong, should not be needed.

init_fn can be NULL if you convert IOMMU driver to use platform device
infrastructure based initialization and you don't need to do anything
before the driver gets probed, so please keep this check.

I used this approach here:
https://git.linaro.org/people/marek.szyprowski/linux-srpol.git/commitdiff/a30735973573128b14bb4a25cf4debaa0979a655
(this commit is a part of v4.8-clocks-pm branch)

IOMMU_OF_DECLARE() with NULL init_fn is needed to notify IOMMU core that
this IOMMU driver is available in the system and core has to defer
probing of drivers before the IOMMU driver gets initialized from its
controller's platform device.

>
>>
>>>                          pr_err("Failed to initialise IOMMU %s\n",
>>>                                  of_node_full_name(np));
>>>          }
>>> diff --git a/drivers/of/device.c b/drivers/of/device.c
>>> index e1fad50..92e02dc 100644
>>> --- a/drivers/of/device.c
>>> +++ b/drivers/of/device.c
>>> @@ -149,6 +149,8 @@ int of_dma_configure_ops(struct device *dev, struct device_node *np)
>>>                  coherent ? " " : " not ");
>>>
>>>          iommu = of_iommu_configure(dev, np);
>>> +       if (IS_ERR(iommu))
>>> +               return PTR_ERR(iommu);
>> nit: Would be good to add a blank line here for improved readability.
>     ok, will add.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
