From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration with DT and
 DMA-mapping subsystem
Date: Tue, 6 Jan 2015 10:49:44 +0100
Message-ID: <CABxcv=n=eNqbyBbOk1Wb87tCnnLZAJQurmCdeTOSqMZMbNaSHw@mail.gmail.com>
References: <1416395748-10731-1-git-send-email-m.szyprowski@samsung.com>
 <1417514366.21830.22.camel@collabora.co.uk>
 <54818768.3080303@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <54818768.3080303@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linaro-mm-sig@lists.linaro.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Gustavo Padovan <gustavo.padovan@collabora.co.uk>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org, Tomasz Figa <tomasz.figa@gmail.com>, Inki Dae <inki.dae@samsung.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Kukjin Kim <kgene.kim@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Olof Johansson <olof@lixom.net>, Kyungmin Park <kyungmin.park@samsung.com>, Thierry Reding <treding@nvidia.com>, Cho KyongHo <pullip.cho@samsung.com>, David Wodhouse <dwmw2@infradead.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists>
List-Id: iommu@lists.linux-foundation.org

Hello Marek,

On Fri, Dec 5, 2014 at 11:22 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> On 2014-12-02 10:59, Sjoerd Simons wrote:
>>>
>>> This is another attempt to finally make Exynos SYSMMU driver fully
>>> integrated with DMA-mapping subsystem. The main change from previous
>>> version is a rebase onto latest "automatic DMA configuration for IOMMU
>>> masters" patches from Will Deacon.
>>
>> Do you happen to know if anyone is working on iommu/dma-mapping patches
>> for Exynos 5 based on this patchset?
>
>
> I hope to add Exynos5 SYSMMU patches to the next iteration of my patchset,
> but I doubt it will get into v3.19-rc1.
>
>> For some background to that question, We (re-)discovered yesterday that
>> the out-of-tree exynos-reference kernel iommu patches are required to
>> get HDMI out working on exynos 5 boards. The current situation in
>> mainline is rather broken, HDMI output without CONFIG_DRM_EXYNOS_IOMMU
>> results in just displaying stripes[0]. While turning on
>> CONFIG_DRM_EXYNOS_IOMMU causes a kernel oops at boot....
>
>
> We have observed similar issues with Exynos4 based boards, when LCD0 power
> domain was turned off and only TV power domain has been powered on. Please
> check the power domain configuration. Maybe in case of Exynos5 the same

So IIUC what you are saying is that enabling the Exynos DRM IOMMU
support has the side effect of turning on all the power domains needed
by HDMI? I've compared the power domains configuration in mainline
with the downstream exynos-reference [0] tree and I didn't find any
differences.

> issue
> is caused by the interaction between DISP1 and GSCL domains.
>

I was also not able to find a dependency betwen GSCL and DISP1 power
domains in the Exynos 5420 manual. But If that's the case then your
patch to add support for sub-power domains on Exynos [1] will also be
needed, right?

AFAICT from the manual, all the used modules in the case of HDMI +
Display (LCD, DP, HDMI and MIXER) needs only the DISP1 power domain to
be enabled which BTW was removed for Exynos5420 on commit d51cad7
("ARM: dts: remove display power domain for exynos5420"). It seems to
work just because the power domain is turned on by the bootloader.

Also I tried forcing the kernel to not disable unused power domains by
passing the pd_ignore_unused parameter to the kernel command line. I
see on the kernel log a "genpd: Not disabling unused power domains"
message but HDMI output still has the stripes that Sjoerd mentioned.
Do you know if Exynos DRM HDMI in mainline is supposed to work without
SysMMU / IOMMU support?

Thanks a lot for your help and suggestions.

> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

Best regards,
Javier

[0]: https://github.com/exynos-reference/kernel/commits/exynos5-v3.17-rc1-chrome
[1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/308335.html
