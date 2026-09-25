Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9164C6526
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349462; cv=none; b=BO7QuGgLMZY9ToAiuFz050fUfkzYttg9CwAdfJdcM3DuExWw9MFo/F9iMj7NeR0nfdxGSpguObWdzg4HhpuU+tlJVzVDd0IqULaVBCpfOQdBMm/irIqc2OeJoA5PhuNKYKA7e/e0QJlDTqpb9fZR599J9bfpGR747DSBOa0kn0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349462; c=relaxed/simple;
	bh=F8RSt2f/tEtIcxsDf7icCujwJ/uEq6rM1fU3FoLv9ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+nPP+Mkud0ZFvGfdXukTfSkXRQn45kGUTR07Bq5LuGT8isHL+6Zx9fU0qhD9XD6Y5xh570Vr7c7bGw6610L5A8LgH+H8MQvimfZxYPeICLodUvMYVKs0RSWRPXCzfFHf7/x+0X7T02VAdNE4+rWPslNfxpmUmv/FkFHno8wuhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cPtgrO39; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YpLTCueg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cPtgrO39";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YpLTCueg"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PEJ4Kv756680
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uXMNL24iPvL
	yDWGuh484cz07PeZoh2YQVYmOCMNTIg8=; b=cPtgrO39pjDnZP+gorSQxD1Vptx
	+efkiH39n6Dlh7KDDFMTOn0lRA3kSo3//th97jjI0Yzip8WEXvwHX/9FqO66fGDr
	7dmDLhFwa8QQNaZxbfF+3FOeFRN+AnqzvQlwGGD3z167tbrp+0zh+n8jExWYAGrf
	rHuR8JaPcihWppx9AFBPQOVVuknZjwBKJn8uZihJpJmbYYuhEZ11W0K/cVURL5hr
	CXe9/jGpu6hchcqb9/I4LmekQlqa9TY6oJQmis6WR5/EjXccwdc0/QcEO19U2i0v
	/tliGRx2iwKxj13f56VkoJWwTmjOPIKTMQ+vpsS+PA4Yb9VM40qFZ3xx+vA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq09wkt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 15:17:27 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-980b637ed69so116398241.1
        for <iommu@lists.linux.dev>; Fri, 25 Sep 2026 08:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790349447; x=1790954247; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uXMNL24iPvLyDWGuh484cz07PeZoh2YQVYmOCMNTIg8=;
        b=YpLTCuegvNdy0NS6yOeHAIJVLuTAE1airZnIF1ttCpBIyWuqJbTq+OPlqWE6C/DGzP
         9xBlouIZBhPqxJAyGzlkgilMdkpv+5tX0FSvcBJExn/q/6ZsnFP2VOhHbNM8LorWEfBg
         rBi8w/zF8wbRGwl4JT35LlYYs7S0pWRHnQZzjeM9hr/CAxEcUxZUGHzGkikjCkjzUJ1o
         P0qtZDf7sBaYPNuBk4IkxxeRYQvJbpjrSC3DnqnFQZdxXAj4yVNMf3BkYnz7Qqi/OeEB
         KmvNDFcBjSPd4X25m89L5MmAC/PKK9vSETruBoFA51w8XQ5fydHt4lfNBOvfqSckSOgc
         xMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349447; x=1790954247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uXMNL24iPvLyDWGuh484cz07PeZoh2YQVYmOCMNTIg8=;
        b=kBsM5+EYF6K0K99Yw6HAcsCqYLiR0jjrTRYvowBDExbGgR3xWf4Do+ISsTtXT9wa+i
         LIbeKjDtPWmxdsuGLrNLtjY15ssZib9EfQfQObV3rKOltzuybA72JDgTtaDWDvQmrSRF
         QP5scfkVEOKg3/lkKZ7Kt6Dq4nuigI+EyA2M5M+sPfIAkDlL9m7RuXxdxFS6ZrpMl7z+
         ZogyfnItEO9YwMcSQmAX/NdsUJeE93ACKMxqho0o2iDbXGftUMR389ufOT+gR6GNL0hn
         DJySh8YH073dqYO48HKaNQBjSIN2kaQYIHnE+pfDJYSHmat6O43HVJx1m2McvqkhNTLp
         VTaw==
X-Forwarded-Encrypted: i=1; AKwUvBzocwTkYAnODmohdqEk08Ut74eYso38QTEJy1V1X7byYhOs/c93kn9EhXfwKxPm1L3bgwX8TA==@lists.linux.dev
X-Gm-Message-State: AFuF++nS6WZ7GS0/2mBtxdXC5XaCC+si3UQm9VKxkmaPzc+5WJcQjglD
	qcxpNxPLOJaVTGvLeBsf8gaoyumPPPPtCrdqAcLas95NtCETFgqVxmN45MwUeWIxEpCNkKKCVaj
	55EXqNSCkQAl50AM3TkLldy+RIs0jCrpe7x8kl+x8FmvtELBWovN4OXEmOA==
