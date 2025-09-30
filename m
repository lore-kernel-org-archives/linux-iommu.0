Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBC82D7D2F
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759219713; cv=none; b=a6gC3FoU6YNeSn1hNVdkVVUYqwSQNUSN2IwU+Uws3UCbC3+9D36EbF9CLQpz4l+q9XjPSamwlUbb+o7GVJ4bDarGVTyG2g3UwCgSjGWJbNz9fBhloLqfn1p2lh4DGCioF4F2GH5p0gILuAKE6/o1IYDW2s+RH4FizMNx74KKkrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759219713; c=relaxed/simple;
	bh=t/PSaj7/kSLjJpWsSZcEqrGGoZSx/Inwa5cZmbF2yFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnY41k1hloqkZ4J86sUXZQk4Gy0I8F8A4m9QMkLZL+UbmCSnhmNFNo0TnO810TVEFcOdwQmnOzGbJuXmYmjYmkcS2x5tMdj1MI9MdDX65l2cI3fOokEi55IDrAXJHlGOEmoKeEgbxGMUglMlaiIYDTMG/HTCSMQWmX1K7ugBjuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N1qdBNuf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N1qdBNuf"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58U4Hneg011599
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 08:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=tdPcpcAJ/7XDpmuDRfRlI/S+hgyHhmTmislpSVH8GwM=; b=N1
	qdBNufwiDVzEOm1n14Khll9R8w/v904q5xwWnUdHY+iMFph+zQgCzAqee7hpuQ9m
	kiAirEE2mhIbz7I9UbpuRVqzFdUB8o424nexa9uiWbLOM7ctuggeoBtR5tTXAxnn
	/PsUEJn8PaOLYs3yDHh1rY5UgW3KiGdTxFTp/dASNbhRKy+9sN/iX9Cz+5FydWC2
	5QScWuKxWt4HNqNBZUX4Sk3Mr4Gidp551w+dc4bnGpHaDMNG/9neFCcJ0a2dw7uj
	Dc21uMnkc2gvyYLtkzX6BNxB47aM4ldyUSXszsuvlNLH4IMV+n/9zD8vWQ6WF44w
	T5/cqXdOFetyW8XPG0fg==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e5mcre05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 08:08:26 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-75a0c7b8005so8415098a34.0
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 01:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759219703; x=1759824503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tdPcpcAJ/7XDpmuDRfRlI/S+hgyHhmTmislpSVH8GwM=;
        b=BkSzRTbvx6J4B788XyuZ1pSdSF/P2IV8xMFJYSCb08cpe6PvkJ1WrL+jH9LRuEnAOS
         6BeuHrLQ+YfGf/f3pHsOaV2HiGfj4STM8IKy/BGdcBDFzd0F+gcOyNUzvEZ7Xq87HW+0
         rugqjfrKlWkR6Hhsnz4jTykPI4M7rqQar6rAKAsCA7a4dXv0pF/fA6TRM5Ftvq3PG+Zf
         /MaGknyEPGFQHCvtuXuVxzMjjKW5U20oCIsjnvbWYKHvQpSObY01wFc+791o6XCs6hKK
         urnTlXJNRHaVDHJRWoOskYyPJiEbxWNMMoZsc9py8OZKkImRsga6TrZ4tVDdYQgP4pnW
         0QsA==
X-Forwarded-Encrypted: i=1; AJvYcCVHGHHHmwunFjc0doC9H8PKpeGnVx3YtyXAPL9o31eW5xadnfCUb3Y+m8Vb2LpnY5iCtgwCSw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5MlXoM+X8nfsfIjzDyw2e+hopHfhp1sNs43acic8XCf3fs1Di
	GQlasE83GIrTLFnh02Lq4P0lV8uAzHCUPHTRiV6aDx4+uB0ytS7QeG5bD+wD3r3pJ+Dn8GuX84p
	f+HD5lhlSRsQENoQhTwyb64zXzo1ernx+Z/6A8jVoDqB/2axDrV6hK/o7VQKkPdD1i5+ts+E7bZ
	HtHxOplKM4N40ZkA1YlBYEE7EE5HmfHB7S
X-Gm-Gg: ASbGncuVriBCEO/kItdnUjkKWRkF8ERw82VijaZprqJus77mNaEAiT3tHpRcOYgcdAr
	qHLa96cXyIyMCQHG+IKAmYlPkM1L2w95xBhs5PDmZS2JSZ44onUZxmLlRkwcR19GsoRVBUaKBQO
	kDiWP7gb4Ly71NgNYVDTa1MiC4r+mlEBXqBQQYZwqAbdJRKrJhL+bikLw=
