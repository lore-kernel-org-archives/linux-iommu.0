From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: RFC: extend IOMMU attributes
Date: Thu, 25 Feb 2016 15:00:54 +0000
Message-ID: <20160225150053.GA15330@arm.com>
References: <HE1PR04MB1641F22E38710B68F4ED891F8DAF0@HE1PR04MB1641.eurprd04.prod.outlook.com>
	<20160225143855.GD16675@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160225143855.GD16675-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Varun Sethi <V.Sethi-3arQi8VN3Tc@public.gmane.org>, Peter Newton <peter.newton-3arQi8VN3Tc@public.gmane.org>, Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Feb 25, 2016 at 03:38:55PM +0100, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org wrote:
> On Thu, Feb 18, 2016 at 04:16:26PM +0000, Stuart Yoder wrote:
> >  #define IOMMU_READ            (1 << 0)
> >  #define IOMMU_WRITE           (1 << 1)
> > -#define IOMMU_CACHE           (1 << 2) /* DMA cache coherency */
> > +#define IOMMU_CACHE_COHERENT  (1 << 2) /* cacheable and coherent */
> >  #define IOMMU_NOEXEC          (1 << 3)
> >  #define IOMMU_MMIO            (1 << 4) /* e.g. things like MSI doorbells */
> > +#define IOMMU_CACHEABLE       (1 << 5) /* cacheable, not coherent */
> > +#define IOMMU_CACHE_ALLOCATE  (1 << 6) /* hint to allocate in the cache */
> 
> Hmm, this might be a valid use-case to introduce the
> map_attr()/unmap_attr() calls to the IOMMU-API. I have been resistant to
> these functions until now because the proposed use-cases were not
> convincing, but for hardware-specific map-attributes like this one it
> could make sense.

So this particular use-case is completely insane, but something like
read/write allocation hints could make sense for arm-smmu systems.

Will
