Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE2B21ABD7
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 22:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778021236; cv=none; b=h6i8rwMvDbd9HEnPRSzFrqFL/cpK1CKktAyWYi8wM3DEB3oKMvcz5+9NB+dBk1BeEyov6LhlWT+YWJZwOoxxrxJF+/3XN4LULhyYrEPG9CoTwLTL/ad2aqPx6TxlIdYKaUSXscT/VEVEzV+GqlQ8zaiU9DuZgci45lwztmz0e9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778021236; c=relaxed/simple;
	bh=ThAZON2qJ1bfOCpmOWqCdEaMPjyOeWFL9PwzOSaVDHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEajqXYmLVBJmNK7WzSxrXJ/tZ6ZwkAHKVz1+ty8D4rgD+qKFsc8zGlxrIaDW7xd/6FTY6DfdYt6kMCPf9ez7fjkEe6xkwzBKVXDvbD/7+6ppfNUXD8XTzr3xPeKvpA8lmQJOLWpHlmiuHtVDogXru6ruqELaTVX0OseYTpLaaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nGLZ2qSW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UXp92ayj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nGLZ2qSW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UXp92ayj"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645LOPwx3475816
	for <iommu@lists.linux.dev>; Tue, 5 May 2026 22:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=80QsdjvMKgByQ+N3vQwQVN1P
	Ot2Azp0fZNR7U+S/ywA=; b=nGLZ2qSW7qAP5IVLc38deKesNE4nEEYyU+ewj6Fz
	7BHEEClAsMXCAyFHJckZhk3z+nMe4UQQx4I39gumjZrmCnUch5jJCoKvQLLbVpqG
	Cu6uTPx0UgrYCDeZrs+t1xG65UADU/Wq/tr6DVhgTylph7zQiaTPgB/ohRlpLS9Z
	iWu/cjQrz+Z5GlHc5uvoSOkus2kGFIbdZz2P6ldJzrhoVBg/6BstxoQj9NSHicz3
	cFk/HxsYqh/0Oqd0uyK7cVuGbyC84ZpnfgJl3ZVjHYIbHkNUanzoG4bkOg9af99U
	XkOCPrli0Ndu6uU5hjdVBucJKSPe5Ympn8/iJ/+56UE5eQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyhsgt2yq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 05 May 2026 22:47:13 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2ef62078ee7so3560506eec.0
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 15:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778021233; x=1778626033; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=80QsdjvMKgByQ+N3vQwQVN1POt2Azp0fZNR7U+S/ywA=;
        b=UXp92ayjZu68AfjPYPlPEKuxtJ3l1wNWASeBYdmb/drx9uU/9ACi41cOrsBNMcBFUx
         jbpKI/Ml2uXwOzChyFqGPR4H7zDu4FJDSP+5tZqMefS86iYXawWr4ul8cG1Ja07RoAlh
         eYUdl1DwFiwV93m8lOAc3NV+yXCC1jQMwQbmdNKF+Lwxg0LkJgcVuptplWvAObtibX2u
         4sMPh0ZLwVoUv+VTwm2Tt2nESumSyflim/6612aYba//gHX2KxtSu7X1XGK4Okcs/Qft
         G3R2iwcRlvItsHkrX6edzBBtpJuZJ01IlGaR8Zv5ijpFsXS41LtKtM7HIXTg7hnixrnq
         LEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778021233; x=1778626033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80QsdjvMKgByQ+N3vQwQVN1POt2Azp0fZNR7U+S/ywA=;
        b=CPy4YbNm81IWyCJl9p+JyggoF7oAh1M2P+fMH9+glQtp7UlfbEVi+fuynpunpLD2Sv
         Z88LPqnQfBZqFJSGMYeiuD5Mqn6pkhhEtI83apWnppE6IDALZM/dAAeIWMNHyx8T22qI
         DPkXObZWTjTMPLCRf0cWx98k127SL0FTS7S314aZjzl1aqBIbhSt9P13iJ/R04E6ALrO
         lg7usOiUesqxWnIMMPHGrIie2YRZ8VXxPwEFXIsOPNNZQO4rncrfMy2U40LoD5Qi9Bnl
         I/4BuaANF1vHd+0nSRB8+hiBZWEK6A2mB3rfZH3to+0jwoEhCtixngMfvAsw+ckoDPhK
         VY+Q==
