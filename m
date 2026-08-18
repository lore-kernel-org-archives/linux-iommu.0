Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0558A2F1FF4
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787050796; cv=none; b=m7+aYWWuu7655DwmaMCmkSLGuqFU4V3hWRGf6cbK7IltukSt0PuoKF7/LjASiX60BuSyDhd0z2zXGrx6OuRhBSVdH22RU5K3EAlMqgorH1qX0R3lHvuRqWVcOAEZ+JGIm7eXA7Od04eCe8NlVwOAoE+F1w4H+UTquSyLJWZ73IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787050796; c=relaxed/simple;
	bh=qQpo4F8E8YM6JVnq7O1ZYj6VyTUk3b19py9kDJeWMKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqK9MeSaCIXl7AQnjq1KfP83QFG2JNY0Z0eZbfVr7V+V9BVOkktij3P6bSuQTK/ymndbyNJaq8JfuIHrYPAngxlEGtiVHgbw9gQySB55SQY2JW1IQSg863jkge/AL823EkYvkAiW08O4+26WE6JlyQ+odVlefOz2eq43G1d9Fro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J60TawLL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qq+qZo0F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J60TawLL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qq+qZo0F"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABZuJ3979101
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 10:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=97oyElD7Ik9opXwUE5qADXHh
	NFeKHDDf3nqCTfRJei4=; b=J60TawLLIuSg8NbfgtjwGsJfjgui/RptVu344kDD
	llEnlZc99ED1Odhs98GrZXdsPCRnQXysN50fi6sV9C+tdTfr8EeVCR0vmQoGfl5v
	ttGcLdBFc4b3bHstiQfuRnCKqD2HG/GF+oDwusUL8IyyGkBDLRsTpgqntLKj32Zq
	Ckl0AG/gfe6B9jxGHt+3vo34GRPskctLjTG1igjzEgrAhaEjaaky361TJZsdtzzm
	/kvE5xvcEwWkGGhW0oSDiAEl0ncmwLymcCCFDMV8+6Nhdjl5Ubp2v9+4G5iLCxA8
	s2WM+NId3pst9+pYQVSHe6uLWZNX/muG//QOMJel0lrPDQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4ebpt2n5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 10:59:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-930b571432fso93524985a.0
        for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 03:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787050792; x=1787655592; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=97oyElD7Ik9opXwUE5qADXHhNFeKHDDf3nqCTfRJei4=;
        b=Qq+qZo0FdVHLiXUT1KKsjNJ7PP1FC9ekb1bwwGyG98akOuDfEFOu/gJdvNe2dSGoGQ
         8iWJBBXfgOLunsigL+Z1btgOtmVDCiOZLINmkReT5T34ajA3NcDE20X6k0+VIBjed4Sp
         c+yZcLvvKAsGCL3izL9Lw3/5FFO+Sn60VRVbP8YKh2dAnB+gvm4Zzro6uaWbirwT92sR
         6gkb9sjx4zse0qsc2JtojMQAPcWKBKKc4aXtJ/7cyXa3NBOkYtT0xX2W5gj9hP7XtC7i
         T3rjb7MPw+m0JPV2hdpj1ILKLs3puWUdCloTuL4FaCUc3dtphuva4FxZ1wQIWnr/1MM4
         IMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787050792; x=1787655592;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=97oyElD7Ik9opXwUE5qADXHhNFeKHDDf3nqCTfRJei4=;
        b=cjwRbyaFzKBJFmz1YwwiBnJvHysZXR7AINwfMFrSCSBD+8I/VAPQZUcW/MCoTtRwm9
         FKM/cT1IkixeuAdYlmmb1+NeCkO79s6GiiABvL3+J5cNHC0oLBWQQOhbxXdwWVg+H9eE
         fnC/aP1c9KNmqFSBveTM6YHrKI2sdSON9Yvd6SKoO2CwA2KnxmPkd0nBX3kX2WoAgY+6
         9xAHUpk1oAQnM/JKAtRvOh6DTr6htSmNmbd7ngrlqvdKS1ARMWTS3BeapqI3hIIV6E+E
         Fs9xaoBVGN29L3Mcagkp0zDwwy4B2MlzufjuRTWOi45ofyTkyqFGGn/+B7jLxITHrtlk
         4S2A==
