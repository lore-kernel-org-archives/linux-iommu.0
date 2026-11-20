Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182148;
	b=xI54Er/R/Hqabfsa+ZbrXTZy3mLht+biq9fCXYmR7udg+CMB9EkUGGtv/nWUdBE8foYJ
	 hj18v/PFAXWVSrzj7ROjdovPCCkBOqelAVwhskeQuy/EeYeFgufkL7Kf1xopdDIWO1vMH
	 fpSEczpZPIe6Bc7vyPJVNH3UeUq0VJnlybRhtN6Fy9ikavT1hoJbRIc63qf87Dna5VATY
	 ndEbxkvs4lIXWozNn3lgs//rVkCLaY386Z5hMOnGUzExjNGQlGZ+vaBFa+AdZVf4QF0T6
	 CWmcjpUb02ZKNhk/xIhVXxERNbYTJ4gEmCK/o8c7SmKhSJEpPwEI7H/l5l5vtJVFgwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182148;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=YETMORu0EwmjXjFiIGRDhxEkjqRjM/MriqWWStXTlnM=;
	b=d2l3evob0lE/eGj7ijf/+Pc5KuWy+/ZlBavN5EuAPu9W7KbrxvNI4twJ9rW6okSydt+z
	 d8Oan+w925z9vHF38qt/sMOMFXMV1Ayz6gSIJJOvaOuDu7wA1tMnP5W24i9Z6yhaUwEwG
	 sWIkDjykmxHbLuYR4CqR3RPhzE92VdLH/+rIrms6r8Inn9e04lMWwj0IKUJQVUmWdPSTr
	 TzeNFj+e+zF+VK160Z7kZAufUIv+NINJ+KmJJalWFvTQiQme2qtsXkd5R0UQMNVqhGrp9
	 3eWhRLNMu2or8pucgKAHLNGuOPD9SIAztDMl9b+zU8CledARUMQsYDdKgYwXZWU1hiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D4EGHd+t;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HZIgOpaQ;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26ED2606A331
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26ED2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D4EGHd+t;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HZIgOpaQ
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjuoM1168921
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YETMORu0EwmjXjFiIGRDhx
	EkjqRjM/MriqWWStXTlnM=; b=D4EGHd+tVRWg4U09w/JD4wiYraxbgQO3SUN85+
	StDapF3TZJiv6K7eAzaj+uyiGeyfyYoDLFP5PA9+tgfpTqwA5AWNXTKMatXUZ6T6
	SwTKQmy0tgUL3qrluBGmmDqHuhD4INyWVfD9kyizv49BpqbHUZ8DuoMao+4y0RN8
	njND0851JusG1OjyeeKgsBUHe3uEKLch2sRRBHdT+oPLmt90KtDxoaD8AeAcJL/O
	dpw+ukwxO9p0XuLiVuHAVCGXyleQb7Cr+mHW+yqzXuBSTdvc8VRAWMJIER3IMBbM
	No9Cn9U01SM9DsazpmVPctnHLxgK047/R+VMWRy1yUGZyPTQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27b5uy4r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 13:42:26 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-382af5cfc58so2554890eec.0
        for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 05:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795182146; x=1795786946; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YETMORu0EwmjXjFiIGRDhxEkjqRjM/MriqWWStXTlnM=;
        b=HZIgOpaQA+mk3xGC1b09SLLD3GdBka8axuBPLH+OSVYEiKvyLRl+BMe7DwXoaSRfaA
         0RlygBdeNQ1jy8kFadFXBgP1vFxiLM88Kh32PwIX0Q/kY15vj7gsAUiwpfYxoWnTplsn
         vEgozhKCqLlK0Lrpm5E3S+kYthzd7OFsemimmlAKWV4tEcb1JJfmpxhsAU+TNZ6FeaEP
         ZYkfcr0WXoq+myzjy0J0LLxsp65vqYs/aUSEX2HQMVMFHQH+xVP+GCwTF/xpKnPrvzT7
         Nqe5j4GtG1EWubnUn0HAGz0IuoY59QVRRtmMvOj89nljj5PEyDifCsxp/RKn5qxGq0xQ
         JynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182146; x=1795786946;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YETMORu0EwmjXjFiIGRDhxEkjqRjM/MriqWWStXTlnM=;
        b=KxataueISKUSS3kjHgfcUiT8nC3pIRr6x/SCvEtjyJwAPwxv1Od2L85u9ck/+Rt1hG
         Iie/WqYRFmhJTBxRmx4cBMtIdZJEb6WQkQNJO85VKrCQGcP/VaUGQAsahm4Arg7qnM4H
         JB8dS6gQlbDxIZOI+OMQ8LlpyLkk1v3hqdnRS7gntuBrhWazkf3luigH+zUqS1mDPuwe
         zeCqHAF5+T4ffGgU4BaZqDT969fPHPOda7C05pydszOnSRPaZa6uki8TM3AsBYx+1mWD
         0HvOet8tTaGWpv6BDJX1GAyC7TPIZGGYAfMYbCesRoA83MDHYnH6jwFuYbpoWLmtLjqu
         XRxw==
