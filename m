Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984533C109A
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045424; cv=none; b=KDlLcmaSsg9r3Ug1uNjhf3Eg8qyOvZjQo0uKSo//tfPGgVBhz4Sy2uNnSsBW3uNVxunawXkSDpN6kbtxUARxnpjOL8Iyk8hpTb6ivHh6tsRLEAqVY+eHMOanjNDq5GLtaJCHXxQrMR6WtKI/2n4wQP/HeLwjM5j9PXU2kQ3ig4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045424; c=relaxed/simple;
	bh=u/BWCSgfFG2ljiQOHjptAUguARK/FOBMk//P2B/w9ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK16bF95bN6jyFR8+ajJdsiv2HYgRrOiLquXdAQED4sdZGM9TNo0Gjcfdd+kCInbMUcmN4ME5674dEImQa+sojVjvkUN3iOKNqA5ufZB8tUj002Y/t1fpeMqWAqWKwO8F9rndyU/HXopvyajkm9bqQBOysPG5irLS3Ysn3HgsYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kEKyJXPV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ghvcfOaV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kEKyJXPV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ghvcfOaV"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I8BIO8325432
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 09:30:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LXlibvlGY1oX1qWEiKzlvaaM
	w4T84Ny5R2TwrL3n5og=; b=kEKyJXPV3vXHQfI0ndkDEhzsaBksjjyfmzKyk3wL
	E8vb35VTADnpVtdXr8Vo3IZer8gSLJkSmAVhLXbraQg+HR5San5dk73bGJTnGvsK
	PPx1LaAteWqeAT0oawvIOP/ILSJz5x2I1ymMx3XuYvSzCBG1umUc+glh6jB34P0e
	W+O5AV0Hk0aiW4InxYLzEXR8nE2qAWH/xHwfY1yp39R/pRJ80S0mbWA7iznXXjEq
	a7zOpkKuSo6UeLLt34Bpeme7dEhsBeLMAkQ+6doQao6FhzhZn0NLjJy1Vd/PhUlB
	S04PbAFmmRsf27AjOkA14kaRoNSiYZ7YATJrHwuBH1VFSA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4eqtsmed-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 09:30:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-934956beec8so740891485a.0
        for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 02:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787045422; x=1787650222; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LXlibvlGY1oX1qWEiKzlvaaMw4T84Ny5R2TwrL3n5og=;
        b=ghvcfOaVJAbINn4lhIhOodmK6dFQ5cjoKuI6j9E5dGZTWAi3wEU8abuv0kyls/h69f
         9/gsMM94GVfN01G7qXtUIL0+J2RkEb7VFK5kNsDKxSwmZeYd59FBOCQG3mZ4rdl2s+mk
         FGee5McPP6T0prHsol6FUqvEPgcBqjVF0BWaJJSOwrYKIl64Bd+VB6b6LzAcch9nlxHa
         nskGw9ai1FWvtpTEoke01N65qnApcwtUrH0oFDNtODIW35PgBUmFEY4ICkEMnI8d24tL
         WAZX46jAJ7XxaKlsGB9zdVgWSEg6jORyt8GNKkUBljucNoobEm/n1FdmBHq+pUvWI3wC
         /EmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787045422; x=1787650222;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LXlibvlGY1oX1qWEiKzlvaaMw4T84Ny5R2TwrL3n5og=;
        b=X5Xq9CNahhfjqdA8yngTvSdhsKN/6I5GF64hgQct554cNUW+2t5FlGbrhoiEKFoHeQ
         L0L+/rUvVt202lgfEdidOswbSERUh4Iqy9NiJzWt6KIwoINdwtZCpinVrJ6eFvEfwiMm
         0MLKRo6fNFuPckh2m+u58uCEDs7f9yD83GeHpBuF/PvkE3SXNvQNdSnhaKYZmLz9yxA6
         ENsxqxwvjcOhYCuobGFS8XcsBCGBv2OQzVE1Uc38VkS0GTcQtN/4wKoy7YBR1q6bt0CS
         gjV6N9riehJx24V1p8Umi8Mkm5SDIW0AEIxuFfbwlwK6mlDBaiYBADEH5AzQhFYCJOSR
         QM8g==
X-Forwarded-Encrypted: i=1; AHgh+RqkDQ88GlOnib8B6vRya3LJFfkJvSQKzJTsLA76IQNIraHbCY6M2Zxgk/qIAZSHgaM7C25pCw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+G6RpOPGsdTKvlK5nP7jdRyb5hvI5hKk/jK9qGA+pywKmeOFG
	GeteYTEyWgLy30nU7FHD5j40ZlKDl3//nzKYbuRWvIHQkQhnbHv+T6rK7p1VcqTnXp4nZkCIUL2
	wuWBLwVlrhMtEt1HJPJ7sylh2LZQkKoIsqcORkT3IV6/f9Afp6P8+yzxREA==