X-Received: by 2002:a05:6808:1a28:b0:43b:5101:4f11 with SMTP id 5614622812f47-43f93fc1e78mr1860075b6e.9.1759219702822;
        Tue, 30 Sep 2025 01:08:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcoEmRdWRcD570gTS4wPgVGpk7oyq939HgjsA8bixWbXV7rwUu71ZOf7cJVGAnkOtdD9wcOHxun3thoKqbhnc=
X-Received: by 2002:a05:6808:1a28:b0:43b:5101:4f11 with SMTP id
 5614622812f47-43f93fc1e78mr1860036b6e.9.1759219702086; Tue, 30 Sep 2025
 01:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250930-kaana-gpu-support-v1-0-73530b0700ed@oss.qualcomm.com>
 <20250930-kaana-gpu-support-v1-12-73530b0700ed@oss.qualcomm.com> <ks3ppjsy35wka2at5nxrr74l5mvzr4l6ovm5ncohanu2gn3ytl@gt2mzwjehq73>
In-Reply-To: <ks3ppjsy35wka2at5nxrr74l5mvzr4l6ovm5ncohanu2gn3ytl@gt2mzwjehq73>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 01:08:10 -0700
X-Gm-Features: AS18NWCsh4S2MZXUcSJHYdZHGSXjKtcQjqoeMmepSAf77ciOOrg3D6uWf3QbvqE
Message-ID: <CACSVV00AFEJVti7BryA-_sosmBKCuDtX7+NEi4aL4X98AqR1Qg@mail.gmail.com>
Subject: Re: [PATCH 12/17] drm/msm/adreno: Introduce A8x GPU Support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=RMC+3oi+ c=1 sm=1 tr=0 ts=68db8ffa cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=5vtyHJrLNaRNZaWRzd4A:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: -MFdiYjsUIj_eaqYKlyY6Pi_3Sly4wMp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwNCBTYWx0ZWRfX5zduKwyyv7UZ
 /HmSvhW/BG41oKWY5kBpIJSFqmhGM6FtKM460y6NZ1TXytU3APA0PhIcP8mS4f5LDFv1fE3r3c2
 9MzWjm3LS0nyO5pjx8oAnLMhcURux0H9id3+cThg5OhlucUEZbVrWI5vzzTW9HduFWOib0fVZGH
 SdbUdM8s1aUVwI7wuQqzhp5nZacAlZEo7PMpIdBrMftiysATWQoWrxzikVq/PzWt6ernb7AlNhS
 0w3GZcHFxs4f16qWT1A5ICHf98TTZk89Jq37hwHjIt4LVVE75Tn35rVShP2VR7Wp15NjO7YgIOQ
 KwNDyxs3Z7YxRpjaNRdAKoS9QOZn1Ux+hk3NtAGttAQE5bbOWZ1tz/cjS50P6UIjSwO8wIDmMIb
 eiRjmkOxrFXklEpW0jHF/ZLgGNMqKQ==
X-Proofpoint-GUID: -MFdiYjsUIj_eaqYKlyY6Pi_3Sly4wMp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270004