X-Forwarded-Encrypted: i=1; AFNElJ9mMFleONdQfaFSFjWDBkNiGwCbBUdjjns7Hhr97hk4RTcPOAi1X9QmFkJrOVIb71xcdQoyuw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFvT9etEiDTuyxCA+g1oMKP98dS2aWU5ss+XDD+6hXllmpppJU
	u0NfOybNE5qCXD4Wr6XneGdlwiGl7v3b9jDIb4eFtMBBQu9eZQDQnQBOtnWlkt6ymDSpGVRhx0G
	+Dt6tNf1DQt6YQASRamQOoP8L79EbfEcySqyg8vwbrfL9btKK7zphj4u8zQ==
X-Gm-Gg: AeBDiesCyIdslcvweyQyWeXbAUKePRIQSWvy0+PeLTQP/gM/sMe+CUOIsyj0SRr+FKH
	M+DVptvFDiovP2UFS3n1LshgvBd9du9IqsQazwvDr2OwdtDhsEKQteunJMdlvqPnVb5sVg1b+Eo
	7tndMqsWH4xgnhAzDCKzUPm29QR5nMm4GeUcNHz/bbOo7gWrmuuM7tqv6aF1G7ssu91FNgoLDwr
	wo3rMp5/vjrxw11xojvM7VP8adgM6srIy0oTf/PgB7OyCddQlu8sHzRLQoVFarKPwRcVSw7Ca7q
	pfPG995VRIBzcAg/GlXRoT0NVZKe1durAzVC72I4lBOWR+XX4cPACDzzqN4NUE1XuTb6OiRn+zd
	GxWlzZDBnHLUnaehiROjx9dGGXIkNLCN4LmaToj9LJQ==
X-Received: by 2002:a05:7300:bb8a:b0:2ed:e14:7f5e with SMTP id 5a478bee46e88-2f54b899b3dmr493946eec.34.1778021233023;
        Tue, 05 May 2026 15:47:13 -0700 (PDT)
X-Received: by 2002:a05:7300:bb8a:b0:2ed:e14:7f5e with SMTP id 5a478bee46e88-2f54b899b3dmr493936eec.34.1778021232461;
        Tue, 05 May 2026 15:47:12 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56d5c5027sm828041eec.10.2026.05.05.15.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 15:47:12 -0700 (PDT)
Date: Tue, 5 May 2026 17:47:10 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
        iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Tomasz Jeznach <tjeznach@rivosinc.com>, Will Deacon <will@kernel.org>,
        Fangyu Yu <fangyu.yu@linux.alibaba.com>, patches@lists.linux.dev
Subject: Re: [PATCH 7/7] iommu/riscv: Add NAPOT range invalidation support
Message-ID: <oe75yk2fx2c7wg73xrikppw2gxxe2e6bsvkktowbo64ftldy7p@53gjjzhu6cy5>
References: <0-v1-54e7264d71b4+17cc3-iommu_riscv_inv_jgg@nvidia.com>
 <7-v1-54e7264d71b4+17cc3-iommu_riscv_inv_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7-v1-54e7264d71b4+17cc3-iommu_riscv_inv_jgg@nvidia.com>
X-Proofpoint-ORIG-GUID: 5fwv-PqWrKcsJoV2PhfAhY1xAd99qD6k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDIyMiBTYWx0ZWRfX9nl2BXKxMQ+g
 alI7GOL+om1QMTA/8l8pBvRGcGgSCbadb8sJSVXL7bSfRT308asgAVpfLZqHDYDOKPhdca2oLRA
 lJaWl3aFOZEMdD+xwivCs+zEaxgegmi4JcTFyZxx10kz/admcrgbu4QTbgDWznR99qY+e2hK+j/
 INQTM1/XBPIuVRBVnlOO8urzX7TYuf+BBnsZL+C1IOZlNS10isr4LeiQYnkAvfVz5dH4JdXVtUc
 ue1nSGDkoz9N9MYIZ45nq6Dv/AMgX9FABqedLE8Wn91Evy7Pgqm5TQsHHTPZuhiwH1HZBnlJsK2
 +0EjectPpS6VuzkcKAsieIxDHKmsryBokd3ROt4rysrq6mUxIHJJb0b2OY+g6c6az/aVYzxLzws
 vYWLIb0G9hl1lia5+aSCBQy+3Yc/Lpw2u60MzWFSGuUICD1VgkcGnyTnbRAb+CRUINXwfXD1t9Z
 xEr2ORSRaMxc55I4WfA==
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=69fa7371 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=Ikd4Dj_1AAAA:8 a=h2i9vGFyncx6_ar2YjIA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: 5fwv-PqWrKcsJoV2PhfAhY1xAd99qD6k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050222

