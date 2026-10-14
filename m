Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07293412276
	for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 04:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791951161; cv=pass; b=L1yM5V5a2fH1u333eibUWaXA0TPZ5PHU6gsFrOthLfObWHlHyWpKtCJG+26EWWQB6H0FQ7lK8AcQlMUOxGquLvZOuvu6UOcqqLoQjn2lWU0HdVoWVWV9n7jxTJ3B2RuB2qhZIHxPjfdtle5QWh9Y+lsv7Fen6uP7OgtKDcGPIRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791951161; c=relaxed/simple;
	bh=l8OShMunAP6CnTzML3fBuG0pGlsaDFB/65p8ok5Q4Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OC+21I+fyau/e5KNlCIKcJA/IraY6zcrfyCfHkVyfJtlmJ2uajXR8Wk76dWP2QXB6umwA7hJxPHPmED6ZFh3NQd3RN766z0ZYwbId4WkQKyg+/wX2M/gHpkxL/3rbHEozxmesq1YFjs5mSBG2TKW4uAMUV2Po6TUuUBEyUPAH2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SQpxAFcS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=goWXzB7W; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SQpxAFcS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="goWXzB7W"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E3u5QR2222165
	for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 04:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=0IToitMTYp/Rl/u3v1Im6m2B2/IkDFAQrOa2qxOYerA=; b=SQ
	pxAFcS+1SQ+AskTGAEMjYX4fMsFRgqxpslh90yM7fF594sep6OqAVAwInsXHsgow
	BL4dDj70qgx0yW/FdzUvYhHMO8SUBiok8zHTz6DSJBKyC0S4es+UWv/sZjUvtB1Q
	TxV5RCv2MGp+BxeFreqNTpTU7fXT2tpYrpmdEw6b7ZTBhWvN23zZqH0oOurCfQvy
	G3APDC2Bjgke2qis/y9PITSOfzrkrgKQsfmbESyB0b/xsLDCdGh6NNcuY6CZemZl
	CrTd8bOlb+4yZjuzD+VH5KQ6O+MpmOgd1goEeBssdRzvh3c8oFP+RtOb4dtVAjRx
	RRaASqepXNhztxsusPNw==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9txs9ncj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 04:12:38 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-81eddfe28b4so54227297b3.3
        for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 21:12:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791951157; cv=none;
        d=google.com; s=arc-20260327;
        b=sgE5thbVnASiitKe3joMUzFlqJBE1CLaItd3N9btCXQyQ1Th5o7Hfg4MX8pwo6Ffwa
         whg0Qo6Ydyvepui0LQSJXuos8rI8OS0J4bdMCWmddWpRS9J12+dlj6zwcl+EOFndclLE
         NlgR7kx4Akh4r8ELsvXfOwgkkUYfOvwmUhzMob565SNRAQ6EDNWTDj8kBJK+UY4EuyUw
         X/jOaCvBvWHtue6pEX4IsczoiRz48t9kOf/q4w9OkZ73ASnEb8zuXQHpWLwKfwSNhMSf
         17mMgJmdDJhbwbfiKc0DFjYl6geSe+HTHpfdpqjEuMCT7PYKdd89uwUVwM+pfWu+GDDx
         8omw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=0IToitMTYp/Rl/u3v1Im6m2B2/IkDFAQrOa2qxOYerA=;
        fh=tIpGzLxHEkTkIISvog8O6CvPbUEsXhu4Md6VKuwYSJ0=;
        b=AskDPT06ethNZAsPUMPraIv6Y+94t9xzne2HBKXyoPWZtB8OpecIMXqjimMrpbjHZH
         lb7vnHAg4PnDDTQIG06EjrQI2dBQltrUL8OxkevqFPFzLMs2ZUbOZmcRgsWHRx47Qgni
         kt8ix+BumoRnclTRP+lIvXtpj3MRue1TTtR3EaiaiOiDVUJiVcBT2G/7vT5tdNqxAnYP
         +PLPhB9SZf57RCu+SmgV9f2UuDs+1bK//bdHp42WBARazFVabhPEJBzqMQASJiNnWM4o
         7/WgJs50nTELZu/g1EYAel2b208goLWKgu7yHkd3ElbAbmwJEYneXRBOIHGjp57Cnt01
         0RWg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791951157; x=1792555957; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0IToitMTYp/Rl/u3v1Im6m2B2/IkDFAQrOa2qxOYerA=;
        b=goWXzB7Wyg2NlXPl54NgX+7Nnpmh76QObevwFxaDFZ1gr0yvy1Jf2+QZhFTU5128Dt
         TenwdDHUMKp5+x0W1bTshdXDMYMmo4Cdv4XNWGFbFEIhcNggipD7wtGr3UIz1Bq91E9C
         eUuAH5tB56n4FUzCNK3cdUaLE4WukO1UUP+YqYlYtD9YvuIAPperXjKcrMESi3sbW7i6
         h+i8/aJsAVR4yzcvZzW1ry1E1nEt04N7bMHQmOE3GwsFLnmqHIkrjkXGg1OV0YDfRo6z
         IjBokPHGZVGDMWGN2f0uVeYnfZmgCyU+/JsiRMH/w3Q6rL2wclduEHkyZOX18e6bti3d
         ESOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791951157; x=1792555957;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0IToitMTYp/Rl/u3v1Im6m2B2/IkDFAQrOa2qxOYerA=;
        b=LdNBDEsCUFAqf305hYYq8KF/gI9rCn9+/g72mdR6U6m6UTHPwKdn5pdz1Vo/r7sN83
         cUjJ1zcUvMu0IlY3436G7ufau3+58hITcUGHB/ZTUS2rIBFIOxv//6oyiCO3cemIDJJ6
         75KQgwVJJ36VMSL3k/E9PgelSBvCczuPGkyOmTkpjp/axarSxu4FAaQNHFKmfqcn0etY
         VlKO94GUy+xLzhrQ8qDBalXfFe/8Fwc/1lEbQtcc9y7vQUsgVhrS2/Q3bJV85WvhVMzc
         qtOAg3rj8/gL/hJWg7aEHC5Dl2PoHPVEXdRX7CtLXb8NPN8IoGlDAe2GaGEeAO4IsaBo
         2I2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxLFKG07BvH0uOcKCnmYBNMqUGIU+5EOFO5OqRdHUy/v5LK28q/ABnh7LphM6pgsRKBxLzNOw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKspRbbOJjdJYfSlfbKVVlndMkOMC5NNqc/RFm02xbLbWUkQeJC
	bFCSwoxyXkjFNLhRUaIH6474ILrhJiVKzy/lplAIooLjkEv+I9HD/26lWLmFkd3ycVqWaQAzG+O
	h0cnlSd9/p5spi3HJg58btfTkTZhE6Q++t7MwZ4xAwypmcFHAxiAcRKlmGr4VrTEEtvLZwabtCf
	diK3Z5gleISFvbBfp779EzFkgk1OR07cjE
