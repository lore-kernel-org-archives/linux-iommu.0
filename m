Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A99F48F847
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262157; cv=none; b=YYJsyk522n0zW/AZb1gXLv1TamRxxBKJofwJirk8B/MamFAMNfenv3jInJjHOUU8GNAiLW8u2TeyxiIDQSs2w0od1Ap1WkKv8ddDjPFjry41wTSLenl0S1VGFdtaVsWbitqu1D/gPynF5vNK2Sra5pA7lW731YnNZPMC3FZVceE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262157; c=relaxed/simple;
	bh=oTI9lnA5nbjrxciBQ498nnak3FdH2n0sumiIJz66Poo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4NGfipRMHnuRpi299KWYv1sGEuIUfURrXotV+QsWzjQa4SXq3L/BlpSDm0yU7goXTjHYGBJwv0KnhtSSTyZzPW0mv6GIls0o7ruKHEi7xLLTA931u/kcz0k7TFPQn1nzcE4CODeAE5TKsiafU0CL+sNifArTgs7VUgb5lJBr/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YuMxvZkC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ciJSlmHa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YuMxvZkC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ciJSlmHa"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KK7dwh250389
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sXxW/4DEUBO
	CwZCmYrY7nB3sSKdx+Hk1vdDeS7TRF7I=; b=YuMxvZkCbrYbvw5aKnSye5M4SJ1
	94imcuc4Iz+gZFvaYCduzX/Fq4useYPARPXnsMTGaO4aLuxcv+acc5+OWl+VWWnB
	Ksi0zh0EFAqwbsi5CUxlfX0I1kVEeZtSh9pF4b4GuZR8hrdU6/GWIqJG/0CNRlMX
	HJRKEZmkz+p4ElTbgC3LWGOW9S8HQuzqs6NuvuLk55ean2NykzKHtESeG1ooj+KS
	RTkxGvcAvQjtfitixdTDQdbQ0gobfJaFAEcW+nl0XQAr/Sq6A8ulVnveoxMoB7mP
	X20Axo7YCLHLn5Assa8PnRFvKPMe2PVdHZBXmMcmxaPFado+/ucyFWjWNtg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5w49bqs9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 21:42:35 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9368f2b7b2bso34308685a.0
        for <iommu@lists.linux.dev>; Thu, 20 Aug 2026 14:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787262155; x=1787866955; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sXxW/4DEUBOCwZCmYrY7nB3sSKdx+Hk1vdDeS7TRF7I=;
        b=ciJSlmHaFR+7w1RnhFJug0Uq8kBm8MkWyfx39K8T0nJJzaj3skyfd2MjuSwkieSZFU
         A7B03vNx+ilGMZLvOkVTDT2YXzMSDcnBywYNZINd9p8bdl5iLg/mtIOZFrxd799Q4in/
         stEh+Rh63yHqbzh5WIu6UOb4tGDMDrfn4eCzH7CFawGP+pZKNX2OBhH5M0A668C376Fx
         /U5l4PWvVKHqUNl8/VibEgm3AU9CYrBxHsYUlv+Z8KfCJo/+RP4w4+ti5L6c+OxzjR2E
         h+nQrjiRfkMYfJIK7EngOoZdfZtVopwHxMgu4OIloXYoCNy+cawg+ITdzY8AT6w0PCyZ
         gwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787262155; x=1787866955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sXxW/4DEUBOCwZCmYrY7nB3sSKdx+Hk1vdDeS7TRF7I=;
        b=N2nKVgIMNicMH7jmO9z+gJhoHQVUgGmMIKWPT10YlgF/X1OxZLDPGSQjzeHEyQ70zJ
         XPGdTaJnbgyuPoygcinPKaHS6oeCTSTZ1m5P6RmFUqCpS9KLp6p3KSfi89+JxYCI6Gwn
         3YFAGLilG43Z5fqasCzNhtK8I8o8k/uLJXqvz5O0BwEhB9Ot/9F4gHCw5el76FrFYwo4
         9GM/QPlj0ns2+M9R20CEhkONlzpahQ2ySLhlhgYWPe13d0w02ZYwho4aUL4auKyy7Peo
         eRyL0HK37/sXwwv3lRxNWbNNl0GJ0P4XfKPLzc9C932GvJG+9+/kSiWwraSmhYJ+k7q4
         RbUA==
X-Forwarded-Encrypted: i=1; AHgh+RrDcA5B8tdXb4gBJvYX/UYDDGORceTUHLqRvK/1V0Pq0qfgLYIKpExmunLnHj1rNLCnHQ/wYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAmRxdMFoyE1Fz4U1k1C8IZ027k96TcfroFAVsF9hV1YB2NA4N
	1Gz4m2MTEXR9w/4ETxkhe4qP6zBAbKGNDp42UtuBW3sLXjU75iqs9hhVWew57r6u1v6euC88YXO
	LMyVuOXxw3qlklgLgVQWTn55IdTUWSu9tFioCbViTdKHDpyx/tl9hX9pdqg==
