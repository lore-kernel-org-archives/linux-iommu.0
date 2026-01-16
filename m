Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241BB3A1A59
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594331; cv=none; b=unMce9aSqBi5/zaqUIonEy3B3L/OHzoUGp+NU9XTLOzdcNXOLMZ6oJhCifd9RoTqe5m9D1sugpPwnl6w/hfm5AdNv4PJZ5JW9mnMqND954wPfZNeeiyCTbyJSiCS39BYzXrVsfX8A3gx3hF454HFtMqE8bPBgK+wOQTvZRlhiNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594331; c=relaxed/simple;
	bh=/L9ExpZCscfiM98QRpyOG5XRpoe3MayI+OZdi3XZnIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nprvSHTeM2iv6reHCKNoDjeZOpocWoeul+v+xmxHkEiThylGk/ewXHg0FHX0/TMYTYUm1PJdOGZVf5uO02WFztSOpwGdoaf1q43KQoTaGqgVI5uGi8cVF+2vS+s9Jdv9UzpMk1+5fiVKRLlWWeC4bnrpG4dhv9WnJrzVwXyzv1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ggGPT0dM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q3/jRP3E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ggGPT0dM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q3/jRP3E"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60GJAlXk1451526
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 20:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=F0iTtiZUAH8dw0zZmuH/r59V
	0R+RqGKf8svO6zz8Cxs=; b=ggGPT0dM6jHxOV3uGfQzqU0q4OdhdA91sWx/nSyf
	FF0yxSUsweBl/pqfY/fkBvGPbc23RE9hMVnFXl2AQ5WVcNRHYNS5HQMBqViLbUzF
	NrDy9NfDFGpTGgTIUTdY4f6m091jv1JtVHqeVbQkfWjs5ZBSJWxqQh/4GtqCrrPf
	dhN7Ny0pgfX6Efue+UB572IddQGEp/jFZ6T3XfiNMYwgw9P7TCaXNU5E5GJCRqjh
	xlah0yPfTpvCzyxdo52fJhS7LtAlR/TqG8DfdKt2r2BLk2MacrbSgesqgd5JKy8N
	ZCmyQPVQDH5aUlycUQIgwp2eWTJSeACX+Nj6r0tvhAucKQ==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bqqjurxj2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 20:12:08 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4041ef81d32so6078230fac.3
        for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 12:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768594328; x=1769199128; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F0iTtiZUAH8dw0zZmuH/r59V0R+RqGKf8svO6zz8Cxs=;
        b=Q3/jRP3ELDGFhOZssC6qBe3fgSHv9crKxmhcZyjJPTn1lfNvVWtAHplyvCk2OCezMI
         AJqYQtLoNCKi1g+A93cVv9N0zxr2c10iNokm+R7kPrGZzglGdAfbMB6BRo9r5UUOXskx
         kAcFy5F7XUIHsue//AlySShKQBfmJ8Ac9uRzcUCHk4fGaobQZcdnVTfJgxQoz6OiW5sk
         FgVrXgtcZki1cgcPTZ5YsSBAq9Q6oetzoULP+lDPREjVfbzstvwVXebBRHtm44SJW5Qo
         BaLfcJENNpAWC1dJyDdHA0Ag7srjcPp+WSsODxVZNh+MeuzlPYQ2JTToaPqYenRoYZ1V
         xrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768594328; x=1769199128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0iTtiZUAH8dw0zZmuH/r59V0R+RqGKf8svO6zz8Cxs=;
        b=TgADb/R2EBwsm4PFZoPqc/H4Ljv1UUbGmOEC0xpgwuWlD7qlSzze9zOkeI3BWt7f0x
         9bPuQ6TvQjnq2pFRiR6xPcoMcrmN36dRwh7N+zk6hwrCCNFGEkLU0vH+OLjhutrTtWRZ
         9lI4AuOkcnwuteCZhtOeWnVRUMWtdoVsHckaqD+yO/EUnUiNAD9XbwPyfslRN60m9f1Z
         +G/Ek2BJ3xp+n0v+miDuX/ANrCSFujgStnfbwt1nq9ZsTZHBjQgtq2hqA8/P8bs6G3v3
         3PHnJkXTwbuFZUBiHTRfhgPb2BWWbf3zkKzzcZORCximiP4LtXGt0YkhYyLcafFktb0D
         mZmw==
