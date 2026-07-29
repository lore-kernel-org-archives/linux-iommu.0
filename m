Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C563AAF73
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339231; cv=none; b=rgmdLwDTs3ql2B7bxJMI4xzeEmb5Ep7g7t/FOmOViF6qzqjNc7yKG21JsrBBR545hbf1YmixFuskrbmoL/o9suQq0H+RrMphMTc/TtQjoNHwm/y/AU+YHHS5pyAZuFPy8LaY8HDRan+OXBpOZ1sV0EMFGVcq70nxX9CPcCIWfdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339231; c=relaxed/simple;
	bh=qvVc2UIs3ngSUpzRlpZ1gkEZR3fbSXfz0detzuWTJac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBs1uCqEWg9AN8Jaz7oKD9qxStrSY9HMgNJxaw0zX2vPSAsfhwOxG3vdZQ4PkrI9PZroRIG5ILKKUeQYLLBuruR3QGNRLg3CDg8u4GRNRR0YZRksObxpkMoZZc3qzNnXssPpFZPJyKL7UJtw0Ty9awwKgSIM83wVJvd+Csg5oV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L7xEEHtj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BhDr5Fgi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L7xEEHtj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BhDr5Fgi"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TF3JCg2108303
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 15:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ajMms+zzZs+uBR5tOwHZNPSy
	MNLyGmo/TMRwS6asBT8=; b=L7xEEHtjD1i38yrf6/u7zQbJ2t12vUPoUyI+nUD6
	ae/s5RMzWNzGK/Nu7UMp4siroDNpWvty9UlKquAo5likeh7ZvPzZAZiSWs3CVe+1
	JngEKgVsq1pIiJC22CrYztdDpsShfG/8KKBWnZDmbodNThQ7re9aYDwNYT/gfPkW
	ZEE5NyGiiyWei9rER889z+bANm1/H5VEBXrZUFWA0v9Nj4oHgJcsDy3KVSHFkD9w
	fMO1O6Vw3G6pKpIGJkQoXl6FqU7urXrOibEaK/RsBhK7aQKKnXLETCFsGbgtlRA8
	vfz2fj2CzT6LYbKf2XhiKwpQPACIw0LHJxx3yyIKksp0Rw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqkds8bmu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 15:33:47 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-520a00c7a03so20054101cf.1
        for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785339226; x=1785944026; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ajMms+zzZs+uBR5tOwHZNPSyMNLyGmo/TMRwS6asBT8=;
        b=BhDr5Fgi4bfkoEIvoHvc6J7saxrugpXmopHAyfuZNhX0hENy3r99pm8BLQYMn+Vsz0
         156kDMiAG3RPuiD60mkbqXhWscANZv/L3pqKS9zt1rANTFLClKW2890ymnkQzoUALFWl
         t5XxoQ3iZerboxoPngflujopX/H+EXANk1YIQe/ctKdSWgg8ujA0PWEwau78WFu7gln4
         vhNGdVv/pxo3Sizij6bO1fMNw9VrE8BQknaDWLr9frh41xvQBSNZjARyI9jfqmCyyH5J
         PpfDIwiv8foYTdmXURWmBjuJTcCN+UV0hXb0anC1Zm7whp3UX3SVk4ktm1cqofSs/RAw
         E1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785339226; x=1785944026;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ajMms+zzZs+uBR5tOwHZNPSyMNLyGmo/TMRwS6asBT8=;
        b=ILIX4geoaUPuz6CoDyTvnXoeC12oEHIGmv2yDBqlNMEMMVLONRbU94G3SSO+PeoSrH
         Qjf6QLMbBI2BOUEuFYhNFb1EoFFqLZXxSUDSGx+axjcniXhvnpNOQXTaZZAPQipwbmZV
         JQvqcLQq8yyZgmblj7EJCQ+mpSAZWROaTsn0TDQVU1OY/fxzkANrE6N5I60TXxiye62e
         wuujYewp2V0+Rfj/bvKLaNRi0JOojJEFfOD64jXNBTB6YCymm8/csRbK6YfJ0gQ9GWJj
         UY2sp//30rz2vYZTw7BIA05AZUHE3Di0+00HhRSuSQzAaXqqK1nodCncAn4A1cy66Yra
         Stlw==
X-Forwarded-Encrypted: i=1; AHgh+Rr0Ox+K2dWs+MH8tDjntmkErW12pyLP/X/W4OdEb7Cp3/+jYHJWfgwoRh1LuFKqjIVeD/FItQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBf76GVZ3Gg6cgEhGI1Nn7wGJEHy8eSdFZNVvRr3uY4rvFW3J6
	63/FQmt44j0GovnG31GvQt1aBzZQ2DRXqU8AWs/isP6u0O0/zFxyz9oMPL5hTH3V5g3KvPV7sNa
	CVQ+SzsERRl9+LeDvRU8gJ/od+1KfdTOmSCU3lVVpVU5NgZJUvi+A6Wm/Xw==
