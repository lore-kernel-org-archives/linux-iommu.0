Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD49733FE1F
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 23:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783120317; cv=none; b=mCAYb/7jH4yqnxVbcmhh9sGBKg+2YclFJITH6wO4Ep0jOar8GI90BA1hFGfJUkcRix6DlyyH7oHVoB5s+N36aGcvuehMGpG99Y03XdRa/wYpn5mQj4qU7Ptlf5XhJX14TEin3BIKrGdpZZbNqyjskcR8ACm+ZEmfrNzppzOPVEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783120317; c=relaxed/simple;
	bh=csZOo7AmeNUmL4fc4xF7fLl0U6yGblbmYFidYkave10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyZ9hPVdIzbVNZGXt8plTlFn1Au4NtNxu5O1Lco5HzBDKm5gMXf7G6M28yk5mPU/HA+VzL+1nWJs9M/uVglHIanX82SdfjjbmHSqncSw53otKunkJfGrBYWcU+6aDWucP3YjSG0JgNydVnARjKKqA+nThgdHUhbRqqwUkyvRllY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pziJtIyb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X8WSa9YJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pziJtIyb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X8WSa9YJ"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 663KPSeL1005411
	for <iommu@lists.linux.dev>; Fri, 3 Jul 2026 23:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iSahybJeUk4w63sJ9vrP7jxxk2JxoTxAM8oSmXe9jj8=; b=pziJtIybqcXIcHGY
	16uqYBUx5N/NQcu3RbmzMBy7qXMjMyRWnQnW0e+YAIzOO+/jIi2ZjOFdlZsUHK55
	MJtpBpnIaIsWphbHLScDa2McSQ6HH0IH4yK5eIn+0pTfNAZd4ibOGkecXIRnGMr8
	2ijq2jLz+kq9hb4PUwWsTAwX1Lh65nMREjjMqqNd3O7PyRCVk+5HOL/nmZiESBN4
	OtUEEqNhKVY18F+dgeSzsJ4+S3mywjbF43heo7nJVt5DD1hzNbqK6QlsAY/kSpr8
	E1gWIEN95XAGB50G4MF8OpxOcHhttAAvTJhhkdpPeDwOF58JURaMm7BEjwd21/GI
	kq9Tvw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eycxkd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 23:11:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e53b8a302so92367785a.1
        for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 16:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783120314; x=1783725114; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iSahybJeUk4w63sJ9vrP7jxxk2JxoTxAM8oSmXe9jj8=;
        b=X8WSa9YJxmo+f+S+yK9eMCYABXcN8TKWM8UbjseudZn/ZseFPsE+4KkmMq5xSK243L
         cOdtsa8XMYFV2fDKaqxpKpQVPYs9yH6QlAoytC5WBRhasPHaaEcxtSh6SYPCPbx1W1Ln
         qJNemn6TvPWrPSUZ9zdoQmi3P+lnfOWbJTdKrTFdF6roio5JeaKyl1YXOaGhUtoBwr9i
         XACtvYq7K/hQ4mkDFZhMMabGvj+1c3MU0HkF3gUc23uDXJD6htUwRPug3GgXCJ7uluMe
         DQzQAbXKgyn16FgsV8fqn7TogM+rhtMmG3JiXQdt9dYvnaqIgRwtJmCeBSX5KKXTQadi
         1lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783120314; x=1783725114;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSahybJeUk4w63sJ9vrP7jxxk2JxoTxAM8oSmXe9jj8=;
        b=dXq1/71pz9X2F1NZEMYdUZNWlI9Yk0sZnQwJ+RLqzEzxvdnLpTeijAd+JYXfnUfzGq
         PTrA95Sqmn16TXxXfKQq4Cs9U4ayPn9blHkIWAtWxOKM3ZeJjJaN6pYag7kDdeNgb2XR
         9wZ6ur4q6BfEVqrbzNTef7WsF0XgjweWL9y0Lp4H+VoaBpx1KedjY14EVeFeXZPs+gx/
         vQQCeYso1O+Cr0OwHT2YbLuTlKkBHM3uXxxhuQJUb/E+iv8swdFE0ZhzffBPU8Mi/uUI
         EWr975H+vm0MnGJwpHTd+xOH2peha1kPkuEAMaw/QRddmKlvfRRQwGFaRMxviCX2n37g
         AtQg==
X-Forwarded-Encrypted: i=1; AFNElJ/h2EhSGxoUf951m9n/DhWi983zfbkuzzDQjPxpaYaK1HhAXqvs4ajXI83bbfg4sOKnyT7bHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyyiGeH7ei/L11AYJ2xXSmppE43035E/dDs36GNEJO+I8Ol210S
	qFkwaZCSO1SaN3iD19vsVFcuASGBNoSEKb5Hbxni2KBDwFPV/o1jDQ31YDZGowsA4wo7yHTkeZF
	NDhqvmA2ADTRnIaj5N+8tDLuxrUb15TgszuG8/cW9n13jifxw5GxU4U7BdA==
