From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v3 1/3] iommu/io-pgtable: Add ARMv7 short descriptor
	support
Date: Wed, 27 Jan 2016 09:16:26 +0800
Message-ID: <1453857386.28284.4.camel@mhfsdcap03>
References: <cover.1453723096.git.robin.murphy@arm.com>
	<066c4af0e29c9cc658bd5e48edc5e2d7ba7140a1.1453723096.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <066c4af0e29c9cc658bd5e48edc5e2d7ba7140a1.1453723096.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 2016-01-26 at 17:13 +0000, Robin Murphy wrote:
> Add a nearly-complete ARMv7 short descriptor implementation, omitting
> only a few legacy and CPU-centric aspects which shouldn't be necessary
> for IOMMU API use anyway.
> 
> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

This looks good to me.
And actually our disp/vdec/venc works well on your v2.

You could choose the two below,
Reviewed-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Tested-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

Thanks.

> ---
>  drivers/iommu/Kconfig              |  19 +
>  drivers/iommu/Makefile             |   1 +
>  drivers/iommu/io-pgtable-arm-v7s.c | 849 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/io-pgtable.c         |   3 +
>  drivers/iommu/io-pgtable.h         |  14 +-
>  5 files changed, 885 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iommu/io-pgtable-arm-v7s.c
