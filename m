Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C37B6C433F5
	for <iommu@archiver.kernel.org>; Thu, 31 Mar 2022 16:23:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EDAA812D2;
	Thu, 31 Mar 2022 16:23:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R0GEck-iwjwV; Thu, 31 Mar 2022 16:23:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 23B32812B7;
	Thu, 31 Mar 2022 16:23:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA4F1C001D;
	Thu, 31 Mar 2022 16:23:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74CBEC0012
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 16:23:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 625A661346
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 16:23:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=yahoo.ca
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FaQqyK516l7w for <iommu@lists.linux-foundation.org>;
 Thu, 31 Mar 2022 16:23:30 +0000 (UTC)
X-Greylist: delayed 22:22:13 by SQLgrey-1.8.0
Received: from sonic301-22.consmr.mail.gq1.yahoo.com
 (sonic301-22.consmr.mail.gq1.yahoo.com [98.137.64.148])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BB3CB61324
 for <iommu@lists.linux-foundation.org>; Thu, 31 Mar 2022 16:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048;
 t=1648743809; bh=vh0mN54GaPK2olsZPvxEEBFBlhw6zVFMSWnf5S6k/K8=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject:Reply-To;
 b=lUG/t005sV86fkrmw7jO6ARLqmcI/rvGuZSbn0hN2oCmZjxNWr5XsTunls0YtfvbYcbq/+qexFt5FdS+uZfLyYiwrIXTAwK38NS29m8aMzX9FzM2yf5GuyGS0Gdv4lUSPuzSzc/e9zcs8HEMpFoyg05YcHyI+tvQ/HfEPOWQaWbcd15SouKl8r9NO+fRdNx0aRIqBInU8mQU4/UZO8CSzTYpQfIGRT7zN+McUr6W0hn4soNu5omAzVNvnntJKFc2yuxvSj9a8uReAz7+HcPTaqo5IPiwxgmsv5ROVV70r7PJNrAI0DLE3ZYqAEl21j+qrkEGgrK2pIlwkuW0nndlgA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1648743809; bh=qPa8ahLJRVoqFulp4q/eRPQp66IwnGI/8i5JIBZYKES=;
 h=X-Sonic-MF:Date:From:Subject:To:From:Subject;
 b=KB1NtuYmPn5m+4K2EVjKgb2lZHQvN0E+uwcWZ/244BbxQ/oRxMmmPi3+Sre++YuABXusOAqQcJ2KfYNZMFF6UKqKLbP7ZWSXDPt/IQWqXlug16UnRaCrmI0Tc7FLF5fGv5S2zeVdveiDMUmfh5UgB/F5UaeJAxjMyegzMVKtWqRjKIQSiG/1D9zuSYmu78ihv0iQemYPpbx11eC7GtON5v1zAkUuxJQGjsphILWeZe0K4+t0jB+OpsTcWoiPnbRRZqbEDzn6ioC0wAO+nYZnuKVdB0zB2nPp4D4JnlMYlVIpPkfmJwv5HgELISlDKxenlS0WeF0Up6An75nJoYq8UQ==
