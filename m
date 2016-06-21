From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V6 0/6] iommu/msm: Add DT adaptation and generic bindings
	support
Date: Tue, 21 Jun 2016 14:04:42 +0200
Message-ID: <20160621120442.GH28248@8bytes.org>
References: <1465817767-9856-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1465817767-9856-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jun 13, 2016 at 05:06:01PM +0530, Sricharan R wrote:
> Sricharan R (6):
>   iommu/msm: Add DT adaptation
>   documentation: iommu: Add bindings for msm,iommu-v0 ip
>   iommu/msm: Move the contents from msm_iommu_dev.c to msm_iommu.c
>   iommu/msm: Add support for generic master bindings
>   iommu/msm: use generic ARMV7S short descriptor pagetable ops
>   iommu/msm: Remove driver BROKEN
> 
>  .../devicetree/bindings/iommu/msm,iommu-v0.txt     |  64 ++
>  drivers/iommu/Kconfig                              |   2 +-
>  drivers/iommu/Makefile                             |   2 +-
>  drivers/iommu/msm_iommu.c                          | 870 +++++++++++----------
>  drivers/iommu/msm_iommu.h                          |  73 +-
>  drivers/iommu/msm_iommu_dev.c                      | 381 ---------
>  6 files changed, 564 insertions(+), 828 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
>  delete mode 100644 drivers/iommu/msm_iommu_dev.c

Applied this series, thanks.
