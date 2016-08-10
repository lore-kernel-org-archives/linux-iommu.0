From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] iommu/dma: Respect IOMMU aperture when allocating
Date: Wed, 10 Aug 2016 12:32:04 +0200
Message-ID: <20160810103204.GA8737@8bytes.org>
References: <3feb8016c2def4aabc5513b548e17bbf57c27959.1470755555.git.robin.murphy@arm.com>
	<6d73ab5fb671089057b31beb73667c09147a0f0e.1470755555.git.robin.murphy@arm.com>
	<3538fbec92fcbf2f0f4c98e28eaed89b9a0f1230.1470759552.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3538fbec92fcbf2f0f4c98e28eaed89b9a0f1230.1470759552.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 09, 2016 at 05:31:35PM +0100, Robin Murphy wrote:
> Where a device driver has set a 64-bit DMA mask to indicate the absence
> of addressing limitations, we still need to ensure that we don't
> allocate IOVAs beyond the actual input size of the IOMMU. The reported
> aperture is the most reliable way we have of inferring that input
> address size, so use that to enforce a hard upper limit where available.
> 
> Fixes: 0db2e5d18f76 ("iommu: Implement common IOMMU ops for DMA mapping")
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> Now with bonus "not being completely broken" as well as the min()
> change - seems the necessary prototype changes somehow wound up rebased
> into a different patch :/
> 
>  drivers/iommu/dma-iommu.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Applied, thanks.
