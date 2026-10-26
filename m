Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008796;
	b=EQo45Om1DVNXaj80WoZqjzW+mVe8c3H+sUyQ1WPUPJziSYszeLJTgR4jEX/9QVHRdT6b
	 bjHz3jKg+sXDM6eQoYgC6NeD742H3XfUo/fq+4zFuDdE0G42fN4THUGoP+SjlQjyc66d6
	 WAOGlj6hXJ8LUg+paPDuUggZXxDeP16Piw7v1rmIWh9e6SRn3ef6eL90bTQ2TldyjfGRL
	 0a/XyPTTw19pcnckRsMesWs7tsXCQSDpIR/beNdle9eq+tcfw0HZjW5I2NfFIgokZZcj8
	 xflb6nh5HS+j8BFTskeoOQztPMSvzufWWb8i7/VgNtFJYQ5FC0wavpO5tVZYxeIDliQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008796;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=EihPl48XyzquhIbKjuEyAajD35LkfbvtwIfgKv80/jQ=;
	b=b4KOn2i+WNXLpWu1voIVpBzJPxLBuzGFqIrn9gyP01/98b19Yb5aLYqm/s+eimDoS89v
	 CJH1gZUEKfLMijWMpzA4VAnWiHkcAyQ9vyEy9dp6A1VZe1ygaOEhrlr5cUzXy+boecpY+
	 i8QVN6uIs5hK3kB8AQqFxEhd+RzFC7K9KB/qCYN6UbZe+XwfAjjK+Mhrkx30IL+Y3URRE
	 GcRxLfS5+nmjGGl0c7ZoairmGyj6IgMTMxend4uat1qUZVbwy9TzlQ1dAOBN5sUkyfrVR
	 yrtyF3YJFMlm7ivnCxURi0iMVDehdV/a8y2BSUgUA9/0cuSWKdf5y+DEGpJKLKE7yUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=duOPPQmS;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="E/SByKfX";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F2D606A8EB
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 09:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F2D606A8EB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=duOPPQmS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E/SByKfX
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q4aPt22222515
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 09:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EihPl48XyzquhIbKjuEyAajD
	35LkfbvtwIfgKv80/jQ=; b=duOPPQmSNBtx6zhy2MyD4npHJuJX7Gm6wHBXP8ce
	gso6SBXwNnKeARLD/e0CobapPe+Pf7ies1PCMX8l0Ug5iwRxIVau+SXTqeR4fsTE
	bPqNxK1Bfn5d+FDp8KiVM+Bp+TZkWsYiaO5Dxo3FHoaEt9Yu7ndZYJNRki6RGyau
	e9TqyPtI9Gei8s75Mu/XbJ23qlTZsPaJIRg3qr0eUH6Wvuq+DaaJU5SFPTDHFggF
	7OibQZR51kSYWjQNBxzIW8c0qzGWVc8rErJCz0VI/N1iO4JE5O3EbCK0hg/I3CsL
	BG8uaN7ChjqvVzPqPBbYVSwVAksgA7o7Ey9Rzt7q1IwiOg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhvdd9jx0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 09:59:54 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-7cc48fbca26so406617137.3
        for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 02:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793008794; x=1793613594; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EihPl48XyzquhIbKjuEyAajD35LkfbvtwIfgKv80/jQ=;
        b=E/SByKfX6whDyz3aviCngIRGeIUKaBJJ5ITRat+jgqQVFDCqmQFCXc19tGIfWT3TpU
         Q9RvYVag8t9kVEQ6odt7sbFIRtKCb5NBd3J1Z9njqg5hQ1B35kj+c/8XAC1bi0WpAE+Q
         MPkzmjIKOTg+072NmqhujuX6A88K3vz2Z3D7yXuNU3vbSngmP0/FbmSZ8rrXq6T1vMwO
         CzT8e8Z2rPhkGe14LD27vylFx2a3MybESUsEm0Q2vdUBWphm5Kz+h43YZLEzDS9bBr0/
         uNE5KXpRXcb/0zZkWZpDGZ5h6R6YNCBIM72G8oBNYdxDxqgTrZKxschAGuLG/ipHKMNJ
         kSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008794; x=1793613594;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EihPl48XyzquhIbKjuEyAajD35LkfbvtwIfgKv80/jQ=;
        b=lPUDqXmHVmcNTWnXKv0qB17k9TT2gmAa8ucBBMsYMOcJILJZ1reeyeCzmBpBxVyEVF
         jp4go8TjRd+osJaYilnb1HXPlR1NrtTO0v/oOUOG1h00VhY1RGk9H2T8UdcR6s2sXUT0
         cejpkuUUaMGyoQHlqyFy1miWlIcEx+Oz81eir/2PeccGz4kiBJ9JTZjbzyhX2rsZ1u0c
         3sDbFYUI3UKpzQ0x9jt4ARXcUl1tJ9uK3UfOZrlIpoMiEg7YTp7CiCQqwnRDsdcn+l0v
         bODuKoUdsO8kKY43Dfeyj9qgnixZMkrzDrgM4pk2wqnUyTUqGgR8OBKyB1c24gRL5uHY
         SOmQ==
X-Forwarded-Encrypted: i=1; AKwUvBwr+cVPn5gTr4NWzlImv9yeV+mS3Kq8U2yrWXTQMzAxZFucT9VYrSiSKWHD8VZFwTg/I1MXvA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJr9xTblOtz3WUnp5Pj+8PVKf4xCuFLrp4cgYsteXrzAsK57jAA
	kuKY0MVtUlGzXfYnP2vJ/3a3j9tfATpOw/53saN5nkmLv3LpC7gH3HoaR/3VNTowQaEUuhLX6rf
	F2ixpDew+sb9LfG2GAQ4rfXaFaudpwn7HZUCzmslGtDTyFp9wEtZD3ivUoA==
