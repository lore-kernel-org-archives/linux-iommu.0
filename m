Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823CF4FB9D4
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188413; cv=none; b=mgTNtM4TaNGU6wAM6ttM8JiinyL+kx7CxTLoGm8HVNIu+NGnitLg9yKN6z9AOXtA/wqv65ixPjPaHoKE5mAFoU4LuYt6iOZfnmm7ICKQIR7dYXjWSf11O/cOuvkw6vgCbFhDlPtTe71HZ6LHX27t8UO0liQkSQfAhbZES4znojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188413; c=relaxed/simple;
	bh=TFwknJ0YqCRA1LM+i6U61SM1MSuulgej0FGruggnW7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gU8vK0fPEk82V5BfEpi7p54HZsywDsaL+UHA9V3bGZjfuLSdazopO2J/qsqQWrjpXggQCGnuh9jpQqFEEj+I6zdkkNDslyujXnklvtKXIKh0XVFLFwob4pdzpf461RkMveXEgQkhrVA7EcosTZz1k2hUUwpKgotYTu6BtyaJI9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FJY+UZ5w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Td1ACQ8l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FJY+UZ5w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Td1ACQ8l"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VETQDs3296595
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Z/0MUXfJDNe
	HlErsfNSNArUm0DaS7PuJvPVjEpFxNjQ=; b=FJY+UZ5wY0Pooggdsd9At+BbBAQ
	Lp1R9dHZfYhnMrLjazZTQTXXwd13pRpgl/GN0BiudGNYxrw9VJpGYA4/YN7zt+BP
	aoo3n6IhpIxds9ukDfa3Sy65BuHW8PBuOBZZoKTkzKymwwgZxWhkpPsQJudLB+hX
	jYhqzb9rpHN2MJ+JtRsxBOLlSrh/I93wMoGfQbgpJCbBwxtANfeHpX1GK7IZhdSF
	DT56QYgg5H6tyR14AvzaAySlrenn2x2hcYYQ6bm62wz2pEs6RL6l70pKoxfbbSFE
	i1BL/AkVHtlAYA96jrfouNy7xxL2zzlszBLikRA8Pb5ENI6VCcUbT2hdxGg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6ayhj0q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-936708f129aso455743385a.0
        for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 08:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788188410; x=1788793210; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z/0MUXfJDNeHlErsfNSNArUm0DaS7PuJvPVjEpFxNjQ=;
        b=Td1ACQ8lSXx+CnKM1Uq0ZvR8laa+LocIo0gV/OSl3iRCx/jeTZegOIHkDJcYUco8sE
         3xnWgsp1/Q1sQoy6QfuQLFLOCF2D5QOaf5nPNc0Itnvn95HegFO/EGmW84pt+PKQhwXH
         alqgyhZAz6TkyBdCG/3Nm7hM4tZLVzbxI+jYhQsukCzYYr/KPeHXGYJMLWH+EWJkBy6P
         /LlPriu0AokvZFM3vZXakXe63JQoOgK1oryRaeFCsL/TrTTufOD43ZlZXtfsWuG8CfGM
         Bq7Il4kJsvg6/iArvsXL0OsjUMX6tVtR2LOyRUQS52I+h1m/DmdxDE4KF11EShU1Uuva
         JHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188410; x=1788793210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z/0MUXfJDNeHlErsfNSNArUm0DaS7PuJvPVjEpFxNjQ=;
        b=jsqa7BJNrbae9iTCB+3dPCESgCiE2dkUHzU0LrgAWqSE+L2+B1iGwrcG9UftP45xcE
         sq2jCny2nXQpZnVncwUjRFmcS7JucvccxNbK8uZiJKMDjtulLupsKyFb39lClGYVjh7V
         MPY9XbSdOTzWstFZafWhflJiXXh8faeZtwawpeBe9+P4V7GpyZSZp1vlP21HsV3N/RYB
         FihaSAhyLn+F2SKwC0otguiv2Tuve2yPRlteSjRNFyJFpvuuTxNat3UuITfU0c23Cw+A
         feZHSDwRLIWWJipjPVUEA4Hs8dWm1COcOVLV3NwzMqqiaYJdIIRqevnlrBb9WLJWac0w
         NkUw==
X-Forwarded-Encrypted: i=1; AHgh+RrvR6pqc61+6gT9fLg0+2QCCrBeN4PoKMId/NfaxfbZiqVlb2R7Lf2R1DzwTLlwWnZaV6pQ4w==@lists.linux.dev
X-Gm-Message-State: AFuF++kL//cNU3wZUJfvLOqbmz2Cjix+GD+olIv0+EZ6AcCKZ1WUxg8z
	x2Ge3lsj7TSOkhUAhIYjP9+aOhhOxloXekluiDqt2ARIcWA1Xd0wYUW3S8tOMJAp8d6zJGiR+f8
	mJVaaaomEympLlg82RRuecargzfx49bipxWTlpwFabCiGJKQNhlD7Z+QiDA==
