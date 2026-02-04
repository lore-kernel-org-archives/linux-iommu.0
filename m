Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD92421EF4
	for <iommu@lists.linux.dev>; Wed,  4 Feb 2026 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770230387; cv=none; b=d2T2GhEg5rpwyHyr9P6yG49p8erWXov4mZdV2QbU4sXJHNw9z25EefZJpDME2+tTu4kIBtp663zGAUfOulo5YPURBheNrVamcK9uITuW39iYPePHreCvnyrEBjbb0T+d0BpLk3wFzJsvtDxDiiwWyzTldJQhjmQXzXrXc7+2SN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770230387; c=relaxed/simple;
	bh=4xHL8leDKCLz6JEsceKtUmCPHoByynQNq65Q405b+EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKn645OQn7/WmpLr7PP1xkjX9RddEdfaEKbmDSRF3yKrWvbiDPXGNRtkZ0NzYNgLRmc/ZqPC+eRMHGEsC6TOops4Gzt9uyZ8Lz3Dntvn+RyFOV8Ul7nEK7JdVNj+Kx9I/LF57TmK9bXoNQtOy8Yh7PXbQu97nyObZU2NayoTraI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VsWk7wql; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YT6V8uoH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VsWk7wql";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YT6V8uoH"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CIO8l787448
	for <iommu@lists.linux.dev>; Wed, 4 Feb 2026 18:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=I1Ej76cz71aZvXkYw99NqdEA
	d6dQhn3hI8uMX6IFc2o=; b=VsWk7wqlkw6gDKSyQDZyl6ZypAYi3bN6sGNiUk+K
	I3gipjoxIWCkPAsT7Ko5OCYT8tAXiBBHRx+4JX7Q4CjA0CU/Sr+pmNZDP71LPQR8
	UTp0eekjVMab+8ODgqgrJIUnEfRXBLzjLK3Vkw8y5SK+rxZHrcoWAFe0dVwi2FCA
	2+ukxmOEiwjdMRACDzBkry5EG1JL3ieU/51HH+cQkBe1bMCbDOxCKCv7qMU029DK
	H3aHq2XTUVxGaN8bD90tNJW8qeGxsq4GLLM1ru44v69RZad7uYLcRElryHnYsPOE
	U7Fh7aOmErfL8wGB6OUd0vP55aC7ltAwrR/T2wLkOMjkvA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c43uxhqwh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 04 Feb 2026 18:39:46 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-124a978ba9bso273847c88.0
        for <iommu@lists.linux.dev>; Wed, 04 Feb 2026 10:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770230385; x=1770835185; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I1Ej76cz71aZvXkYw99NqdEAd6dQhn3hI8uMX6IFc2o=;
        b=YT6V8uoHK2l9QLY+xMceNbAbQEcGHNJPjfBtOISX35wTyiLNZOLj7OZub/9WlmZ+y8
         OjhxXfJR3bv/5ifhgip2fMiPapon9V3TeyJWjP23Jo0tOPQAbXRtABTLf2mYUqCqsrK5
         fdHNe9CIi+YyNyC3y9N4Olx0VMi1Y6uuf5KGiZoi6jw+5eH42OhWNSkGjH/aR5fy+aau
         OmG3yuMF8l1IrJrG6SsZNKFGT7oGHBKS23L9tOG5/R/frvP2QfB3JgCVyY7R+x4rq0hS
         pNpRRT6eb3tJmETObZX8+w1f5Zf16LQfPgU4V5VnXjGQjy+gng6QFA05XrW8GcR3FSZK
         Gw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770230385; x=1770835185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1Ej76cz71aZvXkYw99NqdEAd6dQhn3hI8uMX6IFc2o=;
        b=oBbiUVxM1e2bLjPGTfnZYW7eFdvrN/SbCfD9nCRagBp75zC+8NMi0AkeXtKwiwHXGO
         4yjhf5w1W8U+Bi8bRpE+cKHmh4R/rHTmq2RVXdVmnw/r/GJs1oPuxH0gADSleMzP+yTD
         iifeJ5ycUMXSz+NEZAIKWiV/2ou67IDTzLkqFUJLcs4hXObk4spfFHKU+Oxall243ONt
         mbm4iNJPboNXJ85s0Rbw/koka4vw7qp/ZYmhhZQ7VkQdiRkoHrzMRVxubXXKzjlquJm1
         S7VNpiXNU5csSLKt5O++8EC5QuhcZbwuEX9wKSWxsl9I8Fegp0kOiAiJsvAlvguX2l0s
         eZ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPlxxXFeY1iibMA4wo+nJKtTJsyBWBYTtp2g43oCFyK3t6bs9aqA1K+QYqRpezg7LpuGqRKA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9plQcIWFhJVcMoIDV9P0d0xG4v+YELdhAm1EAB2Hn0eAu/hSh
	okm/fL/PoZ3HhEgVo3B+4cWYxkGdD4epQdsuZboPLyrT7Jtz+QSC2Fx9Q/OVaEqoUv++akVTM4r
	rYgaOBb2X+8/WlPWMxzxWsH+LR8Am6bmi4lzJIHwSH6BR0ulRf4qsbEVMgg==
X-Gm-Gg: AZuq6aICvJQ08ZPaab+DcpZ3zGNYhEdnjGJCORHdY56c/QXZNX/R+CzxxbWai0cgLKT
	0sQ929kaLrrUIRR4HssP5/8hq/nGtmBjV0GdmLJkhBlp4PWSvHu6cLX/cY83MapuALMPYbXFACc
	hA6GrHaBSRMp58swfD0G2fpjrWZ4avMVqLHBpAAp7RlOydvxxrfMo8f8IyTV7eUlwkoOC5qgXCN
	004VM3vQZe2Jk57v4tgdgz/NoDLu3s6sOBhe6tzZ9uoBy0wnqAM+65urcPMf5cD6kLQ3HmNsj9B
	qULY8XO8FJc/Pk29d+YQxTmnSQOHC6wvDTY/JVBi8Do03YgVCYNwPR6Bkk5AoYgFJ+pTsqN1yW0
	skM280DwdWsjqLAuESjk=
