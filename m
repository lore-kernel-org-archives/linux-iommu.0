From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Apply workaround for ATS write permission check
Date: Thu, 25 Feb 2016 16:07:27 +0100
Message-ID: <20160225150727.GD2280@suse.de>
References: <1455140881-17041-1-git-send-email-jay@jcornwall.me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1455140881-17041-1-git-send-email-jay-gJmSnxjMpeIFV7jr3Ov9Ew@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jay Cornwall <jay-gJmSnxjMpeIFV7jr3Ov9Ew@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 10, 2016 at 03:48:01PM -0600, Jay Cornwall wrote:
> The AMD Family 15h Models 30h-3Fh (Kaveri) BIOS and Kernel Developer's
> Guide omitted part of the BIOS IOMMU L2 register setup specification.
> Without this setup the IOMMU L2 does not fully respect write permissions
> when handling an ATS translation request.
> 
> The IOMMU L2 will set PTE dirty bit when handling an ATS translation with
> write permission request, even when PTE RW bit is clear. This may occur by
> direct translation (which would cause a PPR) or by prefetch request from
> the ATC.
> 
> This is observed in practice when the IOMMU L2 modifies a PTE which maps a
> pagecache page. The ext4 filesystem driver BUGs when asked to writeback
> these (non-modified) pages.
> 
> Enable ATS write permission check in the Kaveri IOMMU L2 if BIOS has not.
> 
> Signed-off-by: Jay Cornwall <jay-gJmSnxjMpeIFV7jr3Ov9Ew@public.gmane.org>
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # v3.19+
> ---
>  drivers/iommu/amd_iommu_init.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)

Applied, thanks.