X-Forwarded-Encrypted: i=1; AJvYcCU40wsHaiVLk79YtnIR6jIG6iIySE1aiw70bnKGrBwJQ0XjciHTuumoSo4iQZzkFgWEsEg2cA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4x2kpcm48BxsNPEn3Sd1DmW0WtW6J4d7KEFC68eIUFuF4SQhC
	2bnF4AAaJTMxhtMhRc49hKK79Gstm/9icyqzppBj1T2dC1AN3LqsJDeJVMtsl2fhEfbKxBsIzsU
	9wQAC2uubAOGaotBpWWCu69Z/+fqDit7iPXKdOH8IjG2U0VMaf8hVGuQvGQ==
X-Gm-Gg: AY/fxX5OUIN7AoaEtmljvH54QBoDEVl5Bk4YsbzDxRrm/dfWB24Ll6bBI7TJ993BZVU
	zYDAbZkZ2WUrCY9+Oj3aEfRG1G7Jo8oePPD2E5AgaWiybluucGUqUYIcjLivG3Xgm1r4LApaenz
	u7CAtdY9ARC1CPEV4Yhy+ZMoKWGNOatpG6DRP1Y9ShqH24yc00DBu17LkWubmUqaUoidJ2/Lsez
	S+RiBOuw0xXhji2+QYgKQeVNyRbujoY4Z4f3MtRMYYUKtHtdhEEU9DJQdwSENYGpEXPY5zBpLRn
	Uf4YmV0GVSNjTwlZLr4SdpBdXs54H0kGEJWvBMCu3rr8V/u3DAW0EdCTswkpcqltm1nX6hWIa1P
	vuNPHosnkTD2hAP0E3+o=
X-Received: by 2002:a05:6871:c70c:b0:3f5:4172:12 with SMTP id 586e51a60fabf-4044c62c893mr1920560fac.59.1768594328230;
        Fri, 16 Jan 2026 12:12:08 -0800 (PST)
X-Received: by 2002:a05:6871:c70c:b0:3f5:4172:12 with SMTP id 586e51a60fabf-4044c62c893mr1920545fac.59.1768594327832;
        Fri, 16 Jan 2026 12:12:07 -0800 (PST)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4044bb528d5sm2422436fac.8.2026.01.16.12.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:12:07 -0800 (PST)
Date: Fri, 16 Jan 2026 14:12:06 -0600
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: fangyu.yu@linux.alibaba.com
Cc: tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alex@ghiti.fr, guoren@kernel.org,
        ajones@ventanamicro.com, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/riscv: Add IOTINVAL after updating DDT/PDT entries