X-Gm-Gg: AYBFou3hRO4qw3CEUJ1XUFrrde1vzdPdCyuLQMFOpHM6BIZ7ejc2itsuzccUkqUhQ9r
	L93PJpHr4Hy2SfVYPV2OmR8mxXGcLSh6pGfOU8dQARLWYh1xbRfcRnn41ssJg6GfFVWNp+Wf8gQ
	vy5IBsTs0JfCYceLV0ZxbfDA9nSVnrAd7oOymbX9i9PNrrAhjT8qNxau6u5NI=
X-Received: by 2002:a05:690e:128c:b0:679:8835:a554 with SMTP id 956f58d0204a3-6798835b6f3mr595921d50.94.1791951157094;
        Tue, 13 Oct 2026 21:12:37 -0700 (PDT)
X-Received: by 2002:a05:690e:128c:b0:679:8835:a554 with SMTP id
 956f58d0204a3-6798835b6f3mr595910d50.94.1791951156684; Tue, 13 Oct 2026
 21:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260903140031.3684-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260903140031.3684-1-fangyu.yu@linux.alibaba.com>
Reply-To: sunilvl@oss.qualcomm.com
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 09:42:25 +0530
X-Gm-Features: AclHuK86voQc4FUtiCdkEZEAZb2HJ7wq0GZX-kU_HOfP197uYVxA3KPb_kIuB4o
Message-ID: <CAB19ukELrF5wf3vKaPhoCLWmzGDExv1mZQAyEs8K6uq-zxqsKQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: RIMT: Enable PCI ACS for root complexes mapped
 to an IOMMU
