From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu: Fix printk formats for dma_addr_t
Date: Thu, 2 May 2013 12:11:52 +0200
Message-ID: <20130502101150.GA2859@8bytes.org>
References: <1365652184-4340-1-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1365652184-4340-1-git-send-email-Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 11, 2013 at 09:19:44AM +0530, Varun Sethi wrote:
> Fix printk formats for dma_addr_t:
> 
>    drivers/iommu/tegra-smmu.c: In function 'smmu_iommu_iova_to_phys':
> >> drivers/iommu/tegra-smmu.c:774:2: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'dma_addr_t' [-Wformat]
> --
>    drivers/iommu/tegra-gart.c: In function 'gart_iommu_iova_to_phys':
> >> drivers/iommu/tegra-gart.c:298:3: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'dma_addr_t' [-Wformat]
> 
> Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Applied to arm/tegra, thanks.
