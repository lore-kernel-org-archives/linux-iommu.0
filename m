Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CED3B19D0
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 06:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949890; cv=none; b=mtZbIJYvinCEEOb1fOOZwj7KOiY82uYcae8dJJNLZjq/FCh8crfwfQMudKNjZdcBvxsIwDhfIBDbm2xlBSoqCsD+CmjeFFSMh9r6sD4JGJ9NLcmhkSKEZdv2KYmYUpgn8ZuhIHakoQeR7Fps1z48i9Dzw9UU1dzPL6crav3mFEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949890; c=relaxed/simple;
	bh=aQ2QdEMrxnuRhjKWtOccXPZh+dbmFTMZ3oT+QDfEqVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+MM7aRWv7AszG2ZOZ/B1/yieUhFYfs4ckPoOPB3Y/i2SL0O4HGHa9lBvueLOWwz0nCQSQv1L//K2zhEPDlULO53s/3pqPCqocl9J7wMoK+XACxO24x7vion+QMhE5Fq00SktKAJyTZqTcMyhLcS0T1jChTCYx60mV3QgA210PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WvjKzKS6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kLm319+j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WvjKzKS6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kLm319+j"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67H6eFbM4059807
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 06:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SBRrabcYBEIHtygqtEKhQW0Z
	lUPvQs3RPnhnKjeoIdY=; b=WvjKzKS6qRwZItZ88u09pS5Z6G+fORseRx1d6A58
	lj0rfbvKkjjQrvUuvpCDbnJ4LOuKnkaYZVZgPB8Nj5aHW+mW0DBKjhX/FhaYLXjk
	qjA/QbRWnA5nxpiSWq9vMFjKidb0HVYQBJE64FEbkqTHnP+SdHIxK5d5T9D5DXr4
	jw9yL5CgJbbng9gt0M/PwgTMGNz5Z831gaiGoluNwLmYcRBtO2ByLBNseZvy4X/d
	bKRtfIPIiXJ1q5N60gR+uYq7gX4eDJgyE86lFLKTJd8MmBAtLt08pYWuqcPbiWCd
	nskBHBZ2kmXKO7zV8I1mNf0Xhi+lyn81+Yf/p1ihxrzlvw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2hd7wfvr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 06:58:06 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-930edb4362dso288542385a.3
        for <iommu@lists.linux.dev>; Sun, 16 Aug 2026 23:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786949885; x=1787554685; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SBRrabcYBEIHtygqtEKhQW0ZlUPvQs3RPnhnKjeoIdY=;
        b=kLm319+jmF5OW5SUWCsSb1KZMPZy1hI+PjwgBFTEObU0ptOXiFcY5sUTNd8dW7JGWh
         TUyWWJSCeip4DIgMYKRjpNmFcYHdsRnEUmXTl9EWbBPQU+6Xpmdb0K0DzjOeLFCX/Y3w
         rGsL5XzG9l3XrCtb22FEe8PlJdBSOO9o38jhKbr/k8H8+lF8kvvQB1TDOy2n8FkiXubE
         nW1wcOi7LCFP1fbQ3FbfBqy1WinnsANvor44J626hA4Pa70JFS3mpZXeFOdtIC2aQNS6
         hxEyof7V51KWZc5O9FsP8nLNHcscDZqQrUXqyt95JkYTGqAlOhswN+TMI2bOdM8iV09D
         wIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786949885; x=1787554685;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SBRrabcYBEIHtygqtEKhQW0ZlUPvQs3RPnhnKjeoIdY=;
        b=gkbYbMZgt3bL8IkNk8BjQEe2rgrN+PSQNDmWM06YITmqdChlwAdP9ZoVD+SFeKfu2R
         oVZ42msiA+1TlbDq/0BmRf0zNVWepXFkOl3KmT8/dHyOqjirf0lICxHvwv5HP7J2BZiK
         M0U2XHn8teu8UT6AyxHVoWBnnCsAdb1isbdCqhFvcZExsEUCGtJXDiJcTX7TGtlooeFP
         EqgzquIiH6SO3dU4fsEYaZr/UampnGwsZeKgp4eEvHimlzR8nyapSykf1fYv96lVfBOL
         /ZPAa6BVI+vBNDbBCNQkCwKJsI/E/snnOsIWjXlg/W+kLyjffav+Xq+pdzV+cqU3vhRf
         uMnQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp8kBPdaB5nA+cls6Ecy1AjW1Y+pu2vm2wMZo8u0rG4LPg6SXTrJ3mgwHH5oF9uPeAkwhzg2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyS+T1RvUZJBV+VOolKOUR143kNrV7ffS/gpAuNKj0S+boLudPE
	xwTeZT7Ao+aLYl486B5zdVj4AtcadO1ivRLAE8RW8EkiFzuBsdby6ScsBiWjRc6ri20lHZ+kzsh
	mYLRs+x/X+glBFnCa/UP6CXXLIykoBaA8QNuCcMrnCdWw/Af3ZBqUtJ7nQw==
