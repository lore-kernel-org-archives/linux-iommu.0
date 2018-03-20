From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH  1/3] dt-bindings: iommu: ipmmu-vmsa: Add device tree
	support for r8a774[35]
Date: Tue, 20 Mar 2018 13:36:10 -0500
Message-ID: <20180320183609.3tdbenxkr3lkjbqp@8bytes.org>
References: <1516808522-17348-1-git-send-email-biju.das@bp.renesas.com>
	<1516808522-17348-2-git-send-email-biju.das@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1516808522-17348-2-git-send-email-biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Cc: Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>, Chris Paterson <chris.paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 24, 2018 at 03:42:00PM +0000, Biju Das wrote:
> Document r8a774[35] specific compatible strings. The Renesas RZ/G1[ME]
> (r8a774[35]) IPMMU are identical to the R-Car Gen2 family.
> 
> Signed-off-by: Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
> Reviewed-by: Chris Paterson <chris.paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.

Patches 2 and 3 seems already to be applied to another tree.
