Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29FC3876D6
	for <iommu@lists.linux.dev>; Mon,  2 Mar 2026 08:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772441019; cv=none; b=I9coPXrEvUFHgjSdUu5jI3W3yZ7zVj9B3rOLqZh2FQUcGOpRc5/EG6vAp35M4iOrRv4aP42AaG26Pp9M498B5FsUHgzW4DDyV23eZRHM/LLo9RZFkHaqUrn2iiWhABw0OIIbirK9hewarmevq/1RyzUKU9y232CSh22FewyarNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772441019; c=relaxed/simple;
	bh=/xZ2osG6NIrmnyZ+TWhCavfR/+FAn/7RvAjDCbyOXRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ed7RUfWpMebmyuAeU7QoFtaz8wZKLS4+TYTvYz8X3JQq3aJa1hqAPfM03fwUgihLr2H39n5mvgpn13R7op4CQuVtMe7L2bhUT2CwTcza5hyeEfVB3gm75a8slETk6RZHA3AE8LadNOaqxJQ92xF/hWNJWrXWdy4K17O3gu4dSIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E6FZQn/V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S6qG+n51; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E6FZQn/V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S6qG+n51"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6223jNcO329026
	for <iommu@lists.linux.dev>; Mon, 2 Mar 2026 08:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kzhcGz9kiSv/N4brhbDMgmBjGdF9z8YyVnAXdkdzS5I=; b=E6FZQn/V+eAhBHn0
	8tH6CLUWeLzRwHKNoHRBXFhESTg8oppg4/shnlBIJSpK+UUNYJAXzfZDV/Xew3cn
	gxxUjFZDbR2tQM7WKMRb0DQ5YsZ3IetF4VzbhlOYem8u3zzwysF/7B3IB19HrAPK
	ws+FiOiFDsF3Q4K/mpYNHAUf9JkNiPHXP10RACAUFmWye2LgYHeVX3Mh9FGZbirm
	TplyKHUGAQNGq1kLz6AXSsZlDeaY4QjdkdTLnyTxJmMydlc93l7LSXqvo22pHurH
	V54k0ahuW39O9Ba6kfFlEUEaoRsTlOo7SQD+XQZAKeOlFk6xUqJo0+N5OEtXWA0p
	1mENwQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksgrvty4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 08:43:38 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae3badc00dso18762585ad.3
        for <iommu@lists.linux.dev>; Mon, 02 Mar 2026 00:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772441015; x=1773045815; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kzhcGz9kiSv/N4brhbDMgmBjGdF9z8YyVnAXdkdzS5I=;
        b=S6qG+n51ShPCyncRU0Tyv4DDAllPx+o7NyAxYDwGJSrxwYrX5v3urQWyhStMFJnh/f
         E/J1NUCB3n44svSkDbNEkmYdL+9ZI9dJBQ+9QklboHXarnYWzLIFXKpU4Gsqf9IGzLws
         dnRfj/cA15oTCi7DUMSrOIroLMJ+ZvYA6wY4c6jfzd9FtWS2ifshSsk0r9qT/Uj4EymJ
         8cyT3BQO6PlJsBj07ZsyczeiCAK/3cp/hfibXaWRRv+4n7BxCjOGqCVJ8GfN9TosaJaX
         UC0jjgVhHsXMq9z3NVlMbQzAM2de3Ngbi7jSxdHZR8mmVIXqyXs3hDVq+r+i/us73+rx
         tW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772441015; x=1773045815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzhcGz9kiSv/N4brhbDMgmBjGdF9z8YyVnAXdkdzS5I=;
        b=vCnHbeW6lVDHnWuqkyfdN55uQH1veJs6pXbKMsiRtyNUYVKkYbExTIwsf4doWu/JeZ
         pIzvZTuCcdcs+23WM7aTcFueCkTTl0ZB9IdTJ7BoLSsF/plLbtIOaHkRPu7VM/0KvwOP
         lmvOAwbMXhsavJQP+0rU2iBpGjlHVSeobl1ZM71xb7nvIOSJVTXJcXgHrxZFrWO2Nd8O
         VRgDrkh1cjSHKlXDBxvwNBzwcLl18yV3XpoDV+rBkFwQ8a2qi8fBF2AQMuM+VuZF9po0
         Gq/Z76lhfuqUJ8LzjUyRNNaV8hX39Z6PTFI6/xrrng9ycqW4vbZX2Fcg0eshmJFa7/hc
         A7BA==
X-Forwarded-Encrypted: i=1; AJvYcCXcAqNTWH6JSFyTD4yd/zcqmXpHH75CEonkx+8cwMTN3SHlQBK6LL0Fj5o8OjKYOBgMQVITHA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxpsf06Zs3ZzRUO41YUsy+h+DmkEW1MPHFa3mxrqyGtWW1kTkV5
	Cak43tLSAaqsMlZ1jg68yAyvXJKWLC56U2Xf4WQfTmVZHf5YszvpYZKfXvBJmszlCBFi6EBcZ0A
	0DIUosGxK/H8G7o1fS7LxR47ItiK/wD6sl6OxAtnaczU/RvyCD8uyhsGcNQJNdBlnKQ==