X-Gm-Gg: AYBFou0jGTVu8zBrFFM3SokXEU78e1R6r5dQErK9GX1TlGRg2+5sBqqwWeYinYG9LNQ
	qeJp4R7/jpX9jVYuuYjmhiSDmQWHEPG/ToNvTyiGTKIu9YAjhl6QglUBS9HhgKb8GFedD9fdZfO
	kPXMy8urDC++Ve4RVlr28D3eTQEKINwZKzrk5sQWo7mHNhtnTGIH50XYgvbT1rJsl3eUa46tarL
	XtNdtcmpYGl7LG2PYi8x1jdD5JtUgqiArSWlIZf+iTq4YGyGrU1Oi2KUPdcT4mmwbZXDnN6YpYh
	Uf1Q+RpWqfcza251sfv/JlqfsxX+N52YU88n/MVAbuTeybSECj5lvxUgeD9Rn2xD3RYuhRTkdEr
	USWKkGJAGTFYiU4VGMIagn4CryRWxdm4HdNKIQA==
X-Received: by 2002:a05:6102:5112:b0:7a1:f7d2:e84b with SMTP id ada2fe7eead31-7af1eff69cbmr2471825137.27.1790349447363;
        Fri, 25 Sep 2026 08:17:27 -0700 (PDT)
X-Received: by 2002:a05:6102:5112:b0:7a1:f7d2:e84b with SMTP id ada2fe7eead31-7af1eff69cbmr2471811137.27.1790349446893;
        Fri, 25 Sep 2026 08:17:26 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a3625ccsm8182262f8f.22.2026.09.25.08.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:17:26 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com,
        Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v6 13/16] vfio: enable IOMMU_TYPE1 for RISC-V
Date: Fri, 25 Sep 2026 17:16:56 +0200
Message-ID: <20260925151659.419512-14-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfXz7Hay09dAjD1
 z+CmA9ryZToHId5Ldfokyl/Udmu44p/RsUtN0gi8qL3P2APkV1fQE2lDyZWcgoKgIVa9HNLsSWU
 CL4QReDxHiLbgJpCdXSar86wrC1iia4=
X-Proofpoint-GUID: GgmK8AwgZJrjy3OZ6HhnmI0dvmGrqEmY
X-Proofpoint-ORIG-GUID: GgmK8AwgZJrjy3OZ6HhnmI0dvmGrqEmY
X-Authority-Analysis: v=2.4 cv=LNPz05W9 c=1 sm=1 tr=0 ts=6ab69088 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=h0uksLzaAAAA:8
 a=EUspDBNiAAAA:8 a=69EAbJreAAAA:8 a=SRrdq9N9AAAA:8 a=UCRwF759qLZD2Be3sjoA:9
 a=1WsBpfsz9X-RYQiigVTh:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfX9/v2VrPeuCVM
 qC4KeV1PX0qPJIbxem7VSOWpRB9Ps92yRJ3qK+sYH0TRNQxo5YHzXz1ebaYwS0pzpNOnBSxApMs
 tMMXbFppSuLqH1mxj+tBXKRyWT0AS4IJjOxGcPJvI98oDkr+vAZibrMwB6P9bhSx1L+5mCa0LQ5
 XDRiiimIuvDKdwNF6ANhh6jgCuBXCBJsn7+r3vWkYIum09MaxrLPgix+MiPL9P+XtMvEGrh8ALm
 /WI5xDNDV8xc4H+KvdoqCWQFjkZ/z10urR/s+Swfk0F8vFcLhmC89Pyz7mXUhmfmnfRfBmBUl2e
 YlrhgnKxRXvEPoo4kVvP3XnFQFvu3A+oVWvFPmhJ5D4n530vL3j6wXnhvSMf5Sd4gFpVXLovBOW
 lYohpw1/Heb1fpl0zOGaSmGJ+3tc6Z2ZcBEJSP/CyjIZx6RFKFIbrt+ye4hrNPmr184M05sHXNK
 HmFsiv5F/dwLoYD1uGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250060

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Enable VFIO support on RISC-V architecture, now that the RISC-V IOMMU
driver reports the IOMMU_CAP_CACHE_COHERENCY capability VFIO_TYPE1 and
iommufd both require before allowing a device to be bound.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
---
 drivers/vfio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index b9d6e1c22aed..f7f5b9c1950d 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -38,7 +38,7 @@ config VFIO_GROUP
 
 config VFIO_CONTAINER
 	bool "Support for the VFIO container /dev/vfio/vfio"
-	select VFIO_IOMMU_TYPE1 if MMU && (X86 || S390 || ARM || ARM64)
+	select VFIO_IOMMU_TYPE1 if MMU && (X86 || S390 || ARM || ARM64 || RISCV)
 	depends on VFIO_GROUP
 	default y
 	help
-- 
2.43.0

