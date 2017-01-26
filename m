From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 4/5] arm64: dma-mapping: Only swizzle DMA ops for
 IOMMU_DOMAIN_DMA
Date: Thu, 26 Jan 2017 17:57:45 +0000
Message-ID: <20170126175745.GQ14167@arm.com>
References: <1484849955-1871-1-git-send-email-will.deacon@arm.com>
 <1484849955-1871-5-git-send-email-will.deacon@arm.com>
 <91cf771f-af55-f66f-ea24-9582fc83f03a@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <91cf771f-af55-f66f-ea24-9582fc83f03a@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, joro@8bytes.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 19, 2017 at 07:00:25PM +0000, Robin Murphy wrote:
> On 19/01/17 18:19, Will Deacon wrote:
> > The arm64 DMA-mapping implementation sets the DMA ops to the IOMMU DMA
> > ops if we detect that an IOMMU is present for the master and the DMA
> > ranges are valid.
> > 
> > In the case when the IOMMU domain for the device is not of type
> > IOMMU_DOMAIN_DMA, then we have no business swizzling the ops, since
> > we're not in control of the underlying address space. This patch leaves
> > the DMA ops alone for masters attached to non-DMA IOMMU domains.
> 
> In fact, I don't think there would be any harm in taking this one
> through arm64 straight away. The DMA ops can't be expected to work
> successfully on any old domain, so it's a reasonable sanity check
> regardless.
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Good point; I'll queue this one for 4.11 via arm64.

Will
