From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 3/4] iommu/iova: Extend rbtree node caching
Date: Tue, 19 Sep 2017 11:07:05 +0100
Message-ID: <d9945e6a-b605-a531-cefb-6ba13bd45f1f@arm.com>
References: <cover.1500636791.git.robin.murphy@arm.com>
	<b5b7e5541e47cba1112ef5bfb036d8ad44df8893.1500636791.git.robin.murphy@arm.com>
	<23972edc-e59e-3a43-59a9-d776e64af4d7@codeaurora.org>
	<e5d4524e-bfe9-acf1-66c1-ea1d9d319855@arm.com>
	<59C0E694.6080508@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <59C0E694.6080508-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 19/09/17 10:42, Leizhen (ThunderTown) wrote:
[...]
>>>>     static void
>>>>   __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova
>>>> *free)
>>>>   {
>>>>       struct iova *cached_iova;
>>>> -    struct rb_node *curr;
>>>> +    struct rb_node **curr = NULL;
>>>>   -    if (!iovad->cached32_node)
>>>> -        return;
>>>> -    curr = iovad->cached32_node;
>>>> -    cached_iova = rb_entry(curr, struct iova, node);
> 
> -----------------------------
>>>> +    if (free->pfn_hi < iovad->dma_32bit_pfn)
>>>> +        curr = &iovad->cached32_node;
>>>> +    if (!curr)
>>>> +        curr = &iovad->cached_node;
>>
>> +	if (!*curr)
>> +		return;
> Is it necessary for us to try the following adjustment?
> +	if (free->pfn_hi < iovad->dma_32bit_pfn)
> +		curr = &iovad->cached32_node;
> +	else
> +		curr = &iovad->cached_node;
> +
> +	if (!*curr) {
> +		*curr = rb_next(&free->node);
> +		return;
> +	}

Yeah, I spotted that this looked a bit wonky after I posted it. It's
already cleaned up in v3, which I'll be posting shortly after I write up
some cover letters.

Thanks,
Robin.
