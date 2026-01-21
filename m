Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1816E33DED0
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 06:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977531; cv=pass; b=Uav8BMrOTvb2HCEyS0f2iBnRvR9Wcsu1IM6/n8Cnc6jJPeBG6FqYFhCBaN64PYUU5Z94EmPBbN8zBQdiS0Rnf37i49lYLBqWAoVjxpV8nup40bTmQd6mmglIE/mCdM5zbV16ZcbbBMYFhaFPrgwpfH4/Puw3ZgWbsBv7z9bpKIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977531; c=relaxed/simple;
	bh=Dtf4w95lF+8TX0T6sV6oHXiZp1Ndj03ujSIe1/MJOi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7gDuFz5vQLVuxs7NFMT6bfPoJ1Hmwhz1s72QwXbsYuMXzIUX0I9HPWPk4JkrcIKdOv8gGhB1OM+pD4iByAVEmbKkRcMQadC1IY2Rv91XSrUW/4fmsEwVkFfbrOpM5fc0p8tzx7yj73KXdFzZSkGzc/BYaTOCunkvkZDVCpf/Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pmr4inOx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KCOFRRZr; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pmr4inOx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KCOFRRZr"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L602J71036610
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 06:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uoVAHLF3EYmcr2exeun9a/uy
	VZa4cbJ6kjUkolrWsj8=; b=Pmr4inOxwo5dFwMqmub3kZgpcFcNiouqtSaI47Zb
	myAWqzp74odY3kdgejAX/qQVz7bE43fLbICO7B4D6GgRjwirHBT5xdlY6bAefa71
	2QleDdLpexovb3bfbsdaTHG4oWMQnhvl3XfyQ5Qtq6USrprsb4mbdoHCSxJs898J
	i0xpiB0IHi4YGxUZdU+T0067DZtReec4iouIZQDOqwRDh49+wNO+enE+R8jBiyWq
	iGD+3RU6MAChHGdQcK2BdpncWLqrdRziTWybCBL390QecM/buyTbM0jUxcgiqHPp
	2w+rOwH5xgEKQhtO1H60v4a5BQqXL2B1pxfNhUjiTKPEOA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bth55husp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 06:38:48 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f25e494c2so8770265ad.0
        for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 22:38:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768977528; cv=none;
        d=google.com; s=arc-20240605;
        b=WYmnQ/uFtCiPqonKluIoxLtlPQvp4LxctbO4B+3uUJ08vHYqEHTvAwBexTB57aDw5N
         Yvi/YOF2KWdZZVqXZM3YW7eEcUWs1Z8WVmbjByRiVBdF7QfsncSZV9twJ5fgunqBd0uM
         IzUuWgt0S0+p/PqK01eMejrr8ZYPmGxwozIOv8uMXYglLUrxkWl6YnF1FaZkoz3yL62T
         2XRz6RKASFNpq3lVc1T2wGiIDhjMz3ee4Lpe7zT0gkK2x477G+jSRw4tIo8AlYzXlwIK
         2IshEv+MCSptUuP5P9j7rPv03uuA6yxQ0S4EI2Viox3P9wbS6ZTA+a2Hs0fVfXIlRbwi
         jg5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uoVAHLF3EYmcr2exeun9a/uyVZa4cbJ6kjUkolrWsj8=;
        fh=Qc/o+zC9MG5ZgBAoYi0Jl9cGnaJZ3xc9EXzwUhPWfz8=;
        b=TBDLP+qctDjEIDfupjd09ByZL0Vvs+humS0fY4Nz9BdXE/B6PSuqr4vb3WM0d9Zqmu
         OuI7m4PzQZWQU64Oz/KyYf4ZGTU4ny9qOU66TF7mfrhfFqN8nSMASnPxULSddd9ZoxOt
         eVQOq1n855cT6GNjGfCSaye7ueVgBMe1KrO41LSQaZIEKlPyrc8w2qqnecHsqW7rGsRG
         rU5S/DVoYY0llwMbwjwd578pF/8H9a4QLzmsteDPdm0MsKdstqB0idlXMJG73awcT787
         B0mV/Hit7AKIUcj5FShrdsr33LrApqZd619VPMHeVDkK7RTDCQK8xq+RS3x3UHTq1W0t
         rjoA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768977528; x=1769582328; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uoVAHLF3EYmcr2exeun9a/uyVZa4cbJ6kjUkolrWsj8=;
        b=KCOFRRZrEOk5at1T2J8H5aajP1QtTPLaUdSUHU8fu49Ix6oYaxmPKeE7fJeehINnfb
         s66hcgRr64je6MKdPlRpZQd7/pnnzgZ1kPzRYeP++tySa/CB2AjgDBpFRwpYqht9QqhP
         t/UV+Y+T/4amlTTQN+2s/4/1zhDNW5uNLuWh4LTl/7l3JW4+xKCAHYGOp8aXlNxNc7ml
         20VI0GG13S1E6znAoTt7pe9EfVpGB6kIO5rI8MaLhvJ01hCid6HLWNDbpQ1OubEckYBW
         MbUtw6nuwDXP1gfjyjnSE4jQ1hmWWaiEwdKmbVccwAqKV6T9bX1EwdGs+6P60xaMq1HZ
         g+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768977528; x=1769582328;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uoVAHLF3EYmcr2exeun9a/uyVZa4cbJ6kjUkolrWsj8=;
        b=t1+jGlMnNHKc/z0U/QYdTjdrSSmkDLKaC6rntti2pHs6Wi+IpBI4Th0GMuBJyAx1LH
         tvL7SMJjSD3RVHay8csEtOpug0gAhUWaUxRbihHW6VKoWkucQiMFWq8FqgfUm5qAdOwz
         u5pNuNuWCcBxjD6kGjtifviuYeeTR+EXytJ50bNX5jzFcKL+bLsUOiqmMYH6nwUx6CYa
         MQ/GZFMjwMj8x+CeGMG6FG0Cn/MGYm05tw/TfpjZ8m1jv6hlvIJEUqlQIFgiVTKJctrq
         /QR/zJTedPoVpXPJOlASrUvY4e+Gu2rN04xY2oc/3+UeizoAbRngMrU125gjYbh91Mi5
         2HSw==
