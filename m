Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B3225F98A
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782402717; cv=none; b=aIyQp3UW5DMlzsGnE0O0/z21DWad6QA465BGMNJ7J1PUBCsZSDqzfK9QGumjdn2cuNDsyn0huDyh6XrtjhLLHwoFVkgNdY6MigZZuHqjnclWLxmPR6Fji+d+Df1YLGu6gFKlYF+q+1ZvupHsbUBFxzWyPJ+1bEMoPmFkxEHMcks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782402717; c=relaxed/simple;
	bh=Khk+EgWMgrd/fcIfSlawiG1GabII3LIvD1WbEgg6eN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzZXeZJtl7bDqmlv66inOCnuPnjAU0B2QuTKYp3FJMD+MIXZP0Rf+ALlriV3EghKu7RdzlpoUZr8tL9yQZjMsve5Xd3bDtEC/TaajOQHYkxzymXTRUDDb4SlLMk9w3cCFiH2xehBBhBuzjuaMXyIVhbyBbB/PhQRiuqpBWpB2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bgA0McvA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NNOwoYkJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bgA0McvA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NNOwoYkJ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65PFeMew2737434
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 15:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XaN+L0rplw4GK7Sfc4WHtZLm/QYscT75GFb5hPkpKto=; b=bgA0McvAmFJLtIls
	L/buW7JAYI9PfSDopgUvteWZRgcR/N5FKzN6CPAn6aoklfg7vNbD2F+czjeGAs57
	duWQR7LM7mcfYrf9JKD7zLe8tmWfxQ9VikSWevJw4AvvfH5mvk2THdpe0C69sYT0
	Wl2gmeVXHjw9r3gfyGpxtj/pO0kPIeZoTOZYezeZD62kVgmtytVHnUiF+l42iYep
	+LRMNrJbJJjw5iUu+qyCDDDg3PbqF/1ielieE3RZJmZhPZiD9WltuWyumNhtYAT1
	fHnupap2l1GOf3hIJb4U/Ru7rY2Wacqc9tEfnb7S45bi9ehRNBvJ11PMBz6+6thl
	GrPamQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ya8t3bs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 15:51:54 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1384427c3efso110730c88.0
        for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 08:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782402714; x=1783007514; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XaN+L0rplw4GK7Sfc4WHtZLm/QYscT75GFb5hPkpKto=;
        b=NNOwoYkJu1MRfihi1z+0Z0Ff60azoyTcevxySt71IFpI84awopxf1UA7yj0H9InsaQ
         +dB3TUOLyHt3fQngvMtt/Kl6ISJ0qdW03CNffh9JYPgem12Ll71LMXXKiGDvKQ3h4Voo
         SA+s9karmynh+UjOqA+wNtWRaYdK/uGy5wkkQAROIRdFm09537Z1Z11DE0lZu/9xo+9h
         a1O25zq4jdPM8cAQbop0vDtAw++sTFHPPS+Byy9i2Qq5631xpoPynB3ykPur9ZnnOYmS
         KP7DS5jB07mG5K2v/KnpX3231OqhViBdQa/o0FA0Oni/e2ClxDxyt0JK8CJjdVGQ7XQ9
         STsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782402714; x=1783007514;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XaN+L0rplw4GK7Sfc4WHtZLm/QYscT75GFb5hPkpKto=;
        b=IzXrbT8QGBnX+ntPLNjncu09ZjZIBb8sHCuWPJfFyVlS+yyzkKQZvTFveDEizGuUUk
         upvSAzfvxyMQmF65cYPVA6QUZBLg7flfHkYYOvzYhk0qJCZMzO0VwHZX4B3S3md7ylhH
         1n6T/tM4RIlAWltrvik+/y3FbLuZ8vlb56JnHN/p8BU6VtohpVnHUVNBpR9+4ltoZMNp
         XolgK8k91B0WM62+SjJ6amyIsTYJ4Qy03mj3Agxt/ImwqQz005tYELqs7lAYsBXMzicJ
         ZceLlEK/kuZYP9jncHtlOm4G6HYpvcyDzjQaR5v4wcN1U4iDEjTxqXvhh/2JFXuxvFQs
         LU4Q==
