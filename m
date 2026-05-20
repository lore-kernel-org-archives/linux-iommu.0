Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77F536BCCC
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264200; cv=none; b=pB0PN27Qosf+C4LpIfxNXdoOhlf5xyLRyZ3nfjbx6yET7z3DfCZmdh7U4yDSsONMD7/ggJXC5fMySMY/Z5bWywJFn6W9xYsg+cfQayGPbeS5t6D9e8jt6dno76j5Ott5fnG5J5YbsHOMjMP80a0vUTVnmlmaQArQ+hYVpqAL0xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264200; c=relaxed/simple;
	bh=iNWcrRc8U4lM1k8ax/30YJhUEnlFBubqUx9ZeFn1nFA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SnWuX/Y7tStsrTvwVxL0WsmIkwHovfXsM5/GwYKtI/fHJo7VJ7EeCWsOnHwwlMJyKNjv6PaRAQQTia1jHgGZg2vF7xcwJiKpMCwW/CjpbI1K9JhlfLwRh5rXGG1jZ43cok8V7r5Yy+roFQyjUwt7wKh8JjqMvGGUVUkC4vum0Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IwDPonQh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SoxGI00t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IwDPonQh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SoxGI00t"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K6svkw1237939
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 08:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jlSKfthX4HPtf4+kK54drZ
	mQ19Rqg4gAjCsyLiQCKHc=; b=IwDPonQhvvyJevlabHcwTTFLwsVT53P8rB5/He
	GSbTKmyCQP2enzl7cpF/ylHVoFR1Dc+5Dgy63LdRTa94Y268kiNDo0+ZTMRCrbLj
	yu5FljcIumMIitp/eqh/tq1iEFeSj9DHbnCY6Fz3AwDn849V/hdhG5rAYd3uiDqW
	tLvlBYSIcXUSEP9qn5wi9efTksX6t4VVJ4tQAxnl3UjZjxKcpyOuCX+fb3ShyU6V
	N5TtgidypoPPwsxQuo2+umOShvr84ENx8naZUrDzkYYQnvZJ57LRpJKfl0lU6uri
	5QBcvkMTo+NlmplyHVjNV7g5djtTk0Fi8GMQO4i1+yccPtZA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3sustc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 08:03:17 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-368b01f8adeso6458951a91.0
        for <iommu@lists.linux.dev>; Wed, 20 May 2026 01:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779264197; x=1779868997; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jlSKfthX4HPtf4+kK54drZmQ19Rqg4gAjCsyLiQCKHc=;
        b=SoxGI00tDRSaXTjPuUIgBs90ccb1Oqzo1FbU39eCcF+YMvix3FjXVyNUyMSR7kCFEE
         nng/AL0keSXxs/MIAFqzb2P8+JgStZFrzwgZzWKYxKxMEAjkewp1KvWWGbYPZMd+bSZ0
         5k7c4hfAh4NyR/qTAz4wI2lMxCaPzeSKVPd5bR8vNarlr7iEht290T1h4Te+yIS3i4/R
         EXC9eoeH5F+nq83W3FTX5KFOHhLeht2rs8WjOkLJAH6d4edieC4JsvRNY/LoEL8nGnwa
         akHfEPejAPVPFcQdSgDjVPZ5VenuElnehnS3n3OEVnTYQEQIys+j9ENyjDQpeo3t3Ndd
         vJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779264197; x=1779868997;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlSKfthX4HPtf4+kK54drZmQ19Rqg4gAjCsyLiQCKHc=;
        b=A0O5jHsLY01rOoIZPmY4q6i8ENknOUXYcA3RcJOd2fhDw53AuUtfsZ6rAv+lyF4ri5
         TT09MRjrpO8I6EmRKFh4t9t5ceUWkQKvVz7jF0PympDeFZ2dLZjJvZd+QY3aIoRiXRpa
         LLZWzXMl1tZj/LeVOBNOPxSk78UXEoelj6EYPDmICklvmT9NfAMYpbFNE9PIdvgfBYsU
         rofHALA+76d/7fI+IHEP9PLAkv4SPU65L6DBklNGA8Dnc1Ba6X4/rjJGFjMz7tJfOT/a
         0GG/N+dOgc6Du3lC9Tb/AQhR0H96OdNg9GqwBwX1Lm9XFaiJ2eX292rEEMIluMphuuxH
         4jCQ==
