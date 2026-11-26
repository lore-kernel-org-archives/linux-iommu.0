Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795692796;
	b=B6mTDKAiMZn+URAhQ5595+YrAVSuS/Ob1OIa4dGxhlCRMgWqKsghndWVQ1z6Y4J0T9Ci
	 Q8O1OcpGX1RtCVelbWBWof1W2xcd70LBBNOxwPvMgeAdj4EqUfbZCLj4xz+WwMwxIq8jW
	 YE0SUhnwsXLTDFJVwHm2YqbaJUBZgXhtwBMqmiEi6lgdI7afvlT88gJkXWGsoLpJytwD9
	 UVPUkFDJ8/U8w6BZ1M8U2v0l8V1eviqr1jOcIfhodtLWnnEeDZutCwrdfi1M6RepuyOUX
	 p7erEJlms0WJfD/qYDga+M2ZbKrk01OrSJx2mgktYA/or8ofE8w3S9t74yeWbmIAUXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795692796;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yzojCckQ+xllk0Py6ZM8C/6T/sfzNuCOCrHEJWMWxtE=;
	b=VCpgpZ/BUlaq+H7PAiRGxhrqiZYvaQayVe4tQwdMEe+xqJNaccKF8OURcp9J4a7oxKk/
	 NlbCtdIBBDLhO2hGfZRjAYU+wznb8xAkk25aVzwqKkbMUU7htHeqk5pi/ghVv5hxC4ANZ
	 DFxxqqmjnFW1Y/GeYqMrsr+P8GFVXut80RMJBNxWEiDqs9YAY5qtnYU/T36rYhqhjvUIR
	 bveqWY5U8r2cAhRlTcJe/nZO0V9EH47DntdFdUUqwX3JiAheOBiYgasdzA9fiWCcP5hBV
	 WRcclpLrFLMC/oHjkjw5rLDnUentKTm1OJKAHhQClN2eWoSZMvXjDftLxOS2YOfNfyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PqVJGybq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DjNfKqyE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BC7606A323
	for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 11:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6BC7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PqVJGybq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DjNfKqyE
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQBVZKq1497145
	for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 11:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yzojCckQ+xllk0Py6ZM8C/6T/sfzNuCOCrHEJWMWxtE=; b=PqVJGybqKLFI6hDt
	VO4m5YKjtmV1AzjsX3B1Zbr9cjc5CS7Ow6DYPvnEVAzENBwwDXshzJQOcnhxuN/C
	KzwV50fP+KHiMsjc/KnSV2EupXcI1r2Ny+HFyPGaFUo5/EQOKfaU+Ks0E8Otugnv
	GOoz8Dx9RJ3u3yRwwJkuDKjRL5RK8FIo6hRq9kEVWl0OdbPl/fZZn6IfAepdbGry
	6X0s78HPuoUn04bPTlUTfXlgKCJJEKhC8MAzEAPn+PYva0FkeXZw2UjIxkapLyGD
	k7Vl/+z4d/VZdCKoU8GKPUlKQIG6vBI3jx4phqEcC8yATegHOf+X3Ogax/ckd1w/
	aS1L1Q==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j662y2vd8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 11:33:14 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3b0a7cbf164so5712533a91.3
        for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 03:33:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795692794; cv=none;
        d=google.com; s=arc-20260327;
        b=IkCE31pFb+LvCs3cMpVDDn/BGEkndxxodTGlqQl/Z5yhEt0tpL2RTH7FoaJ8Ho15n4
         3UUxx1yLu9IakWkGzodMwPbwbhSwzq+VfsNx/SawUjwW1tEmXuB1SXXooxOl0BuS6HxY
         jT5nryheiO+2yuknPc29GddRHJ4+6nGeqrtcDk1scvZmlfiJwIrE2FYDIcpPoAyoWnrP
         BhVGOMOGFwD89F9vBufR1XBvsP3hruuJwKqcGC07CR1VFlzTDv5wWBPMdlrZ2AWjxyad
         yDw/fxIrSePDpBQMEb2p2epXYpmDPdOW9jAyIxEYPUM7LJtN4A+4zVZEHm8l+kZTn/0K
         Y0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yzojCckQ+xllk0Py6ZM8C/6T/sfzNuCOCrHEJWMWxtE=;
        fh=ATtFr9z/IbTPhg3jceWF2WKER28nqoYi96kH6XcrUXs=;
        b=BC+HYLOA1dcsVzAc4lxkJwi8k604DcXfh8wE4spPOXxdkjnMCa9u3vjsnyTRUzUS0F
         FeZpibQvFhidPzxlHzDjP4ZqHJQQEtCxFoN4M/imtcal4uCGG6tf+U76q5FNPw+WrDDo
         XwM+z7Q2wf3myB6ZJgJTSflL3//ONoMjYcAysx6Sbs52wefbOUR+PdrdDd132TRXjAnC
         YaQ8iunc2YfEHqzzqONMZsC27LgUfryZ+M/GP5qxhLslEXrm9ckqQHvnh5ryVXMdtbWh
         mhCSAAYpKKnCSxtu66Am7Cjcx7Bcq/ntA/8sy5A9VgDjtlTg05NRdI+d1OYhJqJv2F+R
         jwnQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795692794; x=1796297594; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yzojCckQ+xllk0Py6ZM8C/6T/sfzNuCOCrHEJWMWxtE=;
        b=DjNfKqyE3j2pM3Fbu57FKnR3disCbM3eqZd4ON34sqg8k3pf6UlgVpDXHEKxCGgguV
         bLS5YlA0S/Cpqswr/my0QqJODoB0kj8JVE9U/WJe2WjR5mUG1C0wUKIfne8mn4cpX77h
         VEP3Za7a3g8YkvNEEye65W4ATLkIQ3eG3nfYeArrhUaDv7SsTvHfIqtBy6J3710GW/98
         u5vX8EApB4fIRFJSPdSZf0G3q+v23XliKK+tEGwAycNhA3y+MhQ3XgkrzKurPXVLK2OZ
         QGv5d51NidGZUOLDmbN9cf6dS/nar0px/TH8Kho3Aa4daG1l7ooIyp+/GAiR3PEgtRLp
         3QrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795692794; x=1796297594;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yzojCckQ+xllk0Py6ZM8C/6T/sfzNuCOCrHEJWMWxtE=;
        b=kZfXzRmm+gT8FkyD+qX9EdXNJ/Be5ZIQ9SNnmPijpMnBs1Mjvr5IMQpWAxKJARWzle
         nQiMHHUWCQKWAneydCEJ7vu0Kyosu0WZZp1WBCJbl3GZ0QyyGAZptKXMWCbgR0oHLKDC
         3tsgnuqJ5iK0ApDTN9Ze0JGN3z2yIQ0CNpLfPeuUCWcydoaD5vEVRMQHh6xBw9l1lUGg
         b+tXpkaR3H+nUfbvmJLdEcxRsiHKQ/Sg+g5vF45aiEaCCuuBiFZNvvc+8Z48AUh16Mkc
         3wkPOteUGArnR3xI6yx7gs9g0jStvtq74vwf6lQSTsuMod36GsWtlgux4XCzctZIbJy8
         BU6g==
