From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
Date: Tue, 13 Jan 2015 10:21:35 +0100
Message-ID: <54B4E39F.8040506@collabora.co.uk>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com> <1417514366.21830.22.camel@collabora.co.uk> <54818768.3080303@samsung.com> <CABxcv=n=eNqbyBbOk1Wb87tCnnLZAJQurmCdeTOSqMZMbNaSHw@mail.gmail.com> <54AC93E0.8010705@samsung.com> <54ACFD69.1020500@collabora.co.uk> <54AD0293.70909@samsung.com> <54AEB384.2040005@collabora.co.uk> <54B36C5A.6050109@samsung.com> <54B3F1B7.7090307@collabora.co.uk> <54B4ABFB.5000501@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <54B4ABFB.5000501@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linaro-mm-sig@lists.linaro.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Gustavo Padovan <gustavo.padovan@collabora.co.uk>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org, Tomasz Figa <tomasz.figa@gmail.com>, Inki Dae <inki.dae@samsung.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Kukjin Kim <kgene.kim@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Olof Johansson <olof@lixom.net>, Kyungmin Park <kyungmin.park@samsung.com>, Thierry Reding <treding@nvidia.com>, Cho KyongHo <pullip.cho@samsung.com>, David Wodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hello Joonyoung,

On 01/13/2015 06:24 AM, Joonyoung Shim wrote:
>> 
>> Also, the SW_ACLK_300_DISP1 and USER_ACLK_300_DISP1 are needed for the FIMD
>> parent and input clock respectively. Adding those to the clocks list of the
>> DISP1 power domain gives me working display + HDMI on my Exynos5800 Peach Pi.
>> 
>> These are the changes I have now [0]. Please let me know what you think.
>> 
> 
> Good, it's working with your patch without u-boot changes and reverting
> of commit 2ed127697eb.
>

Perfect, I'll split the the clk and DTS changes in different patches and
post the series once we figure out the "power-domain disable failed" issue.

>> 
>> Yes, I was not able to trigger that by running modetest but by turning off
>> my HDMI monitor and then turning it on again. When the monitor is turned
>> on then I see a "Power domain power-domain disable failed" and the imprecise
>> external abort error.
>> 
>> I had to disable CONFIG_DRM_EXYNOS_DP in order to trigger though and that
>> is why I was not able to reproduce it before.
>> 
>> I think though that this is a separate issue of the HDMI not working since
>> power domains should be able to have many consumers devices and I see that
>> other power domains are used that way.
>> 
> 
> OK, we need more investigation.
> 

Agreed, since even though I think this is a separate issue, I'll prefer
to not add a known bug as a side effect of having a working HDMI.

Best regard,
Javier
