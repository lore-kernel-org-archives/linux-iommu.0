From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 0/7] iommu/arm-smmu: fixes for 3.17
Date: Mon, 1 Sep 2014 16:34:51 +0200
Message-ID: <20140901143451.GR27125@suse.de>
References: <1409323665-9605-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409323665-9605-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: hans-7z9IcJk4adCsTnJN9+BGXg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, vladimir.murzin-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Fri, Aug 29, 2014 at 03:47:38PM +0100, Will Deacon wrote:
> Hans Wennborg (1):
>   iommu/arm-smmu: fix decimal printf format specifiers prefixed with 0x
> 
> Mitchel Humpherys (1):
>   iommu/arm-smmu: avoid calling request_irq in atomic context
> 
> Olav Haugan (2):
>   iommu/arm-smmu: Do not access non-existing S2CR registers
>   iommu/arm-smmu: fix programming of SMMU_CBn_TCR for stage 1
> 
> Vladimir Murzin (1):
>   iommu/arm-smmu: remove pgtable_page_{c,d}tor()
> 
> Will Deacon (2):
>   iommu/arm-smmu: fix s2cr and smr teardown on device detach from domain
>   iommu/arm-smmu: fix corner cases in address size calculations
> 
>  drivers/iommu/arm-smmu.c | 127 +++++++++++++++++++++++++++--------------------
>  1 file changed, 73 insertions(+), 54 deletions(-)

Please don't forget to add stable-tags to these, if necessary.


	Joerg
