From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] powerpc: Fix incorrect PPC32 PAMU dependency
Date: Thu, 7 Apr 2016 14:46:34 +0200
Message-ID: <20160407124634.GA31146@8bytes.org>
References: <1458188144-10331-1-git-send-email-afleming@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1458188144-10331-1-git-send-email-afleming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andy Fleming <afleming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 16, 2016 at 11:15:44PM -0500, Andy Fleming wrote:
> The Freescale PAMU can be enabled on both 32 and 64-bit Power
> chips. Commit 477ab7a19cec8409e4e2dd10e7348e4cac3c06e5
> (iommu: Make more drivers depend on COMPILE_TEST)
> restricted PAMU to PPC32. PPC covers both.
> 
> Signed-off-by: Andy Fleming <afleming-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> 
> v2: Implemented Michael Ellerman's suggestion to clean up the
>     dependency chain

Applied, thanks.
