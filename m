From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: iommu/vt-d: drop mm use count if address is not canonical
Date: Fri, 26 Apr 2019 08:47:31 -0700
Message-ID: <20190426084731.7481d384@jacob-builder>
References: <1555492377-79859-1-git-send-email-bianpan2016@163.com>
        <20190426133846.GC24576@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190426133846.GC24576@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Pan Bian <bianpan2016@163.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Fri, 26 Apr 2019 15:38:46 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> [ Adding more people. ]
> 
> On Wed, Apr 17, 2019 at 05:12:57PM +0800, Pan Bian wrote:
> > The use count of svm->mm is incremented by mmget_not_zero. However,
> > it is not dropped when the address is not canonical. This patch
> > fixes the bug.
> > 
> > Fixes: 9d8c3af31607("iommu/vt-d: IOMMU Page Request needs to check
> > if address is canonical.")
> > 
> > Signed-off-by: Pan Bian <bianpan2016@163.com>
> > ---
> >  drivers/iommu/intel-svm.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> > index 3a4b09a..2630d2e 100644
> > --- a/drivers/iommu/intel-svm.c
> > +++ b/drivers/iommu/intel-svm.c
> > @@ -574,8 +574,10 @@ static irqreturn_t prq_event_thread(int irq,
> > void *d) goto bad_req;
> >  
> >  		/* If address is not canonical, return invalid
> > response */
> > -		if (!is_canonical_address(address))
> > +		if (!is_canonical_address(address)) {
> > +			mmput(svm->mm);
> >  			goto bad_req;
> > +		}
> >  
> >  		down_read(&svm->mm->mmap_sem);
> >  		vma = find_extend_vma(svm->mm, address);  
> 
> I think it is better to move the canonical address check before
> mmget_not_zero() like in the diff below. But I let David and Jacob
> comment on this.
> 
Looks good to me. Tested with PRQ and fake non canonical address then
send an invalid page response.

 Tested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>


> Regards,
> 
> 	Joerg
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 8f87304f915c..5e9e1eee8336 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -586,14 +586,15 @@ static irqreturn_t prq_event_thread(int irq,
> void *d)
>  		 * any faults on kernel addresses. */
>  		if (!svm->mm)
>  			goto bad_req;
> -		/* If the mm is already defunct, don't handle
> faults. */
> -		if (!mmget_not_zero(svm->mm))
> -			goto bad_req;
>  
>  		/* If address is not canonical, return invalid
> response */ if (!is_canonical_address(address))
>  			goto bad_req;
>  
> +		/* If the mm is already defunct, don't handle
> faults. */
> +		if (!mmget_not_zero(svm->mm))
> +			goto bad_req;
> +
>  		down_read(&svm->mm->mmap_sem);
>  		vma = find_extend_vma(svm->mm, address);
>  		if (!vma || address < vma->vm_start)

[Jacob Pan]
