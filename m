From: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Don't put completion-wait semaphore on stack
Date: Wed, 14 Sep 2016 17:26:48 +0200
Message-ID: <20160914152647.GA13814@gmail.com>
References: <1473846119-9527-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1473846119-9527-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


* Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> The semaphore used by the AMD IOMMU to signal command
> completion lived on the stack until now, which was safe as
> the driver busy-waited on the semaphore with IRQs disabled,
> so the stack can't go away under the driver.
> 
> But the recently introduced vmap-based stacks break this as
> the physical address of the semaphore can't be determinded
> easily anymore. The driver used the __pa() macro, but that
> only works in the direct-mapping. The result were
> Completion-Wait timeout errors seen by the IOMMU driver,
> breaking system boot.
> 
> Since putting the semaphore on the stack is bad design
> anyway, move the semaphore into 'struct amd_iommu'. It is
> protected by the per-iommu lock and now in the direct
> mapping again. This fixes the Completion-Wait timeout errors
> and makes AMD IOMMU systems boot again with vmap-based
> stacks enabled.
> 
> Reported-by: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu.c       | 14 ++++++++------
>  drivers/iommu/amd_iommu_types.h |  2 ++
>  2 files changed, 10 insertions(+), 6 deletions(-)

Cool, thanks! I'll put this into tip:x86/asm which has the virtually mapped stack 
patches - ok?

Thanks,

	Ingo