X-Forwarded-Encrypted: i=1; AFNElJ/04YXaVjImzw5fuJpSG4Af5T9A5HGlNxCBm2vR1gasRsnyYjGJLhlBUPNyoNW2UNaCKr7fJg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwR6LclxCAnqEtZZONa5Z5HHPrqLiKaO5vDNuCbjvL3qBSvSu2P
	4Uw+bAg/uScO/U9DHRlWH/4N7S9QJp4V9l5dXmS6/GeN80AYJoE8IyV4Kivp7X9jC0TLG1BaEbz
	XVtsSo1nCujkCvws6cK4Bzo91B7boEa0TcUYEDIyyaF5pUC2NZS8o+KUCcg==
X-Gm-Gg: Acq92OFMurPMaoBg9+EyEJqF7zkIB4MzmbNcrDF6C5GW7rp56ezFamRngbNNTpO2/Jk
	Eleh805BiUgRzy3Wi8oka7KcgZ6gOTg5e2053bKaSMxhO04gdAZZieFYtaJOtvJ8gbToIiGnNIN
	8wTZocHH42ZQ0P0l0j5YGeVM5jRxlTBl9Hb3Tc7JeTCMVj0IxUrv+SS8OPDcSYYBW1dSAY+W0UE
	X/92uJRXnGlYzoKJHzThnzUUE3bnx20vplxo74R93EAKQkGBktwWPnDpU0yN4tRecT1JU6S0QBF
	u9JSavEdfA6d5p0n4Oc2U+5dQRTF9aIklKU1/0/x7UldjqUbSKxbi1ZkI5cSCiQZgztb+bqdolu
	nYFJU0Z7yVpU0PX62Smn/FSbswtelC3pXi+s+Nbj/kmvR0hk6K24uU+th
X-Received: by 2002:a17:90b:5904:b0:367:d850:6a5f with SMTP id 98e67ed59e1d1-36951c9f53dmr23576103a91.25.1779264197106;
        Wed, 20 May 2026 01:03:17 -0700 (PDT)
X-Received: by 2002:a17:90b:5904:b0:367:d850:6a5f with SMTP id 98e67ed59e1d1-36951c9f53dmr23576055a91.25.1779264196495;
        Wed, 20 May 2026 01:03:16 -0700 (PDT)
Received: from hu-vjitta-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517aa6f8sm20889290a91.11.2026.05.20.01.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 01:03:15 -0700 (PDT)
From: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: [PATCH v15 0/3] of: parsing of multi #{iommu,msi}-cells in maps
Date: Wed, 20 May 2026 13:32:39 +0530
Message-Id: <20260520-parse_iommu_cells-v15-0-b5f99ad4e7e8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJ9qDWoC/33QwU7DMAwA0F+ZcqZT7DSh4cR/IDS5jsMibetoW
 AWa+u+ku9BDysWSLftZ9l1lGZNk9bK7q1GmlNNwKQnYp53iI10+pEmhFBRqdNpoaK40Zjmk4Xy
 +HVhOp9wAG/PsOpK+J1XmrqPE9P1A395Lfkz5axh/Hjsmv1T/0ybf6KYN0LMIsxV4HXLef97ox
 KVrX4Ja0An0WvI1CXSh2GFkIksQui0KVhTaKgWFgiiRLGvpkLcoXFGmeh9goYJwDEZbEfJblPm
 jWt1VKVOoSB5BPDoH/RbVrihsq1S7UEFjBOgdm9qv5nn+BdtGt/ExAgAA
X-Change-ID: 20260301-parse_iommu_cells-1c33768aebba
To: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Prakash Gupta <prakash.gupta@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, imx@lists.linux.dev,
        xen-devel@lists.xenproject.org, linux-arm-msm@vger.kernel.org,
        Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779264185; l=11180;
 i=vijayanand.jitta@oss.qualcomm.com; s=20260301; h=from:subject:message-id;
 bh=iNWcrRc8U4lM1k8ax/30YJhUEnlFBubqUx9ZeFn1nFA=;
 b=07EsmYfofxVCPU2Je9T3PGCZ5cjU9kJe1yL3BwAPeQsdVaBtAkvf00Fj0WfbPDVAxb2jPyVks
 h1aA3AbmsLXAN617RCr+2eG6fvYxmLMaxJPpDY0VZEobOFwGPKVdK0C