X-Forwarded-Encrypted: i=1; AJvYcCW9fYnLfDSuMqQR5pKNrRHFwRNTHHRMuzJ9uQu7RcD6xnm3rKJrvhxuLJE1CzF0UPy3HYoUUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+88zUTRkqqzMWkS+gmI26Z6Nd2VDE2DC00RC0By0fRYWFy+n7
	GXeTW37OfwhnXKSulbhh05k3mC8a37bgTHtkOonRpAKkRiu9qR8kp0ouTEKB0veY3fYrPoJVDrE
	+GIN4HK8rJxxKgcVLj85XIpmmd3uEvCyHls2PZeSbQIQYx/Im7hv2LGWXzDpLEvkiZ8ZxpokyeW
	wIgZ9LHFTrOOlIVaI8RUIlmOcTW6fuD/gk
X-Gm-Gg: AZuq6aKUOpAHKOsFbu40p/nuce4WK5NScdPAxM4DehBs8umxxw9fNRnVO2HOPoLX0ds
	LS5sVoBkSyu/dLdrmw5uni/0Sc601kLIikbQpLlhwlvyWgD98sNfMkoFet5P9uQz2SfzDkwH7jW
	l6qfWcsRqaC3J6AoVUjIfpl6W1Nd0TkP6VUg7Mmqjs7peLSmevSJ8TtJ7BmlPgILdcasXatBggl
	CBF/uSLYJg3PX3Cp26iVA5FuJE=
X-Received: by 2002:a17:903:124d:b0:269:7840:de24 with SMTP id d9443c01a7336-2a700a32cd4mr146164045ad.21.1768977527573;
        Tue, 20 Jan 2026 22:38:47 -0800 (PST)
X-Received: by 2002:a17:903:124d:b0:269:7840:de24 with SMTP id
 d9443c01a7336-2a700a32cd4mr146163755ad.21.1768977527043; Tue, 20 Jan 2026
 22:38:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260121055400.937856-1-vijayanand.jitta@oss.qualcomm.com>
 <20260121055400.937856-3-vijayanand.jitta@oss.qualcomm.com>
 <CAO9ioeXLJK6fvriRA9RZs8cWcBdv4fgw8VG1_LqLDfc-5hFQZQ@mail.gmail.com> <21b3f41a-d480-4eb1-a02e-c2ae411f3dd9@oss.qualcomm.com>
