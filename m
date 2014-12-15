From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 3/3] Documentation: dt-bindings: Add the binding info for
	APM X-Gene AHBC IOMMU driver.
Date: Mon, 15 Dec 2014 22:30:06 +0100
Message-ID: <17322841.g8pTBk7ToU@wuerfel>
References: <1418662523-8458-1-git-send-email-stripathi@apm.com>
	<1418662523-8458-4-git-send-email-stripathi@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1418662523-8458-4-git-send-email-stripathi-qTEPVZfXA3Y@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, patches-qTEPVZfXA3Y@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Monday 15 December 2014 22:25:23 Suman Tripathi wrote:
> +*APM X-Gene AHBC IOMMU Architecture Implementation
> +
> +APM X-Gene SoC AHBC IOMMU translates the AHBC 32-bit address from
> +dma master to 42-bit AXI address by using a set of AIM(AHB Inbound mapper)
> +register.
> +
> +** AHBC IOMMU required properties:
> +
> +- compatible    : Should be "apm,xgene-ahbc-iommu"
> +- reg           : Base address of the AHBC AXI mapper registers
> +
> +Example:
> +
> +               ahbc_iommu: ahbc_iommu@0x1f2a0080 {
> +                       compatible = "apm,xgene-ahbc-iommu";
> +                       reg = <0x0 0x1f2a0080 0x0 0x90>;
> +               };
> --
> 1.8.2.1
> 

This is incompatible with the iommu binding from 
Documentation/devicetree/bindings/iommu/iommu.txt

Please fix.

	Arnd