Message-ID: <c5sk7h5r5fozjdyguamekenlzd7pzbtvdh2boq3arynxifba22@ii4ikea2tuyq>
References: <20260108134855.91341-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108134855.91341-1-fangyu.yu@linux.alibaba.com>
X-Proofpoint-ORIG-GUID: cfQSjBgUc_ZfqDWvkEPRsf5amOGUxLaT
X-Proofpoint-GUID: cfQSjBgUc_ZfqDWvkEPRsf5amOGUxLaT
X-Authority-Analysis: v=2.4 cv=atu/yCZV c=1 sm=1 tr=0 ts=696a9b98 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8
 a=78wgLUYcwfu5JlQfcDUA:9 a=CjuIK1q_8ugA:10 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDE1MSBTYWx0ZWRfX8Ch9S7jHSMo7
 kLEIcZ5PetO0aZOTx63QkQv002RLhSADPbW1S57UGQlD5CExTA56WuKGuYa20/eVfkLMoUfvEH6
 /pS7LJJ5adxXPsC2lNeVOfq7DNl4G/3C4rPLNLa1gJKZt3BNudFu3RYjTrOoVBKrZ7PpxGlLrjC
 Z472yBlTmumOM78qy+eLkGwe/jXrtzjq1eaHry7/r2J1MbhJMKehMmkNSr4neosyWagPiBV0QDV
 XSSUAMpYTTYzM4Z/fwaTkw3dsD6LO/1Ec3J4caHgX0I5M6+KcuHOng+U04BRQ7suuDhi3nJnQeV
 7ZuBS8VTZh1I9C6aTNAdXT/tEYDDXlffg1+HBhJNcbkOErYoV+JHlHAqI8jGP22NJ76szI2coOq
 p9zuRnlqJCqNsWsjj45dpdEeO+JQoL+pSyjT/yR8hdn23iTI8VB0T/FCRkVwLV+CWvdVC3CENQs
 hM2Pxr8RRZ3ri/VFj6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_07,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0 suspectscore=0
 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160151