X-Forwarded-Encrypted: i=1; AFNElJ/QseE2+szcN0LBrCF/cQcgX+5RDt8FejAPd/IEQfqBhEIKuvnzF20wAjdMEsCjtNsn+8n46A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5l+dYp39PXMBm5pa4LsZ6nGmWHinOUtGFLQBDWQXt+RIkPU7n
	icqvqLRtbQv05EAGeX536xdG03DezYyTdSAIW9CoW1w177862MbjhR63F0ZxhhHWlOREadOjj3N
	VT11J6RLOtxuf5/m0JnS/lsiW1VRJ5kIKMWe36rebHTFb3L9jaO9spnpwZQ==
X-Gm-Gg: AfdE7cl1QmbJ1Hzr+92VF+0FOB5YCY0fmJ8VNzYxCcUWlHx1zSiLKLw035Ifm3FzLp7
	ird7AE1G6ikfq3DU+jQHPf4BBp7YwoBHov5U5/EqElFBAdk6R1X3rKr1Rbn/MNpRSSnTXr+hvG1
	VskKtvbhyZxfdVcNgCHnjxAXHl9SoaLSt31wAbKLfuJuEmXOy6xEiC+r1BVKT//Z953ujtt5hSx
	SzDKANZ/5UvQAXco3iAcsOMaRCJ9H3imljcfynKO0m9zyMGVdjt49lyxwGJfdJ+oq7Woz7nRZEo
	g3EGj1Wr5gKnDOrLicDK5Vri/LQXrjjWFCORSm8QxMK8Ms5cvTanCWg22a8xjWEfxi5t57/PPxI
	IBTPLgv8xtuIpWx9zOIB5uscWrb9y0KLxpg+Q7fVUAGEY+kDoYnIJ9Ns9JDDh
X-Received: by 2002:a05:7022:160c:b0:137:fec9:8ffb with SMTP id a92af1059eb24-139dbb69b90mr2427654c88.25.1782402713727;
        Thu, 25 Jun 2026 08:51:53 -0700 (PDT)
X-Received: by 2002:a05:7022:160c:b0:137:fec9:8ffb with SMTP id a92af1059eb24-139dbb69b90mr2427626c88.25.1782402713025;
        Thu, 25 Jun 2026 08:51:53 -0700 (PDT)
Received: from hu-ashoraj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f77602sm8736337c88.8.2026.06.25.08.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 08:51:52 -0700 (PDT)
Date: Thu, 25 Jun 2026 08:51:50 -0700
From: Ashok Raj <ashok.raj@oss.qualcomm.com>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, robin.murphy@arm.com,
        joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, jgg@ziepe.ca,
        kyle@mcmartin.ca, ashok.raj@oss.qualcomm.com
Subject: Re: [PATCH 3/3] iova: defer maple tree erase on GFP_ATOMIC failure
Message-ID: <aj1OlqBtTOUSFm-h@hu-ashoraj-lv.qualcomm.com>
References: <20260624030853.2340880-1-riel@surriel.com>
 <20260624030853.2340880-4-riel@surriel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624030853.2340880-4-riel@surriel.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEzNiBTYWx0ZWRfX0zogLzjgJBbk
 kML+3NjRm9PfMh7auC8ZUBCgg6ccRidMkUI2NklooRz+8fif48wCUpmxqu9hspbGNpQDBKhPlRE
 hhSpkAVu2KunMAZN1W26HuNeK7zX3C4=
X-Proofpoint-GUID: 0my0Vdu0kkdyRiVE03xPl84DL-zZWQxa
X-Proofpoint-ORIG-GUID: 0my0Vdu0kkdyRiVE03xPl84DL-zZWQxa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEzNiBTYWx0ZWRfX4qc2uRGG6HtR
 Y11DavgLxUONFASuDCxhrEMu+sAF6HPJxyrYBql/d2/ZM0tMNWOebaz2cZEjXEObOB049r3BY7x
 rmMZRGy2iVDz4tBLK57lzY4cfXVtiAXw0oxouLpkYL0843S7IPGifMG2iAQF9pY/nKPzchv2jrP
 oJVJfely1FkSIx5OY/q/NZ9Ri8PzAaeJWhyj8aamcfoqrHR2eG/IHrWgJGZQTYwNEHBq0ilJKgw
 g+Xd48b1Y+yAbTOczsxYmllZtMZD7v6XhH1Gvi4YzB/QhAMuwrl9GSUrQ15bQkGqJ3SIQHvfPED
 qs6woDyqOxdKfe+m014JGfSzOgbsiS31zYSkgSZC5EmrPzXeRrn9UCk6q7gtK3UFEZl4Q5Fvk+J
 od90Nk7YtiKtATQJPb4Z+70jd8bMRogJnGYhdftfSH9m2DC0pmatvb6DAYpAMuWiTl6SxFSAmLW
 BmjNVX8+1jB5rX1WPLg==