X-Forwarded-Encrypted: i=1; AL+hErGa6r45pTV3p0pTUyDDK1lZJwdht8EB/VBXFfR+xwH+GUFj8fpY973o/28lIQ9Vtq9OQO/hZg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9vvk2NC5Z7GF415fPtytoSa2j5npb22VZsavGE9XFYNoWC7+M1
	Z+g06lc6OqxoHM3+MTYZdcNmaT05XLIru+cYCyg2aNQ7bwvLVtFKRwN89nJOT4GqMN7kFqf9PJt
	ZDieuMeEagWFMzhnydkqjeJaAR5rBN9kyoO+t33/XFdv/1iVZzM/w4jTwwbEGzBCVkg==
X-Gm-Gg: AZFdTZebkDp/5pcXPYlKqCxuhhF563fc+4vM6x9sQjGZsIMfr6iRvLkZYhatXUoBv6g
	Vsx1TPld6wgITudqbyKBXDExXasxep5P8KoYZtowJ/+sBtEVbxlXJYZmob4KRG5B1vjE2WL2wZw
	GeYSsfyeDuu/iHAJ6RbqpwZ3vsc9D51kUxip3TQs3LrDRXLzsDkuaUJur8Q9pgztxe/1Brubynx
	orOKCL/IcCDesWVOcQFPp8B1ujn9Vp112CHDEAfqVjhC7Drp2zGV3WKU/rgoA7kASj0tpsPOOsd
	Fve98vvxiGqFEbvBRsHIIWfQvft5S1mlv/IHAbQ9hW8R1XFs9/WsCupPqBO4eR1Y1tfL2h4Uuid
	EYhGowN3WsmfxZxmqEYoMBoRTruTgeGVPLwJeMOXdfTJWNWDWazdFWYRJWpq5SX9aj+ThjofLFc
	zVv5U=
X-Received: by 2002:a05:7301:dd86:b0:351:2958:1740 with SMTP id 5a478bee46e88-3856fb641famr2813677eec.37.1795182145352;
        Fri, 20 Nov 2026 05:42:25 -0800 (PST)
X-Received: by 2002:a05:7301:dd86:b0:351:2958:1740 with SMTP id 5a478bee46e88-3856fb641famr2813631eec.37.1795182144436;
        Fri, 20 Nov 2026 05:42:24 -0800 (PST)
Received: from hu-bibekkum-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm9379222eec.27.2026.11.20.05.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:42:24 -0800 (PST)
From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Subject: [PATCH RESEND v4 00/20] iommu/arm-smmu: Add interconnect bandwidth
 voting support