X-Gm-Gg: AR+sD113ylFTD/u02DogMR0z/t4HTI4wZcXohPxNCEGoCtgOuhHh96HMS9KTJEJ4SG0
	AOo4qvApCXqIbIzTNZPVhLGLO623AFcFcLFpNyuy0nBgmqdQ78gakiUk74wAgbXWGjEHai+lCbW
	2iKisvmKg51ACnhqf57u22v99rraQEqSWEmNHumGnpu3glfw2kbtrjsDQqJwlwf3LNHvyP64vBc
	Qfsp8qNuXvHPpTco2Wy8iDj3oQHoLYC3SZd0nd4VlJCnEHN17yfg/fYDRGZ1f0kCWItmK1c2RY4
	zVAiPrtQ1HXEccfZn4vVru1kvgoaZtJzqXv1EDR1SXqbTm6T/0N5J3T9SFeux6fTlSZMEp29QDI
	D6FXLyVxv
X-Received: by 2002:a05:620a:2983:b0:937:260b:4d8c with SMTP id af79cd13be357-937395747cemr120518785a.33.1787262154654;
        Thu, 20 Aug 2026 14:42:34 -0700 (PDT)
X-Received: by 2002:a05:620a:2983:b0:937:260b:4d8c with SMTP id af79cd13be357-937395747cemr120515285a.33.1787262154260;
        Thu, 20 Aug 2026 14:42:34 -0700 (PDT)
Received: from localhost ([193.165.40.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1450e54sm16782276f8f.11.2026.08.20.14.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:42:33 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com
Subject: [PATCH v4 20/21] riscv: defconfig: Enable IOMMUFD and VFIO
Date: Thu, 20 Aug 2026 23:41:49 +0200
Message-ID: <20260820214150.545737-21-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX3Of1GxzQrUNs
 nRpTOwv21UrL5GXMzLbhtCIrar6vzD+p+EyLhiOe9W2OFari8dJMBn+7AybvP1AxPusTPpX9DZ3
 JA88QT3aVcraVIeiv38KbyzWSmTeIqs=
X-Authority-Analysis: v=2.4 cv=YP+vDxGx c=1 sm=1 tr=0 ts=6a8774cb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=CzrpMg+lqiTzknPDBj2tlw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=B9Crq1QHcyRNgBBHHYMA:9 a=zZCYzV9kfG8A:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: CXoIOxDO7agGcL6_Fye8OsOTrBHrWXoO
X-Proofpoint-GUID: CXoIOxDO7agGcL6_Fye8OsOTrBHrWXoO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MiBTYWx0ZWRfX6gau6T1XWumK
 oFjt45QJbaeOw2jyXkS+KmjVC8OOyIrwzNTkN76TYxx03kM1rDhW5sLbDG3v0Ldrii53GVWaMJq
 J1ae5nBtRu/9h+63lhXZiS7tbhCdf3CWooMxRCl8McZUuNHrY6lgO/tZwRII/Ef9UOHkv9HwFlh
 6Ll6El8Ovu57065di7kp15Oxiy0PkgfN8cKwyL5Xly0ahoznQHHcOr52SqiMhsLIjNXZdSAYdJk
 8I4wCG594fmpfC+knVKzMrzlCMiJTBq3Wx5joLRUeR9aPpDT2cxJldPjoVaxbCu8U8fXHDa56X3
 VF3b49S8Nu8Aqc52CrtGwmjT9SfDPjpFIaTbvm0M7gbbD5HcwGmMR5xiV3BVmDH+V5jpcTBX7pP
 /Zs9uYvDO0kpplUEz9ZKOTp5ycVDVa3ymyDW+lL6fMYwORgl5RoHa8hy80U8hq2VpeaV29xYt6Q
 PvooDax3Bw5RwHmC6SQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200162

Enable iommufd and VFIO in the default configuration now that the
RISC-V IOMMU provides the DMA and MSI remapping needed for userspace
device access, including assignment to virtual machines.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 arch/riscv/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index ed605b5e3162..bae9a0f32f89 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -249,6 +249,10 @@ CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
 CONFIG_DW_AXI_DMAC=y
 CONFIG_MMP_PDMA=m
+CONFIG_IOMMUFD=m
+CONFIG_VFIO_DEVICE_CDEV=y
+CONFIG_VFIO=m
+CONFIG_VFIO_PCI=m
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
-- 
2.43.0

