Return-Path: <SRS0=uwQI=Y4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86ACCA9EB5
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 18:17:30 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3877C20578
	for <iommu@archiver.kernel.org>; Mon,  4 Nov 2019 18:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MregfVcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3877C20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EBE77CD2;
	Mon,  4 Nov 2019 18:17:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1D6BBCAF
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 18:17:28 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C144DA9
	for <iommu@lists.linux-foundation.org>;
	Mon,  4 Nov 2019 18:17:27 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id B025420578;
	Mon,  4 Nov 2019 18:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572891447;
	bh=I0ClEyfYYg+5vZmQ5JQDLaZ5AFVtu2E4q0e7uMtVpz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MregfVcg4Le7ebB4b6p6lGzAOFFhK7K25ALaLHWbsDc8WmaRHztAMBvyXPfhH57Zk
	Ymq4nsLSWJaxb1X/M0ZO4nPFio44FxATL1oAHF4tzCygnuURfV/PK0o/voR6/EdndF
	D+4XkeyENeKp0wa3XYpIN0XyIod2Um9Mjw6r+M4A=
Date: Mon, 4 Nov 2019 18:17:23 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 06/10] iommu/io-pgtable-arm: Simplify level indexing
Message-ID: <20191104181722.GF24909@willie-the-truck>
References: <cover.1572024119.git.robin.murphy@arm.com>
	<698173b487383735e470a28e5cca4f9db22703de.1572024120.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <698173b487383735e470a28e5cca4f9db22703de.1572024120.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, Oct 25, 2019 at 07:08:35PM +0100, Robin Murphy wrote:
> The nature of the LPAE format means that data->pg_shift is always
> redundant with data->bits_per_level, since they represent the size of a
> page and the number of PTEs per page respectively, and the size of a PTE
> is constant. Thus it works out more efficient to only store the latter,
> and derive the former via a trivial addition where necessary.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 4b1483eb0ccf..15b4927ce36b 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -36,10 +36,11 @@
>   * in a virtual address mapped by the pagetable in d.
>   */
>  #define ARM_LPAE_LVL_SHIFT(l,d)						\
> -	(((ARM_LPAE_MAX_LEVELS - 1 - (l)) * (d)->bits_per_level) +	\
> -	(d)->pg_shift)
> +	(((ARM_LPAE_MAX_LEVELS - (l)) * (d)->bits_per_level) +		\
> +	ilog2(sizeof(arm_lpae_iopte)))
>  
> -#define ARM_LPAE_GRANULE(d)		(1UL << (d)->pg_shift)
> +#define ARM_LPAE_GRANULE(d)						\
> +	(sizeof(arm_lpae_iopte) << (d)->bits_per_level)
>  #define ARM_LPAE_PGD_SIZE(d)						\
>  	(sizeof(arm_lpae_iopte) << (d)->pgd_bits)
>  
> @@ -55,9 +56,7 @@
>  	 ((1 << ((d)->bits_per_level + ARM_LPAE_PGD_IDX(l,d))) - 1))
>  
>  /* Calculate the block/page mapping size at level l for pagetable in d. */
> -#define ARM_LPAE_BLOCK_SIZE(l,d)					\
> -	(1ULL << (ilog2(sizeof(arm_lpae_iopte)) +			\
> -		((ARM_LPAE_MAX_LEVELS - (l)) * (d)->bits_per_level)))
> +#define ARM_LPAE_BLOCK_SIZE(l,d)	(1ULL << ARM_LPAE_LVL_SHIFT(l,d))
>  
>  /* Page table bits */
>  #define ARM_LPAE_PTE_TYPE_SHIFT		0
> @@ -175,8 +174,7 @@ struct arm_lpae_io_pgtable {
>  
>  	int			pgd_bits;
>  	int			start_level;
> -	unsigned long		pg_shift;
> -	unsigned long		bits_per_level;
> +	int			bits_per_level;
>  
>  	void			*pgd;
>  };
> @@ -206,7 +204,7 @@ static phys_addr_t iopte_to_paddr(arm_lpae_iopte pte,
>  {
>  	u64 paddr = pte & ARM_LPAE_PTE_ADDR_MASK;
>  
> -	if (data->pg_shift < 16)
> +	if (data->bits_per_level < 13) /* i.e. 64K granule */

nit, but:

	if (ARM_LPAE_GRANULE(data) < SZ_64K)

might be clearer and avoid the need for a comment?

(I can make the change locally if you agree)

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