On Thu, Jan 08, 2026 at 09:48:55PM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> Add riscv_iommu_iodir_iotinval() to perform required TLB and context cache
> invalidations after updating DDT or PDT entries, as mandated by the RISC-V
> IOMMU specification (Section 6.3.1 and 6.3.2).
> 
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/iommu/riscv/iommu.c | 85 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index d9429097a2b5..2900170133fc 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -996,7 +996,82 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
>  }
>  
>  #define RISCV_IOMMU_FSC_BARE 0
> +/*
> + * This function sends IOTINVAL commands as required by the RISC-V
> + * IOMMU specification (Section 6.3.1 and 6.3.2 in 1.0 spec version)
> + * after modifying DDT or PDT entries
> + */
> +static void riscv_iommu_iodir_iotinval(struct riscv_iommu_device *iommu,
> +				    bool inval_pdt, unsigned long iohgatp,
> +				    struct riscv_iommu_dc *dc, struct riscv_iommu_pc *pc)
> +{
> +	struct riscv_iommu_command cmd;
>  
> +	if (FIELD_GET(RISCV_IOMMU_DC_IOHGATP_MODE, iohgatp) ==
> +		RISCV_IOMMU_DC_IOHGATP_MODE_BARE) {

nit: This condition can stick out. We have 100 chars.

> +		if (inval_pdt) {
> +			/*
> +			 * IOTINVAL.VMA with GV=AV=0, and PSCV=1, and
> +			 * PSCID=PC.PSCID
> +			 */
> +			riscv_iommu_cmd_inval_vma(&cmd);
> +			riscv_iommu_cmd_inval_set_pscid(&cmd,
> +				FIELD_GET(RISCV_IOMMU_PC_TA_PSCID, pc->ta));
> +		} else {
> +			if (FIELD_GET(RISCV_IOMMU_DC_TC_PDTV, dc->tc) || (
> +				    FIELD_GET(RISCV_IOMMU_DC_FSC_MODE, dc->fsc) ==
> +				    RISCV_IOMMU_DC_FSC_MODE_BARE)) {

nit: formatting
			if (FIELD_GET(RISCV_IOMMU_DC_TC_PDTV, dc->tc) ||
			    (FIELD_GET(RISCV_IOMMU_DC_FSC_MODE, dc->fsc) ==
			     RISCV_IOMMU_DC_FSC_MODE_BARE)) {

> +				/* IOTINVAL.VMA with GV=AV=PSCV=0 */
> +				riscv_iommu_cmd_inval_vma(&cmd);
> +			} else {
> +				/*
> +				 * IOTINVAL.VMA with GV=AV=0, and PSCV=1, and
> +				 * PSCID=DC.ta.PSCID
> +				 */
> +				riscv_iommu_cmd_inval_vma(&cmd);
> +				riscv_iommu_cmd_inval_set_pscid(&cmd,
> +					FIELD_GET(RISCV_IOMMU_DC_TA_PSCID, dc->ta));
> +			}
> +		}
> +	} else {
> +		if (inval_pdt) {
> +			/*
> +			 * IOTINVAL.VMA with GV=1, AV=0, and PSCV=1, and
> +			 * GSCID=DC.iohgatp.GSCID, PSCID=PC.PSCID
> +			 */
> +			riscv_iommu_cmd_inval_vma(&cmd);
> +			riscv_iommu_cmd_inval_set_gscid(&cmd,
> +				FIELD_GET(RISCV_IOMMU_DC_IOHGATP_GSCID, iohgatp));
> +			riscv_iommu_cmd_inval_set_pscid(&cmd,
> +				FIELD_GET(RISCV_IOMMU_PC_TA_PSCID, pc->ta));
> +		} else {
> +			/*
> +			 * IOTINVAL.VMA with GV=1,AV=PSCV=0,and
> +			 * GSCID=DC.iohgatp.GSCID
> +			 */
> +			riscv_iommu_cmd_inval_vma(&cmd);
> +			riscv_iommu_cmd_inval_set_gscid(&cmd,
> +				FIELD_GET(RISCV_IOMMU_DC_IOHGATP_GSCID, iohgatp));
> +
> +			/*
> +			 * IOTINVAL.GVMA with GV=1,AV=0,and
> +			 * GSCID=DC.iohgatp.GSCID
> +			 */
> +			/*
> +			 * For now, the Second-Stage feature have not yet been merged, so
> +			 * let's comment out the code first.
> +			 */
> +#if 0
> +			riscv_iommu_cmd_send(iommu, &cmd);
> +			memset(&cmd, 0, sizeof(cmd));

The memset isn't necessary since riscv_iommu_cmd_inval_gvma(), which
doesn't yet exist, will overwrite dword0 and zero out dword1.

> +			riscv_iommu_cmd_inval_gvma(&cmd);
> +			riscv_iommu_cmd_inval_set_gscid(&cmd,
> +				FIELD_GET(RISCV_IOMMU_DC_IOHGATP_GSCID, iohgatp));
> +#endif
> +		}
> +	}
> +	riscv_iommu_cmd_send(iommu, &cmd);
> +}
>  /*
>   * Update IODIR for the device.
>   *
> @@ -1031,6 +1106,11 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
>  		riscv_iommu_cmd_iodir_inval_ddt(&cmd);
>  		riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
>  		riscv_iommu_cmd_send(iommu, &cmd);
> +		/*
> +		 * For now, the SVA and PASID features have not yet been merged, the
> +		 * default configuration is inval_pdt=false and pc=NULL.
> +		 */
> +		riscv_iommu_iodir_iotinval(iommu, false, dc->iohgatp, dc, NULL);
>  		sync_required = true;
>  	}
>  
> @@ -1055,6 +1135,11 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
>  		/* Invalidate device context after update */
>  		riscv_iommu_cmd_iodir_inval_ddt(&cmd);
>  		riscv_iommu_cmd_iodir_set_did(&cmd, fwspec->ids[i]);
> +		/*
> +		 * For now, the SVA and PASID features have not yet been merged, the
> +		 * default configuration is inval_pdt=false and pc=NULL.
> +		 */
> +		riscv_iommu_iodir_iotinval(iommu, false, dc->iohgatp, dc, NULL);
>  		riscv_iommu_cmd_send(iommu, &cmd);
>  	}
>  
> -- 
> 2.50.1
>

A faithful implementation of the 6.3.1 and 6.3.2 guidelines for what the
code currently supports. I presume this is fixing an issue? If so, can you
point that out in the commit message?

Otherwise,

Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>

Thanks,
drew
