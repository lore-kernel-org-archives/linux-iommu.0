From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC 0/2] arm-smmu-v3 tlbi-on-map option
Date: Wed, 12 Jul 2017 18:54:56 +0100
Message-ID: <20170712175454.GF15191@arm.com>
References: <1499613303-30173-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1499613303-30173-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc.Zyngier-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Eric,

On Sun, Jul 09, 2017 at 05:15:01PM +0200, Eric Auger wrote:
> This series adds a new tlbi-on-map option to the smmuv3 driver.
> When set, the IO_PGTABLE_QUIRK_TLBI_ON_MAP quirk is applied for 
> LPAE tables and the smmuv3 driver sends TLB invalidations on map.
> 
> This mode is useful when running the driver on a guest as it allows
> the virtualizer to trap any change to the translation structures.
> This is similar to the Intel vtd caching mode (CM).
> 
> This is especially needed for VFIO integration integration where
> guest mappings must be applied to the physical IOMMU.
> 
> At the moment the option only is available for DT probing.

I'm really not a fan of this approach. If a virtual IOMMU implementation is
advertising itself as an SMMUv3, then it should adhere to the SMMUv3
architecture and not require non-standard behaviour from the driver. If
we're going to allow that, then we're better off going the extra mile and
using a PV approach. Given that the the SMMU3 architecture does *not*
require TLBI on map, then I don't think we should be quirking our behaviour
in this way. The fact that you only have this implemented for DT is the
canary in the coal mine imo.

Will
