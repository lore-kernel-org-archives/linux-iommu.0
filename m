From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/amd: Fix for pasid initialization
Date: Wed, 9 Jul 2014 16:04:43 +0200
Message-ID: <20140709140442.GK1958@8bytes.org>
References: <1404829817-19584-1-git-send-email-oded.gabbay@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404829817-19584-1-git-send-email-oded.gabbay-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Oded Gabbay <oded.gabbay-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Alexey Skidanov <Alexey.Skidanov-5C7GfCeVMHo@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 08, 2014 at 05:30:16PM +0300, Oded Gabbay wrote:
> From: Alexey Skidanov <Alexey.Skidanov-5C7GfCeVMHo@public.gmane.org>
> 
> The pasid wasn't properly initialized before caling to invalid PPR calback
> 
> Signed-off-by: Alexey Skidanov <Alexey.Skidanov-5C7GfCeVMHo@public.gmane.org>
> Signed-off-by: Oded Gabbay <oded.gabbay-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu_v2.c | 1 +
>  1 file changed, 1 insertion(+)

Applied both, thanks Oded.