X-Gm-Gg: AR+sD128p3LzS8WY8xj6y5/V/Fx68QuFxtOA6rOpTN0l73UorY75q1iOGm2LnoPmx5R
	wTHVpkhsQ0JJ2BMbc4WErCcBCvMFprzgrMhVJ3sQ+l8gaJBXRO4ykV0T9JxQxwMFQIhOXJgTFSj
	WSeWuSdf7g5gFYVbLPGyQMe0K1c8AGf7ByS9E/Y/f11ztjt8Hi9zq23ojQEdxjHyiqO2SHut0te
	cR7WBa2Zas8pTogz20cqz4W50VgSSjBR9nyMjmb/HBTMgYXCk9iiQpZfBmeHggUB2/hZ0nWLQQW
	F7dYDwaJggR89m505o49IRfbPSLvKPPjXLAq33YKs82oJI52WVjz+BzVo8+cmOe68geV5sa0v5G
	N6xig0QDTcgozG30XUjj2MnoaoarlxSmgBvAU9XcxCWLjPLkWdyyA61VmfMZDVn5ZIR5oPYKLld
	OmMBOyp+0pG0NO
X-Received: by 2002:a05:620a:43a4:b0:92e:b1ca:8ea3 with SMTP id af79cd13be357-936d2356ef3mr2575748785a.47.1786949885091;
        Sun, 16 Aug 2026 23:58:05 -0700 (PDT)
X-Received: by 2002:a05:620a:43a4:b0:92e:b1ca:8ea3 with SMTP id af79cd13be357-936d2356ef3mr2575745085a.47.1786949884607;
        Sun, 16 Aug 2026 23:58:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46d02851csm139928e87.84.2026.08.16.23.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 23:58:03 -0700 (PDT)
Date: Mon, 17 Aug 2026 09:58:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>,
        srinivas.kandagatla@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 08/15] accel/qda: Add QUERY IOCTL and QDA UAPI header
Message-ID: <r7bx25akbxomzhxxyqd644efy2vc65etwcnhlyha7wm7xrt7ea@p4v5sesn5rzw>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-8-69a02e9090d4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-qda-v2-v2-8-69a02e9090d4@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1MCBTYWx0ZWRfXy1dokJ2bzgfz
 BInZwn2WB7Ad1lYJw79vhQuOz6aMiEnlkB1l/LyWdJAP4vOAsfNcaEIrUxREXT4XNPq3W6fjF39
 C8CoumEzQvuXghfefHBxGCLwcOS7igupJR9FOp5ixJwvTfjNew474UOpywspBEVhD1NDfJcv+ei
 gHqyKl6oDhJZTWYnHWKQQSMsvqF1SGwOo+6wWaBbqNnP7XXedTfYBdvC+LdZ1jh1HaarqgmFYMH
 ttCAv5JMlBNVNrDYsvWGrP9xKQ2X1NNsQCrIl1lKuuCCEV9ceL9KgdP/kb7qZIAcg/fHFPbGUew
 5FgQ6Xpq3W58lg/NK39KP64bNyZ/hAFoS9fdXwXwuz1iE/cDz8E5t4gUTzve3XVNfcbZQxwWhMK
 wvxGNqK1s4SkJroRISp8hGNr+AwKmqynppyZtCDchyoUFhoK1A6+U9m4EgX9HiyF7py9BjQwfBD
 knbHmZkNy7IHE+pGiZw==
