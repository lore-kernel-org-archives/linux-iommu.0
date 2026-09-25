Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674A4C9E07
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349459; cv=none; b=hbDYi4/m7BsaJDN1Fv5xu4Oagok1xVgPEm50YAI5X3BpQ79vKBtAJ/GKTtcWyiQMRQ8D7mlS/hfrVRe+kOjDFXu8RIlBtD0Zv7DZBBxv+5qyjG6rlO0Afck1vSmUP8VPKzpoaMxxP2bfIPlodKUaxbLsVRKyP+LJxqQ9NXu7RSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349459; c=relaxed/simple;
	bh=a5oytnDkmMXynqtEz5VrJ07XBRBsaDHHyN2LUZ/r3Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkwVaQx2nMXkj7w7P+6CZ2Vf3ND5/yRxoJtHdX3KoJeGt9YN0m6iqxNeQ0oRDjaqYVAH7D8fLopogPWps0t4itb4qQAv8kS5KcSTWvY6DA5e0R4v8SsBDhkalme9MKawnbe5HJawgGQl65X0u/fb+vpIenIn3RJ2LUYbJPCfiv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=anZX7FM+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T55gZzHY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="anZX7FM+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T55gZzHY"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PBLl8m900563
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=FqZyxFQiqFO
	gguIkL3ayyqgZx2I4bO9MC3PloM4KLYg=; b=anZX7FM+R8lHsC29l45QTc82xuP
	LhidCHKsY06Ajxus7clL2vWKSxAMpp9e9EQ76IBuRac6LzzlpaHO6onI3r2e7Bd+
	NgmrCjYXOzfqfp+729/uh95Fqt+HKkgKKirYOq5b8Gkswr7n14MTt6APKXO8a6ni
	6Cy6wSqZrzEw8NrsnlbmR/I/DMNvswALPpy2UiI1RFUnYWSkW6OpUbcgoFF9Tyqn
	ZRwWdK/chY2AzGSQ+osxnFOzbOGolEqWtNIXvLrsjEfPpsBQWHGVanJKIFfHoa6K
	jRS6M2q7TeWXtC6pGLVW8cAZthIVXpp82XDkZdN+35qiAj1v4DOZAM2AHqQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwr100rmw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:29 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9857717bd19so100276241.2
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 08:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790349449; x=1790954249; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FqZyxFQiqFOgguIkL3ayyqgZx2I4bO9MC3PloM4KLYg=;
        b=T55gZzHYVPFW4khZatxWNvp27xZavcOi8MEJiFTfE8rRxciaA59pClZfrMYvJe4ojz
         VvhkFcWjNWTrl06hpzgx9OzZeOqCTG/WEFu4huxzEXNiQywZvr7+rd9BKOYYflu4SgcJ
         wznQZk7SrcZagjtiyhxosyhLCwPHYqzt/5q+U4VK/uiQ+9QArLjBLHZma6kQ2rXaVZfH
         AJM7+o9N3oUG+ACEYvmc2zsaopesjp0ULFCwLbPQT/S99L9b0htEXooRxPv4yJVPxFV8
         IDsA/kxgPHXUcsob7wBfT6pPDrYvHcKqEKQLDhX3NiZNhkxq66CWwk84BXpQrlOAXA9b
         0hFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349449; x=1790954249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FqZyxFQiqFOgguIkL3ayyqgZx2I4bO9MC3PloM4KLYg=;
        b=ARdDoVtWa5/rG8316recID+fytlbzTOdpPCxlbtHaV297spWj5FtryjR9ZJ+lgH311
         LfqIOQ1dAs6Tsyv0n4g0t/New6lnQReHrqzcBXHlrS1C4DDX0yRPsGvxX2znrCdTfZOL
         dCRPDrNnMQzubYP+mYzeDeaeycod4d1Efd05SJrhleqPb5uRN+yceLnZ6ji2jX8k25eU
         pODowjSDxxLTLEN4a2gbj1dPJvqWJuZEhPcJ3Stk+b2tbxcj9TgbF5SY6cpf+T2IB7UA
         XveCxdJhJE5uWNdkgpyxD0dhlpOCBWlazdIpzk0Ilag4hWicOd/3QlL36cQOJowDiAvI
         Pdfw==
X-Forwarded-Encrypted: i=1; AKwUvBzo03CO6t3tdkODPB6rMg2W8jeacvl4mvBCT8ZPgEkvqASkIokv5qOj/rPKtLcAUAE2rL7Qsg==@lists.linux.dev
X-Gm-Message-State: AFuF++nsHA16G5Pbr0YmsD/rzc24WwIiEX3IFxNK6zCbDwhdk5OLAAQ0
	Tt/v34dGExb1HKbqFTnX3O2vr4+hMRrIrhypXmsM/JGiiirSTEOpy8MGbEVa2CtMSsuAeYpJYVs
	xlk3x0HcZE7YhSvw9SzUw8oYsWsWhT5o/KW99EeBiw9w+aY2BqMiKE3EBxQ==
