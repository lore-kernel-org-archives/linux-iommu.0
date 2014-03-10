From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] arm64: iommu: Refactoring common code.
Date: Mon, 10 Mar 2014 17:58:10 +0000
Message-ID: <20140310175810.GF10240@arm.com>
References: <CAD15agbWL0A_vO4Osgi=uC1JxkMQgL3gshU3Z7euZf5eVaU0VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD15agbWL0A_vO4Osgi=uC1JxkMQgL3gshU3Z7euZf5eVaU0VA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Mar 10, 2014 at 04:32:50PM +0000, Ritesh Harjani wrote:
> Hi Everyone,
> 
> Please find the following patch as refactoring of the common code out
> from arch/arm/mm/dma-mapping.c to lib/iommu-helper.c
> 
> This is just an initial version of patch to get more details and to
> know if this is how we want to plan refactoring iommu code to
> lib/iommu-helper.
> 
> Please let me know the changes/suggestion which you think in this ?
> 
> 
> 
> 
> Taking out the common code of buffer allocation and mapping
> for iommu from arch/arm to lib/iommu-helper file.
> 
> Signed-off-by: Ritesh Harjani <ritesh.harjani-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  arch/arm/mm/dma-mapping.c    | 159 +++++-----------------------------------
>  include/linux/iommu-helper.h |  22 ++++++
>  lib/iommu-helper.c           | 169 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 210 insertions(+), 140 deletions(-)

I haven't had the time to look at this patch but I think you should
change the subject prefix to just arm (rather than arm64) and cc Russell
King and the linux-arm-kernel mailing list.

I'll have a look at the patch tomorrow.

Thanks.

-- 
Catalin