X-Developer-Key: i=vijayanand.jitta@oss.qualcomm.com; a=ed25519;
 pk=Lpi7Cs3wHe8KZtqvyci7FTOLzsKpEHKGCaPNZw+1zRI=
X-Proofpoint-GUID: IJW2sp5qFanvuNOduvjQVFTNFmVCxyQv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA3NiBTYWx0ZWRfXxnvcr1wxvdSR
 uyy6/XfeuI620lFH77CkyVhyLl18LpXwhgM6mjVdk6b98uahlqZb+w7zCq6oxzB9Y8Qw4vhzYiz
 upzZTPRdDuz1hQKDevdXz7z497wsKPg7bNAxnUg2p285N9moLUIsMkvRsSJtstKMpSmtCxYEiny
 VWcI3cc239FCVLVG6V2PtTzizbtOeVy0SF8rXsI/FyUFp2o8ogAC1guvi02/OWnaR9z28UuOeAm
 7kU/y/6fuTVXQbuyeWZQWed+OYbK1+7GPY2DJJbiUJvDOq7PBfwx3//BQyRdgngTqwwekEjwvpb
 iLrFpP6IfIwZlXH8f5c/+4yX/f04AEdv9vbS7jUjBuZBQWUKgGnfsPtX6W7lG2mQT6LiiKZK2FI
 6O4FThRjaahxwheeeuIq7qHlGZbHW2txGs5z0ZSVzoF4gXL1BOwk0kXBsqrSMOmKaQZ6OIRJ5Mf
 8TcSq41++iFaTq74iyA==
X-Proofpoint-ORIG-GUID: IJW2sp5qFanvuNOduvjQVFTNFmVCxyQv
X-Authority-Analysis: v=2.4 cv=SNhykuvH c=1 sm=1 tr=0 ts=6a0d6ac6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=NEAV23lmAAAA:8 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=zd2uoN0lAAAA:8 a=tA7aZXjiAAAA:8 a=7CQSdrXTAAAA:8
 a=8AirrxEcAAAA:8 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=iox4zFpeAAAA:8
 a=DBfv99YmAAAA:8 a=JfrnYn6hAAAA:8 a=cWRNjhkoAAAA:8 a=vIDDpPC5oxyFppbewhgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=TjNXssC_j7lpFel5tvFf:22 a=FO4_E8m0qiDe52t0p3_H:22 a=kIIFJ0VLUOy1gFZzwZHL:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=ST-jHhOKWsTCqRlWije3:22 a=WzC6qhA0u3u7Ye7llzcV:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=sVa6W5Aao32NNC1mekxh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200076

So far our parsing of {iommu,msi}-map properties has always blindly
assumed that the output specifiers will always have exactly 1 cell.
This typically does happen to be the case, but is not actually enforced
(and the PCI msi-map binding even explicitly states support for 0 or 1
cells) - as a result we've now ended up with dodgy DTs out in the field
which depend on this behaviour to map a 1-cell specifier for a 2-cell
provider, despite that being bogus per the bindings themselves.

Since there is some potential use[1] in being able to map at least
single input IDs to multi-cell output specifiers (and properly support
0-cell outputs as well), add support for properly parsing and using the
target nodes' #cells values, albeit with the unfortunate complication of
still having to work around expectations of the old behaviour too.
							-- Robin.

Unlike single #{}-cell, it is complex to establish a linear relation
between input 'id' and output specifier for multi-cell properties, thus
it is always expected that len never going to be > 1.

These changes have been tested on QEMU for the arm64 architecture.

Since, this would also need update in dt-schema, raised PR[2] for the
same.

[1] https://lore.kernel.org/all/20250627-video_cb-v3-0-51e18c0ffbce@quicinc.com/
[2] PR for iommu-map dtschema: https://github.com/devicetree-org/dt-schema/pull/184

