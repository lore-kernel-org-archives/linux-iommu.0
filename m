From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: IOMMU DMA-mapping API for arm64 ?
Date: Tue, 29 Apr 2014 13:52:59 +0100
Message-ID: <20140429125259.GA27770@arm.com>
References: <CAD15agaps45rZT5ko9JKP2CfRF_iTV+0JMDwa239ExgKrRzBYQ@mail.gmail.com>
	<201402272006.51057.arnd@arndb.de>
	<CAD15aga3VAHH9aV134tfp+CgA8x25R_H4DKoPKNkFyAC9FTxBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD15aga3VAHH9aV134tfp+CgA8x25R_H4DKoPKNkFyAC9FTxBg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Apr 26, 2014 at 03:28:37PM +0100, Ritesh Harjani wrote:
> Hi Guys,
> 
> Need again some help in deciding which all functions/Data structures
> needs to be moved out from arch/arm/mm/dma-mapping to
> lib/iommu-helper.c.
> 
> 1. There is this dma_iommu_mapping structure defination in
> arch/arm/include/asm/dma-iommu.h. In arm this structure is declared as
> "mapping" which is part of dev_archdata structure, which is used for
> IOVA management.
> Now, does this make sense to move this structure out to
> include/linux/iommu-helper.h ? And define a config like
> CONFIG_IOMMU_USE_HELPER_MAPPING (default n) which will be used to,
> have a variable("mapping") defined or not in dev_archdata of all
> archs.

In that case, wouldn't it make more sense to put the DMA mapping information
in the struct device itself, rather than the dev_archdata? The CMA data, for
example, is stored directly there.

Will
