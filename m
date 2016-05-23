From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V5 0/7] iommu/msm: Add DT adaptation and generic bindings
	support
Date: Mon, 23 May 2016 09:10:40 +0100
Message-ID: <5742BB00.3040504@linaro.org>
References: <1463741694-1735-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1463741694-1735-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Sricharan,

Thanks for the patchset,

On 20/05/16 11:54, Sricharan R wrote:
> The msm_iommu.c driver currently works based on platform data.
> A single master device can be connected to more than one iommu and multiple
> contexts in each of the iommu. This association between master and iommus was
> represented from platform data using parent/child devices. The master drivers
> were responsible for attaching all of the iommus/context to a domain. Now the
> platform data support is removed and DT support is added. The master/iommus are
> added through generic iommu bindings.
...
> [V1]
>     https://lists.linuxfoundation.org/pipermail/iommu/2015-August/014074.html
>
> Sricharan R (7):
>    iommu/msm: Add DT adaptation
>    documentation: iommu: Add bindings for msm,iommu-v0 ip
>    iommu/msm: Move the contents from msm_iommu_dev.c to msm_iommu.c
>    iommu/msm: Add support for generic master bindings
>    iommu/msm: use generic ARMV7S short descriptor pagetable ops
>    iommu/msm: Use writel_relaxed and add a barrier
>    iommu/msm: Remove driver BROKEN
>
>   .../devicetree/bindings/iommu/msm,iommu-v0.txt     |  64 ++
>   drivers/iommu/Kconfig                              |   2 +-
>   drivers/iommu/Makefile                             |   2 +-
>   drivers/iommu/msm_iommu.c                          | 885 +++++++++++----------
>   drivers/iommu/msm_iommu.h                          |  73 +-
>   drivers/iommu/msm_iommu_dev.c                      | 381 ---------
>   drivers/iommu/msm_iommu_hw-8xxx.h                  | 109 +--
>   7 files changed, 636 insertions(+), 880 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
>   delete mode 100644 drivers/iommu/msm_iommu_dev.c


Tested It on IFC6410 and DB600c.

Tested-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>


--srini
