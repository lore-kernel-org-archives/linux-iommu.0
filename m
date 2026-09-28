Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76CA4973AA
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590859; cv=none; b=CXMi+pMlZVXkhf9U7thQGsn8BjprMJvi9MSJp/HnNxZpy6bXPXqyUYvIyJWvYPSzflSEmG/ICB0gfdKl2pexzQGVfmUnxHncQdRYmq47me5gRqcOyP4LUNQ10GWwXH1oZVilvGNmT12dgZ7IX12tPbJTt6PEc8Pq3tq+efOi0f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590859; c=relaxed/simple;
	bh=ObulXsSUbt5b1BlK/NY/o/9kun1M+44BCZu4NGNgZZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sT1M/ZxQU/cbMOkX9RLh+cEKEaIAwqMWZ3J9hLfoQlDipLJ2QzgL7JNfrdUMB9QAGzl1sdh4/mp+MS2JfsrcJVXCA0MpO5iNhVWyso3IIW16610INj8o0ga8aMTDHx/cDmrmqxpy9IYPYxpDsq7Qw3jOY2YiOMD0q7B+ADhzr1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hKFVFnf5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IMHhXgkJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hKFVFnf5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IMHhXgkJ"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S9MDAs2168227
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 10:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LNvreq1RRV6+/G/WXMIv7HZy
	uYx4WiTqcHV8qcpeqIo=; b=hKFVFnf5bWxCxr/6oIfHPODASy6vBNTHh6i07HZS
	UTbq/qoAv6JZVNBYZwH+1aBstmm+aN7BWrn4Ebh2ZakOLP/kdDenS7Tq24jfFvtt
	L/r6BXWlloTHkc+Bv/V1TF+8Trl/SqsEw1jfJ0PukKSmHDEmppsBFeKBJP5mjupG
	1JPsZOzkj/DQN4B+vT7OMHUKLzgJBG9RAyMBhIekq8OoO9Ngc9eNoFYshJkVg2G0
	TFuOrqHa6anHINX+9K6bspSc1R6lEU2TPlRO2gbzJ2b8e/pcSKIsAdSbWTyszEC7
	cF+3irStk4OYHwitYEGO1W4Kfap2y7BwESqGCiMxtZ+3Pg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj6t126w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 10:20:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93c5ab5c136so297929785a.3
        for <iommu@lists.linux.dev>; Mon, 28 Sep 2026 03:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790590856; x=1791195656; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LNvreq1RRV6+/G/WXMIv7HZyuYx4WiTqcHV8qcpeqIo=;
        b=IMHhXgkJKFNMSPLzwl9ypTYGY7Q7+KYFHW7HpvLWtDWBzdZWi+CBjgd0w5iI6GyS2q
         +5oFW27Zkpf3mhzKD3k4AHVaBWuS6qBsCJg2R+4Q94ryod2X/47GF/JXz0DstSjk33+v
         TWjmfEzyw2TTGKbgb34JiILF/+aFA3mN7E7mHg1qK9r+FGHn6seMDVn829MZsLzzObTZ
         q9yfoSsHsflDG6qyKguAZDXD/z7HfHdD4nz1bVFRahw8cPbsGt//uegw8qxeUmcn2al4
         ho14kc2jh6RS3TGSGsBTRwZDfBgPhnME+7gmkbi/yN9KO28mrIHOi17NHDZ+RrwnQx3K
         Gj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790590856; x=1791195656;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LNvreq1RRV6+/G/WXMIv7HZyuYx4WiTqcHV8qcpeqIo=;
        b=f6hcIll6X+Aj+J37GmO/r+/cqvLxHEKX5a0vFfbh5wvYvIimoBCM2kgLgC95iaHF0g
         K8dy9LxNlarDFlu6SpH9eSZ6yc9tCqSKjJRBT5wahlyjZTDiE7aUso7JiviN9ISatH4I
         tPC+uIVJI6mYFPCNhJdVqYoHjjQ2egw1oNTzjel+dGogwt+EqGnTkqkD7y5h+7Wmuljy
         +5BQ7xHP1AUXnzx/FeuD5QvOFFAhxoYsx0GcbQf6CTm/2+aVtM8y7UWqpxFqOAnTghd0
         NTTW1i5GWPiLl+iZwa5KNRz4iFgpNIewX0IqTICDOybB5+zLt5j9MHgf7QC1CrXu/Lhj
         yY+w==
X-Forwarded-Encrypted: i=1; AKwUvBxKB1j9lFzgTCVtOBANswkocuq4Egyms76DvRthljLq86fSp1nxOfiA98JeS7GAXTFZSUXPWA==@lists.linux.dev
X-Gm-Message-State: AFuF++lITfYTC/b5AtrgGvqhvFCM1Bew+uXuvZeM+mYZMAz/G8ZpnYZ6
	eqgCXt9GdKq9nOWqwsdcwTsQXuhTj4abTOqFYCCpOFjkI2npkPtpXSUmR2jtEr0Abar8sHsIdI+
	/5j6sdr4Jt83izsTdw0RWGDouyZER3grwv8uEhr1hgN81UMszDLgffHgOxA==
