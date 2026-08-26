Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DDE37A4AF
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755687; cv=none; b=GED5/4ehOHeKL/IALr4E9Jt/m5wuuTPDxAvbVnOtkW5cC30+vYlpbsWQAYghBdNc0ExFkt2Tn1GAkrIV2W57OtjabDpFcZ5kz5n4xSlBVHymwAzGL5a1maX9Z2Pe4U97TGxcsuTVysRJSVurcWKlh7d3xA5t8Ngxn/jVnGwSyt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755687; c=relaxed/simple;
	bh=eFKNRs/YM3tVCJQfBBvgS8zARI4a6CJVRm6eUkfUI3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pi7vYT1DKhfLZqQmoRyeXVQHlxroDFn0NUf8m2apBH+zA5sulvZLhPECAo1DRHKiMlabLdZc/FrAv32P6Te6TiX4nCfxZcrWqEOLFpGx1roLxNzzObx+djU04Fm7IcmBmV/5XlYnSBrGBSe4fnc2Apism6fm2KBmGqgpHHiJ93U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZtxHhWEB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LUlINTxY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZtxHhWEB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LUlINTxY"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QDuluO593259
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eFKNRs/YM3tVCJQfBBvgS8zA
	RI4a6CJVRm6eUkfUI3w=; b=ZtxHhWEBRPELNFtqJMn52UtxPBsL6OaKQWFEgNql
	zyXbfCwCOsgSe3mXpp+FQ0Sfnskm6se+ptPYLR2BmzCEbu3Xmynys+p1Noym8hXf
	ZVnPNB3ip+14qit31xpRLBTWxWGJl5AvQSaVaBvXFL1BfSnku+D2J6s3xsWxOM6l
	ln3maz4Ia3k788dY6RxbWKn3MlDQ1G9Nbd+0SG4IQZS0EVvM65POeoCwTK5Mbbda
	Mp8tDVOuTMPlKQU8C3UGpPpUsvNpSJZzkpizt8+TQ1NtR/8f3EV1171ygjexx1xb
	cwv5tNfqVT6iMOrRv7UucmIEhNrWZgZIyIvqb3uC2NOg4g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9s9gacyc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 14:48:04 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-526da7e3c9dso10334151cf.1
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 07:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787755684; x=1788360484; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eFKNRs/YM3tVCJQfBBvgS8zARI4a6CJVRm6eUkfUI3w=;
        b=LUlINTxYLeuwugjMjHtl6NBkYBqKo54YJ/60RilN5S3W4LmvrNsuaBloH+ZNj6R/Sf
         Zi7Q79Y2lBS3LaeMK5WoAHATDtPugz1QiKq0y4yVhHt0sko+Ur1Pzel0cyLwIeSxxGNj
         fzoPPgjOzLgQ7R5CjyDObpBQM9eJIPdvPwtpAaxkTtq7u53zHJ3rtrTI5VgU+4Owyr/i
         AU0qP/1TQPJvjKICrzcfET2LajB+QEGTbd7lkTaiuA2/72W8ltzmgclJsqEORBzEs/VA
         a23NeRVoTFMqb6aCMfMNc1F/UBbkIzHPdjzbwmlGOH2TV0C/1KfmFMcxYmZ48DUi09Fk
         VmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787755684; x=1788360484;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eFKNRs/YM3tVCJQfBBvgS8zARI4a6CJVRm6eUkfUI3w=;
        b=jKhJYC7ndLKf0hUjhT+WKqKnNf3CzYxqHRxc79ZqTtUNIqm8I7Ash8S16xN1311tPM
         9NqDpLBH2+GAoFvx5sTe8rwXkMBWD1Nt4SJSj2Mg3DAPwfwRtNRFlRC3jLo/iLNqLfgX
         ptAqn98v+PV6lUAJdCHtvNUfjfLBKko+LRFwJjLX1YW4KiCW3wtPF5XlduMMhSHXVGiS
         gEObpKlndZ4b0ZUmNdwBSlJUVu1WO4zy78Ok4Nma5uoLE8pSziViv/V9bKVjqVkfq+Wg
         C1ffiDo1IWebw55gO8dE5aiV8DziAbgqQLVQv5vG1v5tW3Kn8iM3cHiEz+QQKZGBl0Vw
         YiBg==
X-Forwarded-Encrypted: i=1; AHgh+RpmMS9BVvesjMpsGidP4g7dI3zkWyek6cXKkSb0b/9HM+gAWDBlllqyBVU5GEbBBo/rYydBCA==@lists.linux.dev
X-Gm-Message-State: AFuF++k1t1uDK/B6iWKcxdfBaJivgMX77KAYYYfjLfsvQZRJ6m2LHx0Z
	i8Ri6ntxE+aIABFw/ASiR1uPP017sHFlTVHLHwxll1+psNN6rrrdXPDR83w3AMWGnF4Mlx8+xRz
	zSilHaQmQu9ogPMc3RCjmNT07hK8V9iDp/giH2CEfOJ9FK+RZLFZoJD9v9A==
