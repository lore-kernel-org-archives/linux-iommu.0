Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793460514;
	b=phBTmIyLhwGkEJRLib2ATgL4JWCnUZGIGPbm8znMg2yesLUX5i1LVtPByOYA6UFlP/Bd
	 kHWaoxzLoPdeylsoJmgOH8QXRnc8OF6tF/sKqnVlaLFXWgmvy9+U4pHOKLWwPSTAG8bxK
	 YlG4DFW411v8JAdQA8nnJU/8IQkw1bjiGjn6XNd2o5Bvhy0+bKwZhjh1+GtIk3Lo1HPul
	 Uz3UUfhGNp6HT1liXS1iiCgmqu+DFWAr6VRfc9nAOLuOPDCBXIxIEpiYbxleDvU+3SJJV
	 byKBc77tHDd7jdmkPxRCve2Ngi/0ghofWoLhRYEYdxRpFTFTKIBWVhEuEsTF9aNKaNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793460514;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:Reply-To:From:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=tOU7wcttXT/neIukANAweAXjE4RpchSIStpTuwhO4/I=;
	b=0E7bYG/ALvAbvVTVYcAnbkhFTyg4yrUvoByzgRUfVpuKsE9mhoMB8UlBM+KT+Krd/oMx
	 NjuMWWZWmEHSh0y8MNyxAzYIUkBlHHGF65cyZnK/0TnOzuiyJG0CcSABj4yYiJ9sFXCPj
	 0a7Dp84RmHHxgtC0mykIopkgtCCTzYrqUMbApV5FIILewsIms4L4OSoBc+gZZ2PlJt+lJ
	 wo2dAaxKsGet3OsZonI+LGRpoFicJq9TK4gbpwnWwyH2U0r2noALPRtP1pjrnlQTLu6Ub
	 mizb/1Y2ZTDberH9KLT2iGFcNUF91aol5VHe3qFYL9B6W2Qmm3dvIjok6QGovA+Didg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XZLNe5kD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YQyMKIgC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A4C606A31D
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 15:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0A4C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XZLNe5kD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YQyMKIgC
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69VD01UE2202736
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 15:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=tOU7wcttXT/neIukANAweAXjE4RpchSIStpTuwhO4/I=; b=XZ
	LNe5kDRdCTsgzIsQk5zfpO5sEiFbxO2CNTuFoTP5VJyXH+UhBnzsk/MNA39YdJ1W
	QWDX8I5aZ8fw3NeZvo5gYtySWiHmi/mp7rqFFMtfL0WC5IIzT21BwzompCqdxGzW
	bPk6UZtW5PCoFs4ThsuKIrPwSOxyZesizOuxU49DEVM4M/mEtXR0t2jlUnH4s8BW
	5ZfJowD+Tbo4WHJyxAZG2cFJH5ZsIjgRRKK5w94RL2VF0yaX8Q2C8YpbGWgeT1WR
	uVGY65/XjDF9At0kG9kt54DU2kBU90fSzqf2X4iBFy9YF/A3VbG1BIk1NtNcdio3
	abjjvJbQ/pqbgXP0F7xA==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn5pkhrqs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 15:28:32 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-702f2edafaaso2288826eaf.1
        for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 08:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793460512; cv=none;
        d=google.com; s=arc-20260327;
        b=Rrq7Pch043KdtjeGJkMhgqRQ2y9RgP54qV4NvXfWQV40nodvlap3PS+ljusek6B/Qt
         PiTcXSzr/kvZDmqb3sHvJSa9JIAnudD6zjpAF+ScMKVKyI1RanDG8SAM07VvPpUmAzaa
         ddv2v53YDJHj6RkpcOSVs1VG2U8SGcH1pPPZswS1jH1eStn7exrERIffJ/7V62TxrQXf
         GTDJ4FdyMx8FMw4eKIuk5ud4wEN1fsS5VqyvGLgCnABoXk2jNpoz8Sc8BrLHysTdueNk
         tLUr2I/VX9mD4rTVlK8cR8sSC1S/CyIPwmHt8VPAu6SprHUMdgunuFUZayT1j2jSY+oS
         y5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=tOU7wcttXT/neIukANAweAXjE4RpchSIStpTuwhO4/I=;
        fh=e4UEjdwgGinOqc6Ib7NFL3xLF4Lph66SCmpN3h0TkyM=;
        b=cT9Mk1uUzFA4reua3KXeU9BBqW7GgBG5LrwRAMVlV/zSZxloqNA+/Or+8MVHoUJ8/J
         xc/iar63b6nQ42MImD3Vp5RXIXFOD2cK22XUH9EtB8o1BKoO9xEZ+UwGj5KMUKrp7B8E
         VfRcbNE2HzKQ/uu1Ft3Dp/iDo4mjfNM/Gb8+YWkTNUpyB7rEUnczw2Am0mVNubjbENbR
         7R1a+2UFlIm5+WmRFSIbYjRGM73STnle0VP6+9qKcWsl6ZCsFIKoSBUsGuiaxXCt3L9b
         lBFS5+5NANRjH+SXaDD8wt0g735mSWUGR0QkTz/mvNtT0H4eRnLZGu9d9CkA3B0TngcA
         mAlw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793460512; x=1794065312; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tOU7wcttXT/neIukANAweAXjE4RpchSIStpTuwhO4/I=;
        b=YQyMKIgCykwRNcFXOtpAPeL5Mh27bu5mu4yAPl0xNnLhTtTHrCqwHYngwh8Tv7SRRF
         9DgtSAKaY5MoBE1HYofYRHM4359x/MXFlZl9RE+BhDkLItQb3fonJecHSh2AYYCiqDdG
         ejYrKq2Guh12hHdaFAzxn5emFbmG7Ai7J8PieIy0V5YGq9A9QeGJogPU6FL/MzuNUvgq
         /RnPwFwf4T2o1QP+UNFLWnysxvP9vT4gXmppQAfZBuLt3y6Qdr8owtJU5inm6Fmq/nFG
         ThbZDTVXzTSBm8xwc4yhHt0cH6Xjx0oJZyotSlG7Bu10dZ5Xt8GM1WHD27KUT3S4988B
         APRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793460512; x=1794065312;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tOU7wcttXT/neIukANAweAXjE4RpchSIStpTuwhO4/I=;
        b=jUjiHOClF4RgOLoDOQ+cbuALMi+7Dy7gmdRVnV8y3aKtgoqe1PiUh1YhNeVZDbHqK3
         1PQ9y9VqR1GPUBnc2mSKJLgFN/xZt4nO8fRNY74gOX9NPFrDapXi97H60FdYanKMRb0O
         DMrAdifIb4RSEdeFoDkVg+hJWzKyUWfsH2jCJ3ntG116f+CfObDhq3YH9WbrpaK0cqaH
         nrvWteE1KpIF+cr3Yo8pWZT1HunXniP9CjTMfCmnNKwEt3RYq4fkUvnUqRgIxqhp8jry
         Gcc82LnjJjduhXbwJz/QHNEBEdd4sbnoS1ks+a5zB4BNNFUBrK8GSRCa8LHXLsBlbHAJ
         sAvw==
