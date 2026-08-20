Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF21948D874
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262153; cv=none; b=mUMpoeT1YTRYuVRe18jt07A3Q8TqJoju3sB+8pzbkVZ1bkvHNNQyDOT5Qb6njWZ9sZDKWsk7xh/YRj0ri43Kj5Fd1NASkNu13QCcACTCMkQpVM/2UneXOfmev3CYxjwMye/ylNwucUW8y3UqDkGyUSPGALCCldnae9Lq85VPfbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262153; c=relaxed/simple;
	bh=TFwknJ0YqCRA1LM+i6U61SM1MSuulgej0FGruggnW7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwM/eJe9xkx08wj8L8lTfhK3CtT77t+k1dML8QB/fUW48wFtbw8B9FpL92yS8poGCb1uZPw/Iav+srQZLM5+lzcc8OdkfO0YXoK+lMkSxMfngSctOs1SGD3xT+RrVOHffJKgKTr6x0LYUh++ugebv4oQTz9LIJCyv81d8zHb9tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JLH5GaAu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PKMMGYNZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JLH5GaAu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PKMMGYNZ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK7eig065802
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Z/0MUXfJDNe
	HlErsfNSNArUm0DaS7PuJvPVjEpFxNjQ=; b=JLH5GaAuBDa/E6iVIzx0xaiNbmK
	B+2Qr3s958/jGq36s4P/kqmnN92P2ecOp2/jiL6uqTDiTYfBheDK43XhC7ihtyR+
	QY/RNtY9g+VtoRQaIJJLNJPcr3x6VHjgMKoffHxw7T8v+ixItFx7QdQAdz0HxljF
	LPWT8Fv1D3l3f18ioJ484vNtOWk/3oqGgtNYuDdulsCPAzHzQeTlmgKSLGgvqizu
	xvI1QVNH7HMNnP0m9QMDg3LHFLi4c0szZ1QRS2Wf5zAihr88oPCRbMnWNlXOQjrl
	IicLkic1JGM2If3u0lw2lLmXOiUKUsd8oNJGqRMFRoho347H/1v4yAXEqGg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5yg0k1bn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bfe3fa93bso3327131cf.2
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262150; x=1787866950; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z/0MUXfJDNeHlErsfNSNArUm0DaS7PuJvPVjEpFxNjQ=;
        b=PKMMGYNZh7zIpSpM12ZKNkk9rcsBa7OG9YF1GH4eDZHAQ4TSVWbtYPHD1Owoib13+g
         X4ZTr6r56+iNBH+iVd6pHsVH38qkrPjCfbd9Q70Ct5EuFPs9SOtXo75YNAHqZXmq6F1w
         4b5H115MztBp6Tw9jmV/BC3JgmaBuFIu1ylrHd4LOu0z6vCfJRuky9baCQsrlxkGsYzl
         jlkD1oGb8lk7ZBSTfxgwkEiE8tGubDnHoIg+YJ3DVoouAnb1Q0GrPR95/YkJffCgSDOG
         5dIxPyPlMHRVk58i2npcvjnbyfYzoXAbLcria8C+57d4m8raMqveHHR05OQJ0bnYPxsx
         YLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262150; x=1787866950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z/0MUXfJDNeHlErsfNSNArUm0DaS7PuJvPVjEpFxNjQ=;
        b=cbl6RZX77jZluFZiZscM7LgvaZ9v6yJy1XpWp+pPP0ztxWDbmb/dZeQfAOCMiEeQLA
         SldviwiUfIDea7fhdm6nfZIW2c1aYshD+p7zqpjO1kJerdd4mnCEwmeTyvPtH9lMLSG/
         NhlAKak8bDD0iYw8fYyk+e3IuuquSbnF5gi1j2l8FStJlTEvSsnitnBNfnq8iraMQ9WJ
         8DToUYb0eCoTVUghk4aacfbKchs1ZlLihbhwwZNmFF7gbP9/vM9HaFAFUcsZXKZxNqNf
         u359daIqx8FY3L2W31+JqXVAnwG0aFnNzRdQQ9cMjvt6X6ITu4zsSxZKz7YYEtaHE9lk
         Ocvw==