X-Forwarded-Encrypted: i=1; AHgh+RqYToFUN5TGpTEIvyna8CFHlj4fddannLKSLyerkwXFnIU7bzTRfR9Db2dOLtSfgbB98r6AWg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2Edmr27N/xtgx3nS0nx0vD//IKGf0vAj5EUy58Uiq+zAg3zFx
	CtF7HHZwvltHPQlux0GNvgHbicTzMs/xdzXsqm1mzjlXqdKCzK+8pQE+hr7+Gcgqr+zN4v+UvNy
	ANbm2yAMKCMVwPnw01O9YTTzuNBnGtLg7SH50rbSAu4v5t5y217fhmM6lkw==
X-Gm-Gg: AR+sD12BvxNUTSwllkOjxYRbe4nb6hR4vKLiT/qMfsdHYirdUWC33OxALeclB7Qrp7z
	64eN+CYj7EZ0A1euzZn0HEpw1NtLLv0HCsLOMDDKECKAbRK2QaRZEQQ6bDGRKpvajo+EU+0h/Yy
	gqi7yZiFXX6hyblVv0zgHx07f/o1DAWqdsv3QiUz2eUMHUlmxgmfUkCFc7jiSYkzcfssOvcQ9Ik
	eSTeaeUg2uuJBv+n2OgqrkJMPRrL/4dkGUvY3LbX268CXRI1ucpQierPwKaE2SK6u0+TnXep3wX
	vXCtkrG0BJIbfJZeq8Hq6TIcqESC9bkA4usM2PJtIbCgisCJKwM7SKD/RbVFM3gYUcK3JFqR+o7
	ckDEUdmvywKX6y5kd5UUI9TuYXBE/RZjLt2M=
X-Received: by 2002:a05:620a:280e:b0:936:a8a0:cdf0 with SMTP id af79cd13be357-9370662ee48mr557156985a.15.1787050792143;
        Tue, 18 Aug 2026 03:59:52 -0700 (PDT)
X-Received: by 2002:a05:620a:280e:b0:936:a8a0:cdf0 with SMTP id af79cd13be357-9370662ee48mr557152885a.15.1787050791724;
        Tue, 18 Aug 2026 03:59:51 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b783basm11499220f8f.30.2026.08.18.03.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:59:50 -0700 (PDT)
Date: Tue, 18 Aug 2026 12:59:49 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        tjeznach@rivosinc.com, jgg@ziepe.ca, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, vasant.hegde@amd.com, anup@brainfault.org,
        atish.patra@linux.dev, skhawaja@google.com, jgg@nvidia.com,
        guoren@kernel.org, kvm@vger.kernel.org, iommu@lists.linux.dev,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Zong Li <zong.li@sifive.com>
Subject: Re: [RFC PATCH v2 05/10] iommu/riscv: support GSCID and GVMA
 invalidation command
Message-ID: <4mcwrlk7yc4kozsqbrumf5gbknydquzwdb4g7lv6bgjk7m6ob2@alld2yusipnq>
References: <20260507113706.11400-1-fangyu.yu@linux.alibaba.com>
 <20260507113706.11400-6-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507113706.11400-6-fangyu.yu@linux.alibaba.com>