X-Forwarded-Encrypted: i=1; AL+hErG/zdPBetAodOBmxzfSxMDbhaXbH5EDaYe4y21pou3RvBX1AjIJQyoHa5dmjmlQSS+yUSFZwA==@lists.linux.dev
X-Gm-Message-State: APuU4Z93CquY8Xvrb+YaYYKTNKem5Dq1Va5wpxhHCaLgxAB98a8Jqymv
	/ErcbAunVaikQr+5E5BVh57Vl1aZlCnJbAEEdw7SDubd+pSXDko42AyAYe7M9LeQItaCOklISRI
	gIgVRbS0JV500QN+5eD64a43HMsWGNcB6k9F0lYZgWFQvYqcZRG+oaCALdiAVcNTvr5kzmAfxov
	G+f+tWSHjFfpHy3zitrtCLzuQkZQdjLfQ3
X-Gm-Gg: AZFdTZcCSa8H2JjT3Qkij2N2LHlsGNWH/7T1QhE+rTiabBgb2sxeC4vuWvnpHNQDrW4
	JK7wK9qCuacZtMm/S9l4GCVzCqQUz41MO9FGYZowKkWI+lhn2IbCs5pQr6dw19Vgd18NwoLE1R9
	fJv21sjicrR+aqk2T3VaxqIxYc+0jJMLr6mZrH+Rmaeqrv1hEu/Dfg0cs3Vg==
X-Received: by 2002:a17:90b:5287:b0:3b4:d22:8601 with SMTP id 98e67ed59e1d1-3b41c8fa9c8mr18812574a91.23.1795692794049;
        Thu, 26 Nov 2026 03:33:14 -0800 (PST)
X-Received: by 2002:a17:90b:5287:b0:3b4:d22:8601 with SMTP id
 98e67ed59e1d1-3b41c8fa9c8mr18812543a91.23.1795692793515; Thu, 26 Nov 2026
 03:33:13 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <13014755.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <13014755.O9o76ZdvQC@rafael.j.wysocki>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 12:33:02 +0100
X-Gm-Features: Aa3M54ph000dT0mgXrbi9kmWLblkGU9R39SHDDhIoTh294IoF-r8S4DLc94NZLc
Message-ID: <CAPx+jO-zXL2W1qnmbaCUNmTojNoUhymbZCXV8Lsw2jz-LT9vxw@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Eliminate __pm_runtime_put_autosuspend()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Linux Driver Core Development <driver-core@lists.linux.dev>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, iommu@lists.linux.dev,
        Brian Norris <briannorris@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA0NCBTYWx0ZWRfX4KfAl7GBjlOe
 kNtR1iMjuib7xAvWcpa8BTBamMkC9zd3FYac3HyONS8VGHxSEev/iuwYWJGg/qn9SXrNygZdSPw
 Sude3fjuAQjllPErQZbDz6+o6/t/tPP6ZTh2GBQ47BEh2VxPMr2ZbaPW0l3znWDuVBEbbsunrh1
 Cf4pPhovuk2f2LxccXjBkyeUyh8LJEP0Qb+VLUqUxbPiyqiw+6mSY4/netfw4qdeYmU6ADUzLsW
 WxI462D0m+CcXYl9rBEPLlKw5GLIAjhtTIj/aKd0YY7wm9iHnJXh0beHS2/GgORwrDFRKviILnj
 SF4GCcFiMlOc49y+Jiki5IRQSUfZ9DmmPd3+2z5vsXQAKUg1GKpHQosQ6g2J3U9jmLqwnIDgHjq
 DK2WH+ABSGV2or/u/7BeY0jUQDYKFdLpfxIKxLIqr1RFA1plnRk/g018LdZLPl2hsXRvQwwEOeZ
 h1a1Jf5tLGkH2EFeEbg==