X-Forwarded-Encrypted: i=1; AHgh+RouS5VrAcVOhCcUliYo3Stcz10a7bmhWC7hY3lmYBNKGWgU+8KDRbSGqu53+FOZ7ScJGZ/W/A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1tBgaHkvajfHOnrbbrpDCRh4JqJRtI7S9gZsp8cQ7O1TBAQju
	ejXrl/jg38YEl4ybHHeRUi1k2SNVo7LUtP/m+2bCDc1JPdPqqeaoqJv8UPe6r7RCVvkztzF9OCw
	7u62/BQ3D7bgOnt7Ra7/T6Gl89ud3w9AbWTX0q0NVIPFIpKfcpckETNPJ/g==
X-Gm-Gg: AR+sD13QokKgy6yBFU9WgP7PJZc287DQtkwENS/pWRjRPSVpc5FK27kAm2Yu+s69LA8
	ksYSamOBfDBsjKBIESs9IBFh1gxZiEGIEEfB4jomoH4Bm5FXKQN/V6pLZ4HdspFzj3mIOHK6KPc
	WCPD12MMFhESgt3t+jjKSFIF2jght+ktqPHCl2RAVGdD4e/TKd609alxVeA7tjJbQHYcv6O1KsX
	jRjxO6UfESNfScdwcqVtfCFQ2PssSYpji9jdsXZz96CaaaSftmzQYlz2I8s1Rl0iUZ5oG7IS14u
	KnEB5PfgGOjaEP8KHNJylaPbTZ8PiamXQaV0qSKE4jXc/OL9vvICqWVdn0G6UBA20aZBW9HXFtY
	ypVTweyhF
X-Received: by 2002:a05:622a:1487:b0:52d:41d0:89e0 with SMTP id d75a77b69052e-52df5a7b373mr14203741cf.40.1787262150209;
        Thu, 20 Aug 2026 14:42:30 -0700 (PDT)
X-Received: by 2002:a05:622a:1487:b0:52d:41d0:89e0 with SMTP id d75a77b69052e-52df5a7b373mr14203261cf.40.1787262149813;
        Thu, 20 Aug 2026 14:42:29 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b915cda6sm8427905e9.14.2026.08.20.14.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:42:29 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com,
        Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v4 18/21] vfio: enable IOMMU_TYPE1 for RISC-V
Date: Thu, 20 Aug 2026 23:41:47 +0200
Message-ID: <20260820214150.545737-19-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
References: <20260820214150.545737-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KmwBt2uDkHevAZfvKS9tmspjtB3hsmla
X-Proofpoint-ORIG-GUID: KmwBt2uDkHevAZfvKS9tmspjtB3hsmla
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX/W4GA1C+NUBC
 8zgII2VXorkOfWOKNLB5Se41I9vflIkI4QjaX3C7yifiAhc023ROBTWwyyP8YOfnL/k6v5zSTpE
 Bt7qqM9shW2WZx9bVbsQKSg8mD9GIQmgJBCH1++508xJkOxrgYxDlOZ7Ie8k9OSYu6EKsO0BpcQ
 e/0aGQi0Jr+18RfQWkZUqtWjH2/R8EKlvYZ5MDtnJ54r6vJsEm9c1Jt8uyRL7P2NBQ9LiMYalim
 NNpHkG9Jw7x1Mrn2dJKMNpHSX83NkB2w1Sn+f10NL8oJDtS6FGuvRnVMxg6udWw0BW9TUQDylrk
 FMKfCQlr1NND7zNshBx0C0cGzk6PjmC3WvVrXE+MuHov0Vqdi7kj116jbqB1QZozuMLeHYU1pmw
 htg8jTvh0v0Tw0REmYXaohoh9gJ2K+nJcyjwHhLLUb6ep2t9/Y2Gc6ow4LM1TW6AHrCmbpnIEcc
 OW/FbFAU3GLDcXEPMfA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX62jmM72cKI/F
 chJnza5gADvQOuZjLWo8y7B5fdigRKxK4OF1Htu9ubynV+1DiVlLzrwkPqBimyVy+GaicByQoEZ
 2a1BodG3I2dYrWnDOAkQhXBtMQ7KXbw=
X-Authority-Analysis: v=2.4 cv=JoXBas4C c=1 sm=1 tr=0 ts=6a8774c6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=h0uksLzaAAAA:8
 a=EUspDBNiAAAA:8 a=69EAbJreAAAA:8 a=e-vb6wPzIjHU0Swrx_MA:9
 a=kacYvNCVWA4VmyqE58fU:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200162

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

