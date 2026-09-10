Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B0F4A0924
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789050036; cv=pass; b=az1ggdJUaC/3dcjwJIKaiWw3bhOYRW3ZyebuZwYUe22QrmCFArSMSP3jJWz/MMZ4QOqtzf/3lDW0UDFy8afaRYmFrGf5DcURu8KHNr+qafLCv15LtJaW9fseT7n8xtRhVJsuISajawJ8mwIj/bxyqfuziarYM+u9+WiuRqTOoj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789050036; c=relaxed/simple;
	bh=9QJteI92RwPPdOMUgnNnI7QviKfuZP58/utp5AmqgiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZW0j3N2gUU+HJhAm2U4XG8AcjJcA6Ccuco23jKgCl/Y3beGGEC6BYm2ycmqF4UTeivr1dxBSVaEOd3dwFpvIvq6N6vmS3U6wr+WdJ9AB7DnAb/SJUHuq+226f7dzGHX1a5hKFNdl1YrnyPAYK6okogJnyd94Y9GKm3nwUgAybz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TEl+QYBj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XpU1pppX; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TEl+QYBj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XpU1pppX"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AC7hN81732398
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 14:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LzPgv+JUw7blI/3j2Lv9Lk9a
	WSnQjmSVlk9jgF9EUWw=; b=TEl+QYBjvKr7HpD3M/E1C0inzzxT3wPzMBXyaxhQ
	JS/k2+jCEgSrZI5BXgXVlsRw8NSb9S6vwE+BV6TNPQgVtJ1i/VGUYRW8xvArJpBb
	/FExhwovNJjR603crm8ThBG4bbHouAHtaZpkFVtj6BKT+ii/rzl6nGDYwhdmj4Ps
	/vIW9HOv7ifG3YpVyTiyfvPIMG12n812GMt2C72XhR4SfIJeR1BK0QjC2mRH9q8H
	CX8pRnTA46axH3If96TmEpgPN2r7k4NWxWdZR3TEf1+tKv/S3/XwAl62V2FMl6ZU
	XGM1IaoqCeU7iFyUzmBIrAeE5yMqXRYPbUS/inILFhZTrw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcydma5x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 14:20:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6df0a1e18so143940535ad.1
        for <iommu@lists.linux.dev>; Thu, 10 Sep 2026 07:20:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789050033; cv=none;
        d=google.com; s=arc-20260327;
        b=CEYChVX4AwgLje1KwFF18WMj/eE2VTuTPwWdTM8FAw4XPgCdr8O3/kNK2BhToZ5TkU
         e/tePrCMLndnddHPdTgxq+WAtY5ONLTJf2xx2YSckCR5O2TSeNchA7VpBj+zjQTB/riZ
         SQ65hF7atrfe6H/tmv0Na6A5vYTFbOWOhcFVJq/A3pxtPAAF/2ntOqZ5q0R9MIPJJgz0
         8jyVgsoJ24ZuTg/4yWJA1rPfa9bj2bEZPR0BfrLyhMUsxbvSMjG6OYJFwwCdFsTv2yzD
         Zwq3wfJGL0vFaRXfEUagA42roRvkQWxPNiPvTiLmK+U+HazoMWfu9yYZ30WS3hamR2Gf
         jJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LzPgv+JUw7blI/3j2Lv9Lk9aWSnQjmSVlk9jgF9EUWw=;
        fh=lT4M3sXPPKxT4vfO5D2u4MfU2s2MqOghR7JabuB62+E=;
        b=U7lOK1fCn1VEevP2qgapP0Wjp6ZiBAY+O2BVjJ6lNSXS8ypWc7KavKcXmXhS4Lsts0
         uBLWTqm3azXcBeEno/NJpnOvbtrXEuJqdE0LvSlNwOt7lj7BZ7k8Pve4ev+EUlVnocK5
         7Oex7KwV/Iv4HUHD9oLL6hekCrUIQKyfVe/7pheEmAXEWac2RpNtl2Iw960xEEx9wkrr
         J4dZCEsCeau53agfLmgJBtVdqoqgoN6bg2d9sfmcCII6PxlEFkGz24DIOdgYlDRMOHzQ
         vzUoRyami9cNd94qe/CT+OdTgVNRAh0I+G6ZnOm7sUKukRwqTpaOFzfOo8vbF7qGN8WX
         st8Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789050033; x=1789654833; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LzPgv+JUw7blI/3j2Lv9Lk9aWSnQjmSVlk9jgF9EUWw=;
        b=XpU1pppXgge8P6KuZaVxSes6fg4qangXvPdun7fTqd/1JFt5xLWYLY9SatdlFRcZ8t
         LY2L1/gpE/BebESQqOISvOqFey1QvTV1NXpnEw1O55WjeXuWLQ6jiS8V5NM/rCMtmp0o
         kb1t7ypGl9NRJfwz8pjFiPBVLQA7CM9jEWXD1O9KPnjb4blWb7AW5BHA9z+cKlWAbBQY
         M8G5acf4ofOS897lui8bXew6D140WQPHE1dRRWc8a/KiDxhoI7XwPc6RPG4o5OYA5733
         hvIZpYwk+rAI84iLsjEkL+OeTq2wNzjju9G9CMhOKyoLqHJAo2mgCgtnUIN19RcBSN/3
         HQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789050033; x=1789654833;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LzPgv+JUw7blI/3j2Lv9Lk9aWSnQjmSVlk9jgF9EUWw=;
        b=HCbfEspDYl4/bj4lf7CB7mspdQzDL/QrnamZir2biZom8A1tlORE/v25IRgTBM+Qp0
         2bn+KTUxlt/PjSDBSSspCQb2NeUknDYlJrqKMG3GoyAuDJwtJfayg6uoe2pRpvgHbzne
         v84DpB0da1JQmxYANDSmgRSVI4aSX1enD/H15qZuWe5ydmyovLcrWgSHil6tMpFep95k
         O0Yj4t0TWrjQ9r5s20rtehSkIsLmgNRq+OsJijTtIMcEYn87poKpJKrx52TwsXz5/mvF
         1JhUUFLOKHsyHxlvG6Bsul969YLkZ3LqOtsHSDbfR7FEXjwE6kh/6grYrIsGknIEUjzC
         r3Hw==