On Fri, Apr 10, 2026 at 12:57:08PM -0300, Jason Gunthorpe wrote:
> Use the RISC-V IOMMU Address Range Invalidation extension
> (capabilities.S, spec section 9.3) to invalidate an IOVA range with
> a single IOTINVAL.VMA command using NAPOT-encoded addressing.
> 
> One iommu_iotlb_gather maps to one NAPOT invalidation command. The
> smallest power-of-two aligned range covering the gather is used since
> over-invalidation is always safe.
> 
> S and NL seem to be orthogonal in the spec, so if NL is not
> supported then global invalidation is probably always going to happen
> as wiping a large range without a table change is not common.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/riscv/iommu-bits.h | 17 +++++++++++++
>  drivers/iommu/riscv/iommu.c      | 43 +++++++++++++++++++++++++++-----
>  2 files changed, 54 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/riscv/iommu-bits.h b/drivers/iommu/riscv/iommu-bits.h
> index f01b49ac815586..32b3ad3ac9ae59 100644
> --- a/drivers/iommu/riscv/iommu-bits.h
> +++ b/drivers/iommu/riscv/iommu-bits.h
> @@ -64,6 +64,7 @@
>  #define RISCV_IOMMU_CAPABILITIES_PD17		BIT_ULL(39)
>  #define RISCV_IOMMU_CAPABILITIES_PD20		BIT_ULL(40)
>  #define RISCV_IOMMU_CAPABILITIES_NL		BIT_ULL(42)
> +#define RISCV_IOMMU_CAPABILITIES_S		BIT_ULL(43)
>  
>  /**
>   * enum riscv_iommu_igs_settings - Interrupt Generation Support Settings
> @@ -475,6 +476,7 @@ struct riscv_iommu_command {
>  #define RISCV_IOMMU_CMD_IOTINVAL_GV		BIT_ULL(33)
>  #define RISCV_IOMMU_CMD_IOTINVAL_GSCID		GENMASK_ULL(59, 44)
>  #define RISCV_IOMMU_CMD_IOTINVAL_NL		BIT_ULL(34)
> +#define RISCV_IOMMU_CMD_IOTINVAL_S		BIT_ULL(9)

We should add a comment here that this is actually bit 73, i.e.

#define RISCV_IOMMU_CMD_IOTINVAL_S           BIT_ULL(9)	/* bit 73 (dword1 bit 9) */

because...

>  /* dword1[61:10] is the 4K-aligned page address */
>  #define RISCV_IOMMU_CMD_IOTINVAL_ADDR		GENMASK_ULL(61, 10)
>  
> @@ -731,6 +733,21 @@ static inline void riscv_iommu_cmd_inval_set_nl(struct riscv_iommu_command *cmd)
>  	cmd->dword0 |= RISCV_IOMMU_CMD_IOTINVAL_NL;
>  }
>  
> +/*
> + * Set NAPOT-encoded address for range invalidation (S=1).
> + * sz_lg2: log2 of total range in bytes, must be >= 13 (8KiB, 2 pages).
> + * addr must be naturally aligned to 2^sz_lg2.
> + */
> +static inline void riscv_iommu_cmd_inval_set_napot(
> +	struct riscv_iommu_command *cmd, u64 addr, unsigned int sz_lg2)
> +{
> +	u64 pfn = addr >> 12;
> +
> +	pfn |= BIT_U64(sz_lg2 - 13) - 1;
> +	cmd->dword1 = FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_ADDR, pfn);
> +	cmd->dword0 |= RISCV_IOMMU_CMD_IOTINVAL_AV | RISCV_IOMMU_CMD_IOTINVAL_S;

...here we're setting the wrong dword. This should be

	cmd->dword1 = FIELD_PREP(RISCV_IOMMU_CMD_IOTINVAL_ADDR, pfn) |
		      RISCV_IOMMU_CMD_IOTINVAL_S;
	cmd->dword0 |= RISCV_IOMMU_CMD_IOTINVAL_AV;

Thanks,
drew