X-Forwarded-Encrypted: i=1; AKwUvBzNDjSASsw9xZ4Vwo6RAcYrqmp4cfcZtHlhzbiBDbVMbuk4ddTXKS/VjX9zXqQqKKt9tRl7cw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ/Ql5Dpalwui1sjQOZy3EwFrNyPV75Qe8ueHe1rufdsYKeo7Qw
	iB2ZIJ3RMnxtOGf2EJOJKYI7m8CzSrRgBWWiZ618CM3yse+9SHgskzoIniGT6F4Zc8Lm48W23VJ
	IeM08dGXUUymzixkM+PQtQMvEd6XY/bIj7D6gJ1Rtulq1+PoJEWK1ijDYlwRns32XNMhGN2y4Qx
	KFTGIJOOHJkrTJDX/Pi+5Cxe/83G3EnlVF
X-Gm-Gg: AYBFou3uBC4N4yaL8XKZF5OmoQBgkkGUzBVqjSzM4uaYOXjTaQRyl9ptYsZrwgSnb4+
	utvk3xU0L5kY4Xb+ppmuWiperyqO4ESA9tsAZRW8ARsthzybZo+im3MD7BGHqJc9NdtnOF74F9P
	Qlhe9irk7zYXdVQO95KL/5YzvwGiscg//izpgtGCOUgQ4lSMUhssYNNU0qZA==
X-Received: by 2002:a05:6820:5616:b0:702:a3b3:810a with SMTP id 006d021491bc7-714f241202cmr2221792eaf.22.1793460511695;
        Sat, 31 Oct 2026 08:28:31 -0700 (PDT)
X-Received: by 2002:a05:6820:5616:b0:702:a3b3:810a with SMTP id
 006d021491bc7-714f241202cmr2221784eaf.22.1793460511233; Sat, 31 Oct 2026
 08:28:31 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261031-msm-smmu-identity-v1-0-a2a70580eebd@oss.qualcomm.com> <20261031-msm-smmu-identity-v1-2-a2a70580eebd@oss.qualcomm.com>