X-Gm-Gg: AYBFou09P9hOtn/nBlApS8cWUAlB76073hMVZCZgrkB6IEnSGcdV15pP7UPvVZngw6k
	TOwyMKojzlM5MNuM/low6B8UgBd0cANrn3alu+yMbhx7M1xvNmWgHYmW4AjqY0S+UcllquytB6A
	F6ayNpvGmci3aV5HLvuLPL/8v0FkagLtPs0UegXlpbtRPiDSVUX08nKpCC7OadihMoRTQkG5cli
	EY94/543yP/sgdolxM/sKvWou4pi7zsYE1ULHIdPuG7Z+8SQm9N3oWbwvorrLQJC+qU/t68Gra3
	b0h5vgS5ccj4f91C4AIwPY50wCLfHmVHO5xqkU2eoV8vHl53yT75cFq/Iv4mg04vJgvOtqM4+fB
	sZ5tE3E9/XTDJ15sBzwqajC3nJIb8HI3R+5h4ag==
X-Received: by 2002:a05:620a:40d2:b0:93b:fafd:3adf with SMTP id af79cd13be357-93c43d0ddf0mr1872145485a.48.1790590855785;
        Mon, 28 Sep 2026 03:20:55 -0700 (PDT)
X-Received: by 2002:a05:620a:40d2:b0:93b:fafd:3adf with SMTP id af79cd13be357-93c43d0ddf0mr1872141985a.48.1790590855273;
        Mon, 28 Sep 2026 03:20:55 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a64ef3asm26815729f8f.30.2026.09.28.03.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:20:54 -0700 (PDT)
Date: Mon, 28 Sep 2026 12:20:52 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: Re: [PATCH v6 10/16] irqchip/riscv-imsic: Add MSI address list
Message-ID: <ocjk3jylktlomol75tprkquallwhajlrcrjcjfiycfnhlsxcep@nk73eccs2gqc>
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
 <20260925151659.419512-11-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925151659.419512-11-andrew.jones@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0MSBTYWx0ZWRfX2OZLYlv0rg+M
 AASbxq3EvPH97hQfvfqaZnROUgVsclu9dnHuqXM0PcaYFnHxudWmhVGERUWRypxFkZrOCgSqUh+
 zQJ1KyCQ7JBTPF73J65mFze66BXDw7LqkTp1RLhoxkxJvW3YfoE+g5VEJRD/3AcLphSKGCDCTdj
 5b8D81fu6NwtIVphwtz3rwwzCP6Ajt44wJJ/idwW4xsQOtChYgjAKvOkfXWVyksv54rr5nKbA/i
 cBuQRW355+vnMcGDqG7aqF9n7WMWscooQkIZJuNW5Dn8qxksYfIxL4fh7bpr2jpyHmPfhOcFmZd
 5e3EJIajgcrJR3rmf3vfyH5ZDEKUgb4MIg08VLQjA91JdxEljxaX/WilzhWRb+XsyBs88FBEkOX
 VLvSVtx6az1d1RByhCxn8JRb4yqJDscWBBGia5jFX7x0vnRWR/lJnnMQc88nvIeHCgloMxJkhit
 vx7uGBGg6Zeib0vBgGw==
X-Proofpoint-ORIG-GUID: NoMhuSAuAQQgn9ZiTiQ6caqL-i9fY04q
X-Authority-Analysis: v=2.4 cv=dZkVTnXe c=1 sm=1 tr=0 ts=6aba3f88 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SRrdq9N9AAAA:8 a=azrel2x1CCEZ_N9yfE4A:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: NoMhuSAuAQQgn9ZiTiQ6caqL-i9fY04q
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0MSBTYWx0ZWRfXymuqjwTb1lDg
 wpvL3ETexhPMlXeOOuc3hY5SQIeoxr43FvYWOZgWqHbp+fKFhQxjKsEAjtbCB5yj27Gx/T2PmR7
 rSBgeHkuWN4cisOqSebavJItHvifRWg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280041

On Fri, Sep 25, 2026 at 05:16:53PM +0200, Andrew Jones wrote:
> Upcoming RISC-V IOMMU interrupt remapping needs to map every possible
> host IMSIC target into one contiguous MSI IOVA range. MSI message
> composition then uses the target CPU's position within that range.
> 
> Build an IMSIC physical address array indexed by logical CPU.
> Require every possible CPU to have an initialized IMSIC page before
> publishing the array. This preserves physical address zero as a valid
> target and guarantees the array has num_possible_cpus() entries.
> 
> The array size and each target's index can therefore be derived
> directly, without storing duplicate count or per-CPU index metadata.
> 
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/irqchip/irq-riscv-imsic-state.c | 32 +++++++++++++++++++++++++
>  drivers/irqchip/irq-riscv-imsic-state.h |  3 +++
>  2 files changed, 35 insertions(+)
>

Regarding the Sashiko findings for this patch. The first I already
responded to on v5[1] and the second, which is new, is complaining
about the error handing in imsic_setup_state() for the new call to
imsic_init_msi_pa_list(), but the error handling follows the pattern
of all other error handling for that function. So there is nothing
to do for Sashiko here.

[1] https://lore.kernel.org/all/20260901133835.345001-1-andrew.jones@oss.qualcomm.com/

Thanks,
drew
