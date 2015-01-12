From: Hongbo Zhang <hongbo.zhang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: Exynos IOMMU driver doesn't work?
Date: Mon, 12 Jan 2015 18:51:29 +0800
Message-ID: <CAOhR-w0BcdrSLw7fVOTokNrQkcfsRj8skm6fn1UCMGgDeGDNKA@mail.gmail.com>
References: <CAOhR-w2vQbyYrWsvZjs-Pt6tU6m9BmH-T5tuBDSyUXteWgxP0Q@mail.gmail.com>
	<CAOhR-w1gH6zzSZcw-0Lo0zc+p1Mt0=4aqWEZ0Agz4xw0uHsq7A@mail.gmail.com>
	<CABxcv=n26-A86OmsqviEUz=XSF6QP6K0s=Dfzc43x4+if_qP7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CABxcv=n26-A86OmsqviEUz=XSF6QP6K0s=Dfzc43x4+if_qP7A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Cc: "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 9 January 2015 at 23:34, Javier Martinez Canillas
<javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org> wrote:
> [adding Marek, Sjoerd and Joonyoung that were discussing about iommu
> support in another thread]

Thank you Javier.

>
> Hello Hongbo,
>
> On Fri, Jan 9, 2015 at 8:31 AM, Hongbo Zhang <hongbo.zhang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> Add linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org mailing list.
>>
>> On 7 January 2015 at 18:31, Hongbo Zhang <hongbo.zhang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>> Hi Cho KyongHo, Joerg et al,
>>> I found the latest Exynos IOMMU driver doesn't work, the line 481:
>>> BUG_ON(!has_sysmmu(dev));
>>> in function __exynos_sysmmu_enable() in file exynos-iommu.c triggers
>>> kernel panic.
>>>
>>> Then I found the dev->archdata.iommu isn't initialized at all, it
>>> should be the root cause.
>>>
>
> That's correct, I found the same the other day since and thought about
> posting a patch to return -ENODEV if !has_sysmmu(dev) instead to avoid
> the driver to panic the kernel. But then I realized this is already
> fixed in Marek's "[PATCH v3 00/19] Exynos SYSMMU (IOMMU) integration
> with DT and DMA-mapping subsystem" series [0].
>
>>> Another problem is this driver is added support of device tree, but
>>> there is no device tree nodes in the dts file, so I had to search from
>>> internet and added those nodes manually.
>>>
>>> I've found these links of v12 and v13 patches
>>> https://lkml.org/lkml/2014/4/27/171
>>> https://lkml.org/lkml/2014/5/12/34
>>> patch v13 was merged into mainline kernel, but as a part of v12, it
>>> isn't complete and doesn't work alone, eg dts nodes are missing.
>>> (I didn't research much dev->archdata.iommu initialization error is
>>> introduced by which patch, but it seems in very old codes there is no
>>> such problem)
>>>
>
> Yes, please take a look to Marek series [0]. Keep in mind that the
> series does not support all sysmmu revisions so IOMMU is not supported
> for some SoCs (e.g: Exynos5). Support for that is planned once that
> series land into mainline though [1].
>
> May I ask why are you interested in IOMMU support on Exynos? I'm
> asking because the reason why I tried to enable IOMMU support (and hit
> the same issue) was to try using the Exynos DRM HDMI driver with IOMMU
> since I found that HDMI is working on the downstream Samsung kernel
> [2] that has IOMMU support, but is not working on mainline.

Because I am testing vfio-platform patches, IOMMU is used in this case.
http://www.spinics.net/lists/kvm-arm/msg12445.html

And I am glad to find a working kernel as you pointed out, then I
found these two commits in this tree may solve my problem:
841a7fe TEMP/TO POST: iommu: exynos: Add "mmu-masters" support
bd7e4c7 TEMP/TO POST: ARM: dts: add System MMU nodes of Exynos SoCs

>
> At the end the HDMI problem seems to not be IOMMU related but
> something with the power domains and clocking but in case you are
> facing the same issue, you may be interested in that discussion [3].
>
> Best regards,
> Javier
>
> [0]: http://www.spinics.net/lists/linux-samsung-soc/msg39168.html
> [1]: http://www.spinics.net/lists/linux-samsung-soc/msg39980.html
> [2]: git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:exynos-reference/kernel.git
> [3]: http://www.spinics.net/lists/linux-samsung-soc/msg40828.html