X-Gm-Gg: ATEYQzzQ13XcG7srugxNz9ZwITLnqtiWrJuL90OR5L7MSEok4y6XjnRTh+03Ueaz60t
	4K8MqWmQqS5sA35prhKQduZ9GMs2klGOCrHsC0O18+e5a6fbgBGzK9MD+DVXpgqtmyTWKCkgLOS
	+ag5fG8R/U/gh18v15mdzCh90mntwn81CGuWBEETvgNgZjvNLptdMJqNtqEN5luNNeh8rEk15G/
	QafYxTu6vX+FAW3uGy3B5fJ6/6ntjFhx9KZEAExzQgCVTDa41t9M9n4uBO+9aDoD+coZxEF1AmS
	2pK1rgDdcxJN+ZuYWnitYUZxIlC0dDc/nk0MPfWLD0X8m8vmJd7sjimSBlxwGmCzuAULJQFgxex
	w1tCnNLDmh22L8sdUmHprnEtuM3XMh2keSGl8oBULrWwk8JcUEA==
X-Received: by 2002:a17:903:2352:b0:2ae:4a4e:1e25 with SMTP id d9443c01a7336-2ae4a4e1f37mr39247965ad.25.1772441015352;
        Mon, 02 Mar 2026 00:43:35 -0800 (PST)
X-Received: by 2002:a17:903:2352:b0:2ae:4a4e:1e25 with SMTP id d9443c01a7336-2ae4a4e1f37mr39247665ad.25.1772441014848;
        Mon, 02 Mar 2026 00:43:34 -0800 (PST)
Received: from [10.206.99.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae5276097asm23725485ad.34.2026.03.02.00.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 00:43:34 -0800 (PST)
Message-ID: <9eb6d9a3-268b-4dee-9fab-ec59322e8a3b@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 14:13:26 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/18] accel/qda: Introduce Qualcomm DSP Accelerator
 driver
To: Trilok Soni <trilokkumar.soni@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <cac08f2f-73b0-4629-898a-1e24840910fd@oss.qualcomm.com>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <cac08f2f-73b0-4629-898a-1e24840910fd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3NiBTYWx0ZWRfX87KY6RSdlk/0
 lXk0mkeXBcG74KPxG9+17nvx6h9ZG3cud8qWn7kuPF5aSSaaGuZ4RAD4kisqNqKTFx8eff//brO
 sriOz2OKLwVov0p58hV4As396wROLYWYTc3Xybh48zyyhrxppzYoFh+vDkvvXNJ0KtenvwtBZpn
 1QEcl7FKU2NaESmyMShxIu2Sg2mtnntxABN19tYrzb6351Je2n82OJiyI+Ges7LcMLsuUjRGoa4
 mdO4yTB4kDRBn2thcqrm1OLg8gEsZWtdBdzvTfnhID1I7OOG5lesJryhz7go+8heFfiWOX2dXUX
 TVhi5aDMhYrvWMg5K4ect+H2EO1THxlUfZoiWI0faGL4KsGjsOXVQmGagkeJvEikVPbOctgK7/q
 M4xTe/7VDuEWer3Ie7CNkXpsPz8b0raFA7hxmF+m/Ka4an0QrMf0LMbA7Iw0R7zer5qa0trzElH
 5zBV7troUV+zVGBbGqg==
X-Proofpoint-GUID: bF4dHEFhPp4EdZ0vc_EIIlrgftPIzn6M
X-Proofpoint-ORIG-GUID: bF4dHEFhPp4EdZ0vc_EIIlrgftPIzn6M
X-Authority-Analysis: v=2.4 cv=Zqzg6t7G c=1 sm=1 tr=0 ts=69a54dba cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=AnEmtbbmQWdTvrL9bUcA:9 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020076



On 2/24/2026 9:09 AM, Trilok Soni wrote:
> On 2/23/2026 11:08 AM, Ekansh Gupta wrote:
>> * Userspace Interface: While the driver provides a new DRM-based UAPI,
>>   the underlying FastRPC protocol and DSP firmware interface remain
>>   compatible. This ensures that DSP firmware and libraries continue to
>>   work without modification.
>
> This is not very clear and it is not explained properly in the 1st patch
> where you document this driver. It doesn't talk about how older
> UAPI based application will still work without any change
> or recompilation. I prefer the same old binary to work w/ the new
> DRM based interface without any changes (I don't know how that will be possible)
> OR if recompilation + linking is needed then you need to provide the wrapper library.
I'll add more details for this based on the discussion for compat driver.
>
> ---Trilok Soni

