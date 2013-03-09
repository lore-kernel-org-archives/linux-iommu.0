From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] amd_iommu_init: remove __init from
	amd_iommu_erratum_746_workaround
Date: Sat, 9 Mar 2013 19:03:15 +0100
Message-ID: <20130309180314.GB4876@8bytes.org>
References: <a6e63dc6f1bdc2d20f3d7d07a5d878e9c1b01d85.1361891160.git.npajkovs@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a6e63dc6f1bdc2d20f3d7d07a5d878e9c1b01d85.1361891160.git.npajkovs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Nikola Pajkovsky <npajkovs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 26, 2013 at 04:12:05PM +0100, Nikola Pajkovsky wrote:
> commit 318fe78 ("IOMMU, AMD Family15h Model10-1Fh erratum 746 Workaround")
> added amd_iommu_erratum_746_workaround and it's marked as __init, which is wrong
> 
> WARNING: drivers/iommu/built-in.o(.text+0x639c): Section mismatch in reference from the function iommu_init_pci() to the function .init.text:amd_iommu_erratum_746_workaround()
> The function iommu_init_pci() references
> the function __init amd_iommu_erratum_746_workaround().
> This is often because iommu_init_pci lacks a __init
> annotation or the annotation of amd_iommu_erratum_746_workaround is wrong.
> 
> Signed-off-by: Nikola Pajkovsky <npajkovs-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Applied to iommu/fixes, thanks.