X-Gm-Gg: AR+sD12cOdI5M2o0dBnawf0BCX4On5m+4wMUBUr7yfEtOkrudYcaJ18pMX4W2qWHBHE
	bMFKf59k+OZ78x5kX89Ofpbi6sCROdJZSpZFFQjn9rhzERY8ryGTxiUr7YQ/Fv91x/UXPXpkE1Q
	LSkZE5PnYjyenTUcMsbM1fDaCOtI9Nn4sN9q0din/qUmNciVlMY4I6XqTTySLH24lg6VpDVD21e
	6ZuB3u/tlaxh3YaL1RKNy1ndSE9DK3pkuwdr6ZY8BuAH4Dr+sXIBeXGLCy43/8IvMdH2IeSEOCG
	bQ0uxiYgRpIaPa1qe4hDhrxBPHZCFeZW6mrl3GirBW5lBdKD7JirnhKoea4gVe4ofcqKdmJqpfg
	Su4aBhqSaf29exmpT6vDEwu95rh/rpt00cS8=
X-Received: by 2002:a05:620a:5cc1:b0:914:afc1:c66d with SMTP id af79cd13be357-936d201c77cmr2678125985a.11.1787045421773;
        Tue, 18 Aug 2026 02:30:21 -0700 (PDT)
X-Received: by 2002:a05:620a:5cc1:b0:914:afc1:c66d with SMTP id af79cd13be357-936d201c77cmr2678119885a.11.1787045421397;
        Tue, 18 Aug 2026 02:30:21 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961098cdsm260422965e9.6.2026.08.18.02.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 02:30:20 -0700 (PDT)
Date: Tue, 18 Aug 2026 11:30:19 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        tjeznach@rivosinc.com, jgg@ziepe.ca, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, vasant.hegde@amd.com, anup@brainfault.org,
        atish.patra@linux.dev, skhawaja@google.com, jgg@nvidia.com,
        guoren@kernel.org, kvm@vger.kernel.org, iommu@lists.linux.dev,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 01/10] iommupt: Add RISC-V Second-stage (iohgatp)
 page table support
Message-ID: <lpnxdqyekcczbyxo3n7zxpbj7243gixdzutvngpvr24ozmc4jt@nsoblujgprhe>
References: <20260507113706.11400-1-fangyu.yu@linux.alibaba.com>
 <20260507113706.11400-2-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507113706.11400-2-fangyu.yu@linux.alibaba.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA2OSBTYWx0ZWRfX3QpHD1GlUrcY
 XP4dUoB/hkfl00aDsugfgSzpwSTn2TMUM7q++Mu1ayyOg3LLHWsQIFv0QJLG9jr+amyDY+k9nGE
 VhaJ8RQWyUpKvJCvhgCnT1fPFqEDgEM=
X-Proofpoint-ORIG-GUID: rQwefLsZ9x76f_xxEdQJCUz_tRNz8uED
X-Authority-Analysis: v=2.4 cv=UfFhjqSN c=1 sm=1 tr=0 ts=6a84262e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SRrdq9N9AAAA:8 a=0xFToDSQ33sWTIcn7J8A:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: rQwefLsZ9x76f_xxEdQJCUz_tRNz8uED
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA2OSBTYWx0ZWRfX7nEu5dDzszBM
 aJpGnXl7+dprFDCrhmlI+CqJVPKlKZbmRNoU/6o7vPJxmoGQocSUoYFuVDYKlCjKrrJhcTCh3f3
 vVAt07u8pXOT1Uh4hejuz8JZTcV5KzQ4GLsimZXAk8yqFTSz4z7ISJ83iBnl6Y0ib+2vcIMHVwP
 w9AbjLJymAfHEdl1miujEdTKYLMJe64EoyfqG9UWb9/F75Ij35GDPmrKm0Kti+yva8LBQgVSdjY
 COdu3uhGfsOZzwXh765wg7PsH3jkmzkWIKN8hvpR1RxOJqJIm1eV0nWUJcIgf1l7fLzsO83wrJo
 c9qK33FIPYuIQvHDr/nXpbuGlapHiTYXD0G6KCL8KpTp4SKNeNz0W8sreqJJiVRHIRQMewfORFT
 fTD5o21se88GoT6UQpKWl3I78fEsuVSP0gffiQEatDaPvamekna5Mc/pIBy+LCG1C1s1TSe+wGc
 R3QKbO9KLaH2S3DTHdg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180069

On Thu, May 07, 2026 at 07:36:57PM +0800, fangyu.yu@linux.alibaba.com wrote:
...
> diff --git a/include/linux/generic_pt/common.h b/include/linux/generic_pt/common.h
> index fc5d0b5edadc..59448125159e 100644
> --- a/include/linux/generic_pt/common.h
> +++ b/include/linux/generic_pt/common.h
> @@ -188,7 +188,10 @@ enum {
>  	 * Support the 64k contiguous page size following the Svnapot extension.
>  	 */
>  	PT_FEAT_RISCV_SVNAPOT_64K = PT_FEAT_FMT_START,
> -
> +	/*
> +	 * Using second-stage / iohgatp address translation.
> +	 */
> +	PT_FEAT_RISCV_S2,

Hi Fangyu,

I just sent [1], but I actually discovered that issue when testing this
patch and finding PT_FEAT_RISCV_S2 was missing from PT_SUPPORTED_FEATURES.
So this patch needs the same fix as [1] as well.

Thanks,
drew

[1] https://lore.kernel.org/all/20260818092444.42755-1-andrew.jones@oss.qualcomm.com/
