From: Joerg Roedel <joro@8bytes.org>
Subject: Re: iommu/vt-d: drop mm use count if address is not canonical
Date: Fri, 26 Apr 2019 15:38:46 +0200
Message-ID: <20190426133846.GC24576@8bytes.org>
References: <1555492377-79859-1-git-send-email-bianpan2016@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555492377-79859-1-git-send-email-bianpan2016@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pan Bian <bianpan2016@163.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: iommu@lists.linux-foundation.org

[ Adding more people. ]

On Wed, Apr 17, 2019 at 05:12:57PM +0800, Pan Bian wrote:
> The use count of svm->mm is incremented by mmget_not_zero. However, it
> is not dropped when the address is not canonical. This patch fixes the
> bug.
> 
> Fixes: 9d8c3af31607("iommu/vt-d: IOMMU Page Request needs to check if
> address is canonical.")
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> ---
>  drivers/iommu/intel-svm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 3a4b09a..2630d2e 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -574,8 +574,10 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  			goto bad_req;
>  
>  		/* If address is not canonical, return invalid response */
> -		if (!is_canonical_address(address))
> +		if (!is_canonical_address(address)) {
> +			mmput(svm->mm);
>  			goto bad_req;
> +		}
>  
>  		down_read(&svm->mm->mmap_sem);
>  		vma = find_extend_vma(svm->mm, address);

I think it is better to move the canonical address check before
mmget_not_zero() like in the diff below. But I let David and Jacob
comment on this.

Regards,

	Joerg

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 8f87304f915c..5e9e1eee8336 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -586,14 +586,15 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		 * any faults on kernel addresses. */
 		if (!svm->mm)
 			goto bad_req;
-		/* If the mm is already defunct, don't handle faults. */
-		if (!mmget_not_zero(svm->mm))
-			goto bad_req;
 
 		/* If address is not canonical, return invalid response */
 		if (!is_canonical_address(address))
 			goto bad_req;
 
+		/* If the mm is already defunct, don't handle faults. */
+		if (!mmget_not_zero(svm->mm))
+			goto bad_req;
+
 		down_read(&svm->mm->mmap_sem);
 		vma = find_extend_vma(svm->mm, address);
 		if (!vma || address < vma->vm_start)
