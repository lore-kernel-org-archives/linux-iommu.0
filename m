From: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 0/3] Add support for APM X-Gene SoC AHBC IOMMU driver.
Date: Mon, 15 Dec 2014 14:54:57 -0500
Message-ID: <548F3C91.3030803@redhat.com>
References: <1418662523-8458-1-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1418662523-8458-1-git-send-email-stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 12/15/2014 11:55 AM, Suman Tripathi wrote:
> This patch adds the support for the APM X-Gene SoC AHBC IOMMU driver.
>
> Signed-off-by: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
> ---
>
> Suman Tripathi (3):
>    xgene-ahbc-iommu: Add support for APM X-Gene SoC AHBC IOMMU driver.
>    arm64: dts: Add the APM X-Gene AHBC IOMMU DTS node.
>    Documentation: dt-bindings: Add the binding info for APM X-Gene AHBC
>      IOMMU driver.
>
>   .../devicetree/bindings/iommu/xgene,ahbc-iommu.txt |  17 ++
>   arch/arm64/boot/dts/apm-storm.dtsi                 |   5 +
>   drivers/iommu/Kconfig                              |  10 +
>   drivers/iommu/Makefile                             |   1 +
>   drivers/iommu/xgene-ahbc-iommu.c                   | 336 +++++++++++++++++++++
>   5 files changed, 369 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/iommu/xgene,ahbc-iommu.txt
>   create mode 100644 drivers/iommu/xgene-ahbc-iommu.c
>
> --
> 1.8.2.1
>

Have you tested this with a kernel that uses 64K page size ?