X-Proofpoint-GUID: D0Pr_8f7iPQrEJ1VLEKr0fix1f2-Qmvm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA0NCBTYWx0ZWRfXyOXyXGCE7+5A
 3QYMKDD2qHfo9JE6Cus1dB4xpRrKy/q/BeEqBhNEuB8nc8fdm7HjdVoJwM1ez/myUt5sLRpKjg7
 uq9IKAJo1vs7KMU2mHlfYku4yStrsY4=
X-Proofpoint-ORIG-GUID: D0Pr_8f7iPQrEJ1VLEKr0fix1f2-Qmvm
X-Authority-Analysis: v=2.4 cv=W/KtxhWk c=1 sm=1 tr=0 ts=6b0818fa cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=wRRl36yi_DWTeFIZz0kA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260044

On Tue, Nov 24, 2026 at 5:36=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> There are two users of __pm_runtime_put_autosuspend(),
> pm_runtime_put_autosuspend() and arm_smmu_rpm_put(), but
> the latter duplicates the code from the former.
>
> Fold __pm_runtime_put_autosuspend() into pm_runtime_put_autosuspend()
> and make arm_smmu_rpm_put() call the latter.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
>  Documentation/power/runtime_pm.rst    |    1 -
>  drivers/iommu/arm/arm-smmu/arm-smmu.c |    7 ++-----
>  include/linux/pm_runtime.h            |   26 +-------------------------
>  3 files changed, 3 insertions(+), 31 deletions(-)
>
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -338,7 +338,6 @@ It is safe to execute the following help
>  - pm_runtime_put_noidle()
>  - pm_runtime_put()
>  - pm_runtime_put_autosuspend()
> -- __pm_runtime_put_autosuspend()
>  - pm_runtime_enable()
>  - pm_suspend_ignore_children()
>  - pm_runtime_set_active()
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -79,11 +79,8 @@ static inline int arm_smmu_rpm_get(struc
>
>  static inline void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
>  {
> -       if (pm_runtime_enabled(smmu->dev)) {
> -               pm_runtime_mark_last_busy(smmu->dev);
> -               __pm_runtime_put_autosuspend(smmu->dev);
> -
> -       }
> +       if (pm_runtime_enabled(smmu->dev))
> +               pm_runtime_put_autosuspend(smmu->dev);
>  }
>
>  static void arm_smmu_rpm_use_autosuspend(struct arm_smmu_device *smmu)
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -588,30 +588,6 @@ static inline void pm_runtime_put(struct
>  }
>
>  /**
> - * __pm_runtime_put_autosuspend - Drop device usage counter and queue au=
tosuspend if 0.
> - * @dev: Target device.
> - *
> - * Decrement the runtime PM usage counter of @dev and if it turns out to=
 be
> - * equal to 0, queue up a work item for @dev like in pm_request_autosusp=
end().
> - *
> - * Return:
> - * * %1: Success. Usage counter dropped to zero, but device was already =
suspended.
> - * * %0: Success.
> - * * %-EINVAL: Runtime PM error.
> - * * %-EACCES: Runtime PM disabled.
> - * * %-EAGAIN: Runtime PM usage counter became non-zero or Runtime PM st=
atus
> - *   change ongoing.
> - * * %-EBUSY: Runtime PM child_count non-zero.
> - * * %-EPERM: Device PM QoS resume latency 0.
> - * * %-EINPROGRESS: Suspend already in progress.
> - * * %-ENOSYS: %CONFIG_PM not enabled.
> - */
> -static inline int __pm_runtime_put_autosuspend(struct device *dev)
> -{
> -       return __pm_runtime_suspend(dev, RPM_GET_PUT | RPM_ASYNC | RPM_AU=
TO);
> -}
> -
> -/**
>   * pm_runtime_put_autosuspend - Update the last access time, drop usage =
counter
>   * and request autosuspend.
>   * @dev: Target device.
> @@ -635,7 +611,7 @@ static inline int __pm_runtime_put_autos
>  static inline int pm_runtime_put_autosuspend(struct device *dev)
>  {
>         pm_runtime_mark_last_busy(dev);
> -       return __pm_runtime_put_autosuspend(dev);
> +       return __pm_runtime_suspend(dev, RPM_GET_PUT | RPM_ASYNC | RPM_AU=
TO);
>  }
>
>  DEFINE_GUARD(pm_runtime_noresume, struct device *,
>
>
>
