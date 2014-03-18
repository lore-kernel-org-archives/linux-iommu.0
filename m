From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v11 10/27] iommu/exynos: use managed device helper functions
Date: Tue, 18 Mar 2014 16:14:53 +0100
Message-ID: <532862ED.8040809@samsung.com>
References: <20140314140542.f4ded6c50dbd8a1d937bf354@samsung.com>
 <CAK9yfHw7zYaX9EYFE+m3Mh-u8Uiyubx-cS0EwPmfW+0weLiBKw@mail.gmail.com>
 <20140318200915.7dd833ce0fddbbd6ecd8dac9@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20140318200915.7dd833ce0fddbbd6ecd8dac9@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Cho KyongHo <pullip.cho@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>
Cc: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Linux DeviceTree <devicetree@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>, Antonios Motakis <a.motakis@virtualopensystems.com>, Grant Grundler <grundler@chromium.org>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene.kim@samsung.com>, Prathyush <prathyush.k@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Varun Sethi <Varun.Sethi@freescale.com>
List-Id: iommu@lists.linux-foundation.org

On 18.03.2014 12:09, Cho KyongHo wrote:
> On Fri, 14 Mar 2014 20:52:43 +0530, Sachin Kamat wrote:
>> Hi KyongHo,
>>
>> On 14 March 2014 10:35, Cho KyongHo <pullip.cho@samsung.com> wrote:
>>> This patch uses managed device helper functions in the probe().
>>>
>>> Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
>>> ---
>> [snip]
>>
>>> +       data->clk = devm_clk_get(dev, "sysmmu");
>>> +       if (IS_ERR(data->clk)) {
>>> +               dev_info(dev, "No gate clock found!\n");
>>> +               data->clk = NULL;
>>> +       }
>>
>> Why aren't you returning from here upon error?
>
> It is for the case of a System MMU which does not need clock gating.
>

Are there really such cases?

Best regards,
Tomasz