X-Proofpoint-GUID: CGPJWdjQrT_Laf8VLcpmfABCSOKFyBup
X-Authority-Analysis: v=2.4 cv=Ja2Ma0KV c=1 sm=1 tr=0 ts=6a82b0fe cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=WSzJgX5NAZKvnqDBNMEA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: CGPJWdjQrT_Laf8VLcpmfABCSOKFyBup
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1MCBTYWx0ZWRfX7YQ2YKxrZLfN
 r06MwYjNwzqEtoBSMyBopsr6X5gmI1PhhTbh83P1UfbYqZkmoHl+zRyBw1DZAX1qN41IYdmnQtZ
 UclhQN5FOG6+WVFJOr+LLydlyAWfvek=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170050

On Mon, Aug 17, 2026 at 10:17:43AM +0530, Ekansh Gupta wrote:
> Introduce DRM_IOCTL_QDA_QUERY, a query IOCTL that lets user-space
> retrieve information about the DSP a given /dev/accel/accel* node
> represents.
> 
> The IOCTL takes a query_type selector as input, so it can be extended
> to return additional parameters (capabilities, attributes) in the
> future without adding new IOCTLs: drm_ioctl() zero-extends the argument
> structure, so new fields can be appended to struct drm_qda_query as
> long as they go at the end. The first supported query,
> QDA_QUERY_DSP_NAME, returns the DSP domain name (e.g. "cdsp", "adsp").
> 
> The UAPI header include/uapi/drm/qda_accel.h defines the command number,
> the DRM_IOWR IOCTL definition, the query_type values, and struct
> drm_qda_query. It follows the standard DRM UAPI conventions: fixed-width
> types, a C++ extern "C" guard, and GPL-2.0-only WITH Linux-syscall-note
> licensing.
> 
> qda_ioctl_query() validates the reserved pad field, dispatches on
> query_type, and copies the DSP name from qda_dev.dsp_name into the
> user-supplied buffer with strscpy(). Unknown query types are rejected
> with -EINVAL.
> 
> qda_drv.c registers the qda_ioctls[] table with the drm_driver so the
> DRM core dispatches DRM_IOCTL_QDA_QUERY to qda_ioctl_query().

Please tell your AI agent to stop describing patch contents. Ask it to
describe the reasons for the change.

> 
> Assisted-by: Claude:claude-sonnet-5
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
> Changes in v2:
> - Add a query_type input selector so the IOCTL can return different
>   parameters in future, and switch DRM_IOR -> DRM_IOWR so the input
>   reaches the kernel (Dmitry Baryshkov)
> - Reject unknown query types and a non-zero pad with -EINVAL

> +
> +/*
> + * QDA IOCTL command numbers
> + *
> + * These define the command numbers for QDA-specific IOCTLs.
> + * They are used with DRM_COMMAND_BASE to create the full IOCTL numbers.
> + */
> +#define DRM_QDA_QUERY		0x00
> +
> +/*
> + * QDA IOCTL definitions
> + *
> + * These macros define the actual IOCTL numbers used by userspace applications.
> + * They combine the command numbers with DRM_COMMAND_BASE and specify the
> + * data structure and direction (read/write) for each IOCTL.

Is it not obvious?

> + */
> +#define DRM_IOCTL_QDA_QUERY		DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_QUERY, \
> +					 struct drm_qda_query)
> +
> +/* Query type definitions for drm_qda_query */
> +#define QDA_QUERY_DSP_NAME	1

Why is it necessary for the userspace?

> +
> +/**
> + * struct drm_qda_query - Device information query structure
> + * @query_type: Type of query (input)
> + * @pad: Padding for 64-bit alignment (must be zero)
> + * @dsp_name: Null-terminated name of the DSP (returned when query_type is QDA_QUERY_DSP_NAME)
> + *
> + * This structure is used with DRM_IOCTL_QDA_QUERY to query device attributes
> + * based on @query_type.
> + */
> +struct drm_qda_query {
> +	__u32 query_type;
> +	__u32 pad;

What for? If you have u8 array afterwards, you don't need the padding.

> +	__u8 dsp_name[16];
> +};
> +
> +#if defined(__cplusplus)
> +}
> +#endif
> +
> +#endif /* __QDA_ACCEL_H__ */
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
