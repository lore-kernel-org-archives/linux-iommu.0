From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/5 v11] iommu/fsl: Freescale PAMU driver and IOMMU API
	implementation.
Date: Tue, 2 Apr 2013 18:23:12 +0200
Message-ID: <20130402162310.GJ15687@8bytes.org>
References: <1364500442-20927-1-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1364500442-20927-1-git-send-email-Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
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
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 29, 2013 at 01:23:57AM +0530, Varun Sethi wrote:
> This patchset provides the Freescale PAMU (Peripheral Access Management Unit) driver
> and the corresponding IOMMU API implementation. PAMU is the IOMMU present on Freescale
> QorIQ platforms. PAMU can authorize memory access, remap the memory address, and remap 
> the I/O transaction type.
> 
> This set consists of the following patches:
> 1.  Make iova dma_addr_t in the iommu_iova_to_phys API.
> 2. Addition of new field in the device (powerpc) archdata structure for storing iommu domain information
>    pointer.
> 3. Add window permission flags in the iommu_domain_window_enable API.
> 4. Add domain attributes for FSL PAMU driver.
> 5. PAMU driver and IOMMU API implementation.

Okay, I am about to apply patches 1 and 3 to a new ppc/pamu branch in my
tree.

As a general question, how did you test the IOMMU driver and what will
you do in the future to avoid regressions?


	Joerg