X-Forwarded-Encrypted: i=1; AKwUvBxP/1VJcfWZ8lUzKCAXPNq7oUs/FdnQG7vUvW5pkidMcBlPoDOOQpLWRw40N/qFp3bYCPvi5w==@lists.linux.dev
X-Gm-Message-State: AFuF++klkKix0n4xKRTR+ve63ycYnsbsN20LQc35sO5RxSDrlHr2tTQl
	IulykiT+iKXnZ2LoOhMlLKYBraNWEhXu90+rveL817GSfLn8PJ36fbPsWVi7zH8G4oMARo1crXQ
	VlhQrBcEwlbLLHYFXFCBiTZIivSXGba/da2Pa7A/8h4D0fxP6QYd/u8ht8ZmifwOSkTW7SoJ/2P
	qtMAymIT+psOjfW8O1XSWxoF6zISpCx1yk
X-Gm-Gg: AYBFou3BVaqem8wf+lnvT3wGLKp2bwpOGtdNBtW2b/mA3JE//D+Pv7zVEBeZDjJmIM+
	jyL2F+fkTEgXnPWZ+heob0FOIf8YtwKlBArGHPXS14JEK7kKMvrzlyegeoOqq66tZ52ABcNzj6+
	zt13uPLQTncbDh7gL0mWpGiCSbPDBnx5ACRsiPbGmqElIiyRNBGnRzur+9AGkdnmnyKevQRj8=
X-Received: by 2002:a17:903:3d0e:b0:2db:2c09:98ad with SMTP id d9443c01a7336-2db8dc82407mr200795515ad.12.1789050031335;
        Thu, 10 Sep 2026 07:20:31 -0700 (PDT)
