Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F80343887
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188415; cv=none; b=emZ1nK8vnazglOGYtVfvCUW4q06y6+rDwf3olgegA6mf4QbENGPIqONxsx8fEt2U3OSlD3teWfF0PMKI4B8+qZ+KTCNvVZFomdls9jTQ0XruL3zUyLHcrOKdGv0RHC9gLPfqyr8esCRmcKC2pYWKLeiG4H6RbspD8WyJ9V6rhZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188415; c=relaxed/simple;
	bh=rgbN+C4Uu9VnYpldnT8r4jnxZtq5fWBTmRSZCWos7/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6Y7LNurL7VPZBA7Soq9g6Fy895+bxWlEgpNxyWTlhpK9jq/hvA8wUQqnShR/7xehthLuRcVKltTcLlCDWe7V5YHaqrj/Jb846eP9svVgqhYt88eijdOTgmH/yIydKOigmOd7q4+oHxEExSxyz45zMYB0g9oV32OTtiTYWQPq88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G8PfWLu5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UDvwRQTj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G8PfWLu5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UDvwRQTj"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VETcZu121965
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TkV4Y148NbG
	wrVCtbfFhs8oeQskF5fVQw0EynKCSZS8=; b=G8PfWLu5yz+mM83PnY4ZUwB/ETo
	+sdstrb9OxLlo5Ml8P78PUXPNqbBTBjnBN6zYyFVeyYfNuOc5ie+sXgzC4nZ6iDV
	ICMxCGwR4l/IKaHo4NTR46+b0mt20V1mEvtKf/4kzdd2J2MkGRaoZh1eJjVdOPIN
	G/jsFq7vb8UjmbxhAjBbBdGpm37xfO6aM+zlvAfS5ILhIM7wrQXfmU2qnMls437o
	zEZwaZuU04XVprmvLh/S7frIJTEvC0aoL7k1B4XPpdDRetkeldXq4QjIajnF5fqU
	u+BI+GBjxMO1s6qQeL5OwHpMb0doivLXWhnmbtFiLnh5ziwi8I3DqEhKVkg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd4pma2qs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 15:00:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e5fc4c7e9so325306685a.3
        for <iommu@lists.linux.dev>; Mon, 31 Aug 2026 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788188412; x=1788793212; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TkV4Y148NbGwrVCtbfFhs8oeQskF5fVQw0EynKCSZS8=;
        b=UDvwRQTj4Kw5yIhnBvpwYQ1VVMCy8mlm8i/pEg8/0UcIdS3kI7ObRchZgD9j1euhLY
         lTpqR1LR8oT9oHOO9uE4PlgGWghnvMa8c8oQQMWWad52AMD7UgBIc05J7a1/ePKNiAGj
         Zlq+jusivAKULX3zAOWBWD1yitNmezvKM4un5uXUzuRJzO/PUW5Uueja4N/8iGKqwuyo
         L6hlVd4i2vR2i74ghnbro+TEAA+W28jQqVApO1kgIrR6kzliQyGii+VApzeNlWaCXBsO
         FVKa3CfWP0rOIrUSdlTYjeKZnqrUVsM1OCo60t+Fib2TPAwmnbAg93HZegk3FangHb93
         K/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788188412; x=1788793212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TkV4Y148NbGwrVCtbfFhs8oeQskF5fVQw0EynKCSZS8=;
        b=k/TMB2rUTh4X0ewIWVp24NUIFEGUWlcCyWBscEIPJcjgoDUrjPPPAO30oFwQM06BTk
         K9rZ3XY4Mfu7yjKJ8wVCCYD1JFgi5YPxR8zSuGnnoB8Fx0y7No7GuQM5oq7tpePmkckB
         khF6S3MEvf8NtJ6WgghANlyVCegnCwQNLAJNMavcf1xXDe8qhIBz7KM8oYPr3bzY8FLU
         s03A36DWtfOcmNyzLtVgK6hhxP0J5Fp/vT5IYngNdFYCTNWuRhKtKoF9yr+7ymFOtrnr
         WE/rE3O4QkUx04XecO2F92adZH7WwT07ZbLrNezzWazlMh3nskSa1PwltgEMe1KcE/Pw
         Di5w==
X-Forwarded-Encrypted: i=1; AHgh+Rp6IkcK5uE9dCIXvkqGIMJedE+044mO96jK3Iyt2/PAHHQ2aHeltMTQSnhXWlqGQCR1Mn4CEg==@lists.linux.dev
X-Gm-Message-State: AFuF++nj5tsP45UT7v9Q4H+YqN03RW3gqadCh4nLBT1eTwdzJZm4VmE7
	6s4E/LTOeXJurcI11v4gTWDjtNsnjQjDZqDsyvniEBws4xTJ802lNeojjk1ILbNbKKhh2NNPzb1
	U4vee33SrBVBsOG/6Z8h5HY70EoCoAs8aIvxyjrwjaflFejZE2b7hEqe9jg==