Date: Fri, 20 Nov 2026 19:11:31 +0530
Message-Id: <20261120-smmu_interconnect_addition-v4-0-be30526391d9@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAtOAGsC/32OSw+CMBCE/wrZsyXljZ48yNWDHg0hfaxSI622Q
 DSE/27Bu5dNZjPzzUzg0Cp0sAsmsDgqp4z2It0EIFqmb0iU9BpiGuc0i3Lium5olO7RCqM1ir5
 hUqrex4jcZnmRJRluZQEe8LR4Ve8VfoFTda6OB6h/fzfwu88u5MXZKtcb+1lXjOnqXwqjKKb/C
 seUUCIYLxFLjpQne+Nc+BrYQ5iuC/2Bep7nLzgflPvlAAAA
X-Change-ID: 20260516-smmu_interconnect_addition-d9567535e9d7
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Val Packett <val@packett.cool>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795182138; l=7804;
 i=bibek.patro@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=jUDvZazO474CIj6UfK9rrKEEe6NXIbdeQpztmygDkp0=;
 b=Oz0AHVzotegR1lX+57u3OLv//lRYW7v2Ee3ue88L3mdvsW6UaoFAQQXyE8ps6BDj6Ij2u13RC
 gCl4ptkMWSIDmubhzASYZ+eSUIZObaxNIRWc0TcxECBUSbp4JIiGCuq
X-Developer-Key: i=bibek.patro@oss.qualcomm.com; a=ed25519;
 pk=DkrbE5dhskZJmBAKR5LygWRsAydEOSN+T0/YxNYxDLM=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX9lMK6GFp5kiB
 5jGvRZrYgu+azCjzd67xJYKSdOnQicyEqTM+n4cKvmdHTLjpc/U/zlcdAxzKWsUn8oTxo4fVOG+
 YxwrNo+5/xrVWmEkd5+EHvV/9t6LYJQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA1NCBTYWx0ZWRfX2Sbo+b0pm1qN
 cKommSTvR4NvPa6qkp4yhXZ5H+w1HRyZLkQFdMorcu4yCcViUP0Ezois6AfH9TFw5xFp9s1p8i6
 BtdeqxduoswOUrvg2wdsjOkTlP8/Ue7CBYaRCYul17bTjYL8TuZYxS4B5wqmHXVDRDdi1294JS+
 yqUoVFBtXnYsh9ZRf0MF9oC9zNxIJIE9B9Wcp7TVjYqEhSD2jf47fmYdcieBi/4JlqlWRm4fV/x
 x84ObMowbMlh1p/RC/SMlSCp382lqbCi1fcgOmeNBMWk1mpNnxke3bnOTNeqWkrlq8wf9SIIXxx
 DpzgdyHz56xbOhloihpfOZ8Mks+Z2LxspiD6egIYPC8aL+cFaRfUfdp/GnTIwy30lkP94nfSLLg
 yeRNITNVHYjYM0Y8FuI2s2YHjYUIQm3TWzRW33npNWdlJWPP1EBzVbGc+t3bMy03jYL28T+p7rD
 AWxxzHZDVkaqU/ZxKjw==
X-Proofpoint-GUID: nz-Aem_IRfFIoXo7vOyrBD-Dviqz5Y3W
X-Proofpoint-ORIG-GUID: nz-Aem_IRfFIoXo7vOyrBD-Dviqz5Y3W
X-Authority-Analysis: v=2.4 cv=LPTz05W9 c=1 sm=1 tr=0 ts=6b004e42 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fn02ttKd-iuB0E_vrvUA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200054

On Qualcomm platforms using the ARM MMU-500 as the adreno SMMU,
the GPU TCU is a separate hardware block with its own AXI master
port (alm_gpu_tcu) on GEM_NOC, independent of the GPU rendering
data ports. Without an explicit interconnect bandwidth vote, the
GEM_NOC path to DDR can be left unvoted during sleep/wakeup
transitions while the TCU is still active, causing intermittent
SMMU register access failures and SError aborts.

On earlier platforms using QSMMU (SMMU-v2), the TCU is integrated
inside the SMMU block and shares the GPU data AXI port, so no
independent vote is required.

This series adds interconnect bandwidth voting support to the
arm-smmu driver for all Qualcomm platforms using qcom,smmu-500
as the adreno SMMU, starting from SM8150 (Snapdragon 855) where
this topology was introduced.