X-YMail-OSG: Vm2v7M0VM1khhNMOPyt8w12a5p9m0922buS4EdHIeYfvsECbJb3Go9GEp1C3z2S
 bxPWhMvlBLNKlYlB_hjn9Zmj6o_eOgAAaGJ6dlSHGHGKxqj_IAEoDjZ2a4piDKxZ7BEY1lU1B1JL
 P0IfuFBGZ3dODUl8bU5qNFf4q8wX8Tsr5KZgfaFZMxw8hFGNK61RoU100FA6Dxftz4PJ3_XI21kr
 kuhOkI6HCZpa54_jheZ4JeD8K7si_Hm4nWQzMBxV2qld.QoYoLEnqcpHL.mApxO5wLxBoV9.MFww
 HxoC5sI74swndC9Pgta1S_37ZPsNIhGETWexQ3MV_XrzqbC8rOd1i.iqImr3KziHqcVd7ssfjrM.
 j6uvPD70XxJmKWEJ9INsry2gns52Usv8AFMSOvdj.DqF.CBXoOTlYhk5114FJZsuFZkkcKft2xiq
 jitnrT7HSeVWZQdXKxzYKauqlIP.7TyM6zQ.RAMNbsi7gAszwylXFTwqvB34ZqJ38ATCVTngtDlq
 EfazQnvA2JhfV62mIEVi8bE.pTM54JqO982BEKUiuHy9Gpw4Wryh_T6tfiLhg40csYcYDINDHpv8
 4bhCZs5Etelj7kwVJvjBZ1DxtHjGIpMz9_C8Xua7thgkNkDT4KyFmbOdUOlFR91.lgtRgD0D.X9z
 Uy8DjqjAaIe15pPVqY2_Xwe4RQnA5_1WNUeXF8e_yM_c3G1krZZn_h4EBNt8XFdf_nkVhccsFCR6
 V.77_k1vs5RWPAjqenRvPkln7es962ppiocB5pvQrTvvKzJZ40ew9T81W.YRNEfCgbJ6peoZudrC
 PfmQ.YIAz1cr5lVv1HKsFbuO98MCxUYU7jaGsxIONpU5.ro8yNzIVq_41PGOlsLKusDIxY2rMn3w
 GyQB7uaEQ7y5zTCAadkbbJNN.t59mbSzSX19Y23QTxDjUF1eFQwJfUbKXbJkZFG07lybb4i6t0.z
 .K1C63_ybB1gE3WcL548t5ToIRgDzs40AJLi3._S6xXTJHmDhrr3IZWqwejtBf9MSE4LCs9VBAsy
 eq1UHRfkEUDlz9IIDf_eK_fi7n0NYKGB_Lifxh981OakIiU2iretESzW.pu1m3kGiXpmU21o6.Gc
 Q41e1c8E3uRdFfIF9GiH2QwtTbgD8h4H3Q8N4VXGgYtM3eGc8E0zTnj6VMgL2HJFjazzV_9awzeh
 0apOVkiME3nNZmm6NHq.Tk15cp6zUHLDXja6KdNJKtmJEWAwlgSf9WLSaxuuEHWg_OitXM_ARf5G
 54fxfqzy_UTGAkTjbg4WGwE_k831rG3.5MSsJwGiMicLIjsWSuLSCEBv2pUOEEfiNmC5zVKyjS53
 DdPUJW7ORiqAcEYFoio5Rx6qtsQmGWsOwSmfwLDUcR1d5BixM3sGeXpRHPAmwcljCvj7aREQl2bH
 Qb.2RVmLM6XLz5STHphwy9gaoN5UvjUv3w8w3jcPOJNkqKYlSzqArIBEiWCUBkp61njYdU31wCrO
 z3H8Olk8P2ndkdfamGhy8Z07H9HtBQTo_Qr83kw2tX.W_BU5fVgKr4YogyHuF1kz.QuZ1d2CYjKW
 5a5okEqIRtbxuoJXgGDd18Otyjc5bAty3wzTcuqOAaaY4L8WNoHZS4W4Qc9Fxqs20uixR4oclJ5T
 ksZ43uY_YSJpdIcSwo3SA5TCEieBtzrID.gg1AtRks9l6sW4UpHLxYBbvxTNBwy4vOl9tCCEmyXH
 BG7v0uXISB8rA8xgFdV7cmGRmtyXngz6J.aUGDvQJwhyUd7359kN.IXqRiAMY4RiD9F8d20LK6hS
 P.g8TMoz.VhvaVi38p4rwcQS5hHn_25Dxxcw0sIlljbEVxj7nCu0SuxyWRTXzvHSzNEVeiSLOvmC
 fuSwg9HGBhYSBaJ9WffjxzOadZ._aEtfytEK9D33fc.aovHoWHyd5P07h0T1W38FccPexF6Sqemf
 nBFgrvqv302v5IEBnRh8jXJKAtYoSKmmgFGj32s_6MrGDQCvlBSr2IrOoL8_h.szfGl.CQHYDhNo
 NPNpaLLIJVWAKoiVXWrinegfb6QGabtRTmyBig4ek.fwLpm5skeYUg1VhENvwmchWwrQbA9TDpXv
 BOyIZz_1SZO1QF0KVVCFEnXbCjBjf9gKwwxP_FnGOdCKXfo.j0qgTbyptQCfQnWLorqoCN7A98hV
 yd4KgByl9kcTAdASx6CEOfbFZDed9OzOGBWpJQ13G0h7LbNmxI8C2ZIvkEVcbZZM8RxqBbSwWMnA
 xT5dF.cQZYQthSFd7nOUihArtPbTAVKe9RqXfaDE2_jEn3Y._iiH83.qQEQl8TspK