X-Authority-Analysis: v=2.4 cv=Z+Xc2nRA c=1 sm=1 tr=0 ts=6a3d4e9b cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=mOSHGkzkEfEHChMdZykA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250136

On Tue, Jun 23, 2026 at 11:07:36PM -0400, Rik van Riel wrote:

Hi Rik,

  Thanks for the v4 redesign — the in-place marker approach is much cleaner than
  the delayed_work/llist scheme from v3, and it directly addresses the
  retry-forever concern I raised earlier.

[snip]

> +/*
> + * Remove an IOVA entry from the maple tree and free it.
> + *
> + * This runs in atomic context (DMA map/unmap can be called from hardirq,
> + * softirq, or with spinlocks held) and must not fail. Erasing an entry can
> + * require a maple tree node for rebalancing, and mas_store_gfp(NULL,
> + * GFP_ATOMIC) can fail under memory pressure. When it does, overwrite the slot
> + * in place with IOVA_DEFERRED -- an in-place store needs no node allocation and
> + * so cannot fail -- which keeps the address range reserved (the allocator's gap
> + * search treats the non-NULL slot as occupied) and lets the struct iova be
> + * freed now. The marker is erased later by iova_drain_deferred().
> + */
>  static void remove_iova(struct iova_domain *iovad, struct iova *iova)
>  {
> -	MA_STATE(mas, &iovad->mtree, iova->pfn_lo, iova->pfn_hi);
> +	unsigned long pfn_lo = iova->pfn_lo, pfn_hi = iova->pfn_hi;
> +
> +	MA_STATE(mas, &iovad->mtree, pfn_lo, pfn_hi);
>  
>  	assert_spin_locked(&iovad->iova_lock);
>  
> -	if (iova->pfn_lo < iovad->dma_32bit_pfn)
> +	if (pfn_lo < iovad->dma_32bit_pfn)
>  		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
>  
> -	mas_store_gfp(&mas, NULL, GFP_ATOMIC);
> +	if (iova_kunit_defer_erase || mas_store_gfp(&mas, NULL, GFP_ATOMIC)) {
> +		/* Erase failed: mark the slot in place and defer removal. */
> +		mas_set_range(&mas, pfn_lo, pfn_hi);
> +		if (WARN_ON_ONCE(mas_store_gfp(&mas, IOVA_DEFERRED, GFP_ATOMIC)))
> +			return;	/* in-place store cannot fail; entry stays put */
		/* 
		 * <-- deferred_lo/hi not updated and range stays
		 * occupied for ever?
		 */
> +		if (pfn_lo < iovad->deferred_lo)
> +			iovad->deferred_lo = pfn_lo;
> +		if (pfn_hi > iovad->deferred_hi)
> +			iovad->deferred_hi = pfn_hi;
> +		free_iova_mem(iova);  
			<--- only reached if second store succeeds?
> +		return;
> +	}
> +
> +	free_iova_mem(iova);
> +
> +	/* A successful erase means memory is available; clear any backlog. */
> +	if (unlikely(iova_has_deferred(iovad)))
> +		iova_drain_deferred(iovad);
>  }
>  

  If the in-place marker store fails and WARN_ON_ONCE fires:

  - free_iova_mem(iova) is never reached — the struct iova leaks.
  - deferred_lo/hi is not updated — the address range stays permanently
  occupied with no way to reclaim it.
  - After the first occurrence, WARN_ON_ONCE suppresses the warning on all
  subsequent hits, so further failures on this path are completely silent.

  I understand the comment says this cannot happen, and if that guarantee holds
  then it's fine. But if it can, a BUG_ON might be a cleaner way to express
  that invariant — it makes the intent unambiguous rather than leaving the
  impression the failure is being gracefully handled when it isn't.

  Happy to be wrong if I'm missing something about the maple tree's in-place store
  guarantees.

  Cheers,
  Ashok
