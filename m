From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH v2 0/2] iommu/ipmmu-vmsa: Add r8a779(6|70|95) DT bindings
Date: Wed, 20 Dec 2017 11:26:35 +0100
Message-ID: <20171220102635.z2tsusclwelvobmd@verge.net.au>
References: <20171124105804.26924-1-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171124105804.26924-1-horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Alex,

On Fri, Nov 24, 2017 at 10:58:02AM +0000, Simon Horman wrote:
> Update the IPMMU DT binding documentation to include r8a7796 (R-Car M3-W),
> r8a77970 (R-Car V3M) and r8a77995 (R-Car D3) compat strings.
> 
> This patch-set is comprised of patches previously included in
> * [PATCH v4 0/3] iommu/ipmmu-vmsa: r8a7796 support V4
> * [PATCH 0/2] iommu/ipmmu-vmsa: r8a779(70|95) support
> 
> Those series also include driver updates to implement the bindings,
> however, it while it is felt that the bindings themselves are ready
> to be merged we feel that the driver updates are not at that stage yet.
> 
> Changes since v1:
> * Correct typo in r8a779(70|95) patch: R8A7770 -> R8A77970
> 
> 
> Magnus Damm (1):
>   iommu/ipmmu-vmsa: Add r8a7796 DT binding
> 
> Simon Horman (1):
>   iommu/ipmmu-vmsa: Add r8a779(70|95) DT bindings
> 
>  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt | 3 +++
>  1 file changed, 3 insertions(+)

I'm not aware of any problems with this series.
Could you consider applying it?