To: fangyu.yu@linux.alibaba.com
Cc: rafael@kernel.org, lenb@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, alex@ghiti.fr, guoren@kernel.org,
        linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxNiBTYWx0ZWRfX4bh7h3Z94YF3
 YYr3bODXsVCSjoRp00pZM82ED2pY1u5PimpNDkNjASsSngYh2Td0cBh5RZDVD/N0vag74+Rva9x
 2pzSascu8N0+CTc3IDi75yL1HvC33BvAgTcfNbJb2xVjjiE81ql6Exnl57Isb1bH5FMgkrweY0Y
 O8RsDUHVCu8pvp5kWt0tRYyF1OH35EOpkpKfoNB0GcqsN9s08DsINDxgmYac8cLEyoqDYWEXsuK
 b9drw6abtqq5fJhmgjEwT3d8siwAuLuCrVUMAgVpJBYsh7XX+CGHP2ivMBTEVWemIuuSxrSuN73
 /ZjvJC9BgVahR7DoKTg7WwzjTfvVjWKtVccLi4jt+xLsKzf3+9MfysF9vSb/ro3GhC551aT2lx4
 gVlaNEMDB/VZ4XaV+QvK1ksjPV5EC9pTBAijhqBqSpX0iaBcPjdLDtMessxKVVJKUbx2pLKA9iP
 /J3U1mWf5Ni3Ams1yLQ==
X-Authority-Analysis: v=2.4 cv=LPPz05W9 c=1 sm=1 tr=0 ts=6acf0136 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8
 a=N72Xn8VYRMkAawgvMsQA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxNiBTYWx0ZWRfX49ekAhI+9lDM
 OPh+PjXU7DosSNwcnzHAx5aQyz3ebr4xyYGKIp5UrKBVjv+YkKPtAhZUiqx5OCGfIfSc2HYIPI+
 Ahyf24mEJDf6kxDi/UfMQ5w/EEj2YJ4=
X-Proofpoint-ORIG-GUID: SJgcHe9uOFMfFjKa4YJE_swt-R2g3Qlk
X-Proofpoint-GUID: SJgcHe9uOFMfFjKa4YJE_swt-R2g3Qlk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140016

Hi Rafael,

On Thu, Sep 3, 2026 at 7:30=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrote:
>
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> Mirror the ACPI IORT solution used on arm64 (see iort_enable_acs())
> by scanning the RIMT table for PCIe root complex nodes during
> riscv_acpi_rimt_init(), which runs before ACPI PCI enumeration. If a
> root complex node's ID mapping points at an IOMMU node, call
> pci_request_acs() immediately, so pci_acs_enable is already set by
> the time any PCI device is scanned and pci_enable_acs() runs.
>
> Only one call to pci_request_acs() is needed regardless of how many
> root complexes are found, so track that with a static acs_enabled
> flag, same as iort_enable_acs() does.
>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
>
> ---
> Changes in v2 (Suggested by Sunil):
>     - Check the RIMT node type in riscv_acpi_rimt_init() and invoke
>       rimt_enable_acs() only for PCIe root-complex nodes.
> ---
>  drivers/acpi/riscv/rimt.c | 58 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
Could you please take this patch via ACPI tree?

Thanks,
Sunil
