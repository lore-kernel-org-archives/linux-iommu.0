Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B8337B40B
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887044; cv=none; b=HxIVhzPYKa82dGy5GkpvZh8B8tEuXKNyWXrLH464HmwOoajUlb0Npa1gJnqLirbijcZRaaIQY4e8Vxq+tu03cshqn5zIa1/K/RP15yaRkg0Ni+ebFg52X4zwEU7U0WZWrFabIFIneevTEk3GaH0s4sF0UUBqsTvCHNx94K+01+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887044; c=relaxed/simple;
	bh=ESozs9CA7nx8WRP63rzwxXm2lTOPC3wduzBK1YIpQFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uy5t8glJw3TxU+nlnT8Mu2Fo9xVXrHuPDY/OnPtfxDJV1DrRp09SkYh/djKeylHALG266hZFEgbt8pT2wUbXvDX7QVVWbW7VHE5rKV2uqpt2Ae9KQBdjXR/djDxfzYIFNMJezmbmC0/5HMxVdndwqq6DUiHNN55v7CLwDU1V4Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T/oPrwQF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AdRIcEJa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T/oPrwQF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AdRIcEJa"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NH4F06910162
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=TLrQewx1LWqE8yixuzB68j48
	P2XGnr1QqREmwV+PFsM=; b=T/oPrwQFOqKER80CI6r0E2nLqTAVQ/gXyaoUHDvd
	DPxVH12jR7atAn68LTSq15qRt7dkY6jRAzq/rrxed5/Gcw1sK+TtmRO/vnj2AO1Y
	xoqaS0/yoNBwrHUjfwIrTqNFXrjhrkyFpWGWg7WYaNsb9T5fioDexRWDtIxzXTqF
	EZ+rppWzrS+K9kNb00k5qQqGnYw8f0BIaSnmaqcdx6cnjRdHQFf88BgtXJHpx9e3
	LXY678B3Ug6dvUpwDSxZ7fwyAzZJpjvHF1syPYrjQ9ObhDMF9+2eWlFBekhhgQOp
	5NwSYgb/iJW0wOQ82ywZrqWpbAC5ezx2HFMZA9+728XKTQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cgtyj8xc2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 22:50:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb3a129cd2so5966495985a.0
        for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 14:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771887041; x=1772491841; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TLrQewx1LWqE8yixuzB68j48P2XGnr1QqREmwV+PFsM=;
        b=AdRIcEJaJUIsFFwBqXo7wj15rHIns1lMZfBf65/Pd/TbjJAp7B9IdG7R/DrPRJ62TD
         D9rL5ojU7Z/I6Lmm37j3p4Er400T/pAlZ94o7WWQWJqotuxpKqYW91zL8SwGFBKrMIjc
         wp62uPGeHTdg5GZA8kW5YSCS0+lwPgHlldY/krj6DIWm++1T7jT+XC1EPPOZuHoQhhYl
         gzRuZ/AxP2TnSJ+/T7HpFIt6se7hO+e9tQMwI+8hzJN+eN5pzjJZdbkk1yfizlKn3Myu
         MW9O5cfkElWUeOGMtCVnZg3tg6SgeEtAz4W2ObDMj/9REjfAhDNs++7eXdel7BfoFH5e
         XGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771887041; x=1772491841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLrQewx1LWqE8yixuzB68j48P2XGnr1QqREmwV+PFsM=;
        b=pItKnLWNI6FPr2+y1dw1TUL23i59S8rIrVnZDkyZgLjoK5NqhV4UzyVF5l331GQXQM
         0+DCg9LOdhHwgYqvj6gNXp8ujj99SbaXUG6nTCUFrq8HF4F6rzhIqpp2074nbZ3i99ZJ
         lBXJ0X9uN+eCUFDCHoZs+fZ2ms/qFedqDrSSgvWt5gblf0S7GOCIRVwLXgn7S20KmEei
         rHCG8P7gxx0wzbRlnpbVozMvERtTssNryD8Gm7r+PO1S5Gn+YUeLB+ODcauu/F2wWguh
         oY2pynefXqTphKIBHEj6gGeuemOPauf1txG0hKib5Fsz4hI7aUSEf9U222AA01Gl9rqg
         ezkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpztFUTWn1/OR3dWE+235ZpB1/LBM5mAM5RpKuhzP/sGe+Iha4KHJIOrT4Y6wo7mSAQI12TQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEK4lhcDx/t1SGzKwhMTQ+X8IruHSpq3hxswBV1o+rvhCkK1xq
	KIGzOfejh1PhUQIUFauxDSbGw6u2fi3MsAWk0MF3OEjppFkLvJFakEpnEUoca1pci+0Kjh6246G
	p4c1abIpFbj9eYTMcrAJOnxGVZy0JlBA1kVxHQqw9GlP2a/R0xSppzdg6nA==