X-Gm-Gg: AYBFou2nQevBdURI3hVD1fqPQx7GVJo4oJK8EGQspN0uHGhVtOmmz48z4eMzNLIMvjI
	iUlBXyXy3AneK85cewm9vd8r2Hi49Ag+EBzVvuCrUmxb9+WLPMbWzEE1EMqdwI09BxBAnuqstX8
	RCHibO+q8FSc7H89qBytC78h5egz5KF2pCCbzgV0CsBxn9f8gVNlKlChY5N8DuOUboAlsyW1fGq
	5fub8aA8pNFf8GL91cWxB4gHykDx5PACuADsOPL03uLrTAg+mX6/GdXvw3IGozCL+sQui0FwJgo
	XuK2iU6YKS+QGra+vUiYzcfYkX+nUbkZpmK/AowudztVHwKzMeZVl35GRBtZMB0orqPoOGt7pJR
	SKhXY/TfL6VnlnokuBA/9qyBDj3ZFiOzMd2TI3w==
X-Received: by 2002:a67:e703:0:b0:7a5:c8c4:fe87 with SMTP id ada2fe7eead31-7af1cb9a2bdmr2325506137.9.1790349449291;
        Fri, 25 Sep 2026 08:17:29 -0700 (PDT)
X-Received: by 2002:a67:e703:0:b0:7a5:c8c4:fe87 with SMTP id ada2fe7eead31-7af1cb9a2bdmr2325492137.9.1790349448726;
        Fri, 25 Sep 2026 08:17:28 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5cd4271sm230756115e9.5.2026.09.25.08.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:17:27 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com,
        Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v6 14/16] RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch
Date: Fri, 25 Sep 2026 17:16:57 +0200
Message-ID: <20260925151659.419512-15-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
References: <20260925151659.419512-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfXytL8dIa15l0J
 ceIiHXnHMBVL1DDcSAzJEkYFXFWpnEKDkRoBhDguwjvfHof6SF9Vfw87DQeNb0JI6xaVk1UC5TL
 36HW0/gHhGGRIhFRBW0Up7fAExJyKLlLgWDb2ImF2yCPyMaNWzcAzn5PpKvLYdGzomoTaV7Rnhz
 U3UmgsrTBNVHh/sGwHZPDUm9Iy552t9f0MNTIoLT9BVgbGquyzm8y1tcMDkcKhkXHZ9ty8faQq8
 /IlcVP+UfnHPawriv5nBm1RQrWz+7uZUZ4Ycec7ZTg9+r6BI4t+XWcPjknw+rZs06qPP+D7zajW
 t/bfbYbdk03Djk4Ow23lLvkBWwqTJG0N9cmOSIX3E34LCxdmCdeHYBrL/B2ymaZYo4qsY2I7nK9
 NxxNAy9LS4P/96VfvAmIuEcXJ5zbp9ceHoHsu6T4I2NgzMJgUVBhS8FWU+NbqvnPXwO6yze6hOF
 IaNQKuel7LmqCO/bCiQ==
X-Authority-Analysis: v=2.4 cv=ZfKIpcVA c=1 sm=1 tr=0 ts=6ab69089 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=h0uksLzaAAAA:8
 a=EUspDBNiAAAA:8 a=69EAbJreAAAA:8 a=SRrdq9N9AAAA:8 a=Hp3hLBw8nfLOXl02dSwA:9
 a=o1xkdb1NAhiiM49bd1HK:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-ORIG-GUID: -OKwsqgkXsxi9kx2GI6-XsJu_rOZY4Qs
X-Proofpoint-GUID: -OKwsqgkXsxi9kx2GI6-XsJu_rOZY4Qs
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfXyIlkdaUOdrzU
 iyUHJgynIjjwMuMXbBqbqVD+Nz3GwSJjvctabBbD3Vi9iEic0+Y8nUvbzg/zel/rqCthSQOL73Z
 KQVmwOIGzFvEkEj7sSB5Nv3vlW59T94=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250060

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Enable KVM/VFIO support on RISC-V architecture, now that VFIO device
assignment is available on RISC-V through VFIO_IOMMU_TYPE1, so a
RISC-V KVM guest can be notified about VFIO-assigned devices.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 arch/riscv/kvm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index ec2cee0a39e0..49179aae9504 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -29,6 +29,7 @@ config KVM
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_GENERIC_HARDWARE_ENABLING
 	select KVM_MMIO
+	select KVM_VFIO
 	select VIRT_XFER_TO_GUEST_WORK
 	select SCHED_INFO
 	select GUEST_PERF_EVENTS if PERF_EVENTS
-- 
2.43.0