X-Sonic-MF: <alex_y_xu@yahoo.ca>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Thu, 31 Mar 2022 16:23:29 +0000
Received: by kubenode531.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID 82036486bf6898d8a478e0f881737164; 
 Thu, 31 Mar 2022 16:13:22 +0000 (UTC)
Date: Thu, 31 Mar 2022 12:13:19 -0400
Subject: Re: [PATCH] dma-mapping: move pgprot_decrypted out of dma_pgprot
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20220331060627.2872150-1-hch@lst.de>
In-Reply-To: <20220331060627.2872150-1-hch@lst.de>
MIME-Version: 1.0
Message-Id: <1648742102.xmws9oicm6.none@localhost>
X-Mailer: WebService/1.1.20001
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Cc: thomas.lendacky@amd.com, robin.murphy@arm.com
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
From: "Alex Xu \(Hello71\) via iommu" <iommu@lists.linux-foundation.org>
Reply-To: "Alex Xu \(Hello71\)" <alex_y_xu@yahoo.ca>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Excerpts from Christoph Hellwig's message of March 31, 2022 2:06 am:
> pgprot_decrypted is used by AMD SME systems to allow access to memory
> that was set to not encrypted using set_memory_decrypted.  That only
> happens for dma-direct memory as the IOMMU solves the addressing
> challenges for the encryption bit using its own remapping.
> 
> Move the pgprot_decrypted call out of dma_pgprot which is also used
> by the IOMMU mappings and into dma-direct so that it is only used with
> memory that was set decrypted.
> 
> Fixes: 5ff79fddf0ef ("dma-mapping: remove CONFIG_DMA_REMAP")
> Reported-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/direct.c  | 10 ++++++++--
>  kernel/dma/mapping.c |  2 --
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 35a1d29d6a2e9..9743c6ccce1a9 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -277,12 +277,16 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  	}
>  
>  	if (remap) {
> +		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
> +
> +		if (force_dma_unencrypted(dev))
> +			prot = pgprot_decrypted(prot);
> +
>  		/* remove any dirty cache lines on the kernel alias */
>  		arch_dma_prep_coherent(page, size);
>  
>  		/* create a coherent mapping */
> -		ret = dma_common_contiguous_remap(page, size,
> -				dma_pgprot(dev, PAGE_KERNEL, attrs),
> +		ret = dma_common_contiguous_remap(page, size, prot,
>  				__builtin_return_address(0));
>  		if (!ret)
>  			goto out_free_pages;
> @@ -535,6 +539,8 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
>  	int ret = -ENXIO;
>  
>  	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
> +	if (force_dma_unencrypted(dev))
> +		vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
>  
>  	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
>  		return ret;
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 559461a826bab..db7244291b745 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -407,8 +407,6 @@ EXPORT_SYMBOL(dma_get_sgtable_attrs);
>   */
>  pgprot_t dma_pgprot(struct device *dev, pgprot_t prot, unsigned long attrs)
>  {
> -	if (force_dma_unencrypted(dev))
> -		prot = pgprot_decrypted(prot);
>  	if (dev_is_dma_coherent(dev))
>  		return prot;
>  #ifdef CONFIG_ARCH_HAS_DMA_WRITE_COMBINE
> -- 
> 2.30.2
> 
> 

Tested-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>

Thanks,
Alex.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