X-Gm-Gg: AZuq6aInvxJNB+dPvHVnImUEtsZRlD++MtgFKXeQQy2b4Eam5/SsRf14JG48OWqWerf
	wanYAlp8+Bltuw213aBr3HDluocjgchzHh62In+a63wmi/a5DfgY3K0taTA6jvPgKp9amCjYEU4
	DsDx4742+1mLh4dRn9eNLnv24SETv4/rPSUFFTCkRiLntlKVD2/zDdYMS3wmqrYf4VmZyuLgTvk
	T7nU6qE+kK9mj4FXQwu0ksVk31plUC86q7vh2NvUw0Mc3RBKtBJbiumJEYdhRvUZNPjkIjwQJPq
	ZJJRhr6FA6Yo3gkocE7/2q3TLfT5M/Gc4+5BDyXRzrM7l/RRa6OfDFaPkWi8he73A8JQPxxzytA
	rVeLEsvgPpt1jsWMFtV1m4O1Xe2H2y5ENcRkcFlgEwPzMnvj3Fa3kuQNKFqssw8/0jlNup/d5Yf
	X4WxWwDdTYcZX0BjXCEPKM8dlJspMH5Cvs0r4=
X-Received: by 2002:a05:620a:4506:b0:8cb:df8:e86a with SMTP id af79cd13be357-8cb7bfc8d11mr1987074485a.28.1771887040669;
        Mon, 23 Feb 2026 14:50:40 -0800 (PST)
X-Received: by 2002:a05:620a:4506:b0:8cb:df8:e86a with SMTP id af79cd13be357-8cb7bfc8d11mr1987071185a.28.1771887040143;
        Mon, 23 Feb 2026 14:50:40 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a0eeb45a64sm1809193e87.67.2026.02.23.14.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:50:39 -0800 (PST)
Date: Tue, 24 Feb 2026 00:50:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH RFC 06/18] accel/qda: Add memory manager for CB devices
Message-ID: <d7s4e7xzfqfbcf5o3grc6xqm74dzwpck6ge7hyrwewmyacpuez@lcd6nhzyjr55>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-6-fe46a9c1a046@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224-qda-firstpost-v1-6-fe46a9c1a046@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=Jq/8bc4C c=1 sm=1 tr=0 ts=699cd9c1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=6noqdOoYruC88qHUYLQA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: QHuWZDdUd8eIRLPic92HGrvOCbAHoIdz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDE5OSBTYWx0ZWRfXw2EhsFQMP6tX
 Bu1NQdOfxs37vYh/Lvbp0IswN/oGVjaTLvZlGAywH0BDkpbL39KBf48HWLB0EBTzkAhwOkeShYh
 SRAO/rEt278M56bYDDG1kpeUnSMVnYb+Q+wyfRJR7kYf3uMRguq6alxjdnQ+kwGw4quqnX0Af9B
 YjxRdwFD7BuulMyodmJAxZB4TPEXc7bGCsDLU3F/6Wm6m8H99gHJRLYkqcCB3QLEMZtEgbz1hrL
 7XMicAYx81VxhPI7Gwcc4gWiGqD/urMfFHvh0+ZKY0uXXnqDtlYXq5vSjItwrkgnWSqnONkXgAR
 +a3zDATj7PoE5Tmprwg4vCwNgix/blonp8SDTbCimJAUtwJAAZoM2R6srEkWsJCdrcCAckPE1XY
 2FvTyWOo6PCpFcEXZPn15U4eDETTttt0bQgrkibbzqRMd70BpUxYcZN5EV8IaGptkVBpHBW1k27
 jMf/nTsWcOg6LnQoc8Q==
X-Proofpoint-GUID: QHuWZDdUd8eIRLPic92HGrvOCbAHoIdz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602230199

On Tue, Feb 24, 2026 at 12:39:00AM +0530, Ekansh Gupta wrote:
> Introduce a per-device memory manager for the QDA driver that tracks
> IOMMU-capable compute context-bank (CB) devices. Each CB device is
> represented by a qda_iommu_device and registered with a central
> qda_memory_manager instance owned by qda_dev.
> 
> The memory manager maintains an xarray of devices and assigns a
> unique ID to each CB. It also provides basic lifetime management

Sounds like IDR.

> and a workqueue for deferred device removal. qda_cb_setup_device()

What is deferred device removal? Why do you need it?

> now allocates a qda_iommu_device for each CB and registers it with
> the memory manager after DMA configuration succeeds.
> 
> qda_init_device() is extended to allocate and initialize the memory
> manager, while qda_deinit_device() will tear it down in later
> patches. This prepares the QDA driver for fine-grained memory and
> IOMMU domain management tied to individual CB devices.
> 
> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
> ---
>  drivers/accel/qda/Makefile             |   1 +
>  drivers/accel/qda/qda_cb.c             |  32 +++++++
>  drivers/accel/qda/qda_drv.c            |  46 ++++++++++
>  drivers/accel/qda/qda_drv.h            |   3 +
>  drivers/accel/qda/qda_memory_manager.c | 152 +++++++++++++++++++++++++++++++++
>  drivers/accel/qda/qda_memory_manager.h | 101 ++++++++++++++++++++++
>  6 files changed, 335 insertions(+)
> 

-- 
With best wishes
Dmitry