X-Gm-Gg: AYBFou2/2mLV5osbM9RP/aQhAECiiHuKh6q0OJRedAF9UAHdtMN4SVRBhE/Zo4TKi2U
	f6OGia/19Ezyc4K5qJwJspud1UilyVHayHq5xarT+oAdn693nj8iW+JLkp9Zxkgusbt97hRWrF5
	J8XPBPs2tQ4g4h7dWfIvf0jPGw/6xg0vCxYhfmB3dyji4WTNI1Q+fnNBXwYdUvmeTCnHPh+y7ZO
	dp2n/TNuwndCwjL3ndqc+P5shk/tjn9XucafCtXbeh8fpP8XOfWL1lthNPnacGDVjUsmTapwKu2
	W+xeaKhvG5/kz+6g26nJvj9j76tPJKBsdICVCr/q/jIU3yaER37Yw+gzPOWtvRzP2l8Espwa1sb
	3m4xRpX316X4gJt/odCC3pbdfEwbhDNmsyZrJFVpulBYcAQTD9Mx/u/zSOQkwTeTgMPHZZ+H6OE
	wIV7njIbc0CX1i
X-Received: by 2002:a05:6102:511e:b0:7cc:2fd1:7143 with SMTP id ada2fe7eead31-7ce5cd65a0fmr1586672137.17.1793008793959;
        Mon, 26 Oct 2026 02:59:53 -0700 (PDT)
X-Received: by 2002:a05:6102:511e:b0:7cc:2fd1:7143 with SMTP id ada2fe7eead31-7ce5cd65a0fmr1586636137.17.1793008793315;
        Mon, 26 Oct 2026 02:59:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ac709d0606sm16973671fa.14.2026.10.26.02.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:59:52 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:59:50 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Philipp Stanner <phasta@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Flemin Jose <flemin.jose@oss.qualcomm.com>,
        Mahadevan P <mahap@oss.qualcomm.com>, virtualization@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 18/23] virtio: Add Qualcomm Platform Services Firmware
 Interface ID
Message-ID: <lisaligvjmnnib7gm6klab77jfzyagn5cx5pix3isodu2cjvrr@o6efvpyte5yg>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-18-7cf014efdee1@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-18-7cf014efdee1@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: C98NNZkhJWH-n7QaqDzhTRnuG9heL-VL
X-Proofpoint-GUID: C98NNZkhJWH-n7QaqDzhTRnuG9heL-VL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfX7xFbFzVcObuf
 NrCj30kbFNHM6mrNlGZqE3iMZDaDUN9LEKA8vACltUZme7ph8tD4gJ3QYC4ACV17wYa+1/Rl5NN
 ThM7z/ZGP/PG4MV+QKjiZpy79Ml8NRUuWISFvaYz6VxTBlrmWO9U60DfwM4PYosCIA0w1vOJU64
 bQrhLQ8oepULfbd7o832W+XQC29mrcmWzccFBReilBqJ6vIphEeiy9VCWxfutcih1tDtytwDaGz
 INOeU/AR/oXmaZtdxg1MKFKylZQYlzyP/FjpP4x99q6ZaMLEGRrZcnYcAd9tDajGEstTpb228bm
 o5j4VrrZ78aMlVt2l2mTh5wXXlZAjCCvCAirzeZ7zPazkN9GlKnF0MlrMCQzabk1siRdfYK89ia
 +8yHs7F6VY8GHSguJSCKYe+FVH55wYF+ywCgm54ENcip41qJeJVf5JPScDMo1vllMBTBjZpiSne
 Ib8yt1d2zhAeqrT1bXA==
X-Authority-Analysis: v=2.4 cv=N8+8hG9B c=1 sm=1 tr=0 ts=6adf249a cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=dTofmrguFlo4DCddnn8A:9 a=CjuIK1q_8ugA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAzOSBTYWx0ZWRfXzQDPyALU9ZCf
 M1XzHWNX1foSoSEDPWVk5GqI3nYdGBqknmxNZbf+di2SF+OpW0VKlFYO9ft42koFOtp0JGZO8K2
 tV2zUiwaKdqw8LFbJnFf2LveWd32RtU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260039

On Mon, Oct 26, 2026 at 11:51:28AM +0530, Jayant Shekhar wrote:
> The Qualcomm Platform Services Firmware Interface (QPSFI) is exposed

Can it be anything other than the DCP? If so, how would you identify it
on the Linux side?

> as a VirtIO device with device ID 52. Define VIRTIO_ID_QPSFI in the
> common VirtIO ID header so transport and function drivers use the
> shared identifier.
> 
> Assisted-by: LLM
> Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
> ---
>  include/uapi/linux/virtio_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
> index f9056af0c622..6c6f283733b1 100644
> --- a/include/uapi/linux/virtio_ids.h
> +++ b/include/uapi/linux/virtio_ids.h
> @@ -70,6 +70,7 @@
>  #define VIRTIO_ID_GPIO			41 /* virtio gpio */
>  #define VIRTIO_ID_SPI			45 /* virtio spi */
>  #define VIRTIO_ID_MEDIA			48 /* virtio media */
> +#define VIRTIO_ID_QPSFI			52 /* Qualcomm Platform Services Firmware Interface */
>  
>  /*
>   * Virtio Transitional IDs
> 
> -- 
> 2.43.0
> 

-- 
With best wishes
Dmitry
