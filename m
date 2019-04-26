Return-Path: <SRS0=codQ=S4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E91DC43218
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 13:41:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED16A206E0
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 13:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED16A206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6E4D627D6;
	Fri, 26 Apr 2019 13:41:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E6B4127CE
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 13:38:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 71CC482A
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 13:38:50 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id AC762447; Fri, 26 Apr 2019 15:38:48 +0200 (CEST)
Date: Fri, 26 Apr 2019 15:38:46 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Pan Bian <bianpan2016@163.com>
Subject: Re: iommu/vt-d: drop mm use count if address is not canonical
Message-ID: <20190426133846.GC24576@8bytes.org>
References: <1555492377-79859-1-git-send-email-bianpan2016@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1555492377-79859-1-git-send-email-bianpan2016@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>,
	linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190426133846.hdYSU74X-MnHTdE7O44EGieWGGiqHV7Tea3McDfc_PQ@z>

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
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
