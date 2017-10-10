From: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Do not disable SWIOTLB if SME is active
Date: Tue, 10 Oct 2017 10:00:26 -0500
Message-ID: <3117832f-db8f-a0db-c825-f97e3e097b1b@amd.com>
References: <20171006213540.19038.84350.stgit@tlendack-t1.amdoffice.net>
	<800bd17c-475b-c5b2-c4d1-776c655f084a@amd.com>
	<20171010095814.ux7nrtsnylz573hh@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171010095814.ux7nrtsnylz573hh-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Borislav Petkov <bp-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/10/2017 4:58 AM, Joerg Roedel wrote:
> Hi Tom,

Hi Joerg,

> 
> On Fri, Oct 06, 2017 at 04:39:07PM -0500, Tom Lendacky wrote:
>> This is an SME bug fix.  Assuming this is acceptable, any chance it can be
>> pushed to the current 4.14 linux rc release tree?
> 
> Sure, can you please also provide a "Fixes:"-tag?

I can.  I'm not sure if you want me to re-submit the patch with it or if
you just want to add it yourself.  Let me know.

Fixes: 2543a786aa25 ("iommu/amd: Allow the AMD IOMMU to work with memory encryption")

Thanks,
Tom

> 
> 
> Thanks,
> 
> 	Joerg
> 
