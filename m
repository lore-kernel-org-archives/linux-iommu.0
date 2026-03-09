Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7838F3603F0
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 06:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773039217; cv=none; b=kuYsAB7J8gVXLdmST0YD44joPKU11H4BYffFYVISFiWHbm/hyBb7dYaxxfGVIffe2hK+TLch068qpPKEoXADbypvYfL4ZoxnB1ZKUGhDriPaXzIEl8TC4pMxuo7buDYe1UpI6wgeN5VwME35Kxhtj9pEBIwnRskArI77DK/eAek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773039217; c=relaxed/simple;
	bh=inf3CvJ7ATeqqM3HBNoEykf6mIlvXg+5yMAPESU9CNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZ8mfemBeokq0TujUvgYZQwFJB7T6c6iiwQPr+S+bmrY5vH7tClp/i74cBvPgv4NUrwsd3GR2Gi6KpAEOzo5W1dQadULC+dcKiwt1BelyYUGYeHJZ45gEmFN+MEjgBH4ndVHsepzZyt5noL+AjVK4h2gCZIexHenZbeXwJsu4GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UsIEUek4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I6iaGKN/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UsIEUek4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I6iaGKN/"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 628N1o4O200749
	for <iommu@lists.linux.dev>; Mon, 9 Mar 2026 06:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mVgFqX2DBPDBaFLa3PVw54gA+GcENZGtutXAv5LndUk=; b=UsIEUek4Fe3f4Aqn
	fxQRIA/Kk6hOUiaqGNLJsR2oFJYcB3CDNQlg/Hb46GLjLpfJngErRAaLpqsnRq/4
	FSNYnFEIsCGfpt6WEzzUinND8smSGzsVEC+gj9sxjAtZSU2Li1gZCTJPT0weTD7w
	7BzN5yu3jPZ9FUkyo0Pb1cCM2yTwpmGzzZ5Klv6LBzCxJwELQM+Ttm3Abc0ogiV7
	JytN8LDB7w9uVRnVv5ARinNUO3H5lEPndqIQ9KgWMLFs8HnK51AN/be03hiQ+uS4
	V9OqsfmOJpvRXgd0UgEc4ziMwn9c2ZJWHV5jD55sisvRHFWv09Gv1SbonyLYpkl/
	YZDBfQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4crc3vc6cp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <iommu@lists.linux.dev>; Mon, 09 Mar 2026 06:53:35 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-829a72475a1so7905155b3a.3
        for <iommu@lists.linux.dev>; Sun, 08 Mar 2026 23:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773039214; x=1773644014; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mVgFqX2DBPDBaFLa3PVw54gA+GcENZGtutXAv5LndUk=;
        b=I6iaGKN/lq55ZSs+vR8lQq8Fyi8cOtYfmsVP5J/xCQTC7INXCgOstbCbcSgd3afoqJ
         98jEhXHxA9ycByiQK9ld5bvOL7aq++0zQ8V0LP1T989phjGap1+970KaX5IPztxuqu+A
         3u/HefhQzu1TFe5Bphfc7k93OGYJTyRxq7F6/ISp6bsLab+ZvfzHPBLmqxEbocKakjUh
         T+hXpUGvcv8sSoAeLGETwHkWOTU8LAJP5nKoNfJ2wBwTWJTk/HleIH2Q5QC5UnW7aNSs
         V2CX+eADTGZkZmQwjgfW5vdqY04JyQw4OiWLcLFbfUCH6/29kNC34IwmoRxtucxr8KL7
         F0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773039214; x=1773644014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mVgFqX2DBPDBaFLa3PVw54gA+GcENZGtutXAv5LndUk=;
        b=W2KGrDC1k+k2agkExL4iu3sPCL2BQHLieUraPzPqxWK9+RUs2j1mU/7ogd7/I5UHjh
         LXiLAuMAQI/PoU3svJFg2E0c3xlR+uH0c9FQrwp1sgxUTg2karckfo2TipuKrwj/dJ40
         eUm+dGtWWyoGPMp90bLUZQNnoDNqXe4q02jXRz6al4noi1eYwwBXEkw7iONTAPaJFnoy
         vrFSlVH6+MWsIk6lbMGGbH1CjAOmKvlMaCcqpNzKW1pXHHuX/NQv/l5CeTXtQNWA0GnM
         Gyrk2z+qfw5qThjUCRSIPWHg+iSd2AAZOFKDJAMbCLN5ucfxVc1rzhRikMIb5ho5vNJp
         ZgJg==
