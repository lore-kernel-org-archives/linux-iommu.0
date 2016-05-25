From: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: reduce extra first level entry in
	iommu->domains
Date: Wed, 25 May 2016 21:43:59 +0000
Message-ID: <20160525214359.GA4132@vultr.guest>
References: <1463798511-4015-1-git-send-email-richard.weiyang@gmail.com>
	<20160524230655.GA28550@vultr.guest> <57457BCD.7080909@arm.com>
Reply-To: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57457BCD.7080909-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, May 25, 2016 at 11:17:49AM +0100, Robin Murphy wrote:
>On 25/05/16 00:06, Wei Yang wrote:
>>Hi, Joerg
>>
>>Not sure whether you think this calculation is correct.
>>
>>If I missed something for this " + 1" in your formula, I am glad to hear your
>>explanation. So that I could learn something from you :-)
>
>I'm not familiar enough with this aspect of the driver to confirm whether the
>change is appropriate or not, but it does seem worth noting that using
>DIV_ROUND_UP would be an even neater approach.
>

Hi, Robin,

Thanks for your comment.

Yes, I agree DIV_ROUND_UP would make the code more easy to read.

I have thought about using DIV_ROUND_UP, while from the definition
DIV_ROUND_UP use operation "/", and ALIGN use bit operation. So the change in
my patch chooses the second one and tries to keep the efficiency.

>Robin.
>
>>Have a good day~
>>
>>On Sat, May 21, 2016 at 02:41:51AM +0000, Wei Yang wrote:
>>>In commit <8bf478163e69> ("iommu/vt-d: Split up iommu->domains array"), it
>>>it splits iommu->domains in two levels. Each first level contains 256
>>>entries of second level. In case of the ndomains is exact a multiple of
>>>256, it would have one more extra first level entry for current
>>>implementation.
>>>
>>>This patch refines this calculation to reduce the extra first level entry.
>>>
>>>Signed-off-by: Wei Yang <richard.weiyang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>---
>>>drivers/iommu/intel-iommu.c |    4 ++--
>>>1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>>diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>>>index e3061d3..2204ca4 100644
>>>--- a/drivers/iommu/intel-iommu.c
>>>+++ b/drivers/iommu/intel-iommu.c
>>>@@ -1634,7 +1634,7 @@ static int iommu_init_domains(struct intel_iommu *iommu)
>>>		return -ENOMEM;
>>>	}
>>>
>>>-	size = ((ndomains >> 8) + 1) * sizeof(struct dmar_domain **);
>>>+	size = (ALIGN(ndomains, 256) >> 8) * sizeof(struct dmar_domain **);
>>>	iommu->domains = kzalloc(size, GFP_KERNEL);
>>>
>>>	if (iommu->domains) {
>>>@@ -1699,7 +1699,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
>>>static void free_dmar_iommu(struct intel_iommu *iommu)
>>>{
>>>	if ((iommu->domains) && (iommu->domain_ids)) {
>>>-		int elems = (cap_ndoms(iommu->cap) >> 8) + 1;
>>>+		int elems = ALIGN(cap_ndoms(iommu->cap), 256) >> 8;
>>>		int i;
>>>
>>>		for (i = 0; i < elems; i++)
>>>--
>>>1.7.9.5
>>

-- 
Wei Yang
Help you, Help me