Changes in v4 RESEND:
- Fixed accidental gfx-mem interconnect-names field removal on some
  platforms during rebase.
- Link to v4: https://lore.kernel.org/all/20261120-smmu_interconnect_addition-v4-0-cab8ee8be0b3@oss.qualcomm.com/

Changes in v4:
- dt-bindings: Changed interconnect constraint from items:-based
  compatible matching to allOf/contains: approach as requested by
  Dmitry Baryshkov. The new form matches any compatible string
  combination that contains both qcom,smmu-500 and qcom,adreno-smmu,
  rather than enumerating specific compatible strings, making the
  constraint future-proof.
- iommu/arm-smmu: Moved qcom_adreno_smmu_icc_init() into a function
  pointer hook icc_init in qcom_smmu_match_data as requested by
  Dmitry Baryshkov. The init is dispatched via data->icc_init() in
  qcom_smmu_create(), keeping the hook architecture consistent with
  other Qualcomm impl callbacks.
- iommu/arm-smmu: Replaced #include <linux/interconnect.h> in
  arm-smmu-qcom.h with a forward declaration struct icc_path; as
  requested by Dmitry Baryshkov, to avoid propagating the full
  interconnect header to all includers.
- DTS: Extended platform coverage from 4 (kodiak, lemans, monaco,
  talos) to 18 platforms, adding sm8150, sm8250, sm8350, sc8180x,
  sc8280xp, sm8450, sm8550, sm8650, hamoa, kaanapali, glymur, milos,
  hawi, and sar2130p. Note: glymur uses hsc_noc/MASTER_GPU_TCU
  instead of gem_noc; sm8550 and sm8650 use MASTER_GFX3D instead of
  MASTER_GPU_TCU.
- DTS: Kept QCOM_ICC_TAG_ALWAYS (not changed to QCOM_ICC_TAG_ACTIVE_ONLY
  as initially discussed). The GPU TCU is a separate AXI master on
  GEM_NOC that may fetch page tables from DDR during CPU sleep while
  the GPU remains powered. Using TAG_ALWAYS ensures the interconnect
  vote is held across both active and sleep states, preventing the
  vote from being dropped before the SMMU is fully powered down.
- Link to v3: https://lore.kernel.org/r/20260706-smmu_interconnect_addition-v3-0-afdca0125a65@oss.qualcomm.com

Changes in v3:
- iommu/arm-smmu: Moved ICC voting from generic arm-smmu.c to
  Qualcomm-specific arm-smmu-qcom.c via new runtime_resume and
  runtime_suspend hooks in struct arm_smmu_impl, as suggested by
  Konrad Dybcio.
- iommu/arm-smmu: Moved icc_path from arm_smmu_device to
  qcom_smmu to keep Qualcomm-specific fields out of the generic
  driver.
- iommu/arm-smmu: Restructured arm_smmu_icc_get() error path to
  exit early on success as suggested by Dmitry Baryshkov.
- iommu/arm-smmu: Dropped if (smmu->icc_path) guards from
  icc_enable/disable since icc_set_bw() handles NULL path safely.
- iommu/arm-smmu: Changed WARN_ON() to WARN_ON_ONCE() and
  propagate error code to callers.
- iommu/arm-smmu: Changed ARM_SMMU_ICC_PEAK_BW_HIGH from 1000
  to 1 kBps as a minimal keep-alive vote.
- Link to v2: https://lore.kernel.org/r/20260526-smmu_interconnect_addition-v2-0-2a6d8ca30d63@oss.qualcomm.com

Changes in v2:
- dt-bindings: Cleaned up 'interconnects' property description --
  removed "Optional" prefix and driver implementation details as
  flagged by Krzysztof Kozlowski.
- dt-bindings: Added allOf conditional using 'items' to restrict the
  'interconnects' property to Adreno SMMU nodes only (qcom,adreno-smmu
  with qcom,qcs615-smmu-500, qcom,qcs8300-smmu-500,
  qcom,sa8775p-smmu-500 or qcom,sc7280-smmu-500 compatible), so
  non-Adreno SMMU nodes on the same SoC cannot use this property.
