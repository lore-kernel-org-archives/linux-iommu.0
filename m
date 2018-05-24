From: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v7 2/2] iommu/amd: Add basic debugfs infrastructure for
	AMD IOMMU
Date: Thu, 24 May 2018 18:51:18 -0500
Message-ID: <51bc04a4-81f4-f2ab-091e-a77059de12ec@amd.com>
References: <152631818082.18929.13970142119193316487.stgit@sosxen2.amd.com>
	<152631842907.18929.8819955271544326298.stgit@sosxen2.amd.com>
	<ba2bb6f7-77ea-4431-af0f-d20c19820d5d@infradead.org>
	<5e45f38e-cb45-d4a1-f351-30543f787290@amd.com>
	<20180515134603.GD18595@8bytes.org>
	<4041cb33-19a2-5542-4211-1dce51de5e40@amd.com>
	<89a0e3af-8970-cd80-418d-630841795807@infradead.org>
	<3eefbef8-142e-0a29-3e97-536717f63a98@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <3eefbef8-142e-0a29-3e97-536717f63a98-5C7GfCeVMHo@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 05/18/2018 04:02 PM, Gary R Hook wrote:
> On 05/18/2018 11:49 AM, Randy Dunlap wrote:
>> I think the Kconfig option would have been the correct choice.
> 
> "Preferred", perhaps. Neither is incorrect. And really, the 
> Makefile/Kconfig choice is somewhat separate from the organization issue.
> 
> So I've made the changes for this. Now I'm waiting on Joerg to make a 
> decision on the code/file organization. I still prefer a separate file 
> for the debug fs code.

Joerg:

*poke*

Any thoughts on this?
