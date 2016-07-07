From: Wei Yongjun <weiyj_lk@163.com>
Subject: Re: [PATCH -next v2] iommu/exynos: Fix return value check in
 exynos_iommu_of_setup()
Date: Thu, 7 Jul 2016 20:09:38 +0800
Message-ID: <fe43720e-52ff-72c9-36a7-0d3410e6d86d@163.com>
References: <1467807354-26503-1-git-send-email-weiyj_lk@163.com>
 <1467860372-6940-1-git-send-email-weiyj_lk@163.com>
 <577E2442.4000002@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <577E2442.4000002@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene@kernel.org>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 07/07/2016 05:43 PM, Krzysztof Kozlowski wrote:
> On 07/07/2016 04:59 AM, weiyj_lk@163.com wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> In case of error, the function of_platform_device_create() returns
>> NULL pointer not ERR_PTR(). The IS_ERR() test in the return value
>> check should be replaced with NULL test.
>>
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> ---
>> v1 -> v2: chenge the error code to -ENODEV
>> ---
>>   drivers/iommu/exynos-iommu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
> Why you didn't include mine and Dennis reviews? Why you ignored my
> comments - you don't agree with them?
>
Sorry, I missed your last mail. I will change patch as your advise.

Regards,
Yongjun Wei