X-Gm-Gg: AR+sD11YaBml64sJvUm5Sy4pd2K2G85XxN7NxeYU2dRf4g8+ND911ORvpfCcl42uFHs
	L6FohKee+MPcfoTLoxDnWWk6ThERUndS9NX7gl80VYlUBCapBwWuhS0va5XnahMQJZIIU+BHs7d
	l6xvmUJ0keH3vZczAxY6RfvPrlLNhfBnpIna3E5WKKcXMvuhcyBCj2mQiqU7gb9zilKbm3CR+tS
	v5pOBwLR0nN/7+g61y43oKYiooSIGtdEjNC+XQaEK7n+DfXEXMO36oIfKtKdEsCwX4q9mlGJ4dm
	rUfMimDm39PfxXq9AxjiG/Y1J/1bXiaCrXxOhQVCzqurEyNyiokc/GmuB7UODJut3wjYLwD8S/x
	yLDzYkWQmaE3bqwo=
X-Received: by 2002:a05:622a:2c6:b0:528:3b83:3483 with SMTP id d75a77b69052e-529d70fc0aemr69903321cf.23.1785339226331;
        Wed, 29 Jul 2026 08:33:46 -0700 (PDT)
X-Received: by 2002:a05:622a:2c6:b0:528:3b83:3483 with SMTP id d75a77b69052e-529d70fc0aemr69902581cf.23.1785339225661;
        Wed, 29 Jul 2026 08:33:45 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.163.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c4615f5fsm156186365e9.9.2026.07.29.08.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:33:44 -0700 (PDT)
Date: Wed, 29 Jul 2026 18:33:42 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
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
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 9/9] arm64: dts: qcom: eliza-mtp: Enable Adreno A722
 GPU
Message-ID: <q6f5b7xejzawn263ipbi7hsqin4c6jqsk6n7h77libdcvaq725@n3jzmra4wgdi>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
 <20260718-eliza-gpu-v2-9-64379dbebd7a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718-eliza-gpu-v2-9-64379dbebd7a@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNSBTYWx0ZWRfXz+nB5XpUrSLN
 E4HmwL+/DkEe6WKAoSWyw0I55zKlgtOX6DpXEndLIZkJlb4sQ/MGN4WH9qp7KYWZqbevre04j8p
 nE3dI+tBWbUBX1d3Mfl/jQfTFXr7Jyg=
X-Proofpoint-ORIG-GUID: JeFLk5UWMsDEu0LxUlm-MxfRgU7b_2rb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNSBTYWx0ZWRfX1lT4Eo9pWoSk
 /j8vdPxkvXaDnHdwRkapK0Ias0xXyKFgJFQPQ42Z8kj+xwreXT2FIRAMEOZgz9k+bOOccxZljjV
 pYUk1EK5NoFaXvJOYpw16f4UCi1p7d6jLz53l548B/+VCUA9HkleUKMQ5BCaJO7/u9lHHeOKvpj
 A1Mellk7zv+UWCZsiie5wgSgoDc5LEBAwiNJufLrhiPYDGKnY97C7D++nNZtCMlS0KTJ8xg6j5w
 kPdhtCdTB9w4A/W4NBnvgN/dMv5fadUcJ13jbSrZvTjtV2qafybHd0x5pFNjF1ztZBH+76736aF
 3/BZy+rGh6YkUzMFBemHIqsnAPmX0wtZuLyjwLM1KVBjafGBNA2MeQVj8hF+vzo4JCgf1e7Q1pn
 rFznIEp8Pdy8RQ82p5Rlv2/Fx/WpXM+zYVLRn49lCyVYtbV6Vc7/7lwtlzTTcus3h2PVDEP5a1L
 x/IiSakVKfE7rJlWcBw==
X-Authority-Analysis: v=2.4 cv=VJTtWdPX c=1 sm=1 tr=0 ts=6a6a1d5b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=6dw9+iwJWV8PcCi9M4lOBg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=2dTW7TWR5CdT-0lf7KkA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: JeFLk5UWMsDEu0LxUlm-MxfRgU7b_2rb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290125

On 26-07-18 02:11:34, Akhil P Oommen wrote:
> From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> 
> Enable the Adreno A722 GPU on the Eliza MTP board and provide the zap
> shader firmware path.
> 
> Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