V15:
  Address Sashiko AI review comments on v14:

  Patch 2:
  - [Critical] pci-imx6: pass &msi_filter (not NULL) to of_map_msi_id()
    so that of_map_id() returns -ENODEV when msi-map is absent, preventing
    the '!err_m && !msi_spec.np' path from incorrectly returning -EINVAL
  - [High] of_map_id(): explicitly set arg->np = NULL before any bypass
    path so callers can safely call of_node_put(arg->np) on all return paths
  - [Medium] of_msi_xlate(): pass msi_np directly to of_map_msi_id() and
    of_check_msi_parent() (removing the local_np/np indirection), and use
    'break' (not 'continue') when msi_spec.np is NULL so that msi-parent
    bindings are still checked when msi-map is present but has no match
  - Guard 'id_out = msi_spec.args[0]' with 'args_count > 0' in
    of_msi_xlate() to correctly handle 0-cell MSI output specifiers
  - Use of_node_get() + unconditional of_node_put() in of_msi_xlate()
    for clearer reference ownership

  Patch 3:
  - [Critical] of_map_id(): add 'cells > MAX_PHANDLE_ARGS' check before
    using cells as an array index to prevent stack buffer overflow
  - [High] of_map_id(): the MAX_PHANDLE_ARGS bound on cells also prevents
    integer overflow in the '3 + cells' length check
  - [High] of_map_id(): fix misleading bad-map workaround message from
    "assuming extra cell of 0" to "treating as 1-cell output" to accurately
    describe the actual behavior
  - [Medium] of_msi_xlate(): guard 'id_out = msi_spec.args[0]' with
    'args_count > 0' to preserve id_in for 0-cell MSI output specifiers

  Link to v14:
  https://patch.msgid.link/20260424-parse_iommu_cells-v14-0-fd02f11b6c38@oss.qualcomm.com

V14:
  - Updated Patch 2 ("of: Factor arguments passed to of_map_id() into a struct") to
    fix below two issues in of_msi_xlate() that were introduced by the API refactoring:

    1) The refactoring changed of_map_id()'s dual-purpose **target parameter to
    an explicit filter_np parameter. In of_msi_xlate(), this caused
    of_map_msi_id() to return 0 (pass-through) instead of -ENODEV when a node
    has no msi-map, terminating the device hierarchy walk prematurely before
    reaching the root complex node that has the msi-map. This broke MSI
    allocation for PCIe endpoint devices (e.g., wcn7850 Wi-Fi on ARM64).

    2) Additionally, fsl_mc_get_msi_id() passes msi_np == NULL to of_msi_xlate(),
    which would dereference NULL with the new API.

  Link to v13:
  https://patch.msgid.link/20260408-parse_iommu_cells-v13-0-fa921e92661b@oss.qualcomm.com

V13:
  - Fix bad_map handling in of_map_id(): 'cells' is re-initialized to 0
    on each loop iteration, so the !bad_map guard was insufficient, cells
    stayed 0 for all entries after the first. Fix by explicitly setting
    cells=1 when bad_map is true on every iteration.
  - Collected Acked-by from Frank Li.

  Link to v12:
  https://patch.msgid.link/20260331-parse_iommu_cells-v12-0-decfd305eea9@oss.qualcomm.com

V12:
  - Call of_node_put() unconditionally in imx_pcie_add_lut_by_rid()
    thereby addressing comments from Bjorn Helgaas.

  Link to v11:
  https://lore.kernel.org/r/20260325-parse_iommu_cells-v11-0-1fefa5c0e82c@oss.qualcomm.com

V11:
  - Added explicit filter_np parameter to of_map_id() and of_map_msi_id()
    per Dmitry Baryshkov's review feedback, making the filter explicit
    instead of overloading arg->np as both input filter and output parameter.
  - Removed of_node_put() from inside of_map_id(), making the caller responsible
    for reference management. Updated of_msi_xlate() to properly handle reference counting.
  - Collected ACKed by tags, and fixed minor typos.
  Link to v10:
  https://lore.kernel.org/r/20260309-parse_iommu_cells-v10-0-c62fcaa5a1d8@oss.qualcomm.com

V10:
  - Move of_map_iommu_id()/of_map_msi_id() from include/linux/of.h to
    drivers/of/base.c as out-of-line helpers per feedback from Marc Zyngier
    and Rob Herring.
  - Add kernel-doc to document both helpers for discoverability and
    usage clarity.
  - Fix of_map_msi_id() wrapper and all its callers (cdx_msi.c,
    irq-gic-its-msi-parent.c, drivers/of/irq.c) to correctly use the new
    struct of_phandle_args-based API with proper of_node_put() handling
    as per feeback from Dmitry.
  Link to v9:
  https://lore.kernel.org/r/20260301-parse_iommu_cells-v9-0-4d1bceecc5e1@oss.qualcomm.com