X-Forwarded-Encrypted: i=1; AJvYcCUKpOu5iNRc2TNKhWjy4OanO12oCJk0PKVhNZhPvlHsnNbbHivuxJ+poxaCd+Hm66X5R9DBKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKeot/ebKaNMmzw9HY4JNUKXPnbIABbHvGYeP07y9NBYLkO5AM
	zi+NhDCxZ8o8oUDB1xCkYt72BiYlmH0wUNWIhRtjfXLeF3626ibhDv5CgqWgyBzgrSpW5SoaU2c
	uRgzouJ4Nh9xBguopFMmWa4Uapicx6ojvSYgDi4cytr6lQ+HLcPYaA4m2ug==
X-Gm-Gg: ATEYQzwo9knYiZYJQRxl9ZJg2Fx+GtLsUJ69jR6WN3plybikY9MYfWVFCOyXGm2+q9k
	ho+yEhEofeGj1fM+kDikxkLoT8DStg+kf7LHxLkPrLGGmO/ts0NShLQMWFwJhXnmUAcVv2PXR6h
	ShiZPsb1nym1fElVzC+3BT62gVvHpOtwRjCof+xIHZNpDArwP7DcDaVE4XY+KOF4eYvf9p76Tkc
	MhsXcxKHfm925ZdaCSLWi6omx0dpFBabAvVOamWmF7EpaY8xM/eR0B9UsX5YihnINPcJc1zX+Y9
	arss2jkZ0PHj8nzShbf6a5EAZIj5gYjRViWoYSDJySRdyxmyg1PRE1SFnPGXv8Sy/xxOtVtBfEP
	bpyLXjJfH6ORJxerH8xMfpAwHIgS9++eKa7I/crjWU9WVW5I7Gg==
X-Received: by 2002:a05:6a00:1805:b0:829:7692:cddc with SMTP id d2e1a72fcca58-829a2e5a4b2mr10500540b3a.21.1773039214502;
        Sun, 08 Mar 2026 23:53:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:1805:b0:829:7692:cddc with SMTP id d2e1a72fcca58-829a2e5a4b2mr10500515b3a.21.1773039214023;
        Sun, 08 Mar 2026 23:53:34 -0700 (PDT)
Received: from [10.206.99.28] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48a54cesm9002319b3a.48.2026.03.08.23.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2026 23:53:33 -0700 (PDT)
Message-ID: <b4751c57-8ed2-4bed-8c0f-34f0a2e54345@oss.qualcomm.com>
Date: Mon, 9 Mar 2026 12:23:25 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 14/18] accel/qda: Add FastRPC dynamic invocation
 support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Bharath Kumar <quic_bkumar@quicinc.com>,
        Chenna Kesava Raju <quic_chennak@quicinc.com>
References: <20260224-qda-firstpost-v1-0-fe46a9c1a046@oss.qualcomm.com>
 <20260224-qda-firstpost-v1-14-fe46a9c1a046@oss.qualcomm.com>
 <57we5xzyxvctwzgggqpemlqf7q524mbaqnczqxua6eaehqv6vw@bq4raxwkbava>
Content-Language: en-US
From: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
In-Reply-To: <57we5xzyxvctwzgggqpemlqf7q524mbaqnczqxua6eaehqv6vw@bq4raxwkbava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zDd30Xfly5nugXqMq03VP3WHWYfMOmlB
X-Proofpoint-GUID: zDd30Xfly5nugXqMq03VP3WHWYfMOmlB
X-Authority-Analysis: v=2.4 cv=OOQqHCaB c=1 sm=1 tr=0 ts=69ae6e6f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=m5BqE4nBN3PhNdyHHPEA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA2MiBTYWx0ZWRfX4RB593Z4EKO+
 tYf/nfjrBNctoSRFEn65gcqp4rmkiPifWx6oScfkaoh1zHiwa40Ybp15zbUuft3yGMjJJValxBg
 2JxDZZ8YWV1UBq6wxoBQF5Ldb0g6YXO4X/Bav9oEB7n3K909SRoHkkn3ccUxbXzhPyJf/u96QHC
 F/ah4FnK6mMmimo3qRysocK54GnoiKS8cD9ACmSejnbsaDF0Vz9PARj3btQa1rh+dPofMQLiAU2
 IZ72OL9XROfxSUe4f23qhygkOCgDuydQlu+LP0U8Tv2oSfeysEm3miZyOMfjIrkRDyd1eAWXbnx
 AvI7lXcGbdHtVYnZwqTs7lNBghXU+RroPiSrbP7yrcZTLeGgp054LuePsMGOcpDuKU+s1lU4b37
 fNSUmmsAMJ5hrRtRQ1sAXziefokVsE0YDUvhg4mxxGQaxpY5TDsp7rU8xB0FIm6Up3/R2kFChR+
 btqcVqXBWGh9p8RbMnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090062



