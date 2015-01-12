From: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Subject: Re: Exynos IOMMU driver doesn't work?
Date: Mon, 12 Jan 2015 12:17:11 +0100
Message-ID: <CABxcv=koJjdXb6z1K3op8m4rFO=3NRYtGwqVH7WqOb7kR8jVaw@mail.gmail.com>
References: <CAOhR-w2vQbyYrWsvZjs-Pt6tU6m9BmH-T5tuBDSyUXteWgxP0Q@mail.gmail.com>
	<CAOhR-w1gH6zzSZcw-0Lo0zc+p1Mt0=4aqWEZ0Agz4xw0uHsq7A@mail.gmail.com>
	<CABxcv=n26-A86OmsqviEUz=XSF6QP6K0s=Dfzc43x4+if_qP7A@mail.gmail.com>
	<CAOhR-w0BcdrSLw7fVOTokNrQkcfsRj8skm6fn1UCMGgDeGDNKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAOhR-w0BcdrSLw7fVOTokNrQkcfsRj8skm6fn1UCMGgDeGDNKA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hongbo Zhang <hongbo.zhang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello Hongbo,

On Mon, Jan 12, 2015 at 11:51 AM, Hongbo Zhang <hongbo.zhang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 9 January 2015 at 23:34, Javier Martinez Canillas
>>
>> Yes, please take a look to Marek series [0]. Keep in mind that the
>> series does not support all sysmmu revisions so IOMMU is not supported
>> for some SoCs (e.g: Exynos5). Support for that is planned once that
>> series land into mainline though [1].
>>
>> May I ask why are you interested in IOMMU support on Exynos? I'm
>> asking because the reason why I tried to enable IOMMU support (and hit
>> the same issue) was to try using the Exynos DRM HDMI driver with IOMMU
>> since I found that HDMI is working on the downstream Samsung kernel
>> [2] that has IOMMU support, but is not working on mainline.
>
> Because I am testing vfio-platform patches, IOMMU is used in this case.
> http://www.spinics.net/lists/kvm-arm/msg12445.html
>

Ok, different use case then.

> And I am glad to find a working kernel as you pointed out, then I

Glad that you found the information useful.

> found these two commits in this tree may solve my problem:
> 841a7fe TEMP/TO POST: iommu: exynos: Add "mmu-masters" support
> bd7e4c7 TEMP/TO POST: ARM: dts: add System MMU nodes of Exynos SoCs
>
>>

Yes, that's what we cherry-picked as well to test HDMI since enabling
IOMMU has a side effect of turning on the right power domains and
enabling the needed clocks.

Best regards,
Javier
