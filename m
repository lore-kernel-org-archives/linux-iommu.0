From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/3] iommu/fsl: Fix section mismatch
Date: Mon, 26 Jan 2015 13:49:53 +0100
Message-ID: <20150126124953.GF4653@8bytes.org>
References: <1421938042-22580-1-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421938042-22580-1-git-send-email-Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
Cc: Varun.Sethi-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 22, 2015 at 08:47:20AM -0600, Emil Medve wrote:
> Section mismatch in reference from the variable fsl_of_pamu_driver to the function .init.text:fsl_pamu_probe()
> The variable fsl_of_pamu_driver references
> the function __init fsl_pamu_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> 
> Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>

Applied patch 1 and 2 to ppc/pamu, thanks.
