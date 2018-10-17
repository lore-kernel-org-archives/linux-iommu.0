From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Hook up r8a77990 DT matching code
Date: Wed, 17 Oct 2018 11:13:49 +0200
Message-ID: <20181017091348.gg4rifioitndu3am@verge.net.au>
References: <20181015095557.25135-1-horms+renesas@verge.net.au>
	<c90c9a8b-d101-280f-7ee6-67e6cc473e64@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c90c9a8b-d101-280f-7ee6-67e6cc473e64-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kazuya Mizuguchi <kazuya.mizuguchi.ks-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 15, 2018 at 01:56:18PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 10/15/2018 12:55 PM, Simon Horman wrote:
> 
> > From: Hai Nguyen Pham <hai.pham.ud-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> > 
> > Support the r8a77990 IPMMU and update IPMMU_OF_DECLARE to hook up
> 
>    That macro is gone, you need to update the description.

Thanks, v2 sent.

> 
> > the updated compat string.
> > 
> > Signed-off-by: Hai Nguyen Pham <hai.pham.ud-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> > Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> > [simon: rebased; dropped no longer required IOMMU_OF_DECLARE hunk]
> 
>    Yet you didn't drop it from the description. :-)
> 
> > Signed-off-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
> [...]
> 
> MBR, Sergei
> 
