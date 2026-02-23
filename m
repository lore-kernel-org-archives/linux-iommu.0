Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091CB378D64
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884759; cv=none; b=suAD2lHKamiAuWdWPwZAzD9yj2pDM0daLrGSAJnkaDDoM9Xl8X9xHaVD1gLKl/XKZi8Tg6PyCWt9DSu86Gp1M16B7fQcL/PSTYoVAKFOfM6img8TVAGTiEsHlqNOZ77RUsRZyYAUDkdqqPiW/zSd9OLGCEInCeMvZvZzewvGdjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884759; c=relaxed/simple;
	bh=Xmv6AivAPcyN4oojDSQhWKjUpiZH47TkKPpC0QkmJxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUTKLIU9vvW697/kCF3ZvEKYm13VX7Vb0RvrhGQbQCShe2IggmqeVsQnFnx2B45FbFCEOSj4RnhEiBbGhYoW2t3W4+DeXWJzbvne6GCAoG2jOlaSvEURbDZo1ncxTs8p57g60PkYrfg4RzwHcX3QUiVnAbppHqILL1QznM31lvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l74upXwG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=faw9lkpG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l74upXwG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="faw9lkpG"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NH0rBn109859
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=U8+99t2Q08+ketqYxwhfTfYr
	syyINxyz6SnBAR9Q/Mc=; b=l74upXwGKe5nvGSpUt5Sr+jvI1kN0EmQQJwIkT/f
	5rtolmxcSheWmP6r/BFNpA2OevUrbWJ+NAkmQcD4GHilDIXCkTUhHpz27O9z1yFC
	CBVYpIojePUWbaaugRyAZVBDVzIaLJN9nUYCw+bziNJV6OtlW+9iGCmq98a2W/ER
	NeBaHDaTESG+IjXV4SYxQKbS5e25zYOEnyIUu+lFeT7wKvY2JTB4pqTnN1Cb3IaB
	PqrL3bNhhZr7fM8R7W7/fXm16D96rajTYO7RSnV+Yqg/f+pfsHLHRjXOIwXac4Gg
	W9IkXjkizbIiNY7WGpfiVoICtOTDa1h7TAOVvkHQWdq2fQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgtx08vw3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:12:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb0595def4so5792795085a.0
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 14:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771884756; x=1772489556; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U8+99t2Q08+ketqYxwhfTfYrsyyINxyz6SnBAR9Q/Mc=;
        b=faw9lkpGuBc5733kZhpfUtJN2UodTgsLYMOfXy1Qwc4motnYRg2MudTWv5ylOVltp0
         UxuPJhbjzoJf9Y++z39XOreThL/33q+9K0HIMorN+jJxIhfMr+nSlWLTvWKksHYC4alp
         1aF6FGN+cMC0zA3pjc47H0b8o5sQJiai67mkD+5vUAO0VmLfH4zQmcMr9BeoQLL5nmHg
         NKZZpZYTH5a8f2b05mKG6ZGQzu6VInqx4sI4nEK0WL+bXYDuYz8CNo0FBggt8VCVFUTq
         7MduE+nEKLbcgRgYZZWz6zz+Ov20NnTPd6immwdYMUgMhf4nVBi8hkcXdDF+nZ6Gav/B
         U3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771884756; x=1772489556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8+99t2Q08+ketqYxwhfTfYrsyyINxyz6SnBAR9Q/Mc=;
        b=U0e8npGWm+Z5bIhOqNTL4PQkqsu0F0bMDv4JJ62s1LdX4qI0K4fZqYyvV5IAFZAPKT
         38S1yA72fIV5LNISzMJHQUA/Cdj/z+rjxRE2jNTSivA6G0z25Ect7U41qZICN/ciGfoo
         mJoiRVtu7kUhJhF+2vvV0R7UgLkAzeXDpz+gLYGIedcclMqWUDr60NBumK8dokZ9L1HH
         284l69n2CgobPfom7FSk/YlqYMLVWvPslG3sKFkP+1DeFSlyVzPi7qzYXb61AFQk41gl
         T88BGez2b5p98WWnqINEgvJVANbbsVsVHiKUIY/GJRVnOqSsiIPnVJhZE7HdfN/inKGg
         XVfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSo0N24WptqOURNetq/lXdWomtFITwnUdGIdkcqFH/cfz1sVsN/jVspmFI66yl14BrI7Rbng==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbV5bgv477BtB7lcD4eo+7waPESIeSIkdD3sAIIbjU0WEyHSgZ
	CuKDtaXajRQiAIoFSMli5S1cX9FZIHQOYpgJYfy/9vHnnIJ33J2NmDLkS+BSidFFCaPQ5b0TWO2
	duyjQTNi59tO83iqp7rmy0q+23Q8EDEsGC70tY3hLZ3bVj6ClDa8ZPdStZg==
