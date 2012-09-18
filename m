From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] intel-iommu: Default to non-coherent for domains
	unattached to iommus
Date: Tue, 18 Sep 2012 16:34:46 +0200
Message-ID: <20120918143446.GO2505@amd.com>
References: <1347479705-33972-1-git-send-email-ddutile@redhat.com>
	<20120918115937.GB9939@8bytes.org> <50587DE6.3000207@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50587DE6.3000207-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 18, 2012 at 09:57:58AM -0400, Don Dutile wrote:
> And you can't apply Alex's original patch as-is, since the iommu_bmp
> structure element changed from a ptr to an array,
> (a snippet of) alex's patch looked like:
> +    i = find_first_bit(&domain->iommu_bmp, g_num_of_iommus);
> 
> and the correct patch with the change to iommu_bmp is:
> +    i = find_first_bit(domain->iommu_bmp, g_num_of_iommus);
> 
> and the reason why I re-posted it, vs fwd-ing the original patch
> & asking for inclusion.
> Additionally, the above patch is what the customer tested & verified.
> 
> So, if you made the above adjustment to Alex's patch,
> then the patch is ok.  If not, the above adjustment must be made.

Okay, fine then. I made the adjustment to Alex' patch and will push my
updated tree out after some compile-testing.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