V9:
  - Updated TO/CC list based on feedback to include all relevant
    maintainers.
  - No functional changes to the patches themselves.

  Link to V8:
  https://lore.kernel.org/all/20260226074245.3098486-1-vijayanand.jitta@oss.qualcomm.com/

V8:
  - Removed mentions of of_map_args from commit message to match code.

  Link to V7:
  https://lore.kernel.org/all/20260210101157.2145113-1-vijayanand.jitta@oss.qualcomm.com/

V7:
  - Removed of_map_id_args structure and replaced it with
    of_phandle_args as suggested by Dmitry.

  Link to V6:
  https://lore.kernel.org/all/20260121055400.937856-1-vijayanand.jitta@oss.qualcomm.com/

V6:
  - Fixed build error reported by kernel test bot.

  Link to V5:
  https://lore.kernel.org/all/20260118181125.1436036-1-vijayanand.jitta@oss.qualcomm.com/

V5:
  - Fixed Build Warnings.
  - Raised PR for iommu-map dtschema: https://github.com/devicetree-org/dt-schema/pull/184

  Link to V4:
  https://lore.kernel.org/all/20251231114257.2382820-1-vijayanand.jitta@oss.qualcomm.com/

V4:
  - Added Reviewed-by tag.
  - Resolved warnings reported by kernel test bot, minor code
    reorganization.

  Link to V3:
  https://lore.kernel.org/all/20251221213602.2413124-1-vijayanand.jitta@oss.qualcomm.com/

V3:
  - Added Reviewed-by tag.
  - Updated of_map_id_args struct as a wrapper to of_phandle_args and
    added comment description as suggested by Rob Herring.

  Link to V2:
  https://lore.kernel.org/all/20251204095530.8627-1-vijayanand.jitta@oss.qualcomm.com/

V2:
  - Incorporated the patches from Robin that does the clean implementation.
  - Dropped the patches the were adding multi-map support from this series
    as suggested.

V1:
 https://lore.kernel.org/all/cover.1762235099.git.charan.kalla@oss.qualcomm.com/

RFC:
 https://lore.kernel.org/all/20250928171718.436440-1-charan.kalla@oss.qualcomm.com/#r

Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
---
To: Nipun Gupta <nipun.gupta@amd.com>
To: Nikhil Agarwal <nikhil.agarwal@amd.com>
To: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Saravana Kannan <saravanak@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>
To: Krzysztof Wilczyński <kwilczynski@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Frank Li <Frank.Li@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Juergen Gross <jgross@suse.com>
To: Stefano Stabellini <sstabellini@kernel.org>
To: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: xen-devel@lists.xenproject.org

---

To: Nipun Gupta <nipun.gupta@amd.com>
To: Nikhil Agarwal <nikhil.agarwal@amd.com>
To: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Marc Zyngier <maz@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Saravana Kannan <saravanak@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>
To: Krzysztof Wilczyński <kwilczynski@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Frank Li <Frank.Li@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Juergen Gross <jgross@suse.com>
To: Stefano Stabellini <sstabellini@kernel.org>
To: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: xen-devel@lists.xenproject.org

---
Charan Teja Kalla (1):
      of: Factor arguments passed to of_map_id() into a struct

Robin Murphy (2):
      of: Add convenience wrappers for of_map_id()
      of: Respect #{iommu,msi}-cells in maps

 drivers/cdx/cdx_msi.c                    |  10 +-
 drivers/iommu/of_iommu.c                 |   6 +-
 drivers/irqchip/irq-gic-its-msi-parent.c |  10 +-
 drivers/of/base.c                        | 227 +++++++++++++++++++++++++------
 drivers/of/irq.c                         |  25 +++-
 drivers/pci/controller/dwc/pci-imx6.c    |  55 ++++----
 drivers/pci/controller/pcie-apple.c      |   6 +-
 drivers/xen/grant-dma-ops.c              |   5 +-
 include/linux/of.h                       |  32 ++++-
 9 files changed, 277 insertions(+), 99 deletions(-)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260301-parse_iommu_cells-1c33768aebba

Best regards,
--  
Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>

