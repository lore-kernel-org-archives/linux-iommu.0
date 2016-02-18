From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: RFC: extend IOMMU attributes
Date: Thu, 18 Feb 2016 16:21:45 +0000
Message-ID: <20160218162145.GB16883@arm.com>
References: <HE1PR04MB1641F22E38710B68F4ED891F8DAF0@HE1PR04MB1641.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <HE1PR04MB1641F22E38710B68F4ED891F8DAF0-6LN7OEpIatU5tNmRkpaxD89NdZoXdze2vxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>
Cc: Peter Newton <peter.newton-3arQi8VN3Tc@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Varun Sethi <V.Sethi-3arQi8VN3Tc@public.gmane.org>, Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Stuart,

On Thu, Feb 18, 2016 at 04:16:26PM +0000, Stuart Yoder wrote:
> We are implementing support for some specialized NXP SoC network
> devices and have the desire to extend the mapping attributes beyond
> those currently in iommu.h. (I see there is a recent proposal to
> add an IOMMU_MMIO flag)
> 
> What we have right now in Linux is a least-common-denominator set of
> attributes, while for the ARM SMMU there is a much richer set of
> attributes that seem useful to support. Specifically, we have one
> SoC device we're dealing with right now that is the target of DMA
> that functionally requires a "cacheable, non-shareable" attribute
> in its SMMU mapping.
> 
> In addition, there are many other attributes such as r/w allocate
> hints, transient hints, write-back/write-thru, etc in the SMMU.
> 
> We wanted to see what your thinking is with respect to the
> direction the Linux IOMMU layer will head over the longer term with
> respect to attributes.
> 
> Is there anything problematic with continuing to grow the
> attributes in iommu.h?...e.g.:
> 
>  #define IOMMU_READ            (1 << 0)
>  #define IOMMU_WRITE           (1 << 1)
> -#define IOMMU_CACHE           (1 << 2) /* DMA cache coherency */
> +#define IOMMU_CACHE_COHERENT  (1 << 2) /* cacheable and coherent */
>  #define IOMMU_NOEXEC          (1 << 3)
>  #define IOMMU_MMIO            (1 << 4) /* e.g. things like MSI doorbells */
> +#define IOMMU_CACHEABLE       (1 << 5) /* cacheable, not coherent */

What does that even mean?

> +#define IOMMU_CACHE_ALLOCATE  (1 << 6) /* hint to allocate in the cache */
> 
> Also, are we willing to let somewhat architecture specific flags
> onto that list?  For, example the ARM 'transient' hint.

If we're going to support fine-grained attribute control, I think it needs
to be done in a page-table specific manner. That is, io-pgtable-arm could
provide those attribute controls which feature in the ARMv8 architecture...

...but that brings me onto my next question: Who on Earth is actually
going to provide these attributes to the IOMMU API?

There seems to be a missing piece.

Will