X-Gm-Gg: AR+sD11AqfVNVNnLbo2/6pI/0YSaFi2RM+nJx/Lc1K8bqXLIycPcoflZvcPZSogZqwX
	lgUnupX0ZUyA2dTA4+KAblLgsNJMc4rbZ2TuZ+TN3WKjWN8vaMrotdZTYEQNvMZ4M+0CYN0AUT8
	AErRew4zohr2CrrJ9nOM4yeQpXJKLH4/ZFdiQs/m5h8R+FP3hY8KnGsnXXiE/51aINCKN1XDDRz
	WucoxDGG5QqprRNzA8eg0xNjR8+0TkRKsrEH2XbEBJg3Qyk2SBgKpLnBh2nptUEeXL1Z327XR6e
	h6JU0TjYDg24UNKBJhpUvXtLNtYRmvktc1IaGb4AiAiqkANazDgT/aqKwvi2ppNKF4VGC/YkvR+
	abKQ1Vi6YeuUEStgMaMpPWBujKhiZX2K8+c0=
X-Received: by 2002:a05:620a:6190:b0:936:41fe:2351 with SMTP id af79cd13be357-939138fc2a3mr3163668285a.30.1788188411410;
        Mon, 31 Aug 2026 08:00:11 -0700 (PDT)
X-Received: by 2002:a05:620a:6190:b0:936:41fe:2351 with SMTP id af79cd13be357-939138fc2a3mr3163645185a.30.1788188410537;
        Mon, 31 Aug 2026 08:00:10 -0700 (PDT)
Received: from localhost (ip-86-49-251-7.bb.vodafone.cz. [86.49.251.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48440e4319bsm1480512f8f.4.2026.08.31.08.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:00:09 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, tomasz.jeznach@linux.dev,
        tjeznach@rivosinc.com, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, anup@brainfault.org, tglx@kernel.org,
        kevin.tian@intel.com, fangyu.yu@linux.alibaba.com,
        Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH v5 15/17] RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch
Date: Mon, 31 Aug 2026 16:59:41 +0200
Message-ID: <20260831145943.313726-16-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: tZ56DL0aVEX7Fdf8DWjvQE0vKPsT4Ht5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfXz+HSqf5pGjTK
 GU2/VtbCXXMLYh9kFn6lpd67m45qkHDgKSh/GUCfkDDfKpHhius6cN8vYnNek13iKGMgNCZkacW
 pknpgVkBljZSe6J8SgVQdzlM7YD3osnFgH5dGZ8DWce814a7WUGhB+ZV1xndcxF8iNSxIYUZFk9
 Vg5xCtMp50f1zeBHCNmbL78Y3jTdhWW0d59Hyb34Rj4RZ6hep9Sz24mHVgFjmuWqu6ql6t37plp
 r52g26nkk5FrvkflylVAC+IADdNIPzIlg2p+9iFNZ2PHXUG78KJSzSWBhpKNSkpf5gZprYDuaLR
 QBY+ku3HIS7G1SilPzJ7stCyysgPq9RAsmFaAsX0bx6pTAtrabLGwl7ZBqTIwUT4CNP8bPTEQNh
 nWv9oDT+p4pcvhcbYP1isMJ2sMaUwds+jKJs71RU6bOb9+bsjESn2H8vgs9EnhtTu0hhj5MqwQO
 oQ0uZRtm88EPvVxC+WQ==
X-Proofpoint-GUID: tZ56DL0aVEX7Fdf8DWjvQE0vKPsT4Ht5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyOSBTYWx0ZWRfXy/Tz/01Lir0S
 /GXtZgLKWR8x6ICCoJs9jidCo23Q0GnjKrAy9hOF2eu6kZbvHuVwN4tcbREZnimFP5lLs5VEbHC
 OgvwPJ+AAxfgju3XXF6rQRtZyrct3oQ=
X-Authority-Analysis: v=2.4 cv=GbQnWwXL c=1 sm=1 tr=0 ts=6a9596fc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=on9AXyaqQ0RhfYpiXjjEXA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=h0uksLzaAAAA:8
 a=EUspDBNiAAAA:8 a=69EAbJreAAAA:8 a=Hp3hLBw8nfLOXl02dSwA:9
 a=PEH46H7Ffwr30OY-TuGO:22 a=MSi_79tMYmZZG2gvAgS0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310129

From: Tomasz Jeznach <tjeznach@rivosinc.com>

Enable KVM/VFIO support on RISC-V architecture, now that VFIO device
assignment is available on RISC-V through VFIO_IOMMU_TYPE1, so a
RISC-V KVM guest can be notified about VFIO-assigned devices.

Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
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