X-Gm-Gg: AfdE7ckze4i59BRsrUDanngV2H8cU/CCrkVHXt2End0B9HtKyjvOZtAGWyOFYY908JH
	ZawLs7mbA9wjByecD2ZCNGPJUEr4iUySiiOPIA+CGoaMn9hLL0ww8UCPSQJrGzuuFv/th69bhw+
	Y2X678i6hM5Bts/Pm+9NNoX1jzFNvwc8KreTdTo/KPEx2PQ6vgeSPxz3dwFlDq2xfx/ZuEDhnLv
	eLXRiw/mWsAs45uCN6gRCOpBA5M3Ik9EXHwOZUQDdR6rht0x8w+X9JqIQMeTGVX3GVI4dt4ZWhu
	N3Q+BK88SrJwd6OXacT7qs47/r2UQvIp9uFSKYmJaoS5EVpA/HBf/i4rDAVQwAcFfejavOp5Ycq
	j+3SAUhnZIQ4VckN6KLmgyUWE9WoE+ASQy9aVldK84Bq0udt6mSM4QjgRfR5qQQ3/z78qOd1jRm
	5AzEW87EKrl3eV8YpgUNJHE3v1
X-Received: by 2002:a05:620a:372a:b0:915:9125:e652 with SMTP id af79cd13be357-92e9a481185mr196240185a.48.1783120314153;
        Fri, 03 Jul 2026 16:11:54 -0700 (PDT)
X-Received: by 2002:a05:620a:372a:b0:915:9125:e652 with SMTP id af79cd13be357-92e9a481185mr196236085a.48.1783120313712;
        Fri, 03 Jul 2026 16:11:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13bfdf2sm835345e87.58.2026.07.03.16.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 16:11:50 -0700 (PDT)
Date: Sat, 4 Jul 2026 02:11:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Aastha Pandey <aastha.pandey@oss.qualcomm.com>
Subject: Re: [PATCH v4 6/9] arm64: dts: qcom: shikra: Add GPU cooling
Message-ID: <opgj6twppqwhb77itqelmyzniaifcja3wdazyzeal5axstr25g@a7v634mnimbm>
References: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
 <20260704-shikra-gpu-v4-6-90cf1a52e539@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260704-shikra-gpu-v4-6-90cf1a52e539@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIzNCBTYWx0ZWRfX1VjpTBhx+qJj
 zwCk1xu3w5NcWM11K3y3k5vPwbAfw7LDYqO60uDHYBHobhoYKHb7uqzvLCPnI8B9u5nDkFVgRP/
 zM+KTF/ywBM1x8WDyx2w0KDhMZKPGU9ZSe6rvR8/WIbToLaj4UAYOPmaBW95OXc8AkJPCH7k7dA
 DZpyf1VRS3tOg6uAL4+akGTtx3zgFA40FvuVzqhT/jyJ7QMAeX8O/hsSEv1PsdPLzj/nGGepZRI
 gs6XN6UQiE/dfDWXm/lTG5t1JNl5yAydu3BYW82G/44FB6M9XJihmo8AA0sTCjvNVuDwmCBejTY
 ZJyV5rV9wSTPJKhddOVYluGvkeRniS6xBkjIDiOl97E4ktV7H+MJmkDgeOcV1tbB3GCMAC5wdRU
 zzd7O0z23YilFNKDRXZHJhVUhbHIZVdqcHFWT9yG3AVy98uZv097qoLtg3rz8GX/RcyF7T6fddx
 pLsxIhEbVg8nCpISSKg==
X-Proofpoint-GUID: 914gB7mG4b9TQQYRkE8BoFURDU7-25oW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIzNCBTYWx0ZWRfX4n93dWz4ja1I
 /wBKuJMlwe9vqaB8a8ii+cRB0nCBhK2vIQMGLN+//FaFWJE5BkFhC7rbYXIfBd6hRf9NK0gyWuZ
 zeHTg2NxT1gNzGbhsFIUF9udyjguMaI=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a4841ba cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=fEDeFOH8jy0W6kBJ9PsA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 914gB7mG4b9TQQYRkE8BoFURDU7-25oW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030234

On Sat, Jul 04, 2026 at 02:04:32AM +0530, Akhil P Oommen wrote:
> From: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> 
> Unlike the CPU, the GPU does not throttle its speed automatically when it
> reaches high temperatures.
> 
> Set up GPU cooling by throttling the GPU speed
> when reaching 115°C.

Nit: 72 chars. It looks really strange to see two paragraphs with
different line wrapping.

> 
> Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
> index 34261221664b..eeeaa369d3a7 100644
> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
> @@ -2510,6 +2510,7 @@ cpuss0-critical {
>  		};
>  
>  		gpuss-thermal {
> +			polling-delay-passive = <10>;

Why?

>  			thermal-sensors = <&tsens0 6>;
>  
>  			trips {

-- 
With best wishes
Dmitry