X-Received: by 2002:a05:7022:b91:b0:124:a610:62f6 with SMTP id a92af1059eb24-126f48e2d5amr1318237c88.44.1770230385414;
        Wed, 04 Feb 2026 10:39:45 -0800 (PST)
X-Received: by 2002:a05:7022:b91:b0:124:a610:62f6 with SMTP id a92af1059eb24-126f48e2d5amr1318219c88.44.1770230384803;
        Wed, 04 Feb 2026 10:39:44 -0800 (PST)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f5030e22sm2666926c88.10.2026.02.04.10.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 10:39:44 -0800 (PST)
Date: Wed, 4 Feb 2026 12:39:41 -0600
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Lv Zheng <lv.zheng@linux.spacemit.com>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Jingyu Li <joey.li@spacemit.com>,
        Zhijian Chen <zhijian@spacemit.com>, iommu@lists.linux.dev,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        spacemit@lists.linux.dev, devicetree@vger.kernel.org,
        zong.li@sifive.com
Subject: Re: [PATCH v3 3/8] iommu/riscv: Add HPM support for performance
 monitoring
Message-ID: <p74snip7yykhogvzqld4gyjlygmd2z4kqnat7w3qj63fwebnmm@dlz6tloevgbs>
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <9C0A2AD4850D179B+524146e74e808db90d5f28fcb6ee791cf1d1bfaa.1770195980.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9C0A2AD4850D179B+524146e74e808db90d5f28fcb6ee791cf1d1bfaa.1770195980.git.lv.zheng@linux.spacemit.com>
X-Authority-Analysis: v=2.4 cv=StqdKfO0 c=1 sm=1 tr=0 ts=69839272 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pFyQfRViAAAA:8 a=NEAV23lmAAAA:8
 a=lv0vYI88AAAA:8 a=ZVKkqgoUvZHFR46stTEA:9 a=CjuIK1q_8ugA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=oJz5jJLG1JtSoe7EL652:22 a=9qqun4PRrEabIEPCFt1_:22
X-Proofpoint-GUID: M3GmNtn7S0cOT9l0xCeWZBApsxfP4OtM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDE0MiBTYWx0ZWRfX+MOAIZvhjqNA
 A+UgIh1+AwTWs5ywwumYY7lVg5b3o765l6CxaIJivz0eqQoNbHsAb+uamHnnpmHtIV51x/IL9Xm
 6uxfv9OniRTtqUrFJNGgT3y35dEej7sqoHh+MV0/FNk81D4Oz+fSZOkOGsYZBe4Ng/WVQt2abIi
 b+thQUynwn5CUmIyoBdzXNM+vTh755M+PwbZt5gYrgruxEfDyC3InnDcGmNPKkE9Eikm2te1I6c
 E7TFy2V5RP7YMbf4MqfIBFKY28klFeZ3L7JTJE7eWyLk99qtJ05vP2GsFsmMdKsT8BzhskIxBx0
 f9fa9I7G8mTkhlkrEKy18FpDVvjTtISauSPQy0qF+w1THMmj0T2dznM2ZPQOHx0MZniJD4lE7Km
 gH25EYOBkCYmdM27Qo7+UTKfEYN5jFPLCsTyXbbm6zPE4wyQs4VieK74hFM2K+VXA+ItrOeBCmo
 n0MznJhfLcKlClNxF3Q==
X-Proofpoint-ORIG-GUID: M3GmNtn7S0cOT9l0xCeWZBApsxfP4OtM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_06,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040142

How does this relate to 

https://lore.kernel.org/all/20250115030306.29735-1-zong.li@sifive.com/

From a quick skim it looks like there's plenty of overlap.

Thanks,
drew


On Wed, Feb 04, 2026 at 05:09:01PM +0800, Lv Zheng wrote:
> From: Jingyu Li <joey.li@spacemit.com>
> 
> Introduces perf-based HPM driver for RISC-V IOMMU, enabling performance
> monitoring capabilities.
> 
> Note that the RISC-V IOMMU HPM module uses COUNTER_MAX-1 as a static
> counter index of HPMCYCLES, and 0~COUNTER_MAX-2 as the dynamic counter
> indexes of other HPMEVENTS in order to correctly index into IOHPMEVT and
> IOHPMCTR registers that have already been defined in the iommu-bits.h.
> However the users treat 0 as the index of HPMCYCLES and 1~COUNTER_MAX-1 as
> the indexes of other HPMEVENTS, thus care should be taken in dealing with
> counter indexes between userspace and kernel space.
> 
> Signed-off-by: Jingyu Li <joey.li@spacemit.com>
> Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
> Link: https://github.com/riscv-non-isa/riscv-iommu
> ---
>  drivers/iommu/riscv/Kconfig          |   9 +
>  drivers/iommu/riscv/Makefile         |   1 +
>  drivers/iommu/riscv/iommu-bits.h     |   6 +
>  drivers/iommu/riscv/iommu-hpm.c      | 843 +++++++++++++++++++++++++++
>  drivers/iommu/riscv/iommu-pci.c      |  13 +-
>  drivers/iommu/riscv/iommu-platform.c |   8 +-
>  drivers/iommu/riscv/iommu.h          |  42 ++
>  7 files changed, 919 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/iommu/riscv/iommu-hpm.c
> 
