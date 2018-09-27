From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu: rockchip: Drop verbose prints in the interrupt
	handler
Date: Thu, 27 Sep 2018 09:10:23 +0100
Message-ID: <03cdadf4-14e7-8643-81f6-cd2e7d2f3e88@arm.com>
References: <20180830222832.16766-1-ezequiel@collabora.com>
	<20180925112930.u5kftmo3vhmdxji4@8bytes.org>
	<ea4d539ecbaf229bef8c0810c6a11cf824339b4b.camel@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <ea4d539ecbaf229bef8c0810c6a11cf824339b4b.camel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ezequiel Garcia <ezequiel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, enric.balletbo-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org, kernel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 26/09/18 18:31, Ezequiel Garcia wrote:
> On Tue, 2018-09-25 at 13:29 +0200, Joerg Roedel wrote:
>> On Thu, Aug 30, 2018 at 07:28:32PM -0300, Ezequiel Garcia wrote:
>>> Printing verbosely via WARN macros and friends in interrupt handlers
>>> is strongly discouraged. Drop them and use proper ratelimited
>>> prints.
>>>
>>> Signed-off-by: Ezequiel Garcia <ezequiel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
>>> ---
>>>   drivers/iommu/rockchip-iommu.c | 10 ++++++----
>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> This doesn't apply cleanly to v4.19-rc5, can you please base the patch
>> on that tag, add the Reviewed-by and re-send?
>>
> 
> Well, after looking at the latest code, now I'm wondering why Marc
> changed the WARN_ON with a WARN_ON_ONCE, instead of a less verbose
> ratelimited print.

WARN_ONCE does it exactly once. A rate-limited printk will still spit as 
many messages as you want.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