X-Gm-Gg: AZuq6aKDwMdV7NiXNVU8RM9AIaYjdPbmZvsfXMCRoH3/c9bMDlcvTZ/5o2tuGFKDERY
	05tcEgOdPvQ669WvR+6JweakneN0sjyo8CHlq/zFQbhDz3KPt6pdTz/9Vf1txqww650mZpmTjEv
	CDwhnNsszo9NGsWEERYWWRzlIRP/8mF5UuKSgLHG0D59EcZcoEoYyuDxDXyfOSreuZLZSDyictJ
	ped3uBgyqX5N1T7cBalfyh04vklv6IyjRAZhb1zgKzW1LK+K28J2xTobV1gN5rPbrHuUIsROwi/
	+ABSORzPqeILrnl9vtiqstflYQ8U942BUnuKWCJCFrgCKpW0AMrveW9n3fmLRla51mdF3B3db1j
	/fC+SrlgGH8OhkpnqR9ENJpw5U/rJtFk7ZzurjXeFRHjvcxdcW/OYhcgT+uqX9weodRhAdQ73NV
	+BGhDyaOvnz8/UsZHSunbuM1MsUpPLGanS85o=
X-Received: by 2002:a05:620a:4441:b0:828:faae:b444 with SMTP id af79cd13be357-8cb7bfc8d06mr1818109685a.20.1771884756290;
        Mon, 23 Feb 2026 14:12:36 -0800 (PST)
X-Received: by 2002:a05:620a:4441:b0:828:faae:b444 with SMTP id af79cd13be357-8cb7bfc8d06mr1818103585a.20.1771884755417;
        Mon, 23 Feb 2026 14:12:35 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389a7aaed3esm18805261fa.40.2026.02.23.14.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:12:34 -0800 (PST)
Date: Tue, 24 Feb 2026 00:12:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
Subject: Re: [PATCH RFC 03/18] accel/qda: Add RPMsg transport for Qualcomm
 DSP accelerator
Message-ID: <r7eko65ua2ofyejqf6ipnh6jm4s76f4mqy6a4msgmlraz4xuec@uymfzc65dbng>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-3-fe46a9c1a046@oss.qualcomm.com>
 <tqsdbijgjomrn7fq3sdz7v2axwxqvbccpjh4fmvod4kbrq7pod@af3igw5dx66p>
 <lyco6vkfjlerri55ldyn6fbhihbkhnuolifddcnscevybsztq7@ljhjln2ynmid>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lyco6vkfjlerri55ldyn6fbhihbkhnuolifddcnscevybsztq7@ljhjln2ynmid>
X-Proofpoint-ORIG-GUID: QmToNggooAoBMwxegmx_fDfv-bAcmRv_
X-Authority-Analysis: v=2.4 cv=euvSD4pX c=1 sm=1 tr=0 ts=699cd0d5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=WRMiGO0D-mV3MfwFjRkA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: QmToNggooAoBMwxegmx_fDfv-bAcmRv_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE5MyBTYWx0ZWRfX5i0TRYVu5yLr
 ptlwmVC5j3h3fAk9N5awHomqmEZQ/g6A18IzCVmclVx1lUE3p7a++Lu3YEvctHFLEzIlmXY6duy
 CiXhmABTUZqo9I6E6tNN2s/WH0+MnUZhcbil4VxrrPJaEGJP9NP+E9Pnfw8BrsTVMWbGjBpIi3G
 MemqWJt4NBWBwKUzjIQi8gcgW1pjHSHPLXHu0XFRuaMbB6iiSaryGcFwsZ3x4uhBiNAY4tBxObU
 aWH55k/W2A2F/S0Eus+O+fLAv7UfzIkGetgIKeb8Bq78YOGhyeIXcaH3u36qfSm2WCuJ2SCkyCJ
 85MUneBIr3N+RfJYuKkHBYD+DzIzRC743O4HwCeoV/5I7jwDBOKZix4h1F0e9+x+Mh8FChV26f0
 Xu1F+XIw5eicI67hdVxdt3v8TWzTLiER7w2hzto4+NpO/4jFVnxttOga5bsMpVS10+Fy/Sa7RDI
 vBz3j93Utys20AUx/YQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230193

On Mon, Feb 23, 2026 at 03:50:32PM -0600, Bjorn Andersson wrote:
> On Mon, Feb 23, 2026 at 11:23:13PM +0200, Dmitry Baryshkov wrote:
> > On Tue, Feb 24, 2026 at 12:38:57AM +0530, Ekansh Gupta wrote:
> [..]
> > > diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
> [..]
> > > +/* Error logging - always logs and tracks errors */
> > > +#define qda_err(qdev, fmt, ...) do { \
> > > +	struct device *__dev = qda_get_log_device(qdev); \
> > > +	if (__dev) \
> > > +		dev_err(__dev, "[%s] " fmt, __func__, ##__VA_ARGS__); \
> > > +	else \
> > > +		pr_err(DRIVER_NAME ": [%s] " fmt, __func__, ##__VA_ARGS__); \
> > 
> > What /why? You are under drm, so you can use drm_* helpers instead.
> > 
> 
> In particular, rather than rolling our own wrappers around standard
> functions, just use dev_err() whenever you have a struct device. And for
> something like fastrpc - life starts at some probe() and ends at some
> remove() so that should be always.

I'd say differently. For the DRM devices the life cycle is centered
around the DRM device (which can outlive platform device for multiple
reasons). So, please start by registering the DRM accel device and using
it for all the logging (and btw for private data management too).

> 
> Regards,
> Bjorn

-- 
With best wishes
Dmitry