In-Reply-To: <21b3f41a-d480-4eb1-a02e-c2ae411f3dd9@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 21 Jan 2026 08:38:36 +0200
X-Gm-Features: AZwV_QiJlNZEj58i8rePDdx1qSaitOJE_ow44ZEZkiy8ZtWQEH2g-4qzJoIkY9w
Message-ID: <CAO9ioeU8-uQx4cJ=_nPfQ_ZJ=ZUAwwCYrehSqLw5X-YBVnFz3Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] of: factor arguments passed to of_map_id() into a struct
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, robh@kernel.org,
        konrad.dybcio@oss.qualcomm.com, bjorn.andersson@oss.qualcomm.com,
        bod@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
        prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: QJm7cPiO0ec_sDmrQvQTu6Rr7bT2wroS
X-Authority-Analysis: v=2.4 cv=Oa6VzxTY c=1 sm=1 tr=0 ts=69707478 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=TmfMg1Oyh4ahZQCI_-sA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA1MyBTYWx0ZWRfXywRALgIh3KCv
 3BN8V0BKYtzoRm5VbuprWb9d2P799IFmN1Dwm82wU1avb6WRB7H1K6yHiSvuKBVq0o+G+bN0KGk
 0bp5pccyxFEJBQg/GT3BP6AnD8hyjogHKrj8NFIpUNMWMysw5d04nUIL3Km3e3FUcl0Qe+mQQ4t
 pJkwGIqalWg/IrriyOp3NsEzpB1Az2At3bl3tviDgaGN6g0sxMOjg9jE0srfe+HgJaD9CSrmcf4
 zbmCo04xqYOz0dLcgB+GlRwrTvsNRWKg0s018S7shER8CCzxEiEUPd4GBIitozo1m4+GlscXx7H
 sxzW2LihmPM3eDtH8wdfCM6x9agc7sKVfMB8tpyLRa9/+15cRWep6N3IP93KOGGvQWeUTMOnlcT
 zS7sekOfliX4PZey1hYOvFs8HMwzXYOtszfWzd7WROZozZXfn0ZI2d9qlq/xlPOlzrfkWhv8hvR
 GIHhjcKfExaj9hHtXjQ==
X-Proofpoint-GUID: QJm7cPiO0ec_sDmrQvQTu6Rr7bT2wroS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210053

On Wed, 21 Jan 2026 at 08:38, Vijayanand Jitta
<vijayanand.jitta@oss.qualcomm.com> wrote:
>
>
>
> On 1/21/2026 11:30 AM, Dmitry Baryshkov wrote:
> > On Wed, 21 Jan 2026 at 07:54, Vijayanand Jitta
> > <vijayanand.jitta@oss.qualcomm.com> wrote:
> >>
> >> From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> >>
> >> Introduce a new struct type where the optional arguments passed to
> >> of_map_id() are Currently embedded as of_phandle_args struct.
> >> Subsequent patches add additional arguments to the struct that the
> >> caller expects to be filled of_map_id().
> >
> > Which additional arguments? I don't see anything being added in 3/3 of
> > this series.
> >
> > Can we use of_phandle_args and switch to of_map_id_args when it's
> > actually required.
> >
>
> As mentioned in the cover letter, this change prepares the interface for a
> follow-up series adding multi-map support, which we will be sending out
> shortly and which extends these arguments. Keeping this in place avoids a
> subsequent rework and keeps the overall transition incremental.

Could you please point out patches adding more args.

>
>
> Thanks,
> Vijay
>
> >>
> >> Suggested-by: Rob Herring (Arm) <robh@kernel.org>
> >> Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
> >> Signed-off-by: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
> >> ---
> >>  drivers/cdx/cdx_msi.c                 |  2 +-
> >>  drivers/iommu/of_iommu.c              | 12 ++++++---
> >>  drivers/of/base.c                     | 37 +++++++++++++--------------
> >>  drivers/pci/controller/dwc/pci-imx6.c | 10 ++++++--
> >>  drivers/pci/controller/pcie-apple.c   |  4 ++-
> >>  drivers/xen/grant-dma-ops.c           | 20 +++++++++------
> >>  include/linux/of.h                    | 32 ++++++++++++++++++-----
> >>  7 files changed, 75 insertions(+), 42 deletions(-)
> >>
> >
> >
>


-- 
With best wishes
Dmitry