X-Gm-Gg: AR+sD11lo4UXvqIuAzEWppyyIIfaAVmtTL+Tn67lNX1t5a8x5l9B1utHUFx/Uq3x7dh
	QVOjfkeOIV7C17K2Vh+MKKzyunEcviarwnE91ZfxLQQrManeZh242OD4VognZX2WUUxnbK2Kvfj
	F2R7HhVjESIBpuVTgkI9wVczAmYBEDVSqA3Caaj0dn1aiPJ1OJ3J37uZWi5JUF7gK6Eyw3rjnE3
	icS+e+mYg3gU/IrYdmVAWtOC+lBKtfBWj/pn+ZT71TDodDQAtDwYqlJnQIhbzwidgYH90etg+yC
	QC6J0SRINXXJUkQipY7LfogOvGb2/JcR/muqNjo1DElXqDR+x1ziDopVdfXtwdYF2Lnbctm4RWc
	YAA17dzHa
X-Received: by 2002:a05:622b:106:10b0:52e:467e:e9e5 with SMTP id d75a77b69052e-52e467eecfamr31370211cf.40.1787755684324;
        Wed, 26 Aug 2026 07:48:04 -0700 (PDT)
X-Received: by 2002:a05:622b:106:10b0:52e:467e:e9e5 with SMTP id d75a77b69052e-52e467eecfamr31369441cf.40.1787755683714;
        Wed, 26 Aug 2026 07:48:03 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28dc0d6sm3053781f8f.18.2026.08.26.07.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 07:48:02 -0700 (PDT)
Date: Wed, 26 Aug 2026 16:48:01 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-riscv@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
        anup@brainfault.org, tglx@kernel.org, kevin.tian@intel.com,
        fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v4 02/21] iommufd: Add iommufd_sw_map_msi()
Message-ID: <gzgrgpsnku7npueut6zjel2gb6m4g5b5mjdohlyamrq6ogswlm@6mh42uxi4imd>
References: <20260824125204.GP244917@nvidia.com>
 <fp5myre5qaersxxshitgoupbzkx2zwo3rsz3q5jfdiarmtwknh@gmfhz3cxuc33>
 <20260824170417.GR244917@nvidia.com>
 <3gdj54zcs5dncgom3zlntyredyuh2xe5ueg7nd4pdrcksmnwfl@k3fyky4h6556>
 <20260825140334.GA3325090@nvidia.com>
 <cxbneh42ui3gbkoqrsnoatxoec5exzbprfbgxcy4iekqmbceho@gouiwn5q5uzs>
 <20260825165209.GB3325090@nvidia.com>
 <iltwtfmgnmofsroo7eqrvjx6yhqbptwutywq65mgm7adudz7pq@2mdg3dhvtoud>
 <20260825175901.GE3325090@nvidia.com>
 <pzutriwhwe4whonj3veoo4hzxmq5tlmmyui5u6gt4bgl5wxxrg@qjsq2pvd7by3>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pzutriwhwe4whonj3veoo4hzxmq5tlmmyui5u6gt4bgl5wxxrg@qjsq2pvd7by3>
X-Proofpoint-GUID: 2gDma_dbsE-a9KskZ2jrULjbZnAsblky
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyMyBTYWx0ZWRfX7WM+BfAg7kSi
 QNRyku2yW8fSCNH5TrS5wInFE9FP2yHmhNX8UJeD+UDzne18NlYA5rTn0ODRHwA/1KDmwfrBZfs
 xN60EK6UkEL3iayhVobJ0aDI6ywRRPpsWCGO3DZNeqCWs6SFhhQiVcs6ncvgGGfhQZc3sr81DJs
 OCJ9E3f1c0C9CkT+8o6RKQs1pICBt2wz/hGaW2SDyAZQQCvaWakbf6dZup9XETgt21Jz7LsvbCX
 mgNfIcP8SV5w9ytPHZGCnTFjgIrK9vV0nj8JN2OZWOcT968PG/I85felY9/ZVBkvPQqXrlOv0/Z
 e9t7hLKhxkucfcIY4AKsVtLHu3lignGipkeQ8EvpgVtr3h86j/L5bEPrCTjD/Kz1WbAWbb9r+wf
 4sTtkF+N+TF6xGMQYRM1Yx1LvPg3lHrV30zk1rCA6O8InNxD8g96domHv+epGF00ETcBGV6ZZNX
 pV0SS7oUu6+REbjw3pw==
X-Authority-Analysis: v=2.4 cv=Xfq5Co55 c=1 sm=1 tr=0 ts=6a8efca4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=K8_gVM2FpOf_7PldHO8A:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyMyBTYWx0ZWRfX812FkFctrOIp
 wtAEJOGrG112PzUSo1FPm7e6yoBLGzKRJz9+4BFNfjWMotcD2puExDPzZlgik8z671MQtS690lF
 0B2tnB8wLKL5FbepJk0SZMDnC2E2dVA=
X-Proofpoint-ORIG-GUID: 2gDma_dbsE-a9KskZ2jrULjbZnAsblky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260123

On Wed, Aug 26, 2026 at 10:23:20AM +0200, Andrew Jones wrote:
> As said, iommu_dma_prepare_msi() handles one fixed MSI target. RISC-V
> has one target PA per IMSIC, so the proposed list API prepares them
> together and guarantees contiguous IOVAs. The interrupt remapping IRQ
> domain's compose callback selects the IOVA corresponding to the IMSIC PA
> selected by its parent. That selection belongs in the IRQ hierarchy.
>

That said, it should be possible to move the host MSI remapping into the
IMSIC irqdomain. I can do that for this series and see what Anup thinks
about putting it there. A per-device IOMMU irqdomain will still be needed
later for guest irqbypass through irq_set_vcpu_affinity(), but that can
wait for the next series.

Thanks,
drew
