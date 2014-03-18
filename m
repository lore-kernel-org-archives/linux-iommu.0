From: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v11 15/27] iommu/exynos: use convenient macro to handle
	gate clocks
Date: Tue, 18 Mar 2014 14:07:51 +0100
Message-ID: <53284527.8010903@samsung.com>
References: <20140314140951.3d443a3096e80297c9fecef0@samsung.com>
	<5323078E.4060903@samsung.com>
	<CAK9yfHx_=Os1G46nNO1HDA3tigkRNeHKN1KGCvuN=w7dRTkfjg@mail.gmail.com>
	<20140318200329.cc1dca7541b4b1916e5d9d48@samsung.com>
	<CAK9yfHxcArgmxm4wSipY1afjmG00zugyycdU+BQbuexvL2bmBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <CAK9yfHxcArgmxm4wSipY1afjmG00zugyycdU+BQbuexvL2bmBw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Linux DeviceTree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 18.03.2014 12:18, Sachin Kamat wrote:
> On 18 March 2014 16:33, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>> On Fri, 14 Mar 2014 22:27:59 +0530, Sachin Kamat wrote:
>>>   Hi KyongHo,
>>>
>>> On 14 March 2014 19:13, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>>>> Hi KyongHo,
>>>>
>>>>
>>>> On 14.03.2014 06:09, Cho KyongHo wrote:
>>>>>
>>>>> exynos-iommu driver must care about master H/W's gate clock as well as
>>>>> System MMU's gate clock. To enhance readability of the source code,
>>>>> macros to gate/ungate those clocks are defined.
>>>>>
>>>>> Signed-off-by: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>>>> ---
>>>>>    drivers/iommu/exynos-iommu.c |   34 ++++++++++++++++++++++------------
>>>>>    1 file changed, 22 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
>>>>> index 71e77f1..cef62d0 100644
>>>>> --- a/drivers/iommu/exynos-iommu.c
>>>>> +++ b/drivers/iommu/exynos-iommu.c
>>>>> @@ -101,6 +101,16 @@
>>>>>    #define REG_PB1_SADDR         0x054
>>>>>    #define REG_PB1_EADDR         0x058
>>>>>
>>>>> +#define __clk_gate_ctrl(data, clk, en) do {            \
>>>>> +               if (data->clk)                          \
>>>>> +                       clk_##en##able(data->clk);      \
>>>>> +       } while (0)
>>>>> +
>>>>> +#define __sysmmu_clk_enable(data)      __clk_gate_ctrl(data, clk, en)
>>>>> +#define __sysmmu_clk_disable(data)     __clk_gate_ctrl(data, clk, dis)
>>>>> +#define __master_clk_enable(data)      __clk_gate_ctrl(data, clk_master,
>>>>> en)
>>>>> +#define __master_clk_disable(data)     __clk_gate_ctrl(data, clk_master,
>>>>> dis)
>>>>> +
>>>>
>>>>
>>>> I'd say that such macros only obfuscate code, without any gains, as you can
>>>> see in diffstat - this patch adds more lines than it removes.
>>>>
>>>> Please drop this change.
>>>
>>>   I agree with Tomasz here.
>>>
>>
>> Are you concerning about using macros or more insertions than deletions?
>
> It is just making the code more difficult to read and understand.

Especially when hiding accesses to struct fields inside and doing fancy 
stuff like concatenations.

Best regards,
Tomasz