In-Reply-To: <20261031-msm-smmu-identity-v1-2-a2a70580eebd@oss.qualcomm.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 08:28:20 -0700
X-Gm-Features: AclHuK9eauWalhgtTBC2J8Fwe5Mi3Jn1yWHBYz9zSLaNIZfyReKOdimAawUMQ1k
Message-ID: <CACSVV033K2=PUfZPHfZnUq7ACmU0wz8iw7Mev6YOWJ7s+h7iPQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] iommu/qcom: Use identity default domains for the MSM
 GPU and display
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, iommu@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 4xAqt5nxvGFa1U2UB_L3H2FsLL5DZBhH
X-Authority-Analysis: v=2.4 cv=Z4F5j3RA c=1 sm=1 tr=0 ts=6ae60920 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=Yhi7VFIheabn5aZjDpkA:9
 a=QEXdDO2ut3YA:10 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA2MSBTYWx0ZWRfXzOyRCuME1Ihk
 vqvlwGDcOAAMx70vuvmv2ZR2AuqnMt9wN6NoOSUNawLJnklotAQqeJB2F93hf1es68esO2PsTO5
 SeGRSE0agw0oNne3H0SQZ4Q93zW3+Go=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA2MSBTYWx0ZWRfX0bngfFMbLp+n
 wU4JV79qbOg6B8hVUB45VLovWIHLfGZquJfAf44QtPCrhvmJla9X8QCmXoSbiKS0HRRuF2MNIk+
 j+/0cR6dnTTXfsp9iU3aSAMthqJkEmt/9FDtYBkNcl/YKkDYQeGf5nGhtRESweSMvK/6dJoTDyl
 hBWfu7n0GjkSZ1qlSSu/LogtdnSVCJW7yW06kfnXIbGBeJJryvZlFggqvpbjy4qpOV52Vw436vi
 vCV0wWQLCaMJL3zGnwnvgD/PkcAFClirmJqQQoI0EzphjvsLxlB5dgAl7Dm0DiTpDiJtFgyKbw/
 Jcn7Gkd9Qpji/Qv98KBVWa347v3ISI1lzbjaATaAODlVLfa/yllMPbTfNKnPH0EPr419FinrJIl
 Aw2Ym9eT6awe7mBLbp0DoBoDb4gWbhUprROxPCPczuU/u2o4Iy/MVCnVC8l/Yp6PnZrbjdDr5aL
 gvxXM8EmELJjjkPt2fw==
X-Proofpoint-ORIG-GUID: 4xAqt5nxvGFa1U2UB_L3H2FsLL5DZBhH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310061

On Fri, Oct 30, 2026 at 3:05=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> drm/msm writes the addresses dma_map_sgtable() returns for the DRM
> device into its own page tables, so they have to be physical addresses,
> i.e. the device must not use iommu-dma. qcom_iommu has no
> def_domain_type, so the MDP5 and Adreno devices do get iommu-dma, the
> buffers end up mapped at IOVAs of the unused default domain and the
> db410c GPU fails to start.
>
> Use identity default domains for these devices, as arm-smmu-qcom does.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

Reviewed-by: Rob Clark <rob.clark@oss.qualcomm.com>

> ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/=
arm-smmu/qcom_iommu.c
> index 54130c32056a..4a9c4cf63724 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -22,6 +22,7 @@
>  #include <linux/init.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
> @@ -531,6 +532,18 @@ static bool qcom_iommu_capable(struct device *dev, e=
num iommu_cap cap)
>         }
>  }
>
> +static const struct of_device_id qcom_iommu_client_of_match[] =3D {
> +       { .compatible =3D "qcom,adreno" },
> +       { .compatible =3D "qcom,mdp5" },
> +       { }
> +};
> +
> +static int qcom_iommu_def_domain_type(struct device *dev)
> +{
> +       return of_match_device(qcom_iommu_client_of_match, dev) ?
> +               IOMMU_DOMAIN_IDENTITY : 0;
> +}
> +
>  static struct iommu_device *qcom_iommu_probe_device(struct device *dev)
>  {
>         struct qcom_iommu_dev *qcom_iommu =3D dev_iommu_priv_get(dev);
> @@ -602,6 +615,7 @@ static const struct iommu_ops qcom_iommu_ops =3D {
>         .capable        =3D qcom_iommu_capable,
>         .domain_alloc_paging =3D qcom_iommu_domain_alloc_paging,
>         .probe_device   =3D qcom_iommu_probe_device,
> +       .def_domain_type =3D qcom_iommu_def_domain_type,
>         .device_group   =3D generic_device_group,
>         .of_xlate       =3D qcom_iommu_of_xlate,
>         .default_domain_ops =3D &(const struct iommu_domain_ops) {
>
> --
> 2.47.3
>
