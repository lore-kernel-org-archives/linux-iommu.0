From: JeffyChen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [RESEND PATCH v6 09/14] dt-bindings: iommu/rockchip: Add clock
	property
Date: Tue, 06 Mar 2018 10:32:45 +0800
Message-ID: <5A9DFDCD.7040107@rock-chips.com>
References: <20180301101837.27969-1-jeffy.chen@rock-chips.com>
	<20180301101837.27969-10-jeffy.chen@rock-chips.com>
	<20180306022742.yfx2ond45orzhqiy@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180306022742.yfx2ond45orzhqiy@rob-hp-laptop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jcliang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Rob,

Thanks for your reply.

On 03/06/2018 10:27 AM, Rob Herring wrote:
> On Thu, Mar 01, 2018 at 06:18:32PM +0800, Jeffy Chen wrote:
>> Add clock property, since we are going to control clocks in rockchip
>> iommu driver.
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> ---
>>
>> Changes in v6: None
>
> Really? There was a different number of clocks before.
hmm, right, forgot to modify the change log, sorry...
>
>> Changes in v5: None
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2: None
>>
>>   Documentation/devicetree/bindings/iommu/rockchip,iommu.txt | 7 +++++++
>>   1 file changed, 7 insertions(+)
>
> Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
>
>