X-Gm-Gg: AR+sD11b0SNxABaGixwyGULxZYiQqBJf6ExQE5ZrtYVTXA1tY6aGod+0Ti/UilBcti1
	HaY0V2GfGnxMr5g1bxnvpqlVtd0JZ6xiShfAcJHALTlk3AmsZYCuFVoiX/3CBrRd/Nsc/PXex/Z
	MHDtEd9SujpBLp8ikDG6MgpgSC1osiQtBK886GAR7LOPCO16+FtvnJgpmXSxpYSFToYZk/RNnnT
	ZGg5l3VidYEYLdgcyQBcgKg7mpY2fDxWrfyBQuZOEUTGZB3zgQeiNR2vpalWua6CiKjGNfHt5Jb
	uL4JxnWA8UkM5ESDVal+m/k0r/z6tTjpfJM1rBiyX19b+6YVjkROyWPco4EN5GHLO552w6m6M6b
	My17JoyHz0/4KDy0tu88dYb+covEPCL6rriQ=
X-Received: by 2002:a05:620a:a404:20b0:939:365b:37d8 with SMTP id af79cd13be357-9394817f9d9mr195743785a.36.1788188409470;
        Mon, 31 Aug 2026 08:00:09 -0700 (PDT)
X-Received: by 2002:a05:620a:a404:20b0:939:365b:37d8 with SMTP id af79cd13be357-9394817f9d9mr195730785a.36.1788188408868;
        Mon, 31 Aug 2026 08:00:08 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ccd1e19desm252798825e9.1.2026.08.31.08.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:00:08 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com,
        Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v5 14/17] vfio: enable IOMMU_TYPE1 for RISC-V
Date: Mon, 31 Aug 2026 16:59:40 +0200
Message-ID: <20260831145943.313726-15-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com>
References: <20260831145943.313726-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfX0uD6alRZeBU2
 JeUaOV1AWx+TGL1LdzCAEYeAOm8U7Yw+JoCxT/cEqJSvXpdc9CS9c9coOgNZrB71/DHvEq373SU
 cA3xKPj8Q8ESidI2ZKy7lie/igPgFJs=
X-Proofpoint-GUID: e0lkpKedXT-wVC5xy8BO_wgBNYCMcYmX
X-Authority-Analysis: v=2.4 cv=CYE4Irrl c=1 sm=1 tr=0 ts=6a9596fa cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=h0uksLzaAAAA:8
 a=EUspDBNiAAAA:8 a=69EAbJreAAAA:8 a=e-vb6wPzIjHU0Swrx_MA:9
 a=IoWCM6iH3mJn3m4BftBB:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-ORIG-GUID: e0lkpKedXT-wVC5xy8BO_wgBNYCMcYmX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfX05Sej5aAkIZg
 X9UXzsYQkEJDu/j/gphrG72orliMp8u5sKYp9rPVgnqJDrX/kTghpkAn/dBPpVirupSMlR9mx5N
 Gx+Z2ZqfVnYog8zW+ol/VkEMpiS5tZdk553joNzPHhEQKmiT5NlzcvhuxUKbCKnxkdURf8xTxJg
 GtdQVQVn/cbbugQjGkWUsFg9U9uLI39t6Xcy1PJMVsxbuLM5NCyFDx9a7SLsD15Eze1frMyDEok
 F87P+3gKrLDTt25FLXzXvqgDIgrQMgCrpzUK3ieFNhfu+74BD3cQRfhf2/pP+BjBOp8x2zAQOc7
 +lTmt76lI1zLof8UIAJKtlDnRLHl/9DYz7iymvTxmFOUzSIHMNdPEirlAKp7hsbhoXvpXdg2Ye4
 dungehLTvC2SXJ4uG18SeG494sS8fV8eAx3VwxS84Wg32i5NA+M13PysNr3VFthha7XLpPPrxwv
 NXFa9T2KILM9gXlsnKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310129

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Enable VFIO support on RISC-V architecture, now that the RISC-V IOMMU
driver reports the IOMMU_CAP_CACHE_COHERENCY capability VFIO_TYPE1 and
iommufd both require before allowing a device to be bound.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 drivers/vfio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index ceae52fd7586..ad62205b4e45 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -39,7 +39,7 @@ config VFIO_GROUP
 
 config VFIO_CONTAINER
 	bool "Support for the VFIO container /dev/vfio/vfio"
-	select VFIO_IOMMU_TYPE1 if MMU && (X86 || S390 || ARM || ARM64)
+	select VFIO_IOMMU_TYPE1 if MMU && (X86 || S390 || ARM || ARM64 || RISCV)
 	depends on VFIO_GROUP
 	default y
 	help
-- 
2.43.0

