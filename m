From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC][PATCH 1/2] Introduce the IOMMU_DEVICE flag.
Date: Mon, 6 Oct 2014 12:04:29 +0100
Message-ID: <20141006110428.GE12935@arm.com>
References: <1412591296-31934-1-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1412591296-31934-1-git-send-email-Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Varun,

[adding the Qualcomm guys, as I have an open question below]

On Mon, Oct 06, 2014 at 11:28:15AM +0100, Varun Sethi wrote:
> This is used for indicating device memory type for a DMA transaction. IOMMU
> driver would set up attributes indicationg access to device memory.
> 
> Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  include/linux/iommu.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 20f9a52..0599fe1 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -28,6 +28,7 @@
>  #define IOMMU_WRITE	(1 << 1)
>  #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
>  #define IOMMU_EXEC	(1 << 3)
> +#define IOMMU_DEVICE	(1 << 4) /* Indicates access to device memory */

An alternative to this would be to make device-memory the default type for
!IOMMU_CACHE mappings (i.e. MAIR index 0).

I'd value feedback either way; the argument comes down to whether we should
use normal non-cacheable or device-nGnRE as the default (!IOMMU_CACHE) memory
type. The latter is likely to be significantly slower, but provides the
ordering guarantees that you need for MSI delivery.

If we do go down the route of adding a new IOMMU_* option, it probably needs
a better name (IOMMU_MMIO, for example).

Will