X-Received: by 2002:a17:903:3d0e:b0:2db:2c09:98ad with SMTP id
 d9443c01a7336-2db8dc82407mr200793205ad.12.1789050030094; Thu, 10 Sep 2026
 07:20:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260809-msm8974-iommu-upstream-v1-0-87f5cd492560@oss.qualcomm.com>
 <DKL6P7G0WTM7.UJ6KZERQZDFK@fairphone.com> <iv5radfllym2bjvkrdu4ffs25bqixyos7k3ymncpcdtc2uobn2@zlhsybrj3pwz>
 <DKX384NK76OS.3NNOMAH72PV2P@fairphone.com> <ssleznoahzs4wgf5irjiagss2rjwl2s2jjnqrrnlpp74rdkgfs@au6x63ykyjfs>
 <DLBKL8SJL58R.2XQ76X6JILZ8E@fairphone.com>
In-Reply-To: <DLBKL8SJL58R.2XQ76X6JILZ8E@fairphone.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 17:20:18 +0300
X-Gm-Features: AcwNN1VVA4SntoL5ZvQXqShw0ZuVR288fdr4bQQ_lWLwdYYaNA3KoOK8hgJ80N8
Message-ID: <CAO9ioeUEQ+kzBLj3KTv+uayaE-5aw-aL49-0pJ-x_Vwq4nu9JA@mail.gmail.com>
Subject: Re: [PATCH 00/12] iommu: qcom_iommu: implement support for instances
 on MSM8974
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE3MiBTYWx0ZWRfXwXPZfBG/jzm5
 eOZee03Mx0Us9A+4EPPbUOPB2L150ZLz08Yl1eh4z0gTQ3fg7yez0RN+dH+4PmyCK7KcKjDp+q2
 91d8SeYo4Ohi+FWzKvZE4nHHoAdgXzE=
X-Authority-Analysis: v=2.4 cv=UJNIjyfy c=1 sm=1 tr=0 ts=6aa2bcb1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=dlmhaOwlAAAA:8
 a=6H0WHjuAAAAA:8 a=YxQatw1j_ZWosVD_vr4A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=FO4_E8m0qiDe52t0p3_H:22 a=y4cfut4LVr_MrANMpYTh:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: e1ru5g2UekIaQjoNgjWMbdadSYYlBcFn
X-Proofpoint-ORIG-GUID: e1ru5g2UekIaQjoNgjWMbdadSYYlBcFn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE3MiBTYWx0ZWRfX11AYzK/QPPtw
 +MLgKXmqU8K8gACQxc1t4ZWFTWTxqU+CZ1e+Jx/BVLmbT4rbeSVG9YyRH/OEzlBSFziZvwBdPtU
 WWXYaAx5JqlQFkTAA7qL+MgYhqe8lJujFh4JzbgqukD+JFEbVDCy4rKWbt+mK39Q1Ga3jsOSSBa
 Sphcoy7lupC46KG6YPjOfPTR1LzBNxPX0lpAw7o5cuIOKYgPIGU7trU7sdfSsRYIO+M+c6FTC2q
 1cVVvuq1SbL8v+OE8GBBVTGAuIaAbnUdyZWy2PHOStrq3LyvpjdKdt+hjeM2TJzi3w1tJbv5CAI
 w4nxG7+M+A8+oiF5gb8YOnu5HcxwNR6Hub0Ep8KUq3E8/7PoveL08EOliUZDHKqiz1+D8mteUuE
 d7HNciq8LUjQXE5rLPs95BBHqK3ucuK1Xsw+/uJkzswuERVx5sGNifDGVRccd7nGAQlAh+a4wXD
 uqNwylgqnUzeTanagNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100172