On 2/24/2026 4:40 AM, Dmitry Baryshkov wrote:
> On Tue, Feb 24, 2026 at 12:39:08AM +0530, Ekansh Gupta wrote:
>> Extend the QDA FastRPC implementation to support dynamic remote
>> procedure calls from userspace. A new DRM_QDA_INVOKE ioctl is added,
>> which accepts a qda_invoke_args structure containing a remote handle,
>> FastRPC scalars value and a pointer to an array of fastrpc_invoke_args
>> describing the individual arguments. The driver copies the scalar and
>> argument array into a fastrpc_invoke_context and reuses the existing
>> buffer overlap and packing logic to build a GEM-backed message buffer
>> for transport.
>>
>> The FastRPC core gains a FASTRPC_RMID_INVOKE_DYNAMIC method type and a
>> fastrpc_prepare_args_invoke() helper that reads the qda_invoke_args
>> header and argument descriptors from user or kernel memory using a
>> copy_from_user_or_kernel() helper. The generic fastrpc_prepare_args()
>> path is updated to handle the dynamic method alongside the existing
>> INIT_ATTACH and INIT_RELEASE control calls, deriving the number of
>> buffers and scalars from the provided FastRPC scalars encoding.
>>
>> On the transport side qda_ioctl_invoke() simply forwards the request
>> to fastrpc_invoke() with the dynamic method id, allowing the RPMsg
>> transport and context lookup to treat dynamic calls in the same way as
>> the existing control methods. This patch establishes the basic FastRPC
>> invoke mechanism on top of the QDA GEM and RPMsg infrastructure so
>> that future patches can wire up more complex DSP APIs.
>>
>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>> ---
>>  drivers/accel/qda/qda_drv.c     |  1 +
>>  drivers/accel/qda/qda_fastrpc.c | 48 +++++++++++++++++++++++++++++++++++++++++
>>  drivers/accel/qda/qda_fastrpc.h |  1 +
>>  drivers/accel/qda/qda_ioctl.c   |  5 +++++
>>  drivers/accel/qda/qda_ioctl.h   | 13 +++++++++++
>>  include/uapi/drm/qda_accel.h    | 21 ++++++++++++++++++
>>  6 files changed, 89 insertions(+)
>>
>> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
>> index 3034ea660924..f94f780ea50a 100644
>> --- a/drivers/accel/qda/qda_drv.c
>> +++ b/drivers/accel/qda/qda_drv.c
>> @@ -162,6 +162,7 @@ static const struct drm_ioctl_desc qda_ioctls[] = {
>>  	DRM_IOCTL_DEF_DRV(QDA_GEM_CREATE, qda_ioctl_gem_create, 0),
>>  	DRM_IOCTL_DEF_DRV(QDA_GEM_MMAP_OFFSET, qda_ioctl_gem_mmap_offset, 0),
>>  	DRM_IOCTL_DEF_DRV(QDA_INIT_ATTACH, qda_ioctl_attach, 0),
>> +	DRM_IOCTL_DEF_DRV(QDA_INVOKE, qda_ioctl_invoke, 0),
>>  };
>>  
>>  static struct drm_driver qda_drm_driver = {
>> diff --git a/drivers/accel/qda/qda_fastrpc.c b/drivers/accel/qda/qda_fastrpc.c
>> index eda7c90070ee..a48b255ffb1b 100644
>> --- a/drivers/accel/qda/qda_fastrpc.c
>> +++ b/drivers/accel/qda/qda_fastrpc.c
>> @@ -12,6 +12,16 @@
>>  #include "qda_gem.h"
>>  #include "qda_memory_manager.h"
>>  
>> +static int copy_from_user_or_kernel(void *dst, const void __user *src, size_t size)
>> +{
>> +	if ((unsigned long)src >= PAGE_OFFSET) {
>> +		memcpy(dst, src, size);
>> +		return 0;
>> +	} else {
>> +		return copy_from_user(dst, src, size) ? -EFAULT : 0;
>> +	}
> Nah, it's a direct route to failure. __user is for user pointers, it
> can't be a kernel data. Define separate functions and be 100% sure
> whether the data is coming from the user (and thus needs to be
> sanitized) or of it is coming from the kernel. Otherwise a funny user
> can pass kernel pointer and get away with your code copying data from or
> writing data to the kernel buffer.
I see, I get your comment on the other patch also, I'll fix this.
>
>> +}
>> +
>>  static int copy_to_user_or_kernel(void __user *dst, const void *src, size_t size)
>>  {
>>  	if ((unsigned long)dst >= PAGE_OFFSET) {
>> @@ -509,6 +519,41 @@ static int fastrpc_prepare_args_release_process(struct fastrpc_invoke_context *c
>>  	return 0;
>>  }
>>  
>> +static int fastrpc_prepare_args_invoke(struct fastrpc_invoke_context *ctx, char __user *argp)
>> +{
>> +	struct fastrpc_invoke_args *args = NULL;
>> +	struct qda_invoke_args inv;
>> +	int err = 0;
>> +	int nscalars;
>> +
>> +	if (!argp)
>> +		return -EINVAL;
>> +
>> +	err = copy_from_user_or_kernel(&inv, argp, sizeof(inv));
>> +	if (err)
>> +		return err;
>> +
>> +	nscalars = REMOTE_SCALARS_LENGTH(inv.sc);
>> +
>> +	if (nscalars) {
>> +		args = kcalloc(nscalars, sizeof(*args), GFP_KERNEL);
>> +		if (!args)
>> +			return -ENOMEM;
>> +
>> +		err = copy_from_user_or_kernel(args, (const void __user *)(uintptr_t)inv.args,
>> +					       nscalars * sizeof(*args));
> So... You are allowing users to specify the address in the kernel
> address space? Are you... sure?
ack, I'll fix this
>
>> +		if (err) {
>> +			kfree(args);
>> +			return err;
>> +		}
>> +	}
>> +	ctx->sc = inv.sc;
>> +	ctx->args = args;
>> +	ctx->handle = inv.handle;
>> +
>> +	return 0;
>> +}
>> +
>>  int fastrpc_prepare_args(struct fastrpc_invoke_context *ctx, char __user *argp)
>>  {
>>  	int err;
>> @@ -521,6 +566,9 @@ int fastrpc_prepare_args(struct fastrpc_invoke_context *ctx, char __user *argp)
>>  	case FASTRPC_RMID_INIT_RELEASE:
>>  		err = fastrpc_prepare_args_release_process(ctx);
>>  		break;
>> +	case FASTRPC_RMID_INVOKE_DYNAMIC:
>> +		err = fastrpc_prepare_args_invoke(ctx, argp);
>> +		break;
>>  	default:
>>  		return -EINVAL;
>>  	}
>> diff --git a/drivers/accel/qda/qda_fastrpc.h b/drivers/accel/qda/qda_fastrpc.h
>> index 744421382079..bcadf9437a36 100644
>> --- a/drivers/accel/qda/qda_fastrpc.h
>> +++ b/drivers/accel/qda/qda_fastrpc.h
>> @@ -237,6 +237,7 @@ struct fastrpc_invoke_context {
>>  /* Remote Method ID table - identifies initialization and control operations */
>>  #define FASTRPC_RMID_INIT_ATTACH	0	/* Attach to DSP session */
>>  #define FASTRPC_RMID_INIT_RELEASE	1	/* Release DSP session */
>> +#define FASTRPC_RMID_INVOKE_DYNAMIC	0xFFFFFFFF	/* Dynamic method invocation */
>>  
>>  /* Common handle for initialization operations */
>>  #define FASTRPC_INIT_HANDLE		0x1
>> diff --git a/drivers/accel/qda/qda_ioctl.c b/drivers/accel/qda/qda_ioctl.c
>> index 1066ab6ddc7b..e90aceabd30d 100644
>> --- a/drivers/accel/qda/qda_ioctl.c
>> +++ b/drivers/accel/qda/qda_ioctl.c
>> @@ -192,3 +192,8 @@ int fastrpc_release_current_dsp_process(struct qda_dev *qdev, struct drm_file *f
>>  {
>>  	return fastrpc_invoke(FASTRPC_RMID_INIT_RELEASE, qdev->drm_dev, NULL, file_priv);
>>  }
>> +
>> +int qda_ioctl_invoke(struct drm_device *dev, void *data, struct drm_file *file_priv)
>> +{
>> +	return fastrpc_invoke(FASTRPC_RMID_INVOKE_DYNAMIC, dev, data, file_priv);
>> +}
>> diff --git a/drivers/accel/qda/qda_ioctl.h b/drivers/accel/qda/qda_ioctl.h
>> index 044c616a51c6..e186c5183171 100644
>> --- a/drivers/accel/qda/qda_ioctl.h
>> +++ b/drivers/accel/qda/qda_ioctl.h
>> @@ -63,4 +63,17 @@ int qda_ioctl_attach(struct drm_device *dev, void *data, struct drm_file *file_p
>>   */
>>  int fastrpc_release_current_dsp_process(struct qda_dev *qdev, struct drm_file *file_priv);
>>  
>> +/**
>> + * qda_ioctl_invoke - Invoke a remote procedure on the DSP
>> + * @dev: DRM device structure
>> + * @data: User-space data containing invocation parameters
>> + * @file_priv: DRM file private data
>> + *
>> + * This IOCTL handler initiates a remote procedure call on the DSP,
>> + * marshalling arguments, executing the call, and returning results.
>> + *
>> + * Return: 0 on success, negative error code on failure
>> + */
>> +int qda_ioctl_invoke(struct drm_device *dev, void *data, struct drm_file *file_priv);
>> +
>>  #endif /* _QDA_IOCTL_H */
>> diff --git a/include/uapi/drm/qda_accel.h b/include/uapi/drm/qda_accel.h
>> index 4d3666c5b998..01072a9d0a91 100644
>> --- a/include/uapi/drm/qda_accel.h
>> +++ b/include/uapi/drm/qda_accel.h
>> @@ -22,6 +22,9 @@ extern "C" {
>>  #define DRM_QDA_GEM_CREATE		0x01
>>  #define DRM_QDA_GEM_MMAP_OFFSET	0x02
>>  #define DRM_QDA_INIT_ATTACH		0x03
>> +/* Indexes 0x04 to 0x06 are reserved for other requests */
>> +#define DRM_QDA_INVOKE			0x07
>> +
>>  /*
>>   * QDA IOCTL definitions
>>   *
>> @@ -35,6 +38,8 @@ extern "C" {
>>  #define DRM_IOCTL_QDA_GEM_MMAP_OFFSET	DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_GEM_MMAP_OFFSET, \
>>  						 struct drm_qda_gem_mmap_offset)
>>  #define DRM_IOCTL_QDA_INIT_ATTACH	DRM_IO(DRM_COMMAND_BASE + DRM_QDA_INIT_ATTACH)
>> +#define DRM_IOCTL_QDA_INVOKE		DRM_IOWR(DRM_COMMAND_BASE + DRM_QDA_INVOKE, \
>> +						 struct qda_invoke_args)
>>  
>>  /**
>>   * struct drm_qda_query - Device information query structure
>> @@ -95,6 +100,22 @@ struct fastrpc_invoke_args {
>>  	__u32 attr;
>>  };
>>  
>> +/**
>> + * struct qda_invoke_args - User-space IOCTL arguments for invoking a function
>> + * @handle: Handle identifying the remote function to invoke
>> + * @sc: Scalars parameter encoding buffer counts and attributes
> Encoding... how?
I can add more details for this over here or over FASTRPC_BUILD_SCALARS definition.
>
>> + * @args: User-space pointer to the argument array
> Which is defined at...?
>
>
> Can you actually write the user code by looking at your uapi header?
will add more details for this.
>
>> + *
>> + * This structure is passed from user-space to invoke a remote function
>> + * on the DSP. The scalars parameter encodes the number and types of
>> + * input/output buffers.
>> + */
>> +struct qda_invoke_args {
>> +	__u32 handle;
>> +	__u32 sc;
>> +	__u64 args;
>> +};
>> +
>>  #if defined(__cplusplus)
>>  }
>>  #endif
>>
>> -- 
>> 2.34.1
>>

