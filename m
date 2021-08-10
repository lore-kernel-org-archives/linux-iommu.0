Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2659AC4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 16:54:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABAEB60FC4
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 16:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ABAEB60FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E0BA6067A;
	Tue, 10 Aug 2021 16:54:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wBAvZTS262KB; Tue, 10 Aug 2021 16:54:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3BCF2606CB;
	Tue, 10 Aug 2021 16:54:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA54FC001A;
	Tue, 10 Aug 2021 16:54:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9ABB2C000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 16:19:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8ABAD60672
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 16:19:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id krXDbmM0nKjO for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 16:19:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 112B4605BC
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 16:19:34 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D515600CC;
 Tue, 10 Aug 2021 16:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628612374;
 bh=rUrQspPgCz1GB/kLMPpAV5Oz5uFIYwUtwRxo8l8CgxQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FoKJI/tWK/6kSLtIxyJfheigFp9Dbk39gOIdQawyWlg/IV94uf8MeVLmFCk/QQFGZ
 nrURh8v2Y/B2Ah/51rD46AOuFfzffVzne77EWYedGNlu+fHlDNjC/TI0ahcurePvdQ
 MRbnVzVIw3VloWG+nu87QnB1v4o+O5LBh8KhXkybvvbw7+Z0+xXZajZMOnP5Zy6vMx
 yYLnP9WMwnDJVHB+x0oKDdtdOqdf8pStAfdCAqjQzZjXJxNo/bsOltJkph/KE8sFoa
 J/M+fytEJTw0ReNNrAkT0GAGy4pF2vseBrTdWNnLtxsewLz4VYcDA+jV7RlAr0AEMR
 jXgBkj8miZhkA==
Date: Tue, 10 Aug 2021 19:19:32 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Subject: Re: [PATCH v3 02/14] x86/boot: Add missing handling of
 setup_indirect structures
Message-ID: <20210810161932.wdwfu3wosjytdj4h@kernel.org>
References: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
 <1628527136-2478-3-git-send-email-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1628527136-2478-3-git-send-email-ross.philipson@oracle.com>
X-Mailman-Approved-At: Tue, 10 Aug 2021 16:54:15 +0000
Cc: linux-doc@vger.kernel.org, dpsmith@apertussolutions.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, luto@amacapital.net,
 iommu@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, kanth.ghatraju@oracle.com, linux-integrity@vger.kernel.org,
 trenchboot-devel@googlegroups.com, tglx@linutronix.de
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Aug 09, 2021 at 12:38:44PM -0400, Ross Philipson wrote:
> One of the two functions in ioremap.c that handles setup_data was
> missing the correct handling of setup_indirect structures.

What is "correct handling", and how was it broken?

What is 'setup_indirect'?

> Functionality missing from original commit:

Remove this sentence.

> commit b3c72fc9a78e (x86/boot: Introduce setup_indirect)

Should be.

Fixes: b3c72fc9a78e ("x86/boot: Introduce setup_indirect")

 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/mm/ioremap.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index ab74e4f..f2b34c5 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -669,17 +669,34 @@ static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
>  
>  	paddr = boot_params.hdr.setup_data;
>  	while (paddr) {
> -		unsigned int len;
> +		unsigned int len, size;
>  
>  		if (phys_addr == paddr)
>  			return true;
>  
>  		data = early_memremap_decrypted(paddr, sizeof(*data));
> +		size = sizeof(*data);
>  
>  		paddr_next = data->next;
>  		len = data->len;
>  
> -		early_memunmap(data, sizeof(*data));
> +		if ((phys_addr > paddr) && (phys_addr < (paddr + len))) {
> +			early_memunmap(data, sizeof(*data));
> +			return true;
> +		}
> +
> +		if (data->type == SETUP_INDIRECT) {
> +			size += len;
> +			early_memunmap(data, sizeof(*data));
> +			data = early_memremap_decrypted(paddr, size);
> +
> +			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
> +				paddr = ((struct setup_indirect *)data->data)->addr;
> +				len = ((struct setup_indirect *)data->data)->len;
> +			}
> +		}
> +
> +		early_memunmap(data, size);
>  
>  		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
>  			return true;
> -- 
> 1.8.3.1
> 
> 

/Jarkko
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
