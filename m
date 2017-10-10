From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Do not disable SWIOTLB if SME is active
Date: Tue, 10 Oct 2017 19:50:11 +0200
Message-ID: <20171010175011.GB30803@8bytes.org>
References: <20171006213540.19038.84350.stgit@tlendack-t1.amdoffice.net>
	<800bd17c-475b-c5b2-c4d1-776c655f084a@amd.com>
	<20171010095814.ux7nrtsnylz573hh@8bytes.org>
	<3117832f-db8f-a0db-c825-f97e3e097b1b@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3117832f-db8f-a0db-c825-f97e3e097b1b-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Tom,

On Tue, Oct 10, 2017 at 10:00:26AM -0500, Tom Lendacky wrote:
> I can.  I'm not sure if you want me to re-submit the patch with it or if
> you just want to add it yourself.  Let me know.
> 
> Fixes: 2543a786aa25 ("iommu/amd: Allow the AMD IOMMU to work with memory encryption")

No need to re-submit, I applied the patch and added the tag.


Thanks,

	Joerg