On Tue, Sep 30, 2025 at 12:43=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, Sep 30, 2025 at 11:18:17AM +0530, Akhil P Oommen wrote:
> > A8x is the next generation of Adreno GPUs, featuring a significant
> > hardware design change. A major update to the design is the introductio=
n
> > of Slice architecture. Slices are sort of mini-GPUs within the GPU whic=
h
> > are more independent in processing Graphics and compute workloads. Also=
,
> > in addition to the BV and BR pipe we saw in A7x, CP has more concurrenc=
y
> > with additional pipes.
> >
> > From a software interface perspective, these changes have a significant
> > impact on the KMD side. First, the GPU register space has been extensiv=
ely
> > reorganized. Second, to avoid  a register space explosion caused by the
> > new slice architecture and additional pipes, many registers are now
> > virtualized, instead of duplicated as in A7x. KMD must configure an
> > aperture register with the appropriate slice and pipe ID before accessi=
ng
> > these virtualized registers.
> >
> > This patch adds only a skeleton support for the A8x family. An A8x GPU
> > support will be added in an upcoming patch.
>
> Consider this lands in a commit message. What would it mean in the Git
> history?
>
> >
> > Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> > ---
> >  drivers/gpu/drm/msm/Makefile                      |    1 +
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.c             |  103 +-
> >  drivers/gpu/drm/msm/adreno/a6xx_gpu.h             |   21 +
> >  drivers/gpu/drm/msm/adreno/a8xx_gpu.c             | 1238 +++++++++++++=
++++++++
> >  drivers/gpu/drm/msm/adreno/adreno_gpu.h           |    7 +
> >  drivers/gpu/drm/msm/registers/adreno/a6xx.xml     |    1 -
> >  drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml |    1 +
> >  7 files changed, 1344 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefil=
e
> > index 7acf2cc13cd047eb7f5b3f14e1a42a1cc145e087..8aa7d07303fb0cd66869767=
cb6298b38a621b366 100644
> > --- a/drivers/gpu/drm/msm/Makefile
> > +++ b/drivers/gpu/drm/msm/Makefile
> > @@ -24,6 +24,7 @@ adreno-y :=3D \
> >       adreno/a6xx_gmu.o \
> >       adreno/a6xx_hfi.o \
> >       adreno/a6xx_preempt.o \
> > +     adreno/a8xx_gpu.o \
> >
> >  adreno-$(CONFIG_DEBUG_FS) +=3D adreno/a5xx_debugfs.o \
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/ms=
m/adreno/a6xx_gpu.c
> > index bd4f98b5457356c5454d0316e59d7e8253401712..4aeeaceb1fb30a9d68ac636=
c14249e3853ef73ac 100644
> > --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> > @@ -239,14 +239,21 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a=
6xx_gpu,
> >       }
> >
> >       if (!sysprof) {
> > -             if (!adreno_is_a7xx(adreno_gpu)) {
> > +             if (!(adreno_is_a7xx(adreno_gpu) || adreno_is_a8xx(adreno=
_gpu))) {
>
> Here and in several other similar places:
>
>                 if (!adreno_is_a7xx(adreno_gpu) &&
>                     !adreno_is_a8xx(adreno_gpu))) {
>
> >                       /* Turn off protected mode to write to special re=
gisters */
> >                       OUT_PKT7(ring, CP_SET_PROTECTED_MODE, 1);
> >                       OUT_RING(ring, 0);
> >               }
> >
> > -             OUT_PKT4(ring, REG_A6XX_RBBM_PERFCTR_SRAM_INIT_CMD, 1);
> > -             OUT_RING(ring, 1);
> > +             if (adreno_is_a8xx(adreno_gpu)) {
> > +                     OUT_PKT4(ring, REG_A8XX_RBBM_PERFCTR_SRAM_INIT_CM=
D, 1);
> > +                     OUT_RING(ring, 1);
> > +                     OUT_PKT4(ring, REG_A8XX_RBBM_SLICE_PERFCTR_SRAM_I=
NIT_CMD, 1);
> > +                     OUT_RING(ring, 1);
> > +             } else {
> > +                     OUT_PKT4(ring, REG_A6XX_RBBM_PERFCTR_SRAM_INIT_CM=
D, 1);
> > +                     OUT_RING(ring, 1);
> > +             }
> >       }
> >
> >       /* Execute the table update */
> > @@ -275,7 +282,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6x=
x_gpu,
> >        * to make sure BV doesn't race ahead while BR is still switching
> >        * pagetables.
> >        */
> > -     if (adreno_is_a7xx(&a6xx_gpu->base)) {
> > +     if (adreno_is_a7xx(&a6xx_gpu->base) && adreno_is_a8xx(&a6xx_gpu->=
base)) {
> >               OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
> >               OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_=
THREAD_BR);
> >       }
> > @@ -289,20 +296,22 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a=
6xx_gpu,
> >       OUT_RING(ring, CACHE_INVALIDATE);
> >
> >       if (!sysprof) {
> > +             u32 reg_status =3D adreno_is_a8xx(adreno_gpu) ?
> > +                     REG_A8XX_RBBM_PERFCTR_SRAM_INIT_STATUS :
> > +                     REG_A6XX_RBBM_PERFCTR_SRAM_INIT_STATUS;
> >               /*
> >                * Wait for SRAM clear after the pgtable update, so the
> >                * two can happen in parallel:
> >                */
> >               OUT_PKT7(ring, CP_WAIT_REG_MEM, 6);
> >               OUT_RING(ring, CP_WAIT_REG_MEM_0_FUNCTION(WRITE_EQ));
> > -             OUT_RING(ring, CP_WAIT_REG_MEM_POLL_ADDR_LO(
> > -                             REG_A6XX_RBBM_PERFCTR_SRAM_INIT_STATUS));
> > +             OUT_RING(ring, CP_WAIT_REG_MEM_POLL_ADDR_LO(reg_status));
> >               OUT_RING(ring, CP_WAIT_REG_MEM_POLL_ADDR_HI(0));
> >               OUT_RING(ring, CP_WAIT_REG_MEM_3_REF(0x1));
> >               OUT_RING(ring, CP_WAIT_REG_MEM_4_MASK(0x1));
> >               OUT_RING(ring, CP_WAIT_REG_MEM_5_DELAY_LOOP_CYCLES(0));
> >
> > -             if (!adreno_is_a7xx(adreno_gpu)) {
> > +             if (!(adreno_is_a7xx(adreno_gpu) || adreno_is_a8xx(adreno=
_gpu))) {
> >                       /* Re-enable protected mode: */
> >                       OUT_PKT7(ring, CP_SET_PROTECTED_MODE, 1);
> >                       OUT_RING(ring, 1);
> > @@ -441,6 +450,7 @@ static void a7xx_submit(struct msm_gpu *gpu, struct=
 msm_gem_submit *submit)
> >       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> >       struct msm_ringbuffer *ring =3D submit->ring;
> >       unsigned int i, ibs =3D 0;
> > +     u32 rbbm_perfctr_cp0, cp_always_on_counter;
> >
> >       adreno_check_and_reenable_stall(adreno_gpu);
> >
> > @@ -460,10 +470,16 @@ static void a7xx_submit(struct msm_gpu *gpu, stru=
ct msm_gem_submit *submit)
> >       if (gpu->nr_rings > 1)
> >               a6xx_emit_set_pseudo_reg(ring, a6xx_gpu, submit->queue);
> >
> > -     get_stats_counter(ring, REG_A7XX_RBBM_PERFCTR_CP(0),
> > -             rbmemptr_stats(ring, index, cpcycles_start));
> > -     get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_COUNTER,
> > -             rbmemptr_stats(ring, index, alwayson_start));
> > +     if (adreno_is_a8xx(adreno_gpu)) {
> > +             rbbm_perfctr_cp0 =3D REG_A8XX_RBBM_PERFCTR_CP(0);
> > +             cp_always_on_counter =3D REG_A8XX_CP_ALWAYS_ON_COUNTER;
> > +     } else {
> > +             rbbm_perfctr_cp0 =3D REG_A7XX_RBBM_PERFCTR_CP(0);
> > +             cp_always_on_counter =3D REG_A6XX_CP_ALWAYS_ON_COUNTER;
> > +     }
> > +
> > +     get_stats_counter(ring, rbbm_perfctr_cp0, rbmemptr_stats(ring, in=
dex, cpcycles_start));
> > +     get_stats_counter(ring, cp_always_on_counter, rbmemptr_stats(ring=
, index, alwayson_start));
> >
> >       OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
> >       OUT_RING(ring, CP_SET_THREAD_BOTH);
> > @@ -510,10 +526,8 @@ static void a7xx_submit(struct msm_gpu *gpu, struc=
t msm_gem_submit *submit)
> >               OUT_RING(ring, 0x00e); /* IB1LIST end */
> >       }
> >
> > -     get_stats_counter(ring, REG_A7XX_RBBM_PERFCTR_CP(0),
> > -             rbmemptr_stats(ring, index, cpcycles_end));
> > -     get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_COUNTER,
> > -             rbmemptr_stats(ring, index, alwayson_end));
> > +     get_stats_counter(ring, rbbm_perfctr_cp0, rbmemptr_stats(ring, in=
dex, cpcycles_end));
> > +     get_stats_counter(ring, cp_always_on_counter, rbmemptr_stats(ring=
, index, alwayson_end));
> >
> >       /* Write the fence to the scratch register */
> >       OUT_PKT4(ring, REG_A6XX_CP_SCRATCH(2), 1);
> > @@ -706,8 +720,11 @@ static int a6xx_calc_ubwc_config(struct adreno_gpu=
 *gpu)
> >       /* Copy the data into the internal struct to drop the const quali=
fier (temporarily) */
> >       *cfg =3D *common_cfg;
> >
> > -     cfg->ubwc_swizzle =3D 0x6;
> > -     cfg->highest_bank_bit =3D 15;
> > +     /* Use common config as is for A8x */
> > +     if (!adreno_is_a8xx(gpu)) {
> > +             cfg->ubwc_swizzle =3D 0x6;
> > +             cfg->highest_bank_bit =3D 15;
> > +     }
> >
> >       if (adreno_is_a610(gpu)) {
> >               cfg->highest_bank_bit =3D 13;
> > @@ -818,7 +835,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gp=
u)
> >                 cfg->macrotile_mode);
> >  }
> >
> > -static void a7xx_patch_pwrup_reglist(struct msm_gpu *gpu)
> > +void a7xx_patch_pwrup_reglist(struct msm_gpu *gpu)
> >  {
> >       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> >       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> > @@ -868,7 +885,7 @@ static void a7xx_patch_pwrup_reglist(struct msm_gpu=
 *gpu)
> >       lock->dynamic_list_len =3D 0;
> >  }
> >
> > -static int a7xx_preempt_start(struct msm_gpu *gpu)
> > +int a7xx_preempt_start(struct msm_gpu *gpu)
> >  {
> >       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> >       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> > @@ -925,7 +942,7 @@ static int a6xx_cp_init(struct msm_gpu *gpu)
> >       return a6xx_idle(gpu, ring) ? 0 : -EINVAL;
> >  }
> >
> > -static int a7xx_cp_init(struct msm_gpu *gpu)
> > +int a7xx_cp_init(struct msm_gpu *gpu)
> >  {
> >       struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> >       struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> > @@ -993,7 +1010,7 @@ static bool a6xx_ucode_check_version(struct a6xx_g=
pu *a6xx_gpu,
> >               return false;
> >
> >       /* A7xx is safe! */
> > -     if (adreno_is_a7xx(adreno_gpu) || adreno_is_a702(adreno_gpu))
> > +     if (adreno_is_a7xx(adreno_gpu) || adreno_is_a702(adreno_gpu) || a=
dreno_is_a8xx(adreno_gpu))
> >               return true;
> >
> >       /*
> > @@ -2161,7 +2178,7 @@ void a6xx_bus_clear_pending_transactions(struct a=
dreno_gpu *adreno_gpu, bool gx_
> >  void a6xx_gpu_sw_reset(struct msm_gpu *gpu, bool assert)
> >  {
> >       /* 11nm chips (e.g. ones with A610) have hw issues with the reset=
 line! */
> > -     if (adreno_is_a610(to_adreno_gpu(gpu)))
> > +     if (adreno_is_a610(to_adreno_gpu(gpu)) || adreno_is_a8xx(to_adren=
o_gpu(gpu)))
> >               return;
> >
> >       gpu_write(gpu, REG_A6XX_RBBM_SW_RESET_CMD, assert);
> > @@ -2192,7 +2209,12 @@ static int a6xx_gmu_pm_resume(struct msm_gpu *gp=
u)
> >
> >       msm_devfreq_resume(gpu);
> >
> > -     adreno_is_a7xx(adreno_gpu) ? a7xx_llc_activate(a6xx_gpu) : a6xx_l=
lc_activate(a6xx_gpu);
> > +     if (adreno_is_a8xx(adreno_gpu))
> > +             a8xx_llc_activate(a6xx_gpu);
> > +     else if (adreno_is_a7xx(adreno_gpu))
> > +             a7xx_llc_activate(a6xx_gpu);
> > +     else
> > +             a6xx_llc_activate(a6xx_gpu);
> >
> >       return ret;
> >  }
> > @@ -2561,10 +2583,8 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_=
device *dev)
> >       adreno_gpu->base.hw_apriv =3D
> >               !!(config->info->quirks & ADRENO_QUIRK_HAS_HW_APRIV);
> >
> > -     /* gpu->info only gets assigned in adreno_gpu_init() */
> > -     is_a7xx =3D config->info->family =3D=3D ADRENO_7XX_GEN1 ||
> > -               config->info->family =3D=3D ADRENO_7XX_GEN2 ||
> > -               config->info->family =3D=3D ADRENO_7XX_GEN3;
> > +     /* gpu->info only gets assigned in adreno_gpu_init(). A8x is incl=
uded intentionally */
> > +     is_a7xx =3D config->info->family >=3D ADRENO_7XX_GEN1;
>
> Is A8xx also a part of is_a7xx? What about the A9XX which will come at
> some point in future?
>
> >
> >       a6xx_llc_slices_init(pdev, a6xx_gpu, is_a7xx);
> >
> > +
> > +int a8xx_gpu_feature_probe(struct msm_gpu *gpu)
> > +{
> > +     struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> > +     struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> > +     u32 fuse_val;
> > +     int ret;
> > +
> > +     /*
> > +      * Assume that if qcom scm isn't available, that whatever
> > +      * replacement allows writing the fuse register ourselves.
> > +      * Users of alternative firmware need to make sure this
> > +      * register is writeable or indicate that it's not somehow.
> > +      * Print a warning because if you mess this up you're about to
> > +      * crash horribly.
> > +      */
> > +     if (!qcom_scm_is_available()) {
>
> How can it be not available here?
>
> > +             dev_warn_once(gpu->dev->dev,
> > +                     "SCM is not available, poking fuse register\n");
> > +             a6xx_llc_write(a6xx_gpu, REG_A7XX_CX_MISC_SW_FUSE_VALUE,
> > +                     A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING |
> > +                     A7XX_CX_MISC_SW_FUSE_VALUE_FASTBLEND |
> > +                     A7XX_CX_MISC_SW_FUSE_VALUE_LPAC);
> > +             adreno_gpu->has_ray_tracing =3D true;
> > +             return 0;
> > +     }
> > +
> > +     ret =3D qcom_scm_gpu_init_regs(QCOM_SCM_GPU_ALWAYS_EN_REQ |
> > +                                  QCOM_SCM_GPU_TSENSE_EN_REQ);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /*
> > +      * On a750 raytracing may be disabled by the firmware, find out
>
> It's a8xx-related code, why do you have a750 in the comment?

This is actually related to >=3D a750..  from a brief look it seems like
the whole fuse thing can be split into a helper and shared btwn
a7xx/a8xx?

BR,
-R

> > +      * whether that's the case. The scm call above sets the fuse
> > +      * register.
> > +      */
> > +     fuse_val =3D a6xx_llc_read(a6xx_gpu,
> > +                              REG_A7XX_CX_MISC_SW_FUSE_VALUE);
> > +     adreno_gpu->has_ray_tracing =3D
> > +             !!(fuse_val & A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING);
> > +
> > +     return 0;
> > +}
> > +
> > +
> > +#define GBIF_CLIENT_HALT_MASK                BIT(0)
> > +#define GBIF_ARB_HALT_MASK           BIT(1)
> > +#define VBIF_XIN_HALT_CTRL0_MASK     GENMASK(3, 0)
> > +#define VBIF_RESET_ACK_MASK          0xF0
> > +#define GPR0_GBIF_HALT_REQUEST               0x1E0
> > +
> > +void a8xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu=
, bool gx_off)
> > +{
> > +     struct msm_gpu *gpu =3D &adreno_gpu->base;
> > +
> > +     if (gx_off) {
> > +             /* Halt the gx side of GBIF */
> > +             gpu_write(gpu, REG_A8XX_RBBM_GBIF_HALT, 1);
> > +             spin_until(gpu_read(gpu, REG_A8XX_RBBM_GBIF_HALT_ACK) & 1=
);
> > +     }
> > +
> > +     /* Halt new client requests on GBIF */
> > +     gpu_write(gpu, REG_A6XX_GBIF_HALT, GBIF_CLIENT_HALT_MASK);
> > +     spin_until((gpu_read(gpu, REG_A6XX_GBIF_HALT_ACK) &
> > +                     (GBIF_CLIENT_HALT_MASK)) =3D=3D GBIF_CLIENT_HALT_=
MASK);
> > +
> > +     /* Halt all AXI requests on GBIF */
> > +     gpu_write(gpu, REG_A6XX_GBIF_HALT, GBIF_ARB_HALT_MASK);
> > +     spin_until((gpu_read(gpu,  REG_A6XX_GBIF_HALT_ACK) &
> > +                     (GBIF_ARB_HALT_MASK)) =3D=3D GBIF_ARB_HALT_MASK);
> > +
> > +     /* The GBIF halt needs to be explicitly cleared */
> > +     gpu_write(gpu, REG_A6XX_GBIF_HALT, 0x0);
> > +}
> > +
> > +int a8xx_gmu_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
> > +{
> > +     struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> > +     struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> > +
> > +     mutex_lock(&a6xx_gpu->gmu.lock);
> > +
> > +     /* Force the GPU power on so we can read this register */
> > +     a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
> > +
> > +     *value =3D gpu_read64(gpu, REG_A8XX_CP_ALWAYS_ON_COUNTER);
> > +
> > +     a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
> > +
> > +     mutex_unlock(&a6xx_gpu->gmu.lock);
> > +
> > +     return 0;
> > +}
> > +
> > +u64 a8xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
> > +{
> > +     struct adreno_gpu *adreno_gpu =3D to_adreno_gpu(gpu);
> > +     struct a6xx_gpu *a6xx_gpu =3D to_a6xx_gpu(adreno_gpu);
> > +     u64 busy_cycles;
> > +
> > +     /* 19.2MHz */
> > +     *out_sample_rate =3D 19200000;
> > +
> > +     busy_cycles =3D gmu_read64(&a6xx_gpu->gmu,
> > +                     REG_A8XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_0_L,
> > +                     REG_A8XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_0_H);
> > +
> > +     return busy_cycles;
> > +}
> > +
> > +bool a8xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
> > +{
> > +     return true;
> > +}
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/=
msm/adreno/adreno_gpu.h
> > index 9831401c3bc865b803c2f9759d5e2ffcd79d19f8..6a2157f31122ba0c2f2a700=
5c98e3e4f1ada6acc 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
> > @@ -90,6 +90,13 @@ struct adreno_reglist {
> >       u32 value;
> >  };
> >
> > +/* Reglist with pipe information */
> > +struct adreno_reglist_pipe {
> > +     u32 offset;
> > +     u32 value;
> > +     u32 pipe;
> > +};
> > +
> >  struct adreno_speedbin {
> >       uint16_t fuse;
> >       uint16_t speedbin;
> > diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml b/drivers/gp=
u/drm/msm/registers/adreno/a6xx.xml
> > index ddde2e03b748f447b5e57571e2b04c68f8f2efc2..c3a202c8dce65d414c89bf7=
6f1cb458b206b4eca 100644
> > --- a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
> > +++ b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
> > @@ -4876,7 +4876,6 @@ by a particular renderpass/blit.
> >  <domain name=3D"A6XX_CX_MISC" width=3D"32" prefix=3D"variant" varset=
=3D"chip">
> >       <reg32 offset=3D"0x0001" name=3D"SYSTEM_CACHE_CNTL_0"/>
> >       <reg32 offset=3D"0x0002" name=3D"SYSTEM_CACHE_CNTL_1"/>
> > -     <reg32 offset=3D"0x0087" name=3D"SLICE_ENABLE_FINAL" variants=3D"=
A8XX-"/>
>
> Why?
>
> >       <reg32 offset=3D"0x0039" name=3D"CX_MISC_TCM_RET_CNTL" variants=
=3D"A7XX-"/>
> >       <reg32 offset=3D"0x0087" name=3D"CX_MISC_SLICE_ENABLE_FINAL" vari=
ants=3D"A8XX"/>
> >       <reg32 offset=3D"0x0400" name=3D"CX_MISC_SW_FUSE_VALUE" variants=
=3D"A7XX-">
> > diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml b/driver=
s/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
> > index 5dce7934056dd6472c368309b4894f0ed4a4d960..c4e00b1263cda65dce89c2f=
16860e5bf6f1c6244 100644
> > --- a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
> > +++ b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
> > @@ -60,6 +60,7 @@ xsi:schemaLocation=3D"https://gitlab.freedesktop.org/=
freedreno/ rules-fd.xsd">
> >       <reg32 offset=3D"0x1f400" name=3D"GMU_ICACHE_CONFIG"/>
> >       <reg32 offset=3D"0x1f401" name=3D"GMU_DCACHE_CONFIG"/>
> >       <reg32 offset=3D"0x1f40f" name=3D"GMU_SYS_BUS_CONFIG"/>
> > +     <reg32 offset=3D"0x1f50b" name=3D"GMU_MRC_GBIF_QOS_CTRL"/>
> >       <reg32 offset=3D"0x1f800" name=3D"GMU_CM3_SYSRESET"/>
> >       <reg32 offset=3D"0x1f801" name=3D"GMU_CM3_BOOT_CONFIG"/>
> >       <reg32 offset=3D"0x1f81a" name=3D"GMU_CM3_FW_BUSY"/>
> >
> > --
> > 2.51.0
> >
>
> --
> With best wishes
> Dmitry
