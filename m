From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/1] x86/iommu: use bit structures for context_entry
Date: Fri, 10 Jan 2014 15:32:58 +0800
Message-ID: <52CFA22A.9060609@linux.intel.com>
References: <1387529101-29769-1-git-send-email-zhen-hual@hp.com>
	<20140107144108.GF2742@8bytes.org> <52CFA140.5060700@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <52CFA140.5060700-VXdhtT5mjnY@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Li, ZhenHua" <zhen-hual-VXdhtT5mjnY@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

I have noticed the same issue too. But after second check, seems
it's safe with current implementation, but obviously it's not
future safe.

On 2014/1/10 15:29, Li, ZhenHua wrote:
> I have not seen such a bug yet . but obviously a '=' should be used when
> you want to set a value.
> 
> for example, if x != 0,
>     x=10
> and
>     x|=10
> will cause different result.
> 
> ZhenHua
> 
> On 01/07/2014 10:41 PM, Joerg Roedel wrote:
>> On Fri, Dec 20, 2013 at 04:45:01PM +0800, Li, Zhen-Hua wrote:
>>> There is a structure named context_entry used by intel iommu, and there
>>> are some bit operations on it. Use bit structure may make these
>>> operations
>>> easy.
>>> Also the function context_set_address_root may cause problem because
>>> it uses
>>>   |= operation, not set the new value. And this patch can fix it.
>>
>> What is the problem you are trying to fix here? Is it an actual bug?
>>
>>
>>     Joerg
>>
>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