- Added DTS patches for kodiak, lemans, monaco and talos to add
  the GEM_NOC interconnect path for the adreno_smmu node on each
  platform.
- Link to v1: https://lore.kernel.org/all/20260516-smmu_interconnect_addition-v1-0-f889d933f5c1@oss.qualcomm.com/

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
---
Bibek Kumar Patro (20):
      dt-bindings: iommu: arm,smmu: Document interconnects property
      iommu/arm-smmu: Add interconnect bandwidth voting support
      arm64: dts: qcom: kodiak: Add GEM_NOC interconnect for adreno SMMU
      arm64: dts: qcom: lemans: Add GEM_NOC interconnect for adreno SMMU
      arm64: dts: qcom: monaco: Add GEM_NOC interconnect for adreno SMMU
      arm64: dts: qcom: talos: Add GEM_NOC interconnect for adreno SMMU
      arm64: dts: qcom: sm8150: Add GEM_NOC interconnect for adreno SMMU
      arm64: dts: qcom: sm8250: Add GEM_NOC interconnect for adreno SMMU
      arm64: dts: qcom: sm8350: Add GEM_NOC interconnect for adreno SMMU
      arm64: dts: qcom: sc8180x: Add GEM_NOC interconnect for adreno SMMU
      arm64: dts: qcom: sc8280xp: Add GEM_NOC interconnect for adreno SMMU
      arm64: dts: qcom: sm8450: Add GEM_NOC interconnect for adreno SMMU
      arm64: dts: qcom: sm8550: Add GEM_NOC interconnect for adreno SMMU
      arm64: dts: qcom: sm8650: Add GEM_NOC interconnect for adreno SMMU
      arm64: dts: qcom: hamoa: Add GEM_NOC interconnect for adreno SMMU
      arm64: dts: qcom: kaanapali: Add GEM_NOC interconnect for adreno SMMU
      arm64: dts: qcom: glymur: Add HSC_NOC interconnect for adreno SMMU
      arm64: dts: qcom: milos: Add GEM_NOC interconnect for adreno SMMU
      arm64: dts: qcom: hawi: Add GEM_NOC interconnect for adreno SMMU
      arm64: dts: qcom: sar2130p: Add GEM_NOC interconnect for adreno SMMU

 .../devicetree/bindings/iommu/arm,smmu.yaml        | 25 +++++++++++
 arch/arm64/boot/dts/qcom/glymur.dtsi               |  2 +
 arch/arm64/boot/dts/qcom/hamoa.dtsi                |  2 +
 arch/arm64/boot/dts/qcom/hawi.dtsi                 |  2 +
 arch/arm64/boot/dts/qcom/kaanapali.dtsi            |  2 +
 arch/arm64/boot/dts/qcom/kodiak.dtsi               |  2 +
 arch/arm64/boot/dts/qcom/lemans.dtsi               |  2 +
 arch/arm64/boot/dts/qcom/milos.dtsi                |  2 +
 arch/arm64/boot/dts/qcom/monaco.dtsi               |  2 +
 arch/arm64/boot/dts/qcom/sar2130p.dtsi             |  2 +
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              |  2 +
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |  2 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |  2 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |  2 +
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |  2 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  2 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |  2 +
 arch/arm64/boot/dts/qcom/sm8650.dtsi               |  2 +
 arch/arm64/boot/dts/qcom/talos.dtsi                |  2 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         | 50 ++++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h         |  4 ++
 drivers/iommu/arm/arm-smmu/arm-smmu.c              | 29 +++++++++++--
 drivers/iommu/arm/arm-smmu/arm-smmu.h              |  2 +
 23 files changed, 143 insertions(+), 3 deletions(-)
---
base-commit: 6d582d78fad9d828e575ca0cdcff8ea47a77220b
change-id: 20260516-smmu_interconnect_addition-d9567535e9d7

Best regards,
--  
Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