X-Proofpoint-GUID: GACYCK3-53OtPOvAOc4EOdAm6i6nxgY4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4MCBTYWx0ZWRfXxJjVaoHPhJP2
 7MpBShn1i5H79T8HPKDDBacgFR48nYi1+sOA9iHmUNnzPaEY6SK3I+XinCgRSwnWp1thQym9iJt
 h1ltGmM+wXWchF2Z5+h2YIj3k5rHSkGZtSg8LkOMUZOIjhNs6yCoHGGRGMlQVitZZtX3yaIWF29
 kmet6BXsaLd0hyG0hm66k6rcGyIdaf5aH6CKaXMatVz3k/ebxyZbc6uQlTJeQfItsoGPVowjRj5
 n0FoE5qrXm0sjJRaakz/CkRkEANLHkuSspEeb4k3QrAamHkAF9eYtz0PqpcTLLBrZMTA/YQF1gk
 sEUbSkASc+YIFE6Ly/zIF0JeoyOWPy141eym+5bXN94w3pbzCPd6DdCQ3TljoHXk3v7XsgA87Ga
 JJlzEkqcMPKvXYgl7aqlXEC7bCPgDg5tfSACOKSdH5u9InSuxoZor3dOjt7EkEOcObrefZ2ll12
 sPdCxqzYMYqQcNv2ZWw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4MCBTYWx0ZWRfX8mOflRBGgS8o
 SfJco15isxArYEI5CKZbywL6Qed56yQF0huMf9PEZB2GRH7AVHKkQgQ/v0bVWb6TKcCVSfAY41Z
 krp2BXStA0T/R5Z5mTkIFobRIE42gjE=
X-Authority-Analysis: v=2.4 cv=FsU1OWrq c=1 sm=1 tr=0 ts=6a843b28 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=SRrdq9N9AAAA:8 a=VdMlnMEb94GnahmMsAwA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: GACYCK3-53OtPOvAOc4EOdAm6i6nxgY4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180080

On Thu, May 07, 2026 at 07:37:01PM +0800, fangyu.yu@linux.alibaba.com wrote:
> @@ -1212,8 +1225,15 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>  	if (!riscv_iommu_pt_supported(iommu, pt_info.fsc_iosatp_mode))
>  		return -ENODEV;

This needs something like the below diff squashed in.

Thanks,
drew

>  
> -	dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
> -	      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, pt_info.ppn);
> +	if (domain->gscid) {
> +		dc.iohgatp = FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, pt_info.iohgatp_mode) |
> +			     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->gscid) |
> +			     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_PPN, pt_info.ppn);
> +	} else {
> +		dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
> +		      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, pt_info.ppn);
> +	}
> +
>  	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
>  	     RISCV_IOMMU_PC_TA_V;
>

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 307baf33c646..434d2d4f26f5 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1262,9 +1262,9 @@ static void riscv_iommu_free_paging_domain(struct iommu_domain *iommu_domain)
 	kfree(domain);
 }
 
-static bool riscv_iommu_pt_supported(struct riscv_iommu_device *iommu, int pgd_mode)
+static bool riscv_iommu_fsc_supported(struct riscv_iommu_device *iommu, int mode)
 {
-	switch (pgd_mode) {
+	switch (mode) {
 	case RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV39:
 		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39;
 
@@ -1277,6 +1277,21 @@ static bool riscv_iommu_pt_supported(struct riscv_iommu_device *iommu, int pgd_m
 	return false;
 }
 
+static bool riscv_iommu_iohgatp_supported(struct riscv_iommu_device *iommu, int mode)
+{
+	switch (mode) {
+	case RISCV_IOMMU_DC_IOHGATP_MODE_SV39X4:
+		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39X4;
+
+	case RISCV_IOMMU_DC_IOHGATP_MODE_SV48X4:
+		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48X4;
+
+	case RISCV_IOMMU_DC_IOHGATP_MODE_SV57X4:
+		return iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57X4;
+	}
+	return false;
+}
+
 static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 					    struct device *dev,
 					    struct iommu_domain *old)
@@ -1294,14 +1309,17 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 
 	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
 
-	if (!riscv_iommu_pt_supported(iommu, pt_info.fsc_iosatp_mode))
-		return -ENODEV;
-
 	if (domain->gscid) {
+		if (!riscv_iommu_iohgatp_supported(iommu, pt_info.iohgatp_mode))
+			return -ENODEV;
+
 		dc.iohgatp = FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, pt_info.iohgatp_mode) |
 			     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->gscid) |
 			     FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_PPN, pt_info.ppn);
 	} else {
+		if (!riscv_iommu_fsc_supported(iommu, pt_info.fsc_iosatp_mode))
+			return -ENODEV;
+
 		dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
 			 FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, pt_info.ppn);
 	}