On Thu, 10 Sept 2026 at 13:38, Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> Hi Dmitry,
>
> On Tue Sep 8, 2026 at 3:28 PM CEST, Dmitry Baryshkov wrote:
> > On Mon, Aug 24, 2026 at 12:04:57PM +0200, Luca Weiss wrote:
> >> Hi Dmitry,
> >>
> >> On Tue Aug 11, 2026 at 2:43 PM CEST, Dmitry Baryshkov wrote:
> >> > On Mon, Aug 10, 2026 at 12:16:19PM +0200, Luca Weiss wrote:
> >> >> Hi Dmitry,
> >> >>
> >> >> Many thanks for working on this and sending this patch series!
> >> >>
> >> >> On Sun Aug 9, 2026 at 10:15 PM CEST, Dmitry Baryshkov wrote:
> >> >> > Qualcomm MSM8974 platform has five SMMU instances, used by display, GPU,
> >> >> > Venus, VFE (camera) and JPEG encoder. Each of them follows ARM SMMU v1
> >> >> > spec, however they differ from other Qualcomm platforms in the
> >> >> > implementation-specific registers and also in interaction with TZ.
> >> >> > Venus, MDP and VFE SMMUs are secured and require programming only of
> >> >> > CBs, while GPU and JPEG require full programming.
> >> >> >
> >> >> > This series skips IOMMUs which can't be tested right now (VFE and JPEG),
> >> >> > and adds only MDP, GPU and Venus (although untested, it is required for
> >> >> > display to work) SMMU instances.
> >> >>
> >> >> I do have a patch series (sent years ago to the mailing lists as well)
> >> >> for CAMSS so I can definitely test this in the future.
> >> >
> >> > Ok, let's land these first, unless VFE IOMMU blocks display on your
> >> > platform (Venus was blocking display on APQ8074 DragonBoard).
> >> >
> >> >> > Note, to get display to work properly one fix is necessary, [1]
> >> >> >
> >> >> > [1] https://patch.msgid.link/20260809-msm8974-mmcc-fix-v1-1-50f2dcf18d2e@oss.qualcomm.com
> >> >>
> >> >> I've applied this series on v7.2-rc7, with the extra commits between
> >> >> that and linux-next for qcom_iommu.c backported so that your series
> >> >> applies without conflicts.
> >> >>
> >> >> So far I'm stuck with the GPU not being able to probe, adding some
> >> >> printk's shows that in msm_iommu_new() the call for
> >> >> iommu_attach_device() is failing.
> >> >>
> >> >> [    5.971154] msm_mdp fd900100.display-controller: failed to load adreno gpu
> >> >> [    5.972991] msm_mdp fd900100.display-controller: failed to bind fdb00000.gpu (ops a3xx_ops [msm]): -16
> >> >> [    5.974073] msm_mdp fd900100.display-controller: adev bind failed: -16
> >> >> [    5.974152] panel-s6d6fa1 fd922800.dsi.0: error -EBUSY: Failed to attach to DSI host
> >> >> [    5.974230] panel-s6d6fa1 fd922800.dsi.0: probe with driver panel-s6d6fa1 failed with error -16
> >> >
> >> > See the patch [1], it's picked up for 7.3
> >>
> >> I missed replying to you, with this patch the display lights up again!
> >>
> >> Unfortunately the GPU still seems to have issues, I don't have a log
> >> right now (I think even SSH was dropping then with a bunch of log lines
> >> appearing in kernel log on screen). I assume kmscube + more complex
> >> workloads worked fine for you?
> >
> > I was mostly using kmscube, but I can try running the CTS once I get
> > back to it, sorry for the delays.
>
> Yeah, kmscube doesn't even work for me.
>
> Bootup works to a tty with screen on (mdss doesn't seem to have any
> problems for me), but then as soon as I run kmscube the device shows a
> few errors on the tty0 on the screen (USB stops working apparently since
> my "dmesg -w" doesn't show anything) and a few seconds later the device
> reboots.

Interesting. I wonder if it's TZ tripping on the VFE IOMMU.

>
> dmesg: https://public.lucaweiss.eu/tmp/fp2-iommu-dmesg.txt
>
> The SoC in my device should be MSM8974PRO-AA (a.k.a. MSM8974AB-AA).
>
> I know there are some differences for some bits between MSM8974
> (Snapdragon 800) and MSM8974PRO (Snapdragon 801), which variant do you
> have? Maybe that's relevant, also since downstream splits devicetree
> based on 8974 and 8974pro.

Mine is APQ8074, not sure if there were revisions.

-- 
With best wishes
Dmitry
